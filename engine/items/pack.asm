; Pack.Jumptable and BattlePack.Jumptable indexes
	const_def
	const PACKSTATE_INITGFX            ;  0
	const PACKSTATE_INITITEMSPOCKET    ;  1
	const PACKSTATE_ITEMSPOCKETMENU    ;  2
	const PACKSTATE_INITBALLSPOCKET    ;  3
	const PACKSTATE_BALLSPOCKETMENU    ;  4
	const PACKSTATE_INITKEYITEMSPOCKET ;  5
	const PACKSTATE_KEYITEMSPOCKETMENU ;  6
	const PACKSTATE_INITTMHMPOCKET     ;  7
	const PACKSTATE_TMHMPOCKETMENU     ;  8
	const PACKSTATE_INITMEDPOCKET	   ;  9
	const PACKSTATE_MEDPOCKETMENU	   ; 10
	const PACKSTATE_INITBERRYPOCKET	   ; 11
	const PACKSTATE_BERRYPOCKETMENU	   ; 12
	const PACKSTATE_QUITNOSCRIPT       ; 13
	const PACKSTATE_QUITRUNSCRIPT      ; 14

Pack:
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop

.done
	ld a, [wCurPocket]
	ld [wLastPocket], a
	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

.Jumptable:
; entries correspond to PACKSTATE_* constants
	dw .InitGFX            ;  0
	dw .InitItemsPocket    ;  1
	dw .ItemsPocketMenu    ;  2
	dw .InitBallsPocket    ;  3
	dw .BallsPocketMenu    ;  4
	dw .InitKeyItemsPocket ;  5
	dw .KeyItemsPocketMenu ;  6
	dw .InitTMHMPocket     ;  7
	dw .TMHMPocketMenu     ;  8
	dw .InitMedPocket      ;  9
	dw .MedPocketMenu      ; 10 
	dw .InitBerryPocket    ; 11
	dw .BerryPocketMenu    ; 12 
	dw Pack_QuitNoScript   ; 13
	dw Pack_QuitRunScript  ; 14

.InitGFX:
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wPackJumptableIndex]
	ld [wJumptableIndex], a
	jmp Pack_InitColors

.InitItemsPocket:
	xor a ; ITEM_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.ItemsPocketMenu:
	ld hl, ItemsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, PACKSTATE_INITKEYITEMSPOCKET, PACKSTATE_INITMEDPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	call .ItemBallsKey_LoadSubmenu
	ret

.InitKeyItemsPocket:
	ld a, KEY_ITEM_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.KeyItemsPocketMenu:
	ld hl, KeyItemsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	lb bc, PACKSTATE_INITTMHMPOCKET, PACKSTATE_INITITEMSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	call .ItemBallsKey_LoadSubmenu
	ret

