	object_const_def
	const ROUTE8_BIKER1
	const ROUTE8_BIKER2
	const ROUTE8_BIKER3
	const ROUTE8_SUPER_NERD1
	const ROUTE8_SUPER_NERD2
	const ROUTE8_FRUIT_TREE
	const ROUTE8_JASMINE
	const ROUTE8_BURIAL_GUY1
	const ROUTE8_BURIAL_GUY2
	const ROUTE8_BURIAL_GUY3
	const ROUTE8_BURIAL_GUY4

Route8_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBikerDwayne:
	trainer BIKER, DWAYNE, EVENT_BEAT_BIKER_DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerDwayneAfterBattleText

TrainerBikerHarris:
	trainer BIKER, HARRIS, EVENT_BEAT_BIKER_HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerHarrisAfterBattleText

TrainerBikerZeke:
	trainer BIKER, ZEKE, EVENT_BEAT_BIKER_ZEKE, BikerZekeSeenText, BikerZekeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerZekeAfterBattleText

TrainerSupernerdSam:
	trainer SUPER_NERD, SAM, EVENT_BEAT_SUPER_NERD_SAM, SupernerdSamSeenText, SupernerdSamBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SupernerdSamAfterBattleText

TrainerSupernerdTom:
	trainer SUPER_NERD, TOM, EVENT_BEAT_SUPER_NERD_TOM, SupernerdTomSeenText, SupernerdTomBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SupernerdTomAfterBattleText

Route8LockedDoor:
	jumptext Route8LockedDoorText

Route8UndergroundPathSign:
	jumptext Route8UndergroundPathSignText

Route8BurialGuyScript:
	jumptextfaceplayer Route8BurialGuyText

Route8FruitTree:
	fruittree FRUITTREE_ROUTE_8


BikerDwayneSeenText: 
if DEF(_FR_FR)
	text "Nous sommes la"
	line "FEDERATION des"
	cont "dresseurs de #-"
	cont "MON de KANTO."

	para "On va te faire"
	line "ta fête!"
else
	text "We're the KANTO"
	line "#MON FEDERATION"
	cont "trainer group."

	para "We'll drive you"
	line "under our wheels!"
endc

	done

BikerDwayneBeatenText: 
if DEF(_FR_FR)
	text "P-Pardon!"
else
	text "S-sorry!"
endc

	done

BikerDwayneAfterBattleText: 
if DEF(_FR_FR)
	text "La FEDERATION des"
	line "dresseurs de KANTO"
	cont "est invincible!"
else
	text "The KANTO #MON"
	line "FEDERATION will"
	cont "never fall!"
endc

	done

BikerHarrisSeenText: 
if DEF(_FR_FR)
	text "La police a fermé"
	line "notre SOUTERRAIN!"

	para "C'est injuste!"
	line "C'est dégueulasse!"
else
	text "The cops shut down"
	line "our UNDERGROUND"

	para "PATH! That really"
	line "fries me!"
endc

	done

BikerHarrisBeatenText: 
if DEF(_FR_FR)
	text "P-Pardon!"
else
	text "F-forgive me!"
endc

	done

BikerHarrisAfterBattleText: 
if DEF(_FR_FR)
	text "Battu par quelqu'"
	line "un de JOHTO..."
else
	text "Wiped out by some"
	line "punk from JOHTO…"
endc

	done

BikerZekeSeenText: 
if DEF(_FR_FR)
	text "On est la FEDERA-"
	line "TION des dresseurs"
	cont "de KANTO."
	cont "On est cool!"
else
	text "We're the KANTO"
	line "#MON FEDERA-"
	cont "TION!"
	cont "Right on!"
endc

	done

BikerZekeBeatenText: 
if DEF(_FR_FR)
	text "Oups! Pardon!"
else
	text "Yikes! Sorry!"
endc

	done

BikerZekeAfterBattleText: 
if DEF(_FR_FR)
	text "On va essayer de"
	line "n'plus déranger..."
	cont "Pardon."
else
	text "We'll try not to"
	line "disturb anyone"
	cont "from now on…"
endc

	done

SupernerdSamSeenText: 
if DEF(_FR_FR)
	text "Comment ça marche"
	line "un TRAIN MAGNET?"
else
	text "How does the MAG-"
	line "NET TRAIN work?"
endc

	done

SupernerdSamBeatenText: 
if DEF(_FR_FR)
	text "Moi je veux voir"
	line "le TRAIN MAGNET..."
else
	text "I just want to see"
	line "the MAGNET TRAIN…"
endc

	done

SupernerdSamAfterBattleText: 
if DEF(_FR_FR)
	text "La puissance"
	line "magnétique, c'est"
	cont "terrible!"
else
	text "The power of mag-"
	line "nets is awesome!"
endc

	done

SupernerdTomSeenText: 
if DEF(_FR_FR)
	text "Hmm... Tu en as"
	line "des bô BADGES."
else
	text "Hm… You've got"
	line "many GYM BADGES."
endc

	done

SupernerdTomBeatenText: 
if DEF(_FR_FR)
	text "Pas mal..."
	line "Je m'y attendais!"
else
	text "Just as I thought…"
	line "You're tough!"
endc

	done

SupernerdTomAfterBattleText:
if DEF(_FR_FR)
	text "Les BADGES sont"
	line "une preuve de"
	cont "ta valeur."
else
	text "GYM BADGES are"
	line "a proof of your"
	cont "worth."
endc
	done

Route8LockedDoorText: 
if DEF(_FR_FR)
	text "C'est fermé..."
else
	text "It's locked…"
endc

	done

Route8UndergroundPathSignText: 
if DEF(_FR_FR)
	text "L'affiche est"
	line "déchirée."

	para "C'est impossible"
	line "de la lire..."
else
	text "The flyer's torn."

	para "It's impossible to"
	line "read…"
endc

	done

Route8BurialGuyText:
if DEF(_FR_FR)
	text "Notre groupe a"
	line "fait le chemin"
	
	para "depuis JOHTO pour"
	line "les funérailles de"
	
	para "notre bien-aimé"
	line "#MON..."
else
	text "Our group comes"
	line "all the way from"

	para "JOHTO for the"
	line "funeral of our"

	para "beloved #MON…"
endc
	done

Route8_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  4, ROUTE_8_SAFFRON_GATE, 3
	warp_event  4,  5, ROUTE_8_SAFFRON_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 11,  5, BGEVENT_READ, Route8UndergroundPathSign
	bg_event 10,  3, BGEVENT_READ, Route8LockedDoor

	def_object_events
	object_event 10,  7, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerBikerDwayne, -1
	object_event 10,  8, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerBikerHarris, -1
	object_event 10,  9, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerBikerZeke, -1
	object_event 26,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerSupernerdSam, -1
	object_event 39, 12, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerSupernerdTom, -1
	object_event 41,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route8FruitTree, -1
	object_event 47,  8, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_AMPHY_BURIAL_CEREMONY_IN_PROGRESS
	object_event 45,  8, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_AMPHY_BURIAL_CEREMONY_IN_PROGRESS
	object_event 43,  8, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route8BurialGuyScript, EVENT_AMPHY_BURIAL_CEREMONY_IN_PROGRESS
	object_event 48, 10, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_AMPHY_BURIAL_CEREMONY_IN_PROGRESS
	object_event 48,  7, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_AMPHY_BURIAL_CEREMONY_IN_PROGRESS
