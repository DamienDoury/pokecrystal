LinkCommunications:
	call ClearBGPalettes
	ld c, 80
	call DelayFrames
	call ClearScreen
	call ClearSprites
	call UpdateSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld c, 80
	call DelayFrames
	call ClearScreen
	call UpdateSprites
	call LoadStandardFont
	call LoadFontsBattleExtra
	farcall LinkComms_LoadPleaseWaitTextboxBorderGFX
	call WaitBGMap2
if DEF(_FR_FR)
	hlcoord 4, 8
	ld b, 2
	ld c, 10
else
	hlcoord 3, 8
	ld b, 2
	ld c, 12
endc
	ld d, h
	ld e, l
	farcall LinkTextbox2
if DEF(_FR_FR)
	hlcoord 5, 10
else
	hlcoord 4, 10
endc
	ld de, String_PleaseWait
	call PlaceString
	call SetTradeRoomBGPals
	call WaitBGMap2
	ld hl, wLinkByteTimeout
	assert LOW(SERIAL_LINK_BYTE_TIMEOUT) == 0
	xor a ; LOW(SERIAL_LINK_BYTE_TIMEOUT)
	ld [hli], a
	ld [hl], HIGH(SERIAL_LINK_BYTE_TIMEOUT)
	; fallthrough
	
