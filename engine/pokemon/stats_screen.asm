	const_def 1
	const PINK_PAGE  ; 1
	const GREEN_PAGE ; 2
	const BLUE_PAGE  ; 3
NUM_STAT_PAGES EQU const_value - 1

STAT_PAGE_MASK EQU %00000011

BattleStatsScreenInit:
	ld a, [wLinkMode]
	cp LINK_MOBILE
	jr nz, StatsScreenInit

	ld a, [wBattleMode]
	and a
	jr z, StatsScreenInit
	jr _MobileStatsScreenInit

StatsScreenInit:
	ld hl, StatsScreenMain
	jr StatsScreenInit_gotaddress

_MobileStatsScreenInit:
	ld hl, StatsScreenMobile
	jr StatsScreenInit_gotaddress

StatsScreenInit_gotaddress:
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a ; disable overworld tile animations
	ld a, [wBoxAlignment] ; whether sprite is to be mirrorred
	push af
	ld a, [wJumptableIndex]
	ld b, a
	ld a, [wStatsScreenFlags]
	ld c, a

	push bc
	push hl
	call ClearBGPalettes
	call ClearTilemap
	call UpdateSprites
	farcall StatsScreen_LoadFont
	pop hl
	call _hl_
	call ClearBGPalettes
	call ClearTilemap
	pop bc

	; restore old values
	ld a, b
	ld [wJumptableIndex], a
	ld a, c
	ld [wStatsScreenFlags], a
	pop af
	ld [wBoxAlignment], a
	pop af
	ldh [hMapAnims], a
	ret

StatsScreenMain:
	xor a
	ld [wJumptableIndex], a
; ???
	ld [wStatsScreenFlags], a
	ld a, [wStatsScreenFlags]
	and $ff ^ STAT_PAGE_MASK
	or PINK_PAGE ; first_page
	ld [wStatsScreenFlags], a
.loop
	ld a, [wJumptableIndex]
	and $ff ^ (1 << 7)
	ld hl, StatsScreenPointerTable
	rst JumpTable
	call StatsScreen_WaitAnim
	ld a, [wJumptableIndex]
	bit 7, a
	jr z, .loop
	ret

StatsScreenMobile:
	xor a
	ld [wJumptableIndex], a
; ???
	ld [wStatsScreenFlags], a
	ld a, [wStatsScreenFlags]
	and $ff ^ STAT_PAGE_MASK
	or PINK_PAGE ; first_page
	ld [wStatsScreenFlags], a
.loop
	farcall Mobile_SetOverworldDelay
	ld a, [wJumptableIndex]
	and $7f
	ld hl, StatsScreenPointerTable
	rst JumpTable
	call StatsScreen_WaitAnim
	farcall MobileComms_CheckInactivityTimer
	jr c, .exit
	ld a, [wJumptableIndex]
	bit 7, a
	jr z, .loop

.exit
	ret

StatsScreenPointerTable:
	dw MonStatsInit       ; regular pokémon
	dw EggStatsInit       ; egg
	dw StatsScreenWaitCry
	dw EggStatsJoypad
	dw StatsScreen_LoadPage
	dw StatsScreenWaitCry
	dw MonStatsJoypad
	dw StatsScreen_Exit

StatsScreen_WaitAnim:
	ld hl, wStatsScreenFlags
	bit 6, [hl]
	jr nz, .try_anim
	bit 5, [hl]
	jr nz, .finish
	call DelayFrame
	ret

.try_anim
	farcall SetUpPokeAnim
	jr nc, .finish
	ld hl, wStatsScreenFlags
	res 6, [hl]
.finish
	ld hl, wStatsScreenFlags
	res 5, [hl]
	farcall HDMATransferTilemapToWRAMBank3
	ret

StatsScreen_SetJumptableIndex:
	ld a, [wJumptableIndex]
	and $80
	or h
	ld [wJumptableIndex], a
	ret

StatsScreen_Exit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

MonStatsInit:
	ld hl, wStatsScreenFlags
	res 6, [hl]
	call ClearBGPalettes
	call ClearTilemap
	farcall HDMATransferTilemapToWRAMBank3
	call StatsScreen_CopyToTempMon
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	call StatsScreen_InitUpperHalf
	ld hl, wStatsScreenFlags
	set 4, [hl]
	ld h, 4
	call StatsScreen_SetJumptableIndex
	ret

.egg
	ld h, 1
	call StatsScreen_SetJumptableIndex
	ret

EggStatsInit:
	call EggStatsScreen
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

EggStatsJoypad:
	call StatsScreen_GetJoypad
	jr nc, .check
	ld h, 0
	call StatsScreen_SetJumptableIndex
	ret

.check
	bit A_BUTTON_F, a
	jr nz, .quit
if DEF(_DEBUG)
	cp START
	jr z, .hatch
endc
	and D_DOWN | D_UP | A_BUTTON | B_BUTTON
	jp StatsScreen_JoypadAction

.quit
	ld h, 7
	call StatsScreen_SetJumptableIndex
	ret

if DEF(_DEBUG)
.hatch
	ld a, [wMonType]
	or a
	jr nz, .skip
	push bc
	push de
	push hl
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Happiness
	call AddNTimes
	ld [hl], 1
	ld a, 1
	ld [wTempMonHappiness], a
	ld a, 127
	ld [wStepCount], a
	ld de, .HatchSoonString
	hlcoord 8, 17
	call PlaceString
	ld hl, wStatsScreenFlags
	set 5, [hl]
	pop hl
	pop de
	pop bc
.skip
	xor a
	jp StatsScreen_JoypadAction

.HatchSoonString:
	db "▶HATCH SOON!@"
endc

StatsScreen_LoadPage:
	xor a
	ld [wStatsSubmenuOpened], a ; Submenu must be closed when the page is first loaded.
	call StatsScreen_LoadGFX
	ld hl, wStatsScreenFlags
	res 4, [hl]
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

MonStatsJoypad:
	call StatsScreen_GetJoypad
	jr nc, .next
	ld h, 0
	call StatsScreen_SetJumptableIndex
	ret

.next
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON | SELECT
	jp StatsScreen_JoypadAction

StatsScreenWaitCry:
	call IsSFXPlaying
	ret nc
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

StatsScreen_CopyToTempMon:
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .not_tempmon
	ld a, [wBufferMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBufferMon
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	jr .done

.not_tempmon
	farcall CopyMonToTempMon
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .done
	ld a, [wMonType]
	cp BOXMON
	jr c, .done
	farcall CalcTempmonStats
.done
	and a
	ret

StatsScreen_GetJoypad:
	call GetJoypad
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .not_tempmon
	
	ld a, [wStatsSubmenuOpened]
	cp 0
	jr nz, .not_tempmon
	
	push hl
	push de
	push bc
	farcall StatsScreenDPad
	pop bc
	pop de
	pop hl
	ld a, [wMenuJoypad]
	and D_DOWN | D_UP
	jr nz, .set_carry
	ld a, [wMenuJoypad]
	jr .clear_carry

.not_tempmon
	ldh a, [hJoyPressed]
.clear_carry
	and a
	ret

.set_carry
	scf
	ret

StatsScreen_JoypadAction:
	push af
	ld a, [wStatsSubmenuOpened]
	cp 0
	jp nz, .submenu_navigation ; If we are in the submenu.

	ld a, [wStatsScreenFlags]
	maskbits NUM_STAT_PAGES
	ld c, a
	pop af
	bit B_BUTTON_F, a
	jp nz, .b_button
	bit D_LEFT_F, a
	jr nz, .d_left
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit D_UP_F, a
	jr nz, .d_up
	bit D_DOWN_F, a
	jr nz, .d_down
	jr .done

.b_button
	ld h, 7
	call StatsScreen_SetJumptableIndex
	ret

.d_down
	ld a, [wMonType]
	cp BOXMON
	jr nc, .done
	and a
	ld a, [wPartyCount]
	jr z, .next_mon
	ld a, [wOTPartyCount]
.next_mon
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, .done
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jp nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jp .load_mon

.d_up
	ld a, [wCurPartyMon]
	and a
	jr z, .done
	dec a
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jp nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jp .load_mon

.a_button
	ld a, c
	cp GREEN_PAGE ; item/ability/moves page
	jp z, .open_submenu
	ret

.d_right
	inc c
	ld a, BLUE_PAGE ; last page
	cp c
	jp nc, .set_page
	ld c, PINK_PAGE ; first page
	jp .set_page

.d_left
	dec c
	jp nz, .set_page
	ld c, BLUE_PAGE ; last page
	jp .set_page

.done
	ret

.submenu_navigation
	pop af
	bit B_BUTTON_F, a
	jp nz, .b_button_submenu
	bit D_LEFT_F, a
	jp nz, .d_left_submenu
	bit D_RIGHT_F, a
	jp nz, .d_right_submenu
	bit A_BUTTON_F, a
	jp nz, .a_button_submenu
	bit D_UP_F, a
	jr nz, .d_up_submenu
	bit D_DOWN_F, a
	jr nz, .d_down_submenu
	bit SELECT_F, a
	jp nz, .a_button_submenu
	ret

.d_down_submenu
	ld a, [wStatsSubmenuCursorIndex]
	inc a
	cp 6
	jr c, .down_cursor_index_found ; No overflow.

	; The cursor is at index 6 or above. We set it back to zero.
	ld a, [wStatsSubmenuOpened]
	cp 2
	ld a, 0
	jr nz, .down_cursor_index_found
	
	ld a, 2 ; When swapping, we loop back to the first move. Will cause infinite loop when only 1 move exists.
	
.down_cursor_index_found
	ld [wStatsSubmenuCursorIndex], a ; Saving the next index.
	call IsDetailSlotEmpty
	jr z, .d_down_submenu ; As long as the next slot is empty, the cursor keeps moving down.

	ld a, [wStatsSubmenuCursorIndex]
	ld b, a
	ld a, [wStatsSwapMovesSourceCursorIndex]
	cp b
	jr z, .d_down_submenu

	jr .next_cursor_index_determined

.d_up_submenu
	ld a, [wStatsSubmenuCursorIndex]
	dec a
	ld b, a

	ld a, [wStatsSubmenuOpened]
	cp 2
	ld a, b
	jr nz, .d_up_submenu_no_swap

	cp 1 ; Ability slot: we are out of the moves range! It's an underflow when swapping moves!
	jr z, .d_up_submenu_underflow

	; No underflow fallthrough.

.d_up_submenu_no_swap
	cp $ff
	jr nz, .up_cursor_index_found ; No underflow.

.d_up_submenu_underflow
	; Underflow: setting the cursor back to its max index.
	ld a, 5

.up_cursor_index_found
	ld [wStatsSubmenuCursorIndex], a ; Saving the next index.
	call IsDetailSlotEmpty
	jr z, .d_up_submenu

	ld a, [wStatsSubmenuCursorIndex]
	ld b, a
	ld a, [wStatsSwapMovesSourceCursorIndex]
	cp b
	jr z, .d_up_submenu ; As long as the next slot is empty, the cursor keeps moving up.

.next_cursor_index_determined
	ld a, [wStatsSubmenuCursorIndex] ; Retrieving the next index.
	ld b, 0
	add a
	ld c, a
	ld a, [wStatsSubmenuCursorCoords]
	ld l, a
	ld a, [wStatsSubmenuCursorCoords + 1]
	ld h, a
	ld [hl], " " ; Erasing the old arrow.

.displaying_arrow
	hlcoord 1, 1
	push bc
	lb bc, 6, 18
	call ClearBox ; Erasing the previous tooltip in the box.

	ld a, [wStatsSubmenuOpened]
	cp 2
	jr nz, .hollow_arrow_done

	ld a, [wStatsSwapMovesSourceCursorIndex]
	add a
	ld c, a
	ld b, 0

	ld hl, .submenuCursorCoordinates
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld [hl], "▷" ; Displaying the hollow arrow. Note: it will be erased once, when the player leaves the move swap menu.

.hollow_arrow_done
	pop bc
	ld hl, .submenuCursorCoordinates
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld [wStatsSubmenuCursorCoords], a ; Saving the new coords (so we can quickly erase the inserted char later).
	ld a, h
	ld [wStatsSubmenuCursorCoords + 1], a

	ld [hl], "▶" ; Displaying the new arrow.

	; We refresh the description in the textbox.
	ld a, [wStatsSubmenuCursorIndex]
	and a
	jp z, .tooltip_item
	
	cp 1
	jp z, .tooltip_ability

;.tooltip_moves
	call PrepareToPlaceMoveDataNew
	and a
	ret z

	jp PlaceMoveDataNew

.tooltip_item
	ld a, [wTempMonItem]
	and a
	ret z

	jp PlaceItemDetail

.tooltip_ability
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE) ; TODO: remove this condition once ability effect have been implemented.
	ret
