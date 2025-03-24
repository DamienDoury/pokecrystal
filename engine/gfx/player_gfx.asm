MovePlayerPicRight:
	hlcoord 6, 4
	ld de, 1
	jr MovePlayerPic

MovePlayerPicLeft:
	hlcoord 13, 4
	ld de, -1
	; fallthrough

MovePlayerPic:
; Move player pic at hl by de * 7 tiles.
	ld c, $8
.loop
	push bc
	push hl
	push de
	xor a
	ldh [hBGMapMode], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ldh [hBGMapThird], a
	call WaitBGMap
	call DelayFrame
	pop de
	pop hl
	add hl, de
	pop bc
	dec c
	ret z
	push hl
	push bc
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	lb bc, 7, 7
	call ClearBox
	pop bc
	pop hl
	jr .loop

ShowPlayerNamingChoices:
	ld hl, ChrisNameMenuHeader
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_header
	ld hl, KrisNameMenuHeader
.got_header
	call LoadMenuHeader
	call VerticalMenu
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	ret

INCLUDE "data/player_names.asm"

GetPlayerNameArray: ; unreferenced
	ld hl, wPlayerName
	ld de, MalePlayerNameArray
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_array
	ld de, FemalePlayerNameArray
.got_array
	call InitName
	ret

GetPlayerIcon:
	ld de, ChrisSpriteGFX
	ld b, BANK(ChrisSpriteGFX)
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_gfx
	ld de, KrisSpriteGFX
	ld b, BANK(KrisSpriteGFX)
.got_gfx
	ret

GetCardPic:
	; If the player is deep enough into the story and is now wearing a mask, we must display it.
	ld b, CHECK_FLAG
	ld de, EVENT_GOT_FAKE_ID
	call EventFlagAction
	ld a, c
	and a
	jr nz, .fake_id

	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_WEARING_FACE_MASK_F, a
	jr nz, .with_mask

	ld hl, ChrisPicUnmasked
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_pic
	ld hl, KrisPicUnmasked
	jr .got_pic

.fake_id
	ld hl, BurglarIDPic
	ld a, BANK(BurglarIDPic)
	jr .got_pic_and_bank

.with_mask
	ld hl, ChrisPic
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_pic
	ld hl, KrisPic
	
.got_pic
	ld a, BANK(ChrisPic) ; aka BANK(KrisCardPic)
.got_pic_and_bank
	ld de, 112 ; We are using the 7 tiles * 7 tiles pic instead of the default 5*7. So we need to start reading 7 tiles ahead. 7 tiles * 64 pixels / 4 (pixels / byte) = 112.
	add hl, de
	ld de, vTiles2 tile $00
	ld bc, $23 tiles
	call FarCopyBytes

	ld hl, TrainerCardGFX
	ld de, vTiles2 tile $23
	ld bc, 6 tiles
	ld a, BANK(TrainerCardGFX)
	call FarCopyBytes

	ld hl, TrainerCardAdditionsGFX
	ld de, vTiles2 tile $00
	ld bc, 2 tiles
	ld a, BANK(TrainerCardAdditionsGFX)
	call FarCopyBytes
	ret

TrainerCardGFX:
if DEF(_FR_FR)
	INCBIN "gfx/trainer_card/trainer_card_fr.2bpp"
else
	INCBIN "gfx/trainer_card/trainer_card.2bpp"
endc

TrainerCardAdditionsGFX:
	INCBIN "gfx/trainer_card/trainer_card_additions.2bpp"

GetPlayerBackpic:
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, GetChrisBackpic
	call GetKrisBackpic
	ret

GetChrisBackpic:
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_WEARING_FACE_MASK_F, a
	ld hl, ChrisBackpic
	jr nz, .with_mask
	ld hl, ChrisUnmaskedBackpic

.with_mask
	ld b, BANK(ChrisBackpic)
	ld de, vTiles2 tile $31
	ld c, 7 * 7
	predef DecompressGet2bpp
	ret

HOF_LoadTrainerFrontpic:
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a

; Get class
	ld e, CHRIS
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_class
	ld e, KRIS
.got_class
	ld a, e
	ld [wTrainerClass], a

; Load pic
	ld de, ChrisPic
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_pic
	ld de, KrisPic
.got_pic
	ld hl, vTiles2
	ld b, BANK(ChrisPic) ; aka BANK(KrisPic)
	ld c, 7 * 7
	call Get2bpp

	call WaitBGMap
	ld a, $1
	ldh [hBGMapMode], a
	ret

DrawIntroPlayerPic:
; Draw the player pic at (6,4).

; Get class
	ld e, CHRIS
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_class
	ld e, KRIS
.got_class
	ld a, e
	ld [wTrainerClass], a

; Load pic
	ld de, ChrisPicUnmasked
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_pic
	ld de, KrisPicUnmasked

.got_pic
	ld hl, vTiles2
	ld b, BANK(ChrisPicUnmasked) ; aka BANK(KrisPic)
	ld c, 7 * 7 ; dimensions
	call Get2bpp

; Draw
	xor a
	ldh [hGraphicStartTile], a
	hlcoord 6, 4
	lb bc, 7, 7
	predef PlaceGraphic
	ret

ChrisPicUnmasked:
INCBIN "gfx/player/chris_unmasked.2bpp"

ChrisPic:
INCBIN "gfx/player/chris.2bpp"

KrisPicUnmasked:
INCBIN "gfx/player/kris_unmasked.2bpp"

KrisPic:
INCBIN "gfx/player/kris.2bpp"

GetKrisBackpic:
; Kris's backpic is uncompressed.
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_WEARING_FACE_MASK_F, a
	ld de, KrisBackpic
	jr nz, .with_mask
	ld de, KrisUnmaskedBackpic

.with_mask
	ld hl, vTiles2 tile $31
	lb bc, BANK(KrisBackpic), 7 * 7 ; dimensions
	call Get2bpp
	ret

KrisBackpic:
INCBIN "gfx/player/kris_back.2bpp"

KrisUnmaskedBackpic:
INCBIN "gfx/player/kris_back_unmasked.2bpp"
