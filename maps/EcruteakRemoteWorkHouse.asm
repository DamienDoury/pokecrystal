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
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	changeblock  2,  2, $3a
	changeblock  6,  6, $2b
.end
	endcallback

EcruteakRemoteWorkHouse_MotherScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown

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
	jumptext EcruteakRemoteWorkHouse_Computer2Text

EcruteakRemoteWorkHouse_Radio:
	jumpstd Radio1Script

EcruteakRemoteWorkHouse_MotherAloneText:
if DEF(_FR_FR)
	text "Cette maison est"
	line "vide sans mes"
	cont "deux hommes..."
else
	text "This house feels"
	line "empty without my"
	cont "two men…"
endc
	done

EcruteakRemoteWorkHouse_MotherHappyText:
if DEF(_FR_FR)
	text "Le confinement me"
	line "permet de voir"
	cont "mes deux hommes."
	
	para "Cela me rend"
	line "joyeuse!"
else
	text "The stay-at-home"
	line "order allows me to"
	cont "see my two men."
	
	para "It makes me"
	line "joyful!"
endc
	done

EcruteakRemoteWorkHouse_ScientistText:
if DEF(_FR_FR)
	text "J'ai hâte de"
	line "retourner sur"
	cont "le terrain!"
else
	text "I can't wait to be"
	line "back on the field!"
endc
	done

EcruteakRemoteWorkHouse_MickeyText:
if DEF(_FR_FR)
	text "MICKEY: J'aimerais"
	line "échanger avec"
	cont "mon ami ROBIN."

	para "Mais le CABLE"
	line "LINK n'est pas"
	cont "assez long pour"
	cont "aller jusqu'à sa"
	cont "maison à MAUVILLE!"

	para "Bref. La leçon"
	line "d'aujourd'hui est"
	cont "passionnante!"
	cont "Jette un oeil à"
	cont "mon écran."
else
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
endc
	done

EcruteakRemoteWorkHouse_Computer2Text:
if DEF(_FR_FR)
	text "C'est un éditeur"
	line "de texte."

	para "-Notes de"
	line "recherche-"
	
	para "Les écrits dans"
	line "la salle princi-"
	cont "pale semblent"
	cont "être une sorte de"
	cont "langage."

	para "Certains passages"
	line "sont plus récents"
	cont "que d'autres."
	
	para "Personne ne sait"
	line "de quoi il s'agit!"
else
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
endc
	done

EcruteakRemoteWorkHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 18
	warp_event  4,  7, ECRUTEAK_CITY, 18

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_MotherScript, -1
	object_event  5,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_ScientistScript, -1
	object_event  2,  3, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_MickeyScript, -1
	object_event  3,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_Computer1Script, -1
	object_event  4,  4, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakRemoteWorkHouse_Computer2Script, -1
