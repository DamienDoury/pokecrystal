	object_const_def
	const ROUTE5_POKEFAN_M

Route5_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TurnOffLights

.TurnOffLights
	changeblock 12, 32, $68
	changeblock 14, 32, $7f
	changeblock 16, 32, $69

	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .EndCallback

	; Turns off the underground path lights.
	changeblock 16, 26, $60
	changeblock 18, 26, $26

.EndCallback
	endcallback

Route5PokefanMScript:
	jumptextfaceplayer Route5PokefanMText

Route5UndergroundPathSign:
	jumptext Route5UndergroundPathSignText

HouseForSaleSign:
	jumptext HouseForSaleSignText

Route5PokefanMText: 
if DEF(_FR_FR)
	text "La route sera"
	line "fermée tant que le"

	para "problème à la"
	line "CENTRALE ne sera"
	cont "pas résolu."
else
	text "The road is closed"
	line "until the problem"

	para "at the POWER PLANT"
	line "is solved."
endc

	done

Route5UndergroundPathSignText: 
if DEF(_FR_FR)
	text "SOUTERRAIN"

	para "AZURIA -"
	line "CARMIN SUR MER"
else
	text "UNDERGROUND PATH"

	para "CERULEAN CITY -"
	line "VERMILION CITY"
endc

	done

HouseForSaleSignText: 
if DEF(_FR_FR)
	text "C'est quoi ça?"

	para "Maison à vendre..."
	line "Il n'y a personne."
else
	text "What's this?"

	para "House for Sale…"
	line "Nobody lives here."
endc

	done

Route5_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 27, ROUTE_5_UNDERGROUND_PATH_ENTRANCE, 1
	warp_event  8, 29, ROUTE_5_SAFFRON_GATE, 1
	warp_event  9, 29, ROUTE_5_SAFFRON_GATE, 2
	warp_event 10, 21, ROUTE_5_CLEANSE_TAG_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 17, 29, BGEVENT_READ, Route5UndergroundPathSign
	bg_event 10, 21, BGEVENT_READ, HouseForSaleSign

	def_object_events
	object_event 17, 28, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route5PokefanMScript, EVENT_RETURNED_MACHINE_PART
