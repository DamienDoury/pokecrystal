GOLDENRODGAMECORNER_TM25_COINS EQU 3000
GOLDENRODGAMECORNER_TM14_COINS EQU 3000
GOLDENRODGAMECORNER_TM38_COINS EQU 3000
GOLDENRODGAMECORNER_CUBONE_COINS    EQU 400
GOLDENRODGAMECORNER_ABRA_COINS      EQU 800
GOLDENRODGAMECORNER_DITTO_COINS 	EQU 1600

	object_const_def
	const GOLDENRODGAMECORNER_CLERK
	const GOLDENRODGAMECORNER_VP_CONTROLLER
	const GOLDENRODGAMECORNER_RECEPTIONIST1
	const GOLDENRODGAMECORNER_RECEPTIONIST2
	const GOLDENRODGAMECORNER_PHARMACIST1
	const GOLDENRODGAMECORNER_POKEFAN_M1
	const GOLDENRODGAMECORNER_COOLTRAINER_M
	const GOLDENRODGAMECORNER_POKEFAN_F
	const GOLDENRODGAMECORNER_COOLTRAINER_F
	const GOLDENRODGAMECORNER_GENTLEMAN
	const GOLDENRODGAMECORNER_POKEFAN_M2
	const GOLDENRODGAMECORNER_MOVETUTOR
	const GOLDENRODGAMECORNER_ABRA

GoldenrodGameCorner_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_TILES, .SetTiles
	callback MAPCALLBACK_OBJECTS, .MoveTutor

	
.DummyScene0:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .vaccine_passport_check

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	readvar VAR_XCOORD
	ifnotequal 16, .vaccine_passport_check
	readvar VAR_YCOORD
	ifnotequal 9, .vaccine_passport_check

	; Cutscene when the player gets wrongly teleported.
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	turnobject GOLDENRODGAMECORNER_COOLTRAINER_M, RIGHT
	showemote EMOTE_SHOCK, GOLDENRODGAMECORNER_COOLTRAINER_M, 30
	turnobject PLAYER, LEFT
	sjump GoldenrodGameCornerCooltrainerMScript

.vaccine_passport_check
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	
	readvar VAR_YCOORD
	ifless 12, .end
	jumpstd VaccinePassCheckpoint
.end
	end

.SetTiles:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse .endcallback 
	
	; The casino goes back to normal after it legally reopened.
	changeblock  2,  0, $2b
	changeblock  0,  2, $09
	changeblock  2,  2, $09
	changeblock  2, 12, $0c

	; Social distancing.
	changeblock  4,  6, $39
	changeblock  4,  8, $39
	changeblock  4, 10, $39
	changeblock 10,  6, $39
	changeblock 10,  8, $39
	changeblock 10, 10, $39
	changeblock 16,  6, $39
	changeblock 16,  8, $39
	changeblock 16, 10, $39

	changeblock  8,  6, $3a
	changeblock  8,  8, $3a
	changeblock  8, 10, $3a
	changeblock 14,  6, $3a
	changeblock 14,  8, $3a
	changeblock 14, 10, $3a

.endcallback
	endcallback

.MoveTutor:
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .finish
	checkitem COIN_CASE
	iffalse .move_tutor_inside
	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .move_tutor_outside
	ifequal SATURDAY, .move_tutor_outside
.move_tutor_inside
	appear GOLDENRODGAMECORNER_MOVETUTOR
	endcallback

.move_tutor_outside
	checkflag ENGINE_DAILY_MOVE_TUTOR
	iftrue .finish
	disappear GOLDENRODGAMECORNER_MOVETUTOR
.finish
	endcallback

GoldenrodGameCornerGreetingsScript:
	playsound SFX_HIT_END_OF_EXP_BAR
	showemote EMOTE_SHOCK, GOLDENRODGAMECORNER_CLERK, 10
	pause 15
	turnobject GOLDENRODGAMECORNER_CLERK, LEFT
	pause 15
	turnobject PLAYER, RIGHT
	showemote EMOTE_HAPPY, GOLDENRODGAMECORNER_CLERK, 25
	scall GiveCoinCase
	writetext GoldenrodGameCornerGreetings4Text
	waitbutton
	turnobject GOLDENRODGAMECORNER_CLERK, DOWN
	closetext
	end

