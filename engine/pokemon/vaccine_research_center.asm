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
    ld a, [wNewStarterSpecies]
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
    ld a, [wNewStarterMovesIndex]
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
    jmp GetName

_SilphCo_SetMonAttributes:
    ld hl, wPartyMon1Moves
    ld bc, PARTYMON_STRUCT_LENGTH
    ld a, [wPartyCount]
    dec a
    ld [wCurPartyMon], a
    call AddNTimes
    ld d, h
    ld e, l

    xor a
    ld [wNewStarterMovesIndex], a

    ld b, TRUE
    push de
    call _LoadSilphCoPokemonMoves
    pop de

    ld bc, 4
    push de
    call CopyBytes ; Copy moves.

    ld h, d
    ld l, e

    ld a, [wPlayerID]
    cpl
    ld [hli], a
    ld a, [wPlayerID + 1]
    cpl
    ld [hl], a ; Trainer ID.
    pop de
    
    ld h, d
    ld l, e
    ld de, MON_STAT_EXP - MON_MOVES
    add hl, de

    ld a, VITAMIN_STAT_EXP_CAP
    ld [hli], a ; HPExp
    inc hl 
    ld [hli], a ; AtkExp
    inc hl 
    ld [hli], a ; DefExp
    inc hl 
    ld [hli], a ; SpdExp / Speed.
    inc hl 
    ld [hli], a ; SpcExp / Special Attack only, Special Defense is ignored when gaining stat exp.
    inc hl ; We have reached DVs.

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
    ld bc, 8
    call CopyBytes ; Copy Silph Co trainer name.

    farcall HealPartyMon ; The stats of the Pokémon need to be recalculated.
    ret

SilphCo_TrainerName:
if DEF(_FR_FR)
    db "SYLPHE@@"
else
    db "SILPH@@@"
endc

; Input: none.
; Output: [wScriptVar]: 0 if the mon is not within the party, $a if the mon needs more training, $b if more than 50% of the training, $c if >= 100% of the training.
_SilphCo_GetTestSubjectProgress::
    call SilphCoFindTestSubjectInParty
    jp c, CheckTestSubjectProgress

    xor a
    ld [wScriptVar], a ; Return value of FALSE: the test subject wasn't found in the party.
    ret

; Input: none.
; Output: FALSE if non-carry, TRUE if carry and HL = wPartyMon1 + MON_ID + 1 of the found test-subject Pokémon.
SilphCoFindTestSubjectInParty:
    ld a, [wPlayerID]
    cpl
    ld b, a
    ld a, [wPlayerID + 1]
    cpl
    ld c, a ; BC contains the Trainer ID of Silph Co, the one we are looking for.

    ld a, [wPartyCount]
    ld d, a
    ld hl, wPartyMon1ID

.party_loop
    ld a, [hli]
    sub b
    jr nz, .next

    ld a, [hl]
    sub c
    jr nz, .next

    ; We have found the right ID!
    ; There is 1 chance out of 2^16 that another player could have the right ID and trade with the player.
    ; We consider this an edge case, and won't fix the issue.
    ; Even it the bug occured, it would be a very minor issue, unless when speedruning. However, trading is forbidden while speedrunning.
    ; Same opinion if the trainer has more than 1 test subject in its team.

    ld a, [wPartyCount]
    sub d
    ld [wCurPartyMon], a
    scf ; Return TRUE.
    ret

.next
    xor a ; We need to manually unset the carry in case we return FALSE, as "dec" doesn't do it.
    dec d
    ret z ; Return FALSE. We quit once we have reached the last mon in the party.

    push de
    ld de, PARTYMON_STRUCT_LENGTH - 1
    add hl, de
    pop de
    jr .party_loop


; Input: none.
; Output: c if the OT ID and OT Name of the selected mon are those of Silph Co. Returns nc otherwise.
; Works from both the PC and the party menu.
IsTestSubjectForSure::
    ld bc, 8
    ld hl, SilphCo_TrainerName
    ld de, wStringBuffer1
    call CopyBytes ; copy bc bytes from hl to de

    ld a, [wPlayerID]
    cpl
    ld b, a
    ld a, [wPlayerID + 1]
    cpl
    ld c, a ; BC contains the Trainer ID of Silph Co, the one we are looking for.

    ld d, -1 ; species
	ld e, -1 ; level
    farcall BillsPC_CheckSelectedMonOTIDAndName
    ret


