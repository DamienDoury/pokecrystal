	const_def
	const MARTTEXT_HOW_MANY
	const MARTTEXT_COSTS_THIS_MUCH
	const MARTTEXT_NOT_ENOUGH_MONEY
	const MARTTEXT_BAG_FULL
	const MARTTEXT_HERE_YOU_GO
	const MARTTEXT_SOLD_OUT

OpenMartDialog::
	call GetMart
	ld a, c
	ld [wMartType], a
	call LoadMartPointer
	ld a, [wMartType]
	ld hl, .dialogs
	rst JumpTable
	ret

.dialogs
	dw MartDialog
	dw HerbShop
	dw BargainShop
	dw Pharmacist
	dw RooftopSale
	dw StoneShop

MartDialog:
	ld a, MARTTYPE_STANDARD
	ld [wMartType], a
	xor a ; STANDARDMART_HOWMAYIHELPYOU
	ld [wMartJumptableIndex], a
	jmp StandardMart

HerbShop:
	call FarReadMart
	call LoadStandardMenuHeader
	ld hl, HerbShopLadyIntroText
	call MartTextbox
	call BuyMenu
	ld hl, HerbalLadyComeAgainText
	jmp MartTextbox

StoneShop:
	call FarReadMart

	ld b, CHECK_FLAG
	ld de, EVENT_BOUGHT_EVERSTONE
	call EventFlagAction
	jr z, .inventory_determined

	farcall RemoveEviostoneFromStoneShopInventory

.inventory_determined
	call LoadStandardMenuHeader
	ld hl, StoneShopIntroText
	call MartTextbox
	call BuyMenu
	ld hl, StoneShopComeAgainText
	jmp MartTextbox

BargainShop:
	ld b, BANK(BargainShopData)
	ld de, BargainShopData
	call LoadMartPointer
	call ReadMart
	call LoadStandardMenuHeader
	ld hl, BargainShopIntroText
	call MartTextbox
	call BuyMenu
	ld hl, wBargainShopFlags
	ld a, [hli]
	or [hl]
	jr z, .skip_set
	ld hl, wDailyFlags1
	set DAILYFLAGS1_GOLDENROD_UNDERGROUND_BARGAIN_F, [hl]

.skip_set
	ld hl, BargainShopComeAgainText
	jmp MartTextbox

Pharmacist:
	call FarReadMart
	call LoadStandardMenuHeader
	ld hl, PharmacyIntroText
	call MartTextbox
	call BuyMenu
	ld hl, PharmacyComeAgainText
	jmp MartTextbox

RooftopSale:
	ld b, BANK(RooftopSaleMart1)
	ld de, RooftopSaleMart1
	ld hl, wStatusFlags
	bit STATUSFLAGS_HALL_OF_FAME_F, [hl]
	jr z, .ok
	ld b, BANK(RooftopSaleMart2)
	ld de, RooftopSaleMart2

.ok
	call LoadMartPointer
	call ReadMart
	call LoadStandardMenuHeader
	ld hl, MartWelcomeText
	call MartTextbox
	call BuyMenu
	ld hl, MartComeAgainText
	jmp MartTextbox

INCLUDE "data/items/rooftop_sale.asm"

LoadMartPointer:
	ld a, b
	ld [wMartPointerBank], a
	ld a, e
	ld [wMartPointer], a
	ld a, d
	ld [wMartPointer + 1], a
	ld hl, wCurMartCount
	assert wCurMartCount + 1 == wCurMartItems
	xor a
	ld bc, 16
	call ByteFill
	xor a ; STANDARDMART_HOWMAYIHELPYOU
	ld [wMartJumptableIndex], a
	ld [wBargainShopFlags], a
	ret

GetMart:
	xor a ; ld a, FALSE
	ld [wShortageInCurrentMart], a

	ld a, e
	ld [wCurrentMartID], a
	cp NUM_MARTS
	jr c, .IsAMart
	ld b, BANK(DefaultMart)
	ld de, DefaultMart
	ret

