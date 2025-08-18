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

EusineHouseRadio:
	jumpstd Radio3Script

CeladonEusineText1:
if DEF(_FR_FR)
	text "EUSINE: Salut!"

	para "J'ai apporté un"
	line "échantillon d'eau"
	cont "de SUICUNE à la"
	cont "SYLPHE SARL."

	para "Et alors là, ils"
	line "étaient aux anges!"

	para "Ils ont montré"
	line "leur gratitude en"
	cont "m'offrant ceci."
else
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
endc
	done

CeladonEusineText2:
if DEF(_FR_FR)
	text "Je ne t'ai jamais"
	line "remercié d'avoir"
	cont "trouvé SUICUNE,"

	para "alors accepte"
	line "cette MASTER BALL."

	para "C'est un proto-"
	line "type de # BALL"
	cont "qui capture tout"
	cont "#MON avec un"

	para "taux de succès"
	line "de 100<PERCENT>."

	para "Utilise-la avec"
	line "sagesse. Pas sur"
	cont "un RATTATA stp."
else
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
endc
	done

EusineLeavesCeladonText:
if DEF(_FR_FR)
	text "<PLAYER>, es-tu"
	line "au courant?"

	para "On raconte qu'un"
	line "#MON aux cou-"

	para "leurs de l'arc-"
	line "en-ciel est apparu"
	cont "à la TOUR"
	cont "FERRAILLE."

	para "Je viens de soi-"
	line "gner mon équipe."

	para "Je retourne à"
	line "ROSALIA."

	para "A très bientôt,"
	line "<PLAYER>!"
else
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
endc

	done

NoBeastsText:
if DEF(_FR_FR)
	text "Au fait,"
	line "<PLAYER>."

	para "As-tu attrapé les"
	line "#MON légendai-"

	para "res RAIKOU et"
	line "ENTEI?"

	para "<……><……><……>"

	para "D'accord..."

	para "Si tu en attrapes"
	line "un, préviens-moi."

	para "Je compte sur toi,"
	line "<PLAYER>!"
else
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
endc

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
	bg_event  7,  1, BGEVENT_READ, EusineHouseRadio

	def_object_events
	object_event  4,  5, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EusineHouse_Eusine, EVENT_EUSINE_IN_CELADON
