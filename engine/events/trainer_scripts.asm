TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

; Input: none.
; Output: the last talked NPC's action in wScriptVar. 
GetObserverAction:
    ldh a, [hLastTalked]
    ld hl, wPlayerObjectStructID
    ld bc, MAPOBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld hl, wPlayerWalking
    ld bc, OBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld [wScriptVar], a
    ret

SaveObserverData:
	ldh a, [hLastTalked]
    ld hl, wPlayerObjectStructID
    ld bc, MAPOBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld hl, wPlayerWalking
    ld bc, OBJECT_LENGTH
    call AddNTimes
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

	callasm HandleLastTalkedStep
	callasm NextOverworldFrame
	callasm HandleMapBackground
	pause 1
	callasm GetObserverAction ; Returns the observer's action in wScriptVar.
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
	faceplayer

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
