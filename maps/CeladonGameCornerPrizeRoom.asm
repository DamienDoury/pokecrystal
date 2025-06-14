CELADONGAMECORNERPRIZEROOM_TM32_COINS EQU 1500
CELADONGAMECORNERPRIZEROOM_TM15_COINS EQU 5500
CELADONGAMECORNERPRIZEROOM_PIKACHU_COINS  EQU 2222
CELADONGAMECORNERPRIZEROOM_PORYGON_COINS  EQU 5555
CELADONGAMECORNERPRIZEROOM_LARVITAR_COINS EQU 8888

	object_const_def
	const CELADONGAMECORNERPRIZEROOM_GENTLEMAN
	const CELADONGAMECORNERPRIZEROOM_VP_CONTROLLER
	const CELADONGAMECORNERPRIZEROOM_PHARMACIST

CeladonGameCornerPrizeRoom_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

CeladonGameCornerPrizeRoomGentlemanScript:
	jumptextfaceplayer CeladonGameCornerPrizeRoomGentlemanText

CeladonGameCornerPrizeRoomPharmacistScript:
	jumptextfaceplayer CeladonGameCornerPrizeRoomPharmacistText

CeladonGameCornerPrizeRoomTMVendor:
	faceplayer
	opentext
	writetext CeladonPrizeRoom_PrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse CeladonPrizeRoom_NoCoinCase
	writetext CeladonPrizeRoom_AskWhichPrizeText
CeladonPrizeRoom_tmcounterloop:
	special DisplayCoinCaseBalance
	loadmenu CeladonPrizeRoom_TMMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .DoubleTeam
	ifequal 2, .HyperBeam
	sjump CeladonPrizeRoom_CancelPurchaseScript

.DoubleTeam:
	checkitem TM_DOUBLE_TEAM
	iftrue CeladonPrizeRoom_alreadyhavetm
	checkcoins CELADONGAMECORNERPRIZEROOM_TM32_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	getitemname STRING_BUFFER_3, TM_DOUBLE_TEAM
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	giveitem TM_DOUBLE_TEAM
	takecoins CELADONGAMECORNERPRIZEROOM_TM32_COINS
	sjump CeladonPrizeRoom_purchased

.HyperBeam:
	checkitem TM_HYPER_BEAM
	iftrue CeladonPrizeRoom_alreadyhavetm
	checkcoins CELADONGAMECORNERPRIZEROOM_TM15_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	getitemname STRING_BUFFER_3, TM_HYPER_BEAM
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	giveitem TM_HYPER_BEAM
	takecoins CELADONGAMECORNERPRIZEROOM_TM15_COINS
	sjump CeladonPrizeRoom_purchased

CeladonPrizeRoom_askbuy:
	writetext CeladonPrizeRoom_ConfirmPurchaseText
	yesorno
	end

CeladonPrizeRoom_purchased:
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	sjump CeladonPrizeRoom_tmcounterloop

CeladonPrizeRoom_alreadyhavetm:
	farwritetext GoldenrodGameCornerPrizeVendorAlreadyHaveTMText
	waitbutton
	sjump CeladonPrizeRoom_tmcounterloop

CeladonPrizeRoom_notenoughcoins:
	writetext CeladonPrizeRoom_NotEnoughCoinsText
	waitbutton
	closetext
	end

CeladonPrizeRoom_notenoughroom:
	writetext CeladonPrizeRoom_NotEnoughRoomText
	waitbutton
	closetext
	end

CeladonPrizeRoom_CancelPurchaseScript:
	writetext CeladonPrizeRoom_ComeAgainText
	waitbutton
	closetext
	end

CeladonPrizeRoom_NoCoinCase:
	writetext CeladonPrizeRoom_NoCoinCaseText
	waitbutton
	closetext
	end

CeladonPrizeRoom_TMMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
if DEF(_FR_FR)
	db "CT32    {d:CELADONGAMECORNERPRIZEROOM_TM32_COINS}@"
	db "CT15    {d:CELADONGAMECORNERPRIZEROOM_TM15_COINS}@"
	db "RETOUR@"
else
	db "TM32    {d:CELADONGAMECORNERPRIZEROOM_TM32_COINS}@"
	db "TM15    {d:CELADONGAMECORNERPRIZEROOM_TM15_COINS}@"
	db "CANCEL@"
endc

CeladonGameCornerPrizeRoomPokemonVendor:
	faceplayer
	opentext
	writetext CeladonPrizeRoom_PrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse CeladonPrizeRoom_NoCoinCase
.loop
	writetext CeladonPrizeRoom_AskWhichPrizeText
	special DisplayCoinCaseBalance
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Pikachu
	ifequal 2, .Porygon
	ifequal 3, .Larvitar
	sjump CeladonPrizeRoom_CancelPurchaseScript

