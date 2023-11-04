; From Idain's commit https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/78c92b5b7aaf7d88963008263aa8db4011b8dfaa#diff-7d1c1d57fb99f9d3331d0585e2ed629348d7ac82997a5d684fcbc454c159a173
; Based on an old commit of Rangi's Polished Crystal, which was in turn based off TPP Anniversary Crystal
; https://github.com/Rangi42/polishedcrystal/blob/39bf603531d74254e7ab2740677d38ec3ef9b6bd/event/move_reminder.asm
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/event/move_relearner.asm

MoveReminder:
	ld hl, Text_MoveReminderIntro
	call PrintText
	farcall PlaceMoneyTopRight
	call YesNoBox
	jp c, .cancel

	ld hl, .cost_to_relearn
	ld de, hMoneyTemp
	ld bc, 3
	call CopyBytes

	ld bc, hMoneyTemp
	ld de, wMoney
	farcall CompareMoney
	jp c, .not_enough_money

	ld hl, Text_MoveReminderWhichMon
	call PrintText
	call JoyWaitAorB

	ld b, $6
	farcall SelectMonFromParty
	jp c, .cancel

	ld a, [wCurPartySpecies]
	cp EGG
	jp z, .egg

	call IsAPokemon
	jp c, .no_mon

	call GetRemindableMoves
	jp z, .no_moves

	ld hl, Text_MoveReminderWhichMove
	call PrintText
	call JoyWaitAorB

	call SetupRemindableMovesList

.choose_move
	call ChooseMoveToLearn
	jr c, .skip_learn

	ld a, [wMenuCursorY] ; Allows to go back to the previous selection on cancelation.
	ld [wOWTempByte1], a

	ld a, [wMenuSelection]
	ld [wd265], a
	call GetMoveName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, wStringBuffer2 - wStringBuffer1
	call CopyBytes
	ld b, 0
	ld a, TRUE
	ld [wIsLearningTMHM], a
	predef LearnMove
	ld a, FALSE
	ld [wIsLearningTMHM], a
	ld a, b
	and a
	jr z, .choose_move

	call ReturnToMapWithSpeechTextbox
	farcall PlaceMoneyTopRight
	ld hl, .cost_to_relearn
	ld de, hMoneyTemp
	ld bc, 3
	call CopyBytes

	ld hl, Text_MoveReminderTakeMoney
	call PrintText
	call PromptButton
	call WaitSFX

	ld bc, hMoneyTemp
	ld de, wMoney
	farcall TakeMoney

	farcall PlaceMoneyTopRight

	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX

	ld hl, Text_MoveReminderThanks
	call PrintText
	ret

.skip_learn
	call ReturnToMapWithSpeechTextbox
.cancel
	ld hl, Text_MoveReminderCancel
	call PrintText
	ret

.egg
	ld hl, Text_MoveReminderEgg
	call PrintText
	ret

.not_enough_money
	ld hl, Text_MoveReminderNotEnough
	call PrintText
	ret

.no_mon
	ld hl, Text_MoveReminderNoMon
	call PrintText
	ret

.no_moves
	ld hl, Text_MoveReminderNoMoves
	call PrintText
	ret

.cost_to_relearn
	dt 500

GetRemindableMoves:
; Get moves remindable by CurPartyMon
; Returns z if no moves can be reminded.
;	EXPORT EvosAttacksPointers, EvosAttacks
	ld hl, wd002
	xor a
	ld [hli], a
	ld [hl], $ff

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartySpecies], a

	push af
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a

	ld b, 0
	ld de, wd002 + 1
; based on GetEggMove in engine/breeding/egg.asm
;.loop
	ld a, [wCurPartySpecies]
	dec a
	push bc
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
rept 2
	add hl, bc
endr
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
.skip_evos
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr nz, .skip_evos

.loop_moves
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr z, .done
	ld c, a
	ld a, [wCurPartyLevel]
	cp c
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	jr c, .loop_moves

	ld c, a
	call CheckAlreadyInList
	jr c, .loop_moves
	call CheckPokemonAlreadyKnowsMove
	jr c, .loop_moves
	ld a, c
	ld [de], a
	inc de
	ld a, $ff
	ld [de], a
	pop bc
	inc b
	push bc
	jr .loop_moves

