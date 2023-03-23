	object_const_def
	const CERULEANPOLICESTATION_FISHING_GURU
	const CERULEANPOLICESTATION_POKEFAN_F
	const CERULEANPOLICESTATION_JENNY
	const CERULEANPOLICESTATION_SQUIRTLE
	const CERULEANPOLICESTATION_SQUIRTLE_SQUAD

CeruleanPoliceStation_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanPoliceStationFishingGuruScript:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .rave_notification
	jumptextfaceplayer CeruleanPoliceStationFishingGuruText

.rave_notification:
	jumptextfaceplayer CeruleanPoliceStationRaveText

CeruleanPoliceStationPokefanFScript:
	jumptextfaceplayer CeruleanPoliceStationPokefanFText

CeruleanPoliceStationJennyScript:
	applymovement CERULEANPOLICESTATION_JENNY, CeruleanPoliceStationStompUpMovement
	pause 5
	faceplayer
	opentext
	writetext CeruleanPoliceStationJennyText
	waitbutton
	closetext
	applymovement CERULEANPOLICESTATION_JENNY, CeruleanPoliceStationStompUpMovement
	end

CeruleanDiglett:
	opentext
	writetext CeruleanDiglettText
	cry SQUIRTLE
	waitbutton
	closetext
	end

CeruleanCoolSquirtle:
	cry SQUIRTLE
	waitsfx
	opentext
	writetext CeruleanCoolSquirtleText
	cry SQUIRTLE
	waitbutton
	closetext
	end

CeruleanPoliceStationRaver:
	checkevent EVENT_RETURNED_MACHINE_PART
	iffalse CeruleanPoliceCell
	
	jumptext CeruleanPoliceStationRaverText

CeruleanPoliceRocketCell:
	checkevent EVENT_RETURNED_MACHINE_PART
	iffalse CeruleanPoliceCell
	
	jumptext CeruleanRocketPrisonerText

CeruleanPoliceCell:
	farjumptext EcruteakPoliceStationCustodyCellText

CeruleanPoliceStationPhoneScript:
	farjumptext EcruteakPoliceStationPhoneText

CeruleanPoliceStationSign:
	jumptext CeruleanPoliceStationSignText

CeruleanPoliceStationStompUpMovement:
	turn_step UP
	step_bump
	step_end

CeruleanPoliceStationFishingGuruText:
	text "I heard that some"
	line "shady character is"
	cont "skulking about."

	para "I won't stand for"
	line "it if he turns out"
	cont "to be a thief."
	done

CeruleanPoliceStationRaveText:
	text "Now that we're done"
	line "with this thief,"

	para "we have to deal"
	line "with an illegal"
	cont "rave."

	para "We know it usual-"
	line "takes place in a"
	cont "deserted area"
	cont "late at night."

	para "But we're having"
	line "a hard time find-"
	cont "ing where."
	done

CeruleanPoliceStationPokefanFText:
	text "We were held up by"
	line "robbers before."
	done

CeruleanDiglettText:
	text "SQUIRTLE: lelele!"
	done

CeruleanCoolSquirtleText:
	text "SQUIRTLE SQUAD"
	line "LEADER: Squirtle!"
	done

CeruleanPoliceStationJennyText:
	text "We've been watching"
	line "this dude since"
	cont "the last rave."
	
	para "Last Thursday we"
	line "caught him while"
	cont "he was heading to"
	cont "another party."

	para "He doesn't want to"
	line "tell us where"
	cont "he was going."
	done

CeruleanPoliceStationRaverText:
	text "A custody cell."

	para "There's a young man"
	line "wearing a funny"
	cont "party hat and…"
	cont "a swimsuit."
	done

CeruleanRocketPrisonerText:
	text "A custody cell."

	para "There's a ROCKET"
	line "GRUNT swearing"
	cont "with a thick"
	cont "accent."
	done

CeruleanPoliceStationSignText:
	text "To the backyard."
	line "Now robber-free!"
	done

CeruleanPoliceStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, CERULEAN_CITY, 2
	warp_event  7,  9, CERULEAN_CITY, 2
	warp_event  0,  0, CERULEAN_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  1,  0, BGEVENT_READ, CeruleanPoliceStationSign
	bg_event  9,  1, BGEVENT_READ, CeruleanPoliceStationPhoneScript
	bg_event  3,  0, BGEVENT_READ, CeruleanPoliceStationRaver
	bg_event  5,  0, BGEVENT_READ, CeruleanPoliceCell
	bg_event  7,  0, BGEVENT_READ, CeruleanPoliceRocketCell

	def_object_events
	object_event  6,  3, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationFishingGuruScript, -1
	object_event  9,  6, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationPokefanFScript, -1
	object_event  3,  2, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationJennyScript, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	object_event  9,  5, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanDiglett, -1
	object_event  1,  2, SPRITE_SQUIRTLE_SQUAD, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCoolSquirtle, -1
