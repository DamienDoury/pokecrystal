	object_const_def
	const RUINSOFALPHOUTSIDE_YOUNGSTER1
	const RUINSOFALPHOUTSIDE_SCIENTIST
	const RUINSOFALPHOUTSIDE_FISHER
	const RUINSOFALPHOUTSIDE_YOUNGSTER2
	const RUINSOFALPHOUTSIDE_YOUNGSTER3
	const RUINSOFALPHOUTSIDE_CONE1
	const RUINSOFALPHOUTSIDE_CONE2

RuinsOfAlphOutside_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_RUINSOFALPHOUTSIDE_NOTHING
	scene_script .DummyScene0 ; SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .ScientistCallback

.DummyScene0:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .end

	checkevent EVENT_RED_IN_MT_SILVER
	iftrue .end

	readvar VAR_XCOORD
	ifnotequal 10, .end

	prioritysjump RuinsOfAlph_PlayerStepsDown
.end
	end

.ScientistCallback:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .Scientist

	checkevent EVENT_RED_IN_MT_SILVER
	iftrue .Scientist

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

.Scientist
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .NoScientist
	ifequal 1 << CURFEW, .NoScientist
	checkflag ENGINE_UNOWN_DEX
	iftrue .NoScientist
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .MaybeScientist
	sjump .NoScientist

.MaybeScientist:
	readvar VAR_UNOWNCOUNT
	ifgreater 2, .YesScientist
	sjump .NoScientist

.YesScientist:
	appear RUINSOFALPHOUTSIDE_SCIENTIST
	setscene SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX
	endcallback

.NoScientist:
	disappear RUINSOFALPHOUTSIDE_SCIENTIST
	setscene SCENE_RUINSOFALPHOUTSIDE_NOTHING
	endcallback

.TilesLoad:
	; Research Center
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock 16, 10, $30

.EndTilesCallback
	endcallback

RuinsOfAlph_PlayerStepsDown:
	applymovement PLAYER, RuinsOfAlphOutsideStepDown2Movement
	end

RuinsOfAlphOutsideScientistScene1:
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST, RuinsOfAlphOutsideStepDownMovement
	turnobject RUINSOFALPHOUTSIDE_SCIENTIST, UP
	turnobject PLAYER, DOWN
	sjump RuinsOfAlphOutsideScientistSceneContinue

RuinsOfAlphOutsideScientistScene2:
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST, RuinsOfAlphOutsideStepRightMovement
	turnobject RUINSOFALPHOUTSIDE_SCIENTIST, LEFT
	turnobject PLAYER, RIGHT
	sjump RuinsOfAlphOutsideScientistSceneContinue

RuinsOfAlphOutsideScientistScript:
	faceplayer
RuinsOfAlphOutsideScientistSceneContinue:
	opentext
	writetext RuinsOfAlphOutsideScientistText
	waitbutton
	closetext
	playmusic MUSIC_SHOW_ME_AROUND
	readvar VAR_FACING
	ifequal DOWN, .FacingDown
	ifequal UP, .FacingUp
	ifequal LEFT, .FacingLeft
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST, RuinsOfAlphOutsideStepLeftMovement
	sjump .StartStroll
.FacingUp:
	applymovement PLAYER, RuinsOfAlphOutsideStepUpMovement
	sjump .StartStroll
.FacingDown:
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST, RuinsOfAlphOutsideStepUpMovement
	sjump .StartStroll
.FacingLeft:
	applymovement PLAYER, RuinsOfAlphOutsideStepLeftMovement
.StartStroll:
	follow RUINSOFALPHOUTSIDE_SCIENTIST, PLAYER
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST, RuinsOfAlphOutsideScientistWalkToLabMovement
	disappear RUINSOFALPHOUTSIDE_SCIENTIST
	stopfollow
	applymovement PLAYER, RuinsOfAlphOutsidePlayerEnterLabMovement
	setmapscene RUINS_OF_ALPH_RESEARCH_CENTER, SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX
	warpcheck
	end

RuinsOfAlphOutsideFisherScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_RUINS_COWARD
	iftrue .Next
	setevent EVENT_TALKED_TO_RUINS_COWARD
	writetext RuinsOfAlphOutsideFisherText1
	promptbutton
