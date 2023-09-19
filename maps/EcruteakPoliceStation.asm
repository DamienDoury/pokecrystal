	object_const_def
	const ECRUTEAKPOLICESTATION_RECEPTIONIST

EcruteakPoliceStation_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	readvar VAR_YCOORD
	ifequal 5, .got_arrested
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

.got_arrested
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

EcruteakPoliceStationReceptionistScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .got_arrested
	jumptextfaceplayer EcruteakPoliceStationReceptionistText

.got_arrested
	jumptextfaceplayer EcruteakPoliceStationReceptionistShooText

EcruteakPoliceStationBriefing1Script:
	jumptextfaceplayer EcruteakPoliceStationBriefingText1

EcruteakPoliceStationBriefing2Script:
	jumptextfaceplayer EcruteakPoliceStationBriefingText2

EcruteakPoliceStationBriefing3Script:
	jumptextfaceplayer EcruteakPoliceStationBriefingText3

EcruteakPoliceStationBriefing4Script:
	jumptextfaceplayer EcruteakPoliceStationBriefingText4

EcruteakPoliceStationOutfitScript:
	jumptextfaceplayer EcruteakPoliceStationOutfitText

EcruteakPoliceStationPrisonerScript:
	jumptextfaceplayer EcruteakPoliceStationPrisonerText

EcruteakPoliceStationPrisoner2Script:
	jumptextfaceplayer EcruteakPoliceStationPrisoner2Text

EcruteakPoliceStationBurnOutScript:
	jumptext EcruteakPoliceStationBurnOutText

EcruteakPoliceDoorLockedScript:
	farjumptext GoldenrodUndergroundTheDoorsLockedText

EcruteakPoliceStationCustodyCellScript:
	jumptext EcruteakPoliceStationCustodyCellText

EcruteakPoliceStationPhoneScript:
	jumptext EcruteakPoliceStationPhoneText

EcruteakPoliceStationTrainingSign:
	jumptext EcruteakPoliceStationTrainingSignText

EcruteakPoliceStationReceptionistText:
	text "Welcome to the"
	line "police station."

	para "What can I do"
	line "for you?"
	done

EcruteakPoliceStationReceptionistShooText:
	text "I don't want to"
	line "see you here ever"
	cont "again. Shoo!"
	done

EcruteakPoliceStationOutfitText:
	text "What do you think"
	line "of my outfit?"
	
	para "It's A-MA-ZING,"
	line "right?"
	
	para "They don't allow"
	line "me to wear it…"
	done

EcruteakPoliceStationBriefingText1:
	text "We've got so"
	line "much to do"
	cont "these days…"
	done

EcruteakPoliceStationBriefingText2:
	text "Shouldn't you"
	line "be home?"
	done

EcruteakPoliceStationBriefingText3:
	text "I'm briefing"
	line "my colleagues."
	done

EcruteakPoliceStationBriefingText4:
	text "…"
	done

EcruteakPoliceStationPrisonerText:
	text "I should've worn"
	line "my face mask"
	cont "properly, not"
	cont "under the chin."

	para "I'm in deep"
	line "trouble now!"
	done

EcruteakPoliceStationPrisoner2Text:
	text "Let me tell you"
	line "my story."

	para "I was going to the"
	line "MART to do groce-"
	cont "ries and got con-"
	cont "trolled by the"
	cont "police."

	para "I showed them my"
	line "self-made attesta-"
	cont "tion: everything"
	cont "was in order."

	para "Then they asked me"
	line "where I live, and"
	cont "their answer was"
	cont "that the #MART"
	cont "I was going to"
	cont "wasn't the closest"
	cont "one to my house."

	para "I told them that"
	line "the closest one"
	cont "was in short"
	cont "supply, but they"
	cont "didn't wanna hear"
	cont "it and I got"
	cont "arrested!"

	para "Can you believe"
	line "it??"
	done

EcruteakPoliceStationBurnOutText:
	text "I can't do it"
	line "anymore…"

	para "I applied to this"
	line "job to protect"
	cont "civilians from"
	cont "dangerous indivi-"
	cont "duals."

	para "Now my only"
	line "mission is to"
	cont "arrest people"
	cont "not wearing a"
	cont "face mask…"

	para "What am I doing?"
	done

EcruteakPoliceStationCustodyCellText:
	text "A custody cell."
	done

EcruteakPoliceStationPhoneText:
	text "There's a phone for"
	line "those who don't"
	cont "have a #GEAR."
	done

EcruteakPoliceStationTrainingSignText:
	text "POLICE TRAINING"
	line "FIELD"
	done	

EcruteakPoliceStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, ECRUTEAK_CITY, 17
	warp_event  7,  9, ECRUTEAK_CITY, 17
	warp_event  0,  0, BATTLE_TOWER_1F, 1

	def_coord_events

	def_bg_events
	bg_event  1,  0, BGEVENT_READ, EcruteakPoliceStationTrainingSign
	bg_event  9,  1, BGEVENT_READ, EcruteakPoliceStationPhoneScript
	bg_event  3,  0, BGEVENT_READ, EcruteakPoliceStationCustodyCellScript
	bg_event  5,  0, BGEVENT_READ, EcruteakPoliceStationCustodyCellScript
	bg_event  7,  0, BGEVENT_READ, EcruteakPoliceStationCustodyCellScript

	def_object_events
	object_event  9,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationReceptionistScript, -1
	object_event  0,  0, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceDoorLockedScript, -1
	object_event  4,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing1Script, -1
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | MORN, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing2Script, -1
	object_event  4,  5, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing3Script, -1
	object_event  3,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, %11100000 | MORN, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing4Script, -1
	object_event  9,  2, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 1, -1, %11100000 | MORN | DAY, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationOutfitScript, -1
	object_event  4,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY | NITE, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationPrisonerScript, -1
	object_event  9,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationPrisoner2Script, -1
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBurnOutScript, -1
