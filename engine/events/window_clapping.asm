; Output: carry is it is currently clapping time, within a clapping area (town).
; Clobbers B.
IsClappingAuthorized::
    ldh a, [hHours] ; Quickest dismissal method. So we put it first.
    cp 20
    jr nz, .return_false
    
    push bc
    push de
    push hl
    ld a, [wEnvironment]
    ld hl, ClappingEnvironments
    call IsInByteArray
    pop hl
    pop de
    pop bc
    ret nc
    ;ret ; A virer.
    
    ld a, [wYearMonth] ; Upper nibble = year (0 = 2020), lower nibble = month (0 = january).
    cp $07 ; August 2020.
    ret nc

    sub $02 ; March 2020.
    add a
    ld b, a
    ld a, 10
    sub b
    ld b, a

    ldh a, [hMinutes]
    cp b
    ret

    ; 0. january  = return
    ; 1. february = return
    ; 2. march    = 10 minutes of clapping (from minute 0:00 to 9:59)
    ; 3. april    = 8 minutes
    ; 4. may      = 6 minutes
    ; 5. june     = 4 minutes
    ; 6. july     = 2 minutes
    ; 7. august   = return

.return_false
    xor a
    ret

ClappingEnvironments:
    db TOWN
    db INDOOR
    db ENVIRONMENT_5
    db -1

IsClappingAuthorizedScript::
    ld a, [wClappingData]
    and CLAP_F
    rlca
    ld [wScriptVar], a
    ret

NursesStopBowing::
    ld b, 1
    jr NursesBowWhenClappedAt.loop_init

NursesBowWhenClappedAt::
    ld b, 0 ; start bowing param.

    ld a, [wClappingData]
    bit CLAP_BEHAVIOUR_BIT, a
    ret z

    and CLAPPING_IDLE_FRAMES_MASK
    and a
    ret z

.loop_init
    ld hl, wObject1Struct
	ld c, NUM_OBJECT_STRUCTS
.loop
	ld a, [hl]
	and a
    jr z, .next

    cp SPRITE_HOSPITAL_VISITOR ; 4 Nurses (including Chief Nurse Joy before the lockdown starts) use this variable sprite.
    jr z, .check_variable_sprite

    cp SPRITE_HOSPITAL_HUMAN_PATIENT ; 2 Nurses (including one that is sick) use this variable sprite.
    jr z, .check_variable_sprite

.variable_sprite_decrypted
    cp SPRITE_NURSE
    jr nz, .next

    push hl
    push bc

    ld a, b
    and a
    ld b, SPRITEMOVEDATA_POKEMON
    ld c, OBJECT_ACTION_BOUNCE
    jr z, .start_bowing

    ; stop bowing data.
    ld b, SPRITEMOVEDATA_STANDING_DOWN
    ld c, OBJECT_ACTION_STAND
.start_bowing
    ld de, OBJECT_MOVEMENTTYPE - OBJECT_SPRITE
	add hl, de
    ld a, [hl]
    cp b ; If we change the movement type, we also reset the frame counter, so the animation plays from its start.
    ld a, b
    ld [hl], a
    jr z, .no_frame_reset

    push hl
    ld de, OBJECT_STEP_FRAME - OBJECT_MOVEMENTTYPE
	add hl, de
    ld [hl], 0
    pop hl

.no_frame_reset
    ld de, OBJECT_ACTION - OBJECT_MOVEMENTTYPE
	add hl, de
    ld a, c
    ld [hl], a
    pop bc
    pop hl
	
.next
    ld de, OBJECT_LENGTH
    add hl, de
	dec c
	jr nz, .loop
	ret

.check_variable_sprite
    push de
    push hl
    ld hl, wVariableSprites - SPRITE_VARS
    ld e, a
    ld d, 0
    ld a, d
    add hl, de

    ld a, [wMapGroup]
	cp GROUP_GOLDENROD_HOSPITAL_ROOM
	jr nz, .skip

	ld a, [wMapNumber]
	cp MAP_GOLDENROD_HOSPITAL_ROOM
	jr nz, .skip

    ld a, [wGoldenrodHospitalCorridorNumber]
    cp 1
    jr z, .skip ; Nurse in the rooms of the first corridor can't bow: 1 is the stressed out Chief Nurse Joy, and the other one is a sick one.

    ld a, [hl]
.skip
    pop hl
    pop de
    jr .variable_sprite_decrypted