Gen2ToGen2LinkComms:
	call ClearLinkData
	call Link_PrepPartyData_Gen2
	call FixDataForLinkTransfer
	call CheckLinkTimeout_Gen2
	ld a, [wScriptVar]
	and a
	jp z, LinkTimeout
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1

	ld c, 3
	call DelayFrames
	xor a
	ldh [hSerialSend], a
	ld a, (0 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a

	call DelayFrame
	xor a
	ldh [hSerialSend], a
	ld a, (0 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a

.player_1
	ld de, MUSIC_NONE
	call PlayMusic
	ld c, 3
	call DelayFrames
	xor a
	ldh [rIF], a
	ld a, 1 << SERIAL
	ldh [rIE], a

	ld hl, wLinkBattleRNPreamble
	ld de, wEnemyMon
	ld bc, SERIAL_RN_PREAMBLE_LENGTH + SERIAL_RNS_LENGTH
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wLinkData
	ld de, wOTPartyData
	ld bc, SERIAL_PREAMBLE_LENGTH + NAME_LENGTH + 1 + PARTY_LENGTH + 1 + 2 + (PARTYMON_STRUCT_LENGTH + NAME_LENGTH * 2) * PARTY_LENGTH + 3
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wPlayerPatchLists
	ld de, wOTPatchLists
	ld bc, 200
	call Serial_ExchangeBytes

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr nz, .not_trading
	ld hl, wLinkPlayerMail
	ld de, wLinkOTMail
	ld bc, wLinkPlayerMailEnd - wLinkPlayerMail
	call ExchangeBytes

.not_trading
	xor a
	ldh [rIF], a
	ld a, (1 << JOYPAD) | (1 << SERIAL) | (1 << TIMER) | (1 << VBLANK)
	ldh [rIE], a
	ld de, MUSIC_NONE
	call PlayMusic

	call Link_CopyRandomNumbers

	ld hl, wOTPartyData
	call Link_FindFirstNonControlCharacter_SkipZero
	ld de, wLinkData
	ld bc, NAME_LENGTH + 1 + PARTY_LENGTH + 1 + 2 + (PARTYMON_STRUCT_LENGTH + NAME_LENGTH * 2) * PARTY_LENGTH
	call Link_CopyOTData

	ld de, wPlayerTrademon
	ld hl, wLinkPatchList1
	ld c, 2
.loop1
	ld a, [de]
	inc de
	and a
	jr z, .loop1
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop1
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop1
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .next1
	push hl
	push bc
	ld b, 0
	dec a
	ld c, a
	add hl, bc
	ld a, SERIAL_NO_DATA_BYTE
	ld [hl], a
	pop bc
	pop hl
	jr .loop1

.next1
	ld hl, wLinkPatchList2
	dec c
	jr nz, .loop1

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jp nz, .skip_mail
	ld hl, wLinkOTMail
.loop2
	ld a, [hli]
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr nz, .loop2
.loop3
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop3
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr z, .loop3
	dec hl
	ld de, wLinkOTMail
	ld bc, wLinkDataEnd - wLinkOTMail ; should be wLinkOTMailEnd - wLinkOTMail
	call CopyBytes
	ld hl, wLinkOTMail
	ld bc, (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
.loop4
	ld a, [hl]
	cp SERIAL_MAIL_REPLACEMENT_BYTE
	jr nz, .okay1
	ld [hl], SERIAL_NO_DATA_BYTE
.okay1
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop4
	ld de, wOTPlayerMailPatchSet
.loop5
	ld a, [de]
	inc de
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .start_copying_mail
	ld hl, wLinkOTMailMetadata
	dec a
	ld b, 0
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	jr .loop5

.start_copying_mail
	ld hl, wLinkOTMail
	ld de, wLinkReceivedMail
	ld b, PARTY_LENGTH
.copy_mail_loop
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	call CopyBytes
	ld a, LOW(MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1))
	add e
	ld e, a
	ld a, HIGH(MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1))
	adc d
	ld d, a
	pop bc
	dec b
	jr nz, .copy_mail_loop
	ld de, wLinkReceivedMail
	ld b, PARTY_LENGTH
.copy_author_loop
	push bc
	ld a, LOW(MAIL_MSG_LENGTH + 1)
	add e
	ld e, a
	ld a, HIGH(MAIL_MSG_LENGTH + 1)
	adc d
	ld d, a
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	call CopyBytes
	pop bc
	dec b
	jr nz, .copy_author_loop
	ld b, PARTY_LENGTH
	ld de, wLinkReceivedMail
.fix_mail_loop
	push bc
	push de
	farcall IsMailEuropean
	ld a, c
	or a
	jr z, .next
	sub $3
	jr nc, .skip
	farcall ConvertEnglishMailToFrenchGerman
	jr .next

.skip
	cp $2
	jr nc, .next
	farcall ConvertEnglishMailToSpanishItalian

.next
	pop de
	ld hl, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop bc
	dec b
	jr nz, .fix_mail_loop
	ld de, wLinkReceivedMailEnd
	xor a
	ld [de], a

.skip_mail
	ld hl, wLinkPlayerName
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes

	ld de, wOTPartyCount
	ld bc, 1 + PARTY_LENGTH + 1
	call CopyBytes

	ld de, wOTPlayerID
	ld bc, 2
	call CopyBytes

	ld de, wOTPartyMons
	ld bc, wOTPartyDataEnd - wOTPartyMons
	call CopyBytes

	ld de, MUSIC_NONE
	call PlayMusic
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ld c, 66
	call z, DelayFrames
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .ready_to_trade
	ld a, CAL
	ld [wOtherTrainerClass], a
	call ClearScreen
	farcall Link_WaitBGMap

	ld hl, wOptions
	ld a, [hl]
	push af
	and 1 << STEREO
	or TEXT_DELAY_MED
	ld [hl], a
	ld hl, wOTPlayerName
	ld de, wOTClassName
	ld bc, NAME_LENGTH
	call CopyBytes
	call ReturnToMapFromSubmenu
	ld a, [wDisableTextAcceleration]
	push af
	ld a, 1
	ld [wDisableTextAcceleration], a
	ldh a, [rIE]
	push af
	ldh a, [rIF]
	push af
	xor a
	ldh [rIF], a
	ldh a, [rIE]
	set LCD_STAT, a
	ldh [rIE], a
	pop af
	ldh [rIF], a

	; LET'S DO THIS
	predef StartBattle

	ldh a, [rIF]
	ld h, a
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	ld a, h
	ldh [rIF], a
	pop af
	ld [wDisableTextAcceleration], a
	pop af
	ld [wOptions], a

	farcall LoadPokemonData
	jmp ExitLinkCommunications

.ready_to_trade
	ld de, MUSIC_ROUTE_30
	call PlayMusic
	jmp InitTradeMenuDisplay

LinkTimeout:
	ld de, .LinkTimeoutText
	ld b, 10
.loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .loop
	xor a
	ld [hld], a
	ld [hl], a
	ldh [hVBlank], a
	push de
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	push de
	ld d, h
	ld e, l
	farcall LinkTextbox2
	pop de
	pop hl
	bccoord 1, 14
	call PlaceHLTextAtBC
	call RotateThreePalettesRight
	call ClearScreen
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	jmp WaitBGMap2

.LinkTimeoutText:
	text_far _LinkTimeoutText
	text_end

ExchangeBytes:
; This is similar to Serial_ExchangeBytes,
; but without a SERIAL_PREAMBLE_BYTE check.
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.wait
	dec a
	jr nz, .wait
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	xor a
	ldh [hSerialIgnoringInitialData], a
	jr .loop

.load
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

String_PleaseWait:
if DEF(_FR_FR)
	db "UN MOMENT…@"
else
	db "PLEASE WAIT!@"
endc

ClearLinkData:
	ld hl, wLinkData
	ld bc, wLinkDataEnd - wLinkData
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

FixDataForLinkTransfer:
	ld hl, wLinkBattleRNPreamble
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_RN_PREAMBLE_LENGTH
.preamble_loop
	ld [hli], a
	dec b
	jr nz, .preamble_loop

	assert wLinkBattleRNPreamble + SERIAL_RN_PREAMBLE_LENGTH == wLinkBattleRNs
	ld b, SERIAL_RNS_LENGTH
.rn_loop
	call Random
	cp SERIAL_PREAMBLE_BYTE
	jr nc, .rn_loop
	ld [hli], a
	dec b
	jr nz, .rn_loop

	ld hl, wPlayerPatchLists
	ld a, SERIAL_PREAMBLE_BYTE
	ld [hli], a
	ld [hli], a
	ld [hli], a

	ld b, 200
	xor a
.loop1
	ld [hli], a
	dec b
	jr nz, .loop1

	ld hl, (wLinkData + SERIAL_PREAMBLE_LENGTH + NAME_LENGTH + 1 + PARTY_LENGTH + 1) - 1
	ld de, wPlayerPatchLists + 10 ; ???
	lb bc, 0, 0
.loop2
	inc c
	ld a, c
	cp SERIAL_PATCH_LIST_LENGTH + 1
	jr z, .next1
	ld a, b
	dec a
	jr nz, .next2
	push bc
	ld b, 2 + PARTYMON_STRUCT_LENGTH * PARTY_LENGTH - SERIAL_PATCH_LIST_LENGTH + 1
	ld a, c
	cp b
	pop bc
	jr z, .done
.next2
	inc hl
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .loop2
	ld a, c
	ld [de], a
	inc de
	ld [hl], SERIAL_PATCH_REPLACEMENT_BYTE
	jr .loop2

.next1
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	inc de
	lb bc, 1, 0
	jr .loop2

.done
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_PrepPartyData_Gen2:
	ld de, wLinkData
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_PREAMBLE_LENGTH
.loop1
	ld [de], a
	inc de
	dec b
	jr nz, .loop1

	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes

	ld hl, wPartyCount
	ld bc, 1 + PARTY_LENGTH + 1
	call CopyBytes

	ld hl, wPlayerID
	ld bc, 2
	call CopyBytes

	ld hl, wPartyMon1Species
	ld bc, PARTY_LENGTH * PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld hl, wPartyMonOTs
	ld bc, PARTY_LENGTH * NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMonNicknames
	ld bc, PARTY_LENGTH * MON_NAME_LENGTH
	call CopyBytes

; Okay, we did all that.  Now, are we in the trade center?
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ret nz

; Fill 5 bytes at wLinkPlayerMailPreamble with $20
	ld de, wLinkPlayerMailPreamble
	ld a, SERIAL_MAIL_PREAMBLE_BYTE
	call Link_CopyMailPreamble

; Copy all the mail messages to wLinkPlayerMailMessages
	ld a, BANK(sPartyMail)
	call OpenSRAM
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.loop2
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	call CopyBytes
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2
; Copy the mail data to wLinkPlayerMailMetadata
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.loop3
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	add hl, bc
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	call CopyBytes
	pop bc
	dec b
	jr nz, .loop3
	ld b, PARTY_LENGTH
	ld de, sPartyMail
	ld hl, wLinkPlayerMailMessages
.loop4
	push bc
	push hl
	push de
	push hl
	farcall IsMailEuropean
	pop de
	ld a, c
	or a
	jr z, .next
	sub $3
	jr nc, .italian_spanish
	farcall ConvertFrenchGermanMailToEnglish
	jr .next
.italian_spanish
	cp $2
	jr nc, .next
	farcall ConvertSpanishItalianMailToEnglish
.next
	pop de
	ld hl, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, MAIL_MSG_LENGTH + 1
	add hl, bc
	pop bc
	dec b
	jr nz, .loop4
	call CloseSRAM

	ld hl, wLinkPlayerMailMessages
	ld bc, (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
.loop5
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .skip2
	ld [hl], SERIAL_MAIL_REPLACEMENT_BYTE
.skip2
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop5

	ld hl, wLinkPlayerMailMetadata
	ld de, wLinkPlayerMailPatchSet
	ld b, (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH
	ld c, 0
.loop6
	inc c
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .skip3
	ld [hl], SERIAL_PATCH_REPLACEMENT_BYTE
	ld a, c
	ld [de], a
	inc de
.skip3
	inc hl
	dec b
	jr nz, .loop6

	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_CopyMailPreamble:
; fill 5 bytes with the value of a, starting at de
	ld c, SERIAL_MAIL_PREAMBLE_LENGTH
.loop
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Link_CopyOTData:
.loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

Link_CopyRandomNumbers:
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld hl, wEnemyMonSpecies
	call Link_FindFirstNonControlCharacter_AllowZero
	ld de, wLinkBattleRNs
	ld c, 10
.loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Link_FindFirstNonControlCharacter_SkipZero:
.loop
	ld a, [hli]
	and a
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret

Link_FindFirstNonControlCharacter_AllowZero:
.loop
	ld a, [hli]
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret

InitTradeMenuDisplay:
	call ClearScreen
	call LoadTradeScreenBorderGFX
	farcall InitTradeSpeciesList
	xor a
	ld hl, wOtherPlayerLinkMode
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, 1
	ld [wMenuCursorY], a
	inc a
	ld [wPlayerLinkAction], a
	jmp LinkTrade_PlayerPartyMenu

LinkTrade_OTPartyMenu:
	ld a, OTPARTYMON
	ld [wMonType], a
	ld a, A_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [wOTPartyCount]
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 9
	ld [w2DMenuCursorInitY], a
	ld a, 6
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorX], a
	ln a, 1, 0
	ld [w2DMenuCursorOffsets], a
	ld a, MENU_UNUSED_3
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a

LinkTradeOTPartymonMenuLoop:
	farcall LinkTradeMenu
	ld a, d
	and a
	jp z, LinkTradePartiesMenuMasterLoop
	bit A_BUTTON_F, a
	jr z, .not_a_button
	ld a, INIT_ENEMYOT_LIST
	ld [wInitListType], a
	callfar InitList
	ld hl, wOTPartyMon1Species
	farcall LinkMonStatsScreen
	jmp LinkTradePartiesMenuMasterLoop

.not_a_button
	bit D_UP_F, a
	jr z, .not_d_up
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jp nz, LinkTradePartiesMenuMasterLoop
	xor a
	ld [wMonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	ld a, [wPartyCount]
	ld [wMenuCursorY], a
	jr LinkTrade_PlayerPartyMenu

.not_d_up
	bit D_DOWN_F, a
	jp z, LinkTradePartiesMenuMasterLoop
	jmp LinkTradeOTPartymonMenuCheckCancel

LinkTrade_PlayerPartyMenu:
	farcall InitMG_Mobile_LinkTradePalMap
	xor a
	ld [wMonType], a
	ld a, A_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 1
	ld [w2DMenuCursorInitY], a
	ld a, 6
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorX], a
	ln a, 1, 0
	ld [w2DMenuCursorOffsets], a
	ld a, MENU_UNUSED_3
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	call WaitBGMap2

LinkTradePartymonMenuLoop:
	farcall LinkTradeMenu
	ld a, d
	and a
	jr nz, .check_joypad
	jr LinkTradePartiesMenuMasterLoop

.check_joypad
	bit A_BUTTON_F, a
	jr z, .not_a_button
	jr LinkTrade_TradeStatsMenu

.not_a_button
	bit D_DOWN_F, a
	jr z, .not_d_down
	ld a, [wMenuCursorY]
	dec a
	jp nz, LinkTradePartiesMenuMasterLoop
	ld a, OTPARTYMON
	ld [wMonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	ld a, 1
	ld [wMenuCursorY], a
	jmp LinkTrade_OTPartyMenu

.not_d_down
	bit D_UP_F, a
	jr z, LinkTradePartiesMenuMasterLoop
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wPartyCount]
	cp b
	jr nz, LinkTradePartiesMenuMasterLoop
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	jmp LinkTradePartymonMenuCheckCancel

LinkTradePartiesMenuMasterLoop:
	ld a, [wMonType]
	and a
	jp z, LinkTradePartymonMenuLoop ; PARTYMON
	jmp LinkTradeOTPartymonMenuLoop  ; OTPARTYMON

LinkTrade_TradeStatsMenu:
	call LoadTilemapToTempTilemap
	ld a, [wMenuCursorY]
	push af
	hlcoord 0, 15
	ld b, 1
	ld c, 18
	call LinkTextboxAtHL
	hlcoord 2, 16
	ld de, .String_Stats_Trade
	call PlaceString
	farcall Link_WaitBGMap

.joy_loop
	ld a, " "
	ldcoord_a 11, 16
	ld a, A_BUTTON | B_BUTTON | D_RIGHT
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 16
	ld [w2DMenuCursorInitY], a
	ld a, 1
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	call ScrollingMenuJoypad
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit B_BUTTON_F, a
	jr z, .show_stats
.b_button
	pop af
	ld [wMenuCursorY], a
	call SafeLoadTempTilemapToTilemap
	jmp LinkTrade_PlayerPartyMenu

.d_right
	ld a, " "
	ldcoord_a 1, 16
	ld a, A_BUTTON | B_BUTTON | D_LEFT
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 16
	ld [w2DMenuCursorInitY], a
	ld a, 11
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	call ScrollingMenuJoypad
	bit D_LEFT_F, a
	jp nz, .joy_loop
	bit B_BUTTON_F, a
	jr nz, .b_button
	jr .try_trade

.show_stats
	pop af
	ld [wMenuCursorY], a
	ld a, INIT_PLAYEROT_LIST
	ld [wInitListType], a
	callfar InitList
	farcall LinkMonStatsScreen
	call SafeLoadTempTilemapToTilemap
	hlcoord 6, 1
	lb bc, 6, 1
	ld a, " "
	call LinkEngine_FillBox
	hlcoord 17, 1
	lb bc, 6, 1
	ld a, " "
	call LinkEngine_FillBox
	jmp LinkTrade_PlayerPartyMenu

.try_trade
	call PlaceHollowCursor
	pop af
	ld [wMenuCursorY], a
	dec a
	ld [wCurTradePartyMon], a
	ld [wPlayerLinkAction], a
	farcall PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jp z, InitTradeMenuDisplay
	ld [wCurOTTradePartyMon], a
	call LinkTradePlaceArrow
	ld c, 100
	call DelayFrames
	farcall ValidateOTTrademon
	jr c, .abnormal
	farcall CheckAnyOtherAliveMonsForTrade
	jp nc, LinkTrade
	xor a
	ld [wUnusedLinkAction], a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call LinkTextboxAtHL
	farcall Link_WaitBGMap
	ld hl, .LinkTradeCantBattleText
	bccoord 1, 14
	call PlaceHLTextAtBC
	jr .cancel_trade

.abnormal
	xor a
	ld [wUnusedLinkAction], a
	ld [wOtherPlayerLinkAction], a
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call LinkTextboxAtHL
	farcall Link_WaitBGMap
	ld hl, .LinkAbnormalMonText
	bccoord 1, 14
	call PlaceHLTextAtBC

.cancel_trade
	call DisplayTradeCancelled
	ld a, $1
	ld [wPlayerLinkAction], a
	farcall PrintWaitingTextAndSyncAndExchangeNybble
	ld c, 100
	call DelayFrames
	jmp InitTradeMenuDisplay

.LinkTradeCantBattleText:
	text_far _LinkTradeCantBattleText
	text_end

.String_Stats_Trade:
if DEF(_FR_FR)
	db "STATS     ECHANGE@"
else
	db "STATS     TRADE@"
endc

.LinkAbnormalMonText:
	text_far _LinkAbnormalMonText
	text_end

DisplayTradeCancelled:
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	jmp PlaceString

LinkTradeOTPartymonMenuCheckCancel:
	ld a, [wMenuCursorY]
	cp 1
	jp nz, LinkTradePartiesMenuMasterLoop
	call HideCursor

	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	; fallthrough

LinkTradePartymonMenuCheckCancel:
.loop1
	ld a, "▶"
	ldcoord_a 9, 17
.loop2
	call JoyTextDelay
	ldh a, [hJoyLast]
	and a
	jr z, .loop2
	bit A_BUTTON_F, a
	jr nz, .a_button
	push af
	ld a, " "
	ldcoord_a 9, 17
	pop af
	bit D_UP_F, a
	jr z, .d_up
	ld a, [wOTPartyCount]
	ld [wMenuCursorY], a
	jmp LinkTrade_OTPartyMenu

.d_up
	ld a, $1
	ld [wMenuCursorY], a
	jmp LinkTrade_PlayerPartyMenu

.a_button
	ld a, "▷"
	ldcoord_a 9, 17
	ld a, $f
	ld [wPlayerLinkAction], a
	farcall PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jr nz, .loop1
	; fallthrough

ExitLinkCommunications:
	call RotateThreePalettesRight
	call ClearScreen
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call WaitBGMap2
	xor a
	ld [wUnusedLinkCommunicationByte], a
	xor a
	ldh [rSB], a
	ldh [hSerialSend], a
	ld a, (0 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ret

LinkTradePlaceArrow:
; Indicates which pokemon the other player has selected to trade
	ld a, [wOtherPlayerLinkMode]
	hlcoord 6, 9
	ld bc, SCREEN_WIDTH
	call AddNTimes
if DEF(_FR_FR)
; I'm unsure about this.
	;ld [hl], $1f
	;ld bc, MON_NAME_LENGTH
	;add hl, bc
	;ld [hl], $1f
	
	ld [hl], "▷"
else
	ld [hl], "▷"
endc
	ret

LinkEngine_FillBox:
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

LinkTrade:
	xor a
	ld [wUnusedLinkAction], a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call LinkTextboxAtHL
	farcall Link_WaitBGMap
	ld a, [wCurTradePartyMon]
	ld hl, wPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wBufferTrademonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, LinkAskTradeForText
	bccoord 1, 14
	call PlaceHLTextAtBC
	call LoadStandardMenuHeader
if DEF(_FR_FR)
	hlcoord 9, 7
else
	hlcoord 10, 7
endc
	ld b, 3
if DEF(_FR_FR)
	ld c, 8
else
	ld c, 7
endc
	call LinkTextboxAtHL
	ld de, String_TradeCancel
if DEF(_FR_FR)
	hlcoord 11, 8
else
	hlcoord 12, 8
endc
	call PlaceString
	ld a, 8
	ld [w2DMenuCursorInitY], a
if DEF(_FR_FR)
	ld a, 10
else
	ld a, 11
endc
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 2
	ld [w2DMenuNumRows], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	farcall Link_WaitBGMap
	call ScrollingMenuJoypad
	push af
	call ExitMenu
	call WaitBGMap2
	pop af
	bit 1, a
	jr nz, .canceled
	ld a, [wMenuCursorY]
	dec a
	jr z, .try_trade

.canceled
	ld a, $1
	ld [wPlayerLinkAction], a
	call DisplayTradeCancelled
	farcall PrintWaitingTextAndSyncAndExchangeNybble
	jmp InitTradeMenuDisplay_Delay

.try_trade
	ld a, $2
	ld [wPlayerLinkAction], a
	farcall PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	dec a
	jr nz, .do_trade
; If we're here, the other player canceled the trade
	call DisplayTradeCancelled
	jmp InitTradeMenuDisplay_Delay

.do_trade
	ld hl, sPartyMail
	ld a, [wCurTradePartyMon]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(sPartyMail)
	call OpenSRAM
	ld d, h
	ld e, l
	ld bc, MAIL_STRUCT_LENGTH
	add hl, bc
	ld a, [wCurTradePartyMon]
	ld c, a
.copy_mail
	inc c
	ld a, c
	cp PARTY_LENGTH
	jr z, .copy_player_data
	push bc
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	pop bc
	jr .copy_mail

.copy_player_data
	ld hl, sPartyMail
	ld a, [wPartyCount]
	dec a
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld hl, wLinkPlayerMail
	ld a, [wCurOTTradePartyMon]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	pop de
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	call CloseSRAM

; Buffer player data
; nickname
	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	ld bc, NAME_LENGTH
	call CopyBytes
; species
	ld a, [wCurTradePartyMon]
	ld hl, wPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wPlayerTrademonSpecies], a
	push af
; OT name
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	ld de, wPlayerTrademonOTName
	ld bc, NAME_LENGTH
	call CopyBytes
; ID
	ld hl, wPartyMon1ID
	ld a, [wCurTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonID], a
	ld a, [hl]
	ld [wPlayerTrademonID + 1], a
; DVs
	ld hl, wPartyMon1DVs
	ld a, [wCurTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonDVs], a
	ld a, [hl]
	ld [wPlayerTrademonDVs + 1], a
; caught data
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a

; Buffer other player data
; nickname
	ld hl, wOTPlayerName
	ld de, wOTTrademonSenderName
	ld bc, NAME_LENGTH
	call CopyBytes
; species
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wOTTrademonSpecies], a
; OT name
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMonOTs
	call SkipNames
	ld de, wOTTrademonOTName
	ld bc, NAME_LENGTH
	call CopyBytes
; ID
	ld hl, wOTPartyMon1ID
	ld a, [wCurOTTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonID], a
	ld a, [hl]
	ld [wOTTrademonID + 1], a
; DVs
	ld hl, wOTPartyMon1DVs
	ld a, [wCurOTTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonDVs], a
	ld a, [hl]
	ld [wOTTrademonDVs + 1], a
; caught data
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wOTTrademonCaughtData], a

	ld a, [wCurTradePartyMon]
	ld [wCurPartyMon], a
	ld hl, wPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wCurTradePartyMon], a

	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	callfar RemoveMonFromPartyOrBox
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, TRUE
	ld [wForceEvolution], a
	ld a, [wCurOTTradePartyMon]
	push af
	ld hl, wOTPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wCurOTTradePartyMon], a

	ld c, 100
	call DelayFrames
	call ClearTilemap
	call LoadFontsBattleExtra
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player_2
	predef TradeAnimation
	jr .done_animation

