_DoItemEffect::
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	call CopyName1
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	dec a
	ld hl, ItemEffects
	rst JumpTable
	ret

ItemEffects:
; entries correspond to item ids (see constants/item_constants.asm)
	table_width 2, ItemEffects
	dw PokeBallEffect      ; MASTER_BALL
	dw PokeBallEffect      ; ULTRA_BALL
	dw NoEffect            ; BRIGHTPOWDER
	dw PokeBallEffect      ; GREAT_BALL
	dw PokeBallEffect      ; POKE_BALL
	dw TownMapEffect       ; TOWN_MAP
	dw BicycleEffect       ; BICYCLE
	dw EvoStoneEffect      ; MOON_STONE
	dw StatusHealingEffect ; ANTIDOTE
	dw StatusHealingEffect ; BURN_HEAL
	dw StatusHealingEffect ; ICE_HEAL
	dw StatusHealingEffect ; AWAKENING
	dw StatusHealingEffect ; PARLYZ_HEAL
	dw FullRestoreEffect   ; FULL_RESTORE
	dw RestoreHPEffect     ; MAX_POTION
	dw RestoreHPEffect     ; HYPER_POTION
	dw RestoreHPEffect     ; SUPER_POTION
	dw RestoreHPEffect     ; POTION
	dw EscapeRopeEffect    ; ESCAPE_ROPE
	dw RepelEffect         ; REPEL
	dw RestorePPEffect     ; MAX_ELIXER
	dw EvoStoneEffect      ; FIRE_STONE
	dw EvoStoneEffect      ; THUNDERSTONE
	dw EvoStoneEffect      ; WATER_STONE
	dw NoEffect            ; WIDE_LENS
	dw VitaminEffect       ; HP_UP
	dw VitaminEffect       ; PROTEIN
	dw VitaminEffect       ; IRON
	dw VitaminEffect       ; CARBOS
	dw NoEffect            ; LUCKY_PUNCH
	dw VitaminEffect       ; CALCIUM
	dw RareCandyEffect     ; RARE_CANDY
	dw XAccuracyEffect     ; X_ACCURACY
	dw EvoStoneEffect      ; LEAF_STONE
	dw NoEffect            ; METAL_POWDER
	dw NoEffect            ; TOILET PAPER (NUGGET)
	dw PokeDollEffect      ; POKE_DOLL
	dw StatusHealingEffect ; FULL_HEAL
	dw ReviveEffect        ; REVIVE
	dw ReviveEffect        ; MAX_REVIVE
	dw GuardSpecEffect     ; GUARD_SPEC
	dw SuperRepelEffect    ; SUPER_REPEL
	dw MaxRepelEffect      ; MAX_REPEL
	dw DireHitEffect       ; DIRE_HIT
	dw NoEffect            ; ITEM_2D
	dw RestoreHPEffect     ; FRESH_WATER
	dw RestoreHPEffect     ; SODA_POP
	dw RestoreHPEffect     ; LEMONADE
	dw XItemEffect         ; X_ATTACK
	dw NoEffect            ; ITEM_32
	dw XItemEffect         ; X_DEFEND
	dw XItemEffect         ; X_SPEED
	dw XItemEffect         ; X_SPECIAL
	dw CoinCaseEffect      ; COIN_CASE
	dw ItemfinderEffect    ; ITEMFINDER
	dw PokeFluteEffect     ; POKE_FLUTE
	dw NoEffect            ; EXP_SHARE
	dw OldRodEffect        ; OLD_ROD
	dw GoodRodEffect       ; GOOD_ROD
	dw NoEffect            ; SILVER_LEAF
	dw SuperRodEffect      ; SUPER_ROD
	dw RestorePPEffect     ; PP_UP
	dw RestorePPEffect     ; ETHER
	dw RestorePPEffect     ; MAX_ETHER
	dw RestorePPEffect     ; ELIXER
	dw NoEffect            ; RED_SCALE
	dw NoEffect            ; SECRETPOTION
	dw NoEffect            ; S_S_TICKET
	dw NoEffect            ; MYSTERY_EGG
	dw NoEffect            ; CLEAR_BELL
	dw NoEffect            ; SILVER_WING
	dw RestoreHPEffect     ; MOOMOO_MILK
	dw NoEffect            ; QUICK_CLAW
	dw StatusHealingEffect ; PSNCUREBERRY
	dw NoEffect            ; GOLD_LEAF
	dw NoEffect            ; SOFT_SAND
	dw NoEffect            ; SHARP_BEAK
	dw StatusHealingEffect ; PRZCUREBERRY
	dw StatusHealingEffect ; BURNT_BERRY
	dw StatusHealingEffect ; ICE_BERRY
	dw NoEffect            ; POISON_BARB
	dw NoEffect            ; KINGS_ROCK
	dw BitterBerryEffect   ; BITTER_BERRY
	dw StatusHealingEffect ; MINT_BERRY
	dw NoEffect            ; RED_APRICORN
	dw NoEffect            ; TINYMUSHROOM
	dw NoEffect            ; BIG_MUSHROOM
	dw NoEffect            ; SILVERPOWDER
	dw NoEffect            ; BLU_APRICORN
	dw NoEffect            ; ITEM_5A
	dw NoEffect            ; AMULET_COIN
	dw NoEffect            ; YLW_APRICORN
	dw NoEffect            ; GRN_APRICORN
	dw NoEffect            ; CLEANSE_TAG
	dw NoEffect            ; MYSTIC_WATER
	dw NoEffect            ; TWISTEDSPOON
	dw NoEffect            ; WHT_APRICORN
	dw NoEffect            ; BLACKBELT_I
	dw NoEffect            ; BLK_APRICORN
	dw NoEffect            ; ITEM_64
	dw NoEffect            ; PNK_APRICORN
	dw NoEffect            ; BLACKGLASSES
	dw NoEffect            ; SLOWPOKETAIL
	dw NoEffect            ; PINK_BOW
	dw NoEffect            ; STICK
	dw NoEffect            ; SMOKE_BALL
	dw NoEffect            ; NEVERMELTICE
	dw NoEffect            ; MAGNET
	dw StatusHealingEffect ; MIRACLEBERRY
	dw NoEffect            ; PEARL
	dw NoEffect            ; BIG_PEARL
	dw NoEffect            ; EVERSTONE
	dw NoEffect            ; SPELL_TAG
	dw RestoreHPEffect     ; RAGECANDYBAR
	dw NoEffect            ; GS_BALL
	dw BlueCardEffect      ; BLUE_CARD
	dw NoEffect            ; MIRACLE_SEED
	dw NoEffect            ; THICK_CLUB
	dw NoEffect            ; FOCUS_BAND
	dw NoEffect            ; ITEM_78
	dw EnergypowderEffect  ; ENERGYPOWDER
	dw EnergyRootEffect    ; ENERGY_ROOT
	dw HealPowderEffect    ; HEAL_POWDER
	dw RevivalHerbEffect   ; REVIVAL_HERB
	dw NoEffect            ; HARD_STONE
	dw NoEffect            ; LUCKY_EGG
	dw CardKeyEffect       ; CARD_KEY
	dw NoEffect            ; MACHINE_PART
	dw NoEffect            ; EGG_TICKET
	dw NoEffect            ; LOST_ITEM
	dw NoEffect            ; STARDUST
	dw NoEffect            ; STAR_PIECE
	dw BasementKeyEffect   ; BASEMENT_KEY
	dw NoEffect            ; PASS
	dw NoEffect            ; ITEM_87
	dw NoEffect            ; ITEM_88
	dw NoEffect            ; ITEM_89
	dw NoEffect            ; CHARCOAL
	dw RestoreHPEffect     ; BERRY_JUICE
	dw NoEffect            ; SCOPE_LENS
	dw NoEffect            ; ITEM_8D
	dw NoEffect            ; ITEM_8E
	dw NoEffect            ; METAL_COAT
	dw NoEffect            ; DRAGON_FANG
	dw NoEffect            ; ITEM_91
	dw NoEffect            ; LEFTOVERS
	dw NoEffect            ; ITEM_93
	dw NoEffect            ; ITEM_94
	dw NoEffect            ; ITEM_95
	dw RestorePPEffect     ; MYSTERYBERRY
	dw NoEffect            ; DRAGON_SCALE
	dw NoEffect            ; BERSERK_GENE
	dw NoEffect            ; HELIX_FOSSIL
	dw NoEffect            ; DOME_FOSSIL
	dw NoEffect            ; OLD_AMBER
	dw SacredAshEffect     ; SACRED_ASH
	dw PokeBallEffect      ; HEAVY_BALL
	dw NoEffect            ; FLOWER_MAIL
	dw PokeBallEffect      ; LEVEL_BALL
	dw PokeBallEffect      ; LURE_BALL
	dw PokeBallEffect      ; FAST_BALL
	dw NoEffect            ; ITEM_A2
	dw NoEffect            ; LIGHT_BALL
	dw PokeBallEffect      ; FRIEND_BALL
	dw PokeBallEffect      ; MOON_BALL
	dw PokeBallEffect      ; LOVE_BALL
	dw NormalBoxEffect     ; NORMAL_BOX
	dw GorgeousBoxEffect   ; GORGEOUS_BOX
	dw EvoStoneEffect      ; SUN_STONE
	dw NoEffect            ; POLKADOT_BOW
	dw NoEffect            ; ITEM_AB
	dw NoEffect            ; UP_GRADE
	dw RestoreHPEffect     ; BERRY
	dw RestoreHPEffect     ; GOLD_BERRY
	dw SquirtbottleEffect  ; SQUIRTBOTTLE
	dw NoEffect            ; ITEM_B0
	dw PokeBallEffect      ; PARK_BALL
	dw NoEffect            ; RAINBOW_WING
	dw NoEffect            ; POKEMASK
	assert_table_length POKEMASK
