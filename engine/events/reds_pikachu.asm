; Note: this is called after a basic pikachu had been added to the party.
MakeRedsPikachu::
	; First, we have to retrieve the last member of the party.
	ld a, [wPartyCount]
	ret z
	dec a ; We need to sub 1 to the length of the array in order to get the last ID in the array.
	;ret z ; Impossible.
	ld [wCurPartyMon], a

	; We get the first byte of its data structure in the memory.
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	; Finally, we can set all of its data, according to its data structure as described in constants/pokemon_data_constants.asm:PARTYMON_STRUCT_LENGTH.
	; Starting with its first move.
	ld [hl], THUNDER ; Move #1.
	inc hl
	ld [hl], THUNDERBOLT ; Move #2.
	inc hl
	ld [hl], SURF ; Move #3.
	inc hl
	ld [hl], LIGHT_SCREEN ; Move #4.
	inc hl

	ld [hl], 0 ; OT ID leftmost byte.
	inc hl
	ld [hl], 1 ; OT ID rightmost byte.
	inc hl

	; MON_EXP (skipped)
	inc hl
	inc hl
	inc hl

	; MON_STAT_EXP
	ld a, NUM_EXP_STATS + 1
.stat_exp_loop
	dec a
	jr z, .end_stat_exp_loop

	ld [hl], $FF
	inc hl
	ld [hl], $FF ; stat_exp is on 2 bytes (65535).
	inc hl
	jr .stat_exp_loop
.end_stat_exp_loop

	; MON_DVS
	ld [hl], $FF 
	inc hl
	ld [hl], $FF
	inc hl
	push hl
	farcall UpdateStatsAfterItem ; The stats of the Pokémon need to be recalculated.
	pop hl

	; MON_PP
	ld [hl], 16 | PP_UP_MASK
	inc hl
	ld [hl], 24 | PP_UP_MASK
	inc hl
	ld [hl], 24 | PP_UP_MASK
	inc hl
	ld [hl], 48 | PP_UP_MASK
	inc hl

	; MON_HAPPINESS (skipped)
	inc hl

	; MON_PKRUS
	; Note: we need to give 2 symptoms for the disease to be considered as covid. Otherwise it would be cured as a mild illness by the nurse.
	ld [hl], POKERUS_ALPHA_STRAIN | (POKERUS_SYMPTOMS_START - 1) ; We say the Pikachu has been infected by the XP variant (useless as level 100), and is currently sick and checked. He hasn't been vaccinated.
	inc hl

	; MON_CAUGHTDATA
	; Time of day (2 bits) & Caught level (6 bits).
	ld [hl], MORN << 6 | 5 ; %01000101 ; Caught at level 5 in the morning.
	inc hl
	; OT gender (1 bit) & location (7 bits) as seen here: https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_structure_(Generation_II)#Caught_data
	ld [hl], LANDMARK_PALLET_TOWN ; We say the Pikachu has been met as a male (bit 7 at value 0) in Pallet Town.
	inc hl

	; MON_LEVEL (skipped)
	inc hl

	; MON_STATUS (skipped)
	inc hl

	; UNUSED BYTE (skipped)
	inc hl

	; MON_HP ; As the Pokémon gained HP due to UpdateStatsAfterItem, we need to heal it to max HP (its PP already have been restored).
	ld [hl], 0
	inc hl
	ld [hl], 1 ; Pikachu's perfect max HP is 273.
	; Please note that I changed my mind, and I decided to give Pikachu 1 HP left, from after its battle with the player.
	; It's better because it forces the player go to heal him at a pkcenter where he will find out Pikachu as covid.
	ret

RedsPikachu_SetupSearch:
	ld bc, 4
    ld hl, .RedsTrainerName
    ld de, wStringBuffer1
    call CopyBytes ; copy bc bytes from hl to de

    ld bc, $0100 ; BC contains the Trainer ID of Red.
	ld d, PIKACHU ; species
	ld e, 100 ; level
	ret

.RedsTrainerName:
	db "RED@"

; Input: wCurPartyMon.
; Output: Carry if it is Red's Pikachu.
; Works for the party menu.
IsRedsPikachu_Party::
	call RedsPikachu_SetupSearch
    farcall BillsPC_CheckSelectedMonOTIDAndName.party
	ret nc

	jr IsRedsPikachu_PartyOrBox.CheckEvents

; Input: wBillsPC_CursorPosition.
; Output: Carry if it is Red's Pikachu.
; Works for the PC.
IsRedsPikachu_PartyOrBox::
	call RedsPikachu_SetupSearch
    farcall BillsPC_CheckSelectedMonOTIDAndName
	ret nc

.CheckEvents
	ld b, CHECK_FLAG
	ld de, EVENT_RED_BEATEN
	call EventFlagAction
	ret nz ; If Red has not been beaten, the player can't own his Pikachu.

	ld de, EVENT_REDS_PIKACHU_AVAILABLE
	call EventFlagAction
	ret z ; If Red's Pikachu is still waiting in his room, the player can't own it.

	scf
	ret
