	object_const_def
	const GOLDENRODHOSPITALOFFICE_CHIEF

GoldenrodHospitalOffice_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodHospitalOfficeChiefScript:
	jumptextfaceplayer GoldenrodHospitalOfficeChiefText

GoldenrodHospitalOfficePrinterScript:
	jumptext GoldenrodHospitalOfficePrinterText

GoldenrodHospitalOfficeDiplomaScript:
	jumptext VeryPrestigiousDiplomaText

GoldenrodHospitalBookshelfScript:
	jumpstd DifficultBookshelfScript
	
GoldenrodHospitalOfficeChiefText:
	text "Perfect!"
	line "Now we can talk!"
	done

GoldenrodHospitalOfficePrinterText:
	text "The screen says"
	line "“Out of paper”"
	done

VeryPrestigiousDiplomaText:
	text "A diploma from a"
	line "very prestigious"
	cont "medical school."
	done

GoldenrodHospitalOffice_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  9, DYNAMIC_WARP_PREVIOUS ; Sends back to the reception.
	warp_event  3,  9, DYNAMIC_WARP_PREVIOUS ; Sends back to the reception.

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_READ, GoldenrodHospitalOfficePrinterScript
	bg_event  1,  2, BGEVENT_READ, GoldenrodHospitalOfficeDiplomaScript
	bg_event  5,  2, BGEVENT_READ, GoldenrodHospitalBookshelfScript

	def_object_events
	object_event  3,  5, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalOfficeChiefScript, -1
