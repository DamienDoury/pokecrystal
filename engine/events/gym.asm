OFFSET_FROM_MOVE_TO_PP 		EQU 	20

; Applies special effects to some gym battles.
GymSpecialRules::
	ld a, [wOtherTrainerClass]
	cp BUGSY
	jr nz, .check_clair

	ld hl, wPlayerScreens
	set SCREENS_STICKY_WEB, [hl]
	ret

.check_clair
	ld a, [wOtherTrainerClass]
	cp CLAIR
	jr nz, .check_sabrina

	ld c, 0
	jmp ExhaustMovesPP

.check_sabrina
	ld a, [wOtherTrainerClass]
	cp SABRINA
	jr nz, .check_chuck

	ld c, 1
	jmp ExhaustMovesPP

.check_chuck
	ld a, [wOtherTrainerClass]
	cp CHUCK
	ret nz

;ExhaustBatonPassPP:
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Moves
	ld de, PARTYMON_STRUCT_LENGTH
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld b, 0 ; This represents the index of the move.
	push hl

.next_move
	ld a, b
	cp 4
	jr z, .next_party_mon ; Once we have checked all four moves (index 0 to 3), we go to the next mon.

	ld a, [hl] ; Retrieving the first move.
	cp 0
	jr z, .next_party_mon ; If this mon has no more moves, we move on to the next mon.

	inc hl
	inc b
	
	cp BATON_PASS
	jr nz, .next_move ; If the move is not Baton Pass, we check the next move.

	; At this point, we have found baton Pass.

.deplete_pp
	push hl
	push de
	ld de, OFFSET_FROM_MOVE_TO_PP
	add hl, de
	ld [hl], 0 ; We exhaust the PP.
	pop de
	pop hl

	jr .next_move

.next_party_mon
	pop hl
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z ; We exit when we reach the last pkmn.

	ld [wCurPartyMon], a
	add hl, de
	jr .analyze_mon


; Returns true if all Pokémon from the party are Flying type.
CheckAllFlyingTypeParty::
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Species ; TODO: use wPartySpecies instead. Like in CheckCuteParty.
	ld de, PARTYMON_STRUCT_LENGTH
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld a, [hl] ; Retrieving the species.
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wBaseType2] ; The flying type is always the secondary type.
	cp FLYING
	jr z, .next_party_mon

	; Invalid party member.
	xor a
	ld [wScriptVar], a ; Set the return value as FALSE.
	ret

.next_party_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z ; We exit when we reach the last pkmn.

	ld [wCurPartyMon], a
	add hl, de
	jr .analyze_mon
	




; Returns true if all Pokémon from the party are Flying or Water type.
CheckAllFlyingOrWaterTypeParty::
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Species ; TODO: use wPartySpecies instead. Like in CheckCuteParty.
	ld de, PARTYMON_STRUCT_LENGTH
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld a, [hl] ; Retrieving the species.
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wBaseType2] ; The flying type is always the secondary type.
	cp FLYING
	jr z, .next_party_mon

	cp WATER
	jr z, .next_party_mon

	ld a, [wBaseType1]
	cp WATER
	jr z, .next_party_mon

	; Invalid party member.
	xor a
	ld [wScriptVar], a ; Set the return value as FALSE.
	ret

.next_party_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z ; We exit when we reach the last pkmn.

	ld [wCurPartyMon], a
	add hl, de
	jr .analyze_mon


; Returns true if there is at least 1 Pokémon of the type in passed in wScriptVar.
CheckTypePresenceInParty::
	ld hl, wPartyMon1Species ; TODO: use wPartySpecies instead. Like in CheckCuteParty.
	ld de, PARTYMON_STRUCT_LENGTH

	ld a, [wScriptVar] ; We retrieve the type to check, passed as a parameter from the script.
	ld c, a ; We store the type to check in the register c.
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld a, [hl] ; Retrieving the species.
	ld [wCurSpecies], a
	call GetBaseData

	ld a, [wBaseType1]
	cp c
	jr z, .invalid_party_member

	ld a, [wBaseType2]
	cp c
	jr z, .invalid_party_member

.next_party_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, .team_is_ok ; We exit when we reach the last pkmn.

	ld [wCurPartyMon], a
	add hl, de
	jr .analyze_mon

.invalid_party_member
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.
	ret

.team_is_ok
	xor a
	ld [wScriptVar], a ; Set the return value as FALSE.
	ret





