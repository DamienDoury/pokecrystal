	object_const_def
	const SEAFOAMB5F_BOULDER1
	const SEAFOAMB5F_BOULDER2
	const SEAFOAMB5F_BOULDER3
	const SEAFOAMB5F_BOULDER4
	const SEAFOAMB5F_ITEM
	const SEAFOAMB5F_ROCK
	const SEAFOAMB5F_BOULDER5
	const SEAFOAMB5F_BOULDER6
	const SEAFOAMB5F_SOLID_DOOR


SeafoamB5F_MapScripts:
	def_scene_scripts

	def_callbacks

SeafoamB5FWeakGround:
	checkevent EVENT_RED_BEATEN
	iftrue .collapsed
	farjumptext _WeakGroundText

.collapsed
	farjumptext _WeakGroundCollapsedText

SeafoamB5FItem:
	itemball CHARCOAL

SeafoamB5FSolidDoor:
	jumptext SeafoamB5FSolidDoorText

SeafoamB5FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB5FRock:
	jumpstd SmashRockScript

SeafoamB5FSolidDoorText:
	text "The lava on the"
	line "wall is shaped"
	cont "like a door."

	para "It would require"
	line "a lot of power to"
	cont "break it open."
	done

SeafoamB5F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 25,  9, SEAFOAM_B4F, 3
	warp_event 33, 17, SEAFOAM_B6F, 1

	warp_event 35, 11, SEAFOAM_B5F, 5
	warp_event 33,  3, SEAFOAM_B5F, 6
	warp_event  5, 11, SEAFOAM_B5F, 1
	warp_event  3,  3, SEAFOAM_B5F, 4

	; Pit arrival.
	warp_event 32,  7, SEAFOAM_B5F, 1
	warp_event 33,  7, SEAFOAM_B5F, 1
	warp_event 34,  7, SEAFOAM_B5F, 1

	; Pit fall.
	warp_event 21, 15, SEAFOAM_B6F, 3

	def_coord_events

	def_bg_events
	bg_event 21, 12, BGEVENT_READ, SeafoamB5FWeakGround
	bg_event 21, 13, BGEVENT_READ, SeafoamB5FWeakGround
	bg_event 21, 14, BGEVENT_READ, SeafoamB5FWeakGround
	bg_event 21, 15, BGEVENT_READ, SeafoamB5FWeakGround

	def_object_events
	object_event 33,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 32,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 34,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 31,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 28,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB5FItem, EVENT_VOLCANO_CHARCOAL
	object_event 24,  5, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FRock, -1
	object_event 17,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 22,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event 11, 15, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FSolidDoor, -1

