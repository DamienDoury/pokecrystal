	object_const_def
	const PEWTERCITY_COOLTRAINER_F
	const PEWTERCITY_BUG_CATCHER
	const PEWTERCITY_GRAMPS
	const PEWTERCITY_FRUIT_TREE1
	const PEWTERCITY_FRUIT_TREE2
	const PEWTERCITY_FRUIT_TREE3
	const PEWTERCITY_MUSEUM_DOOR
	const PEWTERCITY_MUSEUM_BACKDOOR

PewterCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_PEWTER
	endcallback

PewterCityCooltrainerFScript:
	jumptextfaceplayer PewterCityCooltrainerFText

PewterCityBugCatcherScript:
	checkitem SILVER_WING
	iftrue .GotSilverWing

	jumptextfaceplayer PewterCityBugCatcherJustSavedText

.GotSilverWing
	jumptextfaceplayer PewterCityBugCatcherText

PewterCityGrampsScript:
	faceplayer
	;giveitem MUSEUM_KEY
	checkitem MUSEUM_KEY
	iftrue .GotMuseumKey
	checkevent EVENT_FOUGHT_ZAPDOS
	iftrue .GiveMuseumKey
	jumptext PewterCityGrampsLostGrandKidText

.GiveMuseumKey:
	opentext
	writetext PewterCityGrampsText
	promptbutton
	verbosegiveitem MUSEUM_KEY
	;verbosegiveitem SILVER_WING
	;setevent EVENT_GOT_SILVER_WING
	closetext
	end

.GotMuseumKey:
	jumptext PewterCityGrampsText_GotMuseumKey

PewterCitySign:
	jumptext PewterCitySignText

PewterGymSign:
	jumptext PewterGymSignText

PewterMuseumSign:
	jumptext PewterMuseumSignText

PewterCityMtMoonGiftShopSign:
	jumptext PewterCityMtMoonGiftShopSignText

PewterCityWelcomeSign:
	jumptext PewterCityWelcomeSignText

PewterCityPokecenterSign:
	jumpstd PokecenterSignScript

PewterCityMartSign:
	jumpstd MartSignScript

PewterCityFruitTree1:
	fruittree FRUITTREE_PEWTER_CITY_1

PewterCityFruitTree2:
	fruittree FRUITTREE_PEWTER_CITY_2
	
PewterCityFruitTree3:
	fruittree FRUITTREE_PEWTER_CITY_3

PewterCity_Door1Script:
	opentext
	writetext PewterMuseumHeavyChainText
	checkitem MUSEUM_KEY
	iffalse .end

	promptbutton
	writetext PewterMuseumKeyDoesntFitText
.end
	waitbutton
	closetext
	end

PewterCity_Door2Script:
	opentext
	writetext PewterMuseumHeavyChainText
	checkitem MUSEUM_KEY
	iffalse .end

	promptbutton
	waitsfx
	playsound SFX_ENTER_DOOR
	waitsfx
	disappear PEWTERCITY_MUSEUM_BACKDOOR
	writetext PewterMuseumKeySuccessText
.end
	waitbutton
	closetext
	end

PewterCityCooltrainerFText:
	text "Young people had"
	line "organized an il-"
	cont "legal party in our"
	cont "beloved MUSEUM."
	
	para "How disrespectful!"

	para "Now the doors have"
	line "been locked with"
	cont "chains."
	done

PewterCityBugCatcherJustSavedText:
	text "Thank you for"
	line "“fixing” the"
	cont "forest."

	para "I really thought I"
	line "was going to live"
	cont "there forever…"

	para "My grandpa wants"
	line "to thank you."

	para "He's walking around"
	line "in the city."
	done

PewterCityBugCatcherText:
	text "At night, CLEFAIRY"
	line "come out to play"
	cont "at MT.MOON."

	para "Though not every"
	line "night."

	para "But I won't go."
	line "I'm afraid to get"
	cont "lost once again."
	done

PewterCityGrampsLostGrandKidText:
	text "My grand-kid went"
	line "picking berries"
	cont "in VIRIDIAN FOREST"
	cont "and never came"
	cont "back…"

	para "You! You are a"
	line "trainer!"

	para "Please go search"
	line "my grand-kid,"
	cont "I'm begging you!"
	done

