	object_const_def
	const DIGLETTSCAVE_DIGLETT_1
	const DIGLETTSCAVE_DIGLETT_2
	const DIGLETTSCAVE_DIGLETT_3
	const DIGLETTSCAVE_DIGLETT_4
	const DIGLETTSCAVE_DIGLETT_5
	const DIGLETTSCAVE_DIGLETT_6
	const DIGLETTSCAVE_DIGLETT_7
	const DIGLETTSCAVE_DIGLETT_8
	const DIGLETTSCAVE_DIGLETT_9
	const DIGLETTSCAVE_BOULDER_1
	const DIGLETTSCAVE_BOULDER_2
	const DIGLETTSCAVE_POKEFAN_M
	const DIGLETTSCAVE_DUGTRIO
	const DIGLETTSCAVE_ITEMBALL_1
	const DIGLETTSCAVE_ITEMBALL_2
	const DIGLETTSCAVE_ITEMBALL_3

DiglettsCave_MapScripts:
	def_scene_scripts

	def_callbacks

DiglettsCavePokefanDugtrioPadreScript:
	cry DUGTRIO
	pause 15
	loadwildmon DUGTRIO, 50
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	startbattle
	ifequal LOSE, .NotBeaten
	disappear DIGLETTSCAVE_DUGTRIO
.NotBeaten:
	reloadmapafterbattle
	end

DiglettsCaveBoulder:
	jumpstd StrengthBoulderScript

DiglettsCavePokefanMScript:
	jumptextfaceplayer DiglettsCavePokefanMText

DiglettsCaveGreatBall:
	itemball ESCAPE_ROPE

DiglettsCaveMaxRepel:
	itemball MAX_REPEL

DiglettsCaveEscapeRope:
	itemball ESCAPE_ROPE

DiglettsCaveHiddenMaxRevive:
	hiddenitem MAX_REVIVE, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE

DiglettsCaveHiddenStardust:
	hiddenitem STARDUST, EVENT_DIGLETTS_CAVE_HIDDEN_STARDUST

DiglettsCaveDiglettScript:
	cry DIGLETT
	end

DiglettsCaveHide1Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .next

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	disappear DIGLETTSCAVE_DIGLETT_1
	disappear DIGLETTSCAVE_DIGLETT_7

.next
	end

DiglettsCaveShow1Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .next

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	appear DIGLETTSCAVE_DIGLETT_1
	appear DIGLETTSCAVE_DIGLETT_7

.next
	end

DiglettsCaveHide2Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .next

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	disappear DIGLETTSCAVE_DIGLETT_2
	disappear DIGLETTSCAVE_DIGLETT_3
	disappear DIGLETTSCAVE_DIGLETT_4

.next
	end

DiglettsCaveShow2Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iffalse .next

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	appear DIGLETTSCAVE_DIGLETT_2
	appear DIGLETTSCAVE_DIGLETT_3
	appear DIGLETTSCAVE_DIGLETT_4

.next
	end

DiglettsCaveHide3Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .next

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	disappear DIGLETTSCAVE_DIGLETT_5
	disappear DIGLETTSCAVE_DIGLETT_6

.next
	end

DiglettsCaveShow3Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iffalse .next

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	appear DIGLETTSCAVE_DIGLETT_5
	appear DIGLETTSCAVE_DIGLETT_6

.next
	end

DiglettsCaveHide4Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .next

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	disappear DIGLETTSCAVE_DIGLETT_9

.next
	end

DiglettsCaveShow4Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iffalse .next

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	appear DIGLETTSCAVE_DIGLETT_9

.next
	end

DiglettsCaveHide5Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .next

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	disappear DIGLETTSCAVE_DIGLETT_8

.next
	end

DiglettsCaveShow5Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iffalse .next

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	appear DIGLETTSCAVE_DIGLETT_8

.next
	end

DiglettsCavePokefanMText: ; TO TRANSLATE
	text "I was having fun"
	line "exploring the cave"
	
	para "jumping up, down,"
	line "left and right,"
	
	para "when a bunch of"
	line "DIGLETT popped"

	para "out of the ground!"
	line "That was shocking."
	done

DiglettsCave_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 45, VERMILION_CITY, 10
	warp_event  5, 43, DIGLETTS_CAVE, 5
	warp_event 55,  5, ROUTE_2, 5
	warp_event 57,  3, DIGLETTS_CAVE, 6
	warp_event 57, 45, DIGLETTS_CAVE, 2
	warp_event  3,  3, DIGLETTS_CAVE, 4

	def_coord_events
	coord_event 29, 14, CE_ALWAYS, -1, DiglettsCaveHide1Script
	coord_event 52, 42, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 27, 28, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 22, 21, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 25, 18, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 41, 39, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 33, 28, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 36, 31, CE_ALWAYS, -1, DiglettsCaveShow1Script
	coord_event 27, 27, CE_ALWAYS, -1, DiglettsCaveShow2Script
	coord_event 30, 15, CE_ALWAYS, -1, DiglettsCaveShow2Script
	coord_event  5, 12, CE_ALWAYS, -1, DiglettsCaveHide2Script
	coord_event  3,  5, CE_ALWAYS, -1, DiglettsCaveHide2Script
	coord_event  6,  8, CE_ALWAYS, -1, DiglettsCaveHide3Script
	coord_event  6,  9, CE_ALWAYS, -1, DiglettsCaveHide3Script
	coord_event 26, 27, CE_ALWAYS, -1, DiglettsCaveHide3Script
	coord_event  4, 27, CE_ALWAYS, -1, DiglettsCaveShow3Script
	coord_event 11, 10, CE_ALWAYS, -1, DiglettsCaveHide4Script
	coord_event 27, 29, CE_ALWAYS, -1, DiglettsCaveShow4Script
	coord_event 29, 18, CE_ALWAYS, -1, DiglettsCaveShow4Script
	coord_event  3,  6, CE_ALWAYS, -1, DiglettsCaveShow4Script
	coord_event  2, 24, CE_ALWAYS, -1, DiglettsCaveHide5Script
	coord_event  3,  7, CE_ALWAYS, -1, DiglettsCaveHide5Script
	coord_event 26, 26, CE_ALWAYS, -1, DiglettsCaveShow5Script
	coord_event  7, 10, CE_ALWAYS, -1, DiglettsCaveShow5Script
	coord_event  6, 10, CE_ALWAYS, -1, DiglettsCaveShow5Script

	def_bg_events
	bg_event 49, 30, BGEVENT_ITEM, DiglettsCaveHiddenMaxRevive
	bg_event 56, 36, BGEVENT_ITEM, DiglettsCaveHiddenStardust

	def_object_events
	object_event 43, 32, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 13, 17, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 23, 15, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 20, 25, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  8, 22, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event  6, 15, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event 29, 23, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3, 16, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	object_event 18, 11, SPRITE_DIGLETT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveDiglettScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	object_event 32, 27, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveBoulder, -1
	object_event 32, 28, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCaveBoulder, -1
	object_event  3, 43, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCavePokefanMScript, -1
	object_event 17, 42, SPRITE_DUGTRIO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DiglettsCavePokefanDugtrioPadreScript, EVENT_DIGLETTS_CAVE_FOUGHT_PADRE_DUGTRIO
	object_event  7, 26, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DiglettsCaveGreatBall, EVENT_DIGLETTS_CAVE_GREAT_BALL
	object_event 55, 40, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DiglettsCaveMaxRepel, EVENT_DIGLETTS_CAVE_MAX_REPEL
	object_event 32, 22, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DiglettsCaveEscapeRope, EVENT_DIGLETTS_CAVE_ESCAPE_ROPE
	
