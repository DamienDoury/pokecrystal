_Diploma:
	call PlaceDiplomaOnScreen
	call WaitPressAorB_BlinkCursor
	ret

PlaceDiplomaOnScreen:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, vTiles2
	call Decompress
	ld hl, DiplomaPage1Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .Player
	hlcoord 2, 5
	call PlaceString
if DEF(_FR_FR)
	ld de, wPlayerName
	ld h, b
	ld l, c
	inc hl
else
	ld de, .EmptyString
	hlcoord 15, 5
	call PlaceString
	ld de, wPlayerName
	hlcoord 9, 5
endc
	call PlaceString
	ld de, .Certification
	hlcoord 2, 8
	call PlaceString
	call EnableLCD
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	ret

.Player:
if DEF(_FR_FR)
	db "JOUEUR@"
else
	db "PLAYER@"
endc

.EmptyString:
	db "@"

.Certification:
if DEF(_FR_FR)
	db   "Ceci certifie"
	next "que tu as"
	next "complété le"
	next "nouveau #DEX."
	next "Félicitations!"
	db   "@"
else
	db   "This certifies"
	next "that you have"
	next "completed the"
	next "new #DEX."
	next "Congratulations!"
	db   "@"
endc

PrintDiplomaPage2:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	call ByteFill
	ld hl, DiplomaPage2Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .GameFreak
	hlcoord 8, 0
	call PlaceString
	ld de, .PlayTime
	hlcoord 3, 15
	call PlaceString
	hlcoord 12, 15
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	ld [hl], $67 ; colon
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ret

if DEF(_FR_FR)
.PlayTime: db "TEMPS DE JEU@"
.GameFreak: db "GAME FREAK@"	
else
.PlayTime: db "PLAY TIME@"
.GameFreak: db "GAME FREAK@"
endc

DiplomaGFX:
if DEF(_FR_FR)
INCBIN "gfx/diploma/diploma_fr.2bpp.lz"
else
INCBIN "gfx/diploma/diploma.2bpp.lz"
endc

DiplomaPage1Tilemap:
INCBIN "gfx/diploma/page1.tilemap"

DiplomaPage2Tilemap:
INCBIN "gfx/diploma/page2.tilemap"
