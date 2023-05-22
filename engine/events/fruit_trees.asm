FruitTreeScript::
	callasm GetCurTreeFruit
	opentext
	readmem wCurFruit
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	writetext FruitBearingTreeText
	promptbutton
	callasm CountFruitsInTree
	ifgreater 0, .fruit
	writetext NothingHereText
	waitbutton
	sjump .end

.fruit
	writemem wItemQuantityChange
	getnum STRING_BUFFER_4
	writetext HeyItsFruitText
	readmem wCurFruit
	giveitem ITEM_FROM_MEM, ITEM_QUANTITY_FROM_MEM
	iffalse .packisfull
	promptbutton
	
	writetext ObtainedFruitText
	callasm PickedFruitTree
	specialsound
	itemnotify
	sjump .end

.packisfull
	promptbutton
	writetext FruitPackIsFullText
	waitbutton

.end
	closetext
	end

GetCurTreeFruit:
	ld a, [wCurFruitTree]
	dec a
	call GetFruitTreeItem
	ld [wCurFruit], a
	ret

CountFruitsInTree:
	ld a, [wCurFruitTree]
	dec a
	push bc
	ld c, 4
	call SimpleDivide ; Divide a by c. Return quotient b and remainder a.
	ld c, b
	ld b, 0
	ld hl, wFruitTreeFlags
	add hl, bc

	ld b, [hl]
	and a
.loop
	jr z, .mask_ok

	srl b
	srl b
	dec a
	jr .loop

.mask_ok
	ld a, b
	and %11
	ld [wScriptVar], a
	pop bc
	ret

GrowBerries::
	ld a, b
	cp 4
	jr c, .loop
	
	ld a, 3
.loop
	and a
	ret z
	push af
	call GrowOneBerryInAllTrees
	pop af
	dec a
	jr .loop

GrowOneBerryInAllTrees::
	ld hl, wFruitTreeFlags

	push bc
	push de
	ld b, ((NUM_FRUIT_TREES * 2) + 7) / 8
.loop
	ld a, [hl]
	ld e, a
	and %01010101
	ld d, a

	ld a, e
	srl a
	and %01010101
	and d
	cpl
	and %01010101
	add e
	ld [hli], a

	dec b
	jr nz, .loop

	pop de
	pop bc
	ret

PickedFruitTree:
	farcall StubbedTrainerRankings_FruitPicked
	
	ld a, [wCurFruitTree]
	dec a
	push bc
	ld c, 4
	call SimpleDivide ; Divide a by c. Return quotient b and remainder a.
	ld c, b
	ld b, 0
	ld hl, wFruitTreeFlags
	add hl, bc

	ld b, $ff - %11
	and a
.loop
	jr z, .mask_ok

	rlc b
	rlc b
	dec a
	jr .loop

.mask_ok
	ld a, [hl]
	and b
	ld [hl], a
	pop bc
	ret

GetFruitTreeItem:
	push hl
	push de
	ld e, a
	ld d, 0
	ld hl, FruitTreeItems
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

INCLUDE "data/items/fruit_trees.asm"

FruitBearingTreeText:
	text_far _FruitBearingTreeText
	text_end

HeyItsFruitText:
	text_far _HeyItsFruitText
	text_end

ObtainedFruitText:
	text_far _ObtainedFruitText
	text_end

FruitPackIsFullText:
	text_far _FruitPackIsFullText
	text_end

NothingHereText:
	text_far _NothingHereText
	text_end
