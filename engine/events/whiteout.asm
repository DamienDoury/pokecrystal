Script_BattleWhiteout::
	callasm BattleBGMap
	sjump Script_Whiteout

OverworldWhiteoutScript::
	refreshscreen
	callasm OverworldBGMap

Script_Whiteout:
	writetext .WhitedOutText
	callasm HalveMoney
	getmoney STRING_BUFFER_3, YOUR_MONEY ; Note: the value displayed has 50% of being wrong by 1, but whatever.

	readmem wTrainerClass
	ifequal 0, .wild
	ifequal OFFICER, .police

; regular trainer battle
	writetext .SurrendMoneyText
	sjump .defeat_type_displayed

.police
	writetext .FinedText
	sjump .defeat_type_displayed

.wild 
	writetext .LostMoneyText

.defeat_type_displayed
	waitbutton
	special FadeOutPalettes
	pause 40
	special HealParty
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .bug_contest
	callasm GetWhiteoutSpawn
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	newloadmap MAPSETUP_WARP
	endall

.bug_contest
	jumpstd BugContestResultsWarpScript


.WhitedOutText:
	text_far _WhitedOutText
	text_end

.FinedText:
	text_far _FinedText
	text_end

.LostMoneyText:
	text_far _LostMoneyText
	text_end

.SurrendMoneyText:
	text_far _SurrendMoneyText
	text_end

OverworldBGMap:
	call ClearPalettes
	call ClearScreen
	call WaitBGMap2
	call HideSprites
	jmp RotateThreePalettesLeft

BattleBGMap:
	ld b, SCGB_BATTLE_GRAYSCALE
	call GetSGBLayout
	jmp SetPalettes

HalveMoney:
	farcall StubbedTrainerRankings_WhiteOuts

; Halve the player's money.
	ld hl, wMoney
	ld a, [hl]
	srl a
	ld [hli], a
	ld a, [hl]
	rra
	ld [hli], a
	ld a, [hl]
	rra
	ld [hl], a
	ret

GetWhiteoutSpawn:
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	farcall IsSpawnPoint
	ld a, c
	jr c, .yes
	xor a ; SPAWN_HOME

.yes
	ld [wDefaultSpawnpoint], a
	ret
