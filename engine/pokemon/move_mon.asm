NPC_OT_ID EQU 01001

UpdatePartyStats::
	ld a, -1
	ld c, -1
	ld hl, wPartySpecies - 1

.party_loop
	inc c
	inc hl
	ld a, [hl]
	and a
	ret z ; end loop.

	cp -1
	ret z ; end loop.

	cp EGG
	jr z, .party_loop ; next iteration.

	push bc
	push hl

	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData ; doesn't clobber BC.

	ld a, c
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Level
	call AddNTimes
	ld a, [hl]
	ld [wCurPartyLevel], a	

	ld de, MON_MAXHP - MON_LEVEL
	add hl, de
	ld d, h
	ld e, l
	ld b, [hl]
	inc hl
	ld c, [hl]
	dec hl
	push bc ; We save the current Max HP value (little-endian).

	ld bc, (MON_STAT_EXP - 1) - MON_MAXHP ; This also set B to non-zero.
	add hl, bc

	call CalcMonStats ; B needs to be != 0 for the Stat Exp to be accounted. Doesn't clobber HL.
	pop bc ; We retrieve the previous max HP value (little-endian).

	; When the Pokémon gains Max HP, we want it current HP to increase by the same amount.
	ld a, c
	cpl
	ld c, a
	ld a, b
	cpl
	ld b, a
	inc bc ; BC = -previous Max HP (little-endian).
	
	ld de, MON_MAXHP - (MON_STAT_EXP - 1) ; This also set B to non-zero.
	add hl, de ; HL points to the current Max HP address.
	ld d, h
	ld e, l
	dec de ; DE points to the current Cur HP + 1 address.

	ld a, [hli]
	ld l, [hl]
	ld h, a ; HL contains the current value Max HP value (little endian).
	add hl, bc ; HL contains the Max HP gain (little endian).

	ld b, h
	ld c, l ; BC contains the Max HP gain (little endian).

	ld h, d
	ld l, e ; HL points to the Cur HP + 1 address.
	
	ld a, [hld]
	ld h, [hl]
	ld l, a ; HL contains the current Cur HP value (little endian).
	add hl, bc ; HL contains the updated Cur HP value (little endian).
	ld b, h
	ld a, l ; BA contains the updated Cur HP value (little endian).

	ld h, d
	ld l, e ; HL points to the Cur HP + 1 address.

	ld [hld], a
	ld [hl], b ; The Cur HP value has been written into the Pokémon's data structure (big-endian).
	
	pop hl
	pop bc
	jr .party_loop

TryAddMonToParty:
; Check if to copy wild mon or generate a new one
	; Whose is it?
	ld de, wPartyCount
	ld a, [wMonType]
	and $f
	jr z, .getpartylocation ; PARTYMON
	ld de, wOTPartyCount

.getpartylocation
	; Do we have room for it?
	ld a, [de]
	inc a
	cp PARTY_LENGTH + 1
	ret nc
	; Increase the party count
	ld [de], a
	ld a, [de] ; Why are we doing this?
	ldh [hMoveMon], a ; HRAM backup
	add e
	ld e, a
	jr nc, .loadspecies
	inc d

.loadspecies
	; Load the species of the Pokemon into the party list.
	; The terminator is usually here, but it'll be back.
	ld a, [wCurPartySpecies]
	ld [de], a
	; Load the terminator into the next slot.
	inc de
	ld a, -1
	ld [de], a
	; Now let's load the OT name.
	ld hl, wPartyMonOTs
	ld a, [wMonType]
	and $f
	jr z, .loadOTname
	ld hl, wOTPartyMonOTs

.loadOTname
	ldh a, [hMoveMon] ; Restore index from backup
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes
	; Only initialize the nickname for party mon
	ld a, [wMonType]
	and a
	jr nz, .skipnickname
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wPartyMonNicknames
	ldh a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.skipnickname
	ld hl, wPartyMon1Species
	ld a, [wMonType]
	and $f
	jr z, .initializeStats
	ld hl, wOTPartyMon1Species

.initializeStats
	ldh a, [hMoveMon]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
GeneratePartyMonStats:
; wBattleMode specifies whether it's a wild mon or not.
; wMonType specifies whether it's an opposing mon or not.
; wCurPartySpecies/wCurPartyLevel specify the species and level.
; hl points to the wPartyMon struct to fill.

	ld e, l
	ld d, h
	push hl

	; Initialize the species
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wBaseDexNo]
	ld [de], a
	inc de

	; Copy the item if it's a wild mon
	ld a, [wBattleMode]
	and a
	ld a, $0
	jr z, .skipitem
	ld a, [wEnemyMonItem]
.skipitem
	ld [de], a
	inc de

	; Copy the moves if it's a wild mon
	push de
	ld h, d
	ld l, e
	ld a, [wBattleMode]
	and a
	jr z, .randomlygeneratemoves
	ld a, [wMonType]
	and a
	jr nz, .randomlygeneratemoves
	ld de, wEnemyMonMoves
rept NUM_MOVES - 1
	ld a, [de]
	inc de
	ld [hli], a
endr
	ld a, [de]
	ld [hl], a
	jr .next

.randomlygeneratemoves
	xor a
rept NUM_MOVES - 1
	ld [hli], a
endr
	ld [hl], a
	ld [wSkipMovesBeforeLevelUp], a
	predef FillMoves

.next
	pop de
rept NUM_MOVES
	inc de
endr

	; Initialize ID.
	ld a, [wPlayerID]
	ld [de], a
	inc de
	ld a, [wPlayerID + 1]
	ld [de], a
	inc de

	; Initialize Exp.
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	callfar CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de

	; Initialize stat experience.
	xor a
	ld b, MON_DVS - MON_STAT_EXP
.loop
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	pop hl
	push hl
	ld a, [wMonType]
	and $f
	jr z, .registerpokedex

	push hl
	farcall GetTrainerDVs
	pop hl
	jr .initializeDVs

.registerpokedex
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	dec a
	push de
	call CheckCaughtMon
	ld a, [wTempSpecies]
	dec a
	call SetSeenAndCaughtMon
	pop de

	pop hl
	push hl
	ld a, [wBattleMode]
	and a
	jr nz, .copywildmonDVs

	call Random
	ld b, a
	call Random
	ld c, a
.initializeDVs
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	inc de

	; Initialize PP.
	push hl
	push de
	inc hl
	inc hl
	call FillPP
	pop de
	pop hl
rept NUM_MOVES
	inc de
endr

	; Initialize happiness.
	ld a, [wMonType]
	and $f
	ld a, BASE_HAPPINESS
	jr z, .got_happiness
	ld a, $ff ; max happiness for enemy trainers
.got_happiness
	ld [de], a
	inc de

	xor a
	; PokerusStatus
	ld [de], a
	inc de
	; CaughtData/CaughtTime/CaughtLevel
	ld [de], a
	inc de
	; CaughtGender/CaughtLocation
	ld [de], a
	inc de

	; Initialize level.
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de

	xor a
	; Status
	ld [de], a
	inc de
	; Unused
	ld [de], a
	inc de

	; Initialize HP.
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld a, 1
	ld c, a
	ld b, FALSE
	call CalcMonStatC
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	jr .initstats

.copywildmonDVs
	ld a, [wEnemyMonDVs]
	ld [de], a
	inc de
	ld a, [wEnemyMonDVs + 1]
	ld [de], a
	inc de

	push hl
	ld hl, wEnemyMonPP
	ld b, NUM_MOVES
.wildmonpploop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .wildmonpploop
	pop hl

	; Initialize happiness.
	ld a, BASE_HAPPINESS
	ld [de], a
	inc de

	xor a
	; PokerusStatus
	ld [de], a
	inc de
	; CaughtData/CaughtTime/CaughtLevel
	ld [de], a
	inc de
	; CaughtGender/CaughtLocation
	ld [de], a
	inc de

	; Initialize level.
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de

	ld hl, wEnemyMonStatus
	; Copy wEnemyMonStatus
	ld a, [hli]
	ld [de], a
	inc de
	; Copy EnemyMonUnused
	ld a, [hli]
	ld [de], a
	inc de
	; Copy wEnemyMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de

.initstats
	ld a, [wBattleMode]
	dec a
	jr nz, .generatestats
	ld hl, wEnemyMonMaxHP
	ld bc, PARTYMON_STRUCT_LENGTH - MON_MAXHP
	call CopyBytes
	pop hl
	jr .registerunowndex

.generatestats
	pop hl
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld b, FALSE
	call CalcMonStats

.registerunowndex
	ld a, [wMonType]
	and $f
	jr nz, .done
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .done
	ld hl, wPartyMon1DVs
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	predef GetUnownLetter
	callfar UpdateUnownDex

.done
	scf ; When this function returns, the carry flag indicates success vs failure.
	ret

FillPP:
	push bc
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .next
	dec a
	push hl
	push de
	push bc
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop de
	pop hl
	ld a, [wStringBuffer1 + MOVE_PP]

.next
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop bc
	ret

AddTempmonToParty:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	scf
	ret z

	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartySpecies]
	ld [hli], a
	ld [hl], $ff

	ld hl, wPartyMon1Species
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wTempMonSpecies
	call CopyBytes

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOTs
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	cp EGG
	jr z, .egg
	dec a
	call SetSeenAndCaughtMon
	ld hl, wPartyMon1Happiness
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld [hl], BASE_HAPPINESS
.egg

	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .done
	ld hl, wPartyMon1DVs
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	predef GetUnownLetter
	callfar UpdateUnownDex
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .done
	ld a, [wUnownLetter]
	ld [wFirstUnownSeen], a
.done

	and a
	ret

SendGetMonIntoFromBox:
; Sends/Gets mon into/from Box depending on Parameter
; wPokemonWithdrawDepositParameter == 0: get mon from Box (into party).
; wPokemonWithdrawDepositParameter == 1: sent mon into Box
; wPokemonWithdrawDepositParameter == 2: get mon from DayCare
; wPokemonWithdrawDepositParameter == 3: put mon into DayCare
; wPokemonWithdrawDepositParameter == 4: get mon from Hospital Box
; wPokemonWithdrawDepositParameter == 5: put mon into Hospital Box


; # START BLOCK
	ld a, [wPokemonWithdrawDepositParameter]
	cp HOSPITAL_WITHDRAW
	jr c, .normalBoxBank
	ld a, BANK(sHospitalBoxCount)
	jr .predefinedBank

.normalBoxBank
	ld a, BANK(sBoxCount)
.predefinedBank
	call OpenSRAM
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp PC_WITHDRAW
	jr z, .check_IfPartyIsFull
	cp DAY_CARE_WITHDRAW
	jr z, .check_IfPartyIsFull
	cp HOSPITAL_WITHDRAW
	jr z, .check_IfPartyIsFull
	cp DAY_CARE_DEPOSIT
	ld hl, wBreedMon1Species
	jr z, .destinationDataFound

	; we want to sent a mon into the Box
	; so check if there's enough space
	cp PC_DEPOSIT
	jr z, .activeBox

	ld hl, sHospitalBoxCount
	jr .predefinedBox ; HOSPITAL_DEPOSIT

.activeBox
	ld hl, sBoxCount
.predefinedBox
	ld a, [hl]
	cp MONS_PER_BOX
	jr c, .there_is_room
	jmp CloseSRAM_And_SetCarryFlag

.check_IfPartyIsFull
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jp z, CloseSRAM_And_SetCarryFlag

.there_is_room
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	cp DAY_CARE_WITHDRAW
	ld a, [wBreedMon1Species]
	jr z, .okay1
	ld a, [wCurPartySpecies]

.okay1
	ld [hli], a
	ld [hl], $ff
	ld a, [wPokemonWithdrawDepositParameter]
	and 1
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	jr z, .okay2 ; To reach this line, wPokemonWithdrawDepositParameter must be in mode 0, 1, 2, 4, or 5 (3 excluded). Mode number mod 2 are modes 0, 2, and 4. All those modes try to get a mon into the team.

	ld bc, BOXMON_STRUCT_LENGTH ; This value is common to modes 1 and 5.
	ld a, [wPokemonWithdrawDepositParameter]
	cp HOSPITAL_DEPOSIT
	jr z, .hospitalDeposit1 ; Mode 5 jumps to .hospitalDeposit1.

	; At this point, we have eliminated modes 3, then 0, 2, 4, and finally 5. This that we are into mode 1.
	ld hl, sBoxMon1Species
	ld a, [sBoxCount]
	jr .okay2

.hospitalDeposit1
	ld hl, sHospitalBoxMon1Species
	ld a, [sHospitalBoxCount]

.okay2 ; Here, we are trying to get a Pokemon into the party.
	dec a ; wPartyCount - 1
	call AddNTimes

; Here, hl points to the destination of the Pokémon.
; Now we start looking for the source Pokémon data address.
.destinationDataFound
	push hl
	ld e, l
	ld d, h
	ld a, [wPokemonWithdrawDepositParameter]

	ld bc, BOXMON_STRUCT_LENGTH ; This value is common to modes 0, 2 and 4.

	ld hl, sBoxMon1Species
	cp PC_WITHDRAW
	jr z, .okay3 ; If mode 0 (get mon from Box), jump to okay3.
	
	ld hl, sHospitalBoxMon1Species
	cp HOSPITAL_WITHDRAW
	jr z, .okay3 ; If mode 4 (get mon from Box), jump to okay4. Note that we do not jump to okay3, as we always withdraw the first mon from the hospital bank.

	cp DAY_CARE_WITHDRAW
	ld hl, wBreedMon1Species
	jr z, .okay4

	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH

.okay3
	ld a, [wCurPartyMon]
	call AddNTimes

.okay4
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes ; The Pokémon is TRANSFERED HERE!

	ld a, [wPokemonWithdrawDepositParameter]
	cp DAY_CARE_DEPOSIT
	ld de, wBreedMon1OT
	jr z, .okay5 ; Mode 3 jumps to okay5.

	cp PC_DEPOSIT
	ld hl, sBoxMonOTs
	ld a, [sBoxCount]
	jr z, .okay6 ; Mode 1 jumps to okay6.

	ld a, [wPokemonWithdrawDepositParameter]
	cp HOSPITAL_DEPOSIT
	ld hl, sHospitalBoxMonOTs
	ld a, [sHospitalBoxCount]
	jr z, .okay6  ; Mode 5 jumps to okay6.

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	; Modes 0, 2 and 4 jump fall through okay6.

.okay6
	dec a
	call SkipNames
	ld d, h
	ld e, l

; At this point, we have the destination address for OT name in de. 
; We start looking for the source address of OT name.
.okay5
	ld a, [wPokemonWithdrawDepositParameter]

	ld hl, sBoxMonOTs
	cp PC_WITHDRAW
	jr z, .okay7

	ld hl, sHospitalBoxMonOTs
	cp HOSPITAL_WITHDRAW
	jr z, .okay7

	ld hl, wBreedMon1OT
	cp DAY_CARE_WITHDRAW
	jr z, .okay8

	ld hl, wPartyMonOTs ; Modes 1, 3 and 5 (deposit modes) fall through okay7.

