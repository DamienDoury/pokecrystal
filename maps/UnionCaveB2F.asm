	object_const_def
	const UNIONCAVEB2F_ROCKER
	const UNIONCAVEB2F_COOLTRAINER_F1
	const UNIONCAVEB2F_COOLTRAINER_F2
	const UNIONCAVEB2F_POKE_BALL1
	const UNIONCAVEB2F_POKE_BALL2
	const UNIONCAVEB2F_LAPRAS

UnionCaveB2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Lapras

.Lapras:
	checkflag ENGINE_UNION_CAVE_LAPRAS
	iftrue .NoAppear
	readvar VAR_WEEKDAY
	ifequal FRIDAY, .Appear
.NoAppear:
	disappear UNIONCAVEB2F_LAPRAS
	endcallback

.Appear:
	appear UNIONCAVEB2F_LAPRAS
	endcallback

UnionCaveLapras:
	faceplayer
	cry LAPRAS
	loadwildmon LAPRAS, 20
	startbattle
	disappear UNIONCAVEB2F_LAPRAS
	setflag ENGINE_UNION_CAVE_LAPRAS
	reloadmapafterbattle
	end

TrainerCooltrainermNick:
	trainer COOLTRAINERM, NICK, EVENT_BEAT_COOLTRAINERM_NICK, CooltrainermNickSeenText, CooltrainermNickBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermNickAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfGwen:
	trainer COOLTRAINERF, GWEN, EVENT_BEAT_COOLTRAINERF_GWEN, CooltrainerfGwenSeenText, CooltrainerfGwenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfGwenAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfEmma:
	trainer COOLTRAINERF, EMMA, EVENT_BEAT_COOLTRAINERF_EMMA, CooltrainerfEmmaSeenText, CooltrainerfEmmaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfEmmaAfterBattleText
	waitbutton
	closetext
	end

UnionCaveB2FElixer:
	itemball ELIXER

UnionCaveB2FHyperPotion:
	itemball HYPER_POTION

CooltrainermNickSeenText: 
if DEF(_FR_FR)
	text "Il existe 2 types"
	line "de personnes."

	para "Ceux qui ont la"
	line "classe, et ceux"
	cont "qui l'ont pas."

	para "Toi... T'as la"
	line "classe?"
else
	text "There are two"
	line "kinds of people."

	para "Those who have"
	line "style, and those"
	cont "who don't."

	para "What kind of"
	line "person are you?"
endc

	done

CooltrainermNickBeatenText: 
if DEF(_FR_FR)
	text "Purée..."
	line "Quelle classe!"
else
	text "You've got"
	line "dazzling style!"
endc

	done

CooltrainermNickAfterBattleText: 
if DEF(_FR_FR)
	text "Tes #MON ont"
	line "la super classe!"
	cont "Et c'est bien."

	para "Et tu vas encore"
	line "t'améliorer!"
else
	text "Your #MON style"
	line "is stunning and"
	cont "colorful, I admit."

	para "You'll just keep"
	line "getting better!"
endc

	done

CooltrainerfGwenSeenText: 
if DEF(_FR_FR)
	text "Je m'entraîne."
	line "Ca te tente?"
else
	text "I'm in training."
	line "Care for a round?"
endc

	done

CooltrainerfGwenBeatenText: 
if DEF(_FR_FR)
	text "Hmmm! T'es trop"
	line "balèze pour moi."
else
	text "Aww, no! You're"
	line "too good for me."
endc

	done

CooltrainerfGwenAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais continuer"
	line "à m'entraîner en-"
	cont "core un peu."
else
	text "I'm going to train"
	line "by myself until I"
	cont "improve."
endc

	done

CooltrainerfEmmaSeenText: 
if DEF(_FR_FR)
	text "J'irais n'importe"
	line "où avec le #MON"
	cont "de mes rêves."

	para "C'est ça la beauté"
	line "d'être dresseur."
else
	text "If the #MON I"
	line "liked were there,"
	cont "I'd go anywhere."

	para "That's what a real"
	line "trainer does."
endc

	done

CooltrainerfEmmaBeatenText: 
if DEF(_FR_FR)
	text "Vive l'amour!"
	line "Vive les fleurs!"
else
	text "I'd rather pet my"
	line "babies than this!"
endc

	done

CooltrainerfEmmaAfterBattleText: 
if DEF(_FR_FR)
	text "Une fois par se-"
	line "maine, un #MON"
	cont "vient au bord de"
	cont "l'eau."

	para "Je veux le voir"
	line "ce #MON!!!"
else
	text "Just once a week,"
	line "a #MON comes to"
	cont "the water's edge."

	para "I wanted to see"
	line "that #MON…"
endc

	done

UnionCaveB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  3, UNION_CAVE_B1F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event 15, 19, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermNick, -1
	object_event  5, 13, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainerfGwen, -1
	object_event  3, 30, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfEmma, -1
	object_event 16,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCaveB2FElixer, EVENT_UNION_CAVE_B2F_ELIXER
	object_event 12, 19, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCaveB2FHyperPotion, EVENT_UNION_CAVE_B2F_HYPER_POTION
	object_event 11, 31, SPRITE_SURF, SPRITEMOVEDATA_SWIM_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, UnionCaveLapras, EVENT_UNION_CAVE_B2F_LAPRAS
