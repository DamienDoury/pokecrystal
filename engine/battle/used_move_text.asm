DisplayWeaknessDiseaseText:
	ld hl, WeaknessDiseaseText
	jmp BattleTextbox

WeaknessDiseaseText:
	text_far _FeelsWeakText
	text_end

WeaknessDiseaseText2:
	text_far _FeelsWeakText1
	text_asm
	text_far _FeelsWeakText4
	text_end

DisplayUsedMoveText:
	ld hl, UsedMoveText
	call BattleTextbox
	jmp WaitBGMap

UsedMoveText:
	text_far _ActorNameText
	text_asm

	ldh a, [hBattleTurn]
	and a
	jr nz, .start

	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	call UpdateUsedMoves

.start
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld d, h
	ld e, l

	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [wMoveAnim], a

	push hl
	farcall CheckUserIsCharging
	pop hl
	jr nz, .grammar

	; update last move
	ld a, [wMoveAnim]
	ld [hl], a
	ld [de], a

.grammar
; everything except 'CheckObedience' made redundant in localization

	; check obedience
	ld a, [wAlreadyDisobeyed]
	and a
	ld hl, UsedMove2Text
	ret nz

if DEF(_FR_FR)
	push de
	ld de, wStringBuffer2
	call CountChars
	pop de
	cp 12
	jr nc, .doesnt_fit_in_1_line

	ld hl, UsedMoveOneLinerText
	ret

.doesnt_fit_in_1_line
endc
	ld hl, UsedMove2Text
	ret

if DEF(_FR_FR)
UsedMoveOneLinerText:
	text_far _UsedMoveOneLinerText
	text_asm
	jr UsedMoveText_CheckObedience
endc

UsedMove2Text:
	text_far _UsedMoveText
	text_asm
UsedMoveText_CheckObedience:
; check obedience
	ld a, [wAlreadyDisobeyed]
	and a
	jr z, .GetMoveNameText
; print "instead,"
	ld hl, .UsedInsteadText
	ret

.UsedInsteadText:
	text_far _UsedInsteadText
	text_asm
.GetMoveNameText:
	ld hl, MoveNameText
	ret

MoveNameText:
	text_far _MoveNameText
	text_end

UpdateUsedMoves:
; append move a to wPlayerUsedMoves unless it has already been used

	push bc
; start of list
	ld hl, wPlayerUsedMoves
; get move id
	ld b, a
; next count
	ld c, NUM_MOVES

.loop
; get move from the list
	ld a, [hli]
; not used yet?
	and a
	jr z, .add
; already used?
	cp b
	jr z, .quit
; next byte
	dec c
	jr nz, .loop

; if the list is full and the move hasn't already been used
; shift the list back one byte, deleting the first move used
; this can occur with struggle or a new learned move
	ld hl, wPlayerUsedMoves + 1
; 1 = 2
	ld a, [hld]
	ld [hli], a
; 2 = 3
	inc hl
	ld a, [hld]
	ld [hli], a
; 3 = 4
	inc hl
	ld a, [hld]
	ld [hl], a
; 4 = new move
	ld a, b
	ld [wPlayerUsedMoves + 3], a
	jr .quit

.add
; go back to the byte we just inced from
	dec hl
; add the new move
	ld [hl], b

.quit
; list updated
	pop bc
	ret