; The items past POKEMASK do not have effect entries:
;	BRICK_PIECE
;	SURF_MAIL
;	LITEBLUEMAIL
;	PORTRAITMAIL
;	LOVELY_MAIL
;	EON_MAIL
;	MORPH_MAIL
;	BLUESKY_MAIL
;	MUSIC_MAIL
;	MIRAGE_MAIL
;	ITEM_BE
; They all have the ITEMMENU_NOUSE attribute so they can't be used anyway.
; NoEffect would be appropriate, with the table then being NUM_ITEMS long.

PokeBallEffect::
	ld a, [wBattleMode]
	dec a
	jp nz, UseBallInTrainerBattle

	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .room_in_party

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nz, .room_in_party

	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld a, [sBoxCount]
	cp MONS_PER_BOX
	call CloseSRAM
	jp z, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	call nz, ReturnToBattle_UseBall

	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]

	call .MewtwoMasterBallAvoidance
	ret c

	ld hl, ItemUsedText
	call PrintText

	ld a, [wEnemyMonCatchRate]
	ld b, a

	call .IsItMewtwoBattle
	jr nc, .catch_rate_modifiers_applied

	ld hl, wCeruleanCaveB3FMewtwoCatchRate
	ld a, [hl]
	sub MEWTWO_ENCOUNTER_CATCHRATE_BOOST ; We want Mewtwo's catchrate to be 0 at first. So we subtract the encounter boost which is added at the start of each encounter.
	srl a
	srl a
	srl a ; Divide the value by 8.
	ld b, a ; Mewtwo's base catch rate has been updated.

	; Now we update the catchrate.
	; To increase Mewtwo's catchrate by 1 (up to 20), you need: 
	; 8 Pokéballs or
	; 2 Ultra Balls
	; 4 of any other balls
	; Master Ball doesn't matter as it ends the battle (whether Mewtwo teleported away or got caught).

	ld a, [hl]
	cp MEWTWO_MAX_CATCHRATE + MEWTWO_ENCOUNTER_CATCHRATE_BOOST
	jr nc, .catch_rate_modifiers_applied

	inc [hl]
	ld a, [wCurItem]
	cp POKE_BALL
	jr z, .catch_rate_modifiers_applied

	inc [hl]
	cp ULTRA_BALL
	jr nz, .catch_rate_modifiers_applied

	inc [hl]
	inc [hl]

.catch_rate_modifiers_applied
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jp z, .catch_without_fail

	ld a, [wCurItem]
	cp MASTER_BALL
	jp z, .catch_without_fail

	ld c, a
	ld hl, BallMultiplierFunctionTable

.get_multiplier_loop
	ld a, [hli]
	cp $ff
	jr z, .skip_or_return_from_ball_fn
	
	cp c
	jr z, .call_ball_function

	inc hl
	inc hl
	jr .get_multiplier_loop

.call_ball_function
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .skip_or_return_from_ball_fn
	push de
	jp hl

.skip_or_return_from_ball_fn
	ld a, [wCurItem]
	cp LEVEL_BALL
	ld a, b
	jp z, .end_calculations

	ldh [hMultiplicand + 2], a ; Stores the modified catch rate (after ball multiplier).

	ld hl, wEnemyMonHP
	ld b, [hl] ; [HP], high byte.
	inc hl
	ld c, [hl] ; [HP + 1], low byte.
	inc hl
	ld d, [hl] ; [MaxHP], high byte.
	inc hl
	ld e, [hl] ; [MaxHP + 1], low byte.

	; Current HP -= 1.
	ld a, c
	sub 1
	ld c, a
	ld a, b
	sbc 0
	ld b, a

	; Max HP -= 1.
	ld a, e
	sub 1
	ld e, a
	ld a, d
	sbc 0
	ld d, a

	; Current HP * 2.
	sla c
	rl b

	; Max HP * 3.
	ld h, d
	ld l, e
	add hl, de
	add hl, de
	ld d, h
	ld e, l
	
; While Max HP's value is bigger than 1 byte, we divide it and HP by 2.
	call .reduce_hp_to_one_byte
	jr .one_byte_values

.reduce_hp_to_one_byte
	ld a, d
	and a
	ret z

	srl d
	rr e
	srl b
	rr c

	jr .reduce_hp_to_one_byte

.one_byte_values
	; We subtract HP from Max HP.
	ld a, e
	sub c
	ld c, a

	; We now square both values (fits within 2 bytes).
	ldh a, [hMultiplicand + 2] ; Backup the modified catch rate (after ball effect).
	ld l, a

	ld a, c
	ldh [hMultiplicand + 2], a
	ldh [hMultiplier], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply ; HP squared.	
	ldh a, [hProduct + 3]
	ld c, a
	ldh a, [hProduct + 2]
	ld b, a

	ld a, e
	ldh [hMultiplicand + 2], a
	ldh [hMultiplier], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply ; HP squared.	
	ldh a, [hProduct + 3]
	ld e, a
	ldh a, [hProduct + 2]
	ld d, a

	call .reduce_hp_to_one_byte

	ld a, l ; Retrieving the modified catch rate (after ball effect).
	ldh [hMultiplicand + 2], a

	ld a, c ; C represents (MaxHP - CurHP)².
	ldh [hMultiplier], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply

	ld a, e ; E represents MaxHP².
	ldh [hDivisor], a
	ld b, 4 ; Tells Divide to work with 4 bytes.
	call Divide

	ldh a, [hQuotient + 3]
	and a
	jr nz, .stats_level_check

	ld a, 0 ; Min modified catch rate is 0.

.stats_level_check
	ld b, a ; Backup the current catch rate.
	xor a
	lb de, 7, NUM_BATTLE_STATS
	ld hl, wEnemyStatLevels

.stats_level_check_loop
	add [hl]
	inc hl
	sub d ; Twice as fast as doing "sub 7".

	dec e
	jr nz, .stats_level_check_loop

	and a
	jr z, .add_total_stat_boost

	bit 7, a ; Checking if the total stat boost is positive or negative. Note that the value is reversed at this point: a positive value means positive stat boost, which should reduce the catch rate, and therefore be subtracted.
	jr z, .sub_total_stat_boost

.add_total_stat_boost
	; We get the opposite of A. Because a negative total stat boost should increase the catch rate.
	cpl
	inc a

	add b
	jp c, .catch_without_fail ; In case the catch rate is above the maximum of 255, it's a sure catch. No need to check for the other parameters, as nothing can reduce the catch rate after the current check.
	jr .one_hp_check

.sub_total_stat_boost
	cp b
	jr nc, .floor_catch_rate

	ld c, a
	ld a, b
	sub c
	jr .one_hp_check

.floor_catch_rate
	ld a, 0

.one_hp_check
	ld b, a
	ld hl, wEnemyMonHP
	ld a, [hli] ; [HP], high byte.
	and a
	jr nz, .slp_frz_status_check
	ld a, [hl] ; [HP + 1], low byte.
	cp 1
	jr nz, .slp_frz_status_check

	; 6 bonus points of catch rate if the wild pokemon is at exactly 1 HP left.
	ld a, 6
	add b
	jp c, .catch_without_fail
	ld b, a

.slp_frz_status_check
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	ld a, b
	jr z, .par_psn_brn_status_check

	; x2.5
	srl a
	add b
	jp c, .catch_without_fail

	add b
	jp c, .catch_without_fail

	jr .low_level_check

; Output : carry if it is the Mewtwo fight.
.IsItMewtwoBattle::
	ld a, [wTempEnemyMonSpecies] ; wEnemyMonSpecies can be overriden by Transform.
	cp MEWTWO
	jr nz, .masterball_succeeds

	ld a, [wCurLandmark]
	cp LANDMARK_CERULEAN_CAVE
	jr nz, .masterball_succeeds

	jr .return_carry

; Output: nc if the master ball should proceed as normal.
.MewtwoMasterBallAvoidance:
	ld a, [wCurItem]
	cp MASTER_BALL
	jr nz, .masterball_succeeds

	call .IsItMewtwoBattle
	jr nc, .masterball_succeeds

	farcall TryEnemyFlee.IsMewtwoStrongEnoughToStay
	ret nc

; If wild Mewtwo is still strong enough, it will avoid the Master Ball.
	ld hl, ItemUsedButNopeText
	call PrintText

	ld de, TELEPORT
	call SetPlayerTurn
	farcall PlayOpponentBattleAnim

	ld a, BANK(wWindowStackBottom)
	ld hl, wWindowStackBottom - 2
	call GetFarWRAMByte
	res 0, a ; Tells the upper menu in the stack to not call RestoreTileBackup on Exit, because it causes Mewtwo to re-appear after its teleport animation.
	ldh [hWriteByte], a

	ld a, BANK(wWindowStackBottom)
	call WriteFarWRAMByte

	ld a, $1	
	ld [wBattleEnded], a
	inc a
	ld [wBattleResult], a ; DRAW

.return_carry
	scf
	ret

.masterball_succeeds
	xor a
	ret

.par_psn_brn_status_check
	ld a, [wEnemyMonStatus]
	and a
	ld a, b
	jr z, .low_level_check

	; x1.5
	srl a
	add b
	jr c, .catch_without_fail

.low_level_check
	ld b, a ; Backup the current catch rate.

	ld a, [wEnemyMonLevel]
	cp CAPTURE_MAX_LEVEL_BOOST
	jr nc, .end_calculations

	ld d, a
	ld a, CAPTURE_MAX_LEVEL_BOOST
	sub d

	; Multiply the diff by 8.
	add a ; x2
	add a ; x4
	add a ; x8

	; Add the result to the final result (post status bonus).
	add b
	jr c, .catch_without_fail

.end_calculations
	ld b, a
	ld [wFinalCatchRate], a
	cp $ff
	jr z, .catch_without_fail

	call Random
	cp b	
	ld a, 0
	jr nc, .fail_to_catch

.catch_without_fail
	ld a, [wEnemyMonSpecies]

.fail_to_catch
	ld [wWildMon], a
	ld c, 10
	call DelayFrames

	ld a, [wCurItem]
	cp POKE_BALL + 1 ; Assumes Master/Ultra/Great come before
	jr c, .not_kurt_ball
	ld a, POKE_BALL
.not_kurt_ball
	ld [wBattleAnimParam], a

	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ldh [hBattleTurn], a
	ld [wThrownBallWobbleCount], a
	ld [wNumHits], a
	predef PlayBattleAnim

	ld a, [wWildMon]
	and a
	jr nz, .caught
	ld a, [wThrownBallWobbleCount]
	cp 1
	ld hl, BallBrokeFreeText
	jp z, .shake_and_break_free
	cp 2
	ld hl, BallAppearedCaughtText
	jp z, .shake_and_break_free
	cp 3
	ld hl, BallAlmostHadItText
	jp z, .shake_and_break_free
	cp 4
	ld hl, BallSoCloseText
	jp z, .shake_and_break_free

.caught
	ld hl, wBattleResult
	set BATTLERESULT_CAUGHT_POKEMON, [hl]
	
	ld hl, wEnemyMonStatus
	ld a, [hli]
	push af
	inc hl
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl
	ld hl, wEnemyMonItem
	ld a, [hl]
	push af
	push hl
	ld hl, wEnemySubStatus5
	ld a, [hl]
	push af
	set SUBSTATUS_TRANSFORMED, [hl]

	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .load_data

	ld hl, wEnemyBackupDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a

.load_data
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	farcall LoadEnemyMon

	pop af
	ld [wEnemySubStatus5], a

	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hld], a
	dec hl
	pop af
	ld [hl], a

	ld hl, wEnemySubStatus5
	bit SUBSTATUS_TRANSFORMED, [hl]
	jr nz, .Transformed
	ld hl, wWildMonMoves
	ld de, wEnemyMonMoves
	ld bc, NUM_MOVES
	call CopyBytes

	ld hl, wWildMonPP
	ld de, wEnemyMonPP
	ld bc, NUM_MOVES
	call CopyBytes

.Transformed:
	ld a, [wEnemyMonSpecies]
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jp z, .FinishTutorial

	farcall StubbedTrainerRankings_WildMonsCaught

	ld hl, Text_GotchaMonWasCaught
	call PrintText

	call ClearSprites

	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon

	ld a, c
	push af
	ld a, [wTempSpecies]
	dec a
	call SetSeenAndCaughtMon
	pop af
	and a
	jr nz, .skip_pokedex

	call CheckReceivedDex
	jr z, .skip_pokedex

	ld hl, NewDexDataText
	call PrintText

	call ClearSprites

	ld a, [wEnemyMonSpecies]
	ld [wTempSpecies], a
	predef NewPokedexEntry

.skip_pokedex
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jp z, .catch_bug_contest_mon
	cp BATTLETYPE_CELEBI
	jr nz, .not_celebi
	ld hl, wBattleResult
	set BATTLERESULT_CAUGHT_CELEBI, [hl]
.not_celebi
	ld a, [wTempSpecies]
	cp MEWTWO
	jr nz, .not_mewtwo

	ld hl, wBattleResult
	set BATTLERESULT_CAUGHT_MEWTWO, [hl]

.not_mewtwo
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jp z, .SendToPC

	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites

	predef TryAddMonToParty

	farcall SetCaughtData
	
	ld a, [wBattlePokerusSeed]
	and a
	jr z, .SkipPokerusToParty
	
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1PokerusStatus
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld a, [wBattlePokerusSeed]
	ld [hl], a

.SkipPokerusToParty

	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipPartyMonFriendBall

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld a, FRIEND_BALL_HAPPINESS
	ld [hl], a

.SkipPartyMonFriendBall:
	ld hl, AskGiveNicknameText
	call PrintText

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName

	call YesNoBox
	jp c, .return_from_capture

	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	push de
	xor a ; PARTYMON
	ld [wMonType], a
	ld b, NAME_MON
	farcall NamingScreen

	call RotateThreePalettesRight

	call LoadStandardFont

	pop hl
	ld de, wStringBuffer1
	call InitName

	jmp .return_from_capture

.SendToPC:
	call ClearSprites

	predef SendMonIntoBox

	farcall SetBoxMonCaughtData

	ld a, BANK(sBoxCount)
	call OpenSRAM

	ld a, [sBoxCount]
	cp MONS_PER_BOX
	jr nz, .BoxNotFullYet
	ld hl, wBattleResult
	set BATTLERESULT_BOX_FULL, [hl]
.BoxNotFullYet:
	ld a, [wBattlePokerusSeed]
	and a
	jr z, .SkipPokerusToPC

	ld [sBoxMon1PokerusStatus], a

.SkipPokerusToPC
	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipBoxMonFriendBall
	; The captured mon is now first in the box
	ld a, FRIEND_BALL_HAPPINESS
	ld [sBoxMon1Happiness], a
.SkipBoxMonFriendBall:
	call CloseSRAM

	ld hl, AskGiveNicknameText
	call PrintText

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName

	call YesNoBox
	jr c, .SkipBoxMonNickname

	xor a
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	ld b, NAME_MON
	farcall NamingScreen

	ld a, BANK(sBoxMonNicknames)
	call OpenSRAM

	ld hl, wMonOrItemNameBuffer
	ld de, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, sBoxMonNicknames
	ld de, wStringBuffer1
	call InitName

	call CloseSRAM

.SkipBoxMonNickname:
	ld a, BANK(sBoxMonNicknames)
	call OpenSRAM

	ld hl, sBoxMonNicknames
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	call CloseSRAM

	ld hl, BallSentToPCText
	call PrintText

	call RotateThreePalettesRight
	call LoadStandardFont
	jr .return_from_capture

.catch_bug_contest_mon
	farcall BugContest_SetCaughtContestMon
	jr .return_from_capture

.FinishTutorial:
	ld hl, Text_GotchaMonWasCaught

.shake_and_break_free
	call PrintText
	call ClearSprites

.return_from_capture
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z
	cp BATTLETYPE_DEBUG
	ret z
	cp BATTLETYPE_CONTEST
	jr z, .used_park_ball

	ld a, [wWildMon]
	and a
	jr z, .toss

	call ClearBGPalettes
	call ClearTilemap

.toss
	ld hl, wNumItems
	inc a
	ld [wItemQuantityChange], a
	jmp TossItem

.used_park_ball
	ld hl, wParkBallsRemaining
	dec [hl]
	ret

BallMultiplierFunctionTable:
; table of routines that increase or decrease the catch rate based on
; which ball is used in a certain situation.
	dbw ULTRA_BALL,  UltraBallMultiplier
	dbw GREAT_BALL,  GreatBallMultiplier
	dbw SAFARI_BALL, SafariBallMultiplier ; Safari Ball, leftover from RBY
	dbw HEAVY_BALL,  HeavyBallMultiplier
	dbw LEVEL_BALL,  LevelBallMultiplier
	dbw LURE_BALL,   LureBallMultiplier
	dbw FAST_BALL,   FastBallMultiplier
	dbw MOON_BALL,   MoonBallMultiplier
	dbw LOVE_BALL,   LoveBallMultiplier
	dbw PARK_BALL,   ParkBallMultiplier
	db -1 ; end

UltraBallMultiplier:
; multiply catch rate by 2
	sla b
	ret nc
	ld b, $ff
	ret

SafariBallMultiplier:
GreatBallMultiplier:
ParkBallMultiplier:
; multiply catch rate by 1.5
	ld a, b
	srl a
	add b
	ld b, a
	ret nc
	ld b, $ff
	ret

GetPokedexEntryBank:
	push hl
	push de
	ld a, [wEnemyMonSpecies]
	dec a
	rlca
	rlca
	maskbits NUM_DEX_ENTRY_BANKS
	ld hl, .PokedexEntryBanks
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

.PokedexEntryBanks:
	db BANK("Pokedex Entries 001-064")
	db BANK("Pokedex Entries 065-128")
	db BANK("Pokedex Entries 129-192")
	db BANK("Pokedex Entries 193-251")

HeavyBallMultiplier:
; subtract 20 from catch rate if weight < 102.4 kg
; else add 0 to catch rate if weight < 204.8 kg
; else add 20 to catch rate if weight < 307.2 kg
; else add 30 to catch rate if weight < 409.6 kg
; else add 40 to catch rate (never happens)
	ld a, [wEnemyMonSpecies]
	ld hl, PokedexDataPointerTable
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, BANK(PokedexDataPointerTable)
	call GetFarWord

.SkipText:
	call GetPokedexEntryBank
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .SkipText

	call GetPokedexEntryBank
	push bc
	inc hl
	inc hl
if DEF(_FR_FR)
	call GetFarByte
	pop bc
else
	call GetFarWord

	srl h
	rr l
	ld b, h
	ld c, l

rept 4
	srl b
	rr c
endr
	call .subbc

	srl b
	rr c
	call .subbc

	ld a, h
	pop bc
	jr .compare

.subbc
	; subtract bc from hl
	push bc
	ld a, b
	cpl
	ld b, a
	ld a, c
	cpl
	ld c, a
	inc bc
	add hl, bc
	pop bc
	ret
endc

.compare
	ld c, a
	cp HIGH(1024) ; 102.4 kg
	jr c, .lightmon

	ld hl, .WeightsTable
.lookup
	ld a, c
	cp [hl]
	jr c, .heavymon
	inc hl
	inc hl
	jr .lookup

.heavymon
	inc hl
	ld a, b
	add [hl]
	ld b, a
	ret nc
	ld b, $ff
	ret

.lightmon
	ld a, b
	sub 20
	ld b, a
	ret nc
	ld b, $1
	ret

.WeightsTable:
; weight factor, boost
	db HIGH(2048),   0
	db HIGH(3072),  20
	db HIGH(4096),  30
	db HIGH(65280), 40

LureBallMultiplier:
; multiply catch rate by 3 if this is a fishing rod battle
	ld a, [wBattleType]
	cp BATTLETYPE_FISH
	ret nz

	ld a, b
	add a
	jr c, .max

	add b
	jr nc, .done
.max
	ld a, $ff
.done
	ld b, a
	ret

MoonBallMultiplier:
	push bc
	ld a, [wTempEnemyMonSpecies]
	dec a
	ld c, a
	ld b, 0
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
	pop bc

	push bc
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	cp EVOLVE_ITEM
	pop bc
	ret nz

	inc hl
	inc hl
	inc hl

	push bc
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	cp MOON_STONE
	pop bc
	ret nz

	sla b
	jr c, .max
	sla b
	jr nc, .done
.max
	ld b, $ff
.done
	ret

LoveBallMultiplier:
	; does species match?
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld a, [wTempBattleMonSpecies]
	cp c
	ret nz

	; check player mon species
	push bc
	ld a, [wTempBattleMonSpecies]
	ld [wCurPartySpecies], a
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	farcall GetGender
	jr c, .done1 ; no effect on genderless

	ld d, 0 ; male
	jr nz, .playermale
	inc d   ; female
.playermale

	; check wild mon species
	push de
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, WILDMON
	ld [wMonType], a
	farcall GetGender
	jr c, .done2 ; no effect on genderless

	ld d, 0 ; male
	jr nz, .wildmale
	inc d   ; female
.wildmale

	ld a, d
	pop de
	cp d
	pop bc
	ret z

	sla b
	jr c, .max
	sla b
	jr c, .max
	sla b
	ret nc
.max
	ld b, $ff
	ret

.done2
	pop de

.done1
	pop bc
	ret

FastBallMultiplier:
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld hl, FleeMons
	ld d, 3

.loop
	ld a, BANK(FleeMons)
	call GetFarByte

	inc hl
	cp -1
	jr z, .next
	cp c
	jr nz, .loop
	sla b
	jr c, .max

	sla b
	ret nc

.max
	ld b, $ff
	ret

.next
	dec d
	jr nz, .loop
	ret

LevelBallMultiplier:
; multiply catch rate by 8 if player mon level / 4 > enemy mon level
; multiply catch rate by 4 if player mon level / 2 > enemy mon level
; multiply catch rate by 2 if player mon level > enemy mon level
	ld a, [wBattleMonLevel]
	ld c, a
	ld a, [wEnemyMonLevel]
	cp c
	ret nc ; if player is lower level, we're done here
	sla b
	jr c, .max

	srl c
	cp c
	ret nc ; if player/2 is lower level, we're done here
	sla b
	jr c, .max

	srl c
	cp c
	ret nc ; if player/4 is lower level, we're done here
	sla b
	ret nc

.max
	ld b, $ff
	ret

BallBrokeFreeText:
	text_far _BallBrokeFreeText
	text_end

BallAppearedCaughtText:
	text_far _BallAppearedCaughtText
	text_end

BallAlmostHadItText:
	text_far _BallAlmostHadItText
	text_end

BallSoCloseText:
	text_far _BallSoCloseText
	text_end

Text_GotchaMonWasCaught:
	; Gotcha! @ was caught!@ @
	text_far Text_BallCaught
	text_asm
	call WaitSFX
	push bc
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_CAPTURE
	call PlayMusic
	pop bc
	ld hl, WaitButtonText
	ret

WaitButtonText:
	text_far _WaitButtonText
	text_end

BallSentToPCText:
	text_far _BallSentToPCText
	text_end

NewDexDataText:
	text_far _NewDexDataText
	text_end

AskGiveNicknameText:
	text_far _AskGiveNicknameText
	text_end

ReturnToBattle_UseBall:
	farcall _ReturnToBattle_UseBall
	ret

TownMapEffect:
	farcall PokegearMap
	ret

BicycleEffect:
	farcall BikeFunction
	ret

EvoStoneEffect:
	ld b, PARTYMENUACTION_EVO_STONE
	call UseItem_SelectMon

	jp c, .DecidedNotToUse

	ld a, MON_ITEM
	call GetPartyParamLocation

	ld a, [hl]
	cp EVERSTONE
	jr z, .NoEffect

	ld a, TRUE
	ld [wForceEvolution], a
	farcall EvolvePokemon

	ld a, [wMonTriedToEvolve]
	and a
	jr z, .NoEffect

	jmp UseDisposableItem

.NoEffect:
	call WontHaveAnyEffectMessage

.DecidedNotToUse:
	xor a
	ld [wItemEffectSucceeded], a
	ret

VitaminEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon

	jp c, RareCandy_StatBooster_ExitMenu

	call RareCandy_StatBooster_GetParameters

	call GetStatExpRelativePointer

	ld a, MON_STAT_EXP
	call GetPartyParamLocation

	add hl, bc
	ld a, [hl]
	cp VITAMIN_STAT_EXP_CAP
	jr nc, NoEffectMessage

	add VITAMIN_STAT_EXP_CAP / 2 ; Now, only 2 vitamins are necessary to reach the cap, instead of the original 10.
	ld [hl], a
	call UpdateStatsAfterItem

	call GetStatExpRelativePointer

	ld hl, StatStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	call CopyBytes

	call Play_SFX_FULL_HEAL

	ld hl, ItemStatRoseText
	call PrintText

	ld c, HAPPINESS_USEDITEM
	farcall ChangeHappiness

	predef CopyMonToTempMon
	call DisplayStatsInPartyMenu

	jmp UseDisposableItem

NoEffectMessage:
	ld hl, ItemWontHaveEffectText
	call PrintText
	jmp ClearPalettes

UpdateStatsAfterItem:
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld d, h
	ld e, l
	call WriteDownOldStatsForGainCalculation
	ld a, MON_STAT_EXP - 1
	call GetPartyParamLocation
	ld b, TRUE
	predef_jump CalcMonStats

WriteDownOldStatsForGainCalculation::
	inc hl ; Max HP.
	inc hl ; Max HP + 1.
	inc hl ; Atk high byte (big-endian).
	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 0], a ; Atk.
	inc hl

	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 1], a ; Def.
	inc hl

	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 4], a ; Speed.
	inc hl

	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 2], a ; Special atk.
	inc hl

	ld a, [hl]
	ld [wTempMonLevelUpStatGain + 3], a ; Special def.
	ret

RareCandy_StatBooster_ExitMenu:
	xor a
	ld [wItemEffectSucceeded], a
	jmp ClearPalettes

ItemStatRoseText:
	text_far _ItemStatRoseText
	text_end

StatStrings:
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .special

if DEF(_FR_FR)
	.health  db "VIE@"
	.attack  db "ATTAQUE@"
	.defense db "DEFENSE@"
	.speed   db "VITESSE@"
	.special db "SPECIAL@"
else
	.health  db "HEALTH@"
	.attack  db "ATTACK@"
	.defense db "DEFENSE@"
	.speed   db "SPEED@"
	.special db "SPECIAL@"
endc

GetStatExpRelativePointer:
	ld a, [wCurItem]
	ld hl, StatExpItemPointerOffsets
.next
	cp [hl]
	inc hl
	jr z, .got_it
	inc hl
	jr .next

.got_it
	ld a, [hl]
	ld c, a
	ld b, 0
	ret

StatExpItemPointerOffsets:
	db HP_UP,    MON_HP_EXP - MON_STAT_EXP
	db PROTEIN, MON_ATK_EXP - MON_STAT_EXP
	db IRON,    MON_DEF_EXP - MON_STAT_EXP
	db CARBOS,  MON_SPD_EXP - MON_STAT_EXP
	db CALCIUM, MON_SPC_EXP - MON_STAT_EXP

RareCandy_StatBooster_GetParameters:
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	jmp GetNickname

RareCandyEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon

	jp c, RareCandy_StatBooster_ExitMenu

	call RareCandy_StatBooster_GetParameters

	ld a, MON_LEVEL
	call GetPartyParamLocation

	ld a, [hl]
	cp MAX_LEVEL
	jp nc, NoEffectMessage

	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	cp MAX_LEVEL
	jr z, .end_exp_boost

	inc d ; we add one more level...
	farcall CalcExpAtLevel
	;...then we sub 1 exp from it.
	ldh a, [hMultiplicand + 2]
	sbc 1
	ldh [hMultiplicand + 2], a
	ldh a, [hMultiplicand + 1]
	sbc 0
	ldh [hMultiplicand + 1], a
	ldh a, [hMultiplicand + 0]
	sbc 0
	ldh [hMultiplicand + 0], a
	jr .apply_exp

.end_exp_boost
	farcall CalcExpAtLevel
.apply_exp
	pop de
	ld a, MON_EXP
	call GetPartyParamLocation

	ldh a, [hMultiplicand + 0]
	ld [hli], a
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a

	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	call UpdateStatsAfterItem

	ld a, MON_MAXHP + 1
	call GetPartyParamLocation

	pop bc
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a
	dec hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	farcall LevelUpHappinessMod

	ld a, PARTYMENUTEXT_LEVEL_UP
	call ItemActionText

	xor a ; PARTYMON
	ld [wMonType], a
	predef CopyMonToTempMon

	call DisplayStatsInPartyMenu

	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	predef LearnLevelMoves

	xor a
	ld [wForceEvolution], a
	farcall EvolvePokemon

	jmp UseDisposableItem

DisplayStatsInPartyMenu:
	hlcoord 9, 0
	lb bc, 10, 9
	call Textbox

	hlcoord 11, 1
	ld bc, 4
	predef PrintTempMonLevelUpStats

	jmp WaitPressAorB_BlinkCursor

HealPowderEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon

	jp c, StatusHealer_ExitMenu

	call UseStatusHealer
	cp FALSE
	jr nz, .not_used

	ld c, HAPPINESS_BITTERPOWDER
	farcall ChangeHappiness
	call LooksBitterMessage

	ld a, $0

.not_used
	jmp StatusHealer_Jumptable

StatusHealingEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

FullyHealStatus:
	call UseStatusHealer
	jmp StatusHealer_Jumptable

UseStatusHealer:
	call IsMonFainted
	ld a, TRUE
	ret z
	call GetItemHealingAction
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jr nz, .good
	call IsItemUsedOnConfusedMon
	ld a, TRUE
	ret nc
	ld b, PARTYMENUTEXT_HEAL_CONFUSION
.good
	xor a
	ld [hl], a
	ld a, b
	ld [wPartyMenuActionText], a
	call HealStatus
	call Play_SFX_FULL_HEAL
	call ItemActionTextWaitButton
	call UseDisposableItem
	ld a, FALSE
	ret

IsItemUsedOnConfusedMon:
	call IsItemUsedOnBattleMon
	jr nc, .nope
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .nope
	ld a, c
	cp $ff
	jr nz, .nope
	scf
	ret

.nope
	and a
	ret

BattlemonRestoreHealth:
	call IsItemUsedOnBattleMon
	ret nc
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
	ret

HealStatus:
	call IsItemUsedOnBattleMon
	ret nc
	xor a
	ld [wBattleMonStatus], a
	ld hl, wPlayerSubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	call GetItemHealingAction
	ld a, c
	cp %11111111
	jr nz, .not_full_heal
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]
.not_full_heal
	push bc
	farcall CalcPlayerStats
	pop bc
	ret

GetItemHealingAction:
	push hl
	ld a, [wCurItem]
	ld hl, StatusHealingActions
	ld bc, 3
.next
	cp [hl]
	jr z, .found_it
	add hl, bc
	jr .next

.found_it
	inc hl
	ld b, [hl]
	inc hl
	ld a, [hl]
	ld c, a
	cp %11111111
	pop hl
	ret

INCLUDE "data/items/heal_status.asm"

StatusHealer_Jumptable:
	ld hl, .dw
	rst JumpTable
	ret

.dw
	dw StatusHealer_ClearPalettes
	dw StatusHealer_NoEffect
	dw StatusHealer_ExitMenu

RevivalHerbEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call RevivePokemon
	cp FALSE
	jr nz, .not_used

	ld c, HAPPINESS_REVIVALHERB
	farcall ChangeHappiness
	call LooksBitterMessage

	ld a, $0

.not_used
	jr StatusHealer_Jumptable

ReviveEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call RevivePokemon
	jr StatusHealer_Jumptable

RevivePokemon:
	call IsMonFainted
	ld a, TRUE
	ret nz
	ld a, [wBattleMode]
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld d, 0
	ld hl, wBattleParticipantsIncludingFainted
	ld b, CHECK_FLAG
	predef SmallFarFlagAction
	ld a, c
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, SET_FLAG
	predef SmallFarFlagAction

.skip_to_revive
	xor a
	ld [wLowHealthAlarm], a
	ld a, [wCurItem]
	cp REVIVE
	jr z, .revive_half_hp

	call ReviveFullHP
	jr .finish_revive

.revive_half_hp
	call ReviveHalfHP

.finish_revive
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	ld a, FALSE
	ret

FullRestoreEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp z, StatusHealer_NoEffect

	call IsMonAtFullHealth
	jr c, .NotAtFullHealth

	jmp FullyHealStatus

.NotAtFullHealth:
	call .FullRestore
	jmp StatusHealer_Jumptable

.FullRestore:
	xor a
	ld [wLowHealthAlarm], a
	call ReviveFullHP
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a
	call HealStatus
	call BattlemonRestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	ld a, 0
	ret

BitterBerryEffect:
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_CONFUSED, [hl]
	ld a, 1
	jr z, .done

	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ldh [hBattleTurn], a
	call UseItemText

	ld hl, ConfusedNoMoreText
	call StdBattleTextbox

	ld a, 0

.done
	jmp StatusHealer_Jumptable

RestoreHPEffect:
	call ItemRestoreHP
	jmp StatusHealer_Jumptable

EnergypowderEffect:
	ld c, HAPPINESS_BITTERPOWDER
	jr EnergypowderEnergyRootCommon

EnergyRootEffect:
	ld c, HAPPINESS_ENERGYROOT

EnergypowderEnergyRootCommon:
	push bc
	call ItemRestoreHP
	pop bc
	and a
	jr nz, .skip_happiness

	farcall ChangeHappiness
	call LooksBitterMessage
	ld a, 0

.skip_happiness
	jmp StatusHealer_Jumptable

ItemRestoreHP:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	ld a, 2
	ret c

	call IsMonFainted
	ld a, 1
	ret z

	call IsMonAtFullHealth
	ld a, 1
	ret nc

	xor a
	ld [wLowHealthAlarm], a
	call GetHealingItemAmount
	call RestoreHealth
	call BattlemonRestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	ld a, 0
	ret

HealHP_SFX_GFX:
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	hlcoord 11, 0
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld a, $2
	ld [wWhichHPBar], a
	predef_jump AnimateHPBar

UseItem_SelectMon:
	call .SelectMon
	ret c

	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .not_egg

	call CantUseOnEggMessage
	scf
	ret

.not_egg
	and a
	ret

.SelectMon:
	ld a, b
	ld [wPartyMenuActionText], a
	push hl
	push de
	push bc
	call ClearBGPalettes
	call ChooseMonToUseItemOn
	pop bc
	pop de
	pop hl
	ret

ChooseMonToUseItemOn:
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call WaitBGMap
	call SetPalettes
	call DelayFrame
	farcall PartyMenuSelect
	ret

ItemActionText:
	ld [wPartyMenuActionText], a
	ld a, [wCurPartySpecies]
	push af
	ld a, [wCurPartyMon]
	push af
	push hl
	push de
	push bc
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuActionText
	call WaitBGMap
	call SetPalettes
	call DelayFrame
	pop bc
	pop de
	pop hl
	pop af
	ld [wCurPartyMon], a
	pop af
	ld [wCurPartySpecies], a
	ret

ItemActionTextWaitButton:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	ld a, " "
	call ByteFill
	ld a, [wPartyMenuActionText]
	call ItemActionText
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 50
	call DelayFrames
	jmp WaitPressAorB_BlinkCursor

StatusHealer_NoEffect:
	call WontHaveAnyEffectMessage
	jr StatusHealer_ClearPalettes

StatusHealer_ExitMenu:
	xor a
	ld [wItemEffectSucceeded], a
StatusHealer_ClearPalettes:
	jmp ClearPalettes

IsItemUsedOnBattleMon:
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
	cp [hl]
	pop hl
	jr nz, .nope
	scf
	ret

.nope
	xor a
	ret

ReviveHalfHP:
	call LoadHPFromBuffer1
	srl d
	rr e
	jr ContinueRevive

ReviveFullHP:
	call LoadHPFromBuffer1
ContinueRevive:
	ld a, MON_HP
	call GetPartyParamLocation
	ld [hl], d
	inc hl
	ld [hl], e
	jr LoadCurHPIntoBuffer3

RestoreHealth:
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	jr c, .full_hp
	call LoadCurHPIntoBuffer3
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld a, MON_MAXHP + 1
	call GetPartyParamLocation
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .finish
.full_hp
	call ReviveFullHP
.finish
	ret

RemoveHP:
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	sub e
	ld [hld], a
	ld a, [hl]
	sbc d
	ld [hl], a
	jr nc, .okay
	xor a
	ld [hld], a
	ld [hl], a
.okay
	jr LoadCurHPIntoBuffer3

IsMonFainted:
	push de
	call LoadMaxHPIntoBuffer1
	call LoadCurHPIntoBuffer2
	call LoadHPFromBuffer2
	ld a, d
	or e
	pop de
	ret

IsMonAtFullHealth:
	call LoadHPFromBuffer2
	ld h, d
	ld l, e
	call LoadHPFromBuffer1
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

LoadCurHPIntoBuffer3:
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer3 + 1], a
	ld a, [hl]
	ld [wHPBuffer3], a
	ret

LoadCurHPIntoBuffer2:
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer2 + 1], a
	ld a, [hl]
	ld [wHPBuffer2], a
	ret

LoadHPFromBuffer2:
	ld a, [wHPBuffer2 + 1]
	ld d, a
	ld a, [wHPBuffer2]
	ld e, a
	ret

LoadMaxHPIntoBuffer1:
	push hl
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	pop hl
	ret

LoadHPFromBuffer1:
	ld a, [wHPBuffer1 + 1]
	ld d, a
	ld a, [wHPBuffer1]
	ld e, a
	ret

GetOneFifthMaxHP:
	push bc
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend + 0], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	pop bc
	ret

GetOneFourthMaxHP:
	push bc
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
	srl d
	rr e
	srl d
	rr e
	pop bc
	ret

GetHealingItemAmount:
	push hl
	ld a, [wCurItem]
	cp GOLD_BERRY
	jr z, .SitrusBerry
	ld hl, HealingHPAmounts
	ld d, a
.next
	ld a, [hli]
	cp -1
	jr z, .NotFound
	cp d
	jr z, .done
	inc hl
	inc hl
	jr .next

.SitrusBerry:
	call GetOneFourthMaxHP
	pop hl
	ret

.NotFound:
	scf
.done
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

INCLUDE "data/items/heal_hp.asm"

Softboiled_MilkDrinkFunction:
; Softboiled/Milk Drink in the field
	ld a, [wPartyMenuCursor]
	dec a
	ld b, a
	call .SelectMilkDrinkRecipient ; select pokemon
	jr c, .skip
	ld a, b
	ld [wCurPartyMon], a
	call IsMonFainted
	call GetOneFifthMaxHP
	call RemoveHP
	push bc
	call HealHP_SFX_GFX
	pop bc
	call GetOneFifthMaxHP
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	call RestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	call ItemActionText
	call JoyWaitAorB
.skip
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	ret

