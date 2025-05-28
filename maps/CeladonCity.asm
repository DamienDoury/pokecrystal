	object_const_def
	const CELADONCITY_FISHER
	const CELADONCITY_POLIWAG
	const CELADONCITY_TEACHER1
	const CELADONCITY_GRAMPS1
	const CELADONCITY_GRAMPS2
	const CELADONCITY_YOUNGSTER1
	const CELADONCITY_YOUNGSTER2
	const CELADONCITY_TEACHER2
	const CELADONCITY_LASS

CeladonCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TurnOffLights

.FlyPoint:
	setflag ENGINE_FLYPOINT_CELADON
	endcallback

.TurnOffLights
	checkevent EVENT_RED_IN_MT_SILVER
	iftrue .EndCallback

	; Turns off the lights of the game corner.
	changeblock 16, 18, $70
	changeblock 18, 18, $4b
	changeblock 20, 18, $33
	changeblock 22, 18, $9
	changeblock 24, 18, $33

.EndCallback
	endcallback

CeladonCityFisherScript:
	jumptextfaceplayer CeladonCityFisherText

CeladonCityPoliwrath:
	opentext
	writetext CeladonCityPoliwrathText
	cry POLIWHIRL
	waitbutton
	closetext
	end

CeladonCity_CasinoDoorScript:
	jumptext CeladonCity_CasinoDoorText

CeladonCityTeacher1Script:
	jumptextfaceplayer CeladonCityTeacher1Text

CeladonCityGramps1Script:
	jumptextfaceplayer CeladonCityGramps1Text

CeladonCityGramps2Script:
	jumptextfaceplayer CeladonCityGramps2Text

CeladonCityYoungster1Script:
	jumptextfaceplayer CeladonCityYoungster1Text

CeladonCityYoungster2Script:
	jumptextfaceplayer CeladonCityYoungster2Text

CeladonCityTeacher2Script:
	readmem wCurFreedomState
	ifequal 1 << VACCINE_PASSPORT, .vaccine_passport

	jumptextfaceplayer CeladonCityTeacher2TextBis

.vaccine_passport
	jumptextfaceplayer CeladonCityTeacher2Text

CeladonCityLassScript:
	jumptextfaceplayer CeladonCityLassText

CeladonCitySign:
	jumptext CeladonCitySignText

CeladonGymSign:
	jumptext CeladonGymSignText

CeladonCityDeptStoreSign:
	jumptext CeladonCityDeptStoreSignText

CeladonCityMansionSign:
	jumptext CeladonCityMansionSignText

CeladonCityGameCornerSign:
	jumptext CeladonCityGameCornerSignText

CeladonCityTrainerTips:
	jumptext CeladonCityTrainerTipsText

CeladonCityBedStore:
	jumptext CeladonCityBedStoreText

CeladonCityPokecenterSign:
	jumpstd PokecenterSignScript

CeladonCityHiddenPpUp:
	hiddenitem PP_UP, EVENT_CELADON_CITY_HIDDEN_PP_UP

CeladonCityFisherText: ; TO TRANSLATE
	text "This POLIWHIRL is"
	line "my partner."

	para "I wonder if it'll"
	line "ever evolve into a"
	cont "frog #MON."
	done

CeladonCityPoliwrathText: ; TO TRANSLATE
	text "POLIWHIRL: Croak!"
	done

CeladonCityTeacher1Text: ; TO TRANSLATE
	text "My forehead is"
	line "sore…"

	para "I tried to"
	line "HEADBUTT a small"
	cont "tree over there."

	para "A #MON fell"
	line "from it!"

	para "You don't believe?"
	line "Try it yourself!"
	done

CeladonCityGramps1Text: ; TO TRANSLATE
	text "Where did all"
	line "those GRIMER"
	cont "come from?"

	para "This is a serious"
	line "problem…"
	done

CeladonCityGramps2Text: 
if DEF(_FR_FR)
	text "Hihi! Cette ARENE"
	line "est géniale! C'est"

	para "réservé aux"
	line "filles! Youpi!"
else
	text "Nihihi! This GYM"
	line "is great! Only"

	para "girls are allowed"
	line "here!"
endc

	done

CeladonCityYoungster1Text: 
if DEF(_FR_FR)
	text "Tu veux connaître"
	line "un secret?"

	para "Le MANOIR CELADON"
	line "a une porte cachée"
	cont "à l'arrière."
else
	text "Want to know a"
	line "secret?"

	para "CELADON MANSION"
	line "has a hidden back"
	cont "door."
endc

	done

CeladonCityYoungster2Text: ; TO TRANSLATE
	text "This is the grand"
	line "re-opening of"
	cont "the restaurant."

	para "It was closed"
	line "during the"
	cont "lockdown."
	done

CeladonCityTeacher2Text: ; TO TRANSLATE
	text "CELADON DEPT.STORE"
	line "just recently"
	cont "fully re-opened."

	para "Though entry is"
	line "conditioned on"
	cont "being vaccinated."
	done

CeladonCityTeacher2TextBis: ; TO TRANSLATE
	text "I'll never get"
	line "vaccinated. It's"
	cont "my choice."
	done

CeladonCityLassText: ; TO TRANSLATE
	text "My boyfriend said"
    line "he would dump me"
    
    para "if I didn't get"
    line "vaccinated."
    
    para "Too bad, I kinda"
	line "liked him."
    done

CeladonCitySignText: 
if DEF(_FR_FR)
	text "CELADOPOLE"

	para "La ville aux rêves"
	line "arc-en-ciel"
else
	text "CELADON CITY"

	para "The City of"
	line "Rainbow Dreams"
endc

	done

CeladonGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "de CELADOPOLE:"
	cont "ERIKA"

	para "La princesse de"
	line "la nature"
else
	text "CELADON CITY"
	line "#MON GYM"
	cont "LEADER: ERIKA"

	para "The Nature-Loving"
	line "Princess"
endc

	done

CeladonCityDeptStoreSignText: 
if DEF(_FR_FR)
	text "Y'a de tout au"
	line "CENTRE COMMERCIAL"
	cont "de CELADOPOLE!"
else
	text "Find What You"
	line "Need at CELADON"
	cont "DEPT.STORE!"
endc

	done

CeladonCityMansionSignText: 
if DEF(_FR_FR)
	text "MANOIR CELADON"
else
	text "CELADON MANSION"
endc

	done

CeladonCityGameCornerSignText:
if DEF(_CRYSTAL_AU)
	text "The Game Area for"
	line "Grown-ups--CELADON"
	cont "GAME CORNER"
	done
else
	text "The Playground for"
	line "Everybody--CELADON"
	cont "GAME CORNER"
	done
endc

CeladonCityTrainerTipsText: ; TO TRANSLATE
	text "TRAINER TIPS"

	para "GUARD SPEC."
	line "protects #MON"

	para "from stats reduc-"
	line "tion from your"
	cont "opponent."

	para "Get your items at"
	line "CELADON DEPT."
	cont "STORE!"
	done

CeladonCityBedStoreText: ; TO TRANSLATE
	text "BED STORE"
	done

CeladonCity_CasinoDoorText: ; TO TRANSLATE
	text "“Our entertainment"
	line "establishement is"
	cont "not yet allowed"
	cont "to re-open."
	
	para "We are looking"
	line "forward to seeing"
	cont "you at CELADON"
	cont "GAME CORNER!”"
	done

CeladonCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  9, CELADON_DEPT_STORE_1F, 1
	warp_event 16,  9, CELADON_MANSION_1F, 1
	warp_event 16,  3, CELADON_MANSION_1F, 3
	warp_event 17,  3, CELADON_MANSION_1F, 3
	warp_event 29,  9, CELADON_POKECENTER_1F, 1
	warp_event 18, 19, CELADON_GAME_CORNER, 1
	warp_event 23, 19, CELADON_GAME_CORNER_PRIZE_ROOM, 1
	warp_event 10, 29, CELADON_GYM, 1
	warp_event 25, 29, CELADON_CAFE, 1
	warp_event 33, 19, BED_SHOP, 1
	warp_event 13, 33, EUSINE_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 23, 21, BGEVENT_READ, CeladonCitySign
	bg_event 11, 31, BGEVENT_READ, CeladonGymSign
	bg_event  6,  9, BGEVENT_READ, CeladonCityDeptStoreSign
	bg_event 13,  9, BGEVENT_READ, CeladonCityMansionSign
	bg_event 19, 21, BGEVENT_READ, CeladonCityGameCornerSign
	bg_event 29, 21, BGEVENT_READ, CeladonCityTrainerTips
	bg_event 33, 21, BGEVENT_READ, CeladonCityBedStore
	bg_event 30,  9, BGEVENT_READ, CeladonCityPokecenterSign
	bg_event 37, 21, BGEVENT_ITEM, CeladonCityHiddenPpUp

	def_object_events
	object_event 26, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityFisherScript, -1
	object_event 27, 11, SPRITE_POLIWHIRL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_ICON_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonCityPoliwrath, -1
	object_event 33, 24, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonCityTeacher1Script, -1
	object_event 14, 16, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CeladonCityGramps1Script, -1
	object_event  8, 31, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonCityGramps2Script, -1
	object_event 18, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonCityYoungster1Script, -1
	object_event 24, 33, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityYoungster2Script, -1
	object_event  6, 14, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityTeacher2Script, -1
	object_event  7, 22, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonCityLassScript, -1
	object_event 18, 19, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCity_CasinoDoorScript, EVENT_RED_IN_MT_SILVER
	object_event 23, 19, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCity_CasinoDoorScript, EVENT_RED_IN_MT_SILVER
