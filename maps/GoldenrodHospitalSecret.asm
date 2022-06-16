	object_const_def

GoldenrodHospitalSecret_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodHospitalSecret_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  9, GOLDENROD_HOSPITAL_1F, DYNAMIC_WARP_PREVIOUS ; Sends back to the reception.
	warp_event  3,  9, GOLDENROD_HOSPITAL_1F, DYNAMIC_WARP_PREVIOUS ; Sends back to the reception.

	def_coord_events

	def_bg_events

	def_object_events
