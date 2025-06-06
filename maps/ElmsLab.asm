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
	opentext
;	;iftrue AideScript_AfterTheft
	checkevent EVENT_GOT_COVID_SAMPLE_FROM_MR_POKEMON
	iftrue AideScript_TheftTestimony
	checkflag ENGINE_WEARING_FACE_MASK
	iftrue AideScript_BetterSafeThanSorry
	writetext AideText_AlwaysBusy
ElmsLab_EndText:
	waitbutton
	closetext
	end

AideScript_BetterSafeThanSorry:
	writetext AideText_BetterSafeThanSorry
	waitbutton
	closetext
	end

AideScript_TheftTestimony:
	writetext AideText_TheftTestimony
	promptbutton
	writetext AideText_AfterTheft
	waitbutton
	closetext
	end

AideScript_AfterTheft:
	writetext AideText_AfterTheft
	waitbutton
	closetext
	end

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

ElmText_Intro: ; TO TRANSLATE
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

ElmText_Insist: ; TO TRANSLATE
	text "Wait? Are you sure"
	line "you don't want a"
	cont "#MON?"
	done

ElmText_AllRighty: ; TO TRANSLATE
	text "All righty then…"
	para "…"
	para "…"
	para "…"
	para "…"
	para "NOW GET OUT YOU"
	line "LITTLE SHI"
	done

ElmText_ResearchAmbitions: ; TO TRANSLATE
	text "When I announce my"
	line "findings, I'm sure"

	para "it will shake the"
	line "scientific"
	cont "community."
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

ElmText_MissionFromMrPokemon: ; TO TRANSLATE
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
	done

ElmText_ChooseAPokemon: ; TO TRANSLATE
	text "I want you to"
	line "raise one of the"

	para "#MON contained"
	line "in these BALLS."

	para "You'll be that"
	line "#MON's first"
	cont "partner, <PLAY_G>."

	para "Go on. Pick one!"
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

ElmDirectionsText1: ; TO TRANSLATE
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
	done

ElmDirectionsText2: ; TO TRANSLATE
	text "If your #MON is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

	para "It can heal their"
	line "health points but"
	cont "won't get rid of"
	cont "viruses I'm afraid…"

	para "Feel free to use"
	line "it anytime."
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

ElmDescribesMrPokemonText: ; TO TRANSLATE
	text "MR.#MON goes"
	line "everywhere and"
	cont "finds rarities."

	para "Go fetch this"
	line "PARCEL he got"
	cont "for me, will you?"
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

ElmAfterTheftText1: ; TO TRANSLATE
	text "ELM: <PLAY_G>, this"
	line "is terrible…"

	para "…"

	para "Oh, yes, what was"
	line "MR.#MON's big"
	cont "discovery?"
	done

ElmAfterTheftText2: ; TO TRANSLATE
	text "<PLAYER> handed"
	line "the PARCEL to"
	cont "PROF.ELM."
	done

ElmAfterTheftText3: 
if DEF(_FR_FR)
	text "PROF.ORME: Ca?"
else
	text "ELM: This?"
endc

	done

ElmAfterTheftText4: ; TO TRANSLATE
	text "But… how did he"
	line "get this?"

	para "It's going to"
	line "help a lot with my"
	cont "research!"
	done

ElmAfterTheftText5: ; TO TRANSLATE
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
	done

ElmIsItOfficialText: ; TO TRANSLATE
	text "Is he going to"
	line "make it official?"
	done

ElmListenRadioText: ; TO TRANSLATE
	text "Let's listen to it"
	line "on my computer!"
	done

ElmCovidAnnouncementText: ; TO TRANSLATE
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
	done

ElmWorksWithOakText: ; TO TRANSLATE
	text "So now the word"
	line "is out."
	done

ElmAfterTheftText6: ; TO TRANSLATE
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
	done

ElmInsistOnGettingHelpText: ; TO TRANSLATE
	text "This work is"
	line "crucial and will"
	cont "save lives."

	para "I need you"
	line "to help me!"
	done

ElmMissionAcceptedText: ; TO TRANSLATE
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
	done

ElmFindPatientZeroText: ; TO TRANSLATE
	text "ELM: Don't give up!"
	line "Find patient zero!"
	done

ElmLockdownAnnouncementText: ; TO TRANSLATE
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
	done

ElmLockdownCurfewVisitText: ; TO TRANSLATE
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
	done

ElmVaccinePassportText: ; TO TRANSLATE
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
	done

ElmCurfewDayVisitText: ; TO TRANSLATE
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
	done

ElmFinalText: ; TO TRANSLATE
	text "ELM: Mission"
	line "succeeded!"
	done

ElmFinalText2::
	text "Thank you for"
	line "your help against"
	cont "COVID-19!"
	done

AideText_AfterTheft: 
if DEF(_FR_FR)
	text "...(soupir)..."
	line "Ce #MON volé..."

	para "Je me demande"
	line "comment il va."

	para "On dit qu'un"
	line "#MON élevé par"

	para "un méchant p'tit"
	line "bonhomme tourne"
	cont "mal lui aussi."
else
	text "…sigh… That"
	line "stolen #MON."

	para "I wonder how it's"
	line "doing."

	para "They say a #MON"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
endc

	done

ElmGiveWorkVisaText1: ; TO TRANSLATE
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
	done

ElmGiveWorkVisaText2: ; TO TRANSLATE
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
	done

ElmGiveVaccineText1: ; TO TRANSLATE
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
	done

ElmGiveVaccineText2: ; TO TRANSLATE
	text "For this reason,"
	line "a lot of people"
	
	para "are mistrustful"
	line "because they think"
	
	para "it hasn't been"
	line "tested thourougly."
	done

ElmGiveVaccineText3: ; TO TRANSLATE
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
	done

ElmGiveVaccineText4: ; TO TRANSLATE
	text "CHIEF NURSE JOY"
	line "is ready to give"

	para "you a shot as we"
	line "speak."
	done

ElmGiveVaccineText5: ; TO TRANSLATE
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
	done

ElmFoundPatientZeroText1: ; TO TRANSLATE
	text "Hello <PLAYER>."
	para "We've got a lot"
	line "to talk about."
	
	para "So please sit."
	done

ElmFoundPatientZeroText2: ; TO TRANSLATE
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
	done

ElmComfortOakText: ; TO TRANSLATE
	text "Poor PROF.OAK."

	para "RED was his"
	line "protege, they"
	cont "were very close."

	para "You should visit"
	line "his lab in PALLET"
	cont "TOWN to comfort"
	cont "him."

	para "…"
	done

ElmFoundPatientZeroText3: ; TO TRANSLATE
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
	done

AideText_GiveYouHandSanitizer: ; TO TRANSLATE
	text "I also want you to"
	line "keep clean hands"
	cont "at all times."

	para "<PLAYER> got some"
	line "HAND SANITIZER!"
	done

AideText_AlwaysBusy: ; TO TRANSLATE
	text "Have you heard"
	line "about the virus"
	cont "on TV?"
	done

AideText_BetterSafeThanSorry: ; TO TRANSLATE
	text "Better safe than"
	line "sorry."

	para "This virus is"
	line "something serious"
	cont "and you should be"
	cont "careful about it."
	done

AideText_TheftTestimony: ; TO TRANSLATE
	text "There was a loud"
	line "noise outside…"

	para "When we went to"
	line "look, someone"
	cont "stole a #MON."

	para "It's unbelievable"
	line "that anyone would"
	cont "do that!"
	done

AideScript_ReadBookshelvesText: ; TO TRANSLATE
	text "Nice to meet you"
	line "<PLAYER>!"

	para "As a new TRAINER,"
	line "you should read"
	cont "all of ELM's books."

	para "They're full of"
	line "great knowledge."
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

ElmsLabTrashcanText: ; TO TRANSLATE
	text "Some used surgical"
	line "masks and gloves…"
	done

ElmsLabPCText: ; TO TRANSLATE
	text "OBSERVATIONS ON"
	line "#MON VIROLOGY"

	para "…It says on the"
	line "screen…"
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
