LoadBattleMenu:
	ld hl, BattleMenuHeader
	call LoadMenuHeader
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call InterpretBattleMenu
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	jmp ExitMenu

SafariBattleMenu: ; unreferenced
	ld hl, SafariBattleMenuHeader
	call LoadMenuHeader
	jr CommonBattleMenu

ContestBattleMenu:
	ld hl, ContestBattleMenuHeader
	call LoadMenuHeader
	; fallthrough

CommonBattleMenu:
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call _2DMenu
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	jmp ExitMenu

BattleMenuHeader:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 6, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
else
	menu_coords 8, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	dn 2, 2 ; rows, columns
	db 6 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
if DEF(_FR_FR)
	db "ATTAQ@"
	db "<PKMN>@"
	db "SAC@"
	db "FUITE@"
else
	db "FIGHT@"
	db "<PKMN>@"
	db "PACK@"
	db "RUN@"
endc

SafariBattleMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	dn 2, 2 ; rows, columns
	db 11 ; spacing
	dba .Text
	dba .PrintSafariBallsRemaining

.Text:
	db "サファりボール×　　@" ; "SAFARI BALL×  @"
	db "エサをなげる@" ; "THROW BAIT"
	db "いしをなげる@" ; "THROW ROCK"
	db "にげる@" ; "RUN"

.PrintSafariBallsRemaining:
	hlcoord 17, 13
	ld de, wSafariBallsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum

ContestBattleMenuHeader:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 4, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
else
	menu_coords 2, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	dn 2, 2 ; rows, columns
if DEF(_FR_FR)
	db 8 ; spacing
else
	db 12 ; spacing
endc
	dba .Text
	dba .PrintParkBallsRemaining

.Text:
if DEF(_FR_FR)
	db "ATTAQ@"
	db "<PKMN>@"
	db "BALL×  @"
	db "FUITE@"
else
	db "FIGHT@"
	db "<PKMN>@"
	db "PARKBALL×  @"
	db "RUN@"
endc

.PrintParkBallsRemaining:
if DEF(_FR_FR)
	hlcoord 11, 16
else
	hlcoord 13, 16
endc
	ld de, wParkBallsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum
