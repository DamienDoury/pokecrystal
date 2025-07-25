DrawKrisPackGFX:
	ld hl, PackFGFXPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, vTiles2 tile $50
	lb bc, BANK(PackFGFX), 15
	jmp Request2bpp

PackFGFXPointers:
	dw PackFGFX + (15 tiles) * 5 ; ITEM_POCKET
	dw PackFGFX + (15 tiles) * 3 ; BALL_POCKET
	dw PackFGFX + (15 tiles) * 0 ; KEY_ITEM_POCKET
	dw PackFGFX + (15 tiles) * 2 ; TM_HM_POCKET
	dw PackFGFX + (15 tiles) * 4 ; MED_POCKET
	dw PackFGFX + (15 tiles) * 1 ; BERRY_POCKET

PackFGFX:
INCBIN "gfx/pack/pack_f.2bpp"