; Check if all pokemons in the party are considered cute (non-evolved except if prior evolution is a baby pokemon, less than 1m/3"3' except for pink pkmn that can be up to 1.2m/3"11')
;CheckCuteParty::
;	ld a, 1
;	ld [wScriptVar], a ; Sets the return value as TRUE.
;
;	ld hl, wPartyMon1Species
;	ld de, PARTYMON_STRUCT_LENGTH
;	xor a
;	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)
;
;.analyze_mon
;	ld a, [hl] ; Retrieving the species.
;	push de
;	push hl
;	ld hl, CuteMons ; Getting the array address.
;	call IsInByteArray ; Searching for pkmn a in array hl. Returns its index in b, and carry if found.
;	pop hl
;	pop de
;	jr nc, .invalid_party_member
;
;.next_party_mon
;	ld a, [wPartyCount]
;	ld b, a
;	ld a, [wCurPartyMon]
;	inc a
;	cp b
;	ret z ; We exit when we reach the last pkmn.
;
;	ld [wCurPartyMon], a
;	add hl, de
;	jr .analyze_mon
;
;.invalid_party_member
;	call GetCurNickname
;	ld hl, MonNotCuteText
;	call PrintText
;	ld a, 0
;	ld [wScriptVar], a ; Set the return value as FALSE.
;	ret

CheckCuteParty::
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	dec a ; A = 0. "dec a" is more efficient than "LD r8,n8".
	ld [wNotCuteCount], a

	dec a ; A = -1. "dec a" is more efficient than "LD r8,n8".
	ld hl, wNotCuteSpecies
	ld d, PARTY_LENGTH + 1
.clear_array_loop
	ld [hli], a
	dec d
	jr nz, .clear_array_loop

	ld hl, wPartySpecies
	ld bc, wNotCuteSpecies

.analyze_next_mon
	ld a, [hli] ; Retrieving the species.
	cp $ff
	jr z, .uncute_list_completed

	push hl
	push bc
	ld hl, CuteMons ; Getting the array address.
	call IsInByteArray ; Searching for pkmn a in array hl. Returns its index in b, and carry if found.
	pop bc
	pop hl
	jr c, .analyze_next_mon

	; We add the current species to the list of "uncute" mons.
	dec hl
	ld a, [hli]
	ld [bc], a
	inc bc

	; Increase the count.
	ld a, [wNotCuteCount]
	inc a
	ld [wNotCuteCount], a
	jr .analyze_next_mon

.uncute_list_completed
	ld a, LOW(wNotCuteSpecies)
	cp c ; This works because the list has less than 256 elements.
	ret z ; If the cute list index has never been increased, it means we found no "uncute" mon. Therefore, we return true.

; Print the list.
	ld hl, MonNotCuteText
	call PrintText	

	ld hl, wNotCuteSpecies
	call .get_next_one_name

	ld a, [wNotCuteCount]
	and a
	cp 1
	jr z, .single

; first mon
	push hl
	ld hl, MonNotCuteInstanceFirstText
	call PrintText
	pop hl

.next_print
	ld a, [wNotCuteCount]
	dec a
	ld [wNotCuteCount], a
	cp 1
	jr z, .last_one

	cp 2
	jr z, .last_two

; next two.
	ld a, [wNotCuteCount]
	dec a
	ld [wNotCuteCount], a

	call .get_next_two_names
	push hl
	ld hl, MonNotCuteInstance2Text
	call PrintText
	pop hl
	jr .next_print

.single
	ld hl, MonNotCuteInstanceSingleText
	call PrintText
	jr .bye

.last_one
	call .get_next_one_name
	ld hl, MonNotCuteInstanceLast1Text
	call PrintText
	jr .bye

.last_two
	call .get_next_two_names
	ld hl, MonNotCuteInstanceLast2Text
	call PrintText

.bye
	ld hl, MonNotCuteEndText
	call PrintText

.return_false
	xor a
	ld [wScriptVar], a ; Set the return value as FALSE.
	ret

.get_next_two_names
	ld a, [hli]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	push hl
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, MON_NAME_LENGTH
	call CopyBytes ; copy bc bytes from hl to de
	pop hl

.get_next_one_name
	ld a, [hli]
	ld [wNamedObjectIndex], a
	jmp GetPokemonName ; Preserves HL.

MonNotCuteText:
	text_far _MonNotCuteText
	text_end

MonNotCuteInstanceSingleText:
	text_far _MonNotCuteInstanceSingleText
	text_end

