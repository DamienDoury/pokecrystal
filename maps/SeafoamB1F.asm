	object_const_def
	const SEAFOAMB1F_BOULDER1
	const SEAFOAMB1F_BOULDER2
	const SEAFOAMB1F_BOULDER3
	const SEAFOAMB1F_BOULDER4
	const SEAFOAMB1F_ITEM
	const SEAFOAMB1F_BOULDER5

SeafoamB1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_CMDQUEUE, .SetUpStoneTable

.SetUpStoneTable:
	writecmdqueue .CommandQueue
	endcallback

.CommandQueue:
	cmdqueue CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp

.StoneTable:
	stonetable 7, SEAFOAMB1F_BOULDER1, .Boulder1
	stonetable 6, SEAFOAMB1F_BOULDER2, .Boulder2
	db -1 ; end

.Boulder1:
	disappear SEAFOAMB1F_BOULDER1
	clearevent EVENT_BOULDER_IN_SEAFOAM_B2F_2
	sjump .FinishBoulder

.Boulder2:
	disappear SEAFOAMB1F_BOULDER2
	clearevent EVENT_BOULDER_IN_SEAFOAM_B2F_1
	sjump .FinishBoulder

.FinishBoulder:
	pause 5
	scall .BoulderFallsThrough
	opentext
	writetext SeafoamB1FBoulderFellThroughText
	waitbutton
	closetext
	end

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

SeafoamB1FItem:
	itemball ESCAPE_ROPE

SeafoamB1FBoulder:
	jumpstd StrengthBoulderScript

SeafoamB1FBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done

SeafoamB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6, 15, SEAFOAM_W1F, 1
	warp_event 25, 15, SEAFOAM_E1F, 1
	warp_event  7,  7, SEAFOAM_B2F, 1
	warp_event 19, 15, SEAFOAM_B2F, 2
	warp_event 25,  5, SEAFOAM_B2F, 3
	warp_event 14,  9, SEAFOAM_B2F, 6 ; left pit.
	warp_event 22,  7, SEAFOAM_B2F, 7 ; right pit.


	def_coord_events

	def_bg_events

	def_object_events
	object_event 24,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, EVENT_BOULDER_IN_SEAFOAM_B1F_1
	object_event 10, 14, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, EVENT_BOULDER_IN_SEAFOAM_B1F_2
	object_event 15, 10, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, -1
	object_event 23,  4, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, -1
	object_event 17,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SeafoamB1FItem, EVENT_SEAFOAM_ESCAPE_ROPE
	object_event 17,  6, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB1FBoulder, -1
