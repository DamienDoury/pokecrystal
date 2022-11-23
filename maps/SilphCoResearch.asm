    object_const_def
    const SILPHCORESEARCH_SCIENTIST1

SilphCoResearch_MapScripts:
    def_scene_scripts

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    endcallback

SilphCoResearchScientist1:
    jumptextfaceplayer SilphCoResearchScientist1Text

SilphCoResearchScientist1Text:
    text "Reckless driving"
    line "causes accidents!"
    cont "Take it easy!"
    done

SilphCoResearch_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event 13,  0, SILPHCO_ELEVATOR, 2

    def_coord_events

    def_bg_events

    def_object_events
	object_event  4, 4, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1, -1
