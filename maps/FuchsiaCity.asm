	object_const_def
	const FUCHSIACITY_GRAMPS
	const FUCHSIACITY_BLOCKER
	const FUCHSIACITY_TEACHER
	const FUCHSIACITY_STUPID
	const FUCHSIACITY_LAPRAS
	const FUCHSIACITY_FRUIT_TREE
	const FUCHSIACITY_FRUIT_TREE2
	const FUCHSIACITY_BOULDER1
	const FUCHSIACITY_BOULDER2
	const FUCHSIACITY_BOULDER3
	const FUCHSIACITY_POKEBALL
	const FUCHSIACITY_ROCK1
	const FUCHSIACITY_ROCK2
	const FUCHSIACITY_ROCK3
	const FUCHSIACITY_ROCK4
	const FUCHSIACITY_DOOR_BOULDER_CLEARED
	const FUCHSIACITY_SAFARI_GATE

FuchsiaCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TurnOffLights
	callback MAPCALLBACK_OBJECTS, .FuchsiaSetup

.FlyPoint:
	checkflag ENGINE_FLYPOINT_FUCHSIA
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_FUCHSIA
	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
.endcallback
	endcallback
	
.TurnOffLights
	checkevent EVENT_GOT_SAFARI_KEY_1
	iftrue .EndFuchsiaSetup

	; Turns off the lights of the safari area.
	changeblock 16,  2, $70
	changeblock 18,  2, $4b
	changeblock 20,  2, $33

	sjump .EndFuchsiaSetup

.FuchsiaSetup:
	checkevent EVENT_FUCHSIA_EXCAVATION_STARTED
	iffalse .EndFuchsiaSetup
	moveobject FUCHSIACITY_BLOCKER, 36, 22
	turnobject FUCHSIACITY_BLOCKER, RIGHT
.EndFuchsiaSetup:
	endcallback

FuchsiaCityGramps:
	jumptextfaceplayer FuchsiaCityGrampsText

FuchsiaCityBlocker:
	faceplayer
	checkevent EVENT_FUCHSIA_EXCAVATION_STARTED
	iftrue .Quick
	pause 10
	showemote EMOTE_HAPPY, FUCHSIACITY_BLOCKER, 15 
	opentext
	writetext FuchsiaCityBlockerText
	waitbutton
	closetext
	showemote EMOTE_QUESTION, FUCHSIACITY_BLOCKER, 15 
	opentext
	writetext FuchsiaCityBlockerText2
	waitbutton
	closetext
	turnobject FUCHSIACITY_BLOCKER, DOWN
	pause 15 
	opentext
	writetext FuchsiaCityBlockerText25
	waitbutton
	closetext
	pause 60
	showemote EMOTE_SHOCK, FUCHSIACITY_BLOCKER, 15 
	faceplayer
	opentext
	writetext FuchsiaCityBlockerText3
	waitbutton
	closetext
	showemote EMOTE_HAPPY, FUCHSIACITY_BLOCKER, 15 
	applymovement FUCHSIACITY_BLOCKER, FuchsiaCity_StartExcavation
	setevent EVENT_FUCHSIA_EXCAVATION_STARTED
	turnobject PLAYER, DOWN
.Quick:
	opentext
	writetext FuchsiaCityBlockerText4
	waitbutton
	closetext
	turnobject FUCHSIACITY_BLOCKER, RIGHT
	end

FuchsiaCityTeacher:
	jumptextfaceplayer FuchsiaCityTeacherText

FuchsiaCityStupid:
	checkevent EVENT_FUCSHIA_POKEBALL
	iftrue .Surprised
	jumptextfaceplayer FuchsiaCityStupidText

.Surprised:
	showemote EMOTE_SHOCK, FUCHSIACITY_STUPID, 15 
	jumptextfaceplayer FuchsiaCityStupidSurprisedText

FuchsiaCitySign:
	jumptext FuchsiaCitySignText

