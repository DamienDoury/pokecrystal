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

BillsBrothersHouse_Radio:
	jumpstd Radio3Script

BillsBrotherText: 
if DEF(_FR_FR)
	text "Mon pépé est chez"
	line "mon frère LEO au"
	cont "CAP d'AZURIA."
else
	text "My grandpa is at "
	line "my brother BILL's"
	cont "on CERULEAN CAPE."
endc

	done

BillsBrothersHouseYoungsterText:
if DEF(_FR_FR)
	text "Je peux te racon-"
	line "ter une histoire"
	cont "intéressante au"
	cont "sujet du PC?"
	done
else
	text "Can I tell you an"
	line "interesting story"
	cont "about the PSS?"
	done
endc

BillsBrothersHouseYoungsterOkText:
if DEF(_FR_FR)
	text "Alors je ne dis"
	line "rien."
	done
else
	text "Then I won't."
	done
endc

BillsBrothersHouseYoungsterStoryText:
if DEF(_FR_FR)
	text "Le mode Local"
	line "du PC est en"
	cont "fait la version"
	cont "originale du"
	cont "Stockage #MON,"
	
	para "inventé par"
	line "mon oncle, LEO."
	
	para "Les #MON sont "
	line "stockés localement"
	cont "sur le PC,"
	
	para "et peuvent être"
	line "transférés via"
	cont "des câbles"
	cont "souterrains qui"
	cont "relient les"
	cont "CENTRES #MON"
	cont "de KANTO."
	
	para "Comme les vieux"
	line "téléphones fixes."
	
	para "Quand le sans-fil"
	line "a débarqué et"
	cont "connecté le monde,"
	cont "LEO a gardé"
	cont "la version"
	cont "historique en"
	cont "cas de besoin."
	
	para "Sans cela, ça"
	line "aurait été le"
	cont "chaos lors de"
	cont "la panne de la"
	cont "CENTRALE."
	
	para "Les nouvelles"
	line "technologies sont"
	cont "incroyables, mais"
	cont "de plus en plus"
	cont "complexes."
	
	para "Quand ça plante,"
	line "on est bien"
	cont "contents de pou-"
	cont "voir se reposer"
	cont "sur les vieilles"
	cont "technologies."
	
	para "Belle histoire,"
	line "tu trouves pas?"
	done
else
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
endc

BillsBrothersHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 4
	warp_event  3,  7, FUCHSIA_CITY, 4

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, BillsBrothersHouse_Radio

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BillsBrotherScript, -1
	object_event  6,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsBrothersHouseYoungsterScript, -1
