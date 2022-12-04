	object_const_def
	const GOLDENRODHOSPITALOFFICE_CHIEF
	const GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT
	const GOLDENRODHOSPITALOFFICE_MARY
	const GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT

GoldenrodHospitalOffice_MapScripts:
	def_scene_scripts
	scene_script .Scene0
	scene_script .Scene1

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.Scene0:
.Scene1:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5

	checkevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	iffalse .end

	prioritysjump .PlayerVaccinationScene
	end

.PlayerVaccinationScene:
	applymovement PLAYER, GoldenrodHospitalOffice_WalkToDeskMovement
	showemote EMOTE_SHOCK, GOLDENRODHOSPITALOFFICE_CHIEF, 15
	setlasttalked GOLDENRODHOSPITALOFFICE_CHIEF
	faceplayer
	pause 5
	opentext
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

	pause 30

	opentext
	writetext GoldenrodHospitalOffice_AfterPhoneCalls2Text
	promptbutton
	closetext

	pause 10

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
	writetext GoldenrodHospitalOffice_Itw1Text
	yesorno
	iffalse .itw1bad

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

	; Do the interview while you get vaccinated.
	; At the end of the interview, you get the SS AQUA TICKET from CHIEF NURSE JOY.
	; 
	; 1 dummy question: "How are you doing today? YES/NO"
	; 3 real questions that determine the price you'll get from Mary. 
	; 0 or 1 point = nothing; 
	; 2 points = 5 Ultra Ball; 
	; 3 points = 5 HP_UP.
	; 4 points = 8 PP_MAX.

	;special RestartMapMusic
	musicfadeout MUSIC_GOLDENROD_CITY, 8

	pause 60

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
	ifnotequal 2, .skip_hospital_quest_step_inc
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, 3
.skip_hospital_quest_step_inc
	checkevent EVENT_SICK_CATERPIE
	iffalse .HideChiefNurse
	appear GOLDENRODHOSPITALOFFICE_CHIEF
	endcallback

.HideChiefNurse:
	disappear GOLDENRODHOSPITALOFFICE_CHIEF
	endcallback

GoldenrodHospitalOffice_IncPoints:
	readmem wTempByteValue
	addval 1
	writemem wTempByteValue
	end

GoldenrodHospitalOfficeChiefScript:
	jumptextfaceplayer GoldenrodHospitalOfficeChiefText

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

GoldenrodHospitalOffice_StepRightMovement:
	step RIGHT
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

GoldenrodHospitalOffice_StepDownMovement:
	step DOWN
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

GoldenrodHospitalOfficeChiefText:
	text "CHIEF NURSE JOY:"
	line "Thanks for your"
	cont "help earlier."
	done

GoldenrodHospitalOfficePrinterText:
	text "The screen says"
	line "“Out of paper”"
	done

VeryPrestigiousDiplomaText:
	text "A diploma from a"
	line "very prestigious"
	cont "medical school."
	done

GoldenrodHospitalOffice_ComingForVaccineText:
	text "CHIEF NURSE JOY:"
	line "Hello <PLAYER>,"
	cont "are you coming to"
	cont "get vaccinated?"
	done

GoldenrodHospitalOffice_NotComingForVaccineText:
	text "Oh OK. I got"
	line "ahead of myself."
	done

GoldenrodHospitalOffice_PhoneCallsText:
	text "Amazing! I have"
	line "to make a few"
	cont "phone calls."
	done

GoldenrodHospitalOffice_AfterPhoneCallsText:
	text "So it's happening!"

	para "You'll be the first"
	line "one to get a shot"
	cont "in this region."

	para "…"

	para "She should be here"
	line "any second."
	
	para "She works next"
	line "block after all."
	done

GoldenrodHospitalOffice_AfterPhoneCalls2Text:
	text "ELM has told you"
	line "about the inter-"
	cont "view, right?"
	done

GoldenrodHospitalOffice_MaryIntroText:
	text "MARY: I'm finally"
	line "going to get this"
	cont "interview you owe"
	cont "me, CHAMPION!"

	para "No running away"
	line "this time!"
	done

GoldenrodHospitalOffice_VaccineArrivesText:
	text "CHIEF NURSE JOY:"
	line "You should start"
	cont "rolling, we're"
	cont "ready."

	para "Come next to me"
	line "<PLAYER>."
	done

GoldenrodHospitalOffice_EveryoneInPlaceText:
	text "MARY: All righty,"
	line "everyone in place!"
	done

