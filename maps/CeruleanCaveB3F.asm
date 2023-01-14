	object_const_def
	const CERULEAN_CAVE_MEWTWO

CeruleanCaveB3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_CAUGHT_MEWTWO
	iftrue .end

.end
	endcallback

CeruleanCaveMewtwoScript:
	cry MEWTWO
	waitsfx
	pause 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon MEWTWO, 100
	startbattle
	special CheckCaughtMewtwo
	iffalse .DidntCatchMewtwo
	
	disappear CERULEAN_CAVE_MEWTWO
	setevent EVENT_CAUGHT_MEWTWO
	reloadmapafterbattle
	end

.DidntCatchMewtwo:
	reloadmapafterbattle
	playsound SFX_WARP_TO
	waitsfx
	disappear CERULEAN_CAVE_MEWTWO
	moveobject CERULEAN_CAVE_MEWTWO, 29, 0
	appear CERULEAN_CAVE_MEWTWO
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
	object_event 28, 15, SPRITE_MEWTWO, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CeruleanCaveMewtwoScript, EVENT_CAUGHT_MEWTWO
