	object_const_def
	const WARDENSNEIGHBORHOUSE_MAN

WardensNeighborHouse_MapScripts:
	def_scene_scripts

	def_callbacks

WardensNeighborHouseManScript:
	jumptextfaceplayer WardensNeighborHouseManText

WardensNeighborHouseManText:
	text "My grandpa is the"
	line "SAFARI ZONE WAR-"
	cont "DEN."

	para "At least he was…"

	para "He decided to go"
	line "on a vacation and"

	para "took off overseas"
	line "all by himself."

	para "He quit running"
	line "SAFARI ZONE just"
	cont "like that."
	done

WardensNeighborHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 14
	warp_event  3,  7, FUCHSIA_CITY, 14
	warp_event  2,  0, FUCHSIA_CITY, 13

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensNeighborHouseManScript, -1