.IsAMart:
	push bc
	ld b, HM_CUT
	farcall FarCheckHMSilent
	pop bc
	jr c, .before_mart_rush

	ld a, TRUE
	ld [wShortageInCurrentMart], a

	ld a, [wCurDay] ; Between [1; 7].
	and $7
	dec a
	cp 3
	jr c, .modulo_calculation_done

	sub 3
	cp 3
	jr c, .modulo_calculation_done

	sub 3

.modulo_calculation_done
	; A is between [0; 2].
	ld hl, Marts0
	and a
	jr z, .mart_chosen

	ld hl, Marts1
	cp 1
	jr z, .mart_chosen

	ld hl, Marts2
	jr .mart_chosen

.before_mart_rush
	ld hl, Marts

.mart_chosen
	ld a, e
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, BANK(Marts)
	ret

; StandardMart.MartFunctions indexes
	const_def
	const STANDARDMART_HOWMAYIHELPYOU ; 0
	const STANDARDMART_TOPMENU        ; 1
	const STANDARDMART_BUY            ; 2
	const STANDARDMART_SELL           ; 3
	const STANDARDMART_QUIT           ; 4
	const STANDARDMART_ANYTHINGELSE   ; 5

STANDARDMART_EXIT EQU -1

StandardMart:
.loop
	ld a, [wMartJumptableIndex]
	ld hl, .MartFunctions
	rst JumpTable
	ld [wMartJumptableIndex], a
	cp STANDARDMART_EXIT
	jr nz, .loop
	ret

.MartFunctions:
; entries correspond to STANDARDMART_* constants
	dw .HowMayIHelpYou
	dw .TopMenu
	dw .Buy
	dw .Sell
	dw .Quit
	dw .AnythingElse

.HowMayIHelpYou:
	call LoadStandardMenuHeader

	push de
	ld b, CHECK_FLAG
	ld de, EVENT_EXPLAIN_SHORTAGE_MECHANICS
	call EventFlagAction
	ld a, c
	and a
	jr z, .shortage_explanation_skipped

	ld b, RESET_FLAG
	ld de, EVENT_EXPLAIN_SHORTAGE_MECHANICS
	call EventFlagAction

	ld hl, ShortageExplanationText
	jr .welcome_message_found

.shortage_explanation_skipped
	ld a, [wShortageInCurrentMart]
	cp FALSE
	ld hl, MartWelcomeText
	jr z, .welcome_message_found

	call Random
	and %11
	add a
	ld e, a
	ld d, 0
	ld hl, MartShortageWelcomeTextList
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	
.welcome_message_found
	pop de
	call PrintText
	ld a, STANDARDMART_TOPMENU
	ret

.TopMenu:
	ld hl, MenuHeader_BuySell
	call CopyMenuHeader
	call VerticalMenu
	jr c, .quit
	ld a, [wMenuCursorY]
	cp $1
	jr z, .buy
	cp $2
	jr z, .sell
.quit
	ld a, STANDARDMART_QUIT
	ret
.buy
	ld a, STANDARDMART_BUY
	ret
.sell
	ld a, STANDARDMART_SELL
	ret

.Buy:
	call ExitMenu
	call FarReadMart
	call BuyMenu
	and a
	ld a, STANDARDMART_ANYTHINGELSE
	ret

.Sell:
	call ExitMenu
	call SellMenu
	ld a, STANDARDMART_ANYTHINGELSE
	ret

.Quit:
	call ExitMenu

	ld a, [wShortageInCurrentMart]
	cp FALSE
	ld hl, MartComeAgainText
	jr z, .quit_message_found

	ld hl, MartComeAnotherDayText

.quit_message_found
	call MartTextbox
	ld a, STANDARDMART_EXIT
	ret

