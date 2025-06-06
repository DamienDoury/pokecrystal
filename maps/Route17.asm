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
	jumptextfaceplayer BikerRileyAfterBattleText

TrainerBikerJoel:
	trainer BIKER, JOEL, EVENT_BEAT_BIKER_JOEL, BikerJoelSeenText, BikerJoelBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerJoelAfterBattleText

TrainerBikerGlenn:
	trainer BIKER, GLENN, EVENT_BEAT_BIKER_GLENN, BikerGlennSeenText, BikerGlennBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerGlennAfterBattleText

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
if DEF(_FR_FR)
	text "Hé, toi!"
	line "T'es de JOHTO?"
else
	text "Hey, you! You're"
	line "from JOHTO, huh?"
endc

	done

BikerRileyBeatenText: 
if DEF(_FR_FR)
	text "Graaaaaah!"
else
	text "Whoa, you kick!"
endc

	done

BikerRileyAfterBattleText: 
if DEF(_FR_FR)
	text "Pas la peine de"
	line "crâner!"
else
	text "Don't get cocky,"
	line "you JOHTO punk!"
endc

	done

BikerJoelSeenText: 
if DEF(_FR_FR)
	text "Oh! Elle est cool"
	line "ta BICYCLETTE!"
else
	text "Wow. That's a cool"
	line "BICYCLE!"
endc

	done

BikerJoelBeatenText: 
if DEF(_FR_FR)
	text "Par contre, toi..."
	line "T'es pas cool."
else
	text "But you don't just"
	line "look cool…"
endc

	done

BikerJoelAfterBattleText: 
if DEF(_FR_FR)
	text "Moi j'ai trop la"
	line "classe. T'as vu"
	cont "mes fringues?"

	para "J'suis trop"
	line "relax."
else
	text "I look cool, but"
	line "I'm weak, so I'm"
	cont "not really cool."

	para "I have to train"
	line "harder…"
endc

	done

BikerGlennSeenText: 
if DEF(_FR_FR)
	text "Hé! Ca te dit un"
	line "chtit combat?"
else
	text "Hey! Want to have"
	line "a speed battle?"
endc

	done

BikerGlennBeatenText: 
if DEF(_FR_FR)
	text "Ayaah! Toi t'es"
	line "pas naze!"
else
	text "Yikes! You've got"
	line "awesome torque!"
endc

	done

BikerGlennAfterBattleText: 
if DEF(_FR_FR)
	text "Conduire sans les"
	line "mains, c'est la"
	cont "classe."
else
	text "Hands-free riding"
	line "is considered cool"
	cont "on CYCLING ROAD."
endc

	done

Route17MidSign3Text: ; TO TRANSLATE
	text "Route 16"
	line "CELADON CITY -"
	cont "FUCHSIA CITY"
	done

Route17MidSign1Text: ; TO TRANSLATE
	text "It's a notice!"

	para "Watch out for"
	line "discarded items!"
	done

Route17TrainerTips1Text: ; TO TRANSLATE
	text "TRAINER TIPS"

	para "All #MON are"
	line "unique."

	para "Even #MON of"
	line "the same type and"
	cont "level grow at"
	cont "different rates."
	done

Route17TrainerTips2Text: ; TO TRANSLATE
	text "TRAINER TIPS"

	para "There's graffiti"
	line "written in French…"

	para "“Apres le COVID,"
	line "le FRIGOVID”"
	done

Route17BotSign1Text: ; TO TRANSLATE
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
