    object_const_def
    const SILPHCOELEVATOR_SCIENTIST


SilphCoElevator_MapScripts:
    def_scene_scripts
    scene_script .Scene ; SCENE_DEFAULT  / 0
    scene_script .Scene ; SCENE_FINISHED / 1

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    moveobject SILPHCOELEVATOR_SCIENTIST, 1, 2
    endcallback

.Scene:
    checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
    iftrue .no_scene

    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

    checkevent EVENT_SILPHCO_SCIENTIST_MET
    iftrue .no_scene

    follow SILPHCOELEVATOR_SCIENTIST, PLAYER
    applymovement SILPHCOELEVATOR_SCIENTIST, SilphCoElevator_UpMovement
    stopfollow 
    applymovement PLAYER, SilphCoElevator_OutMovement
    playsound SFX_PUSH_BUTTON
    pause 5
    applymovement SILPHCOELEVATOR_SCIENTIST, SilphCoElevator_HeadDownMovement
    
    pause 5
    playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
    
    pause 5

    applymovement SILPHCOELEVATOR_SCIENTIST, SilphCoElevator_DownMovement
    follow SILPHCOELEVATOR_SCIENTIST, PLAYER
    applymovement SILPHCOELEVATOR_SCIENTIST, SilphCoElevator_DownMovement
    stopfollow
    warpsound
	disappear SILPHCOELEVATOR_SCIENTIST

    applymovement PLAYER, SilphCoElevator_DownMovement

    loadmem wBackupMapGroup, GROUP_SILPHCO_RESEARCH
    loadmem wBackupMapNumber, MAP_SILPHCO_RESEARCH
    loadmem wBackupWarpNumber, 1
    autoinput .movement_data
    ;warpcheck ; Yet again, warpcheck doesn't work on a carpet. What am I doing wrong ?
    end

.no_scene:
    disappear SILPHCOELEVATOR_SCIENTIST
    end

.movement_data
	db D_DOWN, 1, -1

SilphCoElevatorScript:
    opentext
	elevator SilphCoElevatorElevatorData
	closetext
	iffalse .Done
	pause 5
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
.Done:
	end

SilphCoElevator_OutMovement:
	step LEFT

SilphCoElevator_HeadDownMovement:
    turn_head DOWN
    step_end

SilphCoElevator_DownMovement:
    step DOWN
    step_end

SilphCoElevator_UpMovement:
    step UP
    step_end


SilphCoElevatorElevatorData:
	db 2 ; floors
	elevfloor FLOOR_1F, 3, SILPH_CO_1F
	elevfloor FLOOR_11F, 1, SILPHCO_RESEARCH
	db -1 ; end

SilphCoElevator_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  0,  3, SILPH_CO_1F, -1
	warp_event  1,  3, SILPH_CO_1F, -1

    def_coord_events

    def_bg_events
    bg_event  1,  0, BGEVENT_READ, SilphCoElevatorScript

    def_object_events
	object_event 12,  12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoElevatorScript, -1
