	object_const_def
	const GOLDENRODPPSPEECHHOUSE_FISHER
	const GOLDENRODPPSPEECHHOUSE_LASS
	const GOLDENRODPPSPEECHHOUSE_COMPUTER

GoldenrodPPSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject GOLDENRODPPSPEECHHOUSE_FISHER, 5, 1
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	endcallback

.TilesLoad
	readmem wCurFreedomState
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	changeblock  4,  2, $35
.end
	endcallback

GoldenrodPPSpeechHouseFisherScript:
	jumptextfaceplayer GoldenrodPPSpeechHouseFisherText

GoldenrodPPSpeechHouseLassScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	jumptextfaceplayer GoldenrodPPSpeechHouseLassText

.lockdown
	jumptextfaceplayer GoldenrodPPSpeechHouseLassLockdownText

GoldenrodPPSpeechHouseComputerScript:
	jumptext GoldenrodPPSpeechHouseComputerText

GoldenrodPPSpeechHouseBookshelf2:
	jumpstd DifficultBookshelfScript

GoldenrodPPSpeechHouseBookshelf1:
	jumpstd MagazineBookshelfScript

GoldenrodPPSpeechHouseRadio:
	jumpstd Radio3Script

GoldenrodPPSpeechHouseFisherText: 
if DEF(_FR_FR)
	text "Une fois lorsque"
	line "je me battais, mes"

	para "#MON ne"
	line "pouvaient plus"
	cont "attaquer."

	para "Les POINTS de"
	line "POUVOIR, ou PP,"

	para "de mes attaques"
	line "étaient épuisés."
else
	text "Once while I was"
	line "battling, my"

	para "#MON couldn't"
	line "make any moves."

	para "The POWER POINTS,"
	line "or PP, of its"

	para "moves were all"
	line "gone."
endc

	done

GoldenrodPPSpeechHouseLassText: 
if DEF(_FR_FR)
	text "Quelques fois, un"
	line "#MON en pleine"

	para "forme ne peut pas"
	line "utiliser ses"
	cont "attaques."

	para "Si cela se produit"
	line "soigne-le dans un"
	cont "CENTRE #MON ou"
	cont "utilise un objet."
else
	text "Sometimes, a"
	line "healthy #MON"

	para "may be unable to"
	line "use its moves."

	para "If that happens,"
	line "heal it at a #-"
	cont "MON CENTER or use"
	cont "an item."
endc

	done

GoldenrodPPSpeechHouseLassLockdownText:
if DEF(_FR_FR)
	text "Les appels vidéo,"
	line "c'est étrange."
	
	para "Il va me falloir"
	line "du temps pour"
	cont "m'y habituer."
else
	text "Video calls are"
	line "weird. I'll need"
	cont "time to get used"
	cont "to it."
endc
	done

GoldenrodPPSpeechHouseComputerText:
if DEF(_FR_FR)
	text "Un appel vidéo"
	line "avec une personne"
	cont "habillée d'une"
	cont "chemise et d'une"
	cont "cravate."
	
	para "Un miroir sur le"
	line "mur du fond révèle"
	
	para "que cette personne"
	line "ne porte rien"
	cont "d'autre."
else
	text "A video call with"
	line "a person wearing a"
	cont "shirt and a tie."
	
	para "A mirror on the"
	line "back wall reveals"
	
	para "it is all this"
	line "person is wearing."
endc
	done

GoldenrodPPSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 7
	warp_event  3,  7, GOLDENROD_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, GoldenrodPPSpeechHouseBookshelf1
	bg_event  1,  1, BGEVENT_READ, GoldenrodPPSpeechHouseBookshelf2
	bg_event  7,  1, BGEVENT_READ, GoldenrodPPSpeechHouseRadio

	def_object_events
	object_event  2,  4, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodPPSpeechHouseFisherScript, -1
	object_event  5,  3, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPPSpeechHouseLassScript, -1
	object_event  4,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPPSpeechHouseComputerScript, -1
