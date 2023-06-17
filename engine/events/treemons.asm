TreeMonEncounter:
	farcall StubbedTrainerRankings_TreeEncounters

	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a

	ld hl, TreeMonMaps
	call GetTreeMonSet
	jr nc, .no_battle

	call GetTreeMon
	jr nc, .no_battle

	ld a, [wCurPartyLevel]
	ld c, a
	call Random
	and 3
	add c
	ld [wCurPartyLevel], a

	ld a, BATTLETYPE_TREE
	ld [wBattleType], a
	ld a, 1
	ld [wScriptVar], a
	ret

.no_battle
	xor a
	ld [wScriptVar], a
	ret

RockMonEncounter:
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a

	ld hl, RockMonMaps
	call GetTreeMonSet
	jr nc, .no_battle

	call GetTreeMon
	jr nc, .no_battle

	ld a, $ff
	ld [wAssaultBattle], a

	scf
	ret

.no_battle
	xor a
	ret

GetTreeMonSet:
; Return carry and treemon set in a
; if the current map is in table hl.
	ld a, [wMapNumber]
	ld e, a
	ld a, [wMapGroup]
	ld d, a
.loop
	ld a, [hli]
	cp -1
	jr z, .not_in_table

	cp d
	jr nz, .skip2

	ld a, [hli]
	cp e
	jr nz, .skip1

	jr .in_table

.skip2
	inc hl
.skip1
	inc hl
	inc hl
	jr .loop

.not_in_table
	xor a
	ret

.in_table
	; Get temp treemon.
	ld a, [hli]
	ld [wTempWildMonSpecies], a
	ld a, [hl]
	ld [wCurPartyLevel], a
	scf
	ret

INCLUDE "data/wild/treemon_maps.asm"

GetTreeMon:
	push hl
	call GetTreeScore
	pop hl
	and a ; TREEMON_SCORE_BAD
	jr z, NoTreeMon

	; TREEMON_SCORE_GOOD
	scf
	ret

NoTreeMon:
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a
	ret

GetTreeScore:
	call .CoordScore
	cp 3
	jr c, .good

; bad
	xor a ; TREEMON_SCORE_BAD
	ret

.good
	ld a, TREEMON_SCORE_GOOD
	ret

.CoordScore:
	call GetFacingTileCoord
	ld hl, 0
	ld c, e
	ld b, 0
	ld a, d

	and a
	jr z, .next
.loop
	add hl, bc
	dec a
	jr nz, .loop
.next

	add hl, bc
	ld c, d
	add hl, bc

	ld a, h
	ldh [hDividend], a
	ld a, l
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide

	ldh a, [hQuotient + 2]
	ldh [hDividend], a
	ldh a, [hQuotient + 3]
	ldh [hDividend + 1], a
	ld a, 10
	ldh [hDivisor], a
	ld b, 2
	call Divide

	ldh a, [hRemainder]
	ret
