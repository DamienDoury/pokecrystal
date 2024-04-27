	; PokemonCenterPC.WhichPC indexes
	const_def
	const PCPC_BEFORE_POKEDEX ; 0
	const PCPC_BEFORE_HOF     ; 1
	const PCPC_POSTGAME       ; 2

	; PokemonCenterPC.JumpTable indexes
	const_def
	const PCPCITEM_PLAYERS_PC   ; 0
	const PCPCITEM_BILLS_PC     ; 1
	const PCPCITEM_OAKS_PC      ; 2
	const PCPCITEM_HALL_OF_FAME ; 3
	const PCPCITEM_TURN_OFF     ; 4

PokemonCenterPC:
	call PC_CheckPartyForPokemon
	ret c

	ld b, CHECK_FLAG
	ld de, EVENT_GOT_HAND_SANITIZER
	call EventFlagAction
	ld a, c
	and a
	jr z, .clean_hands


	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .male_text
	ld hl, PokecenterPCSanitizerFemaleText
	jr .display_sanitizer_text

.male_text
	ld hl, PokecenterPCSanitizerText
	jr .display_sanitizer_text

.display_sanitizer_text
	call PC_DisplayText
	call PC_PlaySanitizerSound
	ld c, 75
	call DelayFrames

.clean_hands
	call PC_PlayBootSound
	ld hl, PokecenterPCTurnOnText
	call PC_DisplayText
	ld hl, PokecenterPCWhoseText
	call PC_DisplayTextWaitMenu
	ld hl, .TopMenu
	call LoadMenuHeader
.loop
	xor a
	ldh [hBGMapMode], a
	call .ChooseWhichPCListToUse
	ld [wWhichIndexSet], a
	call DoNthMenu
	jr c, .shutdown
	ld a, [wMenuSelection]
	ld hl, .JumpTable
	call MenuJumptable
	jr nc, .loop

.shutdown
	call PC_PlayShutdownSound
	call ExitMenu
	call CloseWindow
	ret

.TopMenu:
	db MENU_BACKUP_TILES | MENU_NO_CLICK_SFX ; flags
	menu_coords 0, 0, 15, 12
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 0 ; items
	dw .WhichPC
	dw PlaceNthMenuStrings
	dw .JumpTable

.JumpTable:
; entries correspond to PCPCITEM_* constants
	dw PlayersPC,    .String_PlayersPC
	dw BillsPC,      .String_BillsPC
	dw OaksPC,       .String_OaksPC
	dw HallOfFamePC, .String_HallOfFame
	dw TurnOffPC,    .String_TurnOff

.String_PlayersPC:  db "<PLAYER>'s PC@"
.String_BillsPC:    db "BILL's PC@"
.String_OaksPC:     db "PROF.OAK's PC@"
.String_HallOfFame: db "HALL OF FAME@"
.String_TurnOff:    db "TURN OFF@"

.WhichPC:
; entries correspond to PCPC_* constants

	; PCPC_BEFORE_POKEDEX
	db 3
	db PCPCITEM_BILLS_PC
	db PCPCITEM_PLAYERS_PC
	db PCPCITEM_TURN_OFF
	db -1 ; end

	; PCPC_BEFORE_HOF
	db 4
	db PCPCITEM_BILLS_PC
	db PCPCITEM_PLAYERS_PC
	db PCPCITEM_OAKS_PC
	db PCPCITEM_TURN_OFF
	db -1 ; end

	; PCPC_POSTGAME
	db 5
	db PCPCITEM_BILLS_PC
	db PCPCITEM_PLAYERS_PC
	db PCPCITEM_OAKS_PC
	db PCPCITEM_HALL_OF_FAME
	db PCPCITEM_TURN_OFF
	db -1 ; end

.ChooseWhichPCListToUse:
	call CheckReceivedDex
	jr nz, .got_dex
	ld a, PCPC_BEFORE_POKEDEX
	ret

.got_dex
	ld a, [wHallOfFameCount]
	and a
	ld a, PCPC_BEFORE_HOF
	ret z
	ld a, PCPC_POSTGAME
	ret

PC_CheckPartyForPokemon:
	ld a, [wPartyCount]
	and a
	ret nz
	ld de, SFX_CHOOSE_PC_OPTION
	call PlaySFX
	ld hl, .PokecenterPCCantUseText
	call PC_DisplayText
	scf
	ret

.PokecenterPCCantUseText:
	text_far _PokecenterPCCantUseText
	text_end


	; PlayersPCMenuData.WhichPC indexes
	const_def
	const PLAYERSPC_NORMAL ; 0
	const PLAYERSPC_HOUSE  ; 1

	; PlayersPCMenuData.PlayersPCMenuPointers indexes
	const_def
	;const PLAYERSPCITEM_WITHDRAW_ITEM ; 0
	;const PLAYERSPCITEM_DEPOSIT_ITEM  ; 1
	;const PLAYERSPCITEM_TOSS_ITEM     ; 2
	const PLAYERSPCITEM_MAIL_BOX      ; 3
	const PLAYERSPCITEM_DECORATION    ; 4
	const PLAYERSPCITEM_TURN_OFF      ; 5
	const PLAYERSPCITEM_LOG_OFF       ; 6

BillsPC:
	call PC_PlayChoosePCSound
	ld hl, PokecenterBillsPCText
	call PC_DisplayText
	farcall _BillsPC
	and a
	ret

PlayersPC:
	call PC_PlayChoosePCSound
	ld hl, PokecenterPlayersPCText
	call PC_DisplayText
	ld b, PLAYERSPC_NORMAL
	call _PlayersPC
	and a
	ret

