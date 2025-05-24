SafariZoneFuchsiaGateBeta_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	setevent EVENT_ENTERED_SAFARI_ZONE
	endcallback

SafariGateEmployeeScript:
	jumptextfaceplayer SafariGateEmployeeText

SafariGateEmployeeText: ; TO TRANSLATE
	text "Oh, hi boss!"
	done

SafariZoneFuchsiaGateBeta_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, SAFARI_ZONE_BETA, 1
	warp_event  5,  0, SAFARI_ZONE_BETA, 2
	warp_event  4,  7, FUCHSIA_CITY, 7
	warp_event  5,  7, FUCHSIA_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event 0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SafariGateEmployeeScript, EVENT_SAFARI_PARK_EMPLOYEES

