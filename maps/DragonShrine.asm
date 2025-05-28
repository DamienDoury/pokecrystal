	object_const_def
	const DRAGONSHRINE_ELDER1
	const DRAGONSHRINE_ELDER2
	const DRAGONSHRINE_ELDER3
	const DRAGONSHRINE_CLAIR

DragonShrine_MapScripts:
	def_scene_scripts
	scene_script .DragonShrineTest ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.DragonShrineTest:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .end

	prioritysjump .DragonShrineTestScript
.end
	end

.DummyScene:
	end

.EnterCallback:
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

.EndCallback:
	endcallback

.DragonShrineTestScript:
	applymovement PLAYER, DragonShrinePlayerWalkInMovement
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderStepDownMovement
	opentext
	writetext DragonShrineElderGreetingText
	promptbutton
.Question1:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	writetext DragonShrineQuestion1Text
	promptbutton
	loadmenu DragonShrineQuestion1_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .RightAnswer
	ifequal 2, .WrongAnswer
	ifequal 3, .RightAnswer
	end

.Question2:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	writetext DragonShrineQuestion2Text
	promptbutton
	loadmenu DragonShrineQuestion2_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .RightAnswer
	ifequal 2, .RightAnswer
	ifequal 3, .WrongAnswer
.Question3:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	writetext DragonShrineQuestion3Text
	promptbutton
	loadmenu DragonShrineQuestion3_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .WrongAnswer
	ifequal 2, .RightAnswer
	ifequal 3, .RightAnswer
.Question4:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	writetext DragonShrineQuestion4Text
	promptbutton
	loadmenu DragonShrineQuestion4_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .RightAnswer
	ifequal 2, .WrongAnswer
	ifequal 3, .RightAnswer
.Question5:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	writetext DragonShrineQuestion5Text
	promptbutton
	loadmenu DragonShrineQuestion5_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .WrongAnswer
	ifequal 2, .RightAnswer
	ifequal 3, .WrongAnswer
.RightAnswer:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .PassedTheTest
	writetext DragonShrineRightAnswerText
	promptbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .Question5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .Question4
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Question3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Question2
.WrongAnswer:
	closetext
	turnobject DRAGONSHRINE_ELDER1, LEFT
	opentext
	writetext DragonShrineWrongAnswerText1
	waitbutton
	closetext
	turnobject DRAGONSHRINE_ELDER1, DOWN
	opentext
	writetext DragonShrineWrongAnswerText2
	waitbutton
	closetext
	setevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .Question5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .Question4
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .Question3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Question2
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Question1
.PassedTheTest:
	writetext DragonShrinePassedTestText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_CLAIR
	appear DRAGONSHRINE_CLAIR
	waitsfx
	turnobject PLAYER, DOWN
	pause 30
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairWalkInMovement
	turnobject DRAGONSHRINE_CLAIR, RIGHT
	turnobject PLAYER, LEFT
	turnobject DRAGONSHRINE_ELDER1, LEFT
	opentext
	writetext DragonShrineClairYouPassedText
	waitbutton
	closetext
	special FadeOutMusic
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairBigStepLeftMovement
	opentext
	writetext DragonShrineClairThatCantBeText
	waitbutton
	closetext
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairSlowStepLeftMovement
	opentext
	writetext DragonShrineClairYoureLyingText
	waitbutton
	closetext
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkToClairMovement
	turnobject DRAGONSHRINE_CLAIR, UP
	opentext
	writetext DragonShrineMustIInformLanceText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, DRAGONSHRINE_CLAIR, 15
	opentext
	writetext DragonShrineIUnderstandText
	waitbutton
	closetext
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairTwoSlowStepsRightMovement
	opentext
	writetext DragonShrineHereRisingBadgeText
	waitbutton
	setflag ENGINE_RISINGBADGE
	playsound SFX_GET_BADGE
	waitsfx
	special RestartMapMusic
	setscene SCENE_FINISHED
	setmapscene DRAGONS_DEN_B1F, SCENE_DRAGONSDENB1F_CLAIR_GIVES_TM
	writetext DragonShrinePlayerReceivedRisingBadgeText
	promptbutton
	farscall NewBadgeObedienceNotification
	closetext
	turnobject DRAGONSHRINE_CLAIR, UP
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkAway2Movement
	turnobject PLAYER, UP
	opentext
	writetext DragonShrineElderScoldsClairText
	waitbutton
	closetext
	opentext
	writetext DragonShrineSpeechlessText
	waitbutton
	closetext
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairWalkOutMovement
	playsound SFX_ENTER_DOOR
	disappear DRAGONSHRINE_CLAIR
	waitsfx
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

