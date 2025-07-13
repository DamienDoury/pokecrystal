	object_const_def
	const CERULEAN_CAVE_MEWTWO_TOP    ; Must stay at position 1, because it's used by RespawnPlayerAndOpponent.
	const CERULEAN_CAVE_MEWTWO_BOTTOM ; Must stay at position 2, because it's used by RespawnPlayerAndOpponent.

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
	loadmem wCeruleanCaveB3FMewtwoCatchRate, 0

.end
	endcallback

CeruleanCaveMewtwoScript:
	readvar VAR_FACING
	ifequal DOWN, .end

	cry MEWTWO
	waitsfx
	pause 30
	readmem wCeruleanCaveB3FMewtwoCatchRate
	ifequal MEWTWO_MAX_CATCHRATE + MEWTWO_ENCOUNTER_CATCHRATE_BOOST, .skip_catch_rate_increase
	ifgreater MEWTWO_MAX_CATCHRATE + MEWTWO_ENCOUNTER_CATCHRATE_BOOST, .skip_catch_rate_increase
	addval MEWTWO_ENCOUNTER_CATCHRATE_BOOST
	writemem wCeruleanCaveB3FMewtwoCatchRate

.skip_catch_rate_increase
	loadmem wBattlePokerusSeed, POKERUS_ALPHA_STRAIN + POKERUS_SYMPTOMS_START + 1
	loadmem wCeruleanCaveB3FStepCount, 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon MEWTWO, 100
	startbattle
	special CheckCaughtMewtwo
	iffalse .DidntCatchMewtwo
	
	disappear CERULEAN_CAVE_MEWTWO_TOP
	disappear CERULEAN_CAVE_MEWTWO_BOTTOM
	setevent EVENT_CAUGHT_MEWTWO
	loadmem wKantoAddLevel, 24
	reloadmapafterbattle
.end
	end

.DidntCatchMewtwo:
	disappear CERULEAN_CAVE_MEWTWO_TOP
	disappear CERULEAN_CAVE_MEWTWO_BOTTOM
	reloadmapafterbattle
	playsound SFX_WARP_TO
	waitsfx

	special ComputeMewtwoTeleportIndex
	readmem wCeruleanCaveB3FTeleportIndex
	ifequal 1, .teleportIndex1
	ifequal 2, .teleportIndex2
	ifequal 3, .teleportIndex3

;.teleportIndex0
	moveobject CERULEAN_CAVE_MEWTWO_TOP, 28, 14
	moveobject CERULEAN_CAVE_MEWTWO_BOTTOM, 28, 15
	sjump .appear

.teleportIndex1
	moveobject CERULEAN_CAVE_MEWTWO_TOP, 11, 8
	moveobject CERULEAN_CAVE_MEWTWO_BOTTOM, 11, 9
	sjump .appear

.teleportIndex2
	moveobject CERULEAN_CAVE_MEWTWO_TOP, 21, 2
	moveobject CERULEAN_CAVE_MEWTWO_BOTTOM, 21, 3
	sjump .appear

.teleportIndex3
	moveobject CERULEAN_CAVE_MEWTWO_TOP, 4, 2
	moveobject CERULEAN_CAVE_MEWTWO_BOTTOM, 4, 3

.appear
	appear CERULEAN_CAVE_MEWTWO_TOP
	appear CERULEAN_CAVE_MEWTWO_BOTTOM
	opentext
	writetext MewtwoTeleportedAwayText
	waitbutton
	closetext

	pause 20

	jumptext MewtwoTeleportedAwaySequelText

MewtwoTeleportedAwayText:
if DEF(_FR_FR)
	text "MEWTWO s'est"
	line "téléporté."
	done
else
	text "MEWTWO teleported"
	line "away."
	done
endc

MewtwoTeleportedAwaySequelText:
if DEF(_FR_FR)
	text "Sa présence est"
	line "encore palpable..."
	done
else
	text "Its presence can"
	line "still be felt…"
	done
endc

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

