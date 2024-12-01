	object_const_def
	const OLIVINEMART_CLERK
	const OLIVINEMART_VP_CONTROLLER
	const OLIVINEMART_COOLTRAINER_F
	const OLIVINEMART_LASS
	const OLIVINEMART_TWIN

OlivineMart_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

OlivineMartClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_OLIVINE
	closetext
	end

OlivineMartCooltrainerFScript:
	jumptextfaceplayer OlivineMartCooltrainerFText

OlivineMartLassScript:
	jumptextfaceplayer OlivineMartLassText

OlivineMartTwinScript:
	faceplayer
	opentext
	writetext OlivineMartYoungsterText
	waitbutton
	closetext
	turnobject OLIVINEMART_TWIN, UP
	end

OlivineMartShelfItem1Script:
	shelfitem 1, REVIVE, 1500

OlivineMartCooltrainerFText:
	text "Do your #MON"
	line "already know the"

	para "move for carrying"
	line "people on water?"
	done

OlivineMartLassText:
	text "My BUTTERFREE came"
	line "from my boyfriend"
	cont "overseas."

	para "It carried some"
	line "MAIL from him."

	para "Want to know what"
	line "it says?"

	para "Let's see… Nope!"
	line "It's a secret!"
	done

OlivineMartYoungsterText:
	text "A friend of mine"
	line "managed to find an"
	
	para "item in the back"
	line "of those empty"
	cont "shelves."
	
	para "It must have been"
	line "missed during the"
	cont "mart rush, because"

	para "it still had the"
	line "old price tag."
	cont "A true bargain!"
	done

OlivineMart_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 8
	warp_event  3,  7, OLIVINE_CITY, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineMartClerkScript, -1
	object_event  5,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  6,  2, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, OlivineMartCooltrainerFScript, -1
	object_event  1,  6, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineMartLassScript, -1
	object_event  8,  6, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, OlivineMartTwinScript, -1
	object_event 11,  4, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineMartShelfItem1Script, EVENT_MART_OLIVINE_MISSED
