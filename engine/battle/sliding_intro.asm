BattleIntroSlidingPics:
	ld a, WARTORTLE
	ld [wCurPartySpecies], a
	ld de, vTiles2
	predef GetAnimatedFrontpic
	;xor a
	;ld [wTrainerClass], a
	;ldh [hGraphicStartTile], a
	;hlcoord 12, 0
	;lb bc, 7, 7
	;predef PlaceGraphic

	ldh a, [rSVBK]
	push af
	ld a, BANK(wLYOverrides)
	ldh [rSVBK], a
	call .subfunction1
	
	;_GetFrontpic
	xor a
	ldh [hBGMapMode], a
	
.loop
	ld [wTileAnimationTimer], a
	add a
	ld c, a
	ld b, 0
	ld hl, EspeonRotatingFrames
	add hl, bc
	ld a, BANK(EspeonRotatingFrames)
	call GetFarWord
	ld b, BANK(EspeonRotatingFrames)
	ld de, vTiles2 tile $00
	ld c, 8 * 6
	predef DecompressGet2bpp

	;ld hl, wDecompressScratch
	;ld a, h
	;ldh [rHDMA1], a ; https://gbdev.io/pandocs/CGB_Registers.html?lcd-vram-dma-transfers#lcd-vram-dma-transfers
	;ld a, l
	;ldh [rHDMA2], a
;
	;ld hl, vTiles2 tile $00
	;ld a, h
	;ldh [rHDMA3], a
	;ld a, l
	;ldh [rHDMA4], a
;
	;ld a, WAVE_TILES_AMOUNT - 1
	;ldh [rHDMA5], a
	;call DelayFrame

	ld a, [wTileAnimationTimer]
	inc a
	cp 36
	jr c, .loop

	xor a
	jr .loop
	ret










	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	call .subfunction2
	xor a
	ldh [hLCDCPointer], a
	pop af
	ldh [rSVBK], a
	ret

.subfunction1
	call .subfunction4
	ld a, $90
	ldh [hSCX], a
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	ret

.subfunction2
	ld d, $90
	ld e, $72
	ld a, $48
	inc a
.loop1
	push af
.loop2
	ldh a, [rLY]
	cp $60
	jr c, .loop2
	ld a, d
	ldh [hSCX], a
	call .subfunction5
	inc e
	inc e
	dec d
	dec d
	pop af
	push af
	cp $1
	jr z, .skip1
	push de
	call .subfunction3
	pop de

.skip1
	call DelayFrame
	pop af
	dec a
	jr nz, .loop1
	ret

.subfunction3
	ld hl, wVirtualOAMSprite00XCoord
	ld c, $12 ; 18
	ld de, SPRITEOAMSTRUCT_LENGTH
.loop3
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop3
	ret

.subfunction4
	ld hl, wLYOverrides
	ld a, $90
	ld bc, SCREEN_HEIGHT_PX
	call ByteFill
	ret

.subfunction5
	ld hl, wLYOverrides
	ld a, d
	ld c, $3e ; 62
.loop4
	ld [hli], a
	dec c
	jr nz, .loop4
	ld a, e
	ld c, $22 ; 34
.loop5
	ld [hli], a
	dec c
	jr nz, .loop5
	xor a
	ld c, $30 ; 48
.loop6
	ld [hli], a
	dec c
	jr nz, .loop6
	ret
