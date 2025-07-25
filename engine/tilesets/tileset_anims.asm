_AnimateTileset::
; Increment [hTileAnimFrame] and run that frame's function
; from the array pointed to by wTilesetAnim.

; Called in WRAM bank 1, VRAM bank 0, so map tiles
; $80 and above in VRAM bank 1 cannot be animated
; without switching to that bank themselves.

	ld a, [wTilesetAnim]
	ld e, a
	ld a, [wTilesetAnim + 1]
	ld d, a

	ldh a, [hTileAnimFrame]
	ld l, a
	inc a
	ldh [hTileAnimFrame], a

	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de

; 2-byte parameter
; All functions take input de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; Function address
	ld a, [hli]
	ld h, [hl]
	ld l, a

	jp hl

Tileset0Anim:
TilesetJohtoModernAnim:
TilesetKantoAnim:
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateWaterPalette
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetKantoWavesAnim:
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateWaterPalette
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateShoreWaves
	dw NULL,  StandingTileFrame
	dw NULL,  DoneTileAnimation

TilesetParkAnim:
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw vTiles2 tile $5f, AnimateFountainTile
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateWaterPalette
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetForestAnim:
	dw NULL,  ForestTreeLeftAnimation
	dw NULL,  ForestTreeRightAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  ForestTreeLeftAnimation2
	dw NULL,  ForestTreeRightAnimation2
	dw NULL,  AnimateFlowerTile
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  AnimateWaterPalette
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetJohtoAnim:
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateWaterPalette
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw WhirlpoolFrames1, AnimateWhirlpoolTile
	dw WhirlpoolFrames2, AnimateWhirlpoolTile
	dw WhirlpoolFrames3, AnimateWhirlpoolTile
	dw WhirlpoolFrames4, AnimateWhirlpoolTile
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetPortAnim:
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateWaterPalette
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetEliteFourRoomAnim:
	dw NULL,  AnimateLavaBubbleTile2
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateLavaBubbleTile1
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetCaveAnim:
TilesetDarkCaveAnim:
	dw NULL,  AnimateLavaBubbleTile2
	dw vTiles2 tile $14, ReadTileToAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  AnimateLavaBubbleTile1
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $14, WriteTileFromAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  AnimateWaterPalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $40, ReadTileToAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $40, WriteTileFromAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetIcePathAnim:
	dw vTiles2 tile $35, ReadTileToAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $35, WriteTileFromAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  AnimateWaterPalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, ReadTileToAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, WriteTileFromAnimBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetTowerAnim:
	dw TowerPillarTilePointer9, AnimateTowerPillarTile
	dw TowerPillarTilePointer10, AnimateTowerPillarTile
	dw TowerPillarTilePointer7, AnimateTowerPillarTile
	dw TowerPillarTilePointer8, AnimateTowerPillarTile
	dw TowerPillarTilePointer5, AnimateTowerPillarTile
	dw TowerPillarTilePointer6, AnimateTowerPillarTile
	dw TowerPillarTilePointer3, AnimateTowerPillarTile
	dw TowerPillarTilePointer4, AnimateTowerPillarTile
	dw TowerPillarTilePointer1, AnimateTowerPillarTile
	dw TowerPillarTilePointer2, AnimateTowerPillarTile
	dw NULL,  StandingTileFrame
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation

TilesetPlayersRoomAnim:
	dw PlayersRoomTVFrames1,  AnimateHouseTVTile
	dw PlayersRoomTVFrames2,  AnimateHouseTVTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetPlayersHouseAnim:
	dw PlayersHouseTVFrames1,  AnimateHouseTVTile
	dw PlayersHouseTVFrames2,  AnimateHouseTVTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetHouseAnim:
	dw HouseTVFrames1,  AnimateHouseTVTile
	dw HouseTVFrames2,  AnimateHouseTVTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetBattleTowerOutsideAnim:
TilesetPokecenterAnim:
TilesetGateAnim:
TilesetLabAnim:
TilesetFacilityAnim:
TilesetMartAnim:
TilesetMartRushedAnim:
TilesetMansionAnim:
TilesetGameCornerAnim:
TilesetTraditionalHouseAnim:
TilesetTrainStationAnim:
TilesetChampionsRoomAnim:
TilesetLighthouseAnim:
TilesetPokeComCenterAnim:
TilesetBattleTowerInsideAnim:
TilesetRuinsOfAlphAnim:
TilesetRadioTowerAnim:
TilesetUndergroundAnim:
TilesetBetaWordRoomAnim:
TilesetHoOhWordRoomAnim:
TilesetKabutoWordRoomAnim:
TilesetOmanyteWordRoomAnim:
TilesetAerodactylWordRoomAnim:
TilesetHospitalAnim:
TilesetMuseumAnim:
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation

TilesetJohtoWavesAnim:
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateWaterPalette
	dw NULL,  AnimateFlowerTile
	dw WhirlpoolFrames1, AnimateWhirlpoolTile
	dw WhirlpoolFrames2, AnimateWhirlpoolTile
	dw WhirlpoolFrames3, AnimateWhirlpoolTile
	dw WhirlpoolFrames4, AnimateWhirlpoolTile
	dw NULL,  AnimateShoreWaves
	dw NULL,  StandingTileFrame
	dw NULL,  DoneTileAnimation

DoneTileAnimation:
; Reset the animation command loop.
	xor a
	ldh [hTileAnimFrame], a

WaitTileAnimation:
; Do nothing this frame.
	ret

StandingTileFrame8:
; Tick the wTileAnimationTimer, wrapping from 7 to 0.
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	ret

ScrollTileRightLeft:
; Scroll right for 4 ticks, then left for 4 ticks.
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	and %100
	jr nz, ScrollTileLeft
	jr ScrollTileRight

ScrollTileUpDown: ; unreferenced
; Scroll up for 4 ticks, then down for 4 ticks.
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	and %100
	jr nz, ScrollTileDown
	jr ScrollTileUp

ScrollTileLeft:
	ld h, d
	ld l, e
	ld c, LEN_2BPP_TILE / 4
.loop
rept 4
	ld a, [hl]
	rlca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

ScrollTileRight:
	ld h, d
	ld l, e
	ld c, LEN_2BPP_TILE / 4
.loop
rept 4
	ld a, [hl]
	rrca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

ScrollTileUp:
	ld h, d
	ld l, e
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld bc, LEN_2BPP_TILE - 2
	add hl, bc
	ld a, LEN_2BPP_TILE / 4
.loop
	ld c, [hl]
	ld [hl], e
	dec hl
	ld b, [hl]
	ld [hl], d
	dec hl
	ld e, [hl]
	ld [hl], c
	dec hl
	ld d, [hl]
	ld [hl], b
	dec hl
	dec a
	jr nz, .loop
	ret

ScrollTileDown:
	ld h, d
	ld l, e
	ld de, LEN_2BPP_TILE - 2
	push hl
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop hl
	ld a, LEN_2BPP_TILE / 4
.loop
	ld b, [hl]
	ld [hl], d
	inc hl
	ld c, [hl]
	ld [hl], e
	inc hl
	ld d, [hl]
	ld [hl], b
	inc hl
	ld e, [hl]
	ld [hl], c
	inc hl
	dec a
	jr nz, .loop
	ret

AnimateFountainTile:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

	ld hl, .FountainTileFramePointers

; A cycle of 8 frames, updating every tick
	ld a, [wTileAnimationTimer]
	and %111

; hl = [.FountainTileFramePointers + a * 2]
	add a
	add l
	ld l, a
	jr nc, .okay
	inc h
.okay
	ld a, [hli]
	ld h, [hl]
	ld l, a

; Write the tile graphic from hl (now sp) to de (now hl)
	ld sp, hl
	ld l, e
	ld h, d
	jmp WriteTile

.FountainTileFramePointers:
	dw .FountainTile1
	dw .FountainTile2
	dw .FountainTile3
	dw .FountainTile4
	dw .FountainTile3
	dw .FountainTile4
	dw .FountainTile5
	dw .FountainTile1

.FountainTile1: INCBIN "gfx/tilesets/fountain/1.2bpp"
.FountainTile2: INCBIN "gfx/tilesets/fountain/2.2bpp"
.FountainTile3: INCBIN "gfx/tilesets/fountain/3.2bpp"
.FountainTile4: INCBIN "gfx/tilesets/fountain/4.2bpp"
.FountainTile5: INCBIN "gfx/tilesets/fountain/5.2bpp"

