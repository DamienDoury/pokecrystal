	object_const_def
	const PALLETTOWN_TEACHER
	const PALLETTOWN_FISHER

PalletTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_PALLET
	endcallback

PalletTownTeacherScript:
	jumptextfaceplayer PalletTownTeacherText

PalletTownFisherScript:
	jumptextfaceplayer PalletTownFisherText

PalletTownSign:
	jumptext PalletTownSignText

RedsHouseSign:
	jumptext RedsHouseSignText

OaksLabSign:
	jumptext OaksLabSignText

BluesHouseSign:
	jumptext BluesHouseSignText

PalletTownTeacherText: 
if DEF(_FR_FR)
	text "J'entraîne des"
	line "#MON. Ils sont"

	para "mes gardes du"
	line "corps."
else
	text "I'm raising #-"
	line "MON too."

	para "They serve as my"
	line "private guards."
endc

	done

PalletTownFisherText: 
if DEF(_FR_FR)
	text "Le progrès..."
	line "C'est dingue!"

	para "On peut maintenant"
	line "échanger des #-"
	cont "MON à travers le"
	cont "temps comme des"
	cont "e-mails."
else
	text "Technology is"
	line "incredible!"

	para "You can now trade"
	line "#MON across"
	cont "time like e-mail."
endc

	done

PalletTownSignText: 
if DEF(_FR_FR)
	text "BOURG PALETTE"

	para "Calme, paix et"
	line "pureté"
else
	text "PALLET TOWN"

	para "A Tranquil Setting"
	line "of Peace & Purity"
endc

	done

RedsHouseSignText: 
if DEF(_FR_FR)
	text "CHEZ RED"
else
	text "RED'S HOUSE"
endc

	done

OaksLabSignText: 
if DEF(_FR_FR)
	text "LABO #MON"
	line "de CHEN"
else
	text "OAK #MON"
	line "RESEARCH LAB"
endc

	done

BluesHouseSignText: 
if DEF(_FR_FR)
	text "CHEZ BLUE"
else
	text "BLUE'S HOUSE"
endc

	done

PalletTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, REDS_HOUSE_1F, 1
	warp_event 13,  5, BLUES_HOUSE, 1
	warp_event 12, 11, OAKS_LAB, 1

	def_coord_events

	def_bg_events
	bg_event  7,  9, BGEVENT_READ, PalletTownSign
	bg_event  3,  5, BGEVENT_READ, RedsHouseSign
	bg_event 13, 13, BGEVENT_READ, OaksLabSign
	bg_event 11,  5, BGEVENT_READ, BluesHouseSign

	def_object_events
	object_event  3,  8, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PalletTownTeacherScript, -1
	object_event 12, 14, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PalletTownFisherScript, -1
