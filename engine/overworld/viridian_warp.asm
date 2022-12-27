ViridianWarp::
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	ret nz

	call .SetRandomPairs

	ld a, [wPlayerFacing]
	and %1100
	cp OW_DOWN
	jr z, .CheckDownWarp
	cp OW_UP
	jr z, .CheckUpWarp
	cp OW_LEFT
	jr z, .CheckLeftWarp
	jr .CheckRightWarp


.SetRandomPairs:
	ld hl, ViridianWarpPairs
	ld bc, VIRIDIAN_VERTICAL_WARP_COUNT + VIRIDIAN_HORIZONTAL_WARP_COUNT
	ld de, wViridianVerticalWarpPair
	call CopyBytes
	ret




.CheckDownWarp:
	ld a, [wYCoord]
	srl a
	ret nc

	ld d, TRUE
	jr .vertical_start




.CheckUpWarp:
	ld a, [wYCoord]
	srl a
	ret c

	ld d, FALSE

; Input: D = TRUE if reverse index search is required.
.vertical_start
	ld b, 0
	ld c, 0
	ld hl, ViridianVerticalWarpsList + 1

.vertical_loop
	ld a, [wYCoord]
	srl a

	cp [hl] ; HL now points to X coord of ViridianVerticalWarpsList.
	push af
	dec hl
	pop af
	jr nz, .vertical_next

	ld a, [wXCoord]
	srl a

	cp [hl]
	jr nz, .vertical_next

	; Seamless warp to a vertical warp.
	ld a, d
	and a
	jr nz, VerticalReverseIndexWarp
	jr VerticalIndexWarp

.vertical_next
	inc hl
	inc hl
	inc hl
	inc c
	ld a, c
	cp VIRIDIAN_VERTICAL_WARP_COUNT
	ret z

	jr .vertical_loop





.CheckRightWarp:
	ld a, [wXCoord]
	srl a
	ret nc

	ld d, TRUE
	jr .horizontal_start

.CheckLeftWarp:
	ld a, [wXCoord]
	srl a
	ret c

	ld d, FALSE

; Input: D = TRUE if reverse index search is required.
.horizontal_start
	ld b, 0
	ld c, 0
	ld hl, ViridianHorizontalWarpsList + 1

.horizontal_loop
	ld a, [wYCoord]
	srl a

	cp [hl] ; HL now points to X coord of ViridianHorizontalWarpsList.
	push af
	dec hl
	pop af
	jr nz, .horizontal_next

	ld a, [wXCoord]
	srl a

	cp [hl]
	jr nz, .horizontal_next

	; Seamless warp to a vertical warp.
	ld a, d
	and a
	jr nz, HorizontalReverseIndexWarp
	jr HorizontalIndexWarp

.horizontal_next
	inc hl
	inc hl
	inc hl
	inc c
	ld a, c
	cp VIRIDIAN_HORIZONTAL_WARP_COUNT
	ret z

	jr .horizontal_loop





; Input: B = 0. C = index of the source warp.
VerticalIndexWarp:
	ld hl, wViridianVerticalWarpPair
	add hl, bc
	ld a, [hl] ; A now contains the ID of the pair.
	add a
	ld c, a
	jr VerticalReverseIndexWarp.IndexFound

; Input: C = index of the warp we are currently walking on (source warp).
VerticalReverseIndexWarp:
	ld hl, wViridianVerticalWarpPair
	ld b, VIRIDIAN_VERTICAL_WARP_COUNT
	call ReverseWarpSearch

.IndexFound
	ld hl, ViridianVerticalWarpsList
	add hl, bc

	ld a, [wXCoord]
	srl a ; We do this to retrieve the carry.

	ld a, [hli]
	adc a
	ld [wXCoord], a

	ld a, [hl]
	add a
	add d ; D is either 0 or 1.

	ld [wYCoord], a
	jr ApplySeamlessWarp





; Input: B = 0. C = index of the source warp.
HorizontalIndexWarp:
	ld hl, wViridianHorizontalWarpPair
	add hl, bc
	ld a, [hl] ; A now contains the ID of the pair.
	add a
	ld c, a
	jr HorizontalReverseIndexWarp.IndexFound

; Input: C = index of the warp we are currently walking on (source warp).
HorizontalReverseIndexWarp:
	ld hl, wViridianHorizontalWarpPair
	ld b, VIRIDIAN_HORIZONTAL_WARP_COUNT
	call ReverseWarpSearch

.IndexFound
	ld hl, ViridianHorizontalWarpsList + 1
	add hl, bc

	ld a, [wYCoord]
	srl a ; We do this to retrieve the carry.

	ld a, [hld]
	adc a
	ld [wYCoord], a

	ld a, [hl]
	add a
	add d ; D is either 0 or 1.

	ld [wXCoord], a
	jr ApplySeamlessWarp





; Input: HL = the address of the array to search from, B = the length of the array, C = the value to search in the array.
; Output: BC = the offset from the first element of the coord array. In other words, double the index of the found value.
ReverseWarpSearch:
	push de
	ld d, 0
	ld a, c
.loop
	cp [hl]
	jr z, .found

.next
	inc d
	inc hl
	dec b
	jr nz, .loop

	; We should never reach this place. Just in case, we manage the case.
	dec d

.found
	ld a, d
	add a
	ld c, a
	ld b, 0
	pop de
	ret

; Input: wXCoord and wYCoord must be set to the new destination.	
ApplySeamlessWarp:
	farcall RefreshPlayerCoords
	farcall GetMapScreenCoords
	ret

ViridianVerticalWarpsList:
	db 0, 3
	db 9, 3
	db 16, 13
	db 20, 13
	db 8, 20
	db 12, 20
	db 16, 7
	db 16, 19

ViridianHorizontalWarpsList:
	db 16, 0
	db 7, 14
	db 4, 17
	db 4, 23

ViridianWarpPairs:
	db 2, 7, 6, 5, 1, 0, 3, 4, 1, 2, 3, 0