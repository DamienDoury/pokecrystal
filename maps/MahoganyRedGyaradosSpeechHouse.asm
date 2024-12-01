	object_const_def
	const MAHOGANYREDGYARADOSSPEECHHOUSE_BLACK_BELT
	const MAHOGANYREDGYARADOSSPEECHHOUSE_TEACHER

MahoganyRedGyaradosSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MahoganyRedGyaradosSpeechHouseBlackBeltScript:
	jumptextfaceplayer MahoganyRedGyaradosSpeechHouseBlackBeltText

MahoganyRedGyaradosSpeechHouseTeacherScript:
	faceplayer
	opentext

	checkevent EVENT_SCALPER_MET
	iftrue .already_met

	writetext MahoganyRedGyaradosSpeechHouseTeacherText
	promptbutton
	setevent EVENT_SCALPER_MET
	sjump .give

.already_met
	checkflag ENGINE_SCALPER
	iffalse .giveaway_available

	writetext MahoganyRedGyaradosSpeechHouse_ScalperNotTodayText
	waitbutton
	closetext
	end

.giveaway_available
	checkevent EVENT_RED_BEATEN
	iftrue .red_not_beaten

	checkevent EVENT_SCALPER_GAVE_GPU
	iftrue .red_not_beaten ; The GPU can be obtained only once.

	writetext MahoganyRedGyaradosSpeechHouse_ScalperFanText
	promptbutton

	verbosegiveitem TOILET_PAPER, 24
	iffalse .full

	writetext MahoganyRedGyaradosSpeechHouse_ScalperPackText
	waitbutton

	closetext

	setevent EVENT_SCALPER_GAVE_GPU
	setflag ENGINE_SCALPER
	end

.red_not_beaten
	writetext MahoganyRedGyaradosSpeechHouse_ScalperGiveText
	promptbutton

.give
	verbosegiveitem GREAT_BALL
	iffalse .full

	closetext

	setflag ENGINE_SCALPER
	end

.full
	writetext MahoganyRedGyaradosSpeechHouse_ScalperFullText
	waitbutton
	closetext
	end
	
MahoganyRedGyaradosSpeechHouseUnusedBookshelf1: ; unreferenced
	jumpstd PictureBookshelfScript

MahoganyRedGyaradosSpeechHouseUnusedBookshelf2: ; unreferenced
	jumpstd MagazineBookshelfScript

MahoganyRedGyaradosSpeechHouseBlackBeltText:
	text "I heard that a red"
	line "GYARADOS appeared"
	cont "at the LAKE."

	para "That's odd, since"
	line "even ordinary"

	para "GYARADOS are rare"
	line "in that lake…"
	done

MahoganyRedGyaradosSpeechHouseTeacherText:
	text "When COVID-19 was"
	line "first announced,"

	para "I rushed the MART"
	line "before everyone"
	cont "else and I bought"

	para "everything I could"
	line "find."

	para "I thought I would"
	line "be able to resell"
	cont "at a profit."

	para "In the end…"

	para "…I made a lot of"
	line "money, not gonna"
	cont "lie!"

	para "But now I feel"
	line "bad about it."

	para "I called myself"
	line "a ninja, but"

	para "young people call"
	line "me a scalper."

	para "So I decided to"
	line "give away the"
	cont "rest of my stock."

	para "Here's a little"
	line "something for you."
	done

MahoganyRedGyaradosSpeechHouse_ScalperGiveText:
	text "SCALPER: Here's a"
	line "little something."
	done

MahoganyRedGyaradosSpeechHouse_ScalperNotTodayText:
	text "SCALPER: Hey! I'm"
	line "not gonna give you"
	cont "everything I got!"

	para "You'll get more"
	line "another day,"
	cont "maybe."
	done

	MahoganyRedGyaradosSpeechHouse_ScalperFanText:
	text "SCALPER: Hey!"
	line "I know you!"

	para "You're the #MON"
	line "MASTER!!"

	para "You can have an"
	line "item from my"
	cont "secret stock."
	done

MahoganyRedGyaradosSpeechHouse_ScalperPackText:
	text "SCALPER: A"
	line "pristine 24-pack"
	cont "for you my friend!"

	para "Super rare,"
	line "worth gold."
	done

MahoganyRedGyaradosSpeechHouse_ScalperFullText:
	text "I see my bag is"
	line "not the only one"
	cont "to be full!"

	para "Are you a"
	line "scalper like me?"
	done

MahoganyRedGyaradosSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, MAHOGANY_TOWN, 2
	warp_event  4,  7, MAHOGANY_TOWN, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyRedGyaradosSpeechHouseBlackBeltScript, -1
	object_event  6,  4, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MahoganyRedGyaradosSpeechHouseTeacherScript, -1
