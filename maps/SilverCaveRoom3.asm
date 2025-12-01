	object_const_def
	const SILVERCAVEROOM3_RED
	const SILVERCAVEROOM3_PIKACHU
	const SILVERCAVEROOM3_PLAYER_M
	const SILVERCAVEROOM3_PLAYER_F

SilverCaveRoom3_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .HidePikachu

.HidePikachu:
	disappear SILVERCAVEROOM3_PIKACHU
	disappear SILVERCAVEROOM3_PLAYER_M
	disappear SILVERCAVEROOM3_PLAYER_F
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iffalse .end_callback
	readmem wPlayerGender
	ifequal 0, .Male

	appear SILVERCAVEROOM3_PLAYER_F
	endcallback

.Male
	appear SILVERCAVEROOM3_PLAYER_M
.end_callback
	endcallback

Red:
	special FadeOutMusic
	
	readmem wPlayerGender
	ifequal 0, .male_intro
; female_intro

	setlasttalked SILVERCAVEROOM3_PLAYER_F
	sjump .intro_check_facing

.male_intro
	setlasttalked SILVERCAVEROOM3_PLAYER_M

.intro_check_facing
	readvar VAR_FACING
	ifequal LEFT, .left_intro
	ifequal RIGHT, .right_intro
	ifequal UP, .up_intro

; Down intro
	moveobject LAST_TALKED, 9, 6
	setval SPRITEMOVEDATA_STANDING_DOWN
	writemem wMap3ObjectMovement
	writemem wMap4ObjectMovement
	appear LAST_TALKED
	applymovement PLAYER, HideObjectMovement
	applymovement PLAYER, Slow_walk_down_movement
	sjump .red_action

.left_intro
	moveobject LAST_TALKED, 11, 8
	setval SPRITEMOVEDATA_STANDING_LEFT
	writemem wMap3ObjectMovement
	writemem wMap4ObjectMovement
	appear LAST_TALKED
	applymovement PLAYER, HideObjectMovement
	applymovement PLAYER, Slow_walk_left_movement
	sjump .red_action

.right_intro
	appear LAST_TALKED
	applymovement PLAYER, HideObjectMovement
	applymovement PLAYER, Slow_walk_right_movement
	sjump .red_action

	
.up_intro
	moveobject LAST_TALKED, 9, 10
	setval SPRITEMOVEDATA_STANDING_UP
	writemem wMap3ObjectMovement
	writemem wMap4ObjectMovement
	appear LAST_TALKED
	applymovement PLAYER, HideObjectMovement
	applymovement PLAYER, Slow_walk_up_movement

.red_action
	setlasttalked SILVERCAVEROOM3_RED
	pause 15

	faceplayer
	pause 15

	opentext
	writetext RedSeenText
	waitbutton
	closetext
	loadmem wBattlePokerusSeed, POKERUS_ALPHA_STRAIN
	winlosstext RedWinLossText, RedWinLossText
	loadtrainer RED, RED1
	startbattle
	dontrestartmapmusic

	; Red's death cutscene.
	appear SILVERCAVEROOM3_PIKACHU

	disappear SILVERCAVEROOM3_RED
	moveobject SILVERCAVEROOM3_RED, 11, 8
	appear SILVERCAVEROOM3_RED
	turnobject SILVERCAVEROOM3_RED, LEFT

	disappear SILVERCAVEROOM3_PLAYER_M
	disappear SILVERCAVEROOM3_PLAYER_F
	moveobject SILVERCAVEROOM3_PLAYER_M, 8, 8
	moveobject SILVERCAVEROOM3_PLAYER_F, 8, 8

	setval SPRITEMOVEDATA_STANDING_RIGHT
	writemem wMap3ObjectMovement
	writemem wMap4ObjectMovement

	readmem wPlayerGender
	ifequal 0, .Male_outro

	appear SILVERCAVEROOM3_PLAYER_F
	sjump .outro_char_appeared

.Male_outro
	appear SILVERCAVEROOM3_PLAYER_M
.outro_char_appeared	
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	reloadmapafterbattle

	special FadeOutMusic
	loadmem wKantoAddLevel, 22

	readvar VAR_FACING
	ifequal LEFT, .left_outro
	ifequal RIGHT, .right_outro
	ifequal UP, .up_outro

; Down intro
	applymovement PLAYER, Slow_walk_down_movement
	sjump .red_outro

.left_outro
	applymovement PLAYER, Slow_walk_left_movement
	sjump .red_outro

.right_outro
	applymovement PLAYER, Slow_walk_right_movement
	sjump .red_outro

	
.up_outro
	applymovement PLAYER, Slow_walk_up_movement
