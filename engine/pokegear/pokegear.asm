; Pokégear cards
	const_def
	const POKEGEARCARD_CLOCK ; 0
	const POKEGEARCARD_MAP   ; 1
	const POKEGEARCARD_PHONE ; 2
	const POKEGEARCARD_RADIO ; 3
NUM_POKEGEAR_CARDS EQU const_value

PHONE_DISPLAY_HEIGHT EQU 4

; PokegearJumptable.Jumptable indexes
	const_def
	const POKEGEARSTATE_CLOCKINIT       ; 0
	const POKEGEARSTATE_CLOCKJOYPAD     ; 1
	const POKEGEARSTATE_MAPCHECKREGION  ; 2
	const POKEGEARSTATE_JOHTOMAPINIT    ; 3
	const POKEGEARSTATE_JOHTOMAPJOYPAD  ; 4
	const POKEGEARSTATE_KANTOMAPINIT    ; 5
	const POKEGEARSTATE_KANTOMAPJOYPAD  ; 6
	const POKEGEARSTATE_PHONEINIT       ; 7
	const POKEGEARSTATE_PHONEJOYPAD     ; 8
	const POKEGEARSTATE_MAKEPHONECALL   ; 9
	const POKEGEARSTATE_FINISHPHONECALL ; a
	const POKEGEARSTATE_RADIOINIT       ; b
	const POKEGEARSTATE_RADIOJOYPAD     ; c

PokeGear:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld a, [wVramState]
	push af

	callfar InitPartyMenuPalettes

	xor a
	ld [wVramState], a
	call .InitTilemap
	call DelayFrame
.loop
	call UpdateTime
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call PokegearJumptable
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .loop

.done
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	pop af
	ld [wVramState], a
	pop af
	ldh [hInMenu], a
	pop af
	ld [wOptions], a
	call ClearBGPalettes
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	jmp ExitPokegearRadio_HandleMusic

.InitTilemap:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ld a, $7
	ldh [hWX], a
	call Pokegear_LoadGFX
	farcall ClearSpriteAnims
	call InitPokegearModeIndicatorArrow
	ld a, 8
	call SkipMusic
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call TownMap_InitCursorAndPlayerIconPositions
	xor a
	ld [wJumptableIndex], a ; POKEGEARSTATE_CLOCKINIT
	ld [wPokegearCard], a ; POKEGEARCARD_CLOCK
	ld [wPokegearMapRegion], a ; JOHTO_REGION
	ld [wUnusedPokegearByte], a
	ld [wPokegearPhoneScrollPosition], a
	ld [wPokegearPhoneCursorPosition], a
	ld [wPokegearPhoneSelectedPerson], a
	ld [wPokegearRadioChannelBank], a
	ld [wPokegearRadioChannelAddr], a
	ld [wPokegearRadioChannelAddr + 1], a
	call Pokegear_InitJumptableIndices
	call InitPokegearTilemap
	ld b, SCGB_POKEGEAR_PALS
	call GetSGBLayout
	call SetPalettes
	ldh a, [hCGB]
	and a
	ret z
	ld a, %11100100
	jmp DmgToCgbObjPal0

Pokegear_LoadGFX:
	call ClearVBank1
	ld hl, TownMapGFX
	ld de, vTiles2
	ld a, BANK(TownMapGFX)
	call FarDecompress
	ld hl, PokegearGFX
	ld de, vTiles2 tile $30
	ld a, BANK(PokegearGFX)
	call FarDecompress
	ld hl, PokegearSpritesGFX
	ld de, vTiles0
	ld a, BANK(PokegearSpritesGFX)
	call Decompress
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	cp LANDMARK_FAST_SHIP
	jr z, .ssaqua
	farcall GetPlayerIcon
	push de
	ld h, d
	ld l, e
	ld a, b
	; standing sprite
	push af
	ld de, vTiles0 tile $10
	ld bc, 4 tiles
	call FarCopyBytes
	pop af
	pop hl
	; walking sprite
	ld de, 12 tiles
	add hl, de
	ld de, vTiles0 tile $14
	ld bc, 4 tiles
	jmp FarCopyBytes

.ssaqua
	ld hl, FastShipGFX
	ld de, vTiles0 tile $10
	ld bc, 8 tiles
	jmp CopyBytes

FastShipGFX:
INCBIN "gfx/pokegear/fast_ship.2bpp"

InitPokegearModeIndicatorArrow:
	depixel 4, 2, 4, 0
	ld a, SPRITE_ANIM_INDEX_POKEGEAR_ARROW
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $0
	ret

AnimatePokegearModeIndicatorArrow:
	ld hl, wPokegearCard
	ld e, [hl]
	ld d, 0
	ld hl, .XCoords
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.XCoords:
	db $00 ; POKEGEARCARD_CLOCK
	db $10 ; POKEGEARCARD_MAP
	db $20 ; POKEGEARCARD_PHONE
	db $30 ; POKEGEARCARD_RADIO

TownMap_GetCurrentLandmark:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	cp LANDMARK_SPECIAL
	ret nz
	ld a, [wBackupMapGroup]
	ld b, a
	ld a, [wBackupMapNumber]
	ld c, a
	jmp GetWorldMapLocation

TownMap_InitCursorAndPlayerIconPositions:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	cp LANDMARK_FAST_SHIP
	jr z, .FastShip
	cp LANDMARK_SPECIAL
	jr nz, .LoadLandmark
	ld a, [wBackupMapGroup]
	ld b, a
	ld a, [wBackupMapNumber]
	ld c, a
	call GetWorldMapLocation
.LoadLandmark:
	ld [wPokegearMapPlayerIconLandmark], a
	ld [wPokegearMapCursorLandmark], a
	ret

.FastShip:
	ld [wPokegearMapPlayerIconLandmark], a
	ld a, LANDMARK_NEW_BARK_TOWN
	ld [wPokegearMapCursorLandmark], a
	ret

Pokegear_InitJumptableIndices:
	ld a, POKEGEARSTATE_CLOCKINIT
	ld [wJumptableIndex], a
	xor a ; POKEGEARCARD_CLOCK
	ld [wPokegearCard], a
	ret

InitPokegearTilemap::
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $4f
	call ByteFill
	ld a, [wPokegearCard]
	maskbits NUM_POKEGEAR_CARDS
	add a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return_from_jumptable
	push de
	jp hl

.return_from_jumptable
	call Pokegear_FinishTilemap
	farcall TownMapPals
	ld a, [wPokegearMapRegion]
	and a
	jr nz, .kanto_0
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	call .UpdateBGMap
	ld a, SCREEN_HEIGHT_PX
	jr .finish

.kanto_0
	xor a ; LOW(vBGMap1)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call .UpdateBGMap
	xor a
.finish
	ldh [hWY], a
	; swap region maps
	ld a, [wPokegearMapRegion]
	maskbits NUM_REGIONS
	xor 1
	ld [wPokegearMapRegion], a
	ret

.UpdateBGMap:
	ldh a, [hCGB]
	and a
	jr z, .dmg
	ld a, $2
	ldh [hBGMapMode], a
	ld c, 3
	call DelayFrames
.dmg
	jmp WaitBGMap

.Jumptable:
; entries correspond to POKEGEARCARD_* constants
	dw .Clock
	dw .Map
	dw .Phone
	dw .Radio

.Clock:
	ld de, ClockTilemapRLE
	call Pokegear_LoadTilemapRLE

	hlcoord 18, 1
	ld de, .switch
	call PlaceString

	ld a, [wYearMonth]
	and $f
	cp 13
	jr c, .monthCapped

	ld a, 0
.monthCapped
	add a 
	ld hl, .months
	ld e, a
	ld d, 0
	add hl, de

	ld e, [hl]
	inc hl
	ld d, [hl]

	hlcoord 4, 7
	call PlaceString

	hlcoord 11, 7
	call .display_year

	ld de, EVENT_POKEGEAR_CONTACT_TRACING_MODULE
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .skip_contact_tracing

	hlcoord 0, 15
	ld bc, SCREEN_WIDTH * 3
	ld a, $7f
	call ByteFill

	hlcoord 0, 15
	ld a, $30
	ld [hl], a

	hlcoord 19, 15
	ld a, $31
	ld [hl], a

	hlcoord 1, 16
	ld a, $0c ; "Rec" icon. Signifies that Contact Tracing is on.
	ld [hl], a

	hlcoord 2, 16
	ld de, .contactTracing
	call PlaceString

.skip_contact_tracing
	hlcoord 0, 12
	lb bc, 4, 18
	jmp Pokegear_UpdateClock

.display_year
	ld de, .year
	call PlaceString

	ld h, b
	ld l, c
	ld a, [wYearMonth]
	swap a
	and $3
	add $f6
	ld [hl], a
	ret

.switch
	db "▶@"
.year
	db "202@"
.contactTracing
if DEF(_FR_FR)
	db "TRAçAGE CONTACTS@"
else
	db " CONTACT TRACING@"
endc

.months
	dw .January
	dw .February
	dw .March
	dw .April
	dw .May
	dw .June
	dw .July
	dw .August
	dw .September
	dw .October
	dw .November
	dw .December

if DEF(_FR_FR)
.January
	db " Janv.@"
.February
	db " Févr.@"
.March
	db " Mars@"
.April
	db " Avril@"
.May
	db " Mai@"
.June
	db " Juin@"
.July
	db " Juil.@"
.August
	db " Août@"
.September
	db " Sept.@"
