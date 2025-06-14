add_stdscript: MACRO
\1StdScript::
	dba \1
ENDM

StdScripts::
	add_stdscript PokecenterNurseScript
	add_stdscript DifficultBookshelfScript
	add_stdscript PictureBookshelfScript
	add_stdscript MagazineBookshelfScript
	add_stdscript TeamRocketOathScript
	add_stdscript IncenseBurnerScript
	add_stdscript MerchandiseShelfScript
	add_stdscript TownMapScript
	add_stdscript WindowScript
	add_stdscript TVScript
	add_stdscript HomepageScript ; unused
	add_stdscript Radio1Script
	add_stdscript Radio2Script
	add_stdscript Radio3Script
	add_stdscript TrashCanScript
	add_stdscript StrengthBoulderScript
	add_stdscript SmashRockScript
	add_stdscript PokecenterSignScript
	add_stdscript MartSignScript
	add_stdscript GoldenrodRocketsScript
	add_stdscript RadioTowerRocketsScript
	add_stdscript ElevatorButtonScript
	add_stdscript DayToTextScript
	add_stdscript BugContestResultsWarpScript
	add_stdscript BugContestResultsScript
	add_stdscript InitializeEventsScript
	add_stdscript AskNumber1MScript
	add_stdscript AskNumber2MScript
	add_stdscript RegisteredNumberMScript
	add_stdscript NumberAcceptedMScript
	add_stdscript NumberDeclinedMScript
	add_stdscript PhoneFullMScript
	add_stdscript RematchMScript
	add_stdscript GiftMScript
	add_stdscript PackFullMScript
	add_stdscript RematchGiftMScript
	add_stdscript AskNumber1FScript
	add_stdscript AskNumber2FScript
	add_stdscript RegisteredNumberFScript
	add_stdscript NumberAcceptedFScript
	add_stdscript NumberDeclinedFScript
	add_stdscript PhoneFullFScript
	add_stdscript RematchFScript
	add_stdscript GiftFScript
	add_stdscript PackFullFScript
	add_stdscript RematchGiftFScript
	add_stdscript GymStatue1Script
	add_stdscript GymStatue2Script
	add_stdscript ReceiveItemScript
	add_stdscript ReceiveTogepiEggScript
	add_stdscript PCScript
	add_stdscript GameCornerCoinVendorScript
	add_stdscript HappinessCheckScript
	add_stdscript ClosedBusinessScript
	add_stdscript GymGuideWalksTowardsPlayerScript
	add_stdscript GymGuideChecksPlayersTeamScript
	add_stdscript GymGuideTextSequel
	add_stdscript GymGuidePlayerLeavesScript
	add_stdscript GymKickPlayerOutAfterEvolution
	add_stdscript LockdownCurfewClosedDoor
	add_stdscript VaccinePassCheckpoint
	add_stdscript IsVaccinePassportValid
	add_stdscript VaccinePassCheckpointCeladonGym

PokecenterNurseScript:
; EVENT_WELCOMED_TO_POKECOM_CENTER is never set

	opentext
	checktime MORN
	iftrue .morn
	checktime DAY
	iftrue .day
	checktime NITE
	iftrue .nite
	sjump .ok

.morn
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .morn_comcenter
	farwritetext NurseMornText
	promptbutton
	sjump .ok
.morn_comcenter
	farwritetext PokeComNurseMornText
	promptbutton
	sjump .ok

.day
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .day_comcenter
	farwritetext NurseDayText
	promptbutton
	sjump .ok
.day_comcenter
	farwritetext PokeComNurseDayText
	promptbutton
	sjump .ok

.nite
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .nite_comcenter
	farwritetext NurseNiteText
	promptbutton
	sjump .ok
.nite_comcenter
	farwritetext PokeComNurseNiteText
	promptbutton
	sjump .ok

.ok
	; only do this once
	clearevent EVENT_WELCOMED_TO_POKECOM_CENTER

	callasm HasPlayerClappedALotInThisRoom
	iffalse .check_pcr_presentation

	farwritetext Pokecenter1F_ThanksForSupport
	promptbutton

.check_pcr_presentation
	; We inform the player about PCR tests, once.
	readvar VAR_BADGES
	ifless 4, .pcr_presentation_skipped
	checkevent EVENT_PCR_TEST_PRESENTATION
	iftrue .pcr_presentation_skipped

	setevent EVENT_PCR_TEST_PRESENTATION
	farwritetext NursePCRArrivedText
	waitbutton
	closetext
	pause 5
	turnobject LAST_TALKED, UP
	pause 15
	turnobject LAST_TALKED, DOWN
	pause 5
	opentext

.pcr_presentation_skipped
	farwritetext NurseAskHealText
	yesorno
	iffalse .bye

	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .heal_start

	special GetPartyCountWithoutEggs
	getnum STRING_BUFFER_3
	farwritetext NurseAskTestText
	special PlaceMoneyTopRight
	yesorno

	loadmem wTempColorMixer, 0
	iffalse .skip_pcr_test

	special GetPartyCountWithoutEggs
	ifequal 1, .hundred1
	ifequal 2, .hundred2
	ifequal 3, .hundred3
	ifequal 4, .hundred4
	ifequal 5, .hundred5
	;.hundred6

	checkmoney YOUR_MONEY, 600
	ifequal HAVE_LESS, .notEnoughMoney
	takemoney YOUR_MONEY, 600
	sjump .paid

.hundred1
	checkmoney YOUR_MONEY, 100
	ifequal HAVE_LESS, .notEnoughMoney
	takemoney YOUR_MONEY, 100
	sjump .paid

.hundred2
	checkmoney YOUR_MONEY, 200
	ifequal HAVE_LESS, .notEnoughMoney
	takemoney YOUR_MONEY, 200
	sjump .paid

.hundred3
	checkmoney YOUR_MONEY, 300
	ifequal HAVE_LESS, .notEnoughMoney
	takemoney YOUR_MONEY, 300
	sjump .paid

.hundred4
	checkmoney YOUR_MONEY, 400
	ifequal HAVE_LESS, .notEnoughMoney
	takemoney YOUR_MONEY, 400
	sjump .paid

.hundred5
	checkmoney YOUR_MONEY, 500
	ifequal HAVE_LESS, .notEnoughMoney
	takemoney YOUR_MONEY, 500
	sjump .paid	

