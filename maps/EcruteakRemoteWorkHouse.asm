	object_const_def
	const ECRUTEAKREMOTEWORKHOUSE_MOTHER
	const ECRUTEAKREMOTEWORKHOUSE_SCIENTIST
	const ECRUTEAKREMOTEWORKHOUSE_MICKEY
	const ECRUTEAKREMOTEWORKHOUSE_COMPUTER1
	const ECRUTEAKREMOTEWORKHOUSE_COMPUTER2

EcruteakRemoteWorkHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad

.TilesLoad
	changeblock  4,  2, $3b
	changeblock  4,  4, $3f
	changeblock  0,  6, $3c
	changeblock  6,  6, $05

	readmem wCurFreedomState
	ifnotequal 1 << LOCKDOWN, .end

	changeblock  2,  2, $3a
	changeblock  6,  6, $2b
.end
	endcallback

EcruteakRemoteWorkHouse_MotherScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown

	jumptextfaceplayer EcruteakRemoteWorkHouse_MotherAloneText
.lockdown
	jumptextfaceplayer EcruteakRemoteWorkHouse_MotherHappyText

EcruteakRemoteWorkHouse_ScientistScript:
	faceplayer
	opentext
	writetext EcruteakRemoteWorkHouse_ScientistText
	waitbutton
	closetext
	turnobject ECRUTEAKREMOTEWORKHOUSE_SCIENTIST, LEFT
	end

EcruteakRemoteWorkHouse_MickeyScript:
	faceplayer
	opentext
	writetext EcruteakRemoteWorkHouse_MickeyText
	waitbutton
	closetext
	turnobject ECRUTEAKREMOTEWORKHOUSE_MICKEY, RIGHT
	end

EcruteakRemoteWorkHouse_Computer1Script:
	farsjump VioletNicknameSpeechHouseComputer1Script

EcruteakRemoteWorkHouse_Computer2Script:
	jumptextfaceplayer EcruteakRemoteWorkHouse_Computer2Text

EcruteakRemoteWorkHouse_Radio:
	jumpstd Radio1Script

EcruteakRemoteWorkHouse_MotherAloneText:
	text "This house feels"
	line "empty without my"
	cont "two men…"
	done

EcruteakRemoteWorkHouse_MotherHappyText:
	text "The stay-at-home"
	line "order allows me to"
	cont "see my two men."
	
	para "It makes me"
	line "joyful!"
	done

EcruteakRemoteWorkHouse_ScientistText:
	text "I can't wait to be"
	line "back on the field!"
	done

EcruteakRemoteWorkHouse_MickeyText:
	text "MICKEY: I wish I"
	line "could trade with"
	cont "my friend ROBIN."

	para "But the Link Cable"
	line "isn't long enough"
	cont "to reach his house"
	cont "in VIOLET CITY!"

	para "Anyway, today's"
	line "lesson is interes-"
	cont "ting! Check it out"
	cont "on my screen."
	done

EcruteakRemoteWorkHouse_Computer2Text:
	text "It's a text editor."

	para "-Research notes-"
	
	para "The writings in"
	line "the main chamber"
	
	para "seem to be some"
	line "kind of language."

	para "Some pieces are"
	line "more recent than"
	cont "others."
	
	para "No one understands"
	line "what it's about!"
	done

EcruteakRemoteWorkHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 18
	warp_event  4,  7, ECRUTEAK_CITY, 18

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_MotherScript, -1
	object_event  5,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_ScientistScript, -1
	object_event  2,  3, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_MickeyScript, -1
	object_event  3,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_Computer1Script, -1
	object_event  4,  4, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_Computer2Script, -1
