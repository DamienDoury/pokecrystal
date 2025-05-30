	object_const_def
	const GOLDENRODDEPTSTORE3F_CLERK
	const GOLDENRODDEPTSTORE3F_SUPER_NERD
	const GOLDENRODDEPTSTORE3F_ROCKER

GoldenrodDeptStore3F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodDeptStore3FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_3F
	closetext
	end

GoldenrodDeptStore3FSuperNerdScript:
	jumptextfaceplayer GoldenrodDeptStore3FSuperNerdText

GoldenrodDeptStore3FRockerScript:
	faceplayer
	jumptext GoldenrodDeptStore3FRockerText

GoldenrodDeptStore3FDirectory:
	jumptext GoldenrodDeptStore3FDirectoryText

GoldenrodDeptStore3FElevatorButton:
	jumpstd ElevatorButtonScript

GoldenrodDeptStore3FSuperNerdText: 
if DEF(_FR_FR)
	text "Je suis super"
	line "speed!"

	para "J'utilise"
	line "VITESSE + pour"
	cont "booster mon"
	cont "#MON."
else
	text "I, I, I'm really"
	line "impatient!"

	para "I use X SPEED in"
	line "battle to speed up"
	cont "my #MON."
endc

	done

GoldenrodDeptStore3FRockerText: 
if DEF(_FR_FR)
	text "Hé! Quand tu te"
	line "bats, utilises-tu"
	cont "du SPECIAL +?"

	para "C'est impression-"
	line "nant! Ca booste"
	cont "vraiment ta stat"
	cont "d'ATQ.SPE!"
else
	text "Hey! When you bat-"
	line "tle, do you use X"
	cont "SPECIAL?"

	para "It's awesome. It"
	line "really jacks up"
	cont "SPECIAL ATTACK!"
endc

	done

GoldenrodDeptStore3FDirectoryText: 
if DEF(_FR_FR)
	text "Pour ceux qui"
	line "aiment gagner"

	para "2EME COLLECTION"
	line "     DE COMBAT"
else
	text "For Victory"
	line "Seekers"

	para "3F BATTLE"
	line "   COLLECTION"
endc

	done

GoldenrodDeptStore3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_2F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_4F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore3FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore3FElevatorButton

	def_object_events
	object_event  6,  1, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore3FClerkScript, -1
	object_event 12,  5, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore3FSuperNerdScript, -1
	object_event  2,  5, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore3FRockerScript, -1
