	object_const_def

CeruleanCaveB1F_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanCaveB1F_MewtwoTelepathy1:
	checkevent EVENT_CERULEAN_CAVE_B1F_TEXT_1
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B1F_TEXT_1

	openredtext
	farwriteredtext _MewtwoB1FText1
	waitbutton
	closetext

	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, CeruleanCave_LookAroundMovement
	jumptext CeruleanCave_SomeoneAroundText
.end
	end

CeruleanCaveB1F_MewtwoTelepathy2:
	checkevent EVENT_CERULEAN_CAVE_B1F_TEXT_2
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B1F_TEXT_2

	openredtext
	farwriteredtext _MewtwoB1FText2
	waitbutton
	closetext

	showemote EMOTE_QUESTION, PLAYER, 15
	jumptext CeruleanCave_VoiceInHeadText
.end
	end

CeruleanCaveB1F_MewtwoTelepathy3:
	checkevent EVENT_CERULEAN_CAVE_B1F_TEXT_3
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B1F_TEXT_3
	openredtext
	farwriteredtext _MewtwoB1FText3
	waitbutton
	closetext
.end
	end

CeruleanCaveB1F_MewtwoTelepathy4:
	checkevent EVENT_CERULEAN_CAVE_B1F_TEXT_4
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B1F_TEXT_4
	openredtext
	farwriteredtext _MewtwoB1FText4
	waitbutton
	closetext
.end
	end

CeruleanCave_LookAroundMovement:
	turn_step DOWN
	step_sleep 3
	turn_step UP
	step_sleep 3
	turn_step DOWN
	step_sleep 3
	turn_step UP
	step_sleep 3
	step_end

CeruleanCave_SomeoneAroundText:
	text "You just heard a"
	line "voice."

	para "You may not"
	line "be alone."
	done

CeruleanCave_VoiceInHeadText:
	text "The voice seems"
	line "to be coming from"
	
	para "…inside of"
	line "your head?"
	done

CeruleanCaveB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 27, 19, CERULEAN_CAVE_ENTRANCE, 1
	warp_event 29,  3, CERULEAN_CAVE_B2F, 2
	warp_event  9,  3, CERULEAN_CAVE_B2F, 3
	warp_event  5, 13, CERULEAN_CAVE_B2F, 4
	warp_event 25,  9, CERULEAN_CAVE_B2F, 5
	warp_event 21, 11, CERULEAN_CAVE_B2F, 6
	warp_event  5,  5, CERULEAN_CAVE_B2F, 7
	warp_event  2,  9, CERULEAN_CAVE_B3F, 2 ; hole

	def_coord_events
	coord_event 10,  9, SCENE_DEFAULT, CeruleanCaveB1F_MewtwoTelepathy1
	coord_event 13, 16, SCENE_DEFAULT, CeruleanCaveB1F_MewtwoTelepathy2
	coord_event 16, 12, SCENE_DEFAULT, CeruleanCaveB1F_MewtwoTelepathy3
	coord_event  3,  8, SCENE_DEFAULT, CeruleanCaveB1F_MewtwoTelepathy4

	def_bg_events

	def_object_events
