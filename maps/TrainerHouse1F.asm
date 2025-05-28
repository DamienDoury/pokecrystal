	object_const_def
	const TRAINERHOUSE1F_COOLTRAINER_M
	const TRAINERHOUSE1F_RECEPTIONIST ; Is the Vaccine Passport controller as well.
	const TRAINERHOUSE1F_COOLTRAINER_F
	const TRAINERHOUSE1F_YOUNGSTER
	const TRAINERHOUSE1F_GENTLEMAN

TrainerHouse1F_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

TrainerHouse1FReceptionistScript:
	jumptextfaceplayer TrainerHouse1FReceptionistText

TrainerHouse1FCooltrainerMScript:
	jumptextfaceplayer TrainerHouse1FCooltrainerMText

TrainerHouse1FCooltrainerFScript:
	jumptextfaceplayer TrainerHouse1FCooltrainerFText

TrainerHouse1FYoungsterScript:
	jumptextfaceplayer TrainerHouse1FYoungsterText

TrainerHouse1FGentlemanScript:
	jumptextfaceplayer TrainerHouse1FGentlemanText

TrainerHouseSign1:
	jumptext TrainerHouseSign1Text

TrainerHouseSign2:
	jumptext TrainerHouseSign2Text

TrainerHouseIllegibleBook:
	jumptext TrainerHouseIllegibleText

TrainerHouse1FReceptionistText: 
if DEF(_FR_FR)
	text "Bienvenue au CLUB"
	line "des DRESSEURS,"

	para "l'attraction de"
	line "JADIELLE."

	para "Nous accueillons"
	line "les dresseurs."

	para "Vous pouvez com-"
	line "battre les meil-"

	para "leurs à l'étage"
	line "inférieur."
else
	text "Welcome to TRAINER"
	line "HOUSE, the newest"

	para "and most happening"
	line "place in VIRIDIAN."

	para "We're open to"
	line "trainers only."

	para "You can battle"
	line "against the best"

	para "of the best right"
	line "downstairs."
endc

	done

TrainerHouse1FCooltrainerMText: 
if DEF(_FR_FR)
	text "JADIELLE est la"
	line "ville voisine du"
	cont "PLATEAU INDIGO."

	para "Elle a été cons-"
	line "truite à cet en-"

	para "droit à cause du"
	line "passage important"

	para "des dresseurs vers"
	line "le PLATEAU."
else
	text "VIRIDIAN is the"
	line "town closest to"
	cont "INDIGO PLATEAU."

	para "They built this"
	line "place because so"

	para "many trainers pass"
	line "through on their"

	para "way up to INDIGO"
	line "PLATEAU."
endc

	done

TrainerHouse1FCooltrainerFText: 
if DEF(_FR_FR)
	text "Des combats d'en-"
	line "traînement se dé-"
	cont "roulent en bas."

	para "J'aimerais bien"
	line "voir comment se"

	para "débrouille un"
	line "dresseur de JOHTO."
else
	text "They hold practice"
	line "battles downstairs"
	cont "here."

	para "I would love to"
	line "see how well a"

	para "trainer from JOHTO"
	line "battles."
endc

	done

TrainerHouse1FYoungsterText: 
if DEF(_FR_FR)
	text "A mon avis, on ne"
	line "peut pas devenir"

	para "un MAITRE sans"
	line "avoir tout vu et"

	para "combattu tout le"
	line "monde."

	para "Le MAITRE de"
	line "PALETTE a voyagé"

	para "dans tous les"
	line "coins de KANTO."
else
	text "I guess you can't"
	line "become the CHAMP"

	para "unless you go all"
	line "over the place and"

	para "battle all kinds"
	line "of people."

	para "The CHAMPION from"
	line "PALLET traveled to"

	para "all the cities and"
	line "towns in KANTO."
endc

	done

TrainerHouse1FGentlemanText: 
if DEF(_FR_FR)
	text "Fouiii...j'ai trop"
	line "combattu. Je me"
	cont "repose un peu."
else
	text "Whew… I'm taking a"
	line "rest from #MON"
	cont "battles."
endc

	done

TrainerHouseSign1Text: 
if DEF(_FR_FR)
	text "Des combats d'en-"
	line "traînement se dé-"

	para "roulent en bas,"
	line "dans le HALL d'EN-"
	cont "TRAINEMENT."

	para "Les bons dresseurs"
	line "y sont invités."
else
	text "Practice battles"
	line "are held in the"

	para "TRAINING HALL"
	line "downstairs."

	para "Skilled trainers"
	line "are invited to"
	cont "participate."
endc

	done

TrainerHouseSign2Text: 
if DEF(_FR_FR)
	text "Comme pour les"
	line "combats en exté-"

	para "rieur, il n'y a"
	line "pas de règles spé-"

	para "ciales pour les"
	line "combats d'entraî-"
	cont "nement!"
else
	text "There are no rules"
	line "or regulations for"

	para "practice matches."
	line "Just like in field"

	para "battles, anything"
	line "goes!"
endc

	done

TrainerHouseIllegibleText: 
if DEF(_FR_FR)
	text "...C'est quoi ça?"
	line "Une note sur la"
	cont "stratégie?"

	para "On dirait des tra-"
	line "cés faits par un"

	para "ONIX..."
	line "C'est illisible..."
else
	text "…What's this?"
	line "A strategy memo?"

	para "This writing looks"
	line "like ONIX tracks…"

	para "It's completely"
	line "illegible…"
endc

	done

TrainerHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 13, VIRIDIAN_CITY, 3
	warp_event  3, 13, VIRIDIAN_CITY, 3
	warp_event  8,  2, TRAINER_HOUSE_B1F, 1

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, TrainerHouseSign1
	bg_event  7,  0, BGEVENT_READ, TrainerHouseSign2
	bg_event  7, 10, BGEVENT_READ, TrainerHouseIllegibleBook

	def_object_events
	object_event  7, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FCooltrainerMScript, -1
	object_event  0, 11, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FReceptionistScript, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FCooltrainerFScript, -1
	object_event  4,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FYoungsterScript, -1
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FGentlemanScript, -1
