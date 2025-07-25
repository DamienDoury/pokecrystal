DisplayCaughtContestMonStats:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call LoadFontsBattleExtra

	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]

	hlcoord 0, 0
	lb bc, 4, 13
	call Textbox

	hlcoord 0, 6
	lb bc, 4, 13
	call Textbox

	hlcoord 2, 0
	ld de, .Stock
	call PlaceString

	hlcoord 2, 6
	ld de, .This
	call PlaceString

if DEF(_FR_FR)
	hlcoord 4, 4
else
	hlcoord 5, 4
endc
	ld de, .Health
	call PlaceString

if DEF(_FR_FR)
	hlcoord 4, 10
else
	hlcoord 5, 10
endc
	ld de, .Health
	call PlaceString

	ld a, [wContestMon]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld de, wStringBuffer1
	hlcoord 1, 2
	call PlaceString

	ld h, b
	ld l, c
	ld a, [wContestMonLevel]
	ld [wTempMonLevel], a
	call PrintLevel

	ld de, wEnemyMonNickname
	hlcoord 1, 8
	call PlaceString

	ld h, b
	ld l, c
	ld a, [wEnemyMonLevel]
	ld [wTempMonLevel], a
	call PrintLevel

if DEF(_FR_FR)
	hlcoord 10, 4
else
	hlcoord 11, 4
endc
	ld de, wContestMonMaxHP
	lb bc, 2, 3
	call PrintNum

if DEF(_FR_FR)
	hlcoord 10, 10
else
	hlcoord 11, 10
endc
	ld de, wEnemyMonMaxHP
	call PrintNum

	ld hl, ContestAskSwitchText
	call PrintText

	pop af
	ld [wOptions], a

	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	jmp SetPalettes

.Health:
if DEF(_FR_FR)
	db "   VIE@"
else
	db "HEALTH@"
endc

.Stock:
if DEF(_FR_FR)
	db " STOCKER <PKMN> @"
else
	db " STOCK <PKMN> @"
endc

.This:
if DEF(_FR_FR)
	db " CE <PKMN> @"
else
	db " THIS <PKMN>  @"
endc

ContestAskSwitchText:
	text_far _ContestAskSwitchText
	text_end

DisplayAlreadyCaughtText:
	call GetPokemonName
	ld hl, .ContestAlreadyCaughtText
	jmp PrintText

.ContestAlreadyCaughtText:
	text_far _ContestAlreadyCaughtText
	text_end

DummyPredef2F:
DummyPredef38:
DummyPredef39:
	ret
