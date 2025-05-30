RuinsOfAlphAerodactylChamber_MapScripts:
	def_scene_scripts
	scene_script .CheckWall ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .HiddenDoors

.CheckWall:
	checkevent EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	iftrue .OpenWall
	end

.OpenWall:
	prioritysjump .WallOpenScript
	end

.DummyScene:
	end

.HiddenDoors:
	checkevent EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $2e ; closed wall
.WallOpen:
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
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

RuinsOfAlphAerodactylChamberPuzzle:
	refreshscreen
	setval UNOWNPUZZLE_AERODACTYL
	special UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_AERODACTYL_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_S_TO_W
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $18 ; left hole
	changeblock 4, 2, $19 ; right hole
	reloadmappart
	playsound SFX_STRENGTH
	earthquake 80
	applymovement PLAYER, RuinsOfAlphAerodactylChamberSkyfallTopMovement
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

RuinsOfAlphAerodactylChamberAncientReplica:
	jumptext RuinsOfAlphAerodactylChamberAncientReplicaText

RuinsOfAlphAerodactylChamberDescriptionSign:
	jumptext RuinsOfAlphAerodactylChamberDescriptionText

RuinsOfAlphAerodactylChamberWallPatternLeft:
	opentext
	writetext RuinsOfAlphAerodactylChamberWallPatternLeftText
	setval UNOWNWORDS_LIGHT
	special DisplayUnownWords
	closetext
	end

RuinsOfAlphAerodactylChamberWallPatternRight:
	checkevent EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	iftrue .WallOpen
	opentext
	writetext RuinsOfAlphAerodactylChamberWallPatternRightText
	setval UNOWNWORDS_LIGHT
	special DisplayUnownWords
	closetext
	end

.WallOpen:
	opentext
	writetext RuinsOfAlphAerodactylChamberWallHoleText
	waitbutton
	closetext
	end

RuinsOfAlphAerodactylChamberSkyfallTopMovement:
	skyfall_top
	step_end

RuinsOfAlphAerodactylChamberWallPatternLeftText: 
if DEF(_FR_FR)
	text "Des figures sont"
	line "apparues sur les"
	cont "murs..."
else
	text "Patterns appeared"
	line "on the walls…"
endc

	done

RuinsOfAlphAerodactylChamberUnownText: ; unreferenced
	text "It's UNOWN text!"
	done

RuinsOfAlphAerodactylChamberWallPatternRightText: 
if DEF(_FR_FR)
	text "Des figures sont"
	line "apparues sur les"
	cont "murs..."
else
	text "Patterns appeared"
	line "on the walls…"
endc

	done

RuinsOfAlphAerodactylChamberWallHoleText: 
if DEF(_FR_FR)
	text "Il y a un gros"
	line "trou dans le mur!"
else
	text "There's a big hole"
	line "in the wall!"
endc

	done

RuinsOfAlphAerodactylChamberAncientReplicaText: 
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

RuinsOfAlphAerodactylChamberDescriptionText: 
if DEF(_FR_FR)
	text "Ce #MON volant"
	line "attaquait ses"

	para "proies de ses"
	line "crocs acérés."
else
	text "This flying #-"
	line "MON attacked its"

	para "prey with saw-like"
	line "fangs."
endc

	done

RuinsOfAlphAerodactylChamber_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 4
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 4
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 8
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 9
	warp_event  4,  0, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, RuinsOfAlphAerodactylChamberAncientReplica
	bg_event  5,  3, BGEVENT_READ, RuinsOfAlphAerodactylChamberAncientReplica
	bg_event  3,  2, BGEVENT_UP, RuinsOfAlphAerodactylChamberPuzzle
	bg_event  4,  2, BGEVENT_UP, RuinsOfAlphAerodactylChamberDescriptionSign
	bg_event  3,  0, BGEVENT_UP, RuinsOfAlphAerodactylChamberWallPatternLeft
	bg_event  4,  0, BGEVENT_UP, RuinsOfAlphAerodactylChamberWallPatternRight

	def_object_events
