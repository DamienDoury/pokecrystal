	object_const_def
	const SEAFOAMB4F_BOULDER1
	const SEAFOAMB4F_BOULDER2
	const SEAFOAMB4F_BOULDER3
	const SEAFOAMB4F_ITEM

SeafoamB4F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback
	callback MAPCALLBACK_CMDQUEUE, .SetUpSokoban

.EnterCallback
	checkevent EVENT_BOULDER_IN_SEAFOAM_B4F_ALL
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
	sokobanparams 3, 10, 12, 4, 4, .Solved

.Solved:
	pause 5
	scall .DisplayGroundHole
	refreshscreen
	disappear SEAFOAMB4F_BOULDER1
	disappear SEAFOAMB4F_BOULDER2
	disappear SEAFOAMB4F_BOULDER3
	scall .BoulderFallsThrough
	opentext
	farwritetext _WeakGroundCollapsedText
	waitbutton
	closetext
	end

.DisplayGroundHole:
	changeblock 10,  4, $62
	changeblock 12,  4, $63
	end

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

SeafoamB4FWeakGround:
	checkevent EVENT_BOULDER_IN_SEAFOAM_B4F_ALL
	iftrue .collapsed
	farjumptext _WeakGroundText

.collapsed
	farjumptext _WeakGroundCollapsedText

SeafoamB4FItem:
	itemball WEATHER_ROCK

SeafoamB4FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  3, SEAFOAM_B3F, 3
	warp_event  9,  5, SEAFOAM_B4F, 1 ; Pit arrival.
	warp_event  3,  5, SEAFOAM_B5F, 1
	warp_event 13,  5, SEAFOAM_B4F, 1 ; Pit arrival.

	; Pit.
	warp_event 10,  4, SEAFOAM_B5F, 4
	warp_event 11,  4, SEAFOAM_B5F, 5
	warp_event 12,  4, SEAFOAM_B5F, 6


	def_coord_events

	def_bg_events
	bg_event 10,  4, BGEVENT_READ, SeafoamB4FWeakGround
	bg_event 11,  4, BGEVENT_READ, SeafoamB4FWeakGround
	bg_event 12,  4, BGEVENT_READ, SeafoamB4FWeakGround

	def_object_events
	object_event 12,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB4FBoulder, EVENT_BOULDER_IN_SEAFOAM_B4F_ALL
	object_event 10,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB4FBoulder, EVENT_BOULDER_IN_SEAFOAM_B4F_ALL
	object_event 11,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB4FBoulder, EVENT_BOULDER_IN_SEAFOAM_B4F_ALL
	object_event  4,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB4FItem, EVENT_VOLCANO_CHARCOAL