.October
	db " Oct.@"
.November
	db " Nov.@"
.December
	db " Déc.@"
else
.January
	db " Jan.@"
.February
	db " Feb.@"
.March
	db " March@"
.April
	db " April@"
.May
	db " May@"
.June
	db " June@"
.July
	db " July@"
.August
	db " Aug.@"
.September
	db " Sept.@"
.October
	db " Oct.@"
.November
	db " Nov.@"
.December
	db " Dec.@"
endc

.Map:
	ld a, [wPokegearMapPlayerIconLandmark]
	cp LANDMARK_FAST_SHIP
	jr z, .johto
	cp KANTO_LANDMARK
	jr nc, .kanto
.johto
	ld e, 0
	jr .ok

.kanto
	ld e, 1
.ok
	farcall PokegearMap
	ld a, $07
	ld bc, SCREEN_WIDTH - 2
	hlcoord 1, 2
	call ByteFill
	hlcoord 0, 2
	ld [hl], $06
	hlcoord 19, 2
	ld [hl], $17
	ld a, [wPokegearMapCursorLandmark]
	jmp PokegearMap_UpdateLandmarkName

.Radio:
	ld de, RadioTilemapRLE
	call Pokegear_LoadTilemapRLE
	hlcoord 0, 12
	lb bc, 4, 18
	jmp Textbox

.Phone:
	ld de, PhoneTilemapRLE
	call Pokegear_LoadTilemapRLE
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	call .PlacePhoneBars
	jmp PokegearPhone_UpdateDisplayList

.PlacePhoneBars:
	hlcoord 17, 1
	ld a, $3c
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 17, 2
	inc a
	ld [hli], a
	call GetMapPhoneService
	and a
	ret nz
	hlcoord 18, 2
	ld [hl], $3f
	ret

Pokegear_FinishTilemap:
	hlcoord 0, 0
	ld bc, $8
	ld a, $4f
	call ByteFill
	hlcoord 0, 1
	ld bc, $8
	ld a, $4f
	call ByteFill
	ld de, wPokegearFlags
	ld a, [de]
	bit POKEGEAR_MAP_CARD_F, a
	call nz, .PlaceMapIcon
	ld a, [de]
	bit POKEGEAR_PHONE_CARD_F, a
	call nz, .PlacePhoneIcon
	ld a, [de]
	bit POKEGEAR_RADIO_CARD_F, a
	call nz, .PlaceRadioIcon
	hlcoord 0, 0
	ld a, $46
	jr .PlacePokegearCardIcon

.PlaceMapIcon:
	hlcoord 2, 0
	ld a, $40
	jr .PlacePokegearCardIcon

.PlacePhoneIcon:
	hlcoord 4, 0
	ld a, $44
	jr .PlacePokegearCardIcon

.PlaceRadioIcon:
	hlcoord 6, 0
	ld a, $42
.PlacePokegearCardIcon:
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, $14
	add hl, bc
	add $f
	ld [hli], a
	inc a
	ld [hld], a
	ret

PokegearJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
; entries correspond to POKEGEARSTATE_* constants
	dw PokegearClock_Init
	dw PokegearClock_Joypad
	dw PokegearMap_CheckRegion
	dw PokegearMap_Init
	dw PokegearMap_JohtoMap
	dw PokegearMap_Init
	dw PokegearMap_KantoMap
	dw PokegearPhone_Init
	dw PokegearPhone_Joypad
	dw PokegearPhone_MakePhoneCall
	dw PokegearPhone_FinishPhoneCall
	dw PokegearRadio_Init
	dw PokegearRadio_Joypad

PokegearClock_Init:
	call InitPokegearTilemap
	ld hl, wJumptableIndex
	inc [hl]
	jmp ExitPokegearRadio_HandleMusic

PokegearClock_Joypad:
	call .UpdateClock
	ld hl, hJoyLast
	ld a, [hl]
	and A_BUTTON | B_BUTTON | START | SELECT
	jr nz, .quit
	ld a, [hl]
	and D_RIGHT
	ret z
	ld a, [wPokegearFlags]
	bit POKEGEAR_MAP_CARD_F, a
	jr z, .no_map_card
	ld c, POKEGEARSTATE_MAPCHECKREGION
	ld b, POKEGEARCARD_MAP
	jr .done

.no_map_card
	ld a, [wPokegearFlags]
	bit POKEGEAR_PHONE_CARD_F, a
	jr z, .no_phone_card
	ld c, POKEGEARSTATE_PHONEINIT
	ld b, POKEGEARCARD_PHONE
	jr .done

.no_phone_card
	ld a, [wPokegearFlags]
	bit POKEGEAR_RADIO_CARD_F, a
	ret z
	ld c, POKEGEARSTATE_RADIOINIT
	ld b, POKEGEARCARD_RADIO
.done
	jmp Pokegear_SwitchPage

.quit
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.UpdateClock:
	xor a
	ldh [hBGMapMode], a
	call Pokegear_UpdateClock
	ld a, $1
	ldh [hBGMapMode], a
	ret

Pokegear_UpdateClock:
	hlcoord 3, 9
	lb bc, 3, 14
	call ClearBox

	ldh a, [hMinutes]
	ld c, a
	ldh a, [hHours]
	add 11
	ld b, 12
	call Modulo
	cp 9
	ldh a, [hHours]
	ld b, a
	decoord 6, 11
	jr c, .offsetTime

	inc de
.offsetTime
	farcall PrintHoursMins

	call GetWeekDayStringAddress
	call CountChars
	ld c, a
	srl c
	ld a, 10
	sbc c
	ld c, a
	ld b, 0
	hlcoord 0, 9
	add hl, bc
	call PlaceString

	hlcoord 5, 11
	ld a, [wTimeOfDay]
	add $1d
	ld [hl], a
	ret

PokegearMap_CheckRegion:
	ld a, [wPokegearMapPlayerIconLandmark]
	cp LANDMARK_FAST_SHIP
	jr z, .johto
	cp KANTO_LANDMARK
	jr nc, .kanto
.johto
	ld a, POKEGEARSTATE_JOHTOMAPINIT
	jr .done
	ret

.kanto
	ld a, POKEGEARSTATE_KANTOMAPINIT
.done
	ld [wJumptableIndex], a
	jmp ExitPokegearRadio_HandleMusic

PokegearMap_Init:
	call InitPokegearTilemap
	ld a, [wPokegearMapPlayerIconLandmark]
	call PokegearMap_InitPlayerIcon
	ld a, [wPokegearMapCursorLandmark]
	call PokegearMap_InitCursor
	ld a, c
	ld [wPokegearMapCursorObjectPointer], a
	ld a, b
	ld [wPokegearMapCursorObjectPointer + 1], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

PokegearMap_KantoMap:
	call TownMap_GetKantoLandmarkLimits
	jr PokegearMap_ContinueMap

PokegearMap_JohtoMap:
	lb de, LANDMARK_SILVER_CAVE, LANDMARK_NEW_BARK_TOWN
PokegearMap_ContinueMap:
	ld hl, hJoyLast
	ld a, [hl]
	and B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	jr .DPad

.right
	ld a, [wPokegearFlags]
	bit POKEGEAR_PHONE_CARD_F, a
	jr z, .no_phone
	ld c, POKEGEARSTATE_PHONEINIT
	ld b, POKEGEARCARD_PHONE
	jr .done

.no_phone
	ld a, [wPokegearFlags]
	bit POKEGEAR_RADIO_CARD_F, a
	ret z
	ld c, POKEGEARSTATE_RADIOINIT
	ld b, POKEGEARCARD_RADIO
	jr .done

.left
	ld c, POKEGEARSTATE_CLOCKINIT
	ld b, POKEGEARCARD_CLOCK
.done
	jmp Pokegear_SwitchPage

.cancel
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.DPad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ret

.up
	ld hl, wPokegearMapCursorLandmark
	ld a, [hl]
	cp d
	jr c, .wrap_around_up
	ld a, e
	dec a
	ld [hl], a
.wrap_around_up
	call Map_PressUp_SkipHiddenLandmarks
	inc [hl]
	jr .done_dpad

.down
	ld hl, wPokegearMapCursorLandmark
	ld a, [hl]
	cp e
	jr nz, .wrap_around_down
	ld a, d
	inc a
	ld [hl], a
.wrap_around_down
	call Map_PressDown_SkipHiddenLandmarks
	dec [hl]
.done_dpad
	ld a, [wPokegearMapCursorLandmark]
	call PokegearMap_UpdateLandmarkName
	ld a, [wPokegearMapCursorObjectPointer]
	ld c, a
	ld a, [wPokegearMapCursorObjectPointer + 1]
	ld b, a
	ld a, [wPokegearMapCursorLandmark]
	jmp PokegearMap_UpdateCursorPosition

Map_PressUp_SkipHiddenLandmarks:
	cp LANDMARK_HOSPITAL - 1
	jr nz, .not_hospital

	push de
	ld de, EVENT_FIRST_LOCKDOWN_STARTED
	call CheckMapEventFlag
	pop de
	jr nz, .not_hospital

	inc [hl]
	ret

.not_hospital
	cp LANDMARK_SAFARI_ZONE - 1
	jr nz, .not_safari

	push de
	ld de, EVENT_ENTERED_SAFARI_ZONE
	call CheckMapEventFlag
	pop de
	jr nz, .not_safari

	inc [hl]
	ret

