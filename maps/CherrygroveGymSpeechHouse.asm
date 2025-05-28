	object_const_def
	const CHERRYGROVEGYMSPEECHHOUSE_POKEFAN_M
	const CHERRYGROVEGYMSPEECHHOUSE_BUG_CATCHER

CherrygroveGymSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject CHERRYGROVEGYMSPEECHHOUSE_BUG_CATCHER, 5, 1
	moveobject CHERRYGROVEGYMSPEECHHOUSE_POKEFAN_M, 6, 1
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

CherrygroveGymSpeechHousePokefanMScript:
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .beforeLockdown

	readvar VAR_BADGES
	ifless 4, .before_pcr

	jumptextfaceplayer CherrygroveGymSpeechHousePokefanM2Text
.before_pcr
	jumptextfaceplayer CherrygroveGymSpeechHousePokefanM1Text
.beforeLockdown
	jumptextfaceplayer CherrygroveGymSpeechHousePokefanM0Text

CherrygroveGymSpeechHouseBugCatcherScript:
	jumptextfaceplayer CherrygroveGymSpeechHouseBugCatcherText

CherrygroveGymSpeechHouseBookshelf:
	jumpstd PictureBookshelfScript

CherrygroveGymSpeechHousePokefanM0Text: ; TO TRANSLATE
	text "A new virus we"
	line "should be scared"
	cont "of? Let me laugh!"
	
	para "In the past decade"
	line "only, medias tried"
	
	para "to scare the popu-"
	line "lation with the"
	
	para "H1N1 epidemic, the"
	line "Ebola epidemic,"
	cont "and some more."

	para "It always turned"
	line "out to be a damp"
	cont "squib."
	done

CherrygroveGymSpeechHousePokefanM1Text: ; TO TRANSLATE
	text "I'm not feeling"
	line "well, I can't know"
	cont "if I caught COVID!"

	para "I've heard scien-"
	line "tists are working"
	cont "on a test to"
	cont "detect the virus."
	done

CherrygroveGymSpeechHousePokefanM2Text: ; TO TRANSLATE
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
if DEF(_FR_FR)
	text "Quand je serai"
	line "grand, je serai un"
	cont "CHAMPION d'ARENE!"

	para "Je fais combattre"
	line "mes #MON contre"

	para "ceux de mon ami"
	line "pour qu'ils"
	cont "progressent!"
else
	text "When I get older,"
	line "I'm going to be a"
	cont "GYM LEADER!"

	para "I make my #MON"
	line "battle with my"

	para "friend's to make"
	line "them tougher!"
endc

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
	object_event  2,  3, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveGymSpeechHousePokefanMScript, -1
	object_event  5,  5, SPRITE_BUG_CATCHER, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveGymSpeechHouseBugCatcherScript, -1
