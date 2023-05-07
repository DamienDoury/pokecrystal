	object_const_def
	const VERMILIONPORT_SAILOR1
	const VERMILIONPORT_SAILOR2
	const VERMILIONPORT_SUPER_NERD
	const VERMILIONPORT_SAILOR_TEMP
	const VERMILIONPORT_CAPTAIN

VermilionPort_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .LeaveFastShip ; SCENE_VERMILIONPORT_LEAVE_SHIP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.LeaveFastShip:
	checkflag ENGINE_FLYPOINT_SAFFRON
	iffalse .FirstTime

	prioritysjump .LeaveFastShipScript
	end

.FirstTime
	prioritysjump .LeaveFastShipFirstTimeScript
	end

.FlyPoint:
	disappear VERMILIONPORT_CAPTAIN
	setflag ENGINE_FLYPOINT_VERMILION
	endcallback

.LeaveFastShipFirstTimeScript:
	appear VERMILIONPORT_CAPTAIN
	follow PLAYER, VERMILIONPORT_CAPTAIN
	applymovement PLAYER, VermilionPortLeaveFastShipLongMovement
	applymovement PLAYER, VermilionPortHeadDownMovement
	stopfollow
	moveobject VERMILIONPORT_CAPTAIN, 5, 14
	scall VermilionPortCaptainScript
	sjump .DoEvents

.LeaveFastShipScript:
	applymovement PLAYER, VermilionPortLeaveFastShipMovement
.DoEvents:
	appear VERMILIONPORT_SAILOR1
	setscene SCENE_DEFAULT
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	setevent EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	clearevent EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	setevent EVENT_FAST_SHIP_FIRST_TIME
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod VERMILION_CITY
	end

VermilionPortSailorAtGangwayScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue VermilionPortAlreadyRodeScript
	writetext VermilionPortDepartingText
	waitbutton
	closetext
	turnobject VERMILIONPORT_SAILOR1, DOWN
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONPORT_SAILOR1
	waitsfx
	applymovement PLAYER, VermilionPortEnterFastShipMovement
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	clearevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	clearevent EVENT_BEAT_POKEMANIAC_ETHAN
	clearevent EVENT_BEAT_BURGLAR_COREY
	clearevent EVENT_BEAT_BUG_CATCHER_KEN
	clearevent EVENT_BEAT_GUITARIST_CLYDE
	clearevent EVENT_BEAT_POKEFANM_JEREMY
	clearevent EVENT_BEAT_POKEFANF_GEORGIA
	clearevent EVENT_BEAT_SAILOR_KENNETH
	clearevent EVENT_BEAT_TEACHER_SHIRLEY
	clearevent EVENT_BEAT_SCHOOLBOY_NATE
	clearevent EVENT_BEAT_SCHOOLBOY_RICKY
	setevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear VERMILIONPORT_SAILOR1
	setmapscene FAST_SHIP_1F, SCENE_FASTSHIP1F_ENTER_SHIP
	warp FAST_SHIP_1F, 25, 1
	end

VermilionPortAlreadyRodeScript:
	writetext VermilionPortCantBoardText
	waitbutton
	closetext
	end

VermilionPortWalkUpToShipScript:
	turnobject VERMILIONPORT_SAILOR2, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .skip
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .skip
	turnobject PLAYER, LEFT
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse VermilionPortNoPowerScript 
	
	readvar VAR_BADGES
	ifless 12, TourismIssue
	
	readvar VAR_WEEKDAY
	ifequal MONDAY, .NextShipWednesday
	ifequal TUESDAY, .NextShipWednesday
	ifequal THURSDAY, .NextShipSunday
	ifequal FRIDAY, .NextShipSunday
	ifequal SATURDAY, .NextShipSunday
	writetext VermilionPortAskBoardingText
	yesorno
	iffalse VermilionPortNotRidingMoveAwayScript
	writetext VermilionPortAskTicketText
	promptbutton
	checkitem S_S_TICKET
	iffalse .NoTicket
	writetext VermilionPortSSTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, VermilionPortApproachFastShipMovement
	sjump VermilionPortSailorAtGangwayScript

.NoTicket:
	writetext VermilionPortNoTicketText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

.NextShipWednesday:
	writetext VermilionPortSailMondayText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

.NextShipSunday:
	writetext VermilionPortSailSundayText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

.skip:
	end

TourismIssue:
	writetext LackOfTourismText
	waitbutton
	closetext
	sjump VermilionPortPlayerPushedAway

TourismIssueNoMove:
	writetext LackOfTourismText
	waitbutton
	closetext
	end

VermilionPortNotRidingScript:
	writetext VermilionPortComeAgainText
	waitbutton
	closetext
	end

VermilionPortNotRidingMoveAwayScript:
	writetext VermilionPortComeAgainText
	waitbutton
	closetext
VermilionPortPlayerPushedAway:
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

VermilionPortNoPowerNoMoveScript:
	writetext VermilionPortPowerOutageText
	waitbutton
	closetext
	end

VermilionPortNoPowerScript:
	writetext VermilionPortPowerOutageText
	waitbutton
	closetext
	applymovement PLAYER, VermilionPortCannotEnterFastShipMovement
	end

VermilionPortSailorScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue VermilionPortAlreadyRodeScript
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse VermilionPortNoPowerNoMoveScript ; This counter-intuitive check means the opposite: the power hasn't been restored if the flag is set/true.
	readvar VAR_BADGES
	ifless 12, TourismIssueNoMove
	readvar VAR_WEEKDAY
	ifequal MONDAY, .NextShipWednesday
	ifequal TUESDAY, .NextShipWednesday
	ifequal THURSDAY, .NextShipSunday
	ifequal FRIDAY, .NextShipSunday
	ifequal SATURDAY, .NextShipSunday
	writetext VermilionPortAskBoardingText
	yesorno
	iffalse VermilionPortNotRidingScript
	writetext VermilionPortAskTicketText
	promptbutton
	checkitem S_S_TICKET
	iffalse .NoTicket
	writetext VermilionPortSSTicketText
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, VermilionPortApproachFastShipLeftMovement
	applymovement PLAYER, VermilionPortApproachFastShipMovement
	sjump VermilionPortSailorAtGangwayScript

.NoTicket:
	writetext VermilionPortNoTicketText
	waitbutton
	closetext
	end

.NextShipWednesday:
	writetext VermilionPortSailMondayText
	waitbutton
	closetext
	end

.NextShipSunday:
	writetext VermilionPortSailSundayText
	waitbutton
	closetext
	end

VermilionPortSuperNerdScript:
	faceplayer
	opentext
	writetext VermilionPortSuperNerdText
	waitbutton
	closetext
	end

VermilionPortTempSailorScript:
	jumptextfaceplayer VermilionPortTempSailorText

VermilionPortCaptainScript:
	jumptextfaceplayer VermilionPortCaptainText

VermilionPortHiddenIron:
	hiddenitem IRON, EVENT_VERMILION_PORT_HIDDEN_IRON

VermilionPortEnterFastShipMovement:
	step DOWN
	step DOWN
	step_end

VermilionPortLeaveFastShipLongMovement:
	step UP
	step UP
	step UP
VermilionPortLeaveFastShipMovement:
	step UP
	step UP
	step_end

VermilionPortHeadDownMovement:
	turn_head DOWN
	step_end

VermilionPortCannotEnterFastShipMovement:
	step RIGHT
	turn_head LEFT
	step_end

VermilionPortApproachFastShipMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

VermilionPortApproachFastShipLeftMovement:
	step LEFT
	step_end

VermilionPortDepartingText:
	text "We're departing"
	line "soon. Please get"
	cont "on board."
	done

VermilionPortCantBoardText:
	text "Sorry. You can't"
	line "board now."
	done

VermilionPortAskBoardingText:
	text "Welcome to FAST"
	line "SHIP S.S.AQUA."

	para "Will you be board-"
	line "ing today?"
	done

VermilionPortAskTicketText:
	text "May I see your"
	line "S.S.TICKET?"
	done

VermilionPortComeAgainText:
	text "We hope to see you"
	line "again!"
	done

VermilionPortSSTicketText:
	text "<PLAYER> flashed"
	line "the S.S.TICKET."

	para "That's it."
	line "Thank you!"
	done

LackOfTourismText:
	text "With the pandemic"
	line "and the recent"
	cont "power outage,"

	para "tourism is at an"
	line "all time low in"
	cont "KANTO."

	para "We are currently"
	line "shutdown because"
	cont "we don't have"
	cont "enough passengers"
	cont "for a trip,"
	cont "I'm sorry."

	para "We expect to"
	line "resume service"
	cont "soon-ish."
	done

VermilionPortNoTicketText:
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "TICKET…"

	para "…But no TICKET!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.TICKET."
	done

VermilionPortSailMondayText:
	text "The FAST SHIP will"
	line "sail on Wednesday."
	done

VermilionPortSailSundayText:
	text "The FAST SHIP will"
	line "sail next Sunday."
	done

VermilionPortSuperNerdText:
	text "You came from"
	line "JOHTO?"

	para "I hear many rare"
	line "#MON live over"
	cont "there."
	done

VermilionPortTempSailorText:
	text "I was supposed"
	line "to embark on"
	cont "the next ship."
	
	para "I guess I'm gonna"
	line "be stuck here"
	cont "for a while…"
	done

VermilionPortPowerOutageText:
	text "Because of the"
	line "power outage, the"
	cont "signaling system"
	cont "of the port is"
	cont "down."

	para "No boat can enter"
	line "or leave the port."

	para "Sorry for the"
	line "inconvenience."
	done

VermilionPortCaptainText:
	text "The signaling"
	line "system of the"
	cont "port is down"
	cont "because of the"
	cont "power outage."

	para "The ship can't"
	line "leave the port."

	para "I'll take the"
	line "opportunity to"
	cont "go see my family."
	done

VermilionPort_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  5, VERMILION_PORT_PASSAGE, 5
	warp_event  5, 19, FAST_SHIP_1F, 1

	def_coord_events
	coord_event  5, 13, SCENE_DEFAULT, VermilionPortWalkUpToShipScript

	def_bg_events
	bg_event 17,  8, BGEVENT_ITEM, VermilionPortHiddenIron

	def_object_events
	object_event  5, 19, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSailorAtGangwayScript, EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	object_event  4, 13, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSailorScript, -1
	object_event  9, 13, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSuperNerdScript, -1
	object_event  9, 12, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortTempSailorScript, EVENT_RETURNED_MACHINE_PART
	object_event  5, 19, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortCaptainScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
