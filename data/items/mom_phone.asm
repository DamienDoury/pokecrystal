momitem: MACRO
; money to trigger, cost, quantity, item
	dt \1
	dt \2
	db \3, \4
ENDM

MomItems:
	momitem    900,   500,  1, SUPER_POTION
	momitem   2000,   100,  1, REPEL
	momitem   4000,     0,  2, MOOMOO_MILK
	momitem   7000,     0,  1, KINGS_ROCK
	momitem  10000,   750,  5, POKE_BALL
	momitem  14000,  3000,  1, MOON_STONE
	momitem  20000,  3000,  5, GREAT_BALL
	momitem  30000,     0,  3, HYPER_POTION
	momitem  40000,  4800,  5, ULTRA_BALL
	momitem  50000,     0,  1, SCOPE_LENS
	momitem  60000,  6000,  3, MAX_REVIVE
	momitem  70000,  5000, 10, MAX_REPEL
	momitem 100000, 14400, 15, ULTRA_BALL
	momitem 120000,     0,  5, MAX_ELIXER
	momitem 150000, 20000, 20, PP_UP ; I would rather give a battle item.
.End

	dt 0 ; unused
