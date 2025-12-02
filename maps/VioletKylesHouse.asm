	object_const_def
	const VIOLETKYLESHOUSE_POKEFAN_M
	const VIOLETKYLESHOUSE_KYLE
	
	const VIOLETKYLESHOUSE_TRADEBACKGUY
	const VIOLETKYLESHOUSE_COMPUTER1
	const VIOLETKYLESHOUSE_COMPUTER2

VioletKylesHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject VIOLETKYLESHOUSE_POKEFAN_M, 7, 3
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
	endcallback

.TilesLoad
	readmem wCurFreedomState
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	changeblock  2,  2, $3a
	changeblock  4,  2, $3b
	changeblock  4,  4, $3f
	changeblock  0,  6, $3c
.end
	endcallback

VioletKylesHousePokefanMScript:
	jumptextfaceplayer VioletKylesHousePokefanMText

Kyle:
	faceplayer
	opentext
	trade NPC_TRADE_KYLE
	waitbutton
	closetext
	end

VioletKylesHouseTradebackGuyScript:
	faceplayer
	opentext
	writetext VioletKylesHouseTradebackGuyText
	waitbutton
	farscall TradebackGuyScript
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID1, DOWN
	end

VioletKylesHouseComputer1Script:
	jumptext VioletKylesHouseComputer1Text

VioletKylesHouseComputer2Script:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, .night
	
	jumptext VioletKylesHouseComputer2DayText

.night
	jumptext VioletKylesHouseComputer2NightText

VioletKylesHousePokefanMText: 
if DEF(_FR_FR)
	text "Un #MON échangé"
	line "grandit plus vite"
	cont "qu'un #MON"
	cont "attrapé."

	para "Mais si tu n'as"
	line "pas le bon BADGE,"

	para "il est possible"
	line "qu'il ne t'obé-"
	cont "isse pas."
else
	text "A #MON you get"
	line "in a trade grows"
	cont "quickly."

	para "But if you don't"
	line "have the right GYM"

	para "BADGE, they may"
	line "disobey you."
endc

	done

VioletKylesHouseTradebackGuyText:
if DEF(_FR_FR)
	text "ROBIN: Mon frère"
	line "ne veut pas faire"
	cont "d'échange avec moi."
else
	text "ROBIN: My brother"
	line "doesn't want to"
	cont "trade with me."
endc
	done

VioletKylesHouseComputer1Text:
if DEF(_FR_FR)
	text "Le navigateur web"
	line "a 30 onglets"
	cont "d'ouverts sur"
	cont "des articles"
	cont "Poképédia."
else
	text "The web browser"
	line "has 30 open tabs"
	cont "of Bulbapedia"
	cont "articles."
endc
	done

VioletKylesHouseComputer2DayText:
if DEF(_FR_FR)
	text "C'est le cours"
	line "en ligne!"

	para "20 personnes sont"
	line "dans l'appel vidéo,"
	cont "mais seul le prof"
	cont "a sa webcam"
	cont "allumée."

	para "Et personne ne"
	line "répond aux ques-"
	cont "tions du prof."

	para "En somme, c'est un"
	line "monologue."
else
	text "It's the online"
	line "classroom!"

	para "There are 20"
	line "people in the"
	cont "video call, but"

	para "only the teacher's"
	line "webcam is on."

	para "Also, no one"
	line "replies to the"

	para "teacher when he"
	line "asks questions."

	para "It's basically"
	line "a monologue."
endc
	done

VioletKylesHouseComputer2NightText:
if DEF(_FR_FR)
	text "Il y a une vidéo"
	line "d'un jeu appelé"
	cont "Version Pandémie."

	para "C'est un guide"
	line "de la Forêt de"
	cont "Jade mais le"
	cont "streameur s'est"
	cont "perdu..."

	para "Le chat enragé dit"
	line "que la vidéo ne"
	cont "les aide pas."
else
	text "There's a video of"
	line "a game called"
	cont "Pandemic Version."

	para "It's a walkthrough"
	line "of Viridian Forest"
	cont "but the streamer"
	cont "got lost…"

	para "The raging chat"
	line "says that the"
	cont "video doesn't help."
endc
	done

VioletKylesHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 6
	warp_event  4,  7, VIOLET_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletKylesHousePokefanMScript, -1
	object_event  6,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Kyle, -1
	object_event  5,  4, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletKylesHouseTradebackGuyScript, -1
	object_event  3,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletKylesHouseComputer1Script, -1
	object_event  4,  4, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletKylesHouseComputer2Script, -1
