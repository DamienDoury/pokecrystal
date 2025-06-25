	object_const_def
	const BURNEDTOWERB1F_BOULDER
	const BURNEDTOWERB1F_RAIKOU1
	const BURNEDTOWERB1F_ENTEI1
	const BURNEDTOWERB1F_SUICUNE1
	const BURNEDTOWERB1F_RAIKOU2
	const BURNEDTOWERB1F_ENTEI2
	const BURNEDTOWERB1F_SUICUNE2
	const BURNEDTOWERB1F_POKE_BALL
	const BURNEDTOWERB1F_EUSINE

BurnedTowerB1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .LadderCallback

.LadderCallback:
	checkevent EVENT_BURNED_TOWER_1F_EUSINE
	iftrue .ShowLadder
	changeblock 6, 14, $02 ; floor
.ShowLadder:
	endcallback

ReleaseTheBeasts:
	playmusic MUSIC_NONE
	pause 30
	appear BURNEDTOWERB1F_RAIKOU1
	turnobject PLAYER, UP
	pause 5
	disappear BURNEDTOWERB1F_RAIKOU2
	pause 15
	cry RAIKOU
	appear BURNEDTOWERB1F_ENTEI1
	turnobject PLAYER, UP
	pause 5
	disappear BURNEDTOWERB1F_ENTEI2
	pause 15
	cry ENTEI
	appear BURNEDTOWERB1F_SUICUNE1
	turnobject PLAYER, UP
	pause 5
	disappear BURNEDTOWERB1F_SUICUNE2
	pause 15
	cry SUICUNE
	pause 15
	playsound SFX_WARP_FROM
	turnobject PLAYER, LEFT
	applymovement BURNEDTOWERB1F_RAIKOU1, BurnedTowerRaikouMovement
	disappear BURNEDTOWERB1F_RAIKOU1
	waitsfx
	playsound SFX_WARP_FROM
	turnobject PLAYER, RIGHT
	applymovement BURNEDTOWERB1F_ENTEI1, BurnedTowerEnteiMovement
	disappear BURNEDTOWERB1F_ENTEI1
	waitsfx
	pause 15
	playsound SFX_WARP_FROM
	turnobject PLAYER, UP
	applymovement BURNEDTOWERB1F_SUICUNE1, BurnedTowerSuicuneMovement1
	playsound SFX_WARP_FROM
	turnobject PLAYER, DOWN
	applymovement BURNEDTOWERB1F_SUICUNE1, BurnedTowerSuicuneMovement2
	turnobject PLAYER, UP
	pause 20
	cry SUICUNE
	pause 30
	playsound SFX_WARP_FROM
	applymovement BURNEDTOWERB1F_SUICUNE1, BurnedTowerSuicuneMovement3
	turnobject PLAYER, DOWN
	disappear BURNEDTOWERB1F_SUICUNE1
	waitsfx
	special RestartMapMusic
	setscene SCENE_FINISHED
	clearevent EVENT_ECRUTEAK_CITY_GRAMPS
	setevent EVENT_BURNED_TOWER_1F_EUSINE
	appear BURNEDTOWERB1F_EUSINE
	refreshscreen
	changeblock 6, 14, $1b ; ladder
	reloadmappart
	closetext
	end

BurnedTowerB1FEusine:
	faceplayer
	opentext
	writetext BurnedTowerB1FEusineText
	waitbutton
	closetext

	setevent EVENT_ECRUTEAK_GYM_GRAMPS
	setevent EVENT_BURNED_TOWER_MORTY
	setevent EVENT_RELEASED_THE_BEASTS
	special InitRoamMons
	setmapscene CIANWOOD_CITY, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE
	clearevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	
	readvar VAR_FACING
	ifequal UP, .Movement2
	applymovement BURNEDTOWERB1F_EUSINE, BurnedTowerB1FEusineMovement1
	sjump .Finish

.Movement2:
	applymovement BURNEDTOWERB1F_EUSINE, BurnedTowerB1FEusineMovement2
.Finish:
	disappear BURNEDTOWERB1F_EUSINE
	playsound SFX_EXIT_BUILDING
	waitsfx
	end

BurnedTowerB1FTMEndure:
	itemball TM_ENDURE

