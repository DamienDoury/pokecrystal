DoPlayerMovement::
	call .GetDPad
	ld a, movement_step_sleep
	ld [wMovementAnimation], a
	xor a
	ld [wWalkingIntoEdgeWarp], a
	call .TranslateIntoMovement
	ld c, a
	ld a, [wMovementAnimation]
	ld [wPlayerNextMovement], a
	ret

.GetDPad:
	ldh a, [hJoyDown]
	ld [wCurInput], a

; Closing a WaitButton with the Down button prevents from using it until released.
	ldh a, [hWaitForDownButtonRelease]
	and a
	jr z, .skip_down_lock ; If we are not waiting for the B button to be released, we skip its checks and move on to the cycling road check.

	ld a, [wCurInput]
	res D_DOWN_F, a
	ld [wCurInput], a ; We remove the B button from the input.

	ldh a, [hJoyDown]
	and D_DOWN
	jr nz, .skip_down_lock ; If the B button is pressed, we keep the B input removed.

	xor a
	ldh [hWaitForDownButtonRelease], a ; We release the B button lock. If can be activated next frame.

.skip_down_lock
; Standing downhill instead moves down.

	ld hl, wBikeFlags
	bit BIKEFLAGS_DOWNHILL_F, [hl]
	ret z

	ld a, [wCurInput]
	ld c, a
	and D_PAD
	ret nz

	ld a, c
	or D_DOWN
	ld [wCurInput], a
	ret

.Clap
	ld a, [wCurInput]
	and D_PAD
	jp z, ._WalkInPlace ; Bump animation.

	; As soon as the player presses any button from the DPad, we set it back to its normal state.
	farcall SetNormalStateIfClapping
	jr .Normal

.TranslateIntoMovement:
	ld a, [wPlayerState]
	cp PLAYER_CLAP
	jr z, .Clap
	cp PLAYER_SURF
	jr z, .Surf
	cp PLAYER_SURF_PIKA
	jr z, .Surf
	cp PLAYER_SKATE
	jr z, .Ice
	; Any other behaviour defaults to .Normal

.Normal:
	call .CheckForced
	call .GetAction
	call .CheckTile
	ret c
	call .CheckTurning
	ret c
	call .TryStep
	ret c
	call .TryJump
	ret c
	call .CheckWarp
	ret c
	jr .NotMoving

.Surf:
	call .CheckForced
	call .GetAction
	call .CheckTile
	ret c
	call .CheckTurning
	ret c
	call .TrySurf
	ret c
	jr .NotMoving

.Ice:
	call .CheckForced
	call .GetAction
	call .CheckTile
	ret c
	call .CheckTurning
	ret c
	call .TryStep
	ret c
	call .TryJump
	ret c
	call .CheckWarp
	ret c
	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .HitWall
	call .Bump
.HitWall:
	call .StandInPlace
	xor a
	ret

.NotMoving:
	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .Standing

; Walking into an edge warp won't bump.
	ld a, [wWalkingIntoEdgeWarp]
	and a
	jr nz, .CantMove
	call .Bump
.CantMove:
	call ._WalkInPlace
	xor a
	ret

.Standing:
	call .StandInPlace
	xor a
	ret

.CheckTile:
; Tiles such as waterfalls and warps move the player
; in a given direction, overriding input.

	ld a, [wPlayerStandingTile]
	ld c, a
	call CheckWhirlpoolTile
	jr c, .not_whirlpool
	ld a, PLAYERMOVEMENT_FORCE_TURN
	scf
	ret

.not_whirlpool
	and $f0
	cp HI_NYBBLE_CURRENT
	jr z, .water
	cp HI_NYBBLE_WALK
	jr z, .land1
	cp HI_NYBBLE_WALK_ALT
	jr z, .land2
	cp HI_NYBBLE_WARPS
	jr z, .warps
	jr .no_walk

.water
	ld a, c
	maskbits NUM_DIRECTIONS
	ld c, a
	ld b, 0
	ld hl, .water_table
	add hl, bc
	ld a, [hl]
	ld [wWalkingDirection], a
	jr .continue_walk

.water_table
	db RIGHT ; COLL_WATERFALL_RIGHT
	db LEFT  ; COLL_WATERFALL_LEFT
	db UP    ; COLL_WATERFALL_UP
	db DOWN  ; COLL_WATERFALL

