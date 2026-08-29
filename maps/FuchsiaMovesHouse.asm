	object_const_def
	const FUCHSIAMOVESHOUSE_DELETER
	const FUCHSIAMOVESHOUSE_REMINDER
	const FUCHSIAMOVESHOUSE_SISTER

FuchsiaMovesHouse_MapScripts:
	def_scene_scripts

	def_callbacks

FuchsiaMoveDeleterScript:
	faceplayer
	opentext
	special MoveDeletion
	waitbutton
	closetext
	end

FuchsiaMoveReminderScript:
	faceplayer
	opentext
	special MoveReminder
	waitbutton
	closetext
	end

FuchsiaMovesHouseSisterScript:
    jumptextfaceplayer FuchsiaMovesHouseSisterText

FuchsiaMovesHouseBookshelf:
	jumpstd DifficultBookshelfScript

FuchsiaMovesHouseSisterText:
if DEF(_FR_FR)
	text "Maman travaille à"
    line "la SYLPHE SARL à"
    cont "SAFRANIA."

    para "Elle aide les gens"
    line "à se souvenir."
    done
else
	text "Mom works at"
    line "SILPH CO. in"
    cont "SAFFRON CITY."

	para "She helps people"
    line "remember."
	done
endc

FuchsiaMovesHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 15
	warp_event  3,  7, FUCHSIA_CITY, 15

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, FuchsiaMovesHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, FuchsiaMovesHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, FuchsiaMoveDeleterScript, -1
	object_event  5,  1, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, FuchsiaMoveReminderScript, -1
	object_event  6,  1, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, FuchsiaMovesHouseSisterScript, -1
