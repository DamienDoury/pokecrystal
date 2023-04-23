	object_const_def
	const SEAFOAMB5F_BOULDER1
	const SEAFOAMB5F_BOULDER2
	const SEAFOAMB5F_BOULDER3
	const SEAFOAMB5F_BOULDER4
	const SEAFOAMB5F_ITEM
	const SEAFOAMB5F_ROCK
	const SEAFOAMB5F_BOULDER5
	;const SEAFOAMB5F_BOULDER6
	const SEAFOAMB5F_SOLID_DOOR


SeafoamB5F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback
	callback MAPCALLBACK_CMDQUEUE, .SetUpSokoban

.EnterCallback
	checkevent EVENT_BOULDER_IN_SEAFOAM_B5F_ALL
	iffalse .DontCollapse

	scall .DisplayGroundHole

.DontCollapse
	endcallback

.SetUpSokoban:
	writecmdqueue .CommandQueue
	endcallback

.CommandQueue:
	cmdqueue CMDQUEUE_SOKOBAN, .SokobanParams ; check if any stones are sitting on a warp

.SokobanParams:
	sokobanparams 4, 17, 17, 12, 15, .Solved

.Solved:
	pause 5
	scall .DisplayGroundHole
	refreshscreen
	disappear SEAFOAMB5F_BOULDER1
	disappear SEAFOAMB5F_BOULDER2
	disappear SEAFOAMB5F_BOULDER3
	disappear SEAFOAMB5F_BOULDER4
	clearevent EVENT_BOULDER_IN_SEAFOAM_B6F_ALL
	scall .BoulderFallsThrough
	opentext
	farwritetext _WeakGroundCollapsedText
	waitbutton
	cry MOLTRES
	showemote EMOTE_QUESTION, PLAYER, 30
	waitsfx
	closetext
	end

.DisplayGroundHole:
	changeblock 16, 12, $59
	changeblock 16, 14, $5a
	end

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

SeafoamB5FWeakGround:
	checkevent EVENT_BOULDER_IN_SEAFOAM_B5F_ALL
	iftrue .collapsed
	farjumptext _WeakGroundText

.collapsed
	farjumptext _WeakGroundCollapsedText

SeafoamB5FItem:
	itemball DOME_FOSSIL

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
	warp_event 21,  9, SEAFOAM_B4F, 3
	warp_event 29,  5, SEAFOAM_B6F, 1
	warp_event 31, 13, SEAFOAM_B6F, 3 ; Pit fall.
	warp_event 28,  7, SEAFOAM_B5F, 1 ; Pit arrival.
	warp_event 29,  7, SEAFOAM_B5F, 1 ; Pit arrival.
	warp_event 30,  7, SEAFOAM_B5F, 1 ; Pit arrival.
	warp_event 17, 15, SEAFOAM_B6F, 4 ; Pit fall.

	def_coord_events

	def_bg_events
	bg_event 17, 12, BGEVENT_READ, SeafoamB5FWeakGround
	bg_event 17, 13, BGEVENT_READ, SeafoamB5FWeakGround
	bg_event 17, 14, BGEVENT_READ, SeafoamB5FWeakGround
	bg_event 17, 15, BGEVENT_READ, SeafoamB5FWeakGround

	def_object_events
	object_event 29,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, EVENT_BOULDER_IN_SEAFOAM_B5F_ALL
	object_event 28,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, EVENT_BOULDER_IN_SEAFOAM_B5F_ALL
	object_event 30,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, EVENT_BOULDER_IN_SEAFOAM_B5F_ALL
	object_event 27,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, EVENT_BOULDER_IN_SEAFOAM_B5F_ALL
	object_event 24,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB5FItem, EVENT_VOLCANO_FOSSIL
	object_event 20,  5, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FRock, -1
	object_event 13,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	;object_event 22,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FBoulder, -1
	object_event  5, 15, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB5FSolidDoor, -1
