VIRTUAL_BOY_PRICE EQU 40000
N64_PRICE         EQU 18000
SNES_PRICE        EQU 12000
NES_PRICE         EQU 11000

	object_const_def
	const AKIBA1F_FAMICOM
	const AKIBA1F_VBOY
	const AKIBA1F_SNES
	const AKIBA1F_N64
	const AKIBA1F_SELLER
	const AKIBA1F_NOTE
	const AKIBA1F_REPAIR_N64
	const AKIBA1F_CLIENT_GRAMPS
	const AKIBA1F_CLIENT_BUG_CATCHER
	const AKIBA1F_CLIENT_LASS

Akiba1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .LoadTiles

.LoadTiles:
	readvar VAR_YCOORD
	ifless 3, .skip_big_doll_selection

	loadmem wJustWonBigDoll, FALSE
	callasm GetTodaysBigDoll
.skip_big_doll_selection
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue .endcallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.endcallback
	endcallback

; Returns TRUE in wScriptVar if the transaction was successfull.
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
	setval TRUE
	sjump .text_end

.cant
	setval FALSE
	writetext Akiba1F_NotEnoughMoneyText
	sjump .text_end

.refused
	setval FALSE
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
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Left1Movement
	opentext
	writetext Akiba1F_N64BuyText
	setval N64_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromLeft1Movement
	end

Akiba1F_SNESBuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Right2Movement
	turnobject AKIBA1F_SELLER, DOWN
	opentext
	writetext Akiba1F_SNESBuyText
	setval SNES_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromRightMovement
	end

Akiba1F_FamicomBuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Right2Movement
	opentext
	writetext Akiba1F_NESBuyText
	setval NES_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromRightMovement
	end

Akiba1F_BeRightBackScript:
	jumptext Akiba1F_BeRightBackText

Akiba1F_Seller_Script:
	faceplayer
	opentext

	checkflag ENGINE_RADIO_CARD
	iftrue .SkipRadioGift

	checkevent EVENT_FETCH_RADIO_CARD
	iftrue .FetchRadio

.SkipRadioGift
	checkevent EVENT_DECO_FAMICOM
	iffalse .RememberMe

	checkevent EVENT_DECO_SNES
	iffalse .RememberMe

	checkevent EVENT_DECO_N64
	iffalse .RememberMe

	checkevent EVENT_DECO_VIRTUAL_BOY
	iffalse .RememberMe

; The player has bought all the consoles.
	writetext Akiba1F_Seller_BestCustomerText
	sjump .ReturnToDesk

.RememberMe
	writetext Akiba1F_Seller_HiText
	promptbutton
	writetext Akiba1F_Seller_HiEndText

.ReturnToDesk
	waitbutton
	closetext
	pause 10
	turnobject AKIBA1F_SELLER, UP
	end

.FetchRadio
	writetext Akiba1F_Seller_HiText
	promptbutton
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
if DEF(_FR_FR)
	db "COUPON RADIO@"
else
	db "RADIO CARD@"
endc

Akiba1F_PricesUpScript:
	faceplayer
	opentext
	writetext Akiba1F_PricesUpText
	waitbutton
	closetext
	turnobject AKIBA1F_CLIENT_GRAMPS, UP
	end

Akiba1F_NoClueScript:
	faceplayer
	opentext
	writetext Akiba1F_NoClueText
	waitbutton
	closetext
	turnobject AKIBA1F_CLIENT_BUG_CATCHER, DOWN
	end

Akiba1F_TrueGemsScript:
	faceplayer
	opentext
	writetext Akiba1F_GemsText
	waitbutton
	closetext
	turnobject AKIBA1F_CLIENT_LASS, RIGHT
	end

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

Akiba1F_GameConsoleText: ; TO TRANSLATE
	text "A game console."
	line "Where's the seller?"
	done

Akiba1F_NotEnoughMoneyText: ; TO TRANSLATE
	text "I'm sorry but I"
	line "won't lower the"
	cont "price of this"
	cont "item. Come back"
	cont "with enough money."
	done

Akiba1F_TransactionCompletedText: ; TO TRANSLATE
	text "Great choice!"
	line "I will ship it to"
	cont "your home without"
	cont "delay!"
	done

Akiba1F_TransactionRefusedText: ; TO TRANSLATE
	text "Think about it."
	line "It may be gone"
	cont "next time you"
	cont "come."
	done

Akiba1F_VirtualBoyBuyText: ; TO TRANSLATE
	text "This is a super"
	line "rare VIRTUAL BOY."

	para "This portable"
	line "console got a 3<BOLD_D>"
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

Akiba1F_N64BuyText: ; TO TRANSLATE
	text "This NINTENDO 64"
	line "is the special"
	cont "Pikachu edition."

	para "A very bold design"
	line "for a game console"
	cont "don't you think?"

	para "The illuminating"
	line "cheeks are a nice"
	cont "touch, and the"
	cont "foot button is"
	cont "so cute!"

	para "It's yours for"
	line "¥{d:N64_PRICE}."
	done

Akiba1F_SNESBuyText: ; TO TRANSLATE
	text "The SUPER NINTENDO"
	line "ENTERTAINMENT"
	cont "SYSTEM is the"
	cont "successor of the"
	cont "NES as you would"
	cont "have guessed."

	para "It's a legendary"
	line "console… that I"
	cont "never played."

	para "You can have it"
	line "for ¥{d:SNES_PRICE}."
	done

Akiba1F_NESBuyText: ; TO TRANSLATE
	text "The Famicom is the"
	line "Japanese version"
	cont "of the NINTENDO"
	cont "ENTERTAINMENT"
	cont "SYSTEM."

	para "Unfortunately I"
	line "don't have R.O.B."
	cont "the robot it was"
	cont "advertised with."

	para "I'm selling it for"
	line "¥{d:NES_PRICE}."
	done

Akiba1F_BeRightBackText: ; TO TRANSLATE
	text "I'm in CELADON,"
	line "I'll be right back."
	done

Akiba1F_Seller_HiText: ; TO TRANSLATE
	text "Oh hi!"

	para "We met at "
	line "GAME FREAK's,"
	cont "remember me?"
	done

Akiba1F_Seller_HiEndText: ; TO TRANSLATE
	text "Feel free to snoop"
	line "around my shop!"
	done

Akiba1F_Seller_BestCustomerText: ; TO TRANSLATE
	text "Hey! Isn't this my"
	line "best customer?"

	para "Thank you for"
	line "supporting"
	cont "retro gaming."

	para "I'd like to share a"
	line "thought with you."

	para "We all know that"
	line "matter is made of"
	cont "pixels, which"
	cont "interact under the"
	cont "laws of the source"
	cont "code and its bits."

	para "But what if all of"
	line "it is a simulation"
	cont "created by higher"
	cont "beings?"

	para "How would we"
	line "ever know?"

	para "Could we interact"
	line "with their"
	cont "reality?"

	para "…"

	para "I wonder."
	done

Akiba1F_Seller_RadioText: ; TO TRANSLATE
	text "My friend the"
	line "MUSIC DIRECTOR"
	cont "sent you? I see."

	para "Here's a RADIO CARD"
	line "for your #GEAR,"
	cont "free of charge!"
	done

Akiba1F_Inventory1Text: ; TO TRANSLATE
	text "Adrenaline and"
	line "testosterone:"

	para "Devil may cry"
	done
	
Akiba1F_Inventory2Text: ; TO TRANSLATE
	text "Golden Sun 1 & 2!"
	line "A must play!"
	done

Akiba1F_Inventory3Text: ; TO TRANSLATE
	text "Some #GEAR "
	line "parts."
	done

Akiba1F_Inventory4Text: ; TO TRANSLATE
	text "Radio parts."
	done

Akiba1F_Inventory5Text: ; TO TRANSLATE
	text "Tamagotchis"
	line "everywhere!"
	done

Akiba1F_Inventory6Text: ; TO TRANSLATE
	text "Pocket Pikachu 2!"
	line "This one connects"
	cont "with the #MON"
	cont "games on the"
	cont "Game Boy Color."
	done

Akiba1F_Inventory7Text: ; TO TRANSLATE
	text "The PC game"
	line "Impossible"
	cont "Creatures."
	done

Akiba1F_Inventory8Text: ; TO TRANSLATE
	text "Zeus: Master of"
	line "Olympus"
	cont "on CD-ROM."
	done

Akiba1F_Inventory9Text: ; TO TRANSLATE
	text "There's a MAGNEMITE"
	line "chilling in"
	cont "this bin."
	done

Akiba1F_Inventory10Text: ; TO TRANSLATE
	text "A cartridge of the"
	line "final release of"
	cont "Coral Version."
	done

Akiba1F_Inventory11Text: ; TO TRANSLATE
	text "Hey that's"
	line "Polished Crystal!"
	done

Akiba1F_Inventory12Text: ; TO TRANSLATE
	text "Insaniquarium"
	line "on CD-ROM."
	done

Akiba1F_Inventory13Text: ; TO TRANSLATE
	text "Morrowind"
	line "on CD-ROM."
	done

Akiba1F_Inventory14Text: ; TO TRANSLATE
	text "Rare Game Boy"
	line "games for"
	cont "very cheap!"
	done

Akiba1F_Inventory15Text: ; TO TRANSLATE
	text "A Super Mario Bros"
	line "Crystal Screen"
	cont "Game & Watch!"
	done

Akiba1F_Inventory16Text: ; TO TRANSLATE
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

Akiba1F_Inventory17Text: ; TO TRANSLATE
	text "Copies of The"
	line "Legend of Zelda"
	cont "for the Game Boy"
	cont "and Game Boy Color"
	cont "consoles. Nice."
	done

Akiba1F_Inventory18Text: ; TO TRANSLATE
	text "A Game Boy game"
	line "for McDonald's"
	cont "employees?"
	done

Akiba1F_Inventory19Text: ; TO TRANSLATE
	text "Pinball circuit"
	line "boards!"
	done

Akiba1F_Inventory20Text: ; TO TRANSLATE
	text "Some junk 5V 2MB"
	line "TSOP-48 flash"
	cont "chips."
	done
	
Akiba1F_Inventory21Text: ; TO TRANSLATE
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

Akiba1F_Inventory22Text: ; TO TRANSLATE
	text "Soldering hot"
	line "plates, tweezers…"
	done

Akiba1F_Inventory23Text: ; TO TRANSLATE
	text "Rayman 2: The"
	line "Great Escape."
	done

Akiba1F_Inventory24Text: ; TO TRANSLATE
	text "Great versus fun:"
	line "The Next Tetris"
	cont "on PlayStation."
	done

Akiba1F_Inventory25Text: ; TO TRANSLATE
	text "Second Sight"
	line "on PlayStation 2."
	done

Akiba1F_Inventory26Text: ; TO TRANSLATE
	text "They even sell"
	line "board games!"

	para "They have Pokémon"
	line "Master Trainer."
	done

Akiba1F_Inventory27Text: ; TO TRANSLATE
	text "3 games in 1:"
	line "Mega Games 2"
	cont "on Mega Drive."
	done

Akiba1F_Inventory28Text: ; TO TRANSLATE
	text "Mickey Mania."
	done

Akiba1F_PricesUpText: ; TO TRANSLATE
	text "I like my games in"
	line "physical format."
	
	para "This way, I truly"
	line "own them."
	
	para "No company can"
	line "take those from"
	cont "me."
	done

Akiba1F_NoClueText: ; TO TRANSLATE
	text "I have no clue"
	line "what this is…"
	done

Akiba1F_GemsText: ; TO TRANSLATE
	text "You can find true"
	line "gems in here!"
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
	object_event 11,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba1F_PricesUpScript, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  0,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, LOW(%11100000 | MORN | DAY), PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Akiba1F_NoClueScript, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  9,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, LOW(%11100000 | DAY | NITE), PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Akiba1F_TrueGemsScript, EVENT_CONSOLE_SELLER_BACK_IN_STORE
