	object_const_def
	const SEAFOAMB3F_BOULDER1
	const SEAFOAMB3F_BOULDER2
	const SEAFOAMB3F_BOULDER3


SeafoamB3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback
	callback MAPCALLBACK_CMDQUEUE, .SetUpSokoban

.EnterCallback
	checkevent EVENT_BOULDER_IN_SEAFOAM_B3F_3
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
	sokobanparams 3, 7, 9, 5, 5, .Solved

.Solved:
	pause 5
	scall .DisplayGroundHole
	refreshscreen
	disappear SEAFOAMB3F_BOULDER1
	disappear SEAFOAMB3F_BOULDER2
	disappear SEAFOAMB3F_BOULDER3
	setevent EVENT_BOULDER_IN_SEAFOAM_B3F_3
	scall .BoulderFallsThrough
	opentext
	farwritetext _WeakGroundCollapsedText
	waitbutton
	closetext
	end

.DisplayGroundHole
	changeblock  6,  4, $5e
	changeblock  8,  4, $5f
	end

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

SeafoamB3FItem:
	itemball ESCAPE_ROPE

SeafoamB3FWeakGround:
	checkevent EVENT_BOULDER_IN_SEAFOAM_B3F_3
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
	warp_event  7,  5, SEAFOAM_B4F, 2
	warp_event  7,  3, SEAFOAM_B2F, 1
	warp_event  9,  5, SEAFOAM_B4F, 4
	warp_event  5,  2, SEAFOAM_B2F, 9

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_READ, SeafoamB3FWeakGround
	bg_event  8,  5, BGEVENT_READ, SeafoamB3FWeakGround
	bg_event  9,  5, BGEVENT_READ, SeafoamB3FWeakGround

	def_object_events
	object_event  6,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB3FBoulder, EVENT_BOULDER_IN_SEAFOAM_B3F_1
	object_event  8,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB3FBoulder, EVENT_BOULDER_IN_SEAFOAM_B3F_2
	object_event  6,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB3FBoulder, EVENT_BOULDER_IN_SEAFOAM_B3F_1
