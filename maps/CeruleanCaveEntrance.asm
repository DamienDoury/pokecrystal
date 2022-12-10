	object_const_def

CeruleanCaveEntrance_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanCaveEntrance_ExitScript:
	opentext
	writetext CeruleanCaveEntrance_ExitQuestionText
	yesorno
	closetext
	iftrue .go_out
	end

.go_out
	special FadeBlackQuickly
	pause 15
	warp CERULEAN_CITY, 0, 14
	end

CeruleanCaveMail:
	jumptext CeruleanCaveMailText

CeruleanCaveMailText:
	text "There's a mail"
	line "deposited on top"
	cont "of the rock."

	para "“Don't go in there."
	line "- RED”"
	done

CeruleanCaveEntrance_ExitQuestionText:
	text "You can see the"
	line "light of day."
	
	para "Go back out?"
	done

CeruleanCaveEntrance_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  3, CERULEAN_CAVE_B1F, 1

	def_coord_events
	coord_event  7, 15, SCENE_DEFAULT, CeruleanCaveEntrance_ExitScript
	coord_event  7, 15, SCENE_FINISHED, CeruleanCaveEntrance_ExitScript

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, CeruleanCaveMail

	def_object_events
