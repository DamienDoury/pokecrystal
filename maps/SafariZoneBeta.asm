	object_const_def
	const SAFARIZONE_FRUIT_TREE

SafariZoneBeta_MapScripts:
	def_scene_scripts

	def_callbacks

SafariZoneFruitTree:
	fruittree FRUITTREE_SAFARI_ZONE

SafariZoneBeta_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 23, SAFARI_ZONE_FUCHSIA_GATE_BETA, 1
	warp_event 10, 23, SAFARI_ZONE_FUCHSIA_GATE_BETA, 2
	warp_event  8, 23, SAFARI_ZONE_FUCHSIA_GATE_BETA, 1
	warp_event 11, 23, SAFARI_ZONE_FUCHSIA_GATE_BETA, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  6, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SafariZoneFruitTree, -1
