RuinsOfAlphOmanyteChamber_MapScripts:
	def_scene_scripts
	scene_script .CheckWall ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .HiddenDoors

.CheckWall:
	special OmanyteChamber
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue .OpenWall
	end

.OpenWall:
	prioritysjump .WallOpenScript
	end

.DummyScene:
	end

.HiddenDoors:
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $2e ; closed wall
.WallOpen:
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
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

RuinsOfAlphOmanyteChamberPuzzle:
	refreshscreen
	setval UNOWNPUZZLE_OMANYTE
	special UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_OMANYTE_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_L_TO_R
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $18 ; left hole
	changeblock 4, 2, $19 ; right hole
	reloadmappart
	playsound SFX_STRENGTH
	earthquake 80
	applymovement PLAYER, RuinsOfAlphOmanyteChamberSkyfallTopMovement
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

RuinsOfAlphOmanyteChamberAncientReplica:
	jumptext RuinsOfAlphOmanyteChamberAncientReplicaText

RuinsOfAlphOmanyteChamberDescriptionSign:
	jumptext RuinsOfAlphOmanyteChamberDescriptionText

RuinsOfAlphOmanyteChamberWallPatternLeft:
	opentext
	writetext RuinsOfAlphOmanyteChamberWallPatternLeftText
	setval UNOWNWORDS_WATER
	special DisplayUnownWords
	closetext
	end

RuinsOfAlphOmanyteChamberWallPatternRight:
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue .WallOpen
	opentext
	writetext RuinsOfAlphOmanyteChamberWallPatternRightText
	setval UNOWNWORDS_WATER
	special DisplayUnownWords
	closetext
	end

.WallOpen:
	opentext
	writetext RuinsOfAlphOmanyteChamberWallHoleText
	waitbutton
	closetext
	end

RuinsOfAlphOmanyteChamberSkyfallTopMovement:
	skyfall_top
	step_end

RuinsOfAlphOmanyteChamberWallPatternLeftText: 
if DEF(_FR_FR)
	text "Des figures sont"
	line "apparues sur les"
	cont "murs..."
else
	text "Patterns appeared"
	line "on the walls…"
endc

	done

RuinsOfAlphOmanyteChamberUnownText: ; unreferenced
	text "It's UNOWN text!"
	done

RuinsOfAlphOmanyteChamberWallPatternRightText: 
if DEF(_FR_FR)
	text "Des figures sont"
	line "apparues sur les"
	cont "murs..."
else
	text "Patterns appeared"
	line "on the walls…"
endc

	done

RuinsOfAlphOmanyteChamberWallHoleText: 
if DEF(_FR_FR)
	text "Il y a un gros"
	line "trou dans le mur!"
else
	text "There's a big hole"
	line "in the wall!"
endc

	done

RuinsOfAlphOmanyteChamberAncientReplicaText: 
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

RuinsOfAlphOmanyteChamberDescriptionText: 
if DEF(_FR_FR)
	text "Ce #MON glis-"
	line "sait dans l'eau en"

	para "tordant ses dix"
	line "tentacules."
else
	text "This #MON"
	line "drifted in the"

	para "sea by twisting"
	line "its ten tentacles."
endc

	done

RuinsOfAlphOmanyteChamber_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 3
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 3
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 6
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 7
	warp_event  4,  0, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, RuinsOfAlphOmanyteChamberAncientReplica
	bg_event  5,  3, BGEVENT_READ, RuinsOfAlphOmanyteChamberAncientReplica
	bg_event  3,  2, BGEVENT_UP, RuinsOfAlphOmanyteChamberPuzzle
	bg_event  4,  2, BGEVENT_UP, RuinsOfAlphOmanyteChamberDescriptionSign
	bg_event  3,  0, BGEVENT_UP, RuinsOfAlphOmanyteChamberWallPatternLeft
	bg_event  4,  0, BGEVENT_UP, RuinsOfAlphOmanyteChamberWallPatternRight

	def_object_events
