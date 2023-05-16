	object_const_def
	const ROUTE18_YOUNGSTER1
	const ROUTE18_YOUNGSTER2
	const ROUTE18_YOUNGSTER3

Route18_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_GOT_COVID_ON_ROUTE_18
	iftrue .end

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the next battle, wherever that battle happens.

.end
	endcallback

TrainerBirdKeeperBoris:
	trainer BIRD_KEEPER, BORIS, EVENT_BEAT_BIRD_KEEPER_BORIS, BirdKeeperBorisSeenText, BirdKeeperBorisBeatenText, 0, .Script

.Script:
	loadmem wBattlePokerusSeed, FALSE
	setevent EVENT_GOT_COVID_ON_ROUTE_18
	
	endifjustbattled
	opentext
	writetext BirdKeeperBorisAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperBob:
	trainer BIRD_KEEPER, BOB, EVENT_BEAT_BIRD_KEEPER_BOB, BirdKeeperBobSeenText, BirdKeeperBobBeatenText, 0, .Script

.Script:
	loadmem wBattlePokerusSeed, FALSE
	setevent EVENT_GOT_COVID_ON_ROUTE_18

	endifjustbattled
	opentext
	writetext BirdKeeperBobAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperBobby:
	trainer BIRD_KEEPER, BOBBY, EVENT_BEAT_BIRD_KEEPER_BOBBY, BirdKeeperBobbySeenText, BirdKeeperBobbyBeatenText, 0, .Script

.Script:
	loadmem wBattlePokerusSeed, FALSE
	setevent EVENT_GOT_COVID_ON_ROUTE_18

	endifjustbattled
	opentext
	writetext BirdKeeperBobbyAfterBattleText
	waitbutton
	closetext
	end

Route18Sign:
	jumptext Route18SignText

BirdKeeperBorisSeenText:
	text "If you're looking"
	line "for #MON, you"

	para "have to look in"
	line "the tall grass."
	done

BirdKeeperBorisBeatenText:
	text "Ayieee!"
	done

BirdKeeperBorisAfterBattleText:
	text "Since you're so"
	line "strong, it must be"
	cont "fun to battle."
	done

BirdKeeperBobSeenText:
	text "CYCLING ROAD is a"
	line "quick shortcut to"
	cont "CELADON."
	done

BirdKeeperBobBeatenText:
	text "…Whew!"
	done

BirdKeeperBobAfterBattleText:
	text "If you don't have"
	line "a BICYCLE, you're"

	para "not allowed to use"
	line "the shortcut."
	done

BirdKeeperBobbySeenText:
	text "The motorbikes on"
	line "the CYCLING ROAD"
	cont "produce fumes that"
	
	para "(cough) pollute "
	line "our clean air."
	done

BirdKeeperBobbyBeatenText:
	text "I feel like my"
	line "head is spinning."
	done

BirdKeeperBobbyAfterBattleText:
	text "(cough)"
	done

Route18SignText:
	text "ROUTE 18"

	para "CELADON CITY -"
	line "FUCHSIA CITY"
	done

Route18_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  6, ROUTE_17_ROUTE_18_GATE, 3
	warp_event  2,  7, ROUTE_17_ROUTE_18_GATE, 4

	def_coord_events

	def_bg_events
	bg_event  9,  5, BGEVENT_READ, Route18Sign

	def_object_events
	object_event 11, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBoris, -1
	object_event 13,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBob, -1
	object_event  8,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerBirdKeeperBobby, -1
