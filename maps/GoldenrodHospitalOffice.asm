	object_const_def
	const GOLDENRODHOSPITALOFFICE_CHIEF
	const GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT
	const GOLDENRODHOSPITALOFFICE_MARY
	const GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT

GoldenrodHospitalOffice_MapScripts:
	def_scene_scripts
	scene_script .Scene0 ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.Scene0:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5

	checkevent EVENT_PLAYER_CAN_GET_ITS_SECOND_SHOT
	iffalse .checkFirstShot

	prioritysjump .PlayerBoosterScene
	end

.checkFirstShot:
	checkevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	iffalse .end

	prioritysjump .PlayerVaccinationScene
	end

.PlayerWalksToDeskAndSurprisesChiefNurseJoy:
	applymovement PLAYER, GoldenrodHospitalOffice_WalkToDeskMovement
	showemote EMOTE_SHOCK, GOLDENRODHOSPITALOFFICE_CHIEF, 15
	setlasttalked GOLDENRODHOSPITALOFFICE_CHIEF
	faceplayer
	pause 5
	opentext
	end

.PlayerBoosterScene:
	scall .PlayerWalksToDeskAndSurprisesChiefNurseJoy
	writetext GoldenrodHospitalOffice_AskForBoosterText
	yesorno
	iffalse .RefusedBooster

	checkflag ENGINE_TRAINER_CARD
	iffalse .NoTrainerCard

	checkevent EVENT_GOT_FAKE_ID
	iftrue .FakeID

	writetext GoldenrodHospitalOffice_ComeNextToMeText
	scall .end_text

	applymovement PLAYER, GoldenrodHospitalOffice_GoGetBoosterMovement

	faceplayer
	pause 45

	opentext
	writetext GoldenrodHospitalOffice_GotBoosterDoseText
	playsound SFX_CAUGHT_MON
	setevent EVENT_PLAYER_VACCINATED_TWICE
	clearevent EVENT_PLAYER_CAN_GET_ITS_SECOND_SHOT
	waitbutton
	waitsfx
	closetext
	pause 3

	opentext
	writetext GoldenrodHospitalOffice_SecondVaccinePassportUpdateText
	sjump .end_text

.FakeID:
	writetext GoldenrodHospitalOffice_FakeIDText
	sjump .end_text

.NoTrainerCard:
	writetext GoldenrodHospitalOffice_NoTrainerCardText
	sjump .end_text
	
.RefusedBooster:
	writetext GoldenrodHospitalOffice_RefusedBoosterText
	sjump .end_text

.PlayerVaccinationScene:
	scall .PlayerWalksToDeskAndSurprisesChiefNurseJoy
	writetext GoldenrodHospitalOffice_ComingForVaccineText
	yesorno
	iffalse .got_ahead

	clearevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	
	writetext GoldenrodHospitalOffice_PhoneCallsText
	waitbutton
	closetext

	pause 3
	playsound SFX_PUSH_BUTTON
	waitsfx

	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadRightMovement

	pause 10
	playsound SFX_CALL
	pause 60
	waitsfx

	playsound SFX_PUSH_BUTTON
	waitsfx

	pause 5
	faceplayer
	pause 5

	opentext
	writetext GoldenrodHospitalOffice_AfterPhoneCallsText
	promptbutton
	closetext

	pause 35

	opentext
	writetext GoldenrodHospitalOffice_AfterPhoneCalls2Text
	promptbutton
	closetext

	pause 15

	warpsound
	pause 2
	applymovement PLAYER, GoldenrodHospitalOffice_HeadDownMovement
	pause 2
	appear GOLDENRODHOSPITALOFFICE_MARY
	waitsfx


	

	musicfadeout MUSIC_BEAUTY_ENCOUNTER, 8

	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_StepUpMovement
	appear GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT
	follow GOLDENRODHOSPITALOFFICE_MARY, GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_StepLeftMovement
	stopfollow
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_StepUpMovement
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_HeadRightMovement
	
	applymovement PLAYER, GoldenrodHospitalOffice_HeadLeftMovement

	pause 3

	opentext
	writetext GoldenrodHospitalOffice_MaryIntroText
	promptbutton
	closetext

	pause 3
	warpsound
	turnobject GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, UP
	appear GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_ChiefAssistantToDeskMovement
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadRightMovement
	pause 20
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadDownMovement
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_HeadDownMovement
	applymovement PLAYER, GoldenrodHospitalOffice_HeadUpMovement
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_HeadUpMovement

	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_HeadDownMovement
	opentext
	writetext GoldenrodHospitalOffice_VaccineArrivesText
	promptbutton
	writetext GoldenrodHospitalOffice_ComeNextToMeText
	promptbutton
	closetext

	pause 2
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_HeadRightMovement
	pause 2

	opentext
	writetext GoldenrodHospitalOffice_EveryoneInPlaceText
	promptbutton
	closetext

	applymovement PLAYER, GoldenrodHospitalOffice_PlayerWalksToChiefAssistantMovement
	follow GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, PLAYER
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_ChiefAssistantInPlaceMovement
	stopfollow
	applymovement PLAYER, GoldenrodHospitalOffice_StepDownMovement
	;applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadLeftMovement

	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_MaryInPlaceMovement
	applymovement GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT, GoldenrodHospitalOffice_StepUpMovement
	applymovement PLAYER, GoldenrodHospitalOffice_HeadLeftMovement
	
	opentext
	writetext GoldenrodHospitalOffice_LiveCountdownIntroText
	promptbutton
	writetext GoldenrodHospitalOffice_LiveCountdown3Text
	pause 30
	writetext GoldenrodHospitalOffice_LiveCountdown2Text
	pause 30
	writetext GoldenrodHospitalOffice_LiveCountdown1Text
	pause 30

	writetext GoldenrodHospitalOffice_ItwIntroText
	yesorno

	setval 0
	writemem2 wScriptVar

	writetext GoldenrodHospitalOffice_Itw1Text
	yesorno
	iffalse .itw1bad

	scall GoldenrodHospitalOffice_IncPoints
	scall GoldenrodHospitalOffice_IncPoints
	writetext GoldenrodHospitalOffice_Itw1GoodText
	sjump .itw2

