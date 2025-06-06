_DepositPKMN:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BillsPC_InitRAM
	xor a
	ld [wBillsPC_LoadedBox], a
	call DelayFrame
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop
.done
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions], a
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call BillsPC_Jumptable
	jp hl

.Jumptable:
	dw .Init
	dw .HandleJoypad
	dw .WhatsUp
	dw .Submenu
	dw BillsPC_EndJumptableLoop

.Init:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call CopyBoxmonSpecies
	call BillsPC_BoxName
	ld de, PCString_ChooseaPKMN
	call BillsPC_PlaceString
	ld a, $5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	ld a, $ff
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	call BillsPC_ApplyPalettes
	call WaitBGMap
	call BillsPC_UpdateSelectionCursor
	jmp BillsPC_IncrementJumptableIndex

.HandleJoypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	call Withdraw_UpDown
	and a
	ret z
	call BillsPC_UpdateSelectionCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jmp DelayFrame

.a_button
	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	jr z, .b_button
	ld a, $2
	ld [wJumptableIndex], a
	ret

.go_back ; unreferenced
	ld hl, wJumptableIndex
	dec [hl]
	ret

.b_button
	ld a, $4
	ld [wJumptableIndex], a
	ret

.WhatsUp:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call BillsPC_GetSelectedPokemonSpecies
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	call BillsPC_ApplyPalettes
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	ld a, $1
	ld [wMenuCursorY], a
	jmp BillsPC_IncrementJumptableIndex

.Submenu:
	ld hl, BillsPCDepositMenuHeader
	call CopyMenuHeader
	ld a, [wMenuCursorY]
	call StoreMenuCursorPosition
	call VerticalMenu
	jp c, BillsPCDepositFuncCancel
	ld a, [wMenuCursorY]
	dec a
	and %11
	ld e, a
	ld d, 0
	ld hl, BillsPCDepositJumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

BillsPCDepositJumptable:
	dw BillsPCDepositFuncDeposit ; Deposit Pokemon
	dw BillsPCDepositFuncStats ; Pokemon Stats
	dw BillsPCDepositFuncRelease ; Release Pokemon
	dw BillsPCDepositFuncCancel ; Cancel

BillsPCDepositFuncDeposit:
	call BillsPC_CheckMail_PreventBlackout
	jp c, BillsPCDepositFuncCancel
	call DepositPokemon
	jr c, .box_full
	ld a, $0
	ld [wJumptableIndex], a
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ret

.box_full
	ld de, PCString_WhatsUp
	jmp BillsPC_PlaceString

BillsPCDepositFuncStats:
	call LoadStandardMenuHeader
	call BillsPC_StatsScreen
	call ExitMenu
	call PCMonInfo
	call BillsPC_GetSelectedPokemonSpecies
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	jmp BillsPC_ApplyPalettes

BillsPCDepositFuncRelease:
	call BillsPC_CheckMail_PreventBlackout
	jr c, BillsPCDepositFuncCancel
	call BillsPC_IsMonAnEgg
	jr c, BillsPCDepositFuncCancel
	call BillsPC_IsSilphCoProperty
	jr c, BillsPCDepositFuncCancel
	call BillsPC_IsRedsPikachu
	jr c, BillsPCDepositFuncCancel
	ld a, [wMenuCursorY]
	push af
	ld de, PCString_ReleasePKMN
	call BillsPC_PlaceString
	call LoadStandardMenuHeader
	lb bc, 14, 11
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	call ExitMenu
	and a
	jr nz, .failed_release
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	call ReleasePKMN_ByePKMN
	ld a, $0
	ld [wJumptableIndex], a
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	pop af
	ret

.failed_release
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	pop af
	ld [wMenuCursorY], a
	ret

BillsPCDepositFuncCancel:
	ld a, $0
	ld [wJumptableIndex], a
	ret

BillsPCDepositMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 9, 4, SCREEN_WIDTH - 1, 13
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "STOCKER@"
	db "STATS@"
	db "RELACHER@"
	db "RETOUR@"
else
	db "DEPOSIT@"
	db "STATS@"
	db "RELEASE@"
	db "CANCEL@"
endc

BillsPCClearThreeBoxes: ; unreferenced
	hlcoord 0, 0
	lb bc, 4, 8
	call ClearBox
	hlcoord 0, 4
	lb bc, 10, 9
	call ClearBox
	hlcoord 0, 14
	lb bc, 2, 8
	jmp ClearBox

_WithdrawPKMN:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BillsPC_InitRAM
	ld a, NUM_BOXES + 1
	ld [wBillsPC_LoadedBox], a
	call DelayFrame
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop
.done
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions], a
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call BillsPC_Jumptable
	jp hl

.Jumptable:
	dw .Init
	dw .Joypad
	dw .PrepSubmenu
	dw BillsPC_Withdraw
	dw BillsPC_EndJumptableLoop

.Init:
	ld a, NUM_BOXES + 1
	ld [wBillsPC_LoadedBox], a
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call CopyBoxmonSpecies
	call BillsPC_BoxName
	ld de, PCString_ChooseaPKMN
	call BillsPC_PlaceString
	ld a, $5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	ld a, $ff
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	call BillsPC_ApplyPalettes
	call WaitBGMap
	call BillsPC_UpdateSelectionCursor
	jmp BillsPC_IncrementJumptableIndex

.Joypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	call Withdraw_UpDown
	and a
	ret z
	call BillsPC_UpdateSelectionCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jmp DelayFrame
.a_button
	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	jr z, .b_button
	ld a, $2
	ld [wJumptableIndex], a
	ret

.go_back ; unreferenced
	ld hl, wJumptableIndex
	dec [hl]
	ret

.b_button
	ld a, $4
	ld [wJumptableIndex], a
	ret

.PrepSubmenu:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call BillsPC_GetSelectedPokemonSpecies
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	call BillsPC_ApplyPalettes
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	ld a, $1
	ld [wMenuCursorY], a
	jmp BillsPC_IncrementJumptableIndex

BillsPC_Withdraw:
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wMenuCursorY]
	call StoreMenuCursorPosition
	call VerticalMenu
	jp c, .cancel
	ld a, [wMenuCursorY]
	dec a
	and %11
	ld e, a
	ld d, 0
	ld hl, .dw
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.dw
	dw .withdraw ; Withdraw
	dw .stats ; Stats
	dw .release ; Release
	dw .cancel ; Cancel

.withdraw
	call BillsPC_CheckMail_PreventBlackout
	jp c, .cancel
	call TryWithdrawPokemon
	jr c, .FailedWithdraw
	ld a, $0
	ld [wJumptableIndex], a
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ret
.FailedWithdraw:
	ld de, PCString_WhatsUp
	jmp BillsPC_PlaceString

