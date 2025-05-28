	object_const_def
	const ROUTE45_POLICE_1_1
	const ROUTE45_POLICE_1_2
	const ROUTE45_POLICE_1_3
	const ROUTE45_POLICE_1_4
	const ROUTE45_POLICE_2_1
	const ROUTE45_POLICE_2_2
	const ROUTE45_POLICE_2_3
	const ROUTE45_POLICE_2_4
	const ROUTE45_POLICE_3_1
	const ROUTE45_POLICE_3_2
	const ROUTE45_POLICE_3_3
	const ROUTE45_POLICE_3_4
	const ROUTE45_POLICE_4_1
	const ROUTE45_POLICE_4_2
	const ROUTE45_POLICE_4_3
	const ROUTE45_POLICE_4_4
	const ROUTE45_POLICE_4_5

	const ROUTE45_POKEFAN_M1
	const ROUTE45_POKEFAN_M2
	const ROUTE45_POKEFAN_M3
	const ROUTE45_POKEFAN_M4
	const ROUTE45_BLACK_BELT
	const ROUTE45_COOLTRAINER_M
	const ROUTE45_COOLTRAINER_F
	const ROUTE45_FRUIT_TREE
	const ROUTE45_POKE_BALL1
	const ROUTE45_POKE_BALL2
	const ROUTE45_POKE_BALL3
	const ROUTE45_POKE_BALL4
	const ROUTE45_YOUNGSTER

Route45_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBlackbeltKenji:
	trainer BLACKBELT_T, KENJI3, EVENT_BEAT_BLACKBELT_KENJI, BlackbeltKenji3SeenText, BlackbeltKenji3BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BLACKBELT_KENJI
	endifjustbattled
	opentext
	checkcellnum PHONE_BLACKBELT_KENJI
	iftrue .Registered
	checkevent EVENT_KENJI_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	special SampleKenjiBreakCountdown
	writetext BlackbeltKenjiAfterBattleText
	waitbutton
	setevent EVENT_KENJI_ASKED_FOR_PHONE_NUMBER
	scall Route45AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route45AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_BLACKBELT_KENJI
	ifequal PHONE_CONTACTS_FULL, Route45PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route45NumberDeclinedM
	gettrainername STRING_BUFFER_3, BLACKBELT_T, KENJI3
	scall Route45RegisteredNumberM
	sjump Route45NumberAcceptedM

.Registered:
	readvar VAR_KENJI_BREAK
	ifnotequal 1, Route45NumberAcceptedM
	checktime MORN
	iftrue .Morning
	checktime NITE
	iftrue .Night
	checkevent EVENT_KENJI_ON_BREAK
	iffalse Route45NumberAcceptedM
	scall Route45GiftM
	verbosegiveitem PP_UP
	iffalse .NoRoom
	clearevent EVENT_KENJI_ON_BREAK
	special SampleKenjiBreakCountdown
	sjump Route45NumberAcceptedM

.Morning:
	writetext BlackbeltKenjiMorningText
	waitbutton
	closetext
	end

.Night:
	writetext BlackbeltKenjiNightText
	waitbutton
	closetext
	end

.NoRoom:
	sjump Route45PackFullM

Route45AskNumber1M:
	jumpstd AskNumber1MScript
	end

Route45AskNumber2M:
	jumpstd AskNumber2MScript
	end

Route45RegisteredNumberM:
	jumpstd RegisteredNumberMScript
	end

Route45NumberAcceptedM:
	jumpstd NumberAcceptedMScript
	end

Route45NumberDeclinedM:
	jumpstd NumberDeclinedMScript
	end

Route45PhoneFullM:
	jumpstd PhoneFullMScript
	end

Route45RematchM:
	jumpstd RematchMScript
	end

Route45GiftM:
	jumpstd GiftMScript
	end

Route45PackFullM:
	jumpstd PackFullMScript
	end

HikerParryHasIron:
	setevent EVENT_PARRY_IRON
	jumpstd PackFullMScript
	end

Route45RematchGiftM:
	jumpstd RematchGiftMScript
	end

TrainerHikerErik:
	trainer HIKER, ERIK, EVENT_BEAT_HIKER_ERIK, HikerErikSeenText, HikerErikBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerErikAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerMichael:
	trainer HIKER, MICHAEL, EVENT_BEAT_HIKER_MICHAEL, HikerMichaelSeenText, HikerMichaelBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerMichaelAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerParry:
	trainer HIKER, PARRY3, EVENT_BEAT_HIKER_PARRY, HikerParry3SeenText, HikerParry3BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_HIKER_PARRY
	endifjustbattled
	opentext
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_HIKER_PARRY
	iftrue Route45NumberAcceptedM
	checkevent EVENT_PARRY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext HikerParryAfterBattleText
	promptbutton
	setevent EVENT_PARRY_ASKED_FOR_PHONE_NUMBER
	scall Route45AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route45AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_HIKER_PARRY
	ifequal PHONE_CONTACTS_FULL, Route45PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route45NumberDeclinedM
	gettrainername STRING_BUFFER_3, HIKER, PARRY1
	scall Route45RegisteredNumberM
	sjump Route45NumberAcceptedM

.WantsBattle:
	scall Route45RematchM
	winlosstext HikerParry3BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer HIKER, PARRY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_PARRY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer HIKER, PARRY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_PARRY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer HIKER, PARRY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_PARRY_READY_FOR_REMATCH
	checkevent EVENT_PARRY_IRON
	iftrue .HasIron
	checkevent EVENT_GOT_IRON_FROM_PARRY
	iftrue .GotIron
	scall Route45RematchGiftM
	verbosegiveitem IRON
	iffalse HikerParryHasIron
	setevent EVENT_GOT_IRON_FROM_PARRY
	sjump Route45NumberAcceptedM

.GotIron:
	end

.HasIron:
	opentext
	writetext HikerParryGivesIronText
	waitbutton
	verbosegiveitem IRON
	iffalse HikerParryHasIron
	clearevent EVENT_PARRY_IRON
	setevent EVENT_GOT_IRON_FROM_PARRY
	sjump Route45NumberAcceptedM

TrainerHikerTimothy:
	trainer HIKER, TIMOTHY, EVENT_BEAT_HIKER_TIMOTHY, HikerTimothySeenText, HikerTimothyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerTimothyAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermRyan:
	trainer COOLTRAINERM, RYAN, EVENT_BEAT_COOLTRAINERM_RYAN, CooltrainermRyanSeenText, CooltrainermRyanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermRyanAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfKelly:
	trainer COOLTRAINERF, KELLY, EVENT_BEAT_COOLTRAINERF_KELLY, CooltrainerfKellySeenText, CooltrainerfKellyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfKellyAfterBattleText
	waitbutton
	closetext
	end

TrainerCamperQuentin:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CAMPER_QUENTIN
	iftrue .Defeated
	writetext CamperQuentinSeenText
	waitbutton
	closetext
	winlosstext CamperQuentinBeatenText, 0
	loadtrainer CAMPER, QUENTIN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CAMPER_QUENTIN
	closetext
	end

.Defeated:
	writetext CamperQuentinAfterBattleText
	waitbutton
	closetext
	end

Route45Sign:
	jumptext Route45SignText

Route45FruitTree:
	fruittree FRUITTREE_ROUTE_45

Route45Nugget:
	itemball TOILET_PAPER

Route45Revive:
	itemball REVIVE

Route45Elixer:
	itemball ELIXER

Route45MaxPotion:
	itemball MAX_POTION

Route45HiddenPpUp:
	hiddenitem PP_UP, EVENT_ROUTE_45_HIDDEN_PP_UP

Route45LevelIncrease:
	setevent EVENT_ROUTE_45_LVL_INCREASE

	readmem wHallOfFameCount
	ifgreater 0, .end

	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel
.end
	end

HikerErikSeenText: 
if DEF(_FR_FR)
	text "Attends-toi à"
	line "l'impossible!"

	para "Montre si tes"
	line "#MON ont bien"
	cont "été entraînés!"
else
	text "Be prepared for"
	line "anything!"

	para "Let me see if your"
	line "#MON have been"
	cont "raised properly!"
endc

	done

HikerErikBeatenText: 
if DEF(_FR_FR)
	text "Oh! Perdu!"
else
	text "Oh, I lost that!"
endc

	done

HikerErikAfterBattleText: 
if DEF(_FR_FR)
	text "Je retourne à la"
	line "ROUTE DE GLACE"

	para "d'EBENELLE pour"
	line "m'entraîner."
else
	text "I'll head back to"
	line "BLACKTHORN's ICE"

	para "PATH and train"
	line "some more."
endc

	done

HikerMichaelSeenText: 
if DEF(_FR_FR)
	text "Toi, tu crains!"
	line "Tu le sais, ça?"

	para "Alors il faut se"
	line "battre. Parce que"
	cont "j't'aime pas!"
else
	text "Yo! You're spunky!"
	line "But you know what?"

	para "When it comes to"
	line "sheer spunkiness,"
	cont "I'm the man!"
endc

	done

HikerMichaelBeatenText: 
if DEF(_FR_FR)
	text "Bien joué!"
else
	text "My #MON weren't"
	line "spunky enough!"
