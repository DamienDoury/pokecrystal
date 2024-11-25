	object_const_def
	const ROUTE4_TUNNEL_KARATEKA

Route4Tunnel_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBlackbeltIcarus:
	trainer BLACKBELT_T, ICARUS, EVENT_BEAT_BLACKBELT_ICARUS, BlackbeltIcarusSeenText, BlackbeltIcarusBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltIcarusAfterBattleText
	waitbutton
	closetext
	end

BlackbeltIcarusSeenText:
	text "…Who's there?"
	done

BlackbeltIcarusBeatenText:
	text "That was self"
	line "defense."
	done

BlackbeltIcarusAfterBattleText:
	text "CERULEAN CAVE is"
	line "no longer being"
	cont "watched since it"
	cont "collapsed."

	para "Trainers have"
	line "been trying to"
	cont "reach it."

	para "I've heard that one"
	line "powerful trainer"
	cont "was able to enter"
	cont "it using his tiny"
	cont "#MON."

	para "So I've been"
	line "digging here, but"
	cont "it leads nowhere…"
	done



Route4Tunnel_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 11, ROUTE_4, 2
	warp_event 17, 13, ROUTE_4, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event 12, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBlackbeltIcarus, -1

