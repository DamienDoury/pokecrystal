	object_const_def
	const CHERRYGROVEPOKECENTER1F_NURSE
	const CHERRYGROVEPOKECENTER1F_FISHER
	const CHERRYGROVEPOKECENTER1F_GENTLEMAN
	const CHERRYGROVEPOKECENTER1F_TEACHER

CherrygrovePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CherrygrovePokecenter1F_AntiSoftLock

.CherrygrovePokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

CherrygrovePokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

CherrygrovePokecenter1FFisherScript:
	jumptextfaceplayer CherrygrovePokecenter1FFisherText

CherrygrovePokecenter1FGentlemanScript:
	jumptextfaceplayer CherrygrovePokecenter1FGentlemanText

CherrygrovePokecenter1FTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .CommCenterOpen
	writetext CherrygrovePokecenter1FTeacherText
	waitbutton
	closetext
	end

.CommCenterOpen:
	writetext CherrygrovePokecenter1FTeacherText_CommCenterOpen
	waitbutton
	closetext
	end

CherrygrovePokecenter1FFisherText: 
if DEF(_FR_FR)
	text "C'est super. Je"
	line "peux stocker"

	para "autant de #MON"
	line "que je veux et"
	cont "c'est gratuit."
else
	text "It's great. I can"
	line "store any number"

	para "of #MON, and"
	line "it's all free."
endc

	done

CherrygrovePokecenter1FGentlemanText: 
if DEF(_FR_FR)
	text "Ce PC est en libre"
	line "service pour les"
	cont "dresseurs."
else
	text "That PC is free"
	line "for any trainer"
	cont "to use."
endc

	done

CherrygrovePokecenter1FTeacherText: 
if DEF(_FR_FR)
	text "Le CENTRE de"
	line "COMMUNICATION"
	cont "d'au-dessus vient"
	cont "d'être construit."

	para "Mais ils le peau-"
	line "finent encore."
else
	text "The COMMUNICATION"
	line "CENTER upstairs"
	cont "was just built."

	para "But they're still"
	line "finishing it up."
endc

	done

CherrygrovePokecenter1FTeacherText_CommCenterOpen: 
if DEF(_FR_FR)
	text "Le CENTRE de"
	line "COMMUNICATION"
	cont "d'au-dessus vient"
	cont "d'être construit."

	para "J'y ai échangé"
	line "des #MON!"
else
	text "The COMMUNICATION"
	line "CENTER upstairs"
	cont "was just built."

	para "I traded #MON"
	line "there already!"
endc

	done

CherrygrovePokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, CHERRYGROVE_CITY, 2
	warp_event  4,  7, CHERRYGROVE_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FNurseScript, -1
	object_event  2,  3, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FFisherScript, -1
	object_event  8,  6, SPRITE_GENTLEMAN, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FGentlemanScript, -1
	object_event  1,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FTeacherScript, -1