.SelectMilkDrinkRecipient:
.loop
	push bc
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	call ChooseMonToUseItemOn
	pop bc
	jr c, .set_carry
	ld a, [wPartyMenuCursor]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .cant_use ; chose the same mon as user
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	jr z, .cant_use
	call IsMonAtFullHealth
	jr nc, .cant_use
	xor a
	ret

.set_carry
	scf
	ret

.cant_use
	push bc
	ld hl, .ItemCantUseOnMonText
	call MenuTextboxBackup
	pop bc
	jr .loop

.ItemCantUseOnMonText:
	text_far _ItemCantUseOnMonText
	text_end

EscapeRopeEffect:
	xor a
	ld [wItemEffectSucceeded], a
	farcall EscapeRopeFunction

	ld a, [wItemEffectSucceeded]
	cp 1
	call z, UseDisposableItem
	ret

SuperRepelEffect:
	ld b, 200
	jr UseRepel

MaxRepelEffect:
	ld b, 250
	jr UseRepel

RepelEffect:
	ld b, 100

UseRepel:
	ld a, [wRepelEffect]
	and a
	ld hl, RepelUsedEarlierIsStillInEffectText
	jp nz, PrintText

	ld a, b
	ld [wRepelEffect], a
	ld a, [wCurItem]
	ld [wRepelType], a
	jmp UseItemText

RepelUsedEarlierIsStillInEffectText:
	text_far _RepelUsedEarlierIsStillInEffectText
	text_end

XAccuracyEffect:
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_X_ACCURACY, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_X_ACCURACY, [hl]
	jmp UseItemText

PokeDollEffect:
	ld a, [wBattleMode]
	dec a ; WILD_BATTLE?
	jr nz, .not_wild
	inc a ; TRUE
	ld [wForcedSwitch], a
	ld a, [wBattleResult]
	and BATTLERESULT_BITMASK
	or DRAW
	ld [wBattleResult], a
	jmp UseItemText

.not_wild
	xor a
	ld [wItemEffectSucceeded], a
	ret

GuardSpecEffect:
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_MIST, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_MIST, [hl]
	jmp UseItemText

DireHitEffect:
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	jmp UseItemText

XItemEffect:
	call UseItemText

	ld a, [wCurItem]
	ld hl, XItemStats

.loop
	cp [hl]
	jr z, .got_it
	inc hl
	inc hl
	jr .loop

.got_it
	inc hl
	ld b, [hl]
	xor a
	ldh [hBattleTurn], a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	farcall RaiseStat
	call WaitSFX

	farcall BattleCommand_StatUpMessage
	farcall BattleCommand_StatUpFailText

	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld c, HAPPINESS_USEDXITEM
	farcall ChangeHappiness
	ret

INCLUDE "data/items/x_stats.asm"

PokeFluteEffect:
	ld a, [wBattleMode]
	and a
	jr nz, .in_battle
	; overworld flute code was dummied out here

.in_battle
	xor a
	ld [wPokeFluteCuredSleep], a

	ld b, $ff ^ SLP

	ld hl, wPartyMon1Status
	call .CureSleep

	ld a, [wBattleMode]
	cp WILD_BATTLE
	jr z, .skip_otrainer
	ld hl, wOTPartyMon1Status
	call .CureSleep
.skip_otrainer

	ld hl, wBattleMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and b
	ld [hl], a

	ld a, [wPokeFluteCuredSleep]
	and a
	ld hl, .PlayedFluteText
	jp z, PrintText
	ld hl, .PlayedTheFlute
	call PrintText

	ld a, [wLowHealthAlarm]
	and 1 << DANGER_ON_F
	jr nz, .dummy
	; more code was dummied out here
.dummy
	ld hl, .FluteWakeUpText
	jmp PrintText

.CureSleep:
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, PARTY_LENGTH
.loop
	ld a, [hl]
	push af
	and SLP
	jr z, .not_asleep
	ld a, TRUE
	ld [wPokeFluteCuredSleep], a
.not_asleep
	pop af
	and b
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

.PlayedFluteText:
	text_far _PlayedFluteText
	text_end

.FluteWakeUpText:
	text_far _FluteWakeUpText
	text_end

.PlayedTheFlute:
	; played the # FLUTE.@ @
	text_far Text_PlayedPokeFlute
	text_asm
	ld a, [wBattleMode]
	and a
	jr nz, .battle

	push de
	ld de, SFX_POKEFLUTE
	call WaitPlaySFX
	call WaitSFX
	pop de

.battle
	jmp PokeFluteTerminator

BlueCardEffect:
	ld hl, .BlueCardBalanceText
	jmp MenuTextboxWaitButton

.BlueCardBalanceText:
	text_far _BlueCardBalanceText
	text_end

CoinCaseEffect:
	ld hl, .CoinCaseCountText
	jmp MenuTextboxWaitButton

.CoinCaseCountText:
	text_far _CoinCaseCountText
	text_end

OldRodEffect:
	ld e, $0
	jr UseRod

GoodRodEffect:
	ld e, $1
	jr UseRod

SuperRodEffect:
	ld e, $2
	; fallthrough

UseRod:
	farcall FishFunction
	ret

ItemfinderEffect:
	farcall ItemFinder
	ret

RestorePPEffect:
	ld a, [wCurItem]
	ld [wTempRestorePPItem], a

.loop
	; Party Screen opens to choose on which mon to use the Item
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, PPRestoreItem_Cancel

.loop2
	ld a, [wTempRestorePPItem]
	cp MAX_ELIXER
	jp z, Elixer_RestorePPofAllMoves
	cp ELIXER
	jp z, Elixer_RestorePPofAllMoves

	ld hl, RaiseThePPOfWhichMoveText
	ld a, [wTempRestorePPItem]
	cp PP_UP
	jr z, .ppup
	ld hl, RestoreThePPOfWhichMoveText

.ppup
	call PrintText

	ld a, [wCurMoveNum]
	push af
	xor a
	ld [wCurMoveNum], a
	ld a, $2
	ld [wMoveSelectionMenuType], a
	farcall MoveSelectionScreen
	pop bc

	ld a, b
	ld [wCurMoveNum], a
	jr nz, .loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon

	push hl
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1
	pop hl

	ld a, [wTempRestorePPItem]
	cp PP_UP
	jp nz, Not_PP_Up

	ld a, [hl]
	cp SKETCH
	jr z, .CantUsePPUpOnSketch

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	cp PP_UP_MASK
	jr c, .do_ppup

.CantUsePPUpOnSketch:
	ld hl, PPIsMaxedOutText
	call PrintText
	jr .loop2

.do_ppup
	ld a, [hl]
	add PP_UP_ONE
	ld [hl], a
	ld a, TRUE
	ld [wUsePPUp], a
	call ApplyPPUp
	call Play_SFX_FULL_HEAL

	ld hl, PPsIncreasedText
	call PrintText

FinishPPRestore:
	call ClearPalettes
	jmp UseDisposableItem

BattleRestorePP:
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .not_in_battle
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .not_in_battle
	call .UpdateBattleMonPP

.not_in_battle
	call Play_SFX_FULL_HEAL
	ld hl, PPRestoredText
	call PrintText
	jr FinishPPRestore

.UpdateBattleMonPP:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBattleMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [de]
	and a
	jr z, .done
	cp [hl]
	jr nz, .next
	push hl
	push de
	push bc
rept NUM_MOVES + 2 ; wBattleMonPP - wBattleMonMoves
	inc de
endr
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	ld [de], a
	pop bc
	pop de
	pop hl

.next
	inc hl
	inc de
	dec b
	jr nz, .loop

.done
	ret

Not_PP_Up:
	call RestorePP
	jr nz, BattleRestorePP
	jr PPRestoreItem_NoEffect

Elixer_RestorePPofAllMoves:
	xor a
	ld hl, wMenuCursorY
	ld [hli], a
	ld [hl], a
	ld b, NUM_MOVES
.moveLoop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [hl]
	and a
	jr z, .next

	call RestorePP
	jr z, .next
	ld hl, wMenuCursorX
	inc [hl]

.next
	ld hl, wMenuCursorY
	inc [hl]
	pop bc
	dec b
	jr nz, .moveLoop
	ld a, [wMenuCursorX]
	and a
	jp nz, BattleRestorePP

PPRestoreItem_NoEffect:
	call WontHaveAnyEffectMessage

PPRestoreItem_Cancel:
	call ClearPalettes
	xor a
	ld [wItemEffectSucceeded], a
	ret

