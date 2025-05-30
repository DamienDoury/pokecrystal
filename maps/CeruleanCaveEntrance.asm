	object_const_def

CeruleanCaveEntrance_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	setevent EVENT_ENTERED_CERULEAN_CAVE
	endcallback

CeruleanCaveEntrance_ExitScript:
	opentext
	writetext CeruleanCaveEntrance_ExitQuestionText
	yesorno
	closetext
	iftrue .go_out
	end

.go_out
	playsound SFX_WATER_GUN
	special FadeBlackQuickly
	pause 20
	warp CERULEAN_CITY, 2, 14
	end

CeruleanCaveMail:
	jumptext CeruleanCaveMailText

CeruleanCaveMailText: ; TO TRANSLATE
	text "There's a mail"
	line "deposited on top"
	cont "of the rock."

	para "“Don't go in there."
	line "- RED”"
	done

CeruleanCaveEntrance_ExitQuestionText: ; TO TRANSLATE
	text "Outside light"
	line "is bleeding in."
	
	para "Go back out?"
	done

CeruleanCaveEntrance_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  1, CERULEAN_CAVE_B1F, 1

	def_coord_events
	coord_event  5, 15, CeruleanCaveEntrance_ExitScript

	def_bg_events
	bg_event  4,  4, BGEVENT_READ, CeruleanCaveMail

	def_object_events
