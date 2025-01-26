TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

; Input: none.
; Output: the address of the last talked NPC wObjectXWalking in HL.
GetObserverWalking_HL:
	ldh a, [hLastTalked]
    ld hl, wPlayerObjectStructID
    ld bc, MAPOBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld hl, wPlayerWalking
    ld bc, OBJECT_LENGTH
    jp AddNTimes

ForceObserverFacing:
	call GetObserverWalking_HL
	;inc hl

	ld a, [wObserverMovementData]
    ld [hl], a
	ret

SaveObserverData::
	call GetObserverWalking_HL
	ld d, h
	ld e, l
	ld hl, wObserverMovementData

    ld a, [de]
	ld [hli], a

	inc de

rept 4
	inc de
	ld a, [de]
	ld [hli], a
endr

rept 5
	inc de
endr

rept 2
	inc de
	ld a, [de]
	ld [hli], a
endr
	ret

RestoreObserverData:
	ldh a, [hLastTalked]
	ld hl, wPlayerObjectStructID
	ld bc, MAPOBJECT_LENGTH
	call AddNTimes
	ld a, [hl]
	ld hl, wPlayerWalking
	ld bc, OBJECT_LENGTH
	call AddNTimes

	ld de, wObserverMovementData
	ld a, [de]
	inc de
	ld [hli], a

	inc hl

rept 4
	ld a, [de]
	inc de
	ld [hli], a
endr

rept 5
	inc hl
endr

rept 2
	ld a, [de]
	inc de
	ld [hli], a
endr
	ret


; Input: action in wScriptVar.
; Output: none. 
SetObserverAction:
    ldh a, [hLastTalked]
    ld hl, wPlayerObjectStructID
    ld bc, MAPOBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld hl, wPlayerAction
    ld bc, OBJECT_LENGTH
    call AddNTimes
    ld a, [wScriptVar]
    ld [hl], a
    ret

WaitForObserverToEndMovement::
	ldh a, [hLastTalked]
	and a
	ret z

	cp -1
	ret z

	call GetObserverWalking_HL
	ld a, [hl]
	cp -1
	ret z

.loop
	farcall HandleLastTalkedStep
	call GetObserverWalking_HL
	ld a, [hl]
	push af

	call ForceObserverFacing
	farcall NextOverworldFrame
	farcall HandleMapBackground

	ld c, 2
	call DelayFrames

	pop af
	cp -1
	jr nz, .loop

	ret

SeenByTrainerScript::
	loadtemptrainer
	encountermusic

	callasm SaveObserverData
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm RestoreObserverData

	callasm WaitForObserverToEndMovement

	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	; fallthrough

StartBattleWithMapTrainerScript:
	opentext
	trainertext TRAINERTEXT_SEEN
	waitbutton
	closetext
	loadtemptrainer
	startbattle
	reloadmapafterbattle
	trainerflagaction SET_FLAG
	loadmem wRunningTrainerBattleScript, -1

AlreadyBeatenTrainerScript:
	scripttalkafter
