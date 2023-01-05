	object_const_def
	const GOLDENRODDEPTSTORE4F_CLERK
	const GOLDENRODDEPTSTORE4F_COOLTRAINER_M
	const GOLDENRODDEPTSTORE4F_BUG_CATCHER
	const GOLDENRODDEPTSTORE4F_GAMEBOY_KID

GoldenrodDeptStore4F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodDeptStore4FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_4F
	closetext
	end

GoldenrodDeptStore4FCooltrainerMScript:
	readmem wCurFreedomState
	ifequal 4, .lockdown
	jumptextfaceplayer GoldenrodDeptStore4FCooltrainerMText
	
.lockdown
	jumptextfaceplayer GoldenrodDeptStore4FCooltrainerMLockdownText

GoldenrodDeptStore4FBugCatcherScript:
	jumptextfaceplayer GoldenrodDeptStore4FBugCatcherText

GoldenrodDeptStore4FGameboyKidScript:
	faceplayer
	opentext
	writetext GoldenrodDeptStore4FGameboyKidText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTORE4F_GAMEBOY_KID, DOWN
	end

GoldenrodDeptStore4FDirectory:
	jumptext GoldenrodDeptStore4FDirectoryText

GoldenrodDeptStore4FElevatorButton:
	jumpstd ElevatorButtonScript

GoldenrodDeptStore4FShelfItem1Script:
	shelfitem 10, SUPER_REPEL, 4000

GoldenrodDeptStore4FShelfItem2Script:
	shelfitem 10, ELIXER, 24000

GoldenrodDeptStore4FCooltrainerMText:
	text "Hey. I love strong"
	line "#MON."

	para "I feed them PRO-"
	line "TEIN to crank up"
	cont "their ATTACK."
	done

GoldenrodDeptStore4FCooltrainerMLockdownText:
	text "I like to hide in"
	line "here while the"
	cont "store is closed"
	cont "heehee!"
	done

GoldenrodDeptStore4FBugCatcherText:
	text "IRON adds to your"
	line "#MON's DEFENSE."
	done

GoldenrodDeptStore4FGameboyKidText:
	text "Some #MON"
	line "evolve only by"

	para "being traded via a"
	line "Game Link cable."

	para "I know of four:"
	line "MACHOKE, KADABRA,"

	para "HAUNTER and, um,"
	line "GRAVELER."

	para "I heard there are"
	line "others too."
	done

GoldenrodDeptStore4FDirectoryText:
	text "Let Us Pump Up"
	line "Your #MON!"

	para "4F MEDICINE BOX"
	done

GoldenrodDeptStore4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_5F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_3F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore4FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore4FElevatorButton

	def_object_events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FClerkScript, -1
	object_event 11,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FCooltrainerMScript, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FBugCatcherScript, -1
	object_event  5,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FGameboyKidScript, -1
	object_event  2,  5, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_LOCKDOWN, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FShelfItem1Script, EVENT_MART_GOLDENROD_4F_1_MISSED
	object_event  8,  1, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_LOCKDOWN, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FShelfItem2Script, EVENT_MART_GOLDENROD_4F_2_MISSED
