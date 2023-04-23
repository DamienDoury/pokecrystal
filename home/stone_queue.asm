HandleStoneQueue::
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank
	call .WarpAction

	pop bc
	ld a, b
	rst Bankswitch
	ret

.WarpAction:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .nope

	ld l, a
	push hl
	call .IsObjectOnWarp
	pop hl
	jr nc, .nope
	ld d, a
	ld e, l
	call .IsObjectInStoneTable
	jr nc, .nope
	call CallMapScript
	farcall EnableScriptMode
	scf
	ret

.nope
	and a
	ret

.IsObjectOnWarp:
	push de

	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld e, [hl]

	sub 4
	ld d, a
	ld a, e
	sub 4
	ld e, a
	call .check_on_warp

	pop de
	ret

.check_on_warp
	ld hl, wCurMapWarpsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurMapWarpCount]
	and a
	jr z, .nope2

.loop
	push af
	ld a, [hl]
	cp e
	jr nz, .not_on_warp
	inc hl
	ld a, [hld]
	cp d
	jr nz, .not_on_warp
	jr .found_warp

.not_on_warp
	ld a, WARP_EVENT_SIZE
	add l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry

	pop af
	dec a
	jr nz, .loop

.nope2
	and a
	ret

.found_warp
	pop af
	ld d, a
	ld a, [wCurMapWarpCount]
	sub d
	inc a
	scf
	ret

.IsObjectInStoneTable:
	inc e
	ld hl, CMDQUEUE_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop2
	ld a, [hli]
	cp $ff
	jr z, .nope3
	cp d
	jr nz, .next_inc3
	ld a, [hli]
	cp e
	jr nz, .next_inc2
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .yes

.next_inc3
	inc hl

.next_inc2
	inc hl
	inc hl
	jr .loop2

.nope3
	and a
	ret

.yes
	scf
	ret








CheckSokobanStone::
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank
	call .CheckPlacement

	pop bc
	ld a, b
	rst Bankswitch
	ret

.CheckPlacement:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .nope

	call .IsStoneOnWeakGround
	jr nc, .nope

	; At this point, we know the stone is correctly placed.
	ld a, [wSokobanPlacedStonesCount]
	inc a
	ld [wSokobanPlacedStonesCount], a
	
	push bc
	ld b, a
	ld a, [wSokobanTargetsCount]
	cp b
	pop bc

	jr nz, .nope

	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	
	call CallMapScript
	farcall EnableScriptMode
	scf
	ret

.nope
	and a
	ret

.IsStoneOnWeakGround:
	push bc

	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld a, [hl]
	sub 4
	ld b, a

	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld a, [hl]
	sub 4
	ld c, a

	call .CheckOnWeakGround

	pop bc
	ret

; Inputs:
; B = X coord of the current stone.
; C = Y coord of the current stone.
;
; Output:
; Carry is true (== if the stone is on weak ground).
.CheckOnWeakGround
	ld a, b
	ld hl, wSokobanTargetsXStart
	cp [hl]
	jr c, .nope

	dec a
	inc hl
	cp [hl]
	jr nc, .nope

	ld a, c ; Loading the Y coord of the stone.
	inc hl
	cp [hl]
	jr c, .nope

	dec a
	inc hl
	cp [hl]
	jr nc, .nope

	scf ; Returns true.
	ret