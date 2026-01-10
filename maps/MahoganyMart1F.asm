	object_const_def
	const MAHOGANYMART1F_PHARMACIST
	const MAHOGANYMART1F_VP_CONTROLLER
	const MAHOGANYMART1F_BLACK_BELT
	const MAHOGANYMART1F_LANCE
	const MAHOGANYMART1F_DRAGONITE
	const MAHOGANYMART1F_GRANNY

MahoganyMart1F_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_MAHOGANYMART1F_NOTHING
	scene_script .LanceUncoversStaircase ; SCENE_MAHOGANYMART1F_LANCE_UNCOVERS_STAIRS

	def_callbacks
	callback MAPCALLBACK_TILES, .MahoganyMart1FStaircase

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

.LanceUncoversStaircase:
	prioritysjump MahoganyMart1FLanceUncoversStaircaseScript
	end

.MahoganyMart1FStaircase:
	checkevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	iftrue .ShowStairs
	endcallback

.ShowStairs:
	changeblock 6, 2, $1e ; stairs
	endcallback

MahoganyMart1FPharmacistScript:
	faceplayer
	opentext
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue .LanceEntered
	pokemart MARTTYPE_STANDARD, MART_MAHOGANY_1
	closetext
	end

.LanceEntered:
	writetext MahoganyMart1FPharmacistText_LanceEntered
	waitbutton
	closetext
	end

MahoganyMart1FBlackBeltScript:
	faceplayer
	opentext
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue .LanceEntered
	writetext MahoganyMart1FBlackBeltText
	waitbutton
	closetext
	end

.LanceEntered:
	writetext MahoganyMart1FBlackBeltText_LanceEntered
	waitbutton
	closetext
	end

MahoganyMart1FLanceUncoversStaircaseScript:
	pause 15
	opentext
	writetext MahoganyMart1FLanceDragoniteStrengthText
	pause 30
	closetext
	playsound SFX_STRENGTH
	applymovement MAHOGANYMART1F_DRAGONITE, MahoganyMart1FDragoniteTackleMovement
	applymovement MAHOGANYMART1F_BLACK_BELT, MahoganyMart1FBlackBeltKnockedBackMovement
	pause 15
	disappear MAHOGANYMART1F_DRAGONITE
	pause 15
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceApproachPlayerMovement
	applymovement PLAYER, MahoganyMart1FPlayerApproachesLanceMovement
	pause 15
	turnobject MAHOGANYMART1F_LANCE, DOWN
	pause 10
	opentext
	writetext MahoganyMart1FLanceRadioText
	waitbutton
	closetext
	follow MAHOGANYMART1F_LANCE, PLAYER
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceApproachPharmacistMovement
	applymovement MAHOGANYMART1F_PHARMACIST, MahoganyMart1FPharmacistShovedAsideMovement
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceApproachHiddenStairsMovement
	stopfollow
	opentext
	writetext MahoganyMart1FLanceStairsText
	waitbutton
	showemote EMOTE_SHOCK, MAHOGANYMART1F_PHARMACIST, 10
	playsound SFX_FAINT
	changeblock 6, 2, $1e ; stairs
	reloadmappart
	closetext
	setevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	turnobject MAHOGANYMART1F_LANCE, LEFT
	opentext
	writetext MahoganyMart1FLanceSplitUpText
	waitbutton
	closetext
	applymovement MAHOGANYMART1F_LANCE, MahoganyMart1FLanceGoDownStairsMovement
	playsound SFX_EXIT_BUILDING
	disappear MAHOGANYMART1F_LANCE
	setscene SCENE_MAHOGANYMART1F_NOTHING
	waitsfx
	readmem wYearMonth
	addval 1
	writemem wYearMonth
	end

MahoganyMart1FGrannyScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_MAHOGANY_2
	closetext
	end

MahoganyMart1FDragoniteTackleMovement:
	fix_facing
	big_step LEFT
	big_step RIGHT
	remove_fixed_facing
	step_end

MahoganyMart1FBlackBeltKnockedBackMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	step_end

MahoganyMart1FPharmacistShovedAsideMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	step_end

MahoganyMart1FLanceApproachPlayerMovement:
	slow_step UP
	step_end

MahoganyMart1FPlayerApproachesLanceMovement:
	step RIGHT
	turn_head UP
	step_end

MahoganyMart1FLanceApproachPharmacistMovement:
	slow_step UP
	step_end

MahoganyMart1FLanceApproachHiddenStairsMovement:
	slow_step UP
	slow_step UP
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	turn_head DOWN
	step_end

MahoganyMart1FLanceGoDownStairsMovement:
	slow_step DOWN
	step_end

MahoganyMart1FPharmacistText_LanceEntered: 
if DEF(_FR_FR)
	text "Graaah... Tu as"
	line "trouvé l'escalier"
	cont "secret!"
else
	text "Arrgh… You found"
	line "the secret stair-"
	cont "way…"
endc

	done

MahoganyMart1FBlackBeltText:
if DEF(_FR_FR)
	text "Héhé! L'expérience"
	line "a marché comme sur"
	cont "des roulettes!"

	para "Le signal est émis"
	line "sur une longue"
	cont "distance!"

	para "Le problème des"
	line "MAGICARPE n'est"
	cont "qu'un dommage"
	cont "collatéral."
else
	text "Heheh! The experi-"
	line "ment worked like a"
	cont "charm."

	para "The signal is"
	line "emitting"

	para "over a great"
	line "distance!"

	para "The MAGIKARP side-"
	line "issue is no"
	cont "big deal."
endc
	done

MahoganyMart1FBlackBeltText_LanceEntered: 
if DEF(_FR_FR)
	text "Gueuhhh..."

	para "Les #MON dragon"
	line "de ce type sont"
	cont "super forts..."
else
	text "Urrgh…"

	para "That guy's dragon"
	line "#MON are tough…"
endc

	done

MahoganyMart1FLanceDragoniteStrengthText:
if DEF(_FR_FR)
	text "PETER: DRACOLOSSE,"
	line "lance FORCE!"
else
	text "LANCE: DRAGONITE,"
	line "use STRENGTH!"
endc
	done

MahoganyMart1FLanceRadioText: 
if DEF(_FR_FR)
	text "Tu en as mis du"
	line "temps, <PLAY_G>!"

	para "Comme je le pen-"
	line "sais, cet étrange"

	para "signal radio vient"
	line "d'ici."
else
	text "What took you,"
	line "<PLAY_G>?"

	para "Just as I thought,"
	line "that strange radio"

	para "signal is coming"
	line "from here."
endc

	done

MahoganyMart1FLanceStairsText: 
if DEF(_FR_FR)
	text "Les escaliers sont"
	line "par ici."
else
	text "The stairs are"
	line "right here."
endc

	done

MahoganyMart1FLanceSplitUpText: 
if DEF(_FR_FR)
	text "PETER: <PLAY_G>,"
	line "nous ferions mieux"

	para "de nous séparer."
	line "Je passe en"
	cont "premier."
else
	text "LANCE: <PLAY_G>, we"
	line "should split up to"

	para "check this place."
	line "I'll go first."
endc

	done

MahoganyMart1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, MAHOGANY_TOWN, 1
	warp_event  4,  7, MAHOGANY_TOWN, 1
	warp_event  7,  3, TEAM_ROCKET_BASE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMart1FPharmacistScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  5,  7, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  1,  6, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMart1FBlackBeltScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  6, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	object_event  3,  6, SPRITE_DRAGON, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	object_event  1,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMart1FGrannyScript, EVENT_MAHOGANY_MART_OWNERS
