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
	setval 0
	writemem wGoldenrodHospitalCorridorNumber ; Resetting the corridor count.
	readvar VAR_XCOORD
	ifnotequal 5, .quit
	readvar VAR_YCOORD
	ifnotequal 9, .quit
	setscene SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS
.quit:
	endcallback

GoldenrodHospitalNurse1Script:
	faceplayer
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iffalse GoldenrodHospitalTakeover
	checkscene
	ifequal SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS, AskGelScript

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .CleanHands

	opentext
	writetext GoldenrodHospitalCleanHandsText
	promptbutton
	closetext
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.CleanHands:
	checkmapscene GOLDENROD_HOSPITAL_CORRIDOR
	ifequal 0, .regulartext
	ifequal 1, .quest1_advance
	ifequal 2, .quest2_text
	ifequal 3, .quest3_advance
	ifgreater 3, .quest4_text

.quest1_advance:
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_2
.quest2_text:
	jumptextfaceplayer GoldenrodHospitalNurse1Step1Text

.quest3_advance:
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_4
.quest4_text
	jumptextfaceplayer GoldenrodHospitalNurse1Step3Text

.regulartext
	jumptextfaceplayer GoldenrodHospitalNurse1Text

GoldenrodHospitalTakeover:
	jumptext GoldenrodHospitalTakeoverNurse1Text

GoldenrodHospitalNurse2Script:
	faceplayer 
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iffalse GoldenrodHospitalTakeover
	checkscene
	ifequal SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS, AskGelScript

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .CleanHands

	opentext
	writetext GoldenrodHospitalCleanHandsText
	promptbutton
	closetext
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.CleanHands:
	opentext
	writetext GoldenrodHospitalNurse2Text_Intro
	waitbutton
	closetext

	applymovement GOLDENROD_HOSPITAL_RECEPTIONIST1, Hospital_NurseWalksToPC
	playsound SFX_BOOT_PC
	waitsfx
	pause 30

	applymovement GOLDENROD_HOSPITAL_RECEPTIONIST1, Hospital_NurseWalksBackFromPC
	faceplayer
	pause 1

	special GetQuantityOfHospitalizedMons
	getnum STRING_BUFFER_3
	
	opentext
	ifequal 0, .NoMon
	
	writetext GoldenrodHospitalNurse2Text_MonQuantity
	promptbutton

	ifequal 1, .SingleMon

	addval 4
	getnum STRING_BUFFER_3
	writetext GoldenrodHospitalNurse2Text_Reside
	sjump .CheckRecoveredMons

.SingleMon:
	writetext GoldenrodHospitalNurse2Text_Room5Solo	

.CheckRecoveredMons:
	special IsFirstHospitalMonReadyToLeave
	ifequal 0, .End

	promptbutton
	writetext GoldenrodHospitalNurse2Text_GoodNews
	promptbutton

	readvar VAR_PARTYCOUNT
	ifgreater 5, .PartyFullAtStart

	writetext GoldenrodHospitalNurse2Text_AreYouReady
	yesorno
	iftrue .PlayerAccepted
	writetext GoldenrodHospitalNurse2Text_ComeBackSoon
	sjump .End

.PlayerAccepted
	writetext GoldenrodHospitalNurse2Text_SignPapers
	readvar VAR_FACING
	ifequal LEFT, .InFrontOfPapers
	
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_RECEPTIONIST1, RIGHT
	pause 15
 	applymovement PLAYER, Hospital_PlayerWalksToPapers
	pause 15
	opentext
	sjump .HasSignedPapers

.InFrontOfPapers:
	promptbutton

.HasSignedPapers:
	; At this point, the player must have at least 1 available spot in its party, and 1 mon in the hospital box.
	special CountHospitalMonsReadyToLeave

.Loop:
	special RetrieveFirstMonFromHospitalBox

	writetext GoldenrodHospitalNurse2Text_MonReadyToLeave
	playsound SFX_KEY_ITEM
	waitsfx
	promptbutton	

	addval $ff ;-1
	ifgreater 0, .Loop

	special IsFirstHospitalMonReadyToLeave
	ifgreater 0, .ComeBackLater

	writetext GoldenrodHospitalNurse2Text_TakeCare
	sjump .End

.ComeBackLater:
	writetext GoldenrodHospitalNurse2Text_PartyFull2
	sjump .End

.PartyFullAtStart:
	writetext GoldenrodHospitalNurse2Text_PartyFull

.End:
	waitbutton
	closetext
	end

.NoMon:
	writetext GoldenrodHospitalNurse2Text_NoMon
	waitbutton
	closetext
	end

AskGelScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	jumptextfaceplayer GoldenrodHospitalAskGelText

GoldenrodHospitalGelScript:
	setmapscene GOLDENROD_HOSPITAL_1F, SCENE_GOLDENROD_HOSPITAL_DEFAULT
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

GoldenrodHospitalDepressedScientistScript:
	jumptextfaceplayer GoldenrodHospitalDepressedScientistText

GoldenrodHospitalCoughScript:
	jumptextfaceplayer GoldenrodHospital1FCoughText

GoldenrodHospitalKarenScript:
	jumptext GoldenrodHospitalKarenText

GoldenrodHospitalGranny1Script:
	jumptext GoldenrodHospitalGranny1Text

GoldenrodHospitalNursePatientScript:
	jumptext GoldenrodHospitalNursePatientText

GoldenrodHospitalRocketScript:
	jumptext GoldenrodHospitalRocketText

GoldenrodHospitalRocketCounterScript:
	jumptext GoldenrodHospitalRocketCounterText

GoldenrodHospitalRocket3Script:
	jumptextfaceplayer GoldenrodHospitalRocket3Text

GoldenrodHospital1FChiefNursePanel:
	jumptext GoldenrodHospital1FChiefNursePanelText

GoldenrodHospital1FScanner:	
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleScanner
	writetext GoldenrodHospitalScannerMaleText
	sjump .AfterScan

.FemaleScanner:
	writetext GoldenrodHospitalScannerFemaleText

.AfterScan:
	promptbutton
	closetext
	pause 15
	playsound SFX_WRONG; OK sound = SFX_ELEVATOR_END
	waitsfx
	pause 5
	opentext
	writetext GoldenrodHospitalScanFailText
	waitbutton
	closetext
	end

GoldenrodHospitalLockScript:
	jumptext GoldenrodHospitalLockText

GoldenrodHospital_PlayerDownMovement:
	slow_step DOWN
	step_end

GoldenrodHospital1FWashHandsMaleText:
	text_far _PlayersPCSanitizerText
	text_end

GoldenrodHospital1FWashHandsFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

GoldenrodHospital1fMaxPotion:
	hiddenitem MAX_POTION, EVENT_GOLDENROD_1F_CORRIDOR_MAX_POTION

GoldenrodHospitalNurse1Text:
	text "Welcome!"

	para "Please understand"
	line "that if you have a"
	cont "sick #MON, we"
	cont "cannot take it in."

	para "We have a limited"
	line "number of rooms,"
	cont "and can't take"
	cont "everyone in."

	para "Only nurses at"
	line "#MON CENTERS"
	cont "are habilitated"
	cont "to determine if a"
	cont "#MON needs to"
	cont "be sent here."
	done

	GoldenrodHospitalNurse1Step1Text:
	text "CHIEF NURSE JOY?"
	
	para "I haven't seen"
	line "her in a while."
	
	para "She must be in"
	line "her office."
	
	para "That's the door"
	line "behind me, next to"
	cont "the waiting room."
	done

GoldenrodHospitalNurse1Step3Text:
	text "If CHIEF NURSE JOY"
	line "isn't in her office"

	para "she must be doing"
	line "her round in the"
	cont "patient rooms."

	para "It will be on your"
	line "right, good luck"
	cont "finding her."
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

GoldenrodHospitalCleanHandsText:
	text "Thanks for washing"
	line "your hands."
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

GoldenrodHospitalRocketText:
	text "Yeah, I'm sitting"
	line "in a forbidden"
	cont "seat."

	para "SO WHAT?"

	para "I'm a rebel,"
	line "hehe!"
	done

GoldenrodHospitalRocketCounterText:
	text "Mind your own"
	line "business, I'm busy."
	done

GoldenrodHospitalRocket3Text:
	text "Finally we own"
	line "the RADIO TOWER!"
	done

GoldenrodHospitalTakeoverNurse1Text:
	text "I… I'm sorry"
	line "I can't help you"
	cont "at the moment…"
	done

GoldenrodHospitalDepressedScientistText:
	text "Our acute beds use"
	line "is at 100<PERCENT> of its"
	cont "capacity, which is"
	cont "reasonable."

	para "How so?"

	para "Some establish-"
	line "ments are working"
	cont "at up to 140<PERCENT> of"
	cont "their capacity."

	para "They added new"
	line "beds in existing"
	cont "rooms, and even in"
	cont "corridors!"

	para "Personel's working"
	line "extra hours at an"
	cont "increased pace."

	para "If patients keep"
	line "flowing in, our"
	cont "organization will"
	cont "end up collapsing."
	done