.land1
	ld a, c
	and 7
	ld c, a
	ld b, 0
	ld hl, .land1_table
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .no_walk
	ld [wWalkingDirection], a
	jr .continue_walk

.land1_table
	db STANDING ; COLL_BRAKE
	db RIGHT    ; COLL_WALK_RIGHT
	db LEFT     ; COLL_WALK_LEFT
	db UP       ; COLL_WALK_UP
	db DOWN     ; COLL_WALK_DOWN
	db STANDING ; COLL_BRAKE_45
	db STANDING ; COLL_BRAKE_46
	db STANDING ; COLL_BRAKE_47

.land2
	ld a, c
	and 7
	ld c, a
	ld b, 0
	ld hl, .land2_table
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .no_walk
	ld [wWalkingDirection], a
	jr .continue_walk

.land2_table
	db RIGHT    ; COLL_WALK_RIGHT_ALT
	db LEFT     ; COLL_WALK_LEFT_ALT
	db UP       ; COLL_WALK_UP_ALT
	db DOWN     ; COLL_WALK_DOWN_ALT
	db STANDING ; COLL_BRAKE_ALT
	db STANDING ; COLL_BRAKE_55
	db STANDING ; COLL_BRAKE_56
	db STANDING ; COLL_BRAKE_57

.warps
	ld a, c
	cp COLL_DOOR
	jr z, .down
	cp COLL_CLOSED_DOOR
	jr z, .down
	cp COLL_STAIRCASE
	jr z, .down
	cp COLL_CAVE
	jr nz, .no_walk

.down
	ld a, DOWN
	ld [wWalkingDirection], a
	jr .continue_walk

.no_walk
	xor a
	ret

.continue_walk
	ld a, STEP_WALK
	call .DoStep
	ld a, PLAYERMOVEMENT_CONTINUE
	scf
	ret

.CheckTurning:
; If the player is turning, change direction first. This also lets
; the player change facing without moving by tapping a direction.

	ld a, [wPlayerTurningDirection]
	and a
	jr nz, .not_turning
	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .not_turning

	ld e, a
	ld a, [wPlayerDirection]
	rrca
	rrca
	maskbits NUM_DIRECTIONS
	cp e
	jr z, .not_turning

	ld a, STEP_TURN
	call .DoStep
	ld a, PLAYERMOVEMENT_TURN
	scf
	ret

.not_turning
	xor a
	ret

.TryStep:
; Surfing actually calls .TrySurf directly instead of passing through here.
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jp z, .TrySurf
	cp PLAYER_SURF_PIKA
	jp z, .TrySurf

	call .CheckLandPerms
	jr c, .obstacle

	call .CheckNPC
	and a
	jr z, .obstacle
	cp 2
	jr z, .obstacle

	ld a, [wPlayerStandingTile]
	call CheckIceTile
	jr nc, .ice

; Downhill riding is slower when not moving down.
	call .BikeCheck
	jr nz, .walk

	ld hl, wBikeFlags
	bit BIKEFLAGS_DOWNHILL_F, [hl]
	jr z, .fast

	ld a, [wWalkingDirection]
	cp DOWN
	jr z, .fast

	ld a, STEP_WALK
	call .DoStep
	scf
	ret

.fast
	ld a, STEP_BIKE
	call .DoStep
	scf
	ret

.walk
	ld a, STEP_WALK
	call .DoStep
	scf
	ret

.ice
	ld a, STEP_ICE
	call .DoStep
	scf
	ret

.obstacle
	xor a
	ret

.Waterfall:
	farcall CheckMapCanWaterfall
	ret c

	ld b, HM_WATERFALL
	farcall FarCheckHMSilent
	ret c

	ld d, WATERFALL
	farcall CheckPartyMove
	ret c

	call PlayCurPartyMonCry
	ld c, 10
	call DelayFrames

	ld a, BANK(Script_UsedWaterfallSilent)
	ld hl, Script_UsedWaterfallSilent
	call CallScript
	farcall EnableScriptMode
	farcall ScriptEvents

	jmp .StandInPlace

.Whirlpool:
	ld b, HM_WHIRLPOOL
	farcall FarCheckHMSilent
	ret c
	
	farcall TryWhirlpoolMenu
	ret c

	ld d, WHIRLPOOL
	farcall CheckPartyMove
	ret c

	call PlayCurPartyMonCry
	ld c, 10
	call DelayFrames
	
	call OpenTextPre
	call OpenTextPost
	farcall DisappearWhirlpool
	call CloseText

	jmp .StandInPlace

