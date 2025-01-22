	object_const_def
	const ROUTE28STEELWINGHOUSE_CELEBRITY
	const ROUTE28STEELWINGHOUSE_FEAROW

Route28SteelWingHouse_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks

.DummyScene:
	end

Celebrity:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; True if the player refused to learn Sky Attack.
	iftrue .covid_chat

	writetext CelebrityText1
	promptbutton
	writetext CelebrityBegging
	promptbutton
	writetext CelebrityAskTeach
	yesorno
	iffalse .refused

	farwritetext GoldenrodCityMoveTutorMoveText
	callasm TopCelebrityMoveTutor
	ifequal -1, .cancelled
	
.covid_chat
	writetext CelebrityText2
	sjump .text_end

.cancelled
	farwritetext GoldenrodCityMoveTutorBButText
	promptbutton
	sjump .refused_2

.refused
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.refused_2
	writetext CelebrityBegging
.text_end
	waitbutton
	closetext
	end

CelebritysFearow:
	opentext
	writetext CelebritysFearowText
	cry FEAROW
	waitbutton
	closetext
	end

CelebrityHouseBookshelf:
	jumpstd MagazineBookshelfScript

CelebrityText1:
	text "Oh, dear."
	line "You've found me."
	done

CelebrityAskTeach:
	text "For keeping my"
	line "secret, I'll teach"
	cont "your #MON the"
	cont "strongest FLYING-"
	cont "type move there"
	cont "is: SKY ATTACK."
	done

CelebrityBegging:
	text "Please don't tell"
	line "anyone about me."
	done

CelebrityText2:
	text "Moving to such a"
	line "far away place was"
	cont "a good decision."
	
	para "I spent a comfor-"
	line "table lockdown,"
	
	para "and I didn't catch"
	line "COVID even once as"
	
	para "I'm the only one"
	line "living around!"

	para "In the city, fans"
	line "chased me every-"
	cont "where I went."

	para "It's tough being a"
	line "top celebrity."
	done

CelebritysFearowText:
	text "FEAROW: Feero!"
	done

Route28SteelWingHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_28, 1
	warp_event  3,  7, ROUTE_28, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CelebrityHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CelebrityHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Celebrity, -1
	object_event  6,  5, SPRITE_FEAROW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CelebritysFearow, -1
