MAHOGANYTOWN_RAGECANDYBAR_PRICE EQU 300

	object_const_def
	const MAHOGANYTOWN_TRAVEL_CONTROLLER
	const MAHOGANYTOWN_GRAMPS
	const MAHOGANYTOWN_LASS

MahoganyTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_MAHOGANY
	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel
	specialphonecall SPECIALCALL_CONTACT_TRACING_AVAILABLE
.endcallback
	endcallback

MahoganyTownGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	writetext MahoganyTownGrampsText
	waitbutton
	closetext
	end

.ClearedRocketHideout:
	writetext MahoganyTownGrampsText_ClearedRocketHideout
	waitbutton
	closetext
	end

MahoganyTownLassScript:
	jumptextfaceplayer MahoganyTownLassText

MahoganyTownSign:
	jumptext MahoganyTownSignText

MahoganyTownRagecandybarSign:
	jumptext MahoganyTownRagecandybarSignText

MahoganyGymSign:
	jumptext MahoganyGymSignText

MahoganyTownPokecenterSign:
	jumpstd PokecenterSignScript

MahoganyTown_DoorScript:
	jumpstd LockdownCurfewClosedDoor

MahoganyTownGrampsText: 
if DEF(_FR_FR)
	text "Sors-tu pour voir"
	line "le LEVIATOR"
	cont "déchaîné au LAC?"
else
	text "Are you off to see"
	line "the GYARADOS ram-"
	cont "page at the LAKE?"
endc

	done

MahoganyTownGrampsText_ClearedRocketHideout: 
if DEF(_FR_FR)
	text "Des MAGICARPE sont"
	line "revenus au LAC"
	cont "COLERE."

	para "Ca devrait faire"
	line "plaisir aux"
	cont "pêcheurs du coin."
else
	text "MAGIKARP have"
	line "returned to LAKE"
	cont "OF RAGE."

	para "That should be"
	line "good news for the"
	cont "anglers there."
endc

	done

MahoganyTownLassText: 
if DEF(_FR_FR)
	text "Va voir la"
	line "boutique de mémé."

	para "Elle vend des"
	line "trucs incroyables."
else
	text "Visit Grandma's"
	line "shop. She sells"

	para "stuff that nobody"
	line "else has."
endc

	done

MahoganyTownSignText: 
if DEF(_FR_FR)
	text "ACAJOU"

	para "Bienvenue chez"
	line "le grand ninja"
else
	text "MAHOGANY TOWN"

	para "Welcome to the"
	line "Home of the Ninja"
endc

	done

MahoganyTownRagecandybarSignText:
if DEF(_FR_FR)
	text "Pendant votre"
	line "visite d'ACAJOU,"
	cont "essayez un BONBON"
	cont "RAGE!"
else
	text "While visiting"
	line "MAHOGANY TOWN, and"
	cont "LAKE OF RAGE, try"
	cont "a CAKE OF RAGE!"
endc
	done

MahoganyGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "d'ACAJOU: FREDO"

	para "Le prof. qui"
	line "venait du froid"
else
	text "MAHOGANY TOWN"
	line "#MON GYM"
	cont "LEADER: PRYCE"

	para "The Teacher of"
	line "Winter's Harshness"
endc

	done

MahoganyTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11,  7, MAHOGANY_MART_1F, 1
	warp_event 17,  7, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, 1
	warp_event  6, 13, MAHOGANY_GYM, 1
	warp_event 15, 13, MAHOGANY_POKECENTER_1F, 1

	def_coord_events

	def_bg_events
	bg_event  1,  5, BGEVENT_READ, MahoganyTownSign
	bg_event  9,  7, BGEVENT_READ, MahoganyTownRagecandybarSign
	bg_event  3, 13, BGEVENT_READ, MahoganyGymSign
	bg_event 16, 13, BGEVENT_READ, MahoganyTownPokecenterSign

	def_object_events
	object_event 17, 14, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | MORN | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event  6,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyTownGrampsScript, -1
	object_event 12,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyTownLassScript, EVENT_MAHOGANY_MART_OWNERS
	object_event 11,  7, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyTown_DoorScript, EVENT_MAHOGANY_MART_OWNERS
