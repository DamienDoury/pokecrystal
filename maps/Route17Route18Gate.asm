	object_const_def
	const ROUTE17ROUTE18GATE_OFFICER

Route17Route18Gate_MapScripts:
	def_scene_scripts

	def_callbacks

Route17Route18GateOfficerScript:
	jumptextfaceplayer Route17Route18GateOfficerText

Route17Route18GateBicycleCheck:
	showemote EMOTE_SHOCK, ROUTE17ROUTE18GATE_OFFICER, 15

	opentext

	readvar VAR_FACING
	ifequal RIGHT, .take_back_rental

	clearflag ENGINE_BIKE_SHOP_CALL_ENABLED
	turnobject PLAYER, UP
	writetext Route17Route18GateCannotPassText
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

Route17Route18Gate_LeftMovement:
	step LEFT
	step_end

Route17Route18Gate_RightMovement:
	step RIGHT
	step_end

Route17Route18GateOfficerText: 
if DEF(_FR_FR)
	text "La montée de la"
	line "PISTE CYCLABLE"
	cont "commence ici."
else
	text "CYCLING ROAD"
	line "Uphill Starts Here"
endc

	done

Route17Route18GateGetRentalBackText: ; TO TRANSLATE
	text "I'll take this"
	line "rental BICYCLE"
	cont "back, thank you!"
	done

Route17Route18GateCannotPassText: ; TO TRANSLATE
	text "Hang on! Don't you"
	line "have a BICYCLE?"

	para "The CYCLING ROAD"
	line "is beyond here"

	para "and you'll need"
	line "a BICYCLE."

	para "I'll give you a"
	line "rental for free."
	done

Route17Route18Gate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, ROUTE_18, 3
	warp_event  0,  5, ROUTE_18, 4
	warp_event  9,  4, ROUTE_18, 1
	warp_event  9,  5, ROUTE_18, 2

	def_coord_events
	coord_event  5,  4, CE_MISSING_ITEM, BICYCLE, Route17Route18GateBicycleCheck
	coord_event  5,  5, CE_MISSING_ITEM, BICYCLE, Route17Route18GateBicycleCheck

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route17Route18GateOfficerScript, -1