.paid
	loadmem wTempColorMixer, 2
	special PlaceMoneyTopRight
	playsound SFX_TRANSACTION
	pause 15
	farwritetext NurseThanksText
	promptbutton
	
	sjump .heal_start
	
.skip_pcr_test
	closetext
	opentext
	farwritetext NurseHealOnlyText
	promptbutton

.heal_start
	farwritetext NurseTakePokemonText
	promptbutton
	pause 10
	special StubbedTrainerRankings_Healings
	turnobject LAST_TALKED, LEFT
	closetext
	pause 10
	special HealParty
	playmusic MUSIC_NONE
	setval HEALMACHINE_POKECENTER
	special HealMachineAnim
	pause 30


	;checkphonecall ; elm already called about pokerus
	;iftrue .no
	;checkflag ENGINE_CAUGHT_POKERUS
	;iftrue .no

	; Check if there is at least 1 critically ill Pokémon, and take it out of the team before we check for Covid and illnesses.
	special SearchCriticallyIllMonInParty
	ifequal -1, .noCriticallyIllMonInParty

	; A severe form of COVID has been found!

	;showemote EMOTE_SAD, LAST_TALKED, 20
	opentext
	farwritetext NurseCriticallyIllText
	promptbutton

	ifequal 0, .criticallyIllMonDirections
	special GetItemNameFromIndex
	ifequal 1, .mailText1
	ifequal 2, .mailText2

	farwritetext NurseCriticallyIllMail3Text
	promptbutton
	sjump .criticallyIllMonDirections

.mailText1
	farwritetext NurseCriticallyIllMail1Text
	promptbutton
	sjump .criticallyIllMonDirections

.mailText2
	farwritetext NurseCriticallyIllMail2Text
	promptbutton

.criticallyIllMonDirections
	farwritetext NurseCriticallyIll2Text
	waitbutton
	closetext

	readmem wTempColorMixer
	addval 1
	writemem wTempColorMixer ; We add 1 to wTempColorMixer to indicate that we must change the text "All tests are negative" to "All other tests are negative".

.noCriticallyIllMonInParty
	special RestartMapMusic

	special GetPartyCountWithoutEggs
	ifequal 0, .skip_all_checks

	; Only check mildillness and pokerus if the player paid for it!
	readmem wTempColorMixer
	ifless 2, .skip_all_checks
	
	special CheckMildIllness
	iftrue .mildIllness
	special CheckPokerus
	iftrue .pokerus

	opentext
	readmem wTempColorMixer
	ifequal 3, .other_tests_negative
	farwritetext NurseTestsNegativeText
	sjump .end_other_tests_negative
.other_tests_negative
	farwritetext NurseOtherTestsNegativeText
.end_other_tests_negative
	waitbutton
	closetext

.skip_all_checks
	pause 10
	turnobject LAST_TALKED, DOWN
	pause 10
	opentext
	sjump .done

.mildIllness
	pause 20
	opentext
	farwritetext NurseMildIllnessText
	waitbutton
	closetext
	special CheckPokerus
	iftrue .pokerus

	pause 10
	turnobject LAST_TALKED, DOWN ; This code is a copy/paste from the code above. I should create a "function"
	pause 10
	opentext
	readmem wTempColorMixer
	ifequal 2, .tests_negative
	farwritetext NurseOtherTestsNegativeText
	sjump .end_tests_negative
.tests_negative
	farwritetext NurseTestsNegativeText
.end_tests_negative
	waitbutton
	sjump .done

.pokerus
	; already cleared earlier in the script
	;checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	;iftrue .pokerus_comcenter
	;closetext
	pause 20
	showemote EMOTE_SHOCK, LAST_TALKED, 20
	pause 20
	turnobject LAST_TALKED, DOWN
	pause 20
	opentext

	farwritetext NursePokerusReaction
	waitbutton

	checkflag ENGINE_CAUGHT_POKERUS
	iftrue .quick_pokerus_warning

	farwritetext NursePokerusLongTextStart
	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iftrue .skip_vaccination_talk
	promptbutton
	farwritetext NursePokerusRecommendsVaccinationText

.skip_vaccination_talk
	waitbutton

.quick_pokerus_warning
	farwritetext NursePokerusEssentialText
	waitbutton

	checkflag ENGINE_CAUGHT_POKERUS
	iftrue .pokerus_done

	farwritetext NursePokerusLongTextEnd
	waitbutton

.pokerus_done
	pause 20

	checkphonecall ; True if elm already called about pokerus ; Commented by Damien. To do: re-enable this line. The player will never get the phone call if he saves then reload before getting the call.
	checkflag ENGINE_CAUGHT_POKERUS
	iftrue .done
	setflag ENGINE_CAUGHT_POKERUS
	specialphonecall SPECIALCALL_POKERUS

.done
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .bye
	farwritetext NurseBallsDisinfectedText
	promptbutton
	sjump .bye

.notEnoughMoney
	farwritetext NurseNotEnoughMoneyText
	promptbutton
	closetext
	opentext

	callasm HasPlayerClappedALotInThisRoom_WithReset
	iffalse .bye

	farwritetext FreePCRTestAfterClappingText
	promptbutton
	loadmem wTempColorMixer, 2 ; Activates the PCR test.
	sjump .heal_start

.bye
	callasm ResetClapInThisRoom
	farwritetext NurseGoodbyeText
	turnobject LAST_TALKED, UP
	pause 15
	turnobject LAST_TALKED, DOWN
	pause 10 ; Damien

	waitbutton
	closetext ; Damien

	special GetPartyCountWithoutEggs
	ifgreater 0, .end

	; At this point, the Pokémon that was sent to the hospital was the last mon of the player.
	; Therefore, the player is left with no pkmn and can't play.
	; We give him one!

	pause 20
	showemote EMOTE_SHOCK, LAST_TALKED, 20
	pause 5
	opentext
	farwritetext NurseAbandonedMonText
	promptbutton

	farwritetext ManiaText_GotShuckle
	playsound SFX_KEY_ITEM
	waitsfx
	promptbutton

	checkevent EVENT_GOT_DAMIANS_CHARMANDER
	iftrue .CharmanderAlreadyGotten
	random 12
	sjump .Jumptable

.CharmanderAlreadyGotten:
	random 11

