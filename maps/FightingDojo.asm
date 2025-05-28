	object_const_def
	const FIGHTINGDOJO_BLACK_BELT
	const FIGHTINGDOJO_POKE_BALL

FightingDojo_MapScripts:
	def_scene_scripts

	def_callbacks

FightingDojoBlackBelt:
	jumptextfaceplayer FightingDojoBlackBeltText

FightingDojoSign1:
	jumptext FightingDojoSign1Text

FightingDojoSign2:
	jumptext FightingDojoSign2Text

FightingDojoFocusBand:
	itemball FOCUS_BAND

FightingDojoBlackBeltText: 
if DEF(_FR_FR)
	text "Bonjour!"

	para "Le ROI du KARATE,"
	line "le maître du DOJO"

	para "est dans une grot-"
	line "te de JOHTO pour"
	cont "s'entraîner."
else
	text "Hello!"

	para "KARATE KING, the"
	line "FIGHTING DOJO's"

	para "master, is in a"
	line "cave in JOHTO for"
	cont "training."
endc

	done

FightingDojoSign1Text: 
if DEF(_FR_FR)
	text "Le riz il est"
	line "cuit!"
	cont "(proverbe)"
else
	text "What goes around"
	line "comes around!"
endc

	done

FightingDojoSign2Text: 
if DEF(_FR_FR)
	text "Tape aussi fort"
	line "que t'es beau!"
	cont "(proverbe)"
else
	text "Enemies on every"
	line "side!"
endc

	done

FightingDojo_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, SAFFRON_CITY, 1
	warp_event  5, 11, SAFFRON_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  4,  0, BGEVENT_READ, FightingDojoSign1
	bg_event  5,  0, BGEVENT_READ, FightingDojoSign2

	def_object_events
	object_event  4,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FightingDojoBlackBelt, -1
	object_event  3,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, FightingDojoFocusBand, EVENT_PICKED_UP_FOCUS_BAND
