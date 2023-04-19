	object_const_def
	const SEAFOAMB6F_MOLTRES

SeafoamB6F_MapScripts:
	def_scene_scripts

	def_callbacks


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
	warp_event 17, 15, SEAFOAM_B5F, 2
	warp_event  5,  3, SEAFOAM_GYM_B3F, 2

	; Pit arrival.
	warp_event  5, 15, SEAFOAM_B6F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5, 11, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamB6FMoltres, EVENT_FOUGHT_MOLTRES
