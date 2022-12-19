inflated_price: MACRO
; inflated price 1, inflated price 2
; Note that the regular price is retrieved from items/attributes.asm.
; Also notice that we save 53 * 2 = 106 bytes by storing the price on 2 bytes instead of 3.
	dw \1, \2
ENDM

InflatedPrices:
; entries correspond to item ids (see constants/item_constants.asm)
	table_width INFLATED_PRICE_STRUCT_LENGTH, InflatedPrices
	inflated_price 0, 0 ; MASTER_BALL
	inflated_price 1800, 2400 ; ULTRA_BALL
	inflated_price 10, 10 ; BRIGHTPOWDER
	inflated_price 900, 1200 ; GREAT_BALL
	inflated_price 400, 600 ; POKE_BALL
	inflated_price 0, 0 ; TOWN_MAP
	inflated_price 0, 0 ; BICYCLE
	inflated_price 0, 0 ; MOON_STONE
	inflated_price 120, 160 ; ANTIDOTE
	inflated_price 300, 420 ; BURN_HEAL
	inflated_price 300, 420 ; ICE_HEAL
	inflated_price 300, 420 ; AWAKENING
	inflated_price 240, 320 ; PARLYZ_HEAL
	inflated_price 4200, 6000 ; FULL_RESTORE
	inflated_price 3500, 5000 ; MAX_POTION
	inflated_price 1680, 2400 ; HYPER_POTION
	inflated_price 980, 1400 ; SUPER_POTION
	inflated_price 420, 600 ; POTION
	inflated_price 825, 1380 ; ESCAPE_ROPE
	inflated_price 525, 880 ; REPEL
	inflated_price 4500, 4500 ; MAX_ELIXER
	inflated_price 2800, 3500 ; FIRE_STONE
	inflated_price 2800, 3500 ; THUNDERSTONE
	inflated_price 2800, 3500 ; WATER_STONE
	inflated_price 0, 0 ; ITEM_19
	inflated_price 10900, 12900 ; HP_UP
	inflated_price 10900, 12900 ; PROTEIN
	inflated_price 10900, 12900 ; IRON
	inflated_price 10900, 12900 ; CARBOS
	inflated_price 10, 10 ; LUCKY_PUNCH
	inflated_price 10900, 12900 ; CALCIUM
	inflated_price 5900, 6900 ; RARE_CANDY
	inflated_price 950, 1000 ; X_ACCURACY
	inflated_price 2800, 3500 ; LEAF_STONE
	inflated_price 10, 10 ; METAL_POWDER
	inflated_price 10000, 6000 ; TOILET_PAPER
	inflated_price 1500, 2500 ; POKE_DOLL
	inflated_price 720, 960 ; FULL_HEAL
	inflated_price 1800, 2400 ; REVIVE
	inflated_price 4800, 6400 ; MAX_REVIVE
	inflated_price 700, 750 ; GUARD_SPEC
	inflated_price 750, 1250 ; SUPER_REPEL
	inflated_price 1050, 1750 ; MAX_REPEL
	inflated_price 650, 700 ; DIRE_HIT
	inflated_price 0, 0 ; ITEM_2D
	inflated_price 220, 240 ; FRESH_WATER
	inflated_price 330, 360 ; SODA_POP
	inflated_price 390, 430 ; LEMONADE
	inflated_price 500, 550 ; X_ATTACK
	inflated_price 0, 0 ; ITEM_32
	inflated_price 550, 600 ; X_DEFEND
	inflated_price 350, 400 ; X_SPEED
	inflated_price 350, 400 ; X_SPECIAL
