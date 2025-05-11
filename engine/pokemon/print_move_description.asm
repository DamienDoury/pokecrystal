PrintMoveFullDescription:
	push hl

	bccoord 10, 0, 0
	add hl, bc
	;hlcoord 12, 1
	ld de, String_MoveAtk_
	call PlaceString

	pop hl
	push hl
	bccoord 10, 1, 0
	add hl, bc
	;hlcoord 12, 2
	ld de, String_MoveAcc_
	call PlaceString

	ld a, [wCurSpecies]
	ld b, a
	farcall GetMoveCategoryName

	pop hl
	push hl
	bccoord 0, 1, 0
	add hl, bc
	;hlcoord 1, 2
	ld de, wStringBuffer1
	call PlaceString

	pop hl
	push hl
	ld a, [wCurSpecies]
	ld b, a
	;hlcoord 1, 1
	predef PrintMoveType

	call GetMovePowerAddress
	ld a, BANK(Moves)
	call GetFarByte

	pop hl
	push hl
	bccoord 15, 0, 0
	add hl, bc
	;hlcoord 16, 1
	cp 2
	jr c, .no_power

	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .accuracy

.no_power
	ld de, String_MoveNoPower_
	call PlaceString

.accuracy
	call GetMovePowerAddress
	
	dec hl
	ld a, BANK(Moves)
	call GetFarByte
	cp EFFECT_ALWAYS_HIT
	jr nc, .perfect_accuracy

	inc hl
	inc hl
	inc hl
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	call ConvertToPercentage ; We convert the 0;255 value given in a to a percentage returned in a.
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	
	pop hl
	push hl
	bccoord 15, 1, 0
	add hl, bc
	;hlcoord 16, 2
	lb bc, 1, 3
	call PrintNum
	jr .description

.perfect_accuracy
	pop hl
	push hl
	bccoord 15, 1, 0
	add hl, bc
	;hlcoord 16, 2
	ld de, String_MoveNoPower_
	call PlaceString

.description
	pop hl
	bccoord 0, 3, 0
	add hl, bc
	; fallthrough.

PrintMoveDescription:
	push hl
	ld hl, MoveDescriptions
	ld a, [wCurSpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

String_MoveAtk_:
if DEF(_FR_FR)
	db "PUIS/@"
else
	db "POW/@"
endc

String_MoveAcc_:
if DEF(_FR_FR)
	db "PREC/@"
else
	db "ACC/@"
endc

String_MoveNoPower_:
	db "---@"

; Input: B = percentage to convert.
; Output: converted percentage in A and [hQuotient + 3].
ConvertToPercentage::
	ld a, b
	xor a, $FF
	ld a, 100
	ldh [hQuotient + 3], a
	ret z ; We can't add 1 to 255, so we make a shortcut for this case.

	ld a, b
	inc a
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 1], a
	ldh [hMultiplicand], a
	ld a, 100
	ldh [hMultiplier], a
	call Multiply

	; The result of the multiplication is stored in the memory slots used for the dividend.
	ld a, 255
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 3]
	ret

; Output: HL.
; Globbers A, BC, F.
GetMovePowerAddress:
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ret

INCLUDE "data/moves/descriptions.asm"
