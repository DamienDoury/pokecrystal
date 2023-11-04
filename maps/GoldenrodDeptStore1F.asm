	object_const_def
	const GOLDENRODDEPTSTORE1F_RECEPTIONIST
	const GOLDENRODDEPTSTORE1F_GENTLEMAN

GoldenrodDeptStore1F_MapScripts:
	def_scene_scripts
	scene_script DeptStoreEnterLockdownCheck ; SCENE_ALWAYS

	def_callbacks

DeptStoreEnterLockdownCheck:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	readmem wCurFreedomState
	ifnotequal 1 << LOCKDOWN, .end

	readvar VAR_XCOORD
	ifless 15, .end

	prioritysjump DeptStore_PlayerStepsDown

.end
	end

DeptStore_PlayerStepsDown:
	applymovement PLAYER, DeptStore_StepDownMovement
	end

GoldenrodDeptStore1FReceptionistScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	jumptextfaceplayer GoldenrodDeptStore1FReceptionistText

.lockdown
	jumptextfaceplayer GoldenrodDeptStore1FReceptionistClosedText

GoldenrodDeptStore1FGentlemanScript:
	checkevent EVENT_RED_BEATEN
	iffalse .redBeaten
	jumptextfaceplayer GoldenrodDeptStore1FGentlemanText

.redBeaten
	jumptextfaceplayer GoldenrodDeptStore1FGentlemanGameCornerText

GoldenrodDeptStore1FDirectory:
	jumptext GoldenrodDeptStore1FDirectoryText

GoldenrodDeptStore1FElevatorButton:
	jumpstd ElevatorButtonScript

GoldenrodDeptStore_Lockdown:
	jumptext DeptStore_FloorClosedText

DeptStore_StepDownMovement:
	step DOWN
	step DOWN
	step_end

GoldenrodDeptStore1FReceptionistText:
	text "Welcome to GOLDEN-"
	line "ROD DEPT.STORE."
	done

GoldenrodDeptStore1FReceptionistClosedText:
	text "The DEPT.STORE"
	line "is closed, but it"
	cont "is allowed to"
	cont "access the roof"
	cont "area."
	done

GoldenrodDeptStore1FGentlemanText:
	text "I just saw someone"
	line "carrying an item"

	para "that you can only"
	line "get as a prize"

	para "from the GAME"
	line "CORNER."

	para "How is it"
	line "possible?"

	para "The GAME CORNER"
	line "has been closed"
	
	para "since the lockdown"
	line "has been declared…"
	done

GoldenrodDeptStore1FGentlemanGameCornerText:
	text "The GAME CORNER is"
	line "offering a free"
	
	para "COIN CASE along"
	line "with 50 COINS to"

	para "celebrate their"
	line "grand re-opening!"
	done

GoldenrodDeptStore1FDirectoryText:
	text "1F SERVICE COUNTER"

	para "2F TRAINER'S"
	line "   MARKET"

	para "3F BATTLE"
	line "   COLLECTION"

	para "4F MEDICINE BOX"

	para "5F TM CORNER"

	para "6F TRANQUIL SQUARE"

	para "ROOFTOP LOOKOUT"
	done

DeptStore_FloorClosedText:
	text "“The DEPT.STORE"
	line "is not allowed to"
	cont "open because of"
	cont "the sanitary"
	cont "restrictions.”"
	done

GoldenrodDeptStore1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  7, GOLDENROD_CITY, 9
	warp_event  8,  7, GOLDENROD_CITY, 9
	warp_event 15,  0, GOLDENROD_DEPT_STORE_2F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore1FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore1FElevatorButton

	def_object_events
	object_event 10,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore1FReceptionistScript, -1
	object_event 11,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore1FGentlemanScript, -1
	object_event 15,  1, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore_Lockdown, -1
