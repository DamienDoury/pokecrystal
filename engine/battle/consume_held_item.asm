; This only works with berries, berry juice included.
ConsumeHeldItem:
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	and a

	ld hl, wOTPartyMon1Item
	ld de, wEnemyMonItem
	ld bc, wPartyItemsOutsideOfBattle ^ $ffff ; ~wPartyItemsOutsideOfBattle
	ld a, [wCurOTMon]
	jr z, .theirturn

	ld hl, wPartyMon1Item
	ld de, wBattleMonItem
	ld bc, wPartyItemsOutsideOfBattle
	ld a, [wCurBattleMon]

.theirturn
	push hl
	push bc
	push af
	ld a, [de]
	ld b, a
	farcall GetItemHeldEffect
	ld hl, ConsumableEffects
.loop
	ld a, [hli]
	cp b
	jr z, .ok

	inc a
	jr nz, .loop

	pop bc
	pop af
	pop hl
	pop bc
	pop de
	pop hl
	ret

.ok
	xor a
	ld [de], a ; Removes the item from wBattleMonItem / wEnemyMonItem.
	pop af ; Retrieves either wCurBattleMon or wCurOTMon.
	pop bc

	ld l, a ; Saving wCurBattleMon/wCurOTMon.
	ld a, c
	cp LOW(wPartyItemsOutsideOfBattle)
	ld a, l ; Retrieving wCurBattleMon/wCurOTMon.
	jr nz, .skip_remove_item_outside_of_battle ; If it's not the player's item, we skip the next part.

	ld h, 0
	add hl, bc ; Adds [wCurBattleMon] to wPartyItemsOutsideOfBattle.
	
	ld b, a ; Saving wCurBattleMon/wCurOTMon.
	xor a
	ld [hl], a ; Removes the player's item from wPartyItemsOutsideOfBattle.
	ld a, b ; Retrieving wCurBattleMon/wCurOTMon.

.skip_remove_item_outside_of_battle
	pop hl
	call GetPartyLocation
	ldh a, [hBattleTurn]
	and a
	jr nz, .ourturn

	ld a, [wBattleMode]
	dec a
	jr z, .done

.ourturn
	ld [hl], NO_ITEM ; Removes the item from wPartyMon / wOTPartyMon.

.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/battle/held_consumables.asm"
