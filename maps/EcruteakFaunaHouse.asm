	object_const_def
	const ECRUTEAKFAUNAHOUSE_PERSON_1
	const ECRUTEAKFAUNAHOUSE_PERSON_2
	const ECRUTEAKFAUNAHOUSE_PERSON_3

EcruteakFaunaHouse_MapScripts:
	def_scene_scripts

	def_callbacks

EcruteakFaunaHouse_Person1Script:
	jumptextfaceplayer EcruteakFaunaHouse_Person1Text

EcruteakFaunaHouse_Person2Script:
	jumptextfaceplayer EcruteakFaunaHouse_Person2Text

EcruteakFaunaHouse_Person3Script:
	faceplayer
	opentext
	writetext EcruteakFaunaHouse_Person3Text

	checkevent EVENT_GOT_CLEANSE_TAG
	iftrue .WaitButton

	promptbutton
	writetext EcruteakFaunaHouse_Person3GiveCleanseTagText
	promptbutton
	verbosegiveitem CLEANSE_TAG
	iffalse .NoRoom

	setevent EVENT_GOT_CLEANSE_TAG
	writetext EcruteakFaunaHouse_Person3DescribesCleanseTagText
.WaitButton:
	waitbutton
.NoRoom:
	closetext
	end


EcruteakFaunaHouse_Radio:
	jumpstd Radio1Script

EcruteakFaunaHouse_Person1Text:
	text "We study the"
	line "impact of the"
	cont "pandemic on the"
	cont "behaviour of"
	cont "wild #MON."
	done

EcruteakFaunaHouse_Person2Text:
	text "COVID has a big"
	line "impact on wild"
	cont "#MON."

	para "Wild species see"
	line "the dangers of the"
	cont "virus and some of"
	cont "them migrated."

	para "Which explains"
	line "why we can find"
	cont "some species in"
	cont "places they didn't"
	cont "use to live in."

	para "Also, the pandemic"
	line "makes wild #MON"
	cont "agitated and"
	cont "harder to catch."
	done

EcruteakFaunaHouse_Person3Text:
	text "Because of the"
	line "migrations, some"
	cont "#MON defend"
	cont "their territory."

	para "We have observed"
	line "wild #MON"
	cont "aggressive towards"
	cont "other species and"
	cont "trainers as well."

	para "Walking in tall"
	line "grass is currently"
	cont "dangerous."
	done

EcruteakFaunaHouse_Person3GiveCleanseTagText:
	text "You should protect"
	line "yourself with"
	cont "this."
	done

EcruteakFaunaHouse_Person3DescribesCleanseTagText:
	text "It repulses some"
	line "wild #MON, but"
	cont "not all of them."
	done

EcruteakFaunaHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 16
	warp_event  4,  7, ECRUTEAK_CITY, 16

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, EcruteakFaunaHouse_Radio

	def_object_events
	object_event  5,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakFaunaHouse_Person1Script, -1
	object_event  6,  2, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakFaunaHouse_Person2Script, -1
	object_event  4,  2, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakFaunaHouse_Person3Script, -1
