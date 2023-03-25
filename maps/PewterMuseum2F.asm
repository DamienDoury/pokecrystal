	object_const_def
	const PEWTERMUSEUM2F_SANDSHREW

PewterMuseum2F_MapScripts:
	def_scene_scripts

	def_callbacks

PewterMuseum2FScript:
	jumptextfaceplayer PewterMuseum2FText

PewterMuseum2FSpaceShuttleScript:
	jumptext MuseumSpaceShuttleText

PewterMuseum2FSandshrewScript:
	cry SANDSHREW
	pause 5
	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid onto Sandshrew.
	loadmem wAssaultBattle, $fe ; The sandshrew can never assault you, otherwise it would override its fleeing behaviour.
	loadwildmon SANDSHREW, 20
	loadvar VAR_BATTLETYPE, BATTLETYPE_NORMAL
	startbattle
	disappear PEWTERMUSEUM2F_SANDSHREW
	reloadmapafterbattle
	end

PewterMuseum2FOldAmber:
	itemball OLD_AMBER

PewterMuseum2FText:
	text "“Meteorite that"
	line "fell on MT.MOON."
	cont "(MOON STONE?)”"
	done

MuseumSpaceShuttleText:
	text "“SPACE SHUTTLE"
	line "COLUMBIA -"
	cont "Never crashed!”"
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
	object_event 13,  6, SPRITE_SANDSHREW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PewterMuseum2FSandshrewScript, EVENT_PEWTER_MUSEUM_SANDSHREW
	object_event 13,  7, SPRITE_OLD_AMBER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, PewterMuseum2FOldAmber, EVENT_PEWTER_MUSEUM_ITEM_OLD_AMBER
