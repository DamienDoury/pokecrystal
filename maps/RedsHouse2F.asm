	object_const_def
	const REDSHOUSE2F_PIKACHU

RedsHouse2F_MapScripts:
	def_scene_scripts

	def_callbacks

RedsHouse2FPikachuScript:
	cry PIKACHU
	end

RedsHouse2FN64Script:
	jumptext RedsHouse2FN64Text

RedsHouse2FPCScript:
	jumptext RedsHouse2FPCText

RedsHouse2FN64Text:
	text "<PLAYER> played the"
	line "N64."

	para "Better get going--"
	line "no time to lose!"
	done

RedsHouse2FPCText:
	text "It looks like it"
	line "hasn't been used"
	cont "in a long time…"
	done

RedsHouse2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  0, REDS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  5, BGEVENT_READ, RedsHouse2FN64Script
	bg_event  0,  1, BGEVENT_READ, RedsHouse2FPCScript

	def_object_events
	object_event  1,  5, SPRITE_PIKACHU, SPRITEMOVEDATA_POKEMON, 1, 1, -1, -1, PAL_BG_YELLOW, OBJECTTYPE_SCRIPT, 0, RedsHouse2FPikachuScript, EVENT_RED_BEATEN
