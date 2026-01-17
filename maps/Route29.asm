	object_const_def
	const ROUTE29_POLICE_1_1
	const ROUTE29_POLICE_1_2
	const ROUTE29_POLICE_1_3
	const ROUTE29_POLICE_1_4
	const ROUTE29_POLICE_2_1
	const ROUTE29_POLICE_2_2
	const ROUTE29_POLICE_2_3
	const ROUTE29_POLICE_2_4
	const ROUTE29_POLICE_3_1
	const ROUTE29_POLICE_3_2
	const ROUTE29_POLICE_3_3
	const ROUTE29_POLICE_4_1
	const ROUTE29_POLICE_4_2
	const ROUTE29_POLICE_4_3
	const ROUTE29_POLICE_4_4

	const ROUTE29_COOLTRAINER_M1
	const ROUTE29_YOUNGSTER
	const ROUTE29_TEACHER1
	const ROUTE29_FRUIT_TREE
	const ROUTE29_FISHER
	const ROUTE29_COOLTRAINER_M2
	const ROUTE29_TUSCANY
	const ROUTE29_POKE_BALL

Route29_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Tuscany

.Tuscany:
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue .DoesTuscanyAppear

.TuscanyDisappears:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE29_TUSCANY
	endcallback

.DoesTuscanyAppear:
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, .TuscanyDisappears
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE29_TUSCANY
	endcallback

Route29Tutorial1:
	clearevent EVENT_CATCHING_TUTORIAL_AVAILABLE
	turnobject ROUTE29_COOLTRAINER_M1, UP
	showemote EMOTE_SHOCK, ROUTE29_COOLTRAINER_M1, 15
	applymovement ROUTE29_COOLTRAINER_M1, DudeMovementData1a
	turnobject PLAYER, LEFT
	opentext
	writetext CatchingTutorialIntroText
	yesorno
	iffalse Script_RefusedTutorial1

	closetext
	follow ROUTE29_COOLTRAINER_M1, PLAYER
	applymovement ROUTE29_COOLTRAINER_M1, DudeMovementData1b
	sjump Route29Tutorial2.tuto_end

Route29Tutorial2:
	clearevent EVENT_CATCHING_TUTORIAL_AVAILABLE
	turnobject ROUTE29_COOLTRAINER_M1, UP
	showemote EMOTE_SHOCK, ROUTE29_COOLTRAINER_M1, 15
	applymovement ROUTE29_COOLTRAINER_M1, DudeMovementData2a
	turnobject PLAYER, LEFT
	opentext
	writetext CatchingTutorialIntroText
	yesorno
	iffalse Script_RefusedTutorial2
	
	closetext
	follow ROUTE29_COOLTRAINER_M1, PLAYER
	applymovement ROUTE29_COOLTRAINER_M1, DudeMovementData2b
.tuto_end
	stopfollow
	loadwildmon RATTATA, 5
	catchtutorial BATTLETYPE_TUTORIAL
	turnobject ROUTE29_COOLTRAINER_M1, UP
	opentext
	writetext CatchingTutorialDebriefText
	waitbutton
	closetext
	setevent EVENT_LEARNED_TO_CATCH_POKEMON
	end

Script_RefusedTutorial1:
	writetext CatchingTutorialDeclinedText
	waitbutton
	closetext
	applymovement ROUTE29_COOLTRAINER_M1, DudeMovementData1b
	end

Script_RefusedTutorial2:
	writetext CatchingTutorialDeclinedText
	waitbutton
	closetext
	applymovement ROUTE29_COOLTRAINER_M1, DudeMovementData2b
	end

CatchingTutorialDudeScript:
	faceplayer
	opentext
	readvar VAR_BOXSPACE
	ifequal 0, .BoxFull
	checkevent EVENT_LEARNED_TO_CATCH_POKEMON
	iftrue .BoxFull
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iffalse .BoxFull
	writetext CatchingTutorialRepeatText
	yesorno
	iffalse .Declined
	closetext
	loadwildmon SENTRET, 2
	catchtutorial BATTLETYPE_TUTORIAL
	opentext
	writetext CatchingTutorialDebriefText
	waitbutton
	closetext
	setevent EVENT_LEARNED_TO_CATCH_POKEMON
	end

.BoxFull:
	writetext CatchingTutorialBoxFullText
	waitbutton
	closetext
	end

.Declined:
	writetext CatchingTutorialDeclinedText
	waitbutton
	closetext
	end

Route29YoungsterScript:
	jumptextfaceplayer Route29YoungsterText

Route29TeacherScript:
	jumptextfaceplayer Route29TeacherText

Route29FisherScript:
	jumptextfaceplayer Route29FisherText

Route29CooltrainerMScript:
	faceplayer
	opentext
	writetext Route29CooltrainerMText_BerryExplanation

	readmem wPartyMon1Item
	ifnotequal BERRY, .end

	promptbutton
	getitemname STRING_BUFFER_4, BERRY
	loadmem wCurPartyMon, 0
	callasm GetCurNickname
	writetext Route29CooltrainerMText_OranBerryDetected