.player_2
	predef TradeAnimationPlayer2

.done_animation
	pop af
	ld c, a
	ld [wCurPartyMon], a
	ld hl, wOTPartySpecies
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld hl, wOTPartyMon1Species
	ld a, c
	call GetPartyLocation
	ld de, wTempMonSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	predef AddTempmonToParty
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	callfar EvolvePokemon
	call ClearScreen
	call LoadTradeScreenBorderGFX
	call SetTradeRoomBGPals
	farcall Link_WaitBGMap

; Check if either of the Pokémon sent was a Mew or Celebi, and send a different
; byte depending on that. Presumably this would've been some prevention against
; illicit trade machines, but it doesn't seem like a very effective one.
; Removing this code breaks link compatibility with the vanilla gen2 games, but
; has otherwise no consequence.
	ld b, 1
	pop af
	ld c, a
	cp MEW
	jr z, .send_checkbyte
	ld a, [wCurPartySpecies]
	cp MEW
	jr z, .send_checkbyte
	ld b, 2
	ld a, c
	cp CELEBI
	jr z, .send_checkbyte
	ld a, [wCurPartySpecies]
	cp CELEBI
	jr z, .send_checkbyte

; Send the byte in a loop until the desired byte has been received.
	ld b, 0
.send_checkbyte
	ld a, b
	ld [wPlayerLinkAction], a
	push bc
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	pop bc
	ld a, b
	and a
	jr z, .save
	ld a, [wOtherPlayerLinkAction]
	cp b
	jr nz, .send_checkbyte

