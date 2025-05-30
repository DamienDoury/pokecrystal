Route22_MapScripts:
	def_scene_scripts

	def_callbacks

VictoryRoadEntranceSign:
	jumptext VictoryRoadEntranceSignText

VictoryRoadEntranceSignText: 
if DEF(_FR_FR)
	text "LIGUE #MON"

	para "ENTREE de la"
	line "ROUTE VICTOIRE"
else
	text "#MON LEAGUE"

	para "VICTORY ROAD"
	line "ENTRANCE"
endc

	done

Route22_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  5, VICTORY_ROAD_GATE, 1

	def_coord_events

	def_bg_events
	bg_event  7, 11, BGEVENT_READ, VictoryRoadEntranceSign

	def_object_events
