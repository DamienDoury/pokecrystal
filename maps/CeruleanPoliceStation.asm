	object_const_def
	const CERULEANPOLICESTATION_FISHING_GURU
	const CERULEANPOLICESTATION_POKEFAN_F
	const CERULEANPOLICESTATION_JENNY
	const CERULEANPOLICESTATION_SQUIRTLE
	const CERULEANPOLICESTATION_SQUIRTLE_SQUAD

CeruleanPoliceStation_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	checkevent EVENT_ROCKET_THIEF_CAUGHT
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.end
	endcallback

CeruleanPoliceStationFishingGuruScript:
	checkevent EVENT_ROCKET_THIEF_CAUGHT
	iftrue .rave_notification
	jumptextfaceplayer CeruleanPoliceStationFishingGuruText

.rave_notification:
	jumptextfaceplayer CeruleanPoliceStationRaveText

CeruleanPoliceStationPokefanFScript:
	jumptextfaceplayer CeruleanPoliceStationPokefanFText

CeruleanPoliceStationJennyScript:
	applymovement CERULEANPOLICESTATION_JENNY, CeruleanPoliceStationStompUpMovement
	pause 5
	faceplayer
	opentext
	writetext CeruleanPoliceStationJennyText
	waitbutton
	closetext
	applymovement CERULEANPOLICESTATION_JENNY, CeruleanPoliceStationStompUpMovement
	end

CeruleanDiglett:
	opentext
	writetext CeruleanDiglettText
	cry SQUIRTLE
	waitbutton
	closetext
	end

CeruleanCoolSquirtle:
	cry SQUIRTLE
	waitsfx
	opentext
	writetext CeruleanCoolSquirtleText
	cry SQUIRTLE
	waitbutton
	closetext
	end

CeruleanPoliceStationRaver:
	checkevent EVENT_ROCKET_THIEF_CAUGHT
	iffalse CeruleanPoliceCell
	
	jumptext CeruleanPoliceStationRaverText

CeruleanPoliceRocketCell:
	checkevent EVENT_ROCKET_THIEF_CAUGHT
	iffalse CeruleanPoliceCell
	
	jumptext CeruleanRocketPrisonerText

CeruleanPoliceCell:
	farjumptext EcruteakPoliceStationCustodyCellText

CeruleanPoliceStationPhoneScript:
	farjumptext EcruteakPoliceStationPhoneText

CeruleanPoliceStationSign:
	jumptext CeruleanPoliceStationSignText

CeruleanPoliceStationStompUpMovement:
	turn_step UP
	step_bump
	step_end

CeruleanPoliceStationFishingGuruText: 
if DEF(_FR_FR)
	text "On raconte qu'un"
	line "drôle de type"
	cont "rode dans le coin."

	para "Si c'est un vo-"
	line "leur, ça craint."
else
	text "I heard that some"
	line "shady character is"
	cont "skulking about."

	para "I won't stand for"
	line "it if he turns out"
	cont "to be a thief."
endc

	done

CeruleanPoliceStationRaveText:
if DEF(_FR_FR)
	text "Maintenant qu'on en"
	line "a fini avec ce"
	
	para "voleur, on a une"
	line "rave party illé-"
	cont "gale à stopper."

	para "Elle a habituelle-"
	line "ment lieu de nuit"
	cont "dans un coin"
	cont "abandonné."

	para "Mais on a du mal"
	line "à localiser"
	cont "l'endroit."
	done
else
	text "Now that we're done"
	line "with this thief,"

	para "we have to deal"
	line "with an illegal"
	cont "rave."

	para "We know it usual-"
	line "takes place in a"
	cont "deserted area"
	cont "late at night."

	para "But we're having"
	line "a hard time find-"
	cont "ing where."
	done
endc

CeruleanPoliceStationPokefanFText: 
if DEF(_FR_FR)
	text "Des voleurs nous"
	line "ont déjà volés."
else
	text "We were held up by"
	line "robbers before."
endc

	done

CeruleanDiglettText:
if DEF(_FR_FR)
	text "CARAPUCE: pupupu!"
	done
else
	text "SQUIRTLE: lelele!"
	done
endc

CeruleanCoolSquirtleText:
if DEF(_FR_FR)
	text "CHEF DU GANG DES"
	line "CARAPUCE: Cara!"
	done
else
	text "SQUIRTLE SQUAD"
	line "LEADER: Squirtle!"
	done
endc

CeruleanPoliceStationJennyText:
if DEF(_FR_FR)
	text "On suit ce type"
	line "depuis la dernière"
	cont "rave."

	para "Jeudi dernier,"
	line "on l'a arrêté"
	cont "en chemin vers"
	cont "une autre rave."

	para "Il refuse de dire"
	line "où il allait."
	done
else
	text "We've been watching"
	line "this dude since"
	cont "the last rave."
	
	para "Last Thursday we"
	line "caught him while"
	cont "he was heading to"
	cont "another party."

	para "He doesn't want to"
	line "tell us where"
	cont "he was going."
	done
endc

CeruleanPoliceStationRaverText:
if DEF(_FR_FR)
	text "Une cellule."
	
	para "Il y a un jeune"
	line "homme qui porte un"
	cont "drôle de chapeau"
	cont "festif et... un"
	cont "maillot de bain."
	done
else
	text "A custody cell."

	para "There's a young man"
	line "wearing a funny"
	cont "party hat and…"
	cont "a swimsuit."
	done
endc

CeruleanRocketPrisonerText:
if DEF(_FR_FR)
	text "Une cellule."
	
	para "Un sbire ROCKET"
	line "râle avec un"
	cont "lourd accent"
	cont "étranger."
	done
else
	text "A custody cell."

	para "There's a ROCKET"
	line "GRUNT swearing"
	cont "with a thick"
	cont "foreign accent."
	done
endc

CeruleanPoliceStationSignText:
if DEF(_FR_FR)
	text "Vers l'arrière-"
	line "cour."
	done
else
	text "To the backyard."
	line "Now robber-free!"
	done
endc

CeruleanPoliceStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, CERULEAN_CITY, 2
	warp_event  7,  9, CERULEAN_CITY, 2
	warp_event  0,  0, CERULEAN_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  1,  0, BGEVENT_READ, CeruleanPoliceStationSign
	bg_event  9,  1, BGEVENT_READ, CeruleanPoliceStationPhoneScript
	bg_event  3,  0, BGEVENT_READ, CeruleanPoliceStationRaver
	bg_event  5,  0, BGEVENT_READ, CeruleanPoliceCell
	bg_event  7,  0, BGEVENT_READ, CeruleanPoliceRocketCell

	def_object_events
	object_event  6,  3, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationFishingGuruScript, -1
	object_event  9,  6, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationPokefanFScript, -1
	object_event  3,  2, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanPoliceStationJennyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  9,  5, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanDiglett, -1
	object_event  1,  2, SPRITE_SQUIRTLE_SQUAD, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCoolSquirtle, -1
