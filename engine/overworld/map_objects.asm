INCLUDE "data/sprites/facings.asm"

INCLUDE "data/sprites/map_objects.asm"

DeleteMapObject::
	push bc
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	pop af
	cp -1
	jr z, .ok
	bit 7, a
	jr nz, .ok
	call GetMapObject
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld [hl], -1
.ok
	pop bc
	ret

HandleLastTalkedStep::
	ldh a, [hLastTalked]
	ld hl, wPlayerObjectStructID
	ld bc, MAPOBJECT_LENGTH
	call AddNTimes
	ld a, [hl]
	ldh [hMapObjectIndex], a
	call GetObjectStruct
	jr HandleObjectStep.skip_visibility

HandleObjectStep:
	call CheckObjectStillVisible
	ret c

.skip_visibility
	call HandleStepType
	jmp HandleObjectAction

CheckObjectStillVisible:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OBJ_FLAGS2_6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .ok
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .ok
	jr .yes

.ok
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OBJ_FLAGS2_6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok2
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .ok2
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok2
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .ok2
.yes
	and a
	ret

.ok2
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit WONT_DELETE_F, [hl]
	jr nz, .yes2
	call DeleteMapObject
	scf
	ret

.yes2
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OBJ_FLAGS2_6, [hl]
	and a
	ret

HandleStepType:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .zero
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit FROZEN_F, [hl]
	jr nz, .frozen
	cp STEP_TYPE_FROM_MOVEMENT
	jr z, .one
	jr .ok3

.zero
	call StepFunction_Reset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit FROZEN_F, [hl]
	jr nz, .frozen
.one
	call StepFunction_FromMovement
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	ret z
	cp STEP_TYPE_FROM_MOVEMENT
	ret z
.ok3
	ld hl, StepTypesJumptable
	rst JumpTable
	ret

.frozen
	ret

HandleObjectAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, SetFacingStanding
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OBJ_FLAGS2_6, [hl]
	jr nz, SetFacingStanding
	bit FROZEN_F, [hl]
	jr nz, _CallFrozenObjectAction
; use first column (normal)
	ld de, ObjectActionPairPointers
	jr CallObjectAction

HandleFrozenObjectAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, SetFacingStanding
_CallFrozenObjectAction:
; use second column (frozen)
	ld de, ObjectActionPairPointers + 2
	; fallthrough. ; pointless

CallObjectAction:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld a, [hl]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp _hl_

INCLUDE "engine/overworld/map_object_action.asm"

CopyNextCoordsTileToStandingCoordsTile:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld [hl], a
	call SetTallGrassFlags
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	ret

CopyStandingCoordsTileToNextCoordsTile:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld [hl], a
	ret

UpdateTallGrassFlags:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OVERHEAD_F, [hl]
	jr z, .ok
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	call SetTallGrassFlags
.ok
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	ret

SetTallGrassFlags:
	call CheckSuperTallGrassTile
	jr z, .set
	call CheckGrassTile
	jr c, .reset
.set
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OVERHEAD_F, [hl]
	ret

.reset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	ret

EndSpriteMovement:
	xor a
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld [hli], a
	ld [hli], a ; OBJECT_1C
	ld [hli], a ; OBJECT_1D
	ld [hl], a  ; OBJECT_1E
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

InitStep:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit FIXED_FACING_F, [hl]
	jr nz, GetNextTile
	add a
	add a
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	; fallthrough

