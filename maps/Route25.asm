	object_const_def
	const ROUTE25_MISTY
	const ROUTE25_RED
	const ROUTE25_YOUNGSTER1
	const ROUTE25_LASS1
	const ROUTE25_YOUNGSTER2
	const ROUTE25_LASS2
	const ROUTE25_YOUNGSTER3
	const ROUTE25_LASS3
	const ROUTE25_SUPER_NERD
	const ROUTE25_COOLTRAINER_M2
	const ROUTE25_POKE_BALL


Route25_MapScripts:
	def_scene_scripts

	def_callbacks

Route25MistyDateStartScript:
	showemote EMOTE_HEART, ROUTE25_MISTY, 40 ; Damien
	pause 15 ; Damien
	showemote EMOTE_SHOCK, ROUTE25_RED, 15 ; Damien
	turnobject ROUTE25_MISTY, DOWN

	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
	end

Route25MistyDate1Script:
	scall Route25MistyDateStartScript
	applymovement ROUTE25_RED, Route25MistysDateLeavesMovement1 ; Damien
	disappear ROUTE25_RED ; Damien
	pause 20 ; Damien
	turnobject ROUTE25_MISTY, UP ; Damien
	pause 20 ; Damien
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject ROUTE25_MISTY, UP
	pause 10
	applymovement ROUTE25_MISTY, Route25MistyApproachesPlayerMovement1
	opentext
	writetext Route25MistyDateText
	waitbutton
	closetext
	;turnobject PLAYER, DOWN ; Damien
	applymovement ROUTE25_MISTY, Route25MistyLeavesPlayerMovement1
	turnobject PLAYER, DOWN ; Damien
	applymovement ROUTE25_MISTY, Route25MistyLeavesMovement
	disappear ROUTE25_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setscene SCENE_ROUTE25_NOTHING
	special RestartMapMusic
	end

Route25MistyDate2Script:
	scall Route25MistyDateStartScript
	applymovement ROUTE25_RED, Route25MistysDateLeavesMovement2 ; Damien
	disappear ROUTE25_RED ; Damien
	pause 15 ; Damien
	turnobject ROUTE25_MISTY, UP ; Damien
	pause 15 ; Damien
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject ROUTE25_MISTY, UP
	pause 10
	applymovement ROUTE25_MISTY, Route25MistyApproachesPlayerMovement2
	opentext
	writetext Route25MistyDateText
	waitbutton
	closetext
	;turnobject PLAYER, UP ; Damien
	applymovement ROUTE25_MISTY, Route25MistyLeavesPlayerMovement2
	turnobject PLAYER, DOWN ; Damien
	applymovement ROUTE25_MISTY, Route25MistyLeavesMovement
	disappear ROUTE25_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setscene SCENE_ROUTE25_NOTHING
	special RestartMapMusic
	end

TrainerSchoolboyDudley:
	trainer SCHOOLBOY, DUDLEY, EVENT_BEAT_SCHOOLBOY_DUDLEY, SchoolboyDudleySeenText, SchoolboyDudleyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyDudleyAfterBattleText

TrainerLassEllen:
	trainer LASS, ELLEN, EVENT_BEAT_LASS_ELLEN, LassEllenSeenText, LassEllenBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer LassEllenAfterBattleText

TrainerSchoolboyJoe:
	trainer SCHOOLBOY, JOE, EVENT_BEAT_SCHOOLBOY_JOE, SchoolboyJoeSeenText, SchoolboyJoeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyJoeAfterBattleText

TrainerLassLaura:
	trainer LASS, LAURA, EVENT_BEAT_LASS_LAURA, LassLauraSeenText, LassLauraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer LassLauraAfterBattleText

TrainerCamperLloyd:
	trainer CAMPER, LLOYD, EVENT_BEAT_CAMPER_LLOYD, CamperLloydSeenText, CamperLloydBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CamperLloydAfterBattleText

TrainerLassShannon:
	trainer LASS, SHANNON, EVENT_BEAT_LASS_SHANNON, LassShannonSeenText, LassShannonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer LassShannonAfterBattleText

TrainerSupernerdPat:
	trainer SUPER_NERD, PAT, EVENT_BEAT_SUPER_NERD_PAT, SupernerdPatSeenText, SupernerdPatBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SupernerdPatAfterBattleText

TrainerCooltrainermKevin:
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERM_KEVIN
	iftrue .AfterBattle
	checkevent EVENT_CLEARED_NUGGET_BRIDGE
	iftrue .AfterNuggetBridge
	writetext CooltrainermKevinNuggetText
	promptbutton
	verbosegiveitem TOILET_PAPER
	iffalse .NoRoomForNugget
	setevent EVENT_CLEARED_NUGGET_BRIDGE
.AfterNuggetBridge:
	writetext CooltrainermKevinSeenText
	waitbutton
	closetext
	winlosstext CooltrainermKevinBeatenText, 0
	loadtrainer COOLTRAINERM, KEVIN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_KEVIN
	opentext
.AfterBattle:
	writetext CooltrainermKevinAfterBattleText
	waitbutton
.NoRoomForNugget:
	closetext
	end

BillsHouseSign:
	jumptext BillsHouseSignText

Route25Protein:
	itemball PROTEIN

Route25HiddenPotion:
	hiddenitem POTION, EVENT_ROUTE_25_HIDDEN_POTION

Route25MistysDateLeavesMovement2:
	big_step DOWN
Route25MistysDateLeavesMovement1:
	big_step DOWN
	step_end

Route25MistyApproachesPlayerMovement1: ; Damien
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step_end

Route25MistyApproachesPlayerMovement2: ; Damien
	step UP
	step UP
	step LEFT
	step LEFT
	step_end

Route25MistyLeavesPlayerMovement1: ; Damien
	step RIGHT
	step RIGHT
	step DOWN
	step_end

Route25MistyLeavesPlayerMovement2: ; Damien
	step RIGHT
	step RIGHT
	step_end

Route25MistyLeavesMovement: ; Damien
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

Route25MistyDateText: ; TO TRANSLATE
	text "MISTY: (cough)"
	line "Aww! Why did you"

	para "have to show up"
	line "and bug us now?"

	para "Do you know what"
	line "they call people"
	cont "like you?"

	para "Pests! You heard"
	line "me right, pest!"

	para "…"
	line "" ; Damien

	para "…Oh? Those BADGES"
	line "you have… Are they"
	cont "JOHTO GYM BADGES?"

	para "If you have eight,"
	line "you must be good…"
	cont "…(cough)…"

	para "OK, then. Come to"
	line "CERULEAN GYM."

	para "I'll be happy to"
	line "take you on."

	para "I'm MISTY, the"
	line "GYM LEADER in"
	cont "CERULEAN."
	done

SchoolboyDudleySeenText: 
if DEF(_FR_FR)
	text "Bats les six"
	line "dresseurs pour"
	cont "gagner un prix!"

	para "Tu crois en être"
	line "capable?"
else
	text "Beat the six of us"
	line "trainers to win a"
	cont "fabulous prize!"

	para "Think you've got"
	line "what it takes?"
endc

	done

SchoolboyDudleyBeatenText: 
if DEF(_FR_FR)
	text "Whoa! Balèze."
else
	text "Whoo! Good stuff."
endc

	done

SchoolboyDudleyAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de"
	line "mon mieux."
else
	text "I did my best."
	line "I have no regrets."
endc

	done

LassEllenSeenText: 
if DEF(_FR_FR)
	text "J'suis en deuz."
	line "Ca va barder!"
else
	text "I'm second."
	line "Now it's serious!"
endc

	done

LassEllenBeatenText: 
if DEF(_FR_FR)
	text "Impossible!"
else
	text "How could I lose?"
endc

	done

LassEllenAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de"
	line "mon mieux."
else
	text "I did my best."
	line "I have no regrets."
endc

	done

SchoolboyJoeSeenText: 
if DEF(_FR_FR)
	text "Numéro 3!"
	line "Tu vas en baver!"
else
	text "Here's No. 3!"
	line "I won't be easy."
endc

	done

SchoolboyJoeBeatenText: 
if DEF(_FR_FR)
	text "Ouille! Perdu!"
else
	text "Ow! Stomped flat!"
endc

	done

SchoolboyJoeAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de"
	line "mon mieux."
else
	text "I did my best."
	line "I have no regrets."
endc

	done

LassLauraSeenText: 
if DEF(_FR_FR)
	text "Numéro 4! Tu"
	line "tiens le coup?"
else
	text "I'm No. 4!"
	line "Getting tired?"
endc

	done

LassLauraBeatenText: 
if DEF(_FR_FR)
	text "Perdu? Moi aussi?"
else
	text "I lost too…"
endc

	done

LassLauraAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de"
	line "mon mieux."
else
	text "I did my best."
	line "I have no regrets."
endc

	done

CamperLloydSeenText: 
if DEF(_FR_FR)
	text "OK! Numéro 5."
	line "COMBAAAAT!"
else
	text "OK! I'm No. 5."
	line "I'll stomp you!"
endc

	done

CamperLloydBeatenText: 
if DEF(_FR_FR)
	text "Whoa! Trop fort."
else
	text "Whoa! Too much."
endc

	done

CamperLloydAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de"
	line "mon mieux."
else
	text "I did my best."
	line "I have no regrets."
endc

	done

LassShannonSeenText: 
if DEF(_FR_FR)
	text "Dernier rempart!"
	line "Autant te dire..."
	cont "Ca va être dur!"
else
	text "I'm the last in"
	line "line, but I tell"
	cont "you, I'm tough!"
endc

	done

LassShannonBeatenText: 
if DEF(_FR_FR)
	text "Sans blague?"
else
	text "You're kidding."
endc

	done

LassShannonAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de"
	line "mon mieux."
else
	text "I did my best."
	line "I have no regrets."
endc

	done

SupernerdPatSeenText: 
if DEF(_FR_FR)
	text "Hin hin hin..."

	para "Je me fiche des"
	line "six autres dres-"
	cont "seurs."

	para "Je suis là pour te"
	line "battre au moment"

	para "où tu es le plus"
	line "à plat."
else
	text "Mufufufu…"

	para "I have nothing to"
	line "do with the six-"
	cont "pack trainers."

	para "I waited here to"
	line "beat you when you"

	para "were tired out by"
	line "all the battles."
endc

	done

SupernerdPatBeatenText: 
if DEF(_FR_FR)
	text "T'es pas à plat?"
else
	text "Aren't you tired"
	line "at all?"
endc

	done

SupernerdPatAfterBattleText: 
if DEF(_FR_FR)
	text "Pardon. Je ne"
	line "tricherai plus..."
else
	text "I'm sorry… I won't"
	line "cheat anymore…"
endc

	done

CooltrainermKevinNuggetText: 
if DEF(_FR_FR)
	text "Tu as livré un"
	line "combat de plus que"

	para "prévu et tu as"
	line "quand même gagné."

	para "Tu remportes donc"
	line "un prix."
else
	text "You took on one"
	line "more battle than"

	para "you expected, but"
	line "you won anyway."

	para "As promised, you"
	line "win a prize."
endc

	done

CooltrainermKevinSeenText: 
if DEF(_FR_FR)
	text "Mais après avoir"
	line "vu ton combat, je"

	para "voudrais tenter ma"
	line "chance."

	para "Ca te dit?"
	line "Alors c'est parti."
else
	text "But after seeing"
	line "how you battle, I"

	para "want to see how"
	line "I'll fare."

	para "How about it? Let"
	line "me take you on."
endc

	done

CooltrainermKevinBeatenText: 
if DEF(_FR_FR)
	text "Ouais!"
	line "Beau combat!"
else
	text "I've never had a"
	line "battle this good!"
endc

	done

CooltrainermKevinAfterBattleText: 
if DEF(_FR_FR)
	text "Quelle belle"
	line "rencontre!"

	para "Toi et tes #MON"
	line "êtes vraiment"
	cont "impressionnants!"
else
	text "That was a great"
	line "battle!"

	para "You and your #-"
	line "MON are truly out-"
	cont "standing!"
endc

	done

BillsHouseSignText: 
if DEF(_FR_FR)
	text "VILLA"
	line "MAISON DE LEO"
else
	text "SEA COTTAGE"
	line "BILL'S HOUSE"
endc

	done

Route25_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 47,  5, BILLS_HOUSE, 1

	def_coord_events
	coord_event 42,  6, CE_SCENE_ID, SCENE_ROUTE25_MISTYS_DATE, Route25MistyDate1Script
	coord_event 42,  7, CE_SCENE_ID, SCENE_ROUTE25_MISTYS_DATE, Route25MistyDate2Script

	def_bg_events
	bg_event 45,  5, BGEVENT_READ, BillsHouseSign
	bg_event  4,  5, BGEVENT_ITEM, Route25HiddenPotion

	def_object_events
	object_event 46,  9, SPRITE_MISTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	object_event 46, 10, SPRITE_RED, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND ; Damien
	object_event 12,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyDudley, -1
	object_event 16, 11, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerLassEllen, -1
	object_event 21,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSchoolboyJoe, -1
	object_event 22,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerLassLaura, -1
	object_event 25,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperLloyd, -1
	object_event 28, 11, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerLassShannon, -1
	object_event 31,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerSupernerdPat, -1
	object_event 37,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerCooltrainermKevin, -1
	object_event 32,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route25Protein, EVENT_ROUTE_25_PROTEIN