else
	call StatsScreen_GetTempMonAbility
	and a
	ret z

	jp PlaceAbilityDescription
endc

.a_button_submenu ; Swapping moves.
	; TODO: interact with the item.
	ld a, [wStatsSubmenuCursorIndex]
	cp 2
	ret c ; TODO: interact with the item.

	ld a, [wStatsSubmenuOpened]
	cp 1
	jr z, .start_swapping_first_check

	; At this point, the user pressed A to select the destination for the swap.
	; We must check if it is a valid swap.
	ld a, [wStatsSwapMovesSourceCursorIndex]

	; Do the swap here.
	sub 2
	ld [wSwappingMove], a

	call SwapMoves
	
	xor a
	ld [wSwappingMove], a
	jr .b_button_submenu

.start_swapping_first_check
	ld a, [wBattleMode]
	and a
	jr z, .start_swapping_second_check

	; If we are in a battle, we can't swap the moves of the CurBattleMon. 
	; Because if may cause issue with disabled moves and transformed mons.
	; And I'm too lazy to use the content of ".not_swapping_disabled_move".
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr z, .prevent_swapping

.start_swapping_second_check
	ld a, [wBillsPC_LoadedBox]
	and a ; party.
	jr z, .start_swapping_third_check

	cp 15 ; current box.
	jr z, .start_swapping_third_check

	; When we are moving boxes, wBillsPC_LoadedBox doesn't display 15, but the actual number of the loaded box.
	dec a
	push hl
	ld hl, wCurBox
	cp [hl]
	pop hl
	jr z, .start_swapping_third_check

	jr .prevent_swapping

.start_swapping_third_check
	; Checking if the Pokémon has at least 2 moves.
	ld a, 2
	call IsDetailSlotEmpty
	jr z, .prevent_swapping

	ld a, 3
	call IsDetailSlotEmpty
	jr nz, .start_swapping_ok

.prevent_swapping
	call WaitSFX
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	ret

.start_swapping_ok
	ld a, 2
	ld [wStatsSubmenuOpened], a
	
	ld a, [wStatsSubmenuCursorIndex]
	ld [wStatsSwapMovesSourceCursorIndex], a

	cp 2
	ld a, 2
	jr nz, .default_target_move_select

	inc a

.default_target_move_select
	ld [wStatsSubmenuCursorIndex], a
	ld b, 0
	add a
	ld c, a
	jp .displaying_arrow
	ret

.d_right_submenu
	xor a
	set D_RIGHT_F, a
	jr .side_press

.d_left_submenu
	xor a
	set D_LEFT_F, a
.side_press
	push af
	call CloseSubMenu
	pop af
	call StatsScreen_JoypadAction
	ret

.b_button_submenu
	ld a, [wStatsSubmenuOpened]
	cp 2
	jp nz, CloseSubMenu

	; Go back to the first submenu.
	ld a, 1
	ld [wStatsSubmenuOpened], a

	call .EraseSubmenuHollowArrow

	ld a, -1
	ld [wStatsSwapMovesSourceCursorIndex], a

	ld a, [wStatsSubmenuCursorIndex]
	add a
	ld b, 0
	ld c, a
	jp .displaying_arrow

.open_submenu
	ld a, 1
	ld [wStatsSubmenuOpened], a

	ld a, -1
	ld [wStatsSwapMovesSourceCursorIndex], a

	xor a
	ldh [hBGMapMode], a
	
	ld hl, wStatsScreenFlags
	set 5, [hl] ; We update the state machine to prevent it from trying to animate the Pokémon.
	res 6, [hl]
	farcall PokeAnim_Finish ; We force stopping the animation.

	ld de, .HideDetailTooltip
	hlcoord  1, 12
	call PlaceString

	hlcoord 0, 0
	lb bc, 6, SCREEN_WIDTH - 2
	call Textbox
	call ApplyTilemap




	; Placing the cursor at the default position.
	ld a, 2 ; Next cursor index.
	ld [wStatsSubmenuCursorIndex], a
	ld bc, 4
	jp .displaying_arrow

.set_page
	ld a, [wStatsScreenFlags]
	and $ff ^ STAT_PAGE_MASK
	or c
	ld [wStatsScreenFlags], a
	ld h, 4
	call StatsScreen_SetJumptableIndex
	ret

.load_mon
	ld h, 0
	call StatsScreen_SetJumptableIndex
	ret

.submenuCursorCoordinates
	dw 8	* SCREEN_WIDTH + 6 + wTilemap ; Item
	dw 11	* SCREEN_WIDTH + 1 + wTilemap ; Ability
	dw 14	* SCREEN_WIDTH + 1 + wTilemap ; Move 1
	dw 15	* SCREEN_WIDTH + 1 + wTilemap ; Move 2
	dw 16	* SCREEN_WIDTH + 1 + wTilemap ; Move 3
	dw 17	* SCREEN_WIDTH + 1 + wTilemap ; Move 4

.HideDetailTooltip:
	db "                  @"

.EraseSubmenuHollowArrow:
	ld a, [wStatsSwapMovesSourceCursorIndex] ; Retrieving the next index.
	add a
	ld c, a
	ld b, 0
	ld hl, .submenuCursorCoordinates
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], " " ; Erasing the old arrow.
	ret

SwapMoves:
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .params_loaded

	ld hl, sBoxMon1Moves
	ld bc, BOXMON_STRUCT_LENGTH

	ld a, BANK(sBox)
	call OpenSRAM

.params_loaded
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call .swap_bytes
	pop hl
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	call .swap_bytes
	ld a, [wBattleMode]
	and a
	jr z, .swap_moves

	ld hl, wBattleMonMoves
	ld bc, wBattleMonStructEnd - wBattleMon
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call .swap_bytes
	pop hl
	ld bc, wBattleMonPP - wBattleMonMoves
	add hl, bc
	call .swap_bytes

