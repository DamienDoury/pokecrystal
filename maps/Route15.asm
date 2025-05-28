	object_const_def
	const ROUTE15_YOUNGSTER1
	const ROUTE15_YOUNGSTER2
	const ROUTE15_YOUNGSTER3
	const ROUTE15_YOUNGSTER4
	const ROUTE15_TEACHER1
	const ROUTE15_TEACHER2
	const ROUTE15_POKE_BALL
	const ROUTE15_FRUIT_TREE

Route15_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerTeacherColette:
	trainer TEACHER, COLETTE, EVENT_BEAT_TEACHER_COLETTE, TeacherColetteSeenText, TeacherColetteBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TeacherColetteAfterBattleText
	waitbutton
	closetext
	end

TrainerTeacherHillary:
	trainer TEACHER, HILLARY, EVENT_BEAT_TEACHER_HILLARY, TeacherHillarySeenText, TeacherHillaryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TeacherHillaryAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyKipp:
	trainer SCHOOLBOY, KIPP, EVENT_BEAT_SCHOOLBOY_KIP, SchoolboyKippSeenText, SchoolboyKippBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyKippAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyTommy:
	trainer SCHOOLBOY, TOMMY, EVENT_BEAT_SCHOOLBOY_TOMMY, SchoolboyTommySeenText, SchoolboyTommyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyTommyAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyJohnny:
	trainer SCHOOLBOY, JOHNNY, EVENT_BEAT_SCHOOLBOY_JOHNNY, SchoolboyJohnnySeenText, SchoolboyJohnnyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyJohnnyAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyBilly:
	trainer SCHOOLBOY, BILLY, EVENT_BEAT_SCHOOLBOY_BILLY, SchoolboyBillySeenText, SchoolboyBillyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyBillyAfterBattleText
	waitbutton
	closetext
	end

Route15Sign:
	jumptext Route15SignText

Route15PPUp:
	itemball PP_UP

Route15FruitTree:
	fruittree FRUITTREE_ROUTE_15

TeacherColetteSeenText: 
if DEF(_FR_FR)
	text "Il est où ton"
	line "cahier?"
	cont "Et ta trousse?"
else
	text "Have you forgotten"
	line "anything?"
endc

	done

TeacherColetteBeatenText: 
if DEF(_FR_FR)
	text "Kyaaah!"
else
	text "Kyaaah!"
endc

	done

TeacherColetteAfterBattleText: 
if DEF(_FR_FR)
	text "Etre professeur ça"
	line "laisse des traces."
else
	text "Before I became a"
	line "teacher, I used to"

	para "forget a lot of"
	line "things."
endc

	done

TeacherHillarySeenText: 
if DEF(_FR_FR)
	text "Avoir son matériel"
	line "est important."

	para "Comme les dictées"
	line "et les devoirs."
else
	text "On sunny days, I"
	line "think that the"

	para "kids would rather"
	line "be playing in the"

	para "schoolyard than"
	line "studying in class."
endc

	done

TeacherHillaryBeatenText: 
if DEF(_FR_FR)
	text "Perdre c'est mal."
	line "Pfff..."
else
	text "I didn't want to"
	line "lose…"
endc

	done

TeacherHillaryAfterBattleText: 
if DEF(_FR_FR)
	text "Un esprit sain"
	line "dans un corps"
	cont "sain..."
else
	text "Studying is impor-"
	line "tant, but exercise"
	cont "is just as vital."
endc

	done

SchoolboyKippSeenText: 
if DEF(_FR_FR)
	text "Un p'tit combat"
	line "et j'appelle ma"
	cont "maman."
else
	text "Hang on. I have to"
	line "phone my mom."
endc

	done

SchoolboyKippBeatenText: 
if DEF(_FR_FR)
	text "Allô maman?"
	line "J'ai perdu!"
else
	text "Sorry, Mom!"
	line "I was beaten!"
endc

	done

SchoolboyKippAfterBattleText: 
if DEF(_FR_FR)
	text "Maman s'inquiète"
	line "beaucoup pour moi."

	para "Alors je dois lui"
	line "téléphoner..."
else
	text "My mom worries so"
	line "much about me, I"

	para "have to phone her"
	line "all the time."
endc

	done

SchoolboyTommySeenText: 
if DEF(_FR_FR)
	text "COOOOMBAAAAT!"
	line "HA HA HA HA!"
else
	text "Let's battle."
	line "I won't lose!"
endc

	done

SchoolboyTommyBeatenText: 
if DEF(_FR_FR)
	text "Heu..."
	line "Copain?"
else
	text "I forgot to do my"
	line "homework!"
endc

	done

SchoolboyTommyAfterBattleText: 
if DEF(_FR_FR)
	text "Trop fort!"
	line "On devient potes?"
	cont "Allez!!!"
else
	text "Sayonara! I just"
	line "learned that in my"
	cont "Japanese class."
endc

	done

SchoolboyJohnnySeenText: 
if DEF(_FR_FR)
	text "On va étudier à la"
	line "TOUR RADIO de"

	para "LAVANVILLE..."
	line "Génial, non?"
else
	text "We're on a field"
	line "trip to LAVENDER"

	para "RADIO TOWER for"
	line "social studies."
endc

	done

SchoolboyJohnnyBeatenText: 
if DEF(_FR_FR)
	text "T'es pas sympa,"
	line "toi!"
else
	text "You're wickedly"
	line "tough!"
endc

	done

SchoolboyJohnnyAfterBattleText: 
if DEF(_FR_FR)
	text "Marcher c'est"
	line "crevant..."
	cont "Je fais une pause."
else
	text "I'm tired of walk-"
	line "ing. I need to"
	cont "take a break."
endc

	done

SchoolboyBillySeenText: 
if DEF(_FR_FR)
	text "J'aime la purée!"
	line "Combat!"
else
	text "My favorite class"
	line "is gym!"
endc

	done

SchoolboyBillyBeatenText: 
if DEF(_FR_FR)
	text "...."
	line "Super."
else
	text "Oh, no!"
	line "How could I lose?"
endc

	done

SchoolboyBillyAfterBattleText: 
if DEF(_FR_FR)
	text "J'aime le lard et"
	line "le jambon, et tout"
	cont "ce qu'il y a dans"
	cont "le cochon!"
else
	text "If #MON were a"
	line "subject at school,"
	cont "I'd be the best!"
endc

	done

Route15SignText: 
if DEF(_FR_FR)
	text "ROUTE 15"

	para "PARMANIE -"
	line "LAVANVILLE"
else
	text "ROUTE 15"

	para "FUCHSIA CITY -"
	line "LAVENDER TOWN"
endc

	done

Route15_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  4, ROUTE_15_FUCHSIA_GATE, 3
	warp_event  2,  5, ROUTE_15_FUCHSIA_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 23, 13, BGEVENT_READ, Route15Sign

	def_object_events
	object_event 12, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSchoolboyKipp, -1
	object_event 16, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyTommy, -1
	object_event 34,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyJohnny, -1
	object_event 29, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyBilly, -1
	object_event 34, 15, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerTeacherColette, -1
	object_event 21, 12, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerTeacherHillary, -1
	object_event 21,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route15PPUp, EVENT_ROUTE_15_PP_UP
	object_event 32,  9, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route15FruitTree, -1
