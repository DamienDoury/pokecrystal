	object_const_def
	const SEAFOAMB2F_BOULDER1
	const SEAFOAMB2F_BOULDER2
	const SEAFOAMB2F_BOULDER3
	const SEAFOAMB2F_ITEM

SeafoamB2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback
	callback MAPCALLBACK_CMDQUEUE, .SetUpStoneTable

.EnterCallback
	checkevent EVENT_BOULDER_IN_SEAFOAM_B2F_2
	iftrue .DontHideBoulder

	disappear SEAFOAMB2F_BOULDER2

.DontHideBoulder
	endcallback

.SetUpStoneTable:
	writecmdqueue .CommandQueue
	endcallback

.CommandQueue:
	cmdqueue CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp

.StoneTable:
	stonetable 8, SEAFOAMB2F_BOULDER1, .Boulder1
	db -1 ; end

.Boulder1:
	disappear SEAFOAMB2F_BOULDER1
	clearevent EVENT_BOULDER_IN_SEAFOAM_B3F_1

	pause 30
	scall .BoulderFallsThrough
	opentext
	writetext SeafoamB2FBoulderFellThroughText
	waitbutton
	closetext
	end

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

SeafoamB2FItem:
	itemball WATER_STONE

SeafoamB2FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB2FRock:
	jumpstd SmashRockScript

SeafoamB2FBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done

SeafoamB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  7, SEAFOAM_B1F, 3
	warp_event 19, 15, SEAFOAM_B1F, 4
	warp_event 25,  5, SEAFOAM_B1F, 5
	warp_event  2,  7, SEAFOAM_B3F, 1
	warp_event  4,  3, SEAFOAM_B3F, 2
	warp_event 15,  8, SEAFOAM_B3F, 1
	warp_event 23,  7, SEAFOAM_B3F, 1 ; left pit (decoy).
	warp_event  6,  3, SEAFOAM_B3F, 5 ; right pit.

	def_coord_events

	def_bg_events

	def_object_events
	object_event 15,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, EVENT_BOULDER_IN_SEAFOAM_B2F_1
	object_event 22,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 24, 13, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, -1
	object_event 15,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB2FItem, EVENT_SEAFOAM_WATER_STONE
	object_event 23,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FBoulder, EVENT_BOULDER_IN_SEAFOAM_B2F_2
	object_event 22,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB2FRock, EVENT_BOULDER_IN_SEAFOAM_B2F_2