FuchsiaGymSign:
	jumptext FuchsiaGymSignText

SafariZoneOfficeSign:
	jumptext SafariZoneOfficeSignText

WardensHomeSign:
	jumptext WardensHomeSignText

SafariZoneClosedSign:
	checkevent EVENT_BOUGHT_SAFARI_PARK
	iftrue .opened
	jumptext SafariZoneClosedSignText

.opened
	jumptext SafariZoneOpenedSignText

NoLitteringSign:
	jumptext NoLitteringSignText

FuchsiaCityPokecenterSign:
	jumpstd PokecenterSignScript

FuchsiaCityMartSign:
	jumpstd MartSignScript

FuchsiaOldSign1:
	jumptext FuchsiaOldSign1Text

FuchsiaOldSign2:
	jumptext FuchsiaOldSign2Text

FuchsiaOldSign3:
	jumptext FuchsiaOldSign3Text

FuchsiaOldSign4:
	jumptext FuchsiaOldSign4Text

FuchsiaOldSign5:
	jumptext FuchsiaOldSign5Text

FuchsiaOldSign6:
	jumptext FuchsiaOldSign6Text

FuchsiaCityBoulderScript:
	jumpstd StrengthBoulderScript

FuchsiaCityRockScript:
	jumpstd SmashRockScript

FuchsiaCityPokeball:
	itemball POKE_BALL

FuchsiaCityFruitTree:
	fruittree FRUITTREE_FUCHSIA_CITY

FuchsiaCityFruitTree2:
	opentext
	writetext FuchsiaEatenTreeText
	promptbutton

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .text_end

	readvar VAR_WEEKDAY
	ifequal TUESDAY, .hungry_tomorrow
	ifequal THURSDAY, .hungry_tomorrow
	ifequal SATURDAY, .hungry_tomorrow
	ifequal SUNDAY, .hungry_tomorrow

	readvar VAR_HOUR
	ifless MORN_HOUR, .hungry_soon

	checktime MORN
	iffalse .this_morning
	
	showemote EMOTE_SHOCK, PLAYER, 30
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	writetext HiddenKangaskhanText
	waitbutton
	closetext
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_NORMAL
	loadwildmon KANGASKHAN, 40
	startbattle
	reloadmapafterbattle
	end

.hungry_tomorrow
	writetext FuchsiaEatenTreeHungryTomorrowText
	sjump .text_end

.hungry_soon
	writetext FuchsiaEatenTreeHungrySoonText
	sjump .text_end

.this_morning
	writetext FuchsiaEatenTreeThisMorningText
.text_end
	waitbutton
	closetext
	end

SafariZoneDoorScript:
	checkitem SAFARI_KEY
	iftrue .UseKey
	
	farjumptext GoldenrodUndergroundTheDoorsLockedText

.UseKey
	disappear FUCHSIACITY_SAFARI_GATE
	moveobject FUCHSIACITY_SAFARI_GATE, 17,  2
	appear FUCHSIACITY_SAFARI_GATE
	takeitem SAFARI_KEY

	opentext
	writetext FuchsiaCity_KeyBrokeText
	promptbutton
	waitsfx
	playsound SFX_ENTER_DOOR
	waitsfx
	writetext DoorUnlockedText
	waitbutton
	closetext
	end
	
FuchsiaCityRareCandy:
	hiddenitem RARE_CANDY, EVENT_FUCSHIA_RARE_CANDY

FuchsiaCityLuckyPunch:
	hiddenitem LUCKY_PUNCH, EVENT_FUCSHIA_LUCKY_PUNCH

FuchsiaCityKingsRock:
	hiddenitem KINGS_ROCK, EVENT_FUCSHIA_KINGS_ROCK

FuchsiaCityHelixFossil:
	hiddenitem HELIX_FOSSIL, EVENT_FOUND_HELIX_FOSSIL

