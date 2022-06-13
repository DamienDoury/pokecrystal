	object_const_def
	const CERULEANPOLICESTATION_FISHING_GURU
	const CERULEANPOLICESTATION_POKEFAN_F
	const CERULEANPOLICESTATION_DIGLETT

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

CeruleanDiglett:
	opentext
	writetext CeruleanDiglettText
	cry SQUIRTLE
	waitbutton
	closetext
	end

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

	para "We know it happ-"
	line "ens in a desert"
	cont "place at night."

	para "But we are"
	line "having a hard"
	cont "time finding it."
	done

CeruleanPoliceStationPokefanFText:
	text "We were held up by"
	line "robbers before."
	done

CeruleanDiglettText:
	text "SQUIRTLE: lelele!"
	done

CeruleanPoliceStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 2
	warp_event  3,  7, CERULEAN_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationFishingGuruScript, -1
	object_event  5,  4, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationPokefanFScript, -1
	object_event  3,  5, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanDiglett, -1
