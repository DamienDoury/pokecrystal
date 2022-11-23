;    object_const_def

SilphCoElevator_MapScripts:
    def_scene_scripts

    def_callbacks
;    callback MAPCALLBACK_TILES, .EnterCallback
;
;.EnterCallback:
;    endcallback

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

SilphCoElevatorElevatorData:
	db 2 ; floors
	elevfloor FLOOR_1F, 3, SILPH_CO_1F
	elevfloor FLOOR_9F, 1, SILPHCO_RESEARCH
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