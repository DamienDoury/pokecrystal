	object_const_def
	const FUCHSIAPOKECENTER1F_NURSE
	const FUCHSIAPOKECENTER1F_COOLTRAINER_M
	const FUCHSIAPOKECENTER1F_COOLTRAINER_F
	const FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR

FuchsiaPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .FuchsiaPokecenter1F_AntiSoftLock

.FuchsiaPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

.DummyScene:
	end

FuchsiaPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

FuchsiaPokecenter1FCooltrainerFScript:
	jumptextfaceplayer FuchsiaPokecenter1FCooltrainerFText

FuchsiaPokecenter1FJanineImpersonatorScript:
	faceplayer
	opentext
	writetext FuchsiaPokecenter1FJanineImpersonatorText1
	waitbutton
	closetext
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, FuchsiaPokecenter1FJanineImpersonatorSpinMovement
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_JANINE
	special LoadUsedSpritesGFX
	opentext
	writetext FuchsiaPokecenter1FJanineImpersonatorText2
	waitbutton
	closetext
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, FuchsiaPokecenter1FJanineImpersonatorSpinMovement
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_LASS
	special LoadUsedSpritesGFX
	end

FuchsiaPokecenter1FJanineImpersonatorSpinMovement:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

FuchsiaPokecenter1FCooltrainerFText: 
if DEF(_FR_FR)
	text "J'me suis fait"
	line "battre à l'ARENE."

	para "Toutes les filles"
	line "s'y ressemblent!"
else
	text "I got quite a"
	line "shock at the GYM."

	para "There were all"
	line "these girls who"
	cont "looked identical."
endc

	done

FuchsiaPokecenter1FJanineImpersonatorText1: 
if DEF(_FR_FR)
	text "J'suis JEANNINE!"
	line "Abracadabra!"
else
	text "I'm JANINE! Hocus-"
	line "pocus… Poof!"
endc

	done

FuchsiaPokecenter1FJanineImpersonatorText2: 
if DEF(_FR_FR)
	text "Tu vois? Je lui"
	line "ressemble, non?"
else
	text "See? I look just"
	line "like her now!"
endc

	done

FuchsiaPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, FUCHSIA_CITY, 5
	warp_event  4,  7, FUCHSIA_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaPokecenter1FNurseScript, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaPokecenter1FCooltrainerFScript, -1
	object_event  5,  3, SPRITE_JANINE_IMPERSONATOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FuchsiaPokecenter1FJanineImpersonatorScript, -1
