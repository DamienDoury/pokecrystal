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
	const FUCHSIACITY_BOULDER4
	const FUCHSIACITY_POKEBALL
	const FUCHSIACITY_ROCK1
	const FUCHSIACITY_ROCK2
	const FUCHSIACITY_ROCK3

FuchsiaCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_OBJECTS, .FuchsiaSetup

.FlyPoint:
	setflag ENGINE_FLYPOINT_FUCHSIA
	endcallback

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
	jumptext SafariZoneClosedSignText

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
	waitbutton
	closetext
	checktime MORN
	iffalse .end
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .end
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .end
	ifequal THURSDAY, .end
	ifequal SATURDAY, .end
	ifequal SUNDAY, .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	opentext
	writetext HiddenKangaskhanText
	waitbutton
	closetext
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_NORMAL
	loadwildmon KANGASKHAN, 40
	startbattle
	reloadmapafterbattle
.end
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

FuchsiaCityGrampsText:
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

FuchsiaCityBlockerText:
	text "Howdy trainer!"

	para "Pleasure to see" 
	line "you! We rarely"
	cont "meet tourists in"
	cont "this town."
	done

FuchsiaCityBlockerText2:
	text "What? You want"
	line "to go west?"
	done

FuchsiaCityBlockerText25:
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

FuchsiaCityBlockerText3:
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

FuchsiaCityBlockerText4:
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

FuchsiaCityTeacherText:
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

FuchsiaCityStupidText:
	text "That item ball in"
	line "there is really a"
	cont "#MON."
	done

FuchsiaCityStupidSurprisedText:
	text "The item ball was"
	line "actually…"
	cont "an item ball?"

	para "Could the #MON"
	line "ZOO have displayed"
	
	para "other fake"
	line "#MON?"
	done

FuchsiaCitySignText:
	text "FUCHSIA CITY"

	para "Behold! It's"
	line "Passion Pink!"
	done

FuchsiaGymSignText:
	text "FUCHSIA CITY"
	line "#MON GYM"
	cont "LEADER: JANINE"

	para "The Poisonous"
	line "Ninja Master"
	done

SafariZoneOfficeSignText:
	text "There's a notice"
	line "here…"

	para "SAFARI ZONE OFFICE"
	line "is closed until"
	cont "further notice."
	done

WardensHomeSignText:
	text "SAFARI ZONE"
	line "WARDEN'S HOME"
	done

SafariZoneClosedSignText:
	text "The WARDEN is"
	line "traveling abroad."

	para "Therefore, the"
	line "SAFARI ZONE is"
	cont "closed."
	done

NoLitteringSignText:
	text "No littering."

	para "Please take your"
	line "waste with you."
	done

FuchsiaOldSign1Text:
	text "Name: VOLTORB"
	para "The very image of"
	line "a #BALL."
	done

FuchsiaOldSign2Text:
	text "Name: CHANSEY"
	para "Catching one is"
	line "all up to chance."
	done

FuchsiaEatenTreeText:
	text "It's a fruit-"
	line "bearing tree."

	para "The fruits appear"
	line "to have been"

	para "eaten by a wild"
	line "#MON…"
	done

HiddenKangaskhanText:
	text "Wow! The wild"
	line "#MON was right"
	cont "behind the tree!"
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

	def_coord_events

	def_bg_events
	bg_event 21, 15, BGEVENT_READ, FuchsiaCitySign
	bg_event  5, 29, BGEVENT_READ, FuchsiaGymSign
	bg_event 25, 15, BGEVENT_READ, SafariZoneOfficeSign
	bg_event 27, 29, BGEVENT_READ, WardensHomeSign
	bg_event 17,  5, BGEVENT_READ, SafariZoneClosedSign
	bg_event 13, 15, BGEVENT_READ, NoLitteringSign
	bg_event 20, 27, BGEVENT_READ, FuchsiaCityPokecenterSign
	bg_event  6, 13, BGEVENT_READ, FuchsiaCityMartSign
	bg_event 27,  7, BGEVENT_READ, FuchsiaOldSign1
	bg_event 33,  7, BGEVENT_READ, FuchsiaOldSign2
	bg_event 22, 18, BGEVENT_ITEM, FuchsiaCityRareCandy
	bg_event 13, 34, BGEVENT_ITEM, FuchsiaCityStardust
	bg_event 28, 14, BGEVENT_ITEM, FuchsiaCityKingsRock
	bg_event  8,  5, BGEVENT_ITEM, FuchsiaCityHelixFossil
	bg_event 31,  4, BGEVENT_ITEM, FuchsiaCityLuckyPunch
	bg_event 27, 14, BGEVENT_ITEM, FuchsiaCitySlowpokeTail
	bg_event 20, 32, BGEVENT_ITEM, FuchsiaCityBurnHeal
	bg_event 11,  4, BGEVENT_ITEM, FuchsiaCityLeftovers
	bg_event 37, 33, BGEVENT_ITEM, FuchsiaCityToiletPaper
	bg_event 12, 15, BGEVENT_ITEM, FuchsiaCityLemonade

	def_object_events
	object_event 23, 18, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityGramps, -1
	object_event 37, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBlocker, EVENT_BEAT_JANINE
	object_event 11, 15, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaCityTeacher, -1
	object_event 24,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityStupid, -1
	object_event  8, 17, SPRITE_SURF, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 3, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FuchsiaCityTeacher, -1
	object_event 36,  9, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityFruitTree, -1
	object_event  8,  1, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityFruitTree2, -1
	object_event 31, 27, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, -1
	object_event 37, 23, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, EVENT_BEAT_JANINE
	object_event 37, 22, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, EVENT_BEAT_JANINE
	object_event 18, 28, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, -1
	object_event 25,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, FuchsiaCityPokeball, EVENT_FUCSHIA_POKEBALL
	object_event 28, 14, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 26, 31, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 33, 24, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
