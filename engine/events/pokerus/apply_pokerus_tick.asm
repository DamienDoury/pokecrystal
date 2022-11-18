; Decreases all pokemon's pokerus counter by b (number of days passed since last save, or when time reaches midnight). 
; If the lower nybble reaches zero, the immunity ends.
; Input: number of "days since" in B (B is always > 0).
ApplyPokerusTick:
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
	and POKERUS_STRAIN_MASK | POKERUS_TEST_MASK
	cp POKERUS_TEST_MASK 
	jr z, .nextMon ; If the Pokémon is vaccinated, we don't decrease its immunity duration.

	
	ld a, [hl]
	and POKERUS_DURATION_MASK
	sub b ; subtract the number of days
	jr nc, .ok ; max(result, 0)
	ld a, 0

.ok
	ld d, a ; back up the new duration value, before destroying a.
	ld a, [hl]
	and POKERUS_INVERSED_DURATION_MASK
	add d ; This is the full Pokerus byte with the new duration.
	ld d, a ; We backup the new Pokérus byte.

	; If the Pokémon is critically ill, we don't decrease its immunity duration (it forces the player to heal it at a PokéCenter, which will send the Pokémon to emergency). 
	push de
	ld de, WillBeCriticallyIll
 	ld a, BANK(WillBeCriticallyIll)
 	call FarCall_de ; Returns carry if a mon has the potential to be critically ill (the duration is not taken into account at this point).
 	pop de

	jr c, .manageCriticallyIllMon

	; If the Pokemon just got naturally cured of a "simple disease" (by getting into the immunity duration), we grant him no immunity. YEEES! I just thought of doing that again! The past version of me already did it!
	push de
	ld de, IsMildIllnessStrain
 	ld a, BANK(IsMildIllnessStrain)
 	call FarCall_de
 	pop de

	jr nc, .reset_test_bit_if_needed ; If it is the covid, we skip .remove_immunity_duration by going directly into .reset_test_bit_if_needed.
	
	ld a, d ; We get back the new pokerus byte.
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION + 1
	ld a, d
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

	jr DecreaseHospitalMonsDuration
	; RETURN

.manageCriticallyIllMon
	; A critically ill pokémon works differently: it is always ill, so its duration cannot reach or go below POKERUS_IMMUNITY_DURATION.
	ld a, d
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION + 1
	ld a, d
	jr nc, .save_pokerus_byte ; If the mon is above the Should be its first day of immunity, but a mild illness procures no immunity after it is cured.

	; At this point, a critically ill mon had its duration decreased below the symptoms period. 
	; As the mon should stay ill, we increase the duration.
	; Also, we make it "more sick" by adding all the symptoms (strain 7 / 111).
	; We only save the test byte, even though it's pointless as we should never end in a situation where the mon had been tested. Otherwise the mon would have been sent into emergency.
	ld a, d
	and POKERUS_INVERSED_DURATION_MASK
	or POKERUS_STRAIN_MASK
	add POKERUS_IMMUNITY_DURATION + 1
	jr .save_pokerus_byte





; Must be called after the hospital box has been loaded (which is the case).
; Input: B is the number of days since last save or when reaching midnight.
; Output: phone call if a new Pokémon has recovered. Hospital box mon duration decreased.
DecreaseHospitalMonsDuration:
	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM
	ld a, [sHospitalBoxCount]
	ld c, a ; c as count.
	and a ; Sets the z flag if a is zero.
	jr z, .end

	ld hl, sHospitalBoxMon1PokerusStatus
.loop
	ld e, TRUE ; E is the register that tells if the mon had recovered or not.
	ld a, [hl]
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION + 1
	jr nc, .previous_state_managed
	
	ld e, FALSE

.previous_state_managed
	sub b
	jr nc, .no_underflow

	xor a ; Setting the remaining duration as 0 in case it underflowed.

.no_underflow
	ld d, a ; Saving the new duration.

	; We check if the Pokémon just recovered. A pokémon recovers when he goes to or under the immunity duration.
	cp POKERUS_IMMUNITY_DURATION + 1
	jr nc, .phone_call_managed

	ld a, e
	cp TRUE
	jr nz, .phone_call_managed

	; At this point, the Pokémon has symptoms the last day the player played, and is now immune.
	; So the Pokémon recovered, and is ready to leave the hospital.
	; We notify the player with a phone call.

	ld a, SPECIALCALL_RECOVER_HOSPITAL
	ld [wSpecialPhoneCallID], a
	xor a
	ld [wSpecialPhoneCallID + 1], a

.phone_call_managed
	ld a, [hl]
	and POKERUS_INVERSED_DURATION_MASK
	add d ; We concatenate the strain and test bit to the duration, which creates our new pokerus byte.
	ld [hl], a ; We write the new Pokérus byte.

	dec c
	jr z, .end ; We leave the loop once we went through the whole hospital box.

	ld de, BOXMON_STRUCT_LENGTH
	add hl, de
	jr .loop

.end
	call CloseSRAM
	ret