	object_const_def
	const ECRUTEAKCITY_TRAVEL_CONTROLLER
	const ECRUTEAKCITY_GRAMPS1
	const ECRUTEAKCITY_GRAMPS2
	const ECRUTEAKCITY_LASS1
	const ECRUTEAKCITY_LASS2
	const ECRUTEAKCITY_FISHER
	const ECRUTEAKCITY_YOUNGSTER
	const ECRUTEAKCITY_GRAMPS3
	const ECRUTEAKCITY_DELIVERY_GUY
	const ECRUTEAKCITY_DANCETHEATER_DOOR
	const ECRUTEAKCITY_TINTOWER_DOOR

EcruteakCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .MoveDeliveryGuyAndCloseMart
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.MoveDeliveryGuyAndCloseMart:
	readmem wCurFreedomState
	ifnotequal 1 << CURFEW, .MoveDeliveryGuy

	changeblock 28, 20, $38 ; Mart.
	
.MoveDeliveryGuy:
	random 4
	ifequal 0, .zero
	ifequal 1, .one
	ifequal 2, .two

	moveobject ECRUTEAKCITY_DELIVERY_GUY, 14, 22
	endcallback

.zero
	moveobject ECRUTEAKCITY_DELIVERY_GUY, 7, 18
	endcallback

.one
	moveobject ECRUTEAKCITY_DELIVERY_GUY, 21, 22
	endcallback

.two
	moveobject ECRUTEAKCITY_DELIVERY_GUY, 27, 28
	endcallback

.FlyPoint:
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_ECRUTEAK
	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel
.endcallback
	endcallback

EcruteakCityGramps1Script:
	jumptextfaceplayer EcruteakCityGramps1Text

EcruteakCityGramps2Script:
	jumptextfaceplayer EcruteakCityGramps2Text

EcruteakCityGramps3Script:
	jumptextfaceplayer EcruteakCityGramps3Text

EcruteakCityLass1Script:
	jumptextfaceplayer EcruteakCityLass1Text

EcruteakCityLass2Script:
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue .ReleasedBeasts

	jumptextfaceplayer EcruteakCityLass2Text

.ReleasedBeasts:
	jumptextfaceplayer EcruteakCityLass2Text_ReleasedBeasts

EcruteakCityFisherScript:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue .JasmineReturned

	jumptextfaceplayer EcruteakCityFisherText

.JasmineReturned:
	jumptextfaceplayer EcruteakCityFisherText_JasmineReturned

EcruteakCity_DeliveryGuyScript:
	faceplayer
	checkevent EVENT_FIRST_CURFEW_STARTED
	iftrue .curfew
	
	jumptext DeliveryGuy_LockdownText

.curfew
	jumptext DeliveryGuy_CurfewText

EcruteakCityYoungsterScript:
	jumptextfaceplayer EcruteakCityYoungsterText

EcruteakCitySign:
	jumptext EcruteakCitySignText

TinTowerSign:
	jumptext TinTowerSignText

EcruteakGymSign:
	jumptext EcruteakGymSignText

EcruteakDanceTheaterSign:
	jumptext EcruteakDanceTheaterSignText

BurnedTowerSign:
	jumptext BurnedTowerSignText

EcruteakCityPokecenterSign:
	jumpstd PokecenterSignScript

EcruteakCityMartSign:
	jumpstd MartSignScript

EcruteakCityPoliceStationSign:
	jumptext EcruteakCityPoliceStationSignText

EcruteakCityHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION

EcruteakCityHiddenSitrusBerry:
	hiddenitem GOLD_BERRY, EVENT_ECRUTEAK_CITY_HIDDEN_SITRUS_BERRY
	
EcruteakCityHiddenLeppaBerry:
	hiddenitem MYSTERYBERRY, EVENT_ECRUTEAK_CITY_HIDDEN_LEPPA_BERRY

EcruteakCityHiddenBerryJuice:
	hiddenitem BERRY_JUICE, EVENT_ECRUTEAK_CITY_HIDDEN_BERRY_JUICE

EcruteakCity_DoorScript:
	jumpstd LockdownCurfewClosedDoor

EcruteakCityGramps1Text:
	text "ECRUTEAK used to"
	line "have two towers:"

	para "one each in the"
	line "east and west."
	done

EcruteakCityGramps2Text:
	text "Ah, child."
	line "Have you learned"

	para "to dance like the"
	line "KIMONO GIRLS?"

	para "If you go to their"
	line "DANCE THEATER, an"

	para "odd old man will"
	line "give you something"
	cont "nice, I hear."
	done

EcruteakCityLass1Text:
	text "I'm going to prac-"
	line "tice at the DANCE"

	para "THEATER. Care to"
	line "join me?"
	done

EcruteakCityLass2Text:
	text "The tower that"
	line "used to be here…"

	para "My grandma told me"
	line "it used to be much"
	cont "taller."
	done

EcruteakCityLass2Text_ReleasedBeasts:
	text "Three big #MON"
	line "ran off in differ-"
	cont "ent directions."
	cont "What were they?"
	done

EcruteakCityFisherText:
	text "I heard a rumor"
	line "about OLIVINE"
	cont "LIGHTHOUSE."

	para "The #MON that"
	line "serves as the"

	para "beacon fell ill."
	line "Sounds like they"
	cont "are in trouble."
	done

EcruteakCityFisherText_JasmineReturned:
	text "What happened to"
	line "the #MON at"
	cont "OLIVINE LIGHTHOUSE"
	cont "was sad…"
	done

EcruteakCityYoungsterText:
	text "I hear #MON are"
	line "rampaging at the"

	para "LAKE OF RAGE. I'd"
	line "like to see that."
	done

EcruteakCityGramps3Text:
	text "In the distant"
	line "past…"

	para "This tower burned"
	line "in a fire. Three"

	para "nameless #MON"
	line "perished in it."

	para "A rainbow-colored"
	line "#MON descended"

	para "from the sky and"
	line "resurrected them…"

	para "It's a legend that"
	line "has been passed"

	para "down by ECRUTEAK"
	line "GYM LEADERS."

	para "Me?"

	para "I was a trainer"
	line "way back when."
	cont "Hohoho!"
	done

EcruteakCitySignText:
	text "ECRUTEAK CITY"
	line "A Historical City"

	para "Where the Past"
	line "Meets the Present"
	done

TinTowerSignText:
	text "TIN TOWER"

	para "A legendary #-"
	line "MON is said to"
	cont "roost here."
	done

EcruteakGymSignText:
	text "ECRUTEAK CITY"
	line "#MON GYM"
	cont "LEADER: MORTY"

	para "The Mystic Seer of"
	line "the Future"
	done

EcruteakDanceTheaterSignText:
	text "ECRUTEAK DANCE"
	line "THEATER"
	done

BurnedTowerSignText:
	text "BURNED TOWER"

	para "It was destroyed"
	line "by a mysterious"
	cont "fire."

	para "Please stay away,"
	line "as it is unsafe."
	done

EcruteakCityPoliceStationSignText:
	text "ECRUTEAK CITY"
	line "POLICE STATION"
	done

DeliveryGuy_LockdownText:
	text "Everyone is qua-"
	line "rantined at home…"

	para "and yet I've never"
	line "had so much work"
	cont "outdoors!"

	para "I spend all day"
	line "delivering OLIVINE"
	cont "CAFE's salads."

	para "I leave them at"
	line "door front, and I"
	
	para "only accept wire-"
	line "less payments."
	done

DeliveryGuy_CurfewText:
	text "Gotta go fast!"

	para "Or I won't be done"
	line "with my deliveries"
	cont "before curfew."
	done

EcruteakCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 35, 26, ROUTE_42_ECRUTEAK_GATE, 1
	warp_event 35, 27, ROUTE_42_ECRUTEAK_GATE, 2
	warp_event 18, 11, ECRUTEAK_TIN_TOWER_ENTRANCE, 1
	warp_event 20,  2, WISE_TRIOS_ROOM, 1
	warp_event 20,  3, WISE_TRIOS_ROOM, 2
	warp_event 23, 27, ECRUTEAK_POKECENTER_1F, 1
	warp_event  5, 21, ECRUTEAK_LUGIA_SPEECH_HOUSE, 1
	warp_event 23, 21, DANCE_THEATRE, 1
	warp_event 29, 21, ECRUTEAK_MART, 2
	warp_event  6, 27, ECRUTEAK_GYM, 1
	warp_event 13, 27, ECRUTEAK_ITEMFINDER_HOUSE, 1
	warp_event 37,  7, TIN_TOWER_1F, 1
	warp_event  5,  5, BURNED_TOWER_1F, 1
	warp_event  0, 18, ROUTE_38_ECRUTEAK_GATE, 3
	warp_event  0, 19, ROUTE_38_ECRUTEAK_GATE, 4
	warp_event 29, 27, ECRUTEAK_FAUNA_HOUSE, 1
	warp_event 13, 11, ECRUTEAK_POLICE_STATION, 1
	warp_event 13, 17, ECRUTEAK_REMOTE_WORK_HOUSE, 1
	warp_event  5, 17, CARPET_SHOP, 1

	def_coord_events

	def_bg_events
	bg_event 15, 21, BGEVENT_READ, EcruteakCitySign
	bg_event 38, 10, BGEVENT_READ, TinTowerSign
	bg_event  8, 28, BGEVENT_READ, EcruteakGymSign
	bg_event 21, 21, BGEVENT_READ, EcruteakDanceTheaterSign
	bg_event  2, 10, BGEVENT_READ, BurnedTowerSign
	bg_event 24, 27, BGEVENT_READ, EcruteakCityPokecenterSign
	bg_event 30, 21, BGEVENT_READ, EcruteakCityMartSign
	bg_event 23, 14, BGEVENT_ITEM, EcruteakCityHiddenHyperPotion
	bg_event  5, 22, BGEVENT_ITEM, EcruteakCityHiddenSitrusBerry
	bg_event 29, 28, BGEVENT_ITEM, EcruteakCityHiddenLeppaBerry
	bg_event 13, 28, BGEVENT_ITEM, EcruteakCityHiddenBerryJuice
	bg_event 11, 11, BGEVENT_READ, EcruteakCityPoliceStationSign
	bg_event 29, 21, BGEVENT_CLOSED_DOOR, EcruteakCity_DoorScript

	def_object_events
	object_event 25, 28, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event 18, 15, SPRITE_GRAMPS, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityGramps1Script, -1
	object_event 20, 21, SPRITE_GRAMPS, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityGramps2Script, -1
	object_event 21, 29, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakCityLass1Script, -1
	object_event  3,  9, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityLass2Script, -1
	object_event  9, 22, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakCityFisherScript, -1
	object_event 10, 14, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakCityYoungsterScript, -1
	object_event  3,  7, SPRITE_GRAMPS, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakCityGramps3Script, EVENT_ECRUTEAK_CITY_GRAMPS
	object_event 10, 12, SPRITE_BIKER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, (%11100000 & HIDE_FREE & HIDE_CURFEW & HIDE_VACCINE_PASS) | (5 - START_HOUR_FILTER_OFFSET), %11100000 | 17, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakCity_DeliveryGuyScript, -1
	object_event 23, 21, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCity_DoorScript, -1
	object_event 18, 11, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCity_DoorScript, -1
	object_event  5, 17, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCity_DoorScript, -1
