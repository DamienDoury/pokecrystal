; Returns in a the wanted level at the current landmark (as indicated by wCurLandmark).
; Returns the address hl where the information is stored.
; Returns the offset within the byte in b.
; Updates [wCurLandmark] (because it's never done at this point).
; Destroys c.
GetCurrentResearchLevelAtLandmark::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld [wCurLandmark], a

	cp $FF
	ret z
	ld c, a

	srl c
	srl c ; We divide the landmark ID by four, and floor the result, to know in which byte the wanted level is stored.
	ld b, 0
	ld hl, wWantedLevelPerLandmark
	add hl, bc
	; Here in hl we have the address of the byte we will read and write into, so we can freely use a, b and c.
	ld c, [hl] ; c contains the byte where the wanted level of this landmark is stored.

	and $03 ; We mask the last 2 bits of the a register to know at what offset the wanted level is stored within its byte.
	ld b, a ; We store a for later use.

.offset
	cp 0
	jr z, .masking
	dec a
	srl c
	srl c ; We shift by 1 landmark.
	jr .offset

.masking
	ld a, c
	and $03
	ret

; Call this after a won battle against a policeman.
; Destroys a, b, c and hl.
IncreaseResearchLevel::
	ld a, [wCurLandmark]
	cp $FF
	ret z

	ld a, [wOtherTrainerClass]
	cp OFFICER
	ret c ; Only a won battle against an OFFICER (or SERGEANT or JENNY) can increase the research level.
	cp SWAT
	ret nc ; do not increase for SWAT (max wanted lvl already).

;.is_the_police
;	ld a, [wFreedomState]
;	cp 1
;	ret z ; We only increase the research level during curfew and/or lockdown, not during a "freedom" period of time.

	call GetCurrentResearchLevelAtLandmark
; level_increase
	inc a
	cp 3
	jr c, .no_overflow
	ld a, 3
.no_overflow
	ld c, a
	ld a, b
	ld b, %11111100 ; We now use b as the mask.

.offset
	cp 0
	jr z, .write_level
	dec a
	sla c
	sla c ; We shift by 1 landmark.
	rlc b
	rlc b ; We also shift the mask by 1 landmark (2 bits).
	jr .offset

.write_level
	ld a, [hl]
	and b
	add c
	ld [hl], a
	ret

; Forces the first lockdown when leaving Ilex Forest.
ForceLockdown::
	ld hl, wCurFreedomState
	ld [hl], 1 << LOCKDOWN
	ret