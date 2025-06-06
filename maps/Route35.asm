	object_const_def
	const ROUTE35_POLICE_1_1
	const ROUTE35_POLICE_1_2
	const ROUTE35_POLICE_1_3
	const ROUTE35_POLICE_2_1
	const ROUTE35_POLICE_2_2
	const ROUTE35_POLICE_2_3
	const ROUTE35_POLICE_2_4
	const ROUTE35_POLICE_3_1
	const ROUTE35_POLICE_3_2
	const ROUTE35_POLICE_3_3
	const ROUTE35_POLICE_4_1
	const ROUTE35_POLICE_4_2
	const ROUTE35_POLICE_4_3
	const ROUTE35_POLICE_4_4
	
	const ROUTE35_YOUNGSTER1
	const ROUTE35_YOUNGSTER2
	const ROUTE35_LASS1
	const ROUTE35_LASS2
	const ROUTE35_YOUNGSTER3
	const ROUTE35_FISHER
	const ROUTE35_BUG_CATCHER
	const ROUTE35_SUPER_NERD
	const ROUTE35_FRUIT_TREE
	const ROUTE35_POKE_BALL
	const ROUTE35_SAVIOUR_OFFICER
	const ROUTE35_SICK_CATERPIE

Route35_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	
.TilesLoad:
	; National Park - South Entrance.
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock  2,  4, $38
	changeblock  4,  4, $5f

.EndTilesCallback
	endcallback

TrainerBirdKeeperBryan:
	trainer BIRD_KEEPER, BRYAN, EVENT_BEAT_BIRD_KEEPER_BRYAN, BirdKeeperBryanSeenText, BirdKeeperBryanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperBryanAfterBattleText

TrainerJugglerIrwin:
	trainer JUGGLER, IRWIN1, EVENT_BEAT_JUGGLER_IRWIN, JugglerIrwin1SeenText, JugglerIrwin1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_JUGGLER_IRWIN
	endifjustbattled
	opentext
	checkcellnum PHONE_JUGGLER_IRWIN
	iftrue Route35NumberAcceptedM
	checkevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext JugglerIrwinAfterBattleText
	promptbutton
	setevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_JUGGLER_IRWIN
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	gettrainername STRING_BUFFER_3, JUGGLER, IRWIN1
	scall Route35RegisteredNumberM
	sjump Route35NumberAcceptedM

Route35AskNumber1M:
	jumpstd AskNumber1MScript
	end

Route35AskNumber2M:
	jumpstd AskNumber2MScript
	end

Route35RegisteredNumberM:
	jumpstd RegisteredNumberMScript
	end

Route35NumberAcceptedM:
	jumpstd NumberAcceptedMScript
	end

Route35NumberDeclinedM:
	jumpstd NumberDeclinedMScript
	end

Route35PhoneFullM:
	jumpstd PhoneFullMScript
	end

Route35RematchM:
	jumpstd RematchMScript
	end

TrainerCamperIvan:
	trainer CAMPER, IVAN, EVENT_BEAT_CAMPER_IVAN, CamperIvanSeenText, CamperIvanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CamperIvanAfterBattleText

TrainerCamperElliot:
	trainer CAMPER, ELLIOT, EVENT_BEAT_CAMPER_ELLIOT, CamperElliotSeenText, CamperElliotBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CamperElliotAfterBattleText

TrainerPicnickerBrooke:
	trainer PICNICKER, BROOKE, EVENT_BEAT_PICNICKER_BROOKE, PicnickerBrookeSeenText, PicnickerBrookeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PicnickerBrookeAfterBattleText

TrainerPicnickerKim:
	trainer PICNICKER, KIM, EVENT_BEAT_PICNICKER_KIM, PicnickerKimSeenText, PicnickerKimBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PicnickerKimAfterBattleText

TrainerBugCatcherArnie:
	trainer BUG_CATCHER, ARNIE1, EVENT_BEAT_BUG_CATCHER_ARNIE, BugCatcherArnieSeenText, BugCatcherArnieBeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BUG_CATCHER_ARNIE
	endifjustbattled
	opentext
	checkflag ENGINE_ARNIE_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkflag ENGINE_YANMA_SWARM
	iftrue .YanmaSwarming
	checkcellnum PHONE_BUG_CATCHER_ARNIE
	iftrue Route35NumberAcceptedM
	checkevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BugCatcherArnieAfterBattleText
	promptbutton
	setevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_BUG_CATCHER_ARNIE
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	gettrainername STRING_BUFFER_3, BUG_CATCHER, ARNIE1
	scall Route35RegisteredNumberM
	sjump Route35NumberAcceptedM

.WantsBattle:
	scall Route35RematchM
	winlosstext BugCatcherArnieBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight1
	loadtrainer BUG_CATCHER, ARNIE1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, ARNIE2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, ARNIE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, ARNIE4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, ARNIE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.YanmaSwarming:
	writetext BugCatcherArnieYanmaText
	waitbutton
	closetext
	end

TrainerFirebreatherWalt:
	trainer FIREBREATHER, WALT, EVENT_BEAT_FIREBREATHER_WALT, FirebreatherWaltSeenText, FirebreatherWaltBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FirebreatherWaltAfterBattleText

Route35SaviourScript:
	checkmapscene GOLDENROD_HOSPITAL_CORRIDOR
	ifnotequal 0, .skip_launch_hospital_quest
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_1 ; Launches the hospital quest.
.skip_launch_hospital_quest
	jumptextfaceplayer Route35SaviourText

Route35CaterpieScript:
	setval CATERPIE
	special PlaySlowCry
	end

Route35Sign:
	jumptext Route35SignText

Route35_DoorScript:
	jumpstd LockdownCurfewClosedDoor

Route35TMRollout:
	itemball TM_ROLLOUT

Route35FruitTree:
	fruittree FRUITTREE_ROUTE_35

CamperIvanSeenText: 
if DEF(_FR_FR)
	text "J'ai appris plein"
	line "de trucs sur les"

	para "#MON à la ra-"
	line "dio. Tu vas voir!"
else
	text "I've been getting"
	line "#MON data off"

	para "my radio. I think"
	line "I'm good."
endc

	done

CamperIvanBeatenText: 
if DEF(_FR_FR)
	text "Perdu!"
else
	text "I give!"
endc

	done

CamperIvanAfterBattleText: 
if DEF(_FR_FR)
	text "La musique de la"
	line "radio fait réagir"
	cont "les #MON sau-"
	cont "vages."
else
	text "Music on the radio"
	line "changes the moods"
	cont "of wild #MON."
endc

	done

CamperElliotSeenText: 
if DEF(_FR_FR)
	text "J'vais montrer à"
	line "ma copine que je"
	cont "suis un vrai dur!"
else
	text "I'm gonna show my"
	line "girlfriend I'm hot"
	cont "stuff!"
endc

	done

CamperElliotBeatenText: 
if DEF(_FR_FR)
	text "T'aurais pu perdre"
	line "pour me faire"
	cont "plaisir..."
else
	text "I wish you would"
	line "have lost for me…"
endc

	done

CamperElliotAfterBattleText: 
if DEF(_FR_FR)
	text "Tu m'as fichu la"
	line "honte devant ma"
	cont "copine..."
else
	text "I was humiliated"
	line "in front of my"
	cont "girlfriend…"
endc

	done

PicnickerBrookeSeenText: 
if DEF(_FR_FR)
	text "Mon copain est"
	line "trop nul! J'ai la"
	cont "super honte!"
else
	text "My boyfriend's"
	line "weak, so I can't"
	cont "rely on him."
endc

	done

PicnickerBrookeBeatenText: 
if DEF(_FR_FR)
	text "Oh! Mazette!"
else
	text "Oh, my! You're so"
	line "strong!"
endc

	done

PicnickerBrookeAfterBattleText: 
if DEF(_FR_FR)
	text "Je préfère mes"
	line "#MON à mon"
	cont "copain."
else
	text "I can count on my"
	line "#MON more than"
	cont "my boyfriend."
endc

	done

PicnickerKimSeenText: 
if DEF(_FR_FR)
	text "Tu vas à l'ARENE?"
	line "Moi aussi!"
else
	text "Are you going to"
	line "the GYM? Me too!"
endc

	done

PicnickerKimBeatenText: 
if DEF(_FR_FR)
	text "J'ai aucune"
	line "chance..."
else
	text "Oh. I couldn't"
	line "win…"
endc

	done

PicnickerKimAfterBattleText: 
if DEF(_FR_FR)
	text "Les BADGES d'ARENE"
	line "sont jolis. Je les"
	cont "collectionne."
else
	text "The GYM BADGES are"
	line "pretty. I collect"
	cont "them."
endc

	done

BirdKeeperBryanSeenText: 
if DEF(_FR_FR)
	text "Quelles # BALLS"
	line "utilises-tu?"
else
	text "What kinds of"
	line "BALLS do you use?"
endc

	done

BirdKeeperBryanBeatenText: 
if DEF(_FR_FR)
	text "Whoa! Pas assez"
	line "rapide!"
else
	text "Yikes! Not fast"
	line "enough!"
endc

	done

BirdKeeperBryanAfterBattleText: 
if DEF(_FR_FR)
	text "Certains #MON"
	line "s'enfuient vite."

	para "Attrape-les avec"
	line "une SPEED BALL de"
	cont "FARGAS."

	para "Apporte à FARGAS"
	line "un NOIGRUME BLC si"
	cont "tu en trouves un."

	para "Il le transformera"
	line "en # BALL!"
else
	text "Some #MON flee"
	line "right away."

	para "Try catching them"
	line "with KURT's FAST"
	cont "BALL."

	para "Whenever I find a"
	line "WHT APRICORN, I"
	cont "take it to KURT."

	para "He turns it into a"
	line "custom BALL."
endc

	done

JugglerIrwin1SeenText: 
if DEF(_FR_FR)
	text "Regarde comme je"
	line "lance bien mes"
	cont "BALLS!"
else
	text "Behold my graceful"
	line "BALL dexterity!"
endc

	done

JugglerIrwin1BeatenText: 
if DEF(_FR_FR)
	text "Alors ça!"
else
	text "Whew! That was a"
	line "jolt!"
endc

	done

JugglerIrwinAfterBattleText: 
if DEF(_FR_FR)
	text "J'allais t'éblouir"
	line "avec mon nouveau"
	cont "#MON..."

	para "Mais tu es trop"
	line "rapide!"
else
	text "I was going to"
	line "dazzle you with my"
	cont "prize #MON."

	para "But your prowess"
	line "electrified me!"
endc

	done

BugCatcherArnieSeenText: 
if DEF(_FR_FR)
	text "Moi mon truc c'est"
	line "les #MON"
	cont "insecte."
else
	text "I'll go anywhere"
	line "if bug #MON"
	cont "appear there."
endc

	done

BugCatcherArnieBeatenText: 
if DEF(_FR_FR)
	text "Hein? Je n'aurais"
	line "pas dû perdre..."
else
	text "Huh? I shouldn't"
	line "have lost that…"
endc

	done

BugCatcherArnieAfterBattleText: 
if DEF(_FR_FR)
	text "Mon MIMITOSS a ga-"
	line "gné au Concours de"

	para "Capture d'insecte"
	line "au PARC NATUREL."
else
	text "My VENONAT won me"
	line "the Bug-Catching"

	para "Contest at the"
	line "NATIONAL PARK."
endc

	done

BugCatcherArnieYanmaText: 
if DEF(_FR_FR)
	text "Woah! Regarde"
	line "ces YANMA!"

	para "J'en suis baba!"
else
	text "Wow… Look at all"
	line "those YANMA!"

	para "I'm so blown away,"
	line "I can't move."
endc

	done

FirebreatherWaltSeenText: 
if DEF(_FR_FR)
	text "Moi j'crache du"
	line "feu. COMBAT!"
else
	text "I'm practicing my"
	line "fire breathing."
endc

	done

FirebreatherWaltBeatenText: 
if DEF(_FR_FR)
	text "Tu m'as cramé!"
else
	text "Ow! I scorched the"
	line "tip of my nose!"
endc

	done

FirebreatherWaltAfterBattleText: 
if DEF(_FR_FR)
	text "La fanfare #MON"
	line "à la radio attire"
	cont "les #MON"
	cont "sauvages."
else
	text "The #MON March"
	line "on the radio lures"
	cont "wild #MON."
endc

	done

Route35SignText: 
if DEF(_FR_FR)
	text "ROUTE 35"
else
	text "ROUTE 35"
endc

	done

Route35SaviourText: ; TO TRANSLATE
	text "This #MON is"
	line "seriously ill and"
	cont "needs immediate"
	cont "care."

	para "Go find CHIEF"
	line "NURSE JOY and"
	cont "bring her here"
	cont "now!"

	para "At this time, she"
	line "must be at the"
	cont "HOSPITAL."
	done

Route35_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 33, ROUTE_35_GOLDENROD_GATE, 1
	warp_event 10, 33, ROUTE_35_GOLDENROD_GATE, 2
	warp_event  3,  5, ROUTE_35_NATIONAL_PARK_GATE, 3

	def_coord_events

	def_bg_events
	bg_event  1,  7, BGEVENT_READ, Route35Sign
	bg_event 11, 31, BGEVENT_READ, Route35Sign
	bg_event  3,  5, BGEVENT_CLOSED_DOOR, Route35_DoorScript

	def_object_events
	object_event  5,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  8, 20, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  7, 20, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	
	object_event  4,  9, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  3, 26, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  8, 32, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 16,  9, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	
	object_event 12,  8, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  9, 30, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 16, 12, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 3, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	
	object_event  9, 22, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 17,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  5, 19, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 12,  9, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 2, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  4, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperIvan, -1
	object_event  8, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerCamperElliot, -1
	object_event  7, 20, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerPicnickerBrooke, -1
	object_event 10, 26, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerKim, -1
	object_event 14, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerBirdKeeperBryan, -1
	object_event  2, 10, SPRITE_FISHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherWalt, -1
	object_event 16,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherArnie, -1
	object_event  5, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerJugglerIrwin, -1
	object_event  2, 25, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route35FruitTree, -1
	object_event 13, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route35TMRollout, EVENT_ROUTE_35_TM_ROLLOUT
	object_event  4, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35SaviourScript, EVENT_SICK_CATERPIE
	object_event  3, 11, SPRITE_CATERPIE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35CaterpieScript, EVENT_SICK_CATERPIE