.okay7
	ld a, [wCurPartyMon]
	call SkipNames

.okay8
	ld bc, NAME_LENGTH
	call CopyBytes

	ld a, [wPokemonWithdrawDepositParameter]
	ld de, wBreedMon1Nickname
	cp DAY_CARE_DEPOSIT
	jr z, .okay9 ; Mode 3 jumps to okay9.

	cp PC_DEPOSIT
	ld hl, sBoxMonNicknames
	ld a, [sBoxCount]
	jr z, .okay10 ; Mode 1 jumps to okay10.

	ld a, [wPokemonWithdrawDepositParameter]
	cp HOSPITAL_DEPOSIT
	ld hl, sHospitalBoxMonNicknames
	ld a, [sHospitalBoxCount]
	jr z, .okay10 ; Mode 5 jumps to okay10.

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount] ; Modes 0, 2 and 4 (withdraw modes) fall through okay10.	

.okay10
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay9
	ld a, [wPokemonWithdrawDepositParameter]

	ld hl, sBoxMonNicknames
	cp PC_WITHDRAW
	jr z, .okay11

	ld hl, sHospitalBoxMonNicknames
	cp HOSPITAL_WITHDRAW
	jr z, .okay11

	ld hl, wBreedMon1Nickname
	cp DAY_CARE_WITHDRAW
	jr z, .okay12

	ld hl, wPartyMonNicknames ; Deposit modes (modes 1, 3, 5).

.okay11
	ld a, [wCurPartyMon]
	call SkipNames

.okay12
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl

	ld a, [wPokemonWithdrawDepositParameter]
	cp PC_DEPOSIT
	jr z, .deposited_into_box
	cp HOSPITAL_DEPOSIT
	jr z, .deposited_into_box
	cp DAY_CARE_DEPOSIT
	jp z, .CloseSRAM_And_ClearCarryFlag

	push hl
	add 1
	cp HOSPITAL_WITHDRAW + 1
	jr z, .montype_is_determined ; wMonType will be HOSPITALMON

	sub 1
	srl a
	add $2

.montype_is_determined
	ld [wMonType], a
	predef CopyMonToTempMon
	callfar CalcLevel
	ld a, d
	ld [wCurPartyLevel], a
	pop hl

	ld b, h
	ld c, l
	ld hl, MON_LEVEL
	add hl, bc
	ld [hl], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc

	push bc
	ld b, TRUE
	call CalcMonStats
	pop bc

	ld a, [wPokemonWithdrawDepositParameter]
	cp PC_WITHDRAW
	jr z, .one_last_thing
	cp HOSPITAL_WITHDRAW ; I'm unsure about this one. TODO: check this condition.
	jr z, .one_last_thing
	jr .CloseSRAM_And_ClearCarryFlag

.one_last_thing
	ld hl, MON_STATUS
	add hl, bc
	xor a
	ld [hl], a
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	inc hl
	inc hl
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	inc de
	ld [de], a
	jr .CloseSRAM_And_ClearCarryFlag

.egg
	xor a
	ld [de], a
	inc de
	ld [de], a
	jr .CloseSRAM_And_ClearCarryFlag

.deposited_into_box
	ld a, [sBoxCount]
	dec a
	ld b, a
	call RestorePPOfDepositedPokemon
.CloseSRAM_And_ClearCarryFlag:
	call CloseSRAM
	and a
	ret

CloseSRAM_And_SetCarryFlag:
	call CloseSRAM
	scf
	ret

RestorePPOfDepositedPokemon:
;	ld a, [wPokemonWithdrawDepositParameter]
;	cp HOSPITAL_DEPOSIT
;	ret nz ; Now, the PPs are restored only when a Pokémon goes to the hospital. The PC doesn't restore PPs anymore.
;
;	ld a, b
;	ld hl, sHospitalBoxMons
;	ld bc, BOXMON_STRUCT_LENGTH
;	call AddNTimes
;	ld b, h
;	ld c, l
;	ld hl, MON_PP
;	add hl, bc
;	push hl
;	push bc
;	ld de, wTempMonPP
;	ld bc, NUM_MOVES
;	call CopyBytes
;	pop bc
;	ld hl, MON_MOVES
;	add hl, bc
;	push hl
;	ld de, wTempMonMoves
;	ld bc, NUM_MOVES
;	call CopyBytes
;	pop hl
;	pop de
;
;	ld a, [wMenuCursorY]
;	push af
;	ld a, [wMonType]
;	push af
;	ld b, 0
;.loop
;	ld a, [hli]
;	and a
;	jr z, .done
;	ld [wTempMonMoves], a
;	ld a, BOXMON
;	ld [wMonType], a
;	ld a, b
;	ld [wMenuCursorY], a
;	push bc
;	push hl
;	push de
;	farcall GetMaxPPOfMove
;	pop de
;	pop hl
;	ld a, [wTempPP]
;	ld b, a
;	ld a, [de]
;	and %11000000
;	add b
;	ld [de], a
;	pop bc
;	inc de
;	inc b
;	ld a, b
;	cp NUM_MOVES
;	jr c, .loop
;
;.done
;	pop af
;	ld [wMonType], a
;	pop af
;	ld [wMenuCursorY], a
	ret

RetrieveMonFromDayCareMan:
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	call GetBreedMon1LevelGrowth
	ld a, b
	ld [wPrevPartyLevel], a
	ld a, e
	ld [wCurPartyLevel], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	ld hl, wBreedMon1Exp
	jr RetrieveBreedmon

RetrieveMonFromDayCareLady:
	ld a, [wBreedMon2Species]
	ld [wCurPartySpecies], a
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	call GetBreedMon2LevelGrowth
	ld a, b
	ld [wPrevPartyLevel], a
	ld a, e
	ld [wCurPartyLevel], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	ld hl, wBreedMon2Exp

RetrieveBreedmon:
	ld de, wTempMonExp
	ld bc, 3
	call CopyBytes

	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nz, .room_in_party
	scf
	ret

.room_in_party
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname
	jr z, .okay
	ld a, [wBreedMon2Species]
	ld de, wBreedMon2Nickname

.okay
	ld [hli], a
	ld [wCurSpecies], a
	ld a, $ff
	ld [hl], a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl
	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl
	call GetLastPartyMon
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	call GetBaseData
	call GetLastPartyMon
	ld b, d
	ld c, e
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [wCurPartyLevel]
	ld [hl], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, $a
	add hl, bc
	push bc
	ld b, TRUE
	call CalcMonStats
	ld hl, wPartyMon1Moves
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld a, TRUE
	ld [wSkipMovesBeforeLevelUp], a
	predef FillMoves
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall HealPartyMon
	ld a, [wCurPartyLevel]
	cp MAX_LEVEL
	jr z, .prevent_exp_overflow

	pop bc
	ld hl, MON_EXP
	add hl, bc
	ld d, h
	ld e, l

	ld hl, wTempMonExp
	ld bc, 3
	call CopyBytes

	and a
	ret

.prevent_exp_overflow
	ld d, a
	callfar CalcExpAtLevel
	pop bc
	ld hl, MON_EXP
	add hl, bc
	ldh a, [hMultiplicand]
	ld [hli], a
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a
	and a
	ret

GetLastPartyMon:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ret

DepositMonWithDayCareMan:
	ld de, wBreedMon1Nickname
	call DepositBreedmon
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	jmp RemoveMonFromPartyOrBox

DepositMonWithDayCareLady:
	ld de, wBreedMon2Nickname
	call DepositBreedmon
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	jmp RemoveMonFromPartyOrBox

DepositBreedmon:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld bc, BOXMON_STRUCT_LENGTH
	jmp CopyBytes

SendMonIntoBox:
; Sends the mon into one of Bills Boxes
; the data comes mainly from 'wEnemyMon:'
	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld de, sBoxCount
	ld a, [de]
	cp MONS_PER_BOX
	jp nc, .full
	inc a
	ld [de], a

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld c, a
.loop
	inc de
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	inc a
	jr nz, .loop

	call GetBaseData
	call ShiftBoxMon

	ld hl, wPlayerName
	ld de, sBoxMonOTs
	ld bc, NAME_LENGTH
	call CopyBytes

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName

	ld de, sBoxMonNicknames
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wEnemyMon
	ld de, sBoxMon1
	ld bc, 1 + 1 + NUM_MOVES ; species + item + moves
	call CopyBytes

	ld hl, wPlayerID
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	callfar CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de

	; Set all 5 Experience Values to 0
	xor a
	ld b, 2 * 5
.loop2
	ld [de], a
	inc de
	dec b
	jr nz, .loop2

	ld hl, wEnemyMonDVs
	ld b, 2 + NUM_MOVES ; DVs and PP ; wEnemyMonHappiness - wEnemyMonDVs
.loop3
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop3

	ld a, BASE_HAPPINESS
	ld [de], a
	inc de
	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld a, [wCurPartyLevel]
	ld [de], a
	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .not_unown
	ld hl, sBoxMon1DVs
	predef GetUnownLetter
	callfar UpdateUnownDex

.not_unown
	ld hl, sBoxMon1Moves
	ld de, wTempMonMoves
	ld bc, NUM_MOVES
	call CopyBytes

	ld hl, sBoxMon1PP
	ld de, wTempMonPP
	ld bc, NUM_MOVES
	call CopyBytes

	ld b, 0
	call RestorePPOfDepositedPokemon

	call CloseSRAM
	scf
	ret

.full
	call CloseSRAM
	and a
	ret

ShiftBoxMon:
	ld hl, sBoxMonOTs
	ld bc, NAME_LENGTH
	call .shift

	ld hl, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	call .shift

	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH

.shift
	ld a, [sBoxCount]
	cp 2
	ret c

	push hl
	call AddNTimes
	dec hl
	ld e, l
	ld d, h
	pop hl

	ld a, [sBoxCount]
	dec a
	call AddNTimes
	dec hl

	push hl
	ld a, [sBoxCount]
	dec a
	ld hl, 0
	call AddNTimes
	ld c, l
	ld b, h
	pop hl
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

GiveEgg::
	ld a, [wCurPartySpecies]
	push af
	callfar GetPreEvolution
	callfar GetPreEvolution
	ld a, [wCurPartySpecies]
	dec a

; TryAddMonToParty sets Seen and Caught flags
; when it is successful.  This routine will make
; sure that we aren't newly setting flags.
	push af
	call CheckCaughtMon
	pop af
	push bc
	call CheckSeenMon
	push bc

	call TryAddMonToParty

; If we haven't caught this Pokemon before receiving
; the Egg, reset the flag that was just set by
; TryAddMonToParty.
	pop bc
	ld a, c
	and a
	jr nz, .skip_caught_flag
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, $0
	ld hl, wPokedexCaught
	ld b, RESET_FLAG
	predef SmallFarFlagAction

.skip_caught_flag
; If we haven't seen this Pokemon before receiving
; the Egg, reset the flag that was just set by
; TryAddMonToParty.
	pop bc
	ld a, c
	and a
	jr nz, .skip_seen_flag
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, $0
	ld hl, wPokedexSeen
	ld b, RESET_FLAG
	predef SmallFarFlagAction

.skip_seen_flag
	pop af
	ld [wCurPartySpecies], a
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Species
	call AddNTimes
	ld a, [wCurPartySpecies]
	ld [hl], a
	ld hl, wPartyCount
	ld a, [hl]
	ld b, 0
	ld c, a
	add hl, bc
	ld a, EGG
	ld [hl], a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld de, String_Egg
	call CopyName2
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	ld a, 1
	jr nz, .got_init_happiness
	ld a, [wBaseEggSteps]

.got_init_happiness
	ld [hl], a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	and a
	ret

String_Egg:
if DEF(_FR_FR)
	db "OEUF@"
else
	db "EGG@"
endc

RemoveMonFromPartyOrBox:
	ld hl, wPartyCount

	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .okay

	ld a, BANK(sBoxCount) ; sHospitalBox is in the same bank now.
	call OpenSRAM

	ld hl, sBoxCount ; sHospitalBox is in the same bank now.
	ld a, [wPokemonWithdrawDepositParameter]
	cp REMOVE_BOX
	jr z, .okay

	ld hl, sHospitalBoxCount

.okay
	ld a, [hl]
	dec a
	ld [hli], a ; Decrements the length of the list.
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld e, l
	ld d, h
	inc de
.loop
	ld a, [de]
	inc de
	ld [hli], a
	inc a
	jr nz, .loop

	ld hl, wPartyMonOTs
	ld d, PARTY_LENGTH - 1
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .party
	ld hl, sBoxMonOTs
	ld d, MONS_PER_BOX - 1
	cp REMOVE_BOX
	jr z, .party
	ld hl, sHospitalBoxMonOTs

.party
	; If this is the last mon in our party (box),
	; shift all the other mons up to close the gap.
	ld a, [wCurPartyMon]
	call SkipNames
	ld a, [wCurPartyMon]
	cp d
	jr nz, .delete_inside
	ld [hl], -1
	jmp .finish

.delete_inside
	; Shift the OT names
	ld d, h
	ld e, l
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .party2
	ld bc, sBoxMonNicknames
	cp REMOVE_BOX
	jr z, .party2
	ld bc, sHospitalBoxMonNicknames
.party2
	call CopyDataUntil
	; Shift the struct
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .party4
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	cp REMOVE_BOX
	jr z, .party4
	ld hl, sHospitalBoxMons

.party4
	ld a, [wCurPartyMon]
	call AddNTimes ; At this point, HL points to the first byte of mon data.
	ld d, h
	ld e, l
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .party5
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld bc, sBoxMonOTs
	cp REMOVE_BOX
	jr z, .copy
	ld bc, sHospitalBoxMonOTs
	jr .copy

.party5
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	ld bc, wPartyMonOTs
.copy
	call CopyDataUntil
	; Shift the nicknames
	ld hl, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .party6
	ld hl, sBoxMonNicknames
	cp REMOVE_BOX
	jr z, .party6
	ld hl, sHospitalBoxMonNicknames
.party6
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknamesEnd
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jr z, .party7
	ld bc, sBoxMonNicknamesEnd
	CP REMOVE_BOX
	jr z, .party7
	ld bc, sHospitalBoxMonNicknamesEnd
.party7
	call CopyDataUntil
	; Mail time!
.finish
	ld a, [wPokemonWithdrawDepositParameter]
	and a ; cp REMOVE_PARTY
	jp nz, CloseSRAM ; If the mode is either REMOVE_BOX or REMOVE_HOSPITAL, this function ends here.
	ld a, [wLinkMode]
	and a
	ret nz
	; Shift mail
	ld a, BANK(sPartyMail)
	call OpenSRAM
	; If this is the last mon in our party, no need to shift mail.
	ld hl, wPartyCount
	ld a, [wCurPartyMon]
	cp [hl]
	jr z, .close_sram
	; Shift our mail messages up.
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	push hl
	add hl, bc
	pop de
	ld a, [wCurPartyMon]
	ld b, a
.loop2
	push bc
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	pop hl
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	add hl, bc
	pop de
	pop bc
	inc b
	ld a, [wPartyCount]
	cp b
	jr nz, .loop2
.close_sram
	jmp CloseSRAM

ComputeNPCTrademonStats:
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [MON_LEVEL], a ; wow
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld d, h
	ld e, l
	push de
	ld a, MON_STAT_EXP - 1
	call GetPartyParamLocation
	ld b, TRUE
	call CalcMonStats
	pop de
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret

CalcMonStats:
; Calculates all 6 Stats of a mon
; b: Take into account stat EXP if not FALSE (not 0).
; 'c' counts from 1-6 and points with 'wBaseStats' to the base value
; hl is the path to the Stat EXP
; de points to where the final stats will be saved
; [wCurPartyLevel] must be set

	ld c, STAT_HP - 1 ; first stat
.loop
	inc c
	call CalcMonStatC
	ldh a, [hMultiplicand + 1]
	ld [de], a
	inc de
	ldh a, [hMultiplicand + 2]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF ; last stat
	jr nz, .loop
	ret

CalcMonStatC:
; 'c' is 1-6 and points to the BaseStat
; 1: HP
; 2: Attack
; 3: Defense
; 4: Speed
; 5: SpAtk
; 6: SpDef
	push hl
	push de
	push bc
	ld d, b
	push hl
	ld hl, wBaseStats
	dec hl ; has to be decreased, because 'c' begins with 1
	ld b, 0
	add hl, bc
	ld e, [hl]
	pop hl
	push hl
	ld a, c
	cp STAT_SDEF ; last stat
	jr nz, .not_spdef
	dec hl
	dec hl

.not_spdef
	sla c
	ld a, d
	and a
	jr z, .no_stat_exp
	add hl, bc
	push de
	ld a, [hld]
	ld e, a
	ld d, [hl]
	farcall GetSquareRoot
	pop de

.no_stat_exp
	srl c
	pop hl
	push bc
	ld bc, MON_DVS - MON_HP_EXP + 1
	add hl, bc
	pop bc
	ld a, c
	cp STAT_ATK
	jr z, .Attack
	cp STAT_DEF
	jr z, .Defense
	cp STAT_SPD
	jr z, .Speed
	cp STAT_SATK
	jr z, .Special
	cp STAT_SDEF
	jr z, .Special
; DV_HP = (DV_ATK & 1) << 3 | (DV_DEF & 1) << 2 | (DV_SPD & 1) << 1 | (DV_SPC & 1)
	push bc
	ld a, [hl]
	swap a
	and 1
	add a
	add a
	add a
	ld b, a
	ld a, [hli]
	and 1
	add a
	add a
	add b
	ld b, a
	ld a, [hl]
	swap a
	and 1
	add a
	add b
	ld b, a
	ld a, [hl]
	and 1
	add b
	pop bc
	jr .GotDV

.Attack:
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Defense:
	ld a, [hl]
	and $f
	jr .GotDV

.Speed:
	inc hl
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Special:
	inc hl
	ld a, [hl]
	and $f

.GotDV:
	ld d, 0
	add e
	ld e, a
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	sla e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_2
	inc d

.no_overflow_2
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wCurPartyLevel]
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 1]
	ldh [hDividend + 0], a
	ldh a, [hProduct + 2]
	ldh [hDividend + 1], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 2], a
	ld a, 100
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	call Divide
	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hQuotient + 3]
	add b
	ldh [hMultiplicand + 2], a
	jr nc, .no_overflow_3
	ldh a, [hQuotient + 2]
	inc a
	ldh [hMultiplicand + 1], a

.no_overflow_3
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ldh a, [hQuotient + 3]
	add b
	ldh [hMultiplicand + 2], a
	jr nc, .no_overflow_4
	ldh a, [hQuotient + 2]
	inc a
	ldh [hMultiplicand + 1], a

.no_overflow_4
	ldh a, [hQuotient + 2]
	cp HIGH(MAX_STAT_VALUE + 1) + 1
	jr nc, .max_stat
	cp HIGH(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay
	ldh a, [hQuotient + 3]
	cp LOW(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay

.max_stat
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hMultiplicand + 1], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hMultiplicand + 2], a

.stat_value_okay
	pop bc
	pop de
	pop hl
	ret

GivePoke::
	push de
	push bc
	xor a ; PARTYMON
	ld [wMonType], a
	call TryAddMonToParty
	jr nc, .failed
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call SkipNames
	ld d, h
	ld e, l
	pop bc
	ld a, b
	ld b, 0
	push bc
	push de
	push af
	ld a, [wCurItem]
	and a
	jr z, .done
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [wCurItem]
	ld [hl], a
	jr .done

