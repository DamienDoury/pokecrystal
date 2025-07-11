; TrainerCard.Jumptable indexes
	const_def
	const TRAINERCARDSTATE_PAGE1_LOADGFX ; 0
	const TRAINERCARDSTATE_PAGE1_JOYPAD  ; 1
	const TRAINERCARDSTATE_PAGE2_LOADGFX ; 2
	const TRAINERCARDSTATE_PAGE2_JOYPAD  ; 3
	const TRAINERCARDSTATE_PAGE3_LOADGFX ; 4
	const TRAINERCARDSTATE_PAGE3_JOYPAD  ; 5
	const TRAINERCARDSTATE_QUIT          ; 6

TrainerCard:
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .InitRAM
.loop
	call UpdateTime
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .quit
	ldh a, [hJoyLast]
	and B_BUTTON
	jr nz, .quit
	call .RunJumptable
	call DelayFrame
	jr .loop

.quit
	pop af
	ld [wOptions], a
	pop af
	ld [wVramState], a
	ret

.InitRAM:
	call ClearBGPalettes
	call ClearSprites
	call ClearTilemap
	call DisableLCD

	farcall GetCardPic

	ld hl, CardRightCornerGFX
	ld de, vTiles2 tile $1c
	ld bc, 1 tiles
	ld a, BANK(CardRightCornerGFX)
	call FarCopyBytes

	ld hl, CardStatusGFX
	ld de, vTiles2 tile $29
	ld bc, 86 tiles
	ld a, BANK(CardStatusGFX)
	call FarCopyBytes

	call TrainerCard_PrintTopHalfOfCard

	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder

	call EnableLCD
	call WaitBGMap
	ld b, SCGB_TRAINER_CARD
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap
	ld hl, wJumptableIndex
	xor a ; TRAINERCARDSTATE_PAGE1_LOADGFX
	ld [hli], a ; wJumptableIndex
	ld [hli], a ; wTrainerCardBadgeFrameCounter
	ld [hli], a ; wTrainerCardBadgeTileID
	ld [hl], a  ; wTrainerCardBadgeAttributes
	ret

.RunJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
; entries correspond to TRAINERCARDSTATE_* constants
	dw TrainerCard_Page1_LoadGFX
	dw TrainerCard_Page1_Joypad
	dw TrainerCard_Page2_LoadGFX
	dw TrainerCard_Page2_Joypad
	dw TrainerCard_Page3_LoadGFX
	dw TrainerCard_Page3_Joypad
	dw TrainerCard_Quit

TrainerCard_IncrementJumptable:
	ld hl, wJumptableIndex
	inc [hl]
	ret

TrainerCard_Quit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

TrainerCard_Page1_LoadGFX:
	call ClearSprites
	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder
	call WaitBGMap
	ld b, SCGB_TRAINER_CARD
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap
	ld de, CardStatusGFX
	ld hl, vTiles2 tile $29
	lb bc, BANK(CardStatusGFX), 86
	call Request2bpp
	call TrainerCard_Page1_PrintDexCaught_GameTime
	jr TrainerCard_IncrementJumptable

TrainerCard_Page1_Joypad:
	call TrainerCard_Page1_PrintGameTime
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT | A_BUTTON
	jr nz, .pressed_right_a
	ret

.pressed_right_a
	ld a, TRAINERCARDSTATE_PAGE2_LOADGFX
	ld [wJumptableIndex], a
	ret

TrainerCard_Page2_LoadGFX:
	call ClearSprites
	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder
	call WaitBGMap
	ld b, SCGB_TRAINER_CARD
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap
	ld de, LeaderGFX
	ld hl, vTiles2 tile $29
	lb bc, BANK(LeaderGFX), 86
	call Request2bpp
	ld de, BadgeGFX
	ld hl, vTiles0 tile $00
	lb bc, BANK(BadgeGFX), 44
	call Request2bpp
	ld hl, TrainerCard_JohtoBadgesOAM
	call TrainerCard_Page2_3_InitObjectsAndStrings
	jr TrainerCard_IncrementJumptable

TrainerCard_Page2_Joypad:
	ld hl, TrainerCard_JohtoBadgesOAM
	call TrainerCard_Page2_3_AnimateBadges
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, .pressed_left

	ld de, ENGINE_FLYPOINT_VERMILION
	push hl
	farcall CheckEngineFlag ; Returns the result of the check in the carry.
	pop hl
	jr nc, .has_kanto_badges


	ld a, [hl]
	and A_BUTTON
	jr nz, .Quit
	ret

.has_kanto_badges
	ld a, [hl]
	and D_RIGHT | A_BUTTON
	jr nz, .pressed_right_a
	ret

.pressed_left
	ld a, TRAINERCARDSTATE_PAGE1_LOADGFX
	ld [wJumptableIndex], a
	ret

.pressed_right_a
	ld a, TRAINERCARDSTATE_PAGE3_LOADGFX
	ld [wJumptableIndex], a
	ret

.Quit:
	ld a, TRAINERCARDSTATE_QUIT
	ld [wJumptableIndex], a
	ret

TrainerCard_Page3_LoadGFX:
	call ClearSprites
	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder
	call WaitBGMap
	ld b, SCGB_TRAINER_CARD_KANTO
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap
	ld de, LeaderGFX2
	ld hl, vTiles2 tile $29
	lb bc, BANK(LeaderGFX2), 86
	call Request2bpp
	ld de, BadgeGFX2
	ld hl, vTiles0 tile $00
	lb bc, BANK(BadgeGFX2), 44
	call Request2bpp
	ld hl, TrainerCard_KantoBadgesOAM
	call TrainerCard_Page2_3_InitObjectsAndStrings
	jmp TrainerCard_IncrementJumptable

TrainerCard_Page3_Joypad:
	ld hl, TrainerCard_KantoBadgesOAM
	call TrainerCard_Page2_3_AnimateBadges
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, .pressed_left
	ld a, [hl]
	and A_BUTTON
	jr nz, .pressed_a
	ret

.pressed_left
	ld a, TRAINERCARDSTATE_PAGE2_LOADGFX
	ld [wJumptableIndex], a
	ret

.pressed_a
	ld a, TRAINERCARDSTATE_QUIT
	ld [wJumptableIndex], a
	ret

TrainerCard_PrintTopHalfOfCard:
	hlcoord 0, 0
	ld d, 5
	call TrainerCard_InitBorder
	hlcoord 2, 2
	ld de, .Name_Money
	call PlaceString
	hlcoord 2, 4
	ld de, .ID_No
	call TrainerCardSetup_PlaceTilemapString
	
	ld b, CHECK_FLAG
	ld de, EVENT_GOT_FAKE_ID
	call EventFlagAction
	ld a, c
	and a

if DEF(_FR_FR)
	hlcoord 2, 2
else
	hlcoord 7, 2
endc

	jr nz, .fake_id
	
	ld de, wPlayerName
	call PlaceString
	
	hlcoord 5, 4
	ld de, wPlayerID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	jr .name_and_trainer_id_displayed

.fake_id
	ld de, .FakeTrainerName
	call PlaceString

	hlcoord 5, 4
	ld de, .FakeTrainerID
	call PlaceString

.name_and_trainer_id_displayed
	hlcoord 7, 6
	ld de, wMoney
	lb bc, PRINTNUM_MONEY | 3, 6
	call PrintNum
	hlcoord 1, 3
	ld de, .HorizontalDivider
	call TrainerCardSetup_PlaceTilemapString
	
	; Player's picture.
	hlcoord 14, 1
	lb bc, 5, 7
	xor a
	ldh [hGraphicStartTile], a
	predef PlaceGraphic

	; Hiding the first 2 tiles (vertically) of the picture.
	hlcoord 14, 1
	lb bc, 1, 2
	ld a, 5 ; vTiles2 $05 and $06 are blank, no matter if the player is male or female.
	ldh [hGraphicStartTile], a
	predef PlaceGraphic

	; Player's vaccination state display.
	ld b, CHECK_FLAG
	ld de, EVENT_GOT_FAKE_ID
	call EventFlagAction
	jr z, .not_fake_id

	jr .DisplayFirstVaccine
	
.not_fake_id
	ld de, EVENT_PLAYER_VACCINATED_ONCE
	ld b, CHECK_FLAG
	call EventFlagAction
	ret z

	call .DisplayFirstVaccine

	ld de, EVENT_PLAYER_VACCINATED_TWICE
	ld b, CHECK_FLAG
	call EventFlagAction
	ret z

	hlcoord 12, 4
	ld [hl], "<VC>"
	ret

.DisplayFirstVaccine
	hlcoord 13, 4
	ld [hl], "<VC>"
	ret

.FakeTrainerName:
	db FAKE_ID_SELLER_NAME

.FakeTrainerID:
	db "69420@"

.Name_Money:
if DEF(_FR_FR)
	db   ""
	next ""
	next "ARG.@"
else
	db   "NAME/"
	next ""
	next "MONEY@"
endc

.ID_No:
	db $27, $28, -1 ; ID NO

.HorizontalDivider:
	db $25, $25, $25, $25, $25, $25, $25, $25, $25, $25, $25, $25, $26, -1 ; ____________>

TrainerCard_Page1_PrintDexCaught_GameTime:
	ld b, CHECK_FLAG
	ld de, EVENT_GOT_FAKE_ID
	call EventFlagAction
	jr nz, .pokemon_trainer

	ld b, CHECK_FLAG
	ld de, EVENT_RED_BEATEN
	call EventFlagAction
	jr nz, .next_check

	hlcoord 2, 10
	ld de, .UndisputedString
	call PlaceString

	ld de, .MasterUndisputedString
	jr .done_with_trainer_state

.next_check
	ld b, CHECK_FLAG
	ld de, EVENT_BEAT_ELITE_FOUR
	call EventFlagAction
	ld de, .MasterString
	jr nz, .done_with_trainer_state

	ld b, CHECK_FLAG
	ld de, EVENT_GOT_A_POKEMON_FROM_ELM
	call EventFlagAction
.pokemon_trainer
	ld de, .TrainerString
	jr nz, .done_with_trainer_state

	ld de, .SpaceString

.done_with_trainer_state
	hlcoord 2, 11
	call PlaceString

	hlcoord 2, 13
	ld de, .Dex_PlayTime
	call PlaceString

	;hlcoord 10, 15
	;ld de, .Badges
	;call PlaceString
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld [wTempByteValue], a
	ld de, wTempByteValue
	hlcoord 15, 13
	lb bc, 1, 3
	call PrintNum
	
	call TrainerCard_Page1_PrintGameTime
	hlcoord 2, 8
	ld de, .StatusTilemap
	call TrainerCardSetup_PlaceTilemapString
	ld a, [wStatusFlags]
	bit STATUSFLAGS_POKEDEX_F, a
	ret nz
	hlcoord 1, 13
	lb bc, 1, 17
	jmp ClearBox

.Dex_PlayTime:
if DEF(_FR_FR)
	db   "#DEX"
else
	db   "#DEX"
endc

if DEF(_FR_FR)
	next "DUREE JEU@"
else
	next "PLAY TIME@"
endc

.SpaceString:
	db   " @"

.TrainerString:
if DEF(_FR_FR)
	db   "DRESSEUR #MON@"
else
	db   "#MON TRAINER@"
endc

.MasterString:
if DEF(_FR_FR)
	db   "MAITRE #MON@"
else
	db   "LEAGUE CHAMPION@"
endc

.MasterUndisputedString:
if DEF(_FR_FR)
	db   " INCONTESTé@"
else
	db   " LEAGUE CHAMPION@"
endc

.UndisputedString:
if DEF(_FR_FR)
	db   "MAITRE #MON@"
else
	db   "UNDISPUTED@"
endc

.StatusTilemap:
	db $29, $2a, $2b, $2c, $2d, $01, -1

TrainerCard_Page2_3_InitObjectsAndStrings:
	push hl
	hlcoord 1, 8
	
	ld a, [wJumptableIndex]
	cp 2
	ld de, .BadgesTilemap
	jr nz, .display_page

	push de
	ld de, ENGINE_FLYPOINT_VERMILION
	push hl
	farcall CheckEngineFlag ; Returns the result of the check in the carry.
	pop hl
	pop de
	jr c, .display_page

	ld de, .BadgesTilemapKantoBadges

.display_page
	call TrainerCardSetup_PlaceTilemapString
	hlcoord 2, 10
	ld a, $29
	ld c, 4
.loop
	call TrainerCard_Page2_3_PlaceLeadersFaces
rept 4
	inc hl
endr
	dec c
	jr nz, .loop
	hlcoord 2, 13
	ld a, $51
	ld c, 4
.loop2
	call TrainerCard_Page2_3_PlaceLeadersFaces
rept 4
	inc hl
endr
	dec c
	jr nz, .loop2
	xor a
	ld [wTrainerCardBadgeFrameCounter], a
	pop hl
	jmp TrainerCard_Page2_3_OAMUpdate

.BadgesTilemap:
	db $00, $79, $7a, $7b, $7c, $7d, -1 ; "◄BADGES"

.BadgesTilemapKantoBadges:
	db $00, $79, $7a, $7b, $7c, $7d, $01, -1 ; "◄BADGES►"

TrainerCardSetup_PlaceTilemapString:
.loop
	ld a, [de]
	cp -1
	ret z
	ld [hli], a
	inc de
	jr .loop

TrainerCard_InitBorder:
	ld e, SCREEN_WIDTH
.loop1
	ld a, $23
	ld [hli], a
	dec e
	jr nz, .loop1

	ld a, $23
	ld [hli], a

	ld e, SCREEN_WIDTH - 3
	ld a, " "
.loop2
	ld [hli], a
	dec e
	jr nz, .loop2

	; Top-right corner.
	ld a, $1c
	ld [hli], a
	ld a, $23
	ld [hli], a

.loop3
	ld a, $23
	ld [hli], a

	ld e, SCREEN_WIDTH - 2
	ld a, " "
.loop4
	ld [hli], a
	dec e
	jr nz, .loop4

	ld a, $23
	ld [hli], a

	dec d
	jr nz, .loop3

	ld a, $23
	ld [hli], a
	ld a, $24
	ld [hli], a

	ld e, SCREEN_WIDTH - 3
	ld a, " "
.loop5
	ld [hli], a
	dec e
	jr nz, .loop5

	ld a, $23
	ld [hli], a

	ld e, SCREEN_WIDTH
.loop6
	ld a, $23
	ld [hli], a
	dec e
	jr nz, .loop6
	ret

TrainerCard_Page2_3_PlaceLeadersFaces:
	push de
	push hl
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld de, SCREEN_WIDTH - 3
	add hl, de
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld de, SCREEN_WIDTH - 3
	add hl, de
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	pop hl
	pop de
	ret

TrainerCard_Page1_PrintGameTime:
	hlcoord 11, 15
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ldh a, [hVBlankCounter]
	and $1f
	ret nz
	hlcoord 15, 15
	ld a, [hl]
	xor " " ^ $2e ; alternate between space and small colon ($2e) tiles
	ld [hl], a
	ret

TrainerCard_Page2_3_AnimateBadges:
	ldh a, [hVBlankCounter]
	and %111
	ret nz
	ld a, [wTrainerCardBadgeFrameCounter]
	inc a
	and %111
	ld [wTrainerCardBadgeFrameCounter], a
	; fallthrough.

TrainerCard_Page2_3_OAMUpdate:
; copy flag array pointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
; get flag array
	ld d, a
	ld a, [de]
	ld c, a
	ld de, wVirtualOAMSprite00
	ld b, NUM_JOHTO_BADGES
.loop
	srl c
	push bc
	jr nc, .skip_badge
	push hl
	ld a, [hli] ; y
	ld b, a
	ld a, [hli] ; x
	ld c, a
	ld a, h
	ld [wTrainerCardBadgePaletteAddr], a
	ld a, l
	ld [wTrainerCardBadgePaletteAddr + 1], a
rept 4
	inc hl
endr
	ld a, [wTrainerCardBadgeFrameCounter]
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]
	ld [wTrainerCardBadgeTileID], a
	call .PrepOAM
	pop hl
.skip_badge
	ld bc, $e ; 6 + 2 * 4
	add hl, bc
	pop bc
	dec b
	jr nz, .loop
	ret

.PrepOAM:
	ld a, [wTrainerCardBadgeTileID]
	and 1 << 7
	jr nz, .xflip
	ld hl, .facing1
	jr .loop2

.xflip
	ld hl, .facing2
.loop2
	ld a, [hli]
	cp -1
	ret z
	add b
	ld [de], a ; y
	inc de

	ld a, [hli]
	add c
	ld [de], a ; x
	inc de

	ld a, [wTrainerCardBadgeTileID]
	and $ff ^ (1 << 7)
	add [hl]
	ld [de], a ; tile id
	inc hl
	inc de

	push hl
	push bc
	ld a, [wTrainerCardBadgePaletteAddr]
	ld h, a
	ld a, [wTrainerCardBadgePaletteAddr + 1]
	ld l, a
	ld a, [hli]
	ld b, a
	ld a, h
	ld [wTrainerCardBadgePaletteAddr], a
	ld a, l
	ld [wTrainerCardBadgePaletteAddr + 1], a
	ld a, b
	pop bc
	pop hl
	add [hl]
	ld [de], a ; attributes
	inc hl
	inc de
	jr .loop2

.facing1
	dbsprite  0,  0,  0,  0, $00, 0
	dbsprite  1,  0,  0,  0, $01, 0
	dbsprite  0,  1,  0,  0, $02, 0
	dbsprite  1,  1,  0,  0, $03, 0
	db -1

