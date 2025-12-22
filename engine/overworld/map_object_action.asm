ObjectActionPairPointers:
; entries correspond to OBJECT_ACTION_* constants (see constants/map_object_constants.asm)
	table_width 2 + 2, ObjectActionPairPointers
	;  normal action,                  frozen action
	dw SetFacingStanding,              SetFacingStanding
	dw SetFacingStandAction,           SetFacingCurrent
	dw SetFacingStepAction,            SetFacingCurrent
	dw SetFacingBumpAction,            SetFacingCurrent
	dw SetFacingCounterclockwiseSpin,  SetFacingCurrent
	dw SetFacingCounterclockwiseSpin2, SetFacingStanding
	dw SetFacingFish,                  SetFacingFish
	dw SetFacingShadow,                SetFacingStanding
	dw SetFacingEmote,                 SetFacingEmote
	dw SetFacingBigDollSym,            SetFacingBigDollSym
	dw SetFacingBounce,                SetFacingFreezeBounce
	dw SetFacingWeirdTree,             SetFacingCurrent
	dw SetFacingBigDollAsym,           SetFacingBigDollAsym
	dw SetFacingBigDoll,               SetFacingBigDoll
	dw SetFacingBoulderDust,           SetFacingStanding
	dw SetFacingGrassShake,            SetFacingStanding
	dw SetFacingSkyfall,               SetFacingCurrent
	dw SetFacingSprinkle,              SetFacingSprinkle
	dw SetFacingRunAction,             SetFacingCurrent
	assert_table_length NUM_OBJECT_ACTIONS

SetFacingCounterclockwiseSpin2:
	call CounterclockwiseSpinAction
	; fallthrough.

SetFacingStanding:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], STANDING
	ret

SetFacingStandAction:
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld a, [hl]
	and CLAP_F
	jr z, .stand_normal

; check clapping time
	ld a, [wClappingData]
	bit CLAP_BEHAVIOUR_BIT, a
	jp nz, SetFacingBounceHuman

.stand_normal
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	and 1
	jr nz, SetFacingStepAction

	; fallthrough.

SetFacingCurrent:
	call GetSpriteDirection
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingStepAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING_F, [hl]
	jp nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	rrca
	rrca
	rrca
	and %11
	ld d, a
	call GetSpriteDirection
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingSkyfall:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING_F, [hl]
	jp nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	add 2
	and %00001111
	ld [hl], a

	rrca
	rrca
	maskbits NUM_DIRECTIONS
	ld d, a

	call GetSpriteDirection
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingBumpAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING_F, [hl]
	jp nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]

	ld a, [hl]
	rrca
	rrca
	rrca
	maskbits NUM_DIRECTIONS
	ld d, a

	call GetSpriteDirection
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingCounterclockwiseSpin:
	call CounterclockwiseSpinAction
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingBounceHuman:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	and %00000011
	ld [hl], a
	and a
	jr nz, .default_facing

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	ret

.default_facing
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, $f0
	cp [hl]
	jp c, SetFacingCurrent
	ret

CounterclockwiseSpinAction:
; Here, OBJECT_STEP_FRAME consists of two components,
; bits 0,1,2 form a 3-bit timer (6 overworld frames) 
; and bits 4,5 form a 2-bit value that determines the facing - the direction is counterclockwise.
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	and %11110000
	ld e, a

	ld a, [hl]
	inc a
	and %00001111
	ld d, a
	cp 6
	jr c, .ok

	ld d, 0
	ld a, e
	add $10
	and %00110000
	ld e, a

.ok
	ld a, d
	or e
	ld [hl], a

	swap e
	ld d, 0
	ld hl, .facings
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret

.facings:
	db OW_DOWN
	db OW_RIGHT
	db OW_UP
	db OW_LEFT

SetFacingSprinkle:
	call GetSpriteDirection
	rrca
	rrca
	add FACING_SPRINKLE_DOWN
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingFish:
	call GetSpriteDirection
	rrca
	rrca
	add FACING_FISH_DOWN
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingShadow:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_SHADOW
	ret

SetFacingEmote:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_EMOTE
	ret

SetFacingBigDollSym:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_BIG_DOLL_SYM
	ret

SetFacingBounce:
	ld a, [bc]
	cp SPRITE_NURSE
	jr z, .nurse_timer

	cp SPRITE_HOSPITAL_VISITOR ; No Pokémon use this variable sprite. 4 Nurses do.
	jr z, .nurse_timer

	cp SPRITE_HOSPITAL_HUMAN_PATIENT ; No Pokémon use this variable sprite. 2 Nurses do.
	jr z, .nurse_timer

	ld d, %00011111
	ld e, %00010000
	jr .got_timer

	; Nurse bow at half the pokemon frequency.
.nurse_timer
	ld d, %00111111
	ld e, %00100000
.got_timer
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	and d
	ld [hl], a
	and e
	jr z, SetFacingFreezeBounce

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_STEP_UP_0
	ret

SetFacingFreezeBounce:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_STEP_DOWN_0
	ret

SetFacingWeirdTree:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	ld [hl], a
	maskbits NUM_DIRECTIONS, 2
	rrca
	rrca
	add FACING_WEIRD_TREE_0
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingBigDollAsym:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_BIG_DOLL_ASYM
	ret

SetFacingBigDoll:
	ld a, [wVariableSprites + SPRITE_BIG_DOLL - SPRITE_VARS]
	ld d, FACING_BIG_DOLL_SYM ; symmetric
	cp SPRITE_BIG_SNORLAX
	jr z, .ok
	cp SPRITE_BIG_LAPRAS
	jr z, .ok
	ld d, FACING_BIG_DOLL_ASYM ; asymmetric

.ok
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], d
	ret

SetFacingBoulderDust:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	and 2
	ld a, FACING_BOULDER_DUST_1
	jr z, .ok
	inc a
	assert FACING_BOULDER_DUST_1 + 1 == FACING_BOULDER_DUST_2
.ok
	ld [hl], a
	ret

SetFacingGrassShake:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	and 4
	ld a, FACING_GRASS_1
	jr z, .ok
	inc a ; FACING_GRASS_2

.ok
	ld [hl], a
	ret

SetFacingRunAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING_F, [hl]
	jp nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	rrca
	rrca
	and %11
	ld d, a
	call GetSpriteDirection
	or d
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret