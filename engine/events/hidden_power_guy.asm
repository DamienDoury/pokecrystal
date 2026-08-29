
SelectMonForHiddenPowerReveal::
    ld a, -1
    ld [wScriptVar], a
    farcall SelectMonFromParty
    ret c

    ld a, -2
    ld [wScriptVar], a
    ld a, [wCurPartySpecies]
	cp EGG
    ret z

    xor a
    ld [wScriptVar], a

    farcall GetPartyNickname

    ld a, [wCurPartyMon]
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

    ld d, h
    ld e, l
    farcall GetHiddenPowerTypeFromDE
    ldh a, [hFarByte]
	ld [wNamedObjectIndex], a
	predef GetTypeName
    ret