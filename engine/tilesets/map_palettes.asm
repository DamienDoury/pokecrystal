_SwapTextboxPalettes::
	hlcoord 0, 0
	decoord 0, 0, wAttrmap
	ld b, SCREEN_HEIGHT
.loop
	push bc
	ld c, SCREEN_WIDTH

	call GetBGMapTilePalettes

	pop bc
	dec b
	jr nz, .loop
	ret

_ScrollBGMapPalettes::
	ld hl, wBGMapBuffer
	ld de, wBGMapPalBuffer
	; fallthrough

GetBGMapTilePalettes:
.loop
	ld a, [hl]
	push af
	push hl
	srl a
	jr c, .UpperNybble

; .LowerNybble
	ld hl, wTilesetPalettes
	add [hl]
	ld l, a
	ld a, [wTilesetPalettes + 1]
	adc 0
	ld h, a
	ld a, [hl]
	and $f
	jr .next

.UpperNybble:
	ld hl, wTilesetPalettes
	add [hl]
	ld l, a
	ld a, [wTilesetPalettes + 1]
	adc 0
	ld h, a
	ld a, [hl]
	swap a
	and $f

.next
	pop hl





	ld b, a; B contains the palette without priority added.

	pop af
	cp $34 		; Bed tile 1.
	jr z, .priority_second_check
	cp $35 		; Bed tile 2.
	jr z, .priority_second_check
	jr .done_with_priority

.priority_second_check
	ld a, [wMapGroup]
	cp GROUP_GOLDENROD_HOSPITAL_ROOM
	jr nz, .done_with_priority

	ld a, [wMapNumber]
	cp MAP_GOLDENROD_HOSPITAL_ROOM
	jr nz, .done_with_priority

	; Adding priority.
	ld a, b
	or $80
	ld b, a
	



.done_with_priority
	ld a, b




	ld [de], a
	res 7, [hl]
	inc hl
	inc de
	dec c
	jr nz, .loop
	ret