.stats
	call LoadStandardMenuHeader
	call BillsPC_StatsScreen
	call ExitMenu
	call PCMonInfo
	call BillsPC_GetSelectedPokemonSpecies
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	jmp BillsPC_ApplyPalettes

.release
	ld a, [wMenuCursorY]
	push af
	call BillsPC_IsMonAnEgg
	jr c, .FailedRelease
	call BillsPC_IsSilphCoProperty
	jr c, .FailedRelease
	call BillsPC_IsRedsPikachu
	jr c, .FailedRelease
	ld de, PCString_ReleasePKMN
	call BillsPC_PlaceString
	call LoadStandardMenuHeader
	lb bc, 14, 11
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	call ExitMenu
	and a
	jr nz, .FailedRelease
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	call ReleasePKMN_ByePKMN
	ld a, $0
	ld [wJumptableIndex], a
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	pop af
	ret
.FailedRelease:
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	pop af
	ld [wMenuCursorY], a
	ret

.cancel
	ld a, $0
	ld [wJumptableIndex], a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 9, 4, SCREEN_WIDTH - 1, 13
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "RETIRER@"
	db "STATS@"
	db "RELACHER@"
	db "RETOUR@"
else
	db "WITHDRAW@"
	db "STATS@"
	db "RELEASE@"
	db "CANCEL@"
endc

_MovePKMNWithoutMail:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BillsPC_InitRAM
	ld a, [wCurBox]
	and $f
	inc a
	ld [wBillsPC_LoadedBox], a
	call DelayFrame
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop

.done
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions], a
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call BillsPC_Jumptable
	jp hl

.Jumptable:
	dw .Init
	dw .Joypad
	dw .PrepSubmenu
	dw .MoveMonWOMailSubmenu
	dw .PrepInsertCursor
	dw .Joypad2
	dw BillsPC_EndJumptableLoop

.Init:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call CopyBoxmonSpecies
	ld de, PCString_ChooseaPKMN
	call BillsPC_PlaceString
	ld a, 5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call BillsPC_MoveMonWOMail_BoxNameAndArrows
	call PCMonInfo
	ld a, $ff
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	call BillsPC_ApplyPalettes
	call WaitBGMap
	call BillsPC_UpdateSelectionCursor
	jmp BillsPC_IncrementJumptableIndex

.Joypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	call MoveMonWithoutMail_DPad
	jr c, .d_pad
	and a
	ret z
	call BillsPC_UpdateSelectionCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jmp DelayFrame

.d_pad
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ld a, $0
	ld [wJumptableIndex], a
	ret

.a_button
	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	jr z, .b_button
	ld a, $2
	ld [wJumptableIndex], a
	ret

.go_back ; unreferenced
	ld hl, wJumptableIndex
	dec [hl]
	ret

.b_button
	ld a, $6
	ld [wJumptableIndex], a
	ret

.PrepSubmenu:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call BillsPC_GetSelectedPokemonSpecies
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	call BillsPC_ApplyPalettes
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	ld a, $1
	ld [wMenuCursorY], a
	jmp BillsPC_IncrementJumptableIndex

.MoveMonWOMailSubmenu:
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wMenuCursorY]
	call StoreMenuCursorPosition
	call VerticalMenu
	jp c, .Cancel
	ld a, [wMenuCursorY]
	dec a
	and %11
	ld e, a
	ld d, 0
	ld hl, .Jumptable2
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable2:
	dw .Move
	dw .Stats
	dw .Cancel

.Move:
	call BillsPC_CheckMail_PreventBlackout
	jp c, .Cancel
	ld a, [wBillsPC_ScrollPosition]
	ld [wBillsPC_BackupScrollPosition], a
	ld a, [wBillsPC_CursorPosition]
	ld [wBillsPC_BackupCursorPosition], a
	ld a, [wBillsPC_LoadedBox]
	ld [wBillsPC_BackupLoadedBox], a
	ld a, $4
	ld [wJumptableIndex], a
	ret

.Stats:
	call LoadStandardMenuHeader
	call BillsPC_StatsScreen
	call ExitMenu
	call PCMonInfo
	call BillsPC_GetSelectedPokemonSpecies
	ld [wCurPartySpecies], a
	ld a, SCGB_BILLS_PC
	jmp BillsPC_ApplyPalettes

.Cancel:
	ld a, $0
	ld [wJumptableIndex], a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 9, 4, SCREEN_WIDTH - 1, 13
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
if DEF(_FR_FR)
	db "ORDRE@"
	db "STATS@"
	db "RETOUR@"
else
	db "MOVE@"
	db "STATS@"
	db "CANCEL@"
endc

.PrepInsertCursor:
	xor a
	ldh [hBGMapMode], a
	call CopyBoxmonSpecies
	ld de, PCString_MoveToWhere
	call BillsPC_PlaceString
	ld a, $5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call BillsPC_MoveMonWOMail_BoxNameAndArrows
	call ClearSprites
	call BillsPC_UpdateInsertCursor
	call WaitBGMap
	jmp BillsPC_IncrementJumptableIndex

.Joypad2:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button_2
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button_2
	call MoveMonWithoutMail_DPad_2
	jr c, .dpad_2
	and a
	ret z
	call BillsPC_UpdateInsertCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jmp DelayFrame

.dpad_2
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ld a, $4
	ld [wJumptableIndex], a
	ret

.a_button_2
	call BillsPC_CheckSpaceInDestination
	jr c, .no_space
	call MovePKMNWitoutMail_InsertMon
	ld a, $0
	ld [wJumptableIndex], a
	ret

.no_space
	ld hl, wJumptableIndex
	dec [hl]
	ret

.b_button_2
	ld a, [wBillsPC_BackupScrollPosition]
	ld [wBillsPC_ScrollPosition], a
	ld a, [wBillsPC_BackupCursorPosition]
	ld [wBillsPC_CursorPosition], a
	ld a, [wBillsPC_BackupLoadedBox]
	ld [wBillsPC_LoadedBox], a
	ld a, $0
	ld [wJumptableIndex], a
	ret

BillsPC_InitRAM:
	call ClearBGPalettes
	call ClearSprites
	call ClearTilemap
	call BillsPC_InitGFX
	ld hl, wBillsPCData
	ld bc, wBillsPCDataEnd - wBillsPCData
	xor a
	call ByteFill
	xor a
	ld [wJumptableIndex], a
	ld [wUnusedBillsPCData], a
	ld [wUnusedBillsPCData+1], a
	ld [wUnusedBillsPCData+2], a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ret

