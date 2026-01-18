_ReceiveItem::
	call DoesHLEqualNumItems
	jp nz, PutItemInPocket
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeValue]
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
; entries correspond to item types
	dw .Item
	dw .Med
	dw .Berry
	dw .Ball
	dw .TMHM
	dw .KeyItem

.Item:
	ld h, d
	ld l, e
	jmp PutItemInPocket

.KeyItem:
	ld h, d
	ld l, e
	jmp ReceiveKeyItem

.Ball:
	ld hl, wNumBalls
	jmp PutItemInPocket

.Med:
	ld hl, wNumMeds
	jmp PutItemInPocket

.Berry:
	ld hl, wNumBerries
	jmp PutItemInPocket

.TMHM:
	ld h, d
	ld l, e
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jmp ReceiveTMHM

_TossItem::
	call DoesHLEqualNumItems
	jr nz, .remove
	push hl
	call CheckItemPocket
	pop de
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
; entries correspond to item types
	dw .Item
	dw .Med
	dw .Berry
	dw .Ball
	dw .TMHM
	dw TossKeyItem

.Ball:
	ld hl, wNumBalls
	jmp RemoveItemFromPocket

.Med:
	ld hl, wNumMeds
	jmp RemoveItemFromPocket

.Berry:
	ld hl, wNumBerries
	jmp RemoveItemFromPocket

.TMHM:
.KeyItem:
	ret

.Item:
	ld h, d
	ld l, e

.remove
	jmp RemoveItemFromPocket

_CheckItem::
	call DoesHLEqualNumItems
	jr nz, .nope
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeValue]
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
; entries correspond to item types
	dw .Item
	dw .Med
	dw .Berry
	dw .Ball
	dw .TMHM
	dw .KeyItem

.Ball:
	ld hl, wNumBalls
	jmp CheckTheItem

.Med:
	ld hl, wNumMeds
	jmp CheckTheItem

.Berry:
	ld hl, wNumBerries
	jmp CheckTheItem

.TMHM:
	ld h, d
	ld l, e
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jmp CheckTMHM

.KeyItem:
	ld h, d
	ld l, e
	jmp CheckKeyItems

.Item:
	ld h, d
	ld l, e

.nope
	jmp CheckTheItem

DoesHLEqualNumItems:
	ld a, l
	cp LOW(wNumItems)
	ret nz
	ld a, h
	cp HIGH(wNumItems)
	ret

GetPocketCapacity:
	ld c, MAX_ITEMS
	ld a, e
	cp LOW(wNumItems)
	jr nz, .not_bag
	ld a, d
	cp HIGH(wNumItems)
	ret z

.not_bag
	ld c, MAX_MEDS
	ld a, e
	cp LOW(wNumMeds)
	jr nz, .not_meds
	ld a, d
	cp HIGH(wNumMeds)
	ret z

.not_meds
	ld c, MAX_BERRIES
	ld a, e
	cp LOW(wNumBerries)
	jr nz, .not_berries
	ld a, d
	cp HIGH(wNumBerries)
	ret z

.not_berries
	ld c, MAX_BALLS
	ret

PutItemInPocket:
	ld d, h
	ld e, l
	inc hl
	ld a, [wCurItem]
	ld c, a
	ld b, 0
.loop
	ld a, [hli]
	cp -1
	jr z, .terminator
	cp c
	jr nz, .next
	ld a, MAX_ITEM_STACK
	sub [hl]
	add b
	ld b, a
	ld a, [wItemQuantityChange]
	cp b
	jr z, .ok
	jr c, .ok

.next
	inc hl
	jr .loop

.terminator
	call GetPocketCapacity
	ld a, [de]
	cp c
	jr c, .ok
	and a
	ret

.ok
	ld h, d
	ld l, e
	ld a, [wCurItem]
	ld c, a
	ld a, [wItemQuantityChange]
	ld [wItemQuantity], a
