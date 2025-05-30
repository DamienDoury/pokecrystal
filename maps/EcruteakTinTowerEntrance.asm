	object_const_def
	const ECRUTEAKTINTOWERENTRANCE_SAGE1
	const ECRUTEAKTINTOWERENTRANCE_VP_CONTROLLER
	const ECRUTEAKTINTOWERENTRANCE_SAGE2
	const ECRUTEAKTINTOWERENTRANCE_SAGE3
	const ECRUTEAKTINTOWERENTRANCE_GRAMPS

EcruteakTinTowerEntrance_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .InitializeSages

.VaccinePassport:
	jumpstd VaccinePassCheckpoint
	
.InitializeSages:
	checkevent EVENT_FOUGHT_SUICUNE
	iftrue .DontBlockTower
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue .DontBlockTower
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .BlockTower
	endcallback

.BlockTower:
	clearevent EVENT_TINTOWER_SAGE_LEFT
	setevent EVENT_TINTOWER_SAGE_RIGHT
	setevent EVENT_ECRUTEAK_TIN_TOWER_ENTRANCE_WANDERING_SAGE
	checkitem CLEAR_BELL
	iftrue .GotClearBell
	clearevent EVENT_RANG_CLEAR_BELL ; This doesn't get reset when the player carries the Clear Bell.
.GotClearBell:
	endcallback

.DontBlockTower:
	clearevent EVENT_ECRUTEAK_TIN_TOWER_ENTRANCE_WANDERING_SAGE
	endcallback

EcruteakTinTowerEntranceSageBlocksLeft:
	checkevent EVENT_TINTOWER_SAGE_RIGHT
	iftrue EcruteakTinTowerEntranceAlreadyBlocked
	applymovement ECRUTEAKTINTOWERENTRANCE_SAGE2, EcruteakTinTowerEntranceSageBlocksLeftMovement
	moveobject ECRUTEAKTINTOWERENTRANCE_SAGE1, 4, 6
	appear ECRUTEAKTINTOWERENTRANCE_SAGE1
	pause 1
	disappear ECRUTEAKTINTOWERENTRANCE_SAGE2
	end

EcruteakTinTowerEntranceSageBlocksRight:
	checkevent EVENT_TINTOWER_SAGE_LEFT
	iftrue EcruteakTinTowerEntranceAlreadyBlocked
	applymovement ECRUTEAKTINTOWERENTRANCE_SAGE1, EcruteakTinTowerEntranceSageBlocksRightMovement
	moveobject ECRUTEAKTINTOWERENTRANCE_SAGE2, 5, 6
	appear ECRUTEAKTINTOWERENTRANCE_SAGE2
	pause 1
	disappear ECRUTEAKTINTOWERENTRANCE_SAGE1
	end

EcruteakTinTowerEntranceAlreadyBlocked:
	end

EcruteakTinTowerEntranceSageScript:
	faceplayer
	opentext
	checkflag ENGINE_FOGBADGE
	iffalse .BlockPassage_NoFogBadge

	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .CheckForClearBell

	checkflag ENGINE_FOGBADGE
	iftrue .BlockPassage_GotFogBadge

.BlockPassage_NoFogBadge:
	writetext EcruteakTinTowerEntranceSageText
	waitbutton
	closetext
	end

.BlockPassage_GotFogBadge:
	writetext EcruteakTinTowerEntranceSageText_GotFogBadge
	waitbutton
	closetext
	end

.CheckForClearBell:
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue .AllowedThrough
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .RangClearBell
	checkitem CLEAR_BELL
	iftrue .GotClearBell
	writetext EcruteakTinTowerEntranceSageText_NoClearBell
	waitbutton
	closetext
	end

.GotClearBell:
	writetext EcruteakTinTowerEntranceSageText_HearsClearBell
	waitbutton
	closetext
	setevent EVENT_RANG_CLEAR_BELL
	setevent EVENT_TINTOWER_SAGE_RIGHT
	clearevent EVENT_TINTOWER_SAGE_LEFT
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

.AllowedThrough:
	writetext EcruteakTinTowerEntranceSageText_PleaseDoGoOn
	waitbutton
	closetext
	end

.RangClearBell:
	writetext EcruteakTinTowerEntranceSageText_HeardClearBell
	waitbutton
	closetext
	end

EcruteakTinTowerEntranceWanderingSageScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_CLEAR_BELL
	iftrue .GotClearBell
	writetext EcruteakTinTowerEntranceWanderingSageText
	waitbutton
	closetext
	end

.GotClearBell:
	writetext EcruteakTinTowerEntranceWanderingSageText_GotClearBell
	waitbutton
	closetext
	end

EcruteakTinTowerEntranceGrampsScript:
	faceplayer
	jumptext EcruteakTinTowerEntranceGrampsText

EcruteakTinTowerEntranceSageBlocksLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	turn_head DOWN
	step_end

EcruteakTinTowerEntranceSageBlocksRightMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	turn_head DOWN
	step_end

EcruteakTinTowerEntranceSageText: 
if DEF(_FR_FR)
	text "La TOUR FERRAILLE"
	line "est inaccessible à"

	para "tous ceux qui"
	line "n'ont pas le BADGE"

	para "de l'ARENE de"
	line "ROSALIA."
	cont "Désolé, mais vous"
	cont "devez partir."
else
	text "TIN TOWER is off"
	line "limits to anyone"

	para "without ECRUTEAK"
	line "GYM's BADGE."

	para "Sorry, but you'll"
	line "have to leave."
endc

	done

EcruteakTinTowerEntranceSageText_GotFogBadge: 
if DEF(_FR_FR)
	text "La TOUR FERRAILLE"
	line "est inaccessible à"

	para "tous ceux qui"
	line "n'ont pas le BADGE"

	para "de l'ARENE de"
	line "ROSALIA."

	para "Ah!"

	para "Le BADGE de"
	line "l'ARENE de"
	cont "ROSALIA! Vous"
	cont "pouvez passer."
