	object_const_def
	const GOLDENRODMAGNETTRAINSTATION_OFFICER
	const GOLDENRODMAGNETTRAINSTATION_GENTLEMAN

GoldenrodMagnetTrainStation_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodMagnetTrainStationOfficerScript:
	faceplayer
	opentext
	
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .NoPower

	writetext GoldenrodMagnetTrainStationOfficerAreYouComingAboardText
	yesorno
	iffalse .DecidedNotToRide

	checkitem PASS
	iffalse .PassNotInBag

	writetext GoldenrodMagnetTrainStationOfficerShowRailPassText
	
	farscall OlivinePortBoardingCheck.VaccinePassportCheckStart
	iffalse .skip ; When the previous script returns false, it also closes the text.

	promptbutton
	writetext GoldenrodMagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext

	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, GoldenrodMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval FALSE
	special MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, .MovementBoardTheTrain
	wait 20
.skip
	end

.NoPower:
	writetext GoldenrodMagnetTrainStationOfficerTheTrainHasntComeInText
	waitbutton
	closetext
	end

.MovementBoardTheTrain:
	turn_head DOWN
	step_end

.PassNotInBag:
	writetext GoldenrodMagnetTrainStationOfficerYouDontHaveARailPassText
	waitbutton
	closetext
	end

.DecidedNotToRide:
	farwritetext NurseGoodbyeText
	waitbutton
	closetext
	end

Script_ArriveFromSaffron:
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, GoldenrodMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, GoldenrodMagnetTrainStationOfficerReturnToBoardingGateMovement
	opentext
	writetext GoldenrodMagnetTrainStationOfficerArrivedInGoldenrodText
	promptbutton
	farwritetext NurseGoodbyeText
	waitbutton
	closetext
	end

GoldenrodMagnetTrainStationGentlemanScript:
	jumptextfaceplayer GoldenrodMagnetTrainStationGentlemanText

GoldenrodMagnetTrainStationTwinScript:
	jumptextfaceplayer GoldenrodMagnetTrainStationTwinText

GoldenrodMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

GoldenrodMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

GoldenrodMagnetTrainStationPlayerApproachAndEnterTrainMovement:
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

GoldenrodMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

GoldenrodMagnetTrainStationOfficerTheTrainHasntComeInText: ; TO TRANSLATE
	text "The train is shut"
	line "down while the"
	cont "travel restriction"
	cont "remains effective."
	done

GoldenrodMagnetTrainStationOfficerAreYouComingAboardText: 
if DEF(_FR_FR)
	text "Nous allons bien-"
	line "tôt partir pour"
	cont "SAFRANIA."

	para "Vous montez"
	line "à bord?"
else
	text "We'll soon depart"
	line "for SAFFRON."

	para "Are you coming"
	line "aboard?"
endc

	done

GoldenrodMagnetTrainStationOfficerShowRailPassText: ; TO TRANSLATE
	text "May I see your"
	line "RAIL PASS, please?"

	para "…"

	para "Looks good to me."
	done
	
GoldenrodMagnetTrainStationOfficerRightThisWayText: ; TO TRANSLATE
	text "Right this way,"
	line "please."
	done

GoldenrodMagnetTrainStationOfficerYouDontHaveARailPassText: ; TO TRANSLATE
	text "Sorry. You don't"
	line "have a RAIL PASS."
	done

GoldenrodMagnetTrainStationOfficerArrivedInGoldenrodText: ; TO TRANSLATE
	text "We have arrived in"
	line "GOLDENROD."
	done

GoldenrodMagnetTrainStationGentlemanText: 
if DEF(_FR_FR)
	text "Je suis le"
	line "PRESIDENT."

	para "Mon rêve était de"
	line "construire un"

	para "train plus rapide"
	line "que n'importe quel"
	cont "#MON."

	para "Cela rapproche"
	line "JOHTO de KANTO."
else
	text "I'm the PRESIDENT."

	para "My dream was to"
	line "build a train that"

	para "is faster than any"
	line "#MON."

	para "It really brings"
	line "JOHTO much closer"
	cont "to KANTO."
endc

	done

GoldenrodMagnetTrainStationTwinText: ; TO TRANSLATE
	text "Being vaccinated"
	line "sounds nice."

	para "I wish I was."
	line "But my parents"
	cont "forbid me."
	done

GoldenrodMagnetTrainStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, GOLDENROD_CITY, 5
	warp_event  9, 17, GOLDENROD_CITY, 5
	warp_event  6,  5, SAFFRON_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, SAFFRON_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, CE_SCENE_ID, SCENE_ALWAYS, Script_ArriveFromSaffron

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationOfficerScript, -1 ; This character can walk, but it'll happen after the clapping period is over. So there's no risk to break its walking animation.
	object_event 11, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 2, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationGentlemanScript, EVENT_TRAIN_STATION_POPULATION
	object_event  6, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationTwinScript, EVENT_TRAIN_STATION_POPULATION