.swap_moves
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	
	hlcoord 2, 14
	ld bc, SCREEN_WIDTH
	ld a, [wStatsSubmenuCursorIndex]
	sub 2
	call AddNTimes
	lb bc, 1, 18
	call ClearBox

	hlcoord 2, 14
	ld bc, SCREEN_WIDTH
	ld a, [wSwappingMove]
	call AddNTimes
	lb bc, 1, 18
	call ClearBox

	ld a, [wBillsPC_LoadedBox]
	cp 0
	jr z, .end_swapping

	call CloseSRAM
	farcall CopyBoxmonToTempMon
	jp LoadGreenPage.display_moves

.end_swapping
	ld a, PARTYMON
	ld [wMonType], a ; Forcing the mon type to PARTYMON, because the Deposit mode of the PC sets it to TEMPMON.
	predef CopyMonToTempMon
	jp LoadGreenPage.display_moves

.swap_bytes
	push hl
	ld a, [wStatsSubmenuCursorIndex]
	sub 2
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wSwappingMove]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

String_CantUseInBattle:
if DEF(_FR_FR)
	db "Inutile en combat.@"
else
	db "No use in battle.@"
endc

String_OneTimeUse:
if DEF(_FR_FR)
	db "Perdu après usage.@"
else	
	db "Lost after use.@"
endc

String_OncePerBattle:
if DEF(_FR_FR)
	db "1 usage / combat.@"
else
	db "Once per battle.@"
endc

String_PassiveEffect:
if DEF(_FR_FR)
	db "Effet passif.@"
else
	db "Passive effect.@"
endc

ClearTopTiles:
	hlcoord 0, 0
	lb bc, 8, 20
	;ld bc, SCREEN_WIDTH * 8
	call ClearBox
	ret

CloseSubMenu:
	xor a
	ld [wStatsSubmenuOpened], a

	call ClearTopTiles

	ld hl, wCurHPPal
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS

 	farcall _CGB_StatsScreenHPPals_Fast ; Sets the right attribute map (palettes) to the upper part.

	call StatsScreen_InitUpperHalf.Fast ; Sets the right tilemap (tiles) to the upper part.
	ld hl, wStatsScreenFlags
	set 4, [hl] ; Tells the state machine to start animation.
	ld h, 4
	call StatsScreen_SetJumptableIndex
	ret

StatsScreen_InitUpperHalf:
	call .PlaceHPBar
.Fast
	xor a
	ldh [hBGMapMode], a
	ld a, [wBaseDexNo]
	ld [wTextDecimalByte], a
	ld [wCurSpecies], a
	hlcoord 8, 0
	ld [hl], "№"
	inc hl
	ld [hl], "."
	inc hl
	hlcoord 10, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	ld de, wTextDecimalByte
	call PrintNum
	hlcoord 14, 0
	call PrintLevel
	ld hl, .NicknamePointers
	call GetNicknamenamePointer
	call CopyNickname
	hlcoord 8, 2
	call PlaceString
	hlcoord 18, 0
	call .PlaceGenderChar
	hlcoord 9, 4
	ld a, "/"
	ld [hli], a
	ld a, [wBaseDexNo]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	call PlaceString
	call StatsScreen_PlaceHorizontalDivider
	call StatsScreen_PlacePageSwitchArrows
	call StatsScreen_PlaceShinyIcon
	ret

.PlaceHPBar:
	ld hl, wTempMonHP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wTempMonMaxHP
	ld a, [hli]
	ld d, a
	ld e, [hl]
	farcall ComputeHPBarPixels
	ld hl, wCurHPPal
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call DelayFrame
	ret

.PlaceGenderChar:
	push hl
	farcall GetGender
	pop hl
	ret c
	ld a, "♂"
	jr nz, .got_gender
	ld a, "♀"
.got_gender
	ld [hl], a
	ret

.NicknamePointers:
	dw wPartyMonNicknames
	dw wOTPartyMonNicknames
	dw sBoxMonNicknames
	dw wBufferMonNickname

StatsScreen_PlaceHorizontalDivider:
	hlcoord 0, 7
	ld b, SCREEN_WIDTH
	ld a, $62 ; horizontal divider (empty HP/exp bar)
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

StatsScreen_PlacePageSwitchArrows:
	hlcoord 12, 6
	ld [hl], "◀"
	hlcoord 19, 6
	ld [hl], "▶"
	ret

StatsScreen_PlaceShinyIcon:
	ld bc, wTempMonDVs
	farcall CheckShininess
	ret nc
	hlcoord 19, 0
	ld [hl], "⁂"
	ret

StatsScreen_LoadGFX:
	ld a, [wBaseDexNo]
	ld [wTempSpecies], a
	ld [wCurSpecies], a
	xor a
	ldh [hBGMapMode], a
	call .ClearBox
	call .PageTilemap
	call .LoadPals
	ld hl, wStatsScreenFlags
	bit 4, [hl]
	jr nz, .place_frontpic
	call SetPalettes
	ret

.place_frontpic
	call StatsScreen_PlaceFrontpic
	ret

.ClearBox:
	ld a, [wStatsScreenFlags]
	maskbits NUM_STAT_PAGES
	ld c, a
	call StatsScreen_LoadPageIndicators
	hlcoord 0, 8
	lb bc, 10, 20
	call ClearBox
	ret

.LoadPals:
	ld a, [wStatsScreenFlags]
	maskbits NUM_STAT_PAGES
	ld c, a
	farcall LoadStatsScreenPals
	call DelayFrame
	ld hl, wStatsScreenFlags
	set 5, [hl]
	ret

.PageTilemap:
	ld a, [wStatsScreenFlags]
	maskbits NUM_STAT_PAGES
	dec a
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable:
; entries correspond to *_PAGE constants
	dw LoadPinkPage
	dw LoadGreenPage
	dw LoadBluePage

LoadPinkPage:
	hlcoord 0, 9
	ld b, $0
	predef DrawPlayerHP
	hlcoord 8, 9
	ld [hl], $41 ; right HP/exp bar end cap
	ld de, .Status
	hlcoord 0, 12
	call PlaceString

	ld de, .Type
	hlcoord 0, 15
	call PlaceString




	; We display the battle permanent status (Burnt, Sleeping, etc.).
	ld a, [wMonType]
	cp BOXMON
	jr z, .CheckShape
	hlcoord 1, 8
	push hl
	ld de, wTempMonStatus
	predef PlaceStatusString
	pop hl

	; We display the shape of the Pokémon.
