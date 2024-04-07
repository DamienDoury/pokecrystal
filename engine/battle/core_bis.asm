BattleIntro:
	farcall StubbedTrainerRankings_Battles ; mobile
	farcall ForceBattleAnimationStart
	call LoadTrainerOrWildMonPic
	xor a
	ld [wTempBattleMonSpecies], a
	ld [wBattleMenuCursorPosition], a
	xor a
	ldh [hMapAnims], a
	farcall PlayBattleMusic
	farcall ShowLinkBattleParticipants
	farcall FindFirstAliveMonAndStartBattle
	call DisableSpriteUpdates
	farcall ClearBattleRAM
	call InitEnemy
	call BackUpBGMap2
	ld b, SCGB_BATTLE_GRAYSCALE
	call GetSGBLayout
	ld hl, rLCDC
	res rLCDC_WINDOW_TILEMAP, [hl] ; select vBGMap0/vBGMap2
	farcall InitBattleDisplay
	call BattleStartMessage
	ld hl, rLCDC
	set rLCDC_WINDOW_TILEMAP, [hl] ; select vBGMap1/vBGMap3
	xor a
	ldh [hBGMapMode], a
	farcall EmptyBattleTextbox
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	hlcoord 0, 0
	lb bc, 5, 11
	call ClearBox
	ld a, [wBattleMode]
	cp WILD_BATTLE
	jr nz, .skip_enemy_hud_update

	farcall UpdateEnemyHUD

.skip_enemy_hud_update
	ld a, $1
	ldh [hBGMapMode], a
	ret
	



ExitBattle:
	farcall UpdatePartyStats
	call ForceBattleAnimationEnd
	call .HandleEndOfBattle
	farcall CleanUpBattleRAM
	ret

.HandleEndOfBattle:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	farcall ShowLinkBattleParticipantsAfterEnd
	ld c, 150
	call DelayFrames
	farcall DisplayLinkBattleResult
	ret

.not_linked
	ld a, [wBattleResult]
	and $ff ^ BATTLERESULT_BITMASK
	ret nz
	farcall CheckPayDay
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle
	farcall GivePokerusAndConvertBerries
	call CheckCaughtBeast
	xor a
	ld [wAssaultBattle], a
	ld [wBattlePokerusSeed], a
	ret
	



LoadTrainerOrWildMonPic:
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .Trainer
	ld a, [wTempWildMonSpecies]
	ld [wCurPartySpecies], a

.Trainer:
	ld [wTempEnemyMonSpecies], a
	ret




_StartAutomaticBattleWeather::
	callfar GetAutomaticBattleWeather
	ldh a, [hFarByte]
	and a
	ret z
; get current AutomaticWeatherEffects entry
	dec a
; fallthrough

;ForceBattleWeather:
	ld hl, AutomaticWeatherEffects
	ld bc, 5 ; size of one entry
	call AddNTimes
; [wBattleWeather] = weather
	ld a, [hli]
	ld [wBattleWeather], a
; de = animation
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; hl = text pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; start weather for 255 turns
	ld a, 255
	ld [wWeatherCount], a

	ld a, [wAssaultBattle]
	cp TRUE
	jp nz, .check_battle_scene_option

	ld a, [wPlayerTurnsTaken]
	cp 0
	jr nz, .check_battle_scene_option 

	; If it is the first turn of an assault, we don't display the weather to make the assault quick and surprising.
	jr .end

.check_battle_scene_option
	push hl
	farcall CheckBattleScene
	pop hl
	jr c, .end

	push hl
	farcall Call_PlayBattleAnim ; uses de
	pop hl
.end
	rla ; Unsets Z flag, fastest instruction I could find to do this. Z flag is the return value of this function.
	ret

INCLUDE "data/battle/automatic_weather_anims.asm"




ForceBattleAnimationStart::
	ld a, [wBattleType]
	cp BATTLETYPE_SHINY
	jr z, .force_animations

	ld a, [wOtherTrainerClass]
	cp RED
	ret nz

.force_animations
	ld a, [wOptions]
	ld [wOptionsBackup], a
	res BATTLE_SCENE, a
	ld [wOptions], a
	ret

ForceBattleAnimationEnd::
	ld a, [wBattleType]
	cp BATTLETYPE_SHINY
	jr z, .restore_animation_options

	ld a, [wOtherTrainerClass]
	cp RED
	ret nz

.restore_animation_options
	ld a, [wOptionsBackup]
	ld [wOptions], a
	ret




InitEnemy:
	ld a, [wOtherTrainerClass]
	and a
	jr nz, InitEnemyTrainer ; trainer

	ld a, WILD_BATTLE
	ld [wBattleMode], a
	farcall StubbedTrainerRankings_WildBattles
	farcall LoadEnemyMon
	ld hl, wEnemyMonMoves
	ld de, wWildMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld hl, wEnemyMonPP
	ld de, wWildMonPP
	ld bc, NUM_MOVES
	call CopyBytes
	ld hl, wEnemyMonDVs
	predef GetUnownLetter
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .skip_unown
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .skip_unown
	ld a, [wUnownLetter]
	ld [wFirstUnownSeen], a
.skip_unown
	ld de, vTiles2
	predef GetAnimatedFrontpic
	xor a
	ld [wTrainerClass], a
	ldh [hGraphicStartTile], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ret




InitEnemyTrainer:
	ld [wTrainerClass], a
	farcall StubbedTrainerRankings_TrainerBattles
	xor a
	ld [wTempEnemyMonSpecies], a
	callfar GetTrainerAttributes
	callfar ReadTrainerParty

	; RIVAL1's first mon has no held item
	ld a, [wTrainerClass]
	cp RIVAL1
	jr nz, .ok
	xor a
	ld [wOTPartyMon1Item], a

.ok
	ld de, vTiles2
	callfar GetTrainerPic
	xor a
	ldh [hGraphicStartTile], a
	dec a
	ld [wEnemyItemState], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ld a, -1
	ld [wCurOTMon], a
	ld a, TRAINER_BATTLE
	ld [wBattleMode], a

	call IsGymLeader
	jr nc, .done
	xor a
	ld [wCurPartyMon], a
	ld a, [wPartyCount]
	ld b, a
.partyloop
	push bc
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	or [hl]
	jr z, .skipfaintedmon
	ld c, HAPPINESS_GYMBATTLE
	callfar ChangeHappiness
.skipfaintedmon
	pop bc
	dec b
	jr z, .done
	ld hl, wCurPartyMon
	inc [hl]
	jr .partyloop
.done
	ret




IsKantoGymLeader:
	ld hl, KantoGymLeaders
	jr IsGymLeaderCommon
	
IsGymLeader:
	ld hl, GymLeaders
IsGymLeaderCommon:
	push de
	ld a, [wOtherTrainerClass]
	call IsInByteArray
	pop de
	ret

INCLUDE "data/trainers/leaders.asm"



BackUpBGMap2:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	ld hl, wDecompressScratch
	ld bc, $40 tiles ; vBGMap3 - vBGMap2
	ld a, $2
	call ByteFill
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld de, wDecompressScratch
	hlbgcoord 0, 0 ; vBGMap2
	lb bc, BANK(BackUpBGMap2), $40
	call Request2bpp
	pop af
	ldh [rVBK], a
	pop af
	ldh [rSVBK], a
	ret




BattleStartMessage:
	ld a, [wBattleMode]
	dec a
	jr z, .wild

	ld de, SFX_SHINE
	call PlaySFX
	call WaitSFX

	ld c, 20
	call DelayFrames

	farcall Battle_GetTrainerName

	ld a, [wTempTrainerClass]
	cp OFFICER
	ld hl, WantsToApprehendText
	jr z, .PlaceBattleStartText

	ld hl, WantToBattlePluralText
	call IsPluralTrainer
	jr z, .PlaceBattleStartText

	ld hl, WantsToBattleText
	jr .PlaceBattleStartText

.wild
	farcall BattleCheckEnemyShininess
	jr nc, .not_shiny

	xor a
	ld [wNumHits], a
	ld a, 1
	ldh [hBattleTurn], a
	ld a, 1
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	farcall Call_PlayBattleAnim

.not_shiny
	farcall CheckSleepingTreeMon
	jr c, .skip_cry

	farcall CheckBattleScene
	jr c, .cry_no_anim

	hlcoord 12, 0
	ld d, $0
	ld e, ANIM_MON_NORMAL
	predef AnimateFrontpic
	jr .skip_cry ; cry is played during the animation

