EnvironmentColorsPointers:
; entries correspond to environment constants (see constants/map_data_constants.asm)
	table_width 2, EnvironmentColorsPointers
	dw .OutdoorColors ; unused
	dw .OutdoorColors ; TOWN
	dw .OutdoorColors ; ROUTE
	dw .IndoorColors  ; INDOOR
	dw .DungeonColors ; CAVE
	dw .Env5Colors    ; ENVIRONMENT_5
	dw .IndoorColors  ; GATE
	dw .DungeonColors ; DUNGEON
	assert_table_length NUM_ENVIRONMENTS + 1

; Valid indices: $00 - $29 (see gfx/tilesets/bg_tiles.pal)
.OutdoorColors:
.DungeonColors:
.Env5Colors:
	db $00, $01, $02, $03, $04, $05, $06, $07 ; morn
	db $08, $09, $0a, $0b, $0c, $0d, $0e, $07 ; day
	db $0f, $10, $11, $12, $13, $14, $15, $07 ; nite
	db $16, $16, $16, $16, $17, $16, $16, $07 ; dark

.IndoorColors:
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $07 ; morn
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $07 ; day
	db $0f, $10, $11, $12, $13, $14, $15, $07 ; nite
	db $16, $16, $16, $16, $17, $16, $16, $07 ; dark