.itw1bad
	writetext GoldenrodHospitalOffice_Itw1BadText

.itw2
	promptbutton
	writetext GoldenrodHospitalOffice_Itw2Text
	yesorno
	iffalse .itw2bad

	scall GoldenrodHospitalOffice_IncPoints

.itw2bad
	writetext GoldenrodHospitalOffice_Itw2SequelText
	promptbutton
	closetext

	pause 3
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadLeftMovement
	pause 3

	opentext
	writetext GoldenrodHospitalOffice_Itw2NurseText
	waitbutton
	closetext

	pause 3
	applymovement PLAYER, GoldenrodHospitalOffice_HeadDownMovement

	pause 45

	opentext
	writetext GoldenrodHospitalOffice_PlayerVaccinatedText
	playsound SFX_CAUGHT_MON
	setevent EVENT_PLAYER_VACCINATED_ONCE
	waitbutton
	waitsfx
	closetext
	pause 3

	opentext
	writetext GoldenrodHospitalOffice_Itw2Nurse2Text
	promptbutton
	closetext

	; Player moves back.
	applymovement PLAYER, GoldenrodHospitalOffice_PlayerMakesSomeRoomMovement
	pause 3

	opentext
	writetext GoldenrodHospitalOffice_Itw2Nurse3Text
	waitbutton
	closetext

	; player moves back in and faces nurse.
	applymovement PLAYER, GoldenrodHospitalOffice_PlayerReceivesGiftMovement

	opentext
	verbosegiveitem S_S_TICKET
	playsound SFX_KEY_ITEM
	waitsfx
	writetext ElmGiveTicketText2
	waitbutton
	closetext
	setevent EVENT_OLIVINE_GYM_JASMINE ; Jasmine board the SS Aqua.

	pause 3
	;applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadRightMovement
	;pause 3

	applymovement PLAYER, GoldenrodHospitalOffice_HeadLeftMovement
	opentext
	writetext GoldenrodHospitalOffice_Itw3Text
	yesorno
	iftrue .itw3bad

	scall GoldenrodHospitalOffice_IncPoints
	writetext GoldenrodHospitalOffice_Itw3GoodText
	sjump .itw4

.itw3bad
	writetext GoldenrodHospitalOffice_Itw3BadText

.itw4
	promptbutton
	writetext GoldenrodHospitalOffice_Itw4Text
	yesorno
	iffalse .itw4bad

	scall GoldenrodHospitalOffice_IncPoints
	scall GoldenrodHospitalOffice_IncPoints
	writetext GoldenrodHospitalOffice_Itw4GoodText
	sjump .itwend

.itw4bad
	writetext GoldenrodHospitalOffice_Itw4BadText

.itwend
	promptbutton
	writetext GoldenrodHospitalOffice_ItwEndText
	waitbutton
	closetext

	musicfadeout MUSIC_GOLDENROD_CITY, 8

	pause 30

	; Do the interview while you get vaccinated.
	; At the end of the interview, you get the SS AQUA TICKET from CHIEF NURSE JOY.
	; 
	; 1 dummy question: "How are you doing today? YES/NO"
	; 4 real questions that determine the price you'll get from Mary. 
	; 0-1 point = nothing;. bad
	; 2-3 points = 1 Ultra Ball. so-so
	; 4 points = 5 Ultra Ball. ok
	; 5 points = 5 HP_UP. went well
	; 6 points = 12 PP_UP. amazing

	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadDownMovement

	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_StepDownTwiceMovement

	follow GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT, GOLDENRODHOSPITALOFFICE_MARY
	applymovement GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT, GoldenrodHospitalOffice_StepDownTwiceMovement
	stopfollow

	warpsound
	disappear GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_HeadRightMovement

	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_StepRightMovement
	follow GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, PLAYER
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_ChiefAssistantOutMovement
	stopfollow

	warpsound
	disappear GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT

	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_HeadRightMovement
	applymovement PLAYER, GoldenrodHospitalOffice_HeadLeftMovement

	readmem wScriptVar2
	ifless 2, .resultNothing
	ifless 4, .resultSoSo
	ifequal 4, .resultOk
	ifequal 5, .resultWell

;.resultAmazing ; Max points
	opentext
	writetext GoldenrodHospitalOffice_ResultAmazingText
	promptbutton
	verbosegiveitem PP_UP, 12
	writetext GoldenrodHospitalOffice_PackOf8Text
	waitbutton
	closetext
	pause 3
	showemote EMOTE_HEART, GOLDENRODHOSPITALOFFICE_MARY, 30
	sjump .resultEnd