; Input: HL= "wPartyMonID + 1" of the Pokémon to check.
; Output: In [wScriptVar]: $a if the mon needs more training, $b if more than 50% of the training, $c if >= 100% of the training.
CheckTestSubjectProgress:
    ld de, MON_STAT_EXP - MON_ID - 1
    add hl, de

    ld b, 5
    xor a

.stat_exp_loop
    add [hl]
    sub VITAMIN_STAT_EXP_CAP
    jr c, .return_max

    inc hl
    inc hl ; We inc HL twice, as we only check the high-weight byte.
    dec b
    jr nz, .stat_exp_loop

    ; Checking the total value.
    ; We consider the average value of a Pokémon's stat is 70 (around Saffron City), which makes an average total base stats of 420 (~Raticate).
    ; We want the player to do 30 battles on average, which represents a gain of 30*70=2100 = $834 per stat exp.
    ; Now that we have doubled the Stat Exp gain, it doubles our result to $834*2 = $1068
    ; There are 5 stat exp, which makes a total of 5 * $1068 = $5208 rounded down to $5200.

    cp $52
    jr nc, .return_max

    cp $3D ; ~= $29 * 74.4%
    jr c, .long_way_to_go

    ; almost done with the training
    ld a, $b
    jr .return

.long_way_to_go
    ld a, $a
    jr .return

.return_max
    ld a, $c
.return
    ld [wScriptVar], a
    ret

; Input: none.
; Output: [wScriptVar] = happiness/friendship of the test subject.
_SilphCo_GetTestSubjectHappiness::
    call SilphCoFindTestSubjectInParty ; Must always return true, as it is only called in scripts when the pokémon has been found in the party before.
    ld de, MON_HAPPINESS - MON_ID - 1
    jr ReturnTestSubjectParam

; Input: HL = wPartyMon1 + MON_ID + 1 of the found test-subject Pokémon.
; Output: [wScriptVar] = happiness/friendship of the test subject.
_SilphCo_GetTestSubjectLevel:
    call SilphCoFindTestSubjectInParty
    ld de, MON_LEVEL- MON_ID - 1    
    ; fallthrough

ReturnTestSubjectParam:
    add hl, de
    ld a, [hl]
    ld [wScriptVar], a
    ret

_SilphCo_TestSubjectRemovedFromParty::
    call SilphCoFindTestSubjectInParty ; Must always return true, as it is only called in scripts when the pokémon has been found in the party before.
DepositCurPartyMon::
    xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
    ret

_SilphCo_PlayerGetsPropertyOfTestSubject::
    call SilphCoFindTestSubjectInParty ; Must always return true, as it is only called in scripts when the pokémon has been found in the party before.
    
    ; Setting the test subject trainer ID to the one of the player.
    dec hl
    ld a, [wPlayerID]
    ld [hli], a
    ld a, [wPlayerID + 1]
    ld [hl], a

    ; Setting the test subject trainer name to the one of the player.
    ld hl, wPartyMonOTs
    ld a, [wCurPartyMon]
    call SkipNames

    ld de, wPlayerName
    call CopyName2 ; Copies the name from de to hl

    ; Copying the name if the test subject into wStringBuffer1.
    jmp GetCurNickname

LanaTrainerName:
if DEF(_FR_FR)
    db "LINA@"
else
    db "LANA@"
endc

SelectScarfTheVaccinatedFurret::
    ld a, -1
    ld [wScriptVar], a

    farcall SelectMonFromParty
    ret c ; We return -1 in wScriptVar if the player cancelled the selection.

    ld a, 2
    ld [wScriptVar], a

    ld bc, 5
    ld hl, LanaTrainerName
    ld de, wStringBuffer1
    call CopyBytes ; copy bc bytes from hl to de

    ld a, HIGH(NPC_OT_ID)
    ld b, a
	ld a, LOW(NPC_OT_ID)
    ld c, a ; BC contains the Trainer ID we are looking for.

    ld d, FURRET ; species
    ld e, -1 ; level
    farcall BillsPC_CheckSelectedMonOTIDAndName.party
    ret nc ; We return 2 in wScriptVar if the Pokemon's identity doesn't match Lana's Furret.

    ld a, 3
    ld [wScriptVar], a

    ld a, [wCurPartyMon]
	ld hl, wPartyMon1PokerusStatus
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

    ld a, [hl]
	and POKERUS_INVERSED_DURATION_MASK
	cp POKERUS_TEST_MASK
	ret nz ; We return 3 in wScriptVar if the Pokemon hasn't been vaccinated at least once.

    ld a, 1
    ld [wScriptVar], a
    ret