RestorePP:
	xor a ; PARTYMON
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1PP
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [wTempPP]
	ld b, a
	ld a, [hl]
	and PP_MASK
	cp b
	jr nc, .dont_restore

	ld a, [wTempRestorePPItem]
	cp MAX_ELIXER
	jr z, .restore_all
	cp MAX_ETHER
	jr z, .restore_all

;	ld c, 5 ; Commented out by Damien, so the Leppa Berry (ex-MysteryBerry) restores 10 PP.
;	cp MYSTERYBERRY
;	jr z, .restore_some

	ld c, 10

.restore_some
	ld a, [hl]
	and PP_MASK
	add c
	cp b
	jr nc, .restore_all
	ld b, a

.restore_all
	ld a, [hl]
	and PP_UP_MASK
	or b
	ld [hl], a
	ret

.dont_restore
	xor a
	ret

RaiseThePPOfWhichMoveText:
	text_far _RaiseThePPOfWhichMoveText
	text_end

RestoreThePPOfWhichMoveText:
	text_far _RestoreThePPOfWhichMoveText
	text_end

PPIsMaxedOutText:
	text_far _PPIsMaxedOutText
	text_end

PPsIncreasedText:
	text_far _PPsIncreasedText
	text_end

PPRestoredText:
	text_far _PPRestoredText
	text_end

SquirtbottleEffect:
	farcall _Squirtbottle
	ret

CardKeyEffect:
	farcall _CardKey
	ret

BasementKeyEffect:
	farcall _BasementKey
	ret

SacredAshEffect:
	farcall _SacredAsh
	ld a, [wItemEffectSucceeded]
	cp $1
	ret nz
	jr UseDisposableItem

NormalBoxEffect:
	ld c, DECOFLAG_SILVER_TROPHY_DOLL
	jr OpenBox

GorgeousBoxEffect:
	ld c, DECOFLAG_GOLD_TROPHY_DOLL
OpenBox:
	farcall SetSpecificDecorationFlag

	ld hl, .SentTrophyHomeText
	call PrintText

	jr UseDisposableItem

.SentTrophyHomeText:
	text_far _SentTrophyHomeText
	text_end

Play_SFX_FULL_HEAL:
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	ret

UseItemText:
	ld hl, ItemUsedText
	call PrintText
	call Play_SFX_FULL_HEAL
	call WaitPressAorB_BlinkCursor
UseDisposableItem:
	ld hl, wNumItems
	ld a, 1
	ld [wItemQuantityChange], a
	jmp TossItem

UseBallInTrainerBattle:
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ld [wBattleAnimParam], a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BallBlockedText
	call PrintText
	ld hl, BallDontBeAThiefText
	call PrintText
	jr UseDisposableItem

WontHaveAnyEffect_NotUsedMessage:
	ld hl, ItemWontHaveEffectText
	call PrintText

	; Item wasn't used.
	ld a, $2
	ld [wItemEffectSucceeded], a
	ret

LooksBitterMessage:
	ld hl, ItemLooksBitterText
	jmp PrintText

Ball_BoxIsFullMessage:
	ld hl, BallBoxFullText
	call PrintText

	; Item wasn't used.
	ld a, $2
	ld [wItemEffectSucceeded], a
	ret

CantUseOnEggMessage:
	ld hl, ItemCantUseOnEggText
	jr CantUseItemMessage

NoEffect:
IsntTheTimeMessage:
	ld hl, ItemOakWarningText
	jr CantUseItemMessage

WontHaveAnyEffectMessage:
	ld hl, ItemWontHaveEffectText
	; fallthrough.

CantUseItemMessage:
; Item couldn't be used.
	xor a
	ld [wItemEffectSucceeded], a
	jmp PrintText

ItemLooksBitterText:
	text_far _ItemLooksBitterText
	text_end

ItemCantUseOnEggText:
	text_far _ItemCantUseOnEggText
	text_end

ItemOakWarningText:
	text_far _OakThisIsntTheTimeText
	text_end

ItemWontHaveEffectText:
	text_far _ItemWontHaveEffectText
	text_end

BallBlockedText:
	text_far _BallBlockedText
	text_end

BallDontBeAThiefText:
	text_far _BallDontBeAThiefText
	text_end

BallBoxFullText:
	text_far _BallBoxFullText
	text_end

ItemUsedText:
	text_far _ItemUsedText
	text_end

ItemUsedButNopeText:
	text_far _ItemUsedButNopeText
	text_end

ApplyPPUp:
	ld a, MON_MOVES
	call GetPartyParamLocation
	push hl
	ld de, wPPUpPPBuffer
	predef FillPP
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld de, wPPUpPPBuffer
	ld b, 0
.loop
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z
	ld a, [wUsePPUp]
	dec a ; FALSE?
	jr nz, .use
	ld a, [wMenuCursorY]
	inc a
	cp b
	jr nz, .skip

.use
	ld a, [hl]
	and PP_UP_MASK
	ld a, [de] ; wasted cycle
	call nz, ComputeMaxPP

.skip
	inc hl
	inc de
	jr .loop

ComputeMaxPP:
	push bc
	; Divide the base PP by 5.
	ld a, [de]
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	; Get the number of PP, which are bits 6 and 7 of the PP value stored in RAM.
	ld a, [hl]
	ld b, a
	swap a
	and $f
	srl a
	srl a
	ld c, a
	; If this value is 0, we are done
	and a
	jr z, .NoPPUp

.loop
	; Normally, a move with 40 PP would have 64 PP with three PP Ups.
	; Since this would overflow into bit 6, we prevent that from happening
	; by decreasing the extra amount of PP each PP Up provides, resulting
	; in a maximum of 61.
	ldh a, [hQuotient + 3]
	cp $8
	jr c, .okay
	ld a, $7

.okay
	add b
	ld b, a
	ld a, [wTempPP]
	dec a
	jr z, .NoPPUp
	dec c
	jr nz, .loop

.NoPPUp:
	ld [hl], b
	pop bc
	ret

RestoreAllPP:
	ld a, MON_PP
	call GetPartyParamLocation
	push hl
	ld a, MON_MOVES
	call GetPartyParamLocation
	pop de
	xor a ; PARTYMON
	ld [wMenuCursorY], a
	ld [wMonType], a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	and a
	ret z
	push hl
	push de
	push bc
	call GetMaxPPOfMove
	pop bc
	pop de
	ld a, [de]
	and PP_UP_MASK
	ld b, a
	ld a, [wTempPP]
	add b
	ld [de], a
	inc de
	ld hl, wMenuCursorY
	inc [hl]
	pop hl
	dec c
	jr nz, .loop
	ret

GetMaxPPOfMove::
	ld a, [wStringBuffer1 + 0]
	push af
	ld a, [wStringBuffer1 + 1]
	push af

	ld a, [wMonType]
	and a

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	jr z, .got_partymon ; PARTYMON

	ld hl, wOTPartyMon1Moves
	dec a
	jr z, .got_partymon ; OTPARTYMON

	ld hl, wTempMonMoves
	dec a
	jr z, .got_nonpartymon ; BOXMON

	ld hl, wTempMonMoves ; Wasted cycles
	dec a
	jr z, .got_nonpartymon ; TEMPMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; BOXMON, TEMPMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON
	call GetMthMoveOfNthPartymon
	jr .gotdatmove

.mysteryberry
	ld a, [wStringBuffer1 + 0]
	push af
	ld a, [wStringBuffer1 + 1]
	push af
	; fallthrough.

.gotdatmove
	ld a, [hl]
	dec a

	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	ld de, wStringBuffer1
	ld [de], a
	pop hl

	push bc
	ld bc, MON_PP - MON_MOVES
	ld a, [wMonType]
	cp WILDMON
	jr nz, .notwild
	ld bc, wEnemyMonPP - wEnemyMonMoves
.notwild
	add hl, bc
	ld a, [hl]
	and PP_UP_MASK
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wTempPP], a
	call ComputeMaxPP
	ld a, [hl]
	and PP_MASK
	ld [wTempPP], a

	pop af
	ld [wStringBuffer1 + 1], a
	pop af
	ld [wStringBuffer1 + 0], a
	ret

GetMthMoveOfNthPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes

GetMthMoveOfCurrentMon:
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ret
