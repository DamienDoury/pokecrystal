; Old version: ~14300 cycles worst case, ~540 bytes of ROM, variable number of iterations (1..255).
; New version: ~1100 cycles, ~70 bytes of ROM, fixed number of iterations (8).




;NUM_SQUARE_ROOTS EQU 255
;
;GetSquareRoot:
;; Return the square root of de in b.
;
;; Rather than calculating the result, we take the index of the
;; first value in a table of squares that isn't lower than de.
;
;	ld hl, .Squares
;	ld b, 0
;.loop
;; Make sure we don't go past the end of the table.
;	inc b
;	ld a, b
;	cp NUM_SQUARE_ROOTS
;	ret z
;
;; Iterate over the table until b**2 >= de.
;	ld a, [hli]
;	sub e
;	ld a, [hli]
;	sbc d
;
;	jr c, .loop
;	ret
;
;.Squares:
;x = 1
;rept NUM_SQUARE_ROOTS
;	dw x * x
;x = x + 1
;endr




; Returns the square root of de in b.
; Clobbers: AF, B, DE, HL
; Preserves C.
GetSquareRoot:
	push bc
    ld h, d
    ld l, e          

    ld de, 0         
    ld bc, $4000     

.loop:
    push hl

    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc a, d
    jr c, .restore

    ld h, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc a, b
    jr c, .restore

    srl d
    rr e

    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a

    pop hl
    jr .shift

.restore:
    pop hl

    srl d
    rr e

.shift:
    srl b
    rr c
    srl b
    rr c

    ld a, b
    or c
    jr nz, .loop

	pop bc
    ld b, e
    ret