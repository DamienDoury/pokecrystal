; Output: carry is it is currently clapping time, within a clapping area (town).
; Clobbers everything.
IsClappingAuthorized::
    ;ldh a, [hHours] ; Quickest dismissal method. So we put it first.
    ;cp 20
    ;jr nz, .return_false
    
    ;ld b, CHECK_FLAG
    ;ld de, EVENT_FIRST_LOCKDOWN_STARTED
    ;call EventFlagAction
    ;ret z

    ; No clapping in gyms.
    ld a, [wMapMusic]
    cp MUSIC_GYM
    ret z

    ; Clapping only takes place inside towns.
    call IsInClappingTown
    ret z

    push bc
    push de
    ld a, [wEnvironment]
    ld hl, ClappingEnvironments
    call IsInByteArray
    pop de
    pop bc
    ret nc
    ret ; A virer.
    
    ld a, [wYearMonth] ; Upper nibble = year (0 = 2020), lower nibble = month (0 = january).
    cp $07 ; August 2020.
    ret nc

    sub $02 ; March 2020. A is now [0-4].
    ld b, a
    add a
    add b
    ld b, a ; A has been multiplied by 3, and is now [0, 3, 6, 9, 12].
    ld a, 15
    sub b
    ld b, a

    ldh a, [hMinutes]
    cp b
    ret

    ; 0. january  = return
    ; 1. february = return
    ; 2. march    = 15 minutes of clapping (from minute 0:00 to 9:59)
    ; 3. april    = 12 minutes
    ; 4. may      = 9 minutes
    ; 5. june     = 6 minutes
    ; 6. july     = 3 minutes
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

HasPlayerClappedALotInThisRoom::
    xor a ; FALSE
    ld [wScriptVar], a

    ld hl, wClappingData
    bit CLAPPED_A_LOT_IN_THIS_ROOM_BIT, [hl]
    ret z

    inc a ; TRUE
    ld [wScriptVar], a
    ret

HasPlayerClappedALotInThisRoom_WithReset::
    call HasPlayerClappedALotInThisRoom
    ; fallthrough.
    
ResetClapInThisRoom::
    ld a, [wClappingData]
    and ~CLAP_COUNT_IN_ROOM_MASK
    ld [wClappingData], a
    ret

ClappingTownLandmarks:
    db \
    1 << (LANDMARK_NEW_BARK_TOWN % 8) /*01*/ | \
    1 << (LANDMARK_CHERRYGROVE_CITY % 8) /*03*/ | \
    1 << (LANDMARK_VIOLET_CITY % 8) /*06*/

    db \
    1 << (LANDMARK_ROUTE_32 % 8) /*08*/ | \ ; Used for Route32 Pokécenter.
    1 << (LANDMARK_AZALEA_TOWN % 8) /*0c*/

    db \
    1 << (LANDMARK_GOLDENROD_CITY % 8) /*10*/ | \
    1 << (LANDMARK_HOSPITAL % 8) /*12*/ | \
    1 << (LANDMARK_ECRUTEAK_CITY % 8) /*17*/

    db \
    1 << (LANDMARK_OLIVINE_CITY % 8) /*1c*/

    db \
    1 << (LANDMARK_CIANWOOD_CITY % 8) /*22*/ | \
    1 << (LANDMARK_MAHOGANY_TOWN % 8) /*25*/

    db \
    1 << (LANDMARK_BLACKTHORN_CITY % 8) /*2a*/

    ;db \
    ;1 << (LANDMARK_PALLET_TOWN % 8) /*30*/ | \
    ;1 << (LANDMARK_VIRIDIAN_CITY % 8) /*32*/ | \
    ;1 << (LANDMARK_PEWTER_CITY % 8) /*35*/
    ;
    ;db \
    ;1 << (LANDMARK_CERULEAN_CITY % 8) /*39*/
    ;
    ;db \
    ;1 << (LANDMARK_VERMILION_CITY % 8) /*40*/
    ;
    ;db \
    ;1 << (LANDMARK_LAVENDER_TOWN % 8) /*48*/ | \
    ;1 << (LANDMARK_CELADON_CITY % 8) /*4a*/ | \
    ;1 << (LANDMARK_SAFFRON_CITY % 8) /*4b*/
    ;
    ;db \
    ;1 << (LANDMARK_FUCHSIA_CITY % 8) /*55*/
    ;
    ;ds 1 ; $58 to $5f
    ;ds 1 ; $60 to $67

; Output: NZ if inside a clapping town. Z otherwise.
IsInClappingTown:
    ld a, [wCurLandmark]
    cp LANDMARK_BLACKTHORN_CITY + 1
    jr nc, .return_false
    
    ld d, 0
    ld e, a
    ld hl, ClappingTownLandmarks
    ld b, CHECK_FLAG
    jp FlagAction

.return_false
    xor a
    ret

; Output: carry if the NPC has the CLAP_F bit in its movement type.
; The use of setlasttalked in the same script as jumptextfaceplayer may break this security.
; But I checked, and it should never be the case anyway.
; Most of the time, setlasttalked actually helps targetting the right NPC .
IsNPCClapping::
    ; Return if the hLastTalkedValue is out of bounds.
    ld a, [hLastTalked]
    and a
    ret z

    cp NUM_OBJECTS + 1
    ret nc

    ; Getting the map object data.
    ld hl, wPlayerObject + MAPOBJECT_SPRITE
    ld bc, MAPOBJECT_LENGTH
    call AddNTimes

    ; A few sprites can't clap.
    ld a, [hl]
    push hl
    ld hl, .non_clapping_sprites
    call IsInByteArray
    pop hl
    ccf
    ret nc

    ; Checking the sprite's CLAP_F flag.
    ccf ; Reset the carry to zero.
    ld bc, MAPOBJECT_MOVEMENT - MAPOBJECT_SPRITE
    add hl, bc
    bit CLAP_BEHAVIOUR_BIT, [hl] ; Doesn't touch the carry flag.
    ret z

    ; The object type must be OBJECTTYPE_SCRIPT. Note that the object type is stored with the color attribute.
    ld bc, MAPOBJECT_COLOR - MAPOBJECT_MOVEMENT
    add hl, bc
    ld a, [hl]
    and $f ; Masking out the color, to keep only the object type.
    sub 1 ; sub 1 will return a carry only if A is 0. OBJECTTYPE_SCRIPT is 0.
    ret

.non_clapping_sprites
    db SPRITE_ROCKET
    db SPRITE_ROCKET_GIRL
    db SPRITE_ROCKER
    db SPRITE_GAMEBOY_KID
    db SPRITE_NURSE
    db SPRITE_GYM_GUIDE
    db SPRITE_PHARMACIST
    db -1
