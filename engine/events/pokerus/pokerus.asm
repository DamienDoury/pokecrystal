GivePokerusAndConvertBerries: ; Called after each non-linked battle.
	call ConvertBerriesToBerryJuice
	ld hl, wPartyMon1PokerusStatus
	ld a, [wPartyCount]
	ld b, a
	ld de, PARTYMON_STRUCT_LENGTH

	; Récupération du premier Pokémon de l'équipe (index 0)
	xor a
	ld [wCurPartyMon], a

; We look for a contagious Pokémon to spread the virus.
.loop_contaminated
	ld c, a
	push hl
	ld hl, wAllBattleParticipantsAfterVirusSpread
	ld b, CHECK_FLAG
	predef SmallFarFlagAction ; Check bit at index c in bit array hl, and returns state of the flag in c.
	pop hl
	ld a, c
	and a
	jp z, .next_mon_contaminated ; This Pokémon didn't go into battle, so it shall not be contaminated.


	; If the Pokémon went into battle, it may infect other party members.
	ld a, [hl]
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION ; Note that a vaccinated Pokémon has a duration of 1: this test discards him.
	jp nc, .TrySpreadPokerus


.next_mon_contaminated
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, .potentialInfectionFromStranger
	ld [wCurPartyMon], a
	ld de, PARTYMON_STRUCT_LENGTH ; de should not be touched, but I'm not sure about SmallFarFlagAction.
	add hl, de
	jr .loop_contaminated




.TrySpreadPokerus:
	call Random
	cp 255
	;cp 33 percent + 1
	jr nc, .potentialInfectionFromStranger ; 1/3 chance the virus won't try to spread.

	ld a, [wPartyCount]
	cp 1
	jr z, .potentialInfectionFromStranger ; only one mon, nothing to do

	ld c, [hl] ; We save the original strain to try to duplicate it.

	ld hl, wPartyMon1PokerusStatus
	xor a
	ld [wCurPartyMon], a

; We look for a healthy Pokémon to contaminate. The contaminated Pokémon will try to infect' em all!
.loop_healthy
	push bc
	ld c, a
	push hl
	ld hl, wAllBattleParticipantsAfterVirusSpread ; We only look for non-contamined Pokémon that came on the battlefield AFTER a contamined Pokémon has been on it.
	ld b, CHECK_FLAG
	predef SmallFarFlagAction ; Check bit at index c in bit array hl, and returns state of the flag in c.
	pop hl
	ld a, c
	pop bc
	and a
	jp z, .next_mon_healthy ; This Pokémon didn't go into battle, so it shall not be contaminated.


	; If this Pokémon went into battle, let's check if it has been infected by another party member.
	ld a, [hl]
	and POKERUS_DURATION_MASK ; Note: vaccinated Pokémons keep a duration of 1, so this check discards them.
	jr nz, .next_mon_healthy

	ld a, [hl]
	and POKERUS_STRAIN_MASK
	cp c ; We compare the strains.
	jr nz, .infectMon ; A Pokemon can't be infected twice in a row by the same strain. This is some kind of immunity, to allow the player to breath a little if she/he can't handle the spread.


.next_mon_healthy
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jp z, .potentialInfectionFromStranger ; When we reach the last Pokémon, we are done with this check and go on to the next one as we only allow 1 infected Pokémon from the team to contaminate its allies (otherwise the contamination would go too fast).
	ld [wCurPartyMon], a
	ld de, PARTYMON_STRUCT_LENGTH ; de should not be touched, but I'm not sure about SmallFarFlagAction.
	add hl, de
	jr .loop_healthy

.infectMon ; Infection coming from another Pokémon of the team.
	ld a, c ; c contains the Pkrs byte from the Pokémon that is the source of the contamination.

	and POKERUS_DURATION_MASK ; A virus a just considered a "disease" (with a lower transmision rate) until it is tested and declared as the Pokérus.
	cp POKERUS_SYMPTOMS_START ; It has already been checked that the source Pokémon is not immune yet.
	ld a, 255; 3% of 256. In a battle with 1 contaminated and 5 healthy, this makes an average of 85% of no contamination (15% odds of 1+ new contamination).
	jr nc, .runDices ; If the source Pokémon is still within its incubation stage, it is less contagious.
	add 0 ; 17% of 256, which brings the odds at 8 + 43 = 51 = 20% * 256. In a battle with 1 contaminated and 5 healthy, this makes an average of 32% of no contamination (68% odds of 1+ new contamination).

