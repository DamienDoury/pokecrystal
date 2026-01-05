GetCurrentGashaCapsulesCount::
    call GetCurrentGashaCapsulesCount_NoScript
    ld [wScriptVar], a
    ret

GetCurrentGashaCapsulesCount_NoScript::
    ld hl, wGasha0CapsulesCount
	ld a, [wGashaID]
    ld b, 0
    ld c, a
    add hl, bc
    add hl, bc
    ld a, [hl]
    ret

; Output: FALSE in wScriptVar if no capsule could be drawn.
CurrentGashaHasRemainingCapsules::
    call GetCurrentGashaCapsulesCount_NoScript
    and a
    ld [wScriptVar], a ; FALSE
    ret z

    ld a, 1
    ld [wScriptVar], a ; TRUE
    ret

; Output: Either wGasha0PrizesRemaining, 1, or 2 in HL.
GetCurrentGashaRemainingPrizes::
    ld hl, wGasha0PrizesRemaining
	ld a, [wGashaID]
    ld b, 0
    ld c, a
    add hl, bc
    add hl, bc
    ret

; Output: in A: a uniform random value within 0 to GetCurrentGashaCapsulesCount_NoScript.
; This method is called Rejection Sampling.
GetUniformRandomCapsuleIndex:
    call GetCurrentGashaCapsulesCount_NoScript
    ld c, a
    ld b, a
    ld a, 255
    call Modulo
    ld b, a
    ld a, 255
    sub b
    ld b, a
    ; At this point, B contains our limit. Limit = 255 - (255 % N), with N being the number of remaining capsules.


    call Random
    cp b
    jr nc, GetUniformRandomCapsuleIndex ; If the random value is equal or greater than our limit, we roll for a new random value.

    ; We return the random modulo the limit.
    ld b, c
    jmp Modulo

; Output: the won prize's index within the current gasha's prize pool (from 0-6) in C. The rarity from 0 (secret) to 3 (common) in wScriptVar2.
DrawRandomPrize:
    call GetUniformRandomCapsuleIndex
    ld b, a
    push bc
    call GetCurrentGashaRemainingPrizes
    pop bc

    ; Secret rare check.
    ld a, [hl]
    swap a
    and $f
    srl a
    srl a
    ld c, a ; C is the addition of all previous prize count. Example: if there are 1 secret, 1 gold, and 3 silver remaining prizes, then C will be 5.

    cp b
    jr z, .CheckGoldPrize
    jr nc, .GetSecretRarePrize

.CheckGoldPrize
    ; Gold rare check.
    ld a, [hl]
    swap a
    and $3
    add c
    ld c, a

    cp b
    jr z, .CheckSilverPrize
    jr nc, .GetGoldRarePrize

.CheckSilverPrize
    ; Silver rare check.
    ld a, [hl]
    and $f
    add c

    cp b
    jr z, .CheckCommonPrize
    jr nc, .GetSilverRarePrize

.CheckCommonPrize
    ; The player receives a Common prize, which is rolled randomly.
    ld a, 3
    ld [wScriptVar2], a

    call Random
    ld b, 4
    call Modulo ; Returns from [0;3].
    add 3 ; Common prizes start at index 3.
    ld c, a
    ret

.GetSecretRarePrize
    ld a, 0
    ld [wScriptVar2], a

    ; We remove this unique prize from its pool.
    res 6, [hl]

    ; Return the index.
    ld c, 0
    ret

.GetGoldRarePrize
    ld a, 1
    ld [wScriptVar2], a

    ; Once again, we remove this prize from the pool.
    ld a, [hl]
    sub 1 << 4
    ld [hl], a

    ; Return the index.
    ld c, 1
    ret

.GetSilverRarePrize
    ld a, 2
    ld [wScriptVar2], a

    ; Remove this prize from the pool.
    dec [hl]

    ; Return the index.
    ld c, 2
    ret

; Output: the won decoration ID in hFarByte, and wScriptVar.
ReturnWonGasha::
    ; Retrieve the current gasha's prize list.
    ld hl, Gasha0Prizes
	ld a, [wGashaID]
    ld bc, 7
    call AddNTimes

    push hl
    call DrawRandomPrize
    pop hl
    ld b, 0
    add hl, bc
    ld a, BANK(Gasha0Prizes)
    call GetFarByte
    ld [wScriptVar], a
    ; fallthrough.

RemoveOneCapsuleFromCurrentGasha::
    call GetCurrentGashaCapsulesCount_NoScript
    and a
    ret z

    dec [hl]
    ret

GetGashaRarityInStringBuffer4::
    ld hl, .Strings
    ld a, [wScriptVar2]
    add a
    ld d, 0
    ld e, a
    add hl, de

    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, wStringBuffer4
    jmp CopyName2

.Strings
    dw .SecretRareCapsuleText
    dw .GoldRareCapsuleText
    dw .SilverRareCapsuleText
    dw .CommonCapsuleText

.SecretRareCapsuleText
if DEF(_FR_FR)
	db   "La capsule secrète@"
else
	db   "The secret rare@"
endc

.GoldRareCapsuleText
if DEF(_FR_FR)
	db   "Une capsule or@"
else
	db   "A gold rare@"
endc

.SilverRareCapsuleText
if DEF(_FR_FR)
	db   "Une capsule argent@"
else
	db   "A silver rare@"
endc

.CommonCapsuleText
if DEF(_FR_FR)
	db   "Une capsule@"
else
	db   "A common@"
endc