.CheckShape
	ld a, [wTempMonPokerusStatus]
	ld b, a

	and POKERUS_DURATION_MASK 
	jr z, .ShapeOK ; If the remaining duration is zero, then the Pokémon is always "OK".

	ld a, b
	and POKERUS_TEST_MASK 
	jr z, .HasNotBeenTestedYet



.HasBeenTested
	; Status displayed will be either Covid, Incub. or Immune. Also, the Vaccinated icon can be displayed.
	ld a, b
	and POKERUS_STRAIN_MASK
	cp 0
	jr nz, .VaccineCaseTreated ; If the strain is not equal to the one of a vaccinated Pokemon, then it is not vaccinated.

	; At this point, we also know that the strain is strictly equal to the one of the vaccine. We conclude that this Pokémon is vaccinated.
	hlcoord 8, 12
	ld [hl], "<VC>"
	ld a, b
	
	and POKERUS_DURATION_MASK
	cp 2
	jr c, .VaccineCaseTreated

	hlcoord 9, 12
	ld [hl], "<VC>" ; We display a second syringe.

.VaccineCaseTreated
	ld a, b
	and POKERUS_DURATION_MASK 
	cp POKERUS_IMMUNITY_DURATION
	jr z, .immune 
	jr nc, .incubOrCovid ; If the duration is strictly greater than the immune duration, then the Pokémon is either incubating or has the covid. Otherwise it is "immune".

.immune
	; Immune text.
	ld de, .PkrsImmuneStr
	hlcoord 1, 13
	call PlaceString
	jr .done_status

.incubOrCovid
	ld a, b
	and POKERUS_DURATION_MASK
	cp POKERUS_SYMPTOMS_START
	jr z, .covid 
	jr nc, .incub

.covid
	ld de, .PkrsStr
	hlcoord 1, 13
	call PlaceString
	jr .done_status

.incub
	ld de, .IncubStr
	hlcoord 1, 13
	call PlaceString
	jr .done_status

.HasNotBeenTestedYet
	; Status displayed will be either Sick or Ok.
	ld a, b
	and POKERUS_DURATION_MASK 
	cp POKERUS_SYMPTOMS_START
	jr z, .sick ; First day of symptoms.
	jr nc, .ShapeOK ; If the remaining duration strictly greater than the first day of symptoms, then we are "ok".

	ld a, b
	and POKERUS_DURATION_MASK 
	cp POKERUS_IMMUNITY_DURATION
	jr c, .ShapeOK
	jr z, .ShapeOK ; less or equal.

.sick
	; Sick text.
	ld de, .PkrsSickStr
	hlcoord 1, 13
	call PlaceString
	jr .done_status







.ShapeOK:
	hlcoord 1, 13
	ld de, .OK_str
	call PlaceString
.done_status
	hlcoord 1, 16
	predef PrintMonTypes
	hlcoord 10, 8
	ld de, SCREEN_WIDTH
	ld b, 10
	ld a, $31 ; vertical divider
.vertical_divider
	ld [hl], a
	add hl, de
	dec b
	jr nz, .vertical_divider

; stats
	hlcoord 11, 8
	ld bc, 5
	predef PrintTempMonStats

; DV_HP = (DV_ATK & 1) << 3 | (DV_DEF & 1) << 2 | (DV_SPD & 1) << 1 | (DV_SPC & 1)
; atk,def,spd,spc
	ld a, [wTempMonDVs + 1]
	srl a
	and %1000
	ld h, a

	ld a, [wTempMonDVs + 1]
	sla a
	sla a
	and %100
	or h
	ld h, a

	ld a, [wTempMonDVs]
	swap a
	sla a
	and %10
	or h
	ld h, a

	ld a, [wTempMonDVs]
	and %1
	or h
	cp $f
	jr nz, .atkDV

	hlcoord 8, 10
	ld [hl], "!"

.atkDV
	ld a, [wTempMonDVs]
	and $f0
	cp $f0
	jr nz, .defDV

	hlcoord 19, 9
	ld [hl], "!"

.defDV
	ld a, [wTempMonDVs]
	and $f
	cp $f
	jr nz, .spdDV

	hlcoord 19, 11
	ld [hl], "!"

.spdDV
	ld a, [wTempMonDVs + 1]
	and $f0
	cp $f0
	jr nz, .spcDV

	hlcoord 19, 17
	ld [hl], "!"

.spcDV
	ld a, [wTempMonDVs + 1]
	and $f
	cp $f
	jr nz, .perfectStatExpDisplay

	hlcoord 19, 13
	ld [hl], "!"

	hlcoord 19, 15
	ld [hl], "!"

.perfectStatExpDisplay
	ld hl, wTempMonHPExp
	call .IsFullExp
	jr nz, .atkExp

	hlcoord 0, 10
	ld [hl], "<EMPTY_STAR>"

.atkExp
	ld hl, wTempMonAtkExp
	call .IsFullExp
	jr nz, .defExp

	hlcoord 15, 9
	ld [hl], "<EMPTY_STAR>"

.defExp
	ld hl, wTempMonDefExp
	call .IsFullExp
	jr nz, .spcExp

	hlcoord 15, 11
	ld [hl], "<EMPTY_STAR>"

.spcExp
	ld hl, wTempMonSpcExp
	call .IsFullExp
	jr nz, .spdExp

	hlcoord 15, 13
	ld [hl], "<EMPTY_STAR>"

	hlcoord 15, 15
	ld [hl], "<EMPTY_STAR>"

.spdExp
	ld hl, wTempMonSpdExp
	call .IsFullExp
	ret nz

	hlcoord 15, 17
	ld [hl], "<EMPTY_STAR>"
	ret

.IsFullExp
	ld a, [hli]
	and [hl]
	cp $ff
	ret

.Status:
if DEF(_FR_FR)
	db "SANTE/@"
else
	db "HEALTH/@"
endc

.Type
	db "TYPE/@"

.OK_str:
if DEF(_FR_FR)
	db "SAIN@"
else
	db "HEALTHY@"
endc

