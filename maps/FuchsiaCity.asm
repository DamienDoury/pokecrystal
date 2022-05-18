	object_const_def
	const FUCHSIACITY_YOUNGSTER
	const FUCHSIACITY_TEACHER
	const FUCHSIACITY_STUPID
	const FUCHSIACITY_LAPRAS
	const FUCHSIACITY_FRUIT_TREE
	const FUCHSIACITY_FRUIT_TREE2
	const FUCHSIACITY_BOULDER1
	const FUCHSIACITY_BOULDER2
	const FUCHSIACITY_POKEBALL
	const FUCHSIACITY_ROCK1
	const FUCHSIACITY_ROCK2
	const FUCHSIACITY_ROCK3

FuchsiaCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_FUCHSIA
	endcallback

FuchsiaCityYoungster:
	jumptextfaceplayer FuchsiaCityYoungsterText

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
	jumptext FuchsiaEatenTreeText

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

FuchsiaCityYoungsterText:
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

	para "eaten by wild"
	line "#MON…"
	done

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
	object_event 23, 18, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityYoungster, -1
	object_event 11, 15, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaCityTeacher, -1
	object_event 24,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FuchsiaCityStupid, -1
	object_event  8, 17, SPRITE_SURF, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 3, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FuchsiaCityTeacher, -1
	object_event  8,  1, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityFruitTree, -1
	object_event 36,  9, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityFruitTree2, -1
	object_event 31, 27, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, -1
	object_event 18, 28, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityBoulderScript, -1
	object_event 25,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, FuchsiaCityPokeball, EVENT_FUCSHIA_POKEBALL
	object_event 28, 14, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 26, 31, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
	object_event 36, 23, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaCityRockScript, -1
