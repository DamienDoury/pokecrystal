; GetOptionPointer.Pointers indexes
	const_def
	const OPT_TEXT_SPEED   ; 0
	const OPT_BATTLE_SCENE ; 1
	const OPT_SOUND        ; 2
	const OPT_PRINT        ; 3
	const OPT_FAST_BOOT    ; 4
	const OPT_FIELD_MOVES  ; 5
	const OPT_FRAME        ; 6
	const OPT_CANCEL       ; 7
NUM_OPTIONS EQU const_value    ; 8

_Option:
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], TRUE
	call ClearBGPalettes
	hlcoord 0, 0
	ld b, SCREEN_HEIGHT - 2
	ld c, SCREEN_WIDTH - 2
	call Textbox
	hlcoord 2, 2
	ld de, StringOptions
	call PlaceString
	xor a
	ld [wJumptableIndex], a

; display the settings of each option when the menu is opened
	ld c, NUM_OPTIONS - 2 ; omit frame type, the last option
.print_text_loop
	push bc
	xor a
	ldh [hJoyLast], a
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	call UpdateFrame ; display the frame type

	xor a
	ld [wJumptableIndex], a
	inc a
	ldh [hBGMapMode], a
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes

.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call OptionsControl
	jr c, .dpad
	call GetOptionPointer
	jr c, .ExitOptions

.dpad
	call Options_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

StringOptions:
if DEF(_FR_FR)
	db "Vitesse texte<LF>"
	db "      :<LF>"
	db "Anim. combat<LF>"
	db "      :<LF>"
	db "Son<LF>"
	db "      :<LF>"
	db "Imprimer<LF>"
	db "      :<LF>"
	db "Allum. rapide<LF>"
	db "      :<LF>"
	db "Interactions<LF>"
	db "      :<LF>"
	db "Cadre<LF>"
	db "      :TYPE<LF>"
	db "Enregistrer@"
else
	db "Text speed<LF>"
	db "      :<LF>"
	db "Battle anim.<LF>"
	db "      :<LF>"
	db "Sound<LF>"
	db "      :<LF>"
	db "Print<LF>"
	db "      :<LF>"
	db "Fast boot<LF>"
	db "      :<LF>"
	db "World actions<LF>"
	db "      :<LF>"
	db "Frame<LF>"
	db "      :TYPE<LF>"
	db "Save options@"
endc

GetOptionPointer:
	jumptable .Pointers, wJumptableIndex

.Pointers:
; entries correspond to OPT_* constants
	dw Options_TextSpeed
	dw Options_BattleScene
	dw Options_Sound
	dw Options_Print
	dw Options_FastBoot
	dw Options_FieldMoves
	dw Options_Frame
	dw Options_Cancel

	const_def
	const OPT_TEXT_SPEED_FAST ; 0
	const OPT_TEXT_SPEED_MED  ; 1
	const OPT_TEXT_SPEED_SLOW ; 2

Options_TextSpeed:
	call GetTextSpeed
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	ld a, c ; right pressed
	cp OPT_TEXT_SPEED_SLOW
	jr c, .Increase
	ld c, OPT_TEXT_SPEED_FAST - 1

.Increase:
	inc c
	ld a, e
	jr .Save

.LeftPressed:
	ld a, c
	and a
	jr nz, .Decrease
	ld c, OPT_TEXT_SPEED_SLOW + 1

.Decrease:
	dec c
	ld a, d

.Save:
	ld b, a
	ld a, [wOptions]
	and $f8
	or b
	ld [wOptions], a

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 3
	call PlaceString
	and a
	ret

.Strings:
; entries correspond to OPT_TEXT_SPEED_* constants
	dw .Fast
	dw .Mid
	dw .Slow

if DEF(_FR_FR)
.Fast: db "IMMEDIAT@"
.Mid:  db "RAPIDE  @"
.Slow: db "LENT    @"
else
.Fast: db "INSTANT@"
.Mid:  db "FAST   @"
.Slow: db "SLOW   @"
endc

