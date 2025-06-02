BattleCommand_LockOn:
; lockon
	call BattleCommand_MindReader.discard_fails
	jr nz, BattleCommand_MindReader.fail

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	set SUBSTATUS_LOCK_ON_NEXT_TURN, [hl]
	call AnimateCurrentMove

	ld hl, TookAimText
	jmp StdBattleTextbox

BattleCommand_MindReader:
; mindreader
	call .discard_fails
	jr nz, .fail
	
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	set SUBSTATUS_MIND_READER_NEXT_TURN, [hl]
	call AnimateCurrentMove

	ld hl, AnticipatedText
	jmp StdBattleTextbox

.fail
	call AnimateFailedMove
	jp PrintDidntAffect

.discard_fails
	call CheckSubstituteOpp
	ret nz

	ld a, [wAttackMissed]
	and a
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr ; Faster than "call GetBattleVar" as we don't care about HL.
	and 1 << SUBSTATUS_MIND_READER | 1 << SUBSTATUS_LOCK_ON
	ret
	; Mind Reader can't be used twice in a row. Otherwise the user would be invincible for the time being.
	; Lock On can't be used twice in a row, because of the remove function.
	