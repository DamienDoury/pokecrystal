_CheckMildIllness: ; Called only by CallPokerus in engine/events/specials.asm, which is only called by the nurse healing macro.
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
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_STRAIN_MASK ; Note that we check the duration, and not the strain. The nurse cannot detect the Pokémon's immunity, only the presence of the virus. It works like a PCR test.
	cp $A0
	jr nc, .next ; If it's THE virus (strains 5, 6 or 7 in the check).
	cp $60
	jr z, .next ; Strain 3 is the last virus strain that the last check couldn't find.
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




_CheckPokerus: ; Called only by CallPokerus in engine/events/specials.asm, which is only called by the nurse healing macro.
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