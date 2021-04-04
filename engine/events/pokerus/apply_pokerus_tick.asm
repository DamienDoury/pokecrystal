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
	jr z, .next ; if already 0 days remaining, skip

	; We check if the Pokemon is vaccinated.
	ld a, [hl]
	and POKERUS_STRAIN_MASK
	cp POKERUS_VACCINE_STRAIN
	jr z, .next ; If the Pokémon is vaccinated, we don't decrease its immunity duration.
	; Note that if the Pokémon has an empty strain (000), and therefore no disease, its duration will still decrease. This allows for asymptomatic Pokémons with and immunity period.
	
	ld a, [hl]
	and POKERUS_DURATION_MASK
	sub b ; subtract the number of days
	jr nc, .ok ; max(result, 0)
	ld a, 0
.ok
	ld d, a ; back up this value because we need to preserve the strain (upper 3 bits)
	ld a, [hl]
	and POKERUS_STRAIN_MASK
	add d
	ld [hl], a
.next
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret
