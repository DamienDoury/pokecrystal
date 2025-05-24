	object_const_def
	const CIANWOODPOKECENTER1F_NURSE
	const CIANWOODPOKECENTER1F_LASS
	const CIANWOODPOKECENTER1F_GYM_GUIDE
	const CIANWOODPOKECENTER1F_SUPER_NERD
	const CIANWOODPOKECENTER1F_FISHING_GURU

CianwoodPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, CianwoodPokecenter1F_AntiSoftLockChecks

CianwoodPokecenter1F_AntiSoftLockChecks:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	farscall CinnabarPokecenter1f_OldRodGuy

AntiSoftLockPokeball:
	checkflag ENGINE_FREE_EMERGENCY_POKEBALL_SENT
	iftrue .end_callback

	checkitem HM_CUT ; We don't want to babysit the player too much. So we'll only help once it's absolutely required.
	iffalse .end_callback

	checkphonecall
	iftrue .end_callback ; Don't override another phone call. This one is low priority.

	readmem wNumBalls
	ifgreater 0, .end_callback

	readvar VAR_MAPGROUP
	ifequal GROUP_CIANWOOD_CITY, .skip_money_check
	ifequal GROUP_CINNABAR_ISLAND, .skip_money_check

	checkmoney YOUR_MONEY, 599
	ifequal HAVE_MORE, .end_callback

.skip_money_check
	specialphonecall SPECIALCALL_ANTI_SOFTLOCK_POKEBALL

.end_callback
	endcallback


	

CianwoodPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

CianwoodPokecenter1FLassScript:
	jumptextfaceplayer CianwoodPokecenter1FLassText

CianwoodGymGuideDudeScript:
	faceplayer
	checkevent EVENT_BEAT_CHUCK
	iftrue .CianwoodGymGuideDudeWinScript
	opentext
	writetext CianwoodGymGuideDudeText
	waitbutton
	closetext
	end

.CianwoodGymGuideDudeWinScript:
	opentext
	writetext CianwoodGymGuideDudeWinText
	waitbutton
	closetext
	showemote EMOTE_HAPPY, CIANWOODPOKECENTER1F_GYM_GUIDE, 20
	end

CianwoodPokecenter1FSuperNerdScript:
	jumptextfaceplayer CianwoodPokecenter1FSuperNerdText

CianwoodPokecenter1FFishingGuruScript:
	farsjump Route32Pokecenter1FFishingGuruScript

CianwoodPokecenter1FLassText: ; AUTOTRAD
	text "Did you meet the"
	line "#MANIAC?"

	para "He's always brag-"
	line "ging about his"
	cont "rare #MON."
	done

CianwoodGymGuideDudeText: ; TO TRANSLATE
	text "The #MON GYM"
	line "trainers here are"
	cont "macho bullies."

	para "If I stick around,"
	line "they might come"
	cont "after me."

	para "Here's some ad-"
	line "vice: the GYM"

	para "LEADER uses the"
	line "fighting-type."

	para "So you should"
	line "confound him with"
	cont "psychic moves."

	para "And those boulders"
	line "in the middle of"
	cont "the GYM?"

	para "If you don't move"
	line "them correctly,"

	para "you won't reach"
	line "the GYM LEADER."

	para "If you get stuck,"
	line "go outside."
	done

CianwoodGymGuideDudeWinText: ; TO TRANSLATE
	text "<PLAYER>! You won!"
	line "I could tell by"
	cont "looking at you!"
	cont "You're my hero!"

	done

CianwoodPokecenter1FUnusedText1: ; unreferenced
	text "Don't you get the"
	line "urge to show off"

	para "your #MON to"
	line "friends?"

	para "I wish I could"
	line "show the #MON I"

	para "raised to my pal"
	line "in VIOLET."
	done

CianwoodPokecenter1FUnusedText2: ; unreferenced
	text "I've been battling"
	line "my pal in VIOLET"

	para "using a MOBILE"
	line "ADAPTER link."

	para "I'm down 5-7"
	line "against him. I've"
	cont "gotta crank it up!"
	done

CianwoodPokecenter1FSuperNerdText: ; AUTOTRAD
	text "I love showing off"
	line "the #MON that"

	para "I've raised."
	line "Don't you?"

	para "I'm going to get"
	line "into a bunch of"

	para "battles, and show"
	line "off my #MON!"
	done

CianwoodPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, CIANWOOD_CITY, 3
	warp_event  4,  7, CIANWOOD_CITY, 3
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodPokecenter1FNurseScript, -1
	object_event  1,  5, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CianwoodPokecenter1FLassScript, -1
	object_event  5,  3, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodGymGuideDudeScript, -1
	object_event  8,  6, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CianwoodPokecenter1FSuperNerdScript, -1
	object_event  4,  5, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CianwoodPokecenter1FFishingGuruScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	