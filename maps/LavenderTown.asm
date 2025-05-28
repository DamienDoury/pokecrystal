	object_const_def
	const LAVENDERTOWN_POKEFAN_M
	const LAVENDERTOWN_TEACHER
	const LAVENDERTOWN_GRAMPS
	const LAVENDERTOWN_YOUNGSTER

LavenderTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setevent EVENT_AMPHY_BURIAL_CEREMONY_IN_PROGRESS
	
	checkflag ENGINE_FLYPOINT_LAVENDER
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_LAVENDER
	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
	
	readmem wYearMonth
	addval 1
	writemem wYearMonth
.endcallback
	endcallback

LavenderTownPokefanMScript:
	jumptextfaceplayer LavenderTownPokefanMText

LavenderTownTeacherScript:
	jumptextfaceplayer LavenderTownTeacherText

LavenderTownGrampsScript:
	jumptextfaceplayer LavenderTownGrampsText

LavenderTownYoungsterScript:
	jumptextfaceplayer LavenderTownYoungsterText

LavenderTownPasserby1Script:
	jumptextfaceplayer LavenderTownPasserby1Text

LavenderTownPasserby2Script:
	jumptextfaceplayer LavenderTownPasserby2Text

LavenderTownPasserby3Script:
	jumptextfaceplayer LavenderTownPasserby3Text

LavenderTownPasserby4Script:
	jumptextfaceplayer LavenderTownPasserby4Text

LavenderTownPasserby5Script:
	jumptextfaceplayer LavenderTownPasserby5Text

LavenderTownSign:
	jumptext LavenderTownSignText

KantoRadioStationSign:
	jumptext KantoRadioStationSignText

VolunteerPokemonHouseSign:
	jumptext VolunteerPokemonHouseSignText

SoulHouseSign:
	jumptext SoulHouseSignText

LavenderPokecenterSignText:
	jumpstd PokecenterSignScript

LavenderMartSignText:
	jumpstd MartSignScript

LavenderTownPokefanMText: 
if DEF(_FR_FR)
	text "Quel bâtiment,"
	line "hein?"

	para "C'est la TOUR"
	line "RADIO de KANTO."
else
	text "That's quite some"
	line "building, eh?"

	para "It's KANTO's RADIO"
	line "TOWER."
endc

	done

LavenderTownTeacherText: 
if DEF(_FR_FR)
	text "KANTO a beaucoup"
	line "d'émissions radio."
else
	text "KANTO has many"
	line "good radio shows."
endc

	done

LavenderTownGrampsText: 
if DEF(_FR_FR)
	text "Les gens viennent"
	line "de loin pour sa-"

	para "luer le départ des"
	line "âmes des pauvres"
	cont "#MON."
else
	text "People come from"
	line "all over to pay"

	para "their respects to"
	line "the departed souls"
	cont "of #MON."
endc

	done

LavenderTownYoungsterText: 
if DEF(_FR_FR)
	text "Il faut une #"
	line "FLUTE pour réveil-"
	cont "ler un #MON."

	para "Tout le monde sait"
	line "ça, voyons!"
else
	text "You need a #"
	line "FLUTE to wake"
	cont "sleeping #MON."

	para "Every trainer has"
	line "to know that!"
endc

	done

LavenderTownSignText: 
if DEF(_FR_FR)
	text "LAVANVILLE"

	para "La ville d'un"
	line "pourpre royal"
else
	text "LAVENDER TOWN"

	para "The Noble Purple"
	line "Town"
endc

	done

KantoRadioStationSignText: 
if DEF(_FR_FR)
	text "STATION de RADIO"
	line "de KANTO"

	para "Vos émissions"
	line "favorites!"
else
	text "KANTO RADIO"
	line "STATION"

	para "Your Favorite"
	line "Programs On-Air"
	cont "Around the Clock!"
endc

	done

VolunteerPokemonHouseSignText: 
if DEF(_FR_FR)
	text "BENEVOLAT de"
	line "LAVANVILLE"
else
	text "LAVENDER VOLUNTEER"
	line "#MON HOUSE"
endc

	done

SoulHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DES AMES"

	para "Que les âmes des"
	line "#MON reposent"
	cont "en paix"
else
	text "SOUL HOUSE"

	para "May the Souls of"
	line "#MON Rest Easy"
endc

	done

LavenderTownPasserby1Text: ; TO TRANSLATE
	text "CAPTAIN: He'd been"
	line "guiding my ship"
	cont "for decades in"
	cont "OLIVINE port…"
	done

LavenderTownPasserby2Text: ; TO TRANSLATE
	text "I'm going to head"
	line "back home now…"
	done

LavenderTownPasserby3Text: ; TO TRANSLATE
	text "I've known him"
	line "since I was"
	cont "a kid."
	
	para "He was a symbol, a"
	line "light in the dark."
	done

LavenderTownPasserby4Text: ; TO TRANSLATE
	text "I hope JASMINE"
	line "is feeling ok…"
	done

LavenderTownPasserby5Text: ; TO TRANSLATE
	text "You missed the"
	line "ceremony, it just"
	cont "ended."
	
	para "It was beautiful."

	para "People came from"
	line "far away to pay"
	
	para "their respects to"
	line "this well-known"
	cont "#MON."
	done

LavenderTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, LAVENDER_POKECENTER_1F, 1
	warp_event  5,  9, MR_FUJIS_HOUSE, 1
	warp_event  3, 13, LAVENDER_SPEECH_HOUSE, 1
	warp_event  7, 13, LAVENDER_NAME_RATER, 1
	warp_event  1,  5, LAVENDER_MART, 2
	warp_event 13, 11, SOUL_HOUSE, 1
	warp_event 14,  5, LAV_RADIO_TOWER_1F, 1

	def_coord_events

	def_bg_events
	bg_event  9,  5, BGEVENT_READ, LavenderTownSign
	bg_event 15,  7, BGEVENT_READ, KantoRadioStationSign
	bg_event  3,  9, BGEVENT_READ, VolunteerPokemonHouseSign
	bg_event 15, 13, BGEVENT_READ, SoulHouseSign
	bg_event  6,  5, BGEVENT_READ, LavenderPokecenterSignText
	bg_event  2,  5, BGEVENT_READ, LavenderMartSignText

	def_object_events
	object_event 12,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavenderTownPokefanMScript, -1
	object_event  2, 15, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, LavenderTownTeacherScript, -1
	object_event 14, 12, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavenderTownGrampsScript, -1
	object_event  6, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 1, LavenderTownYoungsterScript, -1
	object_event  7,  6, SPRITE_CAPTAIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, LavenderTownPasserby1Script, EVENT_AMPHY_BURIAL_CEREMONY_JUST_FINISHED
	object_event  9,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, LavenderTownPasserby3Script, EVENT_AMPHY_BURIAL_CEREMONY_JUST_FINISHED
	object_event  8,  5, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, LavenderTownPasserby5Script, EVENT_AMPHY_BURIAL_CEREMONY_JUST_FINISHED
	object_event  9,  9, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, LavenderTownPasserby4Script, EVENT_JASMINE_AT_SOUL_HOUSE
	object_event 15, 15, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavenderTownPasserby2Script, EVENT_JASMINE_AT_SOUL_HOUSE
