	object_const_def

ViridianForest_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianForestDireHit:
	itemball DIRE_HIT

ViridianForestAntidote:
ViridianForestMaxPotion:
	itemball MAX_POTION

ViridianForestFruitTree1:
	fruittree FRUITTREE_ROUTE_42_1

ViridianForest_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, VIRIDIAN_CITY, 1
	warp_event  1,  0, VIRIDIAN_CITY, 1

	warp_event 25, 53, VIRIDIAN_CITY, 1
	warp_event 24, 53, VIRIDIAN_CITY, 1

;	warp_event 15, 29, VIRIDIAN_CITY, 1
;	warp_event 14, 28, VIRIDIAN_CITY, 1
;
;	warp_event 40, 27, VIRIDIAN_CITY, 1
;	warp_event 41, 27, VIRIDIAN_CITY, 1
;
;	warp_event 41, 26, VIRIDIAN_CITY, 1
;	warp_event 40, 26, VIRIDIAN_CITY, 1
;
;	warp_event 32, 27, VIRIDIAN_CITY, 1
;	warp_event 33, 26, VIRIDIAN_CITY, 1
;
;	warp_event 32, 26, VIRIDIAN_CITY, 1
;	warp_event 33, 27, VIRIDIAN_CITY, 1
;
;	warp_event 17, 40, VIRIDIAN_CITY, 1
;	warp_event 17, 41, VIRIDIAN_CITY, 1
;
;	warp_event 16, 40, VIRIDIAN_CITY, 1
;	warp_event 16, 41, VIRIDIAN_CITY, 1
;
;	warp_event 33, 39, VIRIDIAN_CITY, 1
;	warp_event 32, 39, VIRIDIAN_CITY, 1
;
;	warp_event 32, 38, VIRIDIAN_CITY, 1
;	warp_event 33, 38, VIRIDIAN_CITY, 1
;
;	warp_event  8, 35, VIRIDIAN_CITY, 1
;	warp_event  9, 35, VIRIDIAN_CITY, 1
;
;	warp_event  9, 34, VIRIDIAN_CITY, 1
;	warp_event  8, 34, VIRIDIAN_CITY, 1
;
;	warp_event  8, 47, VIRIDIAN_CITY, 1
;	warp_event  9, 47, VIRIDIAN_CITY, 1
;
;	warp_event  9, 46, VIRIDIAN_CITY, 1
;	warp_event  8, 46, VIRIDIAN_CITY, 1
;
;	warp_event 32,  0, VIRIDIAN_CITY, 1
;	warp_event 33,  0, VIRIDIAN_CITY, 1
;
;	warp_event 32,  1, VIRIDIAN_CITY, 1
;	warp_event 33,  1, VIRIDIAN_CITY, 1
;
;	warp_event 33, 15, VIRIDIAN_CITY, 1
;	warp_event 32, 15, VIRIDIAN_CITY, 1
;
;	warp_event 25, 41, VIRIDIAN_CITY, 1
;	warp_event 24, 41, VIRIDIAN_CITY, 1
;
;	warp_event 33, 14, VIRIDIAN_CITY, 1
;	warp_event 32, 14, VIRIDIAN_CITY, 1
;
;	warp_event 25, 40, VIRIDIAN_CITY, 1
;	warp_event 24, 40, VIRIDIAN_CITY, 1
;
;	warp_event 19,  6, VIRIDIAN_CITY, 1
;	warp_event 18,  6, VIRIDIAN_CITY, 1
;
;	warp_event  1,  6, VIRIDIAN_CITY, 1
;	warp_event  0,  6, VIRIDIAN_CITY, 1
;
;	warp_event 19,  7, VIRIDIAN_CITY, 1
;	warp_event 18,  7, VIRIDIAN_CITY, 1
;
;	warp_event  1,  7, VIRIDIAN_CITY, 1
;	warp_event  0,  7, VIRIDIAN_CITY, 1
;
;	warp_event 15, 28, VIRIDIAN_CITY, 1
;	warp_event 14, 29, VIRIDIAN_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 41, 13, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event 27, 13, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event 25, 34, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event 40, 17, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event 13, 12, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event  1, 37, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event  1, 45, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestDireHit, EVENT_ROUTE_2_DIRE_HIT
	object_event 12, 23, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestMaxPotion, EVENT_ROUTE_2_MAX_POTION
	object_event 33, 21, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestAntidote, EVENT_ROUTE_2_MAX_POTION
	object_event 33, 33, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestAntidote, EVENT_ROUTE_2_MAX_POTION
	object_event  2, 20, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_ITEMBALL, 0, ViridianForestAntidote, EVENT_ROUTE_2_MAX_POTION
