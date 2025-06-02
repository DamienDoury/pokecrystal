; Input: stat address in BC.
EverstoneBoost::
	ld hl, wEnemyMonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonItem
.ok
	ld a, [hl]
	cp EVERSTONE
	ret nz

	; We check if the pokemon is fully evolved by checking if it can evolve.
	dec hl ; HL now points to Species.
	ld a, [hl]
	dec a
	add a

	push bc
	ld c, a
	ld a, 0
	adc 0
	ld b, a
	ld hl, EvosAttacksPointers
	add hl, bc
	pop bc

	ld a, BANK(EvosAttacksPointers)
	call GetFarWord ; Gets the address of the evo data.
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte ; Gets the evo byte value.
	and a
	ret z ; We return if the Pokemon can't evolve.

	jr FiftyPercentStatBoost ; farjump?? Must be in the same bank at the moment.
