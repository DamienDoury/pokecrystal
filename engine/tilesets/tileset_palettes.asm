LoadSpecialMapPalette:
	ld a, [wMapTileset]
	cp TILESET_ICE_PATH
	jr z, .ice_path
	cp TILESET_HOUSE
	jr z, .house
	cp TILESET_RADIO_TOWER
	jr z, .radio_tower
	cp TILESET_HOSPITAL
	jr z, .hospital
	cp TILESET_MANSION
	jr z, .mansion_mobile
	jr .do_nothing

.ice_path
	ld a, [wEnvironment]
	and $7
	cp INDOOR ; Hall of Fame
	jr z, .do_nothing
	call LoadIcePathPalette
	scf
	ret

.house
	ld a, [wMapGroup]
	cp GROUP_GOLDENROD_FLOWER_SHOP
	jr nz, .normal_house

	ld a, [wMapNumber]
	cp MAP_GOLDENROD_FLOWER_SHOP
	jr nz, .normal_house

; Goldenrod Flower Shop
	call LoadFlowerShopPalette
	scf
	ret

.normal_house
	call LoadHousePalette
	scf
	ret

.radio_tower
	call LoadRadioTowerPalette
	scf
	ret

.hospital
	call LoadHospitalPalette
	scf
	ret

.mansion_mobile
	ld a, [wMapNumber]
	cp MAP_CELADON_MANSION_ROOF
	ret z

	ld a, [wMapGroup]
	cp GROUP_AKIBA_2F
	ret z
	
	call LoadMansionPalette
	scf
	ret

.do_nothing
	and a
	ret

LoadIcePathPalette:
	ld a, BANK(wBGPals1)
	ld de, wBGPals1
	ld hl, IcePathPalette
	ld bc, 8 palettes
	jmp FarCopyWRAM

IcePathPalette:
INCLUDE "gfx/tilesets/ice_path.pal"

LoadFlowerShopPalette:
	ld a, BANK(wBGPals1)
	ld de, wBGPals1
	ld hl, MansionPalette1 + 2 palettes
	ld bc, 1 palettes
	call FarCopyWRAM

	ld a, BANK(wBGPals1)
	ld de, wBGPals1 + 1 palettes
	ld hl, HousePalette + 1 palettes
	ld bc, 7 palettes
	jmp FarCopyWRAM

LoadHousePalette:
	ld a, BANK(wBGPals1)
	ld de, wBGPals1
	ld hl, HousePalette
	ld bc, 8 palettes
	jmp FarCopyWRAM

HousePalette:
INCLUDE "gfx/tilesets/house.pal"

LoadRadioTowerPalette:
	ld a, BANK(wBGPals1)
	ld de, wBGPals1
	ld hl, RadioTowerPalette
	ld bc, 8 palettes
	jmp FarCopyWRAM

RadioTowerPalette:
INCLUDE "gfx/tilesets/radio_tower.pal"

LoadHospitalPalette:
	ld a, BANK(wBGPals1)
	ld de, wBGPals1
	ld hl, RadioTowerPalette
	ld bc, 8 palettes
	call FarCopyWRAM

	ld a, BANK(wBGPals1)
	ld de, wBGPals1 + 5 palettes
	ld hl, HospitalPriorityBedPalette
	ld bc, 1 palettes
	jmp FarCopyWRAM

HospitalPriorityBedPalette:
	RGB 27, 31, 27
	RGB 27, 31, 27
	RGB 21, 21, 21
	RGB 07, 07, 07

MansionPalette1:
INCLUDE "gfx/tilesets/mansion_1.pal"

LoadMansionPalette:
	ld a, BANK(wBGPals1)
	ld de, wBGPals1
	ld hl, MansionPalette1
	ld bc, 8 palettes
	call FarCopyWRAM
	ld a, BANK(wBGPals1)
	ld de, wBGPals1 palette PAL_BG_YELLOW
	ld hl, MansionPalette2
	ld bc, 1 palettes
	call FarCopyWRAM
	ld a, BANK(wBGPals1)
	ld de, wBGPals1 palette PAL_BG_WATER
	ld hl, MansionPalette1 palette 6
	ld bc, 1 palettes
	call FarCopyWRAM
	ld a, BANK(wBGPals1)
	ld de, wBGPals1 palette PAL_BG_ROOF
	ld hl, MansionPalette1 palette 8
	ld bc, 1 palettes
	jmp FarCopyWRAM

MansionPalette2:
INCLUDE "gfx/tilesets/mansion_2.pal"
