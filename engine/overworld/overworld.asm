GetEmote2bpp:
	ld a, $1
	ldh [rVBK], a
	call Get2bpp
	xor a
	ldh [rVBK], a
	ret

_UpdatePlayerSprite::
	call GetPlayerSprite
	ld a, [wUsedSprites]
	ldh [hUsedSpriteIndex], a
	ld a, [wUsedSprites + 1]
	ldh [hUsedSpriteTile], a
	call GetUsedSprite

	; Setting the right color. Must be called after GetPlayerSprite, because it can change wPlayerState.
	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	jr z, .red

	cp PLAYER_SURF
	jr z, .blue

	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .red

.blue
	ld d, (PAL_NPC_BLUE << 4) ; Damien.
	jr .apply_palette

.red
	ld d, (PAL_NPC_RED << 4) ; Damien.
.apply_palette
	farcall _SetPlayerPalette
	ret

_RefreshSprites: ; mobile
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	res 7, [hl]
	set 6, [hl]
	call LoadUsedSpritesGFX
	pop af
	ld [wSpriteFlags], a
	ret

_ClearSprites: ; mobile
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	set 7, [hl]
	res 6, [hl]
	call LoadUsedSpritesGFX
	pop af
	ld [wSpriteFlags], a
	ret

GetPlayerSprite:
; Get Chris or Kris's sprite.
	ld hl, ChrisStateSprites
	ld a, [wPlayerSpriteSetupFlags]
	bit PLAYERSPRITESETUP_FEMALE_TO_MALE_F, a
	jr nz, .go

	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .go

	ld hl, KrisStateSprites
.go
	ld a, [wPlayerState]
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .good

	inc hl
	cp -1
	jr nz, .loop

; Any player state not in the array defaults to Chris's sprite.
	xor a ; ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	ld a, SPRITE_CHRIS
	jr .finish

.good
	ld a, [hl]

.finish
	ld [wUsedSprites + 0], a
	ld [wPlayerSprite], a
	ld [wPlayerObjectSprite], a
	ret

INCLUDE "data/sprites/player_sprites.asm"

AddIndoorSprites:
	ld hl, wMap1ObjectSprite
	ld a, 1
.loop
	push af
	ld a, [hl]
	call AddSpriteGFX
	ld de, MAPOBJECT_LENGTH
	add hl, de
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

AddMapSprites:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, AddOutdoorSprites

	jr AddIndoorSprites

AddOutdoorSprites:
	ld a, [wMapGroup]
	dec a
	ld c, a
	ld b, 0
	ld hl, OutdoorSprites
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, wUsedSprites + 1
	
	ld a, WALKING_SPRITE
	ld [bc], a
	inc bc 
.loop
	ld a, [hli]
	and a
	ret z

	ld [bc], a
	inc bc

	ld a, [hli]
	ld [bc], a
	inc bc

	;call AddSpriteGFX
	jr .loop

RefreshSprites::
	xor a
	ld bc, wUsedSpritesEnd - wUsedSprites
	ld hl, wUsedSprites
	call ByteFill
	call GetPlayerSprite
	call AddMapSprites
	call LoadAndSortSprites
	; fallthrough.

LoadUsedSpritesGFX:
	ld a, MAPCALLBACK_SPRITES
	call RunMapCallback
	call GetUsedSprites
	; fallthrough.

LoadMiscTiles:
	ld a, [wSpriteFlags]
	bit 6, a
	ret nz

	ld c, EMOTE_SHADOW
	farcall LoadEmote
	ret

SafeGetSprite:
	push hl
	call GetSprite
	pop hl
	ret

GetSprite:
	call GetMonSprite
	ret c

	ld hl, OverworldSprites + SPRITEDATA_ADDR
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEDATA_FIELDS
	call AddNTimes

	; load the address into de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	; load the sprite bank into both b and h
	ld a, [hli]
	ld b, a

	; Window Clapping special case.
	ld a, c ; Retrieving the sprite ID that was given in A as an input to this function.
	inc a
	call SelectSpriteVariant
	jr z, .load_length

	; loading the alternate sprite (clapping).
	push hl
	ld hl, ClappingOverworldSprites
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc

	; loads the address
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	; load the sprite bank into b
	ld b, [hl]
	pop hl

.load_length
	; load the length into c
	ld a, [hli]
	swap a
	ld c, a
	; load the sprite type into l
	ld l, [hl]
	ld h, b
	ret

; Output: nz if clapping variant must be loaded. z if regular version must be loaded.
SelectSpriteVariant:
	push bc
	push de
	push hl
	call FindSpriteVariant
	pop hl
	pop de
	pop bc
	and a
	ret

; Input: the sprite ID in A.
; Outputs: 
; - the sprite variant in A (0 = regular, 1 = clapping).
; - nz if the sprite variant has been changed.
; Clobbers B, C, D, E, H, L.
FindSpriteVariant:
; If the sprite we loaded is one of the map objects, we register which variant we loaded. 
; Only the first map_object instance using this sprite will be considered. 
; All other map_objects must use the same sprite variant.
	ld hl, wMap1ObjectSprite
	ld de, MAPOBJECT_LENGTH
	call IsInArray
	jr nc, .return_unchanged ; If the sprite is not in the array, we'll return 0 and z.

	ld a, [wClappingData]
	ld e, MAPOBJECT_MOVEMENT - MAPOBJECT_SPRITE
	ld d, 0
	add hl, de
	and [hl]
	and CLAP_F

rept 8 - CLAP_BEHAVIOUR_BIT
	rlca ; Move the value of CLAP_F from bit 7 to bit 0.
endr

	ld e, MAPOBJECT_SPRITE_VARIANT - MAPOBJECT_MOVEMENT
	add hl, de
	cp [hl]
	ld [hl], a
	ret

.return_unchanged
	xor a
	ret

GetMonSprite:
; Return carry if a monster sprite was loaded.

	cp SPRITE_POKEMON
	jr c, .Normal
	cp SPRITE_DAY_CARE_MON_1
	jr z, .BreedMon1
	cp SPRITE_DAY_CARE_MON_2
	jr z, .BreedMon2
	cp SPRITE_HOSPITAL_MON
	jr z, .HospitalMon
	cp SPRITE_VARS
	jr nc, .Variable
	jr .Icon

.Normal:
	and a
	ret

.Icon:
	sub SPRITE_POKEMON
	ld e, a
	ld d, 0
	ld hl, SpriteMons
	add hl, de
	ld a, [hl]
	jr .Mon

.BreedMon1
	ld a, [wBreedMon1Species]
	jr .Mon

.BreedMon2
	ld a, [wBreedMon2Species]
	jr .Mon

.HospitalMon
	ld a, [wSickMonIsInThisRoom]
	cp FALSE
	jr z, .EmptyHospitalMon

	cp 2 ; Vaccination center and Bill's House.
	ld a, [wCurPartySpecies]
	jr z, .Mon

	ld a, [wScriptVar]
	farcall SetHospitalMonSpecies
	ld a, [wTempWildMonSpecies]
	jr .Mon

.EmptyHospitalMon
	ld a, 252 ; Egg by default (will be hidden anyway).

.Mon:
	ld e, a
	and a
	jr z, .NoBreedmon

	farcall LoadOverworldMonIcon

	lb hl, 0, POKEMON_SPRITE
	scf
	ret

.Variable:
	sub SPRITE_VARS
	ld e, a
	ld d, 0
	ld hl, wVariableSprites
	add hl, de
	ld a, [hl]
	and a
	jp nz, GetMonSprite

.NoBreedmon:
	ld a, WALKING_SPRITE
	lb hl, 0, WALKING_SPRITE
	and a
	ret

_DoesSpriteHaveFacings::
; Checks to see whether we can apply a facing to a sprite.
; Returns carry unless the sprite is a Pokemon or a Still Sprite.
	cp SPRITE_POKEMON
	jr nc, .only_down

	push hl
	push bc
	ld hl, OverworldSprites + SPRITEDATA_TYPE
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEDATA_FIELDS
	call AddNTimes
	ld a, [hl]
	pop bc
	pop hl
	cp STILL_SPRITE
	jr nz, .only_down
	scf
	ret

.only_down
	and a
	ret

_GetSpritePalette::
	ld a, c
	call GetMonSprite
	jr c, .is_pokemon

	ld hl, OverworldSprites + SPRITEDATA_PALETTE
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEDATA_FIELDS
	call AddNTimes
	ld c, [hl]
	ret

.is_pokemon
	xor a
	ld c, a
	ret

AddSpriteGFX:
; Add any new sprite ids to a list of graphics to be loaded.
; Return carry if the list is full.

	push hl
	push bc
	ld b, a
	ld hl, wUsedSprites + 2
	ld c, SPRITE_GFX_LIST_CAPACITY - 1
.loop
	ld a, [hl]
	cp b
	jr z, .exists
	and a
	jr z, .new
	inc hl
	inc hl
	dec c
	jr nz, .loop

	pop bc
	pop hl
	scf
	ret

.exists
	pop bc
	pop hl
	and a
	ret

.new
	ld [hl], b
	pop bc
	pop hl
	and a
	ret

LoadSpriteGFX:
	ld hl, wUsedSprites
	ld b, SPRITE_GFX_LIST_CAPACITY
.loop
	ld a, [hli]
	and a
	ret z

	push hl
	call .LoadSprite
	pop hl
	ld [hli], a
	dec b
	jr nz, .loop
	ret

.LoadSprite:
	push bc
	call GetSprite
	pop bc
	ld a, l
	ret

LoadAndSortSprites:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, ArrangeUsedSprites ; Outdoor maps jump to ArrangeUsedSprites, and skip LoadSpriteGFX.

	call LoadSpriteGFX
	; fallthrough.

ArrangeUsedSprites:
; Get the length of each sprite and space them out in VRAM.
; Crystal introduces a second table in VRAM bank 0.

	ld hl, wUsedSprites
	ld c, SPRITE_GFX_LIST_CAPACITY
	ld b, 0
.FirstTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	jr z, .quit

	ld a, [hl]
	call .GetSpriteLength

; Spill over into the second table after $80 tiles.
	add b
	cp $20
	jr z, .loop
	jr nc, .SecondTable

.loop
	ld [hl], b
	inc hl
	ld b, a

; Assumes the next table will be reached before c hits 0.
	dec c
	jr nz, .FirstTableLength

.SecondTable:
; The second tile table starts at tile $80.
	ld b, $20
	dec hl
.SecondTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	jr z, .quit

	ld a, [hl]
	call .GetSpriteLength

; There are only two tables, so don't go any further than that.
	add b
	cp $41 - (8 / 4) ; NOTE: the last 8 tiles are reserved to Emotes.
	jr nc, .ThirdTable

	ld [hl], b
	ld b, a
	inc hl

	dec c
	jr nz, .SecondTableLength

.ThirdTable:
; The third tile table starts at tile $00, but in VRAM 0 instead of VRAM 1 for the 2 previous tables.
	ld b, $40
	dec hl
.ThirdTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	jr z, .quit

	ld a, [hl]
	call .GetSpriteLength

; Spill over into the second table after $80 tiles.
	add b
	cp $61
	jr nc, .quit

	ld [hl], b
	inc hl
	ld b, a

; Assumes the next table will be reached before c hits 0.
	dec c
	jr nz, .ThirdTableLength
	
.quit
	ret

.GetSpriteLength:
; Return the length of sprite type a in tiles.

	cp WALKING_SPRITE
	jr z, .Walking
	cp STANDING_SPRITE
	jr z, .AnyDirection
	cp POKEMON_SPRITE
	jr z, .Pokemon
	cp STILL_SPRITE
	jr z, .OneDirection

	; Default case?
	; fallthrough

.AnyDirection:
	ld a, 12 / 4
	ret

.Pokemon:
	ld a, 8 / 4
	ret

.Walking:
	ld a, 24 / 4
	ret

.OneDirection:
	ld a, 4 / 4
	ret

UpdateSpriteVariants::
	ld hl, wUsedSprites
	ld c, SPRITE_GFX_LIST_CAPACITY
.loop
	ld a, [wSpriteFlags]
	res 5, a
	ld [wSpriteFlags], a

	ld a, [hli]
	and a
	ret z

	ldh [hUsedSpriteIndex], a

	push bc
	push hl
	call FindSpriteVariant
	pop hl
	pop bc
	ld a, [hli]
	jr z, .next

	ldh [hUsedSpriteTile], a
	cp $40
	jr c, .dont_set

	ld a, [wSpriteFlags]
	set 5, a ; load VBank0
	ld [wSpriteFlags], a

.dont_set
	push bc
	push hl
	call GetUsedSprite
	pop hl
	pop bc
	
.next
	dec c
	jr nz, .loop
	ret

.updateSprite
	ret

GetUsedSprites::
	ld hl, wUsedSprites
	ld c, SPRITE_GFX_LIST_CAPACITY

.loop
	ld a, [wSpriteFlags]
	res 5, a
	ld [wSpriteFlags], a

	ld a, [hli]
	and a
	ret z

	ldh [hUsedSpriteIndex], a

	ld a, [hli]
	ldh [hUsedSpriteTile], a

	;bit 7, a
	;jr z, .dont_set

	cp $40
	jr c, .dont_set

	ld a, [wSpriteFlags]
	set 5, a ; load VBank0
	ld [wSpriteFlags], a

.dont_set
	push bc
	push hl
	call GetUsedSprite
	pop hl
	pop bc
	dec c
	jr nz, .loop

	ret

GetUsedSprite:
	ldh a, [hUsedSpriteIndex]
	call SafeGetSprite
	call .GetTileAddr
	push hl
	push de
	push bc
	ld a, [wSpriteFlags]
	bit 7, a
	jr nz, .skip
	call .CopyToVram

.skip
	pop bc
	ld l, c ; Gets the Length attribute of the overworld_sprite struct.
	ld h, $0
rept 4
	add hl, hl
endr
	pop de ; Retrieves the GFX pointer attribute from the overworld_sprite struct.
	add hl, de
	ld d, h
	ld e, l ; DE contains the number of bytes to copy.
	pop hl ; HL contains the tile address in VRAM (target for the copy).

	ld a, [wSpriteFlags]
	bit 6, a
	jr nz, .done

	ldh a, [hUsedSpriteIndex]
	call _DoesSpriteHaveFacings
	jr c, .done

	push bc
	ld bc, 12 tiles
	add hl, bc
	pop bc
	call .CopyToVram

.done
	ret

.GetTileAddr:
; Return the address of tile (a) in (hl).
	ldh a, [hUsedSpriteTile]
	add a
	add a
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld a, l
	add LOW(vTiles0)
	ld l, a
	ld a, h
	adc HIGH(vTiles0)
	ld h, a
	ret

.CopyToVram:
	ldh a, [rVBK]
	push af
	ld a, [wSpriteFlags]
	bit 5, a
	ld a, $1
	jr z, .bankswitch
	ld a, $0

.bankswitch
	ldh [rVBK], a
	call Get2bpp
	pop af
	ldh [rVBK], a
	ret

LoadEmote::
; Get the address of the pointer to emote c.
	ld a, c
	ld bc, EMOTE_LENGTH
	ld hl, Emotes
	call AddNTimes
; Load the emote address into de
	ld e, [hl]
	inc hl
	ld d, [hl]
; load the length of the emote (in tiles) into c
	inc hl
	ld c, [hl]
	swap c
; load the emote pointer bank into b
	inc hl
	ld b, [hl]
; load the VRAM destination into hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
; if the emote has a length of 0, do not proceed (error handling)
	ld a, c
	and a
	ret z
	jmp GetEmote2bpp

INCLUDE "data/sprites/emotes.asm"

INCLUDE "data/sprites/sprite_mons.asm"

INCLUDE "data/maps/outdoor_sprites.asm"

INCLUDE "data/sprites/sprites.asm"
