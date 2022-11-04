	object_const_def
	const CHERRYGROVEGYMSPEECHHOUSE_POKEFAN_M
	const CHERRYGROVEGYMSPEECHHOUSE_BUG_CATCHER

CherrygroveGymSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygroveGymSpeechHousePokefanMScript:
	readvar VAR_BADGES
	ifless 4, .before_pcr
	jumptextfaceplayer CherrygroveGymSpeechHousePokefanM2Text
.before_pcr
	jumptextfaceplayer CherrygroveGymSpeechHousePokefanM1Text

CherrygroveGymSpeechHouseBugCatcherScript:
	jumptextfaceplayer CherrygroveGymSpeechHouseBugCatcherText

CherrygroveGymSpeechHouseBookshelf:
	jumpstd PictureBookshelfScript

CherrygroveGymSpeechHousePokefanM1Text:
	text "I'm not feeling"
	line "well, I can't know"
	cont "if I caught COVID!"

	para "I've heard scien-"
	line "tists are working"
	cont "on a test to"
	cont "detect the virus."
	done

CherrygroveGymSpeechHousePokefanM2Text:
	text "PCR tests are a"
	line "blessing!"

	para "I do one everyday,"
	line "just to make sure"
	cont "I don't have COVID."

	para "…"

	para "Why are you"
	line "looking at me"
	cont "like this?"

	para "Is my nose"
	line "bleeding again?"
	done

CherrygroveGymSpeechHouseBugCatcherText:
	text "When I get older,"
	line "I'm going to be a"
	cont "GYM LEADER!"

	para "I make my #MON"
	line "battle with my"

	para "friend's to make"
	line "them tougher!"
	done

CherrygroveGymSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 3
	warp_event  3,  7, CHERRYGROVE_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CherrygroveGymSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CherrygroveGymSpeechHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveGymSpeechHousePokefanMScript, -1
	object_event  5,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveGymSpeechHouseBugCatcherScript, -1
