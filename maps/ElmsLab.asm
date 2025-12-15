	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER

ElmsLab_MapScripts:
	def_scene_scripts
	scene_script .MeetElm ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_ELMSLAB_CANT_LEAVE
	scene_script .DummyScene2 ; SCENE_ELMSLAB_NOTHING
	scene_script .DummyScene3 ; SCENE_ELMSLAB_MEET_OFFICER
	scene_script .DummyScene4 ; SCENE_ELMSLAB_READ_BOOKSHELVES

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .MoveElmCallback

.MeetElm:
	prioritysjump .WalkUpToElm

.DummyScene1:
.DummyScene2:
.DummyScene3:
.DummyScene4:
	end

.MoveElmCallback:
	checkscene
	iftrue .Skip ; not SCENE_DEFAULT
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	endcallback

.WalkUpToElm:
	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	opentext
	writetext ElmText_Intro
.MustSayYes:
	yesorno
	iftrue .ElmGetsEmail
	writetext ElmText_Insist
	yesorno
	iffalse .ElmGetsEmail
	writetext ElmText_AllRighty
	loadmem wCreditsType, CREDITS_LAB
	credits

.ElmGetsEmail:
	writetext ElmText_Accepted
	promptbutton
	writetext ElmText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext ElmText_GotAnEmail
	waitbutton
	closetext
	opentext
	turnobject ELMSLAB_ELM, RIGHT
	writetext ElmText_MissionFromMrPokemon
	waitbutton
	closetext
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement1
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement2
	turnobject PLAYER, RIGHT
	opentext
	writetext ElmText_ChooseAPokemon
	setscene SCENE_ELMSLAB_CANT_LEAVE
	sjump ElmsLab_EndText

ProfElmScript:
	faceplayer
	opentext
	
	checkevent EVENT_RED_BEATEN
	iftrue ElmRedNotBeaten ; Inversed flag: EVENT_RED_BEATEN is false when Red has been beaten.

	checkevent EVENT_ELM_MISSION_COMPLETE_SPEECH
	iffalse ElmFinalSpeech

	checkevent EVENT_REDS_PIKACHU_AVAILABLE
	iffalse ElmPikachu

	; Final Elm text.
	writetext ElmFinalText
	promptbutton
	writetext ElmFinalText2
	sjump ElmsLab_EndText

ElmRedNotBeaten:
	checkevent EVENT_ELM_ENCOURAGED_TO_GET_VACCINATED
	iftrue ElmCheckWorkVisa

	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue ElmEncouragesPlayerToGetVaccinatedScript

ElmCheckWorkVisa:
	checkevent EVENT_GOT_WORK_VISA_FROM_ELM
	iftrue ElmBeforeWorkVisa

	readvar VAR_BADGES
	ifgreater 7, ElmGiveWorkVisaScript

ElmBeforeWorkVisa:
	checkevent EVENT_LOCKDOWN_MART_RUSH
	iffalse ElmMartRush

	readmem wCurFreedomState
	ifequal 1 << VACCINE_PASSPORT, ElmVaccinePassport

	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse ElmBeforeFirstLockdown

	checkevent EVENT_FIRST_CURFEW_STARTED
	iffalse ElmBeforeFirstCurfew

	readmem wCurFreedomState
	ifnotequal 1 << FREE, ElmBeforeFirstCurfew

	writetext ElmCurfewDayVisitText
	sjump ElmsLab_EndText

ElmBeforeFirstCurfew:
	readmem wCurFreedomState
	ifequal 1 << CURFEW, ElmIllegalToBeHere
	ifequal 1 << LOCKDOWN, ElmIllegalToBeHere

ElmBeforeFirstLockdown:
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue ElmFindPatientZeroScript

	checkevent EVENT_GOT_COVID_SAMPLE_FROM_MR_POKEMON
	iftrue ElmAfterTheftScript

	writetext ElmDescribesMrPokemonText
	sjump ElmsLab_EndText

ElmMartRush:
	writetext ElmLockdownAnnouncementText
	sjump ElmsLab_EndText

ElmIllegalToBeHere:
	showemote EMOTE_QUESTION, ELMSLAB_ELM, 15
	pause 2
	writetext ElmLockdownCurfewVisitText
	sjump ElmsLab_EndText

ElmVaccinePassport:
	writetext ElmVaccinePassportText
	sjump ElmsLab_EndText

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
	applymovement PLAYER, ElmsLab_CantLeaveMovement
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, CYNDAQUIL
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CYNDAQUIL, 5, BERRY
	closetext
	readvar VAR_FACING
	ifequal RIGHT, .AfterCyndaquilFromTheLeft
	applymovement PLAYER, AfterCyndaquilMovement
	sjump ElmDirectionsScript

.AfterCyndaquilFromTheLeft:
	applymovement PLAYER, AfterCyndaquilDownMovement
	sjump ElmDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, TOTODILE
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke TOTODILE, 5, BERRY
	closetext
	applymovement PLAYER, AfterTotodileMovement
	sjump ElmDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, CHIKORITA
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CHIKORITA, 5, BERRY
	closetext
	applymovement PLAYER, AfterChikoritaMovement
	sjump ElmDirectionsScript

DidntChooseStarterScript:
	writetext DidntChooseStarterText
	sjump ElmsLab_EndText

ElmDirectionsScript:
	turnobject PLAYER, UP
	opentext
	writetext ElmDirectionsText1
	waitbutton
	closetext
	addcellnum PHONE_ELM
	opentext
	writetext GotElmsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetext ElmDirectionsText2
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext ElmDirectionsText3
	waitbutton
	closetext
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene SCENE_ELMSLAB_READ_BOOKSHELVES
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Activates some coord_events.
	end	

LookAtElmPokeBallScript:
	opentext
	writetext ElmPokeBallText
	sjump ElmsLab_EndText

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal

	writetext ElmsLabHealingMachineText1
	sjump ElmsLab_EndText

.CanHeal:
	checkevent EVENT_GOT_HAND_SANITIZER
	iffalse .HandsAreClean

	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleHandWash

	farwritetext _PlayersPCSanitizerText
	sjump .CleaningSound

.FemaleHandWash:
	farwritetext _PlayersPCSanitizerFemaleText

.CleaningSound:
	waitsfx
	playsound SFX_2_BOOPS
	waitsfx
	pause 10

.HandsAreClean:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	closetext
	end

ElmsLabHealingMachine_HealParty:
	special StubbedTrainerRankings_Healings
	special HealParty
	playmusic MUSIC_NONE
	setval HEALMACHINE_ELMS_LAB
	special HealMachineAnim
	pause 30
	special RestartMapMusic
	closetext
	end

ElmAfterTheftScript:
	writetext ElmAfterTheftText1
	checkitem MYSTERY_EGG
	iffalse ElmsLab_EndText
	promptbutton
	writetext ElmAfterTheftText2
	waitbutton
	takeitem MYSTERY_EGG
	scall ElmJumpBackScript1
	writetext ElmAfterTheftText3
	waitbutton
	scall ElmJumpBackScript2
	writetext ElmAfterTheftText4
	promptbutton
	writetext ElmAfterTheftText5
	waitbutton
	pause 3
	turnobject ELMSLAB_ELM, RIGHT
	pause 3
	writetext ElmIsItOfficialText
	promptbutton
	pause 3
	turnobject ELMSLAB_ELM, DOWN
	pause 3
	writetext ElmListenRadioText
	promptbutton
	closetext
	applymovement ELMSLAB_ELM, ElmRunsTowardsPCMovement
	turnobject PLAYER, LEFT
	musicfadeout MUSIC_NONE, 8
	opentext 
	writetext ElmCovidAnnouncementText
	waitbutton
	closetext
	musicfadeout MUSIC_PROF_ELM, 8
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	opentext
	writetext ElmWorksWithOakText
	waitbutton
	closetext
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement1
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement2
	opentext
	setevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	setflag ENGINE_MAIN_MENU_MOBILE_CHOICES
	setevent EVENT_CATCHING_TUTORIAL_AVAILABLE
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	setscene SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Activates some coord_events.
	writetext ElmAfterTheftText6
	yesorno
	iftrue .ElmMissionAccepted
