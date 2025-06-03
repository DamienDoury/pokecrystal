	object_const_def
	const ROUTE44_POLICE_1_1
	const ROUTE44_POLICE_1_2
	const ROUTE44_POLICE_1_3
	const ROUTE44_POLICE_1_4
	const ROUTE44_POLICE_2_1
	const ROUTE44_POLICE_2_2
	const ROUTE44_POLICE_2_3
	const ROUTE44_POLICE_2_4
	const ROUTE44_POLICE_2_5
	const ROUTE44_POLICE_2_6
	const ROUTE44_POLICE_3_1
	const ROUTE44_POLICE_3_2
	const ROUTE44_POLICE_3_3
	const ROUTE44_POLICE_3_4
	const ROUTE44_POLICE_4_1
	const ROUTE44_POLICE_4_2
	const ROUTE44_POLICE_4_3
	const ROUTE44_POLICE_4_4
	const ROUTE44_POLICE_4_5

	const ROUTE44_FISHER1
	const ROUTE44_FISHER2
	const ROUTE44_YOUNGSTER1
	const ROUTE44_SUPER_NERD
	const ROUTE44_YOUNGSTER2
	const ROUTE44_COOLTRAINER_M
	const ROUTE44_COOLTRAINER_F
	const ROUTE44_FRUIT_TREE
	const ROUTE44_POKE_BALL1
	const ROUTE44_POKE_BALL2
	const ROUTE44_POKE_BALL3

Route44_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperVance1:
	trainer BIRD_KEEPER, VANCE1, EVENT_BEAT_BIRD_KEEPER_VANCE, BirdKeeperVance1SeenText, BirdKeeperVance1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BIRDKEEPER_VANCE
	endifjustbattled
	opentext
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_BIRDKEEPER_VANCE
	iftrue Route44NumberAcceptedM
	checkevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BirdKeeperVanceLegendaryBirdsText
	promptbutton
	setevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	scall Route44AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route44AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_BIRDKEEPER_VANCE
	ifequal PHONE_CONTACTS_FULL, Route44PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route44NumberDeclinedM
	gettrainername STRING_BUFFER_3, BIRD_KEEPER, VANCE1
	scall Route44RegisteredNumberM
	sjump Route44NumberAcceptedM

.WantsBattle:
	scall Route44RematchM
	winlosstext BirdKeeperVance1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer BIRD_KEEPER, VANCE1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BIRD_KEEPER, VANCE2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BIRD_KEEPER, VANCE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	checkevent EVENT_VANCE_CARBOS
	iftrue .Carbos
	checkevent EVENT_GOT_CARBOS_FROM_VANCE
	iftrue .ReceivedCarbosBefore
	scall Route44RematchGiftM
	verbosegiveitem CARBOS
	iffalse VancePackFull
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	sjump Route44NumberAcceptedM

.ReceivedCarbosBefore:
	end

.Carbos:
	opentext
	writetext BirdKeeperVance2BeatenText
	waitbutton
	verbosegiveitem CARBOS
	iffalse VancePackFull
	clearevent EVENT_VANCE_CARBOS
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	sjump Route44NumberAcceptedM

Route44AskNumber1M:
	jumpstd AskNumber1MScript
	end

Route44AskNumber2M:
	jumpstd AskNumber2MScript
	end

Route44RegisteredNumberM:
	jumpstd RegisteredNumberMScript
	end

Route44NumberAcceptedM:
	jumpstd NumberAcceptedMScript
	end

Route44NumberDeclinedM:
	jumpstd NumberDeclinedMScript
	end

Route44PhoneFullM:
	jumpstd PhoneFullMScript
	end

Route44RematchM:
	jumpstd RematchMScript
	end

Route44GiftM:
	jumpstd GiftMScript
	end

Route44PackFullM:
	jumpstd PackFullMScript
	end

VancePackFull:
	setevent EVENT_VANCE_CARBOS
	jumpstd PackFullMScript
	end

Route44RematchGiftM:
	jumpstd RematchGiftMScript
	end

TrainerPsychicPhil:
	trainer PSYCHIC_T, PHIL, EVENT_BEAT_PSYCHIC_PHIL, PsychicPhilSeenText, PsychicPhilBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicPhilAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherWilton1:
	trainer FISHER, WILTON1, EVENT_BEAT_FISHER_WILTON, FisherWilton1SeenText, FisherWilton1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_FISHER_WILTON
	endifjustbattled
	opentext
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue .HasItem
	checkcellnum PHONE_FISHER_WILTON
	iftrue Route44NumberAcceptedM
	checkevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext FisherWiltonHugePoliwagText
	promptbutton
	setevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	scall Route44AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route44AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_FISHER_WILTON
	ifequal PHONE_CONTACTS_FULL, Route44PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route44NumberDeclinedM
	gettrainername STRING_BUFFER_3, FISHER, WILTON1
	scall Route44RegisteredNumberM
	sjump Route44NumberAcceptedM

.WantsBattle:
	scall Route44RematchM
	winlosstext FisherWilton1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer FISHER, WILTON1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer FISHER, WILTON2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer FISHER, WILTON3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.HasItem:
	scall Route44GiftM
	checkevent EVENT_WILTON_HAS_ULTRA_BALL
	iftrue .UltraBall
	checkevent EVENT_WILTON_HAS_GREAT_BALL
	iftrue .GreatBall
	checkevent EVENT_WILTON_HAS_POKE_BALL
	iftrue .PokeBall
.UltraBall:
	verbosegiveitem ULTRA_BALL
	iffalse .Route44PackFullM
	sjump .ItemReceived

.GreatBall:
	verbosegiveitem GREAT_BALL
	iffalse .Route44PackFullM
	sjump .ItemReceived

.PokeBall:
	verbosegiveitem POKE_BALL
	iffalse .Route44PackFullM
.ItemReceived:
	clearflag ENGINE_WILTON_HAS_ITEM
	sjump Route44NumberAcceptedM

.Route44PackFullM:
	sjump Route44PackFullM

TrainerFisherEdgar:
	trainer FISHER, EDGAR, EVENT_BEAT_FISHER_EDGAR, FisherEdgarSeenText, FisherEdgarBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherEdgarAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfCybil:
	trainer COOLTRAINERF, CYBIL, EVENT_BEAT_COOLTRAINERF_CYBIL, CooltrainerfCybilSeenText, CooltrainerfCybilBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfCybilAfterBattleText
	waitbutton
	closetext
	end

TrainerPokemaniacZach:
	trainer POKEMANIAC, ZACH, EVENT_BEAT_POKEMANIAC_ZACH, PokemaniacZachSeenText, PokemaniacZachBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacZachAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermAllen:
	trainer COOLTRAINERM, ALLEN, EVENT_BEAT_COOLTRAINERM_ALLEN, CooltrainermAllenSeenText, CooltrainermAllenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermAllenAfterBattleText
	waitbutton
	closetext
	end

Route44Sign1:
	jumptext Route44Sign1Text

Route44Sign2:
	jumptext Route44Sign2Text

Route44FruitTree:
	fruittree FRUITTREE_ROUTE_44

Route44MaxRevive:
	itemball MAX_REVIVE

Route44UltraBall:
	itemball ULTRA_BALL

Route44MaxRepel:
	itemball MAX_REPEL

Route44HiddenElixer:
	hiddenitem ELIXER, EVENT_ROUTE_44_HIDDEN_ELIXER

FisherWilton1SeenText: 
if DEF(_FR_FR)
	text "Aahh! Tu m'as fait"
	line "perdre un PTITARD!"

	para "Tu vas t'excuser,"
	line "ouais?"
else
	text "Aack! You made me"
	line "lose a POLIWAG!"

	para "What are you going"
	line "to do about it?"
endc

	done

FisherWilton1BeatenText: 
if DEF(_FR_FR)
	text "Je te pardonne."
else
	text "Just forget about"
	line "it."
endc

	done

FisherWiltonHugePoliwagText: 
if DEF(_FR_FR)
	text "Ce PTITARD était"
	line "énorme!"

	para "Il faisait 5 mè-"
	line "tres au moins!"
else
	text "That POLIWAG that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been 16 feet long!"
endc

	done

FisherEdgarSeenText: 
if DEF(_FR_FR)
	text "Je pêche comme"
	line "un méga dingue."

	para "Je fais des com-"
	line "bats, aussi."

	para "Les #MON, je"
	line "les aime aussi"
	cont "pour ça."
else
	text "I fish until I"
	line "can't anymore."

	para "I also battle"
	line "until I drop."

	para "That's my"
	line "relationship"
	cont "with my #MON."
endc

	done

FisherEdgarBeatenText: 
if DEF(_FR_FR)
	text "Hmmmm..."
else
	text "Hmmmm… "
	line "This isn't right."
endc

	done

FisherEdgarAfterBattleText: 
if DEF(_FR_FR)
	text "Gagné 100 fois et"
	line "perdu 101 fois."

	para "Je vais faire une"
	line "petite pause."
else
	text "That's 100 wins"
	line "to 101 losses."

	para "I won't battle"
	line "again for a while."
endc

	done

BirdKeeperVance1SeenText: 
if DEF(_FR_FR)
	text "Tu connais les"
	line "#MON oiseaux"
	cont "légendaires?"
else
	text "Do you know about"
	line "the legendary bird"
	cont "#MON?"
endc

	done

BirdKeeperVance1BeatenText: 
if DEF(_FR_FR)
	text "Alors toi, tu"
	line "rigoles pas!"
else
	text "Whew! You're hot"
	line "stuff."
endc

	done

BirdKeeperVanceLegendaryBirdsText: 
if DEF(_FR_FR)
	text "ARTIKODIN,"
	line "ELECTHOR et"

	para "SULFURA sont les"
	line "trois #MON oi-"
	cont "seaux légendaires."

	para "On dit qu'il y en"
	line "a d'autres..."
else
	text "ARTICUNO, ZAPDOS"
	line "and MOLTRES are"

	para "the three legend-"
	line "ary bird #MON."

	para "I heard there are"
	line "other legendary"
	cont "birds, though."
endc

	done

BirdKeeperVance2BeatenText: 
if DEF(_FR_FR)
	text "Pourquoi j'arrive"
	line "jamais à te"
	cont "battre, toi?"

	para "Au fait... Voilà"
	line "le truc que je"

	para "voulais te donner"
	line "la dernière fois."
else
	text "Why can't I ever"
	line "beat you?"

	para "Oh yeah, here you"
	line "go. It's that gift"

	para "I couldn't give"
	line "you last time."
endc

	done

PsychicPhilSeenText: 
if DEF(_FR_FR)
	text "J'vais gagner!"
	line "Pour sûr!"
else
	text "I'm gonna win,"
	line "for sure!"
endc

	done

PsychicPhilBeatenText: 
if DEF(_FR_FR)
	text "Qu...Comm..."
	line "Hein?"
else
	text "Arrgh… That's a"
	line "shocking loss…"
endc

	done

PsychicPhilAfterBattleText: 
if DEF(_FR_FR)
	text "Etre sûr de soi,"
	line "c'est important."
else
	text "It's important to"
	line "have conviction"
	cont "on your side."
endc

	done

PokemaniacZachSeenText: 
if DEF(_FR_FR)
	text "J'veux des #MON"
	line "rares! Yaaaaah!"
else
	text "I'll do anything"
	line "to get my hands on"
	cont "rare #MON!"
endc

	done

PokemaniacZachBeatenText: 
if DEF(_FR_FR)
	text "Oooh, tes #MON"
	line "sont siii beaux!"
else
	text "Oooh, your #MON"
	line "are so appealing."
endc

	done

PokemaniacZachAfterBattleText: 
if DEF(_FR_FR)
	text "Si un #MON est"
	line "d'une couleur in-"

	para "habituelle, il a"
	line "plus de valeur."

	para "Quoi? On m'aurait"
	line "menti?"
else
	text "If a #MON has"
	line "different colors"

	para "from usual, it's"
	line "more valuable."

	para "What? You mean"
	line "that's not true?"
endc

	done

CooltrainermAllenSeenText: 
if DEF(_FR_FR)
	text "Tu as du talent,"
	line "ça se voit."

	para "Mais... Comment"
	line "dire... J'suis"
	cont "le plus fort."
else
	text "I can tell you're"
	line "a good trainer by"
	cont "looking at you."

	para "I'm good at #-"
	line "MON, and I can see"
	cont "that you are too."
endc

	done

CooltrainermAllenBeatenText: 
if DEF(_FR_FR)
	text "Pfff!"
	line "Même pas mal."
else
	text "Tch! It's a total"
	line "loss on my part."
endc

	done

CooltrainermAllenAfterBattleText: ; TO TRANSLATE
	text "I wonder if"
	line "ECRUTEAK GYM's"

	para "MORTY is still in"
	line "training?"

	para "He really hammered"
	line "me."
	done

CooltrainerfCybilSeenText: 
if DEF(_FR_FR)
	text "T'as l'air fort."

	para "Ca te dirait un"
	line "p'tit challenge?"
else
	text "You look strong."

	para "Good trainers seek"
	line "tough opponents"
	cont "instinctively."
endc

	done

CooltrainerfCybilBeatenText: 
if DEF(_FR_FR)
	text "Oh! Rien compris!"
else
	text "Nope! This won't"
	line "do at all."
endc

	done

CooltrainerfCybilAfterBattleText: 
if DEF(_FR_FR)
	text "Les combats for-"
	line "ment la jeunesse."

	para "Moi j'ai beaucoup"
	line "combattu et voilà"
	cont "le résultat: je"
	cont "suis un crack."
else
	text "We all get better"
	line "by experiencing"
	cont "many battles."

	para "I battled a lot to"
	line "become what I am"
	cont "today--an elite."
endc

	done

Route44Sign1Text: 
if DEF(_FR_FR)
	text "ROUTE 44"
	line "ROUTE DE GLACE"
	cont "Tout droit"
	
	para "Attention:"
	line "froid extrême."
else
	text "ROUTE 44"
	line "ICE PATH AHEAD"

	para "Danger:"
	line "extreme cold."
endc

	done

Route44Sign2Text: 
if DEF(_FR_FR)
	text "ROUTE 44"

	para "ACAJOU -"
	line "EBENELLE"
else
	text "ROUTE 44"

	para "MAHOGANY TOWN -"
	line "BLACKTHORN CITY"
endc

	done

Route44_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 56,  7, ICE_PATH_1F, 1

	def_coord_events

	def_bg_events
	bg_event 53,  7, BGEVENT_READ, Route44Sign1
	bg_event  6, 10, BGEVENT_READ, Route44Sign2
	bg_event 32,  9, BGEVENT_ITEM, Route44HiddenElixer

	def_object_events
	object_event 43,  5, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 42,  4, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 13, 13, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 12, 12, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	
	object_event 30, 15, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 3, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 30, 14, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 3, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  6,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event  6, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 44,  6, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 52,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1

	object_event 28,  9, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  8, 10, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 49,  6, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 30,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1

	object_event 34,  8, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event 38, 14, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 3, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 38, 15, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 3, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 49, 11, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 26,  2, SPRITE_OFFICER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 10, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1

	object_event 35,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherWilton1, -1
	object_event 19, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherEdgar, -1
	object_event 10,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicPhil, -1
	object_event 43,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacZach, -1
	object_event 42, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperVance1, -1
	object_event 41, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerCooltrainermAllen, -1
	object_event 31, 14, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerCooltrainerfCybil, -1
	object_event  9,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route44FruitTree, -1
	object_event 30,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route44MaxRevive, EVENT_ROUTE_44_MAX_REVIVE
	object_event 45,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route44UltraBall, EVENT_ROUTE_44_ULTRA_BALL
	object_event 14,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route44MaxRepel, EVENT_ROUTE_44_MAX_REPEL
