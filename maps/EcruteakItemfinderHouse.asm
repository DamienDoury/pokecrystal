	object_const_def
	const ECRUTEAKITEMFINDERHOUSE_COOLTRAINER_M
	const ECRUTEAKITEMFINDERHOUSE_POKEDEX
	const ECRUTEAKITEMFINDERHOUSE_SISTER

EcruteakItemfinderHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject ECRUTEAKITEMFINDERHOUSE_SISTER, 7, 3
	loadmem wMap3ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
.end
	endcallback

EcruteakItemfinderGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_ITEMFINDER
	iftrue .itemfinder
	writetext EcruteakItemfinderAdventureText
	yesorno
	iffalse .no
	writetext EcruteakItemfinderTrueSpiritText
	promptbutton
	verbosegiveitem ITEMFINDER
	setevent EVENT_GOT_ITEMFINDER
.itemfinder:
	farwritetext ItemfinderExplanationText
	waitbutton
	closetext
	end

.no:
	writetext EcruteakItemfinderToEachHisOwnText
	waitbutton
	closetext
	end

EcruteakItemfinderGirl:
	jumptextfaceplayer EcruteakItemfinderGirlText

EcruteakHistoryBook:
	opentext
	writetext EcruteakHistoryBookText
	yesorno
	iftrue .ReadBook
	closetext
	end

.ReadBook:
	writetext EcruteakTwoTowersText
	yesorno
	iftrue .KeepReading
	closetext
	end

.KeepReading:
	writetext EcruteakThreeMonText
	waitbutton
	closetext
	end

ItemFinderHouseRadio:
	jumpstd Radio2Script

EcruteakItemfinderAdventureText: ; AUTOTRAD
	text "Ah. You're on an"
	line "adventure with"
	cont "your #MON?"

	para "Well, what's an"
	line "adventure without"
	cont "treasure hunting?"

	para "Am I right, or am"
	line "I right?"
	done

EcruteakItemfinderTrueSpiritText: ; AUTOTRAD
	text "Good! You under-"
	line "stand the true"

	para "spirit of adven-"
	line "ture."

	para "I like that! Take"
	line "this with you."
	done

EcruteakItemfinderToEachHisOwnText: ; AUTOTRAD
	text "Oh… To each his"
	line "own, I suppose…"
	done

EcruteakItemfinderGirlText: ; TO TRANSLATE
	text "My brother lives"
	line "in AZALEA TOWN"
	cont "with his trusty"
	cont "FARFETCH'D."


	para "I hope they"
	line "are ok…"
	done

EcruteakHistoryBookText: ; AUTOTRAD
	text "HISTORY OF"
	line "ECRUTEAK"

	para "Want to read it?"
	done

EcruteakTwoTowersText: ; AUTOTRAD
	text "In ECRUTEAK, there"
	line "were two towers."

	para "Each tower was the"
	line "roost of powerful"
	cont "flying #MON."

	para "But one of the"
	line "towers burned to"
	cont "the ground."

	para "The two #MON"
	line "haven't been seen"
	cont "since…"

	para "Keep reading?"
	done

EcruteakThreeMonText: ; AUTOTRAD
	text "ECRUTEAK was also"
	line "home to three"

	para "#MON that raced"
	line "around the town."

	para "They were said to"
	line "have been born of"

	para "water, lightning"
	line "and fire."

	para "But they could not"
	line "contain their"
	cont "excessive power."

	para "So they say the"
	line "three ran like the"

	para "wind off into the"
	line "grassland."
	done

EcruteakItemfinderHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 11
	warp_event  4,  7, ECRUTEAK_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ItemFinderHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakItemfinderGuy, -1
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakHistoryBook, -1
	object_event  4,  5, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakItemfinderGirl, -1