.IncubStr:
	db "INCUB.@"

.PkrsStr:
	db "COVID@"

.PkrsImmuneStr:
if DEF(_FR_FR)
	db "IMMUNI.@"
else
	db "IMMUNE@"
endc

.PkrsSickStr:
if DEF(_FR_FR)
	db "MALADE@"
else
	db "SICK@"
endc

LoadGreenPage:
	ld de, .Item
	hlcoord 0, 8
	call PlaceString

	call .GetItemName
	hlcoord 7, 8
	call PlaceString

	ld de, .Ability
	hlcoord 0, 10
	call PlaceString

if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE) ; TODO: remove this condition once ability effect have been implemented.
	ld de, .ThreeDashes
	hlcoord 2, 11
	call PlaceString
else
	; Get the ability name.
	call StatsScreen_GetTempMonAbility
	inc a ; GetName decreases A, so we need to compensate.
	ld [wCurSpecies], a
	; A contains the ID of the ability. Now we have to retrieve the name.
	; But we can't just add a fixed offset, as names don't have a fixed length.
	ld a, ABILITY_NAME
	ld [wNamedObjectType], a
	call GetName

	ld hl, wStringBuffer1 + 13
	ld [hl], "@"
	ld de, wStringBuffer1
	hlcoord 2, 11
	call PlaceString
endc

	ld a, [wJohtoBadges]
	cp 0
	jr nz, .skip_details_tooltip ; Once the player has acquired at least 1 badge, we stop displaying this tooltip.
	ld de, .DetailsPressA
	hlcoord 1, 12
	call PlaceString
.skip_details_tooltip

	ld de, .Move
	hlcoord 0, 13
	call PlaceString

.display_moves
	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	hlcoord 2, 14
	ld a, SCREEN_WIDTH * 1
	ld [wListMovesLineSpacing], a
	predef ListMoves
	hlcoord 12, 14
	ld a, SCREEN_WIDTH * 1
	ld [wListMovesLineSpacing], a
	predef ListMovePP
	ret

.GetItemName:
	ld de, .ThreeDashes
	ld a, [wTempMonItem]
	and a
	ret z

	ld [wNamedObjectIndex], a
	call GetItemName
	ret

.Item:
if DEF(_FR_FR)
	db "OBJET/@"
else
	db "ITEM/@"
endc

.Ability:
if DEF(_FR_FR)
	db "TALENT/@"
else
	db "ABILITY/@"
endc

.Move:
if DEF(_FR_FR)
	db "CAPACITES/@"
else
	db "MOVES/@"
endc

.ThreeDashes:
	db "---@"

.DetailsPressA:
if DEF(_FR_FR)
	db "[Détail: appuie A]@"
else
	db "[Details: press A]@"
endc

; Input: wCurSpecies contains the ID of the species.
; Output: the ability ID of this species in A and hFarByte.
; Clobbers BC, HL.
StatsScreen_GetTempMonAbility:
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE) ; TODO: remove this condition once ability effect have been implemented.
	xor a
	ret
else
	ld a, [wBattleMode]
	and a
	jr z, .overworld

; In battle, the player's pokémon ability may change (e.g. Trace).
; This only affects the one Pokémon in battle, as abilities reset after switching out.
; So the Pokémon in the back have their default ability.
; In this specific case, we need to return the in-battle ability.

	ld a, [wCurBattleMon]
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	jr nz, .overworld

	; Note: wEnemyMonAbility can never be displayed in the Stats screen.
	ld a, [wBattleMonAbility]
	ret

.overworld
	ld a, [wTempMonSpecies]
	ld [wCurSpecies], a
	; fallthrough
endc

; Input: species in wCurSpecies.
; Output: ability in A and hFarByte.
; Clobbers BC, HL.
GetSpeciesAbility::
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE) ; TODO: remove this condition once ability effect have been implemented.
	xor a
else
	ld a, [wCurSpecies]
	ld c, a
	ld b, 0
	ld hl, PokemonAbilities
	add hl, bc
	ld a, BANK(PokemonAbilities)
	call GetFarByte
endc
	ret



LoadBluePage:
	call .PlaceOTInfo
	hlcoord 9, 8
	ld de, SCREEN_WIDTH
	ld b, 10
	ld a, $31 ; vertical divider
.vertical_divider
	ld [hl], a
	add hl, de
	dec b
	jr nz, .vertical_divider

	; Exp points
	ld de, .ExpPointStr
	hlcoord 10, 9
	call PlaceString
	hlcoord 17, 14
	call .PrintNextLevel
	hlcoord 13, 10
	lb bc, 3, 7
	ld de, wTempMonExp
	call PrintNum
	call .CalcExpToNextLevel
	hlcoord 13, 13
	lb bc, 3, 7
	ld de, wExpToNextLevel
	call PrintNum
	ld de, .LevelUpStr
	hlcoord 10, 12
	call PlaceString
	ld de, .ToStr
	hlcoord 14, 14
	call PlaceString
	hlcoord 11, 16
	ld a, [wTempMonLevel]
	ld b, a
	ld de, wTempMonExp + 2
	predef FillInExpBar
	hlcoord 10, 16
	ld [hl], $40 ; left exp bar end cap
	hlcoord 19, 16
	ld [hl], $41 ; right exp bar end cap
	ret

