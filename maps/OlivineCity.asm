	object_const_def
	const OLIVINECITY_TRAVEL_CONTROLLER
	const OLIVINECITY_SAILOR1
	const OLIVINECITY_STANDING_YOUNGSTER
	const OLIVINECITY_SAILOR2
	const OLIVINECITY_OLIVINE_RIVAL
	const OLIVINECITY_TAKEAWAY_SELLER

OlivineCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TilesLoad

.FlyPoint:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .FlyPointSequel

	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel

.FlyPointSequel
	setflag ENGINE_FLYPOINT_OLIVINE
	checkevent EVENT_POKEMASK_CALL_RECEIVED
	iftrue .end
	setevent EVENT_POKEMASK_CALL_RECEIVED
	specialphonecall SPECIALCALL_POKEMASK_BEFORE
.end
	endcallback

.TilesLoad:
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock 18, 16, $37 ; Mart.

	checkevent EVENT_FIRST_CURFEW_STARTED
	iffalse .EndTilesCallback

	; Olivine Cafe. The door stays open during lockdown: as it is guarded by the owner no one can enter the cafe.
	changeblock  6, 20, $37
	changeblock  8, 20, $3b

.EndTilesCallback
	endcallback

OlivineCityRivalSceneTop:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalApproachesTopMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalText
	waitbutton
	closetext
	applymovement PLAYER, OlivineCityPlayerStepsAsideTopMovement
	turnobject PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalLeavesTopMovement
	sjump OlivineCityRivalSceneBottom.outro

OlivineCityRivalSceneBottom:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalApproachesBottomMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalText
	waitbutton
	closetext
	applymovement PLAYER, OlivineCityPlayerStepsAsideBottomMovement
	turnobject PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalLeavesBottomMovement
.outro
	setevent EVENT_MET_RIVAL_IN_OLIVINE
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	special LoadUsedSpritesGFX
	end

OlivineCitySailor1Script:
	jumptextfaceplayer OlivineCitySailor1Text

OlivineCityStandingYoungsterScript:
	random 2
	ifequal 0, .FiftyFifty
	jumptextfaceplayer OlivineCityStandingYoungsterPokegearText

.FiftyFifty:
	jumptextfaceplayer OlivineCityStandingYoungsterPokedexText

OlivineCity_ToGoScript:
	faceplayer
	opentext
	checkflag ENGINE_OLIVINE_CAFE
	iftrue .AlreadyBought

	readmem wCurFreedomState
	ifequal 1 << FREE, .skip_lockdown_curfew_text
	ifequal 1 << VACCINE_PASSPORT, .skip_lockdown_curfew_text
	writetext OlivineCity_ToGoText
	promptbutton

.skip_lockdown_curfew_text
	special GetOlivineCafeSalad
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	writetext OlivineCity_TodaysSpecialText
	special PlaceMoneyTopRight
	yesorno
	iffalse .Refused
	checkmoney YOUR_MONEY, 500
	ifequal HAVE_LESS, .NotEnoughMoney


	takemoney YOUR_MONEY, 500
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitsfx
	writetext OlivineCity_ThanksText
	promptbutton
	closetext
	
	setflag ENGINE_OLIVINE_CAFE ; daily flag.
	opentext

	readmem wOlivineCafeBerry1
	giveitem ITEM_FROM_MEM
	writetext OlivineCity_Berry1Text
	iffalse .CantCarry
	playsound SFX_ITEM
	promptbutton
	waitsfx

	readmem wOlivineCafeBerry2
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	giveitem ITEM_FROM_MEM
	writetext OlivineCity_Berry2Text
	iffalse .CantCarry
	playsound SFX_ITEM
	promptbutton
	waitsfx

	readmem wOlivineCafeBerry3
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	giveitem ITEM_FROM_MEM
	writetext OlivineCity_Berry3Text
	iffalse .CantCarry
	playsound SFX_ITEM
	promptbutton
	waitsfx

	getitemname STRING_BUFFER_3, BERRY_JUICE
	writetext OlivineCity_BerryDrinkText

	giveitem BERRY_JUICE
	iffalse .CantCarry
	playsound SFX_ITEM
	waitsfx

.EndText
	waitbutton
	closetext
	end

.AlreadyBought
	writetext OlivineCity_AlreadyBoughtText
	sjump .EndText

.Refused
	writetext OlivineCity_RefusedSaladText
	sjump .EndText

.NotEnoughMoney
	writetext OlivineCity_NotEnoughMoneyText
	sjump .EndText

.CantCarry
	promptbutton
	writetext OlivineCity_CantCarryText
	sjump .EndText

OlivineCitySailor2Script:
	jumptextfaceplayer OlivineCitySailor2Text

OlivineCitySign:
	jumptext OlivineCitySignText

OlivineCityPortSign:
	jumptext OlivineCityPortSignText

OlivineGymSign:
	jumptext OlivineGymSignText

OlivineLighthouseSign:
	jumptext OlivineLighthouseSignText

OlivineCityBattleTowerSign:
	jumptext OlivineCityBattleTowerSignText

OlivineCityPokecenterSign:
	jumpstd PokecenterSignScript

OlivineCityMartSign:
	jumpstd MartSignScript

OlivineCity_DoorScript:
	jumpstd LockdownCurfewClosedDoor

OlivineCityRivalApproachesTopMovement:
	step DOWN
	step RIGHT
	step RIGHT
	step_end

OlivineCityRivalApproachesBottomMovement:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step_end

OlivineCityRivalLeavesTopMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

OlivineCityRivalLeavesBottomMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

OlivineCityPlayerStepsAsideTopMovement:
	step DOWN
	turn_head UP
	step_end

OlivineCityPlayerStepsAsideBottomMovement:
	step UP
	turn_head DOWN
	step_end

OlivineCityRivalText:
	text "…"

	para "You again?"

	para "There's no need to"
	line "panic. I don't"

	para "bother with wimps"
	line "like you."

	para "Speaking of weak-"
	line "lings, the city's"

	para "GYM LEADER isn't"
	line "here."

	para "Supposedly taking"
	line "care of a sick"

	para "#MON at the"
	line "LIGHTHOUSE."

	para "Humph! Boo-hoo!"
	line "Just let sick"
	cont "#MON go!"

	para "A #MON that"
	line "can't battle is"
	cont "worthless!"

	para "Why don't you go"
	line "train at the"
	cont "LIGHTHOUSE?"

	para "Who knows. It may"
	line "make you a bit"
	cont "less weak!"
	done

OlivineCitySailor1Text:
	text "Dark roads are"
	line "dangerous at"
	cont "night."

	para "But in the pitch-"
	line "black of night,"

	para "the sea is even"
	line "more treacherous!"

	para "Without the beacon"
	line "of the LIGHTHOUSE"

	para "to guide it, no"
	line "ship can sail."
	done

OlivineCityStandingYoungsterPokegearText:
	text "That thing you"
	line "have--it's a #-"
	cont "GEAR, right? Wow,"
	cont "that's cool."
	done

OlivineCityStandingYoungsterPokedexText:
	text "Wow, you have a"
	line "#DEX!"

	para "That is just so"
	line "awesome."
	done

OlivineCitySailor2Text:
	text "The sea is sweet!"

	para "Sunsets on the sea"
	line "are marvelous!"

	para "Sing with me! "
	line "Yo-ho! Blow the"
	cont "man down!…"
	done

OlivineCitySignText:
	text "OLIVINE CITY"

	para "The Port Closest"
	line "to Foreign Lands"
	done

OlivineCityPortSignText:
	text "OLIVINE PORT"
	line "FAST SHIP PIER"
	done

OlivineGymSignText:
	text "OLIVINE CITY"
	line "#MON GYM"
	cont "LEADER: JASMINE"

	para "The Steel-Clad"
	line "Defense Girl"
	done

OlivineLighthouseSignText:
	text "OLIVINE LIGHTHOUSE"
	line "Also known as the"
	cont "GLITTER LIGHTHOUSE"
	done

OlivineCityBattleTowerSignText:
	text "BATTLE TOWER AHEAD"
	line "Opening Now!"
	done

OlivineCity_ToGoText:
	text "Our CAFE is not"
	line "allowed to host"
	cont "sitted customers,"
	
	para "but we are allo-"
	line "wed to offer"
	cont "to-go meals."
	done

OlivineCity_TodaysSpecialText:
	text "Today's special is"
	line "the @"
	text_ram wStringBuffer3
	text ""
	cont "salad for ¥500."
	cont "Want one?"
	done

OlivineCity_AlreadyBoughtText:
	text "Come back tomorrow"
	line "for a new special!"
	done

OlivineCity_RefusedSaladText:
	text "No problem."

	para "Perhaps tomorrow's"
	line "special will be"
	cont "to your liking."
	done

OlivineCity_ThanksText:
	text "Thank you!"
	line "Enjoy!"
	done

OlivineCity_NotEnoughMoneyText:
	text "You don't have"
	line "¥500."
	done

OlivineCity_CantCarryText:
	text "Whoops, you can't"
	line "carry this, your"
	cont "pack is full!"

	para "Not my responsibi-"
	line "lity, no refund!"
	done

OlivineCity_Berry1Text:
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer1
	text ""
	done

OlivineCity_Berry2Text:
	text "topped with"
	line "@"
	text_ram wStringBuffer3
	text ""
	done

OlivineCity_Berry3Text:
	text "and @"
	text_ram wStringBuffer3
	text ""
	line "on the side."
	done

OlivineCity_BerryDrinkText:
	text "And here is"
	line "the drink."

	para "<PLAYER> is handed"
	line "a @"
	text_ram wStringBuffer3
	text "."
	done

OlivineCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13, 21, OLIVINE_POKECENTER_1F, 1
	warp_event 10, 11, OLIVINE_GYM, 1
	warp_event 25, 11, OLIVINE_TIMS_HOUSE, 1
	warp_event  0,  0, OLIVINE_POKECENTER_1F, 1 ; inaccessible
	warp_event 29, 11, OLIVINE_PUNISHMENT_SPEECH_HOUSE, 1
	warp_event 13, 15, OLIVINE_GOOD_ROD_HOUSE, 1
	warp_event  7, 21, OLIVINE_CAFE, 1
	warp_event 19, 17, OLIVINE_MART, 2
	warp_event 29, 27, OLIVINE_LIGHTHOUSE_1F, 1
	warp_event 19, 27, OLIVINE_PORT_PASSAGE, 1
	warp_event 20, 27, OLIVINE_PORT_PASSAGE, 2

	def_coord_events
	coord_event 13, 12, CE_EVENT_FLAG_CLEARED, EVENT_MET_RIVAL_IN_OLIVINE, OlivineCityRivalSceneTop
	coord_event 13, 13, CE_EVENT_FLAG_CLEARED, EVENT_MET_RIVAL_IN_OLIVINE, OlivineCityRivalSceneBottom

	def_bg_events
	bg_event 17, 11, BGEVENT_READ, OlivineCitySign
	bg_event 20, 24, BGEVENT_READ, OlivineCityPortSign
	bg_event  7, 11, BGEVENT_READ, OlivineGymSign
	bg_event 30, 28, BGEVENT_READ, OlivineLighthouseSign
	bg_event  3, 23, BGEVENT_READ, OlivineCityBattleTowerSign
	bg_event 14, 21, BGEVENT_READ, OlivineCityPokecenterSign
	bg_event 20, 17, BGEVENT_READ, OlivineCityMartSign
	bg_event  7, 21, BGEVENT_CLOSED_DOOR, OlivineCity_DoorScript ; Cafe.
	bg_event 19, 17, BGEVENT_CLOSED_DOOR, OlivineCity_DoorScript ; Mart.

	def_object_events
	object_event 15, 22, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | DAY | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event 26, 27, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCitySailor1Script, -1
	object_event 20, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineCityStandingYoungsterScript, -1
	object_event 17, 21, SPRITE_SAILOR, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCitySailor2Script, -1
	object_event 10, 11, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
	object_event  7, 22, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCity_ToGoScript, EVENT_FIRST_CURFEW_STARTED
