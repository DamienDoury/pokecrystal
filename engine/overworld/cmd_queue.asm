ClearCmdQueue::
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, CMDQUEUE_CAPACITY
	xor a
.loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

HandleCmdQueue::
	ld hl, wCmdQueue
	xor a
.loop
	ldh [hMapObjectIndex], a
	ld a, [hl]
	and a
	jr z, .skip
	push hl
	ld b, h
	ld c, l
	call HandleQueuedCommand
	pop hl

.skip
	ld de, CMDQUEUE_ENTRY_SIZE
	add hl, de
	ldh a, [hMapObjectIndex]
	inc a
	cp CMDQUEUE_CAPACITY
	jr nz, .loop
	ret

WriteCmdQueue::
	push bc
	push de
	call .GetNextEmptyEntry
	ld d, h
	ld e, l
	pop hl
	pop bc
	ret c
	ld a, b
	ld bc, CMDQUEUE_ENTRY_SIZE - 1
	call FarCopyBytes
	xor a
	ld [hl], a
	ret

.GetNextEmptyEntry:
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, CMDQUEUE_CAPACITY
.loop
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	dec c
	jr nz, .loop
	scf
	ret

.done
	ld a, CMDQUEUE_CAPACITY
	sub c
	and a
	ret

DelCmdQueue::
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, CMDQUEUE_CAPACITY
.loop
	ld a, [hl]
	cp b
	jr z, .done
	add hl, de
	dec c
	jr nz, .loop
	and a
	ret

.done
	xor a
	ld [hl], a
	scf
	ret

_DelCmdQueue:
	ld hl, CMDQUEUE_TYPE
	add hl, bc
	ld [hl], 0
	ret

HandleQueuedCommand:
	ld hl, CMDQUEUE_TYPE
	add hl, bc
	ld a, [hl]
	cp NUM_CMDQUEUE_TYPES
	jr c, .okay
	xor a

.okay
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	rst FarCall
	ret

.Jumptable:
	dba CmdQueue_Null
	dba CmdQueue_Type1
	dba CmdQueue_StoneTable
	dba CmdQueue_Type3
	dba CmdQueue_Type4
	dba CmdQueue_Sokoban

CmdQueues_AnonJumptable:
	ld hl, CMDQUEUE_05
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret

CmdQueues_IncAnonJumptableIndex:
	ld hl, CMDQUEUE_05
	add hl, bc
	inc [hl]
	ret

CmdQueues_DecAnonJumptableIndex:
	ld hl, CMDQUEUE_05
	add hl, bc
	dec [hl]
	ret

CmdQueue_Null:
	ret

CmdQueue_Type1:
	ret

CmdQueue_Type4:
	call CmdQueues_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero
	ldh a, [hSCY]
	ld hl, CMDQUEUE_04
	add hl, bc
	ld [hl], a
	call CmdQueues_IncAnonJumptableIndex
.one
	ld hl, CMDQUEUE_ADDR
	add hl, bc
	ld a, [hl]
	dec a
	ld [hl], a
	jr z, .finish
	and 1
	jr z, .add
	ld hl, CMDQUEUE_02
	add hl, bc
	ldh a, [hSCY]
	sub [hl]
	ldh [hSCY], a
	ret

.add
	ld hl, CMDQUEUE_02
	add hl, bc
	ldh a, [hSCY]
	add [hl]
	ldh [hSCY], a
	ret

.finish
	ld hl, CMDQUEUE_04
	add hl, bc
	ld a, [hl]
	ldh [hSCY], a
	jmp _DelCmdQueue

CmdQueue_Type3:
	call CmdQueues_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	call .IsPlayerFacingDown
	jr z, .PlayerNotFacingDown
	call CmdQueues_IncAnonJumptableIndex
.one
	call .IsPlayerFacingDown
	jr z, .PlayerNotFacingDown
	call CmdQueues_IncAnonJumptableIndex

	ld hl, CMDQUEUE_02
	add hl, bc
	ld a, [hl]
	ld [wd173], a
	ret

.two
	call .IsPlayerFacingDown
	jr z, .PlayerNotFacingDown
	call CmdQueues_DecAnonJumptableIndex

	ld hl, CMDQUEUE_03
	add hl, bc
	ld a, [hl]
	ld [wd173], a
	ret

.PlayerNotFacingDown:
	ld a, $7f
	ld [wd173], a
	ld hl, CMDQUEUE_05
	add hl, bc
	ld [hl], 0
	ret

.IsPlayerFacingDown:
	push bc
	ld bc, wPlayerStruct
	call GetSpriteDirection
	and a
	pop bc
	ret

CmdQueue_StoneTable:
	ld de, wPlayerStruct
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af

	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

	ld hl, OBJECT_MOVEMENTTYPE
	add hl, de
	ld a, [hl]
	and LOW(~CLAP_F)
	cp SPRITEMOVEDATA_STRENGTH_BOULDER
	jr nz, .next

	ld hl, OBJECT_NEXT_TILE
	add hl, de
	ld a, [hl]
	call CheckPitTile
	jr nz, .next

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	cp STANDING
	jr nz, .next
	call HandleStoneQueue
	jr c, .fall_down_hole

.next
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	dec a
	jr nz, .loop
	ret

.fall_down_hole
	pop af
	ret

CmdQueue_Sokoban:
	call .init_sokoban_params

	ld de, wPlayerStruct
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af

	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

	ld hl, OBJECT_MOVEMENTTYPE
	add hl, de
	ld a, [hl]
	and LOW(~CLAP_F)
	cp SPRITEMOVEDATA_STRENGTH_BOULDER
	jr nz, .next

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	cp STANDING
	jr nz, .next

	call CheckSokobanStone
	jr c, .sokoban_solved

.next
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	dec a
	jr nz, .loop
	ret

.sokoban_solved
	pop af
	ret

.init_sokoban_params
	xor a
	ld [wSokobanPlacedStonesCount], a

	ld hl, CMDQUEUE_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	push bc
	ld a, [wMapScriptsBank]
	ld bc, 7
	ld de, wSokobanTargetsCount
	call FarCopyBytes
	pop bc
	ret