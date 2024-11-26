VIRTUAL_BOY_PRICE EQU 60000

	object_const_def
	const AKIBA1F_FAMICOM
	const AKIBA1F_VBOY
	const AKIBA1F_SNES
	const AKIBA1F_N64
	const AKIBA1F_SELLER
	const AKIBA1F_NOTE
	const AKIBA1F_REPAIR_N64

Akiba1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .LoadTiles

.LoadTiles:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue .endcallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.endcallback
	endcallback

Akiba1F_FamicomBuyScript:
	jumptext Akiba1F_FamicomBuyText

Akiba1F_SNESBuyScript:
	jumptext Akiba1F_SNESBuyText

Akiba1F_BuyingProcess:
	special PlaceMoneyTopRight
	writemem wTempByteValue ; Backs up the price of the item, that will be overwritten by the result of yesorno.
	yesorno
	iffalse .refused

	; Checking the player's money.
	readmem wTempByteValue ; Retrieves the price of the item.
	checkmoney YOUR_MONEY, $ffffff
	ifequal HAVE_LESS, .cant

	; Buying.
	playsound SFX_TRANSACTION
	readmem wTempByteValue ; Retrieves the price of the item.
	takemoney YOUR_MONEY, $ffffff
	special PlaceMoneyTopRight
	waitsfx
	disappear LAST_TALKED ; This is the action that adds the item to the player's inventory.
	writetext Akiba1F_TransactionCompletedText
	sjump .text_end

.cant
	writetext Akiba1F_NotEnoughMoneyText
	sjump .text_end

.refused
	writetext Akiba1F_TransactionRefusedText
.text_end
	loadmem wTempByteValue, 0
	waitbutton
	closetext
	end

Akiba1F_GameConsoleNoSeller:
	jumptext Akiba1F_GameConsoleText

Akiba1F_VirtualBoyBuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Left3Movement
	opentext
	writetext Akiba1F_VirtualBoyBuyText
	setval VIRTUAL_BOY_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromLeft3Movement
	end

Akiba1F_N64BuyScript:
	jumptext Akiba1F_N64BuyText

Akiba1F_BeRightBackScript:
	jumptext Akiba1F_BeRightBackText

Akiba1F_Seller_Script:
	faceplayer
	opentext
	writetext Akiba1F_Seller_HiText
	promptbutton

	checkflag ENGINE_RADIO_CARD
	iftrue .SkipRadioGift

	checkevent EVENT_FETCH_RADIO_CARD
	iftrue .FetchRadio

.SkipRadioGift
	writetext Akiba1F_Seller_HiEndText
	waitbutton
	closetext
	pause 10
	turnobject AKIBA1F_SELLER, UP
	end

.FetchRadio
	closetext
	pause 5
	showemote EMOTE_QUESTION, AKIBA1F_SELLER, 15
	pause 5
	opentext
	writetext Akiba1F_Seller_RadioText
	promptbutton
	getstring STRING_BUFFER_4, .RadioCardText
	callstd ReceiveItemScript
	farwritetext RadioTower1FPokegearIsARadioText
	waitbutton
	setflag ENGINE_RADIO_CARD
	clearevent EVENT_FETCH_RADIO_CARD
	closetext
	end

.RadioCardText:
	db "RADIO CARD@"

Akiba1F_Inventory1:
	jumptext Akiba1F_Inventory1Text

Akiba1F_Inventory2:
	jumptext Akiba1F_Inventory2Text

Akiba1F_Inventory3:
	jumptext Akiba1F_Inventory3Text

Akiba1F_Inventory4:
	jumptext Akiba1F_Inventory4Text

Akiba1F_Inventory5:
	jumptext Akiba1F_Inventory5Text

Akiba1F_Inventory6:
	jumptext Akiba1F_Inventory6Text

Akiba1F_Inventory7:
	jumptext Akiba1F_Inventory7Text

Akiba1F_Inventory8:
	jumptext Akiba1F_Inventory8Text

Akiba1F_Inventory9:
	cry MAGNEMITE
	jumptext Akiba1F_Inventory9Text

Akiba1F_Inventory10:
	jumptext Akiba1F_Inventory10Text

Akiba1F_Inventory11:
	jumptext Akiba1F_Inventory11Text

Akiba1F_Inventory12:
	jumptext Akiba1F_Inventory12Text

Akiba1F_Inventory13:
	jumptext Akiba1F_Inventory13Text

Akiba1F_Inventory14:
	jumptext Akiba1F_Inventory14Text

Akiba1F_Inventory15:
	jumptext Akiba1F_Inventory15Text

Akiba1F_Inventory16:
	jumptext Akiba1F_Inventory16Text

Akiba1F_Inventory17:
	jumptext Akiba1F_Inventory17Text

Akiba1F_Inventory18:
	jumptext Akiba1F_Inventory18Text
	
Akiba1F_Inventory19:
	jumptext Akiba1F_Inventory19Text

Akiba1F_Inventory20:
	jumptext Akiba1F_Inventory20Text

Akiba1F_Inventory21:
	jumptext Akiba1F_Inventory21Text

Akiba1F_Inventory22:
	jumptext Akiba1F_Inventory22Text

Akiba1F_Inventory23:
	jumptext Akiba1F_Inventory23Text

Akiba1F_Inventory24:
	jumptext Akiba1F_Inventory24Text

Akiba1F_Inventory25:
	jumptext Akiba1F_Inventory25Text

Akiba1F_Inventory26:
	jumptext Akiba1F_Inventory26Text

Akiba1F_Inventory27:
	jumptext Akiba1F_Inventory27Text

Akiba1F_Inventory28:
	jumptext Akiba1F_Inventory28Text

Akiba1F_Left3Movement:
	step LEFT
	step LEFT
Akiba1F_Left1Movement:
	step LEFT
	turn_head DOWN
	step_end

Akiba1F_Right2Movement:
	step RIGHT
	step RIGHT
	step_end

Akiba1F_BackToChairFromLeft3Movement:
	step RIGHT
	step RIGHT
Akiba1F_BackToChairFromLeft1Movement:
	step RIGHT
	turn_head UP
	step_end

Akiba1F_BackToChairFromRightMovement:
	step LEFT
	step LEFT
	turn_head UP
	step_end

Akiba1F_GameConsoleText:
	text "A game console."
	line "Where's the seller?"
	done

Akiba1F_NotEnoughMoneyText:
	text "I'm sorry but I"
	line "won't lower the"
	cont "price of this"
	cont "item. Come back"
	cont "with enough money."
	done

Akiba1F_TransactionCompletedText:
	text "Great choice!"
	line "I will ship it to"
	cont "your home without"
	cont "delay!"
	done

Akiba1F_TransactionRefusedText:
	text "Think about it."
	line "It may be gone"
	cont "next time you"
	cont "come."
	done

Akiba1F_FamicomBuyText:
	text "Famicom"
	done

Akiba1F_SNESBuyText:
	text "Super NES"
	done

Akiba1F_VirtualBoyBuyText:
	text "This is a super"
	line "rare VIRTUAL BOY."

	para "This portable"
	line "console got a 3D"
	cont "screen before the"
	cont "Game Boy Color"
	cont "was even born."

	para "Only 770 000 units"
	line "were sold during"
	cont "its single year of"
	cont "lifetime."

	para "You can join the"
	line "happy few club"
	cont "for ¥{d:VIRTUAL_BOY_PRICE}."
	done

Akiba1F_N64BuyText:
	text "Nintendo 64"
	done

Akiba1F_BeRightBackText:
	text "I'm in CELADON,"
	line "I'll be right back."
	done

Akiba1F_Seller_HiText:
	text "Oh hi!"

	para "We met at "
	line "GAME FREAK's,"
	cont "remember me?"
	done

