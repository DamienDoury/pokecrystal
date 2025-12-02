	object_const_def
	const VERMILIONDIGLETTSCAVESPEECHHOUSE_GENTLEMAN

VermilionDiglettsCaveSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad

.TilesLoad
	changeblock  2,  2, $36
	endcallback

VermilionDiglettsCaveSpeechHouseGentlemanScript:
	jumptextfaceplayer VermilionDiglettsCaveSpeechHouseGentlemanText

VermilionDiglettsCaveSpeechHouseComputerScript:
	jumptext VermilionDiglettsCaveSpeechHouseComputerText

VermilionDiglettsCaveSpeechHouseGentlemanText:
if DEF(_FR_FR)
	text "Maintenant qu'on"
	line "peut sortir à"
	cont "nouveau, la majo-"
	cont "rité des gens a"
	cont "repris le travail"
	cont "sur site."
	
	para "Mais certains,"
	line "comme moi, ont"
	cont "pris goût au"
	cont "télétravail."
	
	para "Bon, il est l'heure"
	line "d'aller se détendre"
	cont "à la plage!"
else
	text "Now that we can go"
	line "out once again,"
	cont "most people went"
	cont "back to work on"
	cont "site."
	
	para "But some people"
	line "like me took a"
	cont "fancy to the"
	cont "remote work."

	para "All right, time to"
	line "go relax at the"
	cont "beach!"
endc
	done

VermilionDiglettsCaveSpeechHouseComputerText:
if DEF(_FR_FR)
	text "Un agenda hebdoma-"
	line "daire est ouvert."
	
	para "Il est rempli de"
	line "réunions d'une"
	cont "heure chacune."
	
	para "Environ six par"
	line "jour."
else
	text "There's a weekly"
	line "schedule opened."

	para "It's filled with"
	line "one hour meetings."

	para "About six a day."
endc
	done

VermilionDiglettsCaveSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, VERMILION_CITY, 6
	warp_event  3,  7, VERMILION_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VermilionDiglettsCaveSpeechHouseGentlemanScript, -1
	object_event  3,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionDiglettsCaveSpeechHouseComputerScript, -1
