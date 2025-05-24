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

Route39BarnTwinMoomooIsSickText: ; TO TRANSLATE
	text "MOOMOO is sick…"

	para "She needs lots of"
	line "ORAN BERRIES."
	done

Route39BarnTwinWereFeedingMoomooText: ; AUTOTRAD
	text "We're feeding"
	line "MOOMOO!"
	done

MoomooWeakMooText: ; TO TRANSLATE
	text "MOOMOO: …Moo…"
	done

Route39BarnItsCryIsWeakText: ; AUTOTRAD
	text "Its cry is weak…"
	done

MoomooHappyMooText: ; TO TRANSLATE
	text "MOOMOO: Mooo!"
	done

Route39BarnAskGiveBerryText: ; TO TRANSLATE
	text "Give an ORAN BERRY"
	line "to MILTANK?"
	done

Route39BarnGaveBerryText: ; TO TRANSLATE
	text "<PLAYER> gave an"
	line "ORAN BERRY to"
	cont "MILTANK."
	done

Route39BarnLittleHealthierText: ; TO TRANSLATE
	text "MOOMOO feels a"
	line "little healthier!"
	done

Route39BarnQuiteHealthyText: ; TO TRANSLATE
	text "MOOMOO feels a"
	line "little bit better!"
	done

Route39BarnTotallyHealthyText: ; TO TRANSLATE
	text "MOOMOO feels"
	line "better!"
	done

Route39BarnNoBerriesText: ; TO TRANSLATE
	text "<PLAYER> has no"
	line "ORAN BERRIES…"
	done

Route39BarnRefusedBerryText: ; TO TRANSLATE
	text "<PLAYER> wouldn't"
	line "give an ORAN"
	cont "BERRY."

	para "MOOMOO looks sad."
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