PewterCityGrampsText:
	text "Ah, you're the one"
	line "that solved the"
	cont "forest's mystery."

	para "Thanks to you, my"
	line "grand-kid made it"
	cont "out alive."

	para "I am in debt to"
	line "you. How can I"
	cont "repay you?"

	para "Oh, I know!"

	para "People loved the"
	line "MUSEUM OF SCIENCE."

	para "I am the one who"
	line "locked it down."
	
	para "Take my spare key."
	line "I trust you to"
	cont "close the place"
	cont "when you leave."
	done

PewterCityGrampsText_GotMuseumKey:
	text "When you were into"
	line "VIRIDIAN FOREST,"

	para "I could see the"
	line "mythical thunder"

	para "#MON dive into"
	line "the forest from"
	
	para "the sky, then this"
	line "other fairy-like"
	
	para "#MON flew out"
	line "of the forest"
	cont "to the west."

	para "Was the first one"
	line "keeping the other"
	cont "captive?"
	
	para "Or did the first"
	line "one come to prot-"
	cont "ect the other one?"

	para "It's hard to tell…"
	done

PewterCitySignText:
	text "PEWTER CITY"
	line "A Stone Gray City"
	done

PewterGymSignText:
	text "PEWTER CITY"
	line "#MON GYM"
	cont "LEADER: BROCK"

	para "The Rock Solid"
	line "#MON Trainer"
	done

PewterMuseumSignText:
	text "There's a notice"
	line "here…"

	para "We are sorry to"
	line "inform you that"
	
	para "due to the lack of"
	line "customers during"
	
	para "the lockdowns,"
	line "PEWTER MUSEUM OF"

	para "SCIENCE has filed"
	line "for bankruptcy."
	done

PewterMuseumHeavyChainText:
	text "A heavy chain"
	line "keeps the door"
	cont "locked."
	done

PewterMuseumKeyDoesntFitText:
	text "The MUSEUM KEY"
	line "doesn't fit into"
	cont "the padlock."
	done

PewterMuseumKeySuccessText:
	text "The MUSEUM KEY"
	line "unlocked the"
	cont "chain."
	done

PewterCityMtMoonGiftShopSignText:
	text "There's a notice"
	line "here…"

	para "MT.MOON GIFT SHOP"
	line "NOW OPEN!"
	done

PewterCityWelcomeSignText:
	text "WELCOME TO"
	line "PEWTER CITY!"
	done

PewterCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 29, 13, PEWTER_NIDORAN_SPEECH_HOUSE, 1
	warp_event 16, 17, PEWTER_GYM, 1
	warp_event 23, 17, PEWTER_MART, 2
	warp_event 13, 25, PEWTER_POKECENTER_1F, 1
	warp_event  7, 29, PEWTER_SNOOZE_SPEECH_HOUSE, 1
	warp_event 19,  5, PEWTER_MUSEUM_1F, 1

	def_coord_events

	def_bg_events
	bg_event 25, 23, BGEVENT_READ, PewterCitySign
	bg_event 11, 17, BGEVENT_READ, PewterGymSign
	bg_event 15,  9, BGEVENT_READ, PewterMuseumSign
	bg_event 33, 19, BGEVENT_READ, PewterCityMtMoonGiftShopSign
	bg_event 19, 29, BGEVENT_READ, PewterCityWelcomeSign
	bg_event 14, 25, BGEVENT_READ, PewterCityPokecenterSign
	bg_event 24, 17, BGEVENT_READ, PewterCityMartSign

	def_object_events
	object_event 19, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PewterCityCooltrainerFScript, -1
	object_event 14, 29, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PewterCityBugCatcherScript, EVENT_VIRIDIAN_FOREST_GUY_SAVED
	object_event 29, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterCityGrampsScript, -1
	object_event 32,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree1, -1
	object_event 30,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree2, -1
	object_event  7,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree3, -1
	object_event 14,  7, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCity_Door1Script, -1
	object_event 19,  5, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCity_Door2Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
