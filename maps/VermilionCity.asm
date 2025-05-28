	object_const_def
	const VERMILIONCITY_TEACHER
	const VERMILIONCITY_GRAMPS
	const VERMILIONCITY_MACHOP
	const VERMILIONCITY_SUPER_NERD
	const VERMILIONCITY_BIG_SNORLAX
	const VERMILIONCITY_POKEFAN_M

VermilionCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_VERMILION
	endcallback

VermilionCityTeacherScript:
	jumptextfaceplayer VermilionCityTeacherText

VermilionMachopOwner:
	jumptextfaceplayer VermilionMachopOwnerText

VermilionMachop:
	opentext
	writetext VermilionMachopText1
	cry MACHOP
	waitbutton
	closetext
	earthquake 30
	opentext
	writetext VermilionMachopText2
	waitbutton
	closetext
	end

VermilionCitySuperNerdScript:
	jumptextfaceplayer VermilionCitySuperNerdText

VermilionSnorlax:
	opentext
	special SnorlaxAwake
	iftrue .Awake
	writetext VermilionCitySnorlaxSleepingText
	waitbutton
	closetext
	end

.Awake:
	writetext VermilionCityRadioNearSnorlaxText
	pause 15
	cry SNORLAX
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon SNORLAX, 50
	startbattle
	disappear VERMILIONCITY_BIG_SNORLAX
	setevent EVENT_FOUGHT_SNORLAX
	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
	reloadmapafterbattle
	end

VermilionGymBadgeGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_HP_UP_FROM_VERMILION_GUY
	iftrue .AlreadyGotItem
	readvar VAR_BADGES
	ifequal NUM_BADGES, .AllBadges
	ifgreater 13, .MostBadges
	ifgreater 9, .SomeBadges
	writetext VermilionCityBadgeGuyTrainerText
	waitbutton
	closetext
	end

.SomeBadges:
	writetext VermilionCityBadgeGuySomeBadgesText
	waitbutton
	closetext
	end

.MostBadges:
	writetext VermilionCityBadgeGuyMostBadgesText
	waitbutton
	closetext
	end

.AllBadges:
	writetext VermilionCityBadgeGuyAllBadgesText
	promptbutton
	verbosegiveitem PP_UP, 10
	iffalse .Done
	setevent EVENT_GOT_HP_UP_FROM_VERMILION_GUY
.AlreadyGotItem:
	writetext VermilionCityBadgeGuyBattleEdgeText
	waitbutton
.Done:
	closetext
	end

VermilionSnorlaxGuy:
	faceplayer
	checkevent EVENT_VERMILION_CITY_SNORLAX
	iftrue .snorlaxBeaten

	jumptext VermilionSnorlaxGuyBeforeBattleText

.snorlaxBeaten
	jumptext VermilionSnorlaxGuyAfterBattleText

VermilionGymBlocker:
	jumptextfaceplayer VermilionGymBlockerText

VermilionCitySign:
	jumptext VermilionCitySignText

VermilionGymSign:
	jumptext VermilionGymSignText

PokemonFanClubSign:
	jumptext PokemonFanClubSignText

VermilionCityDiglettsCaveSign:
	jumptext VermilionCityDiglettsCaveSignText

VermilionCityPortSign:
	jumptext VermilionCityPortSignText

VermilionCityPokecenterSign:
	jumpstd PokecenterSignScript

VermilionCityMartSign:
	jumpstd MartSignScript

VermilionCityHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL

VermilionCityTeacherText: 
if DEF(_FR_FR)
	text "Le PORT de CARMIN"
	line "est la porte de"
	cont "KANTO vers"
	cont "l'océan."

	para "De magnifiques"
	line "paquebots du monde"
	cont "entier viennent y"
	cont "jeter l'ancre."
else
	text "VERMILION PORT is"
	line "KANTO's seaside"
	cont "gateway."

	para "Luxury liners from"
	line "around the world"
	cont "dock here."
endc

	done

VermilionMachopOwnerText: ; TO TRANSLATE
	text "My #MON is"
	line "preparing the land"
	cont "for construction."

	para "The project was"
	line "already running"
	cont "late, but because"
	cont "of the pandemic,"
	cont "it has been"
	cont "delayed even"
	cont "more."

	para "I wonder if it is"
	line "ever going to be"
	cont "finished…"
	done

