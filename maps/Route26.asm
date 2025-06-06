	object_const_def
	const ROUTE26_COOLTRAINER_M1
	const ROUTE26_COOLTRAINER_M2
	const ROUTE26_COOLTRAINER_F1
	const ROUTE26_COOLTRAINER_F2
	const ROUTE26_YOUNGSTER
	const ROUTE26_FISHER
	const ROUTE26_FRUIT_TREE
	const ROUTE26_POKE_BALL

Route26_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerCooltrainermJake:
	trainer COOLTRAINERM, JAKE, EVENT_BEAT_COOLTRAINERM_JAKE, CooltrainermJakeSeenText, CooltrainermJakeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainermJakeAfterBattleText

TrainerCooltrainermGaven3:
	trainer COOLTRAINERM, GAVEN3, EVENT_BEAT_COOLTRAINERM_GAVEN, CooltrainermGaven3SeenText, CooltrainermGaven3BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERM_GAVEN
	endifjustbattled
	opentext
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERM_GAVEN
	iftrue .NumberAccepted
	checkevent EVENT_GAVEN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainermGavenAfterText
	promptbutton
	setevent EVENT_GAVEN_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERM_GAVEN
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, COOLTRAINERM, GAVEN3
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainermGaven3BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer COOLTRAINERM, GAVEN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERM, GAVEN1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERM, GAVEN2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1MScript
	end

.AskNumber2:
	jumpstd AskNumber2MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.Rematch:
	jumpstd RematchMScript
	end

TrainerCooltrainerfJoyce:
	trainer COOLTRAINERF, JOYCE, EVENT_BEAT_COOLTRAINERF_JOYCE, CooltrainerfJoyceSeenText, CooltrainerfJoyceBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerfJoyceAfterBattleText

TrainerCooltrainerfBeth1:
	trainer COOLTRAINERF, BETH1, EVENT_BEAT_COOLTRAINERF_BETH, CooltrainerfBeth1SeenText, CooltrainerfBeth1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERF_BETH
	endifjustbattled
	opentext
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERF_BETH
	iftrue .NumberAccepted
	checkevent EVENT_BETH_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainerfBethAfterText
	promptbutton
	setevent EVENT_BETH_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERF_BETH
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, COOLTRAINERF, BETH1
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainerfBeth1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer COOLTRAINERF, BETH1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERF, BETH2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERF, BETH3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1FScript
	end

.AskNumber2:
	jumpstd AskNumber2FScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.PhoneFull:
	jumpstd PhoneFullFScript
	end

.Rematch:
	jumpstd RematchFScript
	end

TrainerPsychicRichard:
	trainer PSYCHIC_T, RICHARD, EVENT_BEAT_PSYCHIC_RICHARD, PsychicRichardSeenText, PsychicRichardBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicRichardAfterBattleText

TrainerFisherScott:
	trainer FISHER, SCOTT, EVENT_BEAT_FISHER_SCOTT, FisherScottSeenText, FisherScottBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherScottAfterBattleText

Route26Sign:
	jumptext Route26SignText

Route26FruitTree:
	fruittree FRUITTREE_ROUTE_26

Route26MaxElixer:
	itemball MAX_ELIXER

CooltrainermJakeSeenText: 
if DEF(_FR_FR)
	text "Je me prépare pour"
	line "la LIGUE #MON."
else
	text "I'm making my"
	line "final preparations"

	para "for the #MON"
	line "LEAGUE."
endc

	done

CooltrainermJakeBeatenText: 
if DEF(_FR_FR)
	text "Noooon!"
else
	text "I blew it!"
endc

	done

CooltrainermJakeAfterBattleText: 
if DEF(_FR_FR)
	text "Gagner à la LIGUE"
	line "ça doit être dur."

	para "J'ai besoin de"
	line "plus d'entraîne-"
	cont "ment."

	para "On dit que ceux"
	line "du CONSEIL des 4"

	para "sont plus forts"
	line "que les CHAMPIONS."
else
	text "It's going to be"
	line "tough to win at"
	cont "the LEAGUE."

	para "I need to do some"
	line "more training."

	para "I hear that the"
	line "LEAGUE's ELITE"

	para "FOUR are tougher"
	line "than GYM LEADERS."
endc

	done

CooltrainermGaven3SeenText: 
if DEF(_FR_FR)
	text "C'est en rempor-"
	line "tant des combats"
	cont "difficiles que"
	cont "l'on progresse."
else
	text "By experiencing"
	line "tough battles, you"
	cont "gain power."
endc

	done

CooltrainermGaven3BeatenText: 
if DEF(_FR_FR)
	text "Gaah!"
	line "Tu progresses là?"
else
	text "Gaah! Life is even"
	line "tougher!"
endc

	done

CooltrainermGavenAfterText: 
if DEF(_FR_FR)
	text "Pour aller à la"
	line "LIGUE #MON, tu"

	para "dois traverser la"
	line "ROUTE VICTOIRE."

	para "Mais ça ne sera"
	line "pas facile."

	para "Presque personne"
	line "ne va là-bas!"
else
	text "To get to #MON"
	line "LEAGUE, you have"

	para "to get through"
	line "VICTORY ROAD."

	para "But VICTORY ROAD"
	line "is tough."

	para "Practically nobody"
	line "goes there!"
