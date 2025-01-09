GetFirstPokemonHappiness:
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wPartySpecies
.loop
	ld a, [de]
	cp EGG
	jr nz, .done
	inc de
	add hl, bc
	jr .loop

.done
	ld [wNamedObjectIndex], a
	ld a, [hl]
	ld [wScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

CheckFirstMonIsEgg:
	ld a, [wPartySpecies]
	ld [wNamedObjectIndex], a
	cp EGG
	ld a, TRUE
	jr z, .egg
	xor a

.egg
	ld [wScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

ChangeHappiness:
; Perform happiness action c on wCurPartyMon

	ld a, [wCurPartyMon]
	inc a
	ld e, a
	ld d, 0
	ld hl, wPartySpecies - 1
	add hl, de
	ld a, [hl]
	cp EGG
	ret z

	push bc
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	pop bc

	ld d, h
	ld e, l

	push de
	ld a, [de]
	cp HAPPINESS_THRESHOLD_1
	ld e, 0
	jr c, .ok
	inc e
	cp HAPPINESS_THRESHOLD_2
	jr c, .ok
	inc e

.ok
	dec c
	ld b, 0
	ld hl, HappinessChanges
	add hl, bc
	add hl, bc
	add hl, bc
	ld d, 0
	add hl, de
	ld a, [hl]
	cp $64 ; why not $80?
	pop de

	ld a, [de]
	jr nc, .negative
	add [hl]
	jr nc, .done
	ld a, -1
	jr .done

.negative
	add [hl]
	jr c, .done
	xor a

.done
	ld [de], a
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wPartyMenuCursor]
	cp b
	ret nz
	ld a, [de]
	ld [wBattleMonHappiness], a
	ret

INCLUDE "data/events/happiness_changes.asm"

StepHappiness::
; Raise the party's happiness by 1 point every other step cycle.

	ld hl, wHappinessStepCount
	ld a, [hl]
	inc a
	and 1
	ld [hl], a
	ret nz

IncreasePartyHappiness::
	ld de, wPartyCount
	ld a, [de]
	and a
	ret z

	ld c, a
	ld hl, wPartyMon1Happiness
.loop
	inc de
	ld a, [de]
	cp EGG
	jr z, .next
	inc [hl]
	jr nz, .next
	ld [hl], $ff

.next
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	dec c
	jr nz, .loop
	ret

DayCareExpStep::
; Raise the experience of Day-Care Pokémon every step cycle.

	ld a, [wDayCareMan]
	bit DAYCAREMAN_HAS_MON_F, a
	jr z, .day_care_lady

	ld a, [wBreedMon1Level] ; level
	cp MAX_LEVEL
	jr nc, .day_care_lady

	ld hl, wBreedMon1Exp
	; We divide the cur XP by 4096, and take the square root.
	; This formula is great because it scales better with level, but still provides diminishing return, as the exp gained grows slower than the exp required to gain a level.
	call DivideBy4096ThenSqrtThenAdd1
	ld hl, wBreedMon1Exp + 2 ; ld hl, n16 is 4 cycles faster than doing push hl + pop hl, but takes 1 more byte or ROM memory.

	add [hl]
	ld [hl], a
	jr nc, .day_care_lady
	dec hl
	inc [hl]
	jr nz, .day_care_lady
	dec hl
	inc [hl]
	ld a, [hl]
	cp HIGH(MAX_DAY_CARE_EXP >> 8)
	jr c, .day_care_lady
	ld a, HIGH(MAX_DAY_CARE_EXP >> 8)
	ld [hl], a

.day_care_lady
	ld a, [wDayCareLady]
	bit DAYCARELADY_HAS_MON_F, a
	ret z
	
	ld hl, wBreedMon2Exp
	; We divide the cur XP by 4096, and take the square root.
	; This formula is great because it scales better with level, but still provides diminishing return, as the exp gained grows slower than the exp required to gain a level.
	call DivideBy4096ThenSqrtThenAdd1
	ld hl, wBreedMon2Exp + 2 ; ld hl, n16 is 4 cycles faster than doing push hl + pop hl, but takes 1 more byte or ROM memory.

	add [hl]
	ld [hl], a
	ret nc

	dec hl
	inc [hl]
	ret nz

	dec hl
	inc [hl]
	ld a, [hl]
	cp HIGH(MAX_DAY_CARE_EXP >> 8)
	ret c

	ld a, HIGH(MAX_DAY_CARE_EXP >> 8)
	ld [hl], a
	ret

TryLayEgg::
	ld hl, wDayCareMan
	bit DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	ret z

	ld hl, wStepsToEgg
	dec [hl]
	ld a, [hl]
	jr z, .try

	cp $80 ; Doubles the odds of laying an egg, as it will happen when [wStepsToEgg] is either $00 or $80.
	ret nz

.try
	call Random
	ld [hl], a
	callfar CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	cp 230
	ld b, 31 percent + 1
	jr nc, .okay

	ld a, [wBreedingCompatibility]
	cp 170
	ld b, 16 percent
	jr nc, .okay

	ld a, [wBreedingCompatibility]
	cp 110
	ld b, 12 percent
	jr nc, .okay

	ld b, 4 percent

.okay
	call Random
	cp b
	ret nc

	ld hl, wDayCareMan
	res DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	set DAYCAREMAN_HAS_EGG_F, [hl]
	ret

; Input: HL = First byte (high weight) of Exp from party_struct.
; Output: the result in A.
DivideBy4096ThenSqrtThenAdd1:
	; We divide the current XP by 4096 -> 16 * 256 -> $10 * $100: shift by 1 nybble to the right, and drop the last byte.
	ld a, [hli]
	swap a
	ld e, a
	and $f
	ld d, a

	ld a, e
	and $f0
	ld e, a

	ld a, [hl]
	swap a
	and $f
	or e
	ld e, a ; The max XP of a Pokémon is 1 640 000, therefore max xp / 4096 = $190 or 400 (decimal) at most. Sqrt will be fast to find (20 loops at most).

	farcall GetSquareRoot ; Result in B.
	ld a, b
	inc a ; Minimum XP gain is 1, so it's always faster or equal to the vanilla day care.
	ret