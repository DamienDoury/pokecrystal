    object_const_def

VaccinationCenterRoom_MapScripts:
    def_scene_scripts

    def_callbacks
    callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
    endcallback

VaccinationCenterRoom_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  1,  7, VACCINATION_CENTER_CORRIDOR, 3
	warp_event  0,  7, VACCINATION_CENTER_CORRIDOR, 3

    def_coord_events

    def_bg_events


    def_object_events
