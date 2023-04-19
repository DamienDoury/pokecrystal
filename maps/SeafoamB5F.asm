	object_const_def
	const SEAFOAMB5F_BOULDER1
	const SEAFOAMB5F_BOULDER2
	const SEAFOAMB5F_BOULDER3
	const SEAFOAMB5F_BOULDER4

SeafoamB5F_MapScripts:
	def_scene_scripts

	def_callbacks


SeafoamB5FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB5F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 21,  7, SEAFOAM_B4F, 3
	warp_event 13, 11, SEAFOAM_B6F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 11,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 12,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 13,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