.Next:
	writetext RuinsOfAlphOutsideFisherText2
	waitbutton
	closetext
	end

RuinsOfAlphOutsideYoungster1Script:
	faceplayer
	opentext
	writetext RuinsOfAlphOutsideYoungster1Text
	waitbutton
	closetext
	end

RuinsOfAlphOutsideYoungster2Script:
	faceplayer
	opentext
	writetext RuinsOfAlphOutsideYoungster2Text
	waitbutton
	closetext
	turnobject RUINSOFALPHOUTSIDE_YOUNGSTER3, UP
	end

TrainerPsychicNathan:
	trainer PSYCHIC_T, NATHAN, EVENT_BEAT_PSYCHIC_NATHAN, PsychicNathanSeenText, PsychicNathanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicNathanAfterBattleText
	waitbutton
	closetext
	end

RuinsOfAlphDoorScript:
	jumptext RuinsOfAlphDoorText

RuinsOfAlphConeScript:
	jumptext RuinsOfAlphConeText

RuinsOfAlphOutsideMysteryChamberSign:
	jumptext RuinsOfAlphOutsideMysteryChamberSignText

RuinsOfAlphSign:
	jumptext RuinsOfAlphSignText

RuinsOfAlphResearchCenterSign:
	jumptext RuinsOfAlphResearchCenterSignText

RuinsOfAlphOutsideStepRightMovement:
	step RIGHT
	step_end

RuinsOfAlphOutsideStepLeftMovement:
	step LEFT
	step_end

RuinsOfAlphOutsideStepUpMovement:
	step UP
	step_end

RuinsOfAlphOutsideStepDown2Movement:
	step DOWN
RuinsOfAlphOutsideStepDownMovement:
	step DOWN
	step_end

RuinsOfAlphOutsideScientistWalkToLabMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step RIGHT
	step RIGHT
	step UP
	step UP
	step_end

RuinsOfAlphOutsidePlayerEnterLabMovement:
	step UP
	step_end

RuinsOfAlphOutsideScientistText: 
if DEF(_FR_FR)
	text "Hm? C'est un #-"
	line "DEX, n'est-ce pas?"
	cont "Puis-je le voir?"

	para "Il y a tant de"
	line "#MON..."

	para "Hmm? C'est quoi?"

	para "Quel est donc"
	line "ce #MON?"

	para "Il ressemble aux"
	line "inscriptions sur"

	para "les murs des"
	line "RUINES."

	para "Si ces dessins"
	line "sont des #MON,"
	cont "il doit y en avoir"
	cont "beaucoup d'autres."

	para "Je sais! Je vais"
	line "améliorer ton"
	cont "#DEX..."
	cont "Suis-moi."
else
	text "Hm? That's a #-"
	line "DEX, isn't it?"
	cont "May I see it?"

	para "There are so many"
	line "kinds of #MON."

	para "Hm? What's this?"

	para "What is this"
	line "#MON?"

	para "It looks like the"
	line "strange writing on"

	para "the walls of the"
	line "RUINS."

	para "If those drawings"
	line "are really #-"
	cont "MON, there should"
	cont "be many more."

	para "I know! Let me up-"
	line "grade your #-"
	cont "DEX. Follow me."
endc

	done

PsychicNathanSeenText: 
if DEF(_FR_FR)
	text "Hmmm... C'est"
	line "bizarre ici."
else
	text "Hmmm… This is a"
	line "strange place."
endc

	done

PsychicNathanBeatenText:
	text "…"
	done

PsychicNathanAfterBattleText: 
if DEF(_FR_FR)
	text "J'aime réfléchir"
	line "ici."
else
	text "I like thinking"
	line "here."
endc

	done

RuinsOfAlphOutsideMysteryChamberSignText: 
if DEF(_FR_FR)
	text "PIERRE MYSTERE"
	line "CHAMBRE du PANNEAU"
else
	text "MYSTERY STONE"
	line "PANEL CHAMBER"
endc

	done

RuinsOfAlphSignText: 
if DEF(_FR_FR)
	text "RUINES D'ALPHA"
	line "Bienvenue"
else
	text "RUINS OF ALPH"
	line "VISITORS WELCOME"
endc

	done

RuinsOfAlphResearchCenterSignText: 
if DEF(_FR_FR)
	text "RUINES D'ALPHA"
	line "CENTRE de"
	cont "RECHERCHE"

	para "La référence des"
	line "RUINES D'ALPHA"
else
	text "RUINS OF ALPH"
	line "RESEARCH CENTER"

	para "THE AUTHORITY ON"
	line "THE RUINS OF ALPH"
endc

	done

RuinsOfAlphOutsideFisherText1: ; TO TRANSLATE
	text "There is an odd"
	line "presence surroun-"
	cont "ding this area."
	done

RuinsOfAlphOutsideFisherText2: 
if DEF(_FR_FR)
	text "Il y a un secret"
	line "dans les RUINES!"

	para "Enfin je crois..."
else
	text "The RUINS hide a"
	line "huge secret!"

	para "…I think…"
endc

	done

RuinsOfAlphOutsideYoungster1Text: 
if DEF(_FR_FR)
	text "Il existe des"
	line "ZARBI différents."

	para "Nous les utilisons"
	line "pour nos codes"
	cont "secrets."
else
	text "There are many"
	line "kinds of UNOWN, so"

	para "we use them for"
	line "our secret codes."
endc

	done

RuinsOfAlphOutsideYoungster2Text: 
if DEF(_FR_FR)
	text "D… R… O… I… T…"
	line "Hmmm…"

	para "Quoi?"

	para "Je décode le"
	line "message!"
else
	text "A… H… E… A… D…"
	line "Hmm…"

	para "What?"

	para "I'm decoding this"
	line "message!"
endc

	done

RuinsOfAlphDoorText: ; TO TRANSLATE
	text "Our RESEARCH"
	line "CENTER has not"
	
	para "been deemed"
	line "essential."
	
	para "What an insult to"
	line "science!"

	para "We must stay"
	line "closed for now."
	done

RuinsOfAlphConeText: ; TO TRANSLATE
	text "RUINS OF ALPH"
	line "are closed to"
	cont "the public."
	done

RuinsOfAlphOutside_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 17, RUINS_OF_ALPH_HO_OH_CHAMBER, 1
	warp_event 14,  7, RUINS_OF_ALPH_KABUTO_CHAMBER, 1
	warp_event  2, 29, RUINS_OF_ALPH_OMANYTE_CHAMBER, 1
	warp_event 16, 33, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 1
	warp_event 10, 13, RUINS_OF_ALPH_INNER_CHAMBER, 1
	warp_event 17, 11, RUINS_OF_ALPH_RESEARCH_CENTER, 1
	warp_event  6, 19, UNION_CAVE_B1F, 1
	warp_event  6, 27, UNION_CAVE_B1F, 2
	warp_event  7,  5, ROUTE_36_RUINS_OF_ALPH_GATE, 3
	warp_event 13, 20, ROUTE_32_RUINS_OF_ALPH_GATE, 1
	warp_event 13, 21, ROUTE_32_RUINS_OF_ALPH_GATE, 2

	def_coord_events
	coord_event 11, 14, CE_SCENE_ID, SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX, RuinsOfAlphOutsideScientistScene1
	coord_event 10, 15, CE_SCENE_ID, SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX, RuinsOfAlphOutsideScientistScene2

	def_bg_events
	bg_event 16,  8, BGEVENT_READ, RuinsOfAlphOutsideMysteryChamberSign
	bg_event 12, 16, BGEVENT_READ, RuinsOfAlphSign
	bg_event 18, 12, BGEVENT_READ, RuinsOfAlphResearchCenterSign

	def_object_events
	object_event  4, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerPsychicNathan, -1
	object_event 11, 15, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideScientistScript, EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST
	object_event 13, 17, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideFisherScript, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	object_event 14, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideYoungster1Script, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	object_event 12,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideYoungster2Script, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	object_event 10, 14, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphConeScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14,  8, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphConeScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 17, 11, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphDoorScript, -1
