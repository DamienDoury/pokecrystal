    object_const_def
    const VACCINATION_CENTER_RECEPTIONIST
    const VACCINATION_CENTER_CHANSEY
    const VACCINATION_CENTER_WAITRESS

    const VACCINATION_CENTER_PERMANENT_1
    const VACCINATION_CENTER_PERMANENT_2

    const VACCINATION_CENTER_MORNING_1
    const VACCINATION_CENTER_MORNING_2
    const VACCINATION_CENTER_MORNING_3
    const VACCINATION_CENTER_MORNING_4

    const VACCINATION_CENTER_DAY_1
    const VACCINATION_CENTER_DAY_2
    const VACCINATION_CENTER_DAY_3
    const VACCINATION_CENTER_DAY_4
    const VACCINATION_CENTER_DAY_5

    const VACCINATION_CENTER_NITE_1
    const VACCINATION_CENTER_NITE_2
    const VACCINATION_CENTER_NITE_3
    const VACCINATION_CENTER_NITE_4
    const VACCINATION_CENTER_NITE_5

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

    
VaccinationCenter_Script1:
    jumptextfaceplayer VaccinationCenter_Text1

VaccinationCenter_Script2:
    jumptextfaceplayer VaccinationCenter_Text2

VaccinationCenter_Script4:
    jumptextfaceplayer VaccinationCenter_Text4

VaccinationCenter_Script5:
    jumptextfaceplayer VaccinationCenter_Text5

VaccinationCenter_Script6:
    jumptextfaceplayer VaccinationCenter_Text6

VaccinationCenter_Script7:
    jumptextfaceplayer VaccinationCenter_Text7

VaccinationCenter_Script8:
    jumptextfaceplayer VaccinationCenter_Text8

VaccinationCenter_Script9:
    jumptextfaceplayer VaccinationCenter_Text9

VaccinationCenter_Script10:
    jumptextfaceplayer VaccinationCenter_Text10

VaccinationCenter_Script11:
    jumptextfaceplayer VaccinationCenter_Text11

VaccinationCenter_Script12:
    jumptextfaceplayer VaccinationCenter_Text12

VaccinationCenter_Script13:
    faceplayer
    opentext
    writetext VaccinationCenter_Text13
    waitbutton
    closetext
    showemote EMOTE_SHOCK, VACCINATION_CENTER_NITE_1, 15
    jumptext VaccinationCenter_Text13Sequel

VaccinationCenter_Script14:
    jumptextfaceplayer VaccinationCenter_Text14

VaccinationCenter_Script15:
    jumptextfaceplayer VaccinationCenter_Text15

VaccinationCenter_Script16:
    jumptextfaceplayer VaccinationCenter_Text16

VaccinationCenter_Script17:
    showemote EMOTE_SLEEP, VACCINATION_CENTER_NITE_5, 45
    pause 15
    showemote EMOTE_SHOCK, VACCINATION_CENTER_NITE_5, 15
    pause 5
    jumptextfaceplayer VaccinationCenter_Text17

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

VaccinationCenter_Text1:
    text "I am a friend of"
	line "CHIEF NURSE JOY."

	para "She was able to"
	line "tell me which"
	cont "variant of COVID"
	cont "my dear #MON"
	cont "caught last time."

	para "You are a friend"
	line "of her as well?"

	para "Then if your"
	line "#MON has done"

	para "a PCR test, you"
	line "could ask her."
    done

VaccinationCenter_Text2:
    text "It is the 5th"
    line "appointment for"
    cont "my PIKACHU."
    
    para "They say 2 shots"
    line "are enough?"
    
    para "I don't think so."
    done

VaccinationCenter_Text4:
    text "Yo."
    done

VaccinationCenter_Text5:
    text "A wise man shall"
    line "convince its rel-"
    cont "atives to get"
    cont "vaccinated."
    done

VaccinationCenter_Text6:
    text "The #MON vac-"
    line "cine is a blessing"
    cont "for trainers."
    done

VaccinationCenter_Text7:
    text "The vaccines are"
    line "saving our phy-"
    cont "sical health."
    
    para "But it's important"
    line "to maintain a good"
    
    para "mental health as"
    line "well."
    
    para "A lot of people"
    line "fell into depres-"
    
    para "sion during the"
    line "lockdown and the"
    cont "curfew."
    done

VaccinationCenter_Text8:
    text "The fact that the"
    line "virus is mutating"
    
    para "into new variants"
    line "is scary."
    done

VaccinationCenter_Text9:
    text "I'm playing my part"
    line "against COVID."
    done

VaccinationCenter_Text10:
    text "Getting my #MON"
    line "vaccinated will"
    cont "be a relief."
    done

VaccinationCenter_Text11:
    text "Human-#MON"
    line "contamination can"

    para "happen, but it"
    line "is rare."
    done

VaccinationCenter_Text12:
    text "We don't need a"
    line "new lockdown."
    
    para "Everyone should"
    line "get vaccinated."
    done

VaccinationCenter_Text13:
    text "The LEAGUE CHAMP-"
    line "ION inspired me"
    cont "to get vaccinated."
    done
    
VaccinationCenter_Text13Sequel:
    text "Hey it's you!"
    line "Incredible!"
    done

VaccinationCenter_Text14:
    text "I used to be an"
    line "anti-vaxxer until"
    
    para "I became severely"
    line "ill while my vac-"
    
    para "cinated wife didn't"
    line "get affected at"
    cont "all."
    
    para "Now I want to pro-"
    line "tect my #MON."
    done

VaccinationCenter_Text15:
    text "Why are you talk-"
    line "ing to everyone?"
    
    para "Stop it! It's"
    line "embarrassing."
    done

VaccinationCenter_Text16:
    text "As soon as the"
    line "#MON vaccine"
    cont "was announced,"
    
    para "everyone took an"
    line "appointment at"
    cont "once!"
    
    para "It lead to weeks"
    line "of delay."
    done

VaccinationCenter_Text17:
    text "Ah!"

    para "I rested my eyes"
    line "for a second. Did"
    cont "I miss my slot?"
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

	object_event 15,  1, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script1, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 14,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script2, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event  7,  1, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script4, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  9,  1, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script5, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 13,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script6, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script7, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event 12,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script8, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  8,  3, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script9, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  7,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script10, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 13,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script11, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script12, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event 12,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script13, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  8,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script14, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  9,  1, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script15, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script16, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  7,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script17, EVENT_CROWD_IN_VACCINATION_CENTER
