	object_const_def
	const ROUTE12SUPERRODHOUSE_FISHING_GURU

Route12SuperRodHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route12SuperRodHouseFishingGuruScript:
	faceplayer
	opentext
	checkitem SUPER_ROD
	iftrue .GotSuperRod
	writetext OfferSuperRodText
	yesorno
	iffalse .Refused
	writetext GiveSuperRodText
	promptbutton
	verbosegiveitem SUPER_ROD
	iffalse .NoRoom
.GotSuperRod:
	writetext GaveSuperRodText
	waitbutton
	closetext
	end

.Refused:
	writetext DontWantSuperRodText
	waitbutton
.NoRoom:
	closetext
	end

SuperRodHouseBookshelf: ; unreferenced
	jumpstd PictureBookshelfScript

OfferSuperRodText: 
if DEF(_FR_FR)
	text "Je suis le petit"
	line "frère du MAITRE"
	cont "PECHEUR."

	para "Tu aimes la pêche,"
	line "toi! Ca se voit."

	para "J'ai raison, hein?"
	line "Bien sûr que oui!"
else
	text "I'm the FISHING"
	line "GURU's younger"
	cont "brother."

	para "I can see that you"
	line "like fishing."

	para "There's no doubt"
	line "in my mind at all!"

	para "So? I know I'm"
	line "right."
endc

	done

GiveSuperRodText: 
if DEF(_FR_FR)
	text "Crénom de là!"
	line "C'est ben vrai!"

	para "Tiens boudiou!"
	line "Prends ça: c'est"
	cont "la MEGA CANNE."
else
	text "Yes, yes. Just as"
	line "I thought!"

	para "Here, fishing fan!"
	line "Take this--it's a"
	cont "SUPER ROD."
endc

	done

GaveSuperRodText: 
if DEF(_FR_FR)
	text "Essaie de pêcher"
	line "un peu partout où"
	cont "il y a de l'eau."

	para "Souviens-toi: tu"
	line "peux attraper plu-"

	para "sieurs #MON"
	line "grâce à différen-"
	cont "tes CANNES."
else
	text "Try your hand at"
	line "fishing wherever"
	cont "there is water."

	para "Remember--you can"
	line "catch different"

	para "#MON using"
	line "different RODS."
endc

	done

DontWantSuperRodText: 
if DEF(_FR_FR)
	text "Hein? On m'aurait"
	line "trompé?"
else
	text "Huh? My own eyes"
	line "deceived me?"
endc

	done

Route12SuperRodHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_12, 1
	warp_event  3,  7, ROUTE_12, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route12SuperRodHouseFishingGuruScript, -1
