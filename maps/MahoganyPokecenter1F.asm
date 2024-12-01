	object_const_def
	const MAHOGANYPOKECENTER1F_NURSE
	const MAHOGANYPOKECENTER1F_POKEFAN_M
	const MAHOGANYPOKECENTER1F_YOUNGSTER
	const MAHOGANYPOKECENTER1F_COOLTRAINER_F

MahoganyPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .MahoganyPokecenter1F_AntiSoftLock

.MahoganyPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

MahoganyPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

MahoganyPokecenter1FPokefanMScript:
	jumptextfaceplayer MahoganyPokecenter1FPokefanMText

MahoganyPokecenter1FYoungsterScript:
	jumptextfaceplayer MahoganyPokecenter1FYoungsterText

MahoganyPokecenter1FCooltrainerFScript:
	jumptextfaceplayer MahoganyPokecenter1FCooltrainerFText

MahoganyPokecenter1FRocketScript:
	faceplayer
	jumptext MahoganyPokecenter1FRocketText

MahoganyPokecenter1FPokefanMText:
	text "What's this? TEAM"
	line "ROCKET has come"
	cont "back?"

	para "I saw some men in"
	line "black at LAKE OF"
	cont "RAGE…"
	done

MahoganyPokecenter1FYoungsterText:
	text "I stop my #MON"
	line "from evolving too"
	cont "early."

	para "I make them learn"
	line "certain moves be-"
	cont "fore I let them"
	cont "evolve."
	done

MahoganyPokecenter1FCooltrainerFText:
	text "#MON do become"
	line "stronger when they"

	para "evolve, but they"
	line "also learn moves"
	cont "more slowly."
	done

MahoganyPokecenter1FRocketText:
	text "Hear it from"
	line "someone that has"

	para "experience with"
	line "the police:"

	para "if they are after"
	line "you, hide for a"
	cont "about day."
	
	para "Then they'll"
	line "forget about you."
	done

MahoganyPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, MAHOGANY_TOWN, 4
	warp_event  4,  7, MAHOGANY_TOWN, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyPokecenter1FNurseScript, -1
	object_event  7,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MahoganyPokecenter1FPokefanMScript, -1
	object_event  1,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MahoganyPokecenter1FYoungsterScript, -1
	object_event  2,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyPokecenter1FCooltrainerFScript, -1
	object_event  9,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyPokecenter1FRocketScript, EVENT_TEAM_ROCKET_BASE_POPULATION