.save
	farcall SaveAfterLinkTrade
	farcall StubbedTrainerRankings_Trades
	farcall BackupMobileEventIndex
	ld c, 40
	call DelayFrames
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TradeCompleted
	call PlaceString
	farcall Link_WaitBGMap
	ld c, 50
	call DelayFrames
	jmp Gen2ToGen2LinkComms

InitTradeMenuDisplay_Delay:
	ld c, 100
	call DelayFrames
	jmp InitTradeMenuDisplay

String_TradeCancel:
if DEF(_FR_FR)
	db   "ECHANGE"
	next "ANNULER@"
else
	db   "TRADE"
	next "CANCEL@"
endc

LinkAskTradeForText:
	text_far _LinkAskTradeForText
	text_end

String_TradeCompleted:
if DEF(_FR_FR)
	db   "ECHANGE TERMINE!@"
else
	db   "Trade completed!@"
endc

String_TooBadTheTradeWasCanceled:
if DEF(_FR_FR)
	db   "Dommage! L'échange"
	next "est annulé!@"
else
	db   "Too bad! The trade"
	next "was canceled!@"
endc

LinkTextboxAtHL:
	ld d, h
	ld e, l
	farcall LinkTextbox
	ret

LoadTradeScreenBorderGFX:
	farcall _LoadTradeScreenBorderGFX
	ret

