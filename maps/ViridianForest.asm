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
	itemball BIG_ROOT

ViridianForestMiracleSeed:
	itemball MIRACLE_SEED

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
	setlasttalked VIRIDIAN_FOREST_ZAPDOS
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
	end
	
ViridianGSBall:
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	disappear VIRIDIAN_FOREST_GS_BALL ; also does setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	
	opentext
	giveitem GS_BALL
	writetext ViridianForest_FoundGSBallText
	playsound SFX_KEY_ITEM
	waitsfx
	waitbutton
	itemnotify
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
if DEF(_FR_FR)
	text "A l'aide!"
	
	para "Je suis perdu ici"
	line "depuis des jours."

	para "C'est comme si la"
	line "forêt bougeait..."

	para "Je survis en man-"
	line "geant des baies."

	para "Trouve ce qui"
	line "cloche avec la"
	cont "forêt!"
else
	text "Please help!"
	
	para "I've been lost"
	line "for days."

	para "It's like the"
	line "forest is moving…"

	para "I'm surviving"
	line "off berries."

	para "Find what's wrong"
	line "with the forest!"
endc
	done

ViridianForest_PeacefulText:
if DEF(_FR_FR)
	text "La forêt est en"
	line "paix désormais."
else
	text "The forest is"
	line "at peace now."
endc
	done

ViridianForest_FoundGSBallText:
if DEF(_FR_FR)
	text "<PLAYER> trouve"
	line "la GS BALL."
else
	text "<PLAYER> found"
	line "the GS BALL."
endc
	done

ViridianForest_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  5, ROUTE_2, 6
	warp_event  1,  5, ROUTE_2, 7

	warp_event 24, 56, ROUTE_2, 8
	warp_event 25, 56, ROUTE_2, 9

;	; Vertical warps.
;	warp_event  0, 10, VIRIDIAN_CITY, 1
;	warp_event  1, 10, VIRIDIAN_CITY, 1
;	warp_event  0, 11, VIRIDIAN_CITY, 1
;	warp_event  1, 11, VIRIDIAN_CITY, 1
;
;	warp_event 18, 10, VIRIDIAN_CITY, 1
;	warp_event 19, 10, VIRIDIAN_CITY, 1
;	warp_event 18, 11, VIRIDIAN_CITY, 1
;	warp_event 19, 11, VIRIDIAN_CITY, 1
;
;	warp_event 32, 30, VIRIDIAN_CITY, 1
;	warp_event 33, 30, VIRIDIAN_CITY, 1
;	warp_event 32, 31, VIRIDIAN_CITY, 1
;	warp_event 33, 31, VIRIDIAN_CITY, 1
;
;	warp_event 40, 30, VIRIDIAN_CITY, 1
;	warp_event 41, 30, VIRIDIAN_CITY, 1
;	warp_event 40, 31, VIRIDIAN_CITY, 1
;	warp_event 41, 31, VIRIDIAN_CITY, 1
;
;	warp_event 16, 44, VIRIDIAN_CITY, 1
;	warp_event 17, 44, VIRIDIAN_CITY, 1
;	warp_event 16, 45, VIRIDIAN_CITY, 1
;	warp_event 17, 45, VIRIDIAN_CITY, 1
;
;	warp_event 24, 44, VIRIDIAN_CITY, 1
;	warp_event 25, 44, VIRIDIAN_CITY, 1
;	warp_event 24, 45, VIRIDIAN_CITY, 1
;	warp_event 25, 45, VIRIDIAN_CITY, 1
;
;	warp_event 32, 18, VIRIDIAN_CITY, 1
;	warp_event 33, 18, VIRIDIAN_CITY, 1
;	warp_event 32, 19, VIRIDIAN_CITY, 1
;	warp_event 33, 19, VIRIDIAN_CITY, 1
;
;	warp_event 32, 42, VIRIDIAN_CITY, 1
;	warp_event 33, 42, VIRIDIAN_CITY, 1
;	warp_event 32, 43, VIRIDIAN_CITY, 1
;	warp_event 33, 43, VIRIDIAN_CITY, 1
;
;	; Horizontal warps.
;	warp_event 32,  4, VIRIDIAN_CITY, 1
;	warp_event 33,  4, VIRIDIAN_CITY, 1
;	warp_event 32,  5, VIRIDIAN_CITY, 1
;	warp_event 33,  5, VIRIDIAN_CITY, 1
;
;	warp_event 14, 32, VIRIDIAN_CITY, 1
;	warp_event 15, 32, VIRIDIAN_CITY, 1
;	warp_event 14, 33, VIRIDIAN_CITY, 1
;	warp_event 15, 33, VIRIDIAN_CITY, 1
;
;	warp_event  8, 38, VIRIDIAN_CITY, 1
;	warp_event  9, 38, VIRIDIAN_CITY, 1
;	warp_event  8, 39, VIRIDIAN_CITY, 1
;	warp_event  9, 39, VIRIDIAN_CITY, 1
;
;	warp_event  8, 50, VIRIDIAN_CITY, 1
;	warp_event  9, 50, VIRIDIAN_CITY, 1
;	warp_event  8, 51, VIRIDIAN_CITY, 1
;	warp_event  9, 51, VIRIDIAN_CITY, 1

	def_coord_events
	coord_event  2, 27, CE_EVENT_FLAG_CLEARED, EVENT_FOUGHT_ZAPDOS, ViridianForest_ZapdosAppears

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
	object_event 22, 25, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestMiracleSeed, EVENT_VIRIDIAN_FOREST_MIRACLE_SEED
	object_event  2, 24, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, ViridianGSBall, EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	object_event 22, 38, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianForestLostKidScript, EVENT_FOUGHT_ZAPDOS
	object_event  2, 26, SPRITE_ZAPDOS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, ViridianForest_ZapdosAssaultsPlayer, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