.AnythingElse:
	call LoadStandardMenuHeader

	ld a, [wShortageInCurrentMart]
	cp FALSE
	ld hl, MartAskMoreText
	jr z, .anything_else_message_found

	ld hl, MartAllIHaveLeftText

.anything_else_message_found
	call PrintText
	ld a, STANDARDMART_TOPMENU
	ret

FarReadMart:
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wCurMartCount
.CopyMart:
	ld a, [wMartPointerBank]
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	cp -1
	jr nz, .CopyMart
	ld hl, wMartItem1BCD
	ld de, wCurMartItems
.ReadMartItem:
	ld a, [de]
	inc de
	cp -1
	jr z, .done
	push de
	call GetMartItemPrice
	pop de
	jr .ReadMartItem

.done
	ret

GetMartItemPrice:
; Return the price of item a in BCD at hl and in tiles at wStringBuffer1.
	push hl
	ld [wCurItem], a
	farcall GetItemPrice
	pop hl

GetMartPrice:
; Return price de in BCD at hl and in tiles at wStringBuffer1.
	push hl
	ld a, d
	ld [wStringBuffer2], a
	ld a, e
	ld [wStringBuffer2 + 1], a
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	lb bc, PRINTNUM_LEADINGZEROS | 2, 6 ; 6 digits
	call PrintNum
	pop hl

	ld de, wStringBuffer1
	ld c, 6 / 2 ; 6 digits
.loop
	call .CharToNybble
	swap a
	ld b, a
	call .CharToNybble
	or b
	ld [hli], a
	dec c
	jr nz, .loop
	ret

.CharToNybble:
	ld a, [de]
	inc de
	cp " "
	jr nz, .not_space
	ld a, "0"

.not_space
	sub "0"
	ret

ReadMart:
; Load the mart pointer.  Mart data is local (no need for bank).
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
; set hl to the first item
	inc hl
	ld bc, wMartItem1BCD
	ld de, wCurMartItems
.loop
; copy the items to wCurMartItems
	ld a, [hli]
	ld [de], a
	inc de
; -1 is the terminator
	cp -1
	jr z, .done

	push de
; copy the price to de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; convert the price to 3-byte BCD at [bc]
	push hl
	ld h, b
	ld l, c
	call GetMartPrice
	ld b, h
	ld c, l
	pop hl

	pop de
	jr .loop

.done
	pop hl
	ld a, [hl]
	ld [wCurMartCount], a
	ret

INCLUDE "data/items/bargain_shop.asm"

BuyMenu:
	ld a, 1
	ld [wItemQuantityChange], a
	ld b, FALSE
	call CheckAndUpdateStock ; We check if it was the last of the stock.
	jr c, .no_items_in_stock

	call FadeToMenu
	farcall BlankScreen
	xor a
	ld [wMenuScrollPositionBackup], a
	ld a, 1
	ld [wMenuCursorPositionBackup], a
.loop
	call BuyMenuLoop ; menu loop
	jr nc, .loop
	jmp CloseSubmenu

.no_items_in_stock
	push de ; Text round robin.
	ld hl, wItemQuantity ; If the player's can't buy, then this byte is unused. 
	inc [hl]
	ld a, [hl]
	and %11
	add a
	ld e, a
	ld d, 0
	ld hl, MartEmptyStockTextList
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de

	call PrintText
	jmp SpeechTextbox

MartEmptyStockTextList:
	dw MartEmptyStock1Text
	dw MartEmptyStock2Text
	dw MartEmptyStock3Text
	dw MartEmptyStock4Text

MartEmptyStock1Text:
	text_far _MartEmptyStock1Text
	text_end

MartEmptyStock2Text:
	text_far _MartEmptyStock2Text
	text_end

MartEmptyStock3Text:
	text_far _MartEmptyStock3Text
	text_end

MartEmptyStock4Text:
	text_far _MartEmptyStock4Text
	text_end

LoadBuyMenuText:
; load text from a nested table
; which table is in wMartType
; which entry is in register a
	push af
	call GetMartDialogGroup ; gets a pointer from GetMartDialogGroup.MartTextFunctionPointers
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp PrintText