.TrySurf:
	call .CheckSurfPerms
	ld [wWalkingIntoLand], a
	jr c, .surf_bump

	call .CheckNPC
	ld [wWalkingIntoNPC], a
	and a
	jr z, .surf_bump
	cp 2
	jr z, .surf_bump

	ld a, [wWalkingIntoLand]
	and a
	jr nz, .ExitWater

	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	ld a, STEP_BIKE
	jr z, .DoSurfStep
	
	ld a, STEP_WALK
.DoSurfStep
	call .DoStep
	push af

	ld a, [wOptions2]
	bit FIELD_MOVES, a
	jr z, .EndOfSurfStep

	farcall CheckDirection
	jr c, .EndOfSurfStep

	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .EndOfSurfStep

	call .Whirlpool
	call .Waterfall

.EndOfSurfStep
	pop af
	scf
	ret

.ExitWater:
	call .GetOutOfWater
	call PlayMapMusic
	ld a, STEP_WALK
	call .DoStep
	ld a, PLAYERMOVEMENT_EXIT_WATER
	scf
	ret

.surf_bump
	xor a
	ret

.TryJump:
	ld a, [wPlayerStandingTile]
	ld e, a
	and $f0
	cp HI_NYBBLE_LEDGES
	jr nz, .DontJump

	ld a, e
	and 7
	ld e, a
	ld d, 0
	ld hl, .ledge_table
	add hl, de
	ld a, [wFacingDirection]
	and [hl]
	jr z, .DontJump

; d = x coordinate of tile across the ledge
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wWalkingX]
	add a
	add d
	ld d, a
; e = y coordinate of tile across the ledge
	ld a, [wPlayerStandingMapY]
	ld e, a
	ld a, [wWalkingY]
	add a
	add e
	ld e, a
; make sure the tile across the ledge is walkable
	push de
	call GetCoordCollType
	call .CheckWalkable
	pop de
	jr c, .DontJump
; make sure there's no NPC across the ledge
	xor a
	ldh [hMapObjectIndex], a
	farcall IsNPCAtCoord
	jr c, .DontJump

	ld de, SFX_JUMP_OVER_LEDGE
	call PlaySFX
	ld a, STEP_LEDGE
	call .DoStep
	ld a, PLAYERMOVEMENT_JUMP
	scf
	ret

.DontJump:
	xor a
	ret

.ledge_table
	db FACE_RIGHT             ; COLL_HOP_RIGHT
	db FACE_LEFT              ; COLL_HOP_LEFT
	db FACE_UP                ; COLL_HOP_UP
	db FACE_DOWN              ; COLL_HOP_DOWN
	db FACE_RIGHT | FACE_DOWN ; COLL_HOP_DOWN_RIGHT
	db FACE_DOWN | FACE_LEFT  ; COLL_HOP_DOWN_LEFT
	db FACE_UP | FACE_RIGHT   ; COLL_HOP_UP_RIGHT
	db FACE_UP | FACE_LEFT    ; COLL_HOP_UP_LEFT

.CheckWarp:
	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .not_warp
	ld e, a
	ld d, 0
	ld hl, .EdgeWarps
	add hl, de
	ld a, [wPlayerStandingTile]
	cp [hl]
	jr nz, .not_warp

	ld a, TRUE
	ld [wWalkingIntoEdgeWarp], a
	ld a, [wWalkingDirection]

	ld e, a
	ld a, [wPlayerDirection]
	rrca
	rrca
	maskbits NUM_DIRECTIONS
	cp e
	jr nz, .not_warp
	call WarpCheck
	jr nc, .not_warp

	call .StandInPlace
	scf
	ld a, PLAYERMOVEMENT_WARP
	ret

.not_warp
	xor a ; PLAYERMOVEMENT_NORMAL
	ret

.EdgeWarps:
	db COLL_WARP_CARPET_DOWN
	db COLL_WARP_CARPET_UP
	db COLL_WARP_CARPET_LEFT
	db COLL_WARP_CARPET_RIGHT

.DoStep:
	ld e, a
	ld d, 0
	ld hl, .Steps
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wWalkingDirection]
	ld e, a
	cp STANDING
	jp z, .StandInPlace

	add hl, de
	ld a, [hl]
	ld [wMovementAnimation], a

	ld hl, .FinishFacing
	add hl, de
	ld a, [hl]
	ld [wPlayerTurningDirection], a

	ld a, PLAYERMOVEMENT_FINISH
	ret

