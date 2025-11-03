	object_const_def
	const PEWTERMUSEUM2F_SANDSHREW

PewterMuseum2F_MapScripts:
	def_scene_scripts

	def_callbacks

PewterMuseum2FScript:
	jumptextfaceplayer PewterMuseum2FText

PewterMuseum2FSpaceShuttleScript:
	jumptext MuseumSpaceShuttleText

PewterMuseum2FRattataScript:
	cry RATTATA
	pause 5
	loadmem wAssaultBattle, $ff ; Force assault.
	loadwildmon RATTATA, 15
	loadvar VAR_BATTLETYPE, BATTLETYPE_NORMAL
	startbattle
	disappear PEWTERMUSEUM2F_SANDSHREW
	reloadmapafterbattle
	end

PewterMuseum2FOldAmber:
	itemball OLD_AMBER

PewterMuseum2FText:
if DEF(_FR_FR)
	text "Des météorites"
	line "tombés sur le"
	cont "MONT SELENITE."
	cont "(PIERRE LUNE?)"
else
	text "“Meteorite that"
	line "fell on MT.MOON."
	cont "(MOON STONE?)”"
endc
	done

MuseumSpaceShuttleText:
if DEF(_FR_FR)
	text "NAVETTE SPATIALE"
	line "COLUMBIA"
	cont "Aucun accident!"
else
	text "“SPACE SHUTTLE"
	line "COLUMBIA -"
	cont "Never crashed!”"
endc
	done

	PewterMuseum2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  7, PEWTER_MUSEUM_1F, 3

	def_coord_events

	def_bg_events
	bg_event 11,  2, BGEVENT_READ, PewterMuseum2FSpaceShuttleScript
	bg_event 12,  2, BGEVENT_READ, PewterMuseum2FSpaceShuttleScript
	bg_event 12,  1, BGEVENT_READ, PewterMuseum2FSpaceShuttleScript
	bg_event 10,  2, BGEVENT_READ, PewterMuseum2FSpaceShuttleScript
	bg_event 10,  1, BGEVENT_READ, PewterMuseum2FSpaceShuttleScript
	bg_event  3,  5, BGEVENT_READ, PewterMuseum2FScript

	def_object_events
	object_event 13,  6, SPRITE_RATTATA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, PewterMuseum2FRattataScript, EVENT_PEWTER_MUSEUM_RATTATA
	object_event 13,  7, SPRITE_OLD_AMBER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, PewterMuseum2FOldAmber, EVENT_PEWTER_MUSEUM_ITEM_OLD_AMBER
