	object_const_def
	const FASTSHIP1F_SAILOR1
	const FASTSHIP1F_SAILOR2
	const FASTSHIP1F_SAILOR3
	const FASTSHIP1F_GENTLEMAN

FastShip1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .EnterFastShip ; SCENE_FASTSHIP1F_ENTER_SHIP
	scene_script .DummyScene2 ; SCENE_FASTSHIP1F_MEET_GRANDPA

	def_callbacks

.DummyScene0:
	end

.EnterFastShip:
	prioritysjump .EnterFastShipScript
	end

.DummyScene2:
	end

.EnterFastShipScript:
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorStepAsideMovement
	applymovement PLAYER, FastShip1F_PlayerEntersShipMovement
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorBlocksDoorMovement
	pause 30
	playsound SFX_BOAT
	earthquake 30
	blackoutmod FAST_SHIP_CABINS_SW_SSW_NW
	clearevent EVENT_FAST_SHIP_HAS_ARRIVED
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .SkipGrandpa
	setscene SCENE_FASTSHIP1F_MEET_GRANDPA
	end

.SkipGrandpa:
	setscene SCENE_DEFAULT
	end

FastShip1FSailor1Script:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_HAS_ARRIVED
	iftrue .Arrived
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue .Olivine
	writetext FastShip1FSailor1Text_ToVermilion
	waitbutton
	closetext
	end

.Olivine:
	writetext FastShip1FSailor1Text_ToOlivine
	waitbutton
	closetext
	end

.Arrived:
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue ._Olivine
	writetext FastShip1FSailor1Text_InVermilion


	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .GoOut ; If it's not the first trip, immediately go out.

	readmem wCurBox
	ifequal 13, .GoOut ; In case the player shuts down the game and returns to this point, we don't want to make him/her save again.

	promptbutton
	writetext FastShip1FSailor1Text_NeedToSave
	yesorno
	iftrue .SwapToLocalBox

	writetext FastShip1FSailor1Text_CantLetYouOut
	waitbutton
	closetext
	end

.SwapToLocalBox
	writetext FastShip1FSailor1Text_Saving
	loadmem wCurFreedomState, 1 << VACCINE_PASSPORT
	readmem wYearMonth
	addval 1
	writemem wYearMonth
	clearevent GOLDENROD_BIKE_SHOP_CLOSED ; The "stay-at-home order" message in the call from the Bike Shop owner would make no sense during the vaccine pass era and after.
	setevent EVENT_GOLDENROD_ILLEGAL_CASINO ; We prevent the player from illegally entering the casino while the vaccine passport controller is already in the casino.
	setflag ENGINE_FLYPOINT_VERMILION
	clearflag ENGINE_FLYPOINT_INDIGO_PLATEAU ; We don't want the player to leave Kanto. This is an ugly method.
	special BoxLockAfterPowerOutage
	farwritetext _SavedTheGameText
	playsound SFX_SAVE
	waitsfx
	wait 10
	writetext FastShip1FSailor1Text_SeeYou

.GoOut
	waitbutton
	closetext
	scall .LetThePlayerOut
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	setmapscene VERMILION_PORT, SCENE_VERMILIONPORT_LEAVE_SHIP
	warp VERMILION_PORT, 7, 21
	end

._Olivine:
	writetext FastShip1FSailor1Text_InOlivine
	waitbutton
	closetext
	scall .LetThePlayerOut
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	setmapscene OLIVINE_PORT, SCENE_OLIVINEPORT_LEAVE_SHIP
	warp OLIVINE_PORT, 7, 23
	end

.LetThePlayerOut:
	readvar VAR_FACING
	ifequal RIGHT, .YouAreFacingRight
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorStepAsideMovement
	applymovement PLAYER, FastShip1F_PlayerLeavesShipMovement
	end

.YouAreFacingRight:
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorStepAsideDownMovement
	applymovement PLAYER, FastShip1F_PlayerLeavesShipRightMovement
	end

FastShip1FSailor2Script:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .Vermilion
	writetext FastShip1FSailor2Text_FirstTime
	waitbutton
	closetext
	end

.Vermilion:
	writetext FastShip1FSailor2Text
	waitbutton
	closetext
	end

FastShip1FSailor3Script:
	jumptextfaceplayer FastShip1FSailor3Text

WorriedGrandpaSceneRight:
	moveobject FASTSHIP1F_GENTLEMAN, 20, 6

WorriedGrandpaSceneLeft:
	appear FASTSHIP1F_GENTLEMAN
	applymovement FASTSHIP1F_GENTLEMAN, FastShip1F_GrandpaRunsInMovement
	playsound SFX_TACKLE
	applymovement PLAYER, FastShip1F_PlayerHitByGrandpaMovement
	opentext
	writetext FastShip1FGrandpaText
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement FASTSHIP1F_GENTLEMAN, FastShip1F_GrandpaRunsOutMovement
	disappear FASTSHIP1F_GENTLEMAN
	setscene SCENE_DEFAULT
	end

FastShip1F_SailorStepAsideMovement:
	slow_step LEFT
	turn_head RIGHT
	step_end

FastShip1F_SailorBlocksDoorMovement:
	slow_step RIGHT
	turn_head DOWN
	step_end

FastShip1F_SailorStepAsideDownMovement:
	slow_step DOWN
	turn_head UP
	step_end

FastShip1F_PlayerEntersShipMovement:
	step DOWN
	step DOWN
	step DOWN
	step_end

FastShip1F_GrandpaRunsInMovement:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

FastShip1F_GrandpaRunsOutMovement:
	big_step DOWN
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

FastShip1F_PlayerHitByGrandpaMovement:
	big_step RIGHT
	turn_head LEFT
	step_end

FastShip1F_PlayerLeavesShipMovement:
	step UP
	step UP
	step UP
	step_end

FastShip1F_PlayerLeavesShipRightMovement:
	step RIGHT
	step UP
	step_end

FastShip1FSailor1Text_ToVermilion: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA va à"
	cont "CARMIN SUR MER."

	para "Nous ferons un"
	line "appel à notre"
	cont "arrivée."
else
	text "FAST SHIP S.S.AQUA"
	line "is en route to"
	cont "VERMILION CITY."

	para "We will make an"
	line "announcement when"
	cont "we arrive."
endc

	done

FastShip1FSailor1Text_ToOlivine: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA va à"
	cont "OLIVILLE."

	para "Nous ferons un"
	line "appel à notre"
	cont "arrivée."
else
	text "FAST SHIP S.S.AQUA"
	line "is en route to"
	cont "OLIVINE CITY."

	para "We will make an"
	line "announcement when"
	cont "we arrive."
endc

	done

FastShip1FSailor2Text_FirstTime: 
if DEF(_FR_FR)
	text "Voici votre"
	line "cabine."

	para "Si vos #MON"
	line "sont blessés,"
	cont "dormez et..."

	para "Ils seront tous"
	line "soignés."
else
	text "Here's your cabin."

	para "If your #MON"
	line "are hurt, take a"
	cont "nap in the bed."

	para "That will heal"
	line "them."
endc

	done

FastShip1FSailor2Text: 
if DEF(_FR_FR)
	text "Voici votre"
	line "cabine."

	para "Soignez vos #-"
	line "MON en dormant"
	cont "dans le lit."

	para "Le bateau arrivera"
	line "pendant votre"
	cont "sommeil."
else
	text "Here's your cabin."

	para "You can heal your"
	line "#MON by taking"
	cont "a nap in the bed."

	para "The ship will"
	line "arrive while"
	cont "you're sleeping."
endc

	done

FastShip1FSailor3Text: 
if DEF(_FR_FR)
	text "Tous les passagers"
	line "sont dresseurs."

	para "Ils veulent tous"
	line "se battre dans"
	cont "leur cabine."
else
	text "The passengers are"
	line "all trainers."

	para "They're all itch-"
	line "ing to battle in"
	cont "their cabins."
endc

	done

FastShip1FGrandpaText: 
if DEF(_FR_FR)
	text "Whoa! Pardon."
	line "Je suis un peu"
	cont "pressé!"

	para "Ma petite-fille a"
	line "disparu!"

	para "Elle est toute"
	line "jeune... Préviens-"
	cont "moi si tu la vois!"
else
	text "Whoa! Excuse me."
	line "I was in a hurry!"

	para "My granddaughter"
	line "is missing!"

	para "She's just a wee"
	line "girl. If you see"

	para "her, please let me"
	line "know!"
endc

	done

FastShip1FSailor1Text_InOlivine: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA est arrivé"
	cont "à OLIVILLE."
else
	text "FAST SHIP S.S.AQUA"
	line "has arrived in"
	cont "OLIVINE CITY."
endc

	done

FastShip1FSailor1Text_InVermilion: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA est arrivé"
	cont "à CARMIN SUR MER."
else
	text "FAST SHIP S.S.AQUA"
	line "has arrived in"
	cont "VERMILION CITY."
endc

	done

FastShip1FSailor1Text_NeedToSave: ; TO TRANSLATE
	text "You need to save"
	line "the game before"
	cont "leaving."
	done

FastShip1FSailor1Text_Saving: ; TO TRANSLATE
	text "Saving…"
	done

FastShip1FSailor1Text_CantLetYouOut: ; TO TRANSLATE
	text "Sorry I can't"
	line "let you out."
	done

FastShip1FSailor1Text_SeeYou: ; TO TRANSLATE
	text "Have a nice stay"
	line "in VERMILION CITY!"
	done

FastShip1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 25,  1, FAST_SHIP_1F, -1
	warp_event 27,  8, FAST_SHIP_CABINS_NNW_NNE_NE, 1
	warp_event 23,  8, FAST_SHIP_CABINS_NNW_NNE_NE, 2
	warp_event 19,  8, FAST_SHIP_CABINS_NNW_NNE_NE, 3
	warp_event 15,  8, FAST_SHIP_CABINS_SW_SSW_NW, 1
	warp_event 15, 15, FAST_SHIP_CABINS_SW_SSW_NW, 2
	warp_event 19, 15, FAST_SHIP_CABINS_SW_SSW_NW, 4
	warp_event 23, 15, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, 1
	warp_event 27, 15, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, 3
	warp_event  3, 13, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, 5
	warp_event  6, 12, FAST_SHIP_B1F, 1
	warp_event 30, 14, FAST_SHIP_B1F, 2

	def_coord_events
	coord_event 24,  6, CE_SCENE_ID, SCENE_FASTSHIP1F_MEET_GRANDPA, WorriedGrandpaSceneLeft
	coord_event 25,  6, CE_SCENE_ID, SCENE_FASTSHIP1F_MEET_GRANDPA, WorriedGrandpaSceneRight

	def_bg_events

	def_object_events
	object_event 25,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FastShip1FSailor1Script, -1
	object_event 14,  7, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FastShip1FSailor2Script, -1
	object_event 22, 17, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FastShip1FSailor3Script, -1
	object_event 19,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_FAST_SHIP_1F_GENTLEMAN