DragonShrineElder1Script:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .DontGiveDratiniYet
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	iftrue .ReceivedDratini
	checkevent EVENT_GOT_DRATINI
	iffalse .GiveDratini
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue .BeatRivalInMtMoon
	writetext DragonShrineClairsGrandfatherText
	waitbutton
	closetext
	end

.GiveDratini:
	writetext DragonShrineTakeThisDratiniText
	waitbutton
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	writetext DragonShrinePlayerReceivedDratiniText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke DRATINI, 15
	checkevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	special GiveDratini
	setevent EVENT_GOT_DRATINI
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	writetext DragonShrineSymbolicDragonText
	waitbutton
	closetext
	end

.PartyFull:
	writetext DragonShrinePartyFullText
	waitbutton
	closetext
	end

.BeatRivalInMtMoon:
	writetext DragonShrineSilverIsInTrainingText
	waitbutton
	closetext
	end

.DontGiveDratiniYet:
	writetext DragonShrineComeAgainText
	waitbutton
	closetext
	end

.ReceivedDratini:
	writetext DragonShrineSymbolicDragonText
	waitbutton
	closetext
	end

DragonShrineElder2Script:
	faceplayer
	opentext
	writetext DragonShrineElder2Text
	waitbutton
	closetext
	end

DragonShrineElder3Script:
	faceplayer
	opentext
	writetext DragonShrineElder3Text
	waitbutton
	closetext
	end

DragonShrineQuestion1_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 8, 4, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Pal@"
	db "Underling@"
	db "Friend@"

DragonShrineQuestion2_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 9, 4, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Strategy@"
	db "Raising@"
	db "Cheating@"

DragonShrineQuestion3_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 5, 4, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Weak person@"
	db "Tough person@"
	db "Anybody@"

DragonShrineQuestion4_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 8, 4, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Love@"
	db "Violence@"
	db "Knowledge@"

DragonShrineQuestion5_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 12, 4, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	db 3 ; items
	db "Tough@"
	db "Both@"
	db "Weak@"

DragonShrinePlayerWalkInMovement:
	slow_step UP
	slow_step UP
	slow_step UP
	slow_step RIGHT
	slow_step UP
	slow_step UP
	step_end

DragonShrineElderStepDownMovement:
	slow_step DOWN
	step_end

DragonShrineElderWalkToClairMovement:
	slow_step LEFT
	slow_step LEFT
	turn_head DOWN
	step_end

DragonShrineElderWalkAway2Movement:
	slow_step RIGHT
	turn_head DOWN
	step_end

DragonShrineClairWalkInMovement:
	slow_step UP
	slow_step UP
	slow_step UP
	slow_step UP
	slow_step UP
	step_end

DragonShrineClairBigStepLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	step_end

DragonShrineClairSlowStepLeftMovement:
	slow_step RIGHT
	step_end

DragonShrineClairTwoSlowStepsRightMovement:
	turn_head RIGHT
	step_end

DragonShrineClairWalkOutMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

DragonShrineElderGreetingText: 
if DEF(_FR_FR)
	text "Hmm..."
	line "Bienvenue."

	para "Ne parle pas."

	para "SANDRA t'a dit de"
	line "venir, non?"

	para "Coriace la petite,"
	line "non?"

	para "Je dois te mettre"
	line "à l'épreuve."

	para "Tu ne dois répon-"
	line "dre qu'à quelques"
	cont "questions."

	para "On commence?"
else
	text "Hm… Good to see"
	line "you here."

	para "No need to explain"
	line "why you came."

	para "CLAIR sent you"
	line "here, didn't she?"

	para "That girl is a"
	line "handful…"

	para "I am sorry, but I"
	line "must test you."

	para "Not to worry, you"
	line "are to answer only"
	cont "a few questions."

	para "Ready?"
endc

	done

DragonShrineQuestion1Text: 
if DEF(_FR_FR)
	text "Que représente un"
	line "#MON à tes"
	cont "yeux?"
else
	text "What are #MON"
	line "to you?"
endc

	done

DragonShrineQuestion2Text: 
if DEF(_FR_FR)
	text "Qu'est-ce qui aide"
	line "à gagner les"
	cont "combats?"
else
	text "What helps you to"
	line "win battles?"
