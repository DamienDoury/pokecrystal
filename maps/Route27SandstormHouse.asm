	object_const_def
	const ROUTE27SANDSTORMHOUSE_GRANNY

Route27SandstormHouse_MapScripts:
	def_scene_scripts

	def_callbacks

SandstormHouseWoman:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM37_SANDSTORM
	iftrue .AlreadyGotItem
	special GetFirstPokemonHappiness
	writetext SandstormHouseWomanText1
	promptbutton
	ifgreater 150 - 1, .Loyal
	sjump .Disloyal

.Loyal:
	writetext SandstormHouseWomanLoyalText
	promptbutton
	verbosegiveitem TM_SANDSTORM
	iffalse .Done
	setevent EVENT_GOT_TM37_SANDSTORM
.AlreadyGotItem:
	writetext SandstormHouseSandstormDescription
	waitbutton
.Done:
	closetext
	end

.Disloyal:
	writetext SandstormHouseWomanDisloyalText
	waitbutton
	closetext
	end

SandstormHouseBookshelf:
	jumpstd MagazineBookshelfScript

Route27SandstormHouse_Radio:
	jumpstd Radio3Script

SandstormHouseWomanText1: 
if DEF(_FR_FR)
	text "Où tu vas toi avec"
	line "tes #MON?"

	para "La LIGUE #MON?"

	para "Tes #MON sont"
	line "assez confiants"
	cont "pour y aller?"

	para "On va voir..."
else
	text "Where are you off"
	line "to with #MON?"

	para "#MON LEAGUE?"

	para "Are your #MON"
	line "loyal enough for"
	cont "you to win?"

	para "Let me see…"
endc

	done

SandstormHouseWomanLoyalText: 
if DEF(_FR_FR)
	text "Ah! Ton #MON"
	line "te fait vraiment"
	cont "confiance."

	para "C'est agréable de"
	line "voir un bon"
	cont "dresseur."

	para "Tiens! Un cadeau"
	line "pour toi."
else
	text "Ah! Your #MON"
	line "trusts you very"
	cont "much."

	para "It's nice to see a"
	line "good trainer."

	para "Here. A gift for"
	line "your journey."
endc

	done

SandstormHouseSandstormDescription: 
if DEF(_FR_FR)
	text "CT37 apprend"
	line "TEMPETESABLE."

	para "Elle inflige des"
	line "dégâts aux deux"
	cont "combattants."

	para "Seuls les experts"
	line "savent bien s'en"
	cont "servir."

	para "A toi de peaufiner"
	line "une technique!"
else
	text "TM37 happens to be"
	line "SANDSTORM."

	para "It's a move that"
	line "inflicts damage on"
	cont "both battlers."

	para "It's for advanced"
	line "trainers only."

	para "Use it if you"
	line "dare. Good luck!"
endc

	done

SandstormHouseWomanDisloyalText: 
if DEF(_FR_FR)
	text "Sois à la hauteur"
	line "ou ton périple"

	para "sera de plus en"
	line "plus difficile."

	para "La confiance est"
	line "le lien entre"
	cont "les #MON et"
	cont "les dresseurs."
else
	text "If it doesn't come"
	line "to trust you some"

	para "more, it could be"
	line "tough going."

	para "Trust is the tie"
	line "that binds #MON"
	cont "and trainers."
endc

	done

Route27SandstormHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_27, 1
	warp_event  3,  7, ROUTE_27, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, SandstormHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, SandstormHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, Route27SandstormHouse_Radio

	def_object_events
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SandstormHouseWoman, -1