OaksPC:
	call PC_PlayChoosePCSound
	ld hl, PokecenterOaksPCText
	call PC_DisplayText
	farcall ProfOaksPC
	and a
	ret

HallOfFamePC:
	call PC_PlayChoosePCSound
	call FadeToMenu
	farcall _HallOfFamePC
	call CloseSubmenu
	and a
	ret

TurnOffPC:
	ld hl, PokecenterPCOaksClosedText
	call PrintText
	scf
	ret

PC_PlaySanitizerSound:
	ld de, SFX_2_BOOPS
	jr PC_WaitPlaySFX
	call WaitSFX
	ret

PC_PlayBootSound:
	ld de, SFX_BOOT_PC
	jr PC_WaitPlaySFX

PC_PlayShutdownSound:
	ld de, SFX_SHUT_DOWN_PC
	call PC_WaitPlaySFX
	call WaitSFX
	ret

PC_PlayChoosePCSound:
	ld de, SFX_CHOOSE_PC_OPTION
	jr PC_WaitPlaySFX

PC_WaitPlaySFX:
	push de
	call WaitSFX
	pop de
	call PlaySFX
	ret

_PlayersHousePC:
	call PC_PlayBootSound
	ld hl, PlayersPCTurnOnText
	call PC_DisplayText
	ld b, PLAYERSPC_HOUSE
	call _PlayersPC
	and a
	jr nz, .changed_deco_tiles
	call OverworldTextModeSwitch
	call ApplyTilemap
	call UpdateSprites
	call PC_PlayShutdownSound
	ld c, FALSE
	ret

.changed_deco_tiles
	call ClearBGPalettes
	ld c, TRUE
	ret

PlayersPCTurnOnText:
	text_far _PlayersPCTurnOnText
	text_end

_PlayersPC:
	ld a, b
	ld [wWhichIndexSet], a
	ld hl, PlayersPCAskWhatDoText
	call PC_DisplayTextWaitMenu
	call .PlayersPC
	call ExitMenu
	ret

.PlayersPC:
	ld hl, PlayersPCMenuData
	call LoadMenuHeader
.loop
	call UpdateTimePals
	call DoNthMenu
	jr c, .turn_off
	call MenuJumptable
	jr nc, .loop
	jr .done

.turn_off
	xor a

.done
	call ExitMenu
	ret

PlayersPCMenuData:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, 12
	dw .PlayersPCMenuData
	db 1 ; default selected option

.PlayersPCMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 0 ; # items?
	dw .WhichPC
	dw PlaceNthMenuStrings
	dw .PlayersPCMenuPointers

.PlayersPCMenuPointers:
; entries correspond to PLAYERSPCITEM_* constants
	;dw PlayerWithdrawItemMenu, .WithdrawItem
	;dw PlayerDepositItemMenu,  .DepositItem
	;dw PlayerTossItemMenu,     .TossItem
	dw PlayerMailBoxMenu,      .MailBox
	dw PlayerDecorationMenu,   .Decoration
	dw PlayerLogOffMenu,       .LogOff
	dw PlayerLogOffMenu,       .TurnOff

;.WithdrawItem: db "WITHDRAW ITEM@"
;.DepositItem:  db "DEPOSIT ITEM@"
;.TossItem:     db "TOSS ITEM@"
.MailBox:      db "MAIL BOX@"
.Decoration:   db "DECORATION@"
.TurnOff:      db "TURN OFF@"
.LogOff:       db "LOG OFF@"

.WhichPC:
; entries correspond to PLAYERSPC_* constants

	; PLAYERSPC_NORMAL
	db 2
	;db PLAYERSPCITEM_WITHDRAW_ITEM
	;db PLAYERSPCITEM_DEPOSIT_ITEM
	;db PLAYERSPCITEM_TOSS_ITEM
	db PLAYERSPCITEM_MAIL_BOX
	db PLAYERSPCITEM_TURN_OFF
	db -1 ; end

	; PLAYERSPC_HOUSE
	db 3
	;db PLAYERSPCITEM_WITHDRAW_ITEM
	;db PLAYERSPCITEM_DEPOSIT_ITEM
	;db PLAYERSPCITEM_TOSS_ITEM
	db PLAYERSPCITEM_MAIL_BOX
	db PLAYERSPCITEM_DECORATION
	db PLAYERSPCITEM_LOG_OFF
	db -1 ; end

PC_DisplayTextWaitMenu:
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	call MenuTextbox
	pop af
	ld [wOptions], a
	ret

PlayersPCAskWhatDoText:
	text_far _PlayersPCAskWhatDoText
	text_end

PlayerDecorationMenu:
	farcall _PlayerDecorationMenu
	ld a, c
	and a
	ret z
	scf
	ret

PlayerLogOffMenu:
	xor a
	scf
	ret

PlayerMailBoxMenu:
	farcall _PlayerMailBoxMenu
	xor a
	ret

PC_DisplayText:
	call MenuTextbox
	call ExitMenu
	ret

PokecenterPCSanitizerText:
	text_far _PlayersPCSanitizerText
	text_end

PokecenterPCSanitizerFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

PokecenterPCTurnOnText:
	text_far _PokecenterPCTurnOnText
	text_end

PokecenterPCWhoseText:
	text_far _PokecenterPCWhoseText
	text_end

PokecenterBillsPCText:
	text_far _PokecenterBillsPCText
	text_end

PokecenterPlayersPCText:
	text_far _PokecenterPlayersPCText
	text_end

PokecenterOaksPCText:
	text_far _PokecenterOaksPCText
	text_end

PokecenterPCOaksClosedText:
	text_far _PokecenterPCOaksClosedText
	text_end