.Steps:
; entries correspond to STEP_* constants (see constants/map_object_constants.asm)
	table_width 2, DoPlayerMovement.Steps
	dw .SlowStep
	dw .NormalStep
	dw .FastStep
	dw .JumpStep
	dw .SlideStep
	dw .TurningStep
	dw .BackJumpStep
	dw .FinishFacing
	assert_table_length NUM_STEPS

.SlowStep:
	slow_step DOWN
	slow_step UP
	slow_step LEFT
	slow_step RIGHT
.NormalStep:
	step DOWN
	step UP
	step LEFT
	step RIGHT
.FastStep:
	big_step DOWN
	big_step UP
	big_step LEFT
	big_step RIGHT
.JumpStep:
	jump_step DOWN
	jump_step UP
	jump_step LEFT
	jump_step RIGHT
.SlideStep:
	fast_slide_step DOWN
	fast_slide_step UP
	fast_slide_step LEFT
	fast_slide_step RIGHT
.BackJumpStep:
	jump_step UP
	jump_step DOWN
	jump_step RIGHT
	jump_step LEFT
.TurningStep:
	turn_step DOWN
	turn_step UP
	turn_step LEFT
	turn_step RIGHT
.FinishFacing:
	db $80 | DOWN
	db $80 | UP
	db $80 | LEFT
	db $80 | RIGHT

.StandInPlace:
	ld a, 0
	ld [wPlayerTurningDirection], a
	ld a, movement_step_sleep
	ld [wMovementAnimation], a
	xor a
	ret

._WalkInPlace:
	ld a, 0
	ld [wPlayerTurningDirection], a
	ld a, movement_step_bump
	ld [wMovementAnimation], a
	xor a
	ret

.CheckForced:
; When sliding on ice, input is forced to remain in the same direction.

	call CheckStandingOnIce
	ret nc

	ld a, [wPlayerTurningDirection]
	and a
	ret z

	maskbits NUM_DIRECTIONS
	ld e, a
	ld d, 0
	ld hl, .forced_dpad
	add hl, de
	ld a, [wCurInput]
	and BUTTONS
	or [hl]
	ld [wCurInput], a
	ret

.forced_dpad
	db D_DOWN, D_UP, D_LEFT, D_RIGHT

.GetAction:
; Poll player input and update movement info.

	ld hl, .action_table
	ld de, .action_table_1_end - .action_table_1
	ld a, [wCurInput]
	bit D_DOWN_F, a
	jr nz, .d_down
	bit D_UP_F, a
	jr nz, .d_up
	bit D_LEFT_F, a
	jr nz, .d_left
	bit D_RIGHT_F, a
	jr nz, .d_right
; Standing
	jr .update

.d_down
	add hl, de
.d_up
	add hl, de
.d_left
	add hl, de
.d_right
	add hl, de
.update
	ld a, [hli]
	ld [wWalkingDirection], a
	ld a, [hli]
	ld [wFacingDirection], a
	ld a, [hli]
	ld [wWalkingX], a
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE)
	ld d, a
	ld a, [hl]
	ld [wWalkingY], a
	ld e, a

	ld a, [wPlayerStandingMapX]
	add d
	ld d, a
	ld a, [wPlayerStandingMapY]
	add e
	ld e, a

	call GetCoordCollType
else
	ld a, [hli]
	ld [wWalkingY], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
endc
	ld [wWalkingTile], a
	ret

player_action: MACRO
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE)
; walk direction, facing, x movement, y movement
	db \1, \2, \3, \4
else
; walk direction, facing, x movement, y movement, tile collision pointer
	db \1, \2, \3, \4
	dw \5
endc
ENDM

.action_table:
.action_table_1
if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE)
	player_action STANDING, FACE_CURRENT, 0,  0 ; standing
.action_table_1_end
	player_action RIGHT,    FACE_RIGHT,   1,  0 ; right
	player_action LEFT,     FACE_LEFT,   -1,  0 ; left
	player_action UP,       FACE_UP,      0, -1 ; up
	player_action DOWN,     FACE_DOWN,    0,  1 ; down
else
	player_action STANDING, FACE_CURRENT, 0,  0, wPlayerStandingTile
