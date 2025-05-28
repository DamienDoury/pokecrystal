	object_const_def
	const FASTSHIPCABINS_SW_SSW_NW_FISHER
	const FASTSHIPCABINS_SW_SSW_NW_BUG_CATCHER
	const FASTSHIPCABINS_SW_SSW_NW_BEAUTY
	const FASTSHIPCABINS_SW_SSW_NW_ROCKER

FastShipCabins_SW_SSW_NW_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerFirebreatherLyle:
	trainer FIREBREATHER, LYLE, EVENT_BEAT_FIREBREATHER_LYLE, FirebreatherLyleSeenText, FirebreatherLyleBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherLyleAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherKen:
	trainer BUG_CATCHER, KEN, EVENT_BEAT_BUG_CATCHER_KEN, BugCatcherKenSeenText, BugCatcherKenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BugCatcherKenAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautyCassie:
	trainer BEAUTY, CASSIE, EVENT_BEAT_BEAUTY_CASSIE, BeautyCassieSeenText, BeautyCassieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautyCassieAfterBattleText
	waitbutton
	closetext
	end

TrainerGuitaristClyde:
	trainer GUITARIST, CLYDE, EVENT_BEAT_GUITARIST_CLYDE, GuitaristClydeSeenText, GuitaristClydeBeatenText, 0, .Script

.Script:
	endifjustbattled
	special Mobile_DummyReturnFalse
	iftrue .mobile
	opentext
	writetext GuitaristClydeAfterBattleText
	waitbutton
	closetext
	end

.mobile
	opentext
	writetext GuitaristClydeAfterBattleMobileText
	waitbutton
	closetext
	end

FastShipBed:
	opentext
	writetext FastShipBedText1
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	special StubbedTrainerRankings_Healings
	special HealParty
	playmusic MUSIC_HEAL
	pause 60
	special RestartMapMusic
	special FadeInQuickly
	opentext
	writetext FastShipBedText2
	waitbutton
	closetext
	checkevent EVENT_FAST_SHIP_HAS_ARRIVED
	iftrue .AlreadyArrived
	checkevent EVENT_FAST_SHIP_FOUND_GIRL
	iftrue .CanArrive
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .CanArrive
.AlreadyArrived:
	end

.CanArrive:
	playsound SFX_ELEVATOR_END
	pause 30
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue .ArrivedOlivine
	opentext
	writetext FastShipArrivedVermilionText
	waitbutton
	closetext
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	end

.ArrivedOlivine:
	opentext
	writetext FastShipArrivedOlivineText
	waitbutton
	closetext
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	end

FastShipCabinsNorthwestCabinTrashcan:
	jumpstd TrashCanScript

FirebreatherLyleSeenText: 
if DEF(_FR_FR)
	text "Je vais à KANTO"
	line "me donner en"
	cont "spectacle!"
else
	text "I'm going to KANTO"
	line "to put on fire-"
	cont "breathing shows!"
endc

	done

FirebreatherLyleBeatenText: 
if DEF(_FR_FR)
	text "Pfff... Ma flamme"
	line "est minuscule..."
else
	text "Fizzle… The"
	line "flame's tiny…"
endc

	done

FirebreatherLyleAfterBattleText: 
if DEF(_FR_FR)
	text "Le feu c'est nul"
	line "sur l'eau, non?"

	para "Ca change rien?"
	line "Vraiment?"
else
	text "I guess fire is"
	line "weak on the sea."

	para "It doesn't matter?"
	line "Really?"
endc

	done

BugCatcherKenSeenText: 
if DEF(_FR_FR)
	text "Je vais voir ma"
	line "grand-mère pour"
	cont "attraper des"
	cont "insectes!"
else
	text "I'm visiting my"
	line "grandma to catch"
	cont "me some bugs!"
endc

	done

BugCatcherKenBeatenText: 
if DEF(_FR_FR)
	text "Ooh!"
	line "Fort de café!"
else
	text "Ooh, wow."
	line "You're tough!"
endc

	done