.cry_no_anim
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry

.skip_cry
	ld a, [wBattleType]
	cp BATTLETYPE_FISH
	jr nz, .NotFishing

	farcall StubbedTrainerRankings_HookedEncounters

	ld hl, HookedPokemonAttackedText
	jr .PlaceBattleStartText

.NotFishing:
	ld hl, PokemonFellFromTreeText
	cp BATTLETYPE_TREE
	jr z, .PlaceBattleStartText
	ld hl, WildCelebiAppearedText
	cp BATTLETYPE_CELEBI
	jr z, .PlaceBattleStartText
	ret ; Added to gain time at the start of battles.
	;ld hl, WildPokemonAppearedText

.PlaceBattleStartText:
	push hl
	farcall BattleStart_TrainerHuds
	pop hl
	call StdBattleTextbox

	farcall IsMobileBattle2
	ret nz

	ld c, $2 ; start
	farcall Mobile_PrintOpponentBattleMessage

	ret

DeterMineAssaultAndPokerusSeed::
	ld a, [wMapGroup]
	cp GROUP_CERULEAN_CAVE_ENTRANCE
	jr nz, .normal_area

	ld a, [wMapNumber]
	cp MAP_CERULEAN_CAVE_ENTRANCE
	jr c, .normal_area

	jp CeruleanCaveInfection

.normal_area
	ld a, [wBattlePokerusSeed]
	cp TRUE
	push de ; We don't care about the values of DE for this push. We use it to balance the stack if we jump to ".kanto_seed" that does a "pop de".
	jr z, .kanto_seed ; If the seed is 1, it is an invalid seed. This value of TRUE is used to force a covid battle. Note that a seed is set to 0 after each battle.
	pop de ; We balance the stack.

	xor a
	ld [wBattlePokerusSeed], a ; Reset the seed, in case it's dirty.

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_REACHED_GOLDENROD_F, [hl]
	jr z, DetermineAssault

	; Can't get the virus from trainers in Celadon Gym, as everyone is vaccinated.
	ld a, [wMapGroup]
	cp GROUP_CELADON_GYM
	jr nz, .next_checks

	ld a, [wMapNumber]
	cp MAP_CELADON_GYM
	jr z, DetermineAssault

.next_checks
	ld a, [wBattleType]
	cp BATTLETYPE_NORMAL
	jr z, .roll_dice
	cp BATTLETYPE_FISH
	jr z, .roll_dice
	cp BATTLETYPE_TREE
	jr z, .roll_dice
	cp BATTLETYPE_TRAP
	jr z, .roll_dice
	jr DetermineAssault

	; Covid can only be gotten by one of those battle types. BATTLETYPE_NORMAL includes trainers and wild Pokémons.
.roll_dice
	call IsInJohto
	cp JOHTO_REGION
	ld a, 4
	jr z, .odds_calculated

	add a ; Doubles the odds in Kanto.
	
.odds_calculated
	ld b, a
	call Random
	cp b ; Note: we could get this value from an array of landmarks. We could also edit it depending on the advancement of the scenario.
	jr nc, DetermineAssault ; Original: 3/65536 chance (00 00, 00 01 or 00 02 to proceed with the infection check). Now: 4/256 per battle (unless the player fleed immediately).

.generate_seed
	push de
	call IsInJohto
	cp KANTO_REGION
	jr z, .kanto_seed

	ld de, InfectMonWithRandomStrain
	jr .start_generation

.kanto_seed
	ld de, InfectMonWithCovidStrain ; In Kanto, no mild illnesses: only COVID to make the game harder.
.start_generation
	ld hl, wBattlePokerusSeed
	ld a, BANK(InfectMonWithRandomStrain)
	call FarCall_de ; Far calling CheckTypeMatchupFarcall. The a value will be gotten from [hFarByte].
	pop de

DetermineAssault:
	ld a, [wEnemyMonStatus]
	and SLP
	jr nz, .noAssault

	ld a, [wAssaultBattle]
	cp $ff
	jr z, .forceAssault

	ld a, [wAssaultBattle]
	cp $fe ; Forces no assault.
	jr z, .noAssault

	ld a, FALSE
	ld [wAssaultBattle], a

	ld a, [wBattleType]
	cp BATTLETYPE_SHINY
	jr z, .forceAssault ; The Red Gyarados always assaults the player! Cause it's angry!

	cp BATTLETYPE_NORMAL
	ret nz ; Assault can only trigger with regular wild battles (not even fishing).
	
	ld de, ENGINE_FLYPOINT_AZALEA
	farcall CheckEngineFlag ; Returns the result of the check in c.
	ret c ; Assaults start once the player reached Azalea.

	ld a, [wBattleMode]
	cp WILD_BATTLE
	ret nz ; Assaults only happen in wild battles.

	ld a, [wMapGroup]
	cp GROUP_NATIONAL_PARK
	jr nz, .regularOdds

	ld a, [wMapNumber]
	cp MAP_NATIONAL_PARK
	ret z ; No assaults in the National Park.

.regularOdds
	call BattleRandom
	cp 51
	ret nc ; ~1/5 odds of getting assaulted.

.forceAssault
	ld a, TRUE
	ld [wAssaultBattle], a
	ret

.noAssault
	ld a, FALSE
	ld [wAssaultBattle], a
	ret
	
CeruleanCaveInfection: 
	; Covid duration of 14 days (incubation).
	ld a, POKERUS_SYMPTOMS_START + 1

	; Fixed strain (Mewtwo contaminated all Pokémon).
	add POKERUS_ALPHA_STRAIN 
	ld [wBattlePokerusSeed], a

	; Forbid running away.
	ld a, BATTLETYPE_TRAP
	ld [wBattleType], a

	; Always aggressive.
	jr DetermineAssault.forceAssault

CheckCaughtBeast:
	ld a, [wEnemyMonSpecies]
	cp RAIKOU
	jr z, .check
	cp ENTEI
	jr z, .check
	cp SUICUNE
	jr z, .check
	ret

.check
	ld [wScriptVar], a
	farcall CheckOwnMonAnywhere
	push af
	xor a
	ld [wScriptVar], a
	pop af
	ret nc

	ld a, [wEnemyMonSpecies]
	sub RAIKOU
	add LOW(EVENT_CAUGHT_RAIKOU)
	ld e, a
	ld a, 0
	adc HIGH(EVENT_CAUGHT_RAIKOU)
	ld d, a

	ld b, SET_FLAG
	call EventFlagAction
	ret

SelectRandomMove::
	xor a
	ld [wCurEnemyMoveNum], a ; Default choice.
	ld hl, wEnemyMonMoves + 1 ; We start at the first move, as all Pokémon must have at least 1 move.
	ld b, 0
	ld c, 20 ; Number of tries before a forbidden move can be used.

.count_loop
	inc b
	ld a, b
	cp 4
	jr z, .check_loop ; We can't count above 4.

	ld a, [hli]
	and a
	jr nz, .count_loop

.check_loop
	call Random
	and NUM_MOVES - 1
	call Modulo
	
	ld [wCurEnemyMoveNum], a
	dec c
	jr z, .move_chosen
	
	push bc
	ld hl, wEnemyMonMoves
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl] ; Getting the move ID.
	ld b, a
	callfar GetMoveEffect
	ld a, b
	
	ld hl, .forbiddenMovesOnTurn1
	call IsInByteArray ; Clobbers DE, but shouldn't be an issue.
	pop bc

	jr c, .check_loop

.move_chosen
	ld hl, wEnemyMonMoves
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurEnemyMove], a
	ret

.forbiddenMovesOnTurn1
	db EFFECT_HEAL
	db EFFECT_MORNING_SUN
	db EFFECT_SYNTHESIS
	db EFFECT_MOONLIGHT
	db EFFECT_MIMIC
	db EFFECT_MIRROR_MOVE
	db EFFECT_DISABLE
	db EFFECT_SPITE
	db EFFECT_ENCORE
	db EFFECT_COUNTER
	db EFFECT_MIRROR_COAT
	db EFFECT_DREAM_EATER
	db EFFECT_SLEEP_TALK
	db EFFECT_NIGHTMARE
	db EFFECT_SNORE
	db EFFECT_PROTECT
	db EFFECT_ENDURE
	db EFFECT_RESET_STATS
	db EFFECT_HEAL_BELL
	db EFFECT_BATON_PASS
	db EFFECT_PSYCH_UP
	db -1
