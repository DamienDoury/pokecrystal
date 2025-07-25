PRINTPARTY_HP EQU "◀" ; $71

PrintPage1:
	hlcoord 0, 0
	decoord 0, 0, wPrinterTilemapBuffer
	ld bc, 17 * SCREEN_WIDTH
	call CopyBytes
	hlcoord 17, 1, wPrinterTilemapBuffer
	ld a, $62
	ld [hli], a
	inc a ; $63
	ld [hl], a
	hlcoord 17, 2, wPrinterTilemapBuffer
	ld a, $64
	ld [hli], a
	inc a ; $65
	ld [hl], a
	hlcoord 1, 9, wPrinterTilemapBuffer
	ld a, " "
	ld [hli], a
	ld [hl], a
	hlcoord 1, 10, wPrinterTilemapBuffer
	ld a, $61
	ld [hli], a
	ld [hl], a
	hlcoord 2, 11, wPrinterTilemapBuffer
	lb bc, 5, 18
	call ClearBox
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	push af
	ld a, [wTempSpecies]
	ld b, a
	ld c, 1 ; get page 1
	farcall GetDexEntryPagePointer
	pop af
	ld a, b
	hlcoord 1, 11, wPrinterTilemapBuffer
	call nz, PlaceFarString
	hlcoord 19, 0, wPrinterTilemapBuffer
	ld [hl], $35
	ld de, SCREEN_WIDTH
	add hl, de
	ld b, $f
.column_loop
	ld [hl], $37
	add hl, de
	dec b
	jr nz, .column_loop
	ld [hl], $3a
	ret

PrintPage2:
	hlcoord 0, 0, wPrinterTilemapBuffer
	ld bc, 8 * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wPrinterTilemapBuffer
	ld a, $36
	ld b, 6
	call .FillColumn
	hlcoord 19, 0, wPrinterTilemapBuffer
	ld a, $37
	ld b, 6
	call .FillColumn
	hlcoord 0, 6, wPrinterTilemapBuffer
	ld [hl], $38
	inc hl
	ld a, $39
	ld bc, SCREEN_HEIGHT
	call ByteFill
	ld [hl], $3a
	hlcoord 0, 7, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH
	ld a, $32
	call ByteFill
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	push af
	ld a, [wTempSpecies]
	ld b, a
	ld c, 2 ; get page 2
	farcall GetDexEntryPagePointer
	pop af
	hlcoord 1, 1, wPrinterTilemapBuffer
	ld a, b
	call nz, PlaceFarString
	ret

.FillColumn:
	push de
	ld de, SCREEN_WIDTH
.column_loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .column_loop
	pop de
	ret

GBPrinterStrings: ; used only for BANK(GBPrinterStrings)
GBPrinterString_Null: db "@"
if DEF(_FR_FR)
GBPrinterString_CheckingLink: next "   VERIF.LIEN...@"
GBPrinterString_Transmitting: next "  TRANSMISSION...@"
GBPrinterString_Printing: next "   IMPRESSION...@"
GBPrinterString_PrinterError1:
	db   " ERREUR PRINTER 1"
	next ""
	next "Voir le manuel du"
	next "Game Boy Printer."
	db   "@"
GBPrinterString_PrinterError2:
	db   " ERREUR PRINTER 2"
	next ""
	next "Voir le manuel du"
	next "Game Boy Printer."
	db   "@"
GBPrinterString_PrinterError3:
	db   " ERREUR PRINTER 3"
	next ""
	next "Voir le manuel du"
	next "Game Boy Printer."
	db   "@"
GBPrinterString_PrinterError4:
	db   " ERREUR PRINTER 4"
	next ""
	next "Voir le manuel du"
	next "Game Boy Printer."
	db   "@"
else
GBPrinterString_CheckingLink: next " CHECKING LINK...@"
GBPrinterString_Transmitting: next "  TRANSMITTING...@"
GBPrinterString_Printing: next "    PRINTING...@"
GBPrinterString_PrinterError1:
	db   " Printer Error 1"
	next ""
	next "Check the Game Boy"
	next "Printer Manual."
	db   "@"
GBPrinterString_PrinterError2:
	db   " Printer Error 2"
	next ""
	next "Check the Game Boy"
	next "Printer Manual."
	db   "@"
GBPrinterString_PrinterError3:
	db   " Printer Error 3"
	next ""
	next "Check the Game Boy"
	next "Printer Manual."
	db   "@"
GBPrinterString_PrinterError4:
	db   " Printer Error 4"
	next ""
	next "Check the Game Boy"
	next "Printer Manual."
	db   "@"
endc