MartAskPurchaseQuantity:
	ld a, [wCurItem]
	cp TM01
	jr nc, .PurchaseQuantityOfTM
	call GetMartDialogGroup ; gets a pointer from GetMartDialogGroup.MartTextFunctionPointers
	inc hl
	inc hl
	ld a, [hl]
	and a
	jp z, StandardMartAskPurchaseQuantity
	cp 1
	jp z, BargainShopAskPurchaseQuantity
	jmp RooftopSaleAskPurchaseQuantity

.PurchaseQuantityOfTM:
	push de
	ld hl, wNumItems
	call CheckItem
	pop de
	jp c, .AlreadyHaveTM
	farcall GetItemPrice
	ld a, d
	ld [wBuySellItemPrice + 0], a
	ld a, e
	ld [wBuySellItemPrice + 1], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld a, 99
	ld [wItemQuantity], a
	farcall BuySell_MultiplyPrice
	push hl
	ld hl, hMoneyTemp
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
	ret

.AlreadyHaveTM:
	ld hl, .AlreadyHaveTMText
	call PrintText
	call JoyWaitAorB
	scf
	ret

.AlreadyHaveTMText:
	text_far AlreadyHaveTMText
	text_end

GetMartDialogGroup:
	ld a, [wMartType]
	ld e, a
	ld d, 0
	ld hl, .MartTextFunctionPointers
	add hl, de
	add hl, de
	add hl, de
	ret

.MartTextFunctionPointers:
	dwb .StandardMartPointers, 0
	dwb .HerbShopPointers, 0
	dwb .BargainShopPointers, 1
	dwb .PharmacyPointers, 0
	dwb .StandardMartPointers, 2
	dwb .StoneShopMartPointers, 0

.StandardMartPointers:
	dw MartHowManyText
	dw MartFinalPriceText
	dw MartNoMoneyText
	dw MartPackFullText
	dw MartThanksText
	dw BuyMenuLoop

.HerbShopPointers:
	dw MartHowManyText
	dw MartFinalPriceText
	dw HerbalLadyNoMoneyText
	dw HerbalLadyPackFullText
	dw HerbalLadyThanksText
	dw BuyMenuLoop

.BargainShopPointers:
	dw BuyMenuLoop
	dw BargainShopFinalPriceText
	dw BargainShopNoFundsText
	dw BargainShopPackFullText
	dw BargainShopThanksText
	dw BargainShopSoldOutText

.PharmacyPointers:
	dw MartHowManyText
	dw PharmacyFinalPriceText
	dw PharmacyNoMoneyText
	dw PharmacyPackFullText
	dw PharmacyThanksText
	dw BuyMenuLoop

.StoneShopMartPointers
	dw MartHowManyText
	dw MartFinalPriceText
	dw StoneShopNoMoneyText
	dw HerbalLadyPackFullText
	dw StoneShopThanksText
	dw BuyMenuLoop

BuyMenuLoop:
	farcall PlaceMoneyTopRight
	call UpdateSprites
	ld hl, MenuHeader_Buy
	call CopyMenuHeader
	ld a, [wMenuCursorPositionBackup]
	ld [wMenuCursorPosition], a
	ld a, [wMenuScrollPositionBackup]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMenuScrollPositionBackup], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorPositionBackup], a
	call SpeechTextbox
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jp z, .set_carry
	farcall StoneShopSellPitch