GetNextTile:
	call GetStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld a, d
	call GetStepVectorSign
	ld hl, OBJECT_MAP_X
	add hl, bc
	add [hl]
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, e
	call GetStepVectorSign
	ld hl, OBJECT_MAP_Y
	add hl, bc
	add [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld [hl], a
	ld e, a
	push bc
	call GetCoordCollType
	pop bc
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a
	ret

AddStepVector:
	call GetStepVector
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ret

GetStepVector:
; Return (x, y, duration, speed) in (d, e, a, h).
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001111
	add a
	add a
	ld l, a
	ld h, 0
	ld de, StepVectors
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ret

StepVectors:
; x,  y, duration, speed
	; slow
	db  0,  1, 16, 1
	db  0, -1, 16, 1
	db -1,  0, 16, 1
	db  1,  0, 16, 1
	; normal
	db  0,  2,  8, 2
	db  0, -2,  8, 2
	db -2,  0,  8, 2
	db  2,  0,  8, 2
	; fast
	db  0,  4,  4, 4
	db  0, -4,  4, 4
	db -4,  0,  4, 4
	db  4,  0,  4, 4

GetStepVectorSign:
	add a
	ret z  ; 0 or 128 (-128)
	ld a, 1
	ret nc ; +1 to +127
	ld a, -1
	ret    ; -127 to -1

UpdatePlayerStep:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00000011
	ld [wPlayerStepDirection], a
	call AddStepVector
	ld a, [wPlayerStepVectorX]
	add d
	ld [wPlayerStepVectorX], a
	ld a, [wPlayerStepVectorY]
	add e
	ld [wPlayerStepVectorY], a
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_CONTINUE_F, [hl]
	ret

RestoreDefaultMovement:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .ok
	
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.ok
	ld a, SPRITEMOVEDATA_STANDING_DOWN
	ret

ObjectMovementByte_IncAnonJumptableIndex:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	inc [hl]
	ret

ObjectMovementByte_DecAnonJumptableIndex:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	dec [hl]
	ret

ObjectMovementByte_AnonJumptable:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret

Field1c_ZeroAnonJumptableIndex:
	ld hl, OBJECT_1C
	add hl, bc
	ld [hl], 0
	ret

Field1c_IncAnonJumptableIndex:
	ld hl, OBJECT_1C
	add hl, bc
	inc [hl]
	ret

Field1c_AnonJumptable:
	ld hl, OBJECT_1C
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret

StepFunction_Reset:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordCollType
	pop bc
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a
	call CopyNextCoordsTileToStandingCoordsTile
	call EndSpriteMovement
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_FromMovement:
	call Field1c_ZeroAnonJumptableIndex
	call GetSpriteMovementType
	bit CLAP_BEHAVIOUR_BIT, a
	jp nz, MovementFunction_Standing ; Clapping NPCs can't move, because they are using a different sprite set that doesn't have walking frames.

	;and LOW(~CLAP_F)
	call GetMovementFunctionFromMovementType	
	ld a, [hl]
	ld hl, .Pointers
	rst JumpTable
	ret

.Pointers:
; entries correspond to SPRITEMOVEFN_* constants (see constants/map_object_constants.asm)
	table_width 2, StepFunction_FromMovement.Pointers
	dw MovementFunction_Null                 ; 00
	dw MovementFunction_RandomWalkY          ; 01
	dw MovementFunction_RandomWalkX          ; 02
	dw MovementFunction_RandomWalkXY         ; 03
	dw MovementFunction_RandomSpinSlow       ; 04
	dw MovementFunction_RandomSpinFast       ; 05
	dw MovementFunction_Standing             ; 06
	dw MovementFunction_ObeyDPad             ; 07
	dw MovementFunction_Indexed1             ; 08
	dw MovementFunction_Indexed2             ; 09
	dw MovementFunction_0a                   ; 0a
	dw MovementFunction_0b                   ; 0b
	dw MovementFunction_0c                   ; 0c
	dw MovementFunction_0d                   ; 0d
	dw MovementFunction_0e                   ; 0e
	dw MovementFunction_Follow               ; 0f
	dw MovementFunction_Script               ; 10
	dw MovementFunction_Strength             ; 11
	dw MovementFunction_FollowNotExact       ; 12
	dw MovementFunction_Shadow               ; 13
	dw MovementFunction_Emote                ; 14
	dw MovementFunction_BigStanding          ; 15
	dw MovementFunction_Bouncing             ; 16
	dw MovementFunction_ScreenShake          ; 17
	dw MovementFunction_SpinClockwise        ; 18
	dw MovementFunction_SpinCounterclockwise ; 19
	dw MovementFunction_BoulderDust          ; 1a
	dw MovementFunction_ShakingGrass         ; 1b
	dw MovementFunction_PingPongWalk	     ; 1c
	dw MovementFunction_CircleWalk	     	 ; 1d
	dw MovementFunction_Shine       		 ; 1e

	assert_table_length NUM_SPRITEMOVEFN

MovementFunction_Null:
	ret

MovementFunction_RandomWalkY:
	call Random
	ldh a, [hRandomAdd]
	and %00000001
	jmp _RandomWalkContinue

MovementFunction_RandomWalkX:
	call Random
	ldh a, [hRandomAdd]
	and %00000001
	or  %00000010
	jmp _RandomWalkContinue

MovementFunction_RandomWalkXY:
	call Random
	ldh a, [hRandomAdd]
	and %00000011
	jmp _RandomWalkContinue

MovementFunction_RandomSpinSlow:
	call Random
	ldh a, [hRandomAdd]
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	jmp RandomStepDuration_Slow

MovementFunction_RandomSpinFast:
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	ld d, a
	call Random
	ldh a, [hRandomAdd]
	and %00001100
	cp d
	jr nz, .keep
	xor %00001100
.keep
	ld [hl], a
	jmp RandomStepDuration_Fast

MovementFunction_Standing:
	call CopyStandingCoordsTileToNextCoordsTile
	call EndSpriteMovement
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESTORE
	ret

MovementFunction_ObeyDPad:
	ld hl, GetPlayerNextMovementByte
	jmp HandleMovementData

MovementFunction_Indexed1:
	ld hl, GetIndexedMovementByte1
	jmp HandleMovementData

MovementFunction_Indexed2:
	ld hl, GetIndexedMovementByte2
	jmp HandleMovementData

MovementFunction_0a:
	jmp _GetMovementObject

MovementFunction_0b:
	jmp _GetMovementObject

MovementFunction_0c:
	jmp _GetMovementObject

MovementFunction_0d:
	ld hl, GetPlayerNextMovementByte
	jmp HandleMovementData

MovementFunction_0e:
	jmp _GetMovementObject

MovementFunction_Follow:
	ld hl, GetFollowerNextMovementByte
	jmp HandleMovementData

MovementFunction_Script:
	ld hl, GetMovementByte
	jmp HandleMovementData

MovementFunction_Strength:
	call ObjectMovementByte_AnonJumptable
.anon_dw
	dw .start
	dw .stop

.start:
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	call CheckPitTile
	jr z, .on_pit

	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OBJ_FLAGS2_2, [hl]
	res OBJ_FLAGS2_2, [hl]
	jr z, .ok

	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	and %00000011
	call InitStep
	call CanObjectMoveInDirection
	jr c, .ok2

	call WillObjectBumpIntoLadder
	jr nc, .ok2

	ld de, SFX_STRENGTH
	call PlaySFX
	call SpawnStrengthBoulderDust
	call UpdateTallGrassFlags
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STRENGTH_BOULDER
	ret

.ok2
	call CopyStandingCoordsTileToNextCoordsTile
.ok
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

.on_pit
	call ObjectMovementByte_IncAnonJumptableIndex
.stop:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

; Used by boulders.
WillObjectBumpIntoLadder:
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	cp COLL_LADDER
	ret z

	scf
	ret

MovementFunction_FollowNotExact:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	push bc
	call GetObjectStruct
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .standing
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .equal
	jr c, .less
	ld a, 3
	jr .done

.less
	ld a, 2
	jr .done

.equal
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .standing
	jr c, .less2
	ld a, 0
	jr .done

.less2
	ld a, 1
.done
	ld d, a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001100
	or d
	pop bc
	jmp NormalStep

.standing
	pop bc
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ret

MovementFunction_BigStanding:
	call EndSpriteMovement
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_BIG_DOLL_SYM
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING
	ret

MovementFunction_Bouncing:
	call EndSpriteMovement
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_BOUNCE
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING
	ret

MovementFunction_SpinCounterclockwise:
	call ObjectMovementByte_AnonJumptable
.anon_dw
	dw _MovementSpinInit
	dw _MovementSpinRepeat
	dw _MovementSpinTurnLeft

MovementFunction_SpinClockwise:
	call ObjectMovementByte_AnonJumptable
.anon_dw
	dw _MovementSpinInit
	dw _MovementSpinRepeat
	dw _MovementSpinTurnRight

MovementFunction_Shine:
	call ObjectMovementByte_AnonJumptable
.anon_dw
	dw _MovementShineInit
	dw _MovementShineRepeat
	dw _MovementShine

_MovementSpinInit:
	call EndSpriteMovement
	call ObjectMovementByte_IncAnonJumptableIndex
	; fallthrough

_MovementSpinRepeat:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld a, $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	jmp ObjectMovementByte_IncAnonJumptableIndex

_MovementShineInit:
	call EndSpriteMovement
	call ObjectMovementByte_IncAnonJumptableIndex
	; fallthrough

_MovementShineRepeat:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	cp OW_LEFT
	ld a, $80
	jr z, .long_pause
	
	ld a, $2
.long_pause
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	jmp ObjectMovementByte_IncAnonJumptableIndex

_MovementSpinTurnLeft:
	ld de, .facings_counterclockwise
	call _MovementSpinNextFacing
	jr MovementFunction_SpinCounterclockwise

.facings_counterclockwise:
	db OW_RIGHT
	db OW_LEFT
	db OW_DOWN
	db OW_UP

_MovementSpinTurnRight:
	ld de, .facings_clockwise
	call _MovementSpinNextFacing
	jr MovementFunction_SpinClockwise

.facings_clockwise:
	db OW_LEFT
	db OW_RIGHT
	db OW_UP
	db OW_DOWN

_MovementShine:
	ld de, .facings
	call _MovementSpinNextFacing
	jr MovementFunction_Shine

.facings:
	db OW_LEFT
	db OW_DOWN
	db OW_UP
	db OW_DOWN

_MovementSpinNextFacing:
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	rrca
	rrca
	push hl
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	pop hl
	ld [hl], a
	jmp ObjectMovementByte_DecAnonJumptableIndex

MovementFunction_Shadow:
	call InitMovementField1dField1e
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SHADOW
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	inc a
	add a
	add 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	maskbits NUM_DIRECTIONS
	ld d, 1 * 8 + 6
	cp DOWN
	jr z, .ok
	cp UP
	jr z, .ok
	ld d, 1 * 8 + 4
.ok
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

MovementFunction_Emote:
	call EndSpriteMovement
	call InitMovementField1dField1e
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_EMOTE
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], -2 * 8
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