GiveCoinCase:
	opentext
	writetext GoldenrodGameCornerGreetings1Text
	promptbutton
	verbosegiveitem COIN_CASE
	writetext GoldenrodGameCornerGreetings2Text
	givecoins 50
	promptbutton
	writetext GoldenrodGameCornerGreetings3Text
	promptbutton
	end

MoveTutorInsideScript:
	faceplayer
	opentext
	writetext MoveTutorInsideText
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_MOVETUTOR, RIGHT
	end

GoldenrodGameCornerCoinVendorScript:
	checkitem COIN_CASE
	iftrue .HasCoinCase

	scall GiveCoinCase
	closetext
	end

.HasCoinCase
	jumpstd GameCornerCoinVendorScript

GoldenrodGameCornerTMVendorScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
GoldenrodGameCornerTMVendor_LoopScript:
	special DisplayCoinCaseBalance
	loadmenu GoldenrodGameCornerTMVendorMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Thunder
	ifequal 2, .Blizzard
	ifequal 3, .FireBlast
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.Thunder:
	checkitem TM_THUNDER
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins GOLDENRODGAMECORNER_TM25_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_THUNDER
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_THUNDER
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM25_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

.Blizzard:
	checkitem TM_BLIZZARD
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins GOLDENRODGAMECORNER_TM14_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_BLIZZARD
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_BLIZZARD
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM14_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

.FireBlast:
	checkitem TM_FIRE_BLAST
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins GOLDENRODGAMECORNER_TM38_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_FIRE_BLAST
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_FIRE_BLAST
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM38_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript:
	writetext GoldenrodGameCornerPrizeVendorConfirmPrizeText
	yesorno
	end

GoldenrodGameCornerTMVendor_FinishScript:
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	sjump GoldenrodGameCornerTMVendor_LoopScript

GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript:
	writetext GoldenrodGameCornerPrizeVendorAlreadyHaveTMText
	waitbutton
	sjump GoldenrodGameCornerTMVendor_LoopScript

GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript:
	writetext GoldenrodGameCornerPrizeVendorNeedMoreCoinsText
	waitbutton
	closetext
	end

GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript:
	writetext GoldenrodGameCornerPrizeVendorNoMoreRoomText
	waitbutton
	closetext
	end

GoldenrodGameCornerPrizeVendor_CancelPurchaseScript:
	writetext GoldenrodGameCornerPrizeVendorQuitText
	waitbutton
	closetext
	end

GoldenrodGameCornerPrizeVendor_NoCoinCaseScript:
	writetext GoldenrodGameCornerPrizeVendorNoCoinCaseText
	waitbutton
	closetext
	end

GoldenrodGameCornerTMVendorMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "TM25    3000@"
	db "TM14    3000@"
	db "TM38    3000@"
	db "CANCEL@"

GoldenrodGameCornerPrizeMonVendorScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
.loop
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
	special DisplayCoinCaseBalance
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Cubone
	ifequal 2, .Abra
	ifequal 3, .Wobbuffet
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.Abra:
	checkcoins GOLDENRODGAMECORNER_ABRA_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, ABRA
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	setval ABRA
	special GameCornerPrizeMonCheckDex
	givepoke ABRA, 10
	takecoins GOLDENRODGAMECORNER_ABRA_COINS
	sjump .loop

.Cubone:
	checkcoins GOLDENRODGAMECORNER_CUBONE_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, CUBONE
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	setval CUBONE
	special GameCornerPrizeMonCheckDex
	givepoke CUBONE, 10
	takecoins GOLDENRODGAMECORNER_CUBONE_COINS
	sjump .loop

