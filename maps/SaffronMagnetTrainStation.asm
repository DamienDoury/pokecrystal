	object_const_def
	const SAFFRONMAGNETTRAINSTATION_OFFICER
	const SAFFRONMAGNETTRAINSTATION_GYM_GUIDE
	const SAFFRONMAGNETTRAINSTATION_TEACHER
	const SAFFRONMAGNETTRAINSTATION_LASS

SaffronMagnetTrainStation_MapScripts:
	def_scene_scripts

	def_callbacks

SaffronMagnetTrainStationOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .NoPower

	writetext SaffronMagnetTrainStationOfficerAreYouComingOnBoardText
	yesorno
	iffalse .DecidedNotToRide

	checkitem PASS
	iffalse .PassNotInBag

	farwritetext GoldenrodMagnetTrainStationOfficerShowRailPassText

	farscall OlivinePortBoardingCheck.VaccinePassportCheckStart
	iffalse .skip ; When the previous script returns false, it also closes the text.

	promptbutton
	farwritetext GoldenrodMagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext

	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval TRUE
	special MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, .MovementBoardTheTrain
	wait 20
.skip
	end
	
.NoPower:
	writetext SaffronMagnetTrainStationOfficerTrainIsntOperatingText
	waitbutton
	closetext
	end

.MovementBoardTheTrain:
	turn_head DOWN
	step_end

.PassNotInBag:
	farwritetext GoldenrodMagnetTrainStationOfficerYouDontHaveARailPassText
	waitbutton
	closetext
	end

.DecidedNotToRide:
	farwritetext NurseGoodbyeText
	waitbutton
	closetext
	end

Script_ArriveFromGoldenrod:
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement
	opentext
	writetext SaffronMagnetTrainStationOfficerArrivedInSaffronText
	promptbutton
	farwritetext NurseGoodbyeText
	waitbutton
	closetext
	end

SaffronMagnetTrainStationGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext SaffronMagnetTrainStationGymGuideText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart
	waitbutton
	closetext
	end

SaffronMagnetTrainStationTeacherScript:
	jumptextfaceplayer SaffronMagnetTrainStationTeacherText

SaffronMagnetTrainStationLassScript:
	jumptextfaceplayer SaffronMagnetTrainStationLassText

SaffronMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

SaffronMagnetTrainStationOfficerTrainIsntOperatingText:
if DEF(_FR_FR)
	text "Désolé, mais le"
	line "TRAIN MAGNET ne"
	cont "peut pas circuler"
	cont "sans électricité."
else
	text "I'm sorry, but the"
	line "MAGNET TRAIN can't"
	cont "operate without"
	cont "power."
endc
	done

SaffronMagnetTrainStationOfficerAreYouComingOnBoardText: 
if DEF(_FR_FR)
	text "Nous partons bien-"
	line "tôt pour DOUBLON-"
	cont "VILLE."

	para "Veux-tu monter"
	line "à bord?"
else
	text "We'll soon depart"
	line "for GOLDENROD."

	para "Are you coming on"
	line "board?"
endc

	done

SaffronMagnetTrainStationOfficerArrivedInSaffronText:
if DEF(_FR_FR)
	text "Nous sommes arri-"
	line "vés à SAFRANIA."
else
	text "We have arrived in"
	line "SAFFRON."
endc
	done

SaffronMagnetTrainStationGymGuideText: 
if DEF(_FR_FR)
	text "Le TRAIN MAGNET"
	line "est un train super"

	para "moderne qui utili-"
	line "se l'énergie"

	para "magnétique pour"
	line "aller à toute"
	cont "vitesse."

	para "Mais sans électri-"
	line "cité, il ne bouge"
	cont "pas trop..."
else
	text "The MAGNET TRAIN"
	line "is a super-modern"

	para "rail liner that"
	line "uses electricity"

	para "and magnets to"
	line "attain incredible"
	cont "speed."

	para "However, if there"
	line "isn't any elec-"
	cont "tricity…"
endc

	done

SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "Fouiii..."

	para "Combien de fois"
	line "ai-je fait la na-"

	para "vette entre KANTO"
	line "et JOHTO? J'en"
	cont "sais rien, moi!"
else
	text "Whew…"

	para "How many times"
	line "have I gone back"

	para "and forth between"
	line "KANTO and JOHTO?"
endc

	done

SaffronMagnetTrainStationTeacherText: 
if DEF(_FR_FR)
	text "Il y avait une"
	line "maison avant la"

	para "construction de la"
	line "STATION de TRAIN."

	para "Une petite fille,"
	line "appelée COPIEUSE,"
	cont "y vivait."
else
	text "Before the MAGNET"
	line "TRAIN STATION was"

	para "built, there was a"
	line "house there."

	para "A little girl"
	line "named COPYCAT used"
	cont "to live there."
endc

	done

SaffronMagnetTrainStationLassText:
if DEF(_FR_FR)
	text "Bonjour. As-tu un"
	line "PASSE TRAIN?"

	para "Moi j'en ai un!"
	line "Tous ceux de SA-"

	para "FRANIA qui utili-"
	line "sent le TRAIN"
	cont "MAGNET en ont un."
else
	text "Hi. Do you have a"
	line "RAIL PASS? I have"

	para "one. All the peo-"
	line "ple in SAFFRON who"

	para "ride the MAGNET"
	line "TRAIN have PASSES."
endc
	done

SaffronMagnetTrainStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 6
	warp_event  9, 17, SAFFRON_CITY, 6
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, CE_SCENE_ID, SCENE_ALWAYS, Script_ArriveFromGoldenrod

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationOfficerScript, -1
	object_event 10, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationGymGuideScript, -1
	object_event  6, 13, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationTeacherScript, EVENT_TRAIN_STATION_POPULATION
	object_event  6, 11, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationLassScript, EVENT_TRAIN_STATION_POPULATION
