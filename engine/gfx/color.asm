INCLUDE "engine/gfx/sgb_layouts.asm"

SHINY_ATK_BIT EQU 5
SHINY_DEF_VAL EQU 10
SHINY_SPD_VAL EQU 10
SHINY_SPC_VAL EQU 10

CheckShininess:
; Check if a mon is shiny by DVs at bc.
; Return carry if shiny.

	ld l, c
	ld h, b

; Attack
	ld a, [hl]
	and 1 << SHINY_ATK_BIT
	jr z, .not_shiny

; Defense
	ld a, [hli]
	and $f
	cp  SHINY_DEF_VAL
	jr nz, .not_shiny

; Speed
	ld a, [hl]
	and $f0
	cp  SHINY_SPD_VAL << 4
	jr nz, .not_shiny

; Special
	ld a, [hl]
	and $f
	cp  SHINY_SPC_VAL
	jr nz, .not_shiny

; shiny
	scf
	ret

.not_shiny
	and a
	ret

Unused_CheckShininess:
; Return carry if the DVs at hl are all 10 or higher.

; Attack
	ld a, [hl]
	cp 10 << 4
	jr c, .not_shiny

; Defense
	ld a, [hli]
	and $f
	cp 10
	jr c, .not_shiny

; Speed
	ld a, [hl]
	cp 10 << 4
	jr c, .not_shiny

; Special
	ld a, [hl]
	and $f
	cp 10
	jr c, .not_shiny

; shiny
	scf
	ret

.not_shiny
	and a
	ret

SGB_ApplyCreditsPals: ; unreferenced
	push de
	push bc
	ld hl, PalPacket_Pal01
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop bc
	pop de
	ld a, c
	ld [wSGBPals + 3], a
	ld a, b
	ld [wSGBPals + 4], a
	ld a, e
	ld [wSGBPals + 5], a
	ld a, d
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	call PushSGBPals
	ld hl, BlkPacket_AllPal0
	call PushSGBPals
	ret

InitPartyMenuPalettes:
	ld hl, PalPacket_PartyMenu + 1
	call CopyFourPalettes
	call InitPartyMenuOBPals
	call WipeAttrmap
	ret

; SGB layout for SCGB_PARTY_MENU_HP_BARS
SGB_ApplyPartyMenuHPPals:
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, $5
	jr z, .okay
	dec a
	ld e, $a
	jr z, .okay
	ld e, $f
.okay
	push de
	ld hl, wSGBPals + 10
	ld bc, $6
	ld a, [wSGBPals]
	call AddNTimes
	pop de
	ld [hl], e
	ret

Intro_LoadMagikarpPalettes: ; unreferenced
	call CheckCGB
	ret z

; CGB only
	ld hl, .MagikarpBGPal
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM

	ld hl, .MagikarpOBPal
	ld de, wOBPals1
	ld bc, 1 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM

	call ApplyPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.MagikarpBGPal:
INCLUDE "gfx/intro/gs_magikarp_bg.pal"

.MagikarpOBPal:
INCLUDE "gfx/intro/gs_magikarp_ob.pal"

Intro_LoadAllPal0: ; unreferenced
	call CheckCGB
	ret nz
	ldh a, [hSGB]
	and a
	ret z
	ld hl, BlkPacket_AllPal0
	jp PushSGBPals

Intro_LoadBetaIntroVenusaurPalettes: ; unreferenced
	call CheckCGB
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z
	ld hl, PalPacket_BetaIntroVenusaur
	jp PushSGBPals

.cgb
	ld de, wOBPals1
	ld a, PREDEFPAL_BETA_INTRO_VENUSAUR
	call GetPredefPal
	jp LoadHLPaletteIntoDE

Intro_LoadPackPalettes: ; unreferenced
	call CheckCGB
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z
	ld hl, PalPacket_Pack
	jp PushSGBPals

.cgb
	ld de, wOBPals1
	ld a, PREDEFPAL_PACK
	call GetPredefPal
	jp LoadHLPaletteIntoDE

GSIntro_LoadMonPalette: ; unreferenced
	call CheckCGB
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z
	ld a, c
	push af
	ld hl, PalPacket_Pal01
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop af
	call GetMonPalettePointer
	ld a, [hli]
	ld [wSGBPals + 3], a
	ld a, [hli]
	ld [wSGBPals + 4], a
	ld a, [hli]
	ld [wSGBPals + 5], a
	ld a, [hl]
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	jp PushSGBPals

.cgb
	ld de, wOBPals1
	ld a, c
	call GetMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ret

LoadTrainerClassPaletteAsNthBGPal:
	ld a, [wTrainerClass]
	call GetTrainerPalettePointer
	ld a, e
	jr LoadNthMiddleBGPal

LoadMonPaletteAsNthBGPal:
	ld a, [wCurPartySpecies]
	call _GetMonPalettePointer
	ld a, e
	bit 7, a
	jr z, LoadNthMiddleBGPal
	and $7f
	inc hl
	inc hl
	inc hl
	inc hl

LoadNthMiddleBGPal:
	push hl
	ld hl, wBGPals1
	ld de, 1 palettes
.loop
	and a
	jr z, .got_addr
	add hl, de
	dec a
	jr .loop

.got_addr
	ld e, l
	ld d, h
	pop hl
	call LoadPalette_White_Col1_Col2_Black
	ret

LoadBetaPokerPalettes: ; unreferenced
	ldh a, [hCGB]
	and a
	jr nz, .cgb
	ld hl, wBetaPokerSGBPals
	jp PushSGBPals

.cgb
	ld a, [wBetaPokerSGBCol]
	ld c, a
	ld a, [wBetaPokerSGBRow]
	hlcoord 0, 0, wAttrmap
	ld de, SCREEN_WIDTH
.loop
	and a
	jr z, .done
	add hl, de
	dec a
	jr .loop

.done
	ld b, 0
	add hl, bc
	lb bc, 6, 4
	ld a, [wBetaPokerSGBAttr]
	and $3
	call FillBoxCGB
	call CopyTilemapAtOnce
	ret

ApplyMonOrTrainerPals:
	call CheckCGB
	ret z
	ld a, e
	and a
	jr z, .get_trainer
	ld a, [wCurPartySpecies]
	call GetMonPalettePointer
	jr .load_palettes

.get_trainer
	ld a, [wTrainerClass]
	call GetTrainerPalettePointer

.load_palettes
	ld de, wBGPals1
	call LoadPalette_White_Col1_Col2_Black
	call WipeAttrmap
	call ApplyAttrmap
	call ApplyPals
	ret

ApplyHPBarPals:
	ld a, [wWhichHPBar]
	and a
	jr z, .Enemy
	cp $1
	jr z, .Player
	cp $2
	jr z, .PartyMenu
	ret

.Enemy:
	ld de, wBGPals2 palette PAL_BATTLE_BG_ENEMY_HP color 1
	jr .okay

.Player:
	ld de, wBGPals2 palette PAL_BATTLE_BG_PLAYER_HP color 1

.okay
	ld l, c
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarPals
	add hl, bc
	ld bc, 4
	ld a, BANK(wBGPals2)
	call FarCopyWRAM
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.PartyMenu:
	ld e, c
	inc e
	hlcoord 11, 1, wAttrmap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wCurPartyMon]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop

.done
	lb bc, 2, 8
	ld a, e
	call FillBoxCGB
	ret

LoadStatsScreenPals:
	call CheckCGB
	ret z
	ld hl, StatsScreenPals
	ld b, 0
	dec c
	add hl, bc
	add hl, bc
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, [hli]
	ld [wBGPals1 palette 0], a
	ld [wBGPals1 palette 2], a
	ld [wBGPals1 palette 6], a
	ld a, 0
	ld [wBGPals1 palette 6 color 3], a
	ld a, [hl]
	ld [wBGPals1 palette 0 + 1], a
	ld [wBGPals1 palette 2 + 1], a
	ld [wBGPals1 palette 6 + 1], a
	ld a, 0
	ld [wBGPals1 palette 6 color 3 + 1], a

	; Special case for the green page.
	ld a, l
	cp LOW(StatsScreenPals + 3) ; We are checking if we are on the Green page.
	jr nz, .end_loading

	; If it's the Green page, we change the color of the tooltip's text (background has already been edited).
	ld hl, DetailsTooltipTextColor
	ld a, [hli]
	ld [wBGPals1 palette 6 color 3], a
	ld a, [hl]
	ld [wBGPals1 palette 6 color 3 + 1], a

.end_loading
	pop af
	ldh [rSVBK], a
	call ApplyPals
	ld a, $1
	ret

DetailsTooltipTextColor:
	RGB 28, 31, 21

LoadMailPalettes:
	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, .MailPals
	add hl, de
	call CheckCGB
	jr nz, .cgb
	push hl
	ld hl, PalPacket_Pal01
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop hl
	inc hl
	inc hl
	ld a, [hli]
	ld [wSGBPals + 3], a
	ld a, [hli]
	ld [wSGBPals + 4], a
	ld a, [hli]
	ld [wSGBPals + 5], a
	ld a, [hli]
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	call PushSGBPals
	ld hl, BlkPacket_AllPal0
	call PushSGBPals
	ret

.cgb
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	call ApplyPals
	call WipeAttrmap
	call ApplyAttrmap
	ret

.MailPals:
INCLUDE "gfx/mail/mail.pal"

INCLUDE "engine/gfx/cgb_layouts.asm"

CopyFourPalettes:
	ld de, wBGPals1
	ld c, 4

CopyPalettes:
.loop
	push bc
	ld a, [hli]
	push hl
	call GetPredefPal
	call LoadHLPaletteIntoDE
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

GetPredefPal:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PredefPals
	add hl, bc
	ret

LoadHLPaletteIntoDE:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld c, 1 palettes
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

LoadPalette_White_Col1_Col2_Black:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld a, LOW(PALRGB_WHITE)
	ld [de], a
	inc de
	ld a, HIGH(PALRGB_WHITE)
	ld [de], a
	inc de

	ld c, 2 * PAL_COLOR_SIZE
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop

	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de

	pop af
	ldh [rSVBK], a
	ret

FillBoxCGB:
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

ResetBGPals:
	push af
	push bc
	push de
	push hl

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld hl, wBGPals1
	ld c, 1 palettes
.loop
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .loop

	pop af
	ldh [rSVBK], a

	pop hl
	pop de
	pop bc
	pop af
	ret

WipeAttrmap:
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ret

ApplyPals:
	ld hl, wBGPals1
	ld de, wBGPals2
	ld bc, 16 palettes
	ld a, BANK(wGBCPalettes)
	call FarCopyWRAM
	ret

ApplyAttrmap:
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jr z, .UpdateVBank1
	ldh a, [hBGMapMode]
	push af
	ld a, $2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	ret

.UpdateVBank1:
	hlcoord 0, 0, wAttrmap
	debgcoord 0, 0
	ld b, SCREEN_HEIGHT
	ld a, $1
	ldh [rVBK], a
.row
	ld c, SCREEN_WIDTH
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
	ld a, BG_MAP_WIDTH - SCREEN_WIDTH
	add e
	jr nc, .okay
	inc d
.okay
	ld e, a
	dec b
	jr nz, .row
	ld a, $0
	ldh [rVBK], a
	ret

; CGB layout for SCGB_PARTY_MENU_HP_BARS
CGB_ApplyPartyMenuHPPals:
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	inc a
	ld e, a
	hlcoord 11, 2, wAttrmap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wSGBPals]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop
.done
	lb bc, 2, 8
	ld a, e
	call FillBoxCGB
	ret

InitPartyMenuOBPals:
	ld hl, PartyMenuOBPals
	ld de, wOBPals1
	ld bc, 8 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
	ret

GetBattlemonBackpicPalettePointer:
	push de
	farcall GetPartyMonDVs
	ld c, l
	ld b, h
	ld a, [wTempBattleMonSpecies]
	call GetPlayerOrMonPalettePointer
	pop de
	ret

