RotateUnownFrontpic:
; something to do with Unown printer
	push de
	xor a ; BANK(sScratch)
	call OpenSRAM
	ld hl, sScratch
	ld bc, 0
.loop
	push bc
	push hl
	push bc
	ld de, wPrintedUnownTileSource
	call .Copy
	call .Rotate
	ld hl, UnownPrinter_GBPrinterRectangle
	pop bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, wPrintedUnownTileDest
	call .Copy
	pop hl
	ld bc, LEN_2BPP_TILE
	add hl, bc
	pop bc
	inc c
	ld a, c
	cp 7 * 7
	jr c, .loop

	ld hl, wGameboyPrinter2bppSource
	ld de, sScratch
	ld bc, 7 * 7 tiles
	call CopyBytes
	pop hl
	ld de, sScratch
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	jmp CloseSRAM

.Copy:
	ld c, LEN_2BPP_TILE
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy
	ret

.Rotate:
	ld hl, wPrintedUnownTileDest
	ld e, %10000000
	ld d, 8
.loop_decompress
	push hl
	ld hl, wPrintedUnownTileSource
	call .CountSetBit
	pop hl
	ld a, b
	ld [hli], a
	push hl
	ld hl, wPrintedUnownTileSource + 1
	call .CountSetBit
	pop hl
	ld a, b
	ld [hli], a
	srl e
	dec d
	jr nz, .loop_decompress
	ret

.CountSetBit:
	lb bc, 0, 8
.loop_count
	ld a, [hli]
	and e
	jr z, .clear
	scf
	jr .apply

.clear
	and a

.apply
	rr b
	inc hl
	dec c
	jr nz, .loop_count
	ret

gbprinterrect: MACRO
y = 0
rept \1
x = \1 * (\2 - 1) + y
rept \2
	dw wGameboyPrinter2bppSource tile x
x = x - \2
endr
y = y + 1
endr
ENDM

UnownPrinter_GBPrinterRectangle:
	gbprinterrect 7, 7
