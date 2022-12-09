	object_const_def

CeruleanCaveB1F_MapScripts:
	def_scene_scripts

	def_callbacks


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

	def_bg_events

	def_object_events
