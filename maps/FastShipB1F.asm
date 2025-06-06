	object_const_def
	const FASTSHIPB1F_SAILOR1
	const FASTSHIPB1F_SAILOR2
	const FASTSHIPB1F_SAILOR3
	const FASTSHIPB1F_LASS
	const FASTSHIPB1F_SUPER_NERD
	const FASTSHIPB1F_SAILOR4
	const FASTSHIPB1F_FISHER
	const FASTSHIPB1F_BLACK_BELT
	const FASTSHIPB1F_SAILOR5
	const FASTSHIPB1F_TEACHER
	const FASTSHIPB1F_YOUNGSTER1
	const FASTSHIPB1F_YOUNGSTER2

FastShipB1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks

.DummyScene0:
	end

.DummyScene1:
	end

FastShipB1FSailorBlocksLeft:
	checkevent EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	iftrue FastShipB1FAlreadyBlocked
	applymovement FASTSHIPB1F_SAILOR2, FastShipB1FSailorBlocksLeftMovement
	moveobject FASTSHIPB1F_SAILOR1, 30, 6
	appear FASTSHIPB1F_SAILOR1
	pause 5
	disappear FASTSHIPB1F_SAILOR2
	end

FastShipB1FSailorBlocksRight:
	checkevent EVENT_FAST_SHIP_B1F_SAILOR_LEFT
	iftrue FastShipB1FAlreadyBlocked
	applymovement FASTSHIPB1F_SAILOR1, FastShipB1FSailorBlocksRightMovement
	moveobject FASTSHIPB1F_SAILOR2, 31, 6
	appear FASTSHIPB1F_SAILOR2
	pause 5
	disappear FASTSHIPB1F_SAILOR1
	end

FastShipB1FAlreadyBlocked:
	end

FastShipB1FSailorScript:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .FirstTime
	checkevent EVENT_FAST_SHIP_LAZY_SAILOR
	iftrue .LazySailor
	checkevent EVENT_FAST_SHIP_INFORMED_ABOUT_LAZY_SAILOR
	iftrue .AlreadyInformed
	writetext FastShipB1FOnDutySailorText
	waitbutton
	closetext
	setevent EVENT_FAST_SHIP_INFORMED_ABOUT_LAZY_SAILOR
	clearevent EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	end

.AlreadyInformed:
	writetext FastShipB1FOnDutySailorRefusedText
	waitbutton
	closetext
	end

.LazySailor:
	writetext FastShipB1FOnDutySailorThanksText
	checkevent EVENT_FAST_SHIP_FOUND_GIRL
	iffalse .NotFoundGirl
	waitbutton
	closetext
	end

.NotFoundGirl:
	promptbutton
	writetext FastShipB1FOnDutySailorSawLittleGirlText
	waitbutton
	closetext
	end

.FirstTime:
	writetext FastShipB1FOnDutySailorDirectionsText
	waitbutton
	closetext
	end

TrainerSailorJeff:
	trainer SAILOR, JEFF, EVENT_BEAT_SAILOR_JEFF, SailorJeffSeenText, SailorJeffBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorJeffAfterBattleText

TrainerPicnickerDebra:
	trainer PICNICKER, DEBRA, EVENT_BEAT_PICNICKER_DEBRA, PicnickerDebraSeenText, PicnickerDebraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PicnickerDebraAfterBattleText

TrainerJugglerFritz:
	trainer JUGGLER, FRITZ, EVENT_BEAT_JUGGLER_FRITZ, JugglerFritzSeenText, JugglerFritzBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer JugglerFritzAfterBattleText

TrainerSailorGarrett:
	trainer SAILOR, GARRETT, EVENT_BEAT_SAILOR_GARRETT, SailorGarrettSeenText, SailorGarrettBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorGarrettAfterBattleText

TrainerFisherJonah:
	trainer FISHER, JONAH, EVENT_BEAT_FISHER_JONAH, FisherJonahSeenText, FisherJonahBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherJonahAfterBattleText

TrainerBlackbeltWai:
	trainer BLACKBELT_T, WAI, EVENT_BEAT_BLACKBELT_WAI, BlackbeltWaiSeenText, BlackbeltWaiBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BlackbeltWaiAfterBattleText

TrainerSailorKenneth:
	trainer SAILOR, KENNETH, EVENT_BEAT_SAILOR_KENNETH, SailorKennethSeenText, SailorKennethBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorKennethAfterBattleText

TrainerTeacherShirley:
	trainer TEACHER, SHIRLEY, EVENT_BEAT_TEACHER_SHIRLEY, TeacherShirleySeenText, TeacherShirleyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TeacherShirleyAfterBattleText

TrainerSchoolboyNate:
	trainer SCHOOLBOY, NATE, EVENT_BEAT_SCHOOLBOY_NATE, SchoolboyNateSeenText, SchoolboyNateBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyNateAfterBattleText

TrainerSchoolboyRicky:
	trainer SCHOOLBOY, RICKY, EVENT_BEAT_SCHOOLBOY_RICKY, SchoolboyRickySeenText, SchoolboyRickyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyRickyAfterBattleText

FastShipB1FTrashcan:
	jumpstd TrashCanScript

FastShipB1FSailorBlocksRightMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	turn_head DOWN
	step_end

FastShipB1FSailorBlocksLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	turn_head DOWN
	step_end

FastShipB1FOnDutySailorText: 
if DEF(_FR_FR)
	text "Hé toi. Tu peux"
	line "chercher mon pote"
	cont "pour moi?"

	para "Il se balade dans"
	line "le coin. Toujours"
	cont "à rien faire!"

	para "J'aimerais le"
	line "trouver mais moi"
	cont "j'ai du taf."
else
	text "Hey, kid. Could I"
	line "get you to look"
	cont "for my buddy?"

	para "He's goofing off"
	line "somewhere, that"
	cont "lazy bum!"

	para "I want to go find"
	line "him, but I'm on"
	cont "duty right now."
endc

	done

FastShipB1FOnDutySailorRefusedText: 
if DEF(_FR_FR)
	text "Oh, ben..."

	para "Le CAPITAINE va"
	line "être furax..."
else
	text "Oh, gee…"

	para "The CAPTAIN will"
	line "be furious…"
endc

	done

FastShipB1FOnDutySailorThanksText: 
if DEF(_FR_FR)
	text "Merci toi!"
	line "J'lui ai passé un"

	para "savon des familles"
	line "et il va bosser"
	cont "maintenant."
else
	text "Thanks, kid!"
	line "I chewed him out"

	para "good so he'll quit"
	line "slacking off!"
endc

	done

FastShipB1FOnDutySailorSawLittleGirlText: 
if DEF(_FR_FR)
	text "Une fillette?"

	para "Je crois l'avoir"
	line "vue passer."
else
	text "A little girl?"

	para "I may have seen"
	line "her go by here."
endc

	done

FastShipB1FOnDutySailorDirectionsText: 
if DEF(_FR_FR)
	text "La salle à manger"
	line "est tout droit."

	para "Les escaliers au"
	line "bout mènent à la"
	cont "cabine du"
	cont "CAPITAINE."
else
	text "The dining room is"
	line "up ahead."

	para "The stairs at the"
	line "end lead to the"
	cont "CAPTAIN's cabin."
endc

	done

SailorJeffSeenText: 
if DEF(_FR_FR)
	text "Y'a rien de tel"
	line "qu'un combat pen-"
	cont "dant la pause."
else
	text "Nothing beats a"
	line "battle when I'm"
	cont "on my break."
endc

	done

SailorJeffBeatenText: 
if DEF(_FR_FR)
	text "Finie la pause!"
else
	text "Win or lose, my"
	line "break's over!"
endc

	done

SailorJeffAfterBattleText: 
if DEF(_FR_FR)
	text "Faut que je m'en-"
	line "traîne sérieux"
	cont "pour progresser."
