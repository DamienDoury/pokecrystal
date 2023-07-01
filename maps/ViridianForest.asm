	object_const_def
	const VIRIDIAN_FOREST_TREE_1
	const VIRIDIAN_FOREST_TREE_2
	const VIRIDIAN_FOREST_TREE_3
	const VIRIDIAN_FOREST_TREE_4
	const VIRIDIAN_FOREST_TREE_5
	const VIRIDIAN_FOREST_TREE_6
	const VIRIDIAN_FOREST_BALL_1
	const VIRIDIAN_FOREST_BALL_2
	const VIRIDIAN_FOREST_BALL_3
	const VIRIDIAN_FOREST_BALL_4
	const VIRIDIAN_FOREST_GS_BALL
	const VIRIDIAN_FOREST_LOST_KID
	const VIRIDIAN_FOREST_ZAPDOS

ViridianForest_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	special ShuffleAllViridianWarps

	checkevent EVENT_FOUGHT_ZAPDOS
	iftrue .ZapdosDisappears
	checkevent EVENT_ZAPDOS_APPEARED
	iffalse .ZapdosDisappears
	appear VIRIDIAN_FOREST_ZAPDOS
	endcallback

.ZapdosDisappears:
	disappear VIRIDIAN_FOREST_ZAPDOS
	endcallback

ViridianForestDireHit:
	itemball DIRE_HIT

ViridianForestMaxPotion:
	itemball MAX_POTION

ViridianForestRevivalHerb:
	itemball REVIVAL_HERB

ViridianForestAntidote:
	itemball ANTIDOTE

ViridianForestFruitTree1:
	fruittree FRUITTREE_VIRIDIAN_FOREST_1

ViridianForestFruitTree2:
	fruittree FRUITTREE_VIRIDIAN_FOREST_2

ViridianForestFruitTree3:
	fruittree FRUITTREE_VIRIDIAN_FOREST_3

ViridianForestFruitTree4:
	fruittree FRUITTREE_VIRIDIAN_FOREST_4

ViridianForestFruitTree5:
	fruittree FRUITTREE_VIRIDIAN_FOREST_5

ViridianForestFruitTree6:
	fruittree FRUITTREE_VIRIDIAN_FOREST_6

ViridianForest_ZapdosAppears:
	checkevent EVENT_ZAPDOS_APPEARED
	iftrue ViridianForest_ZapdosAssaultsPlayer
	cry ZAPDOS
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	special ZapdosFlyToAnim
	appear VIRIDIAN_FOREST_ZAPDOS
	setevent EVENT_ZAPDOS_APPEARED
	applymovement PLAYER, ViridianForest_PlayerStepsBackMovement
	end

ViridianForest_ZapdosAssaultsPlayer:
	checkevent EVENT_FOUGHT_ZAPDOS
	iftrue .end
	cry ZAPDOS
	loadmem wAssaultBattle, $ff
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon ZAPDOS, 75
	startbattle
	ifequal LOSE, .NotBeaten
	dontrestartmapmusic
	setevent EVENT_VIRIDIAN_FOREST_WARNING_ISSUED
	disappear VIRIDIAN_FOREST_LOST_KID ; also does setevent EVENT_FOUGHT_ZAPDOS.
	disappear VIRIDIAN_FOREST_ZAPDOS ; also does setevent EVENT_FOUGHT_ZAPDOS.
	reloadmapafterbattle
	pause 15
	
	cry CELEBI
	waitsfx
	pause 3
	playsound SFX_BALL_POOF
    waitsfx
	special CelebiFlyAwayAnim

	pause 40
	clearevent EVENT_VIRIDIAN_FOREST_GUY_SAVED
	pause 60

	opentext
	writetext ViridianForest_PeacefulText
	waitbutton
	closetext

	playmapmusic

	; rain end.
	end
	
.NotBeaten:
	reloadmapafterbattle
.end
	end
	
ViridianGSBall:
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	disappear VIRIDIAN_FOREST_GS_BALL ; also does setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	opentext
	verbosegiveitem GS_BALL
	closetext
	end

ViridianForestLostKidScript:
	jumptextfaceplayer ViridianForestLostKidText

ViridianForestHiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_ROUTE_2_HIDDEN_MAX_ETHER

ViridianForestHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_ROUTE_2_HIDDEN_FULL_HEAL

ViridianForestHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_ROUTE_2_HIDDEN_FULL_RESTORE

ViridianForestHiddenRevive:
	hiddenitem REVIVE, EVENT_ROUTE_2_HIDDEN_REVIVE

ViridianForest_PlayerStepsBackMovement:
	fix_facing
	step DOWN
	remove_fixed_facing
	step_end

ViridianForestLostKidText:
	text "Please help!"
	
	para "I've been lost"
	line "for days."

	para "It's like the"
	line "forest is moving…"

	para "I'm surviving"
	line "off berries."

	para "Find what's wrong"
	line "with the forest!"
	done

ViridianForest_PeacefulText:
	text "The forest is"
	line "at peace."
	done

ViridianForest_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  5, ROUTE_2, 6
	warp_event  1,  5, ROUTE_2, 7

	warp_event 24, 56, ROUTE_2, 8
	warp_event 25, 56, ROUTE_2, 9

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
	coord_event  2, 27, SCENE_ALWAYS, ViridianForest_ZapdosAppears

	def_bg_events
	bg_event 22, 24, BGEVENT_ITEM, ViridianForestHiddenMaxEther
	bg_event 10, 11, BGEVENT_ITEM, ViridianForestHiddenFullHeal
	bg_event 39, 50, BGEVENT_ITEM, ViridianForestHiddenFullRestore
	bg_event 40, 18, BGEVENT_ITEM, ViridianForestHiddenRevive

	def_object_events
	object_event 40, 17, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree1, -1
	object_event 27, 17, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree2, -1
	object_event 25, 38, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree3, -1
	object_event 41, 21, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree4, -1
	object_event 13, 16, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree5, -1
	object_event  1, 41, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianForestFruitTree6, -1
	object_event  1, 49, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestDireHit, EVENT_VIRIDIAN_FOREST_DIRE_HIT
	object_event 12, 27, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestMaxPotion, EVENT_VIRIDIAN_FOREST_MAX_POTION
	object_event 25, 25, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestRevivalHerb, EVENT_VIRIDIAN_FOREST_REVIVAL_HERB
	object_event 22, 25, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestAntidote, EVENT_VIRIDIAN_FOREST_ANTIDOTE
	object_event  2, 24, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, ViridianGSBall, EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	object_event 22, 38, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianForestLostKidScript, EVENT_FOUGHT_ZAPDOS
	object_event  2, 26, SPRITE_ZAPDOS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianForest_ZapdosAssaultsPlayer, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