.red_outro
	pause 70
	turnobject SILVERCAVEROOM3_RED, DOWN
	pause 70

	loadmem wDyingFrameSetIndex, 0
	callasm LoadDyingRedNextGFX ; Load next sprite set.
	setval SFX_NOT_VERY_EFFECTIVE
	scall RedCough1

	pause 20
	showemote EMOTE_SHOCK, SILVERCAVEROOM3_PIKACHU, 20
	turnobject SILVERCAVEROOM3_PIKACHU, RIGHT
	pause 20
	opentext
	writetext RedLeavesText
	pause 45
	closetext

	setval SFX_NOT_VERY_EFFECTIVE
	scall RedCough2
	pause 36

	callasm LoadDyingRedNextGFX ; Load next sprite set.
	setval SFX_MEGA_KICK
	scall RedCough1
	pause 45
	scall RedCough2
	pause 45
	setval SFX_SUBMISSION
	scall RedCough3
	pause 100

	callasm LoadDyingRedNextGFX ; Load next sprite set.
	pause 2
	loadmem wObject1SpriteX, $61 ; +6
	turnobject SILVERCAVEROOM3_RED, UP
	pause 4
	playsound SFX_TACKLE
	loadmem wObject1SpriteX, $66 ; +6
	loadmem wObject1SpriteY, $42 ; +2
	turnobject SILVERCAVEROOM3_RED, LEFT
	waitsfx
	pause 60
	showemote EMOTE_QUESTION, SILVERCAVEROOM3_PIKACHU, 20
	waitsfx
	;pause 80
	;cry PIKACHU
	;waitsfx
	pause 100
	applymovement SILVERCAVEROOM3_PIKACHU, DeathCheckPikachuMovement
	;playsound SFX_INTRO_SUICUNE_2
	applymovement SILVERCAVEROOM3_PIKACHU, DeathCheckPikachuMovement2

	specialphonecall SPECIALCALL_MISSION_COMPLETE
	setflag ENGINE_DISPLAY_YEAR_AT_START
	loadmem wYearMonth, $20 ; January 2022.
	clearevent EVENT_RED_BEATEN
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
	setevent EVENT_GOLDENROD_BEATER
	setevent EVENT_RED_IN_MT_SILVER
	setevent EVENT_LORELEI_WANTS_TO_TALK
	clearevent EVENT_REDS_PIKACHU_AVAILABLE
	pause 150
	special HealParty
	refreshscreen
	; End of cutscene.

	loadmem wCreditsType, CREDITS_RED
	credits
	end

RedCough2:
	turnobject SILVERCAVEROOM3_RED, UP
	playsound SFX_FROM_MEM
	pause 6
	turnobject SILVERCAVEROOM3_RED, DOWN
	pause 12
RedCough1:
	turnobject SILVERCAVEROOM3_RED, UP
	playsound SFX_FROM_MEM
	pause 6
	turnobject SILVERCAVEROOM3_RED, DOWN
	pause 12
	turnobject SILVERCAVEROOM3_RED, UP
	playsound SFX_FROM_MEM
	pause 6
	turnobject SILVERCAVEROOM3_RED, DOWN
	end

RedCough3:
	turnobject SILVERCAVEROOM3_RED, UP
	playsound SFX_FROM_MEM
	pause 10
	turnobject SILVERCAVEROOM3_RED, DOWN
	pause 6
	turnobject SILVERCAVEROOM3_RED, UP
	playsound SFX_FROM_MEM
	pause 14
	turnobject SILVERCAVEROOM3_RED, DOWN
	pause 6
	turnobject SILVERCAVEROOM3_RED, UP
	playsound SFX_FROM_MEM
	pause 18
	turnobject SILVERCAVEROOM3_RED, DOWN
	end

Slow_walk_up_movement:
	slow_step UP
	step_end

Slow_walk_down_movement:
	slow_step DOWN
	step_end

Slow_walk_left_movement:
	slow_step LEFT
	step_end

Slow_walk_right_movement:
	slow_step RIGHT
	step_end

ShowObjectMovement:
	show_object
	step_end

HideObjectMovement:
	hide_object
	step_end

DeathCheckPikachuMovement:
	slow_step DOWN
	slow_step RIGHT
	turn_head UP
	step_sleep 40
	fix_facing
	slow_step DOWN
	step_sleep 15
	remove_fixed_facing
	step_end

DeathCheckPikachuMovement2:
	big_step LEFT
	big_step LEFT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end
	

RedSeenText:
	text "<……>"
	line "<……>"
	done

RedWinLossText:
	text "…"
	done

RedLeavesText:
if DEF(_FR_FR)
	text "*TOUSSE TOUSSE*"
	line "*TOUSSE TOUSSE*"
else
	text "*COUGH COUGH*"
	line "*COUGH COUGH*"
endc
	done

SilverCaveRoom3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 31, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  8, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER
	object_event 10,  8, SPRITE_WALKING_PIKACHU, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  7,  8, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event  7,  8, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
