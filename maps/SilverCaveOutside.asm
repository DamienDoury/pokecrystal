	object_const_def
	const MTSILVER_ARTICUNO

SilverCaveOutside_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	endcallback

MtSilverArticuno:
	cry ARTICUNO
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon ARTICUNO, 75
	startbattle
	disappear MTSILVER_ARTICUNO
	reloadmapafterbattle
	end

MtSilverPokecenterSign:
	jumpstd PokecenterSignScript

MtSilverSign:
	jumptext MtSilverSignText

MtSilverHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE

MtSilverSignText:
	text "MT.SILVER"
	done

SilverCaveOutside_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 23, 11, SILVER_CAVE_POKECENTER_1F, 1
	warp_event 18,  3, SILVER_CAVE_ROOM_1, 1

	def_coord_events

	def_bg_events
	bg_event 24, 11, BGEVENT_READ, MtSilverPokecenterSign
	bg_event 17,  5, BGEVENT_READ, MtSilverSign
	bg_event  9, 17, BGEVENT_ITEM, MtSilverHiddenFullRestore

	def_object_events
	object_event  9, 17, SPRITE_ARTICUNO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MtSilverArticuno, EVENT_FOUGHT_ARTICUNO