.done
	pop bc
	pop af
	ld [wCurPartySpecies], a
	ld a, b
	ld [wd002], a
	and a
	ret

CheckAlreadyInList:
	push hl
	ld hl, wd002 + 1
.loop
	ld a, [hli]
	inc a
	jr z, .nope
	dec a
	cp c
	jr nz, .loop
	pop hl
	scf
	ret
.nope
	pop hl
	and a
	ret

CheckPokemonAlreadyKnowsMove:
	push hl
	push bc
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld b, 4
.loop
	ld a, [hli]
	cp c
	jr z, .yes
	dec b
	jr nz, .loop
	pop bc
	pop hl
	and a
	ret
.yes
	pop bc
	pop hl
	scf
	ret

SetupRemindableMovesList:
	call FadeToMenu
	farcall BlankScreen
	call UpdateSprites

	farcall LoadFontLevelSymbol
	farcall LoadStatsScreenPageTilesGFX

	xor a
	ld [wMenuCursorPosition], a
	ld [wMenuScrollPosition], a
	ld [wOWTempByte1], a
	ret

ChooseMoveToLearn:
	; Number of items stored in wd002
	; List of items stored in wd002 + 1
		
	ld hl, .MenuDataHeader
	call CopyMenuHeader
	ld a, [wOWTempByte1]
	ld [wMenuCursorPosition], a

	hlcoord 0, 0
	ld b, 14
	ld c, 18
	call Textbox

	hlcoord 0, 10
	ld b, 6
	ld c, 18
	call Textbox

	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNickname

	call CountChars
	srl a
	ld b, a
	ld a, 7
	sbc b
	ld b, 0
	ld c, a
	hlcoord 0, 0
	add hl, bc
	ld [hl], " "
	inc hl
	call PlaceString
	push bc
	farcall CopyMonToTempMon
	pop hl
	ld [hl], " "
	inc hl
	call PrintLevel
	ld [hl], " "

	call ScrollingMenu
	call SpeechTextbox

	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .carry
	
	ld a, [wMenuSelection]
	ld [wPutativeTMHMMove], a
	and a
	ret

.carry
	scf
	ret

.MenuDataHeader:
	db SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db 1, 1 ; start coords
	db 9, 18 ; end coords
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $30 ; pointers
	db 4, SCREEN_WIDTH + 2 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wd002
	dba .PrintMoveName
	dba .PrintDetails
	dba .PrintMoveDesc

.PrintMoveName
	push de
	ld a, [wMenuSelection]
	ld [wd265], a
	call GetMoveName
	pop hl
	call PlaceString
	ret

.PrintDetails
	push de
	ld a, [wMenuSelection]
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_PP
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld [wBuffer1], a

	pop hl
	ld bc, $ffff - SCREEN_WIDTH + 11
	add hl, bc

	ld de, wBuffer1
	lb bc, 1, 2
	call PrintNum

	ld a, $3e ; P
	ld [hli], a
	ld [hl], a
	ret

.PrintMoveDesc
	push de
	hlcoord 1, 11
	lb bc, 6, 18
	call ClearBox

	ld a, [wMenuSelection]
	inc a
	pop de
	ret z
	dec a
	ld [wCurSpecies], a
	hlcoord 1, 11
	predef PrintMoveFullDescription
	ret

Text_MoveReminderIntro:
	text_far _MoveReminderIntro
	text_end
	
Text_MoveReminderWhichMon:
	text_far _MoveReminderWhichMon
	text_end

Text_MoveReminderWhichMove:
	text_far _MoveReminderWhichMove
	text_end

Text_MoveReminderCancel:
	text_far _MoveReminderCancel
	text_end
	
Text_MoveReminderEgg:
	text_far _MoveReminderEgg
	text_end

Text_MoveReminderNotEnough:
	text_far _MoveReminderNoPay
	text_end

Text_MoveReminderNoMon:
	text_far _MoveReminderNoMon
	text_end
	
Text_MoveReminderNoMoves:
	text_far _MoveReminderNoMoves
	text_end

Text_MoveReminderTakeMoney:
	text_far _MoveReminderTakeMoney
	text_end

Text_MoveReminderThanks:
	text_far _MoveReminderThanks
	text_end