.ask_quantity
	call MartAskPurchaseQuantity
	jr c, .cancel
	call MartConfirmQuantity
	jr c, .ask_quantity
	call MartConfirmPurchase
	jr c, .cancel
	ld de, wMoney
	ld bc, hMoneyTemp
	call CompareMoney
	jr c, .insufficient_funds
	ld hl, wNumItems
	call ReceiveItem
	jr nc, .insufficient_bag_space

	ld b, TRUE
	call CheckAndUpdateStock ; We check if the transaction can complete.
	
	ld a, [wMartItemID]
	ld e, a
	ld d, 0
	ld b, SET_FLAG
	ld hl, wBargainShopFlags
	call FlagAction
	call PlayTransactionSound
	ld de, wMoney
	ld bc, hMoneyTemp
	call TakeMoney

	ld a, MARTTEXT_HERE_YOU_GO
	call LoadBuyMenuText
	call JoyWaitAorB

	xor a
	ld [wWalkingAbuseGuard], a

	farcall NotifyLastEverstone

	ld a, 1
	ld [wItemQuantityChange], a
	ld b, FALSE
	call CheckAndUpdateStock ; We check if it was the last of the stock.
	jr nc, .update_shop_if_everstone_removed_from_inventory ; We stay in the buying menu if the seller's stock is not empty.

; The player just emptied the stock.
	ld hl, MartLastItemText
	call PrintText
	call JoyWaitAorB
	jr .set_carry ; Quits the buying menu.

.update_shop_if_everstone_removed_from_inventory
	farcall CheckIfBoughtEverstoneAtStoneShop
	jp z, BuyMenuLoop

.cancel
	call SpeechTextbox
	and a
	ret

.set_carry
	scf
	ret

.insufficient_bag_space
	ld a, MARTTEXT_BAG_FULL
	call LoadBuyMenuText
	call JoyWaitAorB
	and a
	ret

.insufficient_funds
	ld a, MARTTEXT_NOT_ENOUGH_MONEY
	call LoadBuyMenuText
	call JoyWaitAorB
	and a
	ret

StandardMartAskPurchaseQuantity:
	ld a, MAX_ITEM_STACK
	ld [wItemQuantity], a
	ld a, MARTTEXT_HOW_MANY
	call LoadBuyMenuText
	farcall SelectQuantityToBuy
	jmp ExitMenu

MartConfirmQuantity:
	ld b, FALSE
	call CheckAndUpdateStock
	ret nc

	ld hl, MartShortageText
	call PrintText
	scf ; Returns transaction failure.
	ret

MartConfirmPurchase:
	predef PartyMonItemName
	ld a, MARTTEXT_COSTS_THIS_MUCH
	call LoadBuyMenuText
	jmp YesNoBox

BargainShopAskPurchaseQuantity:
	ld a, 1
	ld [wItemQuantityChange], a
	ld a, [wMartItemID]
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	ld hl, wBargainShopFlags
	call FlagAction
	ld a, c
	and a
	jr nz, .SoldOut
	ld a, [wMartItemID]
	ld e, a
	ld d, 0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	add hl, de
	inc hl
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a
	xor a
	ldh [hMoneyTemp], a
	and a
	ret

.SoldOut:
	ld a, MARTTEXT_SOLD_OUT
	call LoadBuyMenuText
	call JoyWaitAorB
	scf
	ret

RooftopSaleAskPurchaseQuantity:
	ld a, MARTTEXT_HOW_MANY
	call LoadBuyMenuText
	call .GetSalePrice
	ld a, MAX_ITEM_STACK
	ld [wItemQuantity], a
	farcall RooftopSale_SelectQuantityToBuy
	jmp ExitMenu

.GetSalePrice:
	ld a, [wMartItemID]
	ld e, a
	ld d, 0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	add hl, de
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

MartHowManyText:
	text_far _MartHowManyText
	text_end

MartFinalPriceText:
	text_far _MartFinalPriceText
	text_end

MenuHeader_Buy:
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wCurMartCount
	dba PlaceMenuItemName
	dba .PrintBCDPrices
	dba UpdateItemDescription

.PrintBCDPrices:
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, wMartItem1BCD
	add hl, bc
	add hl, bc
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld c, PRINTNUM_LEADINGZEROS | PRINTNUM_MONEY | 3
	jmp PrintBCDNumber

HerbShopLadyIntroText:
	text_far _HerbShopLadyIntroText
	text_end

HerbalLadyThanksText:
	text_far _HerbalLadyThanksText
	text_end

HerbalLadyPackFullText:
	text_far _HerbalLadyPackFullText
	text_end

HerbalLadyNoMoneyText:
	text_far _HerbalLadyNoMoneyText
	text_end

HerbalLadyComeAgainText:
	text_far _HerbalLadyComeAgainText
	text_end

StoneShopIntroText:
	text_far _StoneShopIntroText
	text_end

StoneShopThanksText:
	text_far _StoneShopThanksText
	text_end

StoneShopNoMoneyText:
	text_far _StoneShopNoMoneyText
	text_end

StoneShopComeAgainText:
	text_far _StoneShopComeAgainText
	text_end

BargainShopIntroText:
	text_far _BargainShopIntroText
	text_end

BargainShopFinalPriceText:
	text_far _BargainShopFinalPriceText
	text_end

BargainShopThanksText:
	text_far _BargainShopThanksText
	text_end

BargainShopPackFullText:
	text_far _BargainShopPackFullText
	text_end

BargainShopSoldOutText:
	text_far _BargainShopSoldOutText
	text_end

BargainShopNoFundsText:
	text_far _BargainShopNoFundsText
	text_end

BargainShopComeAgainText:
	text_far _BargainShopComeAgainText
	text_end

PharmacyIntroText:
	text_far _PharmacyIntroText
	text_end

PharmacyFinalPriceText:
	text_far _PharmacyFinalPriceText
	text_end

PharmacyThanksText:
	text_far _PharmacyThanksText
	text_end

PharmacyPackFullText:
	text_far _PharmacyPackFullText
	text_end

PharmacyNoMoneyText:
	text_far _PharmacyNoMoneyText
	text_end

PharmacyComeAgainText:
	text_far _PharmacyComeAgainText
	text_end

SellMenu:
	call DisableSpriteUpdates
	farcall DepositSellInitPackBuffers_ReopenLastPocket
.loop
	farcall DepositSellPack
	ld a, [wPackUsedItem]
	and a
	jp z, .quit
	call .TryToSellItem
	jr .loop

.quit
	call ReturnToMapWithSpeechTextbox
	and a
	ret

.TryToSellItem:
	farcall CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .dw
	rst JumpTable
	ret

.dw
	dw .try_sell
	dw .cant_buy
	dw .cant_buy
	dw .cant_buy
	dw .try_sell
	dw .try_sell
	dw .try_sell

.cant_buy
	ret

.try_sell
	farcall _CheckTossableItem
	ld a, [wItemAttributeValue]
	and a
	jr z, .okay_to_sell
	ld hl, MartCantBuyText
	call PrintText
	and a
	ret

.okay_to_sell
	ld hl, MartHowManyText
	call PrintText
	farcall PlaceMoneyAtTopLeftOfTextbox
	farcall SelectQuantityToSell
	call ExitMenu
	jr c, .declined
	hlcoord 1, 14
	lb bc, 3, 18
	call ClearBox
	ld hl, MartSellPriceText
	call PrintTextboxText
	call YesNoBox
	jr c, .declined
	ld de, wMoney
	ld bc, hMoneyTemp
	call GiveMoney
	ld a, [wMartItemID]
	ld hl, wNumItems
	call TossItem
	predef PartyMonItemName
	hlcoord 1, 14
	lb bc, 3, 18
	call ClearBox
	ld hl, MartBoughtText
	call PrintTextboxText
	call PlayTransactionSound
	farcall PlaceMoneyBottomLeft
	call JoyWaitAorB
	xor a
	ld [wWalkingAbuseGuard], a

.declined
	call ExitMenu
	and a
	ret

MartSellPriceText:
	text_far _MartSellPriceText
	text_end

MartWelcomeText:
	text_far _MartWelcomeText
	text_end

