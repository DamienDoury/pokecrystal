    object_const_def

MrAntonsHouse_MapScripts:
    def_scene_scripts

    def_callbacks

MrAnstonHouseRareCandy:
    hiddenitem RARE_CANDY, EVENT_MR_ANTONS_HOUSE_RARE_CANDY

    MrAntonsHouse_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 16
	warp_event  3,  7, SAFFRON_CITY, 16

    def_coord_events

    def_bg_events
	bg_event  7,  7, BGEVENT_ITEM, MrAnstonHouseRareCandy

    def_object_events
