StickyWebEffect:
	push hl
	push de
	push bc

	; We retrieve the right variables, whether it's our turn or the opponenet's.
	ld hl, wPlayerScreens ; Because callfar destroys hl, we need to retrieve it.
	ld de, wBattleMonType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wEnemyScreens
	ld de, wEnemyMonType

.got_screens
	bit SCREENS_STICKY_WEB, [hl]
	jr z, .exit ; If the sticky web is not set on this side of the field, then we exit.

	; Flying-types aren't affected by Sticky web.
	ld a, [de]
	cp FLYING
	ret z
	inc de
	ld a, [de]
	cp FLYING
	jr z, .exit

	; Effect text.
	ld hl, BattleText_UserCaughtInStickyWeb ; "caught in a STICKY WEB!"
	call StdBattleTextbox

	; Actual effect.
	call BattleCommand_SwitchTurn
	call ResetMiss
	call BattleCommand_SpeedDown2
	call BattleCommand_StatDownMessage
	call BattleCommand_SwitchTurn

.exit
	pop bc
	pop de
	pop hl
	ret