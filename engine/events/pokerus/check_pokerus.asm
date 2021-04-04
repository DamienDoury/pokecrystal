_CheckPokerus: ; Called only by CallPokerus in engine/events/specials.asm, which is only called by the nurse healing macro.
; Return carry if a monster in your party has Pokerus

; Get number of monsters to iterate over
	ld a, [wPartyCount]
	and a
	jr z, .NoPokerus ; No time to waste on an empty party.
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
.Check:
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_TEST_MASK
	jr nz, .next ; No need to notify the player of the Pokémon he already knows is sick.

	; We check if the Pokemon is sick.
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_DURATION_MASK ; Note that we check the duration, and not the strain. The nurse cannot detect the Pokémon's immunity, only the presence of the virus. It works like a PCR test.
	cp POKERUS_IMMUNITY_DURATION
	jr nc, .HasPokerus
; Next PartyMon
.next
	add hl, de
	dec b
	jr nz, .Check
.NoPokerus:
	and a
	ret
.HasPokerus:
	ld a, [wPartyCount]
	and a
	ret z ; No time to waste on an empty party.
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH

.Add_flag:
	; We check if the Pokemon is sick.
	ld a, [hl] ; Retrieving the pokerus byte.
	and POKERUS_DURATION_MASK ; only the bottom 4 bits are used for the duration.
	cp POKERUS_IMMUNITY_DURATION
	jr c, .next_mon

	; Set the test bit/flag to true.
	ld a, [hl]
	or POKERUS_TEST_MASK
	ld [hl], a

; Next PartyMon
.next_mon
	add hl, de
	dec b
	jr nz, .Add_flag
	
	; Set the carry flag then return.
	and a
	scf
	ret