.loop2
	inc hl
	ld a, [hli]
	cp -1
	jr z, .terminator2
	cp c
	jr nz, .loop2
	ld a, [wItemQuantity]
	add [hl]
	cp MAX_ITEM_STACK + 1
	jr nc, .newstack
	ld [hl], a
	jr .done

.newstack
	ld [hl], MAX_ITEM_STACK
	sub MAX_ITEM_STACK
	ld [wItemQuantity], a
	jr .loop2

.terminator2
	dec hl
	ld a, [wCurItem]
	ld [hli], a
	ld a, [wItemQuantity]
	push hl ; We save the RAM address of the item quantity.
	ld [hli], a
	ld [hl], -1
	ld h, d
	ld l, e
	inc [hl]
	pop hl

.done
	; Saving the item slot as the last visited pocket and slot.
	; This way, the player will automatically have the cursor put on the item next time the pack is opened.
	ld a, [wItemAttributeValue]
	dec a
	ld [wLastPocket], a

	cp TM_HM_POCKET
	jr z, .tm_hm_pocket

	cp KEY_ITEM_POCKET
	jr z, .key_item_pocket

	add a ; Doubles A.
	ld e, a
	ld d, 0
	dec hl ; We point to the RAM address of the last inserted element.
	push hl
	ld hl, .pocket_id_to_ram_address
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl] ; DE points to the RAM address of the pocket.
	pop hl

	call HLminusDE ; Result in DE.

	; Divides the result in DE by 2. Note: it will always fit within 1 byte, as a pocket always contains less than 256 entries.
	srl d
	rr e

	push de
	ld a, [wLastPocket]
	ld e, a
	ld d, 0
	ld hl, wItemsPocketScrollPosition
	add hl, de
	pop de

	ld a, e
	sub 3
	jr nc, .no_sub_underflow

	xor a
.no_sub_underflow
	ld [hl], a ; Storing the scroll value.

	; Moving HL from scroll address to corresponding cursor address.
	push de
	ld de, $ffff - (wItemsPocketScrollPosition - wItemsPocketCursor) + 1
	add hl, de
	pop de

	ld a, e
	inc a
	cp 4
	jr c, .dont_cap_cursor_value

	ld a, 4
.dont_cap_cursor_value
	ld [hl], a ; Storing the cursor value.

.tm_hm_pocket
.key_item_pocket
	scf
	ret

.pocket_id_to_ram_address
	dw wItems
	dw wMeds
	dw wBerries
	dw wBalls
	dw wTMsHMs
	dw wKeyItems

RemoveItemFromPocket:
	ld d, h
	ld e, l
	ld a, [hli]
	ld c, a
	ld a, [wCurItemQuantity]
	cp c
	jr nc, .ok ; memory
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [wCurItem]
	cp [hl]
	inc hl
	jr z, .skip
	ld h, d
	ld l, e
	inc hl

.ok
	ld a, [wCurItem]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .skip
	cp -1
	jr z, .nope
	inc hl
	jr .loop

.skip
	ld a, [wItemQuantityChange]
	ld b, a
	ld a, [hl]
	sub b
	jr c, .nope
	ld [hl], a
	ld [wItemQuantity], a
	and a
	jr nz, .yup
	dec hl
	ld b, h
	ld c, l
	inc hl
	inc hl
.loop2
	ld a, [hli]
	ld [bc], a
	inc bc
	cp -1
	jr nz, .loop2
	ld h, d
	ld l, e
	dec [hl]

.yup
	scf
	ret

.nope
	and a
	ret

CheckTheItem:
	ld a, [wCurItem]
	ld c, a
.loop
	inc hl
	ld a, [hli]
	cp -1
	jr z, .done
	cp c
	jr nz, .loop
	scf
	ret

.done
	and a
	ret

ReceiveKeyItem:
	ld hl, wNumKeyItems
	ld a, [hli]
	cp MAX_KEY_ITEMS
	jr nc, .nope

	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurItem]
	ld [hli], a
	ld [hl], -1

	; Saving the slot as the last visited slot.
	ld a, KEY_ITEM_POCKET
	ld [wLastPocket], a

	dec hl ; HL points to the last inserted key item.
	ld de, wKeyItems

	call HLminusDE ; Result in DE.

	ld a, e
	sub 3
	jr nc, .no_sub_underflow
	
	xor a
