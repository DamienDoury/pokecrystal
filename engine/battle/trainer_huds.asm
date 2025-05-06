BattleStart_TrainerHuds:
	ld a, $e4
	ldh [rOBP0], a
	call ShowPlayerMonsRemaining
	ld a, [wBattleMode]
	dec a
	ret z
	call DrawEnemyHUDBorder
	jp ShowOTTrainerMonsRemaining

EnemySwitch_TrainerHud:
	ld a, $e4
	ldh [rOBP0], a
	call DrawEnemyHUDBorder
	jp ShowOTTrainerMonsRemaining

ShowPlayerMonsRemaining:
	call DrawPlayerPartyIconHUDBorder
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call StageBallTilesData
	ld a, 11
	ld hl, wPlaceBallsX
	ld [hli], a
	ld [hl], 10 ; wPlaceBallsY
	ld a, 1
	ld [wPlaceBallsDirection], a
	jp LoadTrainerHudOAM

ShowOTTrainerMonsRemaining::
	ld a, [wBattleMode]
	dec a
	ret z

	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 8
	ld [hli], a
	ld [hl], 3
	ld a, -1
	ld [wPlaceBallsDirection], a
	jp LoadTrainerHudOAM

StageBallTilesData:
	ld a, [de]
	push af
	ld de, wBattleHUDTiles
	ld c, PARTY_LENGTH
	ld a, $71 ; empty slot
.loop1
	ld [de], a
	inc de
	dec c
	jr nz, .loop1
	pop af

	ld de, wBattleHUDTiles
.loop2
	push af
	call .GetHUDTile
	inc de
	pop af
	dec a
	jr nz, .loop2
	ret

.GetHUDTile:
	ld a, [hli]
	and a
	jr nz, .got_hp
	ld a, [hl]
	and a
	ld b, $70 ; fainted
	jr z, .fainted

.got_hp
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	and a
	ld b, $5f ; statused
	jr nz, .load
	dec b ; $5e -> normal
	jr .load

.fainted
	dec hl
	dec hl
	dec hl

.load
	ld a, b
	ld [de], a
	ld bc, PARTYMON_STRUCT_LENGTH + MON_HP - MON_STATUS
	add hl, bc
	ret

DrawPlayerHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 18, 10
	ld de, -1 ; start on right
	jr PlaceHUDBorderTiles

.tiles
	db $73 ; right side
	db $77 ; bottom right
	db $6f ; bottom left
	db $76 ; bottom side
.tiles_end

DrawPlayerPartyIconHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 18, 10
	ld de, -1 ; start on right
	jr PlaceHUDBorderTiles

.tiles
	db $73 ; right side
	db $5c ; bottom right
	db $6f ; bottom left
	db $76 ; bottom side
.tiles_end

DrawEnemyHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 1, 3
	ld de, 1 ; start on left
	jr PlaceHUDBorderTiles

.tiles
	db $6d ; left side
	db $74 ; bottom left
	db $78 ; bottom right
	db $76 ; bottom side
.tiles_end

DrawEnemyHUDCaptureIcon:
	ld a, [wBattleMode]
	dec a
	ret nz
	
	ld a, [wTempEnemyMonSpecies]
	dec a
	call CheckCaughtMon
	ret z
	
	hlcoord 0, 0
	ld [hl], $5d
	ret

PlaceHUDBorderTiles:
	ld a, [wTrainerHUDTiles + 0]
	ld [hl], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld a, [wTrainerHUDTiles + 1]
	ld [hl], a
	ld b, 8
.loop
	add hl, de
	ld a, [wTrainerHUDTiles + 3]
	ld [hl], a
	dec b
	jr nz, .loop
	add hl, de
	ld a, [wTrainerHUDTiles + 2]
	ld [hl], a
	ret

LinkBattle_TrainerHuds:
	call LoadBallIconGFX
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 9
	ld [hli], a
	ld [hl], 6
	ld a, 1
	ld [wPlaceBallsDirection], a
	call LoadTrainerHudOAM

	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 9
	ld [hli], a
	ld [hl], 11
	; fallthrough

LoadTrainerHudOAM:
	ld a, [wPlaceBallsY]
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld a, [wPlaceBallsX]
	ld c, a
	ld b, 0
	add hl, bc ; hlcoord = [wPlaceBallsX], [wPlaceBallsY]
	ld de, wBattleHUDTiles
	ld c, PARTY_LENGTH
	ld a, [wPlaceBallsDirection]
	cp 1
	jr z, .loop_left_to_right
.loop_right_to_left
	ld a, [de]
	ld [hld], a ; tile id
	inc de
	dec c
	jr nz, .loop_right_to_left
	ret

.loop_left_to_right
	ld a, [de]
	ld [hli], a ; tile id
	inc de
	dec c
	jr nz, .loop_left_to_right
	ret

LoadBallIconGFX:
	ld de, .gfx
	ld hl, vTiles2 tile $5e
	lb bc, BANK(LoadBallIconGFX), 2
	call Get2bppViaHDMA

	ld de, .gfx + 2 * 8 * 8 / 4
	ld hl, vTiles2 tile $70
	lb bc, BANK(LoadBallIconGFX), 2
	jp Get2bppViaHDMA

.gfx
INCBIN "gfx/battle/balls.2bpp"

_ShowLinkBattleParticipants:
	call ClearBGPalettes
	call LoadFontsExtra
	hlcoord 2, 3
	ld b, 9
	ld c, 14
	call Textbox
	hlcoord 4, 5
	ld de, wPlayerName
	call PlaceString
	hlcoord 4, 10
	ld de, wOTPlayerName
	call PlaceString
	hlcoord 9, 8
	ld a, "<BOLD_V>"
	ld [hli], a
	ld [hl], "<BOLD_S>"
	call LinkBattle_TrainerHuds
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes
	ld a, $e4
	ldh [rOBP0], a
	ret