GoldenrodHospitalOffice_LiveCountdownIntroText:
	text "MARY: We're live"
	line "in…"
	done

GoldenrodHospitalOffice_LiveCountdown3Text:
	text "3…"
	done

GoldenrodHospitalOffice_LiveCountdown2Text:
	text "2…"
	done

GoldenrodHospitalOffice_LiveCountdown1Text:
	text "1…"
	done

GoldenrodHospitalOffice_ItwIntroText:
	text "MARY: Hi everyone!"
	line "Today I'm with no"
	cont "one but the one"
	cont "LEAGUE CHAMPION!"

	para "<PLAYER>, how are"
	line "doing today?"
	done

GoldenrodHospitalOffice_Itw1Text:
	text "MARY: All right!"

	para "Congratulations on"
	line "your victory over"
	cont "the ELITE 4."

	para "The battles were"
	line "fierces!"

	para "Are you proud of"
	line "your #MON?"
	done

GoldenrodHospitalOffice_Itw1GoodText:
	text "MARY: How sweet"
	line "of you!"
	done

GoldenrodHospitalOffice_Itw1BadText:
	text "MARY: Too shy to"
	line "say it?"
	done

GoldenrodHospitalOffice_Itw2Text:
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
	done

GoldenrodHospitalOffice_Itw2SequelText:
	text "MARY: I have to"
	line "cut you, it is"
	cont "happening."
	done

GoldenrodHospitalOffice_Itw2NurseText:
	text "CHIEF NURSE JOY:"
	line "I'm proceeding to"
	cont "the injection now."
	done

GoldenrodHospitalOffice_PlayerVaccinatedText:
	text "<PLAYER> is now"
	line "vaccinated."
	done

GoldenrodHospitalOffice_Itw2Nurse2Text:
	text "CHIEF NURSE JOY:"
	line "That's all!"

	para "Your left arm may"
	line "feel a little"
	cont "numb for the day."

	para "I'd like to talk"
	line "into the micro-"
	cont "phone."
	done

GoldenrodHospitalOffice_Itw2Nurse3Text:
	text "CHIEF NURSE JOY:"
	line "This shot will"
	cont "not only protect"
	cont "<PLAYER>, but also"
	cont "people around."

	para "Wearing the face"
	line "mask is still"
	cont "required to"
	cont "further reduce the"
	cont "the risk of"
	cont "transmission."

	para "Getting a shot is"
	line "the way to"
	cont "retrieve our"
	cont "lives from before"
	cont "the pandemic."

	para "I will now update"
	line "the vaccination"
	cont "pass on <PLAYER>'s"
	cont "TRAINER CARD."
	
	para "It gives the"
	line "legal right to"
	cont "go outside our"
	cont "national borders."

	para "And to celebrate"
	line "this, here is a"
	cont "gift."
	done

ElmGiveTicketText2:
	text "The ship departs"
	line "from OLIVINE CITY."

	para "Give my regards to"
	line "PROF.OAK in KANTO!"
	done

GoldenrodHospitalOffice_Itw3Text:
	text "MARY: It's official"
	line "<PLAYER> just"
	cont "received the shot!"

	para "Was it painful?"
	done

GoldenrodHospitalOffice_Itw3GoodText:
	text "MARY: That's good"
	line "to hear!"

	para "Don't be afraid"
	line "people!"
	done

GoldenrodHospitalOffice_Itw3BadText:
	text "MARY: Ahah, good"
	line "joke! People know"
	cont "you must be tough"
	cont "to become the"
	cont "CHAMPION."
	done

GoldenrodHospitalOffice_Itw4Text:
	text "I have one"
	line "last question."
	
	para "Do you think"
	line "people should"
	cont "get vaccinated?"
	done

GoldenrodHospitalOffice_Itw4GoodText:
	text "MARY: Well, coming"
	line "from the CHAMPION,"
	cont "now I sure want my"
	cont "shot as well!"
	done
	
GoldenrodHospitalOffice_Itw4BadText:
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
	done

GoldenrodHospitalOffice_ItwEndText:
	text "Thank you so"
	line "much for your"
	cont "time <PLAYER>."

	para "Back to you, Tom."
	done

	;"What was that <PLAYER>?"
	;"I waited so long for this interview, perhaps my expectations were too high."

	;"The interview went well."

	;"This interview was amazing!"
	;"First answer aside, you were so inspiring!"
	;"I'm so happy we finally could do it!"


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
