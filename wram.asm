INCLUDE "constants.asm"

INCLUDE "macros/wram.asm"


INCLUDE "vram.asm"


SECTION "Stack", WRAM0

wStackBottom::
	ds $100 - 1
wStackTop::
	ds 1


SECTION "Audio RAM", WRAM0

; nonzero if playing
wMusicPlaying:: db

wAudio::
	table_width CHANNEL_STRUCT_LENGTH, wAudio
wChannel1:: channel_struct wChannel1
wChannel2:: channel_struct wChannel2
wChannel3:: channel_struct wChannel3
wChannel4:: channel_struct wChannel4
	assert_table_length NUM_MUSIC_CHANS
wChannel5:: channel_struct wChannel5
wChannel6:: channel_struct wChannel6
wChannel7:: channel_struct wChannel7
wChannel8:: channel_struct wChannel8
	assert_table_length NUM_CHANNELS

	ds 1

wCurTrackDuty:: db
wCurTrackVolumeEnvelope:: db
wCurTrackFrequency:: dw
wUnusedBCDNumber:: db ; BCD value, dummied out
wCurNoteDuration:: db ; used in MusicE0 and LoadNote

wCurMusicByte:: db
wCurChannel:: db
wVolume::
; corresponds to rNR50
; Channel control / ON-OFF / Volume (R/W)
;   bit 7 - Vin->SO2 ON/OFF
;   bit 6-4 - SO2 output level (volume) (# 0-7)
;   bit 3 - Vin->SO1 ON/OFF
;   bit 2-0 - SO1 output level (volume) (# 0-7)
	db
wSoundOutput::
; corresponds to rNR51
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	db
wPitchSweep::
; corresponds to rNR10
; bit 7:   unused
; bit 4-6: sweep time
; bit 3:   sweep direction
; but 0-2: sweep shift
	db

wMusicID:: dw
wMusicBank:: db
wNoiseSampleAddress:: dw
wNoiseSampleDelay:: db
	ds 1
wMusicNoiseSampleSet:: db
wSFXNoiseSampleSet:: db

wLowHealthAlarm::
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	db

wMusicFade::
; fades volume over x frames
; bit 7: fade in/out
; bit 0-5: number of frames for each volume level
; $00 = none (default)
	db
wMusicFadeCount:: db
wMusicFadeID:: dw

	ds 5

wCryPitch:: dw
wCryLength:: dw

wLastVolume:: db
wUnusedMusicF9Flag:: db

wSFXPriority::
; if nonzero, turn off music when playing sfx
	db

	ds 1

wChannel1JumpCondition:: db
wChannel2JumpCondition:: db
wChannel3JumpCondition:: db
wChannel4JumpCondition:: db

wStereoPanningMask:: db

wCryTracks::
; plays only in left or right track depending on what side the monster is on
; both tracks active outside of battle
	db

wSFXDuration:: db
wCurSFX::
; id of sfx currently playing
	db

wAudioEnd::

wMapMusic:: db

wDontPlayMapMusicOnReload:: db


SECTION "WRAM", WRAM0

wLZAddress:: dw
wLZBank::    db

	ds 1

wBoxAlignment:: db

wInputType::        db
wAutoInputAddress:: dw
wAutoInputBank::    db
wAutoInputLength::  db

wDebugFlags:: db
wGameLogicPaused:: db
wSpriteUpdatesEnabled:: db

wUnusedScriptByte:: db

wMapTimeOfDay:: db

	ds 3

wPrinterConnectionOpen:: db
wPrinterOpcode:: db
wPrevDexEntry:: db
wDisableTextAcceleration:: db
wPrevLandmark:: db
wCurLandmark:: db
wLandmarkSignTimer:: dw

wLinkMode::
; a LINK_* value for the link type
	db

wScriptVar:: db

wPlayerNextMovement:: db
wPlayerMovement:: db

	ds 2

wMovementObject:: db
wMovementDataBank:: db
wMovementDataAddress:: dw
wIndexedMovement2Pointer:: dw

	ds 2

wMovementByteWasControlSwitch:: db

UNION
wObjectPriorities:: ds NUM_OBJECT_STRUCTS

NEXTU
wMovementPointer:: dw
	ds 3
wTempObjectCopyMapObjectIndex:: db
wTempObjectCopySprite:: db
wTempObjectCopySpriteVTile:: db
wTempObjectCopyPalette:: db
wTempObjectCopyMovement:: db
wTempObjectCopyRange:: db
wTempObjectCopyX:: db
wTempObjectCopyY:: db
wTempObjectCopyRadius:: db
ENDU

	ds 1

wTileDown::  db
wTileUp::    db
wTileLeft::  db
wTileRight:: db

wTilePermissions::
; set if tile behavior prevents
; you from walking in that direction
; bit 3: down
; bit 2: up
; bit 1: left
; bit 0: right
	db

	ds 1


SECTION "wSpriteAnims", WRAM0

UNION
wSpriteAnimData::

wSpriteAnimDict::
; wSpriteAnimDict pairs keys with values
; keys: SPRITE_ANIM_DICT_* indexes (taken from SpriteAnimSeqData)
; values: vTiles0 offsets
	ds NUM_SPRITEANIMDICT_ENTRIES * 2

wSpriteAnimationStructs::
	table_width SPRITEANIMSTRUCT_LENGTH, wSpriteAnimationStructs
; field  0:   index
; fields 1-3: loaded from SpriteAnimSeqData
wSpriteAnim1::  sprite_anim_struct wSpriteAnim1
wSpriteAnim2::  sprite_anim_struct wSpriteAnim2
wSpriteAnim3::  sprite_anim_struct wSpriteAnim3
wSpriteAnim4::  sprite_anim_struct wSpriteAnim4
wSpriteAnim5::  sprite_anim_struct wSpriteAnim5
wSpriteAnim6::  sprite_anim_struct wSpriteAnim6
wSpriteAnim7::  sprite_anim_struct wSpriteAnim7
wSpriteAnim8::  sprite_anim_struct wSpriteAnim8
wSpriteAnim9::  sprite_anim_struct wSpriteAnim9
wSpriteAnim10:: sprite_anim_struct wSpriteAnim10
	assert_table_length NUM_SPRITE_ANIM_STRUCTS
wSpriteAnimationStructsEnd::

NEXTU
; mobile data
wMobileWRAM::
wMobileErrorCodeBuffer:: ds 3
wc303:: ds 2
wc305:: ds 1
wc306:: ds 1
wc307:: ds 1
wc308:: ds 1
wc309:: ds 1
wc30a:: ds 1
wc30b:: ds 1
wc30c:: ds 1
wc30d:: ds 1
wc30e:: ds 1
wc30f:: ds 1
wc310:: ds 1
wc311:: ds 1
wc312:: ds 1
wc313:: ds 1
wc314:: ds 5
wc319:: db
wc31a:: db
wc31b:: db
wc31c:: db
wc31d:: db
wc31e:: db
wc31f:: db
wc320:: ds 38
wc346:: ds 102
wc3ac:: ds 8
ENDU

wSpriteAnimCount:: db
wCurSpriteOAMAddr:: db

wCurIcon:: db

wCurIconTile:: db
UNION
wSpriteAnimID::
wCurSpriteOAMFlags:: db
NEXTU
wSpriteAnimAddrBackup:: dw
ENDU
wCurAnimVTile:: db
wCurAnimXCoord:: db
wCurAnimYCoord:: db
wCurAnimXOffset:: db
wCurAnimYOffset:: db
wGlobalAnimYOffset:: db
wGlobalAnimXOffset:: db

wSpriteAnimDataEnd::

	ds 11

; mobile data
wc3cc:: ds 1
wc3cd:: ds 31
wc3ec:: ds 1
wc3ed:: ds 1
wc3ee:: ds 1
wc3ef:: ds 1
wc3f0:: ds 1
wc3f1:: ds 1
wc3f2:: ds 1
wc3f3:: ds 1
wc3f4:: ds 1
wc3f5:: ds 1
wc3f6:: ds 1
wc3f7:: ds 1
wc3f8:: ds 1
wc3f9:: ds 1
wc3fa:: ds 1
wc3fb:: ds 1
wc3fc:: ds 1
	ds 3
wMobileWRAMEnd::


SECTION "Sprites", WRAM0

wVirtualOAM::
	table_width SPRITEOAMSTRUCT_LENGTH, wVirtualOAM
wVirtualOAMSprite00:: sprite_oam_struct wVirtualOAMSprite00
wVirtualOAMSprite01:: sprite_oam_struct wVirtualOAMSprite01
wVirtualOAMSprite02:: sprite_oam_struct wVirtualOAMSprite02
wVirtualOAMSprite03:: sprite_oam_struct wVirtualOAMSprite03
wVirtualOAMSprite04:: sprite_oam_struct wVirtualOAMSprite04
wVirtualOAMSprite05:: sprite_oam_struct wVirtualOAMSprite05
wVirtualOAMSprite06:: sprite_oam_struct wVirtualOAMSprite06
wVirtualOAMSprite07:: sprite_oam_struct wVirtualOAMSprite07
wVirtualOAMSprite08:: sprite_oam_struct wVirtualOAMSprite08
wVirtualOAMSprite09:: sprite_oam_struct wVirtualOAMSprite09
wVirtualOAMSprite10:: sprite_oam_struct wVirtualOAMSprite10
wVirtualOAMSprite11:: sprite_oam_struct wVirtualOAMSprite11
wVirtualOAMSprite12:: sprite_oam_struct wVirtualOAMSprite12
wVirtualOAMSprite13:: sprite_oam_struct wVirtualOAMSprite13
wVirtualOAMSprite14:: sprite_oam_struct wVirtualOAMSprite14
wVirtualOAMSprite15:: sprite_oam_struct wVirtualOAMSprite15
wVirtualOAMSprite16:: sprite_oam_struct wVirtualOAMSprite16
wVirtualOAMSprite17:: sprite_oam_struct wVirtualOAMSprite17
wVirtualOAMSprite18:: sprite_oam_struct wVirtualOAMSprite18
wVirtualOAMSprite19:: sprite_oam_struct wVirtualOAMSprite19
wVirtualOAMSprite20:: sprite_oam_struct wVirtualOAMSprite20
wVirtualOAMSprite21:: sprite_oam_struct wVirtualOAMSprite21
wVirtualOAMSprite22:: sprite_oam_struct wVirtualOAMSprite22
wVirtualOAMSprite23:: sprite_oam_struct wVirtualOAMSprite23
wVirtualOAMSprite24:: sprite_oam_struct wVirtualOAMSprite24
wVirtualOAMSprite25:: sprite_oam_struct wVirtualOAMSprite25
wVirtualOAMSprite26:: sprite_oam_struct wVirtualOAMSprite26
wVirtualOAMSprite27:: sprite_oam_struct wVirtualOAMSprite27
wVirtualOAMSprite28:: sprite_oam_struct wVirtualOAMSprite28
wVirtualOAMSprite29:: sprite_oam_struct wVirtualOAMSprite29
wVirtualOAMSprite30:: sprite_oam_struct wVirtualOAMSprite30
wVirtualOAMSprite31:: sprite_oam_struct wVirtualOAMSprite31
wVirtualOAMSprite32:: sprite_oam_struct wVirtualOAMSprite32
wVirtualOAMSprite33:: sprite_oam_struct wVirtualOAMSprite33
wVirtualOAMSprite34:: sprite_oam_struct wVirtualOAMSprite34
wVirtualOAMSprite35:: sprite_oam_struct wVirtualOAMSprite35
wVirtualOAMSprite36:: sprite_oam_struct wVirtualOAMSprite36
wVirtualOAMSprite37:: sprite_oam_struct wVirtualOAMSprite37
wVirtualOAMSprite38:: sprite_oam_struct wVirtualOAMSprite38
wVirtualOAMSprite39:: sprite_oam_struct wVirtualOAMSprite39
	assert_table_length NUM_SPRITE_OAM_STRUCTS
wVirtualOAMEnd::


SECTION "Tilemap", WRAM0

wTilemap::
; 20x18 grid of 8x8 tiles
	ds SCREEN_WIDTH * SCREEN_HEIGHT
wTilemapEnd::


SECTION "Miscellaneous", WRAM0

; This union spans 480 bytes.
UNION
; surrounding tiles
; This buffer determines the size for the rest of the union;
; it uses exactly 480 bytes.
wSurroundingTiles:: ds SURROUNDING_WIDTH * SURROUNDING_HEIGHT

NEXTU
; box save buffer
; SaveBoxAddress uses this buffer in three steps because it
; needs more space than the buffer can hold.
wBoxPartialData:: ds 480
wBoxPartialDataEnd::

NEXTU
; battle tower temp struct
wBT_OTTemp:: battle_tower_struct wBT_OTTemp

NEXTU
; battle data
wBattle::
wEnemyMoveStruct::  move_struct wEnemyMoveStruct
wPlayerMoveStruct:: move_struct wPlayerMoveStruct

wEnemyMonNickname::  ds MON_NAME_LENGTH
wBattleMonNickname:: ds MON_NAME_LENGTH

wBattleMon:: battle_struct wBattleMon

	ds 4
wIntroJumptableIndex:: db
wIntroBGMapPointer:: dw
wIntroTilemapPointer:: dw
wIntroTilesPointer:: dw
wIntroFrameCounter1:: db
wIntroFrameCounter2:: db
wIntroSpriteStateFlag:: db
	
	ds 2

wWildMon:: db
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE)
	ds 1
else
wPreventTrainerBattles:: db
endc
wEnemyTrainerItem1:: db
wEnemyTrainerItem2:: db
wEnemyTrainerBaseReward:: db
wEnemyTrainerAIFlags:: ds 3
wOTClassName:: ds TRAINER_CLASS_NAME_LENGTH

wCurOTMon:: db

wBattleParticipantsNotFainted::
; Bit array.  Bits 0 - 5 correspond to party members 1 - 6.
; Bit set if the mon appears in battle.
; Bit cleared if the mon faints.
; Backed up if the enemy switches.
; All bits cleared if the enemy faints.
	db

wTypeModifier::
; >10: super-effective
;  10: normal
; <10: not very effective
; bit 7: stab
	db

wCriticalHit::
; 0 if not critical
; 1 for a critical hit
; 2 for a OHKO
	db

wAttackMissed::
; nonzero for a miss
	db

wPlayerSubStatus1:: db
wPlayerSubStatus2:: db
wPlayerSubStatus3:: db
wPlayerSubStatus4:: db
wPlayerSubStatus5:: db

wEnemySubStatus1:: db
wEnemySubStatus2:: db
wEnemySubStatus3:: db
wEnemySubStatus4:: db
wEnemySubStatus5:: db

wPlayerRolloutCount:: db
wPlayerConfuseCount:: db
wPlayerToxicCount:: db
wPlayerDisableCount:: db
wPlayerEncoreCount:: db
wPlayerPerishCount:: db
wPlayerFuryCutterCount:: db
wPlayerProtectCount:: db

wEnemyRolloutCount:: db
wEnemyConfuseCount:: db
wEnemyToxicCount:: db
wEnemyDisableCount:: db
wEnemyEncoreCount:: db
wEnemyPerishCount:: db
wEnemyFuryCutterCount:: db
wEnemyProtectCount:: db

wPlayerDamageTaken:: dw
wEnemyDamageTaken::  dw

wBattleReward:: ds 3

wBattleAnimParam:: db

wBattleScriptBuffer:: ds 40

wBattleScriptBufferAddress:: dw

wTurnEnded:: db

wIsConfusionDamage:: db

wPlayerStats::
wPlayerAttack::  dw
wPlayerDefense:: dw
wPlayerSpeed::   dw
wPlayerSpAtk::   dw
wPlayerSpDef::   dw
	ds 1

wEnemyStats::
wEnemyAttack::  dw
wEnemyDefense:: dw
wEnemySpeed::   dw
wEnemySpAtk::   dw
wEnemySpDef::   dw
	ds 1

wPlayerStatLevels::
wPlayerAtkLevel::  db
wPlayerDefLevel::  db
wPlayerSpdLevel::  db
wPlayerSAtkLevel:: db
wPlayerSDefLevel:: db
wPlayerAccLevel::  db
wPlayerEvaLevel::  db
	ds 1

wEnemyStatLevels::
wEnemyAtkLevel::  db
wEnemyDefLevel::  db
wEnemySpdLevel::  db
wEnemySAtkLevel:: db
wEnemySDefLevel:: db
wEnemyAccLevel::  db
wEnemyEvaLevel::  db
	ds 1

wEnemyTurnsTaken::  db
wPlayerTurnsTaken:: db
	ds 1

wPlayerSubstituteHP:: db
wEnemySubstituteHP::  db

wUnusedPlayerLockedMove:: db
	ds 1

wCurPlayerMove:: db
wCurEnemyMove::  db

wLinkBattleRNCount::
; how far through the prng stream
	db

wEnemyItemState:: db
	ds 2
wCurEnemyMoveNum:: db

wEnemyHPAtTimeOfPlayerSwitch:: dw
wPayDayMoney:: ds 3

	ds 1

wSafariMonEating:: db

	ds 1
	
wEnemyBackupDVs:: dw ; used when enemy is transformed
wAlreadyDisobeyed:: db

wDisabledMove:: db
wEnemyDisabledMove:: db
wWhichMonFaintedFirst:: db

; exists so you can't counter on switch
wLastPlayerCounterMove:: db
wLastEnemyCounterMove:: db

wEnemyMinimized:: db

wAlreadyFailed:: db

wBattleParticipantsIncludingFainted:: db
wAllBattleParticipants:: db
wAllBattleParticipantsAfterVirusSpread:: db
wBattleLowHealthAlarm:: db
wPlayerMinimized:: db
wPlayerScreens::
; bit
; 0 spikes
; 1
; 2 safeguard
; 3 light screen
; 4 reflect
; 5-7 unused
	db

wEnemyScreens::
; see wPlayerScreens
	db

UNION
wPlayerSafeguardCount:: db
wPlayerLightScreenCount:: db
wPlayerReflectCount:: db
	ds 1

wEnemySafeguardCount:: db
wEnemyLightScreenCount:: db
wEnemyReflectCount:: db
	ds 1

NEXTU
	ds 1
wBetaPokerSGBPals:: dw
	ds 1
wBetaPokerSGBAttr:: db
wBetaPokerSGBCol:: db
wBetaPokerSGBRow:: db
	ds 1
ENDU

	ds 1

wBattleWeather::
; 00 normal
; 01 rain
; 02 sun
; 03 sandstorm
; 04 hail
; 05 rain stopped
; 06 sunliight faded
; 07 sandstorm subsided
; 08 hail stopped
	db

wWeatherCount::
; # turns remaining
	db

wLoweredStat:: db
wEffectFailed:: db
wFailedMessage:: db
wEnemyGoesFirst:: db

wPlayerIsSwitching:: db
wEnemyIsSwitching::  db

wPlayerUsedMoves::
; add a move that has been used once by the player
; added in order of use
	ds NUM_MOVES

wEnemyAISwitchScore:: db
wEnemySwitchMonParam:: db
wEnemySwitchMonIndex:: db
wTempLevel:: db
wLastPlayerMon:: db
wLastPlayerMove:: db
wLastEnemyMove:: db

wPlayerFutureSightCount:: db
wEnemyFutureSightCount:: db

wGivingExperienceToExpShareHolders:: db

wBackupEnemyMonBaseStats:: ds NUM_EXP_STATS
wBackupEnemyMonCatchRate:: db
wBackupEnemyMonBaseExp:: db

wPlayerFutureSightDamage:: dw
wEnemyFutureSightDamage:: dw
wPlayerRageCounter:: db
wEnemyRageCounter:: db

wBeatUpHitAtLeastOnce:: db

wPlayerTrappingMove:: db
wEnemyTrappingMove:: db
wPlayerWrapCount:: db
wEnemyWrapCount:: db
wPlayerCharging:: db
wEnemyCharging:: db

wBattleEnded:: db

wWildMonMoves:: ds NUM_MOVES
wWildMonPP:: ds NUM_MOVES

wAmuletCoin:: db

wSomeoneIsRampaging:: db

wPlayerJustGotFrozen:: db
wEnemyJustGotFrozen:: db
wBattleEnd::

NEXTU
; unown puzzle
wUnownPuzzle::
	ds 200
wPuzzlePieces:: ds 6 * 6
	ds 244
wUnownPuzzleEnd::

NEXTU
; link patch lists
wPlayerPatchLists:: ds 200
wOTPatchLists:: ds 200

NEXTU
wMobileTransferData:: ds 480

NEXTU

; This union spans 200 bytes.
UNION
; timeset temp storage
wTimeSetBuffer::
	ds 20
wInitHourBuffer:: db
	ds 9
wInitMinuteBuffer:: db
	ds 19
wTimeSetBufferEnd::

NEXTU
; hall of fame temp struct
wHallOfFameTemp:: hall_of_fame wHallOfFameTemp

NEXTU
; odd egg
wOddEgg:: party_struct wOddEgg
wOddEggName:: ds MON_NAME_LENGTH
wOddEggOT:: ds NAME_LENGTH

NEXTU
; debug mon color picker
wDebugMiddleColors::
wDebugLightColor:: ds 2
wDebugDarkColor::  ds 2
	ds 6
wDebugRedChannel::   db
wDebugGreenChannel:: db
wDebugBlueChannel::  db

NEXTU
; debug tileset color picker
wDebugPalette::
wDebugWhiteTileColor:: ds 2
wDebugLightTileColor:: ds 2
wDebugDarkTileColor::  ds 2
wDebugBlackTileColor:: ds 2

NEXTU
wc608:: ds 16
wc618:: ds 37
wc63d:: ds 5
wc642:: ds 5
wc647:: ds 1
wc648:: ds 2
wc64a:: ds 30
wc668:: ds 32
wc688:: ds 2
wc68a:: ds 30
wc6a8:: ds 40
ENDU

; This union spans 280 bytes.
UNION
; pokedex
wPokedexDataStart::
wPokedexOrder:: ds $100 ; >= NUM_POKEMON
wPokedexOrderEnd::
wDexListingScrollOffset:: db ; offset of the first displayed entry from the start
wDexListingCursor:: db ; Dex cursor
wDexListingEnd:: db ; Last mon to display
wDexListingHeight:: db ; number of entries displayed at once in the dex listing
wCurDexMode:: db ; Pokedex Mode
wDexSearchMonType1:: db ; first type to search
wDexSearchMonType2:: db ; second type to search
wDexSearchResultCount:: db
wDexArrowCursorPosIndex:: db
wDexArrowCursorDelayCounter:: db
wDexArrowCursorBlinkCounter:: db
wDexSearchSlowpokeFrame:: db
wUnlockedUnownMode:: db
wDexCurUnownIndex:: db
wDexUnownCount:: db
wDexConvertedMonType:: db ; mon type converted from dex search mon type
wDexListingScrollOffsetBackup:: db
wDexListingCursorBackup:: db
wBackupDexListingCursor:: db
wBackupDexListingPage:: db
wDexCurLocation:: db
if DEF(_CRYSTAL11)
wPokedexStatus:: db
wPokedexDataEnd::
else
wPokedexDataEnd:: ds 1
endc
	ds 2

NEXTU
; pokegear
wPokegearPhoneDisplayPosition:: db
wPokegearPhoneCursorPosition:: db
wPokegearPhoneScrollPosition:: db
wPokegearPhoneSelectedPerson:: db
wPokegearPhoneSubmenuCursor:: db
wPokegearMapCursorObjectPointer:: dw
wPokegearMapCursorLandmark:: db
wPokegearMapPlayerIconLandmark:: db
wPokegearRadioChannelBank:: db
wPokegearRadioChannelAddr:: dw
wPokegearRadioMusicPlaying:: db

NEXTU
; trade
wPlayerTrademon:: trademon wPlayerTrademon
wOTTrademon::     trademon wOTTrademon
wTradeAnimAddress:: dw
wLinkPlayer1Name:: ds NAME_LENGTH
wLinkPlayer2Name:: ds NAME_LENGTH
wLinkTradeSendmonSpecies:: db
wLinkTradeGetmonSpecies::  db

NEXTU
; naming screen
wNamingScreenDestinationPointer:: dw
wNamingScreenCurNameLength:: db
wNamingScreenMaxNameLength:: db
wNamingScreenType:: db
wNamingScreenCursorObjectPointer:: dw
wNamingScreenLastCharacter:: db
wNamingScreenStringEntryCoord:: dw

NEXTU
; slot machine
wSlots::
wReel1:: slot_reel wReel1
wReel2:: slot_reel wReel2
wReel3:: slot_reel wReel3
wReel1Stopped:: ds 3
wReel2Stopped:: ds 3
wReel3Stopped:: ds 3
wSlotBias:: db
wSlotBet:: db
wFirstTwoReelsMatching:: db
wFirstTwoReelsMatchingSevens:: db
wSlotMatched:: db
wCurReelStopped:: ds 3
wPayout:: dw
wCurReelXCoord:: db
wCurReelYCoord:: db
	ds 2
wSlotBuildingMatch:: db
wSlotsDataEnd::
	ds 28
wSlotsEnd::

NEXTU
; card flip
wDeck:: ds 4 * 6
wDeckEnd::
wCardFlipNumCardsPlayed:: db
wCardFlipFaceUpCard:: db
wDiscardPile:: ds 4 * 6
wDiscardPileEnd::

NEXTU
; unused memory game
wMemoryGameCards:: ds 9 * 5
wMemoryGameCardsEnd::
wMemoryGameLastCardPicked:: db
wMemoryGameCard1:: db
wMemoryGameCard2:: db
wMemoryGameCard1Location:: db
wMemoryGameCard2Location:: db
wMemoryGameNumberTriesRemaining:: db
wMemoryGameLastMatches:: ds 5
wMemoryGameCounter:: db
wMemoryGameNumCardsMatched:: db

NEXTU
; mobile data
wc6d0:: ds 56
wc708:: db
wc709:: db
wc70a:: db
wc70b:: db
wc70c:: db
wc70d:: db
wc70e:: db
wc70f:: db
wc710:: db
wc711:: db
wc712:: ds 7
wc719:: ds 53
wc74e:: ds 107
wc7b9:: ds 1
wc7ba:: ds 1
wc7bb:: ds 2
wc7bd:: ds 19
wc7d0:: ds 1
wc7d1:: ds 1
wc7d2:: ds 1
wc7d3:: ds 2
ENDU

ENDU

; This was a buffer for map-related pointers in the 1997 G/S prototype.
; See wMapBuffer in pokegold-spaceworld's wram.asm.
wUnusedMapBuffer:: ds 24
wUnusedMapBufferEnd::


SECTION "Overworld Map", WRAM0

UNION
; overworld map blocks
wOverworldMapBlocks:: ds 1300
wOverworldMapBlocksEnd::

NEXTU
; GB Printer data
wGameboyPrinterRAM::
wGameboyPrinter2bppSource:: ds 40 tiles
wGameboyPrinter2bppSourceEnd::
wUnusedGameboyPrinterSafeCancelFlag:: db
wPrinterRowIndex:: db

; Printer data
wPrinterData:: ds 4
wPrinterChecksum:: dw
wPrinterHandshake:: db
wPrinterStatusFlags::
; bit 7: set if error 1 (battery low)
; bit 6: set if error 4 (too hot or cold)
; bit 5: set if error 3 (paper jammed or empty)
; if this and the previous byte are both $ff: error 2 (connection error)
	db

wHandshakeFrameDelay:: db
wPrinterSerialFrameDelay:: db
wPrinterSendByteOffset:: dw
wPrinterSendByteCounter:: dw

; tilemap backup?
wPrinterTilemapBuffer:: ds SCREEN_HEIGHT * SCREEN_WIDTH
wPrinterStatus:: db
	ds 1
; High nibble is for margin before the image, low nibble is for after.
wPrinterMargins:: db
wPrinterExposureTime:: db
	ds 16
wGameboyPrinterRAMEnd::

NEXTU
; bill's pc data
wBillsPCData::
wBillsPCPokemonList::
; (species, box number, list index) x30
	ds 3 * 30
	ds 720
wBillsPC_ScrollPosition:: db
wBillsPC_CursorPosition:: db
wBillsPC_NumMonsInBox:: db
wBillsPC_NumMonsOnScreen:: db
wBillsPC_LoadedBox:: db ; 0 if party, 1 - 14 if box, 15 if active box
wBillsPC_BackupScrollPosition:: db
wBillsPC_BackupCursorPosition:: db
wBillsPC_BackupLoadedBox:: db
wBillsPC_MonHasMail:: db
	ds 5
wBillsPCDataEnd::


NEXTU
; Hall of Fame data
wHallOfFamePokemonList:: hall_of_fame wHallOfFamePokemonList

NEXTU
; debug color picker
wDebugOriginalColors:: ds 256 * 4

NEXTU
; raw link data
wLinkData:: ds 1300
wLinkDataEnd::

NEXTU
; link data members
wLinkPlayerName:: ds NAME_LENGTH
wLinkPartyCount:: db
wLinkPartySpecies:: ds PARTY_LENGTH
wLinkPartyEnd:: db ; older code doesn't check PartyCount

UNION
; link player data
wLinkPlayerData::
	table_width PARTYMON_STRUCT_LENGTH, wLinkPlayerData
wLinkPlayerPartyMon1:: party_struct wLinkPlayerPartyMon1
wLinkPlayerPartyMon2:: party_struct wLinkPlayerPartyMon2
wLinkPlayerPartyMon3:: party_struct wLinkPlayerPartyMon3
wLinkPlayerPartyMon4:: party_struct wLinkPlayerPartyMon4
wLinkPlayerPartyMon5:: party_struct wLinkPlayerPartyMon5
wLinkPlayerPartyMon6:: party_struct wLinkPlayerPartyMon6
	assert_table_length PARTY_LENGTH

wLinkPlayerPartyMonOTs::
	table_width NAME_LENGTH, wLinkPlayerPartyMonOTs
wLinkPlayerPartyMon1OT:: ds NAME_LENGTH
wLinkPlayerPartyMon2OT:: ds NAME_LENGTH
wLinkPlayerPartyMon3OT:: ds NAME_LENGTH
wLinkPlayerPartyMon4OT:: ds NAME_LENGTH
wLinkPlayerPartyMon5OT:: ds NAME_LENGTH
wLinkPlayerPartyMon6OT:: ds NAME_LENGTH
	assert_table_length PARTY_LENGTH

wLinkPlayerPartyMonNicknames::
	table_width MON_NAME_LENGTH, wLinkPlayerPartyMonNicknames
wLinkPlayerPartyMon1Nickname:: ds MON_NAME_LENGTH
wLinkPlayerPartyMon2Nickname:: ds MON_NAME_LENGTH
wLinkPlayerPartyMon3Nickname:: ds MON_NAME_LENGTH
wLinkPlayerPartyMon4Nickname:: ds MON_NAME_LENGTH
wLinkPlayerPartyMon5Nickname:: ds MON_NAME_LENGTH
wLinkPlayerPartyMon6Nickname:: ds MON_NAME_LENGTH
	assert_table_length PARTY_LENGTH

NEXTU
; link patch lists
wLinkPatchList1:: ds SERIAL_PATCH_LIST_LENGTH
wLinkPatchList2:: ds SERIAL_PATCH_LIST_LENGTH
ENDU

NEXTU
; link data prep
	ds 1000
wCurLinkOTPartyMonTypePointer:: dw

wLinkOTPartyMonTypes::
	table_width 2, wLinkOTPartyMonTypes
wLinkOTPartyMon1Type:: dw
wLinkOTPartyMon2Type:: dw
wLinkOTPartyMon3Type:: dw
wLinkOTPartyMon4Type:: dw
wLinkOTPartyMon5Type:: dw
wLinkOTPartyMon6Type:: dw
	assert_table_length PARTY_LENGTH

NEXTU
; link mail data
	ds 500
wLinkPlayerMail::
wLinkPlayerMailPreamble:: ds SERIAL_MAIL_PREAMBLE_LENGTH
wLinkPlayerMailMessages:: ds (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
wLinkPlayerMailMetadata:: ds (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH
wLinkPlayerMailPatchSet:: ds 103
wLinkPlayerMailEnd::
	ds 10
wLinkOTMail::
wLinkOTMailMessages:: ds (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
wLinkOTMailMetadata:: ds (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH
wOTPlayerMailPatchSet:: ds 103 + SERIAL_MAIL_PREAMBLE_LENGTH
wLinkOTMailEnd::
	ds 10

NEXTU
; received link mail data
	ds 500
wLinkReceivedMail:: ds MAIL_STRUCT_LENGTH * PARTY_LENGTH
wLinkReceivedMailEnd:: db

NEXTU
; mystery gift data
wMysteryGiftStaging:: ds 80

UNION
wMysteryGiftTrainer:: ds 1 + (1 + 1 + NUM_MOVES) * PARTY_LENGTH + 1
wMysteryGiftTrainerEnd::

NEXTU
wNameCardData:: ds NAME_LENGTH + 2 + 2 + 1 + 8 + 12
wNameCardDataEnd::

NEXTU
wMysteryGiftCardHolderName:: ds PLAYER_NAME_LENGTH
ENDU

	ds 138 ; Erased every time a map is loaded (filled with zeros by FillBytes).

wMysteryGiftPartnerData::
wMysteryGiftGameVersion:: db
wMysteryGiftPartnerID:: dw
wMysteryGiftPartnerName:: ds NAME_LENGTH
wMysteryGiftPartnerDexCaught:: db
wMysteryGiftPartnerSentDeco:: db
wMysteryGiftPartnerWhichItem:: db
wMysteryGiftPartnerWhichDeco:: db
wMysteryGiftPartnerBackupItem:: db
	ds 1
wMysteryGiftPartnerDataEnd::

	ds 60 ; Also erased every time a map is loaded.

wMysteryGiftPlayerData::
	ds 1
wMysteryGiftPlayerID:: dw
wMysteryGiftPlayerName:: ds NAME_LENGTH
wMysteryGiftPlayerDexCaught:: db
wMysteryGiftPlayerSentDeco:: db
wMysteryGiftPlayerWhichItem:: db
wMysteryGiftPlayerWhichDeco:: db
wMysteryGiftPlayerBackupItem:: db
	ds 1
wMysteryGiftPlayerDataEnd::

NEXTU
	ds $200

UNION
; blank credits tile buffer
wCreditsBlankFrame2bpp:: ds 4 * 4 tiles
wCreditsBlankFrame2bppEnd::

NEXTU
; mystery gift data
wUnusedMysteryGiftStagedDataLength:: db
wMysteryGiftMessageCount:: db
wMysteryGiftStagedDataLength:: db
ENDU

NEXTU
; mobile
	ds 7
wc807:: ds 1
	ds 10
wMobileSDK_PacketChecksum:: dw
	ds 4
wMobileSDK_AdapterType:: db
	ds 5
wMobileSDK_SendCommandID:: db
	ds 2
wc821:: ds 1
wc822:: ds 525
wMobileSDK_ReceivePacketBufferAlt:: ds 11
wMobileSDK_ReceivedBytes:: dw
wMobileSDK_ReceivePacketBuffer:: ds 267
wMobileSDK_PacketBuffer:: ds 281
wcc60:: ds 1
wcc61:: ds 1
wcc62:: ds 2
wcc64:: ds 1
wcc65:: ds 57
	ds 22
wccb4:: ds 1
wccb5:: ds 3
wccb8:: ds 1
wccb9:: ds 1
wccba:: ds 90

if DEF(_DEBUG)
NEXTU
; debug room

; debug room RTC values
wDebugRoomRTCSec::  db
wDebugRoomRTCMin::  db
wDebugRoomRTCHour:: db
wDebugRoomRTCDay::  dw
wDebugRoomRTCCurSec::  db
wDebugRoomRTCCurMin::  db
wDebugRoomRTCCurHour:: db
wDebugRoomRTCCurDay::  dw

; debug room paged values
wDebugRoomCurPage::        db
wDebugRoomCurValue::       db
wDebugRoomAFunction::      dw
wDebugRoomStartFunction::  dw
wDebugRoomSelectFunction:: dw
wDebugRoomAutoFunction::   dw
wDebugRoomPageCount::      db
wDebugRoomPagesPointer::   dw

wDebugRoomROMChecksum:: dw
wDebugRoomCurChecksumBank:: db

UNION
; debug room new item values
wDebugRoomItemID::       db
wDebugRoomItemQuantity:: db
NEXTU
; debug room new pokemon values
wDebugRoomMon::    box_struct wDebugRoomMon
wDebugRoomMonBox:: db
NEXTU
; debug room GB ID values
wDebugRoomGBID:: dw
ENDU

endc

ENDU

	ds 12


SECTION "Video", WRAM0

UNION
; bg map
wBGMapBuffer::    ds 40
wBGMapPalBuffer:: ds 40
wBGMapBufferPointers:: ds 20 * 2
wBGMapBufferEnd::

NEXTU
; credits
wCreditsPos:: dw
wCreditsTimer:: db

NEXTU
; mobile data
wMobileMonSpeciesPointer:: dw
wMobileMonStructPointer:: dw
wMobileMonOTPointer:: dw
wMobileMonNicknamePointer:: dw
wMobileMonMailPointer:: dw

NEXTU
; more mobile data
wcd20:: ds 1
wcd21:: ds 1
wcd22:: ds 1
wcd23:: ds 1
wcd24:: ds 1
wMobileCommsJumptableIndex:: ds 1
wcd26:: ds 1
wcd27:: ds 1
wcd28:: ds 1
wcd29:: ds 1

wMobileMonSpecies::
wcd2a:: db

UNION
wTempOddEggNickname:: ds MON_NAME_LENGTH
NEXTU
wcd2b:: ds 1
wcd2c:: ds 1
wcd2d:: ds 1
wcd2e:: ds 1
wcd2f:: ds 1
wcd30:: ds 1
wcd31:: ds 1
wcd32:: ds 1
wcd33:: ds 1
wcd34:: ds 1
wcd35:: ds 1
ENDU

; current time for link/mobile?
wcd36:: db ; hours
wcd37:: db ; mins
wcd38:: db ; secs

wcd39:: ds 1
wcd3a:: ds 1
wcd3b:: ds 1
wBattleTowerRoomMenu2JumptableIndex:: ds 1
wcd3d:: ds 1
wcd3e:: ds 1
wcd3f:: ds 1
wcd40:: ds 1
wcd41:: ds 1
wcd42:: ds 1
wcd43:: ds 1

; some sort of timer in link battles
wMobileInactivityTimerMinutes:: db ; mins
wMobileInactivityTimerSeconds:: db ; secs
wMobileInactivityTimerFrames:: db ; frames
wcd47:: ds 1

	ds 1

wBTTempOTSprite::
wcd49:: db

wcd4a:: ds 1
wcd4b:: ds 1

wEZChatCursorXCoord::
wcd4c:: db
wEZChatCursorYCoord::
wcd4d:: db

wcd4e:: ds 1
wcd4f:: ds 1
wcd50:: ds 1
wcd51:: ds 1
wcd52:: ds 1

wMobileOpponentBattleMessage:: ; ds 12
wcd53:: ds 1
wcd54:: ds 1
wcd55:: ds 1
wcd56:: ds 1
wcd57:: ds 1
wcd58:: ds 1
wcd59:: ds 1
wcd5a:: ds 1
wcd5b:: ds 1
wcd5c:: ds 1
wcd5d:: ds 1
wcd5e:: ds 1
wcd5f:: ds 1
wcd60:: ds 2
wcd62:: ds 1
wcd63:: ds 1
wcd64:: ds 1
wcd65:: ds 1
wcd66:: ds 1
wcd67:: ds 1
wcd68:: ds 1
wcd69:: ds 1
wcd6a:: ds 1
wcd6b:: ds 1
wcd6c:: ds 1
wcd6d:: ds 1
wcd6e:: ds 1
wcd6f:: ds 1
wcd70:: ds 1
wcd71:: ds 1
wcd72:: ds 1
wcd73:: ds 1
wcd74:: ds 1

wOTMonSelection:: ds 2 ; ds BATTLETOWER_PARTY_LENGTH
wcd77:: ds 1

wMobileCrashCheckPointer:: dw
wcd7a:: ds 2
wcd7c:: ds 3
wcd7f:: ds 1
wcd80:: ds 1
wcd81:: ds 1
wcd82:: ds 1
wcd83:: ds 1
wcd84:: ds 1
wcd85:: ds 4
wcd89:: ds 1
wcd8a:: ds 1
wcd8b:: ds 1
wcd8c:: ds 1
wcd8d:: ds 11
ENDU

wDefaultSGBLayout:: db

wPlayerHPPal:: db
wEnemyHPPal:: db

wHPPals:: ds PARTY_LENGTH
wCurHPPal:: db

	ds 7

wSGBPals:: ds 48

wAttrmap::
; 20x18 grid of bg tile attributes for 8x8 tiles
; read horizontally from the top row
;		bit 7: priority
;		bit 6: y flip
;		bit 5: x flip
;		bit 4: pal # (non-cgb)
;		bit 3: vram bank (cgb only)
;		bit 2-0: pal # (cgb only)
	ds SCREEN_WIDTH * SCREEN_HEIGHT
wAttrmapEnd::

UNION
; addresses dealing with serial comms
	ds 1
wcf42:: db
	ds 1
wcf44:: db
wcf45:: db

NEXTU
wTileAnimBuffer:: ds 1 tiles
ENDU

; link data
UNION
wOtherPlayerLinkMode:: db
wOtherPlayerLinkAction:: db
	ds 3
wPlayerLinkAction:: db
wUnusedLinkAction:: db
	ds 3
NEXTU
wLinkReceivedSyncBuffer:: ds 5
wLinkPlayerSyncBuffer:: ds 5
ENDU
wLinkTimeoutFrames:: dw
wLinkByteTimeout:: dw

wMonType:: db

wCurSpecies:: db

wNamedObjectType:: db

	ds 1

wJumptableIndex::
wBattleTowerBattleEnded::
	db

UNION
; intro data
wIntroSceneFrameCounter:: db
wIntroSceneTimer:: db

NEXTU
; title data
wTitleScreenSelectedOption:: db
wTitleScreenTimer:: dw

NEXTU
; credits data
wCreditsBorderFrame:: db
wCreditsBorderMon:: db
wCreditsLYOverride:: db

NEXTU
; pokedex
wPrevDexEntryJumptableIndex:: db
if DEF(_CRYSTAL11)
wPrevDexEntryBackup:: db
else
wPrevDexEntryBackup::
wPokedexStatus:: db
endc
wUnusedPokedexByte:: db

NEXTU
; pokegear
wPokegearCard:: db
wPokegearMapRegion:: db
wUnusedPokegearByte:: db

NEXTU
; pack
wPackJumptableIndex:: db
wCurPocket:: db
wPackUsedItem:: db

NEXTU
; trainer card badges
wTrainerCardBadgeFrameCounter:: db
wTrainerCardBadgeTileID:: db
wTrainerCardBadgeAttributes:: db

NEXTU
; slot machine
wSlotsDelay:: db
	ds 1
wUnusedSlotReelIconDelay:: db

NEXTU
; card flip
wCardFlipCursorY:: db
wCardFlipCursorX:: db
wCardFlipWhichCard:: db

NEXTU
; unused memory game
wMemoryGameCardChoice:: db

NEXTU
; magnet train
wMagnetTrainOffset:: db
wMagnetTrainPosition:: db
wMagnetTrainWaitCounter:: db

NEXTU
; unown puzzle data
wHoldingUnownPuzzlePiece:: db
wUnownPuzzleCursorPosition:: db
wUnownPuzzleHeldPiece:: db

NEXTU
; battle transitions
wBattleTransitionCounter:: db
wBattleTransitionSineWaveOffset::
wBattleTransitionSpinQuadrant:: db

NEXTU
; bill's pc
wUnusedBillsPCData:: ds 3

NEXTU
; debug mon color picker
wDebugColorRGBJumptableIndex:: db
wDebugColorCurColor:: db
wDebugColorCurMon:: db

NEXTU
; debug tileset color picker
wDebugTilesetCurPalette:: db
wDebugTilesetRGBJumptableIndex:: db
wDebugTilesetCurColor:: db

NEXTU
; stats screen
wStatsScreenFlags:: db

NEXTU
; battle tower
wNrOfBeatenBattleTowerTrainers:: db
	ds 1
wBattleTowerRoomMenuJumptableIndex:: db

NEXTU
; miscellaneous
wFrameCounter::
wMomBankDigitCursorPosition::
wNamingScreenLetterCase::
wHallOfFameMonCounter::
wTradeDialog::
	db
wFrameCounter2::
wPrinterQueueLength::
	db
wUnusedTradeAnimPlayEvolutionMusic:: db

NEXTU
; mobile
wcf64:: db
wcf65:: db
wcf66:: db
ENDU

wRequested2bppSize:: db
wRequested2bppSource:: dw
wRequested2bppDest:: dw

wRequested1bppSize:: db
wRequested1bppSource:: dw
wRequested1bppDest:: dw

wWindowStackPointer:: dw
wMenuJoypad:: db
wMenuSelection:: db
wMenuSelectionQuantity:: db
wWhichIndexSet:: db
wScrollingMenuCursorPosition:: db
wWindowStackSize:: db

	ds 8

; menu header
wMenuHeader::
wMenuFlags:: db
wMenuBorderTopCoord:: db
wMenuBorderLeftCoord:: db
wMenuBorderBottomCoord:: db
wMenuBorderRightCoord:: db
wMenuDataPointer:: dw
wMenuCursorPosition:: db
	ds 1
wMenuDataBank:: db
	ds 6
wMenuHeaderEnd::

wMenuData::
wMenuDataFlags:: db

UNION
; Vertical Menu/DoNthMenu/SetUpMenu
wMenuDataItems:: db
wMenuDataIndicesPointer:: dw
wMenuDataDisplayFunctionPointer:: dw
wMenuDataPointerTableAddr:: dw

NEXTU
; 2D Menu
wMenuData_2DMenuDimensions:: db
wMenuData_2DMenuSpacing:: db
wMenuData_2DMenuItemStringsBank:: db
wMenuData_2DMenuItemStringsAddr:: dw
wMenuData_2DMenuFunctionBank:: db
wMenuData_2DMenuFunctionAddr:: dw

NEXTU
; Scrolling Menu
wMenuData_ScrollingMenuHeight:: db
wMenuData_ScrollingMenuWidth:: db
wMenuData_ScrollingMenuItemFormat:: db
wMenuData_ItemsPointerBank:: db
wMenuData_ItemsPointerAddr:: dw
wMenuData_ScrollingMenuFunction1:: ds 3
wMenuData_ScrollingMenuFunction2:: ds 3
wMenuData_ScrollingMenuFunction3:: ds 3
ENDU
wMenuDataEnd::

w2DMenuData::
w2DMenuCursorInitY:: db
w2DMenuCursorInitX:: db
w2DMenuNumRows:: db
w2DMenuNumCols:: db
w2DMenuFlags1::
; bit 7: Disable checking of wMenuJoypadFilter
; bit 6: Enable sprite animations
; bit 5: Wrap around vertically
; bit 4: Wrap around horizontally
; bit 3: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far down
; bit 2: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far up
; bit 1: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far left
; bit 0: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far right
	db
w2DMenuFlags2:: db
w2DMenuCursorOffsets:: db
wMenuJoypadFilter:: db
w2DMenuDataEnd::

wMenuCursorY:: db
wMenuCursorX:: db
wCursorOffCharacter:: db
wCursorCurrentTile:: dw

	ds 3

wOverworldDelay:: db
wTextDelayFrames:: db
wVBlankOccurred:: db

wPredefID:: db
wPredefHL:: dw
wPredefAddress:: dw
wFarCallBC:: dw

wUnusedLinkCommunicationByte:: db

wGameTimerPaused::
; bit 0: game timer paused
; bit 7: something mobile
	db

	ds 1

wJoypadDisable::
; bits 4, 6, or 7 can be used to disable joypad input
; bit 4
; bit 6: ongoing mon faint animation
; bit 7: ongoing sgb data transfer
	db

wBattlePokerusSeed:: db ; Seed 000 is no Pokérus, otherwise the wild Pokémon will spread Pokérus at the end of the battle, and will have it itself if caught. Set it to 1 before a battle to force a covid battle.

wInBattleTowerBattle::
; 0 not in BattleTower-Battle
; 1 BattleTower-Battle
	db

wAssaultBattle:: db

wFXAnimID:: dw

wPlaceBallsX:: db
wPlaceBallsY:: db

wTileAnimationTimer:: db

; palette backups?
wBGP:: db
wOBP0:: db
wOBP1:: db

wNumHits:: db

wOptionsBackup:: db ; Used during Red's battle and shiny battles, to force the activation of the battle animations.

wOptions::
; bit 0-2: number of frames to delay when printing text
;   fast 1; mid 3; slow 5
; bit 3: ?
; bit 4: no text delay
; bit 5: stereo off/on
; bit 6: battle style shift/set
; bit 7: battle scene off/on
	db
wSaveFileExists:: db
wTextboxFrame::
; bits 0-2: textbox frame 0-7
	db
wTextboxFlags::
; bit 0: 1-frame text delay
; bit 4: no text delay
	db
wGBPrinterBrightness::
; bit 0-6: brightness
;   lightest: $00
;   lighter:  $20
;   normal:   $40 (default)
;   darker:   $60
;   darkest:  $7F
	db
wOptions2::
; bit 1: menu account off/on
	db
	ds 2
wOptionsEnd::

; Time buffer, for counting the amount of time since
; an event began.
wSecondsSince:: db
wMinutesSince:: db
wHoursSince:: db
wDaysSince:: db


SECTION "WRAM 1", WRAMX

wGBCOnlyDecompressBuffer:: ; a $540-byte buffer that continues past this SECTION

wBetaTitleSequenceOpeningType::
; This selected the title screen animation (fire/notes) in pokegold-spaceworld.
	db

wDefaultSpawnpoint:: db

UNION ; 92 bytes.
; mon buffer
wBufferMonNickname:: ds MON_NAME_LENGTH
wBufferMonOT:: ds NAME_LENGTH
wBufferMon:: party_struct wBufferMon

	ds 8 ; Important padding: don't delete.

wMonOrItemNameBuffer:: ds ITEM_NAME_LENGTH + 1

NEXTU
; poke seer
wSeerAction:: db
wSeerNickname:: ds MON_NAME_LENGTH
wSeerCaughtLocation:: ds 17
wSeerTimeOfDay:: ds NAME_LENGTH
wSeerOT:: ds NAME_LENGTH
wSeerOTGrammar:: db
wSeerCaughtLevelString:: ds 4
wSeerCaughtLevel:: db
wSeerCaughtData:: db
wSeerCaughtGender:: db

NEXTU
; mail temp storage
wTempMail:: mailmsg wTempMail

NEXTU
; bug-catching contest
wBugContestResults::
	bugcontestwinner wBugContestFirstPlace
	bugcontestwinner wBugContestSecondPlace
	bugcontestwinner wBugContestThirdPlace
wBugContestWinnersEnd::
	bugcontestwinner wBugContestTemp
	ds 4
wBugContestWinnerName:: ds NAME_LENGTH

NEXTU
; mart items
wMartItem1BCD:: ds 3
wMartItem2BCD:: ds 3
wMartItem3BCD:: ds 3
wMartItem4BCD:: ds 3
wMartItem5BCD:: ds 3
wMartItem6BCD:: ds 3
wMartItem7BCD:: ds 3
wMartItem8BCD:: ds 3
wMartItem9BCD:: ds 3
wMartItem10BCD:: ds 3

NEXTU
; town map data
wTownMapPlayerIconLandmark:: db
UNION
wTownMapCursorLandmark:: db
wTownMapCursorObjectPointer:: dw
NEXTU
wTownMapCursorCoordinates:: dw
wStartFlypoint:: db
wEndFlypoint:: db
ENDU

NEXTU
; phone call data
wPhoneScriptBank:: db
wPhoneCaller:: dw

NEXTU
; radio data
wCurRadioLine:: db
wNextRadioLine:: db
wRadioTextDelay:: db
wNumRadioLinesPrinted:: db
wOaksPKMNTalkSegmentCounter:: db
	ds 5
wRadioText:: ds 2 * SCREEN_WIDTH

NEXTU
; lucky number show
wLuckyNumberDigitsBuffer:: ds 5

NEXTU
; movement buffer data
wMovementBufferCount:: db
wMovementBufferObject:: db
wMovementBuffer:: ds 55

NEXTU
; box printing
wWhichBoxMonToPrint:: db
wFinishedPrintingBox:: db
wAddrOfBoxToPrint:: dw
wBankOfBoxToPrint:: db
wWhichBoxToPrint:: db

NEXTU
; Unown printing
wPrintedUnownTileSource:: ds 1 tiles
wPrintedUnownTileDest:: ds 1 tiles

NEXTU
; trainer HUD data
	ds 1
wPlaceBallsDirection:: db
wTrainerHUDTiles:: ds 4

; battle HUD
wBattleHUDTiles:: ds PARTY_LENGTH ; Damien: this may cause sneaky bugs, because I haven't checked the validity of this memory location, so I don't know if it's shared with something else that is used at the same time. The union is too big to be checked.

NEXTU
; mobile participant nicknames
	ds 4
wMobileParticipant1Nickname:: ds NAME_LENGTH_JAPANESE
wMobileParticipant2Nickname:: ds NAME_LENGTH_JAPANESE
wMobileParticipant3Nickname:: ds NAME_LENGTH_JAPANESE

NEXTU
; battle exp gain
wExperienceGained:: ds 3

NEXTU
; earthquake data buffer
wEarthquakeMovementDataBuffer:: ds 5

NEXTU
; switching items in pack
wSwitchItemBuffer:: ds 2 ; may store 1 or 2 bytes

NEXTU
; switching pokemon in party
; may store NAME_LENGTH, PARTYMON_STRUCT_LENGTH, or MAIL_STRUCT_LENGTH bytes
wSwitchMonBuffer:: ds 48

NEXTU
; giving pokemon mail
wMonMailMessageBuffer:: ds MAIL_MSG_LENGTH + 1

NEXTU
; bill's pc
UNION
wBoxNameBuffer:: ds BOX_NAME_LENGTH
NEXTU
	ds 1
wBillsPCTempListIndex:: db
wBillsPCTempBoxCount:: db
ENDU

NEXTU
; prof. oak's pc
wTempPokedexSeenCount:: db
wTempPokedexCaughtCount:: db

NEXTU
; player's room pc
UNION
wDecoNameBuffer:: ds ITEM_NAME_LENGTH
NEXTU
wNumOwnedDecoCategories:: db
wOwnedDecoCategories:: ds 16
ENDU

NEXTU
; trade
wCurTradePartyMon:: db
wCurOTTradePartyMon:: db
wBufferTrademonNickname:: ds MON_NAME_LENGTH

NEXTU
; link battle record data
wLinkBattleRecordBuffer::
wLinkBattleRecordName::   ds NAME_LENGTH
wLinkBattleRecordWins::   dw
wLinkBattleRecordLosses:: dw
wLinkBattleRecordDraws::  dw

NEXTU
; miscellaneous
wTempDayOfWeek::
wPrevPartyLevel::
wCurBeatUpPartyMon::
wUnownPuzzleCornerTile::
wKeepSevenBiasChance::
wPokeFluteCuredSleep::
wTempRestorePPItem::
wApricorns::
wSuicuneFrame::
	db

NEXTU
; debug color picker
wDebugColorIsTrainer:: db
wDebugColorIsShiny:: db
wDebugColorCurTMHM:: db

NEXTU
; mobile?
wd002:: ds 1
wd003:: ds 1
wd004:: ds 1
	ds 3
wd008:: ds 2
	ds 6
wd010:: ds 1
wd011:: ds 1
wd012:: ds 1
wd013:: ds 1
wd014:: ds 2
	ds 1
wd017:: ds 1
wd018:: ds 1
wd019:: ds 1
	ds 19
wd02d:: ds 1
wd02e:: ds 1
wd02f:: ds 1
wd030:: ds 1
wd031:: ds 1
wd032:: ds 1
wd033:: ds 1
wd034:: ds 2
wd036:: ds 2

NEXTU
; Every previous NEXTU takes up 60 or fewer bytes,
; except the initial "mon buffer" UNION.
	ds 60

UNION
; trainer data
wSeenTrainerBank:: db
wSeenTrainerDistance:: db
wSeenTrainerDirection:: db
wTempTrainer::
wTempTrainerEventFlag:: dw
wTempTrainerClass:: db
wTempTrainerID:: db
wSeenTextPointer:: dw
wWinTextPointer:: dw
wLossTextPointer:: dw
wScriptAfterPointer:: dw
wRunningTrainerBattleScript:: db
wTempTrainerEnd::

NEXTU
; menu items list
wMenuItemsList:: ds 16
wMenuItemsListEnd::

NEXTU
; fruit tree data
wCurFruitTree:: db
wCurFruit:: db

NEXTU
; item ball data
wItemBallData::
wItemBallItemID:: db
wItemBallQuantity:: db
wItemBallDataEnd::

NEXTU
; hidden item data
wHiddenItemData::
wHiddenItemEvent:: dw
wHiddenItemID:: db
wHiddenItemDataEnd::

NEXTU
; elevator data
wElevatorData::
wElevatorPointerBank:: db
wElevatorPointer:: dw
wElevatorOriginFloor:: db
wElevatorDataEnd::

NEXTU
; coord event data
wCurCoordEvent::
wCurCoordEventMapX:: db
wCurCoordEventMapY:: db
wCurCoordEventCondition:: dw
wCurCoordEventScriptAddr:: dw

NEXTU
; BG event data
wCurBGEvent::
wCurBGEventYCoord:: db
wCurBGEventXCoord:: db
wCurBGEventType:: db
wCurBGEventScriptAddr:: dw

NEXTU
; mart data
wMartType:: db
wMartPointerBank:: db
wMartPointer:: dw
wMartJumptableIndex:: db
wBargainShopFlags:: db
wCurrentMartID:: db

NEXTU
; player movement data
wCurInput::
wFacingTileID:: db
wWalkingIntoNPC:: db
wWalkingIntoLand:: db
wWalkingIntoEdgeWarp:: db
wMovementAnimation:: db
wWalkingDirection:: db
wFacingDirection:: db
wWalkingX:: db
wWalkingY:: db
wWalkingTile:: db
	ds 6
wPlayerTurningDirection:: db

NEXTU
; std script buffer
	ds 1
wJumpStdScriptBuffer:: ds 3

NEXTU
; phone script data
wCheckedTime:: db
wPhoneListIndex:: db
wNumAvailableCallers:: db
wAvailableCallers:: ds CONTACT_LIST_SIZE

NEXTU
; phone caller contact
	ds 1
wCallerContact:: ds PHONE_CONTACT_SIZE

NEXTU
; backup menu data
	ds 7
wMenuCursorPositionBackup:: db
wMenuScrollPositionBackup:: db

NEXTU
; poison step data
wPoisonStepData::
wPoisonStepFlagSum:: db
wPoisonStepPartyFlags:: ds PARTY_LENGTH
wPoisonStepDataEnd::
ENDU

	ds 9
ENDU

wTMHMMoveNameBackup:: ds MOVE_NAME_LENGTH

wStringBuffer1:: ds STRING_BUFFER_LENGTH
wStringBuffer2:: ds STRING_BUFFER_LENGTH
wStringBuffer3:: ds STRING_BUFFER_LENGTH
wStringBuffer4:: ds STRING_BUFFER_LENGTH
wStringBuffer5:: ds STRING_BUFFER_LENGTH

wBattleMenuCursorPosition:: db

wCurBattleMon:: db
wCurMoveNum:: db

wLastPocket:: db

wPCItemsCursor::        db
wPartyMenuCursor::      db
wItemsPocketCursor::    db
wKeyItemsPocketCursor:: db
wBallsPocketCursor::    db
wTMHMPocketCursor::     db
wMedPocketCursor::     	db
wBerryPocketCursor::    db

wPCItemsScrollPosition::        db
wItemsPocketScrollPosition::    db
wKeyItemsPocketScrollPosition:: db
wBallsPocketScrollPosition::    db
wTMHMPocketScrollPosition::     db
wMedPocketScrollPosition::     	db
wBerryPocketScrollPosition::  	db

wSwitchMon::
wSwitchItem::
wSwappingMove::
wd0e3:: ; mobile
	db

wMenuScrollPosition:: ds 4

wQueuedScriptBank:: db
wQueuedScriptAddr:: dw

wNumMoves:: db

wFieldMoveSucceeded::
wItemEffectSucceeded::
wBattlePlayerAction::
; 0 - use move
; 1 - use item
; 2 - switch
wSolvedUnownPuzzle::
	db

wVramState::
; bit 0: overworld sprite updating on/off
; bit 1: something to do with sprite updates
; bit 6: something to do with text
; bit 7: on when surf initiates
;        flickers when climbing waterfall
	db

wBattleResult::
; WIN, LOSE, or DRAW
; bit 6: caught celebi
; bit 7: box full
	db
wUsingItemWithSelect:: db

UNION
; mart data
wCurMartCount:: db
wCurMartItems:: ds 12 ; ds 15

NEXTU
; elevator data
wCurElevatorCount:: db
wCurElevatorFloors:: ds 12 ; ds 15

NEXTU
; mailbox data
wCurMessageScrollPosition:: db
wCurMessageIndex:: db
wMailboxCount:: db
wMailboxItems:: ds MAILBOX_CAPACITY
ENDU

wListPointer:: dw

wItemAttributesPointer:: dw

wCurItem:: db
wCurItemQuantity::
wMartItemID::
	db

wCurPartySpecies:: db

wCurPartyMon::
; contains which monster in a party
; is being dealt with at the moment
; 0-5
	db

wWhichHPBar::
; 0: Enemy
; 1: Player
; 2: Party Menu
	db

wPokemonWithdrawDepositParameter::
; 0: Take from PC
; 1: Put into PC
; 2: Take from Day-Care
; 3: Put into Day-Care
; 4: Take from Hospital Box
; 5: Put into Hospital Box
	db

wItemQuantityChange:: db
wItemQuantity:: db

wTempMon:: party_struct wTempMon

wSpriteFlags:: db

wHandlePlayerStep:: db

wCurIconMonHasItemOrMail:: db

wPartyMenuActionText:: db

wItemAttributeValue:: db

wCurPartyLevel:: db

wScrollingMenuListSize:: db

; used when following a map warp
wNextWarp:: db
wNextMapGroup:: db
wNextMapNumber:: db

wPlayerBGMapOffsetX:: db ; used in FollowNotExact; unit is pixels
wPlayerBGMapOffsetY:: db ; used in FollowNotExact; unit is pixels

; Player movement
wPlayerStepVectorX:: db
wPlayerStepVectorY:: db
wPlayerStepFlags:: db
wPlayerStepDirection:: db

wBGMapAnchor:: dw

UNION
wUsedSprites:: ds SPRITE_GFX_LIST_CAPACITY * 2
wUsedSpritesEnd::

NEXTU
	ds SPRITE_GFX_LIST_CAPACITY - 1
wd173:: db ; related to command queue type 3
ENDU

wOverworldMapAnchor:: dw
wMetatileStandingY:: db
wMetatileStandingX:: db

wMapPartial::
wMapAttributesBank:: db
wMapTileset:: db
wEnvironment:: db
wMapAttributesPointer:: dw
wMapPartialEnd::

wMapAttributes::
wMapBorderBlock:: db
; width/height are in blocks (2x2 walkable tiles, 4x4 graphics tiles)
wMapHeight:: db
wMapWidth:: db
wMapBlocksBank:: db
wMapBlocksPointer:: dw
wMapScriptsBank:: db
wMapScriptsPointer:: dw
wMapEventsPointer:: dw
; bit set
wMapConnections:: db
wMapAttributesEnd::

wNorthMapConnection:: map_connection_struct wNorth
wSouthMapConnection:: map_connection_struct wSouth
wWestMapConnection::  map_connection_struct wWest
wEastMapConnection::  map_connection_struct wEast

wTileset::
wTilesetBank:: db
wTilesetAddress:: dw
wTilesetBlocksBank:: db
wTilesetBlocksAddress:: dw
wTilesetCollisionBank:: db
wTilesetCollisionAddress:: dw
wTilesetAnim:: dw ; bank 3f
	ds 2 ; used as a filler, so wTileset uses TILESET_LENGTH bytes.
wTilesetPalettes:: dw ; bank 3f
wTilesetEnd::
	assert wTilesetEnd - wTileset == TILESET_LENGTH

wEvolvableFlags:: flag_array PARTY_LENGTH

wForceEvolution:: db

UNION
; general-purpose HP buffers
wHPBuffer1:: dw
wHPBuffer2:: dw
wHPBuffer3:: dw

NEXTU
; HP bar animations
wCurHPAnimMaxHP::   dw
wCurHPAnimOldHP::   dw
wCurHPAnimNewHP::   dw
wCurHPAnimPal::     db
wCurHPBarPixels::   db
wNewHPBarPixels::   db
wCurHPAnimDeltaHP:: dw
wCurHPAnimLowHP::   db
wCurHPAnimHighHP::  db

NEXTU
; move AI
wEnemyAIMoveScores:: ds NUM_MOVES

NEXTU
; switch AI
wEnemyEffectivenessVsPlayerMons:: flag_array PARTY_LENGTH
wPlayerEffectivenessVsEnemyMons:: flag_array PARTY_LENGTH

NEXTU
; thrown ball data
wFinalCatchRate:: db
wThrownBallWobbleCount:: db

NEXTU
; evolution data
wEvolutionOldSpecies:: db
wEvolutionNewSpecies:: db
wEvolutionPicOffset::  db
wEvolutionCanceled::   db

NEXTU
; experience
wExpToNextLevel:: ds 3

NEXTU
; PP Up
wPPUpPPBuffer:: ds NUM_MOVES

NEXTU
; lucky number show
wMonIDDigitsBuffer:: ds 5

NEXTU
; mon submenu
wMonSubmenuCount:: db
wMonSubmenuItems:: ds NUM_MONMENU_ITEMS + 1

NEXTU
; field move data
wFieldMoveData::
wFieldMoveJumptableIndex:: db
wEscapeRopeOrDigType::
wSurfingPlayerState::
wFishingRodUsed:: db
wCutWhirlpoolOverworldBlockAddr:: dw
wCutWhirlpoolReplacementBlock:: db
wCutWhirlpoolAnimationType::
wStrengthSpecies::
wFishingResult:: db
	ds 1
wFieldMoveDataEnd::

NEXTU
; hidden items
wCurMapScriptBank:: db
wRemainingBGEventCount:: db
wBottomRightYCoord:: db
wBottomRightXCoord:: db

NEXTU
; heal machine anim
wHealMachineAnimType::  db
wHealMachineTempOBP1::  db
wHealMachineAnimState:: db

NEXTU
; decorations
wCurDecoration::          db
wSelectedDecorationSide:: db
wSelectedDecoration::     db
wOtherDecoration::        db
wChangedDecorations::     db
wCurDecorationCategory::  db

NEXTU
; withdraw/deposit items
wPCItemQuantityChange:: db
wPCItemQuantity:: db

NEXTU
; mail
wCurMailAuthorID:: dw
wCurMailIndex:: db

NEXTU
; kurt
wKurtApricornCount:: db
wKurtApricornItems:: ds 10

NEXTU
; restart clock
wRestartClockCurDivision::   db
wRestartClockPrevDivision::  db
wRestartClockUpArrowYCoord:: db
wRestartClockDay::  db
wRestartClockHour:: db
wRestartClockMin::  db

NEXTU
; link
	ds 8
wOtherTrainerType:: db
wLinkBattleRNPreamble:: ds SERIAL_RN_PREAMBLE_LENGTH
wLinkBattleRNs:: ds SERIAL_RNS_LENGTH

NEXTU
; mobile
wd1ea:: ds 1
wd1eb:: ds 1
wd1ec:: ds 1
wd1ed:: ds 1
wd1ee:: ds 1
wd1ef:: ds 1
wd1f0:: ds 1
wd1f1:: ds 1
wd1f2:: ds 1
wd1f3:: ds 1
	ds 6

NEXTU
; miscellaneous bytes
wSkipMovesBeforeLevelUp::
wRegisteredPhoneNumbers::
wListMovesLineSpacing:: db
wSwitchMonTo:: db
wSwitchMonFrom:: db
	ds 4
wCurEnemyItem:: db

NEXTU
; miscellaneous words
wBuySellItemPrice::
wTempMysteryGiftTimer::
wMagikarpLength:: dw
ENDU

wTempEnemyMonSpecies::  db
wTempBattleMonSpecies:: db

wEnemyMon:: battle_struct wEnemyMon
wEnemyMonBaseStats:: ds NUM_EXP_STATS
wEnemyMonCatchRate:: db
wEnemyMonBaseExp::   db
wEnemyMonEnd::

wBattleMode::
; 0: overworld
; 1: wild battle
; 2: trainer battle
	db

UNION
wTempWildMonSpecies:: db
NEXTU
wSickMonIsInThisRoom:: db
ENDU

wOtherTrainerClass::
; class (Youngster, Bug Catcher, etc.) of opposing trainer
; 0 if opponent is a wild Pokémon, not a trainer
	db

; BATTLETYPE_* values
wBattleType:: db

wOtherTrainerID::
; which trainer of the class that you're fighting
; (Joey, Mikey, Albert, etc.)
	db

wForcedSwitch:: db

wTrainerClass:: db

wUnownLetter:: db

wMoveSelectionMenuType:: db

; corresponds to the data/pokemon/base_stats/*.asm contents
wCurBaseData::
wBaseDexNo:: db
wBaseStats::
wBaseHP:: db
wBaseAttack:: db
wBaseDefense:: db
wBaseSpeed:: db
wBaseSpecialAttack:: db
wBaseSpecialDefense:: db
wBaseType::
wBaseType1:: db
wBaseType2:: db
wBaseCatchRate:: db
wBaseExp:: db
wBaseItems::
wBaseItem1:: db
wBaseItem2:: db
wBaseGender:: db
wBaseUnknown1:: db
wBaseEggSteps:: db
wBaseUnknown2:: db
wBasePicSize:: db
wBaseUnusedFrontpic:: dw
wBaseUnusedBackpic:: dw
wBaseGrowthRate:: db
wBaseEggGroups:: db
wBaseTMHM:: flag_array NUM_TM_HM_TUTOR
wCurBaseDataEnd::
	assert wCurBaseDataEnd - wCurBaseData == BASE_DATA_SIZE

UNION
wCurDamage:: dw
NEXTU
wOWTempByte1:: db
wOWTempByte2:: db
ENDU

wMornEncounterRate::  db
wDayEncounterRate::   db
wNiteEncounterRate::  db
wWaterEncounterRate:: db
wListMoves_MoveIndicesBuffer:: ds NUM_MOVES
wPutativeTMHMMove:: db
wInitListType:: db
wBattleHasJustStarted:: db

wNamedObjectIndex::
wTextDecimalByte::
wTempByteValue::
wTypeMatchup::
wCurType::
wTempSpecies::
wTempIconSpecies::
wTempTMHM::
wTempPP::
wNextBoxOrPartyIndex::
wChosenCableClubRoom::
wBreedingCompatibility::
wMoveGrammar::
wApplyStatLevelMultipliersToEnemy::
wUsePPUp::
wd265:: ; mobile
	db

wIsLearningTMHM:: db
wNumFleeAttempts:: db
wMonTriedToEvolve:: db

wTimeOfDay:: db


SECTION "Enemy Party", WRAMX

UNION ; 8 bytes.
wPokedexShowPointerAddr:: dw
wPokedexShowPointerBank:: db
	ds 3
wd271:: dw ; mobile

NEXTU ; 1 byte.
	ds 1

NEXTU ; 28 bytes.
; enemy party
wOTPartyData::
wOTPlayerName:: ds NAME_LENGTH
wOTPlayerID:: dw

wAllBattleParticipantsAfterVirusSpread_ListLength:: db
wAllBattleParticipantsAfterVirusSpread_ChronologicalList:: ds 6 ; This could be shortened to 3 bytes, but using 6 is easier, and the space would be wasted otherwise.

wOTPartyCount::   db
wOTPartySpecies:: ds PARTY_LENGTH
wOTPartyEnd::     db ; older code doesn't check PartyCount
ENDU

UNION
; ot party mons
wOTPartyMons::
	table_width PARTYMON_STRUCT_LENGTH, wOTPartyMons
wOTPartyMon1:: party_struct wOTPartyMon1
wOTPartyMon2:: party_struct wOTPartyMon2
wOTPartyMon3:: party_struct wOTPartyMon3
wOTPartyMon4:: party_struct wOTPartyMon4
wOTPartyMon5:: party_struct wOTPartyMon5
wOTPartyMon6:: party_struct wOTPartyMon6
	assert_table_length PARTY_LENGTH

wOTPartyMonOTs::
	table_width NAME_LENGTH, wOTPartyMonOTs
wOTPartyMon1OT:: ds NAME_LENGTH
wOTPartyMon2OT:: ds NAME_LENGTH
wOTPartyMon3OT:: ds NAME_LENGTH
wOTPartyMon4OT:: ds NAME_LENGTH
wOTPartyMon5OT:: ds NAME_LENGTH
wOTPartyMon6OT:: ds NAME_LENGTH
	assert_table_length PARTY_LENGTH

wOTPartyMonNicknames::
	table_width MON_NAME_LENGTH, wOTPartyMonNicknames
wOTPartyMon1Nickname:: ds MON_NAME_LENGTH
wOTPartyMon2Nickname:: ds MON_NAME_LENGTH
wOTPartyMon3Nickname:: ds MON_NAME_LENGTH
wOTPartyMon4Nickname:: ds MON_NAME_LENGTH
wOTPartyMon5Nickname:: ds MON_NAME_LENGTH
wOTPartyMon6Nickname:: ds MON_NAME_LENGTH
	assert_table_length PARTY_LENGTH
wOTPartyDataEnd::

NEXTU
; catch tutorial dude pack
wDudeNumItems:: db
wDudeItems:: ds 2 * 4 + 1

wDudeNumMeds::
wDudeNumBerries::
wDudeNumKeyItems:: db
wDudeKeyItems:: ds 18 + 1

wDudeNumBalls:: db
wDudeBalls:: ds 2 * 4 + 1

wShortageInCurrentMart:: db
ENDU

wd430:: ; mobile
wBattleAction:: db

wLinkBattleSentAction:: db
wMapStatus:: db
wMapEventStatus:: db

wScriptFlags::
; bit 3: priority jump
	db

wScriptFlags2::
; bit 0: count steps
; bit 1: coord events
; bit 2: warps and connections
; bit 4: wild encounters
; bit 5: unknown
	db

wScriptMode:: db
wScriptRunning:: db
wScriptBank:: db
wScriptPos:: dw

wScriptStackSize:: db
wScriptStack:: ds 3 * 5
wScriptDelay:: db

wPriorityScriptBank::
wScriptTextBank::
	db
wPriorityScriptAddr::
wScriptTextAddr::
	dw
wWildEncounterCooldown:: db

wXYComparePointer:: dw

wBattleScriptFlags:: db
wPlayerSpriteSetupFlags::
; bit 7: if set, cancel wPlayerAction
; bit 6: RefreshMapSprites doesn't reload player sprite
; bit 5: if set, set facing according to bits 0-1
; bit 2: female player has been transformed into male
; bits 0-1: direction facing
	db

wMapReentryScriptQueueFlag:: db
wMapReentryScriptBank:: db
wMapReentryScriptAddress:: dw

wTimeCyclesSinceLastCall:: db
wReceiveCallDelay_MinsRemaining:: db
wReceiveCallDelay_StartTime:: ds 3

wBugContestMinsRemaining:: db
wBugContestSecsRemaining:: db

wMapStatusEnd::

wCrystalData::
wPlayerGender::
; bit 0:
;	0 male
;	1 female
	db
wd473:: ds 1
wd474:: ds 1
wd475:: ds 1
wd476:: ds 1
wd477:: ds 1
wd478:: ds 1
wCrystalDataEnd::

wd479:: ds 2



;####################################################################################################################################################################
;####################################################################################################################################################################
;####################################################################################################################################################################
;####################################################################################################################################################################
wGameData::
wPlayerData::
wPlayerID:: dw

wPlayerName:: ds NAME_LENGTH
wRivalName::  ds NAME_LENGTH

	ds 4

wTravelViolationFine:: db ; The value multiplied by 100 is the fine paid by the player when using Fly or Teleport.

wMartsStock:: ds (NUM_MARTS + 1) / 2

wSavedAtLeastOnce:: db
wSpawnAfterChampion:: db

; init time set at newgame
wStartDay::    db
wStartHour::   db
wStartMinute:: db
wStartSecond:: db

wRTC:: ds 4

wDST::
; bit 7: dst
	db

wGameTime:: ; used only for BANK(wGameTime)
wGameTimeCap::     db
wGameTimeHours::   dw
wGameTimeMinutes:: db
wGameTimeSeconds:: db
wGameTimeFrames::  db

wHospitalVisitsToday:: flag_array MONS_PER_BOX ; 3 bytes, with the 4 upper bits unused.

wCurDay:: db

wObjectFollow_Leader:: db
wObjectFollow_Follower:: db
wCenteredObject:: db
wFollowerMovementQueueLength:: db
wFollowMovementQueue:: ds 5

wObjectStructs::
	table_width OBJECT_LENGTH, wObjectStructs
wPlayerStruct::   object_struct wPlayer
wObject1Struct::  object_struct wObject1
wObject2Struct::  object_struct wObject2
wObject3Struct::  object_struct wObject3
wObject4Struct::  object_struct wObject4
wObject5Struct::  object_struct wObject5
wObject6Struct::  object_struct wObject6
wObject7Struct::  object_struct wObject7
wObject8Struct::  object_struct wObject8
wObject9Struct::  object_struct wObject9
wObject10Struct:: object_struct wObject10
wObject11Struct:: object_struct wObject11
wObject12Struct:: object_struct wObject12
	assert_table_length NUM_OBJECT_STRUCTS

wCmdQueue:: ds CMDQUEUE_CAPACITY * CMDQUEUE_ENTRY_SIZE

wMapObjects::
	table_width MAPOBJECT_LENGTH, wMapObjects
wPlayerObject:: map_object wPlayer
wMap1Object::   map_object wMap1
wMap2Object::   map_object wMap2
wMap3Object::   map_object wMap3
wMap4Object::   map_object wMap4
wMap5Object::   map_object wMap5
wMap6Object::   map_object wMap6
wMap7Object::   map_object wMap7
wMap8Object::   map_object wMap8
wMap9Object::   map_object wMap9
wMap10Object::  map_object wMap10
wMap11Object::  map_object wMap11
wMap12Object::  map_object wMap12
wMap13Object::  map_object wMap13
wMap14Object::  map_object wMap14
wMap15Object::  map_object wMap15
wMap16Object::  map_object wMap16
wMap17Object::  map_object wMap17
wMap18Object::  map_object wMap18
wMap19Object::  map_object wMap19
wMap20Object::  map_object wMap20
wMap21Object::  map_object wMap21
wMap22Object::  map_object wMap22
wMap23Object::  map_object wMap23
wMap24Object::  map_object wMap24
wMap25Object::  map_object wMap25
wMap26Object::  map_object wMap26
wMap27Object::  map_object wMap27
wMap28Object::  map_object wMap28
wMap29Object::  map_object wMap29
wMap30Object::  map_object wMap30
	assert_table_length NUM_OBJECTS

wObjectMasks:: ds NUM_OBJECTS

wVariableSprites:: ds $100 - SPRITE_VARS

wEnteredMapFromContinue:: db
wTimeOfDayPal:: db

UNION ; My first union!
wTempColorMixer:: ds 6 ; Damien
NEXTU
wStatsSubmenuOpened:: db
wStatsSubmenuCursorIndex:: db
wStatsSubmenuCursorCoords:: dw
wStatsSwapMovesSourceCursorIndex:: db
	ds 1
ENDU

wTimeOfDayPalFlags:: db
wTimeOfDayPalset:: db
wCurTimeOfDay:: db

wMustRefreshPaletteNow:: db

wSecretID:: dw
wStatusFlags::
; bit 0: pokedex
; bit 1: unown dex
; bit 2: flash
; bit 3: caught pokerus
; bit 4: rocket signal
; bit 5: wild encounters on/off
; bit 6: hall of fame
; bit 7: bug contest on
	db

wStatusFlags2::
; bit 0: rockets
; bit 1: safari game (unused)
; bit 2: bug contest timer
; bit 3: trainer card possession
; bit 4: bike shop call
; bit 5: can use sweet scent
; bit 6: reached goldenrod
; bit 7: rockets in mahogany
	db

wMoney:: ds 3
wMomsMoney:: ds 3

wMomSavingMoney::
; bit 0: saving some money
; bit 1: saving half money (unused)
; bit 2: saving all money (unused)
; bit 7: active
	db

wCoins:: dw

wBadges::
wJohtoBadges:: flag_array NUM_JOHTO_BADGES
wKantoBadges:: flag_array NUM_KANTO_BADGES

wTMsHMs:: ds NUM_TMS + NUM_HMS

wNumItems:: db
wItems:: ds MAX_ITEMS * 2 + 1

wNumKeyItems:: db
wKeyItems:: ds MAX_KEY_ITEMS + 1

wNumBalls:: db
wBalls:: ds MAX_BALLS * 2 + 1

wNumMeds:: db
wMeds:: ds MAX_MEDS * 2 + 1

wNumBerries:: db
wBerries:: ds MAX_BERRIES * 2 + 1

wNumPCItems:: db ; à virer. To Remove. To delete.
wPCItems:: ds MAX_PC_ITEMS * 2 + 1 ; à virer. To Remove. To delete.

wPokegearFlags::
; bit 0: map
; bit 1: radio
; bit 2: phone
; bit 3: expn
; bit 7: on/off
	db
wRadioTuningKnob:: db
wLastDexMode:: db
wWhichRegisteredItem:: db
wRegisteredItem:: db

wPlayerState:: db


; map scene ids
; Damien's note: the following bytes are used to store the scene ID, or scene state of some maps.
; See "constants/scene_constants.asm".
; The scene ID can either be used to launch a scene script when entering a map, or to mask the coord events of the map.
; See "maps/*.asm"
; A lot of those maps are only using a scene ID to launch a scene script, which could be avoided if the engine called a default scene script for maps that do not use a scene ID.
; Also, 67 of the original 79 of those bytes are used to store a single bit, which is a lot of wasted WRAM.
; We could use flags instead of bytes for those. For example, the engine could differentiate scene IDs that are above a certain value, and read and write a single bit for scene IDs above this value.
; You can also notice that scenes with more than 2 scene IDs/states never go above 7 different values.
; So we could also squeeze 2 scenes per byte to save 6 more bytes in the WRAM.
; In total, by using 2 scenes per byte and flags, we could save 64 bytes of saved WRAM, not counting the use of a default scene script.
wPokecenter2FSceneID::                            db
wColosseumSceneID::                               db
wPowerPlantSceneID::                              db
wCeruleanGymSceneID::                             db
wRoute25SceneID::                                 db
wElmsLabSceneID::                                 db
	ds 1
wRoute35NationalParkGateSceneID::                 db
wRoute36SceneID::                                 db
wRoute36NationalParkGateSceneID::                 db
wAzaleaTownSceneID::                              db
wRoute42SceneID::                                 db
wCianwoodCitySceneID::                            db
wBattleTower1FSceneID::                           db
wBattleTowerBattleRoomSceneID::                   db
wBattleTowerElevatorSceneID::                     db
wBattleTowerHallwaySceneID::                      db
wMountMoonSceneID::                               db
wTinTower1FSceneID::                              db
wBurnedTower1FSceneID::                           db
	ds 1
wRadioTower5FSceneID::                            db
wRuinsOfAlphOutsideSceneID::                      db
wRuinsOfAlphResearchCenterSceneID::               db
wRuinsOfAlphHoOhChamberSceneID::                  db
wRuinsOfAlphKabutoChamberSceneID::                db
wRuinsOfAlphOmanyteChamberSceneID::               db
wRuinsOfAlphAerodactylChamberSceneID::            db
wRuinsOfAlphInnerChamberSceneID::                 db
wMahoganyMart1FSceneID::                          db
wTeamRocketBaseB1FSceneID::                       db
wTeamRocketBaseB2FSceneID::                       db
wTeamRocketBaseB3FSceneID::                       db
wGoldenrodUndergroundSwitchRoomEntrancesSceneID:: db
wVictoryRoadSceneID::                             db
wDragonsDenB1FSceneID::                           db
wDragonShrineSceneID::                            db
wOlivinePortSceneID::                             db
wVermilionPortSceneID::                           db
wFastShip1FSceneID::                              db
wFastShipB1FSceneID::                             db
wMountMoonSquareSceneID::                         db
wMobileTradeRoomSceneID::                         db
wMobileBattleRoomSceneID::                        db
wCharcoalKilnSceneID::							  db
wGoldenrodHospitalReceptionSceneID::			  db
wGoldenrodHospitalCorridorsAndRoomsSceneID::	  db
wVaccinationCenterSceneID::	  					  db

	ds 30

wJohtoAddLevel:: db
wKantoAddLevel:: db

; fight counts have all been removed by Damien (28 bytes spared) thanks to the tutorials.

wEventFlags:: flag_array NUM_EVENTS

wCurBox:: db

; 8 chars + $50
wBoxNames:: ds BOX_NAME_LENGTH * NUM_BOXES

wBikeFlags::
; bit 0: using strength
; bit 1: always on bike
; bit 2: downhill
	db

wCurMapSceneScriptPointer:: dw

wCurCaller:: dw
wCurMapWarpCount:: db
wCurMapWarpsPointer:: dw
wCurMapCoordEventCount:: db
wCurMapCoordEventsPointer:: dw
wCurMapBGEventCount:: db
wCurMapBGEventsPointer:: dw
wCurMapObjectEventCount:: db
wCurMapObjectEventsPointer:: dw
wCurMapSceneScriptCount:: db
wCurMapSceneScriptsPointer:: dw
wCurMapCallbackCount:: db
wCurMapCallbacksPointer:: dw

; Sprite id of each decoration
wDecoBed::           db
wDecoCarpet::        db
wDecoPlant::         db
wDecoPoster::        db
wDecoConsole::       db
wDecoLeftOrnament::  db
wDecoRightOrnament:: db
wDecoBigDoll::       db

; Items bought from Mom
wWhichMomItem:: db
	ds 1
wMomItemTriggerBalance:: ds 3

wDailyResetTimer:: dw
wDailyFlags1:: db
wDailyFlags2:: db
wDailyFlags3:: db
wSwarmFlags:: ds 2 ; Second byte could be used. It's only used by a mobile function.
wTimerEventStartDay:: db

wPrevWarp:: db ; Moved here by Damien, so it can be saved.
wPrevMapGroup:: db
wPrevMapNumber:: db

wFruitTreeFlags:: flag_array NUM_FRUIT_TREES * 2 ; Takes 9 bytes for the current $24 trees.

wLuckyNumberDayTimer:: dw
wLastPaletteTransitionMinute:: db ; Damien.
wSpecialPhoneCallID:: db
wMobileOrCable_LastSelection:: db
wdc41:: ds 1
wdc42:: ds 8
wBuenasPassword:: db
wBlueCardBalance:: db
wDailyRematchFlags:: ds 4
wDailyPhoneItemFlags:: ds 4
wDailyPhoneTimeOfDayFlags:: ds 4
wKenjiBreakTimer:: ds 2 ; Kenji
wYanmaMapGroup:: db
wYanmaMapNumber:: db
wPlayerMonSelection:: ds 3
wdc5f:: db
wdc60:: db

wActivePlaytimePoints:: db ; Used to quickly reset some daily events, so that hardcore players don't have to wait for several days until things happen.
wStepCount:: db
wPoisonStepCount:: db
wHappinessStepCount:: db
wHallOfFameCount:: db
wTradeFlags:: flag_array NUM_NPC_TRADES
wMooMooBerries:: db

; Map specific vars.
UNION ; 12 bytes.
wParkBallsRemaining::
wSafariBallsRemaining:: db
wSafariTimeRemaining:: dw
wBugContestStartTime:: ds 4 ; day, hour, min, sec
wUndergroundSwitchPositions:: db
wFarfetchdPosition:: db
wGoldenrodHospitalCorridorNumber:: db
wAvoidedControlCheckpoint:: db ; Goldenrod Dept Store - Vaccine Passport checks.

NEXTU ; 12 bytes.
wViridianVerticalWarpPair:: 	ds VIRIDIAN_VERTICAL_WARP_COUNT
wViridianHorizontalWarpPair:: 	ds VIRIDIAN_HORIZONTAL_WARP_COUNT

NEXTU ; Cerulean Cave.
wCeruleanCaveB3FStepCount:: db
wCeruleanCaveB3FMessageIndex:: db
wCeruleanCaveB3FTeleportIndex:: db

NEXTU ; Olivine City.
wOlivineCafeBerry1:: db
wOlivineCafeBerry2:: db
wOlivineCafeBerry3:: db

NEXTU
wSokobanPlacedStonesCount:: db ; Used in Seafoam Islands / Cinnabar Volcano.
wSokobanTargetsCount:: db
wSokobanTargetsXStart:: db
wSokobanTargetsXEnd:: db
wSokobanTargetsYStart:: db
wSokobanTargetsYEnd:: db
wSokobanSuccessScript:: dw

NEXTU
wRevivedFossil:: db	; Used in SilphCoResearch.asm.
wFossilItem:: db
wNewStarterSpecies:: db
wNewStarterMovesIndex:: db

NEXTU ; Power plant.
wPowerPlantMoveSFX:: db
wPowerPlantEarthquakeDuration:: db

NEXTU ; Tradeback Guy: either Earl's Academy/School, or his parents' house in Ecruteak.
wTradeGuyItemPayment:: db

NEXTU ; Sprout Tower, Dragons Den, Dragon Shrine, Olivine Lighthouse.
wFreedomStateWhenEntered:: db

NEXTU ; Move reminders.
wBuffer1:: db
ENDU

wPhoneList:: ds CONTACT_LIST_SIZE + 1

wLuckyNumberShowFlag:: db
wRepelType:: db
wLuckyIDNumber:: dw

wRepelEffect:: db ; If a Repel is in use, it contains the nr of steps it's still active
wBikeStep:: dw
wKurtApricornQuantity:: db

wPlayerDataEnd::

wCurMapData::

wVisitedSpawns:: flag_array NUM_SPAWNS

wDigWarpNumber:: db
wDigMapGroup::   db
wDigMapNumber::  db

; used on maps like second floor pokécenter, which are reused, so we know which
; map to return to
wBackupWarpNumber:: db
wBackupMapGroup::   db
wBackupMapNumber::  db

wLastSpawnMapGroup:: db
wLastSpawnMapNumber:: db

wWarpNumber:: db
wMapGroup:: db
wMapNumber:: db
wYCoord:: db
wXCoord:: db
wScreenSave:: ds SCREEN_META_WIDTH * SCREEN_META_HEIGHT

wCurMapDataEnd::


SECTION "Party", WRAMX

wPokemonData::

wPartyCount::   db
wPartySpecies:: ds PARTY_LENGTH
wPartyEnd::     db ; older code doesn't check wPartyCount

wPartyMons::
	table_width PARTYMON_STRUCT_LENGTH, wPartyMons
wPartyMon1:: party_struct wPartyMon1
wPartyMon2:: party_struct wPartyMon2
wPartyMon3:: party_struct wPartyMon3
wPartyMon4:: party_struct wPartyMon4
wPartyMon5:: party_struct wPartyMon5
wPartyMon6:: party_struct wPartyMon6
	assert_table_length PARTY_LENGTH

wPartyMonOTs::
	table_width NAME_LENGTH, wPartyMonOTs
wPartyMon1OT:: ds NAME_LENGTH
wPartyMon2OT:: ds NAME_LENGTH
wPartyMon3OT:: ds NAME_LENGTH
wPartyMon4OT:: ds NAME_LENGTH
wPartyMon5OT:: ds NAME_LENGTH
wPartyMon6OT:: ds NAME_LENGTH
	assert_table_length PARTY_LENGTH

wPartyMonNicknames::
	table_width MON_NAME_LENGTH, wPartyMonNicknames
wPartyMon1Nickname:: ds MON_NAME_LENGTH
wPartyMon2Nickname:: ds MON_NAME_LENGTH
wPartyMon3Nickname:: ds MON_NAME_LENGTH
wPartyMon4Nickname:: ds MON_NAME_LENGTH
wPartyMon5Nickname:: ds MON_NAME_LENGTH
wPartyMon6Nickname:: ds MON_NAME_LENGTH
	assert_table_length PARTY_LENGTH
wPartyMonNicknamesEnd::

wCurFreedomState:: db ; Represents the level of freedom (curfew, lockdown, freedom).
wWantedLevelPerLandmark:: ds NUM_LANDMARKS_QUARTER ; MUST BE 24. Can be increased to 25 by finding "ds 1" somewhere between wGameData and wGameDataEnd. Stores the research level for each landmark (2 bits per landmark).
wCurWantedLevel:: db

wPokedexCaught:: flag_array NUM_POKEMON
wEndPokedexCaught::

wPokedexSeen:: flag_array NUM_POKEMON
wEndPokedexSeen::

wUnownDex:: ds NUM_UNOWN
wUnlockedUnowns:: db
wFirstUnownSeen:: db

wDayCareMan::
; bit 7: active
; bit 6: egg ready
; bit 5: monsters are compatible
; bit 0: monster 1 in day-care
	db

wBreedMon1Nickname:: ds MON_NAME_LENGTH
wBreedMon1OT:: ds NAME_LENGTH
wBreedMon1:: box_struct wBreedMon1

wDayCareLady::
; bit 7: active
; bit 0: monster 2 in day-care
	db

wStepsToEgg::
	db
wBreedMotherOrNonDitto::
;  z: yes
; nz: no
	db

wBreedMon2Nickname:: ds MON_NAME_LENGTH
wBreedMon2OT:: ds NAME_LENGTH
wBreedMon2:: box_struct wBreedMon2

wEggMonNickname:: ds MON_NAME_LENGTH
wEggMonOT:: ds NAME_LENGTH
wEggMon:: box_struct wEggMon

wBugContestSecondPartySpecies:: db
wContestMon:: party_struct wContestMon

wDunsparceMapGroup:: db
wDunsparceMapNumber:: db
wFishingSwarmFlag:: db

wRoamMon1:: roam_struct wRoamMon1
wRoamMon2:: roam_struct wRoamMon2
wRoamMon3:: roam_struct wRoamMon3

wRoamMons_CurMapNumber:: db
wRoamMons_CurMapGroup:: db
wRoamMons_LastMapNumber:: db
wRoamMons_LastMapGroup:: db

wBestMagikarpLengthFeet:: db
wBestMagikarpLengthInches:: db
wMagikarpRecordHoldersName:: ds NAME_LENGTH

wWalkingAbuseGuard:: db ; Counts the number of steps since the last player "useful action", and disables some step counting features when the player walks too much.
wTradebackSuccessfulTradesCount:: db ; Number of trades with the tradeback guy.
	ds 13 ; Available saved memory. 

wPokemonDataEnd::
wGameDataEnd::
;####################################################################################################################################################################
;####################################################################################################################################################################
;####################################################################################################################################################################
;####################################################################################################################################################################


SECTION "Pic Animations", WRAMX

wTempTilemap::
; 20x18 grid of 8x8 tiles
	ds SCREEN_WIDTH * SCREEN_HEIGHT

; PokeAnim data
wPokeAnimStruct::
wPokeAnimSceneIndex:: db
wPokeAnimPointer:: dw
wPokeAnimSpecies:: db
wPokeAnimUnownLetter:: db
wPokeAnimSpeciesOrUnown:: db
wPokeAnimGraphicStartTile:: db
wPokeAnimCoord:: dw
wPokeAnimFrontpicHeight:: db
wPokeAnimIdleFlag:: db
wPokeAnimSpeed:: db
wPokeAnimPointerBank:: db
wPokeAnimPointerAddr:: dw
wPokeAnimFramesBank:: db
wPokeAnimFramesAddr:: dw
wPokeAnimBitmaskBank:: db
wPokeAnimBitmaskAddr:: dw
wPokeAnimFrame:: db
wPokeAnimJumptableIndex:: db
wPokeAnimRepeatTimer:: db
wPokeAnimCurBitmask:: db
wPokeAnimWaitCounter:: db
wPokeAnimCommand:: db
wPokeAnimParameter:: db
	ds 1
wPokeAnimBitmaskCurCol:: db
wPokeAnimBitmaskCurRow:: db
wPokeAnimBitmaskCurBit:: db
wPokeAnimBitmaskBuffer:: ds 7
	ds 2
wPokeAnimStructEnd::


SECTION "Battle Tower RAM", WRAMX

w3_d000:: ds 1
w3_d001:: ds 1
w3_d002:: ds 16
w3_d012:: ds $6e
w3_d080:: ds 1
w3_d081:: ds $f
w3_d090:: ds $70

w3_d100::
wBT_OTTrainer:: battle_tower_struct wBT_OT
	ds $1f
wMustResetWantedLevels:: db
wBT_TrainerTextIndex:: db
	ds 1
w3_d202:: battle_tower_struct w3_d202
w3_d2e2:: battle_tower_struct w3_d2e2
w3_d3c2:: battle_tower_struct w3_d3c2
w3_d4a2:: battle_tower_struct w3_d4a2
w3_d582:: battle_tower_struct w3_d582
w3_d662:: battle_tower_struct w3_d662

UNION
w3_d742:: battle_tower_struct w3_d742

NEXTU
	ds $be
w3_d800:: ds BG_MAP_WIDTH * SCREEN_HEIGHT

NEXTU
	ds $be
wBTChoiceOfLvlGroup:: db
	ds $1
w3_d802:: ds 12
w3_d80e:: db
	ds $1
w3_d810::
	ds $59
w3_d869:: ds $17
w3_d880:: ds 1
w3_d881:: ds 8
w3_d889:: ds 1
w3_d88a:: ds 4
w3_d88e:: ds 1
w3_d88f:: ds 4
w3_d893:: ds 1
w3_d894:: ds 1
w3_d895:: ds 11
w3_d8a0:: ds 1
w3_d8a1:: ds 1
w3_d8a2:: ds 1
w3_d8a3:: ds 1
ENDU

	ds $1c0


w3_dc00:: ds SCREEN_WIDTH * SCREEN_HEIGHT
UNION
w3_dd68:: ds SCREEN_WIDTH * SCREEN_HEIGHT

	ds $11c

w3_dfec:: ds $10
w3_dffc:: ds 4
NEXTU
	ds $98
w3_de00:: ds $200
ENDU


SECTION "GBC Video", WRAMX, ALIGN[8]
; LCD expects wLYOverrides to have an alignment of $100

; eight 4-color palettes each
wGBCPalettes:: ; used only for BANK(wGBCPalettes)
wBGPals1:: ds 8 palettes
wOBPals1:: ds 8 palettes
wBGPals2:: ds 8 palettes
wOBPals2:: ds 8 palettes

wLYOverrides:: ds SCREEN_HEIGHT_PX
wLYOverridesEnd::

wMagnetTrain:: ; used only for BANK(wMagnetTrain)
wMagnetTrainDirection:: db
wMagnetTrainInitPosition:: db
wMagnetTrainHoldPosition:: db
wMagnetTrainFinalPosition:: db
wMagnetTrainPlayerSpriteInitX:: db

	ds 11

wLYOverrides2:: ds SCREEN_HEIGHT_PX - 48
wLYOverridesBackup:: ds SCREEN_HEIGHT_PX - 96
wLYOverrides2End:: ds SCREEN_HEIGHT_PX - 48
wLYOverridesBackupEnd::

	ds 91
	
wAddressStorage:: dw ; Damien.

SECTION "Battle Animations", WRAMX

wBattleAnimTileDict::
; wBattleAnimTileDict pairs keys with values
; keys: ANIM_GFX_* indexes (taken from anim_*gfx arguments)
; values: vTiles0 offsets
	ds NUM_BATTLEANIMTILEDICT_ENTRIES * 2

wActiveAnimObjects::
	table_width BATTLEANIMSTRUCT_LENGTH, wActiveAnimObjects
wAnimObject01:: battle_anim_struct wAnimObject01
wAnimObject02:: battle_anim_struct wAnimObject02
wAnimObject03:: battle_anim_struct wAnimObject03
wAnimObject04:: battle_anim_struct wAnimObject04
wAnimObject05:: battle_anim_struct wAnimObject05
wAnimObject06:: battle_anim_struct wAnimObject06
wAnimObject07:: battle_anim_struct wAnimObject07
wAnimObject08:: battle_anim_struct wAnimObject08
wAnimObject09:: battle_anim_struct wAnimObject09
wAnimObject10:: battle_anim_struct wAnimObject10
	assert_table_length NUM_ANIM_OBJECTS

wActiveBGEffects::
	table_width BG_EFFECT_STRUCT_LENGTH, wActiveBGEffects
wBGEffect1:: battle_bg_effect wBGEffect1
wBGEffect2:: battle_bg_effect wBGEffect2
wBGEffect3:: battle_bg_effect wBGEffect3
wBGEffect4:: battle_bg_effect wBGEffect4
wBGEffect5:: battle_bg_effect wBGEffect5
	assert_table_length NUM_BG_EFFECTS

wLastAnimObjectIndex:: db

wBattleAnimFlags:: db
wBattleAnimAddress:: dw
wBattleAnimDelay:: db
wBattleAnimParent:: dw
wBattleAnimLoops:: db
wBattleAnimVar:: db
wBattleAnimByte:: db
wBattleAnimOAMPointerLo:: db

UNION
wBattleObjectTempID:: db
wBattleObjectTempXCoord:: db
wBattleObjectTempYCoord:: db
wBattleObjectTempParam:: db

NEXTU
wBattleBGEffectTempID:: db
wBattleBGEffectTempJumptableIndex:: db
wBattleBGEffectTempTurn:: db
wBattleBGEffectTempParam:: db

NEXTU
wBattleAnimTempOAMFlags:: db
wBattleAnimTempFixY:: db
wBattleAnimTempTileID:: db
wBattleAnimTempXCoord:: db
wBattleAnimTempYCoord:: db
wBattleAnimTempXOffset:: db
wBattleAnimTempYOffset:: db
wBattleAnimTempFrameOAMFlags:: db
wBattleAnimTempPalette:: db

NEXTU
wBattleAnimGFXTempTileID::
wBattleAnimGFXTempPicHeight:: db

NEXTU
wBattleSineWaveTempProgress:: db
wBattleSineWaveTempOffset:: db
wBattleSineWaveTempAmplitude:: db
wBattleSineWaveTempTimer:: db

NEXTU
wBattlePicResizeTempBaseTileID:: db
wBattlePicResizeTempPointer:: dw
ENDU

UNION
	ds 50
wBattleAnimEnd::

NEXTU
wSurfWaveBGEffect:: ds $40
wSurfWaveBGEffectEnd::
ENDU


SECTION "Mobile RAM", WRAMX

w5_d800:: ds $200
w5_da00:: ds $200
w5_dc00:: ds $d
w5_dc0d:: ds 4
w5_dc11:: ds 9
w5_MobileOpponentBattleMessages:: ds $c
w5_MobileOpponentBattleStartMessage:: ds $c
w5_MobileOpponentBattleWinMessage:: ds $c
w5_MobileOpponentBattleLossMessage:: ds $c


SECTION "Scratch RAM", WRAMX

UNION
wScratchTilemap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT
wScratchAttrmap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT

NEXTU
wDecompressScratch:: ds $100 tiles

NEXTU
; unidentified uses
w6_d000:: ds $1000
ENDU


SECTION "Stack RAM", WRAMX

wWindowStack:: ds $1000 - 1
wWindowStackBottom:: ds 1


INCLUDE "sram.asm"

INCLUDE "hram.asm"