.end	
	waitbutton
	closetext
	end

TuscanyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PINK_BOW_FROM_TUSCANY
	iftrue TuscanyTuesdayScript
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, TuscanyNotTuesdayScript
	checkevent EVENT_MET_TUSCANY_OF_TUESDAY
	iftrue .MetTuscany
	writetext MeetTuscanyText
	promptbutton
	setevent EVENT_MET_TUSCANY_OF_TUESDAY
.MetTuscany:
	writetext TuscanyGivesGiftText
	promptbutton
	verbosegiveitem PINK_BOW
	iffalse TuscanyDoneScript
	setevent EVENT_GOT_PINK_BOW_FROM_TUSCANY
	writetext TuscanyGaveGiftText
	waitbutton
	closetext
	end

TuscanyTuesdayScript:
	writetext TuscanyTuesdayText
	waitbutton
TuscanyDoneScript:
	closetext
	end

TuscanyNotTuesdayScript:
	writetext TuscanyNotTuesdayText
	waitbutton
	closetext
	end

Route29Sign1:
	jumptext Route29Sign1Text

Route29Sign2:
	jumptext Route29Sign2Text

Route29FruitTree:
	fruittree FRUITTREE_ROUTE_29

Route29Potion:
	itemball POTION

DudeMovementData1a:
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step_end

DudeMovementData2a:
	step UP
	step UP
	step UP
	step RIGHT
	step_end

DudeMovementData1b:
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

DudeMovementData2b:
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step_end

CatchingTutorialBoxFullText: 
if DEF(_FR_FR)
	text "Les #MON se"
	line "cachent dans"

	para "l'herbe. Ils sur-"
	line "gissent d'un coup."
	cont "Pouf!"
else
	text "#MON hide in"
	line "the grass. Who"

	para "knows when they'll"
	line "pop out…"
endc

	done

CatchingTutorialIntroText: 
if DEF(_FR_FR)
	text "J'te connais toi."
	line "Combien de #MON"
	cont "as-tu attrapés?"

	para "Veux-tu que je te"
	line "montre comment at-"
	cont "traper des"
	cont "#MON?"
else
	text "I've seen you a"
	line "couple times. How"

	para "many #MON have"
	line "you caught?"

	para "Would you like me"
	line "to show you how to"
	cont "catch #MON?"
endc

	done

CatchingTutorialDebriefText: 
if DEF(_FR_FR)
	text "Voilà comment il"
	line "faut faire."

	para "Si tu affaiblis"
	line "d'abord le #-"
	cont "MON, il sera plus"
	cont "facile à attraper."
else
	text "That's how you do"
	line "it."

	para "If you weaken them"
	line "first, #MON are"
	cont "easier to catch."
endc

	done

CatchingTutorialDeclinedText: 
if DEF(_FR_FR)
	text "Oh. Bon."

	para "En tout cas, tu"
	line "dois beaucoup mar-"

	para "cher pour attraper"
	line "des #MON."
else
	text "Oh. Fine, then."

	para "Anyway, if you"
	line "want to catch"

	para "#MON, you have"
	line "to walk a lot."
endc

	done

CatchingTutorialRepeatText: 
if DEF(_FR_FR)
	text "Hein? Tu veux que"
	line "je te montre com-"
	cont "ment attraper des"
	cont "#MON?"
else
	text "Huh? You want me"
	line "to show you how to"
	cont "catch #MON?"
endc

	done

Route29YoungsterText: 
if DEF(_FR_FR)
	text "Salut. Comment"
	line "vont tes #MON?"

	para "S'ils sont fati-"
	line "gués ou incapables"

	para "de combattre,"
	line "évite l'herbe!"
else
	text "Yo. How are your"
	line "#MON?"

	para "If they're weak"
	line "and not ready for"

	para "battle, keep out"
	line "of the grass."
endc

	done

Route29TeacherText: 
if DEF(_FR_FR)
	text "Tu vois ce mur?"
	line "Sauter de là doit"
	cont "faire peur."

	para "Mais tu peux aller"
	line "à BOURG GEON sans"

	para "marcher dans les"
	line "hautes herbes."
else
	text "See those ledges?"
	line "It's scary to jump"
	cont "off them."

	para "But you can go to"
	line "NEW BARK without"

	para "walking through"
	line "the grass."
endc

	done

Route29FisherText: 
if DEF(_FR_FR)
	text "J'ai voulu faire"
	line "une pause alors"

	para "j'ai sauvegardé ma"
	line "partie."
else
	text "I wanted to take a"
	line "break, so I saved"

	para "to record my"
	line "progress."
endc

	done

Route29CooltrainerMText_BerryExplanation:
if DEF(_FR_FR)
	text "Cet arbre à côté"
	line "de nous fait"
	cont "pousser des baies."
	
	para "N'hésite pas à en"
	line "ramasser!"
	
	para "Ton #MON peut"
	line "en tenir une si tu"
	
	para "lui en donnes une"
	line "depuis ton sac."
	
	para "Il la mangera en"
	line "combat quand sa"
	
	para "santé tombera en"
	line "dessous de la"
	cont "moitié."
else
	text "This tree next to"
	line "us grows berries."

	para "Feel free to pick"
	line "some up!"

	para "Your #MON can"
	line "hold one, if you"
	
	para "give them one"
	line "from your pack."
	
	para "They'll consume it"
	line "in battle when"

	para "their health drops"
	line "below half."
endc
	done

Route29CooltrainerMText_OranBerryDetected:
if DEF(_FR_FR)
	text "Oh! Je vois que"
	line "ton @"
	text_ram wStringBuffer1
	text ""
	
	cont "tient déjà une"
	cont "@"
	text_ram wStringBuffer4
	text "!"
else
	text "Oh! I see your"
	line "@"
	text_ram wStringBuffer1
	text " is"

	para "already holding"
	line "an @"
	text_ram wStringBuffer4
	text "!"
endc
	done

MeetTuscanyText: 
if DEF(_FR_FR)
	text "MARIE: Il me sem-"
	line "ble que c'est la"

	para "première fois que"
	line "l'on se rencontre."

	para "Permets-moi de me"
	line "présenter. Je suis"
	cont "MARIE du mardi."
else
	text "TUSCANY: I do be-"
	line "lieve that this is"

	para "the first time"
	line "we've met?"

	para "Please allow me to"
	line "introduce myself."

	para "I am TUSCANY of"
	line "Tuesday."
endc

	done

TuscanyGivesGiftText: 
if DEF(_FR_FR)
	text "En cadeau..."
	line "Permets-moi"

	para "de t'offrir..."
	line "Un RUBAN ROSE."
else
	text "By way of intro-"
	line "duction, please"

	para "accept this gift,"
	line "a PINK BOW."
endc

	done

TuscanyGaveGiftText: 
if DEF(_FR_FR)
	text "MARIE: C'est"
	line "ravissant, tu ne"
	cont "trouves pas?"

	para "Il améliore les"
	line "capacités de type"
	cont "NORMAL."

	para "Je suis sûre qu'il"
	line "te sera utile."
else
	text "TUSCANY: Wouldn't"
	line "you agree that it"
	cont "is most adorable?"

	para "It strengthens"
	line "normal-type moves."

	para "I am certain it"
	line "will be of use."
endc

	done

TuscanyTuesdayText: 
if DEF(_FR_FR)
	text "MARIE: As-tu"
	line "rencontré LUCIE,"
	cont "ma grande soeur?"

	para "Ou mon petit frère"
	line "HOMER?"

	para "Je suis la deuxiè-"
	line "me des sept en-"
	cont "fants."
else
	text "TUSCANY: Have you"
	line "met MONICA, my"
	cont "older sister?"

	para "Or my younger"
	line "brother, WESLEY?"

	para "I am the second of"
	line "seven children."
endc

	done

TuscanyNotTuesdayText: 
if DEF(_FR_FR)
	text "MARIE: Aujourd'hui"
	line "n'est pas mardi."
	cont "C'est dommage..."
else
	text "TUSCANY: Today is"
	line "not Tuesday. That"
	cont "is unfortunate…"
endc

	done

Route29Sign1Text: 
if DEF(_FR_FR)
	text "ROUTE 29"

	para "VILLE GRIOTTE -"
	line "BOURG GEON"
else
	text "ROUTE 29"

	para "CHERRYGROVE CITY -"
	line "NEW BARK TOWN"
endc

	done

Route29Sign2Text: 
if DEF(_FR_FR)
	text "ROUTE 29"

	para "VILLE GRIOTTE -"
	line "BOURG GEON"
else
	text "ROUTE 29"

	para "CHERRYGROVE CITY -"
	line "NEW BARK TOWN"
endc

	done

Route29_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 27,  1, ROUTE_29_ROUTE_46_GATE, 3

	def_coord_events
	coord_event 53,  8, CE_EVENT_FLAG_SET, EVENT_CATCHING_TUTORIAL_AVAILABLE, Route29Tutorial1
	coord_event 53,  9, CE_EVENT_FLAG_SET, EVENT_CATCHING_TUTORIAL_AVAILABLE, Route29Tutorial2

	def_bg_events
	bg_event 51,  7, BGEVENT_READ, Route29Sign1
	bg_event  3,  5, BGEVENT_READ, Route29Sign2

	def_object_events
	object_event 48, 10, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 23, 14, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 27,  5, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 11,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	
	object_event 36,  7, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_Y, 0, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 53,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  6, 11, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  7,  9, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 50, 11, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 39, 16, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 2, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  7,  8, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 46, 13, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 38, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1
	object_event 26,  4, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  6,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1

	object_event 50, 12, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CatchingTutorialDudeScript, -1
	object_event 27, 16, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route29YoungsterScript, -1
	object_event 15, 11, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route29TeacherScript, -1
	object_event 12,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route29FruitTree, -1
	object_event 25,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route29FisherScript, -1
	object_event 13,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route29CooltrainerMScript, -1
	object_event 29, 12, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, TuscanyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 48,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route29Potion, EVENT_ROUTE_29_POTION
