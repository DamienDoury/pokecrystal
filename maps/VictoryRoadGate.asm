	object_const_def
	const VICTORYROADGATE_OFFICER
	const VICTORYROADGATE_BLACK_BELT1
	const VICTORYROADGATE_BLACK_BELT2

VictoryRoadGate_MapScripts:
	def_scene_scripts

	def_callbacks

VictoryRoadGateBadgeCheckScene:
	turnobject PLAYER, LEFT
	sjump VictoryRoadGateBadgeCheckScript

VictoryRoadGateOfficerScript:
	faceplayer
VictoryRoadGateBadgeCheckScript:
	opentext
	writetext VictoryRoadGateOfficerText
	promptbutton
	readvar VAR_BADGES
	ifgreater NUM_JOHTO_BADGES - 1, .AllEightBadges
	writetext VictoryRoadGateNotEnoughBadgesText
	waitbutton
	closetext
	applymovement PLAYER, VictoryRoadGateStepDownMovement
	end

.AllEightBadges:
	writetext VictoryRoadGateEightBadgesText
	waitbutton
	closetext
	setevent EVENT_ALLOWED_ACCESS_TO_VICTORY_ROAD
	end

VictoryRoadGateLeftBlackBeltScript:
	jumptextfaceplayer VictoryRoadGateLeftBlackBeltText

VictoryRoadGateRightBlackBeltScript:
	jumptextfaceplayer VictoryRoadGateRightBlackBeltText

VictoryRoadGateStepDownMovement:
	step DOWN
	step_end

VictoryRoadGateOfficerText: 
if DEF(_FR_FR)
	text "Seuls les dres-"
	line "seurs confirmés"
	cont "peuvent passer."
else
	text "Only trainers who"
	line "have proven them-"
	cont "selves may pass."
endc

	done

VictoryRoadGateNotEnoughBadgesText: 
if DEF(_FR_FR)
	text "Tu n'as pas tous"
	line "les BADGES d'ARENE"
	cont "de JOHTO."

	para "Je ne peux pas"
	line "te laisser passer."
	cont "Désolé."
else
	text "You don't have all"
	line "the GYM BADGES of"
	cont "JOHTO."

	para "I'm sorry, but I"
	line "can't let you go"
	cont "through."
endc

	done

VictoryRoadGateEightBadgesText: 
if DEF(_FR_FR)
	text "Oh! Les huit"
	line "BADGES de JOHTO!"

	para "Après vous,"
	line "votre altesse!"
else
	text "Oh! The eight"
	line "BADGES of JOHTO!"

	para "Please, go right"
	line "on through!"
endc

	done

VictoryRoadGateLeftBlackBeltText: 
if DEF(_FR_FR)
	text "Cette route mène"
	line "au MONT ARGENT."

	para "Tu y verras des"
	line "#MON affreu-"
	cont "sement forts."
else
	text "This way leads to"
	line "MT.SILVER."

	para "You'll see scary-"
	line "strong #MON out"
	cont "there."
endc

	done

VictoryRoadGateRightBlackBeltText: 
if DEF(_FR_FR)
	text "Tu vas à la LIGUE"
	line "#MON, hein?"

	para "Le CONSEIL des 4"
	line "est super hyper"

	para "méga fort!!! Tu"
	line "vas en baver!"
else
	text "Off to the #MON"
	line "LEAGUE, are you?"

	para "The ELITE FOUR are"
	line "so strong it's"

	para "scary, and they're"
	line "ready for you!"
endc

	done

VictoryRoadGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 25,  7, ROUTE_22, 1
	warp_event 26,  7, ROUTE_22, 1
	warp_event 13, 17, ROUTE_26, 1
	warp_event 14, 17, ROUTE_26, 1
	warp_event 13,  0, VICTORY_ROAD, 1
	warp_event 14,  0, VICTORY_ROAD, 1
	warp_event  1,  7, ROUTE_28, 2
	warp_event  2,  7, ROUTE_28, 2

	def_coord_events
	coord_event 14, 11, CE_EVENT_FLAG_CLEARED, EVENT_ALLOWED_ACCESS_TO_VICTORY_ROAD, VictoryRoadGateBadgeCheckScene

	def_bg_events

	def_object_events
	object_event 12, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateOfficerScript, -1
	object_event 11,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateLeftBlackBeltScript, EVENT_OPENED_MT_SILVER
	object_event 16,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateRightBlackBeltScript, EVENT_CINNABAR_ROCKS_CLEARED
