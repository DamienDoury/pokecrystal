	object_const_def
	const BILLSBROTHERSHOUSE_POKEFAN_F
	const BILLSBROTHERSHOUSE_YOUNGSTER

BillsBrothersHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BillsBrotherScript:
	jumptextfaceplayer BillsBrotherText

BillsBrothersHouseYoungsterScript:
	faceplayer
	opentext
	writetext BillsBrothersHouseYoungsterText
	yesorno
	iffalse .end_dialog
	writetext BillsBrothersHouseYoungsterStoryText
	waitbutton
	closetext
	end

.end_dialog:
	writetext BillsBrothersHouseYoungsterOkText
	waitbutton
	closetext
	end

BillsBrotherText: ; AUTOTRAD
	text "My grandpa is at "
	line "my brother BILL's"
	cont "on CERULEAN CAPE."
	done

BillsBrothersHouseYoungsterText: ; TO TRANSLATE
	text "Can I tell you an"
	line "interesting story"
	cont "about the PSS?"
	done

BillsBrothersHouseYoungsterOkText: ; TO TRANSLATE
	text "Then I won't."
	done

BillsBrothersHouseYoungsterStoryText: ; TO TRANSLATE
	text "The PC's local mode"
	line "is actually the"
	cont "original version"
	cont "of the #MON"
	cont "Storage System,"
	
	para "invented by my"
	line "uncle, BILL."

	para "#MON are stored"
	line "locally in a PC,"
	
	para "and can be trans-"
	line "ferred through"
	cont "underground cables"
	cont "that link KANTO's"
	cont "#MON CENTERS"
	cont "together."

	para "Kinda like old"
	line "landline phones."
	
	para "When wireless"
	line "technology came"
	cont "and connected the"
	cont "world together,"

	para "BILL kept the his-"
	line "torical version"
	cont "as a failsafe."

	para "If he hadn't done"
	line "that, it would"
	cont "have been chaos"
	cont "with the POWER"
	cont "PLANT outage."

	para "New technology is"
	line "amazing, but more"
	cont "and more complex."
	
	para "When it fails, we"
	line "are glad to rely"
	cont "on old tech."

	para "It's a great story,"
	line "don't you think?"
	done

BillsBrothersHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 4
	warp_event  3,  7, FUCHSIA_CITY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BillsBrotherScript, -1
	object_event  6,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsBrothersHouseYoungsterScript, -1
