	object_const_def
	const ROUTE16GATE_OFFICER

Route16Gate_MapScripts:
	def_scene_scripts

	def_callbacks

Route16GateOfficerScript:
	jumptextfaceplayer Route16GateOfficerText

Route16GateBicycleCheck:
	showemote EMOTE_SHOCK, ROUTE16GATE_OFFICER, 15

	opentext
	readvar VAR_FACING
	ifequal RIGHT, .take_back_rental

	clearflag ENGINE_BIKE_SHOP_CALL_ENABLED
	turnobject PLAYER, UP
	writetext Route16GateCannotPassText
	waitbutton
	closetext

	loadvar VAR_MOVEMENT, PLAYER_BIKE
	special UpdatePlayerSprite
	
	applymovement PLAYER, Route17Route18Gate_LeftMovement
	end

.take_back_rental:
	turnobject PLAYER, UP
	writetext Route17Route18GateGetRentalBackText
	waitbutton
	closetext

	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	special UpdatePlayerSprite

	applymovement PLAYER, Route17Route18Gate_RightMovement
	end

Route16GateOfficerText: ; AUTOTRAD
	text "CYCLING ROAD"
	line "starts here."

	para "It's all downhill,"
	line "so it's totally"
	cont "exhilarating."

	para "It's a great sort"
	line "of feeling that"

	para "you can't get from"
	line "a ship or train."
	done

Route16GateCannotPassText: ; TO TRANSLATE
	text "Hey! Whoa! Stop!"

	para "You can't go out"
	line "on the CYCLING"

	para "ROAD without a"
	line "BICYCLE."

	para "I'll lend you one."
	done

Route16Gate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ROUTE_16, 4
	warp_event  0,  5, ROUTE_16, 5
	warp_event  9,  4, ROUTE_16, 2
	warp_event  9,  5, ROUTE_16, 3

	def_coord_events
	coord_event  5,  4, CE_MISSING_ITEM, BICYCLE, Route16GateBicycleCheck
	coord_event  5,  5, CE_MISSING_ITEM, BICYCLE, Route16GateBicycleCheck

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route16GateOfficerScript, -1
