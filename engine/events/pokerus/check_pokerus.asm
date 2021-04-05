_CheckPokerus: ; Called only by CallPokerus in engine/events/specials.asm, which is only called by the nurse healing macro.
; Return carry if a monster in your party has Pokerus

; Get number of monsters to iterate over
	ld a, [wPartyCount]
	and a
	jr z, .NoPokerusToNotify ; No time to waste on an empty party.
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
.Check:
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_TEST_MASK
	jr nz, .next ; No need to notify the player twice about the same Pokémon that already has the virus.

	; We check if the Pokemon is sick.
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_DURATION_MASK ; Note that we check the duration, and not the strain. The nurse cannot detect the Pokémon's immunity, only the presence of the virus. It works like a PCR test.
	cp POKERUS_IMMUNITY_DURATION
	jr z, .next ; If the pokemon is at exactly 10 days, he already is immune.
	jr nc, .PartyHasUndeclaredPokerus
; Next PartyMon
.next
	add hl, de
	dec b
	jr nz, .Check
.NoPokerusToNotify:
	and a
	ret



.PartyHasUndeclaredPokerus:
	ld a, [wPartyCount]
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH

.Add_test_flag_if_undeclared:
	; We check if the Pokemon is sick.
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_DURATION_MASK ; only the bottom 4 bits are used for the duration.
	cp POKERUS_IMMUNITY_DURATION
	jr c, .next_mon
	jr z, .next_mon ; less or equal.

	; Set the test bit/flag to true.
	ld a, [hl]
	or POKERUS_TEST_MASK
	ld [hl], a

; Next PartyMon
.next_mon
	add hl, de
	dec b
	jr nz, .Add_test_flag_if_undeclared
	
	; Set the carry flag then return.
	and a
	scf
	ret