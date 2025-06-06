	object_const_def
	const ROUTE46_POLICE_1_1
	const ROUTE46_POLICE_1_2
	const ROUTE46_POLICE_1_3
	const ROUTE46_POLICE_2_1
	const ROUTE46_POLICE_2_2
	const ROUTE46_POLICE_2_3
	const ROUTE46_POLICE_2_4
	const ROUTE46_POLICE_3_1
	const ROUTE46_POLICE_3_2
	const ROUTE46_POLICE_3_3
	const ROUTE46_POLICE_3_4
	const ROUTE46_POLICE_4_1
	const ROUTE46_POLICE_4_2
	const ROUTE46_POLICE_4_3
	const ROUTE46_POLICE_4_4
	
	const ROUTE46_POKEFAN_M
	const ROUTE46_YOUNGSTER
	const ROUTE46_LASS
	const ROUTE46_FRUIT_TREE1
	const ROUTE46_FRUIT_TREE2
	const ROUTE46_POKE_BALL
	const ROUTE46_POKE_BALL_2

Route46_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerCamperTed:
	trainer CAMPER, TED, EVENT_BEAT_CAMPER_TED, CamperTedSeenText, CamperTedBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CamperTedAfterBattleText

TrainerPicnickerErin1:
	trainer PICNICKER, ERIN1, EVENT_BEAT_PICNICKER_ERIN, PicnickerErin1SeenText, PicnickerErin1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_PICNICKER_ERIN
	endifjustbattled
	opentext
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_PICNICKER_ERIN
	iftrue Route46NumberAcceptedF
	checkevent EVENT_ERIN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext PicnickerErinAfterBattleText
	promptbutton
	setevent EVENT_ERIN_ASKED_FOR_PHONE_NUMBER
	scall Route46AskNumber1F
	sjump .AskForNumber

.AskedAlready:
	scall Route46AskNumber2F
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_ERIN
	ifequal PHONE_CONTACTS_FULL, Route46PhoneFullF
	ifequal PHONE_CONTACT_REFUSED, Route46NumberDeclinedF
	gettrainername STRING_BUFFER_3, PICNICKER, ERIN1
	scall Route46RegisteredNumberF
	sjump Route46NumberAcceptedF

.WantsBattle:
	scall Route46RematchF
	winlosstext PicnickerErin1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer PICNICKER, ERIN1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, ERIN2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, ERIN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN_READY_FOR_REMATCH
	checkevent EVENT_ERIN_CALCIUM
	iftrue .HasCalcium
	checkevent EVENT_GOT_CALCIUM_FROM_ERIN
	iftrue .GotCalciumAlready
	scall Route46RematchGiftF
	verbosegiveitem CALCIUM
	iffalse ErinNoRoomForCalcium
	setevent EVENT_GOT_CALCIUM_FROM_ERIN
	sjump Route46NumberAcceptedF

.GotCalciumAlready:
	end

.HasCalcium:
	opentext
	writetext PicnickerErin2BeatenText
	waitbutton
	verbosegiveitem CALCIUM
	iffalse ErinNoRoomForCalcium
	clearevent EVENT_ERIN_CALCIUM
	setevent EVENT_GOT_CALCIUM_FROM_ERIN
	sjump Route46NumberAcceptedF

Route46AskNumber1F:
	jumpstd AskNumber1FScript
	end

Route46AskNumber2F:
	jumpstd AskNumber2FScript
	end

Route46RegisteredNumberF:
	jumpstd RegisteredNumberFScript
	end

Route46NumberAcceptedF:
	jumpstd NumberAcceptedFScript
	end

Route46NumberDeclinedF:
	jumpstd NumberDeclinedFScript
	end

Route46PhoneFullF:
	jumpstd PhoneFullFScript
	end

Route46RematchF:
	jumpstd RematchFScript
	end

ErinNoRoomForCalcium:
	setevent EVENT_ERIN_CALCIUM
	jumpstd PackFullFScript
	end

Route46RematchGiftF:
	jumpstd RematchGiftFScript
	end

TrainerHikerBailey:
	trainer HIKER, BAILEY, EVENT_BEAT_HIKER_BAILEY, HikerBaileySeenText, HikerBaileyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer HikerBaileyAfterBattleText

Route46Sign:
	jumptext Route46SignText

Route46HiddenCarbos:
	hiddenitem CARBOS, EVENT_ROUTE_46_HIDDEN_CARBOS
	
Route46HiddenPpUp:
	hiddenitem PP_UP, EVENT_ROUTE_46_HIDDEN_PP_UP

Route46XSpeed:
	itemball X_SPEED

Route46MaxRevive:
	itemball MAX_REVIVE

