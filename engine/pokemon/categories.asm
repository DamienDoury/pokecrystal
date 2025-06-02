GetMoveCategoryName:
; Copy the category name of move b to wStringBuffer1.

	ld a, b
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_TYPE
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

; Mask out the type
	and $ff ^ TYPE_MASK
; Shift the category bits into the range 0-2
	rlc a
	rlc a
	dec a

	ld hl, CategoryNames
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld bc, MOVE_NAME_LENGTH
	jmp CopyBytes

GetMoveCategory:
; Copy the category of move a to a.
	ldh a, [hRandomAdd]
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_TYPE
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

; Mask out the type
	and $ff ^ TYPE_MASK
	ldh [hRandomAdd], a ; Store it for use with farcall that overrides the register a.
	ret

INCLUDE "data/types/category_names.asm"