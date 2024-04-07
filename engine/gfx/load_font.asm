INCLUDE "gfx/font.asm"

align 4
StandardFontSpaceGFX:
INCBIN "gfx/font/standard_space.2bpp"

_LoadStandardFont::
	ld a, [wVramState]
	bit 0, a
	jr z, .dont_use_ow_font

	; In vanilla, there are 2 different fonts used on the overworld: one for the Map Sign called "OW font", and a "Standard font" for everything else.
	; We edited Palette_TextBG7 so that the OW font can be the only one used on the OW.
	; So when LoadStandardFont is called while on the OW, LoadOverworldFont should be called instead.
	; We need a way to check that we are on the OW.
	; The solution found, although it looks like a hack and is not designed for this, looks to be working fine.
	; We check wVramState first bit (bit 0).
	; This solution is faster than checking all calls of LoadStandardFont and change those the call to LoadOverworldFont when required.
	; Although the current solution may be unreliable.
	farcall LoadOverworldFont
	ret

.dont_use_ow_font::
	ld de, StandardFontSpaceGFX
	ld hl, vTiles2 tile " "
	lb bc, BANK(StandardFontSpaceGFX), 1
	call Get2bpp

	ld a, [wLoadedFont]
	cp FONT_STANDARD
	ret z ; If the font is already loaded, we don't need to load it again.

	ld a, FONT_STANDARD
	ld [wLoadedFont], a

	ld de, Font
	ld hl, vTiles1
	lb bc, BANK(Font), $80
	jp Get2bpp

_LoadFontsExtra1::
	ld de, FontsExtra_SolidBlackGFX
	ld hl, vTiles2 tile "■" ; $60
	lb bc, BANK(FontsExtra_SolidBlackGFX), 1
	call Get1bppViaHDMA
	ld de, PokegearPhoneIconGFX
	ld hl, vTiles2 tile "☎" ; $62
	lb bc, BANK(PokegearPhoneIconGFX), 1
	call Get2bppViaHDMA
	ld de, FontExtra + 3 tiles ; "<BOLD_D>"
	ld hl, vTiles2 tile "<BOLD_D>"
	lb bc, BANK(FontExtra), 22 ; "<BOLD_D>" to "ぉ"
	call Get2bppViaHDMA
	jr LoadFrame

_LoadFontsExtra2::
	ld de, FontsExtra2_UpArrowGFX
	ld hl, vTiles2 tile "▲" ; $61
	ld b, BANK(FontsExtra2_UpArrowGFX)
	ld c, 1
	call Get2bppViaHDMA
	ret

LoadFontLevelSymbol::
	ld de, FontBattleExtra + 14 tiles ; "<DO>"
	ld hl, vTiles2 tile $6e
	lb bc, BANK(FontBattleExtra), 1
	call Get2bppViaHDMA
	ret

_LoadFontsBattleExtra::
	ld de, FontBattleExtra
	ld hl, vTiles2 tile $60
	lb bc, BANK(FontBattleExtra), 25
	call Get2bppViaHDMA
	; fallthrough

LoadFrame:
	ld a, [wTextboxFrame]
	maskbits NUM_FRAMES
	ld bc, TEXTBOX_FRAME_TILES * LEN_1BPP_TILE
	ld hl, Frames
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile "┌" ; $79
	lb bc, BANK(Frames), TEXTBOX_FRAME_TILES ; "┌" to "┘"
	call Get1bppViaHDMA
	ld hl, vTiles2 tile " " ; $7f
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	call Get1bppViaHDMA
	ret

LoadBattleFontsHPBar:
	ld de, FontBattleExtra
	ld hl, vTiles2 tile $60
	lb bc, BANK(FontBattleExtra), 12
	call Get2bppViaHDMA
	ld hl, vTiles2 tile $70
	ld de, FontBattleExtra + 16 tiles ; "<DO>"
	lb bc, BANK(FontBattleExtra), 3 ; "<DO>" to "『"
	call Get2bppViaHDMA
	call LoadFrame
	; fallthrough

LoadHPBar:
	ld de, EnemyHPBarBorderGFX
	ld hl, vTiles2 tile $6c
	lb bc, BANK(EnemyHPBarBorderGFX), 4
	call Get1bppViaHDMA
	ld de, HPExpBarBorderGFX
	ld hl, vTiles2 tile $73
	lb bc, BANK(HPExpBarBorderGFX), 6
	call Get1bppViaHDMA
	ld de, ExpBarGFX
	ld hl, vTiles2 tile $55
	lb bc, BANK(ExpBarGFX), 9
	call Get2bppViaHDMA
	ld de, MobilePhoneTilesGFX + 7 tiles ; mobile phone icon
	ld hl, vTiles2 tile $5e
	lb bc, BANK(MobilePhoneTilesGFX), 2
	call Get2bppViaHDMA
	farcall LoadBallIconGFX
	ret

StatsScreen_LoadFont:
	call _LoadFontsBattleExtra
	ld de, EnemyHPBarBorderGFX
	ld hl, vTiles2 tile $6c
	lb bc, BANK(EnemyHPBarBorderGFX), 4
	call Get1bppViaHDMA
	ld de, HPExpBarBorderGFX
	ld hl, vTiles2 tile $78
	lb bc, BANK(HPExpBarBorderGFX), 1
	call Get1bppViaHDMA
	ld de, HPExpBarBorderGFX + 3 * LEN_1BPP_TILE
	ld hl, vTiles2 tile $76
	lb bc, BANK(HPExpBarBorderGFX), 2
	call Get1bppViaHDMA
	ld de, ExpBarGFX
	ld hl, vTiles2 tile $55
	lb bc, BANK(ExpBarGFX), 8
	call Get2bppViaHDMA
LoadStatsScreenPageTilesGFX:
	ld de, StatsScreenPageTilesGFX
	ld hl, vTiles2 tile $31
	lb bc, BANK(StatsScreenPageTilesGFX), 17
	call Get2bppViaHDMA
	ret
