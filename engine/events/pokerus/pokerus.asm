GivePokerusAndConvertBerries: ; Called after each non-linked battle.
	call ConvertBerriesToBerryJuice
	call SpreadPokerusFromAllies ; Up to 1 Pokémon can be contaminated from its allies.
	call SpreadPokerusFromOpponents ; Up to 1 Pokémon from the opponent, which makes a maximum of 2 new contaminated Pokémons per battle.
	; The spread from opponents comes after the one from allies, otherwise we could go from 0 to 2 infected mons in a single battle.
	ret




SpreadPokerusFromAllies:
	ld a, [wAllBattleParticipantsAfterVirusSpread_ListLength] ; Note: this is 1 above the last index, as it's a length.
	cp 2
	ret c ; No time to waste if a single Pokemon has been sent into battle.

	dec a
	ld d, a ; Saving the current index into D.

.battle_participants_loop
	ld a, d
	ld hl, wAllBattleParticipantsAfterVirusSpread_ChronologicalList
	ld bc, 1
	call AddNTimes ; Add bc * a to hl. HL now points to the current index within the list.

	ld a, [hl] ; Retrieves the party index.
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes ; Add bc * a to hl.

	ld a, [hli] ; Species.
	cp SUICUNE
	jr z, .next_mon ; Suicune is the only Pokémon immune to covid.

	ld a, [hl] ; Item
	cp POKEMASK
	jr z, .next_mon ; Pokémask immunes to getting covid.

	ld bc, MON_PKRUS - MON_ITEM
	add hl, bc

	; A Pokémon with an active immune protection (duration > 0) can't be infected by another disease.
	ld a, [hl] ; PokerusStatus byte.
	and POKERUS_DURATION_MASK
	jr nz, .next_mon

	; The Pokémon is vulnerable to a virus, so we check all other mons that could have transmitted one.
	push de ; Preserves the index.
	push hl ; Nothing needs to be preserved here, and it's an easy access to this pokémon's pokerus byte if you "pop hl, push hl" within DetermineIfThisPokemonGotContaminedByAllies.
	call DetermineIfThisPokemonGotContaminedByAllies
	pop hl
	pop de

	ret nz ; If Z is unset, it means a Pokemon has been infected. Only 1 Pokemon per battle can be infected from its allies (so the virus doesn't get out of control).

.next_mon
	; Preparing for the next mon check.
	dec d
	ret z ; No need to check the first mon of the chronological list, as it is necessarily a contagious (infected within incubating or symptoms period) mon. So it can't be infected twice.

	jr .battle_participants_loop




; Input: D=list index of the original mon, HL=PokerusStatus of the original mon.
; Output: Z set/TRUE: no pokemon has been infected. Z unset/FALSE: a Pokémon was infected.
; Goes through all allies that have been sent into battle before this pokemon.
DetermineIfThisPokemonGotContaminedByAllies:
	ld c, FALSE
	ld a, [hl]
	and POKERUS_STRAIN_MASK
	ld e, a ; Saving the original strain to later compare against other ones.
	jr z, .next_mon

	call IsMildIllnessStrain
	jr c, .next_mon

	ld c, TRUE 

	; C is TRUE if the original Pokemon is immune to mild illnesses. 
	; Pokémon that caught COVID in the past are immune to mild illnesses because we need to keep a trace of previous COVID infections...
	; ...for the purpose of calculating the number of shots required when doing the vaccination.

.next_mon
	dec d
	ld a, d ; A now contains the list index.
	cp -1
	ret z

; Retrieving the previous battle participant party index.

	ld hl, wAllBattleParticipantsAfterVirusSpread_ChronologicalList
	push bc
	ld bc, 1
	call AddNTimes ; Add bc * a to hl.
	pop bc

	ld a, [hl] ; Retrieves the party index from the list.
	ld hl, wPartyMon1Item
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes ; Add bc * a to hl.
	pop bc 

	ld a, [hl]
	cp POKEMASK
	jr z, .next_mon ; Pokémask immunes to spreading covid.

	push bc
	ld bc, MON_PKRUS - MON_ITEM
	add hl, bc
	pop bc 

; Checking if the previous battle participant is contagious.
	ld a, [hl] ; Pokerus byte from selected party member.
	and POKERUS_DURATION_MASK
	cp POKERUS_SYMPTOMS_START + 1 ; A pokemon is only contagious during the incubation and symptoms phases.
	jr c, .next_mon 

	; At the this point, a Pokémon that is contagious has been sent into battle prior to the Pokémon we are checking.
	; So the mon we're checking might have been infected!

; Checking if the previous battle participant is contagious of a mild illness.
	call IsMildIllnessStrain
	jr nc, .pokemon_can_be_infected ; If the cur mon has covid, it can infect everyone no matter their previous disease.

	; The previously sent Pokémon had a mild illness.
	ld a, c
	cp TRUE
	jr z, .next_mon ; Our original pokémon cannot be infected by a mild illness, so we move on to the next mon.

.pokemon_can_be_infected
; Checking if the original mon is immune to the disease of the previous	battle participant
	ld a, [hl] ; Pokerus byte from selected party member.
	and POKERUS_STRAIN_MASK
	ld b, a ; Saving the strain that could become the source of infection.
	cp e ; We compare the strains.
	jr z, .next_mon ; A Pokemon can't be infected twice in a row by the same strain. This is some kind of long-term immunity, to allow the player to breath a little if she/he can't handle the spread.

	; Now the only chance for the Pokémon to avoid the contamination, is to make a good dice roll.

; Checking the luck of the original Pokémon...
	call Random
	cp 64 ; 64/256 odds of getting infected by this mon, or 25%.
	jr nc, .next_mon ; Lucky Pokémon, he just avoided the infection!

	; Some maths:
	; If a Pokémon has been sent after all other infected party members, it'll have 5 checks.
	; Its odds of getting through the infection are ((256-64))/256)^5 = 23.7%.
	; In other words, this mon has 76.3% odds of getting infected per battle, if sent after all 5 other infected party members.

	; If sent 6th, but only the first mon was infected, the odds of getting infected are 25% for this last mon only.
	; The combined odds of any mon from the team getting infected are (1-(64/256))^5 = 76.3% of 1 of the 5 mons getting infected.

	pop de ; pops the PC of the return function (needs to be re-added after, or return will fail).
	pop hl ; HL now contains the original pokemon's PokerusStatus byte.
	push hl
	push de ; adds the return pointer back into the stack.
	call InfectMon ; The Pokémon has been infected!

	rla ; Unsetting the Z flag. Signifies that a Pokémon has been infected.
	ret





