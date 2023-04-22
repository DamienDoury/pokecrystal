	object_const_def
	const SEAFOAMB6F_MOLTRES

SeafoamB6F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback
	checkevent EVENT_BOULDER_IN_SEAFOAM_B6F_ALL
	iftrue .DontCollapse

	changeblock  4, 10, $4f
	changeblock  4, 12, $4f

.DontCollapse
	endcallback

SeafoamB6FMoltres:
	cry MOLTRES
	loadmem wAssaultBattle, $ff
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon MOLTRES, 75
	startbattle
	disappear SEAFOAMB6F_MOLTRES
	reloadmapafterbattle
	end

SeafoamB6F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17,  3, SEAFOAM_B5F, 2
	warp_event  5,  3, SEAFOAM_GYM_B3F, 2
	warp_event 19, 11, SEAFOAM_B6F, 1 ; Pit arrival.
	warp_event  5, 14, SEAFOAM_B6F, 1 ; Pit arrival.

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5, 11, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB6FMoltres, EVENT_FOUGHT_MOLTRES