Akiba1F_Seller_HiEndText:
	text "Feel free to snoop"
	line "around my shop!"
	done

Akiba1F_Seller_RadioText:
	text "My friend the"
	line "MUSIC DIRECTOR"
	cont "sent you? I see."

	para "Here's a RADIO CARD"
	line "for your #GEAR,"
	cont "free of charge!"
	done

Akiba1F_Inventory1Text:
	text "Adrenaline and"
	line "testosterone:"

	para "Devil may cry"
	done
	
Akiba1F_Inventory2Text:
	text "Golden Sun 1 & 2!"
	line "A must play!"
	done

Akiba1F_Inventory3Text:
	text "Some #GEAR "
	line "parts."
	done

Akiba1F_Inventory4Text:
	text "Radio parts."
	done

Akiba1F_Inventory5Text:
	text "Tamagotchis"
	line "everywhere!"
	done

Akiba1F_Inventory6Text:
	text "Pocket Pikachu 2!"
	line "This one connects"
	cont "with the #MON"
	cont "games on the"
	cont "Game Boy Color."
	done

Akiba1F_Inventory7Text:
	text "The PC game"
	line "Impossible"
	cont "Creatures."
	done

Akiba1F_Inventory8Text:
	text "Zeus: Master of"
	line "Olympus"
	cont "on CD-ROM."
	done

Akiba1F_Inventory9Text:
	text "There's a MAGNEMITE"
	line "chilling in"
	cont "this bin."
	done

Akiba1F_Inventory10Text:
	text "A cartridge of the"
	line "final release of"
	cont "Coral Version."
	done

Akiba1F_Inventory11Text:
	text "Hey that's"
	line "Polished Crystal!"
	done

Akiba1F_Inventory12Text:
	text "Insaniquarium"
	line "on CD-ROM."
	done

Akiba1F_Inventory13Text:
	text "Morrowind"
	line "on CD-ROM."
	done

Akiba1F_Inventory14Text:
	text "Rare Game Boy"
	line "games for"
	cont "very cheap!"
	done

Akiba1F_Inventory15Text:
	text "A Super Mario Bros"
	line "Crystal Screen"
	cont "Game & Watch!"
	done

Akiba1F_Inventory16Text:
	text "Lots of weird"
	line "accessories for"
	cont "the Game Boy."

	para "The Mobile Adapter"
	line "GB cable, a pocket"
	cont "printer, a barcode"
	cont "reader, a…"
	cont "fishing sonar, a"
	cont "sewing machine,"
	cont "and…"

	para "…a blood sugar"
	line "tester?"
	done

Akiba1F_Inventory17Text:
	text "Copies of The"
	line "Legend of Zelda"
	cont "for the Game Boy"
	cont "and Game Boy Color"
	cont "consoles. Nice."
	done

Akiba1F_Inventory18Text:
	text "A Game Boy game"
	line "for McDonald's"
	cont "employees?"
	done

Akiba1F_Inventory19Text:
	text "Pinball circuit"
	line "boards!"
	done

Akiba1F_Inventory20Text:
	text "Some junk 5V 2MB"
	line "TSOP-48 flash"
	cont "chips."
	done
	
Akiba1F_Inventory21Text:
	text "A copy of Tetris"
	line "for the Game Boy."

	para "A very common"
	line "and cheap game."
	
	para "Its sticker looks"
	line "slightly off, and"
	cont "the engraved 'A'"
	cont "is missing."
	
	para "Must be defective."
	line "Better pass."
	done

Akiba1F_Inventory22Text:
	text "Soldering hot"
	line "plates, tweezers…"
	done

Akiba1F_Inventory23Text:
	text "Rayman: The Great"
	line "Escape."
	done

Akiba1F_Inventory24Text:
	text "Great versus fun:"
	line "The Next Tetris"
	cont "on PlayStation."
	done

Akiba1F_Inventory25Text:
	text "Second Sight"
	line "on PlayStation 2."
	done

Akiba1F_Inventory26Text:
	text "They even sell"
	line "board games!"

	para "They have Pokémon"
	line "Master Trainer."
	done

Akiba1F_Inventory27Text:
	text "3 games in 1:"
	line "Mega Games 2"
	cont "on Mega Drive."
	done

Akiba1F_Inventory28Text:
	text "Mickey Mania."
	done

Akiba1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, SAFFRON_CITY, 18
	warp_event  7,  9, SAFFRON_CITY, 18
	warp_event 11,  0, AKIBA_2F, 1

	def_coord_events

	def_bg_events
	bg_event 11,  5, BGEVENT_READ, Akiba1F_Inventory1
	bg_event  4,  7, BGEVENT_READ, Akiba1F_Inventory2
	bg_event 10,  9, BGEVENT_READ, Akiba1F_Inventory3
	bg_event 11,  9, BGEVENT_READ, Akiba1F_Inventory3
	bg_event  8,  9, BGEVENT_READ, Akiba1F_Inventory4
	bg_event  9,  9, BGEVENT_READ, Akiba1F_Inventory4
	bg_event  4,  9, BGEVENT_READ, Akiba1F_Inventory5
	bg_event  5,  9, BGEVENT_READ, Akiba1F_Inventory5
	bg_event  3,  9, BGEVENT_READ, Akiba1F_Inventory6
	bg_event 10,  3, BGEVENT_READ, Akiba1F_Inventory7
	bg_event 11,  3, BGEVENT_READ, Akiba1F_Inventory8
	bg_event  0,  9, BGEVENT_READ, Akiba1F_Inventory9
	bg_event  6,  7, BGEVENT_READ, Akiba1F_Inventory10
	bg_event  7,  7, BGEVENT_READ, Akiba1F_Inventory11
	bg_event 10,  2, BGEVENT_READ, Akiba1F_Inventory12
	bg_event 11,  2, BGEVENT_READ, Akiba1F_Inventory13
	bg_event  8,  7, BGEVENT_READ, Akiba1F_Inventory14
	bg_event  9,  7, BGEVENT_READ, Akiba1F_Inventory14
	bg_event  1,  9, BGEVENT_READ, Akiba1F_Inventory15
	bg_event  2,  9, BGEVENT_READ, Akiba1F_Inventory16
	bg_event  5,  7, BGEVENT_READ, Akiba1F_Inventory17
	bg_event  2,  7, BGEVENT_READ, Akiba1F_Inventory18
	bg_event  2,  5, BGEVENT_READ, Akiba1F_Inventory19
	bg_event  0,  5, BGEVENT_READ, Akiba1F_Inventory20
	bg_event  3,  7, BGEVENT_READ, Akiba1F_Inventory21
	bg_event  1,  5, BGEVENT_READ, Akiba1F_Inventory22
	bg_event  8,  5, BGEVENT_READ, Akiba1F_Inventory23
	bg_event  9,  5, BGEVENT_READ, Akiba1F_Inventory24
	bg_event 10,  5, BGEVENT_READ, Akiba1F_Inventory25
	bg_event  3,  5, BGEVENT_READ, Akiba1F_Inventory26
	bg_event  7,  5, BGEVENT_READ, Akiba1F_Inventory27
	bg_event  6,  5, BGEVENT_READ, Akiba1F_Inventory28

	def_object_events
	object_event  7,  2, SPRITE_FAMICOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_FamicomBuyScript, EVENT_DECO_FAMICOM
	object_event  1,  3, SPRITE_VIRTUAL_BOY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_VirtualBoyBuyScript, EVENT_DECO_VIRTUAL_BOY
	object_event  6,  3, SPRITE_SNES, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_SNESBuyScript, EVENT_DECO_SNES
	object_event  3,  3, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_N64BuyScript, EVENT_DECO_N64
	object_event  4,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba1F_Seller_Script, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  5,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_BeRightBackScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4,  1, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CONSOLE_SELLER_BACK_IN_STORE