FuchsiaCitySlowpokeTail:
	hiddenitem SLOWPOKETAIL, EVENT_FUCHSIA_SLOWPOKETAIL

FuchsiaCityStardust:
	hiddenitem STARDUST, EVENT_FUCHSIA_STARDUST

FuchsiaCityBurnHeal:
	hiddenitem BURN_HEAL, EVENT_FUCHSIA_BURN_HEAL

FuchsiaCityLeftovers:
	hiddenitem LEFTOVERS, EVENT_FUCHSIA_LEFTOVERS

FuchsiaCityToiletPaper:
	hiddenitem TOILET_PAPER, EVENT_FUCHSIA_TOILET_PAPER

FuchsiaCityLemonade:
	hiddenitem LEMONADE, EVENT_FUCHSIA_LEMONADE

FuchsiaCityGrampsText: ; TO TRANSLATE
	text "This town used to"
	line "thrive but now"

	para "it feels like a"
	line "GHOST town."

	para "First the face of"
	line "our town, KOGA,"

	para "was called to the"
	line "ELITE 4."

	para "Then CINNABAR's"
	line "volcano erupted,"

	para "destroying parts"
	line "of our town."

	para "And finally, the"
	line "pandemic forced"

	para "the main source of"
	line "income of this"

	para "town to close,"
	line "the SAFARI ZONE."

	para "Most inhabitants"
	line "have moved out."

	para "FUCHSIA CITY has"
	line "been abandonned,"

	para "this is sad…"

	para "…"

	para "We're in luck that"
	line "KOGA's daughter"

	para "brings in a few"
	line "tourists like you."
	done

FuchsiaCityBlockerText: ; TO TRANSLATE
	text "Howdy trainer!"

	para "Pleasure to see" 
	line "you! We rarely"
	cont "meet tourists in"
	cont "this town."
	done

FuchsiaCityBlockerText2: ; TO TRANSLATE
	text "What? You want"
	line "to go east?"
	done

FuchsiaCityBlockerText25: ; TO TRANSLATE
	text "Oh! Well, we"
	line "haven't moved"
	cont "those boulders"
	
	para "right after the"
	line "eruption, then"
	cont "the pandemic came…"
	cont "and here they are."

	para "This town is very"
	line "calm. No one ever"
	cont "complained about"
	cont "those."
	done

FuchsiaCityBlockerText3: ; TO TRANSLATE
	text "You know what?"

	para "I will do any-"
	line "thing to make a"
	cont "tourist happy!"

	para "Moving those"
	line "boulders could"
	cont "help bringing in"
	cont "more tourists as"
	cont "well! Great idea!"
	done

FuchsiaCityBlockerText4: ; TO TRANSLATE
	text "The clearance"
	line "shouldn't take"
	cont "long."

	para "Meanwhile, I'd"
	line "recommend you go"
	cont "challenge JANINE,"
	cont "the GYM LEADER."

	para "It's the best and"
	line "only activity in"
	cont "this town!"
	done

FuchsiaCityTeacherText: ; TO TRANSLATE
	text "Since the #MON"
	line "zoo closed, only"
	cont "2 #MON stayed."

	para "The LAPRAS can't"
	line "get away, so I'm"
	cont "feeding him."

	para "Someone else must"
	line "be feeding the"
	cont "VOLTORB."
	done

FuchsiaCityStupidText: ; TO TRANSLATE
	text "That # BALL in"
	line "there is really a"
	cont "#MON."
	done

FuchsiaCityStupidSurprisedText: ; TO TRANSLATE
	text "The # BALL was"
	line "actually…"
	cont "an # BALL?"

	para "Could the #MON"
	line "ZOO have displayed"
	
	para "other fake"
	line "#MON?"
	done

FuchsiaCitySignText: ; AUTOTRAD
	text "FUCHSIA CITY"

	para "Behold! It's"
	line "Passion Pink!"
	done

FuchsiaGymSignText: ; AUTOTRAD
	text "FUCHSIA CITY"
	line "#MON GYM"
	cont "LEADER: JANINE"

	para "The Poisonous"
	line "Ninja Master"
	done

SafariZoneOfficeSignText: ; AUTOTRAD
	text "There's a notice"
	line "here…"

	para "SAFARI ZONE OFFICE"
	line "is closed until"
	cont "further notice."
	done

WardensHomeSignText: ; AUTOTRAD
	text "SAFARI ZONE"
	line "WARDEN'S HOME"
	done

SafariZoneClosedSignText: ; TO TRANSLATE
	text "SAFARI ZONE"
	para "FOR SALE"
	done

SafariZoneOpenedSignText: ; TO TRANSLATE
	text "SAFARI ZONE"
	para "Now opened!"
	done

NoLitteringSignText: ; AUTOTRAD
	text "No littering."

	para "Please take your"
	line "waste with you."
	done

FuchsiaOldSign1Text: ; TO TRANSLATE
	text "Name: VOLTORB"
	para "The very image of"
	line "a #BALL."
	done

FuchsiaOldSign2Text: ; TO TRANSLATE
	text "Name: CHANSEY"
	para "Catching one is"
	line "all up to chance."
	done

FuchsiaOldSign3Text: ; TO TRANSLATE
	text "Name: SLOWPOKE"
	para "Friendly and very"
	line "slow moving."
	done
	
FuchsiaOldSign4Text: ; TO TRANSLATE
	text "Name: KANGASKHAN"
	para "A maternal #MON"
	line "that raises its"
	cont "young in a pouch"
	cont "on its belly."
	done
		
FuchsiaOldSign5Text: ; TO TRANSLATE
	text "…was resurrected"
	line "from a fossil."

	para "Top part of the"
	line "sign has faded"
	cont "out to the sun."
	done

FuchsiaOldSign6Text: ; TO TRANSLATE
	text "Name: LAPRAS"
	para "A.K.A. the king"
	line "of the seas."
	done

FuchsiaEatenTreeText: ; TO TRANSLATE
	text "It's a fruit-"
	line "bearing tree."

	para "The fruits appear"
	line "to have been"

	para "eaten by a wild"
	line "#MON."
	done

FuchsiaEatenTreeThisMorningText: ; TO TRANSLATE
	text "The bite marks"
	line "are still fresh…"

	para "Probably from"
	line "this morning."
	done

FuchsiaEatenTreeHungryTomorrowText: ; TO TRANSLATE
	text "Judging by the"
	line "amount of fruits"
	cont "eaten, the #MON"
	cont "will be full for"
	cont "the day."
	done

FuchsiaEatenTreeHungrySoonText: ; TO TRANSLATE
	text "The bite marks"
	line "look old…"

	para "The creature"
	line "feeding off this"
	cont "tree should feel"
	cont "hungry within the"
	cont "next few hours."
	done

HiddenKangaskhanText: ; TO TRANSLATE
	text "Wow! The wild"
	line "#MON was right"
	cont "behind the tree!"
	done

FuchsiaCity_KeyBrokeText: ; TO TRANSLATE
	text "<PLAYER> used the"
	line "SAFARI KEY."
	cont "… and it broke."
	done
	
DoorUnlockedText: ; TO TRANSLATE
	text "The door unlocked."
	done

FuchsiaCity_StartExcavation:
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head RIGHT
	step_end

FuchsiaCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 13, FUCHSIA_MART, 2
	warp_event 22, 13, SAFARI_ZONE_MAIN_OFFICE, 1
	warp_event  8, 27, FUCHSIA_GYM, 1
	warp_event 11, 27, BILLS_BROTHERS_HOUSE, 1
	warp_event 19, 27, FUCHSIA_POKECENTER_1F, 1
	warp_event 27, 27, SAFARI_ZONE_WARDENS_HOME, 1
	warp_event 18,  3, SAFARI_ZONE_FUCHSIA_GATE_BETA, 3 ; inaccessible
	warp_event 37, 22, ROUTE_15_FUCHSIA_GATE, 1
	warp_event 37, 23, ROUTE_15_FUCHSIA_GATE, 2
	warp_event  7, 35, ROUTE_19_FUCHSIA_GATE, 1
	warp_event  8, 35, ROUTE_19_FUCHSIA_GATE, 2
	warp_event 31, 24, WARDENS_NEIGHBOR_HOUSE, 3
	warp_event 27, 24, SAFARI_ZONE_WARDENS_HOME, 3
	warp_event 31, 27, WARDENS_NEIGHBOR_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 21, 15, BGEVENT_READ, FuchsiaCitySign
	bg_event  5, 29, BGEVENT_READ, FuchsiaGymSign
	bg_event 25, 15, BGEVENT_READ, SafariZoneOfficeSign
	bg_event 27, 29, BGEVENT_READ, WardensHomeSign
	bg_event 17,  5, BGEVENT_READ, SafariZoneClosedSign
	bg_event 17, 15, BGEVENT_READ, NoLitteringSign
	bg_event 20, 27, BGEVENT_READ, FuchsiaCityPokecenterSign
	bg_event  6, 13, BGEVENT_READ, FuchsiaCityMartSign
	bg_event 27,  7, BGEVENT_READ, FuchsiaOldSign1
	bg_event 33,  7, BGEVENT_READ, FuchsiaOldSign2
	bg_event 22, 18, BGEVENT_ITEM, FuchsiaCityRareCandy
	bg_event 13, 34, BGEVENT_ITEM, FuchsiaCityStardust
	bg_event 29, 12, BGEVENT_ITEM, FuchsiaCityKingsRock
	bg_event  6,  5, BGEVENT_ITEM, FuchsiaCityHelixFossil
	bg_event 31,  5, BGEVENT_ITEM, FuchsiaCityLuckyPunch
	bg_event 28, 12, BGEVENT_ITEM, FuchsiaCitySlowpokeTail
	bg_event 20, 32, BGEVENT_ITEM, FuchsiaCityBurnHeal
	bg_event  9,  4, BGEVENT_ITEM, FuchsiaCityLeftovers
	bg_event 18, 15, BGEVENT_ITEM, FuchsiaCityToiletPaper
	bg_event 16, 15, BGEVENT_ITEM, FuchsiaCityLemonade
	bg_event 31, 13, BGEVENT_READ, FuchsiaOldSign3
	bg_event 13,  7, BGEVENT_READ, FuchsiaOldSign4
	bg_event  7,  7, BGEVENT_READ, FuchsiaOldSign5
	bg_event 13, 15, BGEVENT_READ, FuchsiaOldSign6

	def_object_events
	object_event 23, 18, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityGramps, -1
	object_event 37, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBlocker, EVENT_BEAT_JANINE
	object_event 11, 15, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaCityTeacher, -1
	object_event 24,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityStupid, -1
	object_event  8, 17, SPRITE_SURF, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 3, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FuchsiaCityTeacher, -1
	object_event 36,  9, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityFruitTree, -1
	object_event  8,  1, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityFruitTree2, -1
	object_event 31, 27, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, EVENT_WARDENS_NEIGHBOR_BOULDER_BLOCKING
	object_event 37, 23, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, EVENT_BEAT_JANINE
	object_event 37, 22, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, EVENT_BEAT_JANINE
	object_event 25,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, FuchsiaCityPokeball, EVENT_FUCSHIA_POKEBALL
	object_event 29, 12, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 27, 31, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 16, 17, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 33, 24, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 32, 28, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, EVENT_WARDENS_NEIGHBOR_BOULDER_CLEARED
	object_event 18,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SafariZoneDoorScript, EVENT_BOUGHT_SAFARI_PARK
