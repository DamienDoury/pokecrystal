	object_const_def
	const AZALEAPOKECENTER1F_NURSE
	const AZALEAPOKECENTER1F_GENTLEMAN
	const AZALEAPOKECENTER1F_FISHING_GURU
	const AZALEAPOKECENTER1F_POKEFAN_F

AzaleaPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .AzaleaPokecenter1F_AntiSoftLock

.AzaleaPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

.DummyScene:
	end

AzaleaPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

AzaleaPokecenter1FGentlemanScript:
	jumptextfaceplayer AzaleaPokecenter1FGentlemanText

AzaleaPokecenter1FFishingGuruScript:
	jumptextfaceplayer AzaleaPokecenter1FFishingGuruText

AzaleaPokecenter1FPokefanFScript:
	jumptextfaceplayer AzaleaPokecenter1FPokefanFText

AzaleaPokecenter1FGentlemanText: ; TO TRANSLATE
	text "Do your #MON"
	line "know TM moves?"

	para "Those moves can"
	line "be taught inde-"
	cont "finitely."
	done

AzaleaPokecenter1FFishingGuruText: 
if DEF(_FR_FR)
	text "Le PC de LEO peut"
	line "garder jusqu'à 20"
	cont "#MON par BOITE."
else
	text "BILL's PC can"
	line "store up to 20"
	cont "#MON per BOX."
endc

	done

AzaleaPokecenter1FPokefanFText: 
if DEF(_FR_FR)
	text "Connais-tu les"
	line "NOIGRUMES?"

	para "Ouvres-en un,"
	line "vide-le et"

	para "remplis-le avec un"
	line "appareil spécial."

	para "Tu pourras alors"
	line "t'en servir pour"
	cont "attraper des"
	cont "#MON."

	para "Avant que les"
	line "# BALLS ne"

	para "soient inventées"
	line "tout le monde"
	cont "utilisait les"
	cont "NOIGRUMES."
else
	text "Do you know about"
	line "APRICORNS?"

	para "Crack one open,"
	line "hollow it out and"

	para "fit it with a"
	line "special device."

	para "Then you can catch"
	line "#MON with it."

	para "Before # BALLS"
	line "were invented,"

	para "everyone used"
	line "APRICORNS."
endc

	done

AzaleaPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 1
	warp_event  4,  7, AZALEA_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FNurseScript, -1
	object_event  9,  6, SPRITE_GENTLEMAN, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FGentlemanScript, -1
	object_event  6,  1, SPRITE_FISHING_GURU, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FFishingGuruScript, -1
	object_event  1,  4, SPRITE_POKEFAN_F, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 2, HIDE_CURFEW & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FPokefanFScript, -1
