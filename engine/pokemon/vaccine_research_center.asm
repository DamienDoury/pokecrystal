SilphCo_PorygonMoves:
    db TOXIC, CONVERSION, PSYCHIC_M, RECOVER

SilphCo_FarfetchdMoves:
    db FLAIL, MIRROR_MOVE, SWORDS_DANCE, AGILITY

SilphCo_MrMimeMoves:
    db SAFEGUARD, SUBSTITUTE, PSYBEAM, LIGHT_SCREEN

SilphCo_LickitungMoves:
    db BELLY_DRUM, FLAMETHROWER, SWAGGER, MAGNITUDE

SilphCo_ExeggcuteMoves:
    db SUBSTITUTE, SYNTHESIS, HYPNOSIS, NIGHTMARE

_DisplaySilphCoPokemonMoves::
    ld b, FALSE
_LoadSilphCoPokemonMoves: ; Returns the moveset pointer in HL.
    ld a, [wScriptVar]
    cp PORYGON
    ld hl, SilphCo_PorygonMoves
    jr z, .loadmoves

    cp FARFETCH_D
    ld hl, SilphCo_FarfetchdMoves
    jr z, .loadmoves

    cp MR__MIME
    ld hl, SilphCo_MrMimeMoves
    jr z, .loadmoves

    cp LICKITUNG
    ld hl, SilphCo_LickitungMoves
    jr z, .loadmoves

    ld hl, SilphCo_ExeggcuteMoves

.loadmoves
    ; First move.
    ld a, [wTempByteValue]
    ld e, a
    ld d, 0
    add hl, de

    ld a, b
    cp TRUE
    ret z

    ld a, [hli]
    ld [wCurSpecies], a

    ld a, MOVE_NAME
    ld [wNamedObjectType], a
	call GetName

    ld de, wStringBuffer1
    push hl
    call CopyName1 ; Copies string buffer 1 into string buffer 2.
    pop hl

    ; Second move.
    ld a, [hl]
    ld [wCurSpecies], a
    call GetName
    ret

_SilphCo_SetMonAttributes:
    ld hl, wPartyMon1Moves
    ld bc, PARTYMON_STRUCT_LENGTH
    ld a, [wPartyCount]
    dec a
    ld [wCurPartyMon], a
    call AddNTimes
    ld d, h
    ld e, l

    ld a, [wTempByteValue]
    ld [wScriptVar], a

    xor a
    ld [wTempByteValue], a

    ld b, TRUE
    push de
    call _LoadSilphCoPokemonMoves
    pop de

    ld bc, 4
    push de
    call CopyBytes ; Copy moves.

    ld h, d
    ld l, e

    ld a, $4d
    ld [hli], a
    ld [hl], $fa ; Trainer ID.
    pop de
    
    ld h, d
    ld l, e
    ld de, MON_DVS - MON_MOVES
    add hl, de

    ld a, ATKDEFDV_SHINY
    ld [hli], a
    ld [hl], SPDSPCDV_SHINY ; Make it shiny.

    ld de, MON_PKRUS - MON_DVS - 1
    add hl, de
    ld [hl], POKERUS_FIRST_SHOT_SIGNATURE + 1 ; Double vaccination.

    ld hl, wPartyMon1OT
    ld bc, NAME_LENGTH
    ld a, [wCurPartyMon]
    call AddNTimes
    ld d, h
    ld e, l

    ld hl, SilphCo_TrainerName
    ld bc, 6
    call CopyBytes ; Copy Silph Co trainer name.

    farcall HealPartyMon ; The stats of the Pokémon need to be recalculated.
    ret

SilphCo_TrainerName:
    db $92, $88, $8B, $8F, $87, $50