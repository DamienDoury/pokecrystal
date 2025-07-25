InitCrystalData:
	ld a, $1
	ld [wd474], a
	xor a
	ld [wd473], a
	ld [wPlayerGender], a
	ld [wd475], a
	ld [wd476], a
	ld [wd477], a
	ld [wd478], a
	ld [wd002], a
	ld [wd003], a
	ld a, [wd479]
	res 0, a ; ???
	ld [wd479], a
	ld a, [wd479]
	res 1, a ; ???
	ld [wd479], a
	ret

INCLUDE "mobile/mobile_12.asm"

DisclaimerScreen:
	ld de, .Disclaimer
	hlcoord 0, 7
	call PlaceString
	ld c, 240
	call DelayFrames
	farcall FadeOutPalettes
	ret

.Disclaimer
if DEF(_FR_FR)
	db "    Ce romhack<LF>"
	db "<LF>"
	db "    n'est pas un<LF>"
	db "<LF>"
	db "    jeu officiel.@"
else
	db "    This fangame<LF>"
	db "<LF>"
	db "     is not an<LF>"
	db "<LF>"
	db "   official game.@"
endc

InitGender:
	call InitGenderScreen
	call LoadGenderScreenPal
	call LoadGenderScreenLightBlueTile
	call WaitBGMap2
	call SetPalettes
	ld hl, AreYouABoyOrAreYouAGirlText
	call PrintText
	ld hl, .MenuHeader
	call LoadMenuHeader
	call WaitBGMap2
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	ld [wPlayerGender], a
	ld c, 10
	jmp DelayFrames

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
if DEF(_FR_FR)
	menu_coords 5, 4, 13, 9
else
	menu_coords 6, 4, 12, 9
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	db 2 ; items
if DEF(_FR_FR)
	db "Garçon@"
	db "Fille@"
else
	db "Boy@"
	db "Girl@"
endc

AreYouABoyOrAreYouAGirlText:
	text_far _AreYouABoyOrAreYouAGirlText
	text_end

InitGenderScreen:
	ld a, $10
	ld [wMusicFade], a
	ld a, LOW(MUSIC_NONE)
	ld [wMusicFadeID], a
	ld a, HIGH(MUSIC_NONE)
	ld [wMusicFadeID + 1], a
	ld c, 8
	call DelayFrames
	call ClearBGPalettes
	call InitCrystalData
	call LoadFontsExtra
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, $0
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	jmp ByteFill

LoadGenderScreenPal:
	ld hl, .Palette
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	farcall ApplyPals
	ret

.Palette:
INCLUDE "gfx/new_game/gender_screen.pal"

LoadGenderScreenLightBlueTile:
	ld de, .LightBlueTile
	ld hl, vTiles2 tile $00
	lb bc, BANK(.LightBlueTile), 1
	jmp Get2bpp

.LightBlueTile:
INCBIN "gfx/new_game/gender_screen.2bpp"