.InsistALot:
	writetext ElmInsistOnGettingHelpText
	yesorno
	iffalse .InsistALot

.ElmMissionAccepted:
	writetext ElmMissionAcceptedText
	sjump ElmsLab_EndText

ElmFindPatientZeroScript:
	writetext ElmFindPatientZeroText
	sjump ElmsLab_EndText

ElmGiveWorkVisaScript:
	writetext ElmGiveWorkVisaText1
	promptbutton
	verbosegiveitem WORK_VISA
	iffalse .notdone
	setevent EVENT_GOT_WORK_VISA_FROM_ELM
	writetext ElmGiveWorkVisaText2
	waitbutton
.notdone
	closetext
	end

ElmEncouragesPlayerToGetVaccinatedScript:
	checkevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	iftrue ElmCheckWorkVisa ; We're going back.

	writetext ElmGiveVaccineText1
	promptbutton
	closetext

	pause 3
	applymovement ELMSLAB_ELM, ElmsLab_SlowStepUpMovement
	applymovement PLAYER, ElmsLab_HeadUpMovement
	pause 3
	opentext
	writetext ElmGiveVaccineText2
	promptbutton
	closetext

	
	applymovement ELMSLAB_ELM, ElmsLab_SlowStepDownMovement
	pause 3
	faceplayer
	pause 3
	faceobject PLAYER, ELMSLAB_ELM
	opentext
	writetext ElmGiveVaccineText3
	promptbutton

	applymovement ELMSLAB_ELM, ElmsLab_HeadUpMovement
	writetext ElmGiveVaccineText4
	promptbutton

	faceobject ELMSLAB_ELM, PLAYER
	writetext ElmGiveVaccineText5
	setevent EVENT_ELM_ENCOURAGED_TO_GET_VACCINATED
	setevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
ElmsLab_EndText:
	waitbutton
	closetext
	end

ElmFinalSpeech:
	setevent EVENT_ELM_MISSION_COMPLETE_SPEECH
	writetext ElmFoundPatientZeroText1
	promptbutton
	closetext 

	readvar VAR_XCOORD
	ifless 4, .playerWalksDown

; player walks left
	applymovement PLAYER, AfterTotodileMovement
	sjump .elmSitsOnTable

.playerWalksDown:
	applymovement PLAYER, ElmsLab_StepDownTwiceThenHeadUp

.elmSitsOnTable:
	applymovement ELMSLAB_ELM, ElmsLab_StepLeftTwiceThenHeadDown
	moveobject ELMSLAB_ELM, 3, 2

	opentext
	writetext ElmFoundPatientZeroText2
	promptbutton

	pause 30

	checkevent EVENT_REDS_PIKACHU_AVAILABLE
	iftrue .SkipComfortOak

	writetext ElmComfortOakText
	promptbutton

.SkipComfortOak
	writetext ElmFoundPatientZeroText3
	waitbutton
	playsound SFX_GET_BADGE
	waitsfx
	pause 10
	closetext
	end

ElmPikachu:
	writetext ElmComfortOakText
	sjump ElmsLab_EndText
	
ElmJumpBackScript1:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpDownScript
	ifequal UP, ElmJumpUpScript
	ifequal LEFT, ElmJumpLeftScript
	ifequal RIGHT, ElmJumpRightScript
	end

ElmJumpBackScript2:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpUpScript
	ifequal UP, ElmJumpDownScript
	ifequal LEFT, ElmJumpRightScript
	ifequal RIGHT, ElmJumpLeftScript
	end

ElmJumpUpScript:
	applymovement ELMSLAB_ELM, ElmJumpUpMovement
	opentext
	end

ElmJumpDownScript:
	applymovement ELMSLAB_ELM, ElmJumpDownMovement
	opentext
	end

ElmJumpLeftScript:
	applymovement ELMSLAB_ELM, ElmJumpLeftMovement
	opentext
	end

ElmJumpRightScript:
	applymovement ELMSLAB_ELM, ElmJumpRightMovement
	opentext
	end

AideScript_PlayerIsLeaving1:
	checkscene
	ifequal SCENE_ELMSLAB_READ_BOOKSHELVES, AideScript_ReadShelves1
	sjump AideScript_WalkBalls1

AideScript_PlayerIsLeaving2:
	checkscene
	ifequal SCENE_ELMSLAB_READ_BOOKSHELVES, AideScript_ReadShelves2
	sjump AideScript_WalkBalls2

AideScript_ReadShelves1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, LEFT
	scall AideScript_ReadBookshelves
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	stopfollow
	applymovement PLAYER, AfterChikoritaMovement
	end

AideScript_ReadShelves2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, LEFT
	scall AideScript_ReadBookshelves
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	stopfollow
	applymovement PLAYER, AfterChikoritaMovement
	end

AideScript_ReadBookshelves:
	setscene SCENE_ELMSLAB_NOTHING
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	opentext
	writetext AideScript_ReadBookshelvesText
	waitbutton
	closetext

	follow ELMSLAB_ELMS_AIDE, PLAYER
	end

AideScript_WalkBalls1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, LEFT
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	turnobject PLAYER, DOWN
	end

AideScript_WalkBalls2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, LEFT
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	turnobject PLAYER, DOWN
	end

AideScript_GiveYouBalls:
	; Pokéballs.
	opentext
	writetext AideText_GiveYouBalls
	promptbutton
	verbosegiveitem POKE_BALL, 5

	; Hand sanitizer.
	writetext AideText_GiveYouHandSanitizer
	setevent EVENT_GOT_HAND_SANITIZER
	playsound SFX_ITEM
	waitsfx

	writetext AideText_BetterSafeThanSorry
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_NOTHING
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

ElmsAideScript:
	faceplayer
	checkevent EVENT_LOCKDOWN_MART_RUSH
	iffalse AideScript_MartRush

	checkflag ENGINE_WEARING_FACE_MASK
	iftrue AideScript_BetterSafeThanSorry

	checkevent EVENT_GOT_COVID_SAMPLE_FROM_MR_POKEMON
	iftrue AideScript_TheftTestimony

	jumptext AideText_AlwaysBusy

AideScript_BetterSafeThanSorry:
	jumptext AideText_BetterSafeThanSorry

AideScript_TheftTestimony:
	jumptext AideText_TheftTestimony

AideScript_MartRush:
	jumptext AideScript_MartRushText

MeetCopScript2:
	applymovement PLAYER, MeetCopScript2_StepLeft

MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	turnobject ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText1
	promptbutton
	special NameRival
	writetext ElmsLabOfficerText2
	waitbutton
	closetext
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	setscene SCENE_ELMSLAB_NOTHING
	applymovement PLAYER, PlayerTakesPlaceOfOfficerMovement
	opentext
	sjump ElmAfterTheftScript

ElmsLabWindow:
	opentext
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue .Normal
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .BreakIn
	sjump .Normal

.BreakIn:
	writetext ElmsLabWindowText2
	waitbutton
	closetext
	end

.Normal:
	writetext ElmsLabWindowText1
	waitbutton
	closetext
	end

ElmsLabTrashcan:
	jumptext ElmsLabTrashcanText

ElmsLabPC:
	jumptext ElmsLabPCText

ElmsLabBookshelf:
	jumpstd DifficultBookshelfScript

ElmsLabBookshelf1:
	farjumptext ElmsLabBookshelf1Text

ElmsLabBookshelf2:
	farjumptext ElmsLabBookshelf2Text

ElmsLabBookshelf3:
	farjumptext ElmsLabBookshelf3Text

ElmsLabBookshelf4:
	farjumptext ElmsLabBookshelf4Text

