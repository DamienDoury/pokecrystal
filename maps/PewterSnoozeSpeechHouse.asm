	object_const_def
	const PEWTERSNOOZESPEECHHOUSE_GRAMPS

PewterSnoozeSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

PewterSnoozeSpeechHouseGrampsScript:
	jumptextfaceplayer PewterSnoozeSpeechHouseGrampsText

PewterSnoozeSpeechHouseBookshelf:
	jumpstd PictureBookshelfScript

PewterSnoozeSpeechHouseRadio:
	jumpstd Radio3Script

PewterSnoozeSpeechHouseGrampsText: 
if DEF(_FR_FR)
	text "J'aime bien dor-"
	line "mir avec la radio"
	cont "allumée..."
	cont "....Zzzz...."
else
	text "I like snoozing"
	line "with the radio on…"
	cont "…Zzzz…"
	endc

	done

PewterSnoozeSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, PEWTER_CITY, 5
	warp_event  3,  7, PEWTER_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PewterSnoozeSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, PewterSnoozeSpeechHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, PewterSnoozeSpeechHouseRadio

	def_object_events
	object_event  5,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterSnoozeSpeechHouseGrampsScript, -1