.resultNothing
	showemote EMOTE_SAD, GOLDENRODHOSPITALOFFICE_MARY, 15
	opentext
	writetext GoldenrodHospitalOffice_ResultBadText
	pause 30
	closetext
	sjump .resultEnd

.resultSoSo
	opentext
	writetext GoldenrodHospitalOffice_ResultSoSoText
	promptbutton
	verbosegiveitem ULTRA_BALL
	closetext
	sjump .resultEnd

.resultOk
	showemote EMOTE_HAPPY, GOLDENRODHOSPITALOFFICE_MARY, 15
	opentext
	writetext GoldenrodHospitalOffice_ResultOkText
	promptbutton
	verbosegiveitem ULTRA_BALL, 5
	writetext GoldenrodHospitalOffice_PackOf5Text
	promptbutton
	writetext GoldenrodHospitalOffice_CatchYouLaterText
	waitbutton
	closetext
	sjump .resultEnd

.resultWell
	showemote EMOTE_HAPPY, GOLDENRODHOSPITALOFFICE_MARY, 30
	opentext
	writetext GoldenrodHospitalOffice_ResultWellText
	promptbutton
	verbosegiveitem HP_UP, 5
	writetext GoldenrodHospitalOffice_PackOf5Text
	promptbutton
	writetext GoldenrodHospitalOffice_CatchYouLaterText
	waitbutton
	closetext

.resultEnd
	pause 5

	setval 0
	writemem2 wScriptVar
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6

	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_DownRightStepMovement
	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_HeadDownMovement
	applymovement PLAYER, GoldenrodHospitalOffice_HeadDownMovement
	warpsound
	disappear GOLDENRODHOSPITALOFFICE_MARY




.end:
	end

.got_ahead:
	writetext GoldenrodHospitalOffice_NotComingForVaccineText
.end_text:
	waitbutton
	closetext
	end

.EnterCallback:
	disappear GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT
	disappear GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT
	disappear GOLDENRODHOSPITALOFFICE_MARY

	checkmapscene GOLDENROD_HOSPITAL_CORRIDOR
	ifnotequal SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_2, .skip_hospital_quest_step_inc
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_3
.skip_hospital_quest_step_inc
	checkevent EVENT_SICK_CATERPIE
	iffalse .HideChiefNurse
	appear GOLDENRODHOSPITALOFFICE_CHIEF
	endcallback

.HideChiefNurse:
	disappear GOLDENRODHOSPITALOFFICE_CHIEF
	endcallback

GoldenrodHospitalOffice_IncPoints:
	readmem wScriptVar2
	addval 1
	writemem2 wScriptVar
	end

GoldenrodHospitalOfficeChiefScript: ; Chief Nurse Joy doesn't get distracted by the player's clapping. She's sharp!
	faceplayer
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .thanksForVaccine

	checkevent EVENT_GOT_LUCKY_EGG
	iffalse .giveLuckyEgg

	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .cantTakeABreak

	opentext
	writetext GoldenrodHospitalOffice_AskVariantText
	promptbutton
	special TellCovidVariant
	ifequal VARIANT_TELLING_CANCEL, .visiting
	ifequal VARIANT_TELLING_NEVER_GOT_COVID_OR_TOO_LONG_AGO, .tooOld
	ifequal VARIANT_TELLING_IS_VACCINATED, .vaccinated

	; wScriptVar = VARIANT_TELLING_TELL
	writetext GoldenrodHospitalOffice_TellVariantText

.waitbutton
	waitbutton
	closetext
	end

.visiting
	writetext GoldenrodHospitalOffice_VisitingText
	sjump .waitbutton

.tooOld
	writetext GoldenrodHospitalOffice_TooOldText
	sjump .waitbutton
	
.vaccinated
	writetext GoldenrodHospitalOffice_VaccinatedText
	sjump .waitbutton

.cantTakeABreak
	jumptext GoldenrodHospitalOfficeChiefText

.giveLuckyEgg
	opentext
	writetext GoldenrodHospitalOfficeChiefLuckyEggText
	promptbutton
	verbosegiveitem LUCKY_EGG
	setevent EVENT_GOT_LUCKY_EGG
	writetext GoldenrodHospitalOfficeChiefLuckyEggSequelText
	waitbutton
	closetext
	end

.thanksForVaccine
	jumptext GoldenrodHospitalOffice_ThanksVaccineText

GoldenrodHospitalOfficePrinterScript:
	jumptext GoldenrodHospitalOfficePrinterText

GoldenrodHospitalOfficeDiplomaScript:
	jumptext VeryPrestigiousDiplomaText

GoldenrodHospitalBookshelfScript:
	jumpstd DifficultBookshelfScript
	
GoldenrodHospitalOffice_WalkToDeskMovement:
	step UP
	step RIGHT
	step UP
	step_end

GoldenrodHospitalOffice_HeadUpMovement:
	turn_head UP
	step_end

GoldenrodHospitalOffice_ChiefAssistantToDeskMovement:
	step UP
	step RIGHT
	step UP
	step RIGHT
	step UP
	step UP
GoldenrodHospitalOffice_HeadLeftMovement:
	turn_head LEFT
	step_end

GoldenrodHospitalOffice_PlayerMakesSomeRoomMovement:
	step UP
	step RIGHT
	turn_head LEFT
	step_end

GoldenrodHospitalOffice_PlayerReceivesGiftMovement:
	step LEFT
	step DOWN
	turn_head RIGHT
	step_end

