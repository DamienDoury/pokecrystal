CeruleanCaveB3FStep::
	ld a, [wMapGroup]
	cp GROUP_CERULEAN_CAVE_B3F
	ret nz

	ld a, [wMapNumber]
	cp MAP_CERULEAN_CAVE_B3F
	ret nz

	ld de, EVENT_CAUGHT_MEWTWO
	ld b, CHECK_FLAG
	call EventFlagAction ; Output: C = 1 if mewtwo caught, 0 otherwise.
	dec c
	ret z
	
	ld a, [wCeruleanCaveB3FStepCount]
	inc a
	ld [wCeruleanCaveB3FStepCount], a
	cp 49
	ret nz

CeruleanCaveB3FTelepathicVoice:
	; Reset the step count.
	xor a
	ld [wCeruleanCaveB3FStepCount], a

	; Get the message address.
	ld a, [wCeruleanCaveB3FMessageIndex]
	ld hl, CeruleanCaveB3FMessageArray
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Play the message.
	push hl
	call OpenRedText
	call ApplyTilemap
	pop hl
	call PrintTextboxText
	call WaitButton
	call CloseText

	; Increase the counter.
	ld a, [wCeruleanCaveB3FMessageIndex]
	inc a
	and 8 - 1
	ld [wCeruleanCaveB3FMessageIndex], a
	ret

CeruleanCaveB3FMessageArray:
	dw MewtwoB3FText1
	dw MewtwoB3FText2
	dw MewtwoB3FText3
	dw MewtwoB3FText4
	dw MewtwoB3FText5
	dw MewtwoB3FText6
	dw MewtwoB3FText7
	dw MewtwoB3FText8

MewtwoB3FText1:
	text_far _MewtwoB3FText1
	text_end

MewtwoB3FText2:
	text_far _MewtwoB3FText2
	text_end

MewtwoB3FText3:
	text_far _MewtwoB3FText3
	text_end

MewtwoB3FText4:
	text_far _MewtwoB3FText4
	text_end

MewtwoB3FText5:
	text_far _MewtwoB3FText5
	text_end

MewtwoB3FText6:
	text_far _MewtwoB3FText6
	text_end

MewtwoB3FText7:
	text_far _MewtwoB3FText7
	text_end

MewtwoB3FText8:
	text_far _MewtwoB3FText8
	text_end
