	object_const_def
	const TRAINERHOUSEB1F_RECEPTIONIST
	const TRAINERHOUSEB1F_CHRIS

TrainerHouseB1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerHouseReceptionistScript:
	turnobject PLAYER, UP
	opentext
	checkflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	iftrue .FoughtTooManyTimes
	writetext TrainerHouseB1FIntroText
	promptbutton
	special TrainerHouse
	iffalse .GetCal3Name
	gettrainername STRING_BUFFER_3, CAL, CAL2
	sjump .GotName

.GetCal3Name:
	gettrainername STRING_BUFFER_3, CAL, CAL3
.GotName:
	writetext TrainerHouseB1FYourOpponentIsText
	promptbutton
	writetext TrainerHouseB1FAskWantToBattleText
	yesorno
	iffalse .Declined
	setflag ENGINE_FOUGHT_IN_TRAINER_HALL_TODAY
	writetext TrainerHouseB1FGoRightInText
	waitbutton
	closetext
	applymovement PLAYER, Movement_EnterTrainerHouseBattleRoom
	opentext
	writetext TrainerHouseB1FCalBeforeText
	waitbutton
	closetext
	special TrainerHouse
	iffalse .NoSpecialBattle
	winlosstext TrainerHouseB1FCalBeatenText, 0
	setlasttalked TRAINERHOUSEB1F_CHRIS
	loadtrainer CAL, CAL2
	startbattle
	reloadmapafterbattle
	iffalse .End
.NoSpecialBattle:
	winlosstext TrainerHouseB1FCalBeatenText, 0
	setlasttalked TRAINERHOUSEB1F_CHRIS
	loadtrainer CAL, CAL3
	startbattle
	reloadmapafterbattle
.End:
	applymovement PLAYER, Movement_ExitTrainerHouseBattleRoom
	end

.Declined:
	writetext TrainerHouseB1FPleaseComeAgainText
	waitbutton
	closetext
	applymovement PLAYER, Movement_TrainerHouseTurnBack
	end

.FoughtTooManyTimes:
	writetext TrainerHouseB1FSecondChallengeDeniedText
	waitbutton
	closetext
	applymovement PLAYER, Movement_TrainerHouseTurnBack
	end

Movement_EnterTrainerHouseBattleRoom:
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	turn_head RIGHT
	step_end

Movement_ExitTrainerHouseBattleRoom:
	step UP
	step UP
	step UP
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

Movement_TrainerHouseTurnBack:
	step RIGHT
	turn_head LEFT
	step_end

TrainerHouseB1FIntroText: 
if DEF(_FR_FR)
	text "Bienvenue au HALL"
	line "d'ENTRAINEMENT."

	para "On peut y affron-"
	line "ter un adversaire"
	cont "par jour."
else
	text "Hi. Welcome to our"
	line "TRAINING HALL."

	para "You may battle a"
	line "trainer once per"
	cont "day."
endc

	done

TrainerHouseB1FYourOpponentIsText: 
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text " est"
	line "l'adversaire du"
	cont "jour."
else
	text_ram wStringBuffer3
	text " is your"
	line "opponent today."
endc

	done

TrainerHouseB1FAskWantToBattleText: 
if DEF(_FR_FR)
	text "Voulez-vous com-"
	line "battre?"
else
	text "Would you like to"
	line "battle?"
endc

	done

TrainerHouseB1FGoRightInText: 
if DEF(_FR_FR)
	text "Passez s'il vous"
	line "plaît."

	para "Vous pouvez com-"
	line "mencer tout de"
	cont "suite."
else
	text "Please go right"
	line "through."

	para "You may begin"
	line "right away."
endc

	done

TrainerHouseB1FPleaseComeAgainText: 
if DEF(_FR_FR)
	text "Seuls les dres-"
	line "seurs allant com-"

	para "battre sont auto-"
	line "risés à entrer."
else
	text "Sorry. Only those"
	line "trainers who will"

	para "be battling are"
	line "allowed to go in."
endc

	done

TrainerHouseB1FSecondChallengeDeniedText: 
if DEF(_FR_FR)
	text "Excusez-moi! Vous"
	line "ne pouvez entrer"

	para "qu'une fois par"
	line "jour!"
else
	text "I'm sorry."
	line "This would be your"

	para "second time today."
	line "You're permitted"

	para "to enter just once"
	line "a day."
endc

	done

TrainerHouseB1FCalBeatenText: 
if DEF(_FR_FR)
	text "Perdu..."
	line "Et zut..."
else
	text "I lost…"
	line "Darn…"
endc

	done

TrainerHouseB1FCalBeforeText: 
if DEF(_FR_FR)
	text "J'ai voyagé jus-"
	line "qu'ici pour t'af-"
	cont "fronter."
else
	text "I traveled out"
	line "here just so I"
	cont "could battle you."
endc

	done

TrainerHouseB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  4, TRAINER_HOUSE_1F, 3

	def_coord_events
	coord_event  7,  3, CE_SCENE_ID, SCENE_ALWAYS, TrainerHouseReceptionistScript

	def_bg_events

	def_object_events
	object_event  7,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  6, 11, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