SpreadPokerusFromOpponents:
	ld a, [wPlayerTurnsTaken]
	ld d, a
	ld a, [wEnemyTurnsTaken]
	add d
	jr z, .clear_seed_then_return ; The player can't get covid if he/she runs away immediately, or catches the Pokémon at first try. Getting assaulted may give it, which it what we expect.
	; Note that this previous check is only useful for a first-turn catch, as this function is not currently called when running away.

	ld hl, wBattlePokerusSeed
	ld a, [hl]
	and a
	ret z ; If the battle seed is zero, then we can exit.

	call IsMildIllnessStrain
	ld d, FALSE
	jr nc, .strain_identified
	ld d, TRUE ; If D is true, then the battle seed is a mild illness.

.strain_identified
	ld a, [wPartyCount]
	ld b, a

	ld hl, wPartyMon1Species
	xor a
	ld [wCurPartyMon], a

; We look for a healthy Pokémon to be contaminated by a stranger Pokémon.
.loop
	push hl
	ld c, a ; C contains the party index.
	push hl
	ld hl, wAllBattleParticipants ; We test all Pokémons that have been on the battlefield, as this infection comes from an enemy Pokémon (we don't know which enemy Pokémon).
	ld b, CHECK_FLAG
	predef SmallFarFlagAction ; Check bit at index c in bit array hl, and returns state of the flag in c.
	pop hl

	ld a, c
	and a
	jp z, .next ; This Pokémon didn't go into battle, so it shall not be contaminated. This also discards eggs.

	; If the Pokémon went into battle, it may have been contaminated.
	ld a, [hli] ; Species.
	cp SUICUNE
	jr z, .next ; Suicune is immune to covid.

	ld a, [hl] ; Item.
	cp POKEMASK
	jr z, .next ; Pokémask immunes to covid.

	push bc
	ld bc, MON_PKRUS - MON_ITEM
	add hl, bc
	pop bc

	ld a, [hl]
	and POKERUS_DURATION_MASK 
	jr nz, .next

	; If the battle strain is the same as the Pokémon's previous strain, then it is immune to it indefinitely.
	ld a, [hl]
	and POKERUS_STRAIN_MASK 
	ld e, a

	ld a, [wBattlePokerusSeed]
	and POKERUS_STRAIN_MASK
	cp e
	jr z, .next ; Both strains are identical, so the Pokémon is immune.

	ld a, d
	and a
	jr z, .do_infect ; If the battle strain is not a mild disease, it means it's a covid strain. Then it can infect any Pokémon, no matter what virus it caught in the past.

	; From here on, we know the battle strain is a mild illness, and not everyone can catch it: Pokémon that had Covid in the past are immune to mild illnesses.

	ld a, [hl]
	and POKERUS_STRAIN_MASK 
	jr z, .do_infect ; If the Pokémon has never been sick, then it can catch this mild disease.

	call IsMildIllnessStrain
	jr c, .do_infect ; If the Pokémon had a mild illness in the past, it can catch this mild illness.

	; At this point, we know the Pokémon has a covid strain and is trying to get infected by a mild disease, which is not possible.
	; So we skip this Pokémon and go to the next one.

.next
	pop hl
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, .clear_seed_then_return
	
	ld [wCurPartyMon], a
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	jr .loop

.do_infect
	ld a, [wBattlePokerusSeed]
	and POKERUS_STRAIN_MASK
	ld d, a
	call RandomSicknessDuration
	or d
	ld [hl], a
	pop hl ; We do this to balance the stack.

.clear_seed_then_return
	xor a
	ld [wBattlePokerusSeed], a
	ret

; Input: HL=pokerus byte to edit/infect.
; Generates a random covid strain.
; The odds match the historical data.
; DE can be clobbered.
SetWildBattleCovidStrain_OrMildIllness:
	ld a, [wYearMonth]
	cp $08
	jr nc, SetWildBattleCovidStrain.checks ; Starting from September 2020, the player can't get mild illnesses.

	; Roll for mild illness.
	sub 3 ; A is between 0 and 4.
	jr nc, .flooring_done

	xor a
.flooring_done
	push bc
	ld c, 50
	call SimpleMultiply
	pop bc

	ld b, a
	call Random
	cp b
	jr z, SetWildBattleCovidStrain.original_strain
	jr c, SetWildBattleCovidStrain.original_strain

	; --- Mild illness generation ---
	; April 2020 and before: 100% mild illness
	; May 2020: ~80% mild illness, ~20% original covid strain
	; June 2020: ~60% mild illness, ~40% original covid strain
	; July 2020: ~40% mild illness, ~60% original covid strain
	; August 2020: ~20% mild illness, ~80% original covid strain
	; September 2020: 100% original covid strain

	ld b, 3
	call Modulo
	ld b, 1
	and a
	jr z, .swap_seed

.shift_loop
	sla b
	dec a
	jr nz, .shift_loop

.swap_seed
	sla b
	swap b
	jr InfectMon

; Input: HL=pokerus byte to edit/infect.
; Generates a random covid strain.
; The odds match the historical data.
; DE can be clobbered.
SetWildBattleCovidStrain:
	ld a, [wYearMonth]
.checks
	cp $10
	jr c, .original_strain ; Before January 2021, original strain.

	cp $20 ; 2 bytes.
	jr z, .january_2022 ; 2 bytes. ; We erect a special case for January 2022, as it allows to discard many cases from the database. 
	; This saves 15+ ROM bytes. 
	; The current system takes 13 bytes.
	; With the other system, the database would need an additional 28 bytes.
	; As well as a more complicated logic that would add even more code and wasted ROM.

	cp $21
	jr nc, .omicron ; Starting from February 2022, Omicron only.

	; We are left with the period from January 2021 to December 2021.

	cp $18
	jr nc, .delta ; Starting from September 2021 to December 2021, it is Delta only.

	; We are left with the period from January 2021 to August 2021.
	; In this period, we use formula to retrieve the correct variant from a historical database.

	sub $10 ; We subtract January 2021, because it is index 0 of our database.
	ld b, a
	add a
	add b ; Multiply a by 3.

	push hl
	ld e, a
	ld d, 0
	ld hl, VariantsOdds
	add hl, de

	call Random
	ld b, POKERUS_ORIGINAL_STRAIN >> 5 ; Original strain divided by 32.
.loop
	cp [hl]
	jr z, .exit_loop
	jr c, .exit_loop

	inc hl
	inc b
	inc b
	jr .loop

.exit_loop
	sla b
	swap b
	pop hl
	jr InfectMon

.original_strain
	ld b, POKERUS_ORIGINAL_STRAIN
	jr InfectMon

.january_2022
	; In January 2022: 61.6% Omicron, 38.4% Delta.
	ld b, POKERUS_OMICRON_STRAIN ; 2 bytes.
	call Random ; 3 bytes.
	cp 157 ; 2 bytes.
	jr c, InfectMon ; 2 bytes.
	; fallthrough.

.delta
	ld b, POKERUS_DELTA_STRAIN
	jr InfectMon

.omicron
	ld b, POKERUS_OMICRON_STRAIN
	; fallthrough

; Input: HL=pokerus byte to edit/infect. B=strain to copy (test bit must be 0).
; Output: HL=edited pokerus byte (strain + duration).
; Note: the test bit isn't addressed here. 
; If a Pokémon gets infected, it means that its duration must be 0, and therefore its test bit must be 0/unset.
InfectMon:
	call RandomSicknessDuration
	add b
	ld [hl], a
	ret

VariantsOdds:
	; Original, Alpha, Delta
    db 211, 255, 255 ; 0x10 January 2021
    db 146, 255, 255 ; 0x11 February 2021
    db 109, 255, 255 ; 0x12 March 2021
    db  31, 255, 255 ; 0x13 April 2021
    db  18, 249, 255 ; 0x14 May 2021
    db  16, 240, 255 ; 0x15 June 2021
    db   7,  85, 255 ; 0x16 July 2021
    db   1,   6, 255 ; 0x17 August 2021
	

; Returns a duration in the a register.
RandomSicknessDuration:
	push bc
	call IsInJohto
	pop bc
	cp KANTO_REGION
	ld a, 0
	jr z, .shortest_incubation ; If the player is in Kanto, the incubation is shorter.

	; We generate a random incubation duration from 1 to 2 days.
	ld a, 2 ; Max value (excluded) passed to RandomRange.
	call RandomRange ; will return a value between 0 and 1 (included) in the a register.
.shortest_incubation
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




AddPartyMonIndexToChronologicalList::
	ld hl, wAllBattleParticipantsAfterVirusSpread ; This flag retains the list of the Pokémons that showed up on the battlefield, after a contamined Pokémon was on it.
	push bc
	ld b, CHECK_FLAG
	predef SmallFarFlagAction ; The result is given in C.
	ld a, c
	and a
	pop bc
	ret nz ; If the flag was already set, it means this Pokémon is already in the list. We don't want to include it as a duplicate.

	; Otherwise, we add the Pokémon to the flag array. 
	push bc
	predef SmallFarFlagAction ; B contains SET_FLAG, and C contains [wCurBattleMon] because of the previous pop bc.
	pop bc

	; And now we add it to the chronological list.
	push de ; I don't know if de must be preserved, so I do it to be safe.
	ld hl, wAllBattleParticipantsAfterVirusSpread_ListLength
	ld a, [hl]
	ld e, a
	ld d, 0
	inc [hl]
	ld hl, wAllBattleParticipantsAfterVirusSpread_ChronologicalList
	add hl, de ; hl now contains the first empty index of the list.

	ld a, c
	ld [hl], a ; The pokemon party index has been added to the chronological list!
	pop de
	ret

; Up to 25% chances of covid per wild battle in February 2022.
HistoricalInfectionOdds::
	db 0	; 0x00 January 2020
	db 0	; 0x01 February 2020
	db 1	; 0x02 March 2020
	db 2	; 0x03 April 2020
	db 2	; 0x04 May 2020
	db 2	; 0x05 June 2020
	db 4	; 0x06 July 2020
	db 5	; 0x07 August 2020
	db 6	; 0x08 September 2020
	db 6	; 0x09 October 2020
	db 10	; 0x0a November 2020
	db 12	; 0x0b December 2020
	
	db 12	; 0x10 January 2021
	db 10	; 0x11 February 2021
	db 8	; 0x12 March 2021
	db 12	; 0x13 April 2021
	db 16	; 0x14 May 2021
	db 10	; 0x15 June 2021
	db 8	; 0x16 July 2021
	db 12	; 0x17 August 2021
	db 13	; 0x18 September 2021
	db 9	; 0x19 October 2021
	db 9	; 0x1a November 2021
	db 12	; 0x1b December 2021

	db 30	; 0x20 January 2022
	db 64	; 0x21 February 2022
	db 30	; 0x22 March 2022
	db 28	; 0x23 April 2022
	db 12	; 0x24 May 2022
	db 12	; 0x25 June 2022
	db 16	; 0x26 July 2022
	db 20	; 0x27 August 2022
	db 13	; 0x28 September 2022
	db 9	; 0x29 October 2022
	db 7	; 0x2a November 2022
	db 10	; 0x2b December 2022

	db 10	; 0x30 January 2023
	db 4	; 0x31 February 2023
	db 3	; 0x32 March 2023
	db 2	; 0x33 April 2023
	db 2	; 0x34 May 2023
	db 1	; 0x35 June 2023
	db 1	; 0x36 July 2023
	db 1	; 0x37 August 2023
	db 2	; 0x38 September 2023
	db 1	; 0x39 October 2023
	db 1	; 0x3a November 2023
	db 1	; 0x3b December 2023

;00 0
;01 0
;02 0
;03 70000
;04 84000
;05 110000
;06 184000
;07 264000
;08 270000
;09 300000
;0a 496000
;0b 585000
;
;10 609000
;11 520000
;12 389000
;13 585000
;14 821000
;15 480000
;16 382000
;17 600000
;18 665000
;19 460000
;1a 447000
;1b 600000
;
;20 1500000
;21 3200000
;22 1500000
;23 1407000
;24 576000
;25 585000
;26 790000
;27 1000000
;28 665000
;29 463000
;2a 355000
;2b 485000
;
;30 508000
;31 206000
;32 150000
;33 112000
;34 95000
;35 57000
;36 37000
;37 68000
;38 70000
;39 45000
;3a 41000
;3b 59000