.Wobbuffet:
	checkcoins GOLDENRODGAMECORNER_DITTO_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, DITTO
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	setval DITTO
	special GameCornerPrizeMonCheckDex
	givepoke DITTO, 10
	takecoins GOLDENRODGAMECORNER_DITTO_COINS
	sjump .loop

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 17, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData: ; TO TRANSLATE
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "CUBONE      400@"
	db "ABRA        800@"
	db "DITTO      1600@"
	db "CANCEL@"

GoldenrodGameCornerPharmacistScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPharmacistText
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanM1Script:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPokefanM1Text
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_POKEFAN_M1, RIGHT
	end

GoldenrodGameCornerCooltrainerMScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .casino_illegal
	writetext GoldenrodGameCornerCooltrainerMText
	sjump .text_sequel

.casino_illegal
	writetext GoldenrodGameCornerCooltrainerMAbraText
.text_sequel
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_COOLTRAINER_M, LEFT
	end

GoldenrodGameCornerPokefanFScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPokefanFText
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_POKEFAN_F, RIGHT
	end

GoldenrodGameCornerCooltrainerFScript:
	faceplayer
	jumptext GoldenrodGameCornerCooltrainerFText

GoldenrodGameCornerGentlemanScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerGentlemanText
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_GENTLEMAN, RIGHT
	end

GoldenrodGameCornerPokefanM2Script:
	faceplayer
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .legally_open

	jumptext GoldenrodGameCornerPokefanM2Text

.legally_open
	jumptext GoldenrodGameCornerPokefanM2LegalText

GoldenrodGameCornerAbraScript:
	cry ABRA
	opentext
	writetext AbraTeleportText
	yesorno
	iffalse .No
	closetext
	playsound SFX_WARP_FROM
	special FadeOutPalettes
	waitsfx
	random 7
	ifequal 0, .FailWarp
	ifequal 1, .GoodEnoughWarp1
	ifequal 2, .GoodEnoughWarp2
	ifequal 3, .AccidentWarpNorth
	ifequal 4, .AccidentWarpWest
	ifequal 5, .AccidentWarpSouth
	warp GOLDENROD_CITY, 13, 6
	end

.FailWarp:
	warp GOLDENROD_GAME_CORNER, 16, 9
	end

.GoodEnoughWarp1:
	warp GOLDENROD_CITY, 33, 15
	end

.GoodEnoughWarp2:
	warp GOLDENROD_CITY, 3, 25
	end

.AccidentWarpNorth:
	warp ROUTE_35, 5, 15
	end

.AccidentWarpWest:
	warp ROUTE_32, 4, 52
	end

.AccidentWarpSouth:
	loadmem wDigWarpNumber, 1 ; Sets the Escape Rope and Dig destination.
	loadmem wDigMapGroup, GROUP_ROUTE_34
	loadmem wDigMapNumber, MAP_ROUTE_34
	warp ILEX_FOREST, 26, 22
	end

.No:
	closetext
	end

GoldenrodGameCornerLeftTheirDrinkScript:
	jumptext GoldenrodGameCornerLeftTheirDrinkText

GoldenrodGameCornerFrontDoorLockScript:
	jumptext GoldenrodGameCornerFrontDoorLockText

GoldenrodGameCornerSlotsMachineScript_OrTurnedOff:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse GoldenrodGameCornerSlotsMachineScript

	farsjump CeladonGameCornerMachineOffScript

GoldenrodGameCornerSlotsMachineScript:
	random 6
	ifequal 0, GoldenrodGameCornerLuckySlotsMachineScript

	farscall GoldenrodHospitalCorridorGelScript
	refreshscreen
	setval FALSE
	special SlotMachine
	closetext
	end

GoldenrodGameCornerLuckySlotsMachineScript_OrTurnedOff:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse GoldenrodGameCornerLuckySlotsMachineScript

	farsjump CeladonGameCornerMachineOffScript

GoldenrodGameCornerLuckySlotsMachineScript:
	farscall GoldenrodHospitalCorridorGelScript
	refreshscreen
	setval TRUE
	special SlotMachine
	closetext
	end

GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse GoldenrodGameCornerCardFlipMachineScript

	farsjump CeladonGameCornerMachineOffScript

