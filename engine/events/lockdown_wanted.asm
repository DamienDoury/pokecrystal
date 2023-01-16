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
	cp KANTO_LANDMARK + 1
	ld c, 0
	jr nc, .masking

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
	ld [wCurWantedLevel], a
	ret

; This is called after a won battle against a trainer.
; Destroys a, b, c and hl.
IncreaseResearchLevel::
	ld a, [wCurLandmark]
	cp KANTO_LANDMARK + 1
	ret nc

	call GetCurrentResearchLevelAtLandmark

	ld a, [wOtherTrainerClass]
	cp OFFICER
	ret c ; Only a won battle against an OFFICER (or SERGEANT or JENNY) can increase the research level.
	cp SWAT
	ret nc ; do not increase for SWAT (max wanted lvl already).

	ld a, [wCurLandmark]
	cp LANDMARK_ROUTE_45
	jr nc, .force_increase ; We force the level increase in the last roads.

	call ShouldResearchLevelBeIncreased
	ret c

.force_increase
	; level_increase
	ld a, [wCurWantedLevel]
	inc a
	ld [wCurWantedLevel], a
	ld c, a
	ld a, b ; B is retrieved from GetCurrentResearchLevelAtLandmark.
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
	ld a, [hl] ; HL is retrieved from GetCurrentResearchLevelAtLandmark.
	and b
	add c
	ld [hl], a

	; Also, we first the leftmost bit of the wCurFreedomState byte to notify that we just increased the wanted level (used and erased by RefreshPolice in warp_connection.asm to reload the map).
	ld a, [wCurWantedLevel]
	or %10000000
	ld [wCurWantedLevel], a
	ret

; Output: Carry if it should be increased. nc otherwise.
ShouldResearchLevelBeIncreased::
	ld a, [wCurWantedLevel]
	and a
	ret z ; Returns true. Backup is always called at level 0.

	cp 3
	jr z, .return_false ; Backup can never be called at level 3.
	
	cp 2
	jr z, .level2

;.level1 ; If the wanted level is 1, there is 75% odds that backup will be called.
	push hl
	farcall GetRandomPoliceSeed
	pop hl
	ldh a, [hDivisor]
	and %00000011
	jr nz, .return_true
	jr .return_false
	
.level2 ; The odds are 50% at level 2.
	push hl
	farcall GetRandomPoliceSeed
	pop hl
	ldh a, [hDivisor]
	and %00000011
	jr z, .return_true
	cp %00000011
	jr z, .return_true
	; fallthrough

.return_false
	scf
	ret

.return_true
	xor a
	ret

ResetResearchLevelInCurrentLandmark::
	ld a, [wCurLandmark]
	cp KANTO_LANDMARK + 1
	ret nc

	ld a, [wOtherTrainerClass]
	cp OFFICER
	ret c ; Only a won battle against an OFFICER (or SERGEANT or JENNY) can increase the research level.
	cp SWAT + 1
	ret nc ; do not increase for SWAT (max wanted lvl already).

	call GetCurrentResearchLevelAtLandmark

	xor a
	ld [wCurWantedLevel], a
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

ResetAllResearchLevels::
	ld hl, wWantedLevelPerLandmark
	ld bc, NUM_LANDMARKS_QUARTER + 1 ; We add 1 to also reset wCurWantedLevel.
	xor a
	call ByteFill ; fill bc bytes with the value of a, starting at hl
	ret

GetOlivineCafeSalad:
	ld a, [wCurDay]
	ld b, 7
	call Modulo
	ld c, a
	ld b, 0
	ld hl, OlivineCafeBerries
	add hl, bc
	ld a, [hli]
	ld [wScriptVar], a
	ld [wOlivineCafeBerry1], a
	ld a, [hli]
	ld [wOlivineCafeBerry2], a
	ld a, [hli]
	ld [wOlivineCafeBerry3], a
	ret

OlivineCafeBerries:
	db PSNCUREBERRY
	db BURNT_BERRY
	db GOLD_BERRY
	db PRZCUREBERRY
	db MINT_BERRY
	db MYSTERYBERRY
	db BITTER_BERRY
	db PSNCUREBERRY
	db BURNT_BERRY

ApplyCurfewStateBasedOnTime::
	ld de, ENGINE_FLYPOINT_VERMILION ; Curfew stops once the player reaches Vermilion.
	farcall CheckEngineFlag
	ret nc ; If the flag is set, we don't edit the freedom state.

	ld b, CHECK_FLAG
	ld de, EVENT_FIRST_CURFEW_STARTED
	call EventFlagAction
	ld a, c
	and a
	ret z ; If the curfew hasn't started yet, we return.

	ld a, [wTimeOfDay]
	cp NITE_F
	jr z, .curfew

; .freedom
	ld a, 1 << FREE
	ld [wCurFreedomState], a

	call ResetAllResearchLevels
	ret

.curfew
	ld a, 1 << LOCKDOWN
	ld [wCurFreedomState], a
	ret

DisplayRandomPoliceSeenText::
	farcall GetRandomPoliceSeed
	ldh a, [hDivisor]
	ld hl, PoliceSeenTextPool
	jr DisplayRandomPoliceBattleText

DisplayRandomPoliceBeatenText::
	ld a, [wCurWantedLevel]
	and %10000000
	jr nz, DisplayPoliceBackupText

	farcall GetRandomPoliceSeed
	ldh a, [hDivisor]
	ld c, a
	swap a
	xor c
	ld hl, PoliceBeatenTextPool

DisplayRandomPoliceBattleText:
	and $f
	add a
	ld c, a
	ld b, 0
	add hl, bc

	ld a, BANK(PoliceSeenTextPool)
	call GetFarWord ; retrieve a word from a:hl, and return it in hl.

	ld b, BANK(PoliceSeenTextPool)
	call MapTextbox
	ret

DisplayPoliceBackupText:
	ld a, BANK(PoliceSeenTextPool)
	call GetFarWord ; retrieve a word from a:hl, and return it in hl.

	ld hl, PoliceBeatenBackupText
	ld b, BANK(PoliceBeatenBackupText)
	call MapTextbox
	ret

ResetWantedLevelsTheNextDay::
	; Note: the wanted level will reset twice per night during the curfew, but it is acceptable.

	ld a, 1
	ldh [hWriteByte], a
	ld a, BANK(wMustResetWantedLevels)
	ld hl, wMustResetWantedLevels
	call WriteFarWRAMByte	
	ret

CheckResetWantedLevels::
	ld a, BANK(wMustResetWantedLevels)
	ld hl, wMustResetWantedLevels
	call GetFarWRAMByte
	and a
	ret z

	xor a
	ldh [hWriteByte], a
	ld a, BANK(wMustResetWantedLevels)
	ld hl, wMustResetWantedLevels
	call WriteFarWRAMByte

	jp ResetAllResearchLevels
