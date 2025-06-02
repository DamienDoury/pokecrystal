LoadOverworldFont::
	; The space char gets erased on map reload, so we need to reload it anyway.
	ld de, .OverworldFontSpaceGFX
	ld hl, vTiles2 tile " "
	lb bc, BANK(.OverworldFontSpaceGFX), 1
	call Get2bpp

	ld a, [wLoadedFont]
	cp FONT_OW
	ret z

	ld a, FONT_OW
	ld [wLoadedFont], a

	ld de, OverworldFontGFX
	ld hl, vTiles1
	lb bc, BANK(OverworldFontGFX), $80
	jmp Get2bpp

align 4
.OverworldFontSpaceGFX:
INCBIN "gfx/font/overworld_space.2bpp"
