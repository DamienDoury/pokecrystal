	object_const_def

CeruleanCaveB2F_MapScripts:
	def_scene_scripts

	def_callbacks


CeruleanCaveB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, CERULEAN_CAVE_B3F, 1
	warp_event 31,  3, CERULEAN_CAVE_B1F, 2
	warp_event 11,  3, CERULEAN_CAVE_B1F, 3
	warp_event  5, 13, CERULEAN_CAVE_B1F, 4
	warp_event 27,  9, CERULEAN_CAVE_B1F, 5
	warp_event 23, 11, CERULEAN_CAVE_B1F, 6
	warp_event  5,  5, CERULEAN_CAVE_B1F, 7

	def_coord_events

	def_bg_events

	def_object_events
