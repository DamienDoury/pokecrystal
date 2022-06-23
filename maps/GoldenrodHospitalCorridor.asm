	object_const_def

GoldenrodHospitalCorridor_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .UpdateCorridor

.UpdateCorridor:
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
	ifnotequal 1, .Done

;FirstCorridor
	changeblock  0,  2, $29 ; plant
	sjump .Done

.LastCorridor:
	changeblock $12,  2, $2b ; plant
	changeblock $12, $a, $2b ; plant
.Done:
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

GoldenrodHospitalCorridorWashHandsMaleText:
	text_far _PlayersPCSanitizerText
	text_end

GoldenrodHospitalCorridorWashHandsFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

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
