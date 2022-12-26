ViridianWarp::
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	ret nz

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	ret nz

	ld hl, wPlayerStandingMapY
	ld a, [hld] ; Y coord.
	cp 7 + 4
	jr nz, .next_check

	ld a, [hl] ; X coord.
	cp 0 + 4
	jr nz, .next_check

	; At this point, we know the player is standing on the warp tile.

	add 16
	;ld [hl], a ; Warp. Insufisiant.
	sub 4
	ld [wXCoord], a
	farcall RefreshPlayerCoords
	farcall GetMapScreenCoords

.next_check
	ret