MovementFunction_BoulderDust:
	call EndSpriteMovement
	call InitMovementField1dField1e
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_BOULDER_DUST
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	inc a
	add a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	and %00000011
	ld e, a
	ld d, 0
	ld hl, .dust_coords
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

.dust_coords:
	;   x,  y
	db  0, -4
	db  0,  8
	db  6,  2
	db -6,  2

MovementFunction_ShakingGrass:
	call EndSpriteMovement
	call InitMovementField1dField1e
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_GRASS_SHAKE
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	add -1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

MovementFunction_PingPongWalk: ; Damien.
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl] ; Note: facing direction is right=c; left=8; up=4; down=0. Meaning the last 0 zeros are always blank.
	rrca
	rrca
	call InitStep
	call CanObjectMoveInDirection
	jr c, .new_duration
	call UpdateTallGrassFlags
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	ld a, $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_WALK
	ret

.new_duration:
	; turn back
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	xor %00000100 ; Alternates the bit 3 between 0 and 1 each call, changing the value between 8 and C (left and right) or between 4 and 0 (up and down) whether the fourth bit is 1 or 0.
	ld [hl], a

	call EndSpriteMovement
	call CopyStandingCoordsTileToNextCoordsTile

	ld a, $01
	jmp _SetRandomStepDuration


MovementFunction_CircleWalk: ; Damien.
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl] ; Note: facing direction is right=c; left=8; up=4; down=0. Meaning the last 0 zeros are always blank.
	rrca
	rrca
	call InitStep
	call CanObjectMoveInDirection
	jr c, .new_duration
	call UpdateTallGrassFlags
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	ld a, $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_WALK
	ret

.new_duration:
	; turn back
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	bit 3, a
	jr nz, .inverse
	add %00001000
	jr .save_value
.inverse
	xor %00001100 ; 00 -> 10 -> 01 -> 11 (-> 00...) 
.save_value
	ld [hl], a

	call EndSpriteMovement
	call CopyStandingCoordsTileToNextCoordsTile

	ld a, $01
	jmp _SetRandomStepDuration


InitMovementField1dField1e:
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	push bc
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld hl, OBJECT_1D
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

MovementFunction_ScreenShake:
	call EndSpriteMovement
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	call .GetDurationAndField1e
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_1E
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SCREENSHAKE
	ret

.GetDurationAndField1e:
	ld d, a
	and %00111111
	ld e, a
	ld a, d
	rlca
	rlca
	and %00000011
	ld d, a
	inc d
	ld a, 1
.loop
	dec d
	ret z
	add a
	jr .loop

_RandomWalkContinue:
	call InitStep
	call CanObjectMoveInDirection
	jr c, .new_duration
	call UpdateTallGrassFlags
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	ld hl, wCenteredObject
	ldh a, [hMapObjectIndex]
	cp [hl]
	jr z, .centered
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_CONTINUE_WALK
	ret

.centered
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_PLAYER_WALK
	ret

.new_duration:
	call EndSpriteMovement
	call CopyStandingCoordsTileToNextCoordsTile
	; fallthrough

RandomStepDuration_Slow:
	call Random
	ldh a, [hRandomAdd]
	and %01111111
	jr _SetRandomStepDuration

RandomStepDuration_Fast:
	call Random
	ldh a, [hRandomAdd]
	and %00011111
_SetRandomStepDuration:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

