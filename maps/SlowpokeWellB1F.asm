	object_const_def
	const SLOWPOKEWELLB1F_ROCKET1
	const SLOWPOKEWELLB1F_ROCKET2
	const SLOWPOKEWELLB1F_ROCKET3
	const SLOWPOKEWELLB1F_ROCKET_GIRL
	const SLOWPOKEWELLB1F_SLOWPOKE1
	const SLOWPOKEWELLB1F_SLOWPOKE2
	const SLOWPOKEWELLB1F_KURT
	const SLOWPOKEWELLB1F_BOULDER
	const SLOWPOKEWELLB1F_POKE_BALL

SlowpokeWellB1F_MapScripts:
	def_scene_scripts

	def_callbacks

SlowpokeWellB1FKurtScript:
	jumptextfaceplayer SlowpokeWellB1FKurtText

TrainerGruntM29:
	trainer GRUNTM, GRUNTM_29, EVENT_BEAT_ROCKET_GRUNTM_29, GruntM29SeenText, GruntM29BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM29AfterBattleText

TrainerGruntM1:
	trainer GRUNTM, GRUNTM_1, EVENT_BEAT_ROCKET_GRUNTM_1, GruntM1SeenText, GruntM1BeatenText, 0, .Script

.Script:
	opentext
	writetext TrainerGruntM1WhenTalkText
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear SLOWPOKEWELLB1F_ROCKET1
	disappear SLOWPOKEWELLB1F_ROCKET2
	disappear SLOWPOKEWELLB1F_ROCKET3
	disappear SLOWPOKEWELLB1F_ROCKET_GIRL
	pause 15
	special FadeInQuickly
	disappear SLOWPOKEWELLB1F_KURT
	moveobject SLOWPOKEWELLB1F_KURT, 11, 6
	appear SLOWPOKEWELLB1F_KURT
	readvar VAR_YCOORD
	ifequal 3, .SlowpokeWellB1F_KurtTop
	applymovement SLOWPOKEWELLB1F_KURT, KurtSlowpokeWellVictoryMovementBotData
	pause 5
	applymovement PLAYER, PlayerRespectsKurtDistancingMovementData
	sjump .SlowpokeWellB1F_KurtIsInPlace

.SlowpokeWellB1F_KurtTop:
	applymovement SLOWPOKEWELLB1F_KURT, KurtSlowpokeWellVictoryMovementTopData
	turnobject PLAYER, RIGHT

.SlowpokeWellB1F_KurtIsInPlace:
	opentext
	writetext KurtLeaveSlowpokeWellText
	waitbutton
	closetext
	setevent EVENT_CLEARED_SLOWPOKE_WELL
	setmapscene AZALEA_TOWN, SCENE_AZALEATOWN_RIVAL_BATTLE
	clearevent EVENT_ILEX_FOREST_APPRENTICE
	clearevent EVENT_ILEX_FOREST_FARFETCHD
	setevent EVENT_CHARCOAL_KILN_FARFETCH_D
	setevent EVENT_CHARCOAL_KILN_APPRENTICE
	setevent EVENT_SLOWPOKE_WELL_SLOWPOKES
	setevent EVENT_SLOWPOKE_WELL_KURT
	clearevent EVENT_AZALEA_TOWN_SLOWPOKES
	clearevent EVENT_KURTS_HOUSE_SLOWPOKE
	clearevent EVENT_KURTS_HOUSE_KURT_1
	special FadeOutPalettes
	special HealParty
	pause 15
	warp KURTS_HOUSE, 3, 4
	end

TrainerGruntM2:
	trainer GRUNTM, GRUNTM_2, EVENT_BEAT_ROCKET_GRUNTM_2, GruntM2SeenText, GruntM2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM2AfterBattleText

TrainerGruntF1:
	trainer GRUNTF, GRUNTF_1, EVENT_BEAT_ROCKET_GRUNTF_1, GruntF1SeenText, GruntF1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntF1AfterBattleText

SlowpokeWellB1FSlowpokeWithMailScript:
	faceplayer
	opentext
	cry SLOWPOKE
	writetext SlowpokeWellB1FSlowpokeWithMailText
	yesorno
	iftrue .ReadMail
	closetext
	end

.ReadMail:
	writetext SlowpokeWellB1FSlowpokeMailText
	waitbutton
	closetext
	end

SlowpokeWellB1FTaillessSlowpokeScript:
	faceplayer
	opentext
	writetext SlowpokeWellB1FTaillessSlowpokeText
	cry SLOWPOKE
	waitbutton
	closetext
	end

SlowpokeWellB1FBoulder:
	jumpstd StrengthBoulderScript

SlowpokeWellB1FSuperPotion:
	itemball SUPER_POTION

KurtSlowpokeWellVictoryMovementTopData:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_sleep 8
	step_sleep 8
	step_sleep 8
	step UP
	step LEFT
	step UP
	step UP
	step RIGHT
	step_sleep 8
	step_sleep 8
	step_sleep 8
	turn_head LEFT
	step_end

KurtSlowpokeWellVictoryMovementBotData:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_sleep 8
	step_sleep 8
	step_sleep 8
	step UP
	step LEFT
	step UP
	step_sleep 8
	step_sleep 8
	step_sleep 8
	turn_head LEFT
	step_end

PlayerRespectsKurtDistancingMovementData:
	turn_head RIGHT
	step_sleep 8
	step_sleep 8
	step_sleep 8
	fix_facing
	step LEFT
	remove_fixed_facing
	step_end

SlowpokeWellB1FKurtText: 
if DEF(_FR_FR)
	text "FARGAS: Salut,"
	line "<PLAYER>!"

	para "Le garde a"
	line "décampé quand je"
	cont "lui ai crié"
	cont "dessus..."

	para "Et puis je suis"
	line "descendu dans le"
	cont "PUITS."

	para "Et ben j'me suis"
	line "planté et... Je"
	cont "peux plus bouger."

	para "Pfff! Si j'étais"
	line "en forme, mes"

	para "#MON les au-"
	line "raient punis..."

	para "C'est vraiment"
	line "trop bête."

	para "<PLAYER>, va leur"
	line "mettre une raclée"
	cont "à ma place!"
else
	text "KURT: Hey there,"
	line "<PLAYER>!"

	para "The guard up top"
	line "took off when I"
	cont "shouted at him."

	para "But then I took a"
	line "tumble down the"
	cont "WELL."

	para "I slammed down"
	line "hard on my back,"
	cont "so I can't move."

	para "Rats! If I were"
	line "fit, my #MON"

	para "would've punished"
	line "them…"

	para "Ah, it can't be"
	line "helped."

	para "<PLAYER>, show them"
	line "how gutsy you are"
	cont "in my place!"
endc

	done

KurtLeaveSlowpokeWellText: 
if DEF(_FR_FR)
	text "FARGAS: Bravo,"
	line "<PLAYER>!"

	para "La TEAM ROCKET a"
	line "décampé."

	para "Mon dos va mieux."
	line "Allez..."
	cont "On se casse."
else
	text "KURT: Way to go,"
	line "<PLAYER>!"

	para "TEAM ROCKET has"
	line "taken off."

	para "My back's better"
	line "too. Let's get out"
	cont "of here."
endc

	done

GruntM29SeenText: 
if DEF(_FR_FR)
	text "Grrah! Je montais"
	line "la garde quand un"

	para "vieux dingue est"
	line "venu me crier"
	cont "dessus."

	para "Il m'a fichu une"
	line "telle trouille que"
	cont "je suis tombé ici."

	para "... Tu sais quoi?"
	line "Je vais calmer mes"
	cont "nerfs sur ta face!"
else
	text "Darn! I was stand-"
	line "ing guard up top"

	para "when some old coot"
	line "yelled at me."

	para "He startled me so"
	line "much that I fell"
	cont "down here."

	para "I think I'll vent"
	line "my anger by taking"
	cont "it out on you!"
endc

	done

GruntM29BeatenText: 
if DEF(_FR_FR)
	text "Grrah! C'est pas"
	line "mon jour!"
else
	text "Arrgh! This is NOT"
	line "my day!"
endc

	done

GruntM29AfterBattleText: ; TO TRANSLATE
	text "Sure, we've been"
	line "hacking the tails"

	para "off SLOWPOKE and"
	line "selling them."

	para "Everything we do"
	line "is for profit."

	para "Times are rough"
	line "and TEAM ROCKET"

	para "needs the money"
	line "for bigger plans!"
	done

GruntM1SeenText: 
if DEF(_FR_FR)
	text "Kesstu veux?"

	para "Si tu viens nous"
	line "embêter, ça va"
	cont "barder!"
else
	text "What do you want?"

	para "If you interrupt"
	line "our work, don't"
	cont "expect any mercy!"
endc

	done

GruntM1BeatenText: 
if DEF(_FR_FR)
	text "Attends voir la"
	line "prochaine fois!"
else
	text "You did OK today,"
	line "but wait till next"
	cont "time!"
endc

	done

TrainerGruntM1WhenTalkText: 
if DEF(_FR_FR)
	text "La TEAM ROCKET a"
	line "été dissoute il y"
	cont "a trois ans..."

	para "Mais on a continué"
	line "nos p'tites affai-"
	cont "res dans l'ombre."

	para "Et à partir d'au-"
	line "jourd'hui... On va"
	cont "tout faire sauter!"
else
	text "Yeah, TEAM ROCKET"
	line "was broken up"
	cont "three years ago."

	para "But we continued"
	line "our activities"
	cont "underground."

	para "Now you can have"
	line "fun watching us"
	cont "stir up trouble!"
endc

	done

GruntM2SeenText: 
if DEF(_FR_FR)
	text "Arrêter de voler"
	line "les QUEUES de"
	cont "RAMOLOSS?"

	para "Et notre réputa-"
	line "tion, tu y as"
	cont "pensé?"
else
	text "Quit taking SLOW-"
	line "POKETAILS?"

	para "If we obeyed you,"
	line "TEAM ROCKET's rep"
	cont "would be ruined!"
endc

	done

GruntM2BeatenText: 
if DEF(_FR_FR)
	text "Heu..."
	line "Trop fort..."
else
	text "Just…"
	line "Too strong…"
endc

	done

GruntM2AfterBattleText: 
if DEF(_FR_FR)
	text "On a besoin de"
	line "sous à la TEAM"
	cont "ROCKET..."

	para "C'est pas facile"
	line "d'être un SBIRE!"
else
	text "We need the money,"
	line "but selling SLOW-"
	cont "POKETAILS?"

	para "It's tough being a"
	line "ROCKET GRUNT!"
endc

	done

GruntF1SeenText: 
if DEF(_FR_FR)
	text "Arrêter de voler"
	line "les QUEUES?"

	para "C'est ça, oui..."
	line "T'as raison..."
else
	text "Stop taking TAILS?"

	para "Yeah, just try to"
	line "defeat all of us!"
endc

	done

GruntF1BeatenText: 
if DEF(_FR_FR)
	text "Sale môme!"
else
	text "You rotten brat!"
endc

	done

GruntF1AfterBattleText: 
if DEF(_FR_FR)
	text "Les QUEUES de"
	line "RAMOLOSS?"
	cont "Ca repousse vite!"

	para "Alors on peut les"
	line "vendre, non?"
else
	text "SLOWPOKETAILS"
	line "grow back fast!"

	para "What's wrong with"
	line "selling them?"
endc

	done

SlowpokeWellB1FSlowpokeWithMailText: 
if DEF(_FR_FR)
	text "Un RAMOLOSS sans"
	line "QUEUE..."

	para "Hein? Il a une"
	line "LETTRE. On la lit?"
else
	text "A SLOWPOKE with"
	line "its TAIL cut off…"

	para "Huh? It has MAIL."
	line "Read it?"
endc

	done

SlowpokeWellB1FSlowpokeMailText: ; TO TRANSLATE
	text "<PLAYER> reads the"
	line "MAIL."

	para "Be good and look"
	line "after the house"

	para "with Grandpa and"
	line "SLOWPOKE."

	para "Love, Dad"
	done

SlowpokeWellB1FTaillessSlowpokeText: 
if DEF(_FR_FR)
	text "Un RAMOLOSS à la"
	line "queue coupée..."
else
	text "A SLOWPOKE with"
	line "its TAIL cut off…"
endc

	done

SlowpokeWellB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 15, AZALEA_TOWN, 6
	warp_event  7, 11, SLOWPOKE_WELL_B2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 15,  7, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM29, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  5,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerGruntM1, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGruntM2, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event 10,  4, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerGruntF1, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  7,  4, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FSlowpokeWithMailScript, EVENT_SLOWPOKE_WELL_SLOWPOKES
	object_event  6,  2, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FTaillessSlowpokeScript, EVENT_SLOWPOKE_WELL_SLOWPOKES
	object_event 16, 14, SPRITE_KURT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FKurtScript, EVENT_SLOWPOKE_WELL_KURT
	object_event  3,  2, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FBoulder, -1
	object_event 10,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SlowpokeWellB1FSuperPotion, EVENT_SLOWPOKE_WELL_B1F_SUPER_POTION
