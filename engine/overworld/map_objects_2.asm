LoadObjectMasks: ; Called NUM_OBJECTS times, so it better be optimized now that I doubled the original amount.
	ld hl, wObjectMasks
	xor a
	ld bc, NUM_OBJECTS
	call ByteFill
	nop
	ld bc, wMapObjects
	ld de, wObjectMasks
	xor a
.loop
	push af
	push bc
	push de
	call GetObjectTimeMask
	jr c, .next
	call CheckLockdownMask
	jr c, .next
	call CheckObjectFlag
.next
	pop de
	ld [de], a
	inc de
	pop bc
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

CheckObjectFlag:
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .masked
	cp SPRITE_OFFICER
	jr nz, .go_on

	ld a, [wCurWantedLevel]
	cp 2 ; Jenny's wanted level.
	jr z, .jenny

	ld a, [wCurWantedLevel]
	cp 3 ; SWAT's wanted level.
	jr nz, .go_on

; Turning the Officer sprite color to brown for the SWAT.
; Note: the map_event object is stored in the order of object_event: MACRO
	ld e, 7
	ld d, 0
	add hl, de
	ld a, PAL_NPC_BROWN
	swap a ; Swap the upper and lower nibbles.
	ld d, a
	ld a, [hl] ; We retrieve the byte that contains the palette (upper nibble) and the object_type (lower nibble).
	and $0F ; We mask out the upper nibble
	or d ; Now the palette has been edited
	ld [hl], a ; We save the new palette.
	jr .go_on

.jenny
	ld a, SPRITE_JENNY
	ld [hl], a ; Updating the sprite.

.go_on
	ld hl, MAPOBJECT_EVENT_FLAG
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	cp -1
	jr nz, .check
	ld a, e
	cp -1
	jr z, .unmasked
	jr .masked
.check
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr nz, .masked
.unmasked
	xor a
	ret

.masked
	ld a, -1
	scf
	ret

GetObjectTimeMask:
	call CheckObjectTime
	ld a, -1
	ret c
	xor a
	ret

CheckLockdownMask:
	ld hl, MAPOBJECT_HOUR
	add hl, bc
	ld a, [hl]
	and %11100000 ; Damien: we only need to read the rightmost 5 bits for a 24 hours time (<= 31), and we use the last 3 bits for the "law condition" or "lockdown condition".
	srl a
	swap a
	ld h, a
	ld a, [wCurFreedomState]
	and h
	jr nz, .ok
	ld a, -1
	scf
	ret
.ok
	xor a
	ret
