ViridianWarp::
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	ret nz

	ld hl, wYCoord
	ld a, [hli] ; Y coord.
	cp 7
	ret nz
	;jr nz, .next_check

	ld a, [hl] ; X coord.
	srl a
	cp 0
	jr z, .warp_shift_right

	; At this point, we know the player is standing on the warp tile.

.next_check
	cp 8
	jr z, .warp_shift_left

	ret

.warp_shift_left
	ld a, [hl] ; X coord.
	sub 16
	jr .warp_shift

.warp_shift_right
	ld a, [hl]
	add 16

.warp_shift
	ld [wXCoord], a
	farcall RefreshPlayerCoords
	farcall GetMapScreenCoords
	ret