.InitTMHMPocket:
	ld a, TM_HM_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	xor a
	ldh [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.TMHMPocketMenu:
	farcall TMHMPocket
	lb bc, PACKSTATE_INITBERRYPOCKET, PACKSTATE_INITKEYITEMSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c

	farcall AskTeachTMHM
	ret c
	farcall ChooseMonToLearnTMHM
	jr c, .declined
	ld hl, wOptions
	ld a, [hl]
	push af
	res NO_TEXT_SCROLL, [hl]
	farcall TeachTMHM
	pop af
	ld [wOptions], a
.declined
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.InitBallsPocket:
	ld a, BALL_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BallsPocketMenu:
	ld hl, BallsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, PACKSTATE_INITMEDPOCKET, PACKSTATE_INITBERRYPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	call .ItemBallsKey_LoadSubmenu
	ret

.InitMedPocket:
	ld a, MED_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.MedPocketMenu:
	ld hl, MedPocketMenuHeader
	call CopyMenuHeader
	ld a, [wMedPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wMedPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMedPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedPocketCursor], a
	lb bc, PACKSTATE_INITITEMSPOCKET, PACKSTATE_INITBALLSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	call .ItemBallsKey_LoadSubmenu
	ret

.InitBerryPocket:
	ld a, BERRIES_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BerryPocketMenu:
	ld hl, BerryPocketMenuHeader
	call CopyMenuHeader
	ld a, [wBerryPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBerryPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBerryPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerryPocketCursor], a
	lb bc, PACKSTATE_INITBALLSPOCKET, PACKSTATE_INITTMHMPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	call .ItemBallsKey_LoadSubmenu
	ret

.ItemBallsKey_LoadSubmenu:
	farcall _CheckTossableItem
	ld a, [wItemAttributeValue]
	and a
	jr nz, .tossable
	farcall CheckSelectableItem
	ld a, [wItemAttributeValue]
	and a
	jr nz, .selectable
	farcall CheckItemMenu
	ld a, [wItemAttributeValue]
	and a
	jr nz, .usable
	jr .unusable

.selectable
	farcall CheckItemMenu
	ld a, [wItemAttributeValue]
	and a
	jr nz, .selectable_usable
	jr .selectable_unusable

.tossable
	farcall CheckSelectableItem
	ld a, [wItemAttributeValue]
	and a
	jr nz, .tossable_selectable
	jr .tossable_unselectable

.usable
	ld hl, MenuHeader_UsableKeyItem
	ld de, Jumptable_UseGiveTossRegisterQuit
	jr .build_menu

.selectable_usable
	ld hl, MenuHeader_UsableItem
	ld de, Jumptable_UseGiveTossQuit
	jr .build_menu

.tossable_selectable
	ld hl, MenuHeader_UnusableItem
	ld de, Jumptable_UseQuit
	jr .build_menu

.tossable_unselectable
	ld hl, MenuHeader_UnusableKeyItem
	ld de, Jumptable_UseRegisterQuit
	jr .build_menu

.unusable
	ld hl, MenuHeader_HoldableKeyItem
	ld de, Jumptable_GiveTossRegisterQuit
	jr .build_menu

.selectable_unusable
	ld hl, MenuHeader_HoldableItem
	ld de, Jumptable_GiveTossQuit
.build_menu
	push de
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

MenuHeader_UsableKeyItem:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 5 ; items
if DEF(_FR_FR)
	db "UTIL@"
	db "DON@"
	db "JETER@"
	db "SLCT@"
	db "RET@"
else
	db "USE@"
	db "GIVE@"
	db "TOSS@"
	db "SEL@"
	db "QUIT@"
endc

Jumptable_UseGiveTossRegisterQuit:
	dw UseItem
	dw GiveItem
	dw TossMenu
	dw RegisterItem
	dw QuitItemSubmenu

MenuHeader_UsableItem:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "UTIL@"
	db "DON@"
	db "JETER@"
	db "RET@"
else
	db "USE@"
	db "GIVE@"
	db "TOSS@"
	db "QUIT@"
endc

Jumptable_UseGiveTossQuit:
	dw UseItem
	dw GiveItem
	dw TossMenu
	dw QuitItemSubmenu

MenuHeader_UnusableItem:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 2 ; items
if DEF(_FR_FR)
	db "UTIL@"
	db "RET@"
else
	db "USE@"
	db "QUIT@"
endc

Jumptable_UseQuit:
	dw UseItem
	dw QuitItemSubmenu

MenuHeader_UnusableKeyItem:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 5, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 5, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 3 ; items
if DEF(_FR_FR)
	db "UTIL@"
	db "SLCT@"
	db "RET@"
else
	db "USE@"
	db "SEL@"
	db "QUIT@"
endc

Jumptable_UseRegisterQuit:
	dw UseItem
	dw RegisterItem
	dw QuitItemSubmenu

MenuHeader_HoldableKeyItem:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "DON@"
	db "JETER@"
	db "SLCT@"
	db "RET@"
else
	db "GIVE@"
	db "TOSS@"
	db "SEL@"
	db "QUIT@"
endc

Jumptable_GiveTossRegisterQuit:
	dw GiveItem
	dw TossMenu
	dw RegisterItem
	dw QuitItemSubmenu

MenuHeader_HoldableItem:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 5, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 5, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 3 ; items
if DEF(_FR_FR)
	db "DON@"
	db "JETER@"
	db "RET@"
else
	db "GIVE@"
	db "TOSS@"
	db "QUIT@"
endc

Jumptable_GiveTossQuit:
	dw GiveItem
	dw TossMenu
	dw QuitItemSubmenu

UseItem:
	farcall CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .dw
	rst JumpTable
	ret

.dw
; entries correspond to ITEMMENU_* constants
	dw .Oak     ; ITEMMENU_NOUSE
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Current ; ITEMMENU_CURRENT
	dw .Party   ; ITEMMENU_PARTY
	dw .Field   ; ITEMMENU_CLOSE

.Oak:
	ld hl, OakThisIsntTheTimeText
	jmp Pack_PrintTextNoScroll

.Current:
	jp DoItemEffect

.Party:
	ld a, [wPartyCount]
	and a
	jr z, .NoPokemon
	call DoItemEffect
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.NoPokemon:
	ld hl, YouDontHaveAMonText
	jmp Pack_PrintTextNoScroll

.Field:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	ld a, PACKSTATE_QUITRUNSCRIPT
	ld [wJumptableIndex], a
	ret

TossMenu:
	ld hl, AskThrowAwayText
	call Pack_PrintTextNoScroll
	farcall SelectQuantityToToss
	push af
	call ExitMenu
	pop af
	jr c, .finish
	call Pack_GetItemName
	ld hl, AskQuantityThrowAwayText
	call MenuTextbox
	call YesNoBox
	push af
	call ExitMenu
	pop af
	jr c, .finish
	ld hl, wNumItems
	ld a, [wCurItemQuantity]
	call TossItem
	call Pack_GetItemName
	ld hl, ThrewAwayText
	call Pack_PrintTextNoScroll
.finish
	ret

RegisterItem:
	farcall CheckSelectableItem
	ld a, [wItemAttributeValue]
	and a
	jr nz, .cant_register
	
	ld a, [wCurItem]
	ld [wRegisteredItem], a
	call Pack_GetItemName
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, RegisteredItemText
	jmp Pack_PrintTextNoScroll

.cant_register
	ld hl, CantRegisterText
	jmp Pack_PrintTextNoScroll

GiveItem:
	ld a, [wPartyCount]
	and a
	jp z, .NoPokemon
	ld a, [wOptions]
	push af
	res NO_TEXT_SCROLL, a
	ld [wOptions], a
	ld a, PARTYMENUACTION_GIVE_ITEM
	ld [wPartyMenuActionText], a
	call ClearBGPalettes
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
.loop
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call WaitBGMap
	call SetPalettes
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .finish
	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .give
	ld hl, .AnEggCantHoldAnItemText
	call PrintText
	jr .loop

.give
	ld a, [wJumptableIndex]
	push af
	ld a, [wPackJumptableIndex]
	push af
	call GetCurNickname
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	call TryGiveItemToPartymon
	pop af
	ld [wPackJumptableIndex], a
	pop af
	ld [wJumptableIndex], a
.finish
	pop af
	ld [wOptions], a
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.NoPokemon:
	ld hl, YouDontHaveAMonText
	jmp Pack_PrintTextNoScroll
.AnEggCantHoldAnItemText:
	text_far _AnEggCantHoldAnItemText
	text_end

QuitItemSubmenu:
	ret

BattlePack:
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .end
	call .RunJumptable
	call DelayFrame
	jr .loop

.end
	ld a, [wCurPocket]
	ld [wLastPocket], a
	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

.Jumptable:
; entries correspond to PACKSTATE_* constants
	dw .InitGFX            ;  0
	dw .InitItemsPocket    ;  1
	dw .ItemsPocketMenu    ;  2
	dw .InitBallsPocket    ;  3
	dw .BallsPocketMenu    ;  4
	dw .InitKeyItemsPocket ;  5
	dw .KeyItemsPocketMenu ;  6
	dw .InitTMHMPocket     ;  7
	dw .TMHMPocketMenu     ;  8
	dw .InitMedPocket  	   ;  9
	dw .MedPocketMenu	   ; 10
	dw .InitBerryPocket	   ; 11
	dw .BerryPocketMenu	   ; 12
	dw Pack_QuitNoScript   ; 13
	dw Pack_QuitRunScript  ; 14

.InitGFX:
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wPackJumptableIndex]
	ld [wJumptableIndex], a
	jmp Pack_InitColors

.InitItemsPocket:
	xor a ; ITEM_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.ItemsPocketMenu:
	ld hl, ItemsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, PACKSTATE_INITBERRYPOCKET, PACKSTATE_INITMEDPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	jmp ItemSubmenu

.InitKeyItemsPocket:
	ld a, KEY_ITEM_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.KeyItemsPocketMenu:
	ld hl, KeyItemsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	lb bc, PACKSTATE_INITBERRYPOCKET, PACKSTATE_INITITEMSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	jmp ItemSubmenu

.InitTMHMPocket:
	ld a, TM_HM_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	xor a
	ldh [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	ld hl, PackEmptyText
	call Pack_PrintTextNoScroll
	jmp Pack_JumptableNext

.TMHMPocketMenu:
	farcall TMHMPocket
	lb bc, PACKSTATE_INITBERRYPOCKET, PACKSTATE_INITITEMSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	xor a
	jmp TMHMSubmenu

.InitBallsPocket:
	ld a, BALL_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BallsPocketMenu:
	ld hl, BallsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, PACKSTATE_INITMEDPOCKET, PACKSTATE_INITBERRYPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	jr ItemSubmenu

.InitMedPocket:
	ld a, MED_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.MedPocketMenu:
	ld hl, MedPocketMenuHeader
	call CopyMenuHeader
	ld a, [wMedPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wMedPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMedPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedPocketCursor], a
	lb bc, PACKSTATE_INITITEMSPOCKET, PACKSTATE_INITBALLSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	jr ItemSubmenu

.InitBerryPocket:
	ld a, BERRIES_POCKET
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BerryPocketMenu:
	ld hl, BerryPocketMenuHeader
	call CopyMenuHeader
	ld a, [wBerryPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBerryPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBerryPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerryPocketCursor], a
	lb bc, PACKSTATE_INITBALLSPOCKET, PACKSTATE_INITITEMSPOCKET ; left ; right
	call Pack_InterpretJoypad
	ret c
	
	; fallthrough

ItemSubmenu:
	farcall CheckItemContext
	ld a, [wItemAttributeValue]
TMHMSubmenu:
	and a
	jr z, .NoUse
	ld hl, .UsableMenuHeader
	ld de, .UsableJumptable
	jr .proceed

.NoUse:
	ld hl, .UnusableMenuHeader
	ld de, .UnusableJumptable
.proceed
	push de
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

.UsableMenuHeader:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .UsableMenuData
	db 1 ; default option

.UsableMenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 2 ; items
if DEF(_FR_FR)
	db "UTIL@"
	db "RET@"
else
	db "USE@"
	db "QUIT@"
endc

.UsableJumptable:
	dw .Use
	dw .Quit

.UnusableMenuHeader:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 12, 9, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 13, 9, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .UnusableMenuData
	db 1 ; default option

.UnusableMenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 1 ; items
if DEF(_FR_FR)
	db "RET@"
else
	db "QUIT@"
endc

.UnusableJumptable:
	dw .Quit

.Use:
	farcall CheckItemContext
	ld a, [wItemAttributeValue]
	ld hl, .ItemFunctionJumptable
	rst JumpTable
	ret

.ItemFunctionJumptable:
; entries correspond to ITEMMENU_* constants
	dw .Oak         ; ITEMMENU_NOUSE
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Unused      ; ITEMMENU_CURRENT
	dw .BattleField ; ITEMMENU_PARTY
	dw .BattleOnly  ; ITEMMENU_CLOSE

.Oak:
	ld hl, OakThisIsntTheTimeText
	jmp Pack_PrintTextNoScroll

.Unused:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .ReturnToBattle
	ret

.BattleField:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .quit_run_script
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.ReturnToBattle:
	call ClearBGPalettes
	jr .quit_run_script

.BattleOnly:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	cp $2
	jr z, .didnt_use_item
.quit_run_script
	ld a, PACKSTATE_QUITRUNSCRIPT
	ld [wJumptableIndex], a
	ret

.didnt_use_item
	xor a
	ld [wItemEffectSucceeded], a
	ret
.Quit:
	ret

InitPackBuffers:
	xor a
	ld [wJumptableIndex], a
	; pocket id -> jumptable index
	ld a, [wLastPocket]
	maskbits NUM_POCKETS
	ld [wCurPocket], a
	inc a
	add a
	dec a
	ld [wPackJumptableIndex], a
	xor a ; FALSE
	ld [wPackUsedItem], a
	xor a
	ld [wSwitchItem], a
	ret

DepositSellInitPackBuffers:
	xor a
	ldh [hBGMapMode], a
	ld [wJumptableIndex], a ; PACKSTATE_INITGFX
	ld [wPackJumptableIndex], a ; PACKSTATE_INITGFX
	ld [wPackUsedItem], a
	ld [wSwitchItem], a
	ld a, BALL_POCKET
	ld [wCurPocket], a ; ITEM_BALLS
	call Pack_InitGFX
	jmp Pack_InitColors

DepositSellPack:
.loop
	call .RunJumptable
	call DepositSellTutorial_InterpretJoypad
	jr c, .loop
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

.Jumptable:
; entries correspond to *_POCKET constants
	dw .ItemsPocket
	dw .MedPocket
	dw .BallsPocket
	dw .BerryPocket
	dw .TMHMPocket
	dw .KeyItemsPocket

.ItemsPocket:
	xor a ; ITEM_POCKET
	call InitPocket
	ld hl, PC_Mart_ItemsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	ret

.KeyItemsPocket:
	ld a, KEY_ITEM_POCKET
	call InitPocket
	ld hl, PC_Mart_KeyItemsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	ret

.TMHMPocket:
	ld a, TM_HM_POCKET
	call InitPocket
	call WaitBGMap_DrawPackGFX
	farcall TMHMPocket
	ret

.BallsPocket:
	ld a, BALL_POCKET
	call InitPocket
	ld hl, PC_Mart_BallsPocketMenuHeader
	call CopyMenuHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	ret

.MedPocket:
	ld a, MED_POCKET
	call InitPocket
	ld hl, PC_Mart_MedPocketMenuHeader
	call CopyMenuHeader
	ld a, [wMedPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wMedPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMedPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedPocketCursor], a
	ret

.BerryPocket:
	ld a, BERRIES_POCKET
	call InitPocket
	ld hl, PC_Mart_BerryPocketMenuHeader
	call CopyMenuHeader
	ld a, [wBerryPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBerryPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBerryPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerryPocketCursor], a
	ret

InitPocket:
	ld [wCurPocket], a
	call ClearPocketList
	call DrawPocketName
	jmp WaitBGMap_DrawPackGFX

DepositSellTutorial_InterpretJoypad:
	ld hl, wMenuJoypad
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	scf
	ret

.a_button
	ld a, TRUE
	ld [wPackUsedItem], a
	and a
	ret

.b_button
	xor a ; FALSE
	ld [wPackUsedItem], a
	and a
	ret

.d_left
	ld a, [wJumptableIndex]
	dec a
	cp -1
	jr nz, .left_ok
	ld a, NUM_POCKETS - 3
.left_ok
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, [wJumptableIndex]
	inc a
	cp NUM_POCKETS - 2
	jr nz, .right_ok
	xor a
.right_ok
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

TutorialPack:
	call DepositSellInitPackBuffers
	ld a, [wInputType]
	or a
	jr z, .loop
	farcall _DudeAutoInput_RightA
.loop
	call .RunJumptable
	call DepositSellTutorial_InterpretJoypad
	jr c, .loop
	xor a ; FALSE
	ld [wPackUsedItem], a
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .dw
	call Pack_GetJumptablePointer
	jp hl

.dw
; entries correspond to *_POCKET constants
	dw .Balls
	dw .Meds
	dw .Balls
	dw .Berries
	dw .TMHM
	dw .KeyItems

.Items:
	xor a ; ITEM_POCKET
	ld hl, .ItemsMenuHeader
	jmp .DisplayPocket

.ItemsMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .ItemsMenuData
	db 1 ; default option

.ItemsMenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wDudeNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

.KeyItems:
	ld a, KEY_ITEM_POCKET
	ld hl, .KeyItemsMenuHeader
	jmp .DisplayPocket

.KeyItemsMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .KeyItemsMenuData
	db 1 ; default option

.KeyItemsMenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wDudeNumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

.TMHM:
	ld a, TM_HM_POCKET
	call InitPocket
	call WaitBGMap_DrawPackGFX
	farcall TMHMPocket
	ret

.Balls:
	ld a, BALL_POCKET
	ld hl, .BallsMenuHeader
	jr .DisplayPocket

.BallsMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .BallsMenuData
	db 1 ; default option

.BallsMenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wDudeNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

.Meds:
	ld a, MED_POCKET
	ld hl, .MedsMenuHeader
	jr .DisplayPocket

.MedsMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MedsMenuData
	db 1 ; default option

.MedsMenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumMeds
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

.Berries:
	ld a, BERRIES_POCKET
	ld hl, .BerriesMenuHeader
	jr .DisplayPocket

.BerriesMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .BerriesMenuData
	db 1 ; default option

.BerriesMenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumBerries
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

.DisplayPocket:
	push hl
	call InitPocket
	pop hl
	call CopyMenuHeader
	jmp ScrollingMenu

Pack_JumptableNext:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pack_GetJumptablePointer:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pack_QuitNoScript:
	ld hl, wJumptableIndex
	set 7, [hl]
	xor a ; FALSE
	ld [wPackUsedItem], a
	ret

Pack_QuitRunScript:
	ld hl, wJumptableIndex
	set 7, [hl]
	ld a, TRUE
	ld [wPackUsedItem], a
	ret

Pack_PrintTextNoScroll:
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	call PrintText
	pop af
	ld [wOptions], a
	ret

WaitBGMap_DrawPackGFX:
	call WaitBGMap
DrawPackGFX:
	ld a, [wCurPocket]
	maskbits NUM_POCKETS
	ld e, a
	ld d, 0
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .male_dude
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr nz, .female
.male_dude
	ld hl, PackGFXPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, vTiles2 tile $50
	lb bc, BANK(PackGFX), 15
	jmp Request2bpp

.female
	farcall DrawKrisPackGFX
	ret

PackGFXPointers:
	dw PackGFX + (15 tiles) * 5 ; ITEM_POCKET
	dw PackGFX + (15 tiles) * 3 ; BALL_POCKET
	dw PackGFX + (15 tiles) * 0 ; KEY_ITEM_POCKET
	dw PackGFX + (15 tiles) * 2 ; TM_HM_POCKET
	dw PackGFX + (15 tiles) * 4 ; MED_POCKET
	dw PackGFX + (15 tiles) * 1 ; BERRIES_POCKET

Pack_InterpretJoypad:
	ld hl, wMenuJoypad
	ld a, [wSwitchItem]
	and a
	jr nz, .switching_item
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	ld a, [hl]
	and SELECT
	jr nz, .select
	scf
	ret

.a_button
	and a
	ret

.b_button
	ld a, PACKSTATE_QUITNOSCRIPT
	ld [wJumptableIndex], a
	scf
	ret

.d_left
	ld a, b
	ld [wJumptableIndex], a
	ld [wPackJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, c
	ld [wJumptableIndex], a
	ld [wPackJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.select
	farcall SwitchItemsInBag
	ld hl, AskItemMoveText
	call Pack_PrintTextNoScroll
	scf
	ret

.switching_item
	ld a, [hl]
	and A_BUTTON | SELECT
	jr nz, .place_insert
	ld a, [hl]
	and B_BUTTON
	jr nz, .end_switch
	scf
	ret

.place_insert
	farcall SwitchItemsInBag
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
.end_switch
	xor a
	ld [wSwitchItem], a
	scf
	ret

Pack_InitGFX:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	ld hl, PackMenuGFX
	ld de, vTiles2
	ld bc, $60 tiles
	ld a, BANK(PackMenuGFX)
	call FarCopyBytes
; Background (blue if male, pink if female)
	hlcoord 0, 1
	ld bc, 11 * SCREEN_WIDTH
	ld a, $24
	call ByteFill
; This is where the items themselves will be listed.
	hlcoord 5, 1
	lb bc, 11, 15
	call ClearBox
; ◀▶ POCKET       ▼▲ ITEMS
;	hlcoord 0, 0
;	ld a, $28
;	ld c, SCREEN_WIDTH
;.loop
;	ld [hli], a
;	inc a
;	dec c
;	jr nz, .loop
	call DrawPocketName
	call PlacePackGFX
; Place the textbox for displaying the item description
	hlcoord 0, SCREEN_HEIGHT - 4 - 2
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	call EnableLCD
	jmp DrawPackGFX

PlacePackGFX:
	hlcoord 0, 3
	ld a, $50
	ld de, SCREEN_WIDTH - 5
	ld b, 3
.row
	ld c, 5
.column
	ld [hli], a
	inc a
	dec c
	jr nz, .column
	add hl, de
	dec b
	jr nz, .row
	ret

DrawPocketName:
	; Draw the top line.
	ld a, [wCurPocket]
	ld e, a
	ld d, 0
	ld hl, .separator
	add hl, de
	ld b, [hl] ; Stores the X coord of the separator (arrow).
	ld a, SCREEN_WIDTH
	sub b
	ld b, a ; Stores the X coord of the separator (arrow).

	hlcoord 0, 0
	ld c, $29
	ld d, SCREEN_WIDTH
.loop
	ld a, d
	cp b
	jr nz, .regular_char

;.separator
	ld a, $28
	jr .display_char

.regular_char
	ld a, c
	inc c
.display_char
	ld [hli], a
	dec d
	jr nz, .loop

	farcall RefreshPackTabsColors
	farcall ApplyAttrmap

	; Draw the box.
	ld a, [wCurPocket]
	; * 15
	ld d, a
	swap a
	sub d
	ld d, 0
	ld e, a
	ld hl, .tilemap
	add hl, de
	ld d, h
	ld e, l
	hlcoord 0, 7
	ld c, 3
.row
	ld b, 5
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .col
	ld a, c
	ld c, SCREEN_WIDTH - 5
	add hl, bc
	ld c, a
	dec c
	jr nz, .row
	ret

.separator:
if DEF(_FR_FR)
	db 0  ; ITEM_POCKET     ; 0
	db 6  ; BALL_POCKET     ; 1
	db 16 ; KEY_ITEM_POCKET ; 2
	db 12 ; TM_HM_POCKET    ; 3
	db 3  ; MED_POCKET      ; 4
	db 9  ; BERRIES_POCKET  ; 5
else
	db 0  ; ITEM_POCKET     ; 0
	db 6  ; BALL_POCKET     ; 1
	db 17 ; KEY_ITEM_POCKET ; 2
	db 13 ; TM_HM_POCKET    ; 3
	db 3  ; MED_POCKET      ; 4
	db 9  ; BERRIES_POCKET  ; 5
endc

.tilemap: ; 5x12
; the 5x3 pieces correspond to *_POCKET constants
INCBIN "gfx/pack/pack_menu.tilemap"

Pack_GetItemName:
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	call CopyName1
	ret

ClearPocketList:
	hlcoord 5, 2
	lb bc, 10, SCREEN_WIDTH - 5
	call ClearBox
	ret

Pack_InitColors:
	call WaitBGMap
	ld b, SCGB_PACKPALS
	call GetSGBLayout
	call SetPalettes
	jmp DelayFrame

ItemsPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

PC_Mart_ItemsPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

KeyItemsPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wNumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

PC_Mart_KeyItemsPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wNumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

BallsPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

PC_Mart_BallsPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

MedPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumMeds
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

PC_Mart_MedPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumMeds
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

BerryPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBerries
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

PC_Mart_BerryPocketMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 7, 1, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_ENABLE_SELECT | STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBerries
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

AskThrowAwayText:
	text_far _AskThrowAwayText
	text_end

AskQuantityThrowAwayText:
	text_far _AskQuantityThrowAwayText
	text_end

ThrewAwayText:
	text_far _ThrewAwayText
	text_end

OakThisIsntTheTimeText:
	text_far _OakThisIsntTheTimeText
	text_end

YouDontHaveAMonText:
	text_far _YouDontHaveAMonText
	text_end

RegisteredItemText:
	text_far _RegisteredItemText
	text_end

CantRegisterText:
	text_far _CantRegisterText
	text_end

AskItemMoveText:
	text_far _AskItemMoveText
	text_end

PackEmptyText:
	text_far _PackEmptyText
	text_end

YouCantUseItInABattleText: ; unreferenced
	text_far _YouCantUseItInABattleText
	text_end

PackMenuGFX:
if DEF(_FR_FR)
INCBIN "gfx/pack/pack_menu_fr.2bpp"
else
INCBIN "gfx/pack/pack_menu.2bpp"
endc

PackGFX:
INCBIN "gfx/pack/pack.2bpp"
