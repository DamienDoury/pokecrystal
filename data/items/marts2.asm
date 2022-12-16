Marts2:
; entries correspond to MART_* constants (see constants/mart_constants.asm)
	table_width 2, Marts2
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
	db POTION
	db AWAKENING
	db -1 ; end

.MartViolet:
	db 3 ; # items
	db POTION
	db AWAKENING
	db X_DEFEND
	db -1 ; end

.MartAzalea:
	db 3 ; # items
	db CHARCOAL
	db POKE_BALL
	db ESCAPE_ROPE
	db -1 ; end

.MartCianwood:
	db 1 ; # items
	db POTION
	db -1 ; end

.MartGoldenrod2F1:
	db 2 ; # items
	db ANTIDOTE
	db PARLYZ_HEAL
	db -1 ; end

.MartGoldenrod2F2:
	db 3 ; # items
	db ESCAPE_ROPE
	db REVIVE
	db FLOWER_MAIL
	db -1 ; end

.MartGoldenrod3F:
	db 2 ; # items
	db X_SPEED
	db GUARD_SPEC
	db -1 ; end

.MartGoldenrod4F:
	db 2 ; # items
	db IRON
	db CALCIUM
	db -1 ; end

.MartGoldenrod5F:
	db 1 ; # items
	db TM_ICE_PUNCH
	db -1 ; end

.MartOlivine:
	db 3 ; # items
	db GREAT_BALL
	db AWAKENING
	db SURF_MAIL
	db -1 ; end

.MartEcruteak:
	db 4 ; # items
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db REVIVE
	db -1 ; end

.MartMahogany1:
	db 4 ; # items
	db TINYMUSHROOM
	db SLOWPOKETAIL
	db POKE_BALL
	db POTION
	db -1 ; end

.MartMahogany2:
	db 4 ; # items
	db RAGECANDYBAR
	db GREAT_BALL
	db ANTIDOTE
	db SUPER_REPEL
	db -1 ; end

.MartBlackthorn:
	db 2 ; # items
	db HYPER_POTION
	db MAX_POTION
	db -1 ; end

.MartViridian:
	db 3 ; # items
	db ANTIDOTE
	db PARLYZ_HEAL
	db BURN_HEAL
	db -1 ; end

.MartPewter:
	db 3 ; # items
	db GREAT_BALL
	db SUPER_REPEL
	db PARLYZ_HEAL
	db -1 ; end

.MartCerulean:
	db 3 ; # items
	db X_ATTACK
	db DIRE_HIT
	db SURF_MAIL
	db -1 ; end

.MartLavender:
	db 2 ; # items
	db GREAT_BALL
	db AWAKENING
	db -1 ; end

.MartVermilion:
	db 3 ; # items
	db ULTRA_BALL
	db REVIVE
	db PARLYZ_HEAL
	db -1 ; end

.MartCeladon2F1:
	db 1 ; # items
	db REVIVE
	db -1 ; end

.MartCeladon2F2:
	db 3 ; # items
	db ULTRA_BALL
	db ESCAPE_ROPE
	db FULL_HEAL
	db -1 ; end

.MartCeladon3F:
	db 2 ; # items
	db TM_SANDSTORM
	db TM_HAIL
	db -1 ; end

.MartCeladon4F:
	db 1 ; # items
	db SURF_MAIL
	db -1 ; end

.MartCeladon5F1:
	db 2 ; # items
	db PROTEIN
	db CALCIUM
	db -1 ; end

.MartCeladon5F2:
	db 3 ; # items
	db X_DEFEND
	db X_SPEED
	db X_SPECIAL
	db -1 ; end

.MartFuchsia:
	db 3 ; # items
	db GREAT_BALL
	db FULL_HEAL
	db FLOWER_MAIL
	db -1 ; end

.MartSaffron:
	db 3 ; # items
	db GREAT_BALL
	db X_ATTACK
	db X_DEFEND
	db -1 ; end

.MartMtMoon:
	db 3 ; # items
	db LEMONADE
	db REPEL
	db PORTRAITMAIL
	db -1 ; end

.MartIndigoPlateau:
	db 2 ; # items
	db REVIVE
	db FULL_HEAL
	db -1 ; end

.MartUnderground:
	db 4 ; # items
	db ENERGY_ROOT
	db HEAL_POWDER
	db -1 ; end