BugCatcherKenAfterBattleText: 
if DEF(_FR_FR)
	text "Il y a plein de"
	line "#MON dans les"
	cont "arbres de JOHTO!"
else
	text "You can find lots"
	line "of #MON in the"
	cont "trees of JOHTO!"
endc

	done

BeautyCassieSeenText: 
if DEF(_FR_FR)
	text "J'oublie mes"
	line "malheurs et..."
	cont "COMBAT!"
else
	text "I'm trying to"
	line "forget my woes."
	cont "Let's battle!"
endc

	done

BeautyCassieBeatenText: 
if DEF(_FR_FR)
	text "Mon coeur saigne."
else
	text "My heart weeps…"
endc

	done

BeautyCassieAfterBattleText: 
if DEF(_FR_FR)
	text "Voyager fait ou-"
	line "blier les peines"
	cont "de coeur."

	para "Mais un BATEAU"
	line "EXPRESS va trop"
	cont "vite!!!"
else
	text "A voyage is best"
	line "for getting over"
	cont "a broken heart."

	para "But a FAST SHIP"
	line "trip is too short"
	cont "for grieving."
endc

	done

GuitaristClydeSeenText: 
if DEF(_FR_FR)
	text "Je vais audition-"
	line "ner à la STATION"

	para "RADIO de DOUBLON-"
	line "VILLE."
else
	text "I'm going to audi-"
	line "tion my songs at"

	para "GOLDENROD's RADIO"
	line "STATION."
endc

	done

GuitaristClydeBeatenText: 
if DEF(_FR_FR)
	text "Wouh!"
	line "Un bide!"
else
	text "Yowza!"
	line "Total distortion!"
endc

	done

GuitaristClydeAfterBattleMobileText: 
if DEF(_FR_FR)
	text "J'allais me lancer"
	line "dans le défi de la"
	cont "TOUR DE COMBAT..."

	para "Je devrais retour-"
	line "ner à CARMIN et"
	cont "m'entraîner..."
else
	text "I was going to"
	line "make my debut at"
	cont "the BATTLE TOWER…"

	para "I should go back"
	line "to VERMILION and"
	cont "redo my training…"
endc

	done

GuitaristClydeAfterBattleText: 
if DEF(_FR_FR)
	text "Au fait..."
	line "C'est quoi le BON"

	para "NUMERO de cette"
	line "semaine?"
else
	text "Speaking of the"
	line "RADIO STATION,"

	para "what's this week's"
	line "lucky number?"
endc

	done

FastShipBedText1: 
if DEF(_FR_FR)
	text "Un lit douillet!"
	line "Hop! Au dodo..."
else
	text "A comfy bed!"
	line "Time to sleep…"
endc

	done

FastShipBedText2: 
if DEF(_FR_FR)
	text "Ah... C'est la"
	line "super pêche!"
else
	text "Ah, refreshed and"
	line "restored!"
endc

	done

FastShipArrivedOlivineText: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA est arrivé"
	cont "à OLIVILLE."
else
	text "FAST SHIP S.S.AQUA"
	line "has arrived in"
	cont "OLIVINE CITY."
endc

	done

FastShipArrivedVermilionText: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA est arrivé"
	cont "à CARMIN SUR MER."
else
	text "FAST SHIP S.S.AQUA"
	line "has arrived in"
	cont "VERMILION CITY."
endc

	done

FastShipCabins_SW_SSW_NW_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  0, FAST_SHIP_1F, 5
	warp_event  2, 19, FAST_SHIP_1F, 6
	warp_event  3, 19, FAST_SHIP_1F, 6
	warp_event  2, 31, FAST_SHIP_1F, 7
	warp_event  3, 31, FAST_SHIP_1F, 7

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, FastShipBed
	bg_event  7,  2, BGEVENT_READ, FastShipBed
	bg_event  7,  7, BGEVENT_READ, FastShipCabinsNorthwestCabinTrashcan

	def_object_events
	object_event  1, 15, SPRITE_FISHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherLyle, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  6, 15, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBugCatcherKen, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  1, 26, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBeautyCassie, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  3, 28, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerGuitaristClyde, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
