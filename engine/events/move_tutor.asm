MoveTutor_ClearScreen:
	call FadeToMenu
	call ClearBGPalettes
	call ClearScreen
	call DelayFrame
	ld b, SCGB_PACKPALS
	call GetSGBLayout
	xor a
	ld [wItemAttributeValue], a
	ret

; Input: the MT_0X move ID to teach in A.
; Output: carry if the player cancelled.
MoveTutor_RegisterMoveToLearn:
	ld [wNamedObjectIndex], a
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyName1
	farcall ChooseMonToLearnTMHM
	ret

TopCelebrityMoveTutor::
	call MoveTutor_ClearScreen
	ld a, MT04_MOVE ; SKY_ATTACK
	call MoveTutor_RegisterMoveToLearn
	jr c, MoveTutor.cancel
	jr MoveTutor.enter_loop

MoveTutor:
	call MoveTutor_ClearScreen
	call .GetMoveTutorMove
	call MoveTutor_RegisterMoveToLearn
	jr c, .cancel
	jr .enter_loop

.loop
	farcall ChooseMonToLearnTMHM_NoRefresh
	jr c, .cancel
.enter_loop
	call CheckCanLearnMoveTutorMove
	jr nc, .loop
	xor a ; FALSE
	ld [wScriptVar], a
	jr .quit

.cancel
	ld a, -1
	ld [wScriptVar], a
.quit
	jmp CloseSubmenu

.GetMoveTutorMove:
	ld a, [wScriptVar]
	cp MOVETUTOR_FLAMETHROWER
	jr z, .flamethrower
	cp MOVETUTOR_THUNDERBOLT
	jr z, .thunderbolt
	; MOVETUTOR_ICE_BEAM
	ld a, MT03_MOVE ; ICE_BEAM
	ret

.flamethrower
	ld a, MT01_MOVE ; FLAMETHROWER
	ret

.thunderbolt
	ld a, MT02_MOVE ; THUNDERBOLT
	ret

CheckCanLearnMoveTutorMove:
	ld hl, .MenuHeader
	call LoadMenuHeader

	predef CanLearnTMHMMove

	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	pop bc

	ld a, c
	and a
	jr nz, .can_learn
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld a, BANK(TMHMNotCompatibleText)
	ld hl, TMHMNotCompatibleText
	call FarPrintText
	jr .didnt_learn

.can_learn
	callfar KnowsMove
	jr c, .didnt_learn

	ld a, TRUE
	ld [wIsLearningTMHM], a
	predef LearnMove
	ld a, FALSE
	ld [wIsLearningTMHM], a
	ld a, b
	and a
	jr z, .didnt_learn

	ld c, HAPPINESS_LEARNMOVE
	callfar ChangeHappiness
	jr .learned

.didnt_learn
	call ExitMenu
	and a
	ret

.learned
	call ExitMenu
	scf
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
