	object_const_def
	const ROUTE6_POKEFAN_M1
	const ROUTE6_POKEFAN_M2
	const ROUTE6_POKEFAN_M3

Route6_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TurnOffLights

.TurnOffLights
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .EndCallback

	; Turns off the underground path lights.
	changeblock 16, 2, $9
	changeblock 18, 2, $33

.EndCallback
	endcallback

TrainerPokefanmRex:
	trainer POKEFANM, REX, EVENT_BEAT_POKEFANM_REX, PokefanmRexSeenText, PokefanmRexBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmRexAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanmAllan:
	trainer POKEFANM, ALLAN, EVENT_BEAT_POKEFANM_ALLAN, PokefanmAllanSeenText, PokefanmAllanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmAllanAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanmFrancis:
	trainer POKEFANM, FRANCIS, EVENT_BEAT_POKEFANM_FRANCIS, PokefanmFrancisSeenText, PokefanmFrancisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmFrancisAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautyJosie:
	trainer BEAUTY, JOSIE, EVENT_BEAT_BEAUTY_JOSIE, BeautyJosieSeenText, BeautyJosieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautyJosieAfterBattleText
	waitbutton
	closetext
	end

Route6PokefanMScript:
	jumptextfaceplayer Route6PokefanMText

Route6UndergroundPathSign:
	jumptext Route6UndergroundPathSignText

Route6PokefanMText:
	text "The road is closed"
	line "until the problem"

	para "at the POWER PLANT"
	line "is solved."
	done

Route6UndergroundPathSignText:
	text "UNDERGROUND PATH"

	para "CERULEAN CITY -"
	line "VERMILION CITY"
	done

PokefanmRexSeenText:
	text "My PHANPY is the"
	line "cutest in the"
	cont "world."
	done

PokefanmRexBeatenText:
	text "My PHANPY!"
	done

PokefanmRexAfterBattleText:
	text "Look how adorable"
	line "my PHANPY acts!"

	para "Isn't it cute"
	line "enough to make"
	cont "your heart melt?"
	done

PokefanmAllanSeenText:
	text "My TEDDIURSA is"
	line "the cutest in the"
	cont "world."
	done

PokefanmAllanBeatenText:
	text "My TEDDIURSA!"
	done

PokefanmAllanAfterBattleText:
	text "Look how adorable"
	line "my TEDDIURSA acts!"

	para "Isn't it cute"
	line "enough to make"
	cont "your heart melt?"
	done

PokefanmFrancisSeenText:
	text "Hi! You're <PLAYER>!"
	line "The trainer that"
	cont "beat the ELITE 4!"

	para "I'm your number 1"
	line "fan!"

	para "Let me shake"
	line "your hand!"
	done

PokefanmFrancisBeatenText:
	text "I can't believe I"
	line "got to fight you!"
	done

PokefanmFrancisAfterBattleText:
	text "I'm sorry, I"
	line "shouldn't have"
	cont "shaken your hand."

	para "Shielding measures"
	line "must still be"
	cont "followed."
	done

BeautyJosieSeenText:
	text "This place is so"
	line "refreshing!"

	para "I'm glad my ship"
	line "got cancelled in"
	cont "KANTO!"

	para "I could have"
	line "gotten stuck in"
	
	para "a stupid place,"
	line "like JOHTO."
	done

BeautyJosieBeatenText:
	text "Hey! Why did you"
	line "start the fight?"
	done

BeautyJosieAfterBattleText:
	text "I'm sorry if I hurt"
	line "your feelings."
	
	para "I didn't know you"
	line "came from JOHTO."

	para "JOHTO isn't"
	line "that bad."

	para "It's better than"
	line "that ugly SINNOH,"
	cont "right?"
	done

Route6_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17,  3, ROUTE_6_UNDERGROUND_PATH_ENTRANCE, 1
	warp_event  6,  1, ROUTE_6_SAFFRON_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 19,  5, BGEVENT_READ, Route6UndergroundPathSign

	def_object_events
	object_event 17,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 2, Route6PokefanMScript, EVENT_RETURNED_MACHINE_PART
	object_event  9, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerPokefanmRex, -1
	object_event 10, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerPokefanmAllan, -1
	object_event  4,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerPokefanmFrancis, -1
	object_event  8,  9, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 1, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, TrainerBeautyJosie, -1
