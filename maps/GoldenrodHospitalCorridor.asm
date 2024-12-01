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

	def_callbacks
	callback MAPCALLBACK_TILES, .UpdateCorridorBlocks
	callback MAPCALLBACK_OBJECTS, .UpdateCorridorNPCs

.UpdateCorridorBlocks:
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

.UpdateCorridorNPCs:
	checkevent EVENT_GOLDENROD_CITY_CIVILIANS
	iftrue .HideEveryone

	readmem wGoldenrodHospitalCorridorNumber
	ifequal 2, .corridor2
	ifequal 3, .corridor3
	ifequal 4, .corridor4

.corridor1:
	;appear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1	; top
	;appear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1 	; bottom

	disappear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2
	endcallback

.corridor2:
	;appear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1		; top
	;appear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1		; bottom

	disappear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2
	disappear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1
	endcallback

.corridor3:
	;appear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1		; top
	;appear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2	; bottom

	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	endcallback

.corridor4:
	;appear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1	; top
	;appear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1	; bottom

	disappear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2
	disappear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1

.EndThisCallback:
	endcallback

.HideEveryone:
	disappear GOLDENROD_HOSPITAL_CORRIDOR_FINDER1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_PSYCHICT1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_NURSE1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_POKEFAN1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_GRANNY1
	disappear GOLDENROD_HOSPITAL_CORRIDOR_SCIENTIST2
	disappear GOLDENROD_HOSPITAL_CORRIDOR_TWIN1
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

GoldenrodHospitalCorridorNurse1Script: ; Medical staff don't clap at themselves.
	faceplayer
	jumptext GoldenrodHospitalCorridorNurse1Text

GoldenrodHospitalCorridorPokefan1Script:
	trainer HIKER, MEREDITH, EVENT_BEAT_HOSPITAL_TRAINER_CORRIDOR_2, GoldenrodHospitalPokefanMTrainerSeenText, GoldenrodHospitalPokefanMTrainerBeatenText, 0, .Script

.Script:
	checkscene 
	ifequal 9, .advance_quest
	endifjustbattled

	ifgreater 9, .quest_afterbattle_text
	faceplayer
	jumptext GoldenrodHospitalPokefanMTrainerAfterBattleText

.advance_quest:
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_10
.quest_afterbattle_text:
	jumptextfaceplayer GoldenrodHospitalCorridorPokefanMTrainerQuestText		

GoldenrodHospitalCorridorFinder1Script: ; Medical staff don't clap at themselves.
	faceplayer
	checkscene
	ifequal 10, .tellAboutChiefNurse
	jumptext GoldenrodHospitalCorridorFinder1Text
.tellAboutChiefNurse
	jumptext GoldenrodHospitalCorridorFinder1ChiefNurseText

GoldenrodHospitalCorridorSick1Script: ; Medical staff don't clap at themselves.
	jumptext GoldenrodHospitalCorridorSick1Text

GoldenrodHospitalCorridorGrannyScript:
	jumptextfaceplayer GoldenrodHospitalCorridorGrannyText

GoldenrodHospitalCorridorWorriedScientist1Script: ; Medical staff don't clap at themselves.
	jumptext GoldenrodHospitalCorridorWorriedScientist1Text

GoldenrodHospitalCorridorBathroomScript:
	faceplayer 
	jumptext GoldenrodHospitalCorridorBathroomText

GoldenrodHospitalCorridorPsychicT1Script:
	trainer PSYCHIC_T, GODOT, EVENT_BEAT_HOSPITAL_TRAINER_CORRIDOR_1, GoldenrodHospitalPsychicTrainerSeenText, GoldenrodHospitalPsychicTrainerBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalPsychicTrainerAfterBattleText

GoldenrodHospitalCorridorWashHandsMaleText:
	text_far _PlayersPCSanitizerText
	text_end

GoldenrodHospitalCorridorWashHandsFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

GoldenrodHospitalCorridorMaxElixer:
	hiddenitem MAX_ELIXER, EVENT_GOLDENROD_HOSPITAL_CORRIDOR_MAX_ELIXER

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
	text "WHERE'S THE"
	line "BATHROOM?"

	para "PLEEEEEASE"
	done

GoldenrodHospitalPsychicTrainerSeenText:
	text "I've been waiting"
	line "here forever…"

	para "I'm losing my"
	line "sanity…"
	done

GoldenrodHospitalPsychicTrainerBeatenText:
	text "Waiting was less"
	line "painful actually."
	done

GoldenrodHospitalPsychicTrainerAfterBattleText:	
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

GoldenrodHospitalPokefanMTrainerSeenText:
	text "My wife isn't in"
	line "this room anymore."
	
	para "Was she moved to"
	line "another room?"

	para "Did something bad"
	line "happen?"
	done

GoldenrodHospitalPokefanMTrainerBeatenText:
	text "I'll ask a nurse"
	line "about my wife."
	done

GoldenrodHospitalPokefanMTrainerAfterBattleText:
	text "Hospitals are"
	line "making me nervous."
	done

GoldenrodHospitalCorridorPokefanMTrainerQuestText:
	text "I just saw the"
	line "CHIEF NURSE, yeah."

	para "She was running"
	line "left, straight"
	cont "towards the lobby."
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

	bg_event  1,  9, BGEVENT_READ, GoldenrodHospitalCorridorGelScript
	bg_event 19,  7, BGEVENT_ITEM, GoldenrodHospitalCorridorMaxElixer

	def_object_events
	object_event  7, 10, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorFinder1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  8,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 3, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorWorriedScientist1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 13,  1, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalCorridorPsychicT1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; This trainer can't walk, so the clapping animation can't break its walking animation.
	object_event 12,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorNurse1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	object_event 13, 11, SPRITE_POKEFAN_M, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 2, 1, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalCorridorPokefan1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	object_event  5,  9, SPRITE_GRANNY, CLAP_F | SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorGrannyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	object_event 19,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorSick1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	object_event  5,  3, SPRITE_TWIN, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCorridorBathroomScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
