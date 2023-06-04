LoadOverworldFont::
	ld a, [wLoadedFontSet]
	cp FONT_OVERWORLD
	ret z

ForceLoadOverworldFont::
	ld de, .OverworldFontGFX
	ld hl, vTiles1
	lb bc, BANK(.OverworldFontGFX), $80
	call Get2bpp
	ld de, .OverworldFontGFX + 16 * 59
	ld hl, vTiles2 tile " "
	lb bc, BANK(.OverworldFontGFX), 1
	call Get2bpp

	ld a, FONT_OVERWORLD
	ld [wLoadedFontSet], a
	ret

.OverworldFontGFX:
INCBIN "gfx/font/overworld.2bpp"

;.OverworldFontSpaceGFX:
;INCBIN "gfx/font/overworld_space.2bpp"