MonNotCuteInstanceFirstText:
	text_far _MonNotCuteInstanceFirstText
	text_end

MonNotCuteInstance2Text:
	text_far _MonNotCuteInstance2Text
	text_end

MonNotCuteInstanceLast1Text:
	text_far _MonNotCuteInstanceLast1Text
	text_end

MonNotCuteInstanceLast2Text:
	text_far _MonNotCuteInstanceLast2Text
	text_end

MonNotCuteEndText:
	text_far _MonNotCuteEndText
	text_end


; If c equals 0, then it will deplete the Status moves PP, otherwise it will deplete the physical and special moves PP.
ExhaustMovesPP:
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Moves
	ld de, PARTYMON_STRUCT_LENGTH
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld b, 0 ; This represents the index of the move.
	push hl

.next_move
	ld a, b
	cp 4
	jr z, .next_party_mon ; Once we have checked all four moves (index 0 to 3), we go to the next mon.

	ld a, [hl] ; Retrieving the first move.
	cp 0
	jr z, .next_party_mon ; If this mon has no more moves, we move on to the next mon.

	; Retrieving the move type attribute.
	ldh [hRandomAdd], a
	push hl
	push bc
	callfar GetMoveCategory
	pop bc
	pop hl

	inc hl
	inc b

	ld a, c
	cp 0
	ldh a, [hRandomAdd]
	jr nz, .check_phy_or_spe_move

; check_status_move
	cp STATUS
	jr nz, .next_move ; If the move is not a status move, we check the next move.

	; At this point, we have found a status move.
	jr .deplete_pp

.check_phy_or_spe_move
	cp STATUS
	jr z, .next_move ; If the move is not a status move, we check the next move.

	; At this point, we have found a physical or special move.

.deplete_pp
	push hl
	push de
	ld de, OFFSET_FROM_MOVE_TO_PP
	add hl, de
	ld [hl], 0 ; We exhaust the PP.
	pop de
	pop hl

	jr .next_move

.next_party_mon
	pop hl
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z ; We exit when we reach the last pkmn.

	ld [wCurPartyMon], a
	add hl, de
	jr .analyze_mon

INCLUDE "data/pokemon/cute.asm" ; Array of cute pokemons. Note: using an array is as fast and uses as much memory as coding the logic for a conditional check with the pokedex data.


; Called from engine/battle/core.asm which is full.
_HandleGrassyTerrain::
	ld a, [wOtherTrainerClass]
	cp ERIKA
	ret nz ; Only works in the battle against Erika.

	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .DoEnemyFirst
	call SetPlayerTurn
	call .do_it
	call SetEnemyTurn
	jr .do_it

.DoEnemyFirst:
	call SetEnemyTurn
	call .do_it
	call SetPlayerTurn
.do_it
	ld hl, wBattleMonHP
	ld de, wBattleMonType2
	ldh a, [hBattleTurn]
	and a
	jr z, .got_mon
	ld hl, wEnemyMonHP
	ld de, wEnemyMonType2

.got_mon
; Don't affect Flying type Pokémons.
	ld a, [de]
	cp FLYING
	ret z

; Affect only Grass types.
	ld a, [de]
	cp GRASS
	jr z, .check_invulnerable

	dec de

	ld a, [de]
	cp GRASS
	ret nz

.check_invulnerable
; Don't affect Pokémons in the semi-invulnerable turn of a move.
; Note: the only 2 moves concerned in this gen are Fly and Dig.
; No grass type Pokémon can learn Fly.
; The only grass type Pokemon that can learn Dig is Parasect. We won't check for Dig, we can deal with that. Plus we can say there is Grass even underground!

; Don't restore if we're already at max HP
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	jr nz, .restore
	ld a, [hl]
	cp c
	ret z

.restore
	farcall GetEighthMaxHP
	farcall SwitchTurnCore
	farcall RestoreHP
	ld hl, BattleText_RecoveredWithGrassyTerrain
	jmp StdBattleTextbox

; Lt. Surge has a 25% boost to its damaging Electric type attacks, as part of its SUPERCHARGED challenge.
; The power of the move is stored in d, and is for sure above 0.
HandleLtSurgeBoost::
	ld a, [wOtherTrainerClass]
	cp LT_SURGE
	ret nz

	ld hl, wEnemyMoveStructType
	ld a, [hl]
	and TYPE_MASK
	cp ELECTRIC
	ret nz

	ld a, d
	srl a
	srl a
	add d
	ld d, a
	ret
