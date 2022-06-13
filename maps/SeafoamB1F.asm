	object_const_def
	const SEAFOAMB1F_BOULDER1
	const SEAFOAMB1F_BOULDER2
	const SEAFOAMB1F_BOULDER3
	const SEAFOAMB1F_BOULDER4

SeafoamB1F_MapScripts:
	def_scene_scripts

	def_callbacks


SeafoamB1FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7, 15, SEAFOAM_W1F, 1
	warp_event 25, 15, SEAFOAM_E1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 24,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, EVENT_BOULDER_IN_SEAFOAM_B1F_1
	object_event 10, 14, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, EVENT_BOULDER_IN_SEAFOAM_B1F_2
	object_event 15, 10, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, -1
	object_event 23,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, -1