else
	text "I guess I can't"
	line "win if I don't get"
	cont "serious."
endc

	done

PicnickerDebraSeenText: 
if DEF(_FR_FR)
	text "J'm'ennuie."
	line "...Combat?"
else
	text "I'm so bored."
	line "Want to battle?"
endc

	done

PicnickerDebraBeatenText: 
if DEF(_FR_FR)
	text "Woah. Cool."
else
	text "Yow! You're too"
	line "strong!"
endc

	done

PicnickerDebraAfterBattleText: 
if DEF(_FR_FR)
	text "SAFRANIA, CELADO-"
	line "POLE... On dit"

	para "qu'il y a plein"
	line "de grandes villes"
	cont "à KANTO."
else
	text "SAFFRON, CELADON…"
	line "I hear there are"

	para "many big cities"
	line "in KANTO."
endc

	done

JugglerFritzSeenText: 
if DEF(_FR_FR)
	text "Beuh..... J'ai"
	line "le mal de mer!"
else
	text "Urrf…"
	line "I'm seasick!"
endc

	done

JugglerFritzBeatenText: 
if DEF(_FR_FR)
	text "J'peux plus"
	line "bouger..."
else
	text "I can't move any-"
	line "more…"
endc

	done

JugglerFritzAfterBattleText: 
if DEF(_FR_FR)
	text "La mer c'est fini"
	line "pour moi. Je vais"

	para "prendre le TRAIN"
	line "MAGNET la prochai-"
	cont "ne fois."
else
	text "No more ships for"
	line "me. Next time,"

	para "I'm taking the"
	line "MAGNET TRAIN."
endc

	done

SailorGarrettSeenText: 
if DEF(_FR_FR)
	text "Nous les marins,"
	line "on rigole pas!"
else
	text "This is where we"
	line "sailors work!"
endc

	done

SailorGarrettBeatenText: 
if DEF(_FR_FR)
	text "Ha ha ha ha ha."
	line "Perdu."
else
	text "I lost on my home"
	line "field…"
endc

	done

SailorGarrettAfterBattleText: 
if DEF(_FR_FR)
	text "Les passagers"
	line "sont de CARMIN"

	para "SUR MER et aussi"
	line "d'OLIVILLE."
else
	text "We get different"
	line "passengers from"

	para "VERMILION CITY to"
	line "OLIVINE CITY."
endc

	done

FisherJonahSeenText: 
if DEF(_FR_FR)
	text "On est en mer"
	line "mais on peut pas"
	cont "pêcher!"

	para "C'est naze!"
	line "Allez...COMBAT!"
else
	text "Even though we're"
	line "out on the sea, I"
	cont "can't fish!"

	para "This is boring!"
	line "Let's battle!"
endc

	done

FisherJonahBeatenText: 
if DEF(_FR_FR)
	text "T'es naze..."
	line "J't'aime pas."
else
	text "I… I'm not bored"
	line "anymore…"
endc

	done

FisherJonahAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais pêcher au"
	line "port de CARMIN."
else
	text "I plan to fish off"
	line "VERMILION's pier."
endc

	done

BlackbeltWaiSeenText: 
if DEF(_FR_FR)
	text "Je me muscle les"
	line "jambes avec le"
	cont "tangage du bateau!"
else
	text "I'm building up my"
	line "legs by bracing"

	para "against the ship's"
	line "rocking!"
endc

	done

BlackbeltWaiBeatenText: 
if DEF(_FR_FR)
	text "Je me suis"
	line "tout planté!"
else
	text "Rocked and rolled"
	line "over!"
endc

	done

BlackbeltWaiAfterBattleText: 
if DEF(_FR_FR)
	text "Je n'ai pas trouvé"
	line "le ROI du KARATE à"
	cont "JOHTO."

	para "On dit qu'il s'en-"
	line "traîne dans une"
	cont "caverne."
else
	text "I couldn't find"
	line "the KARATE KING in"
	cont "JOHTO."

	para "He's supposed to"
	line "be training in a"
	cont "cave somewhere."
endc

	done

SailorKennethSeenText: 
if DEF(_FR_FR)
	text "J'suis un marin!"

	para "J'entraîne aussi"
	line "des #MON pour"
	cont "devenir un boss!"
else
	text "I'm a sailor man!"

	para "But I'm training"
	line "#MON, so I can"
	cont "become the CHAMP!"
endc

	done

SailorKennethBeatenText: 
if DEF(_FR_FR)
	text "J'suis un nul..."
else
	text "My lack of train-"
	line "ing is obvious…"
endc

	done

SailorKennethAfterBattleText: 
if DEF(_FR_FR)
	text "Tant de BADGES!"
	line "Tu as alors battu"

	para "les CHAMPIONS des"
	line "ARENES..."

	para "Normal que tu sois"
	line "balèze!"
else
	text "Eight BADGES!"
	line "They must prove"

	para "that you've beaten"
	line "GYM LEADERS."

	para "No wonder you're"
	line "so good!"
endc

	done

TeacherShirleySeenText: 
if DEF(_FR_FR)
	text "Touche pas à mes"
	line "élèves!"
else
	text "Don't lay a finger"
	line "on my students!"
endc

	done

TeacherShirleyBeatenText: 
if DEF(_FR_FR)
	text "Aaack!"
else
	text "Aaack!"
endc

	done

TeacherShirleyAfterBattleText: 
if DEF(_FR_FR)
	text "On va tous aux"
	line "RUINES près de"
	cont "MAUVILLE."
else
	text "We're on a field"
	line "trip to the RUINS"
	cont "outside VIOLET."
endc

	done

SchoolboyNateSeenText: 
if DEF(_FR_FR)
	text "Tu connais les"
	line "RUINES d'ALPHA?"
else
	text "Do you know the"
	line "RUINS OF ALPH?"
endc

	done

SchoolboyNateBeatenText: 
if DEF(_FR_FR)
	text "Yaargh!"
else
	text "Yaargh!"
endc

	done

SchoolboyNateAfterBattleText: 
if DEF(_FR_FR)
	text "Les radios captent"
	line "d'étranges signaux"
	cont "dans les RUINES."
else
	text "Radios pick up"
	line "strange signals"
	cont "inside the RUINS."
endc

	done

SchoolboyRickySeenText: 
if DEF(_FR_FR)
	text "Il y a d'étranges"
	line "panneaux dans les"
	cont "RUINES d'ALPHA."
else
	text "There are some odd"
	line "stone panels in"
	cont "the RUINS OF ALPH."
endc

	done

SchoolboyRickyBeatenText: 
if DEF(_FR_FR)
	text "Yaaaaaah!"
else
	text "I was done in!"
endc

	done

SchoolboyRickyAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai lu qu'il y a"
	line "quatre panneaux"
	cont "de pierre."
else
	text "I read that there"
	line "are four of those"
	cont "stone panels."
endc

	done

FastShipB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 11, FAST_SHIP_1F, 11
	warp_event 31, 13, FAST_SHIP_1F, 12

	def_coord_events
	coord_event 30,  7, CE_SCENE_ID, SCENE_DEFAULT, FastShipB1FSailorBlocksLeft
	coord_event 31,  7, CE_SCENE_ID, SCENE_DEFAULT, FastShipB1FSailorBlocksRight

	def_bg_events
	bg_event 27,  9, BGEVENT_READ, FastShipB1FTrashcan

	def_object_events
	object_event 30,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FastShipB1FSailorScript, EVENT_FAST_SHIP_B1F_SAILOR_LEFT
	object_event 31,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FastShipB1FSailorScript, EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	object_event  9, 11, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSailorJeff, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  6,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerDebra, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event 26,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerJugglerFritz, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event 17,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSailorGarrett, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event 25,  8, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherJonah, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event 15, 11, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBlackbeltWai, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event 23,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSailorKenneth, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  9, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerTeacherShirley, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event 14,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSchoolboyNate, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event 14, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSchoolboyRicky, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