.not_safari
	cp LANDMARK_CERULEAN_CAVE - 1
	ret nz

	push de
	ld de, EVENT_ENTERED_CERULEAN_CAVE
	call CheckMapEventFlag
	pop de
	ret nz

	inc [hl]
	ret

Map_PressDown_SkipHiddenLandmarks:
	cp LANDMARK_HOSPITAL + 1
	jr nz, .not_hospital

	push de
	ld de, EVENT_FIRST_LOCKDOWN_STARTED
	call CheckMapEventFlag
	pop de
	jr nz, .not_hospital

	dec [hl]
	ret

.not_hospital
	cp LANDMARK_SAFARI_ZONE + 1
	jr nz, .not_safari

	push de
	ld de, EVENT_ENTERED_SAFARI_ZONE
	call CheckMapEventFlag
	pop de
	jr nz, .not_safari

	dec [hl]
	ret

.not_safari
	cp LANDMARK_CERULEAN_CAVE + 1
	ret nz

	push de
	ld de, EVENT_ENTERED_CERULEAN_CAVE
	call CheckMapEventFlag
	pop de
	ret nz

	dec [hl]
	ret

CheckMapEventFlag:
	push bc
	push hl
	ld b, a
	push bc
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	pop bc
	ld a, b
	pop hl
	pop bc
	ret

PokegearMap_InitPlayerIcon:
	push af
	depixel 0, 0
	ld b, SPRITE_ANIM_INDEX_RED_WALK
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_gender
	ld b, SPRITE_ANIM_INDEX_BLUE_WALK
.got_gender
	ld a, b
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $10
	pop af
	ld e, a
	push bc
	farcall GetLandmarkCoords
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

PokegearMap_InitCursor:
	push af
	depixel 0, 0
	ld a, SPRITE_ANIM_INDEX_POKEGEAR_ARROW
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $04
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL
	pop af
	push bc
	call PokegearMap_UpdateCursorPosition
	pop bc
	ret

PokegearMap_UpdateLandmarkName:
	push af
	hlcoord 8, 0
	lb bc, 2, 12
	call ClearBox
	pop af
	ld e, a
	push de
	farcall GetLandmarkName
	pop de
	farcall TownMap_ConvertLineBreakCharacters
	hlcoord 8, 0
	ld [hl], $34
	ret

PokegearMap_UpdateCursorPosition:
	push bc
	ld e, a
	farcall GetLandmarkCoords
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

TownMap_GetKantoLandmarkLimits:
	ld a, [wStatusFlags]
	bit STATUSFLAGS_HALL_OF_FAME_F, a
	jr z, .not_hof
	lb de, LANDMARK_ROUTE_28, LANDMARK_PALLET_TOWN
	ret

.not_hof
	lb de, LANDMARK_ROUTE_28, LANDMARK_VICTORY_ROAD
	ret

PokegearRadio_Init:
	call InitPokegearTilemap
	depixel 4, 10, 4, 4
	ld a, SPRITE_ANIM_INDEX_RADIO_TUNING_KNOB
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $08
	call UpdateRadioStation
	ld hl, wJumptableIndex
	inc [hl]
	ret

PokegearRadio_Joypad:
	ld hl, hJoyLast
	ld a, [hl]
	and B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [wPokegearRadioChannelAddr]
	ld l, a
	ld a, [wPokegearRadioChannelAddr + 1]
	ld h, a
	ld a, [wPokegearRadioChannelBank]
	and a
	ret z
	rst FarCall
	ret

.left
	ld a, [wPokegearFlags]
	bit POKEGEAR_PHONE_CARD_F, a
	jr z, .no_phone
	ld c, POKEGEARSTATE_PHONEINIT
	ld b, POKEGEARCARD_PHONE
	jr .switch_page

.no_phone
	ld a, [wPokegearFlags]
	bit POKEGEAR_MAP_CARD_F, a
	jr z, .no_map
	ld c, POKEGEARSTATE_MAPCHECKREGION
	ld b, POKEGEARCARD_MAP
	jr .switch_page

.no_map
	ld c, POKEGEARSTATE_CLOCKINIT
	ld b, POKEGEARCARD_CLOCK
.switch_page
	jmp Pokegear_SwitchPage

.cancel
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

PokegearPhone_Init:
	ld hl, wJumptableIndex
	inc [hl]
	xor a
	ld [wPokegearPhoneScrollPosition], a
	ld [wPokegearPhoneCursorPosition], a
	ld [wPokegearPhoneSelectedPerson], a
	call InitPokegearTilemap
	call ExitPokegearRadio_HandleMusic
	ld hl, PokegearAskWhoCallText
	jmp PrintText

PokegearPhone_Joypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	jmp PokegearPhone_GetDPad

.left
	ld a, [wPokegearFlags]
	bit POKEGEAR_MAP_CARD_F, a
	jr z, .no_map
	ld c, POKEGEARSTATE_MAPCHECKREGION
	ld b, POKEGEARCARD_MAP
	jr .switch_page

.no_map
	ld c, POKEGEARSTATE_CLOCKINIT
	ld b, POKEGEARCARD_CLOCK
	jr .switch_page

.right
	ld a, [wPokegearFlags]
	bit POKEGEAR_RADIO_CARD_F, a
	ret z
	ld c, POKEGEARSTATE_RADIOINIT
	ld b, POKEGEARCARD_RADIO
.switch_page
	jmp Pokegear_SwitchPage

.b
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.a
	ld hl, wPhoneList
	ld a, [wPokegearPhoneScrollPosition]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wPokegearPhoneCursorPosition]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	and a
	ret z
	ld [wPokegearPhoneSelectedPerson], a
	hlcoord 1, 4
	ld a, [wPokegearPhoneCursorPosition]
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld [hl], "▷"
	call PokegearPhoneContactSubmenu
	jr c, .quit_submenu
	ld hl, wJumptableIndex
	inc [hl]
	ret

.quit_submenu
	ld a, POKEGEARSTATE_PHONEJOYPAD
	ld [wJumptableIndex], a
	ret

PokegearPhone_MakePhoneCall:
	call GetMapPhoneService
	and a
	jr nz, .no_service
	ld hl, wOptions
	res NO_TEXT_SCROLL, [hl]
	xor a
	ldh [hInMenu], a
	ld de, SFX_CALL
	call PlaySFX
	ld hl, .GearEllipseText
	call PrintText
	call WaitSFX
	ld de, SFX_CALL
	call PlaySFX
	ld hl, .GearEllipseText
	call PrintText
	call WaitSFX
	ld a, [wPokegearPhoneSelectedPerson]
	ld b, a
	call MakePhoneCallFromPokegear
	ld c, 10
	call DelayFrames
	ld hl, wOptions
	set NO_TEXT_SCROLL, [hl]
	ld a, $1
	ldh [hInMenu], a
	call PokegearPhone_UpdateCursor
	ld hl, wJumptableIndex
	inc [hl]
	ret

.no_service
	farcall Phone_NoSignal
	ld hl, .GearOutOfServiceText
	call PrintText
	ld a, POKEGEARSTATE_PHONEJOYPAD
	ld [wJumptableIndex], a
	ld hl, PokegearAskWhoCallText
	jmp PrintText

.GearEllipseText:
	text_far _GearEllipseText
	text_end

.GearOutOfServiceText:
	text_far _GearOutOfServiceText
	text_end

PokegearPhone_FinishPhoneCall:
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	ret z
	farcall HangUp
	ld a, POKEGEARSTATE_PHONEJOYPAD
	ld [wJumptableIndex], a
	ld hl, PokegearAskWhoCallText
	jmp PrintText

PokegearPhone_GetDPad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ret

.up
	ld hl, wPokegearPhoneCursorPosition
	ld a, [hl]
	and a
	jr z, .scroll_page_up
	dec [hl]
	jr .done_joypad_same_page

.scroll_page_up
	ld hl, wPokegearPhoneScrollPosition
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .done_joypad_update_page

.down
	ld hl, wPokegearPhoneCursorPosition
	ld a, [hl]
	cp PHONE_DISPLAY_HEIGHT - 1
	jr nc, .scroll_page_down
	inc [hl]
	jr .done_joypad_same_page

.scroll_page_down
	ld hl, wPokegearPhoneScrollPosition
	ld a, [hl]
	cp CONTACT_LIST_SIZE - PHONE_DISPLAY_HEIGHT
	ret nc
	inc [hl]
	jr .done_joypad_update_page

.done_joypad_same_page
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateCursor
	jmp WaitBGMap

.done_joypad_update_page
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateDisplayList
	jmp WaitBGMap

PokegearPhone_UpdateCursor:
	ld a, " "
x = 4
rept PHONE_DISPLAY_HEIGHT
	hlcoord 1, x
	ld [hl], a
x = x + 2
endr
	hlcoord 1, 4
	ld a, [wPokegearPhoneCursorPosition]
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld [hl], "▶"
	ret

PokegearPhone_UpdateDisplayList:
	hlcoord 1, 3
	ld b, PHONE_DISPLAY_HEIGHT * 2 + 1
	ld a, " "
.row
	ld c, SCREEN_WIDTH - 2
.col
	ld [hli], a
	dec c
	jr nz, .col
	inc hl
	inc hl
	dec b
	jr nz, .row
	ld a, [wPokegearPhoneScrollPosition]
	ld e, a
	ld d, 0
	ld hl, wPhoneList
	add hl, de
	xor a
	ld [wPokegearPhoneDisplayPosition], a
