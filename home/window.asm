RefreshScreen::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call _OpenAndCloseMenu_HDMATransferTilemapAndAttrmap
	call LoadFonts_NoOAMUpdate

	pop af
	rst Bankswitch
	ret

CloseText::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	call .CloseText

	ldh a, [hWaitForDownButtonRelease]
	and a
	jr z, .skip_down_button_assignment

	; CloseText only prevents the player from walking down with the Down button if the previous text has been closed with Down.
	ldh a, [hJoyDown]
	and D_DOWN
	ldh [hWaitForDownButtonRelease], a

.skip_down_button_assignment
	pop af
	ldh [hOAMUpdate], a
	ld hl, wVramState
	res 6, [hl]
	ret

.CloseText:
	call ClearWindowData
	xor a
	ldh [hBGMapMode], a
	call OverworldTextModeSwitch
	call _OpenAndCloseMenu_HDMATransferTilemapAndAttrmap
	xor a
	ldh [hBGMapMode], a
	call SafeUpdateSprites
	ld a, $90
	ldh [hWY], a
	call UpdatePlayerSprite
	farcall InitMapNameSign
	;call LoadOverworldFont
	ret

OpenText::
	call OpenTextPre
	call SpeechTextbox
	jr OpenTextPost

OpenRedText::
	call OpenTextPre
	call SpeechTextboxRed
	jp OpenTextPost

OpenTextPre::
	call ClearWindowData
	farcall ReanchorBGMap_NoOAMUpdate ; clear bgmap
	ret

OpenTextPost::
	call _OpenAndCloseMenu_HDMATransferTilemapAndAttrmap ; anchor bgmap
	farcall LoadFonts_NoOAMUpdate ; load font
	ret

_OpenAndCloseMenu_HDMATransferTilemapAndAttrmap::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	farcall OpenAndCloseMenu_HDMATransferTilemapAndAttrmap

	pop af
	ldh [hOAMUpdate], a
	ret

SafeUpdateSprites::
	ldh a, [hOAMUpdate]
	push af
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [hOAMUpdate], a

	call UpdateSprites

	xor a
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ret