BillsPC_IncrementJumptableIndex:
	ld hl, wJumptableIndex
	inc [hl]
	ret

BillsPC_EndJumptableLoop:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

_StatsScreenDPad:
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	and a
	jr z, .empty
	dec a
	cp $1
	jr z, .empty
	ld e, a
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown
.empty
	jmp BillsPC_JoypadDidNothing

Withdraw_UpDown:
	ld hl, hJoyLast
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	ld e, a
	and a
	jr z, .empty
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown
.empty
	jmp BillsPC_JoypadDidNothing

MoveMonWithoutMail_DPad:
	ld hl, hJoyLast
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	ld e, a
	and a
	jr z, .check_left_right
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown

.check_left_right
	ld a, [hl]
	and D_LEFT
	jr nz, BillsPC_PressLeft
	ld a, [hl]
	and D_RIGHT
	jr nz, BillsPC_PressRight
	jmp BillsPC_JoypadDidNothing

MoveMonWithoutMail_DPad_2:
	ld hl, hJoyLast
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	ld e, a
	and a
	jr z, .check_left_right

	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown

.check_left_right
	ld a, [hl]
	and D_LEFT
	jr nz, BillsPC_PressLeft
	ld a, [hl]
	and D_RIGHT
	jr nz, BillsPC_PressRight
	jr BillsPC_JoypadDidNothing

BillsPC_PressUp:
	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	and a
	jr z, .top
	dec [hl]
	jr BillsPC_UpDownDidSomething

.top
	ld hl, wBillsPC_ScrollPosition
	ld a, [hl]
	and a
	jr z, BillsPC_JoypadDidNothing
	dec [hl]
	jr BillsPC_UpDownDidSomething

BillsPC_PressDown:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	inc a
	cp e
	jr nc, BillsPC_JoypadDidNothing

	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	inc a
	cp d
	jr nc, .not_bottom
	inc [hl]
	jr BillsPC_UpDownDidSomething

.not_bottom
	ld hl, wBillsPC_ScrollPosition
	inc [hl]
	jr BillsPC_UpDownDidSomething

BillsPC_PressLeft:
	ld hl, wBillsPC_LoadedBox
	ld a, [hl]
	and a
	jr z, .wrap_around
	dec [hl]
	jr BillsPC_LeftRightDidSomething

.wrap_around
	; We display either 13 boxes (Johto) or 14 (Kanto).
	push hl
	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld de, ENGINE_FLYPOINT_VERMILION - ENGINE_FLYPOINT_PLAYERS_HOUSE
	call FlagAction ; Returns the result of the check in c.
	pop hl
	ld a, c
	and a
	ld [hl], NUM_BOXES - 1
	jr z, BillsPC_LeftRightDidSomething	; false, the player hasn't reached Vermilion yet.
	
	ld [hl], NUM_BOXES
	jr BillsPC_LeftRightDidSomething

BillsPC_PressRight:
	push hl
	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld de, ENGINE_FLYPOINT_VERMILION - ENGINE_FLYPOINT_PLAYERS_HOUSE
	call FlagAction ; Returns the result of the check in c.
	pop hl
	ld a, c
	and a
	ld b, NUM_BOXES - 1
	jr z, .boxes_amount_determined	; false, the player hasn't reached Vermilion yet.
	
	ld b, NUM_BOXES

.boxes_amount_determined
	ld hl, wBillsPC_LoadedBox
	ld a, [hl]
	cp b
	jr z, .wrap_around
	inc [hl]
	jr BillsPC_LeftRightDidSomething

.wrap_around
	ld [hl], 0
	jr BillsPC_LeftRightDidSomething

BillsPC_JoypadDidNothing:
	xor a
	and a
	ret

BillsPC_UpDownDidSomething:
	ld a, TRUE
	and a
	ret

BillsPC_LeftRightDidSomething:
	scf
	ret

BillsPC_PlaceString:
	push de
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	pop de
	hlcoord 1, 16
	jmp PlaceString

BillsPC_MoveMonWOMail_BoxNameAndArrows:
	call BillsPC_BoxName
	hlcoord 8, 1
	ld [hl], $5f
	hlcoord 19, 1
	ld [hl], $5e
	ret

BillsPC_BoxName:
	hlcoord 8, 0
	lb bc, 1, 10
	call Textbox

	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party

	cp NUM_BOXES + 1
	jr nz, .gotbox

	ld a, [wCurBox]
	inc a
.gotbox
	dec a
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	jr .print

.party
	ld de, .PartyPKMN
.print
	hlcoord 10, 1
	jmp PlaceString

.PartyPKMN:
if DEF(_FR_FR)
	db "EQUIPE<PK><MN>@"
else
	db "PARTY <PK><MN>@"
endc

PCMonInfo:
; Display a monster's pic and
; attributes when highlighting
; it in a PC menu.

; Includes the neat cascading
; effect when showing the pic.

; Example: Species, level, gender,
; whether it's holding an item.

	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox

	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox

	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	ret z

	ld [wTempSpecies], a
	hlcoord 1, 4
	xor a
	ld b, 7
.row
	ld c, 7
	push af
	push hl
.col
	ld [hli], a
	add 7
	dec c
	jr nz, .col
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .row

	call BillsPC_LoadMonStats
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld hl, wTempMonDVs
	predef GetUnownLetter
	call GetBaseData
	ld de, vTiles2 tile $00
	predef GetMonFrontpic
	xor a
	ld [wBillsPC_MonHasMail], a
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	cp EGG
	ret z

	call GetBasePokemonName
	hlcoord 1, 14
	call PlaceString

	hlcoord 1, 12
	call PrintLevel

	ld a, $3
	ld [wMonType], a
	farcall GetGender
	jr c, .skip_gender
	ld a, "♂"
	jr nz, .printgender
	ld a, "♀"
.printgender
	hlcoord 5, 12
	ld [hl], a
.skip_gender

	ld a, [wTempMonItem]
	and a
	ret z

	ld d, a
	callfar ItemIsMail
	jr c, .mail
	ld a, $5d ; item icon
	jr .printitem
.mail
	ld a, $1
	ld [wBillsPC_MonHasMail], a
	ld a, $5c ; mail icon
.printitem
	hlcoord 7, 12
	ld [hl], a
	ret

BillsPC_LoadMonStats:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld d, 0
	ld hl, wBillsPCPokemonList + 1 ; box number
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr z, .sBox
	ld b, a
	call GetBoxPointer
	ld a, b
	call OpenSRAM
	push hl
	ld bc, sBoxMon1Level - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	pop hl
	push hl
	ld bc, sBoxMon1Item - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	pop hl
	ld bc, sBoxMon1DVs - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld de, wTempMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jmp CloseSRAM

