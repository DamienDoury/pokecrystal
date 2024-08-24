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
	ld a, [hl]

	push hl
	call CanLearnTMHMMove.skip_start
	pop hl
	ld a, c

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
