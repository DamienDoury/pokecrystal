	object_const_def
	const ROUTE11_YOUNGSTER1
	const ROUTE11_YOUNGSTER2
	const ROUTE11_YOUNGSTER3
	const ROUTE11_YOUNGSTER4
	const ROUTE11_FRUIT_TREE
	const ROUTE11_FRUIT_TREE_2
	const ROUTE11_GENTLEMAN1

Route11_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerYoungsterOwen:
	trainer YOUNGSTER, OWEN, EVENT_BEAT_YOUNGSTER_OWEN, YoungsterOwenSeenText, YoungsterOwenBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer YoungsterOwenAfterBattleText

TrainerYoungsterJason:
	trainer YOUNGSTER, JASON, EVENT_BEAT_YOUNGSTER_JASON, YoungsterJasonSeenText, YoungsterJasonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer YoungsterJasonAfterBattleText

TrainerPsychicHerman:
	trainer PSYCHIC_T, HERMAN, EVENT_BEAT_PSYCHIC_HERMAN, PsychicHermanSeenText, PsychicHermanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicHermanAfterBattleText

TrainerPsychicFidel:
	trainer PSYCHIC_T, FIDEL, EVENT_BEAT_PSYCHIC_FIDEL, PsychicFidelSeenText, PsychicFidelBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicFidelAfterBattleText

TrainerGentlemanPaulo:
	trainer GENTLEMAN, PAULO, EVENT_BEAT_GENTLEMAN_PAULO, GentlemanPauloSeenText, GentlemanPauloBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GentlemanPauloAfterBattleText

Route11Sign:
	jumptext Route11SignText

Route11FruitTree:
	fruittree FRUITTREE_ROUTE_11

Route11FruitTree2:
	fruittree FRUITTREE_ROUTE_11_2
	
Route11HiddenRevive:
	hiddenitem REVIVE, EVENT_ROUTE_11_HIDDEN_REVIVE

YoungsterOwenSeenText: 
if DEF(_FR_FR)
	text "Y'a pas de triche"
	line "à #MON."

	para "Etre honnête, ça"
	line "c'est chouette!"
else
	text "There's no cheat-"
	line "ing in #MON."

	para "Let's keep it fair"
	line "and square!"
endc

	done

YoungsterOwenBeatenText: 
if DEF(_FR_FR)
	text "Hein?"
	line "T'as grugé!"
else
	text "Huh? How did this"
	line "happen?"
endc

	done

YoungsterOwenAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai combattu avec"
	line "honneur."

	para "Je ne regrette"
	line "rien de rien."
else
	text "I fought fair and"
	line "square with honor."

	para "I don't regret"
	line "this at all."
endc

	done

YoungsterJasonSeenText: 
if DEF(_FR_FR)
	text "Porter des shorts"
	line "dans l'herbe, ça"

	para "pique à donf... "
	line "Pas cool."
else
	text "It itches and"
	line "tickles a bit when"

	para "I wear shorts in"
	line "the grass."
endc

	done

YoungsterJasonBeatenText: 
if DEF(_FR_FR)
	text "Aïeuuuuuuu!"
else
	text "Aiyaaah!"
	line "I got stomped!"
endc

	done

YoungsterJasonAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais choper"
	line "d'autres #MON"
	cont "dans les herbes."
else
	text "I'm going to catch"
	line "more #MON in"
	cont "the grass."
endc

	done

PsychicHermanSeenText:
	text "…"
	done

PsychicHermanBeatenText:
	text "…"
	done

PsychicHermanAfterBattleText: 
if DEF(_FR_FR)
	text "…"

	para "J'ai perdu les"
	line "yeux fermés..."
else
	text "…"

	para "I lost while I had"
	line "my eyes closed…"
endc

	done

PsychicFidelSeenText: 
if DEF(_FR_FR)
	text "Je vois tout..."

	para "Présent, futur..."
	line "Combat!"
else
	text "I can see it…"

	para "Everything to see"
	line "about you…"
endc

	done

PsychicFidelBeatenText: 
if DEF(_FR_FR)
	text "Heu..."
	line "Je l'avais prévu!"
else
	text "I couldn't foresee"
	line "your power…"
endc

	done

PsychicFidelAfterBattleText: 
if DEF(_FR_FR)
	text "Volonté..."
	line "Psychisme..."

	para "Ta confiance en"
	line "tes #MON est"
	cont "ta force."
else
	text "Strength in con-"
	line "viction…"

	para "You're strong be-"
	line "cause you believe"
	cont "in your #MON."
endc

	done

GentlemanPauloSeenText: ; TO TRANSLATE
	text "Look what I"
	line "caught!"
	done

GentlemanPauloBeatenText: ; TO TRANSLATE
	text "Are you not happy"
	line "to see my #MON?"
	done

GentlemanPauloAfterBattleText: ; TO TRANSLATE
	text "It has been a"
	line "delightful night"
	cont "of hunting."

	para "Now to rest for"
	line "the remainder of"
	cont "the day."
	done

Route11SignText: 
if DEF(_FR_FR)
	text "ROUTE 11"
else
	text "ROUTE 11"
endc

	done

Route11_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  3,  7, BGEVENT_READ, Route11Sign
	bg_event 42,  5, BGEVENT_ITEM, Route11HiddenRevive

	def_object_events
	object_event 25, 16, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterOwen, -1
	object_event 20,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterJason, -1
	object_event 31,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerPsychicHerman, -1
	object_event 10,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicFidel, -1
	object_event 42,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route11FruitTree, -1
	object_event 43, 14, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route11FruitTree2, -1
	object_event 35, 13, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerGentlemanPaulo, -1
