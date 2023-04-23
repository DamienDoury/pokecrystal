	object_const_def
	const SEAFOAMW1F_BOULDER1
	const SEAFOAMW1F_BOULDER2
	const SEAFOAMW1F_BOULDER3
	const SEAFOAMW1F_BOULDER4

SeafoamW1F_MapScripts:
	def_scene_scripts

	def_callbacks 
	callback MAPCALLBACK_OBJECTS, .ClearRocks

.ClearRocks:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	clearevent EVENT_BROCK_BACK_IN_GYM
	endcallback

SeafoamW1FBoulder:
	jumpstd StrengthBoulderScript

SeafoamW1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 31, SEAFOAM_B1F, 1
	warp_event  3, 33, ROUTE_20, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5, 30, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
	object_event  4, 31, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
	object_event  4, 32, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
	object_event  5, 33, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
