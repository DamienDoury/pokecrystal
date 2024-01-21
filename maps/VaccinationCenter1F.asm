    object_const_def
    const VACCINATION_CENTER_RECEPTIONIST
    const VACCINATION_CENTER_CHANSEY
    const VACCINATION_CENTER_WAITRESS

VaccinationCenter1F_MapScripts:
    def_scene_scripts
    scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene0 ; SCENE_VACCINATION_CENTER_FIND_SEAT

    def_callbacks
    callback MAPCALLBACK_OBJECTS, .EnterCallback

.DummyScene0:
	end

.EnterCallback:
    disappear VACCINATION_CENTER_WAITRESS
    setscene SCENE_DEFAULT

    readvar VAR_YCOORD
	ifnotequal 0, .make_hands_dirty

    applymovement PLAYER, VaccinationCenter_DownMovement

.make_hands_dirty:
    readvar VAR_XCOORD
	ifnotequal 2, .quit
	readvar VAR_YCOORD
	ifnotequal 7, .quit
	setmapscene GOLDENROD_HOSPITAL_1F, SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS
.quit:
	endcallback

VaccinationCenterReceptionistScript:
    faceplayer

    checkevent EVENT_CROWD_IN_VACCINATION_CENTER
    iftrue .in_construction 

    checkscene
    ifequal SCENE_VACCINATION_CENTER_YOUR_TURN, .your_turn

    checkmapscene GOLDENROD_HOSPITAL_1F
    ifequal SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS, .AskGelScript

.CleanHands:
    checkscene SCENE_VACCINATION_CENTER_FIND_SEAT
    iftrue .accepted

    opentext 
    writetext VaccinationCenterAppointmentText
    promptbutton

    checkevent EVENT_GOT_A_SHOT_TODAY
    iftrue .failed
;.success:
    setevent EVENT_GOT_A_SHOT_TODAY
    writetext VaccinationCenterSuccessText
    yesorno
    iffalse .refused

    setscene SCENE_VACCINATION_CENTER_FIND_SEAT
.accepted:
    jumptext VaccinationCenterAcceptedText

.AskGelScript:
    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
    farjumptext GoldenrodHospitalAskGelText

.in_construction:
    jumptext VaccinationCenterConstructionText

.failed:
    jumptext VaccinationCenterFailText

.refused:
    jumptext VaccinationCenterRefusedText

.your_turn:
    jumptext VaccinationCenterYourTurnText

VaccinationCenterGelScript:
    farsjump GoldenrodHospitalGelScript

VaccinationCenterChanseyScript:
    cry CHANSEY
    farjumptext GoldenrodHospitalChanseySeriousText

VaccinationCenterDynamicWalkScript:
    applymovement PLAYER, VaccinationCenter_DownMovement

    readvar VAR_XCOORD
    ifgreater 10, .right_side
.left_side:
    applymovement PLAYER, VaccinationCenter_RightMovement
    readvar VAR_XCOORD
    ifnotequal 10, .left_side
    sjump .top_or_bot

.right_side:
    applymovement PLAYER, VaccinationCenter_LeftMovement
    readvar VAR_XCOORD
    ifnotequal 10, .right_side

.top_or_bot:
    readvar VAR_YCOORD
    ifgreater 3, .bot_side
;.top_side:
    applymovement PLAYER, VaccinationCenter_HeadUpMovement
    end

.bot_side:
    applymovement PLAYER, VaccinationCenter_UpMovement
    applymovement PLAYER, VaccinationCenter_UpMovement
    end

VaccinationCenterAllowedSeatScript:
    applymovement PLAYER, VaccinationCenter_HeadDownMovement

    random 8 ; Random waiting time!
.pause_loop ; Acts as a pause, without freezing Chansey's animations.
    pause 7
    applymovement VACCINATION_CENTER_CHANSEY, VaccinationCenter_HeadUpMovement 
    pause 7
    applymovement VACCINATION_CENTER_CHANSEY, VaccinationCenter_HeadDownMovement
    addval 1
    ifless 12, .pause_loop
    setval 0

    playsound SFX_ENTER_DOOR
    waitsfx
    appear VACCINATION_CENTER_WAITRESS
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_DownMovement

    opentext 
    writetext VaccinationCenterCallText
    waitbutton
    closetext

    moveobject VACCINATION_CENTER_WAITRESS, 10, 1

    setscene SCENE_VACCINATION_CENTER_YOUR_TURN
    end

VaccinationCenterGoToOffice:
    ;scall VaccinationCenterDynamicWalkScript
    applymovement PLAYER, VaccinationCenter_HeadUpMovement
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_NurseScansCardStartMovement
    pause 5
    playsound SFX_PUSH_BUTTON ;SFX_ELEVATOR_END
    waitsfx
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_LeftMovement
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_HeadUpMovement

    readvar VAR_YCOORD
    ifless 3, .move_on

    applymovement PLAYER, VaccinationCenter_UpMovement

.move_on
    follow VACCINATION_CENTER_WAITRESS, PLAYER
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_UpMovement
    playsound SFX_ENTER_DOOR
    stopfollow
    disappear VACCINATION_CENTER_WAITRESS
    applymovement PLAYER, VaccinationCenter_UpMovement
    warpcheck
	;autoinput .movement_data
    ;special FadeOutPalettes
    ;warpfacing UP, VACCINATION_CENTER_CORRIDOR, 12, 3
    end

;.movement_data
;	db D_UP,   5, -1

VaccinationCenterForbiddenSeatScript:
VaccinationCenterChanseyKicksYouScript:
    pause 5
    applymovement PLAYER, VaccinationCenter_HeadDownMovement
    pause 5
    cry CHANSEY
    showemote EMOTE_SAD, VACCINATION_CENTER_CHANSEY, 15
    waitsfx
    pause 10
    applymovement PLAYER, VaccinationCenter_DownMovement
    ;jumptext VaccinationCenterForbiddenSeatText
    end


VaccinationCenter1FScanner:	
    farsjump GoldenrodHospital1FScanner

VaccinationCenterLockScript:
    farjumptext GoldenrodHospitalLockText

VaccinationCenter_HeadDownMovement:
    turn_head DOWN
    step_end

VaccinationCenter_HeadUpMovement:
    turn_head UP
    step_end

VaccinationCenter_DownMovement:
    step DOWN
    step_end

VaccinationCenter_LeftMovement:
    step LEFT
    step_end

VaccinationCenter_RightMovement:
    step RIGHT
    step_end

VaccinationCenter_UpMovement:
    step UP
    step_end

VaccinationCenter_NurseScansCardStartMovement:
    step RIGHT
    turn_head UP
    step_end

VaccinationCenter_ChanseyWaitMovement:
    turn_head UP
    turn_head DOWN
    turn_head UP
    turn_head DOWN
    turn_head UP
    turn_head DOWN
    turn_head UP
    turn_head DOWN
    turn_head UP
    turn_head DOWN
    turn_head UP
    turn_head DOWN
    step_end

VaccinationCenterEmptyScript:
    end

VaccinationCenterConstructionText:
    text "This SILPH CO."
    line "condo is being"
    
    para "rehabilitated to"
    line "serve as a"
    
    para "VACCINATION"
    line "CENTER once"

    para "the vaccine for"
    line "#MON becomes"
    cont "available."

    para "Please come back"
    line "later."
    done

VaccinationCenterAppointmentText:
    text "Welcome to"
    line "SILPH CO."
    cont "VACCINATION"
    cont "CENTER!"

    para "Our schedule is"
    line "full for the next"
    
    para "two months, so we"
    line "don't take new"
    cont "appointments."
    done

VaccinationCenterSuccessText:
    text "However!"

    para "We just had a"
    line "last minute"
    cont "cancellation, so"

    para "there is an open"
    line "spot right now."

    para "Would you like to"
    line "vaccinate one of"
    cont "your #MON?"
    done

VaccinationCenterFailText:
    text "There is still a"
    line "way to get a shot."

    para "Sometimes, people"
    line "don't show up."
    
    para "When it happens,"
    line "we offer the slot"

    para "to the first"
    line "person that comes."

    para "We advise you to"
    line "try again another"
    cont "time, with your"
    cont "#MON ready."
    done

VaccinationCenterAcceptedText:
    text "Please sit and"
    line "wait to be called."
    done

VaccinationCenterRefusedText:
    text "No problem, I will"
    line "give the spot to"
    cont "someone else."
    done

VaccinationCenterYourTurnText:
    text "It's your turn!"
    line "You'll miss it if"
    cont "you don't go now!"
    done

VaccinationCenterForbiddenSeatText:
    text "It is not allowed"
    line "to sit here."

    para "Social distancing"
    line "isn't respected."
    done

VaccinationCenterCallText:
    text "<PLAYER>!"
    line "You're up next."
    done

VaccinationCenter1F_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  3,  7, SAFFRON_CITY, 17
	warp_event  4,  7, SAFFRON_CITY, 17
	warp_event 10,  0, VACCINATION_CENTER_CORRIDOR, 1

    def_coord_events
	coord_event  9,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 13,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 15,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 14,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 12,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event  7,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event  8,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event  6,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript

	coord_event  9,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript
	coord_event 13,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript
	coord_event 12,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript
	coord_event  8,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript

	coord_event 10,  2, CE_SCENE_ID, 2, VaccinationCenterGoToOffice
    
    def_bg_events
	bg_event  5,  6, BGEVENT_READ, VaccinationCenterGelScript
	bg_event 11,  0, BGEVENT_READ, VaccinationCenter1FScanner
	bg_event 10,  0, BGEVENT_READ, VaccinationCenterLockScript

    def_object_events
	object_event  3,  3, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterReceptionistScript, -1
	object_event 11,  5, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenterChanseyScript, -1
	object_event 10,  0, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenterGoToOffice, 0

	object_event  15,  1, SPRITE_GRAMPS, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  14,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event  7,  1, SPRITE_GRANNY, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  9,  1, SPRITE_SAGE, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 13,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event 12,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  8,  3, SPRITE_ROCKER, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  7,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 13,  1, SPRITE_NURSE, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_TWIN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event 12,  3, SPRITE_LASS, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  8,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  9,  1, SPRITE_TWIN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  7,  1, SPRITE_FISHER, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