endc

	done

DragonShrineQuestion3Text: 
if DEF(_FR_FR)
	text "Quel type de"
	line "dresseur veux-tu"
	cont "affronter?"
else
	text "What kind of"
	line "trainer do you"
	cont "wish to battle?"
endc

	done

DragonShrineQuestion4Text: 
if DEF(_FR_FR)
	text "Quelle est la cho-"
	line "se la plus impor-"
	cont "tante en entraî-"
	cont "nant les #MON?"
else
	text "What is most"
	line "important for"
	cont "raising #MON?"
endc

	done

DragonShrineQuestion5Text: 
if DEF(_FR_FR)
	text "#MON puissant."
	line "#MON faible."

	para "Lequel est le plus"
	line "important?"
else
	text "Strong #MON."
	line "Weak #MON."

	para "Which is more"
	line "important?"
endc

	done

DragonShrinePassedTestText: 
if DEF(_FR_FR)
	text "Hmm... Je vois..."

	para "Tu as de vrais"
	line "sentiments pour"
	cont "les #MON."

	para "C'est bien ça."

	para "C'est très impor-"
	line "tant!"

	para "<PLAYER>, ne"
	line "change jamais."

	para "Cela t'aidera"
	line "pour la LIGUE"
	cont "#MON."
else
	text "Hm… I see…"

	para "You care deeply"
	line "for #MON."

	para "Very commendable."

	para "That conviction is"
	line "what is important!"

	para "<PLAYER>, don't"
	line "lose that belief."

	para "It will see you"
	line "through at the"
	cont "#MON LEAGUE."
endc

	done

DragonShrineMustIInformLanceText: 
if DEF(_FR_FR)
	text "SANDRA!"

	para "C'est un bon"
	line "élément..."

	para "Admets ta défaite"
	line "et donne ton"
	cont "BADGE LEVER!"

	para "...Ou dois-je en"
	line "informer PETER?"
else
	text "CLAIR!"

	para "This child is"
	line "impeccable, in"
	cont "skill and spirit!"

	para "Admit defeat and"
	line "confer the RISING-"
	cont "BADGE!"

	para "…Or must I inform"
	line "LANCE of this?"
endc

	done

DragonShrineElderScoldsClairText: 
if DEF(_FR_FR)
	text "SANDRA..."

	para "Penche-toi sur"
	line "tes lacunes..."

	para "Prends exemple sur"
	line "<PLAYER>."
else
	text "CLAIR…"

	para "Reflect upon what"
	line "it is that you"

	para "lack and this"
	line "child has."
endc

	done

DragonShrineComeAgainText: 
if DEF(_FR_FR)
	text "N'hésite pas à"
	line "revenir en ce"
	cont "saint lieu."
else
	text "Come again, if you"
	line "so desire."
endc

	done

DragonShrineTakeThisDratiniText: 
if DEF(_FR_FR)
	text "Hmm..."
	line "Bienvenue."

	para "Tu tombes au bon"
	line "moment."

	para "J'ai quelque chose"
	line "pour toi."

	para "Ce MINIDRACO est"
	line "la preuve de ta"
	cont "valeur..."
else
	text "Hm… Good to see"
	line "you here."

	para "Your arrival is"
	line "most fortunate."

	para "I have something"
	line "for you."

	para "Take this DRATINI"
	line "as proof that I"

	para "have recognized"
	line "your worth."
endc

	done

DragonShrinePlayerReceivedDratiniText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "MINIDRACO!"
else
	text "<PLAYER> received"
	line "DRATINI!"
endc

	done

DragonShrinePartyFullText: 
if DEF(_FR_FR)
	text "Hmm? Ton équipe"
	line "est pleine."
else
	text "Hm? Your #MON"
	line "party is full."
endc

	done

DragonShrineSymbolicDragonText: 
if DEF(_FR_FR)
	text "Les #MON dra-"
	line "gons représentent"
	cont "notre clan."

	para "Tu es digne d'en"
	line "posséder un."
else
	text "Dragon #MON are"
	line "symbolic of our"
	cont "clan."

	para "You have shown"
	line "that you can be"

	para "entrusted with"
	line "one."
endc

	done

DragonShrineClairsGrandfatherText: 
if DEF(_FR_FR)
	text "SANDRA a appris"
	line "quelque chose en"
	cont "te connaissant."

	para "Etant son grand-"
	line "père, je te"
	cont "remercie."
