	object_const_def
	const WARDENSNEIGHBORHOUSE_MAN

WardensNeighborHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	checkevent EVENT_WARDENS_NEIGHBOR_BACK_INTO_HOUSE
	iffalse .OpenFrontDoor
	endcallback

.OpenFrontDoor
	scall WardensNeighborHouse_OpenFrontDoor
	endcallback

WardensNeighborHouse_OpenFrontDoor:
	changeblock  2,  6, $1b
	end

WardensNeighborHouseManScript:
	jumptextfaceplayer WardensNeighborHouseManText

WardensNeighborHouse_BoulderScript:
	checkevent EVENT_WARDENS_NEIGHBOR_BOULDER_CLEARED
	iffalse .cleared
	
	opentext
	writetext WardensNeighborHouse_BoulderBlockingText
	promptbutton

	callstd StrengthBoulderScript
	checkflag ENGINE_STRENGTH_ACTIVE
	iftrue .clear
	end

.clear 
	playsound SFX_STRENGTH
	earthquake 5
	waitsfx

	setevent EVENT_WARDENS_NEIGHBOR_BOULDER_BLOCKING
	clearevent EVENT_WARDENS_NEIGHBOR_BOULDER_CLEARED
	scall WardensNeighborHouse_OpenFrontDoor
.cleared
	jumptext WardensNeighborHouse_BoulderClearedText

WardensNeighborHouseManText:
	text "Why did you have"
	line "to push this rock?"

	para "I've been delaying"
	line "taking care of it"
	cont "for months!"

	para "I was eating for"
	line "free in the"
	cont "company of a"
	cont "pretty lady,"

	para "and you RUINED IT!"
	done

WardensNeighborHouse_BoulderBlockingText:
	text "A big boulder is"
	line "blocking the door."
	done

WardensNeighborHouse_BoulderClearedText:
	text "The boulder has"
	line "been pushed away!"
	done

WardensNeighborHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 14
	warp_event  3,  7, FUCHSIA_CITY, 14
	warp_event  2,  0, FUCHSIA_CITY, 12

	def_coord_events

	def_bg_events
	bg_event  2,  8, BGEVENT_DOWN, WardensNeighborHouse_BoulderScript
	bg_event  3,  8, BGEVENT_DOWN, WardensNeighborHouse_BoulderScript

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensNeighborHouseManScript, EVENT_WARDENS_NEIGHBOR_BACK_INTO_HOUSE