.Jumptable:
	ifless 6,  .zero
	ifequal 6,  .six
	ifequal 7,  .seven
	ifequal 8,  .eight
	ifequal 9,  .nine
	ifequal 10, .ten

	; Damian's Charmander.
	setevent EVENT_GOT_DAMIANS_CHARMANDER
	givepoke CHARMANDER, 7
	setval CHARMANDER
	writemem wTempByteValue
	givepokemail DamiansMail
	sjump .good_care

.zero
	givepoke RATTATA, 14
	sjump .good_care

.six
	givepoke ZUBAT, 13
	sjump .good_care

.seven
	givepoke KOFFING, 20
	sjump .good_care

.eight
	givepoke SENTRET, 14
	sjump .good_care

.nine
	givepoke PIDGEY, 16
	sjump .good_care

.ten
	givepoke MAGIKARP, 14

.good_care
	pause 5
	turnobject LAST_TALKED, UP
	pause 15
	turnobject LAST_TALKED, DOWN
	pause 5
	closetext
.end
	end

DamiansMail:
	db PORTRAITMAIL
if DEF(_FR_FR)
	db   "Je te récupére-"
	next "rai plus tard.@"
else
	db   "I'll come back"
	next "for you later.@"
endc

DifficultBookshelfScript:
	farjumptext DifficultBookshelfText

PictureBookshelfScript:
	farjumptext PictureBookshelfText

MagazineBookshelfScript:
	farjumptext MagazineBookshelfText

TeamRocketOathScript:
	farjumptext TeamRocketOathText

IncenseBurnerScript:
	farjumptext IncenseBurnerText

MerchandiseShelfScript:
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iftrue .MerchandisesGone
	farjumptext MerchandiseShelfText

.MerchandisesGone
	farjumptext MerchandiseGoneText

TownMapScript:
	opentext
	farwritetext LookTownMapText
	waitbutton
	special OverworldTownMap
	closetext
	end

WindowScript:
	callasm IsClappingAuthorizedScript
	iftrue .clapping

	farjumptext WindowText
.clapping
	farjumptext WindowClappingText

TVScript:
	farsjump TVShow

HomepageScript:
	farjumptext HomepageText

Radio1Script:
	opentext
	setval MAPRADIO_POKEMON_CHANNEL
.play
	special MapRadio
	closetext
	end

Radio2Script:
; Lucky Channel
	opentext
	setval MAPRADIO_LUCKY_CHANNEL
	sjump Radio1Script.play

Radio3Script:
; News Radio
	opentext
	setval MAPRADIO_NEWS_RADIO
	sjump Radio1Script.play

TrashCanScript:
	farjumptext TrashCanText

PCScript:
	opentext
	special PokemonCenterPC
	closetext
	end

ElevatorButtonScript:
	playsound SFX_READ_TEXT_2
	pause 15
	playsound SFX_ELEVATOR_END
	end

StrengthBoulderScript:
	farsjump AskStrengthScript

SmashRockScript:
	farsjump AskRockSmashScript

PokecenterSignScript:
	farjumptext PokecenterSignText

MartSignScript:
	farjumptext MartSignText

LockdownCurfewClosedDoor:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .curfew
	end

.lockdown
	farjumptext ClosedBusinessText
.curfew
	farjumptext ClosedBusinessCurfewText

DayToTextScript:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday
	getstring STRING_BUFFER_3, .SundayText
	end
.Monday:
	getstring STRING_BUFFER_3, .MondayText
	end
.Tuesday:
	getstring STRING_BUFFER_3, .TuesdayText
	end
.Wednesday:
	getstring STRING_BUFFER_3, .WednesdayText
	end
.Thursday:
	getstring STRING_BUFFER_3, .ThursdayText
	end
.Friday:
	getstring STRING_BUFFER_3, .FridayText
	end
.Saturday:
	getstring STRING_BUFFER_3, .SaturdayText
	end
if DEF(_FR_FR)
.SundayText:
	db "DIMANCHE@"
.MondayText:
	db "LUNDI@"
.TuesdayText:
	db "MARDI@"
.WednesdayText:
	db "MERCREDI@"
.ThursdayText:
	db "JEUDI@"
.FridayText:
	db "VENDREDI@"
.SaturdayText:
	db "SAMEDI@"
else
.SundayText:
	db "SUNDAY@"
.MondayText:
	db "MONDAY@"
.TuesdayText:
	db "TUESDAY@"
.WednesdayText:
	db "WEDNESDAY@"
.ThursdayText:
	db "THURSDAY@"
.FridayText:
	db "FRIDAY@"
.SaturdayText:
	db "SATURDAY@"
endc

GoldenrodRocketsScript:
	clearevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	end

RadioTowerRocketsScript:
	setflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_CIVILIANS
	setevent EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	clearevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	specialphonecall SPECIALCALL_WEIRDBROADCAST
	end

BugContestResultsWarpScript:
	special ClearBGPalettes
	scall BugContestResults_CopyContestantsToResults
	setevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	clearevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
	setevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	warp ROUTE_36_NATIONAL_PARK_GATE, 0, 4
	applymovement PLAYER, Movement_ContestResults_WalkAfterWarp

BugContestResultsScript:
	clearflag ENGINE_BUG_CONTEST_TIMER
	clearevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	clearevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	clearevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	clearevent EVENT_CONTEST_OFFICER_HAS_BERRY
	opentext
	farwritetext ContestResults_ReadyToJudgeText
	waitbutton
	special BugContestJudging
	getnum STRING_BUFFER_3
	ifequal 1, BugContestResults_FirstPlace
	ifequal 2, BugContestResults_SecondPlace
	ifequal 3, BugContestResults_ThirdPlace
	farwritetext ContestResults_ConsolationPrizeText
	promptbutton
	waitsfx
	verbosegiveitem BERRY
	iffalse BugContestResults_NoRoomForBerry

BugContestResults_DidNotWin:
	farwritetext ContestResults_DidNotWinText
	promptbutton
	sjump BugContestResults_FinishUp

BugContestResults_ReturnAfterWinnersPrize:
	farwritetext ContestResults_JoinUsNextTimeText
	promptbutton

BugContestResults_FinishUp:
	checkevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	iffalse BugContestResults_DidNotLeaveMons
	farwritetext ContestResults_ReturnPartyText
	waitbutton
	special ContestReturnMons