ShortageExplanationText:
	text_far _ShortageExplanationText
	text_end

MartShortageWelcomeTextList:
	dw MartDoMyBestText1
	dw MartDoMyBestText2
	dw MartDoMyBestText3
	dw MartDoMyBestText4

MartDoMyBestText1:
	text_far _MartDoMyBest1Text
	text_end

MartDoMyBestText2:
	text_far _MartDoMyBest2Text
	text_end

MartDoMyBestText3:
	text_far _MartDoMyBest3Text
	text_end

MartDoMyBestText4:
	text_far _MartDoMyBest4Text
	text_end

MartAllIHaveLeftText:
	text_far _MartAllIHaveLeftText
	text_end

MenuHeader_BuySell:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 0, 0, 10, 8
else
	menu_coords 0, 0, 7, 8
endc
	dw .MenuData
	db 1 ; default option

.MenuData
	db STATICMENU_CURSOR ; strings
	db 3 ; items
if DEF(_FR_FR)
	db "ACHETER@"
	db "VENDRE@"
	db "SALUT!@"
else
	db "BUY@"
	db "SELL@"
	db "QUIT@"
endc

MartThanksText:
	text_far _MartThanksText
	text_end

MartNoMoneyText:
	text_far _MartNoMoneyText
	text_end

MartPackFullText:
	text_far _MartPackFullText
	text_end

MartCantBuyText:
	text_far _MartCantBuyText
	text_end

MartComeAgainText:
	text_far _MartComeAgainText
	text_end

MartComeAnotherDayText:
	text_far _MartComeAnotherDayText
	text_end

MartAskMoreText:
	text_far _MartAskMoreText
	text_end

MartBoughtText:
	text_far _MartBoughtText
	text_end

MartShortageText:
	text_far _MartShortageText
	text_end

MartLastItemText:
	text_far _MartLastItemText
	text_end

PlayTransactionSound:
	call WaitSFX
	ld de, SFX_TRANSACTION
	jmp PlaySFX

MartTextbox:
	call MenuTextbox
	call JoyWaitAorB
	jmp ExitMenu

ShelfItemDisplay::
	push bc
	call OpenText
	ld hl, .MissedItemText
	call PrintText
	pop bc

	; Get item name.
	ld a, b
	ld [wCurSpecies], a
	ld a, ITEM_NAME
	ld [wNamedObjectType], a
	call GetName
	
	; Get item batch price into text format.
	push bc
	ld hl, wStringBuffer3
	ld a, "@"
	ld bc, 8
	call ByteFill ; fill bc bytes with the value of a, starting at hl
	
	ld hl, wStringBuffer3
	ld de, wStringBuffer2
	lb bc, 2 | 1 << 6 | 1 << 5, 6 ; Bit 5 is for money symbol, and bit 6 for left-alignment.
	call PrintNum
	pop bc

	ld a, c
	cp 2
	jr c, .singleItem

	ld hl, .MissedItemBundle

	; Get item quantity into text format.
	cp 10
	jr c, .singleDigit

; Two digits, with value < 20.
	ld a, "@" ; EOL.
	ld [wStringBuffer2 + 2], a
	ld a, "1"
	ld [wStringBuffer2 + 0], a
	ld a, c
	sub 10
	add "0"
	ld [wStringBuffer2 + 1], a
	jr .displayItemNameAndQuantity

.singleDigit
	ld a, "@" ; EOL.
	ld [wStringBuffer2 + 1], a
	ld a, c
	add "0"
	ld [wStringBuffer2], a
	jr .displayItemNameAndQuantity

.singleItem
	ld hl, .MissedItemSingle

.displayItemNameAndQuantity
	push bc
	call PrintText

	ld hl, .MissedItemPrice
	call PrintText

	farcall PlaceMoneyTopRight

	call YesNoBox
	ld a, FALSE
	pop bc
	jr c, .end