else
	text "CLAIR appears to"
	line "have learned an"

	para "invaluable lesson"
	line "from you."

	para "I thank you as her"
	line "grandfather."
endc

	done

DragonShrineSilverIsInTrainingText: 
if DEF(_FR_FR)
	text "Un garçon de ton"
	line "âge s'entraîne"
	cont "ici."

	para "Il est comme l'é-"
	line "tait SANDRA plus"

	para "jeune. Je suis"
	line "très inquiet..."
else
	text "A boy close to"
	line "your age is in"
	cont "training here."

	para "He is much like"
	line "CLAIR when she was"

	para "younger. It is a"
	line "little worrisome…"
endc

	done

DragonShrineWrongAnswerText1: 
if DEF(_FR_FR)
	text "Hein? J'ai pas"
	line "tout compris..."
else
	text "Hah? I didn't"
	line "quite catch that…"
endc

	done

DragonShrineWrongAnswerText2: 
if DEF(_FR_FR)
	text "Qu'as-tu dit?"
else
	text "What was it you"
	line "said?"
endc

	done

DragonShrineRightAnswerText: 
if DEF(_FR_FR)
	text "Oh, je vois..."
else
	text "Oh, I understand…"
endc

	done

DragonShrineElder2Text: 
if DEF(_FR_FR)
	text "Cela fait long-"
	line "temps que notre"

	para "MAITRE n'a pas"
	line "cautionné un"
	cont "dresseur."

	para "Pas une seule fois"
	line "depuis PETER."
else
	text "It's been quite"
	line "some time since a"

	para "trainer has gained"
	line "our MASTER's rare"
	cont "approval."

	para "In fact, not since"
	line "Master LANCE."
endc

	done

DragonShrineElder3Text: 
if DEF(_FR_FR)
	text "Tu connais"
	line "Maître PETER?"

	para "Il ressemble à"
	line "notre MAITRE étant"
	cont "jeune."

	para "C'est dans leur"
	line "sang."
else
	text "You know young"
	line "Master LANCE?"

	para "He looks so much"
	line "like our MASTER"
	cont "did in his youth."

	para "It's in their"
	line "blood."
endc

	done

DragonShrineClairYouPassedText: 
if DEF(_FR_FR)
	text "Comment c'était?"

	para "Je ne vois pas"
	line "pourquoi je deman-"
	cont "de..."

	para "Tu as échoué,"
	line "n'est-ce pas?"

	para "<……><……><……><……><……><……>"

	para "...Quoi? Réussi?"
else
	text "So how did it go?"

	para "I guess there's no"
	line "point in asking."

	para "You did fail?"

	para "<……><……><……><……><……><……>"

	para "…What? You passed?"
endc

	done

DragonShrineClairThatCantBeText: 
if DEF(_FR_FR)
	text "Y'a maldonne!"
else
	text "That can't be!"
endc

	done

DragonShrineClairYoureLyingText: 
if DEF(_FR_FR)
	text "Tu mens!"

	para "Même moi j'ai pas"
	line "réussi!"
else
	text "You're lying!"

	para "Even I haven't"
	line "been approved!"
endc

	done

DragonShrineIUnderstandText: 
if DEF(_FR_FR)
	text "Je... Je vois."
else
	text "I-I understand…"
endc

	done

DragonShrineHereRisingBadgeText: 
if DEF(_FR_FR)
	text "Tiens, voilà le"
	line "BADGE LEVER..."

	para "Allez! Prends-le!"
else
	text "Here, this is the"
	line "RISINGBADGE…"

	para "Hurry up! Take it!"
endc

	done

DragonShrinePlayerReceivedRisingBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE LEVER."
else
	text "<PLAYER> received"
	line "RISINGBADGE."
endc

	done

Obey100: ; TO TRANSLATE
	text "With this last"
	line "badge, all #MON"
	cont "will recognize you"
	
	para "as a trainer and"
	line "obey your every"
	
	para "command without"
	line "question."
	done

DragonShrineSpeechlessText: 
if DEF(_FR_FR)
	text "<……><……><……><……><……><……>"
else
	text "<……><……><……><……><……><……>"
endc

	done

DragonShrine_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  9, DRAGONS_DEN_B1F, 2
	warp_event  5,  9, DRAGONS_DEN_B1F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonShrineElder1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	object_event  2,  5, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonShrineElder2Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	object_event  7,  5, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonShrineElder3Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	object_event  3,  9, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGON_SHRINE_CLAIR