else
	text "TIN TOWER is off"
	line "limits to anyone"

	para "without ECRUTEAK"
	line "GYM's BADGE."

	para "Ah!"

	para "ECRUTEAK's GYM"
	line "BADGE! Please, go"
	cont "right through."
endc

	done

EcruteakTinTowerEntranceSageText_NoClearBell: 
if DEF(_FR_FR)
	text "Il y a un"
	line "problème."

	para "Excusez-moi, mais"
	line "vous devez"
	cont "partir."

	para "...Poyé polomi..."

	para "Le TRIO des SAGES"
	line "dit de drôles"
	cont "de trucs..."
else
	text "A momentous event"
	line "has occurred."

	para "I beg your pardon,"
	line "but I must ask you"
	cont "to leave."

	para "…What soothes the"
	line "soul…"

	para "The WISE TRIO say"
	line "things that are so"

	para "very difficult to"
	line "understand…"
endc

	done

EcruteakTinTowerEntranceSageText_HearsClearBell: 
if DEF(_FR_FR)
	text "Il y a un"
	line "problème."

	para "Excuse-moi, mais"
	line "tu dois"
	cont "partir."

	para "<……><……><……>"

	para "Ah!"

	para "Le son du GLAS"
	line "TRANSPARENT!"

	para "C'est... BEAU!"

	para "Je n'ai jamais"
	line "rien entendu"
	cont "d'aussi joli!"

	para "Le son du glas"
	line "reflète l'âme de"
	cont "son porteur."

	para "Toi..."

	para "Tu peux accéder à"
	line "la TOUR FERRAILLE."

	para "Va."
else
	text "A momentous event"
	line "has occurred."

	para "I beg your pardon,"
	line "but I must ask you"
	cont "to leave."

	para "<……><……><……>"

	para "Ah!"

	para "The sound of that"
	line "CLEAR BELL!"

	para "It… It's sublime!"

	para "I've never heard"
	line "so beautiful a"
	cont "sound before!"

	para "That bell's chime"
	line "is indicative of"
	cont "the bearer's soul."

	para "You…"

	para "You may be able to"
	line "make it through"
	cont "TIN TOWER."

	para "Please, do go on."
endc

	done

EcruteakTinTowerEntranceSageText_PleaseDoGoOn: 
if DEF(_FR_FR)
	text "Va."
else
	text "Please, do go on."
endc

	done

EcruteakTinTowerEntranceSageText_HeardClearBell: 
if DEF(_FR_FR)
	text "Le son du glas"
	line "reflète l'âme de"
	cont "son porteur."

	para "Toi..."

	para "Tu peux accéder à"
	line "la TOUR FERRAILLE."

	para "Va."
else
	text "That bell's chime"
	line "is indicative of"
	cont "the bearer's soul."

	para "You…"

	para "You may be able to"
	line "make it through"
	cont "TIN TOWER."

	para "Please, do go on."
endc

	done

EcruteakTinTowerEntranceWanderingSageText: 
if DEF(_FR_FR)
	text "La TOUR FERRAILLE"
	line "est d'une pure"
	cont "beauté."

	para "Elle apaise tous"
	line "ceux qui la"
	cont "regardent."
else
	text "The TIN TOWER"
	line "ahead is a nine-"

	para "tier tower of"
	line "divine beauty."

	para "It soothes the"
	line "soul of all who"
	cont "see it."
endc

	done

EcruteakTinTowerEntranceWanderingSageText_GotClearBell: 
if DEF(_FR_FR)
	text "La TOUR FERRAILLE"
	line "tremble! Un #-"

	para "MON doit s'être"
	line "posé au sommet!"
else
	text "The TIN TOWER"
	line "shook! A #MON"

	para "must have returned"
	line "to the top!"
endc

	done

EcruteakTinTowerEntranceGrampsText: 
if DEF(_FR_FR)
	text "Deux tours..."
	line "Deux #MON..."

	para "Mais lorsqu'une"
	line "d'entre elles a"

	para "brûlé, les deux"
	line "#MON se sont"
	cont "envolés et ne sont"
	cont "jamais revenus."
else
	text "Two towers…"
	line "Two #MON…"

	para "But when one"
	line "burned down, both"

	para "#MON flew away,"
	line "never to return."
endc

	done

EcruteakTinTowerEntrance_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 3
	warp_event  5, 17, ECRUTEAK_CITY, 3
	warp_event  5,  3, ECRUTEAK_TIN_TOWER_ENTRANCE, 4
	warp_event 17, 15, ECRUTEAK_TIN_TOWER_ENTRANCE, 3
	warp_event 17,  3, WISE_TRIOS_ROOM, 3

	def_coord_events
	coord_event  4,  7, CE_EVENT_FLAG_CLEARED, EVENT_RANG_CLEAR_BELL, EcruteakTinTowerEntranceSageBlocksLeft
	coord_event  5,  7, CE_EVENT_FLAG_CLEARED, EVENT_RANG_CLEAR_BELL, EcruteakTinTowerEntranceSageBlocksRight

	def_bg_events

	def_object_events
	object_event  4,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceSageScript, EVENT_TINTOWER_SAGE_LEFT
	object_event  4, 14, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  5,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceSageScript, EVENT_TINTOWER_SAGE_RIGHT
	object_event  6,  9, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceWanderingSageScript, EVENT_ECRUTEAK_TIN_TOWER_ENTRANCE_WANDERING_SAGE
	object_event  3, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceGrampsScript, EVENT_ECRUTEAK_TIN_TOWER_ENTRANCE_WANDERING_SAGE
