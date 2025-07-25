CARPET_PRICE EQU 6000
	
	object_const_def
	const CARPETSHOP_SELLER

CarpetShop_MapScripts:
	def_scene_scripts

	def_callbacks

CarpetSellerScript:
	faceplayer
	opentext
	writetext CarpetSeller_WelcomeText
	special PlaceMoneyTopLeft
CarpetShop_LoopScript:
	loadmenu CarpetShopMenu
	verticalmenu
	closewindow
	ifequal 1, .Carpet1
	ifequal 2, .Carpet2
	ifequal 3, .Carpet3
	ifequal 4, .Carpet4
	sjump CarpetShop_CancelScript

.AlreadyHaveDecorItem
	writetext CarpetShop_AlreadyHaveDecoText
	waitbutton
	sjump CarpetShop_LoopScript
	
.Carpet1
	scall CarpetShop_BuyRoutine
	ifequal HAVE_LESS, CarpetShop_NotEnoughMoneyScript

	checkevent EVENT_DECO_CARPET_1
	iftrue .AlreadyHaveDecorItem
	setevent EVENT_DECO_CARPET_1
	sjump .CarpetBuyValidated
	
.Carpet2
	scall CarpetShop_BuyRoutine
	ifequal HAVE_LESS, CarpetShop_NotEnoughMoneyScript

	checkevent EVENT_DECO_CARPET_2
	iftrue .AlreadyHaveDecorItem
	setevent EVENT_DECO_CARPET_2
	sjump .CarpetBuyValidated
	
.Carpet3
	scall CarpetShop_BuyRoutine
	ifequal HAVE_LESS, CarpetShop_NotEnoughMoneyScript

	checkevent EVENT_DECO_CARPET_3
	iftrue .AlreadyHaveDecorItem
	setevent EVENT_DECO_CARPET_3
	sjump .CarpetBuyValidated

.Carpet4
	scall CarpetShop_BuyRoutine
	ifequal HAVE_LESS, CarpetShop_NotEnoughMoneyScript

	checkevent EVENT_DECO_CARPET_4
	iftrue .AlreadyHaveDecorItem
	setevent EVENT_DECO_CARPET_4
.CarpetBuyValidated
	takemoney YOUR_MONEY, CARPET_PRICE
	waitsfx
	playsound SFX_TRANSACTION
	special PlaceMoneyTopLeft
	farwritetext Akiba1F_TransactionCompletedText
	waitbutton
	sjump CarpetShop_LoopScript

CarpetShop_BuyRoutine:
	writetext CarpetShop_AreYouSureText
	yesorno
	iffalse CarpetShop_CancelScript
	checkmoney YOUR_MONEY, CARPET_PRICE	
	end

CarpetShop_CancelScript:
	writetext CarpetShop_CancelText
	waitbutton
	closetext
	end

CarpetShop_NotEnoughMoneyScript:
	farwritetext _MartNoMoneyText
	waitbutton
	closetext
	end

CarpetShopMenu:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 0, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 5 ; items
if DEF(_FR_FR)
	db "ROUGE@"
	db "BLEU@"
	db "JAUNE@"
	db "VERT@"
	db "RETOUR@"
else
	db "RED@"
	db "BLUE@"
	db "YELLOW@"
	db "GREEN@"
	db "CANCEL@"
endc

CarpetShopBookshelf:
	jumpstd PictureBookshelfScript

CarpetSeller_WelcomeText:
if DEF(_FR_FR)
	text "Bienvenue!"

	para "Je vends des"
	line "tapis faits main."
	done
else
	text "Hello dear"
	line "customer!"

	para "I sell handmade"
	line "carpets."
	done
endc

CarpetShop_AlreadyHaveDecoText:
if DEF(_FR_FR)
	text "Tu possèdes déjà"
	line "celui-ci."
	done
else
	text "You already have"
	line "this one."
	done
endc

CarpetShop_AreYouSureText:
if DEF(_FR_FR)
	text "Le prix est"
	line "{d:CARPET_PRICE}¥."
	done
else
	text "The price is"
	line "¥{d:CARPET_PRICE}."
	done
endc

CarpetShop_CancelText:
if DEF(_FR_FR)
	text "Prends ton temps."
	done
else
	text "Take your time."
	done
endc

CarpetShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 19
	warp_event  4,  7, ECRUTEAK_CITY, 19

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, CarpetShopBookshelf
	bg_event  7,  1, BGEVENT_READ, CarpetShopBookshelf

	def_object_events
	object_event  3,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CarpetSellerScript, -1