.action_table_1_end
	player_action RIGHT,    FACE_RIGHT,   1,  0, wTileRight
	player_action LEFT,     FACE_LEFT,   -1,  0, wTileLeft
	player_action UP,       FACE_UP,      0, -1, wTileUp
	player_action DOWN,     FACE_DOWN,    0,  1, wTileDown
endc

.CheckNPC:
; Returns 0 if there is an NPC in front that you can't move
; Returns 1 if there is no NPC in front
; Returns 2 if there is a movable NPC in front
	ld a, 0
	ldh [hMapObjectIndex], a
; Load the next X coordinate into d
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wWalkingX]
	add d
	ld d, a
; Load the next Y coordinate into e
	ld a, [wPlayerStandingMapY]
	ld e, a
	ld a, [wWalkingY]
	add e
	ld e, a
; Find an object struct with coordinates equal to d,e
	farcall IsNPCAtCoord
	jr nc, .is_npc
	call .CheckStrengthBoulder
	jr c, .no_bump

	xor a
	ret

.is_npc
	ld a, 1
	ret

.no_bump
	ld a, 2
	ret

.CheckStrengthBoulder:
	ld hl, wBikeFlags
	bit BIKEFLAGS_STRENGTH_ACTIVE_F, [hl]
	jr z, .not_boulder

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr nz, .not_boulder

	ld hl, OBJECT_PALETTE
	add hl, bc
	bit STRENGTH_BOULDER_F, [hl]
	jr z, .not_boulder

	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 2, [hl]

	ld a, [wWalkingDirection]
	ld d, a
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	and %11111100
	or d
	ld [hl], a

	scf
	ret

.not_boulder
	xor a
	ret

.CheckLandPerms:
; Return 0 if walking onto land and tile permissions allow it.
; Otherwise, return carry.

	ld a, [wTilePermissions]
	ld d, a
	ld a, [wFacingDirection]
	and d
	jr nz, .NotWalkable

	ld a, [wWalkingTile]
	call .CheckWalkable
	jr c, .NotWalkable

	xor a
	ret

.NotWalkable:
	scf
	ret

.CheckSurfPerms:
; Return 0 if moving in water, or 1 if moving onto land.
; Otherwise, return carry.

	ld a, [wTilePermissions]
	ld d, a
	ld a, [wFacingDirection]
	and d
	jr nz, .NotSurfable

	ld a, [wWalkingTile]
	call .CheckSurfable
	jr c, .NotSurfable

	and a
	ret

.NotSurfable:
	scf
	ret

.BikeCheck:
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ret z
	cp PLAYER_SKATE
	ret

.CheckWalkable:
; Return 0 if tile a is land. Otherwise, return carry.

	call GetTileCollision
	and a ; LAND_TILE
	ret z
	scf
	ret

.CheckSurfable:
; Return 0 if tile a is water, or 1 if land.
; Otherwise, return carry.

	call GetTileCollision
	cp WATER_TILE
	jr z, .Water

; Can walk back onto land from water.
	and a ; LAND_TILE
	jr z, .Land

	jr .Neither

.Water:
	xor a
	ret

.Land:
	ld a, 1
	and a
	ret

.Neither:
	scf
	ret

.Bump:
	; If the player is not visually facing the direction he/she is logically facing, don't try the auto field moves, and don't play the bump sound.
	ld a, [wWalkingDirection]
	add a
	add a
	ld e, a
	ld a, [wPlayerDirection]
	sub e
	ret nz

	; When the player bumps into specific tiles, we try to automatically activate some field moves.
	; Water obstacles (waterfall and whirlpool) don’t Bump. So they are checked somewhere else.
	ld a, [wOptions2]
	bit FIELD_MOVES, a
	jr z, .BumpSound

	farcall CheckDirection
	jr c, .BumpSound

	call GetFacingTileCoordAndCollType
	cp COLL_CUT_TREE
	jr z, .AutoCut

	call GetTileCollision
	cp WATER_TILE
	jr z, .AutoSurf

	farcall GetFacingObject
	jr c, .BumpSound

	ld a, d
	and LOW(~CLAP_F)
	cp SPRITEMOVEDATA_SMASHABLE_ROCK
	jp z, .AutoRockSmash

	cp SPRITEMOVEDATA_STRENGTH_BOULDER
	jp z, .AutoStrength

	; Checking the sprite.
	ldh a, [hObjectStructIndex]
	call GetObjectStruct
	;ld hl, OBJECT_SPRITE ; This is 0, so we don't need to add BC to HL.
	;add hl, bc
	ld a, [hl]
	cp SPRITE_POKE_BALL
	jr nz, .BumpSound
	
	;ld hl, OBJECT_MAP_OBJECT_INDEX ; This is 1, so it's faster to INC HL rather than ADD HL, BC.
	;add hl, bc
	inc hl
	ld a, [hl]
	call GetMapObject
	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and %00001111
	cp OBJECTTYPE_ITEMBALL
	jr nz, .BumpSound

	; Automatically picking itemballs.
	farcall InteractWithObj ; Calls PlayTalkObject which plays the SFX.
	ld a, BANK(FindItemInBallScript)
	ld hl, FindItemInBallScript
	call CallScript
	farcall EnableScriptMode
	farcall ScriptEvents
	ret

