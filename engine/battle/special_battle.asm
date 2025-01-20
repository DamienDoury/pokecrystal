SpecialBattle_RegisterMetronomeUsage::
    ld a, [wCurPlayerMove]
	cp METRONOME
    ret z

    ld hl, wSpecialBattleData
    set NON_METRONOME_USAGE_BIT, [hl] ; Bit set if the player used anything else than Metronome during the battle.
    ret

SpecialBattle_RegisterBattlePriority::
    ret nc

    ld hl, wSpecialBattleData
    set PLAYER_OUTSPEED_BIT, [hl] ; Bit set if the player outsped the opponent at least once during the battle.
    ret

SpecialBattle_UsedOnlyMetronome::
    xor a ; FALSE
    ld [wScriptVar], a

    ld hl, wSpecialBattleData
    bit NON_METRONOME_USAGE_BIT, [hl]
    ret nz

    inc a ; TRUE
    ld [wScriptVar], a
    ret

SpecialBattle_DidPlayerOutspeedTheOpponent::
    xor a ; FALSE
    ld [wScriptVar], a

    ld hl, wSpecialBattleData
    bit PLAYER_OUTSPEED_BIT, [hl]
    ret z

    inc a ; TRUE
    ld [wScriptVar], a
    ret

SpecialBattle_GetBattleResultFromScript::
    ld a, [wBattleResult]
    and $ff ^ BATTLERESULT_BITMASK
    ld [wScriptVar], a
    ret