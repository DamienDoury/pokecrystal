	object_const_def
	const CERULEAN_CAVE_MEWTWO_TOP
	const CERULEAN_CAVE_MEWTWO_BOTTOM

CeruleanCaveB3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_CAUGHT_MEWTWO
	iftrue .end

	loadmem wCeruleanCaveB3FStepCount, 30
	loadmem wCeruleanCaveB3FMessageIndex, 0
	loadmem wCeruleanCaveB3FTeleportIndex, 0

.end
	endcallback

CeruleanCaveMewtwoScript:
	cry MEWTWO
	waitsfx
	pause 30
	loadmem wCeruleanCaveB3FMewtwoRetreat, FALSE
	loadmem wCeruleanCaveB3FStepCount, 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon MEWTWO, 100
	startbattle
	special CheckCaughtMewtwo
	iffalse .DidntCatchMewtwo
	
	disappear CERULEAN_CAVE_MEWTWO_TOP
	disappear CERULEAN_CAVE_MEWTWO_BOTTOM
	setevent EVENT_CAUGHT_MEWTWO
	reloadmapafterbattle
	end

.DidntCatchMewtwo:
	reloadmapafterbattle
	playsound SFX_WARP_TO
	waitsfx
	disappear CERULEAN_CAVE_MEWTWO_TOP
	disappear CERULEAN_CAVE_MEWTWO_BOTTOM
	moveobject CERULEAN_CAVE_MEWTWO_TOP, 38, 0
	moveobject CERULEAN_CAVE_MEWTWO_BOTTOM, 38, 1
	appear CERULEAN_CAVE_MEWTWO_TOP
	appear CERULEAN_CAVE_MEWTWO_BOTTOM
	jumptext MewtwoTeleportedAwayText

MewtwoTeleportedAwayText:
	text "MEWTWO teleported"
	line "away."
	done

CeruleanCaveB3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  7, CERULEAN_CAVE_B2F, 1
	warp_event  4,  7, CERULEAN_CAVE_B2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 28, 14, SPRITE_MEWTWO_OW_TOP, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanCaveMewtwoScript, EVENT_CAUGHT_MEWTWO
	object_event 28, 15, SPRITE_MEWTWO_OW_BOTTOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanCaveMewtwoScript, EVENT_CAUGHT_MEWTWO

