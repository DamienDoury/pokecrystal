	object_const_def
	const AKIBA3F_BIG_DOLL

Akiba3F_MapScripts:
	def_scene_scripts

	def_callbacks

Akiba3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  0, AKIBA_1F, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  4, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_BIGDOLLSYM, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