GetTextSpeed:
; converts TEXT_DELAY_* value in a to OPT_TEXT_SPEED_* value in c,
; with previous/next TEXT_DELAY_* values in d/e
	ld a, [wOptions]
	and TEXT_DELAY_MASK
	cp TEXT_DELAY_SLOW
	jr z, .slow
	cp TEXT_DELAY_FAST
	jr z, .fast
	; none of the above
	ld c, OPT_TEXT_SPEED_MED
	lb de, TEXT_DELAY_FAST, TEXT_DELAY_SLOW
	ret

.slow
	ld c, OPT_TEXT_SPEED_SLOW
	lb de, TEXT_DELAY_MED, TEXT_DELAY_FAST
	ret

.fast
	ld c, OPT_TEXT_SPEED_FAST
	lb de, TEXT_DELAY_SLOW, TEXT_DELAY_MED
	ret

Options_BattleScene:
	ld hl, wOptions
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit BATTLE_SCENE, [hl]
	jr nz, .ToggleOn
	jr .ToggleOff

.LeftPressed:
	bit BATTLE_SCENE, [hl]
	jr z, .ToggleOff
	jr .ToggleOn

.NonePressed:
	bit BATTLE_SCENE, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.ToggleOn:
	res BATTLE_SCENE, [hl]
	ld de, OnText
	jr .Display

.ToggleOff:
	set BATTLE_SCENE, [hl]
	ld de, OffText

.Display:
	hlcoord 9, 5
	call PlaceString
	and a
	ret

if DEF(_FR_FR)
OnText:  db "ON @"
OffText: db "OFF@"
else
OnText:  db "ON @"
OffText: db "OFF@"
endc

Options_FastBoot:
	ld hl, wOptions
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit FAST_BOOT, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit FAST_BOOT, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit FAST_BOOT, [hl]
	jr z, .ToggleOff
	jr .ToggleOn

.ToggleOff:
	res FAST_BOOT, [hl]
	ld de, OffText
	jr .Display

.ToggleOn:
	set FAST_BOOT, [hl]
	ld de, OnText

.Display:
	hlcoord 9, 11
	call PlaceString
	and a
	ret

Options_FieldMoves:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit FIELD_MOVES, [hl]
	jr nz, .ToggleOff
	jr .ToggleOn

.LeftPressed:
	bit FIELD_MOVES, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.NonePressed:
	bit FIELD_MOVES, [hl]
	jr z, .ToggleOff
	jr .ToggleOn

.ToggleOff:
	res FIELD_MOVES, [hl]
	ld de, .Legacy
	jr .Display

.ToggleOn:
	set FIELD_MOVES, [hl]
	ld de, .Quick

.Display:
	hlcoord 9, 13
	call PlaceString
	and a
	ret

if DEF(_FR_FR)
.Legacy: db "TRADI    @"
.Quick:  db "RACCOURCI@"
else
.Legacy: db "LEGACY   @"
.Quick:  db "SHORTCUTS@"
endc

Options_Sound:
	ld hl, wOptions
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit STEREO, [hl]
	jr nz, .SetMono
	jr .SetStereo

.LeftPressed:
	bit STEREO, [hl]
	jr z, .SetStereo
	jr .SetMono

.NonePressed:
	bit STEREO, [hl]
	jr nz, .ToggleStereo
	jr .ToggleMono

.SetMono:
	res STEREO, [hl]
	call RestartMapMusic

.ToggleMono:
	ld de, .Mono
	jr .Display

.SetStereo:
	set STEREO, [hl]
	call RestartMapMusic

.ToggleStereo:
	ld de, .Stereo

.Display:
	hlcoord 9, 7
	call PlaceString
	and a
	ret

if DEF(_FR_FR)
.Mono:   db "MONO  @"
.Stereo: db "STEREO@"
else
.Mono:   db "MONO  @"
.Stereo: db "STEREO@"
endc

	const_def
	const OPT_PRINT_LIGHTEST ; 0
	const OPT_PRINT_LIGHTER  ; 1
	const OPT_PRINT_NORMAL   ; 2
	const OPT_PRINT_DARKER   ; 3
	const OPT_PRINT_DARKEST  ; 4