SetTradeRoomBGPals:
	farcall LoadTradeRoomBGPals ; just a nested farcall; so wasteful
	jmp SetPalettes

INCLUDE "engine/movie/trade_animation.asm"

WaitForOtherPlayerToExit:
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	ld a, (0 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	ld a, (0 << rSC_ON) | (0 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (0 << rSC_CLOCK)
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ldh a, [rIF]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_DEFAULT
	ldh [rIE], a
	pop af
	ldh [rIF], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ldh [hVBlank], a
	ld [wLinkMode], a
	ret

SetBitsForLinkTradeRequest:
	ld a, LINK_TRADECENTER - 1
	ld [wPlayerLinkAction], a
	ld [wChosenCableClubRoom], a
	ret

SetBitsForBattleRequest:
	ld a, LINK_COLOSSEUM - 1
	ld [wPlayerLinkAction], a
	ld [wChosenCableClubRoom], a
	ret

WaitForLinkedFriend:
	ld a, [wPlayerLinkAction]
	and a
	jr z, .no_link_action
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ld a, (0 << rSC_ON) | (0 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (0 << rSC_CLOCK)
	ldh [rSC], a
	call DelayFrame
	call DelayFrame
	call DelayFrame

.no_link_action
	ld a, $2
	ld [wLinkTimeoutFrames + 1], a
	ld a, $ff
	ld [wLinkTimeoutFrames], a
.loop
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .connected
	cp USING_EXTERNAL_CLOCK
	jr z, .connected
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ld a, (0 << rSC_ON) | (0 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (0 << rSC_CLOCK)
	ldh [rSC], a
	ld a, [wLinkTimeoutFrames]
	dec a
	ld [wLinkTimeoutFrames], a
	jr nz, .not_done
	ld a, [wLinkTimeoutFrames + 1]
	dec a
	ld [wLinkTimeoutFrames + 1], a
	jr z, .done

.not_done
	ld a, USING_EXTERNAL_CLOCK
	ldh [rSB], a
	ld a, (0 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	ld a, (1 << rSC_ON) | (1 << rSC_CLOCK)
	ldh [rSC], a
	call DelayFrame
	jr .loop

.connected
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	ld c, 50
	call DelayFrames
	ld a, $1
	ld [wScriptVar], a
	ret

.done
	xor a
	ld [wScriptVar], a
	ret

CheckLinkTimeout_Receptionist:
	ld a, $1
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, 3
	ld [hli], a
	xor a
	ld [hl], a
	call WaitBGMap
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	xor a
	ldh [hVBlank], a
	ld a, [wScriptVar]
	and a
	ret nz
	jmp Link_ResetSerialRegistersAfterLinkClosure

CheckLinkTimeout_Gen2:
; if wScriptVar = 0 on exit, link connection is closed
	ld a, $5
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, 3
	ld [hli], a
	xor a
	ld [hl], a
	call WaitBGMap
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	ld a, [wScriptVar]
	and a
	jr z, .exit

; Wait for ~$70000 cycles to give the other GB time to be ready
	ld bc, $ffff
.wait
	dec bc
	ld a, b
	or c
	jr nz, .wait

; If other GB is not ready at this point, disconnect due to timeout
	ld a, [wOtherPlayerLinkMode]
	cp $5
	jr nz, .timeout

; Another check to increase reliability
	ld a, $6
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, 1
	ld [hli], a
	ld [hl], 50
	call Link_CheckCommunicationError
	ld a, [wOtherPlayerLinkMode]
	cp $6
	jr z, .exit

.timeout
	xor a
	ld [wScriptVar], a
	ret

.exit
	xor a
	ldh [hVBlank], a
	ret

Link_CheckCommunicationError:
	xor a
	ldh [hSerialReceivedNewData], a
	ld a, [wLinkTimeoutFrames]
	ld h, a
	ld a, [wLinkTimeoutFrames + 1]
	ld l, a
	push hl
	call .CheckConnected
	pop hl
	jr nz, .load_true
	call .AcknowledgeSerial
	call .ConvertDW
	call .CheckConnected
	jr nz, .load_true
	call .AcknowledgeSerial
	xor a ; FALSE
	jr .done

.load_true
	ld a, TRUE

.done
	ld [wScriptVar], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ret

.CheckConnected:
	call WaitLinkTransfer
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	inc a
	ret nz
	ld a, [hl]
	inc a
	ret

.AcknowledgeSerial:
	ld b, 10
.loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .loop
	ret

.ConvertDW:
	; [wLinkTimeoutFrames] = ((hl - $100) / 4) + $100
	;                      = (hl / 4) + $c0
	dec h
	srl h
	rr l
	srl h
	rr l
	inc h
	ld a, h
	ld [wLinkTimeoutFrames], a
	ld a, l
	ld [wLinkTimeoutFrames + 1], a
	ret

TryQuickSave:
	ld a, [wChosenCableClubRoom]
	push af
	farcall Link_SaveGame
	ld a, TRUE
	jr nc, .return_result
	xor a ; FALSE
.return_result
	ld [wScriptVar], a
	pop af
	ld [wChosenCableClubRoom], a
	ret

CheckBothSelectedSameRoom:
	ld a, [wChosenCableClubRoom]
	call Link_EnsureSync
	push af
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	pop af
	ld b, a
	ld a, [wChosenCableClubRoom]
	cp b
	jr nz, .fail
	ld a, [wChosenCableClubRoom]
	inc a
	ld [wLinkMode], a
	xor a
	ldh [hVBlank], a
	ld a, TRUE
	ld [wScriptVar], a
	ret

.fail
	xor a ; FALSE
	ld [wScriptVar], a
	ret

TradeCenter:
	ld a, LINK_TRADECENTER
	ld [wLinkMode], a
	call DisableSpriteUpdates
	callfar LinkCommunications
	call EnableSpriteUpdates
	xor a
	ldh [hVBlank], a
	ret

Colosseum:
	ld a, LINK_COLOSSEUM
	ld [wLinkMode], a
	call DisableSpriteUpdates
	callfar LinkCommunications
	call EnableSpriteUpdates
	xor a
	ldh [hVBlank], a
	ret

CloseLink:
	xor a
	ld [wLinkMode], a
	ld c, 3
	call DelayFrames
	jr Link_ResetSerialRegistersAfterLinkClosure

FailedLinkToPast:
	ld c, 40
	call DelayFrames
	ld a, $e
	jr Link_EnsureSync

Link_ResetSerialRegistersAfterLinkClosure:
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ldh [rSC], a
	ret

Link_EnsureSync:
	add $d0
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
.receive_loop
	call Serial_ExchangeSyncBytes
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	and $f0
	cp $d0
	jr z, .done
	ld a, [wLinkReceivedSyncBuffer + 1]
	ld b, a
	and $f0
	cp $d0
	jr nz, .receive_loop

.done
	xor a
	ldh [hVBlank], a
	ld a, b
	and $f
	ret

CableClubCheckWhichChris:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ld a, TRUE
	jr z, .yes
	dec a ; FALSE

.yes
	ld [wScriptVar], a
	ret