GetEnemyFrontpicPalettePointer:
	push de
	farcall GetEnemyMonDVs
	ld c, l
	ld b, h
	ld a, [wTempEnemyMonSpecies]
	call GetFrontpicPalettePointer
	pop de
	ret

GetPlayerOrMonPalettePointer:
	and a
	jp nz, GetMonNormalOrShinyPalettePointer
	ld a, [wPlayerSpriteSetupFlags]
	bit PLAYERSPRITESETUP_FEMALE_TO_MALE_F, a
	jr nz, .male
	ld a, [wPlayerGender]
	and a
	jr z, .male
	ld hl, KrisPalette
	ret

.male
	ld hl, PlayerPalette
	ret

GetFrontpicPalettePointer:
	and a
	jp nz, GetMonNormalOrShinyPalettePointer
	ld a, [wTrainerClass]

GetTrainerPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, TrainerPalettes
	add hl, bc
	ret

GetMonPalettePointer:
	call _GetMonPalettePointer
	ret

CGBCopyBattleObjectPals: ; unreferenced
; dummied out
	ret
	call CheckCGB
	ret z
	ld hl, BattleObjectPals
	ld a, (1 << rOBPI_AUTO_INCREMENT) | $10
	ldh [rOBPI], a
	ld c, 6 palettes
.loop
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .loop
	ld hl, BattleObjectPals
	ld de, wOBPals1 palette 2
	ld bc, 2 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
	ret

BattleObjectPals:
INCLUDE "gfx/battle_anims/battle_anims.pal"

CGBCopyTwoPredefObjectPals: ; unreferenced
	call CheckCGB
	ret z
	ld a, (1 << rOBPI_AUTO_INCREMENT) | $10
	ldh [rOBPI], a
	ld a, PREDEFPAL_TRADE_TUBE
	call GetPredefPal
	call .PushPalette
	ld a, PREDEFPAL_RB_GREENMON
	call GetPredefPal
	call .PushPalette
	ret

.PushPalette:
	ld c, 1 palettes
.loop
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .loop
	ret

_GetMonPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PokemonPalettes
	add hl, bc
	ret

GetMonNormalOrShinyPalettePointer:
	push bc
	call _GetMonPalettePointer
	pop bc
	push hl
	call CheckShininess
	pop hl
	ret nc
rept 4
	inc hl
endr
	ret

PushSGBPals:
	ld a, [wJoypadDisable]
	push af
	set JOYPAD_DISABLE_SGB_TRANSFER_F, a
	ld [wJoypadDisable], a
	call _PushSGBPals
	pop af
	ld [wJoypadDisable], a
	ret

_PushSGBPals:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop
	push bc
	xor a
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	ld b, $10
.loop2
	ld e, $8
	ld a, [hli]
	ld d, a
.loop3
	bit 0, d
	ld a, $10
	jr nz, .okay
	ld a, $20
.okay
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .loop3
	dec b
	jr nz, .loop2
	ld a, $20
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	pop bc
	dec b
	jr nz, .loop
	ret

InitSGBBorder:
	call CheckCGB
	ret nz

; SGB/DMG only
	di
	ld a, [wJoypadDisable]
	push af
	set JOYPAD_DISABLE_SGB_TRANSFER_F, a
	ld [wJoypadDisable], a

	xor a
	ldh [rJOYP], a
	ldh [hSGB], a
	call PushSGBBorderPalsAndWait
	jr nc, .skip
	ld a, $1
	ldh [hSGB], a
	call _InitSGBBorderPals
	call SGBBorder_PushBGPals
	call SGBDelayCycles
	call SGB_ClearVRAM
	call PushSGBBorder
	call SGBDelayCycles
	call SGB_ClearVRAM
	ld hl, MaskEnCancelPacket
	call _PushSGBPals

.skip
	pop af
	ld [wJoypadDisable], a
	ei
	ret

InitCGBPals::
	call CheckCGB
	ret z

; CGB only
	ld a, BANK(vTiles3)
	ldh [rVBK], a
	ld hl, vTiles3
	ld bc, $200 tiles
	xor a
	call ByteFill
	ld a, BANK(vTiles0)
	ldh [rVBK], a
	ld a, 1 << rBGPI_AUTO_INCREMENT
	ldh [rBGPI], a
	ld c, 4 * 8
.bgpals_loop
	ld a, LOW(PALRGB_WHITE)
	ldh [rBGPD], a
	ld a, HIGH(PALRGB_WHITE)
	ldh [rBGPD], a
	dec c
	jr nz, .bgpals_loop
	ld a, 1 << rOBPI_AUTO_INCREMENT
	ldh [rOBPI], a
	ld c, 4 * 8
.obpals_loop
	ld a, LOW(PALRGB_WHITE)
	ldh [rOBPD], a
	ld a, HIGH(PALRGB_WHITE)
	ldh [rOBPD], a
	dec c
	jr nz, .obpals_loop
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	call .LoadWhitePals
	ld hl, wBGPals2
	call .LoadWhitePals
	pop af
	ldh [rSVBK], a
	ret

.LoadWhitePals:
	ld c, 4 * 16
.loop
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
	dec c
	jr nz, .loop
	ret

_InitSGBBorderPals:
	ld hl, .PacketPointerTable
	ld c, 9
.loop
	push bc
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call _PushSGBPals
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

.PacketPointerTable:
	dw MaskEnFreezePacket
	dw DataSndPacket1
	dw DataSndPacket2
	dw DataSndPacket3
	dw DataSndPacket4
	dw DataSndPacket5
	dw DataSndPacket6
	dw DataSndPacket7
	dw DataSndPacket8

UpdateSGBBorder: ; unreferenced
	di
	xor a
	ldh [rJOYP], a
	ld hl, MaskEnFreezePacket
	call _PushSGBPals
	call PushSGBBorder
	call SGBDelayCycles
	call SGB_ClearVRAM
	ld hl, MaskEnCancelPacket
	call _PushSGBPals
	ei
	ret

