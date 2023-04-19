	object_const_def
	const SEAFOAMB3F_BOULDER1
	const SEAFOAMB3F_BOULDER2
	const SEAFOAMB3F_BOULDER3

SeafoamB3F_MapScripts:
	def_scene_scripts

	def_callbacks

SeafoamB3FWeakGround:
	checkevent EVENT_RED_BEATEN
	iftrue .collapsed
	farjumptext _WeakGroundText

.collapsed
	farjumptext _WeakGroundCollapsedText

SeafoamB3FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, SEAFOAM_B2F, 4
	warp_event  5,  3, SEAFOAM_B2F, 5
	warp_event  3,  3, SEAFOAM_B4F, 1
	warp_event  7,  9, SEAFOAM_B4F, 2
	warp_event  7,  3, SEAFOAM_B2F, 1

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_READ, SeafoamB3FWeakGround
	bg_event  8,  5, BGEVENT_READ, SeafoamB3FWeakGround
	bg_event  9,  5, BGEVENT_READ, SeafoamB3FWeakGround

	def_object_events
	object_event  8,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB3FBoulder, -1
	object_event  6,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB3FBoulder, -1
	object_event  6,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB3FBoulder, -1