GoldenrodHospitalOffice_PlayerWalksToChiefAssistantMovement:
	step RIGHT
	step RIGHT
GoldenrodHospitalOffice_StepUpMovement:
	step UP
	step_end

GoldenrodHospitalOffice_ChiefAssistantInPlaceMovement:
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
GoldenrodHospitalOffice_HeadDownMovement:
	turn_head DOWN
	step_end

GoldenrodHospitalOffice_MaryInPlaceMovement:
	step LEFT
	step UP
	step UP
GoldenrodHospitalOffice_HeadRightMovement:
	turn_head RIGHT
	step_end

GoldenrodHospitalOffice_StepLeftMovement:
	step LEFT
	step_end

GoldenrodHospitalOffice_MaryAfterItwMovement:
	step DOWN
GoldenrodHospitalOffice_DownRightStepMovement:
	step DOWN
GoldenrodHospitalOffice_StepRightMovement:
	step RIGHT
	step_end

GoldenrodHospitalOffice_ChiefAssistantOutMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step LEFT

GoldenrodHospitalOffice_StepDownTwiceMovement:
	step DOWN
GoldenrodHospitalOffice_StepDownMovement:
	step DOWN
	step_end

GoldenrodHospitalOffice_GoGetBoosterMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step DOWN
	step_end

GoldenrodHospitalOfficeChiefText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Je ne peux"
	cont "pas me permettre"
	cont "de me reposer"
	cont "avec tous les"
	cont "nouveaux patients"
	cont "qui affluent"
	cont "chaque jour."
else
	text "CHIEF NURSE JOY:"
	line "I can't afford to"
	cont "take a break with"
	cont "all the new"
	cont "patients arriving"
	cont "every day."
endc
	done

GoldenrodHospitalOffice_AskVariantText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Hé <PLAYER>,"

	para "je peux te dire"
	line "quel variant ton"

	para "#MON avait lors"
	line "de son dernier"
	cont "test PCR."

	para "Pour quel #MON"
	line "tu veux savoir?"
else
	text "CHIEF NURSE JOY:"
	line "Hey <PLAYER>,"

	para "I can tell you"
	line "which variant your"

	para "#MON had last"
	line "time they did a"
	cont "PCR test."

	para "For which #MON"
	line "would you like"
	cont "to know?"
endc
	done

GoldenrodHospitalOffice_VisitingText:
if DEF(_FR_FR)
	text "Les patients doi-"
	line "vent supporter"
	cont "la solitude."

	para "Leur rendre visite"
	line "les rend plus"
	cont "heureux."
else
	text "Patients are often"
	line "lonely."

	para "Visiting them ma-"
	line "kes them happier."
endc
	done

GoldenrodHospitalOffice_TooOldText:
if DEF(_FR_FR)
	text "Je ne pourrais pas"
	line "te dire pour"
	cont "celui-ci."

	para "Soit ce #MON n'a"
	line "jamais été testé"
	
	para "positif au COVID,"
	line "soit le test est"
	cont "trop ancien."
else
	text "I can't tell for"
	line "this one."

	para "Either this"
	line "#MON never got"
	
	para "tested positive"
	line "for COVID,"
	
	para "or the test was"
	line "done too long ago."
endc
	done

GoldenrodHospitalOffice_VaccinatedText:
if DEF(_FR_FR)
	text "Je vois que ce"
	line "#MON a été"
	cont "vacciné, bravo!"
else
	text "I see this #MON"
	line "got vaccinated,"
	cont "congratulations!"
endc
	done

GoldenrodHospitalOffice_TellVariantText:
if DEF(_FR_FR)
	text "Lors de son der-"
	line "nier test, ce"
	
	para "#MON avait le"
	line "variant @"
	text_ram wStringBuffer2
	text "."

	para "Continue à faire"
	line "dépister tes"
	cont "#MON!"
else
	text "Last time this"
	line "#MON got tested"

	para "it had the"
	line "@"

	text_ram wStringBuffer2
	text " variant."

	para "Keep testing"
	line "your #MON!"
endc
	done

GoldenrodHospitalOfficeChiefLuckyEggText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Je ne t'ai"
	cont "pas remercié con-"
	cont "venablement pour"
	cont "m'avoir aidé à me"
	cont "détendre la der-"
	cont "nière fois."
else
	text "CHIEF NURSE JOY:"
	line "I didn't properly"
	cont "thank you for"
	cont "helping me relax"
	cont "last time."
endc
	done

GoldenrodHospitalOfficeChiefLuckyEggSequelText:
if DEF(_FR_FR)
	text "Un #MON qui"
	line "tient ceci pro-"
	cont "gresse deux fois"
	cont "plus vite!"
	
	para "Utilise-le"
	line "avec sagesse!"
else
	text "A #MON that"
	line "holds this grows"

	para "twice as fast!"
	line "Use it wisely!"
endc
	done

GoldenrodHospitalOfficePrinterText:
if DEF(_FR_FR)
	text "L'écran indique"
	line "“Plus de papier”"
else
	text "The screen says"
	line "“Out of paper”"
endc
	done

VeryPrestigiousDiplomaText:
if DEF(_FR_FR)
	text "Un diplôme d'une"
	line "prestigieuse école"
	cont "de médecine."
else
	text "A diploma from a"
	line "very prestigious"
	cont "medical school."
endc
	done

GoldenrodHospitalOffice_ComingForVaccineText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Salut"
	cont "<PLAYER>, tu viens"
	cont "pour te faire"
	cont "vacciner?"
