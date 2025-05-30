Route23_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	checkflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel
.endcallback
	endcallback

IndigoPlateauSign:
	jumptext IndigoPlateauSignText

IndigoPlateauSignText: 
if DEF(_FR_FR)
	text "PLATEAU INDIGO"

	para "La quête de tout"
	line "dresseur!"

	para "QG LIGUE #MON"
else
	text "INDIGO PLATEAU"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#MON LEAGUE HQ"
endc

	done

Route23_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  5, INDIGO_PLATEAU_POKECENTER_1F, 1
	warp_event 10,  5, INDIGO_PLATEAU_POKECENTER_1F, 2
	warp_event  9, 21, VICTORY_ROAD, 10
	warp_event 10, 21, VICTORY_ROAD, 10

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, IndigoPlateauSign

	def_object_events
