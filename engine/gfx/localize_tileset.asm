if DEF(_FR_FR)
FrenchMartGFX:
INCBIN "gfx/tilesets/localization/_FR_FR/mart.2bpp"

FrenchGymGFX:
INCBIN "gfx/tilesets/localization/_FR_FR/gym.2bpp"

FrenchHospitalGFX:
INCBIN "gfx/tilesets/localization/_FR_FR/hospital.2bpp"



GetMapTileset:
	ld a, BANK(wMapTileset)
	ld hl, wMapTileset
	jp GetFarWRAMByte

; Edits the "MART" and "GYM" tiles in vTiles2.
LocalizeTileset_vTiles2::
	call GetMapTileset
	cp TILESET_JOHTO
	jr z, .johto

	cp TILESET_JOHTO_MODERN
	jr z, .johto

	cp TILESET_JOHTO_WAVES
	jr z, .johto

	cp TILESET_KANTO
	jr z, .kanto

	cp TILESET_KANTO_WAVES
	ret nz

.kanto
	ld hl, FrenchMartGFX
	ld de, vTiles2 + $44 tiles
	ld bc, 2 tiles
	call CopyBytes

	ld hl, FrenchGymGFX
	ld de, vTiles2 + $2f tiles
	ld bc, 1 tiles
	call CopyBytes

	ld hl, FrenchGymGFX + 1 tiles
	ld de, vTiles2 + $3f tiles
	ld bc, 1 tiles
	jp CopyBytes

.johto
	ld hl, FrenchMartGFX
	ld de, vTiles2 + $18 tiles
	ld bc, 2 tiles
	call CopyBytes

	call GetMapTileset
	cp TILESET_JOHTO_WAVES
	ret z

	ld hl, FrenchGymGFX
	ld de, vTiles2 + $23 tiles
	ld bc, 2 tiles
	jp CopyBytes



; Edits the "GYM" and "HOS" tiles in vTiles5.
LocalizeTileset_vTiles5::
	call GetMapTileset
	cp TILESET_JOHTO_MODERN
	jr z, .johto_modern

	cp TILESET_JOHTO_WAVES
	ret nz

;.johto_waves
	ld hl, FrenchGymGFX
	ld de, vTiles5 + $21 tiles
	ld bc, 2 tiles
	jp CopyBytes

.johto_modern
	ld hl, FrenchHospitalGFX
	ld de, vTiles5 + $09 tiles
	ld bc, 2 tiles
	jp CopyBytes
endc
