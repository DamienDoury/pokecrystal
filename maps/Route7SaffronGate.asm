	object_const_def
	const ROUTE7SAFFRONGATE_OFFICER
	const ROUTE7SAFFRONGATE_OAK

Route7SaffronGate_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	checkevent EVENT_MET_OAK_IN_SAFFRON
	iftrue .disappear
	;appear ROUTE7SAFFRONGATE_OAK
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	endcallback
.disappear
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	endcallback

Route7SaffronGuardScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedPart
	writetext Route7SaffronGuardPowerPlantText
	waitbutton
	closetext
	end

.ReturnedPart:
	writetext Route7SaffronGuardSeriousText
	waitbutton
	closetext
	end

Route7SaffronGateCrossOakScript:
	checkevent EVENT_MET_OAK_IN_SAFFRON
	iftrue .end

	turnobject ROUTE7SAFFRONGATE_OAK, RIGHT
	pause 3
	showemote EMOTE_SHOCK, ROUTE7SAFFRONGATE_OAK, 15

	readvar VAR_YCOORD
	ifequal 4, .entry_movement_done

	applymovement ROUTE7SAFFRONGATE_OAK, Route7SaffronGate_StepDownMovement

.entry_movement_done

	opentext
	writetext Route7SaffronGate_OakGreetingsText
	waitbutton
	closetext

	readvar VAR_YCOORD
	ifequal 4, .exit_movement_from_y4
;.exit_movement_from_y5
	applymovement ROUTE7SAFFRONGATE_OAK, Route7SaffronGate_StepUpMovement
	sjump .exit_movement_done

.exit_movement_from_y4
	applymovement ROUTE7SAFFRONGATE_OAK, Route7SaffronGate_StepDownMovement
.exit_movement_done
	applymovement ROUTE7SAFFRONGATE_OAK, Route7SaffronGate_StepRight4Movement
	warpsound
	disappear ROUTE7SAFFRONGATE_OAK
	waitsfx
	setevent EVENT_MET_OAK_IN_SAFFRON
.end
	end

Route7SaffronGate_StepDownMovement:
	step DOWN
	turn_head RIGHT
	step_end

Route7SaffronGate_StepUpMovement:
	step UP
	step_end

Route7SaffronGate_StepRight4Movement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

Route7SaffronGate_OakGreetingsText:
	text "OAK: <PLAY_G>?"
	para "I wasn't expecting"
	line "you here!"

	para "So, what do you"
	line "think of KANTO?"

	para "It's not showing in"
	line "its best light"
	cont "with the current"
	cont "outage."

	para "You have already"
	line "noticed we do"
	cont "things differently"
	cont "in here."

	para "For example, we're"
	line "done with lock-"
	cont "downs and curfews"
	
	para "and moved to the"
	line "VACCINE PASSPORT."

	para "This allows busi-"
	line "nesses to re-open"
	cont "to vaccinated"
	cont "people."

	para "But I'm getting"
	line "carried away."

	para "I was on my way to"
	line "the SILPH CO."
	cont "building in"
	cont "SAFFRON CITY."

	para "They need all the"
	line "help they can get"
	cont "with the research"
	cont "on the #MON"
	cont "vaccine."

	para "You should go"
	line "check if you could"
	cont "help as well."

	para "They're waiting for"
	line "me, I should go."

	para "My lab is in"
	line "PALLET TOWN,"

	para "come say hi"
	line "sometimes!"
	done

Route7SaffronGuardPowerPlantText:
	text "Did you hear about"
	line "the accident at"
	cont "the POWER PLANT?"

	para "It's located in"
	line "the East, close to"
	cont "LAVENDER TOWN."
	done

Route7SaffronGuardSeriousText:
	text "I take my GUARD"
	line "job seriously."

	para "Hey! You have a"
	line "#DEX."

	para "OK. You can go"
	line "through."
	done

Route7SaffronGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ROUTE_7, 1
	warp_event  0,  5, ROUTE_7, 2
	warp_event  9,  4, SAFFRON_CITY, 10
	warp_event  9,  5, SAFFRON_CITY, 11

	def_coord_events
	coord_event  7,  5, CE_SCENE_ID, SCENE_ALWAYS, Route7SaffronGateCrossOakScript
	coord_event  7,  4, CE_SCENE_ID, SCENE_ALWAYS, Route7SaffronGateCrossOakScript

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route7SaffronGuardScript, -1
	object_event  5,  4, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