ElmsLabBookshelf5:
	farjumptext ElmsLabBookshelf5Text

ElmsLabBookshelf6:
	farjumptext ElmsLabBookshelf6Text

ElmsLabBookshelf7:
	farjumptext ElmsLabBookshelf7Text

ElmsLabBookshelf8:
	farjumptext ElmsLabBookshelf8Text

ElmsLab_WalkUpToElmMovement:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step UP
	turn_head LEFT
	step_end

ElmsLab_CantLeaveMovement:
	step UP
	step_end

MeetCopScript2_StepLeft:
	step LEFT
	step_end

MeetCopScript_WalkUp:
	step UP
	step LEFT
	turn_head RIGHT
	step_end

OfficerLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
AideWalksDown:
	step DOWN
	step_end

PlayerTakesPlaceOfOfficerMovement:
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

ElmRunsTowardsPCMovement:
	big_step LEFT
	big_step LEFT
	big_step DOWN
	big_step DOWN
	step_end

AideWalksRight1:
	step UP
	turn_head RIGHT
	step_end

AideWalksRight2:
	step UP
	step RIGHT
	turn_head RIGHT
	step_end

AideWalksLeft2:
	step LEFT
AideWalksLeft1:
	step DOWN
	step_end

ElmsLab_StepLeftTwiceThenHeadDown:
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

ElmJumpUpMovement:
	fix_facing
	big_step UP
	remove_fixed_facing
	step_end

ElmJumpDownMovement:
	fix_facing
	big_step DOWN
	remove_fixed_facing
	step_end

ElmJumpLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	step_end

ElmJumpRightMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

ElmsLab_ElmToDefaultPositionMovement1:
	step UP
	step UP
	step_end

ElmsLab_ElmToDefaultPositionMovement2:
	step RIGHT
	step RIGHT
	turn_head DOWN
	step_end

ElmsLab_StepDownTwiceThenHeadUp:
	step DOWN
AfterCyndaquilDownMovement:
	step DOWN
ElmsLab_HeadUpMovement:
	turn_head UP
	step_end

AfterChikoritaMovement:
	step LEFT
AfterTotodileMovement:
	step LEFT
AfterCyndaquilMovement:
	step LEFT
	turn_head UP
	step_end

ElmsLab_SlowStepUpMovement:
	slow_step UP
	step_end

ElmsLab_SlowStepDownMovement:
	slow_step DOWN
	step_end

ElmText_Intro:
if DEF(_FR_FR)
	text "ORME: <PLAY_G>!"
	line "Te voilà!"

	para "Oh! Je vois que tu"
	line "gardes 1 pas de"

	para "distance sociale,"
	line "c'est très bien!"

	para "J'ai un service à"
	line "te demander."

	para "Je mène des re-"
	line "cherches sur les"
	cont "#MON."

	para "Je me demandais si"
	line "tu pouvais m'ai-"
	cont "der, <PLAY_G>."

	para "Vois-tu..."

	para "J'écris un article"
	line "pour une grande"
	cont "conférence."

	para "Et j'ai besoin de"
	line "recueillir plus"
	cont "de données sur"
	cont "le terrain."

	para "Donc!"

	para "J'aimerais que tu"
	line "entraînes un de"

	para "mes nouveaux"
	line "#MON."
else
	text "ELM: <PLAY_G>!"
	line "There you are!"

	para "Oh! I see you are"
	line "keeping a 1 step"
	
	para "social distance,"
	line "that's great!"

	para "I needed to ask"
	line "you a favor."

	para "I'm conducting"
	line "#MON research"

	para "right now. I was"
	line "wondering if you"

	para "could help me with"
	line "it, <PLAY_G>."

	para "You see…"

	para "I'm writing a"
	line "paper that I want"

	para "to present at a"
	line "conference."

	para "And I need to"
	line "gather more data"
	cont "from the field."

	para "So!"

	para "I'd like you to"
	line "raise a #MON"

	para "that I recently"
	line "caught."
endc
	done

ElmText_Accepted: 
if DEF(_FR_FR)
	text "Merci, <PLAY_G>!"

	para "Tu es chic!"
else
	text "Thanks, <PLAY_G>!"

	para "You're a great"
	line "help!"
endc

	done

ElmText_Refused: 
if DEF(_FR_FR)
	text "Mais..."
	line "J'en ai besoin!"
else
	text "But… Please, I"
	line "need your help!"
endc

	done

ElmText_Insist:
if DEF(_FR_FR)
	text "Attends? Es-tu sûr"
	line "de ne pas vouloir"
	cont "un #MON?"
else
	text "Wait? Are you sure"
	line "you don't want a"
	cont "#MON?"
endc
	done

ElmText_AllRighty:
if DEF(_FR_FR)
	text "Très bien alors..."
	para "..."
	para "..."
	para "..."
	para "..."
	para "DEGAGE D'ICI SALE"
	line "PETITE MERD"
else
	text "All righty then…"
	para "…"
	para "…"
	para "…"
	para "…"
	para "NOW GET OUT YOU"
	line "LITTLE SHI"
endc
	done

ElmText_ResearchAmbitions:
if DEF(_FR_FR)
	text "Quand j'annoncerai"
	line "mes découvertes,"
	cont "je suis sûr que"

	para "cela secouera la"
	line "communauté scien-"
	cont "tifique."
else
	text "When I announce my"
	line "findings, I'm sure"

	para "it will shake the"
	line "scientific"
	cont "community."
endc
	done

ElmText_GotAnEmail: 
if DEF(_FR_FR)
	text "Oh! J'ai reçu un"
	line "e-mail!"

	para "<……><……><……>"
	line "Hmm… Oui…"

	para "OK…"
else
	text "Oh, hey! I got an"
	line "e-mail!"

	para "<……><……><……>"
	line "Hm… Uh-huh…"

	para "Okay…"
endc

	done

ElmText_MissionFromMrPokemon:
if DEF(_FR_FR)
	text "Ecoute voir."

	para "J'ai un ami du nom"
	line "de M.#MON."

	para "Il découvre sans"
	line "cesse de drôles"
	cont "de trucs."

	para "Il vient de m'en-"
	line "voyer un e-mail"

	para "disant que cette"
	line "fois c'est réel."

	para "C'est tentant mais"
	line "j'ai vraiment trop"
	cont "de travail..."

	para "Attends!"

	para "Je sais!"

	para "<PLAY_G>, peux-tu"
	line "y aller pour moi?"
else
	text "Hey, listen."

	para "I have an acquain-"
	line "tance called MR."
	cont "#MON."

	para "He keeps finding"
	line "weird things and"

	para "raving about his"
	line "discoveries."

	para "Anyway, I just got"
	line "an e-mail from him"

	para "saying that this"
	line "time it's real."

	para "It is intriguing,"
	line "but we're busy"

	para "with our #MON"
	line "research…"

	para "Wait!"

	para "I know."

	para "<PLAY_G>, can you"
	line "go in our place?"
endc
	done

ElmText_ChooseAPokemon:
if DEF(_FR_FR)
	text "Je veux que tu"
	line "entraînes l'un"

	para "des #MON dans"
	line "ces BALLS."

	para "Il sera ton"
	line "nouvel ami,"
	cont "<PLAY_G>!"

	para "Allez! Choisis!"
else
	text "I want you to"
	line "raise one of the"

	para "#MON contained"
	line "in these BALLS."

	para "You'll be that"
	line "#MON's first"
	cont "partner, <PLAY_G>."

	para "Go on. Pick one!"
endc
	done

LabWhereGoingText: 
if DEF(_FR_FR)
	text "PROF.ORME: Hep!"
	line "Où vas-tu?"
else
	text "ELM: Wait! Where"
	line "are you going?"
endc

	done

TakeCyndaquilText: 
if DEF(_FR_FR)
	text "PROF.ORME: Veux-tu"
	line "HERICENDRE, le"
	cont "#MON de feu?"
