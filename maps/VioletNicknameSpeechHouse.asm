	object_const_def
	const VIOLETNICKNAMESPEECHHOUSE_TEACHER
	const VIOLETNICKNAMESPEECHHOUSE_LASS
	const VIOLETNICKNAMESPEECHHOUSE_BIRD
	
	const VIOLETNICKNAMESPEECHHOUSE_PUPIL
	const VIOLETNICKNAMESPEECHHOUSE_NOTEBOOK
	const VIOLETNICKNAMESPEECHHOUSE_COMPUTER1

VioletNicknameSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject VIOLETNICKNAMESPEECHHOUSE_LASS, 7, 3
	moveobject VIOLETNICKNAMESPEECHHOUSE_TEACHER, 7, 4
	moveobject VIOLETNICKNAMESPEECHHOUSE_PUPIL, 7, 5
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
	loadmem wMap4ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
	endcallback

.TilesLoad
	readmem wCurFreedomState
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	changeblock  4,  2, $3b
	changeblock  4,  4, $3f
	changeblock  0,  6, $3c
.end
	endcallback

VioletNicknameSpeechHouseTeacherScript:
	jumptextfaceplayer VioletNicknameSpeechHouseTeacherText

VioletNicknameSpeechHouseLassScript:
	jumptextfaceplayer VioletNicknameSpeechHouseLassText

VioletNicknameSpeechHouseBirdScript:
	faceplayer
	opentext
	writetext VioletNicknameSpeechHouseBirdText
	cry PIDGEY
	waitbutton
	closetext
	end

VioletNicknameSpeechPupilScript:
	jumptextfaceplayer VioletNicknameSpeechPupilText

VioletNicknameSpeechHouseNotebookScript:
	farsjump AcademyNotebook

VioletNicknameSpeechHouseComputer1Script:
	opentext
	writetext VioletNicknameSpeechHouseComputer1Text
	farsjump AcademyBlackboard.Loop

VioletNicknameSpeechHouseTeacherText:
	text "She uses the names"
	line "of her favorite"
	cont "things to eat."

	para "For the nicknames"
	line "she gives to her"
	cont "#MON, I mean."
	done

VioletNicknameSpeechHouseLassText:
	text "I call my PIDGEY"
	line "STRAWBERRY!"
	done

VioletNicknameSpeechHouseBirdText:
	text "STRAWBERRY: Pijji!"
	done
	
VioletNicknameSpeechPupilText:
	text "I dislike the"
	line "online classes."

	para "I remember better"
	line "when I write in"
	cont "my notebook."
	done

VioletNicknameSpeechHouseComputer1Text:
	text "Today's lesson is"
	line "about COVID."
	
	para "The teacher made a"
	line "web presentation."
	done

VioletNicknameSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 4
	warp_event  4,  7, VIOLET_CITY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechHouseTeacherScript, -1
	object_event  6,  4, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechHouseLassScript, -1
	object_event  5,  2, SPRITE_PIDGEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechHouseBirdScript, -1

	object_event  3,  5, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechPupilScript, -1
	object_event  3,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechHouseNotebookScript, -1
	object_event  4,  4, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechHouseComputer1Script, -1