BugContestResults_DidNotLeaveMons:
	special CheckPartyFullAfterContest
	ifequal BUGCONTEST_CAUGHT_MON, BugContestResults_CleanUp
	ifequal BUGCONTEST_NO_CATCH, BugContestResults_CleanUp
	; BUGCONTEST_BOXED_MON
	farwritetext ContestResults_PartyFullText
	waitbutton
BugContestResults_CleanUp:
	closetext
	setscene SCENE_ROUTE36NATIONALPARKGATE_NOTHING
	setmapscene ROUTE_35_NATIONAL_PARK_GATE, SCENE_ROUTE35NATIONALPARKGATE_NOTHING
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setflag ENGINE_DAILY_BUG_CONTEST
	special PlayMapMusic
	end

BugContestResults_FirstPlace:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	getitemname STRING_BUFFER_4, SUN_STONE
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem SUN_STONE
	iffalse BugContestResults_NoRoomForSunStone
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_SecondPlace:
	getitemname STRING_BUFFER_4, EVERSTONE
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem EVERSTONE
	iffalse BugContestResults_NoRoomForEverstone
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_ThirdPlace:
	getitemname STRING_BUFFER_4, GOLD_BERRY
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem GOLD_BERRY
	iffalse BugContestResults_NoRoomForGoldBerry
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForSunStone:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForEverstone:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForGoldBerry:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	sjump BugContestResults_ReturnAfterWinnersPrize

BugContestResults_NoRoomForBerry:
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_BERRY
	sjump BugContestResults_DidNotWin

BugContestResults_CopyContestantsToResults:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .skip1
	clearevent EVENT_BUG_CATCHING_CONTESTANT_1B
.skip1
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .skip2
	clearevent EVENT_BUG_CATCHING_CONTESTANT_2B
.skip2
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .skip3
	clearevent EVENT_BUG_CATCHING_CONTESTANT_3B
.skip3
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .skip4
	clearevent EVENT_BUG_CATCHING_CONTESTANT_4B
.skip4
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .skip5
	clearevent EVENT_BUG_CATCHING_CONTESTANT_5B
.skip5
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .skip6
	clearevent EVENT_BUG_CATCHING_CONTESTANT_6B
.skip6
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .skip7
	clearevent EVENT_BUG_CATCHING_CONTESTANT_7B
.skip7
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .skip8
	clearevent EVENT_BUG_CATCHING_CONTESTANT_8B
.skip8
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .skip9
	clearevent EVENT_BUG_CATCHING_CONTESTANT_9B
.skip9
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .skip10
	clearevent EVENT_BUG_CATCHING_CONTESTANT_10B
.skip10
	end

InitializeEventsScript:
	setevent EVENT_EARLS_ACADEMY_EARL
	setevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	setevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setevent EVENT_RADIO_TOWER_CIVILIANS_AFTER
	setevent EVENT_ILEX_FOREST_APPRENTICE
	setevent EVENT_ILEX_FOREST_FARFETCHD
	setevent EVENT_ILEX_FOREST_CHARCOAL_MASTER
	setevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	setevent EVENT_RIVAL_TEAM_ROCKET_BASE
	setevent EVENT_BLACKTHORN_CITY_SUPER_NERD_DOES_NOT_BLOCK_GYM
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setevent EVENT_RIVAL_AZALEA_TOWN
	setevent EVENT_RIVAL_GOLDENROD_UNDERGROUND
	setevent EVENT_AZALEA_TOWN_SLOWPOKES
	setevent EVENT_KURTS_HOUSE_SLOWPOKE
	setevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	setevent EVENT_COP_IN_ELMS_LAB
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST
	setevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	setevent EVENT_BOULDER_IN_ICE_PATH_1A
	setevent EVENT_BOULDER_IN_ICE_PATH_2A
	setevent EVENT_BOULDER_IN_ICE_PATH_3A
	setevent EVENT_BOULDER_IN_ICE_PATH_4A
	setevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setevent EVENT_FAST_SHIP_1F_GENTLEMAN
	setevent EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	setevent EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	setevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_TIN_TOWER_ROOF_HO_OH
	setevent EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA
	setevent EVENT_PLAYERS_HOUSE_2F_CONSOLE
	setevent EVENT_PLAYERS_HOUSE_2F_DOLL_1
	setevent EVENT_PLAYERS_HOUSE_2F_DOLL_2
	setevent EVENT_PLAYERS_HOUSE_2F_BIG_DOLL
	setevent EVENT_DECO_BED_1
	setevent EVENT_DECO_POSTER_1
	setevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	setevent EVENT_OLIVINE_GYM_JASMINE
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	setevent EVENT_MET_BILL
	setevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	setevent EVENT_MYSTERY_GIFT_DELIVERY_GUY
	setevent EVENT_LAKE_OF_RAGE_LANCE
	setevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_1
	setevent EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_BLOCKED_OFF
	setevent EVENT_DRAGONS_DEN_CLAIR
	setevent EVENT_RIVAL_OLIVINE_CITY
	setevent EVENT_RIVAL_VICTORY_ROAD
	setevent EVENT_RIVAL_DRAGONS_DEN
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	setevent EVENT_BURNED_TOWER_B1F_BEASTS_1
	setevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	setevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	setevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	setevent EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	setevent EVENT_KURTS_HOUSE_KURT_2
	setevent EVENT_KURTS_HOUSE_GRANDDAUGHTER_2
	setevent EVENT_TINTOWER_SAGE_LEFT
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	setevent EVENT_GOLDENROD_CITY_MOVE_TUTOR
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	setevent EVENT_DRAGON_SHRINE_CLAIR
	setevent EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	setevent EVENT_PLAYERS_NEIGHBORS_HOUSE_NEIGHBOR
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_ILEX_FOREST_KURT
	setevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_ECRUTEAK_CITY_GRAMPS
	setevent EVENT_EUSINE_IN_BURNED_TOWER
	setevent EVENT_PLAYERS_HOUSE_MOM_2
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	setevent EVENT_CIANWOOD_CITY_EUSINE
	setevent EVENT_TIN_TOWER_1F_EUSINE
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	setevent EVENT_EUSINE_IN_CELADON
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	setevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setevent EVENT_GOLDENROD_BEATER
	setevent EVENT_RED_BEATEN
	setevent EVENT_REDS_PIKACHU_AVAILABLE
	setevent EVENT_LOCKDOWN_MART_RUSH
	setevent EVENT_NON_ESSENTIAL_BUILDING
	setevent GOLDENROD_BIKE_SHOP_CLOSED
	setflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setflag ENGINE_ROCKETS_IN_MAHOGANY
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_JANINE
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_LASS
	setevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	setevent EVENT_CERULEAN_GYM_ROCKET
	setevent EVENT_ROUTE_25_MISTY_BOYFRIEND
	setevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setevent EVENT_COPYCATS_HOUSE_2F_DOLL
	setevent EVENT_VIRIDIAN_GYM_BLUE
	setevent EVENT_SEAFOAM_GYM_GYM_GUIDE
	setevent EVENT_MT_MOON_SQUARE_CLEFAIRY
	setevent EVENT_TRAIN_STATION_POPULATION
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	setevent EVENT_INITIALIZED_EVENTS
	setevent EVENT_BROCK_BACK_IN_GYM
	setevent EVENT_CROWD_IN_VACCINATION_CENTER
	setevent EVENT_MART_CHERRYGROVE_MISSED
	setevent EVENT_MART_VIOLET_MISSED
	setevent EVENT_MART_AZALEA_MISSED
	setevent EVENT_WARDENS_NEIGHBOR_BOULDER_CLEARED
	setevent EVENT_WARDENS_NEIGHBOR_BACK_INTO_HOUSE
	setevent EVENT_SAFARI_PARK_EMPLOYEES
	setevent EVENT_VIRIDIAN_FOREST_GUY_SAVED
	setevent EVENT_BOULDER_IN_SEAFOAM_B2F_1
	setevent EVENT_BOULDER_IN_SEAFOAM_B2F_2
	setevent EVENT_BOULDER_IN_SEAFOAM_B3F_1
	setevent EVENT_BOULDER_IN_SEAFOAM_B3F_2
	setevent EVENT_BOULDER_IN_SEAFOAM_B6F_ALL
	setevent EVENT_JASMINE_AT_FUJIS
	setevent EVENT_TRAVEL_CONTROL
	setflag ENGINE_TRAINER_CARD
	setevent EVENT_CERULEAN_HOUSE_ROCKET
	setevent EVENT_ROCKET_THIEF_CERULEAN_CITY_GARDEN
	setevent EVENT_ROCKET_THIEF_ROUTE_4_SOUTH
	setevent EVENT_ROCKET_THIEF_ROUTE_4_NORTH
	endcallback