PushSGBBorder:
	call .LoadSGBBorderPointers
	push de
	call SGBBorder_YetMorePalPushing
	pop hl
	call SGBBorder_MorePalPushing
	ret

.LoadSGBBorderPointers:
	ld hl, SGBBorderGFX
	ld de, SGBBorderMapAndPalettes
	ret

SGB_ClearVRAM:
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	xor a
	call ByteFill
	ret

PushSGBBorderPalsAndWait:
	ld hl, MltReq2Packet
	call _PushSGBPals
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	ld a, $20
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $10
	ldh [rJOYP], a
rept 6
	ldh a, [rJOYP]
endr
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	call .FinalPush
	and a
	ret

.carry
	call .FinalPush
	scf
	ret

.FinalPush:
	ld hl, MltReq1Packet
	call _PushSGBPals
	jp SGBDelayCycles

SGBBorder_PushBGPals:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld hl, PredefPals
	ld de, vTiles1
	ld bc, $100 tiles
	call CopyData
	call DrawDefaultTiles
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld hl, PalTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_MorePalPushing:
	call DisableLCD
	ld a, $e4
	ldh [rBGP], a
	ld de, vTiles1
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld b, SCREEN_HEIGHT
.loop
	push bc
	ld bc, 6 * 2
	call CopyData
	ld bc, SCREEN_WIDTH * 2
	call ClearBytes
	ld bc, 6 * 2
	call CopyData
	pop bc
	dec b
	jr nz, .loop
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld bc, $100
	call ClearBytes
	ld bc, 16 palettes
	call CopyData
	call DrawDefaultTiles
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld hl, PctTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_YetMorePalPushing:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld de, vTiles1
	ld b, $80
.loop
	push bc
	ld bc, 1 tiles
	call CopyData
	ld bc, 1 tiles
	call ClearBytes
	pop bc
	dec b
	jr nz, .loop
	call DrawDefaultTiles
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld hl, ChrTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

CopyData:
; copy bc bytes of data from hl to de
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

ClearBytes:
; clear bc bytes of data starting from de
.loop
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

DrawDefaultTiles:
; Draw 240 tiles (2/3 of the screen) from tiles in VRAM
	hlbgcoord 0, 0 ; BG Map 0
	ld de, BG_MAP_WIDTH - SCREEN_WIDTH
	ld a, $80 ; starting tile
	ld c, 12 + 1
.line
	ld b, 20
.tile
	ld [hli], a
	inc a
	dec b
	jr nz, .tile
; next line
	add hl, de
	dec c
	jr nz, .line
	ret

SGBDelayCycles:
	ld de, 7000
.wait
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .wait
	ret

INCLUDE "gfx/sgb/blk_packets.asm"
INCLUDE "gfx/sgb/pal_packets.asm"
INCLUDE "data/sgb_ctrl_packets.asm"

PredefPals:
INCLUDE "gfx/sgb/predef.pal"

SGBBorderMapAndPalettes:
; interleaved tile ids and palette ids, without the center 20x18 screen area
INCBIN "gfx/sgb/sgb_border.sgb.tilemap"
; four SGB palettes of 16 colors each; only the first 4 colors are used
INCLUDE "gfx/sgb/sgb_border.pal"

SGBBorderGFX:
INCBIN "gfx/sgb/sgb_border.2bpp"

HPBarPals:
INCLUDE "gfx/battle/hp_bar.pal"

ExpBarPalette:
INCLUDE "gfx/battle/exp_bar.pal"

INCLUDE "data/pokemon/palettes.asm"

INCLUDE "data/trainers/palettes.asm"

LoadMapPals:
	farcall LoadSpecialMapPalette
	jr c, .got_bg_pals

	; Which palette group is based on whether we're outside or inside
	ld a, [wEnvironment]
	and 7
	ld e, a
	ld d, 0
	ld hl, EnvironmentColorsPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Further refine by time of day
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	ld b, 8
.outer_loop
	ld a, [de] ; lookup index for TilesetBGPalette
	push de
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, TilesetBGPalette
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld c, 1 palettes
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop de
	inc de
	dec b
	jr nz, .outer_loop
	pop af
	ldh [rSVBK], a

.got_bg_pals
	ld de, MapObjectPals
	call DoesCurrentMapUsesPurpleOWSprites
	jr nc, .normal_sprite_palette
	ld de, MapObjectPalsPurple
.normal_sprite_palette:
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	ld bc, 8 palettes
	ld h, d
	ld l, e
	call AddNTimes
	ld de, wOBPals1
	ld bc, 8 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM

	ld a, [wEnvironment]
	cp TOWN
	jr z, .outside
	cp ROUTE
	ret nz
.outside
	ld a, FALSE
	ld [wMustRefreshPaletteNow], a
	call _ForceTimeOfDayPaletteSmoothing
	ret c ; If the palette smoothing has been applied, then the roof pal has already been written so we skip the default roof palette.

	ld a, [wMapGroup]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, RoofPals
	add hl, de
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	cp NITE_F
	jr c, .morn_day
rept 4
	inc hl
endr
.morn_day
	ld de, wBGPals1 palette PAL_BG_ROOF color 1
	ld bc, 4
	ld a, BANK(wBGPals1)
	call FarCopyWRAM

	call HandleDayCareOutdoorPalettes
	ret


; Returns carry if the current map must use the purple palette.
; Destroys a, bc and hl.
DoesCurrentMapUsesPurpleOWSprites:

	ld a, BANK(wMapGroup)
	ld hl, wMapGroup
	call GetFarWRAMByte
	ld b, a
	ld a, BANK(wMapNumber)
	ld hl, wMapNumber
	call GetFarWRAMByte
	ld c, a
	ld hl, PurpleMapList
.loop
	ld a, [hli] ; group
	and a ; unsets the carry flag.
	ret z ; end.
	cp b
	ld a, [hli] ; map
	jr nz, .loop
	cp c
	jr nz, .loop
	scf ; set carry flag.
	ret










; Returns carry is a palette change has been made.
_TimeOfDayPaletteSmoothing::
; Update once per minute.
	ld a, [wLastPaletteTransitionMinute]
	ld b, a
	ldh a, [hMinutes]
	cp b
	jp z, _ForceTimeOfDayPaletteSmoothing.return_false

; Don't update a non-standard palette order
	ldh a, [rBGP]
	cp %11100100
	jp nz, _ForceTimeOfDayPaletteSmoothing.return_false

	ld a, TRUE
	ld [wMustRefreshPaletteNow], a
	; fallthrough

_ForceTimeOfDayPaletteSmoothing::
; Update only on outdoor maps.
	ld a, [wMapTimeOfDay]
	cp PALETTE_AUTO
	jp nz, .return_false

; Checking that the hour is right before a time of day change.
	ldh a, [hHours]
	cp NITE_HOUR - 1
	jr z, .hour_is_adequate
	cp DAY_HOUR - 1
	jr z, .hour_is_adequate
	cp MORN_HOUR - 1
	jp nz, .return_false
.hour_is_adequate

; Don't update the palette on DMG
	ldh a, [hCGB]
	and a
	jp z, .return_false

; Smoothing happens only 32 minutes before a time of day transition (31 actually, as the minute 28 (60 - 32) returns the current time of day palette).
	ldh a, [hMinutes] ; 0 <= hMinutes <= 59.
	cp 60 ; Note: hMinutes cannot go above 59, unless the player used an action replay cheatcode to set wStartMinute above 59.
	jp nc, .return_false
	cp 28
	jr nc, .end_checks
	jp .return_false

.end_checks
	ld [wLastPaletteTransitionMinute], a

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

; #### BG PALETTES #### ;
	ld hl, wBGPals1
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a

; We get the address of the palette indexes, according to the current time of day.
	ld hl, EnvironmentColorsPointers
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld h, d
	ld l, e

	; Further refine by time of day
	push hl
	farcall GetTimeOfDay
	pop hl
	ld a, [wTimeOfDay]
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de ; Now hl contains the address of the 8 indexes (1 byte each) of the current time of day palettes.


	ld b, h
	ld c, l

	cp NITE_F * 8
	jr nz, .not_night
; night: equivalent of sub bc, 16
	ld a, c
	sub a, 16
	ld c, a
	ld a, b
	sbc a, 0
	ld b, a
	jr .second_palette_found

.not_night; equivalent of add bc, 8
	ld a, c
	add a, 8
	ld c, a
	ld a, b
	adc a, 0
	ld b, a

.second_palette_found ; stored in BC.
; For each BG palette, get the current palette and the next time of day palette, then lerp the colors, then apply it.
	ld d, 7 ; 7 palettes.
.bg_palette_loop
	push de ; We save the loop counter.

	push hl ; We save the first palette index address.

	ld a, [hl]
	call FindPaletteFirstColorOffsetInDE
	ld hl, TilesetBGPalette
	add hl, de ; We have the address of the high byte of the first color of the first palette in HL.

	push bc ; We save the second palette index address.
	ld a, [bc]
	call FindPaletteFirstColorOffsetInDE
	ld bc, TilesetBGPalette
	; equivalent of add bc, de (instruction not available on Game Boy Color).
	ld a, c
	add a, e
	ld c, a
	ld a, b
	adc a, d
	ld b, a ; We have the address of the high byte of the first color of the second palette in BC.


	call SinglePaletteTransition
	pop bc
	pop hl
	pop de

	; We can now move on to the next palette.
	inc bc
	inc hl

	dec d
	jp nz, .bg_palette_loop


; #### ROOF PALETTES #### ;
	call RoofPaletteOverride ; Special case for the Roofs.








; #### OBJ PALETTES #### ;
	ld hl, wOBPals1
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a

	ld hl, MapObjectPals + 2
	push hl
	call DoesCurrentMapUsesPurpleOWSprites
	pop hl
	jr nc, .not_purple
; is purple map.
	ld hl, MapObjectPalsPurple + 2

.not_purple
	call TimeOfDayNextOBJPalette ; Further refine by time of day

; For each OBJ palette, get the current palette and the next time of day palette, then lerp the colors, then apply it.
	ld d, 8 ; 8 palettes.
.ob_palette_loop
	push de ; We save the loop counter.

	ld a, [wAddressStorage]
	ld d, a
	ld a, [wAddressStorage + 1]
	ld e, a
	inc de
	inc de 
	ld a, d
	ld [wAddressStorage], a
	ld a, e
	ld [wAddressStorage + 1], a ; Skip the first color of the palette, as it's not used.

	call SinglePaletteTransition

	inc hl
	inc hl
	inc bc
	inc bc ; We skip the first color of the next palette.

	pop de
	dec d
	jp nz, .ob_palette_loop

	call HandleDayCareOutdoorTransitionPalettes




	pop af
	ldh [rSVBK], a

	; If the palette fade was triggered naturally by the time (and not forced), we need to apply now.
	ld a, [wMustRefreshPaletteNow]
	and a
	jr z, .skip_instant_refresh

	call ApplyPals ; Copy everything into wBGPals2 and wOBPals2 for display on the screen.
	ld a, TRUE
	ldh [hCGBPalUpdate], a ; Turn on the flag that triggers the palette refresh on screen.

.skip_instant_refresh

	; TODO: Do the same for map objects. Or not.
	; TODO: Do a special case for purple map objects from PurpleMapList: using the palette MapObjectPalsPurple:
	; Don't worry about maps from LoadSpecialMapPalette, as they all are indoor maps.
	scf
	ret

.return_false
	xor a
	ret




; Input in A: the ID of the palette.
; Output in DE: offset from the address of TilesetBGPalette to the address of the first color of the palette ID given in input.
FindPaletteFirstColorOffsetInDE:
	ldh [hMultiplicand], a
	xor a
	ldh [hMultiplicand + 1], a
	ldh [hMultiplicand + 2], a
	ld a, 8
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 1]
	ld e, a
	ldh a, [hProduct]
	ld d, a
	ret



