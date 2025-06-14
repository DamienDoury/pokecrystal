	object_const_def
	const BLACKTHORNDRAGONSPEECHHOUSE_GRANNY
	const BLACKTHORNDRAGONSPEECHHOUSE_EKANS

BlackthornDragonSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject BLACKTHORNDRAGONSPEECHHOUSE_GRANNY, 4, 2
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

BlackthornDragonSpeechHouseGrannyScript:
	jumptextfaceplayer BlackthornDragonSpeechHouseGrannyText

BlackthornDragonSpeechHouseDratiniScript:
	opentext
	writetext BlackthornDragonSpeechHouseDratiniText
	cry DRATINI
	waitbutton
	closetext
	end

BlackthornDragonSpeechHouse_Radio:
	jumpstd Radio3Script

BlackthornDragonSpeechHouseGrannyText: 
if DEF(_FR_FR)
	text "Un clan de dres-"
	line "seurs commandant"

	para "les dragons vit"
	line "ici à EBENELLE."

	para "C'est pour cela"
	line "qu'il y a beaucoup"

	para "de légendes sur"
	line "les dragons dans"
	cont "cette ville."
else
	text "A clan of trainers"
	line "who can freely"

	para "command dragons"
	line "live right here in"
	cont "BLACKTHORN."

	para "As a result, there"
	line "are many legends"

	para "about dragons in"
	line "this town."
endc

	done

BlackthornDragonSpeechHouseDratiniText: 
if DEF(_FR_FR)
	text "MINIDRACO: Draa!"
else
	text "DRATINI: Draa!"
endc

	done

BlackthornDragonSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 2
	warp_event  3,  7, BLACKTHORN_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, BlackthornDragonSpeechHouse_Radio

	def_object_events
	object_event  2,  3, SPRITE_GRANNY, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornDragonSpeechHouseGrannyScript, -1
	object_event  5,  5, SPRITE_DRATINI, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornDragonSpeechHouseDratiniScript, -1