AskNumber1MScript:
	special RandomPhoneMon
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumber1Text
	end
.Huey:
	farwritetext HueyAskNumber1Text
	end
.Gaven:
	farwritetext GavenAskNumber1Text
	end
.Jose:
	farwritetext JoseAskNumber1Text
	end
.Joey:
	farwritetext JoeyAskNumber1Text
	end
.Wade:
	farwritetext WadeAskNumber1Text
	end
.Ralph:
	farwritetext RalphAskNumber1Text
	end
.Anthony:
	farwritetext AnthonyAskNumber1Text
	end
.Todd:
	farwritetext ToddAskNumber1Text
	end
.Irwin:
	farwritetext IrwinAskNumber1Text
	end
.Arnie:
	farwritetext ArnieAskNumber1Text
	end
.Alan:
	farwritetext AlanAskNumber1Text
	end
.Chad:
	farwritetext ChadAskNumber1Text
	end
.Derek:
	farwritetext DerekAskNumber1Text
	end
.Tully:
	farwritetext TullyAskNumber1Text
	end
.Brent:
	farwritetext BrentAskNumber1Text
	end
.Vance:
	farwritetext VanceAskNumber1Text
	end
.Wilton:
	farwritetext WiltonAskNumber1Text
	end
.Kenji:
	farwritetext KenjiAskNumber1Text
	end
.Parry:
	farwritetext ParryAskNumber1Text
	end

AskNumber2MScript:
	special RandomPhoneMon
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumber2Text
	end
.Huey:
	farwritetext HueyAskNumber2Text
	end
.Gaven:
	farwritetext GavenAskNumber2Text
	end
.Jose:
	farwritetext JoseAskNumber2Text
	end
.Joey:
	farwritetext JoeyAskNumber2Text
	end
.Wade:
	farwritetext WadeAskNumber2Text
	end
.Ralph:
	farwritetext RalphAskNumber2Text
	end
.Anthony:
	farwritetext AnthonyAskNumber2Text
	end
.Todd:
	farwritetext ToddAskNumber2Text
	end
.Irwin:
	farwritetext IrwinAskNumber2Text
	end
.Arnie:
	farwritetext ArnieAskNumber2Text
	end
.Alan:
	farwritetext AlanAskNumber2Text
	end
.Chad:
	farwritetext ChadAskNumber2Text
	end
.Derek:
	farwritetext DerekAskNumber2Text
	end
.Tully:
	farwritetext TullyAskNumber2Text
	end
.Brent:
	farwritetext BrentAskNumber2Text
	end
.Vance:
	farwritetext VanceAskNumber2Text
	end
.Wilton:
	farwritetext WiltonAskNumber2Text
	end
.Kenji:
	farwritetext KenjiAskNumber2Text
	end
.Parry:
	farwritetext ParryAskNumber2Text
	end

RegisteredNumberMScript:
	farwritetext RegisteredNumber1Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	end

NumberAcceptedMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberAcceptedText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyNumberAcceptedText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenNumberAcceptedText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JoseNumberAcceptedText
	waitbutton
	closetext
	end
.Joey:
	farwritetext JoeyNumberAcceptedText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadeNumberAcceptedText
	waitbutton
	closetext
	end
.Ralph:
	farwritetext RalphNumberAcceptedText
	waitbutton
	closetext
	end
.Anthony:
	farwritetext AnthonyNumberAcceptedText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddNumberAcceptedText
	waitbutton
	closetext
	end
.Irwin:
	farwritetext IrwinNumberAcceptedText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArnieNumberAcceptedText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanNumberAcceptedText
	waitbutton
	closetext
	end
.Chad:
	farwritetext ChadNumberAcceptedText
	waitbutton
	closetext
	end
.Derek:
	farwritetext DerekNumberAcceptedText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyNumberAcceptedText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentNumberAcceptedText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VanceNumberAcceptedText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonNumberAcceptedText
	waitbutton
	closetext
	end
.Kenji:
	farwritetext KenjiNumberAcceptedText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryNumberAcceptedText
	waitbutton
	closetext
	end

NumberDeclinedMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberDeclinedText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyNumberDeclinedText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenNumberDeclinedText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JoseNumberDeclinedText
	waitbutton
	closetext
	end
.Joey:
	farwritetext JoeyNumberDeclinedText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadeNumberDeclinedText
	waitbutton
	closetext
	end
.Ralph:
	farwritetext RalphNumberDeclinedText
	waitbutton
	closetext
	end
.Anthony:
	farwritetext AnthonyNumberDeclinedText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddNumberDeclinedText
	waitbutton
	closetext
	end
.Irwin:
	farwritetext IrwinNumberDeclinedText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArnieNumberDeclinedText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanNumberDeclinedText
	waitbutton
	closetext
	end
.Chad:
	farwritetext ChadNumberDeclinedText
	waitbutton
	closetext
	end
.Derek:
	farwritetext DerekNumberDeclinedText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyNumberDeclinedText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentNumberDeclinedText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VanceNumberDeclinedText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonNumberDeclinedText
	waitbutton
	closetext
	end
.Kenji:
	farwritetext KenjiNumberDeclinedText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryNumberDeclinedText
	waitbutton
	closetext
	end

PhoneFullMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackPhoneFullText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyPhoneFullText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenPhoneFullText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JosePhoneFullText
	waitbutton
	closetext
	end
.Joey:
	farwritetext JoeyPhoneFullText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadePhoneFullText
	waitbutton
	closetext
	end
.Ralph:
	farwritetext RalphPhoneFullText
	waitbutton
	closetext
	end
.Anthony:
	farwritetext AnthonyPhoneFullText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddPhoneFullText
	waitbutton
	closetext
	end
.Irwin:
	farwritetext IrwinPhoneFullText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArniePhoneFullText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanPhoneFullText
	waitbutton
	closetext
	end
.Chad:
	farwritetext ChadPhoneFullText
	waitbutton
	closetext
	end
.Derek:
	farwritetext DerekPhoneFullText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyPhoneFullText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentPhoneFullText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VancePhoneFullText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonPhoneFullText
	waitbutton
	closetext
	end
.Kenji:
	farwritetext KenjiPhoneFullText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryPhoneFullText
	waitbutton
	closetext
	end

RematchMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackRematchText
	waitbutton
	closetext
	end
.Huey:
	farwritetext HueyRematchText
	waitbutton
	closetext
	end
.Gaven:
	farwritetext GavenRematchText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JoseRematchText
	waitbutton
	closetext
	end
.Joey:
	farwritetext JoeyRematchText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadeRematchText
	waitbutton
	closetext
	end
.Ralph:
	farwritetext RalphRematchText
	waitbutton
	closetext
	end
.Anthony:
	farwritetext AnthonyRematchText
	waitbutton
	closetext
	end
.Todd:
	farwritetext ToddRematchText
	waitbutton
	closetext
	end
.Arnie:
	farwritetext ArnieRematchText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanRematchText
	waitbutton
	closetext
	end
.Chad:
	farwritetext ChadRematchText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyRematchText
	waitbutton
	closetext
	end
.Brent:
	farwritetext BrentRematchText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VanceRematchText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonRematchText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryRematchText
	waitbutton
	closetext
	end

GiftMScript:
	readvar VAR_CALLERID
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji

.Jose:
	farwritetext JoseGiftText
	promptbutton
	end
.Wade:
	farwritetext WadeGiftText
	promptbutton
	end
.Alan:
	farwritetext AlanGiftText
	promptbutton
	end
.Derek:
	farwritetext DerekGiftText
	promptbutton
	end
.Tully:
	farwritetext TullyGiftText
	promptbutton
	end
.Wilton:
	farwritetext WiltonGiftText
	promptbutton
	end
.Kenji:
	farwritetext KenjiGiftText
	promptbutton
	end

PackFullMScript:
	readvar VAR_CALLERID
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Huey:
	farwritetext HueyPackFullText
	waitbutton
	closetext
	end
.Jose:
	farwritetext JosePackFullText
	waitbutton
	closetext
	end
.Joey:
	farwritetext JoeyPackFullText
	waitbutton
	closetext
	end
.Wade:
	farwritetext WadePackFullText
	waitbutton
	closetext
	end
.Alan:
	farwritetext AlanPackFullText
	waitbutton
	closetext
	end
.Derek:
	farwritetext DerekPackFullText
	waitbutton
	closetext
	end
.Tully:
	farwritetext TullyPackFullText
	waitbutton
	closetext
	end
.Vance:
	farwritetext VancePackFullText
	waitbutton
	closetext
	end
.Wilton:
	farwritetext WiltonPackFullText
	waitbutton
	closetext
	end
.Kenji:
	farwritetext KenjiPackFullText
	waitbutton
	closetext
	end
.Parry:
	farwritetext ParryPackFullText
	waitbutton
	closetext
	end

RematchGiftMScript:
	opentext
	readvar VAR_CALLERID
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_HIKER_PARRY, .Parry

.Huey:
	farwritetext HueyRematchGiftText
	promptbutton
	end
.Joey:
	farwritetext JoeyRematchGiftText
	promptbutton
	end
.Vance:
	farwritetext VanceRematchGiftText
	promptbutton
	end
.Parry:
	farwritetext ParryRematchGiftText
	promptbutton
	end

AskNumber1FScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumber1Text
	end
.Beth:
	farwritetext BethAskNumber1Text
	end
.Reena:
	farwritetext ReenaAskNumber1Text
	end
.Liz:
	farwritetext LizAskNumber1Text
	end
.Gina:
	farwritetext GinaAskNumber1Text
	end
.Dana:
	farwritetext DanaAskNumber1Text
	end
.Tiffany:
	farwritetext TiffanyAskNumber1Text
	end
.Erin:
	farwritetext ErinAskNumber1Text
	end

AskNumber2FScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumber2Text
	end
.Beth:
	farwritetext BethAskNumber2Text
	end
.Reena:
	farwritetext ReenaAskNumber2Text
	end
.Liz:
	farwritetext LizAskNumber2Text
	end
.Gina:
	farwritetext GinaAskNumber2Text
	end
.Dana:
	farwritetext DanaAskNumber2Text
	end
.Tiffany:
	farwritetext TiffanyAskNumber2Text
	end
.Erin:
	farwritetext ErinAskNumber2Text
	end

RegisteredNumberFScript:
	farwritetext RegisteredNumber2Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	end

NumberAcceptedFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberAcceptedText
	waitbutton
	closetext
	end
.Beth:
	farwritetext BethNumberAcceptedText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaNumberAcceptedText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizNumberAcceptedText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaNumberAcceptedText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaNumberAcceptedText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyNumberAcceptedText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinNumberAcceptedText
	waitbutton
	closetext
	end

NumberDeclinedFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberDeclinedText
	waitbutton
	closetext
	end
.Beth:
	farwritetext BethNumberDeclinedText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaNumberDeclinedText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizNumberDeclinedText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaNumberDeclinedText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaNumberDeclinedText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyNumberDeclinedText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinNumberDeclinedText
	waitbutton
	closetext
	end

PhoneFullFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPhoneFullText
	waitbutton
	closetext
	end
.Beth:
	farwritetext BethPhoneFullText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaPhoneFullText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizPhoneFullText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaPhoneFullText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaPhoneFullText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyPhoneFullText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinPhoneFullText
	waitbutton
	closetext
	end

RematchFScript:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethRematchText
	waitbutton
	closetext
	end
.Reena:
	farwritetext ReenaRematchText
	waitbutton
	closetext
	end
.Liz:
	farwritetext LizRematchText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaRematchText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaRematchText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyRematchText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinRematchText
	waitbutton
	closetext
	end

GiftFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany

.Beverly:
	farwritetext BeverlyGiftText
	promptbutton
	end
.Gina:
	farwritetext GinaGiftText
	promptbutton
	end
.Dana:
	farwritetext DanaGiftText
	promptbutton
	end
.Tiffany:
	farwritetext TiffanyGiftText
	promptbutton
	end

PackFullFScript:
	readvar VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPackFullText
	waitbutton
	closetext
	end
.Gina:
	farwritetext GinaPackFullText
	waitbutton
	closetext
	end
.Dana:
	farwritetext DanaPackFullText
	waitbutton
	closetext
	end
.Tiffany:
	farwritetext TiffanyPackFullText
	waitbutton
	closetext
	end
.Erin:
	farwritetext ErinPackFullText
	waitbutton
	closetext
	end

RematchGiftFScript:
	readvar VAR_CALLERID
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Erin:
	opentext
	farwritetext ErinRematchGiftText
	promptbutton
	end

GymStatue1Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	promptbutton
	getchallengename
	farwritetext GymStatue_ChallengeGymText
	waitbutton
	closetext
	end

GymStatue2Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	promptbutton
	getchallengename
	farwritetext GymStatue_ChallengeGymText
	promptbutton
	farwritetext GymStatue_WinningTrainersText
	waitbutton
	closetext
	end

ReceiveItemScript:
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_ITEM
	waitsfx
	end

ReceiveTogepiEggScript:
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_GET_EGG
	waitsfx
	end

GameCornerCoinVendorScript:
	faceplayer
	opentext
	farwritetext CoinVendor_WelcomeText
	promptbutton
	checkitem COIN_CASE
	iftrue CoinVendor_IntroScript
	farwritetext CoinVendor_NoCoinCaseText
	waitbutton
	closetext
	end

CoinVendor_IntroScript:
	farwritetext CoinVendor_IntroText

.loop
	special DisplayMoneyAndCoinBalance
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Buy50
	ifequal 2, .Buy500
	sjump .Cancel

.Buy50:
	checkcoins MAX_COINS - 50
	ifequal HAVE_MORE, .CoinCaseFull
	checkmoney YOUR_MONEY, 1000
	ifequal HAVE_LESS, .NotEnoughMoney
	givecoins 50
	takemoney YOUR_MONEY, 1000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy50CoinsText
	waitbutton
	sjump .loop

.Buy500:
	checkcoins MAX_COINS - 500
	ifequal HAVE_MORE, .CoinCaseFull
	checkmoney YOUR_MONEY, 10000
	ifequal HAVE_LESS, .NotEnoughMoney
	givecoins 500
	takemoney YOUR_MONEY, 10000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy500CoinsText
	waitbutton
	sjump .loop

.NotEnoughMoney:
	farwritetext CoinVendor_NotEnoughMoneyText
	waitbutton
	closetext
	end

.CoinCaseFull:
	farwritetext CoinVendor_CoinCaseFullText
	waitbutton
	closetext
	end

.Cancel:
	farwritetext CoinVendor_CancelText
	waitbutton
	closetext
	end

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 4, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
if DEF(_FR_FR)
	db " 50 :  1000¥@"
	db "500 : 10000¥@"
	db "RETOUR@"
else
	db " 50 :  ¥1000@"
	db "500 : ¥10000@"
	db "CANCEL@"
endc

HappinessCheckScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	ifless 50, .Unhappy
	ifless 150, .KindaHappy
	farwritetext HappinessText3
	waitbutton
	closetext
	end

.KindaHappy:
	farwritetext HappinessText2
	waitbutton
	closetext
	end

.Unhappy:
	farwritetext HappinessText1
	waitbutton
	closetext
	end

Movement_ContestResults_WalkAfterWarp:
	step RIGHT
	step DOWN
	turn_head UP
	step_end

ClosedBusinessScript:
	farjumptext ClosedBusinessText

GymGuideWalksTowardsPlayerScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .continue
	end

.continue
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	pause 10

	readvar VAR_MAPGROUP
	ifequal GROUP_CIANWOOD_CITY, .cian

	showemote EMOTE_SHOCK, LAST_TALKED, 15
	applymovementlasttalked Movement_GymGuideStopsPlayers
	end

.cian 
	applymovementlasttalked Movement_CianwoodGymGuide
	end

GymGuideChecksPlayersTeamScript:
	readvar VAR_MAPGROUP
	ifequal GROUP_CIANWOOD_CITY, .cian
	
	opentext
	readvar VAR_MAPGROUP
	ifequal GROUP_VIOLET_CITY, .violet
	ifequal GROUP_AZALEA_TOWN, .aza
	ifequal GROUP_GOLDENROD_CITY, .gold
	ifequal GROUP_ECRUTEAK_CITY, .ecru
	ifequal GROUP_OLIVINE_CITY, .oliv
	ifequal GROUP_MAHOGANY_TOWN, .maho
	ifequal GROUP_BLACKTHORN_CITY, .black

	ifequal GROUP_PEWTER_CITY, .pew
	ifequal GROUP_CERULEAN_CITY, .ceru
	ifequal GROUP_VERMILION_CITY, .vermi
	ifequal GROUP_CELADON_CITY, .cela
	ifequal GROUP_FUCHSIA_CITY, .fuch
	ifequal GROUP_SAFFRON_CITY, .saff
	ifequal GROUP_CINNABAR_ISLAND, .cinna
	; Viridian City
	farwritetext GGTCViriText ; GGTC stands for Gym Guide Team Check.
	sjump GymGuideTextSequel

