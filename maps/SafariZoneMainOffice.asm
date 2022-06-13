SafariZoneMainOffice_MapScripts:
	def_scene_scripts

	def_callbacks

FuchsiaCityMaxElixer:
	hiddenitem MAX_ELIXER, EVENT_FOUND_FUCHSIA_MAX_ELIXER

SafariZoneMainOffice_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 2
	warp_event  3,  7, FUCHSIA_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_ITEM, FuchsiaCityMaxElixer

	def_object_events
