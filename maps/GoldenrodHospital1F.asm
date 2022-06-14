	object_const_def
	const GOLDENROD_HOSPITAL_RECEPTIONIST1
	const GOLDENROD_HOSPITAL_RECEPTIONIST2
	const GOLDENROD_HOSPITAL_CHANSEY1
	const GOLDENROD_HOSPITAL_SCIENTIST_THANKFUL
	const GOLDENROD_HOSPITAL_PATIENT1
	const GOLDENROD_HOSPITAL_PATIENT2
	const GOLDENROD_HOSPITAL_PATIENT3
	;const GOLDENROD_HOSPITAL_PATIENT4

GoldenrodHospital1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	readvar VAR_XCOORD
	ifnotequal 5, .quit
	readvar VAR_YCOORD
	ifnotequal 9, .quit
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.quit:
	endcallback

GoldenrodHospitalNurse1Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue AskGelScript
	jumptextfaceplayer GoldenrodHospitalNurse1Text

AskGelScript:
	jumptextfaceplayer GoldenrodHospitalAskGelText

GoldenrodHospitalGelScript:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleHandWash
	writetext GoldenrodHospital1FWashHandsMaleText
	sjump .boops

.FemaleHandWash:
	writetext GoldenrodHospital1FWashHandsFemaleText

.boops:
	waitsfx
	playsound SFX_2_BOOPS
	waitsfx
	pause 10
	closetext
	end

GoldenrodHospitalThankOakScript:
	jumptextfaceplayer GoldenrodHospital1FThankOakText

GoldenrodHospitalChansey1Script:
	cry CHANSEY
	jumptext GoldenrodHospitalChanseySeriousText

GoldenrodHospitalChanseyKicksYouScript:
	cry CHANSEY
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, GOLDENROD_HOSPITAL_CHANSEY1, 15
	waitsfx
	pause 10
	applymovement PLAYER, GoldenrodHospital_PlayerDownMovement
	end

GoldenrodHospitalPokefan1Script:
	jumptext GoldenrodHospitalPokefan1Text

GoldenrodHospitalBlackglassesScript:
	jumptext GoldenrodHospitalPharmacist1Text

GoldenrodHospitalTwin1Script:
	jumptextfaceplayer GoldenrodHospital1FTwin1Text

GoldenrodHospitalCoughScript:
	jumptextfaceplayer GoldenrodHospital1FCoughText

GoldenrodHospitalKarenScript:
	jumptext GoldenrodHospitalKarenText

GoldenrodHospitalGranny1Script:
	jumptext GoldenrodHospitalGranny1Text

GoldenrodHospitalNursePatientScript:
	jumptext GoldenrodHospitalNursePatientText

GoldenrodHospital_PlayerDownMovement:
	slow_step DOWN
	step_end

GoldenrodHospital1FWashHandsMaleText:
	text_far _PlayersPCSanitizerText
	text_end

GoldenrodHospital1FWashHandsFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

GoldenrodHospitalNurse1Text:
	text "Welcome!"
	done

GoldenrodHospitalChanseySeriousText:
	text "This CHANSEY"
	line "looks serious."
	done

GoldenrodHospitalAskGelText:
	text "Please wash your"
	line "hands using the"
	cont "hand sanitizer"
	cont "gel available"
	cont "at the entrance."
	done

GoldenrodHospital1FThankOakText:
	text "At the very begin-"
	line "ning of the epi-"
	cont "demic several"
	cont "whistleblowers"
	cont "have been ignored"
	cont "or mocked."

	para "Even though PROF."
	line "OAK is not an"
	cont "epidemiology spe-"
	cont "cialist, he is"
	cont "respected and"
	cont "people listen to"
	cont "its guidance."

	para "Without its inter-"
	line "vention, the"
	cont "situation could"
	cont "have been way"
	cont "worse."

	para "We are thankful"
	line "for him and his"
	cont "team."
	done

GoldenrodHospital1FTwin1Text:
	text "On TV they say"
	line "only old people"
	cont "can get sick from"
	cont "the virus."

	para "But my brother got"
	line "it, and I think"
	cont "it's my turn now."
	done

GoldenrodHospital1FCoughText:
	text "(cough) (cough)"
	line "…"
	done

GoldenrodHospitalKarenText:
	text "I'm visiting my"
	line "grandmother."

	para "She…"

	para "She caught"
	line "the virus."
	done

GoldenrodHospitalPokefan1Text:
	text "My dear #MON"
	line "was brought here"
	cont "urgently…"

	para "No one informed me"
	line "if she is well."

	para "I came to check"
	line "on her."
	done

GoldenrodHospitalPharmacist1Text:
	text "I'm not sure"
	line "I'm gonna make it."

	para "(COUGH COUGH)"

	para "Listen kid."

	para "Live every day"
	line "like its your"
	cont "last day."

	para "You never know"
	line "what comes"
	cont "tomorrow."
	done

GoldenrodHospitalGranny1Text:
	text "I've been waiting"
	line "here 10 hours"
	cont "and counting…"
	done

GoldenrodHospitalNursePatientText:
	text "(cough)"
	
	para "Even nurses"
	line "can get sick."

	para "Even though we are"
	line "taking a lot of"
	cont "precautions, we"
	cont "are the most"
	cont "exposed and a lot"
	cont "of my colleagues"
	cont "are getting sick."
	done

GoldenrodHospital1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  9, GOLDENROD_CITY, 16
	warp_event  5,  9, GOLDENROD_CITY, 16
	warp_event  6,  9, GOLDENROD_CITY, 16
	warp_event  7,  9, GOLDENROD_CITY, 16

	def_coord_events

	def_bg_events
	bg_event  8,  9, BGEVENT_READ, GoldenrodHospitalGelScript

	def_object_events
	object_event  5,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNurse1Script, -1
	object_event  7,  5, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNurse1Script, -1
	object_event 15,  5, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalChansey1Script, -1
	object_event  1,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalThankOakScript, -1
	object_event 17,  1, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalPokefan1Script, -1
	object_event 17,  1, SPRITE_NURSE, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNursePatientScript, -1
	object_event 14,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCoughScript, -1
	object_event 16,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalGranny1Script, -1
	object_event 12,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalTwin1Script, -1
	object_event 15,  1, SPRITE_KAREN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalKarenScript, EVENT_ROUTE_36_SUDOWOODO
	object_event 15,  1, SPRITE_PHARMACIST, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalBlackglassesScript, -1
