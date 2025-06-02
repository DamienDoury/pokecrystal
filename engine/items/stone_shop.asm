StoneShopSellPitch::
    ; Special case for the stone seller in Goldenrod Underground.
	; She describes what she sells.
	ld a, [wCurrentMartID]
	cp MART_UNDERGROUND_STONES
	ret nz

	ld a, [wCurItem]
    ld hl, .StoneShopItemsInOrder
    call IsInByteArray ; Returns index in B.
    ret nc

    ld e, b
    sla e ; Double the value of E, as it's a dw index.
	ld d, 0
	ld hl, .StoneShopSellPitches
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jmp JoyWaitAorB

.StoneShopItemsInOrder
    db JADE_CRYSTAL
    db STAR_PIECE
    db EVERSTONE
    db -1

.StoneShopSellPitches
	dw .JadeCrystalSellPitchText
	dw .StarPieceSellPitchText
	dw .EverstoneSellPitchText

.JadeCrystalSellPitchText:
	text_far _JadeCrystalSellPitchText
	text_end

.StarPieceSellPitchText:
	text_far _StarPieceSellPitchText
	text_end

.EverstoneSellPitchText:
	text_far _EverstoneSellPitchText
	text_end

RemoveEviostoneFromStoneShopInventory::
    ; Remove the Everstone from the shop. By default, it is the last item from the list.
	ld hl, wCurMartCount
	ld e, [hl]
	dec [hl]
	ld d, 0
	add hl, de
	ld [hl], -1
    ret

CheckIfBoughtEverstoneAtStoneShop::
	ld a, [wCurrentMartID]
	cp MART_UNDERGROUND_STONES
	ret nz

	ld a, [wCurItem]
	cp EVERSTONE
	ret nz

    xor a
    ret

NotifyLastEverstone::
    call CheckIfBoughtEverstoneAtStoneShop
    ret nz

	ld b, SET_FLAG
	ld de, EVENT_BOUGHT_EVERSTONE
	call EventFlagAction

	ld hl, .last_one_text
	call PrintText
    call JoyWaitAorB

    call RemoveEviostoneFromStoneShopInventory
    xor a ; Sets the Z flag.
    ret

.last_one_text
	text_far _LastEverstoneText
	text_end