KnowsMove:
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .KnowsMoveText
	call PrintText
	scf
	ret

.KnowsMoveText:
	text_far _KnowsMoveText
	text_end

; Output: nc if a partymon knows Surf. Index in wCurPartyMon.
; Returns a surfing Pikachu in priority, otherwise a regular surfer, otherwise carry.
FindBestSurfer::
	ld e, 0
	xor a
	ld [wCurPartyMon], a
.loop
	ld c, e
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no

	cp -1
	jr z, .no

	cp PIKACHU
	jr nz, .next

	ld c, SURF
	push de
	farcall CheckPokemonAlreadyKnowsMove
	pop de
	jr c, .yes

.next
	inc e
	ld a, e
	ld [wCurPartyMon], a
	jr .loop

.yes
	ld a, e
	ld [wCurPartyMon], a ; which mon has the move
	xor a
	ret

.no
	ld d, SURF
	farcall CheckPartyMove
	ret