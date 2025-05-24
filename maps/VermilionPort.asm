	object_const_def
	const VERMILIONPORT_SAILOR1
	const VERMILIONPORT_SAILOR2
	const VERMILIONPORT_SUPER_NERD
	const VERMILIONPORT_SAILOR_TEMP
	const VERMILIONPORT_CAPTAIN
	const VERMILIONPORT_TRUCK1
	const VERMILIONPORT_TRUCK2

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
	stopfollow
	applymovement PLAYER, VermilionPortHeadDownMovement
	moveobject VERMILIONPORT_CAPTAIN, 7, 17
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
	farwritetext OlivinePortSailorGetOnBoardText
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
	farwritetext OlivinePortCantBoardText
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
	
	farscall OlivinePortBoardingCheck
	iffalse .skip

	applymovement PLAYER, VermilionPortApproachFastShipMovement
	sjump VermilionPortSailorAtGangwayScript

.skip:
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

	farscall OlivinePortBoardingCheck
	iffalse .skip

	applymovement PLAYER, VermilionPortApproachFastShipLeftMovement
	applymovement PLAYER, VermilionPortApproachFastShipMovement
	sjump VermilionPortSailorAtGangwayScript

.skip
	end

VermilionPortSuperNerdScript:
	faceplayer
	opentext
	writetext VermilionPortSuperNerdText
	waitbutton
	closetext
	end

VermilionPortTruckScript:
	opentext
	writetext VermilionPortTruck1Text
	waitbutton
	closetext
	pause 45
	showemote EMOTE_SHOCK, PLAYER, 15
	opentext
	writetext VermilionPortTruck2Text
	waitbutton
	closetext
	pause 15
	cry MEW

	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon MEW, 40
	startbattle
	disappear VERMILIONPORT_TRUCK1
	disappear VERMILIONPORT_TRUCK2
	reloadmapafterbattle
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
	step UP
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

VermilionPortSuperNerdText: ; AUTOTRAD
	text "You came from"
	line "JOHTO?"

	para "I hear many rare"
	line "#MON live over"
	cont "there."
	done

VermilionPortTempSailorText: ; TO TRANSLATE
	text "I was supposed"
	line "to embark on"
	cont "the next ship."
	
	para "I guess I'm gonna"
	line "be stuck here"
	cont "for a while…"
	done

VermilionPortPowerOutageText: ; TO TRANSLATE
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

VermilionPortCaptainText: ; TO TRANSLATE
	text "The signaling"
	line "system of the"
	cont "port is down"
	cont "because of the"
	cont "power outage."

	para "The ship can't"
	line "leave the port."
	done

VermilionPortTruck1Text: ; TO TRANSLATE
	text "There's nothing"
	line "under the truck."
	done

VermilionPortTruck2Text: ; TO TRANSLATE
	text "Wait…"
	done

VermilionPort_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  7, VERMILION_PORT_PASSAGE, 5
	warp_event  7, 21, FAST_SHIP_1F, 1

	def_coord_events
	coord_event  7, 15, CE_SCENE_ID, SCENE_DEFAULT, VermilionPortWalkUpToShipScript

	def_bg_events
	bg_event 19, 10, BGEVENT_ITEM, VermilionPortHiddenIron

	def_object_events
	object_event  7, 21, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSailorAtGangwayScript, EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	object_event  5, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSailorScript, -1
	object_event 11, 15, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortSuperNerdScript, -1
	object_event 11, 14, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortTempSailorScript, EVENT_RETURNED_MACHINE_PART
	object_event  7, 21, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortCaptainScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event 20, 17, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortTruckScript, EVENT_FOUGHT_MEW
	object_event 21, 17, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPortTruckScript, EVENT_FOUGHT_MEW
