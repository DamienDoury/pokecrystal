_CheckMildIllness: ; Called only by CheckPokerus in engine/events/specials.asm, which is only called by the nurse healing macro.
; Return carry if a monster in your party has a mild disease and cures them.
	ld a, [wPartyCount] ; Get number of monsters to iterate over
	and a ; We unset the carry flag to return false, in case the function returns at the next line.
	ret z ; No time to waste on an empty party.
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, 0

.Check:
	; We check if the Pokemon currently has a mild illness, or is incubating one.
	call IsMildIllnessStrain
	jr nc, .next

	; The only strains that can reach this point are 1, 2 and 3.
	ld a, [hl]
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION
	jr z, .next; If the pokemon is at exactly 10 days, he already is immune and the nurse can't detect it.
	call nc, CureIllness ; The pokémon has a mild illness or is incubating one. Note that this check discards vaccinated Pokémons.

; Next PartyMon
.next
	add hl, de
	dec b
	jr nz, .Check

	; If the c register is above zero, we must return true by setting the carry flag.
	ld a, c
	and a
	ret z ; Returns false, as the carry is unset by the previous line. 
	scf ; Sets the carry flag.
	ret ; Return true.




CureIllness: ; Only the strain is saved. Duration is set to 0, and test bit as well.
	ld c, 1 ; We save the fact that a pokémon has been cured.
	ld a, [hl]
	and POKERUS_STRAIN_MASK ; Note: the test flag is also unset, which is required.
	ld [hl], a
	ret



; Called only by CallPokerus in engine/events/specials.asm, which is only called by the nurse healing macro.
; Note: this isn't where we check critically ill Pokémon, as it should be checked even if the player didn't pay for a PCR test.
_CheckPokerus: 
; Return carry if a monster in your party has Pokerus and sets the test flag to true.
	ld a, [wPartyCount] ; Get number of monsters to iterate over
	and a
	ret z ; No time to waste on an empty party.
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, 0

.Check:
	ld a, [hl] ; Retrieving the pokerus byte. Note: Eggs can't get Pokerus, as they can't be sent into battle.
	and POKERUS_TEST_MASK
	jr nz, .next ; No need to notify the player twice about the same Pokémon that already has the virus.

	; We check if the Pokemon is sick.
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_DURATION_MASK ; Note that we check the duration, and not the strain. The nurse cannot detect the Pokémon's immunity, only the presence of the virus. It works like a PCR test.
	cp POKERUS_IMMUNITY_DURATION + 1
	call nc, .SetTestFlag ; Party has undeclared Pokérus.

; Next PartyMon
.next
	add hl, de
	dec b
	jr nz, .Check

	; If the c register is above zero, we must return true by setting the carry flag.
	ld a, c
	and a
	ret z ; Returns false, as the carry is unset by the previous line. 
	scf ; Sets the carry flag.
	ret ; Return true.

.SetTestFlag:
	; If the pokemon is declared covid while carrying a Jade Crystal, we set the scam flag.
	push hl
	push de
	; We check the item.
	ld de, $10000 - (MON_PKRUS - MON_ITEM)
	add hl, de
	ld a, [hl]
	cp JADE_CRYSTAL
	jr nz, .no_scam

	push bc
	ld b, SET_FLAG
	ld de, EVENT_GOT_SICK_WHILE_HOLDING_EVIOSTONE
	call EventFlagAction
	pop bc

.no_scam
	pop de
	pop hl

	ld a, [hl]
	or POKERUS_TEST_MASK
	ld [hl], a
	ld c, 1
	ret



; Input: HL points to the address of the PokerusStatus.
; Output: true/carry if it is a indeed a mild illness, false/no carry otherwise.
; Destroys no other register than A.
IsMildIllnessStrain:
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_STRAIN_MASK ; Note that we check the duration, and not the strain. The nurse cannot detect the Pokémon's immunity, only the presence of the virus. It works like a PCR test.
	ret z ; Returns false when strain is 0.

	push bc
	ld b, a ; Trick: if n & (n - 1) != 0, that means there is more than 1 bit set in the byte.
	dec a
	and b
	pop bc
	ret nz ; Returns false for strains other than 0, 1, 2 and 4.

	; At this point, there's only 1 bit in the strain.
	scf
	ret ; Return true.



; Output in wCurPartyMon: the index of the first partyMon that is currently critically ill, or $ff is no pokémon is critically ill.
_SearchCriticallyIllMonInParty::
	ld a, -1
	ld [wScriptVar], a
	xor a
	ld [wCurPartyMon], a
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH

.loop

	call WillBeCriticallyIll
	jr nc, .next_mon

	; Check the duration.
	ld a, [hl]
	and POKERUS_DURATION_MASK

	cp POKERUS_IMMUNITY_DURATION + 1
	jr c, .next_mon

	cp POKERUS_SYMPTOMS_START + 1
	jr nc, .next_mon

	push hl
	call GetCurNickname ; Saves the infected mon nickname into wStringBuffer1.
	pop hl
	xor a
	ld [wScriptVar], a
	ld [wNamedObjectIndex], a


	farcall SendMonToHospital

	ret

.next_mon
	add hl, de
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	cp b
	jr c, .loop

	; Return false.
	ld a, $ff
	ld [wCurPartyMon], a
	ret

; Destroys A.
; Input: the PokerusStatus byte address in HL.
; Output: TRUE/carry if the mon can become critically ill, FALSE/nc otherwise.
; Note: a Mon can become critically ill if it has all of the conditions below:
;	- DEF DV + SPECIAL DV is strictly less than 7 (odds: ~10.94%).
;	- it has covid (2 or 3 bits strain).
; The covid remaining duration is ignored in this function.
; Now when the duration is gonna be within symptoms (below symptoms_start and above immunity_start) it will be critically ill.
WillBeCriticallyIll:
	push hl
	push de
	push bc
	
	push hl
	farcall IsStuckInKanto
	pop hl
	jr c, .kanto_no_power

	ld bc, $ffff + $0001 - (MON_PKRUS - MON_DVS)
	add hl, bc ; This does "sub hl, MON_PKRUS - MON_DVS".

	ld a, [hli]
	and $f
	ld b, a
	ld a, [hl]
	and $f
	add b
	sub 7
	pop bc
	pop de
	pop hl
	ret nc

	call IsMildIllnessStrain
	ccf ; Note: we need to invert the result (carry) of IsMildIllnessStrain.
	ret

.kanto_no_power
	ld bc, MON_CAUGHTLOCATION - MON_PKRUS
	add hl, bc

	ld a, [hl]
	and CAUGHT_LOCATION_MASK
	cp KANTO_LANDMARK
	jr c, .return_true ; Returns true (the Pokémon was caught in Johto, and therefore should become critically ill).

	cp LANDMARK_FAST_SHIP
	jr nc, .return_true

;.return_false
	pop bc
	pop de
	pop hl
	xor a
	ret

.return_true
	pop bc
	pop de
	pop hl
	scf
	ret
	