AnimateWaterTile:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 4 frames, updating every other tick
	ld a, [wTileAnimationTimer]
	and %110

; hl = .WaterTileFrames + a * 8
; (a was pre-multiplied by 2 from 'and %110')
	add a
	add a
	add a
	add LOW(.WaterTileFrames)
	ld l, a
	ld a, 0
	adc HIGH(.WaterTileFrames)
	ld h, a

; Write the tile graphic from hl (now sp) to de (now hl)
	ld sp, hl
	ld l, e
	ld h, d
	jmp WriteTile

.WaterTileFrames:
	INCBIN "gfx/tilesets/water/water.2bpp"

ForestTreeLeftAnimation:
; Only animate this during the Celebi event.
	ld a, [wMapGroup]
	cp GROUP_ILEX_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_ILEX_FOREST
	ret nz

	ld a, [wPokegearFlags]
	bit CELEBIEVENT_FOREST_IS_RESTLESS_F, a
	ret z

; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

.do_animation
; A cycle of 2 frames, updating every tick
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame

; hl = ForestTreeLeftFrames + a * 8
; (a was pre-multiplied by 2 from GetForestTreeFrame)
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	ld a, 0
	adc HIGH(ForestTreeLeftFrames)
	ld h, a

.got_frames
; Write the tile graphic from hl (now sp) to tile $0c (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $0c
	jmp WriteTile

ForestTreeLeftFrames:
	INCBIN "gfx/tilesets/forest-tree/1.2bpp"
	INCBIN "gfx/tilesets/forest-tree/2.2bpp"

ForestTreeRightFrames:
	INCBIN "gfx/tilesets/forest-tree/3.2bpp"
	INCBIN "gfx/tilesets/forest-tree/4.2bpp"

ForestTreeRightAnimation:
; Only animate this during the Celebi event and Viridian Forest event.
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	jr nz, .check_ilex

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	jr nz, .check_ilex

	ld b, CHECK_FLAG
	ld de, EVENT_VIRIDIAN_FOREST_GUY_SAVED
	call EventFlagAction
	ld a, c
	and a
	jp nz, .do_animation

.check_ilex
	ld a, [wMapGroup]
	cp GROUP_ILEX_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_ILEX_FOREST
	ret nz

	ld a, [wPokegearFlags]
	bit CELEBIEVENT_FOREST_IS_RESTLESS_F, a
	ret z

; Save the stack pointer in bc for WriteTile to restore
.do_animation
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 2 frames, updating every tick
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame

; hl = ForestTreeRightFrames + a * 8
; (a was pre-multiplied by 2 from GetForestTreeFrame)
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	ld a, 0
	adc HIGH(ForestTreeLeftFrames)
	ld h, a
	push bc
	ld bc, ForestTreeRightFrames - ForestTreeLeftFrames
	add hl, bc
	pop bc

.got_frames
; Write the tile graphic from hl (now sp) to tile $0f (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $0f
	jmp WriteTile

ForestTreeLeftAnimation2:
; Only animate this during the Celebi event and Viridian Forest event.
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	jr nz, .check_ilex

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	jr nz, .check_ilex

	ld b, CHECK_FLAG
	ld de, EVENT_VIRIDIAN_FOREST_GUY_SAVED
	call EventFlagAction
	ld a, c
	and a
	jp nz, .do_animation

.check_ilex
	ld a, [wMapGroup]
	cp GROUP_ILEX_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_ILEX_FOREST
	ret nz

	ld a, [wPokegearFlags]
	bit CELEBIEVENT_FOREST_IS_RESTLESS_F, a
	ret z

; Save the stack pointer in bc for WriteTile to restore
.do_animation
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 2 frames, updating every tick
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame

; Offset by 1 frame from ForestTreeLeftAnimation
	xor %10

; hl = ForestTreeLeftFrames + a * 8
; (a was pre-multiplied by 2 from GetForestTreeFrame)
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	ld a, 0
	adc HIGH(ForestTreeLeftFrames)
	ld h, a

.got_frames
; Write the tile graphic from hl (now sp) to tile $0c (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $0c
	jmp WriteTile

ForestTreeRightAnimation2:
; Only animate this during the Celebi event.
	ld a, [wMapGroup]
	cp GROUP_ILEX_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_ILEX_FOREST
	ret nz

	ld a, [wPokegearFlags]
	bit CELEBIEVENT_FOREST_IS_RESTLESS_F, a
	ret z

; Save the stack pointer in bc for WriteTile to restore
.do_animation
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 2 frames, updating every tick
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame

; Offset by 1 frame from ForestTreeRightAnimation
	xor %10

; hl = ForestTreeRightFrames + a * 8
; (a was pre-multiplied by 2 from GetForestTreeFrame)
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	ld a, 0
	adc HIGH(ForestTreeLeftFrames)
	ld h, a
	push bc
	ld bc, ForestTreeRightFrames - ForestTreeLeftFrames
	add hl, bc
	pop bc

.got_frames
; Write the tile graphic from hl (now sp) to tile $0f (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $0f
	jmp WriteTile

GetForestTreeFrame:
; Return 0 if a is even, or 2 if odd.
	and 1
	add a
	ret

AnimateFlowerTile:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 2 frames, updating every other tick
	ld a, [wTileAnimationTimer]
	and %10

; CGB has different tile graphics for flowers
	ld e, a
	ldh a, [hCGB]
	and 1
	add e

; hl = .FlowerTileFrames + a * 16
	swap a
	ld e, a
	ld d, 0
	ld hl, .FlowerTileFrames
	add hl, de

; Write the tile graphic from hl (now sp) to tile $03 (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $03
	jmp WriteTile

.FlowerTileFrames:
	INCBIN "gfx/tilesets/flower/dmg_1.2bpp"
	INCBIN "gfx/tilesets/flower/cgb_1.2bpp"
	INCBIN "gfx/tilesets/flower/dmg_2.2bpp"
	INCBIN "gfx/tilesets/flower/cgb_2.2bpp"


AnimateShoreWaves:
	; A cycle of 8 frames, updating every other tick
	ld a, [wTileAnimationTimer]
	bit 0, a
	ret nz

	and %1110 ; Every other frame as bit0 is ignored.

	ld c, a
	ld b, 0
	ld hl, .ShoreWavesOffsets
	add hl, bc

	ld e, [hl]
	inc hl
	ld d, [hl]

	ld hl, TilesetShoreWavesFrames
	add hl, de

	ld a, h
	ldh [rHDMA1], a ; https://gbdev.io/pandocs/CGB_Registers.html?lcd-vram-dma-transfers#lcd-vram-dma-transfers
	ld a, l
	ldh [rHDMA2], a

	ld hl, vTiles2 tile $22
	ld a, h
	ldh [rHDMA3], a
	ld a, l
	ldh [rHDMA4], a

	ld a, WAVE_TILES_AMOUNT - 1
	ldh [rHDMA5], a
	ret

.ShoreWavesOffsets:
	dw 0
	dw 192
	dw 384
	dw 576
	dw 768
	dw 960
	dw 1152
	dw 1344

AnimateHouseTVTile:
; Input de points to the destination in VRAM, then the source tile frames

; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; de = the destination in VRAM
	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; A cycle of 4 frames, updating every tick
	ld a, [wTileAnimationTimer]
	and %001

; hl = the source tile frames + a * 16
	swap a
	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0
	adc h
	ld h, a

; Write the tile graphic from hl (now sp) to de (now hl)
	ld sp, hl
	ld l, e
	ld h, d
	jmp WriteTile

AnimateLavaBubbleTile1:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 4 frames, updating every other tick
	ld a, [wTileAnimationTimer]
	and %110

; Offset by 2 frames from AnimateLavaBubbleTile2
	srl a
	inc a
	inc a
	and %011

; hl = LavaBubbleTileFrames + a * 16
	swap a
	ld e, a
	ld d, 0
	ld hl, LavaBubbleTileFrames
	add hl, de

; Write the tile graphic from hl (now sp) to tile $5b (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $5b
	jmp WriteTile

AnimateLavaBubbleTile2:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 4 frames, updating every other tick
	ld a, [wTileAnimationTimer]
	and %110

; hl = LavaBubbleTileFrames + a * 8
; (a was pre-multiplied by 2 from 'and %110')
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, LavaBubbleTileFrames
	add hl, de

; Write the tile graphic from hl (now sp) to tile $38 (now hl)
	ld sp, hl
	ld hl, vTiles2 tile $38
	jmp WriteTile

LavaBubbleTileFrames:
	INCBIN "gfx/tilesets/lava/1.2bpp"
	INCBIN "gfx/tilesets/lava/2.2bpp"
	INCBIN "gfx/tilesets/lava/3.2bpp"
	INCBIN "gfx/tilesets/lava/4.2bpp"

AnimateTowerPillarTile:
; Input de points to the destination in VRAM, then the source tile frames

; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; A cycle of 8 frames, updating every tick
	ld a, [wTileAnimationTimer]
	and %111

; a = [.TowerPillarTileFrameOffsets + a]
	ld hl, .TowerPillarTileFrameOffsets
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]

; de = the destination in VRAM
	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; hl = the source tile frames + offset a
	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0
	adc h
	ld h, a

; Write the tile graphic from hl (now sp) to de (now hl)
	ld sp, hl
	ld l, e
	ld h, d
	jr WriteTile

.TowerPillarTileFrameOffsets:
	db 0 tiles
	db 1 tiles
	db 2 tiles
	db 3 tiles
	db 4 tiles
	db 3 tiles
	db 2 tiles
	db 1 tiles

StandingTileFrame:
; Tick the wTileAnimationTimer.
	ld hl, wTileAnimationTimer
	inc [hl]
	ret

AnimateWhirlpoolTile:
; Input de points to the destination in VRAM, then the source tile frames

; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; de = the destination in VRAM
	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; A cycle of 4 frames, updating every tick
	ld a, [wTileAnimationTimer]
	and %11

; hl = the source tile frames + a * 16
	swap a
	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0
	adc h
	ld h, a

; Write the tile graphic from hl (now sp) to de (now hl)
	ld sp, hl
	ld l, e
	ld h, d
	jr WriteTile

WriteTileFromAnimBuffer:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; Write the tile graphic from wTileAnimBuffer (now sp) to de (now hl)
	ld hl, wTileAnimBuffer
	ld sp, hl
	ld h, d
	ld l, e
	jr WriteTile

ReadTileToAnimBuffer:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; Write the tile graphic from de (now sp) to wTileAnimBuffer (now hl)
	ld h, d
	ld l, e
	ld sp, hl
	ld hl, wTileAnimBuffer
	; fallthrough

WriteTile:
; Write one tile from sp to hl.
; The stack pointer has been saved in bc.

; This function cannot be called, only jumped to,
; because it relocates the stack pointer to quickly
; copy data with a "pop slide".

	ld a, LEN_2BPP_TILE / 2
	dec hl

.loop
	pop de
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d

	dec a
	jr nz, .loop

; Restore the stack pointer from bc
	ld h, b
	ld l, c
	ld sp, hl
	ret

AnimateWaterPalette:
; Transition between color values 0-2 for color 0 in palette 3.

; Don't update the palette on DMG
	ldh a, [hCGB]
	and a
	ret z

; Don't update a non-standard palette order
	ldh a, [rBGP]
	cp %11100100
	ret nz

; Only update on even ticks
	ld a, [wTileAnimationTimer]
	ld l, a
	and 1 ; odd
	ret nz

; Ready for BGPD input
	ld a, (1 << rBGPI_AUTO_INCREMENT) palette PAL_BG_WATER
	ldh [rBGPI], a

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

; A cycle of 4 colors (0 1 2 1), updating every other tick
	ld a, l
	and %110
	jr z, .color0
	cp %100
	jr z, .color2

; color1
	ld hl, wBGPals1 palette PAL_BG_WATER color 1
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	jr .end

.color0
	ld hl, wBGPals1 palette PAL_BG_WATER color 0
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	jr .end

.color2
	ld hl, wBGPals1 palette PAL_BG_WATER color 2
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a

.end
	pop af
	ldh [rSVBK], a
	ret

FlickeringCaveEntrancePalette:
; Don't update the palette on DMG
	ldh a, [hCGB]
	and a
	ret z

; Don't update a non-standard palette order
	ldh a, [rBGP]
	cp %11100100
	ret nz

; We only want to be here if we're in a dark cave.
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	ret nz

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

; Ready for BGPD input
	ld a, (1 << rBGPI_AUTO_INCREMENT) palette PAL_BG_YELLOW
	ldh [rBGPI], a

; A cycle of 2 colors (0 2), updating every other vblank
	ldh a, [hVBlankCounter]
	and %10
	jr nz, .color1

; color0
	ld hl, wBGPals1 palette PAL_BG_YELLOW color 0
	jr .okay

.color1
	ld hl, wBGPals1 palette PAL_BG_YELLOW color 1

.okay
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a

	pop af
	ldh [rSVBK], a
	ret

TowerPillarTilePointer1:  dw vTiles2 tile $2d, TowerPillarTile1
TowerPillarTilePointer2:  dw vTiles2 tile $2f, TowerPillarTile2
TowerPillarTilePointer3:  dw vTiles2 tile $3d, TowerPillarTile3
TowerPillarTilePointer4:  dw vTiles2 tile $3f, TowerPillarTile4
TowerPillarTilePointer5:  dw vTiles2 tile $3c, TowerPillarTile5
TowerPillarTilePointer6:  dw vTiles2 tile $2c, TowerPillarTile6
TowerPillarTilePointer7:  dw vTiles2 tile $4d, TowerPillarTile7
TowerPillarTilePointer8:  dw vTiles2 tile $4f, TowerPillarTile8
TowerPillarTilePointer9:  dw vTiles2 tile $5d, TowerPillarTile9
TowerPillarTilePointer10: dw vTiles2 tile $5f, TowerPillarTile10

TowerPillarTile1:  INCBIN "gfx/tilesets/tower-pillar/1.2bpp"
TowerPillarTile2:  INCBIN "gfx/tilesets/tower-pillar/2.2bpp"
TowerPillarTile3:  INCBIN "gfx/tilesets/tower-pillar/3.2bpp"
TowerPillarTile4:  INCBIN "gfx/tilesets/tower-pillar/4.2bpp"
TowerPillarTile5:  INCBIN "gfx/tilesets/tower-pillar/5.2bpp"
TowerPillarTile6:  INCBIN "gfx/tilesets/tower-pillar/6.2bpp"
TowerPillarTile7:  INCBIN "gfx/tilesets/tower-pillar/7.2bpp"
TowerPillarTile8:  INCBIN "gfx/tilesets/tower-pillar/8.2bpp"
TowerPillarTile9:  INCBIN "gfx/tilesets/tower-pillar/9.2bpp"
TowerPillarTile10: INCBIN "gfx/tilesets/tower-pillar/10.2bpp"

WhirlpoolFrames1: dw vTiles2 tile $32, WhirlpoolTiles1
WhirlpoolFrames2: dw vTiles2 tile $33, WhirlpoolTiles2
WhirlpoolFrames3: dw vTiles2 tile $42, WhirlpoolTiles3
WhirlpoolFrames4: dw vTiles2 tile $43, WhirlpoolTiles4

WhirlpoolTiles1: INCBIN "gfx/tilesets/whirlpool/1.2bpp"
WhirlpoolTiles2: INCBIN "gfx/tilesets/whirlpool/2.2bpp"
WhirlpoolTiles3: INCBIN "gfx/tilesets/whirlpool/3.2bpp"
WhirlpoolTiles4: INCBIN "gfx/tilesets/whirlpool/4.2bpp"

HouseTVFrames1: dw vTiles2 tile $16, HouseTVTiles1
HouseTVFrames2: dw vTiles2 tile $17, HouseTVTiles2

HouseTVTiles1: INCBIN "gfx/tilesets/house-tv/bottom-left.2bpp"
HouseTVTiles2: INCBIN "gfx/tilesets/house-tv/bottom-right.2bpp"

PlayersHouseTVFrames1: dw vTiles2 tile $16, PlayersHouseTVTiles1
PlayersHouseTVFrames2: dw vTiles2 tile $17, PlayersHouseTVTiles2

PlayersHouseTVTiles1: INCBIN "gfx/tilesets/players-house-tv/bottom-left.2bpp"
PlayersHouseTVTiles2: INCBIN "gfx/tilesets/players-house-tv/bottom-right.2bpp"

PlayersRoomTVFrames1: dw vTiles2 tile $4b, PlayersRoomTVTiles1
PlayersRoomTVFrames2: dw vTiles2 tile $4c, PlayersRoomTVTiles2

PlayersRoomTVTiles1: INCBIN "gfx/tilesets/players-house-tv/bottom-left.2bpp"
PlayersRoomTVTiles2: INCBIN "gfx/tilesets/players-house-tv/bottom-right.2bpp"