.InteractWithObj:
	callasm InteractWithObj
	end
	
.BumpSound:
	ld a, [wCurSFX]
	cp SFX_CHEERING
	jr z, .PlayBumpSound
	
	call CheckSFX
	ret c

.PlayBumpSound
	ld de, SFX_BUMP
	jmp PlaySFX

.AutoCut:
	farcall CheckAPressOW.try_to_cut
	jr c, .BumpSound
	ret

.AutoSurf:
	ld b, HM_SURF
	farcall FarCheckHMSilent
	jp c, .BumpSound

	farcall FarTrySurf
	ld a, b
	cp $1
	jr nz, .BumpSound

	farcall FindBestSurfer
	jr c, .BumpSound

	; Do Surf.
	farcall GetSurfType
	ld a, d
	ld [wSurfingPlayerState], a

	call PlayCurPartyMonCry
	ld a, BANK(UsedSurfScriptSilent)
	ld hl, UsedSurfScriptSilent
	call CallScript
	farcall EnableScriptMode
	farcall ScriptEvents
	ret

.AutoRockSmash:
	ld d, ROCK_SMASH
	farcall CheckPartyMove
	jr c, .BumpSound

	call PlayCurPartyMonCry
	ld a, BANK(RockSmashScriptNoText)
	ld hl, RockSmashScriptNoText
	call CallScript
	farcall EnableScriptMode
	farcall ScriptEvents
	ret

.AutoStrength:
	ld b, HM_STRENGTH
	farcall FarCheckHMSilent
	jmp c, .BumpSound

	ld d, STRENGTH
	farcall CheckPartyMove
	jmp c, .BumpSound

	; This one is complicated.
	; When bumping into a boulder, even if it can't be pushed, we should always activate Strength.
	; Once activated, we should play the bump sound when the boulder can't be pushed away.

	ld a, [wBikeFlags]
	bit BIKEFLAGS_STRENGTH_ACTIVE_F, a
	jmp nz, .BumpSound ; The bump sound won't play if the "boulder push" sound is being played.

.ActivateStrength
	call PlayCurPartyMonCry
	farcall SetStrengthFlag
	jmp .CheckNPC ; Pushes the Boulder as soon as Strength is activated. 2 actions in 1 input.

.GetOutOfWater:
	push bc
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	call UpdatePlayerSprite ; UpdateSprites
	pop bc
	ret

PlayCurPartyMonCry::
	xor a
	ld [wMonType], a
	ld a, [wCurPartyMon]
	ld e, a
	farcall GetMonSpecies
	ld a, [wCurPartySpecies]
	jmp PlayMonCry

CheckStandingOnIce::
	ld a, [wPlayerTurningDirection]
	and a
	jr z, .not_ice
	cp $f0
	jr z, .not_ice
	ld a, [wPlayerStandingTile]
	call CheckIceTile
	jr nc, .yep
	ld a, [wPlayerState]
	cp PLAYER_SKATE
	jr nz, .not_ice

.yep
	scf
	ret

.not_ice
	and a
	ret

StopPlayerForEvent::
	call SetNormalStateIfClapping
	ld hl, wPlayerNextMovement
	ld a, movement_step_sleep
	cp [hl]
	ret z

	ld [hl], a
	ld a, 0
	ld [wPlayerTurningDirection], a
	ret

SetNormalStateIfClapping::
	ld a, [wPlayerState]
	cp PLAYER_CLAP
	ret nz

	; Reset the clapping idle cooldown.
	ld a, [wClappingData]
	and ~CLAPPING_IDLE_FRAMES_MASK
	ld [wClappingData], a
	
	farcall NursesStopBowing

	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	jmp UpdatePlayerSprite