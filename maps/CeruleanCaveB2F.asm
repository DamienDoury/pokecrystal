	object_const_def

CeruleanCaveB2F_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanCaveB2F_MewtwoTelepathy1:
	checkevent EVENT_CERULEAN_CAVE_B2F_TEXT_1
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B2F_TEXT_1
	farjumptext _MewtwoB2FText1
.end
	end

CeruleanCaveB2F_MewtwoTelepathy2:
	checkevent EVENT_CERULEAN_CAVE_B2F_TEXT_2
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B2F_TEXT_2
	farjumptext _MewtwoB2FText2
.end
	end

CeruleanCaveB2F_MewtwoTelepathy3:
	checkevent EVENT_CERULEAN_CAVE_B2F_TEXT_3
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B2F_TEXT_3
	farjumptext _MewtwoB2FText3
.end
	end

CeruleanCaveB2F_MewtwoTelepathy4:
	checkevent EVENT_CERULEAN_CAVE_B2F_TEXT_4
	iftrue .end
	
	setevent EVENT_CERULEAN_CAVE_B2F_TEXT_4
	farjumptext _MewtwoB2FText4
.end
	end


CeruleanCaveB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  9, CERULEAN_CAVE_B3F, 1
	warp_event 31,  3, CERULEAN_CAVE_B1F, 2
	warp_event 11,  3, CERULEAN_CAVE_B1F, 3
	warp_event  5, 13, CERULEAN_CAVE_B1F, 4
	warp_event 27,  9, CERULEAN_CAVE_B1F, 5
	warp_event 23, 11, CERULEAN_CAVE_B1F, 6
	warp_event  5,  5, CERULEAN_CAVE_B1F, 7

	def_coord_events
	coord_event 15,  9, SCENE_DEFAULT, CeruleanCaveB2F_MewtwoTelepathy1
	coord_event 21, 13, SCENE_DEFAULT, CeruleanCaveB2F_MewtwoTelepathy2
	coord_event 24,  6, SCENE_DEFAULT, CeruleanCaveB2F_MewtwoTelepathy3
	coord_event  4,  6, SCENE_DEFAULT, CeruleanCaveB2F_MewtwoTelepathy4

	def_bg_events

	def_object_events
