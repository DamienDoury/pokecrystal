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




CureIllness:
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
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_TEST_MASK
	jr nz, .next ; No need to notify the player twice about the same Pokémon that already has the virus.

	; We check if the Pokemon is sick.
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_DURATION_MASK ; Note that we check the duration, and not the strain. The nurse cannot detect the Pokémon's immunity, only the presence of the virus. It works like a PCR test.
	cp POKERUS_IMMUNITY_DURATION
	jr z, .next ; If the pokemon is at exactly 10 days, he already is immune.
	call nc, SetTestFlag ; Party has undeclared Pokérus.

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



SetTestFlag:
	ld c, 1
	ld a, [hl]
	or POKERUS_TEST_MASK
	ld [hl], a
	ret



; Input: HL points to the address of the PokerusStatus.
; Output: true/carry if it is a indeed a mild illness, false/no carry otherwise.
; Destroys no other register than A.
IsMildIllnessStrain:
	xor a
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




; Destroys A.
; Input: the PokerusStatus byte address in HL.
; Output: TRUE/carry if the mon can become critically ill, FALSE/nc otherwise.
; Note: a Mon can become critically ill if it has all of the conditions below:
;	- DEF DV + SPECIAL DV is strictly less than 7 (odds: ~10.94%).
;	- it has covid (2 or 3 bits strain).
; Now when the duration is gonna be within symptoms (below symptoms_start and above immunity_start) it will be critically ill.
WillBeCriticallyIll:
	push hl
	push bc
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
	pop hl
	ret nc

	call IsMildIllnessStrain
	ccf ; Note: we need to invert the result (carry) of IsMildIllnessStrain.
	ret
