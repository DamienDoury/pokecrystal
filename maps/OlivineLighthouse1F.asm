	object_const_def
	const OLIVINELIGHTHOUSE1F_SAILOR
	const OLIVINELIGHTHOUSE1F_POKEFAN_F

OlivineLighthouse1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	
.EnterCallback:
	readvar VAR_YCOORD
	ifnotequal 17, .CheckCurfewWhenEntered

	readmem wCurFreedomState
	writemem wFreedomStateWhenEntered

.CheckCurfewWhenEntered
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.EndCallback:
	endcallback

OlivineLighthouse1FSailorScript:
	checkflag ENGINE_FLYPOINT_VERMILION
	iftrue .after_vaccine_pass
	jumptextfaceplayer OlivineLighthouse1FSailorLockdownText

.after_vaccine_pass
	jumptextfaceplayer OlivineLighthouse1FSailorFreedomText

OlivineLighthouse1FPokefanFScript:
	jumptextfaceplayer OlivineLighthouse1FPokefanFText

OlivineLighthouse1FSailorLockdownText:
	text "Most people in"
	line "this place work"
	cont "here."

	para "But some of them"
	line "snuck in here to"
	cont "escape the stay-"
	cont "at-home order."

	para "I bet this is how"
	line "AMPHY got sick."
	done

OlivineLighthouse1FSailorFreedomText:
	text "Some people used"
	line "to sneak in here"
	cont "to avoid the stay-"
	cont "at-home order."

	para "I hold them res-"
	line "ponsible for what"
	cont "happened to AMPHY."
	done

OlivineLighthouse1FPokefanFText:
	text "In the past, #-"
	line "MON used to light"

	para "the sea around"
	line "OLIVINE at night."

	para "The LIGHTHOUSE was"
	line "made in honor of"
	cont "those #MON."
	done

OlivineLighthouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 10, 17, OLIVINE_CITY, 9
	warp_event 11, 17, OLIVINE_CITY, 9
	warp_event  3, 11, OLIVINE_LIGHTHOUSE_2F, 1
	warp_event 16, 13, OLIVINE_LIGHTHOUSE_2F, 3
	warp_event 17, 13, OLIVINE_LIGHTHOUSE_2F, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineLighthouse1FSailorScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 16,  9, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineLighthouse1FPokefanFScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