else
	text "CHIEF NURSE JOY:"
	line "Hello <PLAYER>,"
	cont "are you coming to"
	cont "get vaccinated?"
endc
	done

GoldenrodHospitalOffice_NotComingForVaccineText:
if DEF(_FR_FR)
	text "Ah pardon. Je"
	line "me suis un peu"
	cont "trop avancée."
else
	text "Oh OK. I got"
	line "ahead of myself."
endc
	done

GoldenrodHospitalOffice_PhoneCallsText:
if DEF(_FR_FR)
	text "Formidable! Il"
	line "faut juste que je"
	cont "passe quelques"
	cont "coups de fil."
else
	text "Amazing! I need"
	line "to make a few"
	cont "phone calls."
endc
	done

GoldenrodHospitalOffice_AfterPhoneCallsText:
if DEF(_FR_FR)
	text "Tu as pris la"
	line "bonne décision!"

	para "Tu seras la pre-"
	line "mière personne à"
	cont "recevoir une"
	cont "injection dans"
	cont "cette région."

	para "..."

	para "Elle devrait arri-"
	line "ver d'une seconde"
	cont "à l'autre."

	para "Elle travaille"
	line "juste à côté"
	cont "après tout."
else
	text "So it's happening!"

	para "You'll be the first"
	line "one to get a shot"
	cont "in this region."

	para "…"

	para "She should be here"
	line "any second."
	
	para "She works next"
	line "block after all."
endc
	done

GoldenrodHospitalOffice_AfterPhoneCalls2Text:
if DEF(_FR_FR)
	text "Le PROF.ORME t'a"
	line "parlé de l'inter-"
	cont "view, n'est-ce pas?"
else
	text "PROF.ELM has told"
	line "you about the"
	cont "interview, right?"
endc
	done

GoldenrodHospitalOffice_MaryIntroText:
if DEF(_FR_FR)
	text "LULA: Je vais"
	line "enfin obtenir"
	cont "l'interview que"
	cont "tu me dois,"
	cont "CHAMPION!"

	para "Pas question de"
	line "t'enfuir cette"
	cont "fois-ci!"
else
	text "MARY: I'm finally"
	line "going to get this"
	cont "interview you owe"
	cont "me, CHAMPION!"

	para "No running away"
	line "this time!"
endc
	done

GoldenrodHospitalOffice_VaccineArrivesText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Vous pouvez"
	cont "commencer, tout"
	cont "est prêt."
else
	text "CHIEF NURSE JOY:"
	line "You should start"
	cont "rolling, we're"
	cont "ready."
endc
	done

GoldenrodHospitalOffice_ComeNextToMeText:
if DEF(_FR_FR)
	text "Viens à côté de"
	line "moi, <PLAYER>."
else
	text "Come next to me"
	line "<PLAYER>."
endc
	done

GoldenrodHospitalOffice_EveryoneInPlaceText:
if DEF(_FR_FR)
	text "LULA: Oki doki,"
	line "tout le monde en"
	cont "place!"
else
	text "MARY: All righty,"
	line "everyone in place!"
endc
	done

GoldenrodHospitalOffice_LiveCountdownIntroText:
if DEF(_FR_FR)
	text "LULA: On est"
	line "en direct dans..."
else
	text "MARY: We're live"
	line "in…"
endc
	done

GoldenrodHospitalOffice_LiveCountdown3Text:
if DEF(_FR_FR)
	text "3..."
	done
else
	text "3…"
	done
endc

GoldenrodHospitalOffice_LiveCountdown2Text:
if DEF(_FR_FR)
	text "2..."
	done
else
	text "2…"
	done
endc

GoldenrodHospitalOffice_LiveCountdown1Text:
if DEF(_FR_FR)
	text "1..."
	done
else
	text "1…"
	done
endc

GoldenrodHospitalOffice_ItwIntroText:
if DEF(_FR_FR)
	text "LULA: Bonjour à"
	line "tous!"

	para "Aujourd'hui je suis"
	line "avec nul autre"
	cont "que le CHAMPION"
	cont "de la LIGUE!"

	para "<PLAYER>, comment"
	line "tu vas aujourd'hui?"
else
	text "MARY: Hi everyone!"
	line "Today I'm with no"
	cont "one but the one"
	cont "LEAGUE CHAMPION!"

	para "<PLAYER>, how are"
	line "doing today?"
endc
	done

GoldenrodHospitalOffice_Itw1Text:
if DEF(_FR_FR)
	text "LULA: Excellent!"

	para "Félicitations pour"
	line "ta victoire sur"
	cont "le CONSEIL des 4."

	para "Les combats ont"
	line "été rudes!"

	para "Tu éprouves de la"
	line "de la fierté pour"
	cont "tes #MON?"
else
	text "MARY: All right!"

	para "Congratulations on"
	line "your victory over"
	cont "the ELITE 4."

	para "The battles were"
	line "fierce!"

	para "Are you proud of"
	line "your #MON?"
endc
	done

GoldenrodHospitalOffice_Itw1GoodText:
if DEF(_FR_FR)
	text "LULA: Comme c'est"
	line "mignon de ta part!"
else
	text "MARY: How sweet"
	line "of you!"
endc
	done

GoldenrodHospitalOffice_Itw1BadText:
if DEF(_FR_FR)
	text "LULA: Trop timide"
	line "pour l'admettre?"
