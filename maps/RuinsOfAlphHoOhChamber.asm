RuinsOfAlphHoOhChamber_MapScripts:
	def_scene_scripts
	scene_script .CheckWall ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .HiddenDoors

.CheckWall:
	special HoOhChamber
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue .OpenWall
	end

.OpenWall:
	prioritysjump .WallOpenScript
	end

.DummyScene:
	end

.HiddenDoors:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $2e ; closed wall
.WallOpen:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalse .FloorClosed
	endcallback

.FloorClosed:
	changeblock 2, 2, $01 ; left floor
	changeblock 4, 2, $02 ; right floor
	endcallback

.WallOpenScript:
	pause 30
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 20
	pause 30
	playsound SFX_STRENGTH
	changeblock 4, 0, $30 ; open wall
	reloadmappart
	earthquake 50
	setscene SCENE_FINISHED
	closetext
	end

RuinsOfAlphHoOhChamberPuzzle:
	refreshscreen
	setval UNOWNPUZZLE_HO_OH
	special UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_HO_OH_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_X_TO_Z
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $18 ; left hole
	changeblock 4, 2, $19 ; right hole
	reloadmappart
	playsound SFX_STRENGTH
	earthquake 80
	applymovement PLAYER, RuinsOfAlphHoOhChamberSkyfallTopMovement
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

RuinsOfAlphHoOhChamberAncientReplica:
	jumptext RuinsOfAlphHoOhChamberAncientReplicaText

RuinsOfAlphHoOhChamberDescriptionSign:
	jumptext RuinsOfAlphHoOhChamberDescriptionText

RuinsOfAlphHoOhChamberWallPatternLeft:
	opentext
	writetext RuinsOfAlphHoOhChamberWallPatternLeftText
	setval UNOWNWORDS_HO_OH
	special DisplayUnownWords
	closetext
	end

RuinsOfAlphHoOhChamberWallPatternRight:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue .WallOpen
	opentext
	writetext RuinsOfAlphHoOhChamberWallPatternRightText
	setval UNOWNWORDS_HO_OH
	special DisplayUnownWords
	closetext
	end

.WallOpen:
	opentext
	writetext RuinsOfAlphHoOhChamberWallHoleText
	waitbutton
	closetext
	end

RuinsOfAlphHoOhChamberSkyfallTopMovement:
	skyfall_top
	step_end

RuinsOfAlphHoOhChamberWallPatternLeftText: 
if DEF(_FR_FR)
	text "Des figures sont"
	line "apparues sur les"
	cont "murs..."
else
	text "Patterns appeared"
	line "on the walls…"
endc

	done

RuinsOfAlphHoOhChamberUnownText: ; unreferenced
	text "It's UNOWN text!"
	done

RuinsOfAlphHoOhChamberWallPatternRightText: 
if DEF(_FR_FR)
	text "Des figures sont"
	line "apparues sur les"
	cont "murs..."
else
	text "Patterns appeared"
	line "on the walls…"
endc

	done

RuinsOfAlphHoOhChamberWallHoleText: 
if DEF(_FR_FR)
	text "Il y a un gros"
	line "trou dans le mur!"
else
	text "There's a big hole"
	line "in the wall!"
endc

	done

RuinsOfAlphHoOhChamberAncientReplicaText: 
if DEF(_FR_FR)
	text "C'est la réplique"
	line "d'un ancien #-"
	cont "MON."
else
	text "It's a replica of"
	line "an ancient #-"
	cont "MON."
endc

	done

RuinsOfAlphHoOhChamberDescriptionText: 
if DEF(_FR_FR)
	text "Un #MON qui"
	line "volait avec grâce"

	para "en battant ses"
	line "ailes irisées."
else
	text "A #MON that"
	line "flew gracefully on"

	para "rainbow-colored"
	line "wings."
endc

	done

RuinsOfAlphHoOhChamber_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 2
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 3
	warp_event  4,  0, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, RuinsOfAlphHoOhChamberAncientReplica
	bg_event  5,  3, BGEVENT_READ, RuinsOfAlphHoOhChamberAncientReplica
	bg_event  3,  2, BGEVENT_UP, RuinsOfAlphHoOhChamberPuzzle
	bg_event  4,  2, BGEVENT_UP, RuinsOfAlphHoOhChamberDescriptionSign
	bg_event  3,  0, BGEVENT_UP, RuinsOfAlphHoOhChamberWallPatternLeft
	bg_event  4,  0, BGEVENT_UP, RuinsOfAlphHoOhChamberWallPatternRight

	def_object_events