.loop
	ld a, [hli]
	push hl
	push af
	hlcoord 2, 4
	ld a, [wPokegearPhoneDisplayPosition]
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld d, h
	ld e, l
	pop af
	ld b, a
	call GetCallerClassAndName
	pop hl
	ld a, [wPokegearPhoneDisplayPosition]
	inc a
	ld [wPokegearPhoneDisplayPosition], a
	cp PHONE_DISPLAY_HEIGHT
	jr c, .loop
	jr PokegearPhone_UpdateCursor

PokegearPhone_DeletePhoneNumber:
	ld hl, wPhoneList
	ld a, [wPokegearPhoneScrollPosition]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wPokegearPhoneCursorPosition]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], 0
	ld hl, wPhoneList
	ld c, CONTACT_LIST_SIZE
.loop
	ld a, [hli]
	and a
	jr nz, .skip
	ld a, [hld]
	ld [hli], a
	ld [hl], 0
.skip
	dec c
	jr nz, .loop
	ret

PokegearPhoneContactSubmenu:
	ld hl, wPhoneList
	ld a, [wPokegearPhoneScrollPosition]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wPokegearPhoneCursorPosition]
	ld e, a
	ld d, 0
	add hl, de
	ld c, [hl]
	farcall CheckCanDeletePhoneNumber
	ld a, c
	and a
	jr z, .cant_delete
	ld hl, .CallDeleteCancelJumptable
	ld de, .CallDeleteCancelStrings
	jr .got_menu_data

.cant_delete
	ld hl, .CallCancelJumptable
	ld de, .CallCancelStrings
.got_menu_data
	xor a
	ldh [hBGMapMode], a
	push hl
	push de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	inc de
	push hl
	bccoord -1, -2, 0
	add hl, bc
	ld a, [de]
	inc de
	add a
	ld b, a
	ld c, 8
	push de
	call Textbox
	pop de
	pop hl
	inc hl
	call PlaceString
	pop de
	xor a
	ld [wPokegearPhoneSubmenuCursor], a
	call .UpdateCursor
	call WaitBGMap
.loop
	push de
	call JoyTextDelay
	pop de
	ld hl, hJoyPressed
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	ld a, [hl]
	and A_BUTTON | B_BUTTON
	jr nz, .a_b
	call DelayFrame
	jr .loop

.d_up
	ld hl, wPokegearPhoneSubmenuCursor
	ld a, [hl]
	and a
	jr z, .loop
	dec [hl]
	call .UpdateCursor
	jr .loop

.d_down
	ld hl, 2
	add hl, de
	ld a, [wPokegearPhoneSubmenuCursor]
	inc a
	cp [hl]
	jr nc, .loop
	ld [wPokegearPhoneSubmenuCursor], a
	call .UpdateCursor
	jr .loop

.a_b
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateDisplayList
	ld a, $1
	ldh [hBGMapMode], a
	pop hl
	ldh a, [hJoyPressed]
	and B_BUTTON
	jr nz, .Cancel
	ld a, [wPokegearPhoneSubmenuCursor]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Cancel:
	ld hl, PokegearAskWhoCallText
	call PrintText
	scf
	ret

.Delete:
	ld hl, PokegearAskDeleteText
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .CancelDelete
	call PokegearPhone_DeletePhoneNumber
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateDisplayList
	ld hl, PokegearAskWhoCallText
	call PrintText
	call WaitBGMap
.CancelDelete:
	scf
	ret

.Call:
	and a
	ret

.UpdateCursor:
	push de
	ld a, [de]
	inc de
	ld l, a
	ld a, [de]
	inc de
	ld h, a
	ld a, [de]
	ld c, a
	push hl
	ld a, " "
	ld de, SCREEN_WIDTH * 2
.clear_column
	ld [hl], a
	add hl, de
	dec c
	jr nz, .clear_column
	pop hl
	ld a, [wPokegearPhoneSubmenuCursor]
	ld bc, SCREEN_WIDTH  * 2
	call AddNTimes
	ld [hl], "▶"
	pop de
	ret

.CallDeleteCancelStrings:
	dwcoord 10, 6
	db 3
if DEF(_FR_FR)
	db   "APPELER"
	next "EFFACER"
	next "RETOUR"
else
	db   "CALL"
	next "DELETE"
	next "CANCEL"
endc
	db   "@"

.CallDeleteCancelJumptable:
	dw .Call
	dw .Delete
	dw .Cancel

.CallCancelStrings:
	dwcoord 10, 8
	db 2
if DEF(_FR_FR)
	db   "APPELER"
	next "RETOUR"
else	
	db   "CALL"
	next "CANCEL"
endc
	db   "@"

.CallCancelJumptable:
	dw .Call
	dw .Cancel

GetAMPMHours: ; unreferenced
	ldh a, [hHours]
	cp 12
	jr c, .am
	sub 12
	ld [wTempByteValue], a
	scf
	ret

.am
	ld [wTempByteValue], a
	and a
	ret

ExitPokegearRadio_HandleMusic:
	; If we are at the rave party, we don't unset the music, so that quitting the Radio menu doesn't restart the map music.
	push de
	push hl
	ld b, CHECK_FLAG
	ld de, EVENT_CINNABAR_RAVE_PARTY
	call EventFlagAction
	pop hl
	pop de
	ld a, c
	and a
	ret nz

	ld a, [wPokegearRadioMusicPlaying]
	cp RESTART_MAP_MUSIC
	jr z, .restart_map_music
	cp ENTER_MAP_MUSIC
	call z, PlayMapMusicBike
	xor a
	ld [wPokegearRadioMusicPlaying], a
	ret

.restart_map_music
	call RestartMapMusic
	xor a
	ld [wPokegearRadioMusicPlaying], a
	ret


Pokegear_SwitchPage:
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld a, c
	ld [wJumptableIndex], a
	ld a, b
	ld [wPokegearCard], a
	; fallthrough.

DeleteSpriteAnimStruct2ToEnd:
	ld hl, wSpriteAnim2
	ld bc, wSpriteAnimationStructsEnd - wSpriteAnim2
	xor a
	call ByteFill
	ld a, 2
	ld [wSpriteAnimCount], a
	ret

Pokegear_LoadTilemapRLE:
	; Format: repeat count, tile ID
	; Terminated with -1
	hlcoord 0, 0
.loop
	ld a, [de]
	cp -1
	ret z
	ld b, a
	inc de
	ld a, [de]
	ld c, a
	inc de
	ld a, b
.load
	ld [hli], a
	dec c
	jr nz, .load
	jr .loop

PokegearAskWhoCallText:
	text_far _PokegearAskWhoCallText
	text_end

PokegearPressButtonText:
	text_far _PokegearPressButtonText
	text_end

PokegearAskDeleteText:
	text_far _PokegearAskDeleteText
	text_end

PokegearSpritesGFX:
INCBIN "gfx/pokegear/pokegear_sprites.2bpp.lz"

RadioTilemapRLE:
INCBIN "gfx/pokegear/radio.tilemap.rle"
PhoneTilemapRLE:
INCBIN "gfx/pokegear/phone.tilemap.rle"
ClockTilemapRLE:
INCBIN "gfx/pokegear/clock.tilemap.rle"

; called from engine/gfx/sprite_anims.asm

AnimateTuningKnob:
	push bc
	call .TuningKnob
	pop bc
	ld a, [wRadioTuningKnob]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.TuningKnob:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ld a, [hl]
	and D_UP
	jr nz, .up
	ret

.down
	ld hl, wRadioTuningKnob
	ld a, [hl]
	and a
	ret z
	dec [hl]
	dec [hl]
	jr .update

.up
	ld hl, wRadioTuningKnob
	ld a, [hl]
	cp 80
	ret nc
	inc [hl]
	inc [hl]
.update
UpdateRadioStation:
	ld hl, wRadioTuningKnob
	ld d, [hl]
	ld hl, RadioChannels

	ld a, [wEnvironment]
	cp CAVE
	jr nz, .loop

	push de
	call GetMapPhoneService
	pop de
	and a
	jr nz, .nosignal

.loop
	ld a, [hli]
	cp -1
	jp z, NoRadioStation
	cp d
	jr z, .foundstation
	inc hl
	inc hl
	jr .loop

.nosignal
	call NoRadioStation.skip_music_shutdown
	ld de, NoSignalName
	jr .displaychannelname

.foundstation
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .returnafterstation
	push de
	jp hl

.returnafterstation
	ld a, [wPokegearRadioChannelBank]
	and a
	ret z

.displaychannelname
	xor a
	ldh [hBGMapMode], a
	hlcoord 2, 9
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

LoadPokegearRadioChannelPointer: ; unreferenced
	ld [wPokegearRadioChannelBank], a
	ld a, [hli]
	ld [wPokegearRadioChannelAddr], a
	ld a, [hli]
	ld [wPokegearRadioChannelAddr + 1], a
	ret

RadioChannels:
; entries correspond to constants/radio_constants.asm
; frequency value given here = 4 × ingame_frequency − 2
	dbw 16, .PKMNTalkAndPokedexShow ; 04.5
	dbw 28, .PokemonMusic           ; 07.5
	dbw 32, .LuckyChannel           ; 08.5
	dbw 40, .BuenasPassword         ; 10.5
	dbw 46, .NewsRadioJohto         ; 12.0
	dbw 50, .NewsRadioKanto         ; 13.0
	dbw 52, .RuinsOfAlphRadio       ; 13.5
	dbw 64, .PlacesAndPeople        ; 16.5
	dbw 72, .LetsAllSing            ; 18.5
	dbw 78, .PokeFluteRadio         ; 20.0
	dbw 80, .EvolutionRadio         ; 20.5
	db -1

