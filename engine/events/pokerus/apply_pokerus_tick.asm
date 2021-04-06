ApplyPokerusTick:
; decreases all pokemon's pokerus counter by b. if the lower nybble reaches zero, the pokerus is cured.
	ld hl, wPartyMon1PokerusStatus ; wPartyMon1 + MON_PKRS
	ld a, [wPartyCount]
	and a
	ret z ; make sure it's not wasting time on an empty party
	ld c, a
.loop
	; We check if the Pokemon is still sick or still immune.
	ld a, [hl]
	and POKERUS_DURATION_MASK ; lower 4 bits is the number of days remaining
	jr z, .nextMon ; if already 0 days remaining, skip

	; We check if the Pokemon is vaccinated.
	ld a, [hl]
	and POKERUS_STRAIN_MASK
	cp POKERUS_VACCINE_STRAIN
	jr z, .nextMon ; If the Pokémon is vaccinated, we don't decrease its immunity duration.
	; Note that if the Pokémon has an empty strain (000), and therefore no disease, its duration will still decrease. This allows for asymptomatic Pokémons with and immunity period.
	
	ld a, [hl]
	and POKERUS_DURATION_MASK
	sub b ; subtract the number of days
	jr nc, .ok ; max(result, 0)
	ld a, 0

.ok
	ld d, a ; back up the duration value, before destroying a.
	ld a, [hl]
	and POKERUS_INVERSED_DURATION_MASK
	add d
	ld d, a ; We backup the complete Pokérus byte.

	; If the Pokemon just got naturally cured of a "simple disease", we grant him no immunity.
	and POKERUS_STRAIN_MASK
	ld a, d ; We put the full Pokérus byte back into a.
	cp $A0
	jr nc, .reset_test_bit_if_needed ; If it's THE virus (strains 5, 6 or 7 in the check), we don't reduce the immunity.
	cp $60
	jr z, .reset_test_bit_if_needed ; Strain 3 is the last virus strain that the last check couldn't find. We don't reduce the immunity.
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION
	ld a, d
	jr z, .remove_immunity_duration ; Should be its first day of immunity, but a mild illness procures no immunity after it's cured.
	jr nc, .reset_test_bit_if_needed

.remove_immunity_duration
	; Here we reduce the immunity remaining time to 0 for a "simple disease" (1 bit virus) that just got cured. Note that vaccinated Pokémons were discarded earlier on.
	and POKERUS_STRAIN_MASK ; We set the remaining duration to zero.

.reset_test_bit_if_needed
	; The test the nurse does works like PCR. Once the virus cycle ends, a Pokémon can catch the virus again, and it would need a new test to spot the virus again.
	ld d, a ; We backup the complete Pokérus byte.
	and POKERUS_DURATION_MASK
	ld a, d ; We put the full Pokérus byte back into a.
	jr nz, .save_pokerus_byte ; If the remaining duration is above zero, we can now save the byte.

	; Here the remaining duration is zero, so we need to reset the test flag/bit.
	and POKERUS_INVERSED_TEST_MASK ; Resets the test bit/flag.

.save_pokerus_byte
	ld [hl], a

.nextMon
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret
