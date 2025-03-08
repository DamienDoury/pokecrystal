CanLearnTMHMMove:
	ld a, [wCurPartySpecies]
.skip_start
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBaseTMHM
	push hl

	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, 0
	ld hl, TMHMMoves
.loop
	ld a, [hli]
	and a
	jr z, .end
	cp b
	jr z, .found
	inc c
	jr .loop

.found
	pop hl
	ld b, CHECK_FLAG
	push de
	ld d, 0
	predef SmallFarFlagAction
	pop de
	ret

.end
	pop hl
	ld c, 0
	ret

GetTMHMMove:
	ld a, [wTempTMHM]
	dec a
	ld hl, TMHMMoves
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTempTMHM], a
	ret

; Input: Move ID in wPutativeTMHMMove.
; Output: TRUE of FALSE in wScriptVar.
; Note: if the Pokémon knows 4 HMs, he can technically learn the move in input but won't be able to if the player is stranded on an island.
CanAtLeastOnePartyMemberLearnTMHMMove::
	xor a ; FALSE
	ld [wScriptVar], a

	ld a, [wPartyCount]
	and a
	ret z ; Return if party is empty.

	ld b, a ; Save the number of remaining party members to check in B.
	ld hl, wPartyMon1Species
	
.next
	push bc
	
	call KnowsOrHasRoomForTM

	push af ; Saves the results of KnowsOrHasRoomForTM.
	ld a, [hl]
	push hl
	call CanLearnTMHMMove.skip_start
	pop hl
	pop af
	and c ; Combines the results of KnowsOrHasRoomForTM (stored in A) and CanLearnTMHMMove (stored in C) into A.

	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc

	and a
	jr nz, .yes

	dec b
	ret z

	jr .next

.yes
	ld a, TRUE
	ld [wScriptVar], a
	ret


INCLUDE "data/moves/tmhm_moves.asm"

; Input: Move ID in wPutativeTMHMMove.
; Output: -1 in A if the Pokémon has room to learn (or already knows) the move given in input. 0 otherwise.
; Clobbers BC.
KnowsOrHasRoomForTM:
	push hl
	ld bc, MON_MOVES - MON_SPECIES
	add hl, bc
	ld b, 4
.movepool_loop
	ld a, [wPutativeTMHMMove]
	cp [hl]
	jr z, .return_true ; The Pokémon already knows the move.

	push hl
	push bc
	ld a, [hl]
	call IsHMMove ; Also discards NO_MOVE.
	pop bc
	pop hl
	jr nc, .return_true ; If the move is not an HM, it means the Pokémon has room for a new move, so we return true.

	inc hl
	dec b
	jr nz, .movepool_loop

; return false.
	pop hl
	xor a
	ret

.return_true
	pop hl
	ld a, -1
	ret