StepTypesJumptable:
; entries correspond to STEP_TYPE_* constants (see constants/map_object_constants.asm)
	table_width 2, StepTypesJumptable
	dw StepFunction_Reset           ; 00
	dw StepFunction_FromMovement    ; 01
	dw StepFunction_NPCWalk         ; 02
	dw StepFunction_Sleep           ; 03
	dw StepFunction_Standing        ; 04
	dw StepFunction_Restore         ; 05
	dw StepFunction_PlayerWalk      ; 06
	dw StepFunction_ContinueWalk    ; 07
	dw StepFunction_NPCJump         ; 08
	dw StepFunction_PlayerJump      ; 09
	dw StepFunction_Turn            ; 0a
	dw StepFunction_Bump            ; 0b
	dw StepFunction_TeleportFrom    ; 0c
	dw StepFunction_TeleportTo      ; 0d
	dw StepFunction_Skyfall         ; 0e
	dw StepFunction_StrengthBoulder ; 0f
	dw StepFunction_GotBite         ; 10
	dw StepFunction_RockSmash       ; 11
	dw StepFunction_DigTo           ; 12
	dw StepFunction_TrackingObject  ; 13
	dw StepFunction_14              ; 14
	dw StepFunction_ScreenShake     ; 15
	dw StepFunction_16              ; 16
	dw StepFunction_17              ; 17
	dw StepFunction_Delete          ; 18
	dw StepFunction_SkyfallTop      ; 19
	assert_table_length NUM_STEP_TYPES

WaitStep_InPlace:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_NPCJump:
	call Field1c_AnonJumptable
.anon_dw
	dw .Jump
	dw .Land

.Jump:
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	call GetNextTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	jmp Field1c_IncAnonJumptableIndex

.Land:
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_PlayerJump:
	call Field1c_AnonJumptable
.anon_dw
	dw .initjump
	dw .stepjump
	dw .initland
	dw .stepland

.initjump
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call Field1c_IncAnonJumptableIndex
.stepjump
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	set PLAYERSTEP_MIDAIR_F, [hl]
	jmp Field1c_IncAnonJumptableIndex

.initland
	call GetNextTile
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call Field1c_IncAnonJumptableIndex
.stepland
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_TeleportFrom:
	call Field1c_AnonJumptable
.anon_dw
	dw .InitSpin
	dw .DoSpin
	dw .InitSpinRise
	dw .DoSpinRise

.InitSpin:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Field1c_IncAnonJumptableIndex
.DoSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	jmp Field1c_IncAnonJumptableIndex

.InitSpinRise:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	call Field1c_IncAnonJumptableIndex
.DoSpinRise:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_1F
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_TeleportTo:
	call Field1c_AnonJumptable
.anon_dw
	dw .InitWait
	dw .DoWait
	dw .InitDescent
	dw .DoDescent
	dw .InitFinalSpin
	dw .DoFinalSpin
	dw .FinishStep

.InitWait:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	jmp Field1c_IncAnonJumptableIndex

.DoWait:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Field1c_IncAnonJumptableIndex
.InitDescent:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	jmp Field1c_IncAnonJumptableIndex

.DoDescent:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_1F
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Field1c_IncAnonJumptableIndex
.InitFinalSpin:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	jmp Field1c_IncAnonJumptableIndex

.DoFinalSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
.FinishStep:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Skyfall:
	call Field1c_AnonJumptable
.anon_dw
	dw .Init
	dw .Step
	dw .Fall
	dw .Finish

.Init:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Field1c_IncAnonJumptableIndex
.Step:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Field1c_IncAnonJumptableIndex
.Fall:
	ld hl, OBJECT_1F
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Field1c_IncAnonJumptableIndex
.Finish:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_GotBite:
	call Field1c_AnonJumptable
.anon_dw
	dw .Init
	dw .Run

.Init:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 8
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	call Field1c_IncAnonJumptableIndex
.Run:
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_RockSmash:
	call .Step
	jmp WaitStep_InPlace

.Step:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, OBJECT_ACTION_STAND
	jr z, .yes
	ld a, OBJECT_ACTION_00
.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	ret

StepFunction_DigTo:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, OBJECT_ACTION_SPIN
	jr z, .yes
	ld a, OBJECT_ACTION_SPIN_FLICKER
.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	jmp WaitStep_InPlace

StepFunction_Sleep:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Delete:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	jmp DeleteMapObject

StepFunction_Bump:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Restore:
	call Field1c_AnonJumptable
.anon_dw
	dw .Reset
	dw StepFunction_Standing

.Reset:
	call RestoreDefaultMovement
	call GetInitialFacing
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	call Field1c_IncAnonJumptableIndex
	; fallthrough

StepFunction_Standing:
	call Stubbed_UpdateYOffset
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

StepFunction_NPCWalk:
	call Stubbed_UpdateYOffset
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_ContinueWalk:
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	jmp RandomStepDuration_Slow

StepFunction_PlayerWalk:
	call Field1c_AnonJumptable
.anon_dw
	dw .init
	dw .step

.init
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call Field1c_IncAnonJumptableIndex
.step
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Turn:
	call Field1c_AnonJumptable
.anon_dw
	dw .init1
	dw .step1
	dw .init2
	dw .step2

.init1
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	ld [hl], 2
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 2
	call Field1c_IncAnonJumptableIndex
.step1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Field1c_IncAnonJumptableIndex
.init2
	ld hl, OBJECT_1D ; new facing
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 2
	call Field1c_IncAnonJumptableIndex
.step2
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_StrengthBoulder:
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	push bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ld b, a
	farcall CopyDECoordsToMapObject
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OBJ_FLAGS2_2, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_TrackingObject:
	ld hl, OBJECT_1D
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .nope
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz
.nope
	jmp DeleteMapObject

StepFunction_14:
StepFunction_ScreenShake:
	call Field1c_AnonJumptable
.anon_dw
	dw .Init
	dw .Run

.Init:
	xor a
	ld hl, OBJECT_1D
	add hl, bc
	ld [hl], a
	call Field1c_IncAnonJumptableIndex
.Run:
	ld hl, OBJECT_1D
	add hl, bc
	ld d, [hl]
	ld a, [wPlayerStepVectorY]
	sub d
	ld [wPlayerStepVectorY], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	jp z, DeleteMapObject
	ld a, [hl]
	call .GetSign
	ld hl, OBJECT_1D
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, [wPlayerStepVectorY]
	add d
	ld [wPlayerStepVectorY], a
	ret