GoldenrodGameCornerCardFlipMachineScript:
	farscall GoldenrodHospitalCorridorGelScript
	refreshscreen
	special CardFlip
	closetext
	end

GoldenrodGameCornerGreetings1Text: ; TO TRANSLATE
	text "First time"
	line "I see you!"

	para "Please take this!"
	done

GoldenrodGameCornerGreetings2Text: ; TO TRANSLATE
	text "I put 50 coins"
	line "inside."
	done

GoldenrodGameCornerGreetings3Text: ; TO TRANSLATE
	text "It's on the house."
	line "Enjoy the slots!"
	done

GoldenrodGameCornerGreetings4Text: ; TO TRANSLATE
	text "Oh! You should"
	line "know: to get out"
	cont "of here, ask"
	cont "the ABRA. He will"
	cont "teleport you"
	cont "somewhere far"
	cont "from here, so that"
	cont "no one can guess"
	cont "you were doing"
	cont "something illegal!"

	para "Have fun!"
	done

GoldenrodGameCornerPrizeVendorIntroText: ; AUTOTRAD
	text "Welcome!"

	para "We exchange your"
	line "game coins for"
	cont "fabulous prizes!"
	done

GoldenrodGameCornerPrizeVendorWhichPrizeText: ; AUTOTRAD
	text "Which prize would"
	line "you like?"
	done

GoldenrodGameCornerPrizeVendorConfirmPrizeText: ; AUTOTRAD
	text_ram wStringBuffer3
	text "."
	line "Is that right?"
	done

GoldenrodGameCornerPrizeVendorHereYouGoText: ; AUTOTRAD
	text "Here you go!"
	done

GoldenrodGameCornerPrizeVendorAlreadyHaveTMText: ; TO TRANSLATE
	text "But you already"
	line "own that TM!"
	done

GoldenrodGameCornerPrizeVendorNeedMoreCoinsText: ; AUTOTRAD
	text "Sorry! You need"
	line "more coins."
	done

GoldenrodGameCornerPrizeVendorNoMoreRoomText: ; AUTOTRAD
	text "Sorry. You can't"
	line "carry any more."
	done

GoldenrodGameCornerPrizeVendorQuitText: ; AUTOTRAD
	text "OK. Please save"
	line "your coins and"
	cont "come again!"
	done

GoldenrodGameCornerPrizeVendorNoCoinCaseText: ; AUTOTRAD
	text "Oh? You don't have"
	line "a COIN CASE."
	done

GoldenrodGameCornerPharmacistText:
if DEF(_CRYSTAL_AU)
	text "This machine looks"
	line "the same as the"
	cont "others."
	done
else
	text "I always play this"
	line "slot machine. It"

	para "pays out more than"
	line "others, I think."
	done
endc

GoldenrodGameCornerPokefanM1Text:
if DEF(_CRYSTAL_AU)
	text "These machines"
	line "seem different"

	para "from the ones at"
	line "CELADON CITY!"
	done
else
	text "I just love this"
	line "new slot machine."

	para "It's more of a"
	line "challenge than the"
	cont "ones in CELADON."
	done
endc

GoldenrodGameCornerCooltrainerMText: ; AUTOTRAD
if DEF(_CRYSTAL_AU)
	text "Nothing is certain"
	line "in this area."
	done
else ; TO TRANSLATE
	text "Life is a gamble."
	line "I'm going to flip"
	cont "cards till I drop!"
	done
endc

GoldenrodGameCornerPokefanFText: ; AUTOTRAD
	text "Card flip…"

if DEF(_CRYSTAL_AU)
	para "Different from the"
	line "other machines."
	done
else ; TO TRANSLATE
	para "I prefer it over"
	line "the slots because"

	para "it's easier to"
	line "figure the odds."

	para "But the payout is"
	line "much lower."
	done
endc

GoldenrodGameCornerCooltrainerMAbraText: ; TO TRANSLATE
	text "Did you just get"
	line "teleported here?"
	
	para "The ABRA's getting"
	line "exhausted."
	
	para "Using its TELEPORT"
	line "is gambling your"
	cont "life, you could"
	cont "end up stuck"
	cont "within a wall."
	
	para "You should"
	line "try again!"
	done

GoldenrodGameCornerCooltrainerFText: ; AUTOTRAD
	text "I won't quit until"
	line "I win!"
	done

GoldenrodGameCornerGentlemanText: ; AUTOTRAD
	text "I taught BLIZZARD"
	line "to my #MON."

	para "It was hard to get"
	line "enough coins for"

	para "it, but it was"
	line "worth it."
	done

GoldenrodGameCornerPokefanM2Text: ; TO TRANSLATE
	text "Playing illegally"
	line "is even more"
	cont "thrilling!"

	para "This is the most"
	line "exciting thing"

	para "I have done in"
	line "years!"

	para "Hyaaaah!"
	done

GoldenrodGameCornerPokefanM2LegalText: ; TO TRANSLATE
	text "I'm getting bored"
	line "of this place."

	para "It's not as fun as"
	line "it used to be."
	done

MoveTutorInsideText: ; AUTOTRAD
	text "Wahahah! The coins"
	line "keep rolling in!"
	done

GoldenrodGameCornerLeftTheirDrinkText: ; AUTOTRAD
	text "Someone left their"
	line "drink."

	para "It smells sweet."
	done

GoldenrodGameCornerFrontDoorLockText: ; TO TRANSLATE
	text "The front door is"
	line "locked with chains"

	para "and hidden behind"
	line "an opaque curtain."
	done

AbraTeleportText: ; TO TRANSLATE
	text "This ABRA seems"
	line "exhausted…"

	para "Teleport out of"
	line "here?"
	done

GoldenrodGameCorner_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  0, GOLDENROD_UNDERGROUND, 9
	warp_event  2, 13, GOLDENROD_CITY, 10
	warp_event  3, 13, GOLDENROD_CITY, 10

	def_coord_events
	coord_event  2,  2, CE_MISSING_ITEM, COIN_CASE,  GoldenrodGameCornerGreetingsScript

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event  6,  7, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event  6,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event  6, 11, BGEVENT_RIGHT, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  6, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event  7,  7, BGEVENT_READ, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  7,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event  7,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event  7, 11, BGEVENT_LEFT, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  6, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event 12,  7, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event 12,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript_OrTurnedOff
	bg_event 12, 11, BGEVENT_RIGHT, GoldenrodGameCornerSlotsMachineScript
	bg_event 13,  6, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff
	bg_event 13,  7, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  8, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff
	bg_event 13,  9, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13, 10, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff
	bg_event 13, 11, BGEVENT_LEFT, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  6, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff
	bg_event 18,  7, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  8, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff
	bg_event 18,  9, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 10, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript_OrTurnedOff
	bg_event 18, 11, BGEVENT_RIGHT, GoldenrodGameCornerCardFlipMachineScript
	bg_event 12,  1, BGEVENT_LEFT, GoldenrodGameCornerLeftTheirDrinkScript

	def_object_events
	object_event  4,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCoinVendorScript, -1
	object_event  4, 13, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event 16,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerTMVendorScript, -1
	object_event 18,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPrizeMonVendorScript, -1
	object_event  8,  7, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY | NITE, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	object_event 11, 11, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM1Script, -1
	object_event 14,  9, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerMScript, -1
	object_event 17,  7, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanFScript, -1
	object_event 10,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerFScript, -1
	object_event  5,  9, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerGentlemanScript, -1
	object_event  2,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM2Script, -1
	object_event 17, 11, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MoveTutorInsideScript, EVENT_GOLDENROD_GAME_CORNER_MOVE_TUTOR
	object_event  2,  7, SPRITE_ABRA, SPRITEMOVEDATA_POKEMON, 1, 1, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerAbraScript, EVENT_CINNABAR_ROCKS_CLEARED
	object_event  2, 14, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerFrontDoorLockScript, EVENT_CINNABAR_ROCKS_CLEARED
	object_event  3, 14, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerFrontDoorLockScript, EVENT_CINNABAR_ROCKS_CLEARED
