TrimSpaces::
	push bc
	ld h, d
	ld l, e

.loop:
	ld a, [hli]
	cp " "
	jr z, .loop

	dec hl
	ld b, d
	ld c, e

.loop2:
	ld a, [hli]
	ld [de], a
	cp "@"
	jr z, .done

	inc de
	cp " "
	jr z, .loop2

	ld b, d
	ld c, e
	jr .loop2

.done:
	ld a, "@"
	ld [bc], a
	pop bc
	ret
	
PrintHoursMins:
; Hours in b, minutes in c
	ld a, b
	cp 12
	push af
	jr c, .AM
	jr z, .PM
	sub 12
	jr .PM
.AM:
	or a
	jr nz, .PM
	ld a, 12
.PM:
	ld b, a
; Crazy stuff happening with the stack
	push bc
	ld hl, sp+1
	push de
	push hl
	pop de
	pop hl
	ld [hl], " "
	lb bc, 1, 2
	call PrintNum
	ld [hl], ":"
	inc hl
	ld d, h
	ld e, l
	ld hl, sp+0
	push de
	push hl
	pop de
	pop hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	pop bc
	ld de, String_AM
	pop af
	jr c, .place_am_pm
	ld de, String_PM
.place_am_pm
	inc hl
	jmp PlaceString

String_AM: db "AM@"
String_PM: db "PM@"