else
	text "ELM: You'll take"
	line "CYNDAQUIL, the"
	cont "fire #MON?"
endc

	done

TakeTotodileText: 
if DEF(_FR_FR)
	text "PROF.ORME: Veux-tu"
	line "KAIMINUS, le"
	cont "#MON d'eau?"
else
	text "ELM: Do you want"
	line "TOTODILE, the"
	cont "water #MON?"
endc

	done

TakeChikoritaText: 
if DEF(_FR_FR)
	text "PROF.ORME: Veux-tu"
	line "GERMIGNON, le"
	cont "#MON plante?"
else
	text "ELM: So, you like"
	line "CHIKORITA, the"
	cont "grass #MON?"
endc

	done

DidntChooseStarterText: 
if DEF(_FR_FR)
	text "PROF.ORME: Fais le"
	line "bon choix!"

	para "Ton partenaire est"
	line "très important."
else
	text "ELM: Think it over"
	line "carefully."

	para "Your partner is"
	line "important."
endc

	done

ChoseStarterText: 
if DEF(_FR_FR)
	text "PROF.ORME: C'est"
	line "un très bon"
	cont "#MON!"
else
	text "ELM: I think"
	line "that's a great"
	cont "#MON too!"
endc

	done

ReceivedStarterText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "@"
	text_ram wStringBuffer3
	text "!"
else
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
endc

	done

ElmDirectionsText1:
if DEF(_FR_FR)
	text "M.#MON vit"
	line "après VILLE"

	para "GRIOTTE, la"
	line "ville voisine."

	para "C'est tout droit."
	line "Tu ne peux pas te"
	cont "perdre."

	para "Mais on ne sait"
	line "jamais: prends mon"

	para "No. de téléphone."
	line "Appelle-moi s'il"
	cont "arrive un truc!"
else
	text "MR.#MON lives a"
	line "little bit beyond"

	para "CHERRYGROVE, the"
	line "next city over."

	para "It's almost a"
	line "direct route"

	para "there, so you"
	line "can't miss it."

	para "But just in case,"
	line "here's my phone"

	para "number. Call me if"
	line "anything comes up."
endc
	done

ElmDirectionsText2:
if DEF(_FR_FR)
	text "Si ton #MON est"
	line "blessé, soigne-le"

	para "avec cette jolie"
	line "machine."

	para "Elle restaure les"
	line "PV, mais elle ne"
	cont "débarrasse pas des"
	cont "virus hélas..."

	para "Utilise-la quand"
	line "tu veux."
else
	text "If your #MON is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

	para "It can heal their"
	line "health points but"
	cont "won't get rid of"
	cont "viruses I'm"
	cont "afraid…"

	para "Feel free to use"
	line "it anytime."
endc
	done

ElmDirectionsText3: 
if DEF(_FR_FR)
	text "<PLAY_G>, je"
	line "compte sur toi!"
else
	text "<PLAY_G>, I'm"
	line "counting on you!"
endc

	done

GotElmsNumberText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit le"
	line "numéro de tél. du"
	cont "PROF.ORME."
else
	text "<PLAYER> got ELM's"
	line "phone number."
endc

	done

ElmDescribesMrPokemonText:
if DEF(_FR_FR)
	text "M.#MON fouille"
	line "un peu partout et"
	cont "trouve des bizar-"
	cont "reries."

	para "Ramène le COLIS"
	line "qu'il a pour moi,"
	cont "veux-tu?"
else
	text "MR.#MON goes"
	line "everywhere and"
	cont "finds rarities."

	para "Go fetch this"
	line "PARCEL he got"
	cont "for me, will you?"
endc
	done

ElmPokeBallText: 
if DEF(_FR_FR)
	text "Cela contient un"
	line "#MON attrapé"
	cont "par le PROF.ORME."
else
	text "It contains a"
	line "#MON caught by"
	cont "PROF.ELM."
endc

	done

ElmsLabHealingMachineText1: 
if DEF(_FR_FR)
	text "Je me demande à"
	line "quoi ça sert..."
else
	text "I wonder what this"
	line "does?"
endc

	done

ElmsLabHealingMachineText2: 
if DEF(_FR_FR)
	text "Voulez-vous soi-"
	line "gner vos #MON?"
else
	text "Would you like to"
	line "heal your #MON?"
endc

	done

ElmAfterTheftText1:
if DEF(_FR_FR)
	text "ORME: <PLAY_G>,"
	line "c'est affreux..."

	para "Au fait, quelle"
	line "est la grande"
	cont "découverte de"
	cont "M.#MON?"
else
	text "ELM: <PLAY_G>, this"
	line "is terrible…"

	para "…"

	para "Oh, yes, what was"
	line "MR.#MON's big"
	cont "discovery?"
endc
	done

ElmAfterTheftText2:
if DEF(_FR_FR)
	text "<PLAYER> confie"
	line "le COLIS au"
	cont "PROF.ORME."
else
	text "<PLAYER> handed"
	line "the PARCEL to"
	cont "PROF.ELM."
endc
	done

ElmAfterTheftText3: 
if DEF(_FR_FR)
	text "PROF.ORME: Ca?"
else
	text "ELM: This?"
endc

	done

ElmAfterTheftText4:
if DEF(_FR_FR)
	text "Mais... comment"
	line "a-t-il eu ça?"

	para "Ca va beaucoup"
	line "aider mes"
	cont "recherches!"
else
	text "But… how did he"
	line "get this?"

	para "It's going to"
	line "help a lot with my"
	cont "research!"
endc
	done

ElmAfterTheftText5:
if DEF(_FR_FR)
	text "ORME: Quoi?!?"

	para "Le PROF.CHEN t'a"
	line "donné un #DEX?"

	para "<PLAY_G>, c'est"
	line "vrai? C-c'est"
	cont "incroyable!"

	para "Il a l'oeil pour"
	line "trouver les bons"
	cont "dresseurs pleins"
	cont "d'avenir."

	para "<PLAY_G>..."
	line "Tu dois avoir les"

	para "épaules pour être"
	line "MAITRE."

	para "Tu devrais te lan-"
	line "cer à la conquête"
	cont "des ARENES."

	para "La plus proche est"
	line "celle de MAUVILLE."

	para "... Hmm?"

	para "Le PROF.CHEN a"
	line "demandé qu'on"
	cont "allume la radio?"
else
	text "What?!?"

	para "PROF.OAK also gave"
	line "you a #DEX?"

	para "<PLAY_G>, is that"
	line "true? Th-that's"
	cont "incredible!"

	para "He is superb at"
	line "seeing the poten-"
	cont "tial of people as"
	cont "trainers."

	para "The last two he"
	line "gave a #DEX"

	para "became #MON"
	line "LEAGUE CHAMPION."

	para "You should take"
	line "the #MON GYM"
	cont "challenge."

	para "The closest GYM"
	line "would be the one"
	cont "in VIOLET CITY."

	para "… Hmm?"

	para "PROF.OAK asked me"
	line "to turn on the"
	cont "radio?"
endc
	done

ElmIsItOfficialText:
if DEF(_FR_FR)
	text "Est-ce qu'il va"
	line "l'officialiser?"
else
	text "Is he going to"
	line "make it official?"
endc
	done

ElmListenRadioText:
if DEF(_FR_FR)
	text "Ecoutons-la sur"
	line "mon ordinateur!"
else
	text "Let's listen to it"
	line "on my computer!"
endc
	done

ElmCovidAnnouncementText:
if DEF(_FR_FR)
	text "LULA: Aujourd'hui"
	line "PROF.CHEN, vous"
	cont "avez quelque chose"
	cont "de très important"
	cont "à nous dire, c'est"
	cont "bien ça?"

	para "CHEN: En effet."
	line "Ces derniers jours"
	cont "j'ai travaillé"
	cont "avec un conseil"
	cont "d'experts médi-"
	cont "caux qualifiés."

	para "Notre but est"
	line "d'étudier ce"
	cont "nouveau virus."
	cont "Nous avons nommé"
	cont "la maladie qu'il"
	cont "cause COVID-19."

	para "Elle touche les"
	line "#MON ainsi que"
	cont "les humains."

	para "Les symptômes"
	line "peuvent être dan-"
	cont "gereux, surtout"
	cont "pour les #MON."

	para "Nous avons déjà"
	line "identifié 16 cas"
	cont "à JOHTO."

	para "Ce virus est très"
	line "contagieux et se"
	cont "répand vite."

	para "Ainsi, il devien-"
	line "dra un problème"
	cont "de santé publique"
	cont "d'ici quelques"
	cont "jours."

	para "Demain je tiendrai"
	line "une réunion avec"
	cont "les autorités et"
	cont "les politiques"
	cont "pour définir un"
	cont "plan d'action."

	para "Prenez le COVID"
	line "au sérieux et"
	cont "respectez la"
	cont "distanciation"
	cont "sociale pour le"
	cont "moment."
else
	text "MARY: Today PROF."
	line "OAK you have"
	cont "something very"
	cont "important to tell"
	cont "us, am I right?"

	para "OAK: Indeed."
	line "In the past days,"
	cont "I have been"
	cont "working with a"
	cont "counsel of highly"
	cont "qualified medical"
	cont "experts."

	para "Our goal is to"
	line "study this new"
	cont "virus. We named"
	cont "the disease caused"
	cont "by this virus"
	cont "COVID-19."

	para "It affects #MON"
	line "as well as humans."

	para "The symptoms can"
	line "be dangerous,"
	cont "especially for"
	cont "#MON."

	para "So far, we have"
	line "identified 16"
	cont "cases in JOHTO."

	para "It is very"
	line "contagious and"
	cont "spreads fast."

	para "As such, it will"
	line "become a public"
	cont "health issue in"
	cont "a matter of days."

	para "Tomorrow I will"
	line "hold a meeting"
	cont "with politicians"
	cont "and authorities"
	cont "to come up with a"
	cont "plan of action."

	para "Please take COVID"
	line "seriously and"
	cont "respect social"
	cont "distancing"
	cont "for now."
endc
	done

ElmWorksWithOakText:
if DEF(_FR_FR)
	text "Alors maintenant"
	line "l'info est"
	cont "publique."
else
	text "So now the word"
	line "is out."
endc
	done

ElmAfterTheftText6:
if DEF(_FR_FR)
	text "...<PLAY_G>. Le"
	line "COLIS de M.#MON"
	cont "que tu as apporté"
	cont "contient un"
	cont "échantillon du"
	cont "virus d'un #MON"
	cont "infecté."

	para "On ne sait pas"
	line "encore grand"
	cont "chose de ce virus,"
	cont "alors j'ai besoin"
	cont "de cet échantillon"
	cont "pour mes"
	cont "recherches."

	para "...mais ce n'est"
	line "pas suffisant."

	para "Il me faudrait"
	line "quelqu'un sur le"
	cont "terrain pour re-"
	cont "cueillir des infos"
	cont "pour moi."

	para "Ecoute, j'ai besoin"
	line "de ton aide plus"
	cont "que jamais,"
	cont "<PLAY_G>."

	para "Veux-tu m'aider"
	line "dans cette mis-"
	cont "sion?"
else
	text "…<PLAY_G>. The"
	line "PARCEL you brought"
	cont "from MR.#MON"
	cont "contains a sample"
	cont "of the virus from"
	cont "an infected"
	cont "#MON."

	para "We don't know much"
	line "about this virus"
	cont "yet, so I need"
	cont "this sample for my"
	cont "research."

	para "…but that's not"
	line "enough."

	para "I would need"
	line "someone on the"
	cont "field, to gather"
	cont "info for me."

	para "Look, I need your"
	line "help more than"
	cont "ever, <PLAY_G>."

	para "Are you willing"
	line "to help me on"
	cont "this mission?"
endc
	done

ElmInsistOnGettingHelpText:
if DEF(_FR_FR)
	text "Ce travail est"
	line "crucial et sau-"
	cont "vera des vies."

	para "J'ai besoin de"
	line "ton aide!"
else
	text "This work is"
	line "crucial and will"
	cont "save lives."

	para "I need you"
	line "to help me!"
endc
	done

ElmMissionAcceptedText:
if DEF(_FR_FR)
	text "Parfait! Explore"
	line "la région et ap-"
	cont "pelle-moi quand tu"
	cont "découvres quelque"
	cont "chose d'utile."

	para "Si tu pouvais"
	line "trouver le patient"
	cont "zéro, le tout pre-"
	cont "mier cas du COVID,"
	cont "cela aiderait à"
	cont "comprendre comment"
	cont "tout a commencé."

	para "J'espère aussi que"
	line "tu profiteras de"
	cont "ton voyage et que"
	cont "tu deviendras ami"
	cont "avec tes #MON!"

	para "Avant de quitter"
	line "BOURG GEON, parle"
	cont "bien à ta mère."
else
	text "Great! Explore the"
	line "region and call me"
	cont "whenever you"
	cont "discover something"
	cont "of interest."

	para "If you could find"
	line "patient zero, the"
	cont "first patient that"
	cont "ever contracted"
	cont "COVID, that would"
	cont "help understand"
	cont "how this all"
	cont "started."
	

	para "I also hope you"
	line "will enjoy your"
	cont "journey and make"
	cont "friends with your"
	cont "#MON!"

	para "Before you leave"
	line "NEW BARK TOWN,"
	cont "make sure that you"
	cont "talk to your mom."
endc
	done

ElmFindPatientZeroText:
if DEF(_FR_FR)
	text "ORME: N'abandonne"
	line "pas! Trouve le"
	cont "patient zéro!"
else
	text "ELM: Don't give up!"
	line "Find patient zero!"
endc
	done

ElmLockdownAnnouncementText:
if DEF(_FR_FR)
	text "ORME: Tout le"
	line "monde panique..."
	
	para "Le confinement"
	line "peut sembler une"

	para "mesure sévère,"
	line "mais c'est la"

	para "plus efficace"
	line "qui existe..."

	para "Elle est néces-"
	line "saire."

	para "Sinon, notre sys-"
	line "tème de santé"

	para "sera saturé d'ici"
	line "quelques jours."
else
	text "ELM: Everyone"
	line "is panicking"
	cont "right now…"

	para "The lockdown may"
	line "feel like a harsh"

	para "measure, but it's"
	line "the single most"

	para "effective one"
	line "we know of…"

	para "It is necessary."

	para "Otherwise our"
	line "healthcare system"

	para "will get saturated"
	line "within a few days."
endc
	done

ElmLockdownCurfewVisitText:
if DEF(_FR_FR)
	text "ORME: <PLAYER>?"

	para "C'est illégal que"
	line "tu sois ici!"

	para "Tu devrais être"
	line "chez ta mère."

	para "Dans la situation"
	line "actuelle, je ne"

	para "peux pas te de-"
	line "mander de cher-"
	cont "cher le patient"
	cont "zéro."

	para "Mais je ne peux"
	line "pas t'en empêcher"

	para "non plus..."
	
	para "Fais juste atten-"
	line "tion."
else
	text "ELM: <PLAYER>?"

	para "It's illegal for"
	line "you to be here!"

	para "You should be home"
	line "with your mom."

	para "In the current"
	line "situation, I can't"

	para "ask you to search"
	line "for patient zero."

	para "But I can't stop"
	line "you either…"

	para "Just be careful."
endc
	done

ElmVaccinePassportText:
if DEF(_FR_FR)
	text "ORME: Avec l'uti-"
	line "lisation massive"

	para "du PASS VACCINAL,"
	line "la pandémie sem-"
	cont "ble toucher à sa"
	cont "fin."

	para "Mais il ne faut"
	line "pas relâcher nos"

	para "efforts avant que"
	line "le virus soit"
	cont "totalement éra-"
	cont "diqué."
else
	text "ELM: With the"
	line "widespread use of"

	para "the VACCINE PASS-"
	line "PORT, the pandemic"
	
	para "sure looks close"
	line "to its end."

	para "But we must not"
	line "reduce our efforts"

	para "until this virus"
	line "has been totally"
	cont "eradicated."
endc
	done

ElmCurfewDayVisitText:
if DEF(_FR_FR)
	text "ORME: Bon retour,"
	line "<PLAYER>!"

	para "Avec le couvre-"
	line "feu, tu peux"

	para "de nouveau aller"
	line "dehors librement,"

	para "c'est agréable."

	para "Mais ne baisse pas"
	line "ta garde!"

	para "Le virus conti-"
	line "nue de se répan-"
	cont "dre, et la situa-"
	cont "tion peut empi-"
	cont "rer!"

	para "Je dois admettre"
	line "que le confine-"
	cont "ment a pesé sur"
	cont "la santé mentale."

	para "Alors peut-être"
	line "que le couvre-feu"
	cont "est un compro-"
	cont "mis acceptable."
else
	text "ELM: Welcome back"
	line "<PLAYER>!"
	
	para "With the curfew in"
	line "place, you can"
	
	para "freely roam the"
	line "outside world"
	
	para "once again, this"
	line "is nice."

	para "But don't lower"
	line "your guard!"

	para "The virus keeps"
	line "spreading and"
	
	para "this situation"
	line "could backfire!"

	para "Though I must"
	line "admit that the"
	
	para "lockdown has taken"
	line "a toll on people's"

	para "mental health. So"
	line "maybe the curfew"

	para "is an acceptable"
	line "compromise."
endc
	done

ElmFinalText:
if DEF(_FR_FR)
	text "ORME: Mission"
	line "réussie!"
else
	text "ELM: Mission"
	line "succeeded!"
endc
	done

ElmFinalText2::
if DEF(_FR_FR)
	text "Merci pour ton"
	line "aide contre le"
	cont "COVID-19!"
else
	text "Thank you for"
	line "your help against"
	cont "COVID-19!"
endc
	done

ElmGiveWorkVisaText1:
if DEF(_FR_FR)
	text "ORME: La rumeur"
	line "dit que tu as"

	para "gagné tous les"
	line "badges de JOHTO,"
	cont "est-ce vrai?"

	para "Je suis très"
	line "impressionné!"

	para "Mais comme la"
	line "frontière entre"

	para "JOHTO et KANTO"
	line "est fermée,"

	para "la LIGUE #MON"
	line "est hors d'accès."

	para "Ecoute. Tu m'as"
	line "beaucoup aidé"
	cont "dans mes recher-"
	cont "ches."

	para "C'est à mon tour"
	line "de t'aider."

	para "Mon statut de"
	line "chercheur en viro-"
	cont "logie me donne"
	cont "des avantages"
	cont "en ces temps."

	para "Alors j'en ai pro-"
	line "fité et j'ai obtenu"
	cont "ça pour toi."
else
	text "ELM: The rumors"
	line "say that you won"
	
	para "all badges from"
	line "JOHTO, is it true?"

	para "I am very"
	line "impressed!"

	para "However, as the"
	line "border between"
	
	para "JOHTO and KANTO"
	line "is closed,"
	
	para "the #MON LEAGUE"
	line "is out of reach."

	para "Look. You've helped"
	line "me a lot in my"
	cont "research."
	
	para "Now it's my turn"
	line "to help you."

	para "My status as a"
	line "virology resear-"
	cont "cher currently"
	cont "gives me special"
	cont "benefits."

	para "So I took advan-"
	line "tage of it and"
	cont "got you this."
endc
	done

ElmGiveWorkVisaText2:
if DEF(_FR_FR)
	text "Ils ne sont"
	line "donnés qu'à"
	cont "peu de gens triés"
	cont "sur le volet."

	para "C'est un permis"
	line "pour traverser"

	para "légalement la"
	line "frontière de KANTO"
	cont "en tant que membre"
	cont "de mon équipe."

	para "Peut-être trouve-"
	line "ras-tu le patient"
	cont "zéro à KANTO,"
	cont "qui sait?"

	para "Et si par hasard"
	line "tu fais une halte"
	cont "à la LIGUE"
	cont "#MON..."

	para "C'est pas mes"
	line "oignons, héhé!"

	para "L'accès le plus"
	line "proche de KANTO"

	para "est à l'Est de"
	line "cette ville."

	para "Je te souhaite"
	line "bonne chance!"
else
	text "Those are only"
	line "given to a"
	cont "select few."

	para "It's a permit to"
	line "legally cross"
	
	para "KANTO's border as a"
	line "member of my team."

	para "Perhaps you'll find"
	line "patient zero in"
	cont "KANTO, who knows?"

	para "And if you"
	line "accidentally stop"
	cont "by the #MON"
	cont "LEAGUE…"
	
	para "That's none of my"
	line "business, hehe!"

	para "Closest access"
	line "to KANTO's border"

	para "is East of this"
	line "town."

	para "I wish you"
	line "good luck!"
endc
	done

ElmGiveVaccineText1:
if DEF(_FR_FR)
	text "ORME: <PLAY_G>!"
	line "Te voilà!"

	para "Avant tout,"
	line "félicitations"

	para "pour ton titre de"
	line "MAITRE de la"
	cont "LIGUE!"

	para "Je t'appelle car"
	line "j'ai une nouvelle"
	
	para "formidable à"
	line "t'annoncer!"

	para "Un vaccin pour"
	line "les humains a"

	para "été découvert et"
	line "a passé toutes"

	para "les vérifications"
	line "pour être mis à"
	
	para "disposition du"
	line "public!!"

	para "Jamais dans l'his-"
	line "toire un vaccin"
	
	para "n'a été créé"
	line "si vite!"
else
	text "ELM: <PLAY_G>!"
	line "There you are!"

	para "First of all,"
	line "congratulations"

	para "on becoming the"
	line "LEAGUE CHAMPION!"

	para "I called because I"
	line "have amazing news"
	cont "for you my friend."

	para "A vaccine for hu-"
	line "mans has finally"
	
	para "been found and"
	line "successfully"
	
	para "passed all verif-"
	line "ications to be"
	
	para "made available"
	line "to the public!!"

	para "Never in history"
	line "had a vaccine"
	
	para "been created so"
	line "quickly!"
endc
	done

ElmGiveVaccineText2:
if DEF(_FR_FR)
	text "Pour cette raison,"
	line "beaucoup de gens"

	para "se méfient, car"
	line "ils jugent qu'il"

	para "n'a pas été testé"
	line "assez."
else
	text "For this reason,"
	line "a lot of people"
	
	para "are mistrustful"
	line "because they think"
	
	para "it hasn't been"
	line "tested thourougly."
endc
	done

ElmGiveVaccineText3:
if DEF(_FR_FR)
	text "C'est là que tu"
	line "interviens."

	para "Les autorités"
	line "veulent que les"

	para "gens fassent"
	line "confiance au"

	para "vaccin et se"
	line "fassent vacciner."

	para "Une de leurs"
	line "actions est de"

	para "faire vacciner"
	line "des célébrités,"

	para "pour que les gens"
	line "suivent."

	para "Et maintenant que"
	line "tu es MAITRE,"

	para "les gens comptent"
	line "sur toi."
else
	text "This is where you"
	line "play a part."

	para "Authorities want"
	line "people to trust"

	para "the vaccine and"
	line "get vaccinated."

	para "One of their"
	line "actions is to"

	para "have celebrities"
	line "get vaccinated,"

	para "so people follow"
	line "their lead."

	para "And now that you"
	line "are the CHAMPION,"

	para "people are looking"
	line "up to you."
endc
	done

ElmGiveVaccineText4:
if DEF(_FR_FR)
	text "L'INFIRMIERE JOEL-"
	line "LE est prête à te"

	para "faire l'injection"
	line "dès à présent."
else
	text "CHIEF NURSE JOY"
	line "is ready to give"

	para "you a shot as we"
	line "speak."
endc
	done

ElmGiveVaccineText5:
if DEF(_FR_FR)
	text "En ma qualité de"
	line "chercheur sur le"

	para "vaccin, je peux"
	line "t'affirmer qu'il"

	para "est sûr. Plus sûr"
	line "que de ne pas se"
	cont "faire vacciner"
	cont "en tout cas."

	para "C'est l'action la"
	line "plus significative"

	para "pour éradiquer ce"
	line "virus."

	para "Je te conseille"
	line "de saisir cette"
	cont "chance."

	para "Mais je compren-"
	line "drais si tu ne le"
	cont "fais pas."

	para "Dans tous les cas,"
	line "n'oublie pas de"
	cont "m'aider à trouver"
	cont "le patient zéro!"
else
	text "As someone that"
	line "helped with the"

	para "research on the"
	line "vaccine, I can"

	para "tell you that the"
	line "vaccine is safe."

	para "Safer than not"
	line "getting vaccina-"
	cont "ted anyway."
	
	para "This is the best"
	line "action you can do"

	para "to help erradicate"
	line "this virus."

	para "I would advise you"
	line "to seize this"
	cont "opportunity."

	para "But I would under-"
	line "stand if you don't."

	para "In any case, don't"
	line "forget to help me"
	cont "find patient zero!"
endc
	done

ElmFoundPatientZeroText1:
if DEF(_FR_FR)
	text "Bonjour <PLAYER>."
	para "Nous avons beau-"
	line "coup à discuter."

	para "Assieds-toi."
else
	text "Hello <PLAYER>."
	para "We've got a lot"
	line "to talk about."
	
	para "So please sit."
endc
	done

ElmFoundPatientZeroText2:
if DEF(_FR_FR)
	text "Il y a deux ans"
	line "je t'ai confié"
	cont "une mission."

	para "Il semblerait que"
	line "tu l'aies enfin"
	cont "complétée..."

	para "Tu as trouvé le"
	line "patient zéro."

	para "..."

	para "Je suis à la fois"
	line "heureux et triste."

	para "Je ne voulais pas"
	line "que ça finisse"
	cont "dans ces circons-"
	cont "tances."

	para "Un échantillon du"
	line "sang de RED a été"
	cont "analysé."

	para "Il avait une sou-"
	line "che du virus qui,"

	para "d'après ses muta-"
	line "tions, serait"

	para "l'ancêtre du virus"
	line "que nous connais-"
	cont "sons."

	para "Cette hypothèse"
	line "est renforcée par"
	cont "d'autres faits."

	para "Beaucoup des pre-"
	line "miers malades du"

	para "COVID, comme"
	line "AGATHA ou ONDINE,"

	para "étaient de proches"
	line "parents de lui."

	para "Grâce au traçage"
	line "des contacts et à"

	para "l'analyse des don-"
	line "nées, nous avons"

	para "aussi découvert"
	line "que le COVID s'est"
	cont "d'abord répandu"
	cont "dans les villes"
	cont "de KANTO où RED"

	para "avait été aperçu"
	line "quelques jours"
	cont "auparavant."

	para "Si RED a découvert"
	line "sa maladie, ça"

	para "peut expliquer"
	line "pourquoi il a"

	para "abandonné son"
	line "poste de MAITRE"
	cont "de la LIGUE."

	para "Nous ne pouvons"
	line "pas dire avec"
	
	para "certitude que RED"
	line "était vraiment le"
	cont "patient zéro,"

	para "mais j'imagine que"
	line "c'est la réponse la"
	
	para "plus proche que"
	line "nous puissions"
	cont "obtenir."

	para "..."

	para "Il y a deux ans,"
	line "je pensais que"

	para "trouver le patient"
	line "zéro apporterait"
	cont "une réponse à"

	para "toutes mes"
	line "questions."

	para "Au final, il reste"
	line "encore beaucoup"
	cont "d'interrogations."

	para "Où et comment RED"
	line "a-t-il attrapé le"
	cont "COVID à l'origine?"

	para "Dans quelles"
	line "circonstances le"
	cont "#RUS a-t-il"
	cont "muté?"

	para "Nous ne pourrons"
	line "jamais demander à"
	cont "RED maintenant"
	cont "qu'il est..."

	para "..."
else
	text "Two years ago"
	line "I sent you on"
	cont "a mission."

	para "It looks like"
	line "you finally "
	cont "completed it…"


	para "You've found"
	line "the patient zero."

	para "…"

	para "I am both"
	line "glad and sad."

	para "I didn't wish for"
	line "it to end in those"
	cont "circumstances."

	para "A sample of RED's"
	line "blood has been"
	cont "analyzed."

	para "He had a strain of"
	line "the virus that,"
	
	para "based on its"
	line "mutations,"
	
	para "we assume to be"
	line "the ancestor of"
	
	para "the virus we"
	line "all know."

	para "This hypothesis is"
	line "further strength-"
	cont "ened by other"
	cont "facts."

	para "A lot of the early"
	line "sick people that"
	
	para "have been found"
	line "infected by COVID,"
	
	para "like AGATHA"
	line "or MISTY,"
	
	para "were close"
	line "relatives of him."

	para "With the help of"
	line "contact tracing"
	cont "and data analysis,"
	
	para "we also discovered"
	line "that COVID first"
	cont "spread in KANTO"
	cont "cities,"
	
	para "where RED had been"
	line "seen a few days"
	cont "before."

	para "RED finding out"
	line "about his disease"
	
	para "could also explain"
	line "why he abandonned"
	
	para "his job as the"
	line "LEAGUE CHAMPION."

	para "We can't tell for"
	line "sure if RED was"
	cont "patient zero,"
	
	para "but it is the"
	line "closest answer"
	cont "we'll get I guess."

	para "…"

	para "Two years ago, I"
	line "thought finding"
	
	para "patient zero would"
	line "bring an answer to"
	cont "all my questions."

	para "In the end, there"
	line "are still many"
	cont "questions."

	para "How and where did"
	line "RED get COVID in"
	cont "the first place?"

	para "In what circum-"
	line "stances did"
	cont "#RUS mutate?"

	para "We'll never be"
	line "able to ask RED"
	cont "now that he…"

	para "…" 
endc
	done

ElmComfortOakText:
if DEF(_FR_FR)
	text "Pauvre PROF.CHEN."

	para "RED était son"
	line "protégé, ils"
	cont "étaient proches."

	para "Tu devrais visiter"
	line "son labo à BOURG"
	cont "PALETTE pour le"
	cont "réconforter."

	para "..."
else
	text "Poor PROF.OAK."

	para "RED was his"
	line "protege, they"
	cont "were very close."

	para "You should visit"
	line "his lab in PALLET"
	cont "TOWN to comfort"
	cont "him."

	para "…"
endc
	done

ElmFoundPatientZeroText3:
if DEF(_FR_FR)
	text "Tu as réalisé tant"
	line "de choses <PLAYER>."

	para "En m'aidant dans"
	line "mes recherches..."

	para "En soutenant"
	line "l'INFIRMIERE JOELLE"
	cont "quand elle était"
	cont "au bord du"
	cont "burn-out..."

	para "Ton interview avec"
	line "LULA a incité"
	cont "des milliers de"
	cont "gens à se faire"
	cont "vacciner..."

	para "En obtenant un"
	line "échantillon d'eau"
	cont "de SUICUNE qui fut"
	cont "la clé du vaccin"
	cont "#MON..."

	para "Puis en parti-"
	line "cipant aux tests"
	cont "de ce vaccin..."

	para "Tu es sans doute"
	line "la personne la"
	cont "plus importante"
	cont "dans la lutte"
	cont "contre le COVID."

	para "Je considère ta"
	line "mission terminée."

	para "Merci pour tout!"
