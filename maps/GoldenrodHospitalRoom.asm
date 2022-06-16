	object_const_def

GoldenrodHospitalRoom_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodHospitalRoomMedicineScript:
	jumptext GoldenrodHospitalRoomMedicineText

GoldenrodHospitalRoomMedicineText:
	text "Lots of different"
	line "medications."
	done

GoldenrodHospitalRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  9, GOLDENROD_HOSPITAL_CORRIDOR, DYNAMIC_WARP_PREVIOUS ; Sends back into the corridor, where we entered.
	warp_event  3,  9, GOLDENROD_HOSPITAL_CORRIDOR, DYNAMIC_WARP_PREVIOUS ; Sends back into the corridor, where we entered.

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, GoldenrodHospitalRoomMedicineScript
	bg_event  3,  3, BGEVENT_READ, GoldenrodHospitalRoomMedicineScript

	def_object_events