.PrintNextLevel:
	ld a, [wTempMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .AtMaxLevel
	inc a
	ld [wTempMonLevel], a
.AtMaxLevel:
	call PrintLevel
	pop af
	ld [wTempMonLevel], a
	ret

.CalcExpToNextLevel:
	ld a, [wTempMonLevel]
	cp MAX_LEVEL
	jr z, .AlreadyAtMaxLevel
	inc a
	ld d, a
	farcall CalcExpAtLevel
	ld hl, wTempMonExp + 2
	ld hl, wTempMonExp + 2
	ldh a, [hQuotient + 3]
	sub [hl]
	dec hl
	ld [wExpToNextLevel + 2], a
	ldh a, [hQuotient + 2]
	sbc [hl]
	dec hl
	ld [wExpToNextLevel + 1], a
	ldh a, [hQuotient + 1]
	sbc [hl]
	ld [wExpToNextLevel], a
	ret

.AlreadyAtMaxLevel:
	ld hl, wExpToNextLevel
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.PlaceOTInfo:
	ld de, IDNoString
	hlcoord 0, 14
	call PlaceString
	ld de, OTString
	hlcoord 0, 10
	call PlaceString
	hlcoord 1, 15
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	ld de, wTempMonID
	call PrintNum
	ld hl, .OTNamePointers
	call GetNicknamenamePointer
	call CopyNickname
	farcall CorrectNickErrors
	hlcoord 1, 11
	call PlaceString
	ld a, [wTempMonCaughtGender]
	and a
	jr z, .done
	cp $7f
	jr z, .done
	and CAUGHT_GENDER_MASK
	ld a, "♂"
	jr z, .got_gender
	ld a, "♀"
.got_gender
	hlcoord 8, 11
	ld [hl], a
.done
	ret

.OTNamePointers:
	dw wPartyMonOTs
	dw wOTPartyMonOTs
	dw sBoxMonOTs
	dw wBufferMonOT

.ExpPointStr:
if DEF(_FR_FR)
	db "PTS EXP.@"
else
	db "EXP POINTS@"
endc

.LevelUpStr:
if DEF(_FR_FR)
	db "PROCH.NIV.@"
else
	db "LEVEL UP@"
endc

.ToStr:
if DEF(_FR_FR)
	db "▶@"
else
	db "TO@"
endc

IDNoString:
if DEF(_FR_FR)
	db "№.<ID>@"
else
	db "<ID>№.@"
endc

OTString:
if DEF(_FR_FR)
	db "DO/@"
else
	db "OT/@"
endc

StatsScreen_PlaceFrontpic:
	ld hl, wTempMonDVs
	predef GetUnownLetter
	call StatsScreen_GetAnimationParam
	jr c, .egg
	and a
	jr z, .no_cry
	jr .cry

.egg
	call .AnimateEgg
	call SetPalettes
	ret

.no_cry
	call .AnimateMon
	call SetPalettes
	ret

.cry
	call SetPalettes
	call .AnimateMon
	ld a, [wCurPartySpecies]
	call PlayMonCry2
	ret

.AnimateMon:
	ld hl, wStatsScreenFlags
	set 5, [hl]
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr z, .unown
	hlcoord 0, 0
	call PrepMonFrontpic
	ret

.unown
	xor a
	ld [wBoxAlignment], a
	hlcoord 0, 0
	call _PrepMonFrontpic
	ret

.AnimateEgg:
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr z, .unownegg
	ld a, TRUE
	ld [wBoxAlignment], a
	call .get_animation
	ret

.unownegg
	xor a
	ld [wBoxAlignment], a
	call .get_animation
	ret

.get_animation
	ld a, [wCurPartySpecies]
	call IsAPokemon
	ret c
	call StatsScreen_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef GetAnimatedFrontpic
	hlcoord 0, 0
	ld d, $0
	ld e, ANIM_MON_MENU
	predef LoadMonAnimation
	ld hl, wStatsScreenFlags
	set 6, [hl]
	ret

StatsScreen_GetAnimationParam:
	ld a, [wMonType]
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable:
	dw .PartyMon
	dw .OTPartyMon
	dw .BoxMon
	dw .Tempmon
	dw .Wildmon

.PartyMon:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld b, h
	ld c, l
	jr .CheckEggFaintedFrzSlp

.OTPartyMon:
	xor a
	ret

.BoxMon:
	ld hl, sBoxMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld b, h
	ld c, l
	ld a, BANK(sBoxMons)
	call OpenSRAM
	call .CheckEggFaintedFrzSlp
	push af
	call CloseSRAM
	pop af
	ret

.Tempmon:
	ld bc, wTempMonSpecies
	jr .CheckEggFaintedFrzSlp ; utterly pointless

.CheckEggFaintedFrzSlp:
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	call CheckFaintedFrzSlp
	jr c, .FaintedFrzSlp
.egg
	xor a
	scf
	ret

.Wildmon:
	ld a, $1
	and a
	ret

.FaintedFrzSlp:
	xor a
	ret

StatsScreen_LoadTextboxSpaceGFX:
	nop
	push hl
	push de
	push bc
	push af
	call DelayFrame
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	ld hl, vTiles2 tile " "
	call Get2bpp
	pop af
	ldh [rVBK], a
	pop af
	pop bc
	pop de
	pop hl
	ret

EggStatsScreen:
	xor a
	ldh [hBGMapMode], a
	ld hl, wCurHPPal
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call StatsScreen_PlaceHorizontalDivider
	ld de, EggString
	hlcoord 8, 1
	call PlaceString
	ld de, IDNoString
	hlcoord 8, 3
	call PlaceString
	ld de, OTString
	hlcoord 8, 5
	call PlaceString
	ld de, FiveQMarkString
	hlcoord 11, 3
	call PlaceString
	ld de, FiveQMarkString
	hlcoord 11, 5
	call PlaceString
if DEF(_DEBUG)
	ld de, .PushStartString
	hlcoord 8, 17
	call PlaceString
	jr .placed_push_start

.PushStartString:
	db "▶PUSH START.@"

.placed_push_start
endc
	ld a, [wTempMonHappiness] ; egg status
	ld de, EggSoonString
	cp $6
	jr c, .picked
	ld de, EggCloseString
	cp $b
	jr c, .picked
	ld de, EggMoreTimeString
	cp $29
	jr c, .picked
	ld de, EggALotMoreTimeString
.picked
	hlcoord 1, 9
	call PlaceString
	ld hl, wStatsScreenFlags
	set 5, [hl]
	call SetPalettes ; pals
	call DelayFrame
	hlcoord 0, 0
	call PrepMonFrontpic
	farcall HDMATransferTilemapToWRAMBank3
	call StatsScreen_AnimateEgg

	ld a, [wTempMonHappiness]
	cp 6
	ret nc
	ld de, SFX_2_BOOPS
	call PlaySFX
	ret

EggString:
if DEF(_FR_FR)
	db "OEUF@"
else
	db "EGG@"
endc

FiveQMarkString:
	db "?????@"

EggSoonString:
if DEF(_FR_FR)
	db   "Cela fait du bruit"
	next "à l'intérieur. Il"
	next "va bientôt éclore!@"
else
	db   "It's making sounds"
	next "inside. It's going"
	next "to hatch soon!@"
endc

EggCloseString:
if DEF(_FR_FR)
	db   "Il se déplace à"
	next "l'intérieur. Il"
	next "est sur le point"
	next "d'éclore!@"
else
	db   "It moves around"
	next "inside sometimes."
	next "It must be close"
	next "to hatching.@"
endc

EggMoreTimeString:
if DEF(_FR_FR)
	db   "Qu'y a-t-il à"
	next "l'intérieur?"
	next "Il faut attendre"
	next "encore un peu.@"
else
	db   "Wonder what's"
	next "inside? It needs"
	next "more time, though.@"
endc

EggALotMoreTimeString:
if DEF(_FR_FR)
	db   "Cet OEUF va mettre"
	next "du temps à éclore!@"
else
	db   "This EGG needs a"
	next "lot more time to"
	next "hatch.@"
endc

StatsScreen_AnimateEgg:
	call StatsScreen_GetAnimationParam
	ret nc
	ld a, [wTempMonHappiness]
	ld e, $7
	cp 6
	jr c, .animate
	ld e, $8
	cp 11
	jr c, .animate
	ret

.animate
	push de
	ld a, $1
	ld [wBoxAlignment], a
	call StatsScreen_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef GetAnimatedFrontpic
	pop de
	hlcoord 0, 0
	ld d, $0
	predef LoadMonAnimation
	ld hl, wStatsScreenFlags
	set 6, [hl]
	ret

StatsScreen_LoadPageIndicators:
	hlcoord 13, 5
	ld a, $36 ; first of 4 small square tiles
	call .load_square
	hlcoord 15, 5
	ld a, $36 ; " " " "
	call .load_square
	hlcoord 17, 5
	ld a, $36 ; " " " "
	call .load_square
	ld a, c
	cp GREEN_PAGE
	ld a, $3a ; first of 4 large square tiles
	hlcoord 13, 5 ; PINK_PAGE (< GREEN_PAGE)
	jr c, .load_square
	hlcoord 15, 5 ; GREEN_PAGE (= GREEN_PAGE)
	jr z, .load_square
	hlcoord 17, 5 ; BLUE_PAGE (> GREEN_PAGE)
.load_square
	push bc
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	pop bc
	ret

CopyNickname:
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	jr .okay ; utterly pointless
.okay
	ld a, [wMonType]
	cp BOXMON
	jr nz, .partymon
	ld a, BANK(sBoxMonNicknames)
	call OpenSRAM
	push de
	call CopyBytes
	pop de
	call CloseSRAM
	ret

.partymon
	push de
	call CopyBytes
	pop de
	ret

GetNicknamenamePointer:
	ld a, [wMonType]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonType]
	cp TEMPMON
	ret z
	ld a, [wCurPartyMon]
	jp SkipNames