.Pikachu:
	checkcoins CELADONGAMECORNERPRIZEROOM_PIKACHU_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, CeladonPrizeRoom_notenoughroom
	getmonname STRING_BUFFER_3, PIKACHU
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	setval PIKACHU
	special GameCornerPrizeMonCheckDex
	givepoke PIKACHU, 25
	takecoins CELADONGAMECORNERPRIZEROOM_PIKACHU_COINS
	sjump .loop

.Porygon:
	checkcoins CELADONGAMECORNERPRIZEROOM_PORYGON_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, CeladonPrizeRoom_notenoughroom
	getmonname STRING_BUFFER_3, PORYGON
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	setval PORYGON
	special GameCornerPrizeMonCheckDex
	givepoke PORYGON, 15
	takecoins CELADONGAMECORNERPRIZEROOM_PORYGON_COINS
	sjump .loop

.Larvitar:
	checkcoins CELADONGAMECORNERPRIZEROOM_LARVITAR_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, CeladonPrizeRoom_notenoughroom
	getmonname STRING_BUFFER_3, LARVITAR
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	setval LARVITAR
	special GameCornerPrizeMonCheckDex
	givepoke LARVITAR, 40
	takecoins CELADONGAMECORNERPRIZEROOM_LARVITAR_COINS
	sjump .loop

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 17, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "PIKACHU    {d:CELADONGAMECORNERPRIZEROOM_PIKACHU_COINS}@"
	db "PORYGON    {d:CELADONGAMECORNERPRIZEROOM_PORYGON_COINS}@"
	db "EMBRYLEX   {d:CELADONGAMECORNERPRIZEROOM_LARVITAR_COINS}@"
	db "RETOUR@"
else
	db "PIKACHU    {d:CELADONGAMECORNERPRIZEROOM_PIKACHU_COINS}@"
	db "PORYGON    {d:CELADONGAMECORNERPRIZEROOM_PORYGON_COINS}@"
	db "LARVITAR   {d:CELADONGAMECORNERPRIZEROOM_LARVITAR_COINS}@"
	db "CANCEL@"
endc

CeladonGameCornerPrizeRoomGentlemanText: 
if DEF(_FR_FR)
	text "Je voulais PORYGON"
	line "mais il me manque"
	cont "100 jetons..."
else
	text "I wanted PORYGON,"
	line "but I was short by"
	cont "100 coins…"
endc

	done

CeladonGameCornerPrizeRoomPharmacistText:
if DEF(_FR_FR)
	text "Fouiii..."

	para "Faut que je reste"
	line "cool..."

	para "Si je m'énerve,"
	line "je vais perdre"
	cont "une fortune..."
	done
else
	text "Whew…"

	para "I've got to stay"
	line "calm and cool…"

	para "I can't lose my"
	line "cool, or I'll lose"
	cont "all my money…"
	done
endc

CeladonPrizeRoom_PrizeVendorIntroText: 
if DEF(_FR_FR)
	text "Bienvenue!"

	para "On échange les"
	line "jetons contre"

	para "de bô prix!"
else
	text "Welcome!"

	para "We exchange your"
	line "coins for fabulous"
	cont "prizes!"
endc

	done

CeladonPrizeRoom_AskWhichPrizeText: 
if DEF(_FR_FR)
	text "Quel prix?"
else
	text "Which prize would"
	line "you like?"
endc

	done

CeladonPrizeRoom_ConfirmPurchaseText: 
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text ","
	line "c'est sûr?"
else
	text "OK, so you wanted"
	line "a @"
	text_ram wStringBuffer3
	text "?"
endc

	done

CeladonPrizeRoom_HereYouGoText: 
if DEF(_FR_FR)
	text "Et voilà!"
else
	text "Here you go!"
endc

	done

CeladonPrizeRoom_NotEnoughCoinsText: 
if DEF(_FR_FR)
	text "Pas assez de"
	line "jetons."
else
	text "You don't have"
	line "enough coins."
endc

	done

CeladonPrizeRoom_NotEnoughRoomText: 
if DEF(_FR_FR)
	text "Pas de place."
else
	text "You have no room"
	line "for it."
endc

	done

CeladonPrizeRoom_ComeAgainText: 
if DEF(_FR_FR)
	text "Oh. Il faut amener"
	line "tous les jetons!"
else
	text "Oh. Please come"
	line "back with coins!"
endc

	done

CeladonPrizeRoom_NoCoinCaseText: 
if DEF(_FR_FR)
	text "Oh? Pas de"
	line "BOITE JETON!"
else
	text "Oh? You don't have"
	line "a COIN CASE."
endc

	done

CeladonGameCornerPrizeRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  5, CELADON_CITY, 7
	warp_event  3,  5, CELADON_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, CeladonGameCornerPrizeRoomTMVendor
	bg_event  4,  1, BGEVENT_READ, CeladonGameCornerPrizeRoomPokemonVendor

	def_object_events
	object_event  0,  2, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerPrizeRoomGentlemanScript, -1
	object_event  0,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  4,  4, SPRITE_PHARMACIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerPrizeRoomPharmacistScript, -1
