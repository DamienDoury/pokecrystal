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



; Constant-time (8 loops): 1144~1668 clock-cycles total.
; 70 ROM bytes.
; Returns the same values as vanilla.
;GetSquareRoot: 
;    ; Special case: we return ceil(sqrt(0)) = 1, which is wrong but matches the vanilla function. 
;    ld a, d 
;    or e ; 1o 4c 
;    ld b, 1 ; 2o 8c 
;    ret z ; 1o 20c/8c 
;    
;    push bc ; 1o 16c 
;    ld h, d ; 1o 4c 
;    ld l, e ; 1o 4c 
;    ld de, 0 ; 3o 12c 
;    ld bc, $4000 ; 3o 12c 
;.loop: 
;    push hl ; 1o 16c 
;    ld a, l ; 1o 4c 
;    sub c ; 1o 4c 
;    ld l, a ; 1o 4c 
;    ld a, h ; 1o 4c 
;    sbc a, b ; 1o 4c 
;    ld h, a ; 1o 4c 
;    jr c, .no_bit ; 2o 12c/8c 
;    
;    ld a, l ; 1o 4c 
;    sub e ; 1o 4c 
;    ld l, a ; 1o 4c 
;    ld a, h ; 1o 4c 
;    sbc a, d ; 1o 4c 
;    ld h, a ; 1o 4c 
;    jr c, .no_bit ; 2o 12c/8c 
;    
;.take_bit: 
;    pop af ; 1o 12c 
;    srl d ; 2o 8c 
;    rr e ; 2o 8c 
;    ld a, e ; 1o 4c 
;    add a, c ; 1o 4c 
;    ld e, a ; 1o 4c 
;    ld a, d ; 1o 4c 
;    adc a, b ; 1o 4c 
;    ld d, a ; 1o 4c 
;    jr .next ; 2o 12c 
;    
;.no_bit: 
;    pop hl ; 1o 12c 
;    srl d ; 2o 8c 
;    rr e ; 2o 8c 
;.next: 
;    srl b ; 2o 8c 
;    rr c ; 2o 8c 
;    srl b ; 2o 8c 
;    rr c ; 2o 8c 
;    ld a, b ; 1o 4c 
;    or c ; 1o 4c 
;    jr nz, .loop ; 2o 12c/8c 
;    
;    pop bc ; 1o 12c 
;    ld b, e ; 1o 4c 
;    ld a, h ; 1o 4c 
;    or l ; 1o 4c 
;    ret z ; 1o 20c/8c 
;    
;    ; ceiling 
;    inc b ; 1o 4c 
;    ret nz ; 1o 20c/8c 
;    
;    ; capped at 255 
;    dec b ; 1o 4c 
;    ret ; 1o 16c