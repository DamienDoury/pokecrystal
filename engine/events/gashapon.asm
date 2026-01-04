GetCurrentGashaCapsulesCount::
    ld hl, wGasha0CapsulesCount
	ld a, [wGashaID]
    ld b, 0
    ld c, a
    add hl, bc
    add hl, bc
    ld a, [hl]
    ld [wScriptVar], a
    ret

RemoveOneCapsuleFromCurrentGasha::
    call GetCurrentGashaCapsulesCount
    and a
    ld [wScriptVar], a ; FALSE
    ret z

    dec a
    ld [hl], a
    ld a, 1
    ld [wScriptVar], a ; TRUE
    ret