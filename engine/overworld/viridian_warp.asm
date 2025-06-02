ViridianWarp::
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	ret nz

	ld b, CHECK_FLAG
	ld de, EVENT_FOUGHT_ZAPDOS
	call EventFlagAction
	ld a, c
	and a
	ret nz

	ld a, [wPlayerFacing]
	and %1100
	cp OW_DOWN
	jr z, .CheckDownWarp
	cp OW_UP
	jr z, .CheckUpWarp
	cp OW_LEFT
	jr z, .CheckLeftWarp
	jr .CheckRightWarp





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






ShuffleAllViridianWarps::
	call PrepopulateViridianWarps

	ld hl, wViridianVerticalWarpPair
	ld b, VIRIDIAN_VERTICAL_WARP_COUNT - 1
	ld d, 0
	call ShuffleViridianWarps

	ld hl, wViridianHorizontalWarpPair
	ld b, VIRIDIAN_HORIZONTAL_WARP_COUNT - 1
	ld d, VIRIDIAN_VERTICAL_WARP_COUNT
	jp ShuffleViridianWarps




PrepopulateViridianWarps:
	ld b, VIRIDIAN_VERTICAL_WARP_COUNT
	ld c, 0
	ld hl, wViridianVerticalWarpPair
	ld a, c

.loop
	call Modulo
	ld [hli], a

	inc c
	ld a, c
	cp VIRIDIAN_VERTICAL_WARP_COUNT + VIRIDIAN_HORIZONTAL_WARP_COUNT
	ret z
	jr .loop

; Input: HL = first entry of the array. The array must be sorted. B = array length - 1 (= last index). D = start index for the rand generator.
; Output: HL array shuffled. No value can be the same it was.
ShuffleViridianWarps:
	ld a, b
	call GetFixedRand
	inc a
	call SwapArrayEntries
	inc hl
	inc d
	dec b
	jr nz, ShuffleViridianWarps
	ret

; Input: HL = first entry. A = index offset from HL entry.
; Output: In-memory values swapped.
SwapArrayEntries:
	push bc
	push de
	ld c, [hl]
	ld e, a
	ld d, 0
	push hl
	add hl, de
	ld e, [hl]
	ld [hl], c
	pop hl
	ld [hl], e
	pop de
	pop bc
	ret

; Gets a random value based on the player ID, first 2 chars of the player name, and first 2 chars of the rival name.
; Input: D = the offset for the rand seed (< 12). B = the modulo. Note: the value before modulo is lower than 16 (it's a nybble).
GetFixedRand:
	push de
	push hl

	ld hl, wPlayerID
	ld a, d
	cp 8
	jr c, .hlDetermined

	ld hl, wRivalName
	sub 8
.hlDetermined
	srl a
	ld e, a
	ld d, 0
	push af ; Saving the carry from srl.
	add hl, de
	pop af
	ld a, [hl]
	jr nc, .nybbleDetermined

	swap a
.nybbleDetermined
	and $f ; Masking the lower nybble.
	call Modulo

	pop hl
	pop de
	ret


ViridianVerticalWarpsList:
	db 0, 5
	db 9, 5
	db 16, 15
	db 20, 15
	db 8, 22
	db 12, 22
	db 16, 9
	db 16, 21

ViridianHorizontalWarpsList:
	db 16, 2
	db 7, 16
	db 4, 19
	db 4, 25
