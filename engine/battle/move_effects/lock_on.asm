BattleCommand_LockOn:
; lockon

	call BattleCommand_MindReader.discard_fails
	jr nz, BattleCommand_MindReader.fail

	ld a, BATTLE_VARS_SUBSTATUS5_OPP
	call GetBattleVarAddr
	set SUBSTATUS_LOCK_ON, [hl]
	call AnimateCurrentMove

	ld hl, TookAimText
	jp StdBattleTextbox

BattleCommand_MindReader:
; mindreader
	call .discard_fails
	jr nz, .fail

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	set SUBSTATUS_MIND_READER, [hl]
	call AnimateCurrentMove

	ld hl, AnticipatedText
	jp StdBattleTextbox

.fail
	call AnimateFailedMove
	jp PrintDidntAffect

.discard_fails
	call CheckSubstituteOpp
	ret nz

	ld a, [wAttackMissed]
	and a
	ret