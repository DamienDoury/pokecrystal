Marts1:
; entries correspond to MART_* constants (see constants/mart_constants.asm)
	table_width 2, Marts1
	dw .MartCherrygrove
	dw .MartCherrygroveDex
	dw .MartViolet
	dw .MartAzalea
	dw .MartCianwood
	dw .MartGoldenrod2F1
	dw .MartGoldenrod2F2
	dw .MartGoldenrod3F
	dw .MartGoldenrod4F
	dw .MartGoldenrod5F
	dw .MartOlivine
	dw .MartEcruteak
	dw .MartMahogany1
	dw .MartMahogany2
	dw .MartBlackthorn
	dw .MartViridian
	dw .MartPewter
	dw .MartCerulean
	dw .MartLavender
	dw .MartVermilion
	dw .MartCeladon2F1
	dw .MartCeladon2F2
	dw .MartCeladon3F
	dw .MartCeladon4F
	dw .MartCeladon5F1
	dw .MartCeladon5F2
	dw .MartFuchsia
	dw .MartSaffron
	dw .MartMtMoon
	dw .MartIndigoPlateau
	dw .MartUnderground
	assert_table_length NUM_MARTS

.MartCherrygrove:
.MartCherrygroveDex:
	db 2 ; # items
	db POKE_BALL
	db PARLYZ_HEAL
	db -1 ; end

.MartViolet:
	db 4 ; # items
	db ESCAPE_ROPE
	db X_ATTACK
	db X_SPEED
	db FLOWER_MAIL
	db -1 ; end

.MartAzalea:
	db 4 ; # items
	db POKE_BALL
	db POTION
	db PARLYZ_HEAL
	db FLOWER_MAIL
	db -1 ; end

.MartCianwood:
	db 2 ; # items
	db SUPER_POTION
	db REVIVE
	db -1 ; end

.MartGoldenrod2F1:
	db 3 ; # items
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db -1 ; end

.MartGoldenrod2F2:
	db 3 ; # items
	db ESCAPE_ROPE
	db POKE_DOLL
	db FLOWER_MAIL
	db -1 ; end

.MartGoldenrod3F:
	db 3 ; # items
	db X_SPECIAL
	db X_DEFEND
	db DIRE_HIT
	db -1 ; end

.MartGoldenrod4F:
	db 2 ; # items
	db PROTEIN
	db HP_UP
	db -1 ; end

.MartGoldenrod5F:
	db 1 ; # items
	db TM_FIRE_PUNCH
	db -1 ; end

.MartOlivine:
	db 3 ; # items
	db GREAT_BALL
	db HYPER_POTION
	db ICE_HEAL
	db -1 ; end

.MartEcruteak:
	db 3 ; # items
	db POKE_BALL
	db SUPER_POTION
	db ICE_HEAL
	db -1 ; end

.MartMahogany1:
	db 4 ; # items
	db TINYMUSHROOM
	db SLOWPOKETAIL
	db POKE_BALL
	db POTION
	db -1 ; end

.MartMahogany2:
	db 3 ; # items
	db RAGECANDYBAR
	db HYPER_POTION
	db FLOWER_MAIL
	db -1 ; end

.MartBlackthorn:
	db 3 ; # items
	db GREAT_BALL
	db FULL_HEAL
	db REVIVE
	db -1 ; end

.MartViridian:
	db 3 ; # items
	db ULTRA_BALL
	db AWAKENING
	db FLOWER_MAIL
	db -1 ; end

.MartPewter:
	db 3 ; # items
	db SUPER_POTION
	db AWAKENING
	db BURN_HEAL
	db -1 ; end

.MartCerulean:
	db 3 ; # items
	db SUPER_REPEL
	db FULL_HEAL
	db X_DEFEND
	db -1 ; end

.MartLavender:
	db 3 ; # items
	db GREAT_BALL
	db SUPER_POTION
	db ANTIDOTE
	db -1 ; end

.MartVermilion:
	db 3 ; # items
	db ULTRA_BALL
	db HYPER_POTION
	db LITEBLUEMAIL
	db -1 ; end

.MartCeladon2F1:
	db 1 ; # items
	db MAX_POTION
	db -1 ; end

.MartCeladon2F2:
	db 3 ; # items
	db POKE_BALL
	db GREAT_BALL
	db ULTRA_BALL
	db -1 ; end

.MartCeladon3F:
	db 2 ; # items
	db TM_SUNNY_DAY
	db TM_RAIN_DANCE
	db -1 ; end

.MartCeladon4F:
	db 1 ; # items
	db LOVELY_MAIL
	db -1 ; end

.MartCeladon5F1:
	db 2 ; # items
	db IRON
	db CARBOS
	db -1 ; end

.MartCeladon5F2:
	db 2 ; # items
	db DIRE_HIT
	db X_ATTACK
	db -1 ; end

.MartFuchsia:
	db 3 ; # items
	db ULTRA_BALL
	db MAX_REPEL
	db FLOWER_MAIL
	db -1 ; end

.MartSaffron:
	db 2 ; # items
	db MAX_POTION
	db FLOWER_MAIL
	db -1 ; end

.MartMtMoon:
	db 3 ; # items
	db POKE_DOLL
	db LEMONADE
	db REPEL
	db -1 ; end

.MartIndigoPlateau:
	db 3 ; # items
	db HYPER_POTION
	db MAX_POTION
	db FULL_RESTORE
	db -1 ; end

.MartUnderground:
	db 4 ; # items
	db ENERGYPOWDER
	db ENERGY_ROOT
	db -1 ; end