.violet
	farwritetext GGTCVioletText
	sjump GymGuideTextSequel

.aza
	farwritetext GGTCAzaText
	sjump GymGuideTextSequel

.gold
	farwritetext GGTCGoldText
	sjump GymGuideTextSequel

.ecru
	farwritetext GGTCEcruText
	sjump GymGuideTextSequel

.cian
	opentext
	farwritetext GGTCCianText
	waitbutton
	closetext
	;applymovement PLAYER, Movement_PlayerLeavesBuilding
	;special FadeOutPalettes
	;playsound SFX_ENTER_DOOR
	;waitsfx
	end

.oliv
	farwritetext GGTCOlivText
	sjump GymGuideTextSequel

.maho
	farwritetext GGTCMahoText
	sjump GymGuideTextSequel

.black
	farwritetext GGTCBlackText
	sjump GymGuideTextSequel

.pew
	farwritetext GGTCPewText 
	sjump GymGuideTextSequel

.ceru
	farwritetext GGTCCeruText
	sjump GymGuideTextSequel

.vermi
	farwritetext GGTCVermiText
	sjump GymGuideTextSequel

.cela
	farwritetext GGTCCelaText
	sjump GymGuideTextSequel

.fuch
	farwritetext GGTCFuchText
	sjump GymGuideTextSequel

.saff
	farwritetext GGTCSaffText
	sjump GymGuideTextSequel

.cinna
	farwritetext GGTCCinnaText

GymGuideTextSequel:
	promptbutton
	farwritetext GymGuideRefusesEntranceEndText
	waitbutton
	closetext
	end

GymGuidePlayerLeavesScript:
	applymovement PLAYER, Movement_PlayerLeavesBuilding
	special FadeOutPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	end

GymKickPlayerOutAfterEvolution:
	playsound SFX_ELEVATOR_END
	waitsfx 
	opentext
	farwritetext GymKickPlayerOutAfterEvolutionText
	promptbutton
	closetext
	callasm ClearJoypad
	end

Movement_GymGuideStopsPlayers:
	step DOWN
	step LEFT
	step LEFT
	step UP
	step LEFT
	turn_head DOWN
	step_end

Movement_CianwoodGymGuide:
	step LEFT
	step DOWN
	step_end

Movement_PlayerLeavesBuilding:
	turn_head DOWN
	step_end

IsVaccinePassportValid::
	readmem wCurFreedomState
	ifnotequal 1 << VACCINE_PASSPORT, .yes
	
	checkflag ENGINE_TRAINER_CARD
	iffalse .no_trainer_card

	checkevent EVENT_GOT_FAKE_ID
	iftrue .skip_real_first_shot_check

	checkevent EVENT_PLAYER_VACCINATED_ONCE
	iffalse .not_vaccinated

.skip_real_first_shot_check
	checkevent EVENT_SECOND_SHOT_REQUIRED
	iffalse .yes

	checkevent EVENT_PLAYER_VACCINATED_TWICE
	iffalse .no_booster

.yes
	setval 0
	end

.no_trainer_card
	setval 1
	end

.not_vaccinated
	setval 2
	end

.no_booster
	setval 3
	end

VaccinePassCheckpointCeladonGym:
	setlasttalked 3
	scall GymGuideWalksTowardsPlayerScript
	sjump VaccinePassCheckpoint.ScanVaccinePassport

VaccinePassCheckpoint:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	iffalse .check_passport
.end
	end

.check_passport:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7

	readmem wCurFreedomState
	ifnotequal 1 << VACCINE_PASSPORT, .end

	prioritysjump .ScanVaccinePassport
	end

.ScanVaccinePassport:
	faceobject 3, PLAYER ; Vaccine Passport Controller NPC must always be at the 2nd slot in the object_events list.

	pause 3
	playsound SFX_STOP_SLOT
	pause 10

	scall IsVaccinePassportValid
	ifequal 0, .end

	; No vaccine passport.
	waitsfx
	pause 3
	playsound SFX_WRONG
	waitsfx
	pause 5
	showemote EMOTE_SHOCK, 3, 20
	pause 3
	faceobject PLAYER, 3
	opentext

	scall IsVaccinePassportValid
	ifequal 3, .BoosterRequired

	writetext .NoVaccinePassText
	sjump .CutsceneEnd

.BoosterRequired:
	writetext .BoosterRequiredText

.CutsceneEnd:
	waitbutton
	closetext

	turnobject PLAYER, DOWN
	pause 7
	farsjump PlayerMovesDownThroughDoor

.NoVaccinePassText:
if DEF(_FR_FR)
	text "Mon scanner ne"
	line "détecte pas le"
	cont "PASS VACCINAL sur"
	cont "ta CARTE DRESSEUR."

	para "Peux-tu me"
	line "le montrer?"

	para "Non? Alors tu"
	line "ne peux pas"
	cont "entrer, désolé."
	done
else
	text "My scanner doesn't"
	line "detect the VACCINE"
	cont "PASSPORT on your"
	cont "TRAINER CARD."

	para "Could you please"
	line "show it to me?"

	para "No? Then you can't"
	line "come in, sorry."
	done
endc

.BoosterRequiredText:
if DEF(_FR_FR)
	text "Ta CARTE DRESSEUR"
	line "indique que tu"
	cont "n'as reçu qu'un"
	cont "seul vaccin."

	para "Une dose de rappel"
	line "est désormais"
	cont "requise pour que"
	cont "ton PASS VACCINAL"
	cont "soit valide."

	para "Je ne peux pas"
	line "te laisser entrer"
	cont "sans cela."
	done
else
	text "Your TRAINER CARD"
	line "indicates you were"
	cont "vaccinated only"
	cont "once."

	para "A booster shot is"
	line "now required for"
	cont "the VACCINE PASS-"
	cont "PORT to be valid."

	para "I can't let you"
	line "enter without it."
	done
endc
		