VermilionMachopText1: 
if DEF(_FR_FR)
	text "MACHOC: Maaaa!"
	line "Choc!"
else
	text "MACHOP: Guooh"
	line "gogogoh!"
endc

	done

VermilionMachopText2: 
if DEF(_FR_FR)
	text "Un MACHOC grogne"
	line "en aplatissant le"
	cont "sol."
else
	text "A MACHOP is growl-"
	line "ing while stomping"
	cont "the ground flat."
endc

	done

VermilionCitySuperNerdText: ; TO TRANSLATE
	text "There are eight"
	line "GYMS in KANTO."

	para "GYM LEADERS use a"
	line "POWER RESTRAINER"
	cont "to lower the level"
	cont "of their #MON"
	cont "up to yours."

	para "It's basically"
	line "adding weights"
	cont "onto their #MON"
	
	para "… you already"
	line "knew about it?"

	para "It's the same"
	line "as in JOHTO?"
	cont "Fascinating!"
	done

VermilionCitySnorlaxSleepingText: 
if DEF(_FR_FR)
	text "RONFLEX ronfle"
	line "paisiblement..."
else
	text "SNORLAX is snoring"
	line "peacefully…"
endc

	done

VermilionCityRadioNearSnorlaxText: 
if DEF(_FR_FR)
	text "Le #MATOS est"
	line "placé près de"
	cont "l'oreille du"
	cont "RONFLEX."

	para "..."

	para "RONFLEX se"
	line "réveille!"
else
	text "The #GEAR was"
	line "placed near the"
	cont "sleeping SNORLAX…"

	para "…"

	para "SNORLAX woke up!"
endc

	done

VermilionCityBadgeGuyTrainerText: 
if DEF(_FR_FR)
	text "Les bons dresseurs"
	line "viennent à KANTO."

	para "Les CHAMPIONS"
	line "d'ARENE sont spé-"
	cont "cialement forts."

	para "Ce ne sera pas"
	line "facile de les"
	cont "battre."
else
	text "Skilled trainers"
	line "gather in KANTO."

	para "GYM LEADERS are"
	line "especially strong."

	para "They won't be easy"
	line "to defeat."
endc

	done

VermilionCityBadgeGuySomeBadgesText: 
if DEF(_FR_FR)
	text "Tu as commencé à"
	line "collectionner les"
	cont "BADGES de KANTO?"

	para "Tu ne trouves pas"
	line "que les dresseurs"
	cont "du coin sont"
	cont "super forts?"
else
	text "You've started to"
	line "collect KANTO GYM"
	cont "BADGES?"

	para "Don't you agree"
	line "that the trainers"
	cont "here are tough?"
endc

	done

VermilionCityBadgeGuyMostBadgesText: 
if DEF(_FR_FR)
	text "Je pense que tu"
	line "termineras bientôt"

	para "ta conquête des"
	line "ARENES de KANTO."

	para "Préviens-moi si"
	line "tu gagnes les huit"
	cont "BADGES."
else
	text "I guess you'll be"
	line "finished with your"

	para "conquest of KANTO"
	line "GYMS soon."

	para "Let me know if"
	line "you get all eight"
	cont "BADGES."
endc

	done

VermilionCityBadgeGuyAllBadgesText: 
if DEF(_FR_FR)
	text "Félicitations!"

	para "Tu as tous les"
	line "BADGES des ARENES"
	cont "de KANTO!"

	para "Voilà une petite"
	line "récompense."
else
	text "Congratulations!"

	para "You got all the"
	line "KANTO GYM BADGES."

	para "I've got a reward"
	line "for your efforts."
endc

	done

VermilionCityBadgeGuyBattleEdgeText: 
if DEF(_FR_FR)
	text "Avoir des #MON"
	line "de types diffé-"

	para "rents donne"
	line "l'avantage en"
	cont "combat."

	para "Les BADGES de KAN-"
	line "TO t'aideront,"
	cont "j'en suis sûr."
else
	text "Having a variety"
	line "of #MON types"

	para "should give you an"
	line "edge in battle."

	para "I'm sure the KANTO"
	line "GYM BADGES will"
	cont "help you."