.no_sub_underflow
	ld [wKeyItemsPocketScrollPosition], a ; Storing the scroll value.

	ld a, e
	inc a
	cp 4
	jr c, .dont_cap_cursor_value

	ld a, 4
.dont_cap_cursor_value
	ld [wKeyItemsPocketCursor], a ; Storing the cursor value.

	; Increase the key items count in the pack.
	ld hl, wNumKeyItems
	inc [hl]
	scf
	ret

.nope
	and a
	ret

TossKeyItem:
	ld a, [wCurItemQuantity]
	ld e, a
	ld d, 0
	ld hl, wNumKeyItems
	ld a, [hl]
	cp e
	jr nc, .ok
	call .Toss
	ret nc
	jr .ok2

.ok
	dec [hl]
	inc hl
	add hl, de

.ok2
	ld d, h
	ld e, l
	inc hl
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .loop
	scf
	ret

.Toss:
	ld hl, wNumKeyItems
	ld a, [wCurItem]
	ld c, a
.loop3
	inc hl
	ld a, [hl]
	cp c
	jr z, .ok3
	cp -1
	jr nz, .loop3
	xor a
	ret

.ok3
	ld a, [wNumKeyItems]
	dec a
	ld [wNumKeyItems], a
	scf
	ret

CheckKeyItems:
	ld a, [wCurItem]
	ld c, a
	ld hl, wKeyItems
.loop
	ld a, [hli]
	cp c
	jr z, .done
	cp -1
	jr nz, .loop
	and a
	ret

.done
	scf
	ret

ReceiveTMHM:
	dec c
	ld e, c
	ld d, 0

	ld b, SET_FLAG
	ld hl, wTMsHMs
	push de
	call FlagAction
	pop de

	ld c, 0 ; C will store the index of the TM/HM within the TM/HM pocket.
	ld a, e ; E contains the original TM/HM index.

	; Divide A by 8.
	rrca
	rrca
	rrca
	and %00011111
	ld d, a ; We save the byte offset in D.
	jr z, .previous_bytes_bit_count_done

	ld b, a
	ld hl, wTMsHMs
	push de
	call CountSetBits ; Count the number of set bits in b bytes starting from hl. Return in a and c.
	pop de

.previous_bytes_bit_count_done
	ld a, e
	ld b, 8
	call Modulo

	ld b, a
	inc b
	ld a, $80

.bit_shift_loop
	scf
	rla
	dec b
	jr nz, .bit_shift_loop

	srl a ; A contains the final mask.
	ld e, d
	ld d, 0
	ld hl, wTMsHMs
	add hl, de
	and [hl] ; A now contains the filtered TM/HM bitfield.

	; Now we need to count the set bits in A. 
	; We'll use CountSetBits.
	; But it needs an HL address!
	; So we'll use wTempByteValue, and then backup its value once we don't need it anymore.

	ld hl, wTempByteValue
	ld e, [hl] ; Backup of wTempByteValue in E.
	ld [hl], a ; HL stores our filtered bitfield.

	ld d, c ; Backup of the previous result of CountSetBits.
	ld b, 1
	push de
	call CountSetBits
	pop de
	add d ; A contains the final index of the TM/HM within its pocket.
	ld c, a ; We store the index in C.

	ld a, e
	ld [wTempByteValue], a ; We reset its original value.

	ld a, TM_HM_POCKET
	ld [wLastPocket], a

	ld a, c
	sub 3
	jr nc, .no_sub_underflow
	
	xor a
.no_sub_underflow
	ld [wTMHMPocketScrollPosition], a ; Storing the scroll value.

	ld a, c
	cp 3
	jr c, .dont_cap_cursor_value

	ld a, 3
