	object_const_def
	const CERULEANCITY_COOLTRAINER_M
	const CERULEANCITY_SUPER_NERD
	const CERULEANCITY_SLOWBRO
	const CERULEANCITY_COOLTRAINER_F
	const CERULEANCITY_FISHER
	const CERULEANCITY_YOUNGSTER
	const CERULEANCITY_DETECTIVE
	const CERULEANCITY_SQUIRTLE
	const CERULEANCITY_DETECTIVE2
	const CERULEANCITY_SQUIRTLE2
	const CERULEANCITY_YOUNGSTER2
	const CERULEANCITY_YOUNGSTER3
	const CERULEANCITY_BUGCATCHER
	const CERULEANCITY_LASS
	const CERULEANCITY_ITEM
	const CERULEANCITY_DETECTIVE3
	const CERULEANCITY_SQUIRTLE3
	const CERULEANCITY_ROCKET
	const CERULEANCITY_DETECTIVE4
	const CERULEANCITY_DETECTIVE5
	const CERULEANCITY_SQUIRTLE4

CeruleanCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	checkevent EVENT_CERULEAN_HOUSE_ROCKET
	iffalse .ShowNorthJenny

	checkevent EVENT_ROCKET_THIEF_CERULEAN_CITY_GARDEN
	iftrue .JennyConditionalDisplayDone

.ShowNorthJenny:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.JennyConditionalDisplayDone:
	readvar VAR_YCOORD
	ifgreater 30, .end
	
	checkflag ENGINE_FLYPOINT_CERULEAN
	iftrue .end

	setflag ENGINE_FLYPOINT_CERULEAN
	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
.end
	endcallback

CeruleanCityCooltrainerMScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext CeruleanCityCooltrainerMText1
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext CeruleanCityCooltrainerMText2
	waitbutton
	closetext
	end

CeruleanCitySuperNerdScript:
	jumptextfaceplayer CeruleanCitySuperNerdText

CeruleanCitySlowbro:
	opentext
	writetext CeruleanCitySlowbroText
	cry SLOWBRO
	waitbutton
	closetext
	end

CeruleanCityCooltrainerFScript:
	faceplayer
	opentext
	writetext CeruleanCityCooltrainerFText1
	waitbutton
	closetext
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT ; Damien
	opentext
	writetext CeruleanCityCooltrainerFText2
	waitbutton
	closetext
	pause 30 ; Damien
	showemote EMOTE_QUESTION, CERULEANCITY_SLOWBRO, 15
	opentext
	writetext CeruleanCitySlowbroText
	cry SLOWBRO
	waitbutton
	closetext
	turnobject CERULEANCITY_COOLTRAINER_F, UP ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, RIGHT ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, DOWN ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, UP ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, RIGHT ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, DOWN ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, UP ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, RIGHT ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, DOWN ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT ; Damien
	pause 1 ; Damien
	turnobject CERULEANCITY_COOLTRAINER_F, UP ; Damien
	opentext
	writetext CeruleanCityCooltrainerFText3
	waitbutton
	closetext
	end

CeruleanCityFisherScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	checkevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	iftrue .MetCeruleanRocket
.ReturnedMachinePart:
	writetext CeruleanCityFisherText
	waitbutton
	closetext
	end

.MetCeruleanRocket:
	writetext CeruleanCityFisherRocketTipText
	waitbutton
	closetext
	end

CeruleanCityYoungsterScript:
	faceplayer
	opentext
	checkevent EVENT_ROCKET_THIEF_CERULEAN_CITY_GARDEN
	iffalse .Rocket

	writetext CeruleanCityYoungsterText1
	waitbutton
	closetext
	checkevent EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY
	iffalse .BerserkGenePingsItemfinder
	end

.Rocket
	writetext CeruleanCityYoungsterTextRocket
	waitbutton
	closetext
	end

.BerserkGenePingsItemfinder:
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	showemote EMOTE_SHOCK, CERULEANCITY_YOUNGSTER, 15
	turnobject CERULEANCITY_YOUNGSTER, LEFT
	opentext
	writetext CeruleanCityYoungsterText2
	waitbutton
	closetext
	end

