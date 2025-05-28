CeladonMansion2F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansion2FComputer:
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleHandWash
	farwritetext _PlayersPCSanitizerText
	sjump .boops

.FemaleHandWash:
	farwritetext _PlayersPCSanitizerFemaleText

.boops:
	waitsfx
	playsound SFX_2_BOOPS
	waitsfx
	pause 10
	writetext CeladonMansion2FComputerText
	waitbutton
	closetext

CeladonMansion2FMeetingRoomSign:
	jumptext CeladonMansion2FMeetingRoomSignText

CeladonMansion2FBookshelf:
	jumpstd DifficultBookshelfScript

CeladonMansion2FComputerText: 
if DEF(_FR_FR)
	text "<PLAYER> allume"
	line "le PC."

	para "…"

	para "Quelqu'un était en"
	line "train d'écrire un"
	cont "e-mail..."

	para "...J'espère que"
	line "vous viendrez à"
	cont "KANTO."

	para "Vous verrez à quel"
	line "point les choses"
	cont "ont changé ici."

	para "Vous verrez même"
	line "des #MON qui"

	para "n'existent pas à"
	line "JOHTO."

	para "Pour le PRODUCTEUR"

	para "..."
else
	text "<PLAYER> turned on"
	line "the PC."

	para "…"

	para "Someone was in the"
	line "middle of compos-"
	cont "ing an e-mail."

	para "…I hope you'll"
	line "come visit KANTO."

	para "I think you'll be"
	line "surprised at how"

	para "much things have"
	line "changed here."

	para "You'll also see"
	line "many #MON that"

	para "aren't native to"
	line "JOHTO."

	para "To the PRODUCER"

	para "…"
endc

	done

CeladonMansion2FMeetingRoomSignText: 
if DEF(_FR_FR)
	text "GAME FREAK"
	line "SALLE de REUNION"
else
	text "GAME FREAK"
	line "MEETING ROOM"
endc

	done

CeladonMansion2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, CELADON_MANSION_1F, 4
	warp_event  1,  0, CELADON_MANSION_3F, 2
	warp_event  6,  0, CELADON_MANSION_3F, 3
	warp_event  7,  0, CELADON_MANSION_1F, 5

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_READ, CeladonMansion2FComputer
	bg_event  5,  8, BGEVENT_UP, CeladonMansion2FMeetingRoomSign
	bg_event  2,  3, BGEVENT_READ, CeladonMansion2FBookshelf

	def_object_events
