momitem: MACRO
; money to trigger, cost, kind, item
	dt \1
	dt \2
	db \3, \4
ENDM

MomItems_2:
	momitem    900,   500, 1, SUPER_POTION
	momitem   4000,   100, 1, REPEL
	momitem   7000,     0, 2, SUPER_POTION
	momitem  10000,     0, 5, POKE_BALL
	momitem  14000,  3000, 1, MOON_STONE
	momitem  20000,  2500, 5, SUPER_POTION
	momitem  30000,     0, 5, GREAT_BALL
	momitem  40000,     0, 1, HYPER_POTION
	momitem  50000,  4800, 5, ULTRA_BALL
	momitem 100000, 12800, 1, SCOPE_LENS
.End

	dt 0 ; unused