.GetSign:
	ld hl, OBJECT_1E
	add hl, bc
	and 1
	ld a, [hl]
	ret z
	cpl
	inc a
	ret

StepFunction_16:
	call Field1c_AnonJumptable
	; jumptable was dummied out here

StepFunction_17:
	call Field1c_AnonJumptable
.anon_dw
	dw .null
	dw .null
	dw .null
.null

StepFunction_SkyfallTop:
	call Field1c_AnonJumptable
.anon_dw
	dw .Init
	dw .Run

.Init:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SKYFALL
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Field1c_IncAnonJumptableIndex

.Run:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], $60
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

Stubbed_UpdateYOffset:
; dummied out
	ret
	ld hl, OBJECT_1D
	add hl, bc
	inc [hl]
	ld a, [hl]
	srl a
	srl a
	and %00000111
	ld l, a
	ld h, 0
	ld de, .y_offsets
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ret

.y_offsets:
	db 0, -1, -2, -3, -4, -3, -2, -1

UpdateJumpPosition:
	call GetStepVector
	ld a, h
	ld hl, OBJECT_1F
	add hl, bc
	ld e, [hl]
	add e
	ld [hl], a
	nop
	srl e
	ld d, 0
	ld hl, .y_offsets
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ret

.y_offsets:
	db  -4,  -6,  -8, -10, -11, -12, -12, -12
	db -11, -10,  -9,  -8,  -6,  -4,   0,   0

GetPlayerNextMovementByte:
; copy [wPlayerNextMovement] to [wPlayerMovement]
	ld a, [wPlayerNextMovement]
	ld hl, wPlayerMovement
	ld [hl], a
; load [wPlayerNextMovement] with movement_step_sleep
	ld a, movement_step_sleep
	ld [wPlayerNextMovement], a
; recover the previous value of [wPlayerNextMovement]
	ld a, [hl]
	ret

GetMovementByte:
	ld hl, wMovementDataBank
	jmp _GetMovementByte

GetIndexedMovementByte1:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wMovementObject
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	ret

GetIndexedMovementByte2:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wIndexedMovement2Pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	ret

_GetMovementObject:
	ld hl, GetMovementObject
	jr HandleMovementData

GetMovementObject:
	ld a, [wMovementObject]
	ret

HandleMovementData:
	call .StorePointer
.loop
	xor a
	ld [wMovementByteWasControlSwitch], a
	call JumpMovementPointer
	call DoMovementFunction
	ld a, [wMovementByteWasControlSwitch]
	and a
	jr nz, .loop
	ret

.StorePointer:
	ld a, l
	ld [wMovementPointer], a
	ld a, h
	ld [wMovementPointer + 1], a
	ret

JumpMovementPointer:
	ld hl, wMovementPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

ContinueReadingMovement:
	ld a, 1
	ld [wMovementByteWasControlSwitch], a
	ret

DoMovementFunction:
	push af
	call ApplyMovementToFollower
	pop af
	ld hl, MovementPointers
	rst JumpTable
	ret

INCLUDE "engine/overworld/movement.asm"

ApplyMovementToFollower:
	ld e, a
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	ld a, [wObjectFollow_Leader]
	ld d, a
	ldh a, [hMapObjectIndex]
	cp d
	ret nz
	ld a, e
	cp movement_step_sleep
	ret z
	cp movement_step_end
	ret z
	cp movement_step_4b
	ret z
	cp movement_step_bump
	ret z
	cp movement_slow_step
	ret c
	push af
	ld hl, wFollowerMovementQueueLength
	inc [hl]
	ld e, [hl]
	ld d, 0
	ld hl, wFollowMovementQueue
	add hl, de
	pop af
	ld [hl], a
	ret

GetFollowerNextMovementByte:
	ld hl, wFollowerMovementQueueLength
	ld a, [hl]
	and a
	jr z, .done
	cp -1
	jr z, .done
	dec [hl]
	ld e, a
	ld d, 0
	ld hl, wFollowMovementQueue
	add hl, de
	inc e
	ld a, -1
.loop
	ld d, [hl]
	ld [hld], a
	ld a, d
	dec e
	jr nz, .loop
	ret

.done
	call .CancelFollowIfLeaderMissing
	ret c
	ld a, movement_step_sleep
	ret

.CancelFollowIfLeaderMissing:
	ld a, [wObjectFollow_Leader]
	cp -1
	jr z, .nope
	push bc
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	pop bc
	and a
	jr z, .nope
	and a
	ret

.nope
	ld a, -1
	ld [wObjectFollow_Follower], a
	ld a, movement_step_end
	scf
	ret

SpawnShadow:
	push bc
	ld de, .ShadowObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.ShadowObject:
	; vtile, palette, movement
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_SHADOW

SpawnStrengthBoulderDust:
	push bc
	ld a, [wLoadedGrassRustleOrDust]
	cp EMOTE_BOULDER_DUST
	jr z, .SkipLoadEmote

	push bc
	ld a, EMOTE_BOULDER_DUST
	ld [wLoadedGrassRustleOrDust], a
	ld c, a
	farcall LoadEmote
	pop bc

.SkipLoadEmote
	ld de, .BoulderDustObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.BoulderDustObject:
	; vtile, palette, movement
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_BOULDERDUST

SpawnEmote:
	push bc
	ld de, .EmoteObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.EmoteObject:
	; vtile, palette, movement
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_EMOTE

ShakeGrass:
	push bc
	ld a, [wLoadedGrassRustleOrDust]
	cp EMOTE_GRASS_RUSTLE
	jr z, .SkipLoadEmote

	push bc
	ld a, EMOTE_GRASS_RUSTLE
	ld [wLoadedGrassRustleOrDust], a
	ld c, a
	farcall LoadEmote
	pop bc

.SkipLoadEmote
	ld de, .GrassObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.GrassObject:
	; vtile, palette, movement
	db $00, PAL_OW_TREE, SPRITEMOVEDATA_GRASS

ShakeScreen:
	push bc
	push af
	ld de, .ScreenShakeObject
	call CopyTempObjectData
	pop af
	ld [wTempObjectCopyRange], a
	call InitTempObject
	pop bc
	ret

.ScreenShakeObject:
	; vtile, palette, movement
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_SCREENSHAKE