endc

	done

VermilionCitySignText: 
if DEF(_FR_FR)
	text "CARMIN SUR MER"

	para "Le port aux cou-"
	line "chers de soleil"
else
	text "VERMILION CITY"

	para "The Port of"
	line "Exquisite Sunsets"
endc

	done

VermilionGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "de CARMIN SUR MER:"
	cont "MAJOR BOB"

	para "L'Américain"
	line "survolté"
else
	text "VERMILION CITY"
	line "#MON GYM"
	cont "LEADER: LT.SURGE"

	para "The Lightning"
	line "American"
endc

	done

PokemonFanClubSignText: 
if DEF(_FR_FR)
	text "FAN CLUB #MON"

	para "Fans de #MON"
	line "bienvenus!"
else
	text "#MON FAN CLUB"

	para "All #MON Fans"
	line "Welcome!"
endc

	done

VermilionCityDiglettsCaveSignText: 
if DEF(_FR_FR)
	text "CAVE TAUPIQUEUR"
else
	text "DIGLETT'S CAVE"
endc

	done

VermilionCityPortSignText: 
if DEF(_FR_FR)
	text "PORT de CARMIN"
	line "ENTREE"
else
	text "VERMILION PORT"
	line "ENTRANCE"
endc

	done

VermilionGymBlockerText: ; TO TRANSLATE
	text "LT.SURGE went to"
	line "give a hand at the"
	cont "POWER PLANT."

	para "I've heard his"
	line "#MON are provi-"
	cont "ding enough elec-"
	cont "tricity for a"
	cont "whole town!"
	done

VermilionSnorlaxGuyBeforeBattleText: ; TO TRANSLATE
	text "This SNORLAX has"
	line "been laying here"
	cont "for months."

	para "Exhaustion is one"
	line "of the symptoms"
	cont "of COVID…"

	para "I'm too afraid"
	line "to approach it."
	done

VermilionSnorlaxGuyAfterBattleText: ; TO TRANSLATE
	text "So in the end the"
	line "SNORLAX was just"
	cont "being lazy?"
	
	para "That makes sense"
	line "I guess."
	done

VermilionCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, VERMILION_FISHING_SPEECH_HOUSE, 1
	warp_event  9,  5, VERMILION_POKECENTER_1F, 1
	warp_event  7, 13, POKEMON_FAN_CLUB, 1
	warp_event 13, 13, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, 1
	warp_event 21, 13, VERMILION_MART, 2
	warp_event 21, 17, VERMILION_DIGLETTS_CAVE_SPEECH_HOUSE, 1
	warp_event 10, 19, VERMILION_GYM, 1
	warp_event 19, 31, VERMILION_PORT_PASSAGE, 1
	warp_event 20, 31, VERMILION_PORT_PASSAGE, 2
	warp_event 34,  7, DIGLETTS_CAVE, 1

	def_coord_events

	def_bg_events
	bg_event 25,  3, BGEVENT_READ, VermilionCitySign
	bg_event  5, 19, BGEVENT_READ, VermilionGymSign
	bg_event  5, 13, BGEVENT_READ, PokemonFanClubSign
	bg_event 33,  9, BGEVENT_READ, VermilionCityDiglettsCaveSign
	bg_event 27, 15, BGEVENT_READ, VermilionCityPortSign
	bg_event 10,  5, BGEVENT_READ, VermilionCityPokecenterSign
	bg_event 22, 13, BGEVENT_READ, VermilionCityMartSign
	bg_event 12, 19, BGEVENT_ITEM, VermilionCityHiddenFullHeal

	def_object_events
	object_event 18,  9, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionCityTeacherScript, -1
	object_event 23,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionMachopOwner, -1
	object_event 26,  7, SPRITE_MACHOP, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VermilionMachop, -1
	object_event 14, 16, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VermilionCitySuperNerdScript, -1
	object_event 34,  8, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_BIGDOLLSYM, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, VermilionSnorlax, EVENT_VERMILION_CITY_SNORLAX
	object_event 31, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VermilionGymBadgeGuy, -1
	object_event 10, 20, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionGymBlocker, EVENT_RESTORED_POWER_TO_KANTO
	object_event 35, 14, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionSnorlaxGuy, -1
