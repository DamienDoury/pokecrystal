	object_const_def
	const ROUTE18_YOUNGSTER1
	const ROUTE18_YOUNGSTER2
	const ROUTE18_YOUNGSTER3
	const ROUTE18_BIKER1

Route18_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_GOT_COVID_ON_ROUTE_18
	iftrue .BikeCheck

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the next battle, wherever that battle happens.

.BikeCheck
	readvar VAR_XCOORD
	ifgreater 20, .CanWalk
	setflag ENGINE_ALWAYS_ON_BIKE
	endcallback

.CanWalk:
	clearflag ENGINE_ALWAYS_ON_BIKE
	endcallback

TrainerBirdKeeperBoris:
	trainer BIRD_KEEPER, BORIS, EVENT_BEAT_BIRD_KEEPER_BORIS, BirdKeeperBorisSeenText, BirdKeeperBorisBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_18
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_18
	
	endifjustbattled
	jumptextfaceplayer BirdKeeperBorisAfterBattleText

TrainerBirdKeeperBob:
	trainer BIRD_KEEPER, BOB, EVENT_BEAT_BIRD_KEEPER_BOB, BirdKeeperBobSeenText, BirdKeeperBobBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_18
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_18

	endifjustbattled
	jumptextfaceplayer BirdKeeperBobAfterBattleText

TrainerBirdKeeperBobby:
	trainer BIRD_KEEPER, BOBBY, EVENT_BEAT_BIRD_KEEPER_BOBBY, BirdKeeperBobbySeenText, BirdKeeperBobbyBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_18
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_18

	endifjustbattled
	jumptextfaceplayer BirdKeeperBobbyAfterBattleText

TrainerBikerCharles:
	trainer BIKER, CHARLES, EVENT_BEAT_BIKER_CHARLES, BikerCharlesSeenText, BikerCharlesBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerCharlesAfterBattleText

Route18Sign:
	jumptext Route18SignText

BirdKeeperBorisSeenText: 
if DEF(_FR_FR)
	text "Cherche les #-"
	line "MON dans les"

	para "hautes herbes."
	line "Tu le savais déjà?"
else
	text "If you're looking"
	line "for #MON, you"

	para "have to look in"
	line "the tall grass."
endc

	done

BirdKeeperBorisBeatenText: 
if DEF(_FR_FR)
	text "Aïe!"
else
	text "Ayieee!"
endc

	done

BirdKeeperBorisAfterBattleText: 
if DEF(_FR_FR)
	text "Ca te fait quoi"
	line "d'être balèze?"
	cont "C'est sympa?"
else
	text "Since you're so"
	line "strong, it must be"
	cont "fun to battle."
endc

	done

BirdKeeperBobSeenText: 
if DEF(_FR_FR)
	text "La PISTE CYCLABLE"
	line "est un raccourci"
	cont "vers CELADOPOLE."
else
	text "CYCLING ROAD is a"
	line "quick shortcut to"
	cont "CELADON."
endc

	done

BirdKeeperBobBeatenText: 
if DEF(_FR_FR)
	text "...Fouiii!"
else
	text "…Whew!"
endc

	done

BirdKeeperBobAfterBattleText: 
if DEF(_FR_FR)
	text "Sans BICYCLETTE,"
	line "tu ne peux pas"

	para "emprunter ce"
	line "raccourci."
else
	text "If you don't have"
	line "a BICYCLE, you're"

	para "not allowed to use"
	line "the shortcut."
endc

	done

BirdKeeperBobbySeenText: ; TO TRANSLATE
	text "The motorbikes on"
	line "the CYCLING ROAD"
	cont "produce fumes that"
	
	para "(cough) pollute "
	line "our clean air."
	done

BirdKeeperBobbyBeatenText: ; TO TRANSLATE
	text "I feel like my"
	line "head is spinning."
	done

BirdKeeperBobbyAfterBattleText: ; TO TRANSLATE
	text "(cough)"
	done

BikerCharlesSeenText: 
if DEF(_FR_FR)
	text "Nous on est des"
	line "durs! Des vrais!"
else
	text "We're fearless"
	line "highway stars!"
endc

	done

BikerCharlesBeatenText: 
if DEF(_FR_FR)
	text "Arrrgh!"
	line "Trop dur!"
else
	text "Arrrgh! Crash and"
	line "burn!"
endc

	done

BikerCharlesAfterBattleText: 
if DEF(_FR_FR)
	text "Conduis doucement,"
	line "c'est plus"
	cont "prudent!"
else
	text "Reckless driving"
	line "causes accidents!"
	cont "Take it easy!"
endc

	done

Route18SignText: 
if DEF(_FR_FR)
	text "ROUTE 18"

	para "CELADOPOLE -"
	line "PARMANIE"
else
	text "ROUTE 18"

	para "CELADON CITY -"
	line "FUCHSIA CITY"
endc

	done

Route18_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 22,  4, ROUTE_17_ROUTE_18_GATE, 3
	warp_event 22,  5, ROUTE_17_ROUTE_18_GATE, 4
	warp_event 17,  4, ROUTE_17_ROUTE_18_GATE, 1
	warp_event 17,  5, ROUTE_17_ROUTE_18_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 29,  3, BGEVENT_READ, Route18Sign

	def_object_events
	object_event 31, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBoris, -1
	object_event 33,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBob, -1
	object_event 28,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerBirdKeeperBobby, -1
	object_event  6,  4, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerBikerCharles, -1