DespawnEmote:
	push bc
	ldh a, [hMapObjectIndex]
	ld c, a
	call .DeleteEmote
	pop bc
	ret

.DeleteEmote:
	ld de, wObjectStructs
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af
	ld hl, OBJECT_FLAGS1
	add hl, de
	bit EMOTE_OBJECT_F, [hl]
	jr z, .next
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next
	push bc
	xor a
	ld bc, OBJECT_LENGTH
	call ByteFill
	pop bc
.next
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop af
	dec a
	jr nz, .loop
	ret

InitTempObject:
	call FindFirstEmptyObjectStruct
	ret nc
	ld d, h
	ld e, l
	farcall CopyTempObjectToObjectStruct
	ret

CopyTempObjectData:
; load into wTempObjectCopy:
; -1, -1, [de], [de + 1], [de + 2], [hMapObjectIndex], [NextMapX], [NextMapY], -1
; This spawns the object at the same place as whichever object is loaded into bc.
	ld hl, wTempObjectCopyMapObjectIndex
	ld [hl], -1
	inc hl
	ld [hl], -1
	inc hl
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ldh a, [hMapObjectIndex]
	ld [hli], a
	push hl
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	pop hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], -1
	ret

UpdateAllObjectsFrozen::
	ld a, [wVramState]
	bit 0, a
	ret z
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndex], a
	call DoesObjectHaveASprite
	jr z, .ok
	call UpdateObjectFrozen
.ok
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

RespawnPlayerAndOpponent:
	; called at battle start
	ld a, [wOtherTrainerClass]
	cp RED
	ret z ; Against Red, we keep the fake player visible, as we have moved the camera.

; not_reds_battle
	call HideAllObjects
	ld a, PLAYER
	call RespawnObject
	ld a, [wBattleScriptFlags]
	bit 7, a
	jr z, .skip_opponent

	ldh a, [hLastTalked]
	and a
	jr z, .skip_opponent
	call RespawnObject

	farcall PokeBallEffect.IsItMewtwoBattle
	jr nc, .skip_opponent

	; Special case for Mewtwo, as it uses 2 objects.
	ldh a, [hLastTalked]
	xor %11 ; This find the second object index. 1 -> 2 or 2 -> 1.
	call RespawnObject

.skip_opponent
	jmp _UpdateSprites

RespawnPlayer:
	call HideAllObjects
	ld a, PLAYER
	call RespawnObject
	jmp _UpdateSprites

RespawnObject:
	cp NUM_OBJECTS
	ret nc
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z
	cp NUM_OBJECT_STRUCTS
	ret nc
	call GetObjectStruct
	call DoesObjectHaveASprite
	ret z
	jr UpdateRespawnedObjectFrozen

HideAllObjects:
	xor a
	ld bc, wObjectStructs
.loop
	ldh [hMapObjectIndex], a
	call SetFacing_Standing
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

UpdateObjectFrozen:
	push bc
	call CheckObjectCoveredByTextbox
	pop bc
	jr c, SetFacing_Standing
	call CheckObjectOnScreen
	jr c, SetFacing_Standing
	call UpdateObjectNextTile
	farcall HandleFrozenObjectAction ; no need to farcall
	xor a
	ret

UpdateRespawnedObjectFrozen:
	call CheckObjectOnScreen
	jr c, SetFacing_Standing
	farcall HandleFrozenObjectAction ; no need to farcall
	xor a
	ret

SetFacing_Standing:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], STANDING
	scf
	ret

UpdateObjectNextTile:
	push bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	call GetCoordCollType
	pop bc
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a
	farcall UpdateTallGrassFlags ; no need to farcall
	ret

CheckObjectOnScreen:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	inc d
	inc e
	ld a, [wXCoord]
	cp d
	jr z, .equal_x
	jr nc, .nope
	add MAPOBJECT_SCREEN_WIDTH - 1
	cp d
	jr c, .nope
.equal_x
	ld a, [wYCoord]
	cp e
	jr z, .equal_y
	jr nc, .nope
	add MAPOBJECT_SCREEN_HEIGHT - 1
	cp e
	jr c, .nope
.equal_y
	xor a
	ret

.nope
	scf
	ret

CheckObjectCoveredByTextbox:
; Check whether the object fits in the screen width.
	ld a, [wPlayerBGMapOffsetX]
	ld d, a
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	add [hl]
	add d
	cp $f0
	jr nc, .ok1
	cp SCREEN_WIDTH_PX
	jp nc, .nope
.ok1
; Account for objects currently moving left/right.
	and %00000111
	ld d, 2
	cp TILE_WIDTH / 2
	jr c, .ok2
	ld d, 3
.ok2
; Convert pixels to tiles.
	ld a, [hl]
	srl a
	srl a
	srl a
	cp SCREEN_WIDTH
	jr c, .ok3
	sub BG_MAP_WIDTH
.ok3
	ldh [hCurSpriteXCoord], a

; Check whether the object fits in the screen height.
	ld a, [wPlayerBGMapOffsetY]
	ld e, a
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	add [hl]
	add e
	cp $f0
	jr nc, .ok4
	cp SCREEN_HEIGHT_PX
	jr nc, .nope
.ok4
; Account for objects currently moving up/down.
	and %00000111
	ld e, 2
	cp TILE_WIDTH / 2
	jr c, .ok5
	ld e, 3
.ok5
; Convert pixels to tiles.
	ld a, [hl]
	srl a
	srl a
	srl a
	cp SCREEN_HEIGHT
	jr c, .ok6
	sub BG_MAP_HEIGHT
.ok6
	ldh [hCurSpriteYCoord], a

; Account for big objects that are twice as wide and high.
	ld hl, OBJECT_PALETTE
	add hl, bc
	bit BIG_OBJECT_F, [hl]
	jr z, .ok7
	ld a, d
	add 2
	ld d, a
	ld a, e
	add 2
	ld e, a
.ok7
	ld a, d
	ldh [hCurSpriteXPixel], a

.loop
	ldh a, [hCurSpriteXPixel]
	ld d, a
	ldh a, [hCurSpriteYCoord]
	add e
	dec a
	cp SCREEN_HEIGHT
	jr nc, .ok9
	ld b, a
