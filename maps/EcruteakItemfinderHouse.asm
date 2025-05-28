	object_const_def
	const ECRUTEAKITEMFINDERHOUSE_COOLTRAINER_M
	const ECRUTEAKITEMFINDERHOUSE_POKEDEX
	const ECRUTEAKITEMFINDERHOUSE_SISTER

EcruteakItemfinderHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject ECRUTEAKITEMFINDERHOUSE_SISTER, 7, 3
	loadmem wMap3ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
.end
	endcallback

EcruteakItemfinderGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_ITEMFINDER
	iftrue .itemfinder
	writetext EcruteakItemfinderAdventureText
	yesorno
	iffalse .no
	writetext EcruteakItemfinderTrueSpiritText
	promptbutton
	verbosegiveitem ITEMFINDER
	setevent EVENT_GOT_ITEMFINDER
.itemfinder:
	farwritetext ItemfinderExplanationText
	waitbutton
	closetext
	end

.no:
	writetext EcruteakItemfinderToEachHisOwnText
	waitbutton
	closetext
	end

EcruteakItemfinderGirl:
	jumptextfaceplayer EcruteakItemfinderGirlText

EcruteakHistoryBook:
	opentext
	writetext EcruteakHistoryBookText
	yesorno
	iftrue .ReadBook
	closetext
	end

.ReadBook:
	writetext EcruteakTwoTowersText
	yesorno
	iftrue .KeepReading
	closetext
	end

.KeepReading:
	writetext EcruteakThreeMonText
	waitbutton
	closetext
	end

ItemFinderHouseRadio:
	jumpstd Radio2Script

EcruteakItemfinderAdventureText: 
if DEF(_FR_FR)
	text "Ah! Tu fais les"
	line "400 coups avec tes"
	cont "#MON?"

	para "Mais qu'est-ce"
	line "qu'une aventure"
	cont "sans une chasse au"
	cont "trésor?"

	para "J'ai bon ou j'ai"
	line "bon?"
else
	text "Ah. You're on an"
	line "adventure with"
	cont "your #MON?"

	para "Well, what's an"
	line "adventure without"
	cont "treasure hunting?"

	para "Am I right, or am"
	line "I right?"
endc

	done

EcruteakItemfinderTrueSpiritText: 
if DEF(_FR_FR)
	text "C'est cool, tu"
	line "comprends le vrai"

	para "esprit de l'aven-"
	line "ture."

	para "Et moi, j'aime ça!"
	line "Prends ça avec"
	cont "toi."
else
	text "Good! You under-"
	line "stand the true"

	para "spirit of adven-"
	line "ture."

	para "I like that! Take"
	line "this with you."
endc

	done

EcruteakItemfinderToEachHisOwnText: 
if DEF(_FR_FR)
	text "Oh... Chacun pour"
	line "soi je parie."
else
	text "Oh… To each his"
	line "own, I suppose…"
endc

	done

EcruteakItemfinderGirlText: ; TO TRANSLATE
	text "My brother lives"
	line "in AZALEA TOWN"
	cont "with his trusty"
	cont "FARFETCH'D."


	para "I hope they"
	line "are ok…"
	done

EcruteakHistoryBookText: 
if DEF(_FR_FR)
	text "HISTOIRE de"
	line "ROSALIA"

	para "Désirez-vous lire?"
else
	text "HISTORY OF"
	line "ECRUTEAK"

	para "Want to read it?"
endc

	done

EcruteakTwoTowersText: 
if DEF(_FR_FR)
	text "Il existait deux"
	line "tours à ROSALIA."

	para "Chacune d'elle"
	line "était le perchoir"
	cont "d'un puissant"
	cont "#MON volant."

	para "Mais l'une des"
	line "tours a complète-"
	cont "ment brûlé."

	para "Les deux #MON"
	line "n'ont jamais été"
	cont "revus depuis..."

	para "Continuer à lire?"
else
	text "In ECRUTEAK, there"
	line "were two towers."

	para "Each tower was the"
	line "roost of powerful"
	cont "flying #MON."

	para "But one of the"
	line "towers burned to"
	cont "the ground."

	para "The two #MON"
	line "haven't been seen"
	cont "since…"

	para "Keep reading?"
endc

	done

EcruteakThreeMonText: 
if DEF(_FR_FR)
	text "ROSALIA était"
	line "aussi la demeure"

	para "de trois #MON"
	line "qui couraient"
	cont "autour de la"
	cont "ville."

	para "Ils étaient soi-"
	line "disant nés de"

	para "l'eau, de la"
	line "foudre et du feu."

	para "Mais ils ne"
	line "pouvaient pas"
	cont "contenir toute"
	cont "leur puissance."

	para "C'est la raison"
	line "pour laquelle ils"

	para "couraient sans"
	line "cesse."
else
	text "ECRUTEAK was also"
	line "home to three"

	para "#MON that raced"
	line "around the town."

	para "They were said to"
	line "have been born of"

	para "water, lightning"
	line "and fire."

	para "But they could not"
	line "contain their"
	cont "excessive power."

	para "So they say the"
	line "three ran like the"

	para "wind off into the"
	line "grassland."
endc

	done

EcruteakItemfinderHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 11
	warp_event  4,  7, ECRUTEAK_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ItemFinderHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakItemfinderGuy, -1
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakHistoryBook, -1
	object_event  4,  5, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakItemfinderGirl, -1