else
	text "MARY: Too shy to"
	line "say it?"
endc
	done

GoldenrodHospitalOffice_Itw2Text:
if DEF(_FR_FR)
	text "Nous avons une"
	line "exclusivité:"
	cont "tu vas recevoir la"
	cont "première injection"
	cont "du vaccin à JOHTO!"

	para "Certains ont"
	line "exprimé leur"
	cont "méfiance envers"
	cont "ce vaccin."

	para "Et toi? Tu as"
	line "confiance?"
else
	text "We have an exclu-"
	line "sive info: you are"
	cont "about to receive"
	cont "the first vaccine"
	cont "shot in JOHTO!"

	para "Some people have"
	line "expressed their"
	cont "distrust against"
	cont "this vaccine."

	para "Do you trust it?"
endc
	done

GoldenrodHospitalOffice_Itw2SequelText:
if DEF(_FR_FR)
	text "LULA: Je te coupe,"
	line "c'est en train de"
	cont "se produire."
else
	text "MARY: I have to"
	line "cut you, it is"
	cont "happening."
endc
	done

GoldenrodHospitalOffice_Itw2NurseText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Je procède"
	cont "maintenant à"
	cont "l'injection."
else
	text "CHIEF NURSE JOY:"
	line "I'm proceeding to"
	cont "the injection now."
endc
	done

GoldenrodHospitalOffice_PlayerVaccinatedText:
if DEF(_FR_FR)
	text "<PLAYER> a reçu"
	line "le vaccin."
else
	text "<PLAYER> is now"
	line "vaccinated."
endc
	done

GoldenrodHospitalOffice_Itw2Nurse2Text:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: C'est"
	cont "terminé!"

	para "Ton bras gauche"
	line "peut rester un peu"
	cont "engourdi le reste"
	cont "de la journée."

	para "J'aimerais qu'on me"
	line "passe le micro"
	cont "s'il vous plaît."
else
	text "CHIEF NURSE JOY:"
	line "That's all!"

	para "Your left arm may"
	line "feel a little"
	cont "numb for the day."

	para "I'd like to talk"
	line "into the micro-"
	cont "phone please."
endc
	done

GoldenrodHospitalOffice_Itw2Nurse3Text:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Ce vaccin ne"
	cont "protège pas seule-"
	cont "ment <PLAYER>,"

	para "mais aussi son"
	line "entourage."

	para "Le port du masque"
	line "reste obligatoire"
	cont "afin de réduire"
	cont "davantage le"
	cont "risque de"
	cont "contamination."

	para "Se faire vacciner"
	line "est le moyen de"
	cont "retrouver notre"
	cont "vie d'avant la"
	cont "pandémie."

	para "Je vais à présent"
	line "mettre à jour la"
	cont "CARTE DRESSEUR de"
	cont "<PLAYER> avec le"
	cont "PASS VACCINAL."

	para "Il donne le droit"
	line "de franchir nos"
	cont "frontières natio-"
	cont "nales légalement."

	para "Et pour fêter ça,"
	line "voici un cadeau."
else
	text "CHIEF NURSE JOY:"
	line "This shot will"
	cont "not only protect"
	cont "<PLAYER>, but also"
	cont "people around."

	para "Wearing the face"
	line "mask is still"
	cont "required to"
	cont "further reduce"
	cont "the risk of"
	cont "contamination."

	para "Getting a shot is"
	line "the way of"
	cont "retrieving our"
	cont "lives from before"
	cont "the pandemic."

	para "I will now upgrade"
	line "<PLAYER>'s TRAINER"
	cont "CARD with a"
	cont "VACCINE PASSPORT."
	
	para "It gives the"
	line "legal right to"
	cont "go outside our"
	cont "national borders."

	para "And to celebrate"
	line "this, here is a"
	cont "gift."
endc
	done

ElmGiveTicketText2:
if DEF(_FR_FR)
	text "Le bateau part"
	line "d'OLIVILLE."

	para "Transmets mes"
	line "amitiés au"
	cont "PROF.CHEN à KANTO!"
else
	text "The ship departs"
	line "from OLIVINE CITY."

	para "Give my regards to"
	line "PROF.OAK in KANTO!"
endc
	done

GoldenrodHospitalOffice_Itw3Text:
if DEF(_FR_FR)
	text "LULA: C'est"
	line "officiel!"
	
	para "<PLAYER> vient de"
	line "se faire vacciner!"

	para "Alors, c'était"
	line "douloureux?"
else
	text "MARY: It's official"
	line "<PLAYER> just"
	cont "received the shot!"

	para "Was it painful?"
endc
	done

GoldenrodHospitalOffice_Itw3GoodText:
if DEF(_FR_FR)
	text "LULA: C'est bon à"
	line "savoir!"
	
	para "Vous qui nous"
	line "écoutez, n'ayez"
	cont "rien à craindre!"
else
	text "MARY: That's good"
	line "to hear!"

	para "Don't be afraid"
	line "people!"
endc
	done

GoldenrodHospitalOffice_Itw3BadText:
if DEF(_FR_FR)
	text "LULA: Ahah, bonne"
	line "blague! C'est pas"
	cont "une petite piqûre"
	cont "qui va faire du"
	cont "mal au CHAMPION"
	cont "de la LIGUE!"
else
	text "MARY: Ahah, good"
	line "joke! A little"
	cont "needle wouldn't"
	cont "hurt our though"
	cont "LEAGUE CHAMPION!"
endc
	done

GoldenrodHospitalOffice_Itw4Text:
if DEF(_FR_FR)
	text "J'ai une dernière"
	line "question."

	para "Penses-tu que les"
	line "gens devraient se"
	cont "faire vacciner?"
else
	text "I have one"
	line "last question."
	
	para "Do you think"
	line "people should"
	cont "get vaccinated?"
endc
	done

GoldenrodHospitalOffice_Itw4GoodText:
if DEF(_FR_FR)
	text "LULA: Venant de la"
	line "bouche de notre"
	cont "CHAMPION, j'ai très"
	cont "envie de me faire"
	cont "vacciner"
	cont "maintenant!"
else
	text "MARY: Well, coming"
	line "from the CHAMPION,"
	cont "now I sure want my"
	cont "shot as well!"
endc
	done

GoldenrodHospitalOffice_Itw4BadText:
if DEF(_FR_FR)
	text "LULA: Je vois ce"
	line "que tu veux dire."

	para "Les gens ne"
	line "devraient pas."
	cont "Ils DOIVENT."

	para "C'est notre devoir"
	line "de combattre le"
	cont "virus, comme tu"
	cont "nous l'as montré"
	cont "aujourd'hui."

	para "C'est comme ça que"
	line "nous reviendrons à"
	cont "une vie normale."
else
	text "MARY: I see what"
	line "you mean."

	para "People shouldn't,"
	line "they MUST."
	
	para "It is our duty to"
	line "fight the virus,"
	cont "just like you"
	cont "showed us today."

	para "So we can go back"
	line "to normal life."
endc
	done

GoldenrodHospitalOffice_ItwEndText:
if DEF(_FR_FR)
	text "Merci infiniment"
	line "pour ton temps,"
	cont "<PLAYER>."

	para "A vous les"
	line "studios!"
else
	text "Thank you so"
	line "much for your"
	cont "time <PLAYER>."

	para "Back to you, Tom."
endc
	done

GoldenrodHospitalOffice_ResultBadText:
if DEF(_FR_FR)
	text "C'était quoi ça,"
	line "<PLAYER>?"

	para "T'as répondu à mes"
	line "questions comme si"
	cont "c'était des blagues"
	cont "et envoyé de très"
	cont "mauvaises ondes."

	para "Cette interview"
	line "m'a mise mal à"
	cont "l'aise."
else
	text "What was that"
	line "<PLAYER>?"

	para "You replied to my"
	line "questions like"
	cont "they were jokes"
	cont "and sent very bad"
	cont "signals."

	para "This interview"
	line "made me"
	cont "uncomfortable."
endc
	done

GoldenrodHospitalOffice_ResultSoSoText:
if DEF(_FR_FR)
	text "Cette interview"
	line "aurait pu mieux"
	cont "se passer."

	para "Je suis un peu"
	line "déçue."

	para "Ce n'était pas la"
	line "meilleure version"
	cont "de toi-même."

	para "C'est pas grave,"
	line "prends ceci pour"
	cont "ton temps."
else
	text "This interview"
	line "could have gone"
	cont "better."

	para "I am a little"
	line "disappointed."

	para "It wasn't the best"
	line "version of"
	cont "yourself."

	para "Anyway, take this"
	line "for your time."
endc
	done

GoldenrodHospitalOffice_ResultOkText:
if DEF(_FR_FR)
	text "L'interview était"
	line "pas mal."

	para "Merci encore de"
	line "d'avoir joué"
	cont "le jeu."

	para "Prends ceci pour"
	line "ton temps."
else
	text "The interview was"
	line "ok!"

	para "Thanks again for"
	line "doing this."

	para "Please take this"
	line "for your time."
endc
	done

GoldenrodHospitalOffice_ResultWellText:
if DEF(_FR_FR)
	text "L'interview s'est"
	line "bien déroulée, je"
	cont "suis ravie de"
	cont "l'avoir enfin eue!"

	para "Je suis sûre que"
	line "tu as convaincu"
	cont "plein de gens de"
	cont "se faire vacciner,"
	cont "c'est top!"

	para "Nous aimerions que"
	line "tu prennes ceci."
else
	text "The interview went"
	line "well, I'm glad we"
	cont "finally did it!"

	para "I'm sure you have"
	line "convinced a lot"
	cont "of people to get"
	cont "vaccinated, that's"
	cont "good!"

	para "We would like you"
	line "to take this."
endc
	done

GoldenrodHospitalOffice_ResultAmazingText:
if DEF(_FR_FR)
	text "<PLAYER>."

	para "Cette interview"
	line "était incroyable!"

	para "La meilleure que"
	line "j'aie jamais faite!"

	para "Ta première"
	line "réponse était"
	cont "confuse,"

	para "mais ensuite tu as"
	line "sû te ressaisir et"
	cont "tu as géré avec"
	cont "talent!"

	para "Je suis sûre que"
	line "beaucoup voudront"
	cont "se faire vacciner"
	cont "grâce à toi!"

	para "Tu pourrais avoir"
	line "sauvé de nombreu-"
	cont "ses vies avec tes"
	cont "mots aujourd'hui!"

	para "Je te prie"
	line "d'accepter ce"
	cont "cadeau en gage de"
	cont "ma reconnaissance."
else
	text "<PLAYER>."

	para "This interview was"
	line "amazing!"

	para "Best interview I"
	line "have ever done!"

	para "Your first answer"
	line "didn't make sense."

	para "But once you got"
	line "the hang of"
	cont "yourself,"

	para "you seemed so"
	line "perfect!"

	para "I'm sure lots of"
	line "people will want"
	cont "to get vaccinated"
	cont "thanks to you!"

	para "You may have saved"
	line "a lot of lives"
	cont "today!"

	para "Please accept this"
	line "present as a"
	cont "token of my"
	cont "appreciation."
endc
	done

GoldenrodHospitalOffice_PackOf5Text:
if DEF(_FR_FR)
	text "On offre ces lots"
	line "dans l'émission de"
	cont "BUENA, alors on en"
	cont "a plein en"
	cont "stock."
else
	text "We give those"
	line "away in BUENA's"
	cont "PASSWORD show,"
	cont "so we have plenty"
	cont "of these."
endc
	done

GoldenrodHospitalOffice_PackOf8Text:
if DEF(_FR_FR)
	text "Pas facile d'en"
	line "obtenir, c'est"
	cont "très rare."

	para "J'espère que cela"
	line "sera suffisant"
	cont "pour ton temps."

	para "J'ai hâte de"
	line "pouvoir t'inter-"
	cont "viewer à nouveau!"
else
	text "Those are very"
	line "hard to find."
	
	para "I hope this is"
	line "enough for your"
	cont "time."

	para "I'm looking forward"
	line "to interviewing"
	cont "you again!"
endc
	done

GoldenrodHospitalOffice_CatchYouLaterText:
if DEF(_FR_FR)
	text "A la prochaine!"
else
	text "Catch you later."
endc
	done

GoldenrodHospitalOffice_ThanksVaccineText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Merci d'avoir"
	cont "montré l'exemple!"
else
	text "CHIEF NURSE JOY:"
	line "Thanks for showing"
	cont "the example!"
endc
	done

GoldenrodHospitalOffice_AskForBoosterText:
if DEF(_FR_FR)
	text "INFIRMIERE EN"
	line "CHEF: Ravie de"
	cont "te revoir!"

	para "Ca fait assez"
	line "longtemps depuis"
	
	para "ta dernière dose"
	line "de vaccin."

	para "C'est parti pour"
	line "ta dose de rappel?"
else
	text "CHIEF NURSE JOY:"
	line "Nice to see you!"

	para "It has been long"
	line "enough since you"
	
	para "got your last"
	line "vaccine dose."

	para "Ready to get"
	line "your booster?"
endc
	done

GoldenrodHospitalOffice_RefusedBoosterText:
if DEF(_FR_FR)
	text "Tu es libre de ne"
	line "pas le prendre."
	
	para "Mais ton PASS"
	line "VACCINAL ne sera"
	cont "plus valable."
else
	text "You are free to"
	line "not take it."
	
	para "But your VACCINE"
	line "PASSPORT will be"
	cont "invalidated."
endc
	done

GoldenrodHospitalOffice_NoTrainerCardText:
if DEF(_FR_FR)
	text "Attends, tu n'as"
	line "pas ta CARTE"
	cont "DRESSEUR?"
	
	para "J'en ai besoin"
	line "pour mettre à jour"
	cont "ton PASS VACCINAL."
	
	para "Reviens avec."
else
	text "Wait, you don't"
	line "have your TRAINER"
	cont "CARD?"
	
	para "I need it to up-"
	line "date your VACCINE"
	cont "PASSPORT."
	
	para "Come back with it."
endc
	done

GoldenrodHospitalOffice_FakeIDText:
if DEF(_FR_FR)
	text "Euh... elle est"
	line "à qui cette"
	cont "CARTE DRESSEUR?"

	para "Tu as peut-être"
	line "pris celle de"
	cont "quelqu'un d'autre"
	cont "par erreur?"

	para "Repasse avec la"
	line "tienne."
else
	text "Uh… whose TRAINER"
	line "CARD is this?"

	para "You may have taken"
	line "someone else's."

	para "Come back with"
	line "yours."
endc
	done

GoldenrodHospitalOffice_GotBoosterDoseText:
if DEF(_FR_FR)
	text "<PLAYER> a reçu une"
	line "dose de rappel!"
else
	text "<PLAYER> got a"
	line "booster dose!"
endc
	done

GoldenrodHospitalOffice_SecondVaccinePassportUpdateText:
if DEF(_FR_FR)
	text "Je mets à jour ton"
	line "PASS VACCINAL sur"
	cont "ta CARTE DRESSEUR."

	para "Et voilà, c'est"
	line "terminé!"
else
	text "Let me update the"
	line "VACCINE PASSPORT"
	cont "on your TRAINER"
	cont "CARD."

	para "We're done!"
endc
	done

GoldenrodHospitalOffice_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  9, DYNAMIC_WARP_PREVIOUS ; Sends back to the reception.
	warp_event  3,  9, DYNAMIC_WARP_PREVIOUS ; Sends back to the reception.

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_READ, GoldenrodHospitalOfficePrinterScript
	bg_event  1,  2, BGEVENT_READ, GoldenrodHospitalOfficeDiplomaScript
	bg_event  5,  2, BGEVENT_READ, GoldenrodHospitalBookshelfScript

	def_object_events
	object_event  3,  5, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalOfficeChiefScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3,  9, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalOfficeChiefScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  2,  9, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalOfficeChiefScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event  2,  9, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalOfficeChiefScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
