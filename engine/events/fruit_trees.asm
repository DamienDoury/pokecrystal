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
	promptbutton
	sjump .soil_check

.fruit
	writemem wItemQuantityChange
	getnum STRING_BUFFER_4
	writetext HeyItsFruitText
	promptbutton

	writetext PickUpFruitsText
	yesorno
	iffalse .soil_check

	readmem wCurFruit
	giveitem ITEM_FROM_MEM, ITEM_QUANTITY_FROM_MEM
	iffalse .packisfull
	
	writetext ObtainedFruitText
	callasm PickedFruitTree
	specialsound
	itemnotify
	loadmem wWalkingAbuseGuard, 0
	sjump .close_text

.soil_check
	readmem wCurFruitTreeSoilHumidity
	iffalse .dry

;.wet
	writetext WetSoilText
	sjump .wait_then_close_text

.dry
	writetext DrySoilText

	checkitem SQUIRTBOTTLE
	iffalse .wait_then_close_text

	promptbutton
	writetext AskWaterSoilText
	yesorno
	iffalse .close_text

	closetext
	sjump SquirtbottleOnFruitTreeScript

.packisfull
	promptbutton
	writetext FruitPackIsFullText
.wait_then_close_text
	waitbutton
.close_text
	closetext
	end

SquirtbottleOnFruitTreeScript::
	callasm CheckFruitTreeSoil
	farscall Script_PullOutSquirtbottle

	opentext
	readmem wCurFruitTreeWaterFlags
	callasm WaterCurFruitTree
	ifnotequal 0, .plenty_of_water

	; If the fruit count wasn't boosted, and it's the first time the player waters this fruit tree today,
	; we let them know that their action has been impactful.
	writetext FruitTreeGotStrongerText
	sjump .wait_and_close

.plenty_of_water
	farwritetext _FruitPlentyOfWaterText
.wait_and_close
	waitbutton
	closetext
	end


GetCurTreeFruit:
	ld a, [wCurFruitTree]
	dec a
	call GetFruitTreeItem
	ld [wCurFruit], a
	ret

CountFruitsInTree:
	call CheckFruitTreeSoil

	ld hl, wFruitTreeFlags
	call ApplyFruitTreeOffset
	ld l, a
	ld a, [wCurFruitCountBoosted]
	cp FALSE
	ld a, l
	jr z, .return_result

	; x2 - 1
	add a
	dec a
.return_result
	ld [wScriptVar], a
	ret

CheckFruitTreeSoil:
	ld hl, wFruitTreeWaterFlags
	call ApplyFruitTreeOffset

	ld [wCurFruitTreeWaterFlags], a

	ld l, a ; Bit 0 = TRUE means watered today; Bit 1 = TRUE means fruit count boosted.
	and %1
	ld [wCurFruitTreeSoilHumidity], a
	
	ld a, l
	and %10
	srl a
	ld [wCurFruitCountBoosted], a
	ret

ApplyFruitTreeOffset:
	ld a, [wCurFruitTree]
	dec a
	push bc
	ld c, 4
	call SimpleDivide ; Divide a by c. Return quotient b and remainder a.
	ld c, b
	ld b, 0
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
	pop bc
	ret

WaterCurFruitTree:
	ld a, [wCurFruitTree]
	dec a
	add a
	ld e, a
	ld d, 0
	ld hl, wFruitTreeWaterFlags
	ld b, SET_FLAG
	call FlagAction
	ret

GrowBerries::
	; Water penetration into the soil.
	; Provides a fruit count boost once it happened.
	push bc
	ld b, ((NUM_FRUIT_TREES * 2) + 7) / 8
	ld hl, wFruitTreeWaterFlags
.water_loop
	ld a, [hl]
	ld c, a
	and %01010101 ; We retrieve the "watered today" flags.
	sla a
	or c ; The "watered today" set the "fruit count boost" flags.
	and %10101010 ; We clear the "watered today" flags.
	ld [hli], a ; Saving the result and moving on to the next tree set.
	dec b
	jr nz, .water_loop

	pop bc

	; Growing the adequate number of berries, 
	; based on the number of days passed.
	ld a, b
	cp 4
	jr c, .loop
	
	ld a, 3 ; Can't grow more than 3 berries.
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

	; Removing the fruit count boost from the tree.
	ld a, [wCurFruitTree]
	dec a
	add a
	inc a
	ld e, a
	ld d, 0
	ld hl, wFruitTreeWaterFlags
	ld b, RESET_FLAG
	call FlagAction
	
	; Removing all berries from the tree.
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

PickUpFruitsText:
	text_far _PickUpFruitsText
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

DrySoilText:
	text_far _DrySoilText
	text_end

WetSoilText:
	text_far _WetSoilText
	text_end

AskWaterSoilText:
	text_far _AskWaterSoilText
	text_end

FruitTreeGotStrongerText:
	text_far _FruitTreeGotStrongerText
	text_end
