	object_const_def
	const GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	const GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	const GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	const GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	const GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	const GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	const GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2
	const GOLDENROD_HOSPITAL_CORRIDOR_TWIN1

GoldenrodHospitalCorridor_MapScripts:
	def_scene_scripts
	scene_script HospitalCorridorUpdateNPCs ; 0
	scene_script HospitalCorridorUpdateNPCs ; 1

	def_callbacks
	callback MAPCALLBACK_TILES, UpdateCorridorBlocks
	callback MAPCALLBACK_OBJECTS, GoldenrodHospitalCorridorHideNPCs

HospitalCorridorUpdateNPCs:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Done
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3

	checkevent EVENT_GOLDENROD_CITY_CIVILIANS
	iftrue, .Done

	readmem wGoldenrodHospitalCorridorNumber
	ifequal 1, .corridor1
	ifequal 2, .corridor2
	ifequal 3, .corridor3
	ifequal 4, .corridor4
	sjump .Done

.corridor1:
	appear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	appear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1
	sjump .Done

.corridor2:
	appear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	appear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	sjump .Done

.corridor3:
	appear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	appear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	sjump .Done

.corridor4:
	appear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	appear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2

.Done:
	end

UpdateCorridorBlocks:
	readvar VAR_XCOORD
	ifequal 0, .FacingRight ; The player arrives at the left side of the corridor (he is also facing right).
	ifequal 19, .FacingLeft
	sjump .UpdateTiles

.FacingLeft
	readmem wGoldenrodHospitalCorridorNumber
	addval $ff ; Subtract 1.
	writemem wGoldenrodHospitalCorridorNumber
	sjump .UpdateTiles
.FacingRight:
	readmem wGoldenrodHospitalCorridorNumber
	addval 1
	writemem wGoldenrodHospitalCorridorNumber
	
.UpdateTiles:
	readmem wGoldenrodHospitalCorridorNumber
	ifgreater HOSPITAL_CORRIDOR_LENGTH - 1, .LastCorridor
	ifnotequal 1, .done

;FirstCorridor
	changeblock  0,  2, $29 ; plant
	sjump .done

.LastCorridor:
	changeblock $12,  2, $2b ; plant
	changeblock $12, $a, $2b ; plant
.done:
	endcallback

GoldenrodHospitalCorridorHideNPCs:
	disappear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2
	disappear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1
	endcallback

GoldenrodHospitalCorridorRoomNumberScript:	
	special GetHospitalRoomNumber
	getnum STRING_BUFFER_3
	jumptext GoldenrodHospitalCorridorRoomNumberText

GoldenrodHospitalCorridorRoomNumberText:
	text "Room @"
	text_ram wStringBuffer3
	text_start
	done

GoldenrodHospitalCorridorGelScript:
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleHandWash
	writetext GoldenrodHospitalCorridorWashHandsMaleText
	sjump .boops

.FemaleHandWash:
	writetext GoldenrodHospitalCorridorWashHandsFemaleText

.boops:
	waitsfx
	playsound SFX_2_BOOPS
	waitsfx
	pause 10
	closetext
	end

GoldenrodHospitalCorridorNurse1Script:	
	jumptextfaceplayer GoldenrodHospitalCorridorNurse1Text

GoldenrodHospitalCorridorFinder1Script:
	checkscene
	ifequal 1, .tellAboutChiefNurse
	jumptextfaceplayer GoldenrodHospitalCorridorFinder1Text
.tellAboutChiefNurse
	jumptextfaceplayer GoldenrodHospitalCorridorFinder1ChiefNurseText

GoldenrodHospitalCorridorSick1Script:
	jumptext GoldenrodHospitalCorridorSick1Text

GoldenrodHospitalCorridorGrannyScript:
	jumptextfaceplayer GoldenrodHospitalCorridorGrannyText

GoldenrodHospitalCorridorWorriedScientist1Script:
	jumptext GoldenrodHospitalCorridorWorriedScientist1Text

GoldenrodHospitalCorridorBathroomScript:
	jumptextfaceplayer GoldenrodHospitalCorridorBathroomText

GoldenrodHospitalCorridorPsychicT1Script:
	jumptext GoldenrodHospitalCorridorPsychicT1Text

GoldenrodHospitalCorridorWashHandsMaleText:
	text_far _PlayersPCSanitizerText
	text_end

GoldenrodHospitalCorridorWashHandsFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

GoldenrodHospitalCorridorNurse1Text:
	text "I'm exhausted. I"
	line "wish I could sit."

	para "But the armchairs"
	line "are for patients"
	cont "and visitors."
	done

GoldenrodHospitalCorridorFinder1Text:
	text "I can't find room"
	line "16, where is it?"
	done

GoldenrodHospitalCorridorFinder1ChiefNurseText:
	text "CHIEF NURSE JOY?"

	para "She's here, she"
	line "just stopped into"
	cont "room 18."
	done

GoldenrodHospitalCorridorSick1Text:
	text "I think I'm sick…"

	para "(burp)"

	para "Go away! You'll"
	line "get infected!"
	done

GoldenrodHospitalCorridorGrannyText:
	text "I visit my husband"
	line "every day."
	done

GoldenrodHospitalCorridorWorriedScientist1Text:
	text "There has to be a"
	line "way to save her."

	para "I won't let her"
	line "go."
	done

GoldenrodHospitalCorridorBathroomText:
	text "THERE'S NO"
	line "BATHROOM?"

	para "Where is it?"
	done

GoldenrodHospitalCorridorPsychicT1Text:
	text "Wait"

	para "…"

	para "Wait"

	para "…"

	para "Wait"

	para "…"

	para "All I do is wai-"
	line "ting, and it's"
	cont "driving me insane…"
	done

GoldenrodHospitalCorridor_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0, 10, GOLDENROD_HOSPITAL_CORRIDOR, DYNAMIC_WARP_SCRIPT ; default = GOLDENROD_HOSPITAL_CORRIDOR warp 3, otherwise sends to GOLDENROD_HOSPITAL_1F warp 1.
	warp_event  0, 11, GOLDENROD_HOSPITAL_CORRIDOR, DYNAMIC_WARP_SCRIPT	; default = GOLDENROD_HOSPITAL_CORRIDOR warp 4, otherwise sends to GOLDENROD_HOSPITAL_1F warp 2.

	warp_event 19, 10, GOLDENROD_HOSPITAL_CORRIDOR, 1
	warp_event 19, 11, GOLDENROD_HOSPITAL_CORRIDOR, 2

	warp_event  0,  2, GOLDENROD_HOSPITAL_CORRIDOR, 7
	warp_event  0,  3, GOLDENROD_HOSPITAL_CORRIDOR, 8

	warp_event 19,  2, GOLDENROD_HOSPITAL_CORRIDOR, 5
	warp_event 19,  3, GOLDENROD_HOSPITAL_CORRIDOR, 6

	warp_event  3,  0, GOLDENROD_HOSPITAL_ROOM, 1
	warp_event  7,  0, GOLDENROD_HOSPITAL_ROOM, 1
	warp_event 11,  0, GOLDENROD_HOSPITAL_ROOM, 1
	warp_event 15,  0, GOLDENROD_HOSPITAL_ROOM, 1

	warp_event  3,  8, GOLDENROD_HOSPITAL_ROOM, 1
	warp_event  7,  8, GOLDENROD_HOSPITAL_ROOM, 1
	warp_event 11,  8, GOLDENROD_HOSPITAL_ROOM, 1
	warp_event 15,  8, GOLDENROD_HOSPITAL_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event  3,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event  6,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event  7,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 10,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 11,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 14,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 15,  0, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript

	bg_event  2,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event  3,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event  6,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event  7,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 10,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 11,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 14,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript
	bg_event 15,  8, BGEVENT_READ, GoldenrodHospitalCorridorRoomNumberScript

	bg_event  0,  9, BGEVENT_READ, GoldenrodHospitalCorridorGelScript

	def_object_events
	object_event  7, 10, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorFinder1Script, 0
	object_event  9,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 3, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorWorriedScientist1Script, 0
	object_event 13,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorPsychicT1Script, 0
	object_event  4,  9, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorNurse1Script, 0
	object_event 15, 11, SPRITE_POKEFAN_M, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 2, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorNurse1Script, 0
	object_event  5,  9, SPRITE_GRANNY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorGrannyScript, 0
	object_event 19,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorSick1Script, 0
	object_event  5,  3, SPRITE_TWIN, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorBathroomScript, 0
