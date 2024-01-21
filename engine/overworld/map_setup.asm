RunMapSetupScript::
	ldh a, [hMapEntryMethod]
	and $f
	dec a
	ld c, a
	ld b, 0
	ld hl, MapSetupScripts
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ReadMapSetupScript
	ret

INCLUDE "data/maps/setup_scripts.asm"

ReadMapSetupScript:
.loop
	ld a, [hli]
	cp -1 ; end?
	ret z

	push hl

	ld c, a
	ld b, 0
	ld hl, MapSetupCommands
	add hl, bc
	add hl, bc
	add hl, bc

	; bank
	ld b, [hl]
	inc hl

	; address
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Bit 7 of the bank indicates a parameter.
	; This is left unused.
	bit 7, b
	jr z, .go

	pop de
	ld a, [de]
	ld c, a
	inc de
	push de

.go
	ld a, b
	and $7f
	rst FarCall

	pop hl
	jr .loop

INCLUDE "data/maps/setup_script_pointers.asm"

EnableTextAcceleration:
	xor a
	ld [wDisableTextAcceleration], a
	ret

ActivateMapAnims:
	ld a, TRUE
	ldh [hMapAnims], a
	ret

SuspendMapAnims:
	xor a ; FALSE
	ldh [hMapAnims], a
	ret

LoadMapObjects::
	ld a, MAPCALLBACK_OBJECTS
	call RunMapCallback
	farcall LoadObjectMasks
	farcall InitializeVisibleSprites
	ret

MapSetup_DummyFunction: ; unreferenced
	ret

ResetPlayerObjectAction:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_RESET_ACTION_F, [hl]
	ret

SkipUpdateMapSprites:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F, [hl]
	ret

CheckUpdatePlayerSprite:
	nop
	call .CheckBiking
	jr c, .ok
	call .CheckSurfing
	jr c, .ok
	call .CheckSurfing2
	jr c, .ok
	ret

.ok
	call UpdatePlayerSprite
	ret

.CheckBiking:
	and a
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	ret z
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	scf
	ret

.CheckSurfing2:
	ld a, [wPlayerState]
	cp PLAYER_NORMAL
	jr z, .nope
	cp PLAYER_SKATE
	jr z, .nope
	cp PLAYER_SURF
	jr z, .surfing
	cp PLAYER_SURF_PIKA
	jr z, .surfing
	call GetMapEnvironment
	cp INDOOR
	jr z, .no_biking
	cp ENVIRONMENT_5
	jr z, .no_biking
	cp DUNGEON
	jr z, .no_biking
	jr .nope
.no_biking
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .nope
.surfing
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	scf
	ret

.nope
	and a
	ret

.CheckSurfing:
	call CheckOnWater
	jr nz, .nope2
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .is_surfing
	cp PLAYER_SURF_PIKA
	jr z, .is_surfing

	ld d, SURF
	farcall CheckPartyMove ; Sets wCurPartyMon for GetSurfType.
	ld a, PLAYER_SURF
	ld [wPlayerState], a ; If the player has no Pokémon that knows Surf, we still display a Lapras.
	jr c, .is_surfing

	farcall GetSurfType
	ld a, d
	;ld a, PLAYER_SURF ; This needs to check if we are surfing on Pikachu or Lapras. Only works if the "SURF" option is hidden in the menu, and the game decides to use the first mon that knows Surf.
	
	ld [wPlayerState], a
.is_surfing
	scf
	ret

.nope2
	and a
	ret

FadeOutMapMusic:
	ld a, 6
	call SkipMusic
	ret

ApplyMapPalettes:
	farcall _UpdateTimePals
	ret

FadeMapMusicAndPalettes:
	ld e, LOW(MUSIC_NONE)
	ld a, [wMusicFadeID]
	ld d, HIGH(MUSIC_NONE)
	ld a, [wMusicFadeID + 1]
	ld a, $4
	ld [wMusicFade], a
	call RotateThreePalettesRight
	ret

ForceMapMusic:
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .notbiking
	call MinVolume
	ld a, $88
	ld [wMusicFade], a
.notbiking
	call TryRestartMapMusic
	ret

DynamicWarpPrevious::
	ld a, [wPrevWarp]
	ld [wNextWarp], a

	ld a, [wPrevMapGroup]
	ld [wNextMapGroup], a
	
	ld a, [wPrevMapNumber]
	ld [wNextMapNumber], a
	ret

DynamicWarpScript::
; Warp from the Hospital's corridor to the Hospital's reception.
	; Only works when the player is in the Hospital's corridor.
	ld a, [wMapGroup]
	cp GROUP_GOLDENROD_HOSPITAL_CORRIDOR
	jr nz, .end_check_1

	ld a, [wMapNumber]
	cp MAP_GOLDENROD_HOSPITAL_CORRIDOR
	jr nz, .end_check_1

	; Now we're checking if the player took the bottom left warp from the corridor ID 1.
	ld a, [wGoldenrodHospitalCorridorNumber]
	cp 1
	jr nz, .check_1_default_case

	ld a, [wPrevWarp] ; The player comes from warp ID 1 or 2, are those are the only dynamic warps on this map.
	add 3

	; We change the warp destination to the Hospital's reception.
	ld [wNextWarp], a
	ld a, GROUP_GOLDENROD_HOSPITAL_1F
	ld [wNextMapGroup], a
	ld a, MAP_GOLDENROD_HOSPITAL_1F
	ld [wNextMapNumber], a
	jr .end_check_1

.check_1_default_case
	ld a, [wPrevWarp]
	add 2 
	ld [wNextWarp], a
	
.end_check_1
	ret