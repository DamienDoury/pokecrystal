	object_const_def
	const OLIVINECAFE_FISHING_GURU
	const OLIVINECAFE_VP_CONTROLLER
	const OLIVINECAFE_SAILOR1
	const OLIVINECAFE_SAILOR2

OlivineCafe_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

OlivineCafeFishingGuruScript:
	farscall OlivineCity_ToGoScript
	end

OlivineCafeStrengthSailorScript:
	faceplayer
	jumptext OlivineCafeSailorStrengthText

OlivineCafeSailorScript:
	turnobject OLIVINECAFE_SAILOR2, UP

	opentext
	writetext OlivineCafeSailorText
	waitbutton
	closetext

	pause 3

	faceplayer
	jumptext OlivineCafeSailorText2

OlivineCafeSailorStrengthText:
	text "OLIVINE CAFE used"
	line "to serve hearty"

	para "fares that gave"
	line "beefy SAILORS"
	cont "great STRENGTH!"

	para "But it wasn't"
	line "convenient to"
	cont "deliver."

	para "So they switched"
	line "to BERRY salads."
	done

OlivineCafeSailorText:
	text "Hurry up!"
	line "CHOP CHOP!"
	done
	
OlivineCafeSailorText2:
	text "If I ain't gettin"
	line "my order quickly,"
	cont "Imma miss m'boat!"
	done

OlivineCafe_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 7
	warp_event  3,  7, OLIVINE_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeFishingGuruScript, -1
	object_event  4,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  5,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeStrengthSailorScript, -1
	object_event  6,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeSailorScript, -1