.facing2
	dbsprite  0,  0,  0,  0, $01, 0 | X_FLIP
	dbsprite  1,  0,  0,  0, $00, 0 | X_FLIP
	dbsprite  0,  1,  0,  0, $03, 0 | X_FLIP
	dbsprite  1,  1,  0,  0, $02, 0 | X_FLIP
	db -1

TrainerCard_JohtoBadgesOAM:
; Template OAM data for Johto badges on the trainer card.
; Format:
	; y, x, palette
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw wJohtoBadges

	; Zephyrbadge
	db $68, $18, 0, 0, 0, 0
	db $00, $20, $24, $20 | (1 << 7)
	db $00, $20, $24, $20 | (1 << 7)

	; Hivebadge
	db $68, $38, 1, 1, 1, 1
	db $04, $20, $24, $20 | (1 << 7)
	db $04, $20, $24, $20 | (1 << 7)

	; Plainbadge
	db $68, $58, 2, 2, 2, 2
	db $08, $20, $24, $20 | (1 << 7)
	db $08, $20, $24, $20 | (1 << 7)

	; Fogbadge
	db $68, $78, 3, 3, 3, 3
	db $0c, $20, $24, $20 | (1 << 7)
	db $0c, $20, $24, $20 | (1 << 7)

	; Mineralbadge
	db $80, $38, 4, 4, 4, 4
	db $10, $20, $24, $20 | (1 << 7)
	db $10, $20, $24, $20 | (1 << 7)

	; Stormbadge
	db $80, $18, 5, 5, 5, 5
	db $14, $20, $24, $20 | (1 << 7)
	db $14, $20, $24, $20 | (1 << 7)

	; Glacierbadge
	db $80, $58, 6, 6, 6, 6
	db $18, $20, $24, $20 | (1 << 7)
	db $18, $20, $24, $20 | (1 << 7)

	; Risingbadge
	; X-flips on alternate cycles.
	db $80, $78, 7, 7, 7, 7
	db $1c,            $20, $24, $20 | (1 << 7)
	db $1c | (1 << 7), $20, $24, $20 | (1 << 7)

TrainerCard_KantoBadgesOAM:
   ; Template OAM data for Kanto badges on the trainer card.
   ; Format:
	; y, x, palette
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw wKantoBadges

	; Boulderbadge
	db $68, $18, 0, 0, 0, 0
	db $00, $20 | (1 << 7), $24, $20
	db $00, $20 | (1 << 7), $24, $20

	; Cascadebadge
	db $68, $38, 1, 1, 1, 1
	db $04, $20 | (1 << 7), $24, $20
	db $04, $20 | (1 << 7), $24, $20

	; Thunderbadge
	db $68, $58, 2, 2, 2, 2
	db $08, $20 | (1 << 7), $24, $20
	db $08, $20 | (1 << 7), $24, $20

	; Rainbowbadge
	db $68, $78, 6, 2, 1, 3
	db $0c, $20 | (1 << 7), $24, $20
	db $0c, $20 | (1 << 7), $24, $20

	; Soulbadge
	db $80, $18, 4, 4, 4, 4
	db $10, $20 | (1 << 7), $24, $20
	db $10, $20 | (1 << 7), $24, $20

	; Marshbadge
	db $80, $38, 5, 5, 5, 5
	db $14, $20 | (1 << 7), $24, $20
	db $14, $20 | (1 << 7), $24, $20

	; Volcanobadge
	db $80, $58, 6, 6, 6, 6
	db $18, $20 | (1 << 7), $24, $20
	db $18, $20 | (1 << 7), $24, $20

	; Earthbadge
	; X-flips on alternate cycles.
	db $80, $78, 7, 7, 7, 7
	db $1c,            $20 | (1 << 7), $24, $20
	db $1c | (1 << 7), $20 | (1 << 7), $24, $20

if DEF(_FR_FR)
CardStatusGFX: INCBIN "gfx/trainer_card/card_status_fr.2bpp"
else
CardStatusGFX: INCBIN "gfx/trainer_card/card_status.2bpp"
endc

LeaderGFX:  INCBIN "gfx/trainer_card/johto_leaders.2bpp"
LeaderGFX2: INCBIN "gfx/trainer_card/kanto_leaders.2bpp"
BadgeGFX:   INCBIN "gfx/trainer_card/johto_badges.2bpp"
BadgeGFX2:  INCBIN "gfx/trainer_card/kanto_badges.2bpp"

CardRightCornerGFX: INCBIN "gfx/trainer_card/card_right_corner.2bpp"
