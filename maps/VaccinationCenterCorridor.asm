    object_const_def
    const VACCINATION_CENTER_CORRIDOR_WAITRESS
    const VACCINATION_CENTER_CORRIDOR_PREV_PATIENT

    const VACCINATION_CENTER_CORRIDOR_NEXT_PATIENT_MORN
    const VACCINATION_CENTER_CORRIDOR_NEXT_PATIENT_DAY
    const VACCINATION_CENTER_CORRIDOR_NEXT_PATIENT_NITE

VaccinationCenterCorridor_MapScripts:
    def_scene_scripts
    scene_script .GoToRoom ; SCENE_VACCINATION_CENTER_CORRIDOR_GO_TO_ROOM
	scene_script .GoToLobby ; SCENE_VACCINATION_CENTER_CORRIDOR_GO_TO_LOBBY

    def_callbacks
    callback MAPCALLBACK_TILES, .TilesCallback
    callback MAPCALLBACK_OBJECTS, .EnterCallback

.TilesCallback:
    readvar VAR_TIMEOFDAY
    ifequal MORN_F, .morn
    ifequal DAY_F, .day
;.nite:
    variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_POKEFAN_F
    endcallback

.day:
    variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_ERIKA
    endcallback

.morn:
    variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_YOUNGSTER
    endcallback

.EnterCallback:
    disappear VACCINATION_CENTER_CORRIDOR_PREV_PATIENT
    readvar VAR_YCOORD
	ifequal 0, .go_to_lobby

;.go_to_seat
    setscene SCENE_VACCINATION_CENTER_CORRIDOR_GO_TO_ROOM
    endcallback 
    
.go_to_lobby:
    setscene SCENE_VACCINATION_CENTER_CORRIDOR_GO_TO_LOBBY
    moveobject VACCINATION_CENTER_CORRIDOR_WAITRESS, 1, 2
    endcallback

.GoToRoom:
    checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
    iftrue .end
    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

    disappear VACCINATION_CENTER_CORRIDOR_NEXT_PATIENT_MORN
    disappear VACCINATION_CENTER_CORRIDOR_NEXT_PATIENT_DAY
    disappear VACCINATION_CENTER_CORRIDOR_NEXT_PATIENT_NITE

    follow VACCINATION_CENTER_CORRIDOR_WAITRESS, PLAYER
    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenterCorridor_ToRoomMovement
    stopfollow
    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenter_LeftMovement
    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenterCorridor_HeadRightMovement

    opentext 
    writetext VaccinationCenterCorridor_WaitHereText
    waitbutton
    closetext

    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenter_HeadUpMovement
    applymovement PLAYER, VaccinationCenter_UpMovement
    pause 5
    applymovement PLAYER, VaccinationCenter_HeadDownMovement

    pause 35

    playsound SFX_ENTER_DOOR
    appear VACCINATION_CENTER_CORRIDOR_PREV_PATIENT
    ;moveobject VACCINATION_CENTER_CORRIDOR_PREV_PATIENT, 1, 0
    applymovement VACCINATION_CENTER_CORRIDOR_PREV_PATIENT, VaccinationCenter_DownMovement
    follow VACCINATION_CENTER_CORRIDOR_WAITRESS, VACCINATION_CENTER_CORRIDOR_PREV_PATIENT
    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenterCorridor_ToLobbyMovement

    pause 30

    opentext
    writetext VaccinationCenterCorridor_NextText
    waitbutton
    closetext

    applymovement PLAYER, VaccinationCenterCorridor_FromChairToRoomMovement
    warpcheck
    ;playsound SFX_ENTER_DOOR
	;special FadeOutPalettes
    ;waitsfx
    ;warpfacing UP, VACCINATION_CENTER_ROOM, 1, 7
.end
    end

.GoToLobby:
    checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
    iftrue .end
    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

    ;appear EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
    applymovement PLAYER, VaccinationCenter_DownMovement
    follow VACCINATION_CENTER_CORRIDOR_WAITRESS, PLAYER
    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenterCorridor_LeadTheWayOutMovement
    stopfollow
    applymovement VACCINATION_CENTER_CORRIDOR_WAITRESS, VaccinationCenter_HeadDownMovement
    setval SPRITEMOVEDATA_STANDING_DOWN
    writemem wMap1ObjectMovement

    ;applymovement PLAYER, VaccinationCenter_DownMovement
    ;pause 5
    autoinput .movement_data
    ;warpcheck
    ;playsound SFX_EXIT_BUILDING
	;special FadeOutPalettes
    ;waitsfx
    ;warp VACCINATION_CENTER_1F, 10, 0 ; This warp will break the map music continuity, but whatever.
	end

.movement_data
	db D_DOWN, 1, -1

VaccinationCenterCorridor_HeadRightMovement:
    turn_head RIGHT
    step_end

VaccinationCenterCorridor_ToRoomMovement:
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step_end

VaccinationCenterCorridor_LeadTheWayOutMovement:
    step RIGHT
    step RIGHT
    step RIGHT

VaccinationCenterCorridor_ToLobbyMovement:
    step RIGHT
    step RIGHT
    step RIGHT
    step RIGHT
    step RIGHT
    step RIGHT
    step RIGHT
    step RIGHT
    step RIGHT
    step_end

VaccinationCenterCorridor_FromChairToRoomMovement:
    step DOWN
    step LEFT
    step LEFT
    step UP
    step UP
    step_end

VaccinationCenterCorridor_FixFacingMovement:
    fix_facing
    step_end

VaccinationCenterCorridor_WaitHereText:
    text "Wait here, the"
    line "doctor will call"
    cont "you in a moment."
    done

VaccinationCenterCorridor_NextText:
    text "NEXT!"
    done

VaccinationCenterCorridor_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event 12,  3, VACCINATION_CENTER_1F, 3
	warp_event 13,  3, VACCINATION_CENTER_1F, 3
	warp_event  1,  0, VACCINATION_CENTER_ROOM, 1


    def_coord_events

    def_bg_events


    def_object_events
	object_event 12,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, -1
	object_event  1,  0, SPRITE_HOSPITAL_VISITOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_event  3,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event  3,  1, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event  3,  1, SPRITE_FISHER, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3

    object_event  7,  1, SPRITE_ERIKA, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 11,  1, SPRITE_SAGE, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 15,  1, SPRITE_GRANNY, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER

    object_event  7,  1, SPRITE_GRAMPS, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 11,  1, SPRITE_BEAUTY, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 15,  1, SPRITE_FISHER, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER

    object_event  7,  1, SPRITE_CLERK, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 11,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 15,  1, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterEmptyScript, EVENT_CROWD_IN_VACCINATION_CENTER
