	object_const_def
	const EUSINEHOUSE_EUSINE

EusineHouse_MapScripts:
	def_scene_scripts

	def_callbacks

EusineHouse_Eusine:
	faceplayer
	opentext
	checkevent EVENT_GOT_MASTERBALL
	iftrue .SkipMasterball

	writetext CeladonEusineText1
	promptbutton
	verbosegiveitem MASTER_BALL
	writetext CeladonEusineText2
	waitbutton
	closetext
	setevent EVENT_GOT_MASTERBALL
	end

.SkipMasterball
	special BeastsCheck
	iftrue .HoOh

	writetext NoBeastsText
	waitbutton
	closetext
	end

.HoOh:
	writetext EusineLeavesCeladonText
	waitbutton
	closetext
	applymovement EUSINEHOUSE_EUSINE, .Movement
	disappear EUSINEHOUSE_EUSINE
	playsound SFX_EXIT_BUILDING
	waitsfx
	end

.Movement:
	step LEFT
	step DOWN
	step DOWN
	step_end

EusineHouseBookshelf:
	jumpstd DifficultBookshelfScript

CeladonEusineText1: ; TO TRANSLATE
	text "EUSINE: Hi!"

	para "I brought SUICUNE's"
	line "water sample to"
	cont "SILPH CO."

	para "And oh boy, were"
	line "they happy about"
	cont "it!"

	para "They showed their"
	line "gratitude by"
	cont "offering me this."
	done

CeladonEusineText2: ; TO TRANSLATE
	text "I never thanked"
	line "you for finding"
	cont "SUICUNE, so"

	para "please accept this"
	line "MASTER BALL."

	para "It's a prototype"
	line "# BALL that can"
	cont "catch any #MON"

	para "with a 100<PERCENT>"
	line "success rate."

	para "Use it wisely."
	line "Not on a RATTATA."
	done

EusineLeavesCeladonText: ; AUTOTRAD
	text "<PLAYER>, have you"
	line "heard?"

	para "There have been"
	line "fresh rumors of a"

	para "rainbow-colored"
	line "#MON appearing"
	cont "at TIN TOWER."

	para "I've just had my"
	line "party healed, so"

	para "now I'm headed to"
	line "ECRUTEAK."

	para "I'll be seeing"
	line "you, <PLAYER>!"
	done

NoBeastsText: ; AUTOTRAD
	text "Oh, by the way,"
	line "<PLAYER>."

	para "Have you caught"
	line "the legendary"

	para "#MON RAIKOU and"
	line "ENTEI?"

	para "<……><……><……>"

	para "Okay…"

	para "If you catch even"
	line "one, I hope that"
	cont "you'll inform me."

	para "I'm counting on"
	line "you, <PLAYER>!"
	done

EusineHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 11
	warp_event  3,  7, CELADON_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, EusineHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, EusineHouseBookshelf

	def_object_events
	object_event  4,  5, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EusineHouse_Eusine, EVENT_EUSINE_IN_CELADON