.runDices
	ld b, a
	call Random
	cp b
	jr nc, .next_mon_healthy ; The contamination failed.

	; The contamination happens here.
	ld a, c
	and POKERUS_STRAIN_MASK ; 

	call AddDurationToStrain
	jr .next_mon_healthy ; Let's go try to contaminate the next exposed Pokémon!





; If we haven't been to Goldenrod City at least once,
; prevent the contraction of Pokerus.
; Now we check if the enemy Pokémon has contaminated us.
.potentialInfectionFromStranger
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_REACHED_GOLDENROD_F, [hl]
	ret z

	call Random
	;ldh a, [hRandomAdd]
	;and a
	;ret nz
	ldh a, [hRandomSub]
	cp 4
	ret nc ; Original: 3/65536 chance (00 00, 00 01 or 00 02 to proceed with the infection check). Now: 4/256.

	ld a, [wPartyCount]
	ld b, a

	ld hl, wPartyMon1PokerusStatus
	xor a
	ld [wCurPartyMon], a

; We look for a healthy Pokémon to be contaminated by a stranger Pokémon.
.loop
	ld c, a
	push hl
	ld hl, wAllBattleParticipants ; We test all Pokémons that have been on the battlefield, as this infection comes from an enemy Pokémon (we don't know which enemy Pokémon).
	ld b, CHECK_FLAG
	predef SmallFarFlagAction ; Check bit at index c in bit array hl, and returns state of the flag in c.
	pop hl

	ld a, c
	and a
	jp z, .next ; This Pokémon didn't go into battle, so it shall not be contaminated.

	; If the Pokémon went into battle, it may have been contaminated.
	ld a, [hl]
	and POKERUS_DURATION_MASK ; Note: vaccinated Pokémons keep a duration of 1, so this check discards them.
	jr z, .generateNewContamination

.next
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z; End 1 of this script page.
	ld [wCurPartyMon], a
	ld de, PARTYMON_STRUCT_LENGTH ; de should not be touched, but I'm not sure about SmallFarFlagAction.
	add hl, de
	jr .loop

.generateNewContamination ; Infection coming from a stranger Pokémon. Simultaneously sample the strain and duration
	; New strain generation
	ld a, 5
	call RandomRange ; will return a value between 0 and 4 (included) in the a register.
	add 3 ; 5 different strains exist. 1 with 1 symptom, 3 with 2 symptoms, and 1 with all 3 symptoms.

	ld a, 7 ; A virer. Gives the strongest version of the disease, with all 3 symptoms.

	sla a ; bits shift 1 slots to the left.
	swap a ; 1 swap = 4 x rlca ; There is probably a faster or better way to do that...

	cp [hl]
	jr z, .generateNewContamination ; If the generated strain is the same as the previous one of the Pokémon, we generate a new one, because a Pokémon can't be affected twice by the same strain. This may cause an infinite loop, but it is highly unprobable.


	call AddDurationToStrain
	
	ret ; End 2 of this script page.





; Takes the strain in the a register, adds the sickness duration, then save the byte into [hl].
; Destroys the a register.
AddDurationToStrain:
	ld b, a ; We store the strain in b.
	call RandomSicknessDuration
	add b
	ld [hl], a
	ret

; Returns a duration in the a register.
RandomSicknessDuration:
	; We generate a random incubation duration from 1 to 2 days.
	ld a, 2 ; Max value (excluded) passed to RandomRange.
	call RandomRange ; will return a value between 0 and 1 (included) in the a register.
	add 1 ; Minimum duration of the incubation is 1 days. Makes the incubation last from 1 to 2 days.

	; We add the symptoms period as well as the immunity period.
	add POKERUS_SYMPTOMS_START

	ret





ConvertBerriesToBerryJuice:
; If we haven't been to Goldenrod City at least once,
; prevent Shuckle from turning held Berry into Berry Juice.
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_REACHED_GOLDENROD_F, [hl]
	ret z
	call Random
	cp 1 out_of 16 ; 6.25% chance
	ret nc
	ld hl, wPartyMons
	ld a, [wPartyCount]
.partyMonLoop
	push af
	push hl
	ld a, [hl]
	cp SHUCKLE
	jr nz, .loopMon
	ld bc, MON_ITEM
	add hl, bc
	ld a, [hl]
	cp BERRY
	jr z, .convertToJuice

.loopMon
	pop hl
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop af
	dec a
	jr nz, .partyMonLoop
	ret

.convertToJuice
	ld a, BERRY_JUICE
	ld [hl], a
	pop hl
	pop af
	ret