	object_const_def
	const MRPSYCHICSHOUSE_FISHING_GURU

MrPsychicsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MrPsychic:
	faceplayer
	opentext
	checkitem TM_PSYCHIC_M
	iftrue .AlreadyGotItem
	writetext MrPsychicText1
	promptbutton
	verbosegiveitem TM_PSYCHIC_M
	iffalse .Done
.AlreadyGotItem:
	writetext MrPsychicText2
	waitbutton
.Done:
	closetext
	end

MrPsychicsHouseBookshelf:
	jumpstd DifficultBookshelfScript

MrPsychicText1: 
if DEF(_FR_FR)
	text "..."

	para "...."

	para "....."

	para "......Ah!"

	para "Tu veux ça?"
else
	text "…"

	para "…"

	para "…"

	para "…I got it!"

	para "You wanted this!"
endc

	done

MrPsychicText2: 
if DEF(_FR_FR)
	text "CT29: PSYKO."

	para "Il peux baisser"
	line "la DEFENSE"
	cont "SPECIALE de"
	cont "l'ennemi."
else
	text "TM29 is PSYCHIC."

	para "It may lower the"
	line "target's SPCL.DEF."
endc

	done

MrPsychicsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 5
	warp_event  3,  7, SAFFRON_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MrPsychicsHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, MrPsychicsHouseBookshelf

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MrPsychic, -1
