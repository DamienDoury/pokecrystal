	object_const_def
	const CIANWOODLUGIASPEECHHOUSE_TEACHER
	const CIANWOODLUGIASPEECHHOUSE_LASS
	const CIANWOODLUGIASPEECHHOUSE_TWIN
	const CIANWOODLUGIASPEECHHOUSE_TEACHER_LOCKDOWN
	const CIANWOODLUGIASPEECHHOUSE_COMPUTER

CianwoodLugiaSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad

.TilesLoad
	readmem wCurFreedomState
	ifnotequal 1 << LOCKDOWN, .end

	changeblock  4,  2, $35
.end
	endcallback

CianwoodLugiaSpeechHouseTeacherScript:
	jumptextfaceplayer CianwoodLugiaSpeechHouseTeacherText

CianwoodLugiaSpeechHouseTeacherLockdownScript:
	faceplayer
	opentext
	writetext CianwoodLugiaSpeechHouseTeacherLockdownText
	waitbutton
	closetext
	turnobject CIANWOODLUGIASPEECHHOUSE_TEACHER_LOCKDOWN, LEFT
	end

CianwoodLugiaSpeechHouseLassScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseLassText

.lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseLassLockdownText

CianwoodLugiaSpeechHouseTwinScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseTwinText

.lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseTwinLockdownText

CianwoodLugiaSpeechHouseComputerScript:
	jumptext CianwoodLugiaSpeechHouseComputerText

CianwoodLugiaSpeechHouseBookshelf:
	jumpstd PictureBookshelfScript

CianwoodLugiaSpeechHouseTeacherText:
	text "You came from"
	line "OLIVINE?"

	para "Do you remember"
	line "the four islands"
	cont "along the way?"

	para "I heard that a "
	line "mythical sea crea-"
	cont "ture is hiding in"
	cont "them."
	done

CianwoodLugiaSpeechHouseLassText:
	text "I read that you"
	line "can only see the"

	para "sea creature if"
	line "you have a SILVER"
	cont "WING."

	para "It must have the"
	line "same scent as the"
	cont "creature."
	done

CianwoodLugiaSpeechHouseLassLockdownText:
	text "“The air from the"
	line "sea will be good"
	cont "for you” said Mom."

	para "I know no one"
	line "around, and I can't"
	
	para "even follow the"
	line "online class."

	para "This is the true"
	line "definition of a"
	cont "lockdown."
	done

CianwoodLugiaSpeechHouseTwinText:
	text "I've read that"
	line "the whirlpools"

	para "around the islands"
	line "are caused by the"
	cont "sea creature."

	para "You might need a"
	line "special move to"
	cont "get past them."
	done

CianwoodLugiaSpeechHouseTwinLockdownText:
	text "Mom didn't think"
	line "about the internet"
	
	para "connexion quality"
	line "before moving us"
	cont "here."
	
	para "It's the number one"
	line "most important"
	
	para "thing in this"
	line "period!"
	
	para "Here I am, stuck"
	line "reading books…"
	done

CianwoodLugiaSpeechHouseTeacherLockdownText:
	text "So when the first"
	line "lockdown was ann-"
	cont "ounced, I quickly"
	cont "moved my family"
	cont "from SAFFRON CITY"
	cont "to this vacation"
	cont "house we own."

	para "I am supposed to"
	line "work remotely but…"

	para "This is embarras-"
	line "sing…"
	cont "Look at my screen…"
	done

CianwoodLugiaSpeechHouseComputerText:
	text "A video call run-"
	line "ning at a whopping"
	cont "20 frames per"
	
	para "minute."
	done

CianwoodLugiaSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 6
	warp_event  3,  7, CIANWOOD_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CianwoodLugiaSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CianwoodLugiaSpeechHouseBookshelf

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseTeacherScript, -1
	object_event  6,  5, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseLassScript, -1
	object_event  0,  2, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseTwinScript, -1
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseTeacherLockdownScript, -1
	object_event  4,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseComputerScript, -1