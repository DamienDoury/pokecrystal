SpecialBattle_RegisterMetronomeUsage::
    ld a, [wCurPlayerMove]
	cp METRONOME
    ret z

    ld hl, wSpecialBattleData
    set NON_METRONOME_USAGE_BIT, [hl] ; Bit set if the player used anything else than Metronome during the battle.
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

SpecialBattle_GetBattleResultFromScript::
    ld a, [wBattleResult]
    and $ff ^ BATTLERESULT_BITMASK
    ld [wScriptVar], a
    ret