HandleDayCareOutdoorPalettes:
	ld a, [wMapGroup]
	cp GROUP_ROUTE_34
	ret nz
	ld a, [wMapNumber]
	cp MAP_ROUTE_34
	ret nz

	ld a, BANK(wBreedMon1Species)
	ld hl, wBreedMon1Species
	call GetFarWRAMByte
	cp 0
	jr z, .day_care_mon_2
	cp -1
	jr z, .day_care_mon_2
	ld [wCurPartySpecies], a

	ld hl, wBreedMon1DVs ; HL now points to the params of the wBreedMon1, which is needed by GetMenuMonIconPalette to determine if it's shiny.
	call GetPartyMenuMonTimeOfDayPalettes

	ld de, wOBPals1 palette 6
	ld bc, 1 palettes
 	ld a, BANK(wOBPals1)
 	call FarCopyWRAM

.day_care_mon_2
	ld a, BANK(wBreedMon2Species)
	ld hl, wBreedMon2Species
	call GetFarWRAMByte
	cp 0
	ret z
	cp -1
	ret z
	ld [wCurPartySpecies], a



	ld hl, wBreedMon2DVs ; HL now points to the params of the wBreedMon2, which is needed by GetMenuMonIconPalette to determine if it's shiny.
	call GetPartyMenuMonTimeOfDayPalettes ; Returns the palette in HL.

	ld de, wOBPals1 palette 7
	ld bc, 1 palettes
 	ld a, BANK(wOBPals1)
 	call FarCopyWRAM

	ret



HandleDayCareOutdoorTransitionPalettes:
	; Day Care special case: on Route 34, we change the palette so they match the Pokémon species outside the day care.
	ld a, BANK(wMapGroup)
	ld hl, wMapGroup
	call GetFarWRAMByte
	cp GROUP_ROUTE_34
	ret nz
	ld a, BANK(wMapNumber)
	ld hl, wMapNumber
	call GetFarWRAMByte
	cp MAP_ROUTE_34
	ret nz

	ld a, BANK(wBreedMon1Species)
	ld hl, wBreedMon1Species
	call GetFarWRAMByte
	cp 0
	jr z, .day_care_mon_2
	cp -1
	jr z, .day_care_mon_2
	ld [wCurPartySpecies], a

	ld hl, wOBPals1 palette 6
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a

	ld hl, wBreedMon1DVs ; HL now points to the params of the wBreedMon1, which is needed by GetMenuMonIconPalette to determine if it's shiny.
	call GetPartyMenuMonTimeOfDayPalettes
	call SinglePaletteTransition

.day_care_mon_2
	ld a, BANK(wBreedMon2Species)
	ld hl, wBreedMon2Species
	call GetFarWRAMByte
	cp 0
	ret z
	cp -1
	ret z
	ld [wCurPartySpecies], a

	ld hl, wOBPals1 palette 7
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a

	ld hl, wBreedMon2DVs ; HL now points to the params of the wBreedMon2, which is needed by GetMenuMonIconPalette to determine if it's shiny.
	call GetPartyMenuMonTimeOfDayPalettes
	call SinglePaletteTransition

	ret




; Input: the mon DVs address in hl, set [wCurPartySpecies] to the desired mon.
; Destroys de.
; Output: the source color address in hl, and the destination color address in bc.
GetPartyMenuMonTimeOfDayPalettes:
	ld de, GetMenuMonIconPalette
	ld a, BANK(GetMenuMonIconPalette)
	call FarCall_de ; Returns in A the index of PartyMenuOBPals to use.
	ldh a, [hFarByte]
	add a
	add a
	add a ; A x 8.

	ld e, a
	ld d, 0
	ld hl, PartyMenuOBPals
	add hl, de

	ld b, h
	ld c, l

	ld d, 0
	ld e, 4 * 2 * 8

; Getting the source and destination color addresses based on time of day.
	ld a, [wTimeOfDay]
	cp MORN_F
	ret z
	cp NITE_F
	jr z, .is_night

	ld a, c
	add e
	ld c, a
	ld a, b
	adc d
	ld b, a
	ret

.is_night
	add hl, de
	ret




; Input: hl must contain the address of the OBJ original palette (first color of the fade).
; Output: the address of the OBJ destination palette (second color of the fade) in bc.
; Destroys de and a.
TimeOfDayNextOBJPalette:
	ld a, [wTimeOfDay]
	rrca
	rrca ; This instruction and the previous one make a multiplication by 64 of a 1 byte number whose value is between 0 and 3. In only 2 cycles! Try to beat that!
	ld e, a
	ld d, 0
	add hl, de ; Now hl contains the address of the second color of the first sprite palette.


	ld b, h ; ld bc, hl
	ld c, l

	cp NITE_F * 64
	jr nz, .not_night
; night: equivalent of sub bc, 128
	ld a, c
	sub a, 128
	ld c, a
	ld a, b
	sbc a, 0
	ld b, a
	ret

.not_night; equivalent of add bc, 64
	ld a, c
	add a, 64
	ld c, a
	ld a, b
	adc a, 0
	ld b, a
	ret




RoofPaletteOverride:
	ld a, [wAddressStorage]
	ld h, a
	ld a, [wAddressStorage + 1]
	ld l, a
	push hl

rept 6
	dec hl
endr

	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a ; The address contained in wAddressStorage has been decreased by 6 bytes, so we can edit the 2nd color of the previous palette.

	ld a, BANK(wMapGroup)
	ld hl, wMapGroup
	call GetFarWRAMByte
	add a 
	add a 
	add a ; wMapGroup multiplied by 8. 26 * 8 = 208, still fits within 1 byte with enough room to create 5 new map groups.

	ld e, a
	ld d, 0

	ld hl, RoofPals
	add hl, de ; This is the address of the roof palette within the current map group.
	ld b, h
	ld c, l ; We copy hl into bc.

	ld e, 4 ; We prepare the offset of our next addition.
	ld d, 0

	ld a, [wTimeOfDay]
	cp MORN_F
	jr z, .source_determined
	cp NITE_F
	jr z, .is_night

	ld a, c
	add e
	ld c, a
	ld a, b
	adc d
	ld b, a
	jr .source_determined