;.yes
	call GiveItemToPlayer
	jr nc, .full

	ld de, wMoney
	ld bc, hMoneyTemp
	farcall CompareMoney
	jr c, .notEnoughMoney

	farcall TakeMoney
	farcall Script_disappear_last_talked
	farcall PlaceMoneyTopRight

	ld de, SFX_TRANSACTION ; $22
	call PlaySFX
	call WaitSFX
	farcall Script_itemnotify
	jr .end

.notEnoughMoney
	ld hl, MartNoMoneyText
	jr .errorText
.full 
	ld hl, MartPackFullText
.errorText
	call PrintText
	call WaitButton
.end
	call CloseText
	farcall Script_end
	ret

.MissedItemText:
	text_far _MissedItemText
	text_end

.MissedItemSingle:
	text_far _MissedItemSingle
	text_end

.MissedItemBundle:
	text_far _MissedItemBundle
	text_end

.MissedItemPrice:
	text_far _MissedItemPrice
	text_end

; Input: B = item ID, C = item quantity.
; Output: nc is pack is full.
GiveItemToPlayer::
	ld a, b
	ld [wCurItem], a
	ld a, c
	ld [wItemQuantityChange], a
	ld hl, wNumItems
	;ld [hl], a
	jmp ReceiveItem




; Input: if B=TRUE, then the stock will be updated. [wShortageInCurrentMart], [wCurrentMartID] and [wItemQuantityChange] need to be set.
; Output: Carry if not enough articles in stock to complete the transaction. nc otherwise. Returns the stock (number of available articles) in A.
; Clobbers DE and HL.
CheckAndUpdateStock:
	farcall CheckIfBoughtEverstoneAtStoneShop ; Doesn't clobber B.
	jr nz, .check_shortage

	ld a, [wItemQuantityChange]
	cp 2
	jr nc, .return_false ; The player can only buy 1 Everstone from the Stone Shop.

.check_shortage
	ld a, [wShortageInCurrentMart]
	cp FALSE
	jr z, .return_true_infinite ; Infinite stocks before the market rush.

	ld a, [wCurrentMartID]
	cp NUM_MARTS
	jr nc, .return_false ; This is not a mart, so we return false.

	srl a ; Divides A by 2, then floor the result.
	push af
	ld e, a
	ld d, 0
	ld hl, wMartsStock
	add hl, de
	ld d, [hl]
	pop af
	ld e, FALSE ; Means no swap is needed.
	jr nc, .no_swap_read

	swap d
	ld e, TRUE ; Means a swap has been done.

.no_swap_read
	ld a, d
	and $f ; We only keep the lowest nybble.

	push hl ; Stacking the address of the current stock.
	ld hl, wItemQuantityChange
	sub [hl]
	pop hl
	jr c, .return_false ; We have enough articles in stock.

	push af ; Stacking the return value and its nc flag.
	ld a, b
	cp TRUE
	jr nz, .return_true_quantity

	; We need to save the new stock.
	ld a, d
	and $f0 ; We erase the lower nybble and keep the upper one.
	ld d, a
	pop af 	; Temporarily retrieve our return value.
	push af	; Storing our return value once again.
	or d
	ld d, a
	ld a, e
	cp FALSE
	jr z, .no_swap_write

	swap d

.no_swap_write
	ld a, d
	ld [hl], a ; We write the new stock.
.return_true_quantity
	pop af
	ret ; Returns true (nc), and quantity left in A.

.return_false
	xor a ; Set A to 0 (we will set the flag, don't worry).
	scf
	ret

.return_true_infinite
	xor a ; Unsets carry flag. We will set the quantity in A, don't worry.
	ld a, $ff
	ret

RestockMarts::
	ld a, 10 << 4 | 10; The player can purchase up to 10 items per shop per day. Shortage! There are 2 shops per byte.
	ld bc, (NUM_MARTS + 1) / 2
	ld hl, wMartsStock
	jmp ByteFill ; fill bc bytes with the value of a, starting at hl
