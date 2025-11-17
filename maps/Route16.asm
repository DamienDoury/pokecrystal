	object_const_def
	const ROUTE16_BIKER

Route16_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .AlwaysOnBike

.AlwaysOnBike:
	checkevent EVENT_GOT_COVID_ON_ROUTE_16
	iftrue .BikeCheck

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the next battle, wherever that battle happens.
	
.BikeCheck
	readvar VAR_YCOORD
	ifless 5, .CanWalk
	readvar VAR_XCOORD
	ifgreater 13, .CanWalk
	setflag ENGINE_ALWAYS_ON_BIKE
	endcallback

.CanWalk:
	clearflag ENGINE_ALWAYS_ON_BIKE
	endcallback

TrainerBikerHusq:
	trainer BIKER, HUSQ, EVENT_BEAT_BIKER_HUSQ, BikerHusqSeenText, BikerHusqBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_16
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_16

	endifjustbattled
	jumptextfaceplayer BikerHusqAfterBattleText

TrainerBugCatcherJerome:
	trainer BUG_CATCHER, JEROME, EVENT_BEAT_BUG_CATCHER_JEROME, BugCatcherJeromeSeenText, BugCatcherJeromeBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_16
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_16

	endifjustbattled
	jumptextfaceplayer BugCatcherJeromeAfterBattleText

BikerHusqSeenText:
if DEF(_FR_FR)
	text "La PISTE CYCLABLE"
	line "c'est tout pour"
	cont "la vitesse!!"
else
	text "The CYCLING ROAD"
	line "is all about"
	cont "speed!!"
endc
	done

BikerHusqBeatenText:
if DEF(_FR_FR)
	text "Tu as été trop"
	line "rapide pour moi..."
else
	text "This battle was"
	line "too fast for me…"
endc
	done

BikerHusqAfterBattleText:
if DEF(_FR_FR)
	text "J'aime la vitesse"
	line "et les #MON."
	
	para "Par conséquent"
	line "j'aime les #MON"
	cont "rapides!"
else
	text "I like speed, and"
	line "I like #MON."
	
	para "Therefore I like"
	line "fast #MON!"
endc
	done

BugCatcherJeromeSeenText:
if DEF(_FR_FR)
	text "Avant je jouais"
	line "dans la FORET DE"
	cont "JADE."
	
	para "Mais je ne peux"
	line "plus y aller,"
	cont "c'est devenu trop"
	cont "dangereux."
	
	para "J'ai dû me trouver"
	line "de nouveaux"
	cont "loisirs."
else
	text "I used to play in"
	line "VIRIDIAN FOREST."

	para "But now I can't go"
	line "because it became"
	cont "a dangerous place."

	para "So I had to find"
	line "new hobbies."
endc
	done

BugCatcherJeromeBeatenText:
if DEF(_FR_FR)
	text "Tu pensais à quoi?"
else
	text "What did you"
	line "think?"
endc
	done

BugCatcherJeromeAfterBattleText:
if DEF(_FR_FR)
	text "J'adore ma"
	line "DEMOLOSSE!"
	
	para "C'est une gentille"
	line "fi-fille!"
else
	text "I love my HOUNDOOM"
	line "cause she's a good"
	cont "girl!"
endc
	done

CyclingRoadSign:
	jumptext CyclingRoadSignText

CyclingRoadSignText: 
if DEF(_FR_FR)
	text "PISTE CYCLABLE"

	para "Une descente"
	line "d'enfer!"
else
	text "CYCLING ROAD"

	para "DOWNHILL COASTING"
	line "ALL THE WAY!"
endc

	done

Route16_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  1, ROUTE_16_FUCHSIA_SPEECH_HOUSE, 1
	warp_event 14,  6, ROUTE_16_GATE, 3
	warp_event 14,  7, ROUTE_16_GATE, 4
	warp_event  9,  6, ROUTE_16_GATE, 1
	warp_event  9,  7, ROUTE_16_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  5,  5, BGEVENT_READ, CyclingRoadSign

	def_object_events
	object_event  9, 12, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerBikerHusq, -1
	object_event 12,  1, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherJerome, -1

