MAP_NAME_SIGN_START EQU $60

InitMapNameSign::
	call .CheckPoliceStationMap
	ret z

	xor a
	ldh [hBGMapMode], a
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld [wCurLandmark], a
	call .CheckNationalParkGate
	jr z, .gate

	call GetMapEnvironment
	cp GATE
	jr nz, .not_gate

.gate
	ld a, -1
	ld [wCurLandmark], a

.not_gate
	ld hl, wEnteredMapFromContinue
	bit 1, [hl]
	res 1, [hl]
	jr nz, .dont_do_map_sign

	call .CheckMovingWithinLandmark
	jr z, .dont_do_map_sign
	ld a, [wCurLandmark]
	ld [wPrevLandmark], a

	call .CheckSpecialMap
	jr z, .dont_do_map_sign

	farcall LoadOverworldFont

; Display for 60 frames
	ld a, MAP_NAME_SIGN_DURATION
	ld [wLandmarkSignTimer], a
	call LoadMapNameSignGFX
	;call InitMapNameFrame
	;farcall HDMATransfer_OnlyTopFourRows
	ret

.dont_do_map_sign
	ld a, [wCurLandmark]
	ld [wPrevLandmark], a
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	xor a
	ldh [hLCDCPointer], a
	ret

.CheckMovingWithinLandmark:
	ld a, [wCurLandmark]
	ld c, a
	ld a, [wPrevLandmark]
	cp c
	ret z
	cp LANDMARK_SPECIAL
	ret

.CheckSpecialMap:
; These landmarks do not get pop-up signs.
	cp -1
	ret z
	cp LANDMARK_SPECIAL ; redundant check
	ret z
	cp LANDMARK_RADIO_TOWER
	ret z
	cp LANDMARK_HOSPITAL
	ret z
	cp LANDMARK_LAV_RADIO_TOWER
	ret z
	cp LANDMARK_UNDERGROUND_PATH
	ret z
	cp LANDMARK_INDIGO_PLATEAU
	ret z
	cp LANDMARK_POWER_PLANT
	ret z
	ld a, 1
	and a
	ret

.CheckNationalParkGate:
	ld a, [wMapGroup]
	cp GROUP_ROUTE_35_NATIONAL_PARK_GATE
	ret nz
	ld a, [wMapNumber]
	cp MAP_ROUTE_35_NATIONAL_PARK_GATE
	ret z
	cp MAP_ROUTE_36_NATIONAL_PARK_GATE
	ret

.CheckPoliceStationMap:
	ld a, [wMapGroup]
	cp GROUP_ECRUTEAK_POLICE_STATION
	ret nz
	ld a, [wMapNumber]
	cp MAP_ECRUTEAK_POLICE_STATION
	ret

PlaceMapNameSign::
	ld hl, wLandmarkSignTimer
	ld a, [hl]
	and a
	jr z, .disappear

	dec [hl]
	cp MAP_NAME_SIGN_DURATION
	ret z

	cp MAP_NAME_SIGN_DURATION - 1
	jr nz, .already_initialized
	
	call InitMapNameFrame
	call PlaceMapNameCenterAlign
	farcall HDMATransfer_OnlyTopFourRows
.already_initialized
	ld a, $70
	ldh [rWY], a
	ldh [hWY], a
	ret

.disappear
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	xor a
	ldh [hLCDCPointer], a
	jmp LoadStandardFont

LoadMapNameSignGFX:
	ld de, MapEntryFrameGFX
	ld hl, vTiles2 tile MAP_NAME_SIGN_START
	lb bc, BANK(MapEntryFrameGFX), 14
	jmp Get2bpp

InitMapNameFrame:
	hlcoord 0, 0
	lb bc, 2, 18
	call InitMapSignAttrmap
	jr PlaceMapNameFrame

PlaceMapNameCenterAlign:
	ld a, [wCurLandmark]
	ld e, a
	farcall GetLandmarkName
	call .GetNameLength
	ld a, SCREEN_WIDTH
	sub c
	srl a
	ld b, 0
	ld c, a
	hlcoord 0, 2
	add hl, bc
	ld de, wStringBuffer1
	call PlaceString

	ld a, [wCurFreedomState]
	and (1 << LOCKDOWN) | (1 << CURFEW)
	ret z

	ld a, [wCurWantedLevel]
	and $3
	ret z

	hlcoord SCREEN_WIDTH - 4, 1
	ld b, 3

.full_stars_loop
	ld [hl], "<FULL_STAR>"
	inc hl
	dec b
	dec a
	jr nz, .full_stars_loop

	ld a, b
	and a
	ret z

.empty_stars_loop
	ld [hl], "<EMPTY_STAR>"
	inc hl
	dec a
	jr nz, .empty_stars_loop
	ret

.GetNameLength:
	ld c, 0
	push hl
	ld hl, wStringBuffer1
.loop
	ld a, [hli]
	cp "@"
	jr z, .stop
	cp "%"
	jr z, .loop
	inc c
	jr .loop
.stop
	pop hl
	ret

InitMapSignAttrmap:
	ld de, wAttrmap - wTilemap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, PAL_BG_TEXT | PRIORITY
.loop
	push bc
	push hl
.inner_loop
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec b
	jr nz, .loop
	ret

PlaceMapNameFrame:
	hlcoord 0, 0
	; top left
	ld a, MAP_NAME_SIGN_START + 1
	ld [hli], a
	; top row
	ld a, MAP_NAME_SIGN_START + 2
	call .FillTopBottom
	; top right
	ld a, MAP_NAME_SIGN_START + 4
	ld [hli], a
	; left, first line
	ld a, MAP_NAME_SIGN_START + 5
	ld [hli], a
	; first line
	call .FillMiddle
	; right, first line
	ld a, MAP_NAME_SIGN_START + 11
	ld [hli], a
	; left, second line
	ld a, MAP_NAME_SIGN_START + 6
	ld [hli], a
	; second line
	call .FillMiddle
	; right, second line
	ld a, MAP_NAME_SIGN_START + 12
	ld [hli], a
	; bottom left
	ld a, MAP_NAME_SIGN_START + 7
	ld [hli], a
	; bottom
	ld a, MAP_NAME_SIGN_START + 8
	call .FillTopBottom
	; bottom right
	ld a, MAP_NAME_SIGN_START + 10
	ld [hl], a
	ret

.FillMiddle:
	ld c, SCREEN_WIDTH - 2
	ld a, MAP_NAME_SIGN_START + 13
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

.FillTopBottom:
	ld c, (SCREEN_WIDTH - 2) / 4 + 1
	jr .enterloop

.continueloop
	ld [hli], a
	ld [hli], a

.enterloop
	inc a
	ld [hli], a
	ld [hli], a
	dec a
	dec c
	jr nz, .continueloop
	ret

HideMapNameSign::
	call PlaceMapNameSign.disappear
	xor a
	ld [wLandmarkSignTimer], a
	ret
