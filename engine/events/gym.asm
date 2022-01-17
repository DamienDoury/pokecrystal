OFFSET_FROM_MOVE_TO_PP 		EQU 	20

; Applies special effects to some gym battles.
GymSpecialRules::
	ld a, [wOtherTrainerClass]
	cp BUGSY
	jr nz, .check_clair

	ld hl, wPlayerScreens
	set SCREENS_STICKY_WEB, [hl]
	jr .exit

.check_clair
	ld a, [wOtherTrainerClass]
	cp CLAIR
	jr nz, .check_sabrina

	ld c, 0
	call ExhaustStatusPP

.check_sabrina
	ld a, [wOtherTrainerClass]
	cp SABRINA
	jr nz, .check_blue

	ld c, 1
	call ExhaustStatusPP

.check_blue
.exit
	ret





; Returns true if all Pokémon from the party are Flying type.
CheckAllFlyingTypeParty::
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Species
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

	ld hl, wPartyMon1Species
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
	ld hl, wPartyMon1Species
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
CheckCuteParty::
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Species
	ld de, PARTYMON_STRUCT_LENGTH
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld a, [hl] ; Retrieving the species.
	push de
	push hl
	ld hl, CuteMons ; Getting the array address.
	call IsInByteArray ; Searching for pkmn a in array hl. Returns its index in b, and carry if found.
	pop hl
	pop de
	jr nc, .invalid_party_member

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

.invalid_party_member
	call GetCurNickname
	ld hl, MonNotCuteText
	call PrintText
	ld a, 0
	ld [wScriptVar], a ; Set the return value as FALSE.
	ret

MonNotCuteText:
	text_far _MonNotCuteText
	text_end


; If c equals 0, then it will deplete the Status moves PP, otherwise it will deplete the physical and special moves PP.
ExhaustStatusPP:
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

	; At this point, we have found a physcial or special move.

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
	jp .do_it

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
	jp StdBattleTextbox

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