.PKMNTalkAndPokedexShow:
; Pokédex Show in the morning
; Oak's Pokémon Talk in the afternoon and evening
	call .InJohto
	jp nc, .NoSignal

	ld a, [wTimeOfDay]
	and a
	jp z, LoadStation_PokedexShow
	jmp LoadStation_OaksPokemonTalk

.PokemonMusic:
	call .InJohto
	jr nc, .NoSignal
	jmp LoadStation_PokemonMusic

.LuckyChannel:
	call .InJohto
	jr nc, .NoSignal
	jmp LoadStation_LuckyChannel

.BuenasPassword:
	call .InJohto
	jr nc, .NoSignal
	jmp LoadStation_BuenasPassword

.NewsRadioJohto:
	call .InJohto
	jr nc, .NoSignal
	jmp LoadStation_NewsRadioJohto

.NewsRadioKanto:
	call .InJohto
	jr c, .NoSignal
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, .NoSignal
	jmp LoadStation_NewsRadioKanto

.RuinsOfAlphRadio:
	ld a, [wPokegearMapPlayerIconLandmark]
	cp LANDMARK_RUINS_OF_ALPH
	jr nz, .NoSignal
	jmp LoadStation_UnownRadio

.PlacesAndPeople:
	call .InJohto
	jr c, .NoSignal
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, .NoSignal
	jmp LoadStation_PlacesAndPeople

.LetsAllSing:
	call .InJohto
	jr c, .NoSignal
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, .NoSignal
	jmp LoadStation_LetsAllSing

.PokeFluteRadio:
	call .InJohto
	jr c, .NoSignal
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, .NoSignal
	jmp LoadStation_PokeFluteRadio

.EvolutionRadio:
; This station airs in the Lake of Rage area when Team Rocket is still in Mahogany.
	ld a, [wStatusFlags]
	bit STATUSFLAGS_ROCKET_SIGNAL_F, a
	jr z, .NoSignal
	ld a, [wPokegearMapPlayerIconLandmark]
	cp LANDMARK_MAHOGANY_TOWN
	jr z, .ok
	cp LANDMARK_ROUTE_43
	jr z, .ok
	cp LANDMARK_LAKE_OF_RAGE
	jr nz, .NoSignal
.ok
	jmp LoadStation_EvolutionRadio

.NoSignal:
	jp NoRadioStation

.InJohto:
; if in Johto or on the S.S. Aqua, set carry
; otherwise clear carry
	ld a, [wPokegearMapPlayerIconLandmark]
	cp LANDMARK_FAST_SHIP
	jr z, .johto
	cp KANTO_LANDMARK
	jr c, .johto
; kanto
	and a
	ret

.johto
	scf
	ret

LoadStation_OaksPokemonTalk:
	xor a ; OAKS_POKEMON_TALK
	call LoadRadioStart
	ld de, OaksPKMNTalkName
	ret

LoadStation_PokedexShow:
	ld a, POKEDEX_SHOW
	call LoadRadioStart
	ld de, PokedexShowName
	ret

LoadStation_PokemonMusic:
	ld a, POKEMON_MUSIC
	call LoadRadioStart
	ld de, PokemonMusicName
	ret

LoadStation_LuckyChannel:
	ld a, LUCKY_CHANNEL
	call LoadRadioStart
	ld de, LuckyChannelName
	ret

LoadStation_BuenasPassword:
	ld a, BUENAS_PASSWORD
	call LoadRadioStart
	ld de, NotBuenasPasswordName
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F, a
	ret z
	ld de, BuenasPasswordName
	ret

BuenasPasswordName:   
if DEF(_FR_FR)
	db "CODE DE BUENA@"	
else
	db "BUENA'S PASSWORD@"
endc

NotBuenasPasswordName: db "@"

LoadStation_NewsRadioAuto:
	call IsInJohto
	jr nz, LoadStation_NewsRadioKanto
	; fallthrough.

LoadStation_NewsRadioJohto:
	ld de, NewsRadioNameJohto
	jr LoadStation_NewsRadio

LoadStation_NewsRadioKanto:
	ld de, NewsRadioNameKanto
LoadStation_NewsRadio:
	ld a, NEWS_RADIO
	jr LoadRadioStart

LoadStation_UnownRadio:
	ld de, UnownStationName
	ld a, UNOWN_RADIO
	jr LoadRadioStart

LoadStation_PlacesAndPeople:
	ld de, PlacesAndPeopleName
	ld a, PLACES_AND_PEOPLE
	jr LoadRadioStart

LoadStation_LetsAllSing:
	ld de, LetsAllSingName
	ld a, LETS_ALL_SING
	jr LoadRadioStart

LoadStation_RocketRadio:
	ld de, LetsAllSingName
	ld a, ROCKET_RADIO
	jr LoadRadioStart

LoadStation_PokeFluteRadio:
	ld de, PokeFluteStationName
	ld a, POKE_FLUTE_RADIO
	jr LoadRadioStart

LoadStation_EvolutionRadio:
	ld de, UnownStationName
	ld a, EVOLUTION_RADIO
	; fallthrough.

; Input: radio ID in A.
LoadRadioStart:
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld a, BANK(PlayRadioShow)
	ld hl, PlayRadioShow
	jr Radio_BackUpFarCallParams

RadioMusicRestartDE:
	push de
	ld a, e
	ld [wPokegearRadioMusicPlaying], a
	ld de, MUSIC_NONE
	call PlayMusic
	pop de
	ld a, e
	ld [wMapMusic], a
	jmp PlayMusic

RadioMusicRestartPokemonChannel:
	push de
	ld a, RESTART_MAP_MUSIC
	ld [wPokegearRadioMusicPlaying], a
	ld de, MUSIC_NONE
	call PlayMusic
	pop de
	ld de, MUSIC_POKEMON_CHANNEL
	jmp PlayMusic

Radio_BackUpFarCallParams:
	ld [wPokegearRadioChannelBank], a
	ld a, l
	ld [wPokegearRadioChannelAddr], a
	ld a, h
	ld [wPokegearRadioChannelAddr + 1], a
	ret

NoRadioStation:
; no radio channel
	call NoRadioMusic
.skip_music_shutdown
	call NoRadioName
	xor a
	ld [wPokegearRadioChannelBank], a
	ld [wPokegearRadioChannelAddr], a
	ld [wPokegearRadioChannelAddr + 1], a
	ld a, $1
	ldh [hBGMapMode], a
	ret

NoRadioMusic:
	ld de, MUSIC_NONE
	call PlayMusic
	ld a, ENTER_MAP_MUSIC
	ld [wPokegearRadioMusicPlaying], a
	ret

NoRadioName:
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 8
	lb bc, 3, 18
	call ClearBox
	hlcoord 0, 12
	lb bc, 4, 18
	jmp Textbox

if DEF(_FR_FR)
OaksPKMNTalkName:     db "CHRONIQUE<PKMN> CHEN@"
PokedexShowName:      db "Show #DEX@"
PokemonMusicName:     db "Musique #MON@"
LuckyChannelName:     db "Antenne Chance@"
UnownStationName:     db "?????@"
NoSignalName:         db "--Aucun signal--@"
NewsRadioNameJohto:   db "Johto Quotidien@"
	
NewsRadioNameKanto:   db "Info Kanto@"
PlacesAndPeopleName:  db "Socio FM@"
LetsAllSingName:      db "Chantons un peu@"
PokeFluteStationName: db "FLUTE #MON@"
else
OaksPKMNTalkName:     db "OAK's <PK><MN> Talk@"
PokedexShowName:      db "#DEX Show@"
PokemonMusicName:     db "#MON Music@"
LuckyChannelName:     db "Lucky Channel@"
UnownStationName:     db "?????@"
NoSignalName:         db "-- No signal --@"
NewsRadioNameJohto:   db "Johto Daily@"
	
NewsRadioNameKanto:   db "Kanto News@"
PlacesAndPeopleName:  db "Places & People@"
LetsAllSingName:      db "Let's All Sing!@"
PokeFluteStationName: db "# FLUTE@"
endc

_TownMap:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]

	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a

	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	call Pokegear_LoadGFX
	farcall ClearSpriteAnims
	ld a, 8
	call SkipMusic
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call TownMap_GetCurrentLandmark
	ld [wTownMapPlayerIconLandmark], a
	ld [wTownMapCursorLandmark], a
	xor a
	ldh [hBGMapMode], a
	call .InitTilemap
	call WaitBGMap2
	ld a, [wTownMapPlayerIconLandmark]
	call PokegearMap_InitPlayerIcon
	ld a, [wTownMapCursorLandmark]
	call PokegearMap_InitCursor
	ld a, c
	ld [wTownMapCursorObjectPointer], a
	ld a, b
	ld [wTownMapCursorObjectPointer + 1], a
	ld b, SCGB_POKEGEAR_PALS
	call GetSGBLayout
	call SetPalettes
	ldh a, [hCGB]
	and a
	jr z, .dmg
	ld a, %11100100
	call DmgToCgbObjPal0
	call DelayFrame

.dmg
	ld a, [wTownMapPlayerIconLandmark]
	cp KANTO_LANDMARK
	jr nc, .kanto
	ld d, KANTO_LANDMARK - 1
	ld e, 1
	call .loop
	jr .resume