endc

	done

HikerMichaelAfterBattleText: 
if DEF(_FR_FR)
	text "Moi j'aime les"
	line "PV PLUS! Mmmm!"

	para "C'est pour les"
	line "#MON mais j'en"
	cont "bois quand même!"

	para "C'est trop bon!"
else
	text "Boy, do I love"
	line "HP UP! Mmmm, yum!"

	para "I keep drinking my"
	line "#MON's!"

	para "I can't help it!"
endc

	done

HikerParry3SeenText: 
if DEF(_FR_FR)
	text "J'ai super boosté"
	line "mes #MON!"
else
	text "My #MON are"
	line "power packed!"
endc

	done

HikerParry3BeatenText: 
if DEF(_FR_FR)
	text "Wahahah!"
	line "J'suis nul!"
else
	text "Wahahah! I'm the"
	line "big loser!"
endc

	done

HikerParryAfterBattleText: 
if DEF(_FR_FR)
	text "Réfléchir, c'est"
	line "pas mon truc."

	para "Alors, je cogne."
else
	text "I'm not much good"
	line "at thinking, see?"

	para "So, I just plow"
	line "ahead with power!"
endc

	done

HikerTimothySeenText: 
if DEF(_FR_FR)
	text "Pourquoi j'aime"
	line "l'escalade?"

	para "Parce que j'aime"
	line "la montagne."

	para "Pourquoi j'aime"
	line "les #MON?"

	para "Parce que j'aime"
	line "combattre!"
else
	text "Why do I climb"
	line "mountains?"

	para "Because they're"
	line "there."

	para "Why do I train"
	line "#MON?"

	para "Because they're"
	line "there!"
endc

	done

HikerTimothyBeatenText: 
if DEF(_FR_FR)
	text "Mais..."
	line "J'aime pas perdre!"
else
	text "Losses…"
	line "They're there too!"
endc

	done

HikerTimothyAfterBattleText: 
if DEF(_FR_FR)
	text "Découvrir le monde"
	line "merveilleux des"

	para "#MON a été un"
	line "grand bonheur."
else
	text "The best thing to"
	line "ever happen to me"

	para "was discovering"
	line "#MON."
endc

	done

HikerParryGivesIronText: 
if DEF(_FR_FR)
	text "Je n'arrive pas"
	line "à gagner!"

	para "Courage!"

	para "Oh, prends ça..."
	line "C'est le truc que"

	para "tu ne pouvais pas"
	line "prendre la derniè-"
	cont "re fois."
else
	text "I just can't find"
	line "a way to win!"

	para "Keep it up!"

	para "Oh, and take this"
	line "--it's the gift"

	para "you couldn't take"
	line "when we last met."
endc

	done

BlackbeltKenji3SeenText: 
if DEF(_FR_FR)
	text "Je m'entraîne en"
	line "solitaire."

	para "Et voilà le"
	line "résultat!"
else
	text "I was training"
	line "here alone."

	para "Behold the fruits"
	line "of my labor!"
endc

	done

BlackbeltKenji3BeatenText: 
if DEF(_FR_FR)
	text "Waaaargh!"
else
	text "Waaaargh!"
endc

	done

BlackbeltKenjiAfterBattleText: 
if DEF(_FR_FR)
	text "Parfait..."
	line "Tu l'auras voulu."

	para "Je vais encore"
	line "m'entraîner en"
	cont "solitaire."
else
	text "This calls for"
	line "extreme measures."

	para "I must take to the"
	line "hills and train in"
	cont "solitude."
endc

	done

BlackbeltKenjiMorningText: 
if DEF(_FR_FR)
	text "Je vais encore"
	line "m'entraîner avant"
	cont "de bouffer."
else
	text "I'm going to train"
	line "a bit more before"
	cont "I break for lunch."
endc

	done

BlackbeltKenjiNightText: 
if DEF(_FR_FR)
	text "On a tous bouffé"
	line "comme des malades!"

	para "On a la super"
	line "pêche!"

	para "On va encore"
	line "s'entraîner!"
else
	text "We had plenty of"
	line "rest at lunch, so"

	para "now we're all"
	line "ready to go again!"

	para "We're going to"
	line "train again!"
endc

	done

CooltrainermRyanSeenText: 
if DEF(_FR_FR)
	text "Comment tu fais"
	line "pour entraîner tes"
	cont "#MON?"
else
	text "What are your"
	line "thoughts on rais-"
	cont "ing #MON?"
endc

	done

CooltrainermRyanBeatenText: 
if DEF(_FR_FR)
	text "Respect."
	line "Bravo."
else
	text "You've won my"
	line "respect."
endc

	done

CooltrainermRyanAfterBattleText: 
if DEF(_FR_FR)
	text "Je vois que tu"
	line "prends soin de tes"
	cont "#MON."

	para "Votre amitié vous"
	line "sauvera."
else
	text "I see you're rais-"
	line "ing your #MON"
	cont "with care."

	para "The bond you build"
	line "will save you in"
	cont "tough situations."
endc

	done

CooltrainerfKellySeenText: 
if DEF(_FR_FR)
	text "Quelle est ta"
	line "stratégie?"

	para "Utiliser des capa-"
	line "cités puissantes"
	cont "au hasard ne sert"
	cont "à rien."
else
	text "What is your"
	line "battle strategy?"

	para "It is foolish to"
	line "use strong moves"
	cont "indiscriminately."
endc

	done

CooltrainerfKellyBeatenText: 
if DEF(_FR_FR)
	text "Bien. Perdu."
else
	text "Fine. I lost."
endc

	done

CooltrainerfKellyAfterBattleText: 
if DEF(_FR_FR)
	text "Moi j'aime pas les"
	line "attaques puissan-"
	cont "tes."

	para "Ca ne me fait pas"
	line "plaisir de faire"
	cont "mal aux #MON."
else
	text "I'm not in favor"
	line "of overly power-"
	cont "ful moves."

	para "I want to win, but"
	line "I also don't want"
	cont "to harm #MON."
endc

	done

CamperQuentinSeenText: 
if DEF(_FR_FR)
	text "Trop de la balle!"
else
	text "I'm really, really"
	line "tough!"
endc

	done

CamperQuentinBeatenText: 
if DEF(_FR_FR)
	text "La TOUR DE COMBAT"
	line "c'est de la balle!"
else
	text "I was tough at the"
	line "BATTLE TOWER…"
endc

	done

CamperQuentinAfterBattleText: 
if DEF(_FR_FR)
	text "As-tu visité la"
	line "TOUR DE COMBAT?"

	para "Je ne perds jamais"
	line "là-bas..."
else
	text "Have you been to"
	line "the BATTLE TOWER?"

	para "I never, ever lose"
	line "there, but…"
endc

	done

Route45SignText: 
if DEF(_FR_FR)
	text "ROUTE 45"
	line "CHEMIN de MONTAGNE"
	cont "Tout droit"
else
	text "ROUTE 45"
	line "MOUNTAIN RD. AHEAD"
endc

	done

Route45_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  3, DARK_CAVE_BLACKTHORN_ENTRANCE, 1

	def_coord_events
	coord_event  4, 74, CE_EVENT_FLAG_CLEARED, EVENT_ROUTE_45_LVL_INCREASE, Route45LevelIncrease
	coord_event  5, 74, CE_EVENT_FLAG_CLEARED, EVENT_ROUTE_45_LVL_INCREASE, Route45LevelIncrease
	coord_event 10, 82, CE_EVENT_FLAG_CLEARED, EVENT_ROUTE_45_LVL_INCREASE, Route45LevelIncrease
	coord_event 11, 82, CE_EVENT_FLAG_CLEARED, EVENT_ROUTE_45_LVL_INCREASE, Route45LevelIncrease

	def_bg_events
	bg_event 10,  2, BGEVENT_READ, Route45Sign
	bg_event 13, 78, BGEVENT_ITEM, Route45HiddenPpUp

	def_object_events
	object_event 16, 13, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event 13, 20, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1
	object_event  5, 12, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  4,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  5, 34, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 0, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  4, 34, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 0, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 13, 21, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1
	object_event  3,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1

	object_event 17, 62, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 11, 38, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 0, 2, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 10, 38, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 0, 2, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  2, 51, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 13, 66, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  5, 69, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  7, 84, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  9, 64, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  3, 58, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1


	object_event 10, 14, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerHikerErik, -1
	object_event 15, 63, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerMichael, -1
	object_event  5, 26, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerParry, -1
	object_event  9, 63, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerHikerTimothy, -1
	object_event 11, 48, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBlackbeltKenji, -1
	object_event 17, 16, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainermRyan, -1
	object_event  5, 34, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfKelly, -1
	object_event 16, 80, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route45FruitTree, -1
	object_event  6, 49, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route45Nugget, EVENT_ROUTE_45_NUGGET
	object_event  5, 64, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route45Revive, EVENT_ROUTE_45_REVIVE
	object_event  6, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route45Elixer, EVENT_ROUTE_45_ELIXER
	object_event  7, 31, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route45MaxPotion, EVENT_ROUTE_45_MAX_POTION
	object_event  4, 68, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TrainerCamperQuentin, -1