.dont_cap_cursor_value
	ld [wTMHMPocketCursor], a ; Storing the cursor value.

	; Return true.
	scf
	ret

CheckTMHM:
	dec c
	ld e, c
	ld d, 0

	ld b, CHECK_FLAG
	ld hl, wTMsHMs
	call FlagAction
	ld a, c
	and a
	ret z
	
	scf
	ret

GetTMHMNumber::
; Return the number of a TM/HM by item id c.
	ld a, c
; Skip any dummy items.
	cp ITEM_C3 ; TM04-05
	jr c, .done
	cp ITEM_DC ; TM28-29
	jr c, .skip
	dec a
.skip
	dec a
.done
	sub TM01
	inc a
	ld c, a
	ret

GetNumberedTMHM:
; Return the item id of a TM/HM by number c.
	ld a, c
; Skip any gaps.
	cp ITEM_C3 - (TM01 - 1)
	jr c, .done
	cp ITEM_DC - (TM01 - 1) - 1
	jr c, .skip_one
; skip two
	inc a
.skip_one
	inc a
.done
	add TM01
	dec a
	ld c, a
	ret

_CheckTossableItem::
; Return 1 in wItemAttributeValue and carry if wCurItem can't be removed from the bag.
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_TOSS_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

CheckSelectableItem:
; Return 1 in wItemAttributeValue and carry if wCurItem can't be selected.
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_SELECT_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

CheckItemPocket::
; Return the pocket for wCurItem in wItemAttributeValue.
	ld a, ITEMATTR_POCKET
	call GetItemAttr
	and $f
	ld [wItemAttributeValue], a
	ret

CheckItemContext:
; Return the context for wCurItem in wItemAttributeValue.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	and $f
	ld [wItemAttributeValue], a
	ret

CheckItemMenu:
; Return the menu for wCurItem in wItemAttributeValue.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	swap a
	and $f
	ld [wItemAttributeValue], a
	ret

GetItemAttr:
; Get attribute a of wCurItem.

	push hl
	push bc

	ld hl, ItemAttributes
	ld c, a
	ld b, 0
	add hl, bc

	xor a
	ld [wItemAttributeValue], a

	ld a, [wCurItem]
	dec a
	ld c, a
	ld a, ITEMATTR_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarByte

	pop bc
	pop hl
	ret

ItemAttr_ReturnCarry:
	ld a, 1
	ld [wItemAttributeValue], a
	scf
	ret

; Return the price of wCurItem in DE.
GetItemPrice:
	push hl
	push bc
	jr .get_inflated_price 

.revert_to_regular_price
	ld a, ITEMATTR_PRICE_LO
	call GetItemAttr
	ld e, a
	ld a, ITEMATTR_PRICE_HI
	call GetItemAttr
	ld d, a
	
.return
	pop bc
	pop hl
	ret

.get_inflated_price
	ld a, [wCurItem]
	cp X_SPECIAL + 1
	jr nc, .revert_to_regular_price ; Inflation only applies to items whose ID is up to X_SPECIAL.

	ld b, CHECK_FLAG
	ld de, EVENT_BEAT_ELITE_FOUR
	call EventFlagAction
	jr nz, .second_inflation

	ld b, CHECK_FLAG
	ld de, EVENT_FIRST_LOCKDOWN_STARTED
	call EventFlagAction
	jr nz, .first_inflation

	jr .revert_to_regular_price ; No inflation at the start of the game.

.second_inflation
	ld hl, InflatedPrices + 2
	jr .inflation_applied

.first_inflation
	ld hl, InflatedPrices
.inflation_applied
	ld a, [wCurItem]
	dec a
	ld bc, INFLATED_PRICE_STRUCT_LENGTH
	call AddNTimes
	
	ld a, BANK(InflatedPrices)
	call GetFarWord ; Returns price in HL.

	ld d, h
	ld e, l

	jr .return

; Output: the result of HL-DE in DE.
HLminusDE:
	ld a, l
	sub e
	ld e, a
	ld a, h
	sbc d
	ld d, a
	ret