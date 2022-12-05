	object_const_def
	const SILVERCAVEROOM3_RED
	const SILVERCAVEROOM3_PIKACHU

SilverCaveRoom3_MapScripts:
	def_scene_scripts
	scene_script .MeetRed ; SCENE_DEFAULT

	def_callbacks

.MeetRed:
	disappear SILVERCAVEROOM3_PIKACHU
	end

Red:
	special FadeOutMusic
	faceplayer
	opentext
	writetext RedSeenText
	waitbutton
	closetext
	winlosstext RedWinLossText, RedWinLossText
	loadtrainer RED, RED1
	startbattle
	dontrestartmapmusic
	appear SILVERCAVEROOM3_PIKACHU
	reloadmapafterbattle
	special FadeOutMusic
	turnobject SILVERCAVEROOM3_RED, DOWN
	opentext
	writetext RedLeavesText
	waitbutton
	closetext
	pause 30
	turnobject SILVERCAVEROOM3_RED, UP
	pause 20
	showemote EMOTE_SHOCK, SILVERCAVEROOM3_PIKACHU, 15
	opentext
	writetext RedLeavesText2
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	specialphonecall SPECIALCALL_MISSION_COMPLETE
	setflag ENGINE_DISPLAY_YEAR_AT_START
	clearevent EVENT_RED_BEATEN
	setevent EVENT_RED_IN_MT_SILVER
	clearevent EVENT_REDS_PIKACHU_AVAILABLE
	disappear SILVERCAVEROOM3_RED
	pause 15
	special FadeInQuickly
	pause 15
	showemote EMOTE_QUESTION, SILVERCAVEROOM3_PIKACHU, 30
	pause 180
	special HealParty
	refreshscreen
	credits
	end

RedSeenText:
	text "<……>"
	line "<……>"
	done

RedWinLossText:
	text "…"
	done

RedLeavesText:
	text "<……>"
	line "<……>"

	para "*COUGH COUGH*" ; Damien
	line "*COUGH COUGH*" ; Damien
	done
	
RedLeavesText2:
	text "…Red collapses" ; Damien
	line "to the ground…" ; Damien
	done

SilverCaveRoom3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 33, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  10, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER
	object_event  10, 10, SPRITE_PIKACHU, SPRITEMOVEDATA_STILL, 1, 1, -1, -1, PAL_BG_YELLOW, OBJECTTYPE_SCRIPT, 0, -1, EVENT_RED_IN_MT_SILVER
