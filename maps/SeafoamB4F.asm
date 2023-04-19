	object_const_def
	const SEAFOAMB4F_BOULDER1
	const SEAFOAMB4F_BOULDER2
	const SEAFOAMB4F_BOULDER3
	const SEAFOAMB4F_ITEM

SeafoamB4F_MapScripts:
	def_scene_scripts

	def_callbacks

SeafoamB4FWeakGround:
	checkevent EVENT_RED_BEATEN
	iftrue .collapsed
	farjumptext _WeakGroundText

.collapsed
	farjumptext _WeakGroundCollapsedText

SeafoamB4FItem:
	itemball DOME_FOSSIL

SeafoamB4FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  3, SEAFOAM_B3F, 3
	warp_event 13,  6, SEAFOAM_B3F, 4
	warp_event  3,  7, SEAFOAM_B5F, 1

	; Pit.
	warp_event 10,  6, SEAFOAM_B5F, 7
	warp_event 11,  6, SEAFOAM_B5F, 8
	warp_event 12,  6, SEAFOAM_B5F, 9


	def_coord_events

	def_bg_events
	bg_event 10,  6, BGEVENT_READ, SeafoamB4FWeakGround
	bg_event 11,  6, BGEVENT_READ, SeafoamB4FWeakGround
	bg_event 12,  6, BGEVENT_READ, SeafoamB4FWeakGround

	def_object_events
	object_event 12,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB4FBoulder, -1
	object_event 10,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB4FBoulder, -1
	object_event 11,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB4FBoulder, -1
	object_event  2,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB4FItem, EVENT_VOLCANO_FOSSIL