.is_night
	add hl, de

.source_determined
	call SinglePaletteTransition

	pop hl
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a
	ret



















SinglePaletteTransition:
	; Fades a single palette between its current and its next time of day versions.
	; hl must contain the address of the first color of the first palette to fade from.
	; bc must contain the address of the first color of the second palette to fade to.
	; de are destroyed.
	; [wAddressStorage] and [wAddressStorage + 1] must contains the address of where to write.
	
	push bc ; As we will edit B, we want to save the address of the first color byte of the second palette.

	; We store the ratios of each palette in DE.
	ldh a, [hMinutes] ; A has a value from 28 to 59.
	ld d, a
	ld a, 60
	sub d 
	ld d, a ; D now contains a value between 32 and 1.
	ld e, d ; Backup of the ratio D.

.palette_loop

; **** FIRST PALETTE ****
	; We split this color on 3 separate bytes then apply their ratio.
	ld a, [hl]
	and %11111

	call OriginColorMultiplication
	ld a, b
	ld [wTempColorMixer + 0], a ; Red.
	ld a, c
	ld [wTempColorMixer + 1], a ; Red.

	ld a, [hl]
	swap a
	srl a
	and %111
	ld b, a

	inc hl
	ld a, [hl] ; We get the second (high) byte of the color.
	and %11
	swap a
	srl a
	add b

	call OriginColorMultiplication
	ld a, b
	ld [wTempColorMixer + 2], a ; Green.
	ld a, c
	ld [wTempColorMixer + 3], a ; Green.

	ld a, [hl]
	srl a
	srl a
	and %11111

	call OriginColorMultiplication
	ld a, b
	ld [wTempColorMixer + 4], a ; Blue.
	ld a, c
	ld [wTempColorMixer + 5], a ; Blue.

	;TimeOfDayPaletteSwap ; Getting the second palette ready.
	; Computing the opposite of E.
	ld a, 33
	sub e
	ld e, a ; E now contains the opposite of its previous value, ranging from 1 to 32. This represents the ratio of the next palette.

	; We retrieve the offset to the next time of day palette.
	pop bc
	inc hl
	push hl ; We save hl back in the stack, to retrieve it faster.
	ld h, b
	ld l, c



	

; **** SECOND PALETTE ****
	; We split this color in 3 separate bytes, apply their ratio, then add it to the previously stored color components.
	ld a, [hl]
	and %11111

	ld b, HIGH(wTempColorMixer + 1)
	ld c, LOW(wTempColorMixer + 1)
	call DestinationColorRatio

	ld a, [hl]
	swap a
	srl a
	and %111
	ld b, a ; We can afford to edit the value of C as we don't need it anymore.

	inc hl
	ld a, [hl]
	and %11
	swap a
	srl a
	add b

	ld b, HIGH(wTempColorMixer + 3)
	ld c, LOW(wTempColorMixer + 3)
	call DestinationColorRatio

	ld a, [hl]
	srl a
	srl a
	and %11111

	ld b, HIGH(wTempColorMixer + 5)
	ld c, LOW(wTempColorMixer + 5)
	call DestinationColorRatio


; **** CONCATENATION OF COLORS INTO 2 BYTES ****
	ld a, [wTempColorMixer + 1]
	ld b, a

	ld a, [wTempColorMixer + 3]
	and %111
	swap a
	sla a
	add b
	ld d, a

	ld a, [wAddressStorage]
	ld b, a
	ld a, [wAddressStorage + 1]
	ld c, a
	ld a, d
	ld [bc], a ; Writing the first byte.
	inc bc
	ld a, b
	ld [wAddressStorage], a
	ld a, c
	ld [wAddressStorage + 1], a

	ld a, [wTempColorMixer + 5]
	sla a
	sla a
	ld b, a

	ld a, [wTempColorMixer + 3]
	sla a
	swap a
	and %11
	add b
	ld d, a

	ld a, [wAddressStorage]
	ld b, a
	ld a, d
	ld [bc], a ; Writing the second byte.
	inc bc
	ld a, b
	ld [wAddressStorage], a
	ld a, c
	ld [wAddressStorage + 1], a 



; **** PREPARING FOR THE NEXT LOOP ****
	; Computing the opposite of E.
	ld a, 33
	sub e
	ld e, a ; E now contains the opposite its previous value, ranging from 32 to 1. This represents the ratio of the first palette.
	ld d, e

	; We retrieve the offset to the next time of day palette.
	pop bc
	inc hl
	push hl ; We save hl back in the stack, to retrieve it faster.
	ld h, b
	ld l, c

	; We leave this loop once we've reached the last color of the current palette.
	; To check that, we know that the last nibble of the address of the palette must be a multiple of 8 (4 colors * 2 bytes per palette).
	; This works with both BG and OBJ palettes, as those are aligned in WRAM.
	ld a, [wAddressStorage + 1]
	and $F
	cp $0
	jr z, .end_loop
	cp $8
	jr z, .end_loop

	; For the roof palette, we only need to treat the 2 middle colors of the palette, so we make a special case.
	ld a, h
	cp HIGH(RoofPals)
	jp c, .palette_loop
	ld a, HIGH(DiplomaPalettes) ; Palettes are separated by at least 256 bytes, so checking the high byte is enough.
	cp h
	jp c, .palette_loop

	ld a, [wAddressStorage + 1]
	and $F
	cp $6
	jr z, .end_loop

	; We can now move on to the next color of this palette.
	jp .palette_loop

.end_loop
	pop bc ; Cleaning the stack. Also it returns at the updated addresses in the same order as when entering this function.
	ret





; Multiplies the color A by E, and stores the result in BC.
; Input: the color in A, and the ratio (multiplier) in E.
; Output: the multiplied color in BC.
; Destroys D as well.
OriginColorMultiplication:
	ld d, e
	ld b, 0
	ld c, 0
.color_multiplication_loop
	push af
	add c
	ld c, a
	ld a, b
	adc 0
	ld b, a
	pop af
	dec d
	jr nz, .color_multiplication_loop
	ret



; Multiplies the color A by E-1, then adds it to the color stored in [BC-1] and [BC] before dividing it by 32, and finally storing it back into [BC-1] and [BC].
; Input: color in A, ratio (multiplier) in E, address of the low byte of the color to mix it with in BC. Example: if the color is stored in wTempColorMixer + 0 and wTempColorMixer + 1, then BC must be wTempColorMixer + 1.
; Output: final mixed color in [BC-1] and [BC].
; Destroys A, BC and D.
DestinationColorRatio:
	push hl
	ld d, e
	ld h, 0 ; We use hl instead of bc here, because it allows add hl, hl as needed later, which is impossible with bc.
	ld l, 0
.color_multiplication_loop
	dec d
	jr z, .multiplication_end
	push af
	add l
	ld l, a
	ld a, h
	adc 0
	ld h, a
	pop af
	jr .color_multiplication_loop
.multiplication_end

	ld a, [bc]
	dec bc
	add l
	ld l, a

	ld a, [bc]
	adc h
	ld h, a ; HL now contains the undivided color component. It needs to be divided by 32 to be used in a palette.

	; We divide by 32 (2^5).
	xor a 
	add hl, hl
	rla
	add hl, hl
	rla
	add hl, hl
	rla
	ld l, h
	ld h, a
	ld a, h
  	ld [bc], a 
  	inc bc
  	ld a, l
  	ld [bc], a 
	pop hl
	ret

; Input: E must contain the offset of the selected palette from PartyMenuOBPals.
SetFlyingMonPalette::
	call IsTimeOfDayTransitioning
	jr nc, .regular_palette_load

; Fade mon palette
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPartyMon1DVs)
	ldh [rSVBK], a

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH ; de should not be touched, but I'm not sure about SmallFarFlagAction.
	ld a, [wCurPartyMon]
	call AddNTimes ; Add bc * a to hl.
	call GetPartyMenuMonTimeOfDayPalettes ; Input: the mon DVs address in hl, set [wCurPartySpecies] to the desired mon. Output: the source color address in hl, and the destination color address in bc.
	push hl

	ld a, BANK(wOBPals1)
	ldh [rSVBK], a

	ld hl, wOBPals1
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a

	pop hl
	call SinglePaletteTransition

	pop af
	ldh [rSVBK], a

	call ApplyPals
    ld a, TRUE
    ldh [hCGBPalUpdate], a ; Turn on the flag that triggers the palette refresh on screen.
	ret

.regular_palette_load
	ld a, [wTimeOfDay]
	cp NITE_F
	jr nz, SetFirstOBJPalette
	ld a, 64
	add e
	ld e, a ; If it's NITE, we're using the night palette by adding 64 to the offset.

	; fallthrough

; Input: E must contain the offset of the selected palette from PartyMenuOBPals.
SetFirstOBJPalette::
	ld hl, PartyMenuOBPals
	ld d, 0
	add hl, de
 	ld de, wOBPals1
	ld bc, 1 palettes
 	ld a, BANK(wOBPals1)
 	call FarCopyWRAM
 	call ApplyPals
 	ld a, TRUE
 	ldh [hCGBPalUpdate], a
 	ret

 ; Returns carry if the time of day is currently transitioning (starts 32 minutes before next time of day).
IsTimeOfDayTransitioning:
	ldh a, [hHours]
	cp NITE_HOUR - 1
	jr z, .hour_is_adequate
	cp DAY_HOUR - 1
	jr z, .hour_is_adequate
	cp MORN_HOUR - 1
	jp nz, .return_false

.hour_is_adequate
; Smoothing happens only 32 minutes before a time of day transition (31 actually, as the minute 28 (60 - 32) returns the current time of day palette).
	ldh a, [hMinutes] ; 0 <= hMinutes <= 59.
	cp 60 ; Note: hMinutes cannot go above 59, unless the player used an action replay cheatcode to set wStartMinute above 59.
	jp nc, .return_false
	cp 28
	jr nc, .return_true
.return_false
	xor a
	ret

.return_true
	scf
	ret


INCLUDE "data/sprites/maps_with_purple_objects.asm"

INCLUDE "data/maps/environment_colors.asm"

PartyMenuBGMobilePalette:
INCLUDE "gfx/stats/party_menu_bg_mobile.pal"

PartyMenuBGPalette:
INCLUDE "gfx/stats/party_menu_bg.pal"

TilesetBGPalette:
INCLUDE "gfx/tilesets/bg_tiles.pal"

MapObjectPals::
INCLUDE "gfx/overworld/npc_sprites.pal"

MapObjectPalsPurple::
INCLUDE "gfx/overworld/npc_sprites_purple.pal"

BetaPokerPals:
INCLUDE "gfx/beta_poker/beta_poker.pal"

SlotMachinePals:
INCLUDE "gfx/slots/slots.pal"

RoofPals:
	table_width PAL_COLOR_SIZE * 2 * 2, RoofPals
INCLUDE "gfx/tilesets/roofs.pal"
	assert_table_length NUM_MAP_GROUPS + 1

DiplomaPalettes:
INCLUDE "gfx/diploma/diploma.pal"

PartyMenuOBPals:
INCLUDE "gfx/stats/party_menu_ob.pal"

UnusedBattleObjectPals: ; unreferenced
INCLUDE "gfx/battle_anims/unused_battle_anims.pal"

UnusedGSTitleBGPals:
INCLUDE "gfx/title/unused_gs_bg.pal"

UnusedGSTitleOBPals:
INCLUDE "gfx/title/unused_gs_fg.pal"

MalePokegearPals:
INCLUDE "gfx/pokegear/pokegear.pal"

FemalePokegearPals:
INCLUDE "gfx/pokegear/pokegear_f.pal"