.party
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld de, wTempMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

.sBox
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxMon1Level
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a

	ld hl, sBoxMon1Item
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a

	ld hl, sBoxMon1DVs
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld de, wTempMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	jmp CloseSRAM

BillsPC_RefreshTextboxes:
	hlcoord 8, 2
	lb bc, 10, 10
	call Textbox

	hlcoord 8, 2
	ld [hl], "└"
	hlcoord 19, 2
	ld [hl], "┘"

	ld a, [wBillsPC_ScrollPosition]
	ld e, a
	ld d, 0
	ld hl, wBillsPCPokemonList
	add hl, de
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	hlcoord 9, 4
	ld a, [wBillsPC_NumMonsOnScreen]
.loop
	push af
	push de
	push hl
	call .PlaceNickname
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	inc de
	inc de
	inc de
	pop af
	dec a
	jr nz, .loop
	ret

.CancelString:
if DEF(_FR_FR)
	db "RETOUR@"
else
	db "CANCEL@"
endc

.PlaceNickname:
	ld a, [de]
	and a
	ret z
	cp -1
	jr nz, .get_nickname
	ld de, .CancelString
	jmp PlaceString

.get_nickname
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld e, a
	ld a, b
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr z, .sBox
	push hl
	call GetBoxPointer
	ld a, b
	call OpenSRAM
	push hl
	ld bc, sBoxMons - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	pop hl
	and a
	jr z, .boxfail
	ld bc, sBoxMonNicknames - sBox
	add hl, bc
	ld bc, MON_NAME_LENGTH
	ld a, e
	call AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	call CloseSRAM
	pop hl
	ld de, wStringBuffer1
	jmp PlaceString

.boxfail
	call CloseSRAM
	pop hl
	jr .placeholder_string

.party
	push hl
	ld hl, wPartySpecies
	ld d, $0
	add hl, de
	ld a, [hl]
	and a
	jr z, .partyfail
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, e
	call AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl
	ld de, wStringBuffer1
	jmp PlaceString

.partyfail
	pop hl
	jr .placeholder_string

.sBox
	push hl
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxSpecies
	ld d, $0
	add hl, de
	ld a, [hl]
	and a
	jr z, .sBoxFail
	ld hl, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, e
	call AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	call CloseSRAM
	pop hl
	ld de, wStringBuffer1
	jmp PlaceString

.sBoxFail
	call CloseSRAM
	pop hl
.placeholder_string
	ld de, .Placeholder
	jmp PlaceString

.Placeholder:
if DEF(_FR_FR)
	db "-----@"
else
	db "-----@"
endc

copy_box_data: MACRO
.loop\@
	ld a, [hl]
	cp -1
	jr z, .done\@
	and a
	jr z, .done\@
	ld [de], a ; species
	inc de
	ld a, [wBillsPC_LoadedBox]
	ld [de], a ; box number
	inc de
	ld a, [wBillsPCTempListIndex]
	ld [de], a ; list index
	inc a
	ld [wBillsPCTempListIndex], a
	inc de
	inc hl
	ld a, [wBillsPCTempBoxCount]
	inc a
	ld [wBillsPCTempBoxCount], a
	jr .loop\@

.done\@
if \1
	call CloseSRAM
endc
	ld a, -1
	ld [de], a
	ld a, [wBillsPCTempBoxCount]
	inc a
	ld [wBillsPC_NumMonsInBox], a
ENDM

CopyBoxmonSpecies:
	xor a
	ld hl, wBillsPCPokemonList
	ld bc, 3 * 30
	call ByteFill
	ld de, wBillsPCPokemonList
	xor a
	ld [wBillsPCTempListIndex], a
	ld [wBillsPCTempBoxCount], a
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr z, .sBox
	ld b, a
	call GetBoxPointer
	ld a, b
	call OpenSRAM
	inc hl
	copy_box_data 1
	ret

.party
	ld hl, wPartySpecies
	copy_box_data 0
	ret

.sBox
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxSpecies
	copy_box_data 1
	ret

BillsPC_GetSelectedPokemonSpecies:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld d, 0
	ld hl, wBillsPCPokemonList
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	ret

BillsPC_UpdateSelectionCursor:
	ld a, [wBillsPC_NumMonsInBox]
	and a
	jr nz, .place_cursor
	jmp ClearSprites

.place_cursor
	ld hl, .OAM
	ld de, wVirtualOAMSprite00
.loop
	ld a, [hl]
	cp -1
	ret z
	ld a, [wBillsPC_CursorPosition]
	and $7
	swap a
	add [hl]
	inc hl
	ld [de], a ; y
	inc de
rept SPRITEOAMSTRUCT_LENGTH - 1
	ld a, [hli]
	ld [de], a
	inc de
endr
	jr .loop

.OAM:
	dbsprite 10, 4, 0, 6, $00, 0
	dbsprite 11, 4, 0, 6, $00, 0
	dbsprite 12, 4, 0, 6, $00, 0
	dbsprite 13, 4, 0, 6, $00, 0
	dbsprite 14, 4, 0, 6, $00, 0
	dbsprite 15, 4, 0, 6, $00, 0
	dbsprite 16, 4, 0, 6, $00, 0
	dbsprite 17, 4, 0, 6, $00, 0
	dbsprite 18, 4, 0, 6, $00, 0
	dbsprite 18, 4, 7, 6, $00, 0
	dbsprite 10, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 11, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 12, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 13, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 14, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 15, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 16, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 17, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 18, 7, 0, 1, $00, 0 | Y_FLIP
	dbsprite 18, 7, 7, 1, $00, 0 | Y_FLIP
	dbsprite  9, 5, 6, 6, $01, 0
	dbsprite  9, 6, 6, 1, $01, 0 | Y_FLIP
	dbsprite 19, 5, 1, 6, $01, 0 | X_FLIP
	dbsprite 19, 6, 1, 1, $01, 0 | X_FLIP | Y_FLIP
	db -1

BillsPC_UpdateInsertCursor:
	ld hl, .OAM
	ld de, wVirtualOAMSprite00
.loop
	ld a, [hl]
	cp -1
	ret z
	ld a, [wBillsPC_CursorPosition]
	and $7
	swap a
	add [hl]
	inc hl
	ld [de], a ; y
	inc de
rept SPRITEOAMSTRUCT_LENGTH - 1
	ld a, [hli]
	ld [de], a
	inc de
endr
	jr .loop

.OAM:
	dbsprite 10, 4, 0, 7, $06, 0
	dbsprite 11, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 12, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 13, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 14, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 15, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 16, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 17, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 18, 5, 0, 3, $00, 0 | Y_FLIP
	dbsprite 19, 4, 0, 7, $07, 0
	db -1

BillsPC_FillBox: ; unreferenced
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

BillsPC_CheckSpaceInDestination:
; If moving within a box, no need to be here.
	ld hl, wBillsPC_LoadedBox
	ld a, [wBillsPC_BackupLoadedBox]
	cp [hl]
	jr z, .same_box

; Exceeding box or party capacity is a big no-no.
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	ld e, MONS_PER_BOX + 1
	jr .compare

.party
	ld e, PARTY_LENGTH + 1
.compare
	ld a, [wBillsPC_NumMonsInBox]
	cp e
	jr nc, .no_room
.same_box
	and a
	ret

.no_room
	ld de, PCString_TheresNoRoom
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	ld c, 50
	call DelayFrames
	scf
	ret

BillsPC_CheckMail_PreventBlackout:
	ld a, [wBillsPC_LoadedBox]
	and a
	jr nz, .Okay
	ld a, [wBillsPC_NumMonsInBox]
	cp $3
	jr c, .ItsYourLastPokemon
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	farcall CheckCurPartyMonFainted
	jr c, .AllOthersFainted
	ld a, [wBillsPC_MonHasMail]
	and a
	jr nz, .HasMail
.Okay:
	and a
	ret

.HasMail:
	ld de, PCString_RemoveMail
	jr .NotOkay

.AllOthersFainted:
	ld de, PCString_NoMoreUsablePKMN
	jr .NotOkay

.ItsYourLastPokemon:
	ld de, PCString_ItsYourLastPKMN
.NotOkay:
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	ld c, 50
	call DelayFrames
	scf
	ret

BillsPC_IsMonAnEgg:
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	and a
	ret

.egg
	ld de, PCString_NoReleasingEGGS

ReleaseRefusalNotification:
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	ld c, 50
	call DelayFrames
	scf
	ret

BillsPC_IsSilphCoProperty:
	farcall IsTestSubjectForSure
	ret nc

	; Place refusal text here.
	; Get inspiration from the .egg code above.
	ld de, PCString_SilphCoProperty
	jr ReleaseRefusalNotification

BillsPC_IsRedsPikachu:
	farcall IsRedsPikachu_PartyOrBox
	ret nc

	ld de, PCString_PikachuRefuses
	jr ReleaseRefusalNotification

; Input: 
; 		Trainer ID in BC,
;		species in D (-1 if you don't want to check it),
;		level in E (-1 if you don't want to check it),
; 		name in wStringBuffer1.
; Output: Carry if the selected mon matches the inputs.
BillsPC_CheckSelectedMonOTIDAndName::
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a

	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party

;.loaded_box
	ld a, d
	cp -1
	jr z, .loaded_box_skip_species_check

	ld hl, sBoxMon1Species
    ld a, [wCurPartyMon]
    push bc
    ld bc, BOXMON_STRUCT_LENGTH
    call AddNTimes
    pop bc

    ld a, BANK(sBoxMon1Species)
    call OpenSRAM
	ld a, [hl]
    sub d
    call CloseSRAM
    jp nz, .return_false

.loaded_box_skip_species_check
	ld a, e
	cp -1
	jr z, .loaded_box_skip_level_check

	ld hl, sBoxMon1Level
    ld a, [wCurPartyMon]
    push bc
    ld bc, BOXMON_STRUCT_LENGTH
    call AddNTimes
    pop bc

    ld a, BANK(sBoxMon1Level)
    call OpenSRAM
	ld a, [hl]
    sub e
    call CloseSRAM
    jp nz, .return_false

.loaded_box_skip_level_check
    ld hl, sBoxMon1ID
    ld a, [wCurPartyMon]
    push bc
    ld bc, BOXMON_STRUCT_LENGTH
    call AddNTimes
    pop bc

    ld a, BANK(sBoxMon1ID)
    call OpenSRAM

    ld a, [hli]
    sub b
    jp nz, .close_sram_then_return_false

    ld a, [hl]
    sub c
    jr nz, .close_sram_then_return_false

    call CloseSRAM

    ; We have found the right ID, now we need to check the Original Trainer name.

    ld hl, sBoxMonOTs
    ld a, [wCurPartyMon]
    call SkipNames

    ld de, wStringBuffer1
	call CountChars
	ld c, a

    ld a, BANK(sBoxMonOTs)
    call OpenSRAM
    call CompareBytes ; Compare c bytes at de and hl. Return z if they all match.
    call CloseSRAM
    jr nz, .return_false

    jr .return_true
    
.party::
	ld a, d
	cp -1
	jr z, .party_skip_species_check

	ld hl, wPartyMon1Species
    ld a, [wCurPartyMon]
    push bc
    ld bc, PARTYMON_STRUCT_LENGTH
    call AddNTimes
    pop bc

    ld a, [hl]
    sub d
    jr nz, .return_false

.party_skip_species_check
	ld a, e
	cp -1
	jr z, .party_skip_level_check

	ld hl, wPartyMon1Level	
    ld a, [wCurPartyMon]
    push bc
    ld bc, PARTYMON_STRUCT_LENGTH
    call AddNTimes
    pop bc

    ld a, [hl]
    sub e
    jr nz, .return_false

.party_skip_level_check
    ld hl, wPartyMon1ID
    ld a, [wCurPartyMon]
    push bc
    ld bc, PARTYMON_STRUCT_LENGTH
    call AddNTimes
    pop bc

    ld a, [hli]
    sub b
    jr nz, .return_false

    ld a, [hl]
    sub c
    jr nz, .return_false

    ; We have found the right ID, now we need to check the Original Trainer name.

    ld hl, wPartyMonOTs
    ld a, [wCurPartyMon]
    call SkipNames

    ld de, wStringBuffer1
	call CountChars
	ld c, a

    call CompareBytes ; Compare c bytes at de and hl. Return z if they all match.
    jr nz, .return_false

.return_true
    scf
    ret

.close_sram_then_return_false
    call CloseSRAM
.return_false
    xor a
    ret

BillsPC_StatsScreen:
	call LowVolume
	call BillsPC_CopyMon
	ld a, TEMPMON
	ld [wMonType], a
	predef StatsScreenInit
	call BillsPC_InitGFX
	jmp MaxVolume

StatsScreenDPad:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON | D_RIGHT | D_LEFT
	ld [wMenuJoypad], a
	jr nz, .pressed_a_b_right_left
	ld a, [hl]
	and D_DOWN | D_UP
	ld [wMenuJoypad], a
	jr nz, .pressed_down_up
	jr .pressed_a_b_right_left

.pressed_down_up
	call _StatsScreenDPad
	and a
	jr z, .did_nothing
	call BillsPC_GetSelectedPokemonSpecies
	ld [wTempSpecies], a
	call BillsPC_LoadMonStats
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld hl, wTempMonDVs
	predef GetUnownLetter
	call GetBaseData
	call BillsPC_CopyMon
.pressed_a_b_right_left
	ret

.did_nothing
	xor a
	ld [wMenuJoypad], a
	ret

BillsPC_CopyMon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr nz, .box
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxSpecies
	call CopySpeciesToTemp
	ld hl, sBoxMonNicknames
	call CopyNicknameToTemp
	ld hl, sBoxMonOTs
	call CopyOTNameToTemp
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	call CloseSRAM
	farcall CalcBufferMonStats
	ret

.party
	ld hl, wPartySpecies
	call CopySpeciesToTemp
	ld hl, wPartyMonNicknames
	call CopyNicknameToTemp
	ld hl, wPartyMonOTs
	call CopyOTNameToTemp
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	jmp CopyBytes

.box
	ld b, a
	call GetBoxPointer
	ld a, b
	call OpenSRAM
	push hl
	inc hl
	call CopySpeciesToTemp
	pop hl
	push hl
	ld bc, sBoxMonNicknames - sBox
	add hl, bc
	call CopyNicknameToTemp
	pop hl
	push hl
	ld bc, sBoxMonOTs - sBox
	add hl, bc
	call CopyOTNameToTemp
	pop hl
	ld bc, sBoxMons - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyMonToTemp
	call CloseSRAM
	farcall CalcBufferMonStats
	ret

DepositPokemon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNickname
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	jr c, .BoxFull
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ld a, [wCurPartySpecies]
	call PlayMonCry
	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox
	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	call WaitBGMap
	hlcoord 1, 16

if DEF(_FR_FR)
	ld de, wStringBuffer1
	call PlaceString
	ld l, c
	ld h, b
	ld de, PCString_Stored
	call PlaceString
else
	ld de, PCString_Stored
	call PlaceString
	ld l, c
	ld h, b
	ld de, wStringBuffer1
	call PlaceString
	ld a, "!"
	ld [bc], a
endc

	ld c, 50
	call DelayFrames
	and a
	ret

.BoxFull:
	ld de, PCString_BoxFull
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	ld c, 50
	call DelayFrames
	scf
	ret

; wCurPartyMon contains the pkmn to deposit.
DepositPokemonSilent::
	ld a, BANK(sHospitalBox)
	call OpenSRAM
	ld a, [sHospitalBoxCount]
	cp MONS_PER_BOX
	call CloseSRAM ; Doesn't affect the carry flag.
	jr c, .box_has_available_slots

	; The box is full, so we need to release the oldest Pokémon.
	ld a, [wCurPartyMon]
	ld e, a
	push de
	farcall RemoveFirstMonFromHospitalBox
	pop de
	ld a, e
	ld [wCurPartyMon], a

.box_has_available_slots
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNickname

	; Set the hospital duration to 3 days.
	ld a, MON_PKRUS
	call GetPartyParamLocation ; HL now points to the PokerusStatus of the party mon at index wCurPartyMon.
	ld a, [hl]
	and POKERUS_INVERSED_DURATION_MASK ; We delete the duration.
	add POKERUS_IMMUNITY_DURATION + HOSPITALIZATION_DURATION
	ld [hl], a

	; Lower the happiness of the Pokémon.
	ld a, MON_HAPPINESS
	call GetPartyParamLocation
	ld a, [hl]
	cp LOST_HAPPINESS_WHEN_HOSPITALIZED
	ld b, LOST_HAPPINESS_WHEN_HOSPITALIZED
	jr nc, .happiness_calculated

	ld b, a ; The Pokémon will lose all its happiness all the way to 0.

.happiness_calculated
	sub b
	ld [hl], a

	ld a, HOSPITAL_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	ret c
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox

	; Phone call check.
	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM
	ld a, [sHospitalBoxCount]
	call CloseSRAM
	cp MONS_PER_BOX - 3
	ret c

	; Phone call when hospital box is full.
	ld a, SPECIALCALL_RELEASE_HOSPITAL
	ld [wSpecialPhoneCallID], a
	ret

TryWithdrawPokemon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, BANK(sBoxMonNicknames)
	call OpenSRAM
	ld a, [wCurPartyMon]
	ld hl, sBoxMonNicknames
	call GetNickname
	call CloseSRAM
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	jr c, .PartyFull
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ld a, [wCurPartySpecies]
	call PlayMonCry
	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox
	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	call WaitBGMap
	hlcoord 1, 16

if DEF(_FR_FR)
	ld de, wStringBuffer1
	call PlaceString
	ld l, c
	ld h, b
	ld de, PCString_Got
	call PlaceString
else
	ld de, PCString_Got
	call PlaceString
	ld l, c
	ld h, b
	ld de, wStringBuffer1
	call PlaceString
	ld a, "!"
	ld [bc], a
endc

	ld c, 50
	call DelayFrames
	and a
	ret

.PartyFull:
	ld de, PCString_PartyFull
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	ld c, 50
	call DelayFrames
	scf
	ret

ReleasePKMN_ByePKMN:
	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox
	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox

	call WaitBGMap
	ld a, [wCurPartySpecies]
	call GetCryIndex
	jr c, .skip_cry
	ld e, c
	ld d, b
	call PlayCry
.skip_cry

	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	hlcoord 1, 16
	ld de, PCString_ReleasedPKMN
	call PlaceString
	ld c, 80
	call DelayFrames
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	hlcoord 1, 16
	ld de, PCString_Bye
	call PlaceString
	ld l, c
	ld h, b
	inc hl
	ld de, wStringBuffer1
	call PlaceString
	ld l, c
	ld h, b
	ld [hl], "!"
	ld c, 50
	jmp DelayFrames

MovePKMNWitoutMail_InsertMon:
	push hl
	push de
	push bc
	push af
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	hlcoord 1, 16
	ld de, .Saving_LeaveOn
	call PlaceString
	pop af
	pop bc
	pop de
	pop hl
	ld a, [wCurBox]
	push af
	ld bc, 0
	ld a, [wBillsPC_BackupLoadedBox]
	and a
	jr nz, .moving_from_box
	set 0, c

.moving_from_box
	ld a, [wBillsPC_LoadedBox]
	and a
	jr nz, .moving_to_box
	set 1, c

.moving_to_box
	ld hl, .Jumptable
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .dw_return
	push de
	jp hl

.dw_return
	pop af
	ld e, a
	farcall MoveMonWOMail_InsertMon_SaveGame
	ret

.Saving_LeaveOn:
if DEF(_FR_FR)
	db "Sauv.:patientez.@"
else
	db "Saving… Leave ON!@"
endc

.Jumptable:
	dw .BoxToBox
	dw .PartyToBox
	dw .BoxToParty
	dw .PartyToParty

.BoxToBox:
	ld hl, wBillsPC_BackupLoadedBox
	ld a, [wBillsPC_LoadedBox]
	cp [hl]
	jr z, .same_box
	call .CopyFromBox
	jmp .CopyToBox

.same_box
	call .CopyFromBox
	call .CheckTrivialMove
	jmp .CopyToBox

.PartyToBox:
	call .CopyFromParty
	ld a, $1
	ld [wGameLogicPaused], a
	farcall SaveGameData
	xor a
	ld [wGameLogicPaused], a
	jr .CopyToBox

.BoxToParty:
	call .CopyFromBox
	jmp .CopyToParty

.PartyToParty:
	call .CopyFromParty
	call .CheckTrivialMove
	jmp .CopyToParty

.CheckTrivialMove:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld a, [wBillsPC_BackupCursorPosition]
	ld hl, wBillsPC_BackupScrollPosition
	add [hl]
	cp e
	ret nc
	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	and a
	jr z, .top_of_screen
	dec [hl]
	ret

.top_of_screen
	ld hl, wBillsPC_ScrollPosition
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.CopyFromBox:
	ld a, [wBillsPC_BackupLoadedBox]
	dec a
	ld e, a
	farcall MoveMonWOMail_SaveGame
	ld a, [wBillsPC_BackupCursorPosition]
	ld hl, wBillsPC_BackupScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxSpecies
	call CopySpeciesToTemp
	ld hl, sBoxMonNicknames
	call CopyNicknameToTemp
	ld hl, sBoxMonOTs
	call CopyOTNameToTemp
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyMonToTemp
	call CloseSRAM
	farcall CalcBufferMonStats
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ret

.CopyToBox:
	ld a, [wBillsPC_LoadedBox]
	dec a
	ld e, a
	farcall MoveMonWOMail_SaveGame
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	farcall InsertPokemonIntoBox
	ret

.CopyFromParty:
	ld a, [wBillsPC_BackupCursorPosition]
	ld hl, wBillsPC_BackupScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld hl, wPartySpecies
	call CopySpeciesToTemp
	ld hl, wPartyMonNicknames
	call CopyNicknameToTemp
	ld hl, wPartyMonOTs
	call CopyOTNameToTemp
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyMonToTemp
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ret

.CopyToParty:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	farcall InsertPokemonIntoParty
	ret

CopySpeciesToTemp:
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ret

CopyNicknameToTemp:
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wBufferMonNickname
	ld bc, MON_NAME_LENGTH
	jmp CopyBytes

CopyOTNameToTemp:
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	jmp CopyBytes

CopyMonToTemp:
	ld a, [wCurPartyMon]
	call AddNTimes
	ld de, wBufferMon
	jmp CopyBytes

GetBoxPointer:
	dec b
	ld c, b
	ld b, 0
	ld hl, .BoxBankAddresses
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.BoxBankAddresses:
	table_width 3, GetBoxPointer.BoxBankAddresses
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14
	assert_table_length NUM_BOXES

BillsPC_ApplyPalettes:
	ld b, a
	call GetSGBLayout
	ld a, %11100100
	call DmgToCgbBGPals
	ld a, %11111100
	jmp DmgToCgbObjPal0

BillsPC_Jumptable:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

BillsPC_InitGFX:
	call DisableLCD
	ld hl, vTiles2 tile $00
	ld bc, $31 tiles
	xor a
	call ByteFill
	call LoadStandardFont
	call LoadFontsBattleExtra
	ld hl, PCMailGFX
	ld de, vTiles2 tile $5c
	ld bc, 4 tiles
	call CopyBytes
	ld hl, PCSelectLZ
	ld de, vTiles0 tile $00
	call Decompress
	ld a, 6
	call SkipMusic
	jmp EnableLCD

PCSelectLZ: INCBIN "gfx/pc/pc.2bpp.lz"
PCMailGFX:  INCBIN "gfx/pc/pc_mail.2bpp"

if DEF(_FR_FR)
PCString_ChooseaPKMN: db "Choisir un <PK><MN>.@"
PCString_WhatsUp: db "Que faire?@"
PCString_ReleasePKMN: db "Relâcher <PK><MN>?@"
PCString_MoveToWhere: db "Déplacer où?@"
PCString_ItsYourLastPKMN: db "Dernier #MON!@"
PCString_TheresNoRoom: db "Pas de place!@"
PCString_NoMoreUsablePKMN: db "Plus de <PK><MN> apte!@"
PCString_RemoveMail: db "Effacer LETTRE.@"
PCString_ReleasedPKMN: db "<PK><MN> relâché.@"
PCString_Bye: db "Adieu@"
PCString_Stored: db " gardé!@"
PCString_Got: db " obtenu!@"
PCString_BoxFull: db "BOITE pleine.@"
PCString_PartyFull: db "EQUIPE pleine!@"
PCString_NoReleasingEGGS: db "Impos. jeter OEUFS@"
PCString_SilphCoProperty: db "Prêté par SYLPHE!@"
PCString_PikachuRefuses: db "PIKACHU refuse!@"
else
PCString_ChooseaPKMN: db "Choose a <PK><MN>.@"
PCString_WhatsUp: db "What's up?@"
PCString_ReleasePKMN: db "Release <PK><MN>?@"
PCString_MoveToWhere: db "Move to where?@"
PCString_ItsYourLastPKMN: db "It's your last <PK><MN>!@"
PCString_TheresNoRoom: db "There's no room!@"
PCString_NoMoreUsablePKMN: db "No more usable <PK><MN>!@"
PCString_RemoveMail: db "Remove MAIL.@"
PCString_ReleasedPKMN: db "Released <PK><MN>.@"
PCString_Bye: db "Bye,@"
PCString_Stored: db "Stored @"
PCString_Got: db "Got @"
PCString_BoxFull: db "The BOX is full.@"
PCString_PartyFull: db "The party's full!@"
PCString_NoReleasingEGGS: db "No releasing EGGS!@"
PCString_SilphCoProperty: db "SILPH's property!@"
PCString_PikachuRefuses: db "PIKACHU refuses!@"
endc

_ChangeBox:
	call LoadStandardMenuHeader
	call BillsPC_ClearTilemap
.loop
	xor a
	ldh [hBGMapMode], a
	call BillsPC_PrintBoxName
	call BillsPC_PlaceChooseABoxString

	; We display either 13 boxes (Johto) or 14 (Kanto).
	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld de, ENGINE_FLYPOINT_VERMILION - ENGINE_FLYPOINT_PLAYERS_HOUSE
	call FlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	ld hl, _ChangeBox_MenuHeader_13
	jr z, .display_scroll_list	; false, the player hasn't reached Vermilion yet.
	ld hl, _ChangeBox_MenuHeader_14
	
.display_scroll_list
	call CopyMenuHeader
	xor a
	ld [wMenuScrollPosition], a
	hlcoord 0, 4
	lb bc, 8, 9
	call Textbox
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .done
	call BillsPC_PlaceWhatsUpString
	call BillsPC_ChangeBoxSubmenu
	jr .loop
.done
	jmp CloseWindow

BillsPC_ClearTilemap:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	jmp ByteFill

_ChangeBox_MenuHeader_13:
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 5, 9, 12
	dw .MenuData
	db 1 ; default option

.MenuData:
	db SCROLLINGMENU_CALL_FUNCTION3_NO_SWITCH | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dba .Boxes
	dba .PrintBoxNames
	dba NULL
	dba BillsPC_PrintBoxCountAndCapacity

.Boxes:
	db NUM_BOXES - 1
x = 1
rept NUM_BOXES - 1
	db x
x = x + 1
endr
	db -1

.PrintBoxNames:
	push de
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	pop hl
	jmp PlaceString

_ChangeBox_MenuHeader_14:
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 5, 9, 12
	dw .MenuData
	db 1 ; default option

.MenuData:
	db SCROLLINGMENU_CALL_FUNCTION3_NO_SWITCH | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dba .Boxes
	dba .PrintBoxNames
	dba NULL
	dba BillsPC_PrintBoxCountAndCapacity

.Boxes:
	db NUM_BOXES
x = 1
rept NUM_BOXES
	db x
x = x + 1
endr
	db -1

.PrintBoxNames:
	push de
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	pop hl
	jmp PlaceString

GetBoxName:
	ld bc, BOX_NAME_LENGTH
	ld hl, wBoxNames
	call AddNTimes
	ld d, h
	ld e, l
	ret

BillsPC_PrintBoxCountAndCapacity:
	hlcoord 11, 7
	lb bc, 5, 7
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z
	hlcoord 12, 9
	ld de, .Pokemon
	call PlaceString
	call GetBoxCount
	ld [wTextDecimalByte], a
	hlcoord 13, 11
	ld de, wTextDecimalByte
	lb bc, 1, 2
	call PrintNum
	ld de, .OutOf20
	jmp PlaceString

.Pokemon:
	db "#MON@"

.OutOf20:
	db "/{d:MONS_PER_BOX}@" ; "/20@"

GetBoxCount:
	ld a, [wCurBox]
	ld c, a
	ld a, [wMenuSelection]
	dec a
	cp c
	jr z, .activebox
	ld c, a
	ld b, 0
	ld hl, .BoxBankAddresses
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ld c, a
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .newfile
	ld a, c
	ret

.newfile
	xor a
	ret

.activebox
	ld a, BANK(sBoxCount)
	ld b, a
	call OpenSRAM
	ld hl, sBoxCount
	ld a, [hl]
	jmp CloseSRAM

.BoxBankAddresses:
	table_width 3, GetBoxCount.BoxBankAddresses
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14
	assert_table_length NUM_BOXES

BillsPC_PrintBoxName:
	hlcoord 0, 0
	lb bc, 2, 18
	call Textbox
	hlcoord 1, 2
	ld de, .Current
	call PlaceString
	ld a, [wCurBox]
	and $f
	call GetBoxName
	hlcoord 11, 2
	jmp PlaceString

.Current:
if DEF(_FR_FR)
	db "EN COURS@"
else
	db "CURRENT@"
endc

BillsPC_ChangeBoxSubmenu:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	jr z, .Switch
	cp $2
	jr z, .Name
	cp $3
	jr z, .Print
	and a
	ret

.Print:
	call GetBoxCount
	and a
	jr z, .EmptyBox
	ld e, l
	ld d, h
	ld a, [wMenuSelection]
	dec a
	ld c, a
	farcall PrintPCBox
	call BillsPC_ClearTilemap
	and a
	ret

.EmptyBox:
	call BillsPC_PlaceEmptyBoxString_SFX
	and a
	ret

.Switch:
	ld a, [wMenuSelection]
	dec a
	ld e, a
	ld a, [wCurBox]
	cp e
	ret z
	farcall ChangeBoxSaveGame
	ret

.Name:
	ld b, NAME_BOX
	ld de, wBoxNameBuffer
	farcall NamingScreen
	call ClearTilemap
	call LoadStandardFont
	call LoadFontsBattleExtra
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	ld e, l
	ld d, h
	ld hl, wBoxNameBuffer
	ld c, BOX_NAME_LENGTH - 1
	call InitString
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	ld de, wBoxNameBuffer
	jmp CopyName2

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 11, 4, SCREEN_WIDTH - 1, 13
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "CHANG.@"
	db "NOM@"
	db "IMPRIM@"
	db "RETOUR@"
else
	db "SWITCH@"
	db "NAME@"
	db "PRINT@"
	db "QUIT@"
endc

BillsPC_PlaceChooseABoxString:
	ld de, .ChooseABox
	jr BillsPC_PlaceChangeBoxString

.ChooseABox:
if DEF(_FR_FR)
	db "Choisir une boîte.@"
else
	db "Choose a BOX.@"
endc

BillsPC_PlaceWhatsUpString:
	ld de, .WhatsUp
	jr BillsPC_PlaceChangeBoxString

.WhatsUp:
if DEF(_FR_FR)
	db "Que faire?@"
else
	db "What's up?@"
endc

BillsPC_PlaceEmptyBoxString_SFX:
	ld de, .NoMonString
	call BillsPC_PlaceChangeBoxString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	ld c, 50
	jmp DelayFrames

.NoMonString:
if DEF(_FR_FR)
	db "Pas de #MON!@"
else
	db "There's no #MON.@"
endc

BillsPC_PlaceChangeBoxString:
	push de
	hlcoord 0, 14
	lb bc, 2, 18
	call Textbox
	pop de
	hlcoord 1, 16
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret
