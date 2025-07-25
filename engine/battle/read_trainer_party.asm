ReadTrainerParty:
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz

	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	xor a
	call ByteFill

	ld a, [wOtherTrainerClass]
	cp CAL
	jr nz, .not_cal2
	ld a, [wOtherTrainerID]
	cp CAL2
	jr z, .cal2
	ld a, [wOtherTrainerClass]
.not_cal2

	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	ld a, [hli]
	cp -1
	jr nz, .loop
	jr .skip_trainer
.got_trainer

.skip_name
	ld a, [hli]
	cp "@"
	jr nz, .skip_name

	ld a, [hli]
	ld [wOtherTrainerType], a
	ld d, h
	ld e, l
	call ReadTrainerPartyPieces

.done
	jmp ComputeTrainerReward

.cal2
	ld a, BANK(sMysteryGiftTrainer)
	call OpenSRAM
	ld a, TRAINERTYPE_MOVES
	ld [wOtherTrainerType], a
	ld de, sMysteryGiftTrainer
	call ReadTrainerPartyPieces
	call CloseSRAM
	jr .done

ReadTrainerPartyPieces:
	ld h, d
	ld l, e

	ld a, 0
	ld [wTempByteValue], a

.loop
; end?
	; Special case for Blue.
	ld a, [wOtherTrainerClass]
	cp BLUE
	jr c, .check_level
	cp OFFICER
	jr z, .check_level ; Special case for officers: they always only have a single Growlithe.
	cp SWAT + 1
	jr nc, .check_level

	ld a, [wTempByteValue] ; wTempByteValue contains the number of Pokemon added to the party of OT.
	and a
	jr nz, .check_if_party_full ; When no Pokemon has been added to the party yet (meaning we're going to add the first one), we need to inc to add an offset to the first Pokémon of the team.

	; At the first call, we add an offset to the starting point, so Blue's leading Pokémon isn't always the same.
	ld a, [wOtherTrainerClass]
	cp BLUE
	jr nz, .is_the_police

	call Random ; The leading Pokémon can be any of the first 8. We will then add 0~3, which makes any of the first 11 mons (index 0 to 10) in the pool the potential party leader.
	jr .seed_calculated

.is_the_police
	push hl
	farcall GetRandomPoliceSeed
	pop hl
	ldh a, [hDivisor]

.seed_calculated
	ld [wScriptVar], a
	and 7

	push bc
	ld bc, 7 ; 7 is the length of the struct.
	call AddNTimes
	pop bc

	ld a, [wTempByteValue]
.check_if_party_full	
	cp 6 ; Blue has a party of 6, but has more Pokémon in its database (for randomness).
	ret z

	; We increase the party counter.
	inc a
	ld [wTempByteValue], a
	add 2 ; The first rand used the first 3 bits, we want to skip those by starting at a minimum value of 3 (after the previous "inc a" and "add a").
	
	ld b, 7
	call Modulo
	ld b, a ; B contains the offset.
	and a
	ld a, [wScriptVar]
	jr z, .rand_offset_calculated
	
.rand_offset_loop
	srl a
	dec b
	jr nz, .rand_offset_loop

.rand_offset_calculated
	;call Random
	and 3 ; To simulate randomness, we increase hl by 1 to 3 Pokémon (struct length). We gave 30 Pokémons in Blue's pool. Note that reading a pokémon incs by one, which makes the pool index increase from 1+1=2 to 3+1=4 every loop.
	cp 3 ; If the result is already 3, we shouldn't inc it, otherwise it would give 4, which is out of our range.
	jr z, .after_inc
	inc a ; We want the min value to be 1, as we grouped mons by pair in the pool, in order to make their moveset vary.

.after_inc
	;push bc
	ld bc, 7 ; 7 is the length of the struct.
	call AddNTimes
	;pop bc

.check_level
	ld a, [hli]
	cp -1
	ret z

; level
	ld b, a ; We store the original level of the pkmn in B, for backup.

	push bc
	push hl

	ld hl, wJohtoAddLevel
	ld a, [wMapGroup]
	cp GROUP_ROUTE_27 ; Special case for the path to the victory road (Route 26 & 27), which should be considered from Johto for the purpose of the level curve.
	jr z, .region_determined

	call IsInJohto
	and a
	jr z, .region_determined

	inc hl ; wKantoAddLevel.
.region_determined
	ld a, [hl]

	pop hl
	pop bc
	
	add b ; We add the level increase to the original level.
	cp MAX_LEVEL + 1
	jr c, .level_capped

	ld a, MAX_LEVEL
.level_capped
	ld c, a ; We store the increased level of the pkmn in C, for backup.

	call IsFairTrainer ; Note that this is unoptimized, as it is called once per loop, but could be done once per trainer.
	ld a, c ; We retrieve the badge-increased level.
	jr nc, .lvl_determined ; If the current trainer does not match the class, it uses its fixed lvl.
	
	ld c, b ; We retrieve the original level.
	call GetPlayerHighestLevel ; Note that this is unoptimized, as it is called once per loop, but could be done once per trainer.

	ld b, a
	ld a, c
	; Here we have the enemy real/highest level in a, and the highest level of the player in b.
	cp b
	jr c, .lvl_determined
	jr z, .lvl_determined ; If both levels are the same, we take a shortcut.

	sub 40 ; The "power restrainer" can lower the level of a gym leader by 40 levels maximum.
	; No need to check if the level underflows, as we set the levels by hand and they all are above 41.
	; Here we have the enemy lowest possible level in a, and the highest level of the player in b.
	cp b
	jr nc, .lvl_determined
	jr z, .lvl_determined ; The lvl of the player is the minimum lvl of the gym, so we take a shortcut. Note: this shortcut may take more time than just executing the following action.

	ld a, b ; We give the Other Trainer pokemon the same level as the player's highest level.

.lvl_determined
	ld [wCurPartyLevel], a

; species?
	ld a, [hli]
	ld [wCurPartySpecies], a

; add to party
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	pop hl

; dvs?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_DVS_F, a
	jr z, .no_dvs

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1DVs
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

; When reading DVs, treat PERFECT_DV as $ff
	ld a, [hli]
	cp PERFECT_DV
	jr nz, .atk_def_dv_ok
	ld a, $ff
.atk_def_dv_ok
	ld [de], a
	inc de
	ld a, [hli]
	cp PERFECT_DV
	jr nz, .spd_spc_dv_ok
	ld a, $ff
.spd_spc_dv_ok
	ld [de], a
.no_dvs

; stat exp?
	ld a, [wOtherTrainerClass] ; Doing a hardcoded check rather than adding data into the db saves almost 600 ROM bytes.
	cp BLUE
	jr z, .force_perfect_stat_exp
	cp SWAT
	jr z, .force_perfect_stat_exp
	cp JENNY
	ld a, $55 ; third of max stat exp.
	jr z, .force_stat_exp
	jr .stat_exp_check

.force_perfect_stat_exp ; Blue and Swats get perfect stat exp.
	ld a, $ff
.force_stat_exp ; Jenny gets a third of the max stat exp.
	push af
	call GetLastOTMonStatExpAddress
	pop af
	ld c, NUM_EXP_STATS * 2
.force_perfect_stat_exp_loop
	ld [de], a
	inc de
	dec c
	jr nz, .force_perfect_stat_exp_loop
	jr .no_stat_exp

.stat_exp_check
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_STAT_EXP_F, a
	jr z, .no_stat_exp

.do_stat_exp
	call GetLastOTMonStatExpAddress

	ld c, NUM_EXP_STATS
.stat_exp_loop
; When reading stat experience, treat PERFECT_STAT_EXP as $FFFF
	ld a, [hl]
	cp LOW(PERFECT_STAT_EXP)
	jr nz, .not_perfect_stat_exp
	inc hl
	ld a, [hl]
	cp HIGH(PERFECT_STAT_EXP)
	dec hl
	jr nz, .not_perfect_stat_exp
	ld a, $ff
rept 2
	ld [de], a
	inc de
	inc hl
endr
	jr .continue_stat_exp

.not_perfect_stat_exp
rept 2
	ld a, [hli]
	ld [de], a
	inc de
endr
.continue_stat_exp
	dec c
	jr nz, .stat_exp_loop
.no_stat_exp

; item?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_ITEM_F, a
	jr z, .no_item

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

	ld a, [hli]
	ld [de], a
.no_item

; moves?
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_MOVES_F, a
	jr z, .no_moves

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
.no_moves

; Custom DVs or stat experience affect stats, so recalculate them after TryAddMonToParty
	ld a, [wOtherTrainerClass] ; Doing a hardcoded check rather than adding data into the db saves almost 600 ROM bytes.
	cp BLUE
	jr z, .force_stat_recalc
	cp SWAT
	jr z, .force_stat_recalc

	ld a, [wOtherTrainerType]
	and TRAINERTYPE_DVS | TRAINERTYPE_STAT_EXP
	jr z, .no_stat_recalc

.force_stat_recalc
	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1MaxHP
	call GetPartyLocation
	ld d, h
	ld e, l

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1StatExp - 1
	call GetPartyLocation

; recalculate stats
	ld b, TRUE
	push de
	predef CalcMonStats
	pop hl

; copy max HP to current HP
	inc hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b

	pop hl
.no_stat_recalc

	jmp .loop

GetLastOTMonStatExpAddress:
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1StatExp
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl
	ret

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a ; hMultiplicand + 0
	ld [hli], a ; hMultiplicand + 1
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a ; hMultiplicand + 2
	ld a, [wCurPartyLevel]
	ld [hl], a ; hMultiplier
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

Battle_GetTrainerName::
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ld hl, wOTPlayerName
	jp nz, CopyTrainerName

	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

GetTrainerName::
	ld a, c
	cp CAL
	jr nz, .not_cal2

	ld a, BANK(sMysteryGiftTrainerHouseFlag)
	call OpenSRAM
	ld a, [sMysteryGiftTrainerHouseFlag]
	and a
	call CloseSRAM
	jr z, .not_cal2

	ld a, BANK(sMysteryGiftPartnerName)
	call OpenSRAM
	ld hl, sMysteryGiftPartnerName
	call CopyTrainerName
	jmp CloseSRAM

.not_cal2
	ld a, [wOtherTrainerClass]
	cp OFFICER
	jr z, .is_the_police
	cp SERGEANT
	jr z, .is_the_police
	cp SWAT
	jr z, .is_the_police
	jr .not_the_police

.is_the_police
	farcall GetRandomPoliceName
	ld de, wStringBuffer1
	ret

.not_the_police
	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

.loop
	dec b
	jr z, CopyTrainerName

.skip
	ld a, [hli]
	cp $ff
	jr nz, .skip
	jr .loop

CopyTrainerName:
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	call CopyBytes
	pop de
	ret

; This function sets the carry flag if this trainer class must adapt
; the level of its Pokemon to the player.
; Destroys a (and the flags).
IsFairTrainer:
	ld a, [wOtherTrainerClass]

	; All gym leaders from johto.
	cp FALKNER
	jr z, .yes
	cp WHITNEY
	jr z, .yes
	cp BUGSY
	jr z, .yes
	cp MORTY
	jr z, .yes
	cp PRYCE
	jr z, .yes
	cp JASMINE
	jr z, .yes
	cp CHUCK
	jr z, .yes
	cp CLAIR
	jr z, .yes

	; All gym leaders from kanto.
	cp BROCK
	jr z, .yes
	cp MISTY
	jr z, .yes
	cp LT_SURGE
	jr z, .yes
	cp ERIKA
	jr z, .yes
	cp JANINE
	jr z, .yes
	cp SABRINA
	jr z, .yes
	cp BLAINE
	jr z, .yes
	cp BLUE
	jr z, .yes

	; All elite four.
	cp WILL
	jr z, .yes
	cp BRUNO
	jr z, .yes
	cp KAREN
	jr z, .yes
	cp KOGA
	jr z, .yes

	; Champion (special case for this one).
	cp CHAMPION
	jr z, .yes

	; Cal (Viridian Trainer Club).
	cp CAL
	jr z, .yes

	; Karate Master / Kiyo Blackbelt.
	cp BLACKBELT_T
	jr nz, .no

	ld a, [wOtherTrainerID]
	cp KIYO
	jr z, .yes

.no
	xor a ; Resets the carry flag.
	ret

.yes
	scf ; Sets the carry flag.
	ret

; Gets the level of the strongest Pokemon in the player's team, and stores it in A and hFarByte.
; Destroys the flags.
GetPlayerHighestLevel::
	push bc
	push hl

	ld hl, wPartyMon1Level
	ld de, PARTYMON_STRUCT_LENGTH
	lb bc, 0, 0 ; We start from the first pkmn of the team. ; The highest level is 0 at start.

.loop
	ld a, [hl] ; We get the level of this Pokémon.
	cp c
	jr c, .next
	ld c, a

.next
	add hl, de
	inc b
	ld a, [wPartyCount]
	cp b
	jr nz, .loop

	ld a, c ; We return the highest level in a.
	ldh [hFarByte], a
	pop hl ; Restoring dem values.
	pop bc
	ret

INCLUDE "data/trainers/parties.asm"