FieldMoveJumptableReset:
	xor a
	ld hl, wFieldMoveData
	ld bc, wFieldMoveDataEnd - wFieldMoveData
	jmp ByteFill

FieldMoveJumptable:
	ld a, [wFieldMoveJumptableIndex]
	rst JumpTable
	ld [wFieldMoveJumptableIndex], a
	bit 7, a
	jr nz, .okay
	and a
	ret

.okay
	and $7f
	scf
	ret

GetPartyNickname::
; write wCurPartyMon nickname to wStringBuffer1-3
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wCurPartyMon]
	call GetNickname
	call CopyName1
; copy text from wStringBuffer2 to wStringBuffer3
	ld de, wStringBuffer2
	ld hl, wStringBuffer3
	jmp CopyName2

CheckEngineFlag:
; Check engine flag de
; Return carry if flag is not set
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	jr nz, .isset
	scf
	ret
.isset
	xor a
	ret

; Input: A = the ID of the HM item.
CheckHM:
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr c, .return_nc

	ld hl, .HMRequiredText
	call MenuTextboxBackup ; push text to queue
	scf
	ret

.return_nc
	xor a
	ret

.HMRequiredText:
	text_far _HMRequiredText
	text_end

FarCheckHMSilent::
	ld a, b
	; fallthrough

; Input: A = the ID of the HM item.
CheckHMSilent:
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	ccf
	ret

CheckPartyMove::
; Check if a monster in your party has move d.

	ld e, 0
	xor a
	ld [wCurPartyMon], a
.loop
	ld c, e
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no
	cp -1
	jr z, .no
	cp EGG
	jr z, .next

	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Moves
	ld a, e
	call AddNTimes
	ld b, NUM_MOVES
.check
	ld a, [hli]
	cp d
	jr z, .yes
	dec b
	jr nz, .check

.next
	inc e
	jr .loop

.yes
	ld a, e
	ld [wCurPartyMon], a ; which mon has the move
	xor a
	ret
.no
	scf
	ret

FieldMoveFailed:
	ld hl, .CantUseItemText
	jmp MenuTextboxBackup

.CantUseItemText:
	text_far _CantUseItemText
	text_end

CutFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .CheckAble
	dw .DoCut
	dw .FailCut

.CheckAbleSilent::
	call CheckDirection
	jr c, .nothingtocut

	ld a, HM_CUT
	call CheckHMSilent
	jr c, .notOwned
	jr .checkForSomething

.CheckAble:
	call CheckDirection
	jr c, .nothingtocut
	
	ld a, HM_CUT
	call CheckHM
	jr c, .notOwned

.checkForSomething
	call CheckMapForSomethingToCut
	jr c, .nothingtocut

	xor a ; Unsets the carry flag.
	ld a, $1
	ret

.notOwned
	ld a, $80
	ret

.nothingtocut
	ld a, $2
	ret

.DoCut:
	ld hl, Script_CutFromMenu
	call QueueScript
	ld a, $81
	ret

.FailCut:
	ld hl, CutNothingText
	call MenuTextboxBackup
	ld a, $80
	ret

UseCutText:
	text_far _UseCutText
	text_end

CutNothingText:
	text_far _CutNothingText
	text_end

CheckMapForSomethingToCut:
	; Does the collision data of the facing tile permit cutting?
	call GetFacingTileCoordAndCollType
	ld c, a
	push de
	farcall CheckCutCollision
	pop de
	jr nc, .fail
	; Get the location of the current block in wOverworldMapBlocks.
	call GetBlockLocation
	ld c, [hl]
	; See if that block contains something that can be cut.
	push hl
	ld hl, CutTreeBlockPointers
	call CheckOverworldTileArrays
	pop hl
	jr nc, .fail
	; Save the Cut field move data
	ld a, l
	ld [wCutWhirlpoolOverworldBlockAddr], a
	ld a, h
	ld [wCutWhirlpoolOverworldBlockAddr + 1], a
	ld a, b
	ld [wCutWhirlpoolReplacementBlock], a
	ld a, c
	ld [wCutWhirlpoolAnimationType], a
	xor a
	ret

.fail
	scf
	ret

Script_CutFromMenu:
	reloadmappart
	special UpdateTimePals

Script_Cut:
	callasm GetPartyNickname
	writetext UseCutText
	reloadmappart
	callasm CutDownTreeOrGrass
	closetext
	end

CutDownTreeOrGrass::
	ld hl, wCutWhirlpoolOverworldBlockAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCutWhirlpoolReplacementBlock]
	ld [hl], a
	xor a
	ldh [hBGMapMode], a
	call OverworldTextModeSwitch
	call UpdateSprites
	call DelayFrame
	ld a, [wCutWhirlpoolAnimationType]
	ld e, a
	farcall OWCutAnimation
	call BufferScreen
	call GetMovementPermissions
	call UpdateSprites
	call DelayFrame
	jmp LoadStandardFont

CheckOverworldTileArrays:
	; Input: c contains the tile you're facing
	; Output: Replacement tile in b and effect on wild encounters in c, plus carry set.
	;         Carry is not set if the facing tile cannot be replaced, or if the tileset
	;         does not contain a tile you can replace.

	; Dictionary lookup for pointer to tile replacement table
	push bc
	ld a, [wMapTileset]
	ld de, 3
	call IsInArray
	pop bc
	jr nc, .nope
	; Load the pointer
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Look up the tile you're facing
	ld de, 3
	ld a, c
	call IsInArray
	jr nc, .nope
	; Load the replacement to b
	inc hl
	ld b, [hl]
	; Load the animation type parameter to c
	inc hl
	ld c, [hl]
	scf
	ret

.nope
	xor a
	ret

INCLUDE "data/collision/field_move_blocks.asm"

FlashFunction:
	call .CheckUseFlash
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.CheckUseFlash:
; Flash
	ld a, HM_FLASH
	call CheckHM
	jr c, .notOwned

	push hl
	farcall SpecialAerodactylChamber
	pop hl
	jr c, .useflash
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr nz, .notadarkcave
.useflash
	call UseFlash
	ld a, $81
	ret

.notadarkcave
	call FieldMoveFailed
	ld a, $80
	ret

.notOwned
	ld a, $80
	ret

UseFlash:
	ld hl, Script_UseFlash
	jmp QueueScript

Script_UseFlash:
	reloadmappart
	special UpdateTimePals
	writetext UseFlashTextScript
	callasm BlindingFlash
	closetext
	end

Script_AutoFlash::
	opentext
	writetext AutoFlashText
	callasm BlindingFlash
	closetext
	callasm ReloadMapPals
	writemem wPrevLandmark
	callasm InitMapNameSign
	end

UseFlashTextScript:
	text_far _BlindingFlashText
	text_asm
	call WaitSFX
	ld de, SFX_FLASH
	call PlaySFX
	call WaitSFX
	ld hl, BlankText
	ret

AutoFlashText:
	text_far _AutoFlashText
	text_asm
	call WaitSFX
	ld de, SFX_FLASH
	call PlaySFX
	call WaitSFX
	ld hl, BlankText
	ret

BlankText:
	text_end

FarTrySurf::
	call SurfFunction.TrySurf
	ld b, a
	ret

SurfFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TrySurf
	dw .DoSurf
	dw .FailSurf
	dw .AlreadySurfing

.TrySurf:
	ld a, HM_SURF
	call CheckHM
	jr c, .notOwned

	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .cannotsurf
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .alreadyfail
	cp PLAYER_SURF_PIKA
	jr z, .alreadyfail
	call GetFacingTileCoordAndCollType
	call GetTileCollision
	cp WATER_TILE
	jr nz, .cannotsurf
	call CheckDirection
	jr c, .cannotsurf
	farcall CheckFacingObject
	jr c, .cannotsurf
	ld a, $1
	ret
.notOwned
	ld a, $80
	ret
.alreadyfail
	ld a, $3
	ret
.cannotsurf
	ld a, $2
	ret

.DoSurf:
	call GetSurfType
	ld [wSurfingPlayerState], a
	call GetPartyNickname
	ld hl, SurfFromMenuScript
	call QueueScript
	ld a, $81
	ret

.FailSurf:
	ld hl, CantSurfText
	call MenuTextboxBackup
	ld a, $80
	ret

.AlreadySurfing:
	ld hl, AlreadySurfingText
	call MenuTextboxBackup
	ld a, $80
	ret

SurfFromMenuScript:
	special UpdateTimePals

UsedSurfScript:
	writetext UsedSurfText ; "used SURF!"
	waitbutton
	closetext

UsedSurfScriptSilent::
	callasm .stubbed_fn

	readmem wSurfingPlayerState
	writevar VAR_MOVEMENT

	special UpdatePlayerSprite
	special PlayMapMusic
	special SurfStartStep
	end

.stubbed_fn
	farcall StubbedTrainerRankings_Surf
	ret

UsedSurfText:
	text_far _UsedSurfText
	text_end

CantSurfText:
	text_far _CantSurfText
	text_end

AlreadySurfingText:
	text_far _AlreadySurfingText
	text_end

GetSurfType::
; Surfing on Pikachu uses an alternate sprite.
; This is done by using a separate movement type.

	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de

	ld a, [hl]
	cp PIKACHU
	ld a, PLAYER_SURF_PIKA
	ld d, a ; Also stores the result in D for farcall compatibility.
	ret z
	ld a, PLAYER_SURF
	ld d, a ; Also stores the result in D for farcall compatibility.
	ret

CheckDirection::
; Return carry if a tile permission prevents you
; from moving in the direction you're facing.

; Get player direction
	ld a, [wPlayerDirection]
	and %00001100 ; bits 2 and 3 contain direction
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, .Directions
	add hl, de

; Can you walk in this direction?
	ld a, [wTilePermissions]
	and [hl]
	jr nz, .quit
	xor a
	ret

.quit
	scf
	ret

.Directions:
	db FACE_DOWN
	db FACE_UP
	db FACE_LEFT
	db FACE_RIGHT