endc

	done

CooltrainerfJoyceSeenText: 
if DEF(_FR_FR)
	text "Si tu es là, c'est"
	line "que tu dois être"
	cont "balèze."

	para "Je vais me donner"
	line "à fond..."
	cont "Tu vas voir!"
else
	text "Since you've come"
	line "this far, you must"
	cont "be good."

	para "I'm going to give"
	line "this battle every-"
	cont "thing I've got!"
endc

	done

CooltrainerfJoyceBeatenText: 
if DEF(_FR_FR)
	text "Mais...c'est..."
	line "Incroyable!"
else
	text "No! I don't"
	line "believe this!"
endc

	done

CooltrainerfJoyceAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai battu huit"
	line "CHAMPIONS d'ARENE"

	para "alors j'avais con-"
	line "fiance en moi."

	para "Je ferai plus"
	line "attention la pro-"
	cont "chaine fois."
else
	text "I've defeated"
	line "eight GYM LEADERS,"

	para "so I was feeling"
	line "confident."

	para "I'll have to try"
	line "harder next time."
endc

	done

CooltrainerfBeth1SeenText: 
if DEF(_FR_FR)
	text "J'ai perdu face"
	line "à un type du nom"
	cont "de <RIVAL>."

	para "Il était fort"
	line "mais..."

	para "On aurait dit qu'"
	line "il combattait pour"
	cont "sa vie..."

	para "Ca me faisait de"
	line "la peine pour ses"
	cont "#MON."
else
	text "I lost to a train-"
	line "er named <RIVAL>."

	para "He was really"
	line "strong, but…"

	para "It was as if he"
	line "absolutely had to"
	cont "win at any cost."

	para "I felt sorry for"
	line "his #MON."
endc

	done

CooltrainerfBeth1BeatenText: 
if DEF(_FR_FR)
	text "Les #MON ne"
	line "sont pas nos"
	cont "esclaves."
else
	text "#MON aren't"
	line "tools of war."
endc

	done

CooltrainerfBethAfterText: 
if DEF(_FR_FR)
	text "Les #MON sont"
	line "des amis pour"
	cont "la vie."
else
	text "#MON are in-"
	line "valuable, lifelong"
	cont "partners."
endc

	done

PsychicRichardSeenText: 
if DEF(_FR_FR)
	text "Whoa! Regarde-moi"
	line "tous ces BADGES!"
	cont "J'suis bluffé."

	para "Les collectionner"
	line "ne te suffit pas,"
	cont "hein?"
else
	text "Wow, look at all"
	line "those BADGES!"
	cont "I'm impressed."

	para "But you're not"
	line "satisfied by just"

	para "collecting them,"
	line "right?"
endc

	done

PsychicRichardBeatenText: 
if DEF(_FR_FR)
	text "Même pas mal!"
else
	text "Good battle!"
endc

	done

PsychicRichardAfterBattleText: 
if DEF(_FR_FR)
	text "Humains et #MON"
	line "évoluent grâce à"
	cont "l'expérience."

	para "Il faut s'entraî-"
	line "ner et voyager!"
else
	text "People and #MON"
	line "grow from their"
	cont "experiences."

	para "Don't get lazy and"
	line "complacent."
endc

	done

FisherScottSeenText: 
if DEF(_FR_FR)
	text "Moi j'suis en"
	line "pleine forme!"

	para "J'me sens capable"
	line "de battre l'MAITRE"
	cont "de la LIGUE!"
else
	text "I'm feeling great"
	line "today!"

	para "I feel like I"
	line "could boot even"
	cont "the LEAGUE CHAMP!"
endc

	done

FisherScottBeatenText: 
if DEF(_FR_FR)
	text "Heu..."
	line "Ca compte pas!"
else
	text "No! Not in this"
	line "battle!"
endc

	done

FisherScottAfterBattleText: 
if DEF(_FR_FR)
	text "Comme pour la pê-"
	line "che, faut jamais"

	para "abandonner à"
	line "#MON."
else
	text "Just like in fish-"
	line "ing, it's all over"

	para "in #MON if you"
	line "give up."
endc

	done

Route26SignText: 
if DEF(_FR_FR)
	text "ROUTE 26"

	para "LIGUE #MON"
	line "PORTE D'ACCES"
else
	text "ROUTE 26"

	para "#MON LEAGUE"
	line "RECEPTION GATE"
endc

	done

Route26_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  5, VICTORY_ROAD_GATE, 3
	warp_event 15, 57, ROUTE_26_HEAL_HOUSE, 1
	warp_event  5, 71, DAY_OF_WEEK_SIBLINGS_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  8,  6, BGEVENT_READ, Route26Sign

	def_object_events
	object_event 14, 24, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainermJake, -1
	object_event  9, 38, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermGaven3, -1
	object_event 10, 56, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfJoyce, -1
	object_event  5,  8, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfBeth1, -1
	object_event 13, 79, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerPsychicRichard, -1
	object_event 10, 92, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherScott, -1
	object_event 14, 54, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route26FruitTree, -1
	object_event  9, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route26MaxElixer, EVENT_ROUTE_26_MAX_ELIXER
