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
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON
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
	push hl
	push de
	push bc
	farcall StatsScreenDPad
	pop bc
	pop de
	pop hl
	ld a, [wMenuJoypad]
	and D_DOWN | D_UP
	jr nz, .check_submenu
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

.check_submenu
	ld a, [wStatsSubmenuOpened]
	cp 0
	jp z, .set_carry ; If we are NOT in the submenu, then we leave.
	ld a, [wMenuJoypad]

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
	jr nz, .b_button_submenu
	bit D_LEFT_F, a
	jr nz, .d_left_submenu
	bit D_RIGHT_F, a
	jr nz, .d_right_submenu
	bit A_BUTTON_F, a
	jr nz, .a_button_submenu
	bit D_UP_F, a
	jr nz, .d_up_submenu
	bit D_DOWN_F, a
	jr nz, .d_down_submenu
	ret

.d_down_submenu
	ld a, [wStatsSubmenuCursorIndex]
	inc a
	cp 6
	jr c, .next_cursor_index_determined ; No overflow.
	; The cursor is at index 6 or above. We set it back to zero.
	xor a
	jr .next_cursor_index_determined

.d_up_submenu
	ld a, [wStatsSubmenuCursorIndex]
	dec a
	cp $ff
	jr nz, .next_cursor_index_determined ; No underflow.
	; Underflow: setting the cursor back to its max index.
	ld a, 5

.next_cursor_index_determined
	ld [wStatsSubmenuCursorIndex], a ; Saving the next index.
	ld b, 0
	add a
	ld c, a
	ld a, [wStatsSubmenuCursorCoords]
	ld l, a
	ld a, [wStatsSubmenuCursorCoords + 1]
	ld h, a
	ld [hl], " " ; Erasing the old arrow.

.displaying_arrow
	ld hl, .submenuCursorCoordinates
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld [wStatsSubmenuCursorCoords], a ; Saving the new coords (so we can quickly erase the inserted char later).
	ld a, h
	ld [wStatsSubmenuCursorCoords + 1], a

	ld [hl], "▶" ; Displaying the new arrow.

	; TODO: Here we need to refresh the description in the textbox.

	ret

.a_button_submenu ; Will be used to re-order moves.
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
	call CloseSubMenu
	ret

.open_submenu
	ld a, 1
	ld [wStatsSubmenuOpened], a

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
	add a
	ld c, a
	ld b, 0
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
	cp POKERUS_VACCINE_STRAIN
	jr nz, .VaccineCaseTreated ; If the strain is not equal to the one of a vaccinated Pokemon, then it is not vaccinated.

	; At this point, we also know that the strain is strictly equal to the one of the vaccine. We conclude that this Pokémon is vaccinated.
	hlcoord 8, 12
	ld [hl], "<VC>"
	ld a, b

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
	ld bc, 6
	predef PrintTempMonStats
	ret

.Status:
	db "HEALTH/@"

.Type
	db "TYPE/@"

.OK_str:
	db "HEALTHY@"

.IncubStr:
	db "INCUB.@"

.PkrsStr:
	db "COVID@"

.PkrsImmuneStr:
	db "IMMUNE@"

.PkrsSickStr:
	db "SICK@"

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

	ld de, .ThreeDashes
	hlcoord 2, 11
	call PlaceString

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
	ld b, a
	farcall TimeCapsule_ReplaceTeruSama
	ld a, b
	ld [wNamedObjectIndex], a
	call GetItemName
	ret

.Item:
	db "ITEM/@"

.Ability:
	db "ABILITY/@"

.Move:
	db "MOVES/@"

.ThreeDashes:
	db "---@"

.DetailsPressA:
	db "[Details: press A]@"


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
	db "EXP POINTS@"

.LevelUpStr:
	db "LEVEL UP@"

.ToStr:
	db "TO@"

IDNoString:
	db "<ID>№.@"

OTString:
	db "OT/@"

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

StatsScreenSpaceGFX: ; unreferenced
INCBIN "gfx/font/space.2bpp"

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
	db "EGG@"

FiveQMarkString:
	db "?????@"

EggSoonString:
	db   "It's making sounds"
	next "inside. It's going"
	next "to hatch soon!@"

EggCloseString:
	db   "It moves around"
	next "inside sometimes."
	next "It must be close"
	next "to hatching.@"

EggMoreTimeString:
	db   "Wonder what's"
	next "inside? It needs"
	next "more time, though.@"

EggALotMoreTimeString:
	db   "This EGG needs a"
	next "lot more time to"
	next "hatch.@"

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