TrySurfOW::
; Checking a tile in the overworld.
; Return carry if surf is allowed.

; Don't ask to surf if already surfing.
	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	jr z, .quit
	cp PLAYER_SURF
	jr z, .quit

; Must be facing water.
	ld a, [wFacingTileID]
	call GetTileCollision
	cp WATER_TILE
	jr nz, .quit

; Check tile permissions.
	call CheckDirection
	jr c, .quit

	ld a, HM_SURF
	call CheckHMSilent
	jr c, .quit

	farcall FindBestSurfer
	jr c, .quit

	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .quit

	call GetSurfType
	ld [wSurfingPlayerState], a
	call GetPartyNickname

	ld a, BANK(AskSurfScript)
	ld hl, AskSurfScript
	jmp CallScript

.quit
	xor a
	ret

AskSurfScript:
	opentext
	writetext AskSurfText
	yesorno
	iftrue UsedSurfScript
	closetext
	end

AskSurfText:
	text_far _AskSurfText
	text_end

TryFlyFromOW::
	call FlyFunction.TryFly
	ld b, a ; Return A from the farcall.
	ret

TryFlySilent::
	call FlyFunction.TryFlySilent
	ld b, a ; Return A from the farcall.
	ret

FlyFunction::
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
 	dw .TryFly
 	dw .DoFly
 	dw .FailFly

.TryFly:
; Fly
	ld a, HM_FLY
	call CheckHM
	jr c, .notOwned

	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, .outdoors
	
;.indoors
	ld a, $2
	ret

.TryFlySilent
	ld a, HM_FLY
	call CheckHMSilent
	jr c, .notOwned

	call GetMapEnvironment
	call CheckOutdoorMap
	ld a, $1
	ret z
	
;.indoors
	ld a, $2
	ret

.outdoors
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
	farcall _FlyMap
	ld a, e
	cp -1
	jr z, .illegal

	cp NUM_SPAWNS
	jr nc, .illegal

	ld [wDefaultSpawnpoint], a
	call CloseWindow
	ld a, $1
	ret

.notOwned
	ld a, $82
	ret

.illegal
	call CloseWindow
	call WaitBGMap
	ld a, $80
	ret

.DoFly:
	ld hl, .FlyScript
	call QueueScript
	ld a, $81
	ret

.FailFly:
	call FieldMoveFailed
	ld a, $82
	ret

.FlyScript::
	reloadmappart
	callasm HideSprites
	special UpdateTimePals
	callasm FlyFromAnim
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	callasm SkipUpdateMapSprites
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_FLY
	callasm FlyToAnim
	special WaitSFX
	callasm .ReturnFromFly
	farscall ArrestPlayerForTravellingScript
	end

.ReturnFromFly:
	farcall RespawnPlayer
	call DelayFrame
	call UpdatePlayerSprite
    farcall RefreshMapPals
	farcall LoadOverworldFont
	ret

WaterfallFunction:
	call .TryWaterfall
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryWaterfall:
; Waterfall
	ld a, HM_WATERFALL
	call CheckHM
	ld a, $80
	ret c

	call CheckMapCanWaterfall
	jr c, .failed
	ld hl, Script_WaterfallFromMenu
	call QueueScript
	ld a, $81
	ret

.failed
	call FieldMoveFailed
	ld a, $80
	ret

CheckMapCanWaterfall::
	ld a, [wPlayerDirection]
	and $c
	cp FACE_UP
	jr nz, .failed

if DEF(_CRYSTAL_BETA) || DEF(_CRYSTAL_RELEASE)
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	dec a
	ld e, a

	call GetCoordCollType
else
	ld a, [wTileUp]
endc
	call CheckWaterfallTile
	jr nz, .failed
	xor a
	ret

.failed
	scf
	ret

Script_WaterfallFromMenu:
	reloadmappart
	special UpdateTimePals

Script_UsedWaterfall:
	callasm GetPartyNickname
	writetext UseWaterfallText
	waitbutton
	closetext

Script_UsedWaterfallSilent::
	playsound SFX_BUBBLEBEAM
.loop
	applymovement PLAYER, .WaterfallStep
	callasm .CheckContinueWaterfall
	iffalse .loop
	end

.CheckContinueWaterfall:
	xor a
	ld [wScriptVar], a
	ld a, [wPlayerStandingTile]
	call CheckWaterfallTile
	ret z
	farcall StubbedTrainerRankings_Waterfall
	ld a, $1
	ld [wScriptVar], a
	ret

.WaterfallStep:
	turn_waterfall UP
	step_end

UseWaterfallText:
	text_far _UseWaterfallText
	text_end

TryWaterfallOW::
	ld d, WATERFALL
	call CheckPartyMove
	jr c, .failed
	ld a, HM_WATERFALL
	call CheckHMSilent
	jr c, .failed
	call CheckMapCanWaterfall
	jr c, .failed
	ld a, BANK(Script_AskWaterfall)
	ld hl, Script_AskWaterfall
	jmp CallScript

.failed
	ld a, BANK(Script_CantDoWaterfall)
	ld hl, Script_CantDoWaterfall
	jmp CallScript

Script_CantDoWaterfall:
	jumptext .HugeWaterfallText

.HugeWaterfallText:
	text_far _HugeWaterfallText
	text_end

Script_AskWaterfall:
	opentext
	writetext .AskWaterfallText
	yesorno
	iftrue Script_UsedWaterfall
	closetext
	end

.AskWaterfallText:
	text_far _AskWaterfallText
	text_end

; Output: $1 if Dig can be used as a field move.
TryDigSilent::
	call EscapeRopeOrDig.CheckCanDig
	ld b, a
	ret

DoEscapeRopeFromOW::
	ld a, $1
	jr DoDigFromOW.skip_type

DoDigFromOW::
	ld a, $2
.skip_type
	ld [wEscapeRopeOrDigType], a
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	call CopyBytes
	jmp GetPartyNickname

EscapeRopeFunction:
	call FieldMoveJumptableReset
	ld a, $1
	jr EscapeRopeOrDig

DigFunction:
	call FieldMoveJumptableReset
	ld a, $2

EscapeRopeOrDig:
	ld [wEscapeRopeOrDigType], a
.loop
	ld hl, .DigTable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.DigTable:
	dw .CheckCanDig
	dw .DoDig
	dw .FailDig

.CheckCanDig:
	call GetMapEnvironment
	cp CAVE
	jr z, .incave
	cp DUNGEON
	jr z, .incave
.fail
	ld a, $2
	ret

.incave
	ld hl, wDigWarpNumber
	ld a, [hli]
	and a
	jr z, .fail
	ld a, [hli]
	and a
	jr z, .fail
	ld a, [hl]
	and a
	jr z, .fail
	ld a, $1
	ret

.DoDig:
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	call CopyBytes
	call GetPartyNickname
	ld a, [wEscapeRopeOrDigType]
	cp $2
	jr nz, .escaperope
	ld hl, .UsedDigScript
	call QueueScript
	ld a, $81
	ret

.escaperope
	farcall SpecialKabutoChamber
	ld hl, .UsedEscapeRopeScript
	call QueueScript
	ld a, $81
	ret

.FailDig:
	ld a, [wEscapeRopeOrDigType]
	cp $2
	jr nz, .failescaperope
	ld hl, .CantUseDigText
	call MenuTextbox
	call WaitPressAorB_BlinkCursor
	call CloseWindow

.failescaperope
	ld a, $80
	ret

.UseDigText:
	text_far _UseDigText
	text_end

.UseEscapeRopeText:
	text_far _UseEscapeRopeText
	text_end

.CantUseDigText:
	text_far _CantUseDigText
	text_end

.WantToUseDigText:
	text_far _WantToUseDigText
	text_end

.WantToUseEscapeRopeText:
	text_far _WantToUseEscapeRopeText
	text_end

.UsedEscapeRopeScript:
	reloadmappart
	special UpdateTimePals
	writetext .UseEscapeRopeText
	sjump .UsedDigOrEscapeRopeScript

.UsedDigFromOWScript::
	opentext
	writetext .WantToUseDigText
	yesorno
	iffalse .RefusedToUseDig
	sjump .UsedDigSkipText

.UsedEscapeRopeFromOWScript::
	opentext
	writetext .WantToUseEscapeRopeText
	yesorno
	iffalse .RefusedToUseDig
	callasm SpecialKabutoChamber
	takeitem ESCAPE_ROPE
	sjump .UsedDigSkipText

.RefusedToUseDig
	closetext
	end

.UsedDigScript:
	reloadmappart
	special UpdateTimePals
	writetext .UseDigText

.UsedDigOrEscapeRopeScript:
	waitbutton
.UsedDigSkipText:
	closetext
	playsound SFX_WARP_TO
	applymovement PLAYER, .DigOut
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_DOOR
	playsound SFX_WARP_FROM
	applymovement PLAYER, .DigReturn
	end

.DigOut:
	step_dig 32
	hide_object
	step_end

.DigReturn:
	show_object
	return_dig 32
	step_end

; Output: $1 if Dig can be used as a field move.
TryTeleportSilent::
	call TeleportFunction.TryTeleport
	ld b, a
	ret

TeleportFunction::
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryTeleport
	dw .DoTeleport
	dw .FailTeleport

.TryTeleport:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, .CheckIfSpawnPoint
	jr .nope

.CheckIfSpawnPoint:
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	farcall IsSpawnPoint
	jr nc, .nope
	ld a, c
	ld [wDefaultSpawnpoint], a
	ld a, $1
	ret

.nope
	ld a, $2
	ret

.DoTeleport:
	call GetPartyNickname
	ld hl, .TeleportScript
	call QueueScript
	ld a, $81
	ret

.FailTeleport:
	ld hl, .CantUseTeleportText
	call MenuTextboxBackup
	ld a, $80
	ret

.TeleportReturnText:
	text_far _TeleportReturnText
	text_end

.WantToUseTeleportText:
	text_far _WantToUseTeleportText
	text_end

.CantUseTeleportText:
	text_far _CantUseTeleportText
	text_end

.TeleportFromOWScript::
	opentext
	writetext .WantToUseTeleportText
	yesorno
	iffalse .RefusedToUseTeleport
	sjump .TeleportSkipText

.RefusedToUseTeleport
	closetext
	end

.TeleportScript:
	reloadmappart
	special UpdateTimePals
	writetext .TeleportReturnText
	pause 60
	reloadmappart
.TeleportSkipText:
	closetext
	playsound SFX_WARP_TO
	applymovement PLAYER, .TeleportFrom
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_TELEPORT
	playsound SFX_WARP_FROM
	applymovement PLAYER, .TeleportTo
	farscall ArrestPlayerForTravellingScript
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end

StrengthFunction:
	call .TryStrength
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryStrength:
; Strength
	ld a, HM_STRENGTH
	call CheckHM
	ld a, $80
	ret c

	ld hl, Script_StrengthFromMenu
	call QueueScript
	ld a, $81
	ret

SetStrengthFlag::
	ld hl, wBikeFlags
	set BIKEFLAGS_STRENGTH_ACTIVE_F, [hl]
	ret

GetStrengthParams:
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wStrengthSpecies], a
	jmp GetPartyNickname

Script_StrengthFromMenu:
	reloadmappart
	special UpdateTimePals

Script_UsedStrength:
	callasm SetStrengthFlag
	callasm GetStrengthParams
	writetext .UseStrengthText
	readmem wStrengthSpecies
	cry 0 ; plays [wStrengthSpecies] cry
	pause 3
	writetext .MoveBoulderText
	closetext
	end

.UseStrengthText:
	text_far _UseStrengthText
	text_end

.MoveBoulderText:
	text_far _MoveBoulderText
	text_end

AskStrengthScript:
	callasm TryStrengthOW
	iffalse .AskStrength
	ifequal $1, .DontMeetRequirements
	sjump .AlreadyUsedStrength

.DontMeetRequirements:
	jumptext BouldersMayMoveText

.AlreadyUsedStrength:
	jumptext BouldersMoveText

.AskStrength:
	opentext
	writetext AskStrengthText
	yesorno
	iftrue Script_UsedStrength
	closetext
	end

AskStrengthText:
	text_far _AskStrengthText
	text_end

BouldersMoveText:
	text_far _BouldersMoveText
	text_end

BouldersMayMoveText:
	text_far _BouldersMayMoveText
	text_end

TryStrengthOW:
	ld d, STRENGTH
	call CheckPartyMove
	jr c, .nope

	ld a, HM_STRENGTH
	call CheckHMSilent
	jr c, .nope

	ld hl, wBikeFlags
	bit BIKEFLAGS_STRENGTH_ACTIVE_F, [hl]
	jr z, .already_using

	ld a, 2
	jr .done

.nope
	ld a, 1
	jr .done

.already_using
	xor a
	; fallthrough.

.done
	ld [wScriptVar], a
	ret

WhirlpoolFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryWhirlpool
	dw .DoWhirlpool
	dw .FailWhirlpool

.TryWhirlpool:
	ld a, HM_WHIRLPOOL
	call CheckHM
	jr c, .notOwned

	call TryWhirlpoolMenu
	jr c, .failed
	ld a, $1
	ret

.failed
	ld a, $2
	ret

.notOwned
	ld a, $80
	ret

.DoWhirlpool:
	ld hl, Script_WhirlpoolFromMenu
	call QueueScript
	ld a, $81
	ret

.FailWhirlpool:
	call FieldMoveFailed
	ld a, $80
	ret

UseWhirlpoolText:
	text_far _UseWhirlpoolText
	text_end

TryWhirlpoolMenu::
	call GetFacingTileCoordAndCollType
	ld c, a
	push de
	call CheckWhirlpoolTile
	pop de
	jr c, .failed
	call GetBlockLocation
	ld c, [hl]
	push hl
	ld hl, WhirlpoolBlockPointers
	call CheckOverworldTileArrays
	pop hl
	jr nc, .failed
	; Save the Whirlpool field move data
	ld a, l
	ld [wCutWhirlpoolOverworldBlockAddr], a
	ld a, h
	ld [wCutWhirlpoolOverworldBlockAddr + 1], a
	ld a, b
	ld [wCutWhirlpoolReplacementBlock], a
	ld a, c
	ld [wCutWhirlpoolAnimationType], a
	xor a
	ret

.failed
	scf
	ret

Script_WhirlpoolFromMenu:
	reloadmappart
	special UpdateTimePals

Script_UsedWhirlpool:
	callasm GetPartyNickname
	writetext UseWhirlpoolText
	reloadmappart
	callasm DisappearWhirlpool
	closetext
	end

DisappearWhirlpool::
	ld hl, wCutWhirlpoolOverworldBlockAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCutWhirlpoolReplacementBlock]
	ld [hl], a
	xor a
	ldh [hBGMapMode], a
	call OverworldTextModeSwitch
	ld a, [wCutWhirlpoolAnimationType]
	ld e, a
	farcall PlayWhirlpoolSound
	call BufferScreen
	jmp GetMovementPermissions

TryWhirlpoolOW::
	ld d, WHIRLPOOL
	call CheckPartyMove
	jr c, .failed
	ld a, HM_WHIRLPOOL
	call CheckHMSilent
	jr c, .failed
	call TryWhirlpoolMenu
	jr c, .failed
	ld a, BANK(Script_AskWhirlpoolOW)
	ld hl, Script_AskWhirlpoolOW
	jmp CallScript

.failed
	ld a, BANK(Script_MightyWhirlpool)
	ld hl, Script_MightyWhirlpool
	jmp CallScript

Script_MightyWhirlpool:
	jumptext .MayPassWhirlpoolText

.MayPassWhirlpoolText:
	text_far _MayPassWhirlpoolText
	text_end

Script_AskWhirlpoolOW:
	opentext
	writetext AskWhirlpoolText
	yesorno
	iftrue Script_UsedWhirlpool
	closetext
	end

AskWhirlpoolText:
	text_far _AskWhirlpoolText
	text_end

HeadbuttFunction:
	call TryHeadbuttFromMenu
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

TryHeadbuttFromMenu:
	call GetFacingTileCoordAndCollType
	call CheckHeadbuttTreeTile
	jr nz, .no_tree

	ld hl, HeadbuttFromMenuScript
	call QueueScript
	ld a, $81
	ret

.no_tree
	call FieldMoveFailed
	ld a, $80
	ret

UseHeadbuttText:
	text_far _UseHeadbuttText
	text_end

HeadbuttNothingText:
	text_far _HeadbuttNothingText
	text_end

HeadbuttFromMenuScript:
	reloadmappart
	special UpdateTimePals

HeadbuttScript:
	callasm GetPartyNickname
	writetext UseHeadbuttText

	reloadmappart
	callasm ShakeHeadbuttTree

	callasm TreeMonEncounter
	iffalse .no_battle
	closetext
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.no_battle
	writetext HeadbuttNothingText
	waitbutton
	closetext
	end

TryHeadbuttOW::
	ld d, HEADBUTT
	call CheckPartyMove
	jr c, .no

	ld a, BANK(AskHeadbuttScript)
	ld hl, AskHeadbuttScript
	jmp CallScript

.no
	xor a
	ret

AskHeadbuttScript:
	opentext
	writetext AskHeadbuttText
	yesorno
	iftrue HeadbuttScript
	closetext
	end

AskHeadbuttText:
	text_far _AskHeadbuttText
	text_end

RockSmashFunction:
	call TryRockSmashFromMenu
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

TryRockSmashFromMenu:
	call GetFacingObject
	jr c, .no_rock
	ld a, d
	and LOW(~CLAP_F)
	cp SPRITEMOVEDATA_SMASHABLE_ROCK
	jr nz, .no_rock

	ld hl, RockSmashFromMenuScript
	call QueueScript
	ld a, $81
	ret

.no_rock
	call FieldMoveFailed
	ld a, $80
	ret

GetFacingObject:
	farcall CheckFacingObject
	jr nc, .fail

	ldh a, [hObjectStructIndex]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ldh [hLastTalked], a
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	ld d, a
	and a
	ret

.fail
	scf
	ret

RockSmashFromMenuScript:
	reloadmappart
	special UpdateTimePals

RockSmashScript:
	callasm GetPartyNickname
	writetext UseRockSmashText
	closetext
RockSmashScriptNoText::
	special WaitSFX
	playsound SFX_STRENGTH
	earthquake 84
	applymovementlasttalked MovementData_RockSmash
	disappear -2

	callasm RockMonEncounter
	readmem wTempWildMonSpecies
	iffalse .done
	randomwildmon
	startbattle
	reloadmapafterbattle
.done
	end

MovementData_RockSmash:
	rock_smash 10
	step_end

UseRockSmashText:
	text_far _UseRockSmashText
	text_end

AskRockSmashScript:
	callasm HasRockSmash
	ifequal 1, .no

	opentext
	writetext AskRockSmashText
	yesorno
	iftrue RockSmashScript
	closetext
	end
.no
	jumptext MaySmashText

MaySmashText:
	text_far _MaySmashText
	text_end

AskRockSmashText:
	text_far _AskRockSmashText
	text_end

HasRockSmash:
	ld d, ROCK_SMASH
	call CheckPartyMove
	jr nc, .yes
; no
	ld a, 1
	jr .done
.yes
	xor a
	; fallthrough.
.done
	ld [wScriptVar], a
	ret

FishFunction:
	ld a, e
	push af
	call FieldMoveJumptableReset
	pop af
	ld [wFishingRodUsed], a
.loop
	ld hl, .FishTable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.FishTable:
	dw .TryFish
	dw .FishNoBite
	dw .FishGotSomething
	dw .FailFish
	dw .FishNoFish

.TryFish:
	ld a, [wUsingItemWithSelect]
	and a
	jr z, .skip_screen_refresh

	call RefreshScreen
.skip_screen_refresh
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .fail
	cp PLAYER_SURF_PIKA
	jr z, .fail
	call GetFacingTileCoordAndCollType
	call GetTileCollision
	cp WATER_TILE
	jr nz, .fail
	farcall CheckFacingObject
	jr nc, .facingwater
.fail
	ld a, $3
	ret

.facingwater
	call GetFishingGroup
	and a
	jr nz, .goodtofish
	ld a, $4
	ret

.goodtofish
	ld d, a
	ld a, [wFishingRodUsed]
	ld e, a
	farcall Fish
	ld a, d
	and a
	jr z, .nonibble
	ld [wTempWildMonSpecies], a
	ld a, e
	ld [wCurPartyLevel], a
	ld a, BATTLETYPE_FISH
	ld [wBattleType], a
	ld a, $2
	ret

.nonibble
	ld a, $1
	ret

.FailFish:
	ld a, $80
	ret

.FishGotSomething:
	ld a, $1
	ld [wFishingResult], a
	ld hl, Script_GotABite
	call QueueScript
	ld a, $81
	ret

.FishNoBite:
	ld a, $2
	ld [wFishingResult], a
	ld hl, Script_NotEvenANibble
	call QueueScript
	ld a, $81
	ret

.FishNoFish:
	ld a, $0
	ld [wFishingResult], a
	ld hl, Script_NotEvenANibble2
	call QueueScript
	ld a, $81
	ret

Script_NotEvenANibble:
	scall Script_FishCastRod
	writetext RodNothingText
	sjump Script_NotEvenANibble_FallThrough

Script_NotEvenANibble2:
	scall Script_FishCastRod
	writetext RodNothingText

Script_NotEvenANibble_FallThrough:
	callasm PutTheRodAway
	closetext
	loademote EMOTE_SHADOW
	end

Script_GotABite:
	scall Script_FishCastRod
	callasm Fishing_CheckFacingUp
	iffalse .NotFacingUp
	applymovement PLAYER, .Movement_FacingUp
	sjump .FightTheHookedPokemon

.NotFacingUp:
	applymovement PLAYER, .Movement_NotFacingUp

.FightTheHookedPokemon:
	pause 40
	applymovement PLAYER, .Movement_RestoreRod
	writetext RodBiteText
	callasm PutTheRodAway
	closetext
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.Movement_NotFacingUp:
	fish_got_bite
	fish_got_bite
	fish_got_bite
	fish_got_bite
	show_emote
	step_end

.Movement_FacingUp:
	fish_got_bite
	fish_got_bite
	fish_got_bite
	fish_got_bite
	step_sleep 1
	show_emote
	step_end

.Movement_RestoreRod:
	hide_emote
	fish_cast_rod
	step_end

Fishing_CheckFacingUp:
	ld a, [wPlayerDirection]
	and $c
	cp OW_UP
	ld a, $1
	jr z, .up
	xor a

.up
	ld [wScriptVar], a
	ret

Script_PullOutSquirtbottle::
	;reloadmappart
	loadmem hBGMapMode, $0
	special UpdateTimePals
	applymovement PLAYER, .MovementData_PullOutSquirtbottle
	callasm LoadSquirtbottleGFX
rept 5
	playsound SFX_POWDER
	pause 2
	loademote EMOTE_SPRINKLE_2
	pause 2
	loademote EMOTE_SPRINKLE_3
	playsound SFX_POWDER
	pause 2
	loademote EMOTE_SPRINKLE_4
	pause 2
	loademote EMOTE_SPRINKLE_1
endr
	pause 2
	loademote EMOTE_SPRINKLE_2
	pause 2
	loademote EMOTE_SPRINKLE_3
	applymovement PLAYER, .HideEmote
	end

.MovementData_PullOutSquirtbottle:
	pull_out_squirtbottle
	step_end

.HideEmote:
	hide_emote
	step_sleep 1
	step_end

Script_FishCastRod:
	;reloadmappart
	loadmem hBGMapMode, $0
	special UpdateTimePals
	loademote EMOTE_ROD
	callasm LoadFishingGFX
	loademote EMOTE_SHOCK
	applymovement PLAYER, .MovementData_CastRod
	pause 40
	end

.MovementData_CastRod:
	fish_cast_rod
	step_end

PutTheRodAway:
	xor a
	ldh [hBGMapMode], a
	ld a, OBJECT_ACTION_STAND
	ld [wPlayerAction], a
	call UpdateSprites
	jmp UpdatePlayerSprite

RodBiteText:
	text_far _RodBiteText
	text_end

RodNothingText:
	text_far _RodNothingText
	text_end

; Returns Z if can get on the bike. Carry otherwise.
; This doesn't check if the player owns a bike.
TryBikeSilent::
	call BikeFunction.CheckEnvironment
	ret c

	ld a, [wPlayerState]
	cp PLAYER_NORMAL
	ret z

	cp PLAYER_CLAP
	ret z

	cp PLAYER_BIKE
	ret z

	scf
	ret

