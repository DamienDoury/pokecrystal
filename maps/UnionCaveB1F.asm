	object_const_def
	const UNIONCAVEB1F_POKEFAN_M1
	const UNIONCAVEB1F_POKEFAN_M2
	const UNIONCAVEB1F_SUPER_NERD1
	const UNIONCAVEB1F_SUPER_NERD2
	const UNIONCAVEB1F_POKE_BALL1
	const UNIONCAVEB1F_BOULDER
	const UNIONCAVEB1F_POKE_BALL2

UnionCaveB1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerPokemaniacAndrew:
	trainer POKEMANIAC, ANDREW, EVENT_BEAT_POKEMANIAC_ANDREW, PokemaniacAndrewSeenText, PokemaniacAndrewBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacAndrewAfterBattleText
	waitbutton
	closetext
	end

TrainerPokemaniacCalvin:
	trainer POKEMANIAC, CALVIN, EVENT_BEAT_POKEMANIAC_CALVIN, PokemaniacCalvinSeenText, PokemaniacCalvinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacCalvinAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerPhillip:
	trainer HIKER, PHILLIP, EVENT_BEAT_HIKER_PHILLIP, HikerPhillipSeenText, HikerPhillipBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerPhillipAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerLeonard:
	trainer HIKER, LEONARD, EVENT_BEAT_HIKER_LEONARD, HikerLeonardSeenText, HikerLeonardBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerLeonardAfterBattleText
	waitbutton
	closetext
	end

UnionCaveB1FTMSwift:
	itemball TM_SWIFT

UnionCaveB1FXDefend:
	itemball X_DEFEND

UnionCaveB1FBoulder:
	jumpstd StrengthBoulderScript

HikerPhillipSeenText: 
if DEF(_FR_FR)
	text "Ca fait longtemps"
	line "que je n'ai pas eu"
	cont "de compagnie."

	para "Sois sympa..."
	line "Combat!"
else
	text "It's been a while"
	line "since I last saw"
	cont "another person."

	para "Don't be shy."
	line "Let's battle!"
endc

	done

HikerPhillipBeatenText: 
if DEF(_FR_FR)
	text "Uurggh..."
else
	text "Uurggh…"
endc

	done

HikerPhillipAfterBattleText: 
if DEF(_FR_FR)
	text "Je suis perdu"
	line "depuis longtemps!"

	para "C'est pas trop"
	line "grave mais..."
	cont "J'ai faim!"
else
	text "I've been lost for"
	line "a long time…"

	para "I don't mind it"
	line "here, but I am"
	cont "soooo hungry!"
endc

	done

HikerLeonardSeenText: 
if DEF(_FR_FR)
	text "Ah bah ça alors!"
	line "De la visite!"
else
	text "What do you know!"
	line "A visitor!"
endc

	done

HikerLeonardBeatenText: 
if DEF(_FR_FR)
	text "Wahahah! T'es pas"
	line "drôle!"
else
	text "Wahahah! You're a"
	line "feisty one!"
endc

	done

HikerLeonardAfterBattleText: 
if DEF(_FR_FR)
	text "Je vis ici."

	para "Toi aussi tu veux"
	line "vivre ici?"

	para "Y'a de la place..."
	line "Alors tu veux?"
else
	text "I live down here."

	para "You can, too, if"
	line "you'd like."

	para "There's plenty of"
	line "room, you see."
endc

	done

PokemaniacAndrewSeenText: 
if DEF(_FR_FR)
	text "Qui va là?"

	para "Yaaaah! Laisse-moi"
	line "tranquille!"
else
	text "Who's there?"

	para "Leave me and my"
	line "#MON alone!"
endc

	done

PokemaniacAndrewBeatenText: 
if DEF(_FR_FR)
	text "Va-t'en..."
	line "Ouste!"
else
	text "Go…"
	line "Go away!"
endc

	done

PokemaniacAndrewAfterBattleText: 
if DEF(_FR_FR)
	text "Seul avec mes"
	line "#MON. C'est"
	cont "la fête."
else
	text "Just me and my"
	line "#MON. I'm de-"
	cont "lirious with joy."
endc

	done

PokemaniacCalvinSeenText: 
if DEF(_FR_FR)
	text "Je suis venu ici"
	line "pour mes études"
	cont "sur les #MON."

	para "Je vais te montrer"
	line "tout ça..."
	cont "Au combat!"
else
	text "I came all the way"
	line "here to conduct my"
	cont "#MON research."

	para "Let me demonstrate"
	line "my findings in a"
	cont "real battle!"
endc

	done

PokemaniacCalvinBeatenText: 
if DEF(_FR_FR)
	text "Plein la tête!"
	line "Ouille!"
else
	text "You demonstrated"
	line "on me!"
endc

	done

PokemaniacCalvinAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais révéler"
	line "mes recherches au"
	cont "monde."

	para "Je serai aussi"
	line "célèbre que le"
	cont "PROF.ORME!"
else
	text "I should compile"
	line "and announce my"
	cont "study findings."

	para "I might even be-"
	line "come famous like"
	cont "PROF.ELM."
endc

	done

UnionCaveB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  3, RUINS_OF_ALPH_OUTSIDE, 7
	warp_event  3, 11, RUINS_OF_ALPH_OUTSIDE, 8
	warp_event  7, 19, UNION_CAVE_1F, 1
	warp_event  3, 33, UNION_CAVE_1F, 2
	warp_event 17, 31, UNION_CAVE_B2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerPhillip, -1
	object_event 16,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerLeonard, -1
	object_event  5, 32, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacAndrew, -1
	object_event 17, 30, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacCalvin, -1
	object_event  2, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCaveB1FTMSwift, EVENT_UNION_CAVE_B1F_TM_SWIFT
	object_event  7, 10, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, UnionCaveB1FBoulder, -1
	object_event 17, 23, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCaveB1FXDefend, EVENT_UNION_CAVE_B1F_X_DEFEND