.kanto
	call TownMap_GetKantoLandmarkLimits
	call .loop

.resume
	pop af
	ld [wVramState], a
	pop af
	ldh [hInMenu], a
	pop af
	ld [wOptions], a
	jmp ClearBGPalettes

.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	ret nz

	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .pressed_up

	ld a, [hl]
	and D_DOWN
	jr nz, .pressed_down
.loop2
	push de
	farcall PlaySpriteAnimations
	pop de
	call DelayFrame
	jr .loop

.pressed_up
	ld hl, wTownMapCursorLandmark
	ld a, [hl]
	cp d
	jr c, .okay
	ld a, e
	dec a
	ld [hl], a

.okay
	call Map_PressUp_SkipHiddenLandmarks
	inc [hl]
	jr .next

.pressed_down
	ld hl, wTownMapCursorLandmark
	ld a, [hl]
	cp e
	jr nz, .okay2
	ld a, d
	inc a
	ld [hl], a

.okay2
	call Map_PressDown_SkipHiddenLandmarks
	dec [hl]

.next
	push de
	ld a, [wTownMapCursorLandmark]
	call PokegearMap_UpdateLandmarkName
	ld a, [wTownMapCursorObjectPointer]
	ld c, a
	ld a, [wTownMapCursorObjectPointer + 1]
	ld b, a
	ld a, [wTownMapCursorLandmark]
	call PokegearMap_UpdateCursorPosition
	pop de
	jr .loop2

.InitTilemap:
	ld a, [wTownMapPlayerIconLandmark]
	cp KANTO_LANDMARK
	jr nc, .kanto2
	ld e, JOHTO_REGION
	jr .okay_tilemap

.kanto2
	ld e, KANTO_REGION
.okay_tilemap
	farcall PokegearMap
	ld a, $07
	ld bc, 6
	hlcoord 1, 0
	call ByteFill
	hlcoord 0, 0
	ld [hl], $06
	hlcoord 7, 0
	ld [hl], $17
	hlcoord 7, 1
	ld [hl], $16
	hlcoord 7, 2
	ld [hl], $26
	ld a, $07
	ld bc, NAME_LENGTH
	hlcoord 8, 2
	call ByteFill
	hlcoord 19, 2
	ld [hl], $17
	ld a, [wTownMapCursorLandmark]
	call PokegearMap_UpdateLandmarkName
	farcall TownMapPals
	ret

PlayRadio:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlayStation
	ld c, 100
	call DelayFrames
.loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	jr nz, .stop
	ld a, [wPokegearRadioChannelAddr]
	ld l, a
	ld a, [wPokegearRadioChannelAddr + 1]
	ld h, a
	ld a, [wPokegearRadioChannelBank]
	and a
	jr z, .zero
	rst FarCall
.zero
	call DelayFrame
	jr .loop

.stop
	pop af
	ld [wOptions], a
	jmp ExitPokegearRadio_HandleMusic

.PlayStation:
	ld a, ENTER_MAP_MUSIC
	ld [wPokegearRadioMusicPlaying], a
	ld hl, PlayRadioStationPointers
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .jump_return
	push de
	jp hl

.jump_return
	push de
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	hlcoord 1, 14
	ld [hl], "“"
	pop de
	hlcoord 2, 14
	call PlaceString
	ld h, b
	ld l, c
	ld [hl], "”"
	jmp WaitBGMap

PlayRadioStationPointers:
; entries correspond to MAPRADIO_* constants
	table_width 2, PlayRadioStationPointers
	dw LoadStation_PokemonChannel
	dw LoadStation_OaksPokemonTalk
	dw LoadStation_PokedexShow
	dw LoadStation_PokemonMusic
	dw LoadStation_LuckyChannel
	dw LoadStation_UnownRadio
	dw LoadStation_PlacesAndPeople
	dw LoadStation_LetsAllSing
	dw LoadStation_NewsRadioAuto
	dw LoadStation_RocketRadio
	assert_table_length NUM_MAP_RADIO_STATIONS

LoadStation_PokemonChannel:
	call IsInJohto
	and a
	jr nz, .kanto
	call UpdateTime
	ld a, [wTimeOfDay]
	and a
	jp z, LoadStation_PokedexShow
	jmp LoadStation_OaksPokemonTalk

.kanto:
	jp LoadStation_PlacesAndPeople

PokegearMap:
	ld a, e
	and a
	jr nz, .kanto
	call LoadTownMapGFX
	jmp FillJohtoMap

.kanto
	call LoadTownMapGFX
	jmp FillKantoMap

_FlyMap:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1
	xor a
	ldh [hBGMapMode], a
	farcall ClearSpriteAnims
	farcall InitPartyMenuOBPals ; OBJ palettes always use their "day" palette.
	call LoadStandardFont
	call LoadTownMapGFX
	ld de, FlyMapLabelBorderGFX
	ld hl, vTiles2 tile $30
	lb bc, BANK(FlyMapLabelBorderGFX), 6
	call Request1bpp
	call FlyMap
	ld b, SCGB_POKEGEAR_PALS
	call GetSGBLayout
	call SetPalettes
.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .pressedB
	ld a, [hl]
	and A_BUTTON
	jr nz, .pressedA
	call .HandleDPad
	call GetMapCursorCoordinates
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .loop

.pressedB
	ld a, -1
	jr .exit

.pressedA
	ld a, [wTownMapPlayerIconLandmark]
	ld l, a
	ld h, 0
	add hl, hl
	ld de, Flypoints + 1
	add hl, de
	ld a, [hl]
.exit
	ld [wTownMapPlayerIconLandmark], a
	pop af
	ldh [hInMenu], a
	call ClearBGPalettes
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ld a, [wTownMapPlayerIconLandmark]
	ld e, a
	ret

.HandleDPad:
	ld a, [wStartFlypoint]
	ld e, a
	ld a, [wEndFlypoint]
	ld d, a
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .ScrollNext
	ld a, [hl]
	and D_DOWN
	jr nz, .ScrollPrev
	ret

.ScrollNext:
	ld hl, wTownMapPlayerIconLandmark
	ld a, [hl]
	cp d
	jr nz, .NotAtEndYet
	ld a, e
	dec a
	ld [hl], a
.NotAtEndYet:
	inc [hl]
	call CheckIfVisitedFlypoint
	jr z, .ScrollNext
	jr .Finally

.ScrollPrev:
	ld hl, wTownMapPlayerIconLandmark
	ld a, [hl]
	cp e
	jr nz, .NotAtStartYet
	ld a, d
	inc a
	ld [hl], a
.NotAtStartYet:
	dec [hl]
	call CheckIfVisitedFlypoint
	jr z, .ScrollPrev
.Finally:
	call TownMapBubble
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ret

TownMapBubble:
; Draw the bubble containing the location text in the town map HUD

; Top-left corner
	hlcoord 1, 0
	ld a, $30
	ld [hli], a
; Top row
	ld bc, 16
	ld a, " "
	call ByteFill
; Top-right corner
	ld a, $31
	ld [hl], a
	hlcoord 1, 1

; Middle row
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill

; Bottom-left corner
	hlcoord 1, 2
	ld a, $32
	ld [hli], a
; Bottom row
	ld bc, 16
	ld a, " "
	call ByteFill
; Bottom-right corner
	ld a, $33
	ld [hl], a

; Print "Where?"
	hlcoord 2, 0
	ld de, .Where
	call PlaceString
; Print the name of the default flypoint
	call .Name
; Up/down arrows
	hlcoord 18, 1
	ld [hl], $34
	ret

.Where:
if DEF(_FR_FR)
	db "Où?@"
else
	db "Where?@"
endc

.Name:
; We need the map location of the default flypoint
	ld a, [wTownMapPlayerIconLandmark]
	ld l, a
	ld h, 0
	add hl, hl ; two bytes per flypoint
	ld de, Flypoints
	add hl, de
	ld e, [hl]
	farcall GetLandmarkName
	hlcoord 2, 1
	ld de, wStringBuffer1
	jmp PlaceString

GetMapCursorCoordinates:
	ld a, [wTownMapPlayerIconLandmark]
	ld l, a
	ld h, 0
	add hl, hl
	ld de, Flypoints
	add hl, de
	ld e, [hl]
	farcall GetLandmarkCoords
	ld a, [wTownMapCursorCoordinates]
	ld c, a
	ld a, [wTownMapCursorCoordinates + 1]
	ld b, a
	ld hl, 4
	add hl, bc
	ld [hl], e
	ld hl, 5
	add hl, bc
	ld [hl], d
	ret

CheckIfVisitedFlypoint:
; Check if the flypoint loaded in [hl] has been visited yet.
	push bc
	push de
	push hl
	ld l, [hl]
	ld h, 0
	add hl, hl
	ld de, Flypoints + 1
	add hl, de
	ld c, [hl]
	call HasVisitedSpawn
	pop hl
	pop de
	pop bc
	and a
	ret

HasVisitedSpawn:
; Check if spawn point c has been visited.
	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld d, 0
	predef SmallFarFlagAction
	ld a, c
	ret

INCLUDE "data/maps/flypoints.asm"

FlyMap:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
; If we're not in a valid location, i.e. Pokecenter floor 2F,
; the backup map information is used.
	cp LANDMARK_SPECIAL
	jr nz, .CheckRegion
	ld a, [wBackupMapGroup]
	ld b, a
	ld a, [wBackupMapNumber]
	ld c, a
	call GetWorldMapLocation
.CheckRegion:
; The first 46 locations are part of Johto. The rest are in Kanto.
	cp KANTO_LANDMARK
	jr nc, .KantoFlyMap
; Johto fly map
; Note that .NoKanto should be modified in tandem with this branch
	push af
	ld a, JOHTO_FLYPOINT ; first Johto flypoint
	ld [wTownMapPlayerIconLandmark], a ; first one is default (New Bark Town)
	ld [wStartFlypoint], a
	ld a, KANTO_FLYPOINT - 1 ; last Johto flypoint
	ld [wEndFlypoint], a
; Fill out the map
	call FillJohtoMap
	call .MapHud
	pop af
	jmp TownMapPlayerIcon

.KantoFlyMap:
; The event that there are no flypoints enabled in a map is not
; accounted for. As a result, if you attempt to select a flypoint
; when there are none enabled, the game will crash. Additionally,
; the flypoint selection has a default starting point that
; can be flown to even if none are enabled.
; To prevent both of these things from happening when the player
; enters Kanto, fly access is restricted until Indigo Plateau is
; visited and its flypoint enabled.
	push af
	ld c, SPAWN_INDIGO
	call HasVisitedSpawn
	and a
	ld c, FLY_INDIGO
	jr nz, .KantoAllowed

; Second region check.
	ld c, SPAWN_VERMILION
	call HasVisitedSpawn
	and a
	jr z, .NoKanto

	ld c, FLY_VERMILION

.KantoAllowed
; Kanto's map is only loaded if we've visited Indigo Plateau
	ld a, KANTO_FLYPOINT ; first Kanto flypoint
	ld [wStartFlypoint], a
	ld a, NUM_FLYPOINTS - 1 ; last Kanto flypoint
	ld [wEndFlypoint], a
	ld a, c ; Retrieving the default Flypoint in Kanto (Indigo disabled to prevent the player from escaping).
	ld [wTownMapPlayerIconLandmark], a ; Default flypoint.
; Fill out the map
	call FillKantoMap
	call .MapHud
	pop af
	jmp TownMapPlayerIcon

.NoKanto:
; If Indigo Plateau hasn't been visited, we use Johto's map instead
	ld a, JOHTO_FLYPOINT ; first Johto flypoint
	ld [wTownMapPlayerIconLandmark], a ; first one is default (New Bark Town)
	ld [wStartFlypoint], a
	ld a, KANTO_FLYPOINT - 1 ; last Johto flypoint
	ld [wEndFlypoint], a
	call FillJohtoMap
	pop af
.MapHud:
	call TownMapBubble
	call TownMapPals
	hlbgcoord 0, 0 ; BG Map 0
	call TownMapBGUpdate
	call TownMapMon
	ld a, c
	ld [wTownMapCursorCoordinates], a
	ld a, b
	ld [wTownMapCursorCoordinates + 1], a
	ret

Pokedex_GetArea:
; e: Current landmark
	ld a, [wTownMapPlayerIconLandmark]
	push af
	ld a, [wTownMapCursorLandmark]
	push af
	ld a, e
	ld [wTownMapPlayerIconLandmark], a
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [hInMenu], a
	ld de, PokedexNestIconGFX
	ld hl, vTiles0 tile $7f
	lb bc, BANK(PokedexNestIconGFX), 1
	call Request2bpp
	call .GetPlayerOrFastShipIcon
	ld hl, vTiles0 tile $78
	ld c, 4
	call Request2bpp
	call LoadTownMapGFX
	call FillKantoMap
	call .PlaceString_MonsNest
	call TownMapPals
	hlbgcoord 0, 0, vBGMap1
	call TownMapBGUpdate
	call FillJohtoMap
	call .PlaceString_MonsNest
	call TownMapPals
	hlbgcoord 0, 0
	call TownMapBGUpdate
	ld b, SCGB_POKEGEAR_PALS
	call GetSGBLayout
	call SetPalettes
	xor a
	ldh [hBGMapMode], a
	farcall RegionCheck ; Johto = 0 in e, otherwise 1 in e.
	ld a, e
	and a
	push af
	call nz, .right
	pop af
	call z, .GetAndPlaceNest
.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON
	jr nz, .a_b
	ldh a, [hJoypadDown]
	and SELECT
	jr nz, .select
	call .LeftRightInput
	call .BlinkNestIcons
	jr .next

.select
	call .HideNestsShowPlayer
.next
	call DelayFrame
	jr .loop

.a_b
	call ClearSprites
	pop af
	ld [wTownMapCursorLandmark], a
	pop af
	ld [wTownMapPlayerIconLandmark], a
	ret

.LeftRightInput:
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ret

.left
	ldh a, [hWY]
	cp SCREEN_HEIGHT_PX
	ret z
	call ClearSprites
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	xor a ; JOHTO_REGION
	jr .GetAndPlaceNest

.right
	ld a, [wStatusFlags]
	bit STATUSFLAGS_HALL_OF_FAME_F, a
	ret z
	ldh a, [hWY]
	and a
	ret z
	call ClearSprites
	xor a
	ldh [hWY], a
	ld a, KANTO_REGION
	jr .GetAndPlaceNest

.BlinkNestIcons:
	ldh a, [hVBlankCounter]
	ld e, a
	and $f
	ret nz
	ld a, e
	and $10
	jr nz, .copy_sprites
	jmp ClearSprites

.copy_sprites
	hlcoord 0, 0
	ld de, wVirtualOAM
	ld bc, wVirtualOAMEnd - wVirtualOAM
	jmp CopyBytes

.PlaceString_MonsNest:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	ld a, " "
	call ByteFill
	hlcoord 0, 1
	ld a, $06
	ld [hli], a
	ld bc, SCREEN_WIDTH - 2
	ld a, $07
	call ByteFill
	ld [hl], $17
if DEF(_FR_FR)
	hlcoord 2, 0
else
	call GetPokemonName
	hlcoord 2, 0
	call PlaceString
	ld h, b
	ld l, c
endc
	ld de, .String_SNest
	call PlaceString
if DEF(_FR_FR)
	push bc
	call GetPokemonName
	pop hl
	call PlaceString
endc
	ret

.String_SNest:
if DEF(_FR_FR)
	db "NID DE @"
else
	db "'S NEST@"
endc

.GetAndPlaceNest:
	ld [wTownMapCursorLandmark], a
	ld e, a
	farcall FindNest ; load nest landmarks into wTilemap[0,0]
	decoord 0, 0
	ld hl, wVirtualOAMSprite00
.nestloop
	ld a, [de]
	and a
	jr z, .done_nest

	cp LANDMARK_CERULEAN_CAVE
	jr nz, .not_cerulean_cave

	push de
	ld de, EVENT_ENTERED_CERULEAN_CAVE
	call CheckMapEventFlag
	pop de
	jr z, .nestnext

.not_cerulean_cave
	ld a, [de]
	cp LANDMARK_SAFARI_ZONE
	jr nz, .nestcoords

	push de
	ld de, EVENT_ENTERED_SAFARI_ZONE
	call CheckMapEventFlag
	pop de
	jr z, .nestnext

.nestcoords
	push de
	ld e, a
	push hl
	farcall GetLandmarkCoords
	pop hl
	; load into OAM
	ld a, d
	sub 4
	ld [hli], a ; y
	ld a, e
	sub 4
	ld [hli], a ; x
	ld a, $7f ; nest icon
	ld [hli], a ; tile id
	xor a
	ld [hli], a ; attributes
	; next
	pop de
.nestnext
	inc de
	jr .nestloop

.done_nest
	ld hl, wVirtualOAM
	decoord 0, 0
	ld bc, wVirtualOAMEnd - wVirtualOAM
	jmp CopyBytes

.HideNestsShowPlayer:
	call .CheckPlayerLocation
	ret c
	ld a, [wTownMapPlayerIconLandmark]
	ld e, a
	farcall GetLandmarkCoords
	ld c, e
	ld b, d
	ld de, .PlayerOAM
	ld hl, wVirtualOAMSprite00
.ShowPlayerLoop:
	ld a, [de]
	cp $80
	jr z, .clear_oam
	add b
	ld [hli], a ; y
	inc de
	ld a, [de]
	add c
	ld [hli], a ; x
	inc de
	ld a, [de]
	add $78 ; where the player's sprite is loaded
	ld [hli], a ; tile id
	inc de
	push bc
	ld c, PAL_OW_RED
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .male
	inc c ; PAL_OW_BLUE
.male
	ld a, c
	ld [hli], a ; attributes
	pop bc
	jr .ShowPlayerLoop

.clear_oam
	ld hl, wVirtualOAMSprite04
	ld bc, wVirtualOAMEnd - wVirtualOAMSprite04
	xor a
	jmp ByteFill

.PlayerOAM:
	; y pxl, x pxl, tile offset
	db -1 * 8, -1 * 8, 0 ; top left
	db -1 * 8,  0 * 8, 1 ; top right
	db  0 * 8, -1 * 8, 2 ; bottom left
	db  0 * 8,  0 * 8, 3 ; bottom right
	db $80 ; terminator

.CheckPlayerLocation:
; Don't show the player's sprite if you're
; not in the same region as what's currently
; on the screen.
	ld a, [wTownMapPlayerIconLandmark]
	cp LANDMARK_FAST_SHIP
	jr z, .johto
	cp KANTO_LANDMARK
	jr c, .johto
; kanto
	ld a, [wTownMapCursorLandmark]
	and a
	jr z, .clear
	jr .ok

.johto
	ld a, [wTownMapCursorLandmark]
	and a
	jr nz, .clear
.ok
	and a
	ret

.clear
	ld hl, wVirtualOAM
	ld bc, wVirtualOAMEnd - wVirtualOAM
	xor a
	call ByteFill
	scf
	ret

.GetPlayerOrFastShipIcon:
	ld a, [wTownMapPlayerIconLandmark]
	cp LANDMARK_FAST_SHIP
	jr z, .FastShip
	farcall GetPlayerIcon
	ret

.FastShip:
	ld de, FastShipGFX
	ld b, BANK(FastShipGFX)
	ret

TownMapBGUpdate:
; Update BG Map tiles and attributes

; BG Map address
	ld a, l
	ldh [hBGMapAddress], a
	ld a, h
	ldh [hBGMapAddress + 1], a
; Only update palettes on CGB
	ldh a, [hCGB]
	and a
	jr z, .tiles
; BG Map mode 2 (palettes)
	ld a, 2
	ldh [hBGMapMode], a
; The BG Map is updated in thirds, so we wait

; 3 frames to update the whole screen's palettes.
	ld c, 3
	call DelayFrames
.tiles
; Update BG Map tiles
	call WaitBGMap
; Turn off BG Map update
	xor a
	ldh [hBGMapMode], a
	ret

FillJohtoMap:
	ld de, JohtoMap
	jr FillTownMap

FillKantoMap:
	ld de, KantoMap
FillTownMap:
	hlcoord 0, 0
.loop
	ld a, [de]
	cp -1
	ret z

	call DynamicMapTile
	
	ld [hli], a
	inc de
	jr .loop

DynamicMapTile:
	ld a, e
	cp LOW(KantoMap + $d * SCREEN_WIDTH + $b)
	jr nz, .not_safari_zone

	ld a, d
	cp HIGH(KantoMap + $d * SCREEN_WIDTH + $b)
	jr nz, .not_safari_zone

	push de
	ld de, EVENT_ENTERED_SAFARI_ZONE
	call CheckMapEventFlag
	pop de
	jr z, .not_safari_zone

	ld a, $f
	ret

.not_safari_zone
	ld a, e
	cp LOW(KantoMap + $5 * SCREEN_WIDTH + $b)
	ld a, [de]
	ret nz

	ld a, d
	cp HIGH(KantoMap + $5 * SCREEN_WIDTH + $b)
	ld a, [de]
	ret nz

	push de
	ld de, EVENT_ENTERED_CERULEAN_CAVE
	call CheckMapEventFlag
	pop de
	ld a, [de]
	ret z

	ld a, $f
	ret

TownMapPals:
; Assign palettes based on tile ids
	hlcoord 0, 0
	decoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop
; Current tile
	ld a, [hli]
	push hl
; The palette map covers tiles $00 to $5f; $60 and above use palette 0
	cp $60
	jr nc, .pal0

; The palette data is condensed to nybbles, least-significant first.
	ld hl, .PalMap
	srl a
	jr c, .odd
; Even-numbered tile ids take the bottom nybble...
	add l
	ld l, a
	ld a, h
	adc 0
	ld h, a
	ld a, [hl]
	and PALETTE_MASK
	jr .update

.odd
; ...and odd ids take the top.
	add l
	ld l, a
	ld a, h
	adc 0
	ld h, a
	ld a, [hl]
	swap a
	and PALETTE_MASK
	jr .update

.pal0
	xor a
.update
	pop hl
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

.PalMap:
INCLUDE "gfx/pokegear/town_map_palette_map.asm"

TownMapMon:
; Draw the FlyMon icon at town map location

; Get FlyMon species
	ld a, [wCurPartyMon]
	ld hl, wPartySpecies
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wTempIconSpecies], a
; Get FlyMon icon
	ld e, $08 ; starting tile in VRAM
	farcall GetSpeciesIcon
; Animation/palette
	depixel 0, 0
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $08
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL
	ret

TownMapPlayerIcon:
; Draw the player icon at town map location in a
	push af
	farcall GetPlayerIcon
; Standing icon
	ld hl, vTiles0 tile $10
	ld c, 4 ; # tiles
	call Request2bpp
; Walking icon
	ld hl, 12 tiles
	add hl, de
	ld d, h
	ld e, l
	ld hl, vTiles0 tile $14
	ld c, 4 ; # tiles
	ld a, BANK(ChrisSpriteGFX) ; does nothing
	call Request2bpp
; Animation/palette
	depixel 0, 0
	ld b, SPRITE_ANIM_INDEX_RED_WALK ; Male
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_gender
	ld b, SPRITE_ANIM_INDEX_BLUE_WALK ; Female
.got_gender
	ld a, b
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $10
	pop af
	ld e, a
	push bc
	farcall GetLandmarkCoords
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

LoadTownMapGFX:
	ld hl, TownMapGFX
	ld de, vTiles2
	lb bc, BANK(TownMapGFX), 48
	jmp DecompressRequest2bpp

JohtoMap:
INCBIN "gfx/pokegear/johto.bin"

KantoMap:
INCBIN "gfx/pokegear/kanto.bin"

PokedexNestIconGFX:
INCBIN "gfx/pokegear/dexmap_nest_icon.2bpp"
FlyMapLabelBorderGFX:
INCBIN "gfx/pokegear/flymap_label_border.1bpp"

;EntireFlyMap: ; unreferenced
;; Similar to _FlyMap, but scrolls through the entire
;; Flypoints data of both regions. A debug function?
;	xor a
;	ld [wTownMapPlayerIconLandmark], a
;	call ClearBGPalettes
;	call ClearTilemap
;	call ClearSprites
;	ld hl, hInMenu
;	ld a, [hl]
;	push af
;	ld [hl], $1
;	xor a
;	ldh [hBGMapMode], a
;	farcall ClearSpriteAnims
;	call LoadTownMapGFX
;	ld de, FlyMapLabelBorderGFX
;	ld hl, vTiles2 tile $30
;	lb bc, BANK(FlyMapLabelBorderGFX), 6
;	call Request1bpp
;	call FillKantoMap
;	call TownMapBubble
;	call TownMapPals
;	hlbgcoord 0, 0, vBGMap1
;	call TownMapBGUpdate
;	call FillJohtoMap
;	call TownMapBubble
;	call TownMapPals
;	hlbgcoord 0, 0
;	call TownMapBGUpdate
;	call TownMapMon
;	ld a, c
;	ld [wTownMapCursorCoordinates], a
;	ld a, b
;	ld [wTownMapCursorCoordinates + 1], a
;	ld b, SCGB_POKEGEAR_PALS
;	call GetSGBLayout
;	call SetPalettes
;.loop
;	call JoyTextDelay
;	ld hl, hJoyPressed
;	ld a, [hl]
;	and B_BUTTON
;	jr nz, .pressedB
;	ld a, [hl]
;	and A_BUTTON
;	jr nz, .pressedA
;	call .HandleDPad
;	call GetMapCursorCoordinates
;	farcall PlaySpriteAnimations
;	call DelayFrame
;	jr .loop
;
;.pressedB
;	ld a, -1
;	jr .exit
;
;.pressedA
;	ld a, [wTownMapPlayerIconLandmark]
;	ld l, a
;	ld h, 0
;	add hl, hl
;	ld de, Flypoints + 1
;	add hl, de
;	ld a, [hl]
;.exit
;	ld [wTownMapPlayerIconLandmark], a
;	pop af
;	ldh [hInMenu], a
;	call ClearBGPalettes
;	ld a, SCREEN_HEIGHT_PX
;	ldh [hWY], a
;	xor a ; LOW(vBGMap0)
;	ldh [hBGMapAddress], a
;	ld a, HIGH(vBGMap0)
;	ldh [hBGMapAddress + 1], a
;	ld a, [wTownMapPlayerIconLandmark]
;	ld e, a
;	ret
;
;.HandleDPad:
;	ld hl, hJoyLast
;	ld a, [hl]
;	and D_DOWN | D_RIGHT
;	jr nz, .ScrollNext
;	ld a, [hl]
;	and D_UP | D_LEFT
;	jr nz, .ScrollPrev
;	ret
;
;.ScrollNext:
;	ld hl, wTownMapPlayerIconLandmark
;	ld a, [hl]
;	cp NUM_FLYPOINTS - 1
;	jr c, .NotAtEndYet
;	ld [hl], -1
;.NotAtEndYet:
;	inc [hl]
;	jr .FillMap
;
;.ScrollPrev:
;	ld hl, wTownMapPlayerIconLandmark
;	ld a, [hl]
;	and a
;	jr nz, .NotAtStartYet
;	ld [hl], NUM_FLYPOINTS
;.NotAtStartYet:
;	dec [hl]
;.FillMap:
;	ld a, [wTownMapPlayerIconLandmark]
;	cp KANTO_FLYPOINT
;	jr c, .InJohto
;	call FillKantoMap
;	xor a
;	ld b, HIGH(vBGMap1)
;	jr .Finally
;
;.InJohto:
;	call FillJohtoMap
;	ld a, SCREEN_HEIGHT_PX
;	ld b, HIGH(vBGMap0)
;.Finally:
;	ldh [hWY], a
;	ld a, b
;	ldh [hBGMapAddress + 1], a
;	call TownMapBubble
;	call WaitBGMap
;	xor a
;	ldh [hBGMapMode], a
;	ret
