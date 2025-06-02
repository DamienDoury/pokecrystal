_BillsPC:
	call .CheckCanUsePC
	ret c
	call .LogIn
	call .UseBillsPC
	jmp .LogOut

.CheckCanUsePC:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, .PCGottaHavePokemonText
	call MenuTextboxBackup
	scf
	ret

.PCGottaHavePokemonText:
	text_far _PCGottaHavePokemonText
	text_end

.LogIn:
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuHeader
	call ClearPCItemScreen
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld hl, PCWhatText
	call PrintText
	pop af
	ld [wOptions], a
	jmp LoadFontsBattleExtra

.LogOut:
	call CloseSubmenu
	ret

.UseBillsPC:
	ld hl, .MenuHeader
	call LoadMenuHeader
	ld a, $1
.loop
	ld [wMenuCursorPosition], a
	call SetPalettes
	xor a
	ld [wWhichIndexSet], a
	ldh [hBGMapMode], a
	call DoNthMenu
	jr c, .cancel
	ld a, [wMenuCursorPosition]
	push af
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	rst JumpTable
	pop bc
	ld a, b
	jr nc, .loop
.cancel
	call CloseWindow
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 0 ; items
	dw .items
	dw PlaceMenuStrings
	dw .strings

.strings
if DEF(_FR_FR)
	db "RETIRER <PK><MN>@"
	db "STOCKER <PK><MN>@"
	db "CHANGER BOITE@"
	db "DEP.<PK><MN> SNS LETTRE@"
	db "SALUT!@"
else
	db "WITHDRAW <PK><MN>@"
	db "DEPOSIT <PK><MN>@"
	db "CHANGE BOX@"
	db "MOVE <PK><MN> W/O MAIL@"
	db "SEE YA!@"
endc

.Jumptable:
	dw BillsPC_WithdrawMenu
	dw BillsPC_DepositMenu
	dw BillsPC_ChangeBoxMenu
	dw BillsPC_MovePKMNMenu
	dw BillsPC_SeeYa

.items
	db 5 ; # items
	db 0 ; WITHDRAW
	db 1 ; DEPOSIT
	db 2 ; CHANGE BOX
	db 3 ; MOVE PKMN
	db 4 ; SEE YA!
	db -1

BillsPC_SeeYa:
	scf
	ret

PCWhatText:
	text_far _PCWhatText
	text_end

BillsPC_MovePKMNMenu:
	call IsPCPoweredUp
	jr nc, .no_power	; If the PC isn't powered up (Kanto's power plant is down), the player can't switch boxes.

	call LoadStandardMenuHeader
	farcall IsAnyMonHoldingMail
	jr nc, .no_mail
	ld hl, .PCMonHoldingMailText
	call PrintText
	jr .quit

.no_mail
	farcall StartMoveMonWOMail_SaveGame
	jr c, .quit
	farcall _MovePKMNWithoutMail
	call ReturnToMapFromSubmenu
	call ClearPCItemScreen

.quit
	call CloseWindow
.no_power
	and a
	ret

.PCMonHoldingMailText:
	text_far _PCMonHoldingMailText
	text_end

BillsPC_DepositMenu:
	call LoadStandardMenuHeader
	farcall _DepositPKMN
	call ReturnToMapFromSubmenu
	call ClearPCItemScreen
	call CloseWindow
	and a
	ret

CheckCurPartyMonFainted:
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH
	ld b, $0
.loop
	ld a, [wCurPartyMon]
	cp b
	jr z, .skip
	ld a, [hli]
	or [hl]
	jr nz, .notfainted
	dec hl

.skip
	inc b
	ld a, [wPartyCount]
	cp b
	jr z, .done
	add hl, de
	jr .loop

.done
	scf
	ret

.notfainted
	and a
	ret

BillsPC_WithdrawMenu:
	call LoadStandardMenuHeader
	farcall _WithdrawPKMN
	call ReturnToMapFromSubmenu
	call ClearPCItemScreen
	call CloseWindow
	and a
	ret

BillsPC_ChangeBoxMenu:
	call IsPCPoweredUp
	jr nc, .prevent_box_change	; If the PC isn't powered up (Kanto's power plant is down), the player can't switch boxes.
	farcall _ChangeBox
.prevent_box_change
	and a
	ret

; Destroys all registers: af, bc, de, hl.
; Input: none.
; Returns carry if the player is stuck in Kanto before the power plant is repaired.
IsStuckInKanto::
	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld de, ENGINE_FLYPOINT_VERMILION - ENGINE_FLYPOINT_PLAYERS_HOUSE
	call FlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr z, .is_free	; false, the player hasn't reached Vermilion yet.

	ld b, CHECK_FLAG
	ld de, EVENT_RESTORED_POWER_TO_KANTO
	call EventFlagAction ; Returns the result of the check in c.
	ld a, c
	and a

	jr nz, .is_free	; true, the player has saved the power plant.

	scf ; Return true.
	ret

.is_free
	xor a ; Return false.
	ret


IsPCPoweredUp:
	; Checks the "change box lock" when the power plant is shutdown.
	push hl
	call IsStuckInKanto
	jr nc, .allow_box_change

	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld de, ENGINE_FLYPOINT_VERMILION - ENGINE_FLYPOINT_PLAYERS_HOUSE
	call FlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr z, .allow_box_change	; false, the player hasn't reached Vermilion yet.

	ld b, CHECK_FLAG
	ld de, EVENT_RESTORED_POWER_TO_KANTO
	call EventFlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr nz, .allow_box_change	; true, the player has saved the power plant.

; Prevent box change.
	ld hl, .PC404Text
	call PrintText

	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld hl, PCWhatText
	call PrintText
	pop af
	ld [wOptions], a
	
	pop hl
	xor a	; returns false.
	ret

.allow_box_change
	pop hl
	scf 	; returns true.
	ret

.PC404Text:
	text_far _PC404Text
	text_end

ClearPCItemScreen:
	call DisableSpriteUpdates
	xor a
	ldh [hBGMapMode], a
	call ClearBGPalettes
	call ClearSprites
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	hlcoord 0, 0
	lb bc, 10, 18
	call Textbox
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	call WaitBGMap2
	jmp SetPalettes ; ; load regular palettes?

CopyBoxmonToTempMon:
	ld a, [wCurPartyMon]
	ld hl, sBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wTempMonSpecies
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, BANK(sBoxMon1Species)
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	ret

CopyHospitalboxmonToTempMon:
	ld a, [wCurPartyMon]
	ld hl, sHospitalBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wTempMonSpecies
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, BANK(sHospitalBoxMon1Species)
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	ret