Route46FruitTree1:
	fruittree FRUITTREE_ROUTE_46_1

Route46FruitTree2:
	fruittree FRUITTREE_ROUTE_46_2

HikerBaileySeenText: 
if DEF(_FR_FR)
	text "Je vais t'montrer"
	line "la force des"
	cont "#MON de"
	cont "montagne!"
else
	text "Awright! I'll show"
	line "you the power of"
	cont "mountain #MON!"
endc

	done

HikerBaileyBeatenText: 
if DEF(_FR_FR)
	text "Au secours!"
else
	text "Mercy! You showed"
	line "me your power!"
endc

	done

HikerBaileyAfterBattleText: 
if DEF(_FR_FR)
	text "Perdu c'est perdu."
	line "C'est la vie."
else
	text "It's over. I don't"
	line "mind. We HIKERS"
	cont "are like that."
endc

	done

CamperTedSeenText: 
if DEF(_FR_FR)
	text "Moi aussi j'ai des"
	line "#MON!"

	para "Ca te dit un bon"
	line "combat?"
else
	text "I'm raising #-"
	line "MON too!"

	para "Will you battle"
	line "with me?"
endc

	done

CamperTedBeatenText: 
if DEF(_FR_FR)
	text "Hein...?"
else
	text "Wha…?"
endc

	done

CamperTedAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai fait de mon"
	line "mieux..."

	para "J'suis pas fort."
	line "Tant pis."
else
	text "I did my best but"
	line "came up short."

	para "No excuses--I"
	line "admit I lost."
endc

	done

PicnickerErin1SeenText: 
if DEF(_FR_FR)
	text "J'ai des #MON"
	line "moi z'aussi!"

	para "On se fritte la"
	line "tête?"
else
	text "I raise #MON"
	line "too!"

	para "Will you battle"
	line "with me?"
endc

	done

PicnickerErin1BeatenText: 
if DEF(_FR_FR)
	text "Oh, ben mince!"
else
	text "Oh, rats!"
endc

	done

PicnickerErinAfterBattleText: 
if DEF(_FR_FR)
	text "Je connais toutes"
	line "les ARENES mais ma"

	para "préférée c'est"
	line "celle de DOUBLON-"
	cont "VILLE."

	para "Y'a tout plein"
	line "de zolies fleurs!"
else
	text "I've been to many"
	line "GYMS, but the GYM"

	para "in GOLDENROD is my"
	line "favorite."

	para "It's filled with"
	line "pretty flowers!"
endc

	done

PicnickerErin2BeatenText: 
if DEF(_FR_FR)
	text "Pfff... Je perds"
	line "tout le temps!"

	para "Y faut que je"
	line "m'entraîne!"

	para "Merci quand même."
	line "Voilà le cadeau de"
	cont "la dernière fois."
else
	text "Aww… I keep losing"
	line "all the time!"

	para "I'll just have to"
	line "try harder!"

	para "Anyway, thanks for"
	line "battling me again"

	para "and again. Here's"
	line "that present from"
	cont "the other time."
endc

	done

Route46SignText: 
if DEF(_FR_FR)
	text "ROUTE 46"
	line "CHEMIN de MONTAGNE"
else
	text "ROUTE 46"
	line "MOUNTAIN RD. AHEAD"
endc

	done

Route46_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7, 33, ROUTE_29_ROUTE_46_GATE, 1
	warp_event  8, 33, ROUTE_29_ROUTE_46_GATE, 2
	warp_event 14,  5, DARK_CAVE_VIOLET_ENTRANCE, 3

	def_coord_events

	def_bg_events
	bg_event  9, 27, BGEVENT_READ, Route46Sign
	bg_event 14, 22, BGEVENT_ITEM, Route46HiddenPpUp
	bg_event 11, 20, BGEVENT_ITEM, Route46HiddenCarbos


	def_object_events
	object_event 12,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  8, 31, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 2, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 12,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1

	object_event  4, 12, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  7, 26, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 14, 13, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 2, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1
	object_event  9,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  6, 24, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  2, 23, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  3, 15, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 11, 20, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1

	object_event 13, 21, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1
	object_event  8, 18, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 0, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 13, 16, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  4, 23, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1


	object_event 12, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerBailey, -1
	object_event  4, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperTed, -1
	object_event  2, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerErin1, -1
	object_event  7,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route46FruitTree1, -1
	object_event  8,  6, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route46FruitTree2, -1
	object_event  2, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route46XSpeed, EVENT_ROUTE_46_X_SPEED
	object_event 13, 19, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route46MaxRevive, EVENT_ROUTE_46_MAX_REVIVE