BikeFunction:
	call .TryBike
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryBike:
	call .CheckEnvironment
	jp c, .CannotUseBike
	ld a, [wPlayerState]
	cp PLAYER_NORMAL
	jr z, .GetOnBike
	cp PLAYER_CLAP
	jr z, .GetOnBike
	cp PLAYER_BIKE
	jr z, .GetOffBike
	jr .CannotUseBike

.GetOnBike:
	ld hl, Script_GetOnBike
	ld de, Script_GetOnBike_Register
	call .CheckIfRegistered
	call QueueScript




	; From here down, the code is about starting the music of the bike.
	; during the rave party, we don't play the bike music!
	ld a, [wMapGroup]
	cp GROUP_CINNABAR_ISLAND
	jr nz, .skip_rave_party
	ld a, [wMapNumber]
	cp MAP_CINNABAR_ISLAND
	jr nz, .skip_rave_party

	; check the rave party event flag.
	ld b, CHECK_FLAG
	ld de, EVENT_CINNABAR_RAVE_PARTY
	call EventFlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr z, .skip_rave_party	; false.
	jr .quit_function ; true.
.skip_rave_party:

	; We don't play the bike music in cerulean cave if Mewtwo hasn't been caught yet.
	ld a, [wMapGroup]
	cp GROUP_CERULEAN_CAVE_ENTRANCE
	jr nz, .skip_cerulean_cave

	ld a, [wMapNumber]
	cp MAP_CERULEAN_CAVE_ENTRANCE
	jr c, .skip_cerulean_cave ; false

	cp MAP_CERULEAN_CAVE_B3F + 1
	jr nc, .skip_cerulean_cave ; false

	jr .quit_function ; true.

.skip_cerulean_cave:
	xor a
	ld [wMusicFade], a
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	call MaxVolume
	ld de, MUSIC_BICYCLE
	ld a, e
	ld [wMapMusic], a
	call PlayMusic

.quit_function:
	ld a, $1
	ret

.GetOffBike:
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .CantGetOffBike
	ld hl, Script_GetOffBike
	ld de, Script_GetOffBike_Register
	call .CheckIfRegistered
	ld a, BANK(Script_GetOffBike)
	jr .done

.CantGetOffBike:
	ld hl, Script_CantGetOffBike
	jr .done

.CannotUseBike:
	ld a, $0
	ret

.done
	call QueueScript
	ld a, $1
	ret

.CheckIfRegistered:
	ld a, [wUsingItemWithSelect]
	and a
	ret z
	ld h, d
	ld l, e
	ret

.CheckEnvironment:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, .ok
	cp CAVE
	jr z, .ok
	cp GATE
	jr z, .ok
	jr .nope

.ok
	call GetPlayerStandingTile
	and $f ; lo nybble only
	jr nz, .nope ; not FLOOR_TILE
	xor a
	ret

.nope
	scf
	ret

Script_GetOnBike:
	reloadmappart
	special UpdateTimePals
	loadvar VAR_MOVEMENT, PLAYER_BIKE
	writetext GotOnBikeText
	waitbutton
	closetext
	special UpdatePlayerSprite
	end

Script_GetOnBike_Register:
	loadvar VAR_MOVEMENT, PLAYER_BIKE
	special UpdatePlayerSprite
	end

Script_GetOffBike:
	reloadmappart
	special UpdateTimePals
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	writetext GotOffBikeText
	waitbutton

FinishGettingOffBike:
	closetext
.registered
	special UpdatePlayerSprite
	special PlayMapMusic
	end

Script_GetOffBike_Register:
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	sjump FinishGettingOffBike.registered

Script_CantGetOffBike:
	opentext
	writetext .CantGetOffBikeText
	waitbutton
	closetext
	end

.CantGetOffBikeText:
	text_far _CantGetOffBikeText
	text_end

GotOnBikeText:
	text_far _GotOnBikeText
	text_end

GotOffBikeText:
	text_far _GotOffBikeText
	text_end

TryCutOW::
	ld d, CUT
	call CheckPartyMove
	jr c, .cant_cut

	ld a, HM_CUT
	call CheckHMSilent
	jr c, .cant_cut

	ld a, BANK(AskCutScript)
	ld hl, AskCutScript
	jmp CallScript

.cant_cut
	ld a, BANK(CantCutScript)
	ld hl, CantCutScript
	jmp CallScript

AskCutScript:
	opentext
	writetext AskCutText
	yesorno
	iffalse .declined
	callasm .CheckMap
	iftrue Script_Cut
.declined
	closetext
	end

.CheckMap:
	xor a
	ld [wScriptVar], a
	call CheckMapForSomethingToCut
	ret c
	ld a, TRUE
	ld [wScriptVar], a
	ret

AskCutText:
	text_far _AskCutText
	text_end

CantCutScript:
	jumptext CanCutText

CanCutText:
	text_far _CanCutText
	text_end

; Input: none.
; Output: the follower NPC's action in wScriptVar. 
GetFollowerAction::
    ld a, [wObjectFollow_Follower]
    ld hl, wPlayerAction
    ld bc, OBJECT_LENGTH
    call AddNTimes
    ld a, [hl]
    ld [wScriptVar], a
    ret