GoldenrodHospital1FChiefNursePanelText:
	text " CHIEF NURSE JOY"
	done

GoldenrodHospitalScannerFemaleText:
	text "<PLAYER> scans"
	line "her TRAINER CARD."
	done

GoldenrodHospitalScannerMaleText:
	text "<PLAYER> scans"
	line "his TRAINER CARD."
	done

GoldenrodHospitalScanFailText:
	text "FORBIDDEN"
	done

GoldenrodHospitalLockText:
	text "This door is elec-"
	line "tronically locked."
	done

GoldenrodHospitalNurse2Text_Intro:
	text "Hello trainer!"

	para "Let me check if"
	line "any #MON of"
	cont "yours is in here."

	para "Show me your"
	line "TRAINER CARD"
	cont "please."
	done

GoldenrodHospitalNurse2Text_NoMon:
	text "Lucky you, you"
	line "have no #MON in"
	cont "this hospital."
	done

GoldenrodHospitalNurse2Text_MonQuantity:
	text "We are currently"
	line "taking care of @"

	text_ram wStringBuffer3
	text_start
	cont "of them."
	done

GoldenrodHospitalNurse2Text_Room5Solo:
	text "You'll find it in"
	line "room 5."
	done

GoldenrodHospitalNurse2Text_Reside:
	text "They reside in"
	line "rooms 5 to @"
	text_ram wStringBuffer3
	text "."
	done

GoldenrodHospitalNurse2Text_GoodNews:
	text "Here is the"
	line "good news!"

	para "Some of your"
	line "#MON have fully"
	cont "recovered and are"
	cont "ready to leave."
	done

GoldenrodHospitalNurse2Text_PartyFull:
	text "Please make some"
	line "room in your party"
	cont "and come get them."
	done

GoldenrodHospitalNurse2Text_AreYouReady:
	text "Can you take them"
	line "away now?"
	done

GoldenrodHospitalNurse2Text_SignPapers:
	text "Sign those papers"
	line "and they're"
	cont "good to go!"
	done

GoldenrodHospitalNurse2Text_MonReadyToLeave:
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer1
	text " back!"
	done

GoldenrodHospitalNurse2Text_PartyFull2:
	text "Make room in your"
	line "party to get"
	cont "the others."
	done

GoldenrodHospitalNurse2Text_ComeBackSoon:
	text "Come back as soon"
	line "as possible."
	
	para "We need to free"
	line "rooms for other"
	cont "patients."
	done

GoldenrodHospitalNurse2Text_TakeCare:
	text "Take good care of"
	line "them and yourself."
	done

Hospital_NurseWalksToPC:
	slow_step UP
	slow_step LEFT
	slow_step LEFT
	turn_head UP
	step_end

Hospital_NurseWalksBackFromPC:
	slow_step RIGHT
	slow_step RIGHT
	slow_step DOWN
	step_end

Hospital_PlayerWalksToPapers:
	step RIGHT
	step RIGHT
	step UP
	step UP
	turn_head LEFT
	step_end

GoldenrodHospital1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  9, GOLDENROD_CITY, 16
	warp_event  5,  9, GOLDENROD_CITY, 16
	warp_event  6,  9, GOLDENROD_CITY, 16
	warp_event  7,  9, GOLDENROD_CITY, 16
	warp_event  5,  0, GOLDENROD_HOSPITAL_OFFICE, 1
	warp_event 19,  6, GOLDENROD_HOSPITAL_CORRIDOR, 1
	warp_event 19,  7, GOLDENROD_HOSPITAL_CORRIDOR, 2

	def_coord_events

	def_bg_events
	bg_event  8,  9, BGEVENT_READ, GoldenrodHospitalGelScript
	bg_event  4,  0, BGEVENT_READ, GoldenrodHospital1FChiefNursePanel
	bg_event 15,  9, BGEVENT_ITEM, GoldenrodHospital1fMaxPotion

	def_object_events
	object_event  7,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNurse2Script, -1
	object_event  5,  5, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNurse1Script, -1
	object_event 15,  5, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalChansey1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  1,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalThankOakScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  1, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalPokefan1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  1, SPRITE_NURSE, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNursePatientScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCoughScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 16,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalGranny1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 12,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalTwin1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 15,  1, SPRITE_KAREN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalKarenScript, EVENT_ROUTE_36_SUDOWOODO
	object_event 15,  1, SPRITE_PHARMACIST, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalBlackglassesScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 13,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRocketScript, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRocketCounterScript, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRocket3Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, %11100000 | MORN | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalDepressedScientistScript, EVENT_GOLDENROD_CITY_CIVILIANS
