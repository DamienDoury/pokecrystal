BeastsCheck:
; Check if the player owns all three legendary beasts.
; They must exist in either party, PC or daycare and have the player's OT and ID.
; Return the result in wScriptVar.

	ld b, CHECK_FLAG
	ld de, EVENT_CAUGHT_RAIKOU
	call EventFlagAction
	jr z, .notexist

	ld de, EVENT_CAUGHT_ENTEI
	call EventFlagAction
	jr z, .notexist

	ld de, EVENT_CAUGHT_SUICUNE
	call EventFlagAction
	jr z, .notexist

	; Player caught all beasts.
	ld a, 1
	ld [wScriptVar], a
	ret

.notexist
	xor a
	ld [wScriptVar], a
	ret

MonCheck:
; Check if the player owns any Pokémon of the species in wScriptVar.
; Return the result in wScriptVar.

	call CheckOwnMonAnywhere
	jr c, .exists

	; doesn't exist
	xor a
	ld [wScriptVar], a
	ret

.exists
	ld a, 1
	ld [wScriptVar], a
	ret

CheckOwnMonAnywhere:
; Check if the player owns any monsters of the species in wScriptVar.
; It must exist in either party or PC, and have the player's OT and ID.

	; If there are no monsters in the party,
	; the player must not own any yet.
	ld a, [wPartyCount]
	and a
	ret z

	ld hl, wBreedMon1Species
	ld bc, wBreedMon1OT
	call CheckOwnMon
	ret c ; found!

	ld hl, wBreedMon2Species
	ld bc, wBreedMon2OT
	call CheckOwnMon
	ret c ; found!

	ld d, a
	ld e, 0
	ld hl, wPartyMon1Species
	ld bc, wPartyMonOTs

	; Run CheckOwnMon on each Pokémon in the party.
.partymon
	call CheckOwnMon
	ret c ; found!

	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	call UpdateOTPointer
	dec d
	jr nz, .partymon

	; Run CheckOwnMon on each Pokémon in the PC.
	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld a, [sBoxCount]
	and a
	jr z, .boxes

	ld d, a
	ld hl, sBoxMon1Species
	ld bc, sBoxMonOTs
.openboxmon
	call CheckOwnMon
	jr nc, .loop

	; found!
	jmp CloseSRAM

.loop
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	call UpdateOTPointer
	dec d
	jr nz, .openboxmon

	; Run CheckOwnMon on each monster in the other 13 PC boxes.
.boxes
	call CloseSRAM

	ld c, 0
.box
	; Don't search the current box again.
	ld a, [wCurBox]
	and $f
	cp c
	jr z, .loopbox

	; Load the box.
	ld hl, SearchBoxAddressTable
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Number of monsters in the box
	ld a, [hl]
	and a
	jr z, .loopbox

	push bc

	push hl
	ld de, sBoxMons - sBoxCount
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push de
	ld de, sBoxMonOTs - sBoxCount
	add hl, de
	ld b, h
	ld c, l
	pop hl

	ld d, a

.boxmon
	call CheckOwnMon
	jr nc, .loopboxmon

	; found!
	pop bc
	jmp CloseSRAM

.loopboxmon
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	call UpdateOTPointer
	dec d
	jr nz, .boxmon
	pop bc

.loopbox
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .box

	; not found
	call CloseSRAM
	and a
	ret

CheckOwnMon:
; Check if a Pokémon belongs to the player and is of a specific species.

; inputs:
; hl, pointer to PartyMonNSpecies
; bc, pointer to PartyMonNOT
; wScriptVar should contain the species we're looking for

; outputs:
; sets carry if monster matches species, ID, and OT name.

	push bc
	push hl
	push de
	ld d, b
	ld e, c

; check species
	ld a, [wScriptVar] ; species we're looking for
	ld b, [hl] ; species we have. Note: unhatched egg species is checked here, which may be unintentional.
	cp b
	jr nz, .notfound ; species doesn't match

; check ID number
	ld bc, MON_ID
	add hl, bc ; now hl points to ID number
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .notfound ; ID doesn't match
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	jr nz, .notfound ; ID doesn't match

; check OT
	ld hl, wPlayerName

rept PLAYER_NAME_LENGTH - 2
	ld a, [de]
	cp [hl]
	jr nz, .notfound
	cp "@"
	jr z, .found ; reached end of string
	inc hl
	inc de
endr

	ld a, [de]
	cp [hl]
	jr z, .found

.notfound
	pop de
	pop hl
	pop bc
	and a
	ret

.found
	pop de
	pop hl
	pop bc
	scf
	ret

SearchBoxAddressTable:
	table_width 3, SearchBoxAddressTable
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14
	assert_table_length NUM_BOXES

UpdateOTPointer:
	push hl
	ld hl, NAME_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ret
