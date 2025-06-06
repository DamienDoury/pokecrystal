	object_const_def
	const ROUTE1_YOUNGSTER
	const ROUTE1_COOLTRAINER_F
	const ROUTE1_FRUIT_TREE

Route1_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSchoolboyDanny:
	trainer SCHOOLBOY, DANNY, EVENT_BEAT_SCHOOLBOY_DANNY, SchoolboyDannySeenText, SchoolboyDannyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyDannyAfterBattleText

TrainerCooltrainerfQuinn:
	trainer COOLTRAINERF, QUINN, EVENT_BEAT_COOLTRAINERF_QUINN, CooltrainerfQuinnSeenText, CooltrainerfQuinnBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerfQuinnAfterBattleText

Route1Sign:
	jumptext Route1SignText

Route1FruitTree:
	fruittree FRUITTREE_ROUTE_1

SchoolboyDannySeenText: 
if DEF(_FR_FR)
	text "Si 2 dresseurs se"
	line "rencontrent, ils"
	cont "doivent combattre."
else
	text "If trainers meet,"
	line "the first thing to"
	cont "do is battle."
endc

	done

SchoolboyDannyBeatenText: 
if DEF(_FR_FR)
	text "Graaaaaaah!"
	line "Perduuuu!"
else
	text "Awww… I've got a"
	line "losing record…"
endc

	done

SchoolboyDannyAfterBattleText: 
if DEF(_FR_FR)
	text "Les dresseurs doi-"
	line "vent se battre."

	para "C'est écrit."
	line "C'est la loi."
else
	text "For trainers, it's"
	line "a given that we'll"

	para "battle whenever we"
	line "meet."
endc

	done

CooltrainerfQuinnSeenText: 
if DEF(_FR_FR)
	text "Toi là!"
	line "Combat?"
else
	text "You there!"
	line "Want to battle?"
endc

	done

CooltrainerfQuinnBeatenText: 
if DEF(_FR_FR)
	text "Houlà!"
else
	text "Down and out…"
endc

	done

CooltrainerfQuinnAfterBattleText: 
if DEF(_FR_FR)
	text "Pas mal."

	para "Tu as dû t'entraî-"
	line "ner comme à donf!"
else
	text "You're strong."

	para "You obviously must"
	line "have trained hard."
endc

	done

Route1SignText: 
if DEF(_FR_FR)
	text "ROUTE 1"

	para "BOURG PALETTE -"
	line "JADIELLE"
else
	text "ROUTE 1"

	para "PALLET TOWN -"
	line "VIRIDIAN CITY"
endc

	done

Route1_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  7, 27, BGEVENT_READ, Route1Sign

	def_object_events
	object_event  4, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSchoolboyDanny, -1
	object_event  9, 25, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainerfQuinn, -1
	object_event  3,  7, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route1FruitTree, -1
