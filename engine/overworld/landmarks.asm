GetLandmarkCoords:
; Return coordinates (d, e) of landmark e.
	push hl
	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, Landmarks
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ret

GetLandmarkName::
; Copy the name of landmark e to wStringBuffer1.
	push hl
	push de
	push bc

	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, Landmarks + 2
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de, wStringBuffer1
	ld c, 18
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy

	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/maps/landmarks.asm"

GetChallengeName::
; Copy the name of challenge from map group wMapGroup to wStringBuffer3.
	ld a, [wMapGroup]
	dec a ; Map group ID starts at 1, so we need to decrease it to find its index.
	ld l, a
	ld h, 0
	add hl, hl ; The array is 2 bytes wide, so we need to double the value of "a" (now hl) to find the right index.
	ld de, ChallengeNames
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de, wStringBuffer3
	ld c, 18
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy
	ret

INCLUDE "data/maps/gym_challenges.asm"

RegionCheck:
; Checks if the player is in Kanto or Johto.
; If in Johto, returns 0 in e.
; If in Kanto, returns 1 in e.
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	cp LANDMARK_FAST_SHIP ; S.S. Aqua
	jr z, .johto
	cp LANDMARK_SPECIAL
	jr nz, .checkagain

; In a special map, get the backup map group / map id
	ld a, [wBackupMapGroup]
	ld b, a
	ld a, [wBackupMapNumber]
	ld c, a
	call GetWorldMapLocation

.checkagain
	cp KANTO_LANDMARK
	jr c, .johto

; Victory Road area is considered to be Johto.
	cp LANDMARK_VICTORY_ROAD
	jr c, .kanto

.johto
	ld e, JOHTO_REGION
	ret
.kanto
	ld e, KANTO_REGION
	ret
