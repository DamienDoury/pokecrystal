	object_const_def
	const SEAFOAMB2F_BOULDER1
	const SEAFOAMB2F_BOULDER2
	const SEAFOAMB2F_BOULDER3
	const SEAFOAMB2F_ITEM

SeafoamB2F_MapScripts:
	def_scene_scripts

	def_callbacks

SeafoamB2FItem:
	itemball WATER_STONE
	
SeafoamB2FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  7, SEAFOAM_B1F, 3
	warp_event 19, 15, SEAFOAM_B1F, 4
	warp_event 25,  5, SEAFOAM_B1F, 5
	warp_event  2,  7, SEAFOAM_B3F, 1
	warp_event  4,  3, SEAFOAM_B3F, 2
	warp_event 15,  8, SEAFOAM_B3F, 1
	warp_event 23,  7, SEAFOAM_B3F, 1
	warp_event  6,  3, SEAFOAM_B3F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event 15,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, -1
	object_event 22,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, -1
	object_event 24, 13, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, -1
	object_event 15,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB2FItem, EVENT_SEAFOAM_WATER_STONE
