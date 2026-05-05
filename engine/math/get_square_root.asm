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




; Returns ceil(sqrt(DE)) in B, properly adjusting for exact vanilla values, and $1 <= B <= $FF limit.
; Clobbers: AF, B, DE, HL
; Preserves C.
GetSquareRoot:
    ld h, d
    ld l, e
    ld de, 1
    ld b, d
  
.loop
    inc b
    ld a, b
    inc a
    ret z

    dec e
    dec de
    add hl, de
    ret nc

    ld a, h
    or l
    jr nz, .loop
    
    ret