	object_const_def
	const AKIBA3F_BIG_DOLL
	const AKIBA3F_SELLER

Akiba3F_MapScripts:
	def_scene_scripts

	def_callbacks

Akiba3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, AKIBA_2F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  4, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_BIGDOLLSYM, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  9,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