AshPikachuLeadsToCeruleanCave:
	readvar VAR_FACING
	ifnotequal DOWN, .quit

	readmem wPlayerState
	ifnotequal PLAYER_SURF_PIKA, .quit

	showemote EMOTE_SHOCK, PLAYER, 15
	opentext
	writetext PikachuRecognizesThisPlace
	yesorno
	closetext
	iftrue .lead
.quit
	end

.lead:
	applymovement PLAYER, WayToCeruleanCaveMovement
	pause 15
	opentext
	writetext PikachuDragsYouUnderWater
	pause 45
	closetext

	; fade screen
	playsound SFX_WATER_GUN
	special FadeOutPalettes
	pause 20

	; Escape rope setting.
	loadmem wDigWarpNumber, 7
	loadmem wDigMapGroup, GROUP_CERULEAN_CITY
	loadmem wDigMapNumber, MAP_CERULEAN_CITY

	warpfacing UP, CERULEAN_CAVE_ENTRANCE, 5, 14
	; warp
	end

CeruleanCityRocketScript:
	opentext
	writetext CeruleanCityRocketText1
	waitbutton
	closetext

	showemote EMOTE_SHOCK, CERULEANCITY_ROCKET, 15
	faceplayer
	pause 20
	applymovement CERULEANCITY_ROCKET, CeruleanCityRocketFlee1Movement

	readmem wOverworldMapBlocks + 220
	ifnotequal $35, .tree_is_already_cut

	pause 5
	changeblock 18, 10, $4c
	reloadmappart
	playsound SFX_PLACE_PUZZLE_PIECE_DOWN
	pause 10
.tree_is_already_cut
	applymovement CERULEANCITY_ROCKET, CeruleanCityRocketFlee2Movement
	pause 30
	moveobject CERULEANCITY_DETECTIVE4, 20, 4
	appear CERULEANCITY_DETECTIVE4 ; also does clearevent EVENT_ROCKET_THIEF_ROUTE_4_SOUTH
	follow CERULEANCITY_ROCKET, CERULEANCITY_DETECTIVE4
	applymovement CERULEANCITY_ROCKET, CeruleanCityRocketFlee3Movement
	stopfollow
	disappear CERULEANCITY_ROCKET
	disappear CERULEANCITY_DETECTIVE5
	disappear CERULEANCITY_SQUIRTLE4
	disappear CERULEANCITY_DETECTIVE4
	moveobject CERULEANCITY_DETECTIVE4, 20, 17
	appear CERULEANCITY_DETECTIVE4
	end

CeruleanCityDetectiveScript:
	jumptextfaceplayer CeruleanCityDetectiveText

CeruleanCityDetective2Script:
	jumptextfaceplayer CeruleanCityDetective2Text

CeruleanCitySawThiefScript:
	applymovementlasttalked CeruleanCityStompLeftMovement
	jumptext CeruleanCitySawThiefText

CeruleanCitySquirtleScript:
	cry SQUIRTLE
	jumptextfaceplayer CeruleanCitySquirtleText

CeruleanCitySign:
	jumptext CeruleanCitySignText

CeruleanGymSign:
	jumptext CeruleanGymSignText

CeruleanBikeShopSign:
	jumptext CeruleanBikeShopSignText

CeruleanPoliceSign:
	jumptext CeruleanPoliceSignText

CeruleanCapeSign:
	jumptext CeruleanCapeSignText

CeruleanLockedDoor:
	jumptext CeruleanLockedDoorText

CeruleanCityPokecenterSign:
	jumpstd PokecenterSignScript

CeruleanCityMartSign:
	jumpstd MartSignScript

CeruleanCityBridgeItem:
	itemball TOILET_PAPER

CeruleanCityHiddenBerserkGene:
	hiddenitem BERSERK_GENE, EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY

WayToCeruleanCaveMovement:
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	turn_head UP
	step_end

CeruleanCityRocketFlee1Movement:
	big_step DOWN
	turn_head RIGHT
	step_end

CeruleanCityRocketFlee2Movement:
	big_step RIGHT
	big_step RIGHT
rept 6
	big_step UP
endr
	step_end

CeruleanCityRocketFlee3Movement:
rept 12
	big_step DOWN
endr	
	step_end

CeruleanCityStompLeftMovement:
	turn_step LEFT
	step_bump
	step_end

CeruleanCityCooltrainerMText1:
	text "KANTO's POWER"
	line "PLANT?"

	para "It's near the end"
	line "of ROUTE 9, the"

	para "road that heads"
	line "east from here."

	para "I think there was"
	line "an accident of"
	cont "some sort there."
	done

CeruleanCityCooltrainerMText2:
	text "You're collecting"
	line "every single kind"
	cont "of #MON?"

	para "That must be quite"
	line "a challenge, but"
	cont "it sounds fun too."
	done

CeruleanCitySuperNerdText:
;	text "The CAPE in the"
;	line "north is a good"
;
;	para "place for dates."
;	line "Girls like it!"
;	done

	text "The kids up north"
	line "used to play"
	cont "together."
	
	para "The bridge has"
	line "been named after"
	cont "their challenge:"
	cont "the NUGGET BRIDGE."

	para "Then one day,"
	line "they moved down"
	cont "the bridge and"
	cont "started fighting"
	cont "each other…"

	para "Every single day…"

	para "We now call it"
	line "the SHAME BRIDGE."
	done

CeruleanCitySlowbroText:
	text "SLOWBRO: Yarah?"
	done

CeruleanCityCooltrainerFText1:
	text "My SLOWBRO and I"
	line "make an awesome"
	cont "combination!"
	done

CeruleanCityCooltrainerFText2:
	text "SLOWBRO, show me"
	line "your CONFUSION!"
	done

CeruleanCityCooltrainerFText3:
	text "…"
	done

CeruleanCityFisherText:
	text "I'm a huge fan of"
	line "CERULEAN GYM's"
	cont "MISTY."
	done

CeruleanCityFisherRocketTipText:
	text "I saw this shady"
	line "guy go off toward"
	cont "CERULEAN's CAPE."
	done

CeruleanCityYoungsterText1:
	text "There used to be a"
	line "cave here that had"

	para "horribly powerful"
	line "#MON in it."

	para "Only LEAGUE CHAMP-"
	line "IONS and their"
	cont "#MON were"
	cont "permitted to"
	cont "explore it."

	para "It collapsed the"
	line "day after CINNA-"
	cont "BAR's volcano"
	cont "erupted."
	
	para "Yet, I've seen a"
	line "trainer finding"
	cont "its way in."
	done

CeruleanCityYoungsterText2:
	text "Ayuh?"

	para "My ITEMFINDER is"
	line "responding…"
	done

CeruleanCityYoungsterTextRocket:
	text "What is this dude"
	line "doing in my gar-"
	cont "den? Get him out!"
	done

CeruleanCitySignText:
	text "CERULEAN CITY"

	para "A Mysterious Blue"
	line "Aura Surrounds It"
	done

CeruleanGymSignText:
	text "CERULEAN CITY"
	line "#MON GYM"
	cont "LEADER: MISTY"

	para "The Tomboyish"
	line "Mermaid"
	done

CeruleanBikeShopSignText:
	text "There's a notice"
	line "here…"

	para "The BIKE SHOP"
	line "has filed for"
	cont "bankruptcy."
	done

CeruleanPoliceSignText:
	text "There's a notice"
	line "here…"

	para "Stamp out thievery"
	line "and make the city"

	para "a friendlier, more"
	line "cheerful place!"

	para "CERULEAN POLICE"
	done

CeruleanCapeSignText:
	text "CERULEAN CAPE"
	line "AHEAD"
	done

CeruleanLockedDoorText:
	text "A heavy chain"
	line "seals the door."
	done

CeruleanCityDetectiveText:
	text "There's an ongoing"
	line "investigation into"

	para "the POWER PLANT"
	line "incident."

	para "I can't let"
	line "anyone in or out."
	done

CeruleanCityDetective2Text:
	text "We are looking for"
	line "a thief."
	done

CeruleanCitySawThiefText:
	text "I saw the thief!"
	
	para "He fled to the"
	line "west, get him!"
	done

CeruleanCitySquirtleText:
	text "SQUIRTLE: Squirt"
	line "Squirtle!"
	done

PikachuRecognizesThisPlace:
	text "PIKACHU recognizes"
	line "this place."

	para "Let it lead"
	line "the way?"
	done

PikachuDragsYouUnderWater:
	text "PIKACHU drags you"
	line "under water."
	done

CeruleanCityRocketText1:
	text "…MACHINE PART safe"
	line "in GYM pool, no"
	cont "worry…"
	done

CeruleanCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, CERULEAN_GYM_BADGE_SPEECH_HOUSE, 1
	warp_event 30, 17, CERULEAN_POLICE_STATION, 1
	warp_event 13, 19, CERULEAN_TRADE_SPEECH_HOUSE, 1
	warp_event 19, 21, CERULEAN_POKECENTER_1F, 1
	warp_event 30, 23, CERULEAN_GYM, 1
	warp_event 25, 29, CERULEAN_MART, 2
	warp_event  2, 14, CERULEAN_CAVE_ENTRANCE, 1
	warp_event 29, 13, CERULEAN_POLICE_STATION, 3
	warp_event  9, 13, CERULEAN_GYM_BADGE_SPEECH_HOUSE, 3

	def_coord_events
	coord_event  6,  9, CE_EVENT_FLAG_CLEARED, EVENT_RED_BEATEN, AshPikachuLeadsToCeruleanCave

	def_bg_events
	bg_event 23, 23, BGEVENT_READ, CeruleanCitySign
	bg_event 27, 25, BGEVENT_READ, CeruleanGymSign
	bg_event 11, 29, BGEVENT_READ, CeruleanBikeShopSign
	bg_event 27, 17, BGEVENT_READ, CeruleanPoliceSign
	bg_event 23, 11, BGEVENT_READ, CeruleanCapeSign
	bg_event 14, 29, BGEVENT_READ, CeruleanLockedDoor
	bg_event 20, 21, BGEVENT_READ, CeruleanCityPokecenterSign
	bg_event 26, 29, BGEVENT_READ, CeruleanCityMartSign
	bg_event  3, 14, BGEVENT_ITEM, CeruleanCityHiddenBerserkGene

	def_object_events
	object_event 15, 23, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityCooltrainerMScript, -1
	object_event 23, 15, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySuperNerdScript, -1
	object_event 20, 24, SPRITE_SLOWBRO, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CeruleanCitySlowbro, -1
	object_event 21, 24, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeruleanCityCooltrainerFScript, -1
	object_event 30, 26, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanCityFisherScript, -1
	object_event  8, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanCityYoungsterScript, -1
	
	object_event 34, 32, SPRITE_JENNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityDetectiveScript, EVENT_RETURNED_MACHINE_PART
	object_event 35, 33, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySquirtleScript, EVENT_RETURNED_MACHINE_PART
	object_event  7, 29, SPRITE_JENNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityDetective2Script, EVENT_ROCKET_THIEF_CAUGHT
	object_event  9, 28, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySquirtleScript, EVENT_ROCKET_THIEF_CAUGHT
	
	object_event 23, -5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 2, ObjectEvent, -1
	object_event 25, -5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 2, ObjectEvent, -1
	
	object_event 23, -3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event 25, -3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 2, ObjectEvent, -1

	object_event 24,  0, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCityBridgeItem, EVENT_CERULEAN_BRIDGE_ITEM
	
	object_event 31, 24, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySawThiefScript, EVENT_CERULEAN_HOUSE_ROCKET
	object_event 26, 25, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySquirtleScript, EVENT_CERULEAN_HOUSE_ROCKET

	object_event 18,  9, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityRocketScript, EVENT_ROCKET_THIEF_CERULEAN_CITY_GARDEN
	object_event 20, 17, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySawThiefScript, EVENT_ROCKET_THIEF_ROUTE_4_SOUTH

	object_event 20, -1, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityDetective2Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 21,  0, SPRITE_SQUIRTLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCitySquirtleScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	