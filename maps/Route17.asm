	object_const_def
	const ROUTE17_BIKER1
	const ROUTE17_BIKER2
	const ROUTE17_BIKER3

Route17_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .AlwaysOnBike

.AlwaysOnBike:
	setflag ENGINE_ALWAYS_ON_BIKE
	setflag ENGINE_DOWNHILL
	endcallback

TrainerBikerRiley:
	trainer BIKER, RILEY, EVENT_BEAT_BIKER_RILEY, BikerRileySeenText, BikerRileyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BikerRileyAfterBattleText
	waitbutton
	closetext
	end

TrainerBikerJoel:
	trainer BIKER, JOEL, EVENT_BEAT_BIKER_JOEL, BikerJoelSeenText, BikerJoelBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BikerJoelAfterBattleText
	waitbutton
	closetext
	end

TrainerBikerGlenn:
	trainer BIKER, GLENN, EVENT_BEAT_BIKER_GLENN, BikerGlennSeenText, BikerGlennBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BikerGlennAfterBattleText
	waitbutton
	closetext
	end

Route17Mid1Sign:
	jumptext Route17TrainerTips1Text

Route17Mid2Sign:
	jumptext Route17TrainerTips2Text

Route17Mid3Sign:
	jumptext Route17MidSign3Text

Route17Bot1Sign:
	jumptext Route17BotSign1Text

Route17Bot2Sign:
	jumptext Route17BotSign2Text

Route17HiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_ROUTE_17_HIDDEN_MAX_ETHER

Route17HiddenMaxElixer:
	hiddenitem MAX_ELIXER, EVENT_ROUTE_17_HIDDEN_MAX_ELIXER

BikerRileySeenText:
	text "Hey, you! You're"
	line "from JOHTO, huh?"
	done

BikerRileyBeatenText:
	text "Whoa, you kick!"
	done

BikerRileyAfterBattleText:
	text "Don't get cocky,"
	line "you JOHTO punk!"
	done

BikerJoelSeenText:
	text "Wow. That's a cool"
	line "BICYCLE!"
	done

BikerJoelBeatenText:
	text "But you don't just"
	line "look cool…"
	done

BikerJoelAfterBattleText:
	text "I look cool, but"
	line "I'm weak, so I'm"
	cont "not really cool."

	para "I have to train"
	line "harder…"
	done

BikerGlennSeenText:
	text "Hey! Want to have"
	line "a speed battle?"
	done

BikerGlennBeatenText:
	text "Yikes! You've got"
	line "awesome torque!"
	done

BikerGlennAfterBattleText:
	text "Hands-free riding"
	line "is considered cool"
	cont "on CYCLING ROAD."
	done

Route17MidSign3Text:
	text "Route 16"
	line "CELADON CITY -"
	cont "FUCHSIA CITY"
	done

Route17MidSign1Text:
	text "It's a notice!"

	para "Watch out for"
	line "discarded items!"
	done

Route17TrainerTips1Text:
	text "TRAINER TIPS"

	para "All #MON are"
	line "unique."

	para "Even #MON of"
	line "the same type and"
	cont "level grow at"
	cont "different rates."
	done

Route17TrainerTips2Text:
	text "TRAINER TIPS"

	para "There's a graffiti"
	line "written in french…"

	para "“Apres le covid,"
	line "le frigovid!”"
	done

Route17BotSign1Text:
	text "It's a notice!"

	para "Don't throw the"
	line "game, throw #"
	cont "BALLs instead!"
	done

Route17BotSign2Text::
	text "CYCLING ROAD"
	line "slope ends here!"
	done

Route17_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 136, ROUTE_17_ROUTE_18_GATE, 1
	warp_event 17, 137, ROUTE_17_ROUTE_18_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 17, 64, BGEVENT_ITEM, Route17HiddenMaxEther
	bg_event  8, 45, BGEVENT_ITEM, Route17HiddenMaxElixer
	bg_event  9, 51, BGEVENT_READ, Route17Mid1Sign
	bg_event  9, 63, BGEVENT_READ, Route17Mid2Sign
	bg_event  9, 75, BGEVENT_READ, Route17Mid3Sign
	bg_event  9, 99, BGEVENT_READ, Route17Bot1Sign
	bg_event  9, 129, BGEVENT_READ, Route17Bot2Sign

	def_object_events
	object_event  4, 75, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerBikerRiley, -1
	object_event  9, 122, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerBikerJoel, -1
	object_event  3, 107, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBikerGlenn, -1