else
	text "You've done so"
	line "much, <PLAYER>."

	para "Helping me in my"
	line "research…"

	para "Supporting CHIEF"
	line "NURSE JOY when"
	cont "she was about to"
	cont "burn out…"

	para "Your interview"
	line "with MARY that"
	cont "lead thousands of"
	cont "citizens towards"
	cont "vaccination…"

	para "Obtaining SUICUNE's"
	line "water sample that"
	cont "was the key to the"
	cont "#MON vaccine…"

	para "Then, taking part"
	line "in this vaccine's"
	cont "testing…"

	para "You are probably"
	line "the most important"
	cont "person in the war"
	cont "against COVID."

	para "I consider your"
	line "mission done."

	para "Thank you"
	line "for everything!"
endc
	done

AideText_GiveYouHandSanitizer:
if DEF(_FR_FR)
	text "Je veux aussi que"
	line "tes mains soient"
	cont "propres en"
	cont "permanence."

	para "<PLAYER> obtient"
	line "du GEL HYDRO-"
	cont "ALCOOLIQUE!"
else
	text "I also want you to"
	line "keep clean hands"
	cont "at all times."

	para "<PLAYER> got some"
	line "HAND SANITIZER!"
endc
	done

AideText_AlwaysBusy:
if DEF(_FR_FR)
	text "As-tu entendu"
	line "parler du virus"
	cont "à la télé?"
else
	text "Have you heard"
	line "about the virus"
	cont "on TV?"
endc
	done

AideText_BetterSafeThanSorry:
if DEF(_FR_FR)
	text "Mieux vaut pré-"
	line "venir que guérir."

	para "Ce virus est"
	line "sérieux et tu dois"
	cont "t'en protéger."
else
	text "Better safe than"
	line "sorry."

	para "This virus is"
	line "something serious"
	cont "and you should be"
	cont "careful about it."
endc
	done

AideText_TheftTestimony:
if DEF(_FR_FR)
	text "Il y avait du"
	line "vacarme dehors..."

	para "Lorsque je suis"
	line "allé jeter un"
	cont "oeil, on avait"
	cont "volé un #MON."

	para "C'est impensable,"
	line "il faut vraiment"
	cont "ne pas avoir de"
	cont "coeur pour faire"
	cont "une telle chose!"

	para "...(soupir)..."
	line "Ce #MON volé..."

	para "Je me demande"
	line "comment il va."

	para "On dit qu'un"
	line "#MON élevé par"

	para "un méchant p'tit"
	line "bonhomme tourne"
	cont "mal lui aussi."
else
	text "There was a loud"
	line "noise outside…"

	para "When we went to"
	line "look, someone"
	cont "stole a #MON."

	para "It's unbelievable"
	line "that anyone would"
	cont "do that!"

	para "…sigh… That"
	line "stolen #MON."

	para "I wonder how it's"
	line "doing."

	para "They say a #MON"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
endc
	done

AideScript_MartRushText:
if DEF(_FR_FR)
	text "Un confinement..."
	
	para "Mais comment"
	line "on va faire?"
else
	text "A lockdown…"

	para "How are we"
	line "gonna do?"
endc
	done

AideScript_ReadBookshelvesText:
if DEF(_FR_FR)
	text "Ravi de te ren-"
	line "contrer <PLAYER>!"

	para "Comme tu débutes,"
	line "tu devrais lire"
	cont "tous les livres"
	cont "du PROF.ORME."

	para "Ils sont pleins de"
	line "savoir utile."
else
	text "Nice to meet you"
	line "<PLAYER>!"

	para "As a new TRAINER,"
	line "you should read"
	cont "all of ELM's books."

	para "They're full of"
	line "great knowledge."
endc
	done

AideText_GiveYouBalls: 
if DEF(_FR_FR)
	text "<PLAY_G>!"

	para "Utilise ceci pour"
	line "compléter ton"
	cont "#DEX!"
else
	text "<PLAY_G>!"

	para "Use these on your"
	line "#DEX quest!"
endc

	done

ElmsLabOfficerText1: 
if DEF(_FR_FR)
	text "J'ai entendu dire"
	line "qu'un #MON"
	cont "a été volé ici..."

	para "Je viens de rece-"
	line "voir des infos"
	cont "du PROF.ORME."

	para "Apparemment,"
	line "c'était un jeune"
	cont "garnement aux"
	cont "longs cheveux"
	cont "rouges..."
	cont "Racaille-racaille!"

	para "Quuooi?"

	para "Tu as combattu un"
	line "dresseur comme ça?"

	para "As-tu retenu"
	line "son nom?"
else
	text "I heard a #MON"
	line "was stolen here…"

	para "I was just getting"
	line "some information"
	cont "from PROF.ELM."

	para "Apparently, it was"
	line "a young male with"
	cont "long, red hair…"

	para "What?"

	para "You battled a"
	line "trainer like that?"

	para "Did you happen to"
	line "get his name?"
endc

	done

ElmsLabOfficerText2: 
if DEF(_FR_FR)
	text "Il s'appelait"
	line "donc <RIVAL>."

	para "Merci pour ta"
	line "coopération!"
else
	text "OK! So <RIVAL>"
	line "was his name."

	para "Thanks for helping"
	line "my investigation!"
endc

	done

ElmsLabWindowText1: 
if DEF(_FR_FR)
	text "La fenêtre est"
	line "ouverte."

	para "Un filet d'air"
	line "passe."
else
	text "The window's open."

	para "A pleasant breeze"
	line "is blowing in."
endc

	done

ElmsLabWindowText2: 
if DEF(_FR_FR)
	text "Il a déboulé ici!"
else
	text "He broke in"
	line "through here!"
endc

	done

ElmsLabTrashcanText:
if DEF(_FR_FR)
	text "Des masques"
	line "chirurgicaux & des"
	cont "gants usagés..."
else
	text "Some used surgical"
	line "masks and gloves…"
endc
	done

ElmsLabPCText:
if DEF(_FR_FR)
	text "OBSERVATIONS SUR"
	line "LA VIROLOGIE"
	cont "#MON"

	para "...Il est écrit"
	line "à l'écran..."
else
	text "OBSERVATIONS ON"
	line "#MON VIROLOGY"

	para "…It says on the"
	line "screen…"
endc
	done

ElmsLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 1
	warp_event  5, 11, NEW_BARK_TOWN, 1

	def_coord_events
	coord_event  4,  6, CE_SCENE_ID, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  5,  6, CE_SCENE_ID, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  4,  5, CE_SCENE_ID, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript
	coord_event  5,  5, CE_SCENE_ID, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript2
	coord_event  4,  8, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, AideScript_PlayerIsLeaving1
	coord_event  5,  8, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, AideScript_PlayerIsLeaving2

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ElmsLabHealingMachine
	bg_event  6,  7, BGEVENT_READ, ElmsLabBookshelf5
	bg_event  7,  7, BGEVENT_READ, ElmsLabBookshelf6
	bg_event  8,  7, BGEVENT_READ, ElmsLabBookshelf7
	bg_event  9,  7, BGEVENT_READ, ElmsLabBookshelf8
	bg_event  0,  7, BGEVENT_READ, ElmsLabBookshelf1
	bg_event  1,  7, BGEVENT_READ, ElmsLabBookshelf2
	bg_event  2,  7, BGEVENT_READ, ElmsLabBookshelf3
	bg_event  3,  7, BGEVENT_READ, ElmsLabBookshelf4
	bg_event  6,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  7,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  8,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  3, BGEVENT_READ, ElmsLabTrashcan
	bg_event  5,  0, BGEVENT_READ, ElmsLabWindow
	bg_event  3,  5, BGEVENT_DOWN, ElmsLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript, -1
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  5,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
