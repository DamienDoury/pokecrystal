BattleCommand_ClearHazards:
; clearhazards

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr z, .not_leeched
	res SUBSTATUS_LEECH_SEED, [hl]
	ld hl, ShedLeechSeedText
	call StdBattleTextbox
.not_leeched

	ld hl, wPlayerScreens
	ld de, wPlayerWrapCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_wrap
	ld hl, wEnemyScreens
	ld de, wEnemyWrapCount
.got_screens_wrap
	bit SCREENS_SPIKES, [hl]
	jr z, .no_spikes
	res SCREENS_SPIKES, [hl]
	ld hl, BlewSpikesText
	push de
	call StdBattleTextbox
	pop de
.no_spikes
	bit SCREENS_STICKY_WEB, [hl]
	jr z, .no_sticky_web
	res SCREENS_STICKY_WEB, [hl]
	ld hl, RippedStickyWebText
	push de
	call StdBattleTextbox
	pop de
.no_sticky_web

	ld a, [de]
	and a
	ret z
	xor a
	ld [de], a
	ld hl, ReleasedByText
	jmp StdBattleTextbox
