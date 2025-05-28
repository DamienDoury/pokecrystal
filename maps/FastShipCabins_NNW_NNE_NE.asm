	object_const_def
	const FASTSHIPCABINS_NNW_NNE_NE_COOLTRAINER_M
	const FASTSHIPCABINS_NNW_NNE_NE_COOLTRAINER_F
	const FASTSHIPCABINS_NNW_NNE_NE_SUPER_NERD
	const FASTSHIPCABINS_NNW_NNE_NE_POKEFAN_M
	const FASTSHIPCABINS_NNW_NNE_NE_SAILOR
	const FASTSHIPCABINS_NNW_NNE_NE_GENTLEMAN
	const FASTSHIPCABINS_NNW_NNE_NE_PHARMACIST
	const FASTSHIPCABINS_NNW_NNE_NE_JASMINE

FastShipCabins_NNW_NNE_NE_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerCooltrainermSean:
	trainer COOLTRAINERM, SEAN, EVENT_BEAT_COOLTRAINERM_SEAN, CooltrainermSeanSeenText, CooltrainermSeanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermSeanAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfCarol:
	trainer COOLTRAINERF, CAROL, EVENT_BEAT_COOLTRAINERF_CAROL, CooltrainerfCarolSeenText, CooltrainerfCarolBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfCarolAfterBattleText
	waitbutton
	closetext
	end

TrainerPokemaniacEthan:
	trainer POKEMANIAC, ETHAN, EVENT_BEAT_POKEMANIAC_ETHAN, PokemaniacEthanSeenText, PokemaniacEthanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacEthanAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerNoland:
	trainer HIKER, NOLAND, EVENT_BEAT_HIKER_NOLAND, HikerNolandSeenText, HikerNolandBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerNolandAfterBattleText
	waitbutton
	closetext
	end

TrainerGentlemanEdward:
	trainer GENTLEMAN, EDWARD, EVENT_BEAT_GENTLEMAN_EDWARD, GentlemanEdwardSeenText, GentlemanEdwardBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GentlemanEdwardAfterBattleText
	waitbutton
	closetext
	end

TrainerBurglarCorey:
	trainer BURGLAR, COREY, EVENT_BEAT_BURGLAR_COREY, BurglarCoreySeenText, BurglarCoreyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BurglarCoreyAfterBattleText
	waitbutton
	closetext
	end

FastShipLazySailorScript:
	playmusic MUSIC_HIKER_ENCOUNTER
	faceplayer
	opentext
	writetext SailorStanlySeenText
	waitbutton
	closetext
	winlosstext SailorStanlyBeatenText, 0
	loadtrainer SAILOR, STANLY
	startbattle
	reloadmap
	special HealParty
	setevent EVENT_BEAT_SAILOR_STANLY
	opentext
	writetext SailorStanlyAfterBattleText
	waitbutton
	closetext
	setevent EVENT_FAST_SHIP_LAZY_SAILOR
	setmapscene FAST_SHIP_B1F, SCENE_FINISHED
	applymovement FASTSHIPCABINS_NNW_NNE_NE_SAILOR, FastShipLazySailorLeavesMovement
	playsound SFX_EXIT_BUILDING
	disappear FASTSHIPCABINS_NNW_NNE_NE_SAILOR
	waitsfx
	end

FastShipJasmineScript:
	faceplayer
	opentext
	writetext FastShipJasmineText
	waitbutton
	closetext 
	turnobject FASTSHIPCABINS_NNW_NNE_NE_JASMINE, LEFT
	end

FastShipCabins_NNW_NNE_NETrashcan:
	jumpstd TrashCanScript

FastShipLazySailorLeavesMovement:
	step UP
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

CooltrainermSeanSeenText: 
if DEF(_FR_FR)
	text "Je vais à KANTO"
	line "pour m'entraîner."
else
	text "I'm going to KANTO"
	line "to test my skills."
endc

	done

CooltrainermSeanBeatenText: 
if DEF(_FR_FR)
	text "J'voulais gagner!"
else
	text "I wanted to win!"
endc

	done

CooltrainermSeanAfterBattleText: 
if DEF(_FR_FR)
	text "Les dresseurs de"
	line "JOHTO peuvent af-"
	cont "fronter les CHAM-"
	cont "PIONS de KANTO."
else
	text "Trainers from"
	line "JOHTO can battle"

	para "with KANTO GYM"
	line "LEADERS."
endc

	done

CooltrainerfCarolSeenText: 
if DEF(_FR_FR)
	text "J'm'entraîne pour"
	line "être la meilleure!"
else
	text "I'm training to"
	line "become the CHAMP!"
endc

	done

CooltrainerfCarolBeatenText: 
if DEF(_FR_FR)
	text "Pourquoi?"
else
	text "What's so differ-"
	line "ent between us?"
endc

	done

CooltrainerfCarolAfterBattleText: 
if DEF(_FR_FR)
	text "J'te battrai un"
	line "jour! Oh oui!"
else
	text "I'm going to beat"
	line "you someday!"
endc

	done

PokemaniacEthanSeenText: 
if DEF(_FR_FR)
	text "Tu connais PETRA?"
	line "C'est un super DJ"
	cont "de KANTO."