BurnedTowerB1FBoulder:
	jumpstd StrengthBoulderScript

BurnedTowerRaikouMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step LEFT
	remove_sliding
	step_end

BurnedTowerEnteiMovement:
	set_sliding
	fast_jump_step RIGHT
	fast_jump_step DOWN
	fast_jump_step RIGHT
	remove_sliding
	step_end

BurnedTowerSuicuneMovement1:
	set_sliding
	fast_jump_step RIGHT
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step LEFT
	remove_sliding
	step_end

BurnedTowerSuicuneMovement2:
	set_sliding
	fast_jump_step LEFT
	fast_jump_step UP
	big_step UP
	fast_jump_step RIGHT
	remove_sliding
	step_end

BurnedTowerUnusedMovement: ; unreferenced
	set_sliding
	big_step DOWN
	remove_sliding
	step_end

BurnedTowerSuicuneMovement3:
	set_sliding
	big_step UP
	fast_jump_step RIGHT
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step DOWN
	remove_sliding
	step_end

BurnedTowerB1FEusineMovement2:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step LEFT
	step DOWN
	step_end

BurnedTowerB1FEusineMovement1:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step_end

BurnedTowerB1FEusineText:
if DEF(_FR_FR)
	text "EUSINE: J'ai creu-"
	line "sé un trou ici..."

	para "Quel choc!"

	para "SUICUNE s'est mis"
	line "à débouler juste"
	cont "devant mes yeux!"

	para "Depuis des mois"
	line "je courais"

	para "après SUICUNE..."
	line "Enfin quelque"
	cont "chose!"

	para "La légende dit que"
	line "SUICUNE peut"
	
	para "purifier n'importe"
	line "quelle eau."

	para "Tu penses que son"
	line "pouvoir pourrait"
	
	para "être utilisé pour"
	line "se débarrasser du"

	para "virus qui donne"
	line "le COVID?"

	para "Je vais poursuivre"
	line "SUICUNE."

	para "<PLAYER>,"
	line "à très bientôt!"

	para "Au revoir!"
	done
else
	text "EUSINE: I dug a"
	line "hole here, too…"

	para "I was shocked!"

	para "SUICUNE raced by"
	line "like a blur, right"

	para "in front of my"
	line "eyes!"

	para "For months I"
	line "chased it,"

	para "and I finally got"
	line "to see it."

	para "Legends say that"
	line "SUICUNE can purify"
	
	para "any kind of"
	line "fouled water."

	para "Do you think its"
	line "powers could get"
	
	para "rid of the virus"
	line "that gives COVID?"

	para "I'm going to track"
	line "SUICUNE."

	para "<PLAYER>, let's"
	line "meet again!"

	para "Farewell!"
	done
endc

BurnedTowerB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 10,  9, BURNED_TOWER_1F, 3
	warp_event  7, 15, BURNED_TOWER_1F, 4

	def_coord_events
	coord_event 10,  6, CE_EVENT_FLAG_CLEARED, EVENT_BURNED_TOWER_1F_EUSINE, ReleaseTheBeasts

	def_bg_events

	def_object_events
	object_event 17,  8, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BurnedTowerB1FBoulder, -1
	object_event  7,  3, SPRITE_RAIKOU, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BURNED_TOWER_B1F_BEASTS_1
	object_event 12,  3, SPRITE_ENTEI, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BURNED_TOWER_B1F_BEASTS_1
	object_event 10,  4, SPRITE_SUICUNE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BURNED_TOWER_B1F_BEASTS_1
	object_event  7,  3, SPRITE_RAIKOU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_SILVER, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BURNED_TOWER_B1F_BEASTS_2
	object_event 12,  3, SPRITE_ENTEI, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_SILVER, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BURNED_TOWER_B1F_BEASTS_2
	object_event 10,  4, SPRITE_SUICUNE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_SILVER, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BURNED_TOWER_B1F_BEASTS_2
	object_event 16,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BurnedTowerB1FTMEndure, EVENT_BURNED_TOWER_B1F_TM_ENDURE
	object_event 10, 12, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BurnedTowerB1FEusine, EVENT_EUSINE_IN_BURNED_TOWER