.next
	ldh a, [hCurSpriteXCoord]
	add d
	dec a
	cp SCREEN_WIDTH
	jr nc, .ok8
	ld c, a
	push bc
	call Coord2Tile
	pop bc
; NPCs disappear if standing on tile $60-$7f (or $e0-$ff),
; since those IDs are for text characters and textbox frames.
	ld a, [hl]
	cp FIRST_REGULAR_TEXT_CHAR
	jr nc, .nope
.ok8
	dec d
	jr nz, .next
.ok9
	dec e
	jr nz, .loop

	and a
	ret

.nope
	scf
	ret

ResetStepVector::
	xor a
	ld [wPlayerStepVectorX], a
	ld [wPlayerStepVectorY], a
	ld [wPlayerStepFlags], a
	ld a, STANDING
	ld [wPlayerStepDirection], a
	ret

HandleNPCStep::
	call ResetStepVector
	; fallthrough.

;DoStepsForAllObjects:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndex], a
	call DoesObjectHaveASprite
	jr z, .next
	call HandleObjectStep
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

RefreshPlayerSprite:
	ld a, movement_step_sleep
	ld [wPlayerNextMovement], a
	ld [wPlayerMovement], a
	xor a
	ld [wPlayerTurningDirection], a
	ld [wPlayerObjectStepFrame], a
	call TryResetPlayerAction
	farcall CheckWarpFacingDown
	call c, SpawnInFacingDown
	jr SpawnInCustomFacing

TryResetPlayerAction:
	ld hl, wPlayerSpriteSetupFlags
	bit PLAYERSPRITESETUP_RESET_ACTION_F, [hl]
	jr nz, .ok
	ret

.ok
	ld a, OBJECT_ACTION_00
	ld [wPlayerAction], a
	ret

SpawnInCustomFacing:
	ld hl, wPlayerSpriteSetupFlags
	bit PLAYERSPRITESETUP_CUSTOM_FACING_F, [hl]
	ret z
	ld a, [wPlayerSpriteSetupFlags]
	and PLAYERSPRITESETUP_FACING_MASK
	add a
	add a
	jr _ContinueSpawnFacing

SpawnInFacingDown:
	ld a, DOWN
_ContinueSpawnFacing:
	ld bc, wPlayerStruct
	jmp SetSpriteDirection

_SetPlayerPalette:
	ld a, d
	and 1 << 7
	ret z
	ld hl, OBJECT_FACING
	ld a, [hl]
	or d
	ld [hl], a
	ld a, d
	swap a
	and PALETTE_MASK
	ld d, a
	ld bc, wPlayerStruct
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld a, [hl]
	and $ff ^ PALETTE_MASK
	or d
	ld [hl], a
	ret

StartFollow::
	push bc
	ld a, b
	call SetLeaderIfVisible
	pop bc
	ret c
	ld a, c
	call SetFollowerIfVisible
	farcall QueueFollowerFirstStep
	ret

SetLeaderIfVisible:
	call CheckObjectVisibility
	ret c
	ldh a, [hObjectStructIndex]
	ld [wObjectFollow_Leader], a
	ret

ResetLeader:
	ld a, -1
	ld [wObjectFollow_Leader], a
	ret

SetFollowerIfVisible:
	push af
	call ResetFollower
	pop af
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], SPRITEMOVEDATA_FOLLOWING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ldh a, [hObjectStructIndex]
	ld [wObjectFollow_Follower], a
	ret

StopFollow::
	call ResetLeader
	; fallthrough.

ResetFollower:
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	call GetObjectStruct
	call ResetObject
	ld a, -1
	ld [wObjectFollow_Follower], a
	ret

FreezeAllOtherObjects::
	ld a, c
	call CheckObjectVisibility
	ret c
	push bc
	call FreezeAllObjects
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
	xor a
	ret

FreezeObject: ; unreferenced
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set FROZEN_F, [hl]
	xor a
	ret

FreezeAllObjects:
	ld bc, wObjectStructs
	xor a
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set FROZEN_F, [hl]
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

_UnfreezeFollowerObject::
	ld a, [wObjectFollow_Leader]
	cp -1
	ret z
	push bc
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	pop bc
	cp c
	ret nz
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
	ret

UnfreezeAllObjects::
	push bc
	ld bc, wObjectStructs
	xor a
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	pop bc
	ret

UnfreezeObject: ; unreferenced
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
	ret

ResetObject:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .set_standing
	
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ret

.set_standing:
	call GetSpriteDirection
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, .standing_movefns
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ret

.standing_movefns:
	db SPRITEMOVEDATA_STANDING_DOWN
	db SPRITEMOVEDATA_STANDING_UP
	db SPRITEMOVEDATA_STANDING_LEFT
	db SPRITEMOVEDATA_STANDING_RIGHT

_UpdateSprites::
	ld a, [wVramState]
	bit 0, a
	ret z
	xor a
	ldh [hUsedSpriteIndex], a
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call InitSprites
	call .fill
	pop af
	ldh [hOAMUpdate], a
	ret

.fill
	ld a, [wVramState]
	bit 1, a
	ld b, NUM_SPRITE_OAM_STRUCTS * SPRITEOAMSTRUCT_LENGTH
	jr z, .ok
	ld b, (NUM_SPRITE_OAM_STRUCTS - 12) * SPRITEOAMSTRUCT_LENGTH
.ok
	ldh a, [hUsedSpriteIndex]
	cp b
	ret nc
	ld l, a
	ld h, HIGH(wVirtualOAM)
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld a, b
	ld c, SCREEN_HEIGHT_PX + 2 * TILE_WIDTH
.loop
	ld [hl], c ; y
	add hl, de
	cp l
	jr nz, .loop
	ret

ApplyBGMapAnchorToObjects:
	push hl
	push de
	push bc
	ld a, [wPlayerBGMapOffsetX]
	ld d, a
	ld a, [wPlayerBGMapOffsetY]
	ld e, a
	ld bc, wObjectStructs
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .skip
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
.skip
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	dec a
	jr nz, .loop
	xor a
	ld [wPlayerBGMapOffsetX], a
	ld [wPlayerBGMapOffsetY], a
	pop bc
	pop de
	pop hl
	ret

LoadDyingRedNextGFX::
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a

	ld a, [wDyingFrameSetIndex]
	ld c, a
	ld b, 0
	ld hl, RedDyingGFX
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl] ; ld de, RedDyingGFX + X.
	ld a, c
	add 2
	ld [wDyingFrameSetIndex], a

	ld hl, vTiles3 tile $18
	lb bc, BANK(RedDyingGFX), 12
	call Get2bpp

	pop af
	ldh [rVBK], a
	ret

RedDyingGFX:
	dw RedDying1GFX
	dw RedDying2GFX
	dw RedDying3GFX

RedDying1GFX:
	INCBIN "gfx/sprites/red_dying_1.2bpp"

RedDying2GFX:
	INCBIN "gfx/sprites/red_dying_2.2bpp"

RedDying3GFX:
	INCBIN "gfx/sprites/red_dying_3.2bpp"

PRIORITY_LOW  EQU $10
PRIORITY_NORM EQU $20
PRIORITY_HIGH EQU $30

InitSprites:
	call .DeterminePriorities
	ld c, PRIORITY_HIGH
	call .InitSpritesByPriority
	ld c, PRIORITY_NORM
	call .InitSpritesByPriority
	ld c, PRIORITY_LOW
	jr .InitSpritesByPriority

.DeterminePriorities:
	xor a
	ld hl, wObjectPriorities
	ld bc, NUM_OBJECT_STRUCTS
	call ByteFill
	ld d, 0
	ld bc, wObjectStructs
	ld hl, wObjectPriorities
.loop
	push hl
	call DoesObjectHaveASprite
	jr z, .skip
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .skip
; Define the sprite priority.
	ld e, PRIORITY_LOW
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit LOW_PRIORITY_F, [hl]
	jr nz, .add
	ld e, PRIORITY_NORM
	bit HIGH_PRIORITY_F, [hl]
	jr z, .add
	ld e, PRIORITY_HIGH
	jr .add

.skip
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	jr .next

.add
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ld a, d
	or e
	ld [hli], a
.next
	inc d
	ld a, d
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

.InitSpritesByPriority:
	ld hl, wObjectPriorities
.next_sprite
	ld a, [hli]
	ld d, a
	and $f0
	ret z
	cp c
	jr nz, .next_sprite
	push bc
	push hl
	ld a, d
	and $f
	call .GetObjectStructPointer
	call .InitSprite
	pop hl
	pop bc
	jr .next_sprite

.InitSprite:
	ld hl, OBJECT_SPRITE_TILE
	add hl, bc
	ld a, [hl]
	and $ff ^ (1 << 7)
	ldh [hCurSpriteTile], a
	xor a
	bit 7, [hl]
	jr nz, .not_vram1
	or VRAM_BANK_1
.not_vram1
	ld hl, OBJECT_FLAGS2
	add hl, bc
	ld e, [hl]
	bit OBJ_FLAGS2_7, e
	jr z, .not_priority
	or PRIORITY
.not_priority
	bit USE_OBP1_F, e
	jr z, .not_obp_num
	or OBP_NUM
.not_obp_num
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld d, a
	ld a, [hl]
	and PALETTE_MASK
	or d
	ld d, a
	xor a
	bit OVERHEAD_F, e
	jr z, .not_overhead
	or PRIORITY
.not_overhead
	ldh [hCurSpriteOAMFlags], a
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	add [hl]
	add 8
	ld e, a
	ld a, [wPlayerBGMapOffsetX]
	add e
	ldh [hCurSpriteXPixel], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	add [hl]
	add 12
	ld e, a
	ld a, [wPlayerBGMapOffsetY]
	add e
	ldh [hCurSpriteYPixel], a
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	cp STANDING
	jp z, .done
	cp NUM_FACINGS
	jp nc, .done
	ld l, a
	ld h, 0
	add hl, hl
	ld bc, Facings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hUsedSpriteIndex]
	ld c, a
	ld b, HIGH(wVirtualOAM)
	ld a, [hli]
	ldh [hUsedSpriteTile], a
	add c
	cp LOW(wVirtualOAMEnd)
	jr nc, .full
.addsprite
	ldh a, [hCurSpriteYPixel]
	add [hl]
	inc hl
	ld [bc], a ; y
	inc c
	ldh a, [hCurSpriteXPixel]
	add [hl]
	inc hl
	ld [bc], a ; x
	inc c
	ld e, [hl]
	inc hl
	ldh a, [hCurSpriteTile]
	bit ABSOLUTE_TILE_ID_F, e
	jr z, .nope1
	xor a
.nope1
	add a
	add a
	add [hl]
	inc hl
	ld [bc], a ; tile id
	inc c
	ld a, e
	bit RELATIVE_ATTRIBUTES_F, a
	jr z, .nope2
	ldh a, [hCurSpriteOAMFlags]
	or e
.nope2
	and OBP_NUM | X_FLIP | Y_FLIP | PRIORITY
	or d
	
	push bc
	ld b, a
	ldh a, [hCurSpriteTile]
	cp $40
	ld a, b
	jr c, .vram1

;.vram0
	;and !VRAM_BANK_1
	res OAM_TILE_BANK, a

.vram1
	pop bc
	
	ld [bc], a ; attributes
	inc c
	ldh a, [hUsedSpriteTile]
	dec a
	ldh [hUsedSpriteTile], a
	jr nz, .addsprite
	ld a, c
	ldh [hUsedSpriteIndex], a
.done
	xor a
	ret

.full
	scf
	ret

.GetObjectStructPointer:
	ld c, a
	ld b, 0
	ld hl, .Addresses
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ret

.Addresses:
	dw wPlayerStruct
	dw wObject1Struct
	dw wObject2Struct
	dw wObject3Struct
	dw wObject4Struct
	dw wObject5Struct
	dw wObject6Struct
	dw wObject7Struct
	dw wObject8Struct
	dw wObject9Struct
	dw wObject10Struct
	dw wObject11Struct
	dw wObject12Struct
