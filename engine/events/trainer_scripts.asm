TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

; Output: the address of wObjectXWalking in HL.
GetObserverWalking_HL:
	ldh a, [hLastTalked]
    ld hl, wPlayerObjectStructID
    ld bc, MAPOBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld hl, wPlayerWalking
    ld bc, OBJECT_LENGTH
    call AddNTimes
	ret

; Input: none.
; Output: the last talked NPC's action in wScriptVar. 
GetObserverWalking:
    call GetObserverWalking_HL
    ld a, [hl]
    ld [wScriptVar], a
    ret

ForceObserverFacing:
	call GetObserverWalking_HL
	;inc hl

	ld a, [wObserverMovementData]
    ld [hl], a
	ret

SaveObserverData:
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

WaitForObserverToEndMovementScript:
	readmem hLastTalked
	ifequal  0, .break_loop
	ifequal -1, .break_loop

	callasm GetObserverWalking
	ifequal -1, .break_loop

	callasm HandleLastTalkedStep
	callasm GetObserverWalking ; Returns the observer's action in wScriptVar.
	callasm ForceObserverFacing
	callasm NextOverworldFrame
	callasm HandleMapBackground
	pause 1
	ifnotequal -1, WaitForObserverToEndMovementScript

.break_loop
	end

SeenByTrainerScript::
	loadtemptrainer
	encountermusic

	callasm SaveObserverData
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm RestoreObserverData

	scall WaitForObserverToEndMovementScript

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