.failed
	ld a, [wCurPartySpecies]
	ld [wTempEnemyMonSpecies], a
	callfar LoadEnemyMon
	call SendMonIntoBox
	jp nc, .FailedToGiveMon
	ld a, BOXMON
	ld [wMonType], a
	xor a
	ld [wCurPartyMon], a
	ld de, wMonOrItemNameBuffer
	pop bc
	ld a, b
	ld b, 1
	push bc
	push de
	push af
	ld a, [wCurItem]
	and a
	jr z, .done
	ld a, [wCurItem]
	ld [sBoxMon1Item], a

.done
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	ld [wTempEnemyMonSpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop af
	and a
	jp z, .wildmon
	pop de
	pop bc
	pop hl
	push bc
	push hl
	ld a, [wScriptBank]
	call GetFarWord
	ld bc, MON_NAME_LENGTH
	ld a, [wScriptBank]
	call FarCopyBytes
	pop hl
	inc hl
	inc hl
	ld a, [wScriptBank]
	call GetFarWord
	pop bc
	ld a, b
	and a
	push de
	push bc
	jr nz, .send_to_box

	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	ld d, h
	ld e, l
	pop hl
.otnameloop
	ld a, [wScriptBank]
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	cp "@"
	jr nz, .otnameloop
	ld a, [wScriptBank]
	call GetFarByte
	ld b, a
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, HIGH(NPC_OT_ID)
	ld [hli], a
	ld [hl], LOW(NPC_OT_ID)
	pop bc
	farcall SetGiftPartyMonCaughtData
	jr .skip_nickname

.send_to_box
	ld a, BANK(sBoxMonOTs)
	call OpenSRAM
	ld de, sBoxMonOTs
.loop
	ld a, [wScriptBank]
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	cp "@"
	jr nz, .loop
	ld a, [wScriptBank]
	call GetFarByte
	ld b, a
	ld hl, sBoxMon1ID
	call Random
	ld [hli], a
	call Random
	ld [hl], a
	call CloseSRAM
	farcall SetGiftBoxMonCaughtData
	jr .skip_nickname

.wildmon
	pop de
	pop bc
	push bc
	push de
	ld a, b
	and a
	jr z, .party
	farcall SetBoxMonCaughtData
	jr .set_caught_data

.party
	farcall SetCaughtData
.set_caught_data
	farcall GiveANickname_YesNo
	pop de
	jr c, .skip_nickname
	call InitNickname

.skip_nickname
	pop bc
	pop de
	ld a, b
	and a
	ret z
	ld hl, WasSentToBillsPCText
	call PrintText
	ld a, BANK(sBoxMonNicknames)
	call OpenSRAM
	ld hl, wMonOrItemNameBuffer
	ld de, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	call CloseSRAM
	ld b, $1
	ret

.FailedToGiveMon:
	pop bc
	pop de
	ld b, $2
	ret

WasSentToBillsPCText:
	text_far _WasSentToBillsPCText
	text_end

InitNickname:
	push de
	call LoadStandardMenuHeader
	call DisableSpriteUpdates
	pop de
	push de
	ld b, NAME_MON
	farcall NamingScreen
	pop hl
	ld de, wStringBuffer1
	call InitName
	ld a, $4 ; ExitAllMenus is in bank 0; maybe it used to be in bank 4
	ld hl, ExitAllMenus
	rst FarCall
	ret

; Note this function is called only after we checked that there is at least 1 mon in this box.
_RetrieveFirstMonFromHospitalBox::
	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM

	; We copy the nickname for display purpose.
	xor a
	ld hl, sHospitalBoxMonNicknames ; First mon nickname.
	call GetNickname

	ld a, [sHospitalBoxMon1Species]
	ld [wCurPartySpecies], a

	call CloseSRAM

	; We withdraw the first mon in the hospital box.
	xor a
	ld [wCurPartyMon], a
	ld a, HOSPITAL_WITHDRAW
	ld [wPokemonWithdrawDepositParameter], a
	call SendGetMonIntoFromBox

	call RemoveFirstMonFromHospitalBox

	ld a, [wScriptVar] ; We preserve wScriptVar.
	ld h, a
	push hl
	farcall _IsFirstHospitalMonReadyToLeave
	pop hl
	ld a, [wScriptVar]
	ld l, a
	ld a, h
	ld [wScriptVar], a

	ld a, l
	and a
	ret nz

	; All Pokémons have been retrieved from the hospital box.
	; So we remove the SPECIALCALL_RECOVER_HOSPITAL if it is the current programmed special call.

	ld a, [wSpecialPhoneCallID]
	cp SPECIALCALL_RECOVER_HOSPITAL
	ret nz

	xor a
	ld [wSpecialPhoneCallID], a
	ret

RemoveFirstMonFromHospitalBox::
	; We remove the first Pokemon from the hospital box.
	ld a, REMOVE_HOSPITAL
	ld [wPokemonWithdrawDepositParameter], a
	xor a 
	ld [wCurPartyMon], a
	call RemoveMonFromPartyOrBox

	; We shift the visit flags
	ld hl, wHospitalVisitsToday + 2
	srl [hl]
	dec hl
	rr [hl]
	dec hl
	rr [hl]
	ret