else
	text "Do you know LILY?"
	line "She's a hot DJ in"
	cont "KANTO."
endc

	done

PokemaniacEthanBeatenText: 
if DEF(_FR_FR)
	text "Gyaaaah!"
else
	text "Gyaaaah!"
endc

	done

PokemaniacEthanAfterBattleText: 
if DEF(_FR_FR)
	text "PETRA est cool"
	line "mais LULA est top!"

	para "J'veux connaître"
	line "les stations de"
	cont "radio de JOHTO!"
else
	text "LILY's nice, but"
	line "MARY's the best!"

	para "I want to check"
	line "out JOHTO's radio"
	cont "programs!"
endc

	done

HikerNolandSeenText: 
if DEF(_FR_FR)
	text "Ca va?"
	line "Alors...COMBAT!"
else
	text "Are you alone?"
	line "Then let's battle!"
endc

	done

HikerNolandBeatenText: 
if DEF(_FR_FR)
	text "T'es trop, toi!"
	line "Pfouiii!"
else
	text "That's too much to"
	line "handle!"
endc

	done

HikerNolandAfterBattleText: 
if DEF(_FR_FR)
	text "Tu crois qu'il y a"
	line "de belles monta-"
	cont "gnes à KANTO?"
else
	text "I wonder if there"
	line "are any mountains"

	para "worth climbing in"
	line "KANTO?"
endc

	done

SailorStanlySeenText: 
if DEF(_FR_FR)
	text "Ouaip. Moi j'suis"
	line "un marin."

	para "Un vrai de vrai."
	line "Pur boeuf!"

	para "J'suis grand."
	line "J'suis beau."
	cont "Je sens le sable"
	cont "chaud."

	para "Oh! Tu m'écoutes?"
	line "...COMBAT!"
else
	text "Yeah, I'm a sail-"
	line "or, all right."

	para "I wasn't goofing"
	line "off!"

	para "This cabin was"
	line "vacant, so I just"
	cont "took a quick nap!"

	para "Ah, forget it!"
	line "Let's battle!"
endc

	done

SailorStanlyBeatenText: 
if DEF(_FR_FR)
	text "Heu... Comment?"
	line "De quoi?"
else
	text "Sorry! It's all my"
	line "fault!"
endc

	done

SailorStanlyAfterBattleText: 
if DEF(_FR_FR)
	text "Dans la mariiine,"
	line "on n'est pas des"
	cont "p'tites filles!"
	cont "Dans la mariiine!"
else
	text "Being a sailor, I"
	line "have to do phys-"
	cont "ical labor. It's"
	cont "exhausting!"
endc

	done

GentlemanEdwardSeenText: 
if DEF(_FR_FR)
	text "J'ai perdu un truc"
	line "super important..."
else
	text "Oh, no. I've lost"
	line "something that's"
	cont "very important."
endc

	done

GentlemanEdwardBeatenText: 
if DEF(_FR_FR)
	text "J'le...trouve..."
	line "...pas!!!"
else
	text "I… I can't find"
	line "it…"
endc

	done

GentlemanEdwardAfterBattleText: 
if DEF(_FR_FR)
	text "Je laisse tomber."
	line "Ce n'est pas la"

	para "peine de chercher."
	line "Oublie!"
else
	text "I give up."
	line "You don't have to"

	para "look. Just forget"
	line "about it!"
endc

	done

BurglarCoreySeenText: 
if DEF(_FR_FR)
	text "Ouaiiis!"
	line "Le bol!"
else
	text "Yeehaw!"
	line "Lucky!"
endc

	done

BurglarCoreyBeatenText: 
if DEF(_FR_FR)
	text "Ooooh!"
	line "Pas d'bol!"
else
	text "How unlucky!"
	line "I lost!"
endc

	done

BurglarCoreyAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai trouvé une"
	line "belle pièce."

	para "Quelqu'un a dû"
	line "la perdre..."
else
	text "I found a pretty"
	line "coin here."

	para "Someone must have"
	line "lost it…"
endc

	done

FastShipJasmineText: ; TO TRANSLATE
	text "JASMINE: I'm not"
	line "in the mood for"
	cont "a battle…"
	done

FastShipCabins_NNW_NNE_NE_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  0, FAST_SHIP_1F, 2
	warp_event  2, 12, FAST_SHIP_1F, 3
	warp_event  2, 24, FAST_SHIP_1F, 4

	def_coord_events

	def_bg_events
	bg_event  6, 13, BGEVENT_READ, FastShipCabins_NNW_NNE_NETrashcan
	bg_event  7, 19, BGEVENT_READ, FastShipCabins_NNW_NNE_NETrashcan
	bg_event  7, 31, BGEVENT_READ, FastShipCabins_NNW_NNE_NETrashcan

	def_object_events
	object_event  4,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainermSean, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  1,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfCarol, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  1,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacEthan, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  4, 17, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerNoland, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  4, 30, SPRITE_SAILOR, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FastShipLazySailorScript, EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	object_event  7, 30, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerGentlemanEdward, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  2, 30, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerBurglarCorey, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  4,  5, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FastShipJasmineScript, EVENT_FAST_SHIP_FIRST_TIME
