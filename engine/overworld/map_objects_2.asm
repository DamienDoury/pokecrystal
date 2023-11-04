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

	;push bc
	;push hl
	;ld bc, MAPOBJECT_COLOR - MAPOBJECT_SPRITE
	;add hl, bc
	;ld a, [hl]
	;swap a
	;and $f
	;cp PAL_NPC_BLUE
	;pop hl
	;pop bc

	ld a, [wEnvironment]
	cp ROUTE
	jr nz, .go_on ; Police controls only take place on Routes.

	ld a, [wCurWantedLevel]
	cp 2 ; Jenny's wanted level.
	jr z, .jenny

	cp 1 ; Sergeant's wanted level.
	ld a, PAL_NPC_RED
	jr z, .sergeant

	ld a, [wCurWantedLevel]
	cp 3 ; SWAT's wanted level.
	jr nz, .go_on

	ld a, PAL_NPC_BROWN

; Turning the Officer sprite color to brown for the SWAT or red for the Sergeant.
; Note: the map_event object is stored in the order of object_event: MACRO
.sergeant
	ld e, MAPOBJECT_COLOR - MAPOBJECT_SPRITE
	ld d, 0
	add hl, de
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
	and $f0
	; 5 bits are required to store a 24 hours time.
	; However, as we now need 4 bytes for the lockdown mask, we are left with only 4 bytes for the hour (0-15h).
	; Because of that, we add 4 to the start hour to have a start hour range from 4 to 18 (19th hour can't be used because %11111 is reserved as a special value).
	swap a
	ld h, a
	ld a, [wCurFreedomState]
	and h
	jr z, .return_false

;.lockdown_flag_matches_freedom_state
	and (1 << LOCKDOWN) | (1 << CURFEW) ; If [wCurFreedomState] is LOCKDOWN or CURFEW, we need to further refine by wanted level.
	jr z, .return_true ; As the freedom flag of the object do match the current freedom state, then we should return true. However, if it's a lockdown, then we need further refinement.
	
	; ***** WANTED LEVEL FILTER *****
	ld hl, MAPOBJECT_TIMEOFDAY
	add hl, bc
	ld a, [hl]
	and %11100000
	srl a
	swap a
	cp RESEARCH_ANY
	jr z, .return_true ; If the map_object has the filter RESEARCH_ANY, then if can always appear during lockdown. RESEARCH_ANY is the default value (-1) of MAPOBJECT_TIMEOFDAY.
	
	ld h, a
	ld a, [wCurWantedLevel]
	cp h
	jr z, .return_true ; If the wanted level matches the wanted level of the map_object, then it should appear.

	cp RESEARCH_2
	jr c, .return_false ; If the [wCurWantedLevel] is 0 or 1 at this point, we return false.

	; If [wCurWantedLevel] is 2 or 3, then the map_object has one more chance to be displayed, as level 2 also displays level 0, and level 3 also displays level 1.
	sub 2
	cp h
	jr z, .return_true
	; Otherwise we return false.

.return_false
	ld a, -1
	scf
	ret

.return_true
	xor a
	ret