CheckFaintedFrzSlp:
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .fainted_frz_slp
	ld hl, MON_STATUS
	add hl, bc
	ld a, [hl]
	and 1 << FRZ | SLP
	jr nz, .fainted_frz_slp
	and a
	ret

.fainted_frz_slp
	scf
	ret

; Input: A = the index of the cursor position, wTempMon contains the data (moves) of the selected Pokémon, wCurPartyMon set to the desired mon.
; Output: the ID of the move in [wCurSpecies] and A.
PrepareToPlaceMoveDataNew:
	ld hl, wTempMonMoves
	sub 2
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	ret

PlaceMoveDataNew:
	xor a
	ldh [hBGMapMode], a

	hlcoord 1, 1
	predef PrintMoveFullDescription

	ld a, $1
	ldh [hBGMapMode], a
	ret

PlaceAbilityDescription:
	add a
	ld e, a
	ld d, 0
	ld hl, AbilityDescriptions
	add hl, de

	ld a, BANK(AbilityDescriptions)
	call GetFarWord ; retrieve a word from a:hl, and return it in hl.

	ld e, l
	ld d, h

	ld a, BANK(AbilityDescriptions)
	hlcoord 1, 2
	jp PlaceFarString

PlaceItemDetail:
	ld [wCurSpecies], a
	
	xor a
	ldh [hBGMapMode], a

	decoord 1, 2
	farcall PrintItemDescription

	ld a, [wCurSpecies]
	ld b, a
	farcall GetItemHeldEffect
	ld a, HELD_PASSIVE
	cp b
	jr z, .passive_effect

	ld a, HELD_CONSUMABLE
	cp b
	jr z, .once_per_battle

	ld a, HELD_NONE
	cp b
	jr z, .cant_use_in_battle

	; If the item is not HELD_NONE, we check if it has ITEMMENU_PARTY to determine if it is a consumable object (one time use).
	call GetItemHelpAttr
	and $0f
	cp ITEMMENU_PARTY
	jr z, .consumable

.passive_effect
	ld de, String_PassiveEffect
	jr .display_usability

.consumable
	ld de, String_OneTimeUse
	jr .display_usability

.once_per_battle
	ld de, String_OncePerBattle
	jr .display_usability

.cant_use_in_battle
	ld de, String_CantUseInBattle

.display_usability
	hlcoord 1, 6
	call PlaceString

.item_end
	ld a, $1
	ldh [hBGMapMode], a
	ret 

; Sets the Z flag if the arrow is pointing towards an empty Detail slot.
IsDetailSlotEmpty:
	and a
	jp z, .tooltip_item
	
	cp 1
	jp z, .tooltip_ability

;.tooltip_moves
	call PrepareToPlaceMoveDataNew
	and a
	ret z

	jr .slot_is_not_empty

.tooltip_item
	; We check if the current pkmn holds an item.
	ld a, [wTempMonItem]
	and a
	ret z

	jr .slot_is_not_empty

.tooltip_ability
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE) ; TODO: remove this condition once ability effect have been implemented.
	xor a
	ret
else 
	; At the moment, there are no abilities, so it always returns false.
	call StatsScreen_GetTempMonAbility
	and a
	ret z

	; fallthrough.
endc

.slot_is_not_empty
	xor a
	inc a ; Unsets Z flag. There is probably a better way.
	ret

GetItemHelpAttr:
	ld hl, ItemAttributes + ITEMATTR_HELP
	ld a, [wCurSpecies]
	dec a
	ld c, a
	ld b, 0
	ld a, ITEMATTR_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarByte
	ret