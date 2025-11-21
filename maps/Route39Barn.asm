	object_const_def
	const ROUTE39BARN_TWIN1
	const ROUTE39BARN_TWIN2
	const ROUTE39BARN_MOOMOO
	const ROUTE39BARN_MILTANK1
	const ROUTE39BARN_MILTANK2
	const ROUTE39BARN_MILTANK3
	const ROUTE39BARN_MILTANK4

Route39Barn_MapScripts:
	def_scene_scripts

	def_callbacks

Route39BarnTwin1Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route39BarnTwinMoomooIsSickText
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	turnobject ROUTE39BARN_TWIN1, RIGHT
	end

.FeedingMooMoo:
	writetext Route39BarnTwinWereFeedingMoomooText
	waitbutton
	closetext
	turnobject ROUTE39BARN_TWIN1, RIGHT
	end

Route39BarnTwin2Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route39BarnTwinMoomooIsSickText
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	turnobject ROUTE39BARN_TWIN2, LEFT
	end

.FeedingMooMoo:
	writetext Route39BarnTwinWereFeedingMoomooText
	waitbutton
	closetext
	turnobject ROUTE39BARN_TWIN2, LEFT
	end

MoomooScript:
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .HappyCow
	writetext MoomooWeakMooText
	setval MILTANK
	special PlaySlowCry
	promptbutton
	writetext Route39BarnItsCryIsWeakText
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .GiveBerry
	waitbutton
	closetext
	end

.GiveBerry:
	promptbutton
	writetext Route39BarnAskGiveBerryText
	yesorno
	iffalse .Refused
	checkitem BERRY
	iffalse .NoBerriesInBag
	takeitem BERRY
	readmem wMooMooBerries
	addval 1
	writemem wMooMooBerries
	ifequal 3, .ThreeBerries
	ifequal 5, .FiveBerries
	ifequal 7, .SevenBerries
	writetext Route39BarnGaveBerryText
	waitbutton
	closetext
	end

.ThreeBerries:
	writetext Route39BarnGaveBerryText
	promptbutton
	writetext Route39BarnLittleHealthierText
	waitbutton
	closetext
	end

.FiveBerries:
	writetext Route39BarnGaveBerryText
	promptbutton
	writetext Route39BarnQuiteHealthyText
	waitbutton
	closetext
	end

.SevenBerries:
	playmusic MUSIC_HEAL
	writetext Route39BarnGaveBerryText
	pause 60
	promptbutton
	special RestartMapMusic
	writetext Route39BarnTotallyHealthyText
	waitbutton
	closetext
	setevent EVENT_HEALED_MOOMOO
	end

.NoBerriesInBag:
	writetext Route39BarnNoBerriesText
	waitbutton
	closetext
	end

.Refused:
	writetext Route39BarnRefusedBerryText
	waitbutton
	closetext
	end

.HappyCow:
	writetext MoomooHappyMooText
	cry MILTANK
	waitbutton
	closetext
	end

BarnMiltank:
	farsjump Route39Miltank

Route39BarnTwinMoomooIsSickText:
if DEF(_FR_FR)
	text "MEUMEU est malade."

	para "Elle a besoin de"
	line "beaucoup de BAIES"
	cont "ORAN."
else
	text "MOOMOO is sick…"

	para "She needs lots of"
	line "ORAN BERRIES."
endc
	done

Route39BarnTwinWereFeedingMoomooText: 
if DEF(_FR_FR)
	text "On nourrit"
	line "MEUMEU!"
else
	text "We're feeding"
	line "MOOMOO!"
endc

	done

MoomooWeakMooText:
if DEF(_FR_FR)
	text "ECREMEUH: ...Meu."
else
	text "MOOMOO: …Moo…"
endc
	done

Route39BarnItsCryIsWeakText: 
if DEF(_FR_FR)
	text "Son cri est"
	line "très faible."
else
	text "Its cry is weak…"
endc

	done

MoomooHappyMooText:
if DEF(_FR_FR)
	text "ECREMEUH: MEU!"
else
	text "MOOMOO: Mooo!"
endc
	done

Route39BarnAskGiveBerryText:
if DEF(_FR_FR)
	text "Donner une BAIE"
	line "ORAN à ECREMEUH?"
else
	text "Give an ORAN BERRY"
	line "to MILTANK?"
endc
	done

Route39BarnGaveBerryText:
if DEF(_FR_FR)
	text "<PLAYER> donne une"
	line "BAIE ORAN à"
	cont "ECREMEUH."	
else
	text "<PLAYER> gave an"
	line "ORAN BERRY to"
	cont "MILTANK."
endc
	done

Route39BarnLittleHealthierText:
if DEF(_FR_FR)
	text "MEUMEU se sent"
	line "un peu mieux!"
else
	text "MOOMOO feels a"
	line "little healthier!"
endc
	done

Route39BarnQuiteHealthyText:
if DEF(_FR_FR)
	text "MEUMEU se sent"
	line "mieux!"
else
	text "MOOMOO feels a"
	line "little bit better!"
endc
	done

Route39BarnTotallyHealthyText:
if DEF(_FR_FR)
	text "MEUMEU est en"
	line "pleine forme!"
else
	text "MOOMOO feels"
	line "better!"
endc
	done

Route39BarnNoBerriesText:
if DEF(_FR_FR)
	text "<PLAYER> n'a pas"
	line "de BAIE ORAN..."
else
	text "<PLAYER> has no"
	line "ORAN BERRIES…"
endc
	done

Route39BarnRefusedBerryText:
if DEF(_FR_FR)
	text "<PLAYER> ne donne"
	line "pas de BAIE ORAN."

	para "MEUMEU est"
	line "triste."
else
	text "<PLAYER> wouldn't"
	line "give an ORAN"
	cont "BERRY."

	para "MOOMOO looks sad."
endc
	done

Route39Barn_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ROUTE_39, 1
	warp_event  4,  7, ROUTE_39, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route39BarnTwin1Script, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	object_event  4,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route39BarnTwin2Script, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	object_event  3,  3, SPRITE_MILTANK, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, MoomooScript, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	object_event  0,  4, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_VACCINE_PASS, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BarnMiltank, -1
	object_event  7,  2, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_VACCINE_PASS, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BarnMiltank, -1
	object_event  1,  1, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_VACCINE_PASS, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BarnMiltank, -1
	object_event  6,  6, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_VACCINE_PASS, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BarnMiltank, -1
