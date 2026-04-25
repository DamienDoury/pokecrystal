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

TrainerBikerFarid:
	trainer BIKER, FARID, EVENT_BEAT_BIKER_FARID, BikerFaridSeenText, BikerFaridBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_16
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_16

	endifjustbattled
	jumptextfaceplayer BikerFaridAfterBattleText

TrainerBikerAntony:
	trainer BIKER, ANTONY, EVENT_BEAT_BIKER_ANTONY, BikerAntonySeenText, BikerAntonyBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_16
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_16

	endifjustbattled
	jumptextfaceplayer BikerAntonyAfterBattleText

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


BikerFaridSeenText:
if DEF(_FR_FR)
	text "Je ne suis pas"
	line "“antivax”."

	para "Je refuse juste de"
	line "me faire vacciner."
else
	text "I'm not an “anti-"
	line "vaxxer”."

	para "I just refuse to"
	line "get vaccinated."
endc
	done

BikerFaridBeatenText:
if DEF(_FR_FR)
	text "Je n'ai pas perdu."
	line "J'ai fini second."
else
	text "I didn't lose."
	line "I just didn't win."
endc
	done

BikerFaridAfterBattleText:
if DEF(_FR_FR)
	text "Je déteste le"
	line "terme “antivax”,"
	
	para "je déteste les"
	line "décisions du"
	cont "gouvernement,"
	
	para "je déteste"
	line "cette situation."

	para "Je vais aller"
	line "manifester."
else
	text "I hate the term"
	line "“anti-vax”,"
	
	para "I hate the govern-"
	line "ment's decisions,"
	
	para "I hate this"
	line "situation."
	
	para "I'm going to"
	line "protest."
endc
	done

BikerAntonySeenText:
if DEF(_FR_FR)
	text "Je n'laisserai pas"
	line "pas l'gouvernement"
	cont "m'ôter ma liberté!"
else
	text "I won't let the"
	line "government seize"
	cont "my freedom!"
endc
	done

BikerAntonyBeatenText:
if DEF(_FR_FR)
	text "Je ne me soumet-"
	line "trais pas!"
else
	text "I won't submit"
	line "to you either!"
endc
	done

BikerAntonyAfterBattleText:
if DEF(_FR_FR)
	text "Faut surtout pas"
	line "installer le"
	cont "COUPON de TRAçAGE"
	cont "des CONTACTS sur"
	cont "le #GEAR!"

	para "Le gouvernement"
	line "s'en sers pour"
	cont "surveiller nos"
	cont "déplacements."
	
	para "C'est une viola-"
	line "tion de notre vie"
	cont "privée!"
else
	text "Avoid installing"
	line "the CONTACT"
	cont "TRACING COUPON on"
	cont "your #GEAR!"

	para "The government"
	line "uses it to monitor"
	cont "our movements."
	
	para "It's a violation"
	line "of our privacy!"
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
	object_event  6, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerBikerFarid, -1
	object_event  2,  7, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerBikerAntony, -1
	object_event 12,  1, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherJerome, -1

