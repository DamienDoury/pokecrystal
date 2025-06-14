	object_const_def
	const ROUTE34ILEXFORESTGATE_TEACHER1
	const ROUTE34ILEXFORESTGATE_BUTTERFREE
	const ROUTE34ILEXFORESTGATE_LASS
	const ROUTE34ILEXFORESTGATE_TEACHER2

Route34IlexForestGate_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .IsForestRestless

.IsForestRestless:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse .Normal

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	endcallback

.Normal:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

Route34IlexForestGateCelebiEvent:
	showemote EMOTE_SHOCK, ROUTE34ILEXFORESTGATE_TEACHER2, 20
	turnobject ROUTE34ILEXFORESTGATE_TEACHER2, LEFT
	turnobject PLAYER, RIGHT
	follow PLAYER, ROUTE34ILEXFORESTGATE_TEACHER2
	applymovement PLAYER, Route34IlexForestGateTeacherBlocksPlayerMovement
	stopfollow
	applymovement ROUTE34ILEXFORESTGATE_TEACHER2, Route34IlexForestGateTeacherStepsBackMovement
	turnobject PLAYER, DOWN
	opentext
	writetext Route34IlexForestGateTeacher_ForestIsRestless
	waitbutton
	closetext
	applymovement ROUTE34ILEXFORESTGATE_TEACHER2, Route34IlexForestGateTeacherReturnsMovement
	end

Route34IlexForestGateTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue .ForestIsRestless
	checkitem TM_SWEET_SCENT
	iftrue .GotSweetScent
	writetext Route34IlexForestGateTeacherText
	promptbutton
	verbosegiveitem TM_SWEET_SCENT
.GotSweetScent:
	writetext Route34IlexForestGateTeacher_GotSweetScent
	waitbutton
	closetext
	end

.ForestIsRestless:
	writetext Route34IlexForestGateTeacher_ForestIsRestless
	promptbutton
	closetext
	end

Route34IlexForestGateButterfreeScript:
	opentext
	writetext Route34IlexForestGateButterfreeText
	cry BUTTERFREE
	waitbutton
	closetext
	end

Route34IlexForestGateLassScript:
	jumptextfaceplayer Route34IlexForestGateLassText

Route34IlexForestGateTeacherBlocksPlayerMovement:
	step UP
	step UP
	step_end

Route34IlexForestGateTeacherStepsBackMovement:
	step DOWN
	turn_head UP
	step_end

Route34IlexForestGateTeacherReturnsMovement:
	step RIGHT
	step_end

Route34IlexForestGateTeacherText: ; TO TRANSLATE
	text "Oh honey, can you"
	line "please get rid of"
	cont "this for me?"
	done

Route34IlexForestGateTeacher_GotSweetScent: ; TO TRANSLATE
	text "It's SWEET SCENT."

	para "Use it wherever"
	line "#MON appear."

	para "They will be"
	line "enticed by it."

	para "But this copy"
	line "is broken."

	para "My BUTTERFREE uses"
	line "it often, and I"
	
	para "haven't been able"
	line "to smell it"
	cont "recently."
	done

Route34IlexForestGateTeacher_ForestIsRestless: ; TO TRANSLATE
	text "Something's wrong"
	line "in ILEX FOREST,"
	cont "I can smell it…"

	para "Well, I don't smell"
	line "anything. It's a"
	cont "figure of speech."

	para "But I can"
	line "feel it…"

	para "You should stay"
	line "away right now."
	done

Route34IlexForestGateButterfreeText: 
if DEF(_FR_FR)
	text "PAPILUSION: Piiii!"
else
	text "BUTTERFREE: Freeh!"
endc

	done

Route34IlexForestGateLassText: 
if DEF(_FR_FR)
	text "As-tu vu l'autel"
	line "en l'honneur du"
	cont "gardien?"

	para "Il protège le BOIS"
	line "depuis la nuit des"
	cont "temps."

	para "Ca doit être"
	line "un #MON de"
	cont "type PLANTE."
else
	text "Did you see the"
	line "shrine honoring"
	cont "the protector?"

	para "It watches over"
	line "the FOREST from"
	cont "across time."

	para "I think that it"
	line "must be a grass-"
	cont "type #MON."
endc

	done

Route34IlexForestGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, ROUTE_34, 1
	warp_event  5,  0, ROUTE_34, 2
	warp_event  4,  7, ILEX_FOREST, 1
	warp_event  5,  7, ILEX_FOREST, 1

	def_coord_events
	coord_event  4,  7, CE_EVENT_FLAG_SET, EVENT_FOREST_IS_RESTLESS, Route34IlexForestGateCelebiEvent

	def_bg_events

	def_object_events
	object_event  9,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateTeacherScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  9,  4, SPRITE_BUTTERFREE, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateButterfreeScript, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateLassScript, EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	object_event  5,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateTeacherScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