PrintPartyMonPage1:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	call LoadFontsBattleExtra

	ld de, GBPrinterHPIcon
	ld hl, vTiles2 tile PRINTPARTY_HP
	lb bc, BANK(GBPrinterHPIcon), 1
	call Request1bpp

	ld de, GBPrinterLvIcon
	ld hl, vTiles2 tile "<LV>"
	lb bc, BANK(GBPrinterLvIcon), 1
	call Request1bpp

	ld de, StatsScreenPageTilesGFX + 14 tiles ; shiny icon
	ld hl, vTiles2 tile "⁂"
	lb bc, BANK(StatsScreenPageTilesGFX), 1
	call Get2bpp

	xor a
	ld [wMonType], a
	farcall CopyMonToTempMon
	hlcoord 0, 7
	lb bc, 9, 18
	call Textbox
	hlcoord 8, 2
	ld a, [wTempMonLevel]
	call PrintLevel_Force3Digits
	hlcoord 13, 2
	ld [hl], PRINTPARTY_HP
	inc hl
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	ld [wCurSpecies], a
	ld hl, wPartyMonNicknames
	call GetCurPartyMonName
	hlcoord 8, 4
	call PlaceString
	hlcoord 9, 6
	ld [hl], "/"
	call GetPokemonName
	hlcoord 10, 6
	call PlaceString
	hlcoord 8, 0
	ld [hl], "№"
	inc hl
	ld [hl], "."
	inc hl
	ld de, wNamedObjectIndex
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 1, 9
	ld de, PrintParty_OTString
	call PlaceString
	ld hl, wPartyMonOTs
	call GetCurPartyMonName
	hlcoord 4, 9
	call PlaceString
	hlcoord 1, 11
	ld de, PrintParty_IDNoString
	call PlaceString
	hlcoord 4, 11
	ld de, wTempMonID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
if DEF(_FR_FR)
	hlcoord 1, 13
else
	hlcoord 1, 14
endc
	ld de, PrintParty_MoveString
	call PlaceString
	hlcoord 7, 14
	ld a, [wTempMonMoves + 0]
	call PlaceMoveNameString
	call PlaceGenderAndShininess
	ld hl, wTempMonDVs
	predef GetUnownLetter
	ld hl, wBoxAlignment
	xor a
	ld [hl], a
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr z, .got_alignment
	inc [hl]
.got_alignment
	hlcoord 0, 0
	call _PrepMonFrontpic
	call WaitBGMap
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	jmp SetPalettes

PrintPartyMonPage2:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	call LoadFontsBattleExtra
	xor a
	ld [wMonType], a
	farcall CopyMonToTempMon
	hlcoord 0, 0
	lb bc, 15, 18
	call Textbox
	ld bc, SCREEN_WIDTH
	decoord 0, 0
	hlcoord 0, 1
	call CopyBytes
	hlcoord 7, 0
	ld a, [wTempMonMoves + 1]
	call PlaceMoveNameString
	hlcoord 7, 2
	ld a, [wTempMonMoves + 2]
	call PlaceMoveNameString
	hlcoord 7, 4
	ld a, [wTempMonMoves + 3]
	call PlaceMoveNameString
	hlcoord 7, 7
	ld de, PrintParty_StatsString
	call PlaceString
	hlcoord 16, 7
	ld de, wTempMonAttack
	call .PrintTempMonStats
	hlcoord 16, 9
	ld de, wTempMonDefense
	call .PrintTempMonStats
	hlcoord 16, 11
	ld de, wTempMonSpclAtk
	call .PrintTempMonStats
	hlcoord 16, 13
	ld de, wTempMonSpclDef
	call .PrintTempMonStats
	hlcoord 16, 15
	ld de, wTempMonSpeed
	call .PrintTempMonStats
	call WaitBGMap
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	jmp SetPalettes

.PrintTempMonStats:
	lb bc, 2, 3
	jmp PrintNum

GetCurPartyMonName:
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ret

PlaceMoveNameString:
	and a
	jr z, .no_move

	ld [wNamedObjectIndex], a
	call GetMoveName
	jr .got_string

.no_move
	ld de, PrintParty_NoMoveString

.got_string
	jmp PlaceString

PlaceGenderAndShininess:
	farcall GetGender
	ld a, " "
	jr c, .got_gender
	ld a, "♂"
	jr nz, .got_gender
	ld a, "♀"

.got_gender
	hlcoord 18, 2
	ld [hl], a
	ld bc, wTempMonDVs
	farcall CheckShininess
	ret nc
	hlcoord 14, 0
	ld [hl], "⁂"
	ret

PrintParty_OTString:
if DEF(_FR_FR)
	db "DO/@"
else
	db "OT/@"
endc

PrintParty_MoveString:
if DEF(_FR_FR)
	db "CAPACITE/@"
else
	db "MOVE@"
endc

PrintParty_IDNoString:
if DEF(_FR_FR)
	db "№.<ID>@"
else
	db "<ID>№.@"
endc

PrintParty_StatsString:
if DEF(_FR_FR)
	db   "ATTAQUE"
	next "DEFENSE"
	next "ATQ.SPE."
	next "DEF.SPE."
	next "VITESSE"
	db   "@"
else
	db   "ATTACK"
	next "DEFENSE"
	next "SPCL.ATK"
	next "SPCL.DEF"
	next "SPEED"
	db   "@"
endc

PrintParty_NoMoveString:
	db "------------@"

GBPrinterHPIcon:
if DEF(_FR_FR)
INCBIN "gfx/printer/hp_fr.1bpp"
else
INCBIN "gfx/printer/hp.1bpp"
endc

GBPrinterLvIcon:
if DEF(_FR_FR)
INCBIN "gfx/printer/lv_fr.1bpp"
else
INCBIN "gfx/printer/lv.1bpp"
endc
