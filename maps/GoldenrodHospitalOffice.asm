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

	setevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	
	writetext GoldenrodHospitalOffice_PhoneCallsText
	waitbutton
	closetext

	pause 3
	playsound SFX_PUSH_BUTTON
	waitsfx

	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadRightMovement

	pause 20
	playsound SFX_CALL
	pause 20
	
	waitsfx
	pause 3
	faceplayer
	pause 3

	opentext
	writetext GoldenrodHospitalOffice_AfterPhoneCallsText
	promptbutton
	closetext

	warpsound
	appear GOLDENRODHOSPITALOFFICE_MARY
	waitsfx

	pause 2
	applymovement PLAYER, GoldenrodHospitalOffice_HeadDownMovement
	pause 2

	musicfadeout MUSIC_BEAUTY_ENCOUNTER, 16

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

	;applymovement PLAYER, GoldenrodHospitalOffice_HeadUpMovement

	pause 3
	warpsound
	turnobject GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, UP
	appear GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF_ASSISTANT, GoldenrodHospitalOffice_ChiefAssistantToDeskMovement
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadRightMovement
	pause 10
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
	applymovement GOLDENRODHOSPITALOFFICE_CHIEF, GoldenrodHospitalOffice_HeadLeftMovement

	applymovement GOLDENRODHOSPITALOFFICE_MARY, GoldenrodHospitalOffice_MaryFacesPlayerMovement
	applymovement GOLDENRODHOSPITALOFFICE_MARY_ASSISTANT, GoldenrodHospitalOffice_MaryAssistantInPlaceMovement
	
	opentext
	writetext GoldenrodHospitalOffice_LiveCountdownIntroText
	promptbutton
	writetext GoldenrodHospitalOffice_LiveCountdown3Text
	pause 30
	writetext GoldenrodHospitalOffice_LiveCountdown2Text
	pause 30
	writetext GoldenrodHospitalOffice_LiveCountdown1Text
	pause 30
	closetext
	
	; Do the interview while you get vaccinated.
	; At the end of the interview, you get the SS AQUA TICKET from CHIEF NURSE JOY.
	; 
	; 1 dummy question: "How are you doing today? YES/NO"
	; 3 real questions that determine the price you'll get from Mary. 
	; 0 points = nothing; 
	; 1 or 2 points = 1 rare candy; 
	; 3 points = 5 HP_UP.


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
GoldenrodHospitalOffice_StepUpMovement:
	step UP
	step_end

GoldenrodHospitalOffice_MaryFacesPlayerMovement:
	step RIGHT
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

GoldenrodHospitalOffice_PlayerWalksToChiefAssistantMovement:
	step RIGHT
	step RIGHT
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

GoldenrodHospitalOffice_MaryAssistantInPlaceMovement:
	step LEFT
	step UP
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

	para "…"
	done

GoldenrodHospitalOffice_AfterPhoneCallsText:
	text "So it's happening!"

	para "You'll be the first"
	line "one to get a shot"
	cont "in this region."

	para "ELM has told you"
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
	cont "rolling, the"
	cont "shot is ready."

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
