	object_const_def
	const VIOLETPOKECENTER1F_NURSE
	const VIOLETPOKECENTER1F_GAMEBOY_KID
	const VIOLETPOKECENTER1F_GENTLEMAN
	const VIOLETPOKECENTER1F_YOUNGSTER

VioletPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .VioletPokecenter1F_AntiSoftLock

.VioletPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

VioletPokecenterNurse:
	jumpstd PokecenterNurseScript

VioletPokecenter1FGameboyKidScript:
	faceplayer
	jumptext VioletPokecenter1FGameboyKidText

VioletPokecenter1FGentlemanScript:
	jumptextfaceplayer VioletPokecenter1FGentlemanText

VioletPokecenter1FYoungsterScript:
	jumptextfaceplayer VioletPokecenter1FYoungsterText

VioletPokecenter1FGameboyKidText: 
if DEF(_FR_FR)
	text "Un type du nom de"
	line "LEO a créé le"
	cont "système de stocka-"
	cont "ge de #MON."
else
	text "A guy named BILL"
	line "made the #MON"
	cont "PC storage system."
endc

	done

VioletPokecenter1FGentlemanText: 
if DEF(_FR_FR)
	text "Ca fait plus ou"
	line "moins trois ans."

	para "La TEAM ROCKET"
	line "était la pire en-"
	cont "nemie des #MON."

	para "Mais y'a une"
	line "justice! Un jeune"
	cont "gamin les a depuis"
	cont "détrônés."
else
	text "It was around"
	line "three years ago."

	para "TEAM ROCKET was up"
	line "to no good with"
	cont "#MON."

	para "But justice pre-"
	line "vailed--a young"
	cont "kid broke 'em up."
endc

	done

VioletPokecenter1FYoungsterText: 
if DEF(_FR_FR)
	text "Les #MON"
	line "sont intelligents."

	para "Ils n'obéissent"
	line "pas aux dresseurs"
	cont "qui ne les res-"
	cont "pectent pas."

	para "Sans les BADGES"
	line "appropriés, ils"

	para "n'en feront qu'à"
	line "leur tête."
else
	text "#MON are smart."
	line "They won't obey a"

	para "trainer they don't"
	line "respect."

	para "Without the right"
	line "GYM BADGES, they"

	para "will just do as"
	line "they please."
endc

	done

VioletPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 5
	warp_event  4,  7, VIOLET_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletPokecenterNurse, -1
	object_event  7,  6, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1FGameboyKidScript, -1
	object_event  1,  4, SPRITE_GENTLEMAN, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_CURFEW & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1FGentlemanScript, -1
	object_event  8,  1, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1FYoungsterScript, -1