Options_Print:
	call GetPrinterSetting
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	ld a, c
	cp OPT_PRINT_DARKEST
	jr c, .Increase
	ld c, OPT_PRINT_LIGHTEST - 1

.Increase:
	inc c
	ld a, e
	jr .Save

.LeftPressed:
	ld a, c
	and a
	jr nz, .Decrease
	ld c, OPT_PRINT_DARKEST + 1

.Decrease:
	dec c
	ld a, d

.Save:
	ld b, a
	ld [wGBPrinterBrightness], a

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 9
	call PlaceString
	and a
	ret

.Strings:
; entries correspond to OPT_PRINT_* constants
	dw .Lightest
	dw .Lighter
	dw .Normal
	dw .Darker
	dw .Darkest

if DEF(_FR_FR)
.Lightest: db "CLAIR+ @"
.Lighter:  db "CLAIR  @"
.Normal:   db "NORMAL @"
.Darker:   db "SOMBRE @"
.Darkest:  db "SOMBRE+@"
else
.Lightest: db "LIGHTEST@"
.Lighter:  db "LIGHTER @"
.Normal:   db "NORMAL  @"
.Darker:   db "DARKER  @"
.Darkest:  db "DARKEST @"
endc

GetPrinterSetting:
; converts GBPRINTER_* value in a to OPT_PRINT_* value in c,
; with previous/next GBPRINTER_* values in d/e
	ld a, [wGBPrinterBrightness]
	and a
	jr z, .IsLightest
	cp GBPRINTER_LIGHTER
	jr z, .IsLight
	cp GBPRINTER_DARKER
	jr z, .IsDark
	cp GBPRINTER_DARKEST
	jr z, .IsDarkest
	; none of the above
	ld c, OPT_PRINT_NORMAL
	lb de, GBPRINTER_LIGHTER, GBPRINTER_DARKER
	ret

.IsLightest:
	ld c, OPT_PRINT_LIGHTEST
	lb de, GBPRINTER_DARKEST, GBPRINTER_LIGHTER
	ret

.IsLight:
	ld c, OPT_PRINT_LIGHTER
	lb de, GBPRINTER_LIGHTEST, GBPRINTER_NORMAL
	ret

.IsDark:
	ld c, OPT_PRINT_DARKER
	lb de, GBPRINTER_NORMAL, GBPRINTER_DARKEST
	ret

.IsDarkest:
	ld c, OPT_PRINT_DARKEST
	lb de, GBPRINTER_DARKER, GBPRINTER_LIGHTEST
	ret

Options_Frame:
	ld hl, wTextboxFrame
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	and a
	ret

.RightPressed:
	ld a, [hl]
	inc a
	jr .Save

.LeftPressed:
	ld a, [hl]
	dec a

.Save:
	maskbits NUM_FRAMES
	ld [hl], a
UpdateFrame:
	ld a, [wTextboxFrame]
	hlcoord 14, 15 ; where on the screen the number is drawn
	add "1"
	ld [hl], a
	call LoadFontsExtra
	and a
	ret

Options_Cancel:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr nz, .Exit
	and a
	ret

.Exit:
	scf
	ret

OptionsControl:
	ld hl, wJumptableIndex
	ldh a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl]
	cp OPT_CANCEL ; maximum option index
	jr nz, .Increase
	ld [hl], 0 ; first option
	scf
	ret

.Increase:
	inc [hl]
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a ; OPT_TEXT_SPEED, minimum option index
	jr nz, .Decrease
	ld [hl], NUM_OPTIONS ; decrements to OPT_CANCEL, maximum option index

.Decrease:
	dec [hl]
	scf
	ret

Options_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, SCREEN_HEIGHT - 2
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wJumptableIndex]
	call AddNTimes
	ld [hl], "▶"
	ret
