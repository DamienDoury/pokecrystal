INCLUDE "constants.asm"


SECTION "Events", ROMX

OverworldLoop::
	xor a ; MAPSTATUS_START
	ld [wMapStatus], a
.loop
	ld a, [wMapStatus]
	ld hl, .Jumptable
	rst JumpTable
	ld a, [wMapStatus]
	cp MAPSTATUS_DONE
	jr nz, .loop
.done
	ret

.Jumptable:
; entries correspond to MAPSTATUS_* constants
	dw StartMap
	dw EnterMap
	dw HandleMap
	dw .done

DisableEvents:
	xor a
	ld [wScriptFlags2], a
	ret

EnableEvents::
	ld a, $ff
	ld [wScriptFlags2], a
	ret

EnableWildEncounters:
	ld hl, wScriptFlags2
	set 4, [hl]
	ret

CheckWarpConnxnScriptFlag:
	ld hl, wScriptFlags2
	bit 2, [hl]
	ret

CheckCoordEventScriptFlag:
	ld hl, wScriptFlags2
	bit 1, [hl]
	ret

CheckStepCountScriptFlag:
	ld hl, wScriptFlags2
	bit 0, [hl]
	ret

CheckWildEncountersScriptFlag:
	ld hl, wScriptFlags2
	bit 4, [hl]
	ret

StartMap:
	xor a
	ld [wScriptVar], a
	xor a
	ld [wScriptRunning], a
	ld hl, wMapStatus
	ld bc, wMapStatusEnd - wMapStatus
	call ByteFill
	farcall InitCallReceiveDelay
	call ClearJoypad
EnterMap:
	xor a
	ld [wXYComparePointer], a
	ld [wXYComparePointer + 1], a
	call SetUpFiveStepWildEncounterCooldown
	farcall RunMapSetupScript
	call DisableEvents

	ldh a, [hMapEntryMethod]
	cp MAPSETUP_CONNECTION
	jr nz, .dont_enable
	call EnableEvents
.dont_enable

	ldh a, [hMapEntryMethod]
	cp MAPSETUP_RELOADMAP
	jr nz, .dontresetpoison
	xor a
	ld [wPoisonStepCount], a
.dontresetpoison

	xor a ; end map entry
	ldh [hMapEntryMethod], a
	ld a, MAPSTATUS_HANDLE
	ld [wMapStatus], a
	ret

HandleMap:
	call ResetOverworldDelay
	call HandleMapTimeAndJoypad
	farcall HandleCmdQueue ; no need to farcall
	call MapEvents

; Not immediately entering a connected map will cause problems.
	ld a, [wMapStatus]
	cp MAPSTATUS_HANDLE
	ret nz

	call HandleMapObjects
	call NextOverworldFrame
	call HandleMapBackground
	call CheckPlayerState
	call ClappingModeCheck
	call AnimatePlayerClap
	; fallthrough.

ClappingAutoSFX:
	ld hl, wClappingData
	bit CLAP_BEHAVIOUR_BIT, [hl]
	jr z, .TryEndClapping

	; Trying to start the clapping SFX.
	call CheckSFX
	ret c

	ld de, SFX_CHEERING
	jp PlaySFX

.TryEndClapping
	call CheckSFX
	ret nc
	
	farcall StopSFX
	ret

ClappingModeCheck:
	farcall IsClappingAuthorized
	jr nc, .TryEndClapping

	; Trying to activate the clapping.
	ld hl, wClappingData
	bit CLAP_BEHAVIOUR_BIT, [hl]
	ret nz

	; Activation checks success.
	set CLAP_BEHAVIOUR_BIT, [hl]

	farcall UpdateSpriteVariants
	ret

.TryEndClapping
	ld hl, wClappingData
	bit CLAP_BEHAVIOUR_BIT, [hl]
	ret z

	; Deactivation checks success.
	res CLAP_BEHAVIOUR_BIT, [hl]

	farcall UpdateSpriteVariants
	ret

AnimatePlayerClap:
	ld a, [wPlayerState]
	cp PLAYER_CLAP
	ret nz
	
	ld a, [wClappingData]
	and CLAPPING_IDLE_FRAMES_MASK ; We mask out the countdown.
	ret z ; If the countdown has already reached 0, no need to decrease it.

	dec a
	ld b, a
	jr nz, .save_countdown

; When the countdown reaches 0, we update the player sprite to its normal behaviour.
	push bc
	farcall SetNormalStateIfClapping
	pop bc

.save_countdown
	ld a, [wClappingData]
	and ~CLAPPING_IDLE_FRAMES_MASK
	or b
	ld [wClappingData], a
	ret

MapEvents:
	ld a, [wMapEventStatus]
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable:
; entries correspond to MAPEVENTS_* constants
	dw .events
	dw .no_events

.events:
	call PlayerEvents
	call DisableEvents
	farcall ScriptEvents
	ret

.no_events:
	ret

MaxOverworldDelay:
	db 2

ResetOverworldDelay:
	ld a, [MaxOverworldDelay]
	ld [wOverworldDelay], a
	ret

NextOverworldFrame:
	ld a, [wOverworldDelay]
	and a
	ret z

	ld c, a
	jp DelayFrames

HandleMapTimeAndJoypad:
	ld a, [wMapEventStatus]
	cp MAPEVENTS_OFF
	ret z

	call UpdateTime
	call GetJoypad
	jp TimeOfDayPals

HandleMapBackground:
	farcall _UpdateSprites
	farcall ScrollScreen
	farcall PlaceMapNameSign
	ret

CheckPlayerState:
	ld a, [wPlayerStepFlags]
	bit PLAYERSTEP_CONTINUE_F, a
	jr z, .events
	bit PLAYERSTEP_STOP_F, a
	jr z, .noevents
	bit PLAYERSTEP_MIDAIR_F, a
	jr nz, .noevents
	call EnableEvents
.events
	ld a, MAPEVENTS_ON
	ld [wMapEventStatus], a
	ret

.noevents
	ld a, MAPEVENTS_OFF
	ld [wMapEventStatus], a
	ret

HandleMapObjects:
	farcall HandleNPCStep
	farcall _HandlePlayerStep
	; fallthrough.

_CheckObjectEnteringVisibleRange:
	ld hl, wPlayerStepFlags
	bit PLAYERSTEP_STOP_F, [hl]
	ret z

	farcall CheckObjectEnteringVisibleRange
	ret

PlayerEvents:
	xor a
; If there's already a player event, don't interrupt it.
	ld a, [wScriptRunning]
	and a
	ret nz

	call CheckTrainerBattle_GetPlayerEvent
	jr c, .ok

	call CheckTileEvent
	jr c, .ok

	call RunMemScript
	jr c, .ok

	call RunSceneScript
	jr c, .ok

	call CheckTimeEvents
	jr c, .ok

	call OWPlayerInput
	jr c, .ok

	xor a
	ret

.ok
	push af
	farcall EnableScriptMode
	pop af

	ld [wScriptRunning], a
	call DoPlayerEvent
	ld a, [wScriptRunning]
	cp PLAYEREVENT_CONNECTION
	jr z, .ok2
	cp PLAYEREVENT_JOYCHANGEFACING
	jr z, .ok2

	xor a
	ld [wLandmarkSignTimer], a

.ok2
	scf
	ret

CheckTrainerBattle_GetPlayerEvent:
	nop
	nop
	call CheckTrainerBattle
	jr nc, .nope

if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	ld a, [wPreventTrainerBattles]
	cp TRUE
	jr z, .nope
endc

	ld a, PLAYEREVENT_SEENBYTRAINER
	scf
	ret

.nope
	xor a
	ret

CheckTileEvent:
; Check for warps, coord events, or wild battles.

	call CheckWarpConnxnScriptFlag
	jr z, .connections_disabled

	farcall CheckMovingOffEdgeOfMap
	jr c, .map_connection

	call CheckWarpTile
	jr c, .warp_tile

	farcall ViridianWarp

.connections_disabled
	call CheckCoordEventScriptFlag
	jr z, .coord_events_disabled

	call CheckCurrentMapCoordEvents
	jr c, .coord_event

.coord_events_disabled
	call CheckStepCountScriptFlag
	jr z, .step_count_disabled

	call CountStep
	ret c

.step_count_disabled
	call CheckWildEncountersScriptFlag
	jr z, .ok

	call RandomEncounter
	ret c

.ok
	xor a
	ret

.map_connection
	ld a, PLAYEREVENT_CONNECTION
	scf
	ret

.warp_tile
	ld a, [wPlayerStandingTile]
	call CheckPitTile
	jr nz, .not_pit
	ld a, PLAYEREVENT_FALL
	scf
	ret

.not_pit
	ld a, PLAYEREVENT_WARP
	scf
	ret

.coord_event
	ld hl, wCurCoordEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetMapScriptsBank
	jp CallScript

CheckWildEncounterCooldown::
	ld hl, wWildEncounterCooldown
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret z
	scf
	ret

SetUpFiveStepWildEncounterCooldown:
	ld a, 5
	ld [wWildEncounterCooldown], a
	ret

SetMinTwoStepWildEncounterCooldown:
; dummied out
	ret
	ld a, [wWildEncounterCooldown]
	cp 2
	ret nc
	ld a, 2
	ld [wWildEncounterCooldown], a
	ret

RunSceneScript:
	ld a, [wCurMapSceneScriptCount]
	and a
	jr z, .nope

	cp -1
	jr z, .priority_script_once

	ld c, a
	call CheckScenes
	ld hl, wCurMapSceneScriptsPointer
	ld e, 0
	cp SCENE_ALWAYS
	jr z, .ok
	
	cp c
	jr nc, .nope

	add a ; There should not be more than $7f scene IDs per map, otherwise this will overflow. We have a safe margin.
	ld e, a
.ok
	ld d, 0
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de

	call GetMapScriptsBank
	call GetFarWord
	call GetMapScriptsBank
	call CallScript

	ld hl, wScriptFlags
	res 3, [hl]

	farcall EnableScriptMode
	farcall ScriptEvents

	ld hl, wScriptFlags
	bit 3, [hl]
	jr z, .nope

.priority_script_once
	ld a, [wCurMapSceneScriptCount]
	cp -1
	jr nz, .scene_script_count_reset

	xor a
	ld [wCurMapSceneScriptCount], a

.scene_script_count_reset
	ld hl, wPriorityScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPriorityScriptBank]
	jp CallScript

.nope
	xor a
	ret

CheckTimeEvents:
	ld a, [wLinkMode]
	and a
	jr nz, .nothing

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr z, .do_daily

	farcall CheckBugContestTimer
	jr c, .end_bug_contest
	xor a
	ret

.do_daily
	farcall CheckDailyResetTimer
	farcall CheckPokerusTickAndHospitalVisits
	farcall CheckPhoneCall
	ret c

.nothing
	xor a
	ret

.end_bug_contest
	ld a, BANK(BugCatchingContestOverScript)
	ld hl, BugCatchingContestOverScript
	jp CallScript

OWPlayerInput:
	call PlayerMovement
	ret c
	
	and a
	jr nz, .NoAction

; Can't perform button actions while sliding on ice.
	farcall CheckStandingOnIce
	jr c, .NoAction

	call CheckAPressOW
	jr c, .Action

	call CheckLongBPressOW
	jr c, .Action

	xor a
	ldh [hMenuReturn], a

	call CheckLongSelectPressOW
	jr c, .Action

	call CheckLongStartPressOW
	jr c, .Action

.NoAction:
	xor a
	ret

.Action:
	push af
	farcall StopPlayerForEvent
	pop af
	scf
	ret

LONG_PRESS_FRAMES_DURATION EQU 10

CheckAPressOW::
	ldh a, [hJoypadDown]
	and A_BUTTON
	ret z

	ld a, [wOptions2]
	bit FIELD_MOVES, a
	jr z, .check_pressed_this_frame

	ldh a, [hLongPressA]
	and a
	jr z, .check_pressed_this_frame ; The increment can only start once the hLongPressA has been set to 1 when A is first pressed down.

	ldh a, [hJoypadDown]
	cp A_BUTTON
	jr nz, .cancel_long_press ; If the player is pressing any other button, cancel the long press.

	ldh a, [hLongPressA]
	inc a
	ldh [hLongPressA], a ; Increase the longpress frame counter.
	cp LONG_PRESS_FRAMES_DURATION
	jr c, .check_pressed_this_frame

	xor a
	ldh [hLongPressA], a ; Preventing infinite triggers.

; Grass action check (either Cut or Sweet Scent).
	call IsPlayerFacingGrassWhileStandingOutsideOfGrass
	jr c, .try_to_cut_grass

.try_sweet_scent ; Try to use sweet scent.
	call CanUseSweetScent
	jr nc, .check_pressed_this_frame ; Don't use sweet scent if wild pokemon can't appear on this tile.

	ld d, SWEET_SCENT
	farcall CheckPartyMove
	jr c, .check_pressed_this_frame

	farcall HideMapNameSign
	call OpenTextPre
	call OpenTextPost
	ld a, BANK(SweetScentScript)
	ld hl, SweetScentScript
	jp CallScript

.try_to_cut_grass ; Try to cut grass, while standing outside the edge of a patch.
	call .try_to_cut
	jr c, .check_pressed_this_frame
	ret

.cancel_long_press
	xor a
	ldh [hLongPressA], a

.check_pressed_this_frame
	ldh a, [hJoyPressed]
	and A_BUTTON
	ret z

	ld a, 1
	ldh [hLongPressA], a ; Initiates a long press.

	call TryObjectEvent
	ret c
	call TryBGEvent
	ret c
	call TryTileCollisionEvent
	ret c
	call TryFarNPCOnlyEvent
	ret c

if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	ld a, [wTilePermissionCheat]
	xor 1
	ld [wTilePermissionCheat], a
	and a
	jr z, .enable_collisions

; disable collisions
	xor a
	ld [wTileDown], a
	ld [wTileUp], a
	ld [wTileLeft], a
	ld [wTileRight], a
	ld [wTilePermissions], a
	jr .cheat_end

.enable_collisions
	call GetMovementPermissions

.cheat_end
endc

	; Clapping.
	ldh a, [hJoypadDown]
	cp A_BUTTON
	jr nz, .return_no_action ; If the player is pressing any other button, cancel the clap.

	farcall IsClappingAuthorized
	jr nc, .return_no_action

	; Delay between 2 claps.
	ld a, [wClappingData]
	and CLAPPING_IDLE_FRAMES_MASK
	cp CLAPPING_IDLE_FRAMES_MASK + 1 - MIN_CLAPPING_DELAY
	jr nc, .return_no_action

	; Can't clap while surfing or biking. You can only clap from the normal state, or when already clapping.
	ld hl, wPlayerState
	ld a, [hl]
	cp PLAYER_CLAP + 1
	jr nc, .return_no_action

	; Clap is validated.

	ld hl, wClappingData
	set CLAPPED_IN_THIS_ROOM_BIT, [hl]

	cp PLAYER_CLAP
	jr z, .skip_sprite_update

	; We load the clapping sprite variant of the player.
	ld a, PLAYER_CLAP
	ld [wPlayerState], a
	call UpdatePlayerSprite

.skip_sprite_update
	; We reset the clap countdown, for animation timing purposes.
	ld a, [wClappingData]
	or CLAPPING_IDLE_FRAMES_MASK
	ld [wClappingData], a

	call .increase_clap_count

	ld de, SFX_CLAP_3
	;ld a, SFX_CLAP_3 - SFX_CLAP_1
	;call RandomRange
	;add a
	;add e
	;ld e, a ; When using different sound effects, the audio doesn't transition well. Whereas the same SFX perfectly chains up.
	call PlaySFX
	farcall NursesBowWhenClappedAt
	farcall UpdatePlayerClapAnimation

.return_no_action
	xor a
	ret

.increase_clap_count
	ld hl, wClapCount
	inc [hl] ; The low byte can always overflow, even if the 2 byte value is maxxed out, so the happiness can increase indefinitely. 
	jr nz, .check_clap_count

	inc hl
	ld a, $ff
	cp [hl]
	jr z, .check_clap_count

	inc [hl]
	dec hl

.check_clap_count
	ld a, [hl]
	and $1f
	cp $1f
	ret nz

	; Every 32 claps, the happiness increases.
	farcall IncreasePartyHappiness
	ret

.try_to_cut::
	farcall CutFunction.CheckAbleSilent ; Calls CheckHM and CheckMapForSomethingToCut.
	ret c

	ld d, CUT
	farcall CheckPartyMove ; Sets wCurPartyMon for PlayMonCry.
	ret c

	call OpenTextPre
	call OpenTextPost

	farcall PlayCurPartyMonCry

	farcall CutDownTreeOrGrass
	call CloseText
	farcall HideMapNameSign
	xor a
	ret

CheckLongBPressOW:
	ld a, [wOptions2]
	bit FIELD_MOVES, a
	ret z

	ldh a, [hJoypadDown]
	and B_BUTTON
	ret z

	ldh a, [hLongPressB]
	and a
	jr z, .check_pressed_this_frame ; The increment can only start once the hLongPressB has been set to 1 when B is first pressed down.

	ldh a, [hJoypadDown]
	cp B_BUTTON
	jr nz, .cancel_long_press ; If the player is pressing any other button, cancel the long press.

	ldh a, [hLongPressB]
	inc a
	ldh [hLongPressB], a ; Increase the longpress frame counter.
	cp LONG_PRESS_FRAMES_DURATION
	jr c, .check_pressed_this_frame

	xor a
	ldh [hLongPressB], a ; Preventing infinite triggers.

	; Escape method check: either Fly or Dig. Also Teleport?
	ld d, FLY
	farcall CheckPartyMove ; Sets wCurPartyMon for TownMapMon.
	jr c, .try_dig

	farcall TryFlySilent
	ld a, b
	cp $1
	jr nz, .try_dig ; If Fly can't be used, try Dig.

	call OpenTextPre
	call OpenTextPost
	call FadeToMenu
	farcall TryFlyFromOW
	ld a, b

	cp $1
	jr nz, .close_menu_after_cancel ; If Fly has been cancelled or failed, return to the map.

	call ExitAllMenus

	ld a, BANK(FlyFunction)
	ld hl, FlyFunction.FlyScript
	jp CallScript

.close_menu_after_cancel
; This is a copy of ExitAllMenus.
	call ExitAllMenus
	farcall HideMapNameSign
	call CloseText
	xor a
	ret

.try_dig
	ld d, DIG
	farcall CheckPartyMove ; Sets wCurPartyMon for GetPartyNickname.
	jr c, .try_escape_rope

	farcall TryDigSilent
	ld a, b
	cp $1
	jr nz, .try_escape_rope ; If Dig can't be used, try Teleport.

	farcall DoDigFromOW
	ld a, BANK(EscapeRopeOrDig.UsedDigFromOWScript)
	ld hl, EscapeRopeOrDig.UsedDigFromOWScript
	jp CallScript

.cancel_long_press
	xor a
	ldh [hLongPressB], a

.check_pressed_this_frame
	ldh a, [hJoyPressed]
	and B_BUTTON
	ret z

	ld a, 1
	ldh [hLongPressB], a ; Initiates a long press.
	xor a
	ret

.try_escape_rope
	; Check if we can dig in here.
	farcall TryDigSilent
	ld a, b
	cp $1
	jr nz, .try_teleport

	; Check if player has an escape rope.
	ld a, ESCAPE_ROPE
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .try_teleport

	; Ask for confirmation, and then consumes item and trigger the effect.
	farcall DoEscapeRopeFromOW
	ld a, BANK(EscapeRopeOrDig.UsedEscapeRopeFromOWScript)
	ld hl, EscapeRopeOrDig.UsedEscapeRopeFromOWScript
	jp CallScript

.try_teleport ; Put at the bottom, so we can keep using jr instead of jp above.
	ld d, TELEPORT
	farcall CheckPartyMove ; Sets wCurPartyMon for GetPartyNickname.
	jr c, .check_pressed_this_frame
	
	farcall TryTeleportSilent
	ld a, b
	cp $1
	jr nz, .check_pressed_this_frame ; If Teleport can't be used, then stop here.

	farcall GetPartyNickname
	ld a, BANK(TeleportFunction.TeleportFromOWScript)
	ld hl, TeleportFunction.TeleportFromOWScript
	jp CallScript

CheckLongSelectPressOW:
	ldh a, [hJoypadDown]
	and SELECT
	jr z, .check_short_press

	ldh a, [hLongPressSelect]
	and a
	jr z, .check_pressed_this_frame ; The increment can only start once the hLongPressB has been set to 1 when B is first pressed down.

	ldh a, [hJoypadDown]
	cp SELECT
	jr nz, .cancel_long_press ; If the player is pressing any other button, cancel the long press.

	ldh a, [hLongPressSelect]
	inc a
	ldh [hLongPressSelect], a ; Increase the longpress frame counter.
	cp LONG_PRESS_FRAMES_DURATION
	jr c, .check_pressed_this_frame

	xor a
	ldh [hLongPressSelect], a ; Preventing infinite triggers.

; Try Itemfinder.
	ld a, ITEMFINDER
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .check_pressed_this_frame
	
	ld a, ITEMFINDER
	jr .use_key_item_no_sound

.cancel_long_press
	xor a
	ldh [hLongPressSelect], a

.check_pressed_this_frame
	ldh a, [hJoyPressed]
	and SELECT
	ret z

	ld a, 1
	ldh [hLongPressSelect], a ; Initiates a long press.
	xor a
	ret

.check_short_press
	ldh a, [hLongPressSelect]
	and a
	ret z

	; Note: the long press is activated as soon as possible.
	; Which means if we are here, the short press is automatically validated.

	xor a
	ldh [hLongPressSelect], a ; Prevents infinite triggers.

	; Try fishing.
	call IsPlayerFacingWaterWhileStandingOnLand
	jr nc, .try_squirtbottle

	ld a, [wRegisteredItem]
	call IsRod
	jr z, .use_key_item

	; Get highest rod from the key items pocket.
	call GetFirstRod
	and a
	jr z, .try_squirtbottle

	cp $ff
	jr nz, .use_key_item

.try_squirtbottle
	ld a, SQUIRTBOTTLE
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .try_bike

	xor a
	ld [wCurFruitTree], a
	farcall GetSquirtbottleTarget
	jr c, .try_bike

	ld a, [wScriptVar]
	and a
	jr z, .try_bike
	
	ld a, SQUIRTBOTTLE
	jr .use_key_item

.try_bike
	ld a, BICYCLE
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .abandon

	farcall TryBikeSilent
	jr c, .abandon

	ld a, BICYCLE
	jr .use_key_item_no_sound

.abandon
	xor a
	ret

.use_key_item
	call PlayTalkObject ; Doesn't clobber A!
.use_key_item_no_sound
	ld [wCurItem], a
	ld a, BANK(SelectMenuShortcutScript)
	ld hl, SelectMenuShortcutScript
	jp CallScript

CheckLongStartPressOW:
	ldh a, [hJoypadDown]
	and START
	jr z, .check_short_press

	ldh a, [hLongPressStart]
	and a
	jr z, .check_pressed_this_frame ; The increment can only start once the hLongPressB has been set to 1 when B is first pressed down.

	ldh a, [hJoypadDown]
	cp START
	jr nz, .cancel_long_press ; If the player is pressing any other button, cancel the long press.

	ldh a, [hLongPressStart]
	inc a
	ldh [hLongPressStart], a ; Increase the longpress frame counter.
	cp LONG_PRESS_FRAMES_DURATION
	jr c, .check_pressed_this_frame

	xor a
	ldh [hLongPressStart], a ; Preventing infinite triggers.

; Try quick save.
	farcall LoadOW_BGPal7
	
	ld de, SFX_MENU
	call PlaySFX

	farcall SetNormalStateIfClapping
	farcall HideMapNameSign
	call RefreshScreen
	farcall SaveMenu.quick
	call RefreshScreen
	xor a
	ret

.cancel_long_press
	xor a
	ldh [hLongPressStart], a

.check_pressed_this_frame
	ldh a, [hJoyPressed]
	and START
	ret z

	ld a, 1
	ldh [hLongPressStart], a ; Initiates a long press.
	xor a
	ret

.check_short_press
	ldh a, [hLongPressStart]
	and a
	ret z

	; Note: the long press is activated as soon as possible.
	; Which means if we are here, the short press is automatically validated.

	xor a
	ldh [hLongPressStart], a ; Prevents infinite triggers.

	; Start menu.
	ld a, BANK(StartMenuScript)
	ld hl, StartMenuScript
	jp CallScript

; Output: carry if true.
IsPlayerFacingWaterWhileStandingOnLand:
	call CheckOnWater
	ret z

	call GetFacingTileCoordAndCollType
	call GetTileCollision
	cp WATER_TILE
	jp z, DoBikeStep.returnCarry
	
	xor a
	ret

; Output: A is $00, $ff, OLD_ROD, GOOD_ROD or SUPER_ROD.
GetFirstRod:
	ld hl, wKeyItems
.next
	ld a, [hli]
	and a
	ret z

	cp $ff
	ret z

	call IsRod
	ret z
	
	jr .next

; Returns Z if A is a rod. Returns NZ otherwise.
IsRod:
	cp OLD_ROD
	ret z
	cp GOOD_ROD
	ret z
	cp SUPER_ROD
	ret

; Output: carry if true.
IsPlayerFacingGrassWhileStandingOutsideOfGrass:
	ld a, [wPlayerStandingTile]
	ld hl, .grass_coll
	call IsInByteArray
	ccf
	ret nc

	call GetFacingTileCoordAndCollType
	ld hl, .grass_coll
	call IsInByteArray
	ret

.grass_coll
	db COLL_TALL_GRASS
	db COLL_LONG_GRASS
	db COLL_GRASS_48
	db COLL_GRASS_49
	db COLL_GRASS_4A
	db COLL_GRASS_4B
	db COLL_GRASS_4C
	db -1

PlayTalkObject:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

TryObjectEvent:
	farcall CheckFacingObjectNPCExcluded
	jr c, .IsObject
	xor a
	ret

.IsObject:
	call InteractWithObj
	ret

TryFarNPCOnlyEvent:
	farcall CheckFacingFarNPCOnly
	jr c, .IsObject
	xor a
	ret

.IsObject:
	call InteractWithObj
	ret

InteractWithObj::
	call PlayTalkObject
	ldh a, [hObjectStructIndex]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ldh [hLastTalked], a
	call GetMapObject
	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and %00001111

	push bc
	ld de, 3
	ld hl, ObjectEventTypeArray
	call IsInArray
	pop bc
	jr nc, .nope

	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.nope
	xor a
	ret

ObjectEventTypeArray:
	table_width 3, ObjectEventTypeArray
	dbw OBJECTTYPE_SCRIPT, .script
	dbw OBJECTTYPE_ITEMBALL, .itemball
	dbw OBJECTTYPE_TRAINER, .trainer
	; the remaining four are dummy events
	dbw OBJECTTYPE_3, .three
	dbw OBJECTTYPE_4, .four
	dbw OBJECTTYPE_5, .five
	dbw OBJECTTYPE_6, .six
	assert_table_length NUM_OBJECT_TYPES
	db -1 ; end

.script
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetMapScriptsBank
	jp CallScript

.itemball
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetMapScriptsBank
	ld de, wItemBallData
	ld bc, wItemBallDataEnd - wItemBallData
	call FarCopyBytes
	ld a, PLAYEREVENT_ITEMBALL
	scf
	ret

.trainer
	call TalkToTrainer
	ld a, PLAYEREVENT_TALKTOTRAINER
	scf
	ret

.three
	xor a
	ret

.four
	xor a
	ret

.five
	xor a
	ret

.six
	xor a
	ret

TryBGEvent:
	call CheckFacingBGEvent
	jr c, .is_bg_event
	xor a
	ret

.is_bg_event:
	ld a, [wCurBGEventType]
	ld hl, BGEventJumptable
	rst JumpTable
	ret

BGEventJumptable:
	table_width 2, BGEventJumptable
	dw .read
	dw .up
	dw .down
	dw .right
	dw .left
	dw .ifset
	dw .ifnotset
	dw .itemifset
	dw .copy
	dw .closeddoor
	assert_table_length NUM_BGEVENTS

.up:
	ld b, OW_UP
	jr .checkdir

.down:
	ld b, OW_DOWN
	jr .checkdir

.right:
	ld b, OW_RIGHT
	jr .checkdir

.left:
	ld b, OW_LEFT
	jr .checkdir

.checkdir:
	ld a, [wPlayerDirection]
	and %1100
	cp b
	jp nz, .dontread
.read:
	call PlayTalkObject
	ld hl, wCurBGEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetMapScriptsBank
	jp CallScript

.itemifset:
	call CheckBGEventFlag
	jp nz, .dontread
	call PlayTalkObject
	call GetMapScriptsBank
	ld de, wHiddenItemData
	ld bc, wHiddenItemDataEnd - wHiddenItemData
	call FarCopyBytes
	ld a, BANK(HiddenItemScript)
	ld hl, HiddenItemScript
	jp CallScript

.copy:
	call CheckBGEventFlag
	jr nz, .dontread
	call GetMapScriptsBank
	ld de, wHiddenItemData
	ld bc, wHiddenItemDataEnd - wHiddenItemData
	call FarCopyBytes
	jr .dontread

.ifset:
	call CheckBGEventFlag
	jr z, .dontread
	jr .thenread

.ifnotset:
	call CheckBGEventFlag
	jr nz, .dontread
.thenread:
	push hl
	call PlayTalkObject
	pop hl
	inc hl
	inc hl
	call GetMapScriptsBank
	call GetFarWord
	call GetMapScriptsBank
	jp CallScript

.closeddoor:
	call GetFacingTileCoordAndCollType
	cp COLL_CLOSED_DOOR
	jr z, .read

.dontread:
	xor a
	ret

CheckBGEventFlag:
	ld hl, wCurBGEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	call GetMapScriptsBank
	call GetFarWord
	ld e, l
	ld d, h
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	pop hl
	ret

PlayerMovement:
	farcall DoPlayerMovement
	ld a, c
	ld hl, PlayerMovementPointers
	rst JumpTable
	ld a, c
	ret

PlayerMovementPointers:
; entries correspond to PLAYERMOVEMENT_* constants
	table_width 2, PlayerMovementPointers
	dw .normal
	dw .warp
	dw .turn
	dw .force_turn
	dw .finish
	dw .continue
	dw .exit_water
	dw .jump
	assert_table_length NUM_PLAYER_MOVEMENTS

.normal:
.finish:
	xor a
	ld c, a
	ret

.jump:
	call SetMinTwoStepWildEncounterCooldown
	xor a
	ld c, a
	ret

.warp:
	ld a, PLAYEREVENT_WARP
	ld c, a
	scf
	ret

.turn:
	ld a, PLAYEREVENT_JOYCHANGEFACING
	ld c, a
	scf
	ret

.force_turn:
; force the player to move in some direction
	ld a, BANK(Script_ForcedMovement)
	ld hl, Script_ForcedMovement
	call CallScript ; Note: CallScript calls scf.
	ld c, a
	ret

.continue:
.exit_water:
	ld a, -1
	ld c, a
	and a
	ret

StartMenuScript:
	callasm StartMenu
	sjump StartMenuCallback

SelectMenuShortcutScript:
	callasm UseRegisteredItem
	sjump SelectMenuCallback

StartMenuCallback:
SelectMenuCallback:
	readmem hMenuReturn
	ifequal HMENURETURN_SCRIPT, .Script
	ifequal HMENURETURN_ASM, .Asm
	end

.Script:
	memjump wQueuedScriptBank

.Asm:
	memcallasm wQueuedScriptBank
	end

CountStep:
	; Don't count steps in link communication rooms.
	ld a, [wLinkMode]
	and a
	jp nz, .done

	; If there is a special phone call, don't count the step.
	farcall CheckSpecialPhoneCall
	jp c, .doscript

	; If Repel wore off, don't count the step.
	call DoRepelStep
	jp c, .doscript

	; Count the step for poison and total steps
	ld hl, wPoisonStepCount
	inc [hl]
	ld hl, wStepCount
	inc [hl]
	
	farcall CeruleanCaveB3FStep

	ld hl, wWalkingAbuseGuard
	ld a, $ff
	cp [hl]
	jr z, .check_egg
	
	ld a, [wStepCount]
	and $4 - 1
	jr nz, .skip_walking_abuse_guard_inc
	
	inc [hl]

.skip_walking_abuse_guard_inc
	ld a, [wStepCount]
	cp 42 ; 1 check every 256 steps. Step 42 shouldn't overlap with any other check.
	jr nz, .skip_contact_tracing

	ld b, CHECK_FLAG
	ld de, EVENT_CONTACT_TRACING_NOTIFICATION_DISPLAY
	call EventFlagAction
	ld a, c
	and a
	jr z, .skip_notification_display

	; Player receives phone call as a notification.
	ld a, SPECIALCALL_CONTACT_TRACING_NOTIFICATION
	ld [wSpecialPhoneCallID], a

	ld b, RESET_FLAG
	ld de, EVENT_CONTACT_TRACING_NOTIFICATION_DISPLAY
	call EventFlagAction

.skip_notification_display
	ld b, CHECK_FLAG
	ld de, EVENT_CONTACT_TRACING_NOTIFICATION
	call EventFlagAction
	ld a, c
	and a
	jr z, .skip_contact_tracing

	ld b, CHECK_FLAG
	ld de, EVENT_POKEGEAR_CONTACT_TRACING_MODULE
	call EventFlagAction
	ld a, c
	and a
	jr z, .skip_contact_tracing

	; We move the current flag to the next one, in order to delay the notification.
	; Average of 128 + 256 = 384 steps before notification.
	ld b, SET_FLAG
	ld de, EVENT_CONTACT_TRACING_NOTIFICATION_DISPLAY
	call EventFlagAction

	ld b, RESET_FLAG
	ld de, EVENT_CONTACT_TRACING_NOTIFICATION
	call EventFlagAction
	
.skip_contact_tracing
	; Every 128 steps, increase wActivePlaytimePoints by one.
	ld a, [wStepCount]
	and $80 - 1
	jr nz, .day_care_step

	; Every 128 steps, increase the happiness of all your Pokemon.
	farcall StepHappiness
	
	ld hl, wActivePlaytimePoints
	inc [hl]
	jr nz, .day_care_step

	farcall TriggerDailyEventResetSpecialCall

.day_care_step
	; Increase the EXP of (both) DayCare Pokemon.
	farcall DayCareStep

.check_egg
	; Every 64 steps, decrease the hatch counter of all your eggs
	; until you reach the first one that is ready to hatch.
	ld a, [wStepCount]
	and $40 - 1
	jr nz, .skip_egg

	farcall DoEggStep
	jr nz, .hatch

.skip_egg
	; Every 4 steps, deal damage to all poisoned Pokemon.
	ld hl, wPoisonStepCount
	ld a, [hl]
	cp 4
	jr c, .skip_poison
	ld [hl], 0

	farcall DoPoisonStep
	jr c, .doscript

.skip_poison
	farcall DoBikeStep

.done
	xor a
	ret

.doscript
	ld a, -1
	scf
	ret

.hatch
	ld a, PLAYEREVENT_HATCH
	scf
	ret

DoRepelStep:
	ld a, [wRepelEffect]
	and a ; Sets carry to zero, no matter what.
	ret z

	dec a ; The "dec" instruction doesn't touch the carry flag, which feels weird.
	ld [wRepelEffect], a
	ret nz

	ld a, [wRepelType]
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	ld a, BANK(RepelWoreOffScript)
	ld hl, RepelWoreOffScript
	jr nc, .got_script
	ld a, BANK(UseAnotherRepelScript)
	ld hl, UseAnotherRepelScript
.got_script
	jp CallScript

DoPlayerEvent:
	ld a, [wScriptRunning]
	and a
	ret z

	cp PLAYEREVENT_MAPSCRIPT ; run script
	ret z

	cp NUM_PLAYER_EVENTS
	ret nc

	ld c, a
	ld b, 0
	ld hl, PlayerEventScriptPointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wScriptBank], a
	ld a, [hli]
	ld [wScriptPos], a
	ld a, [hl]
	ld [wScriptPos + 1], a
	ret

PlayerEventScriptPointers:
; entries correspond to PLAYEREVENT_* constants
	table_width 3, PlayerEventScriptPointers
	dba InvalidEventScript      ; PLAYEREVENT_NONE
	dba SeenByTrainerScript     ; PLAYEREVENT_SEENBYTRAINER
	dba TalkToTrainerScript     ; PLAYEREVENT_TALKTOTRAINER
	dba FindItemInBallScript    ; PLAYEREVENT_ITEMBALL
	dba EdgeWarpScript          ; PLAYEREVENT_CONNECTION
	dba WarpToNewMapScript      ; PLAYEREVENT_WARP
	dba FallIntoMapScript       ; PLAYEREVENT_FALL
	dba OverworldWhiteoutScript ; PLAYEREVENT_WHITEOUT
	dba HatchEggScript          ; PLAYEREVENT_HATCH
	dba ChangeDirectionScript   ; PLAYEREVENT_JOYCHANGEFACING
	dba InvalidEventScript      ; (NUM_PLAYER_EVENTS)
	assert_table_length NUM_PLAYER_EVENTS + 1

InvalidEventScript:
	end

HatchEggScript:
	callasm OverworldHatchEgg
	end

WarpToNewMapScript:
	warpsound
	newloadmap MAPSETUP_DOOR
	end

FallIntoMapScript:
	newloadmap MAPSETUP_FALL
	playsound SFX_KINESIS
	applymovement PLAYER, .SkyfallMovement
	playsound SFX_STRENGTH
	scall LandAfterPitfallScript
	end

.SkyfallMovement:
	skyfall
	step_end

LandAfterPitfallScript:
	earthquake 16
	end

EdgeWarpScript:
	reloadend MAPSETUP_CONNECTION

ChangeDirectionScript:
	deactivatefacing 3
	callasm EnableWildEncounters
	end

INCLUDE "engine/overworld/scripting.asm"

WarpToSpawnPoint::
	ld hl, wStatusFlags2
	res STATUSFLAGS2_SAFARI_GAME_F, [hl]
	res STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret

RunMemScript::
; If there is no script here, we don't need to be here.
	ld a, [wMapReentryScriptQueueFlag]
	and a
	ret z
; Execute the script at (wMapReentryScriptBank):(wMapReentryScriptAddress).
	ld hl, wMapReentryScriptAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapReentryScriptBank]
	call CallScript
; Clear the buffer for the next script.
	push af
	xor a
	ld hl, wMapReentryScriptQueueFlag
	ld bc, 8
	call ByteFill
	pop af
	ret

LoadScriptBDE::
; If there's already a script here, don't overwrite.
	ld hl, wMapReentryScriptQueueFlag
	ld a, [hl]
	and a
	ret nz
; Set the flag
	ld [hl], 1
	inc hl
; Load the script pointer b:de into (wMapReentryScriptBank):(wMapReentryScriptAddress)
	ld [hl], b
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
	scf
	ret

TryTileCollisionEvent::
	call GetFacingTileCoordAndCollType
	ld [wFacingTileID], a
	ld c, a
	farcall CheckFacingTileForStdScript
	jr c, .done

	call CheckCutTreeTile
	jr nz, .whirlpool
	farcall TryCutOW
	jr .done

.whirlpool
	ld a, [wFacingTileID]
	call CheckWhirlpoolTile
	jr nz, .waterfall
	farcall TryWhirlpoolOW
	jr .done

.waterfall
	ld a, [wFacingTileID]
	call CheckWaterfallTile
	jr nz, .headbutt
	farcall TryWaterfallOW
	jr .done

.headbutt
	ld a, [wFacingTileID]
	call CheckHeadbuttTreeTile
	jr nz, .surf
	farcall TryHeadbuttOW
	jr c, .done
	jr .noevent

.surf
	farcall TrySurfOW
	jr nc, .noevent
	jr .done

.noevent
	xor a
	ret

.done
	call PlayClickSFX
	ld a, $ff
	scf
	ret

RandomEncounter::
; Random encounter

	call CheckWildEncounterCooldown
	jr c, .nope
	call CanUseSweetScent
	jr nc, .nope
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .bug_contest
	farcall TryWildEncounter
	jr nz, .nope
	jr .ok

.bug_contest
	call _TryWildEncounter_BugContest
	jr nc, .nope
	jr .ok_bug_contest

.nope
	ld a, 1
	and a
	ret

.ok
	ld a, BANK(WildBattleScript)
	ld hl, WildBattleScript
	jp CallScript

.ok_bug_contest
	ld a, BANK(BugCatchingContestBattleScript)
	ld hl, BugCatchingContestBattleScript
	jp CallScript	

WildBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

CanUseSweetScent::
	ld hl, wStatusFlags
	bit STATUSFLAGS_NO_WILD_ENCOUNTERS_F, [hl]
	jr nz, .no
	ld a, [wEnvironment]
	cp CAVE
	jr z, .ice_check
	cp DUNGEON
	jr z, .ice_check
	farcall CheckGrassCollision
	jr nc, .no

.ice_check
	ld a, [wPlayerStandingTile]
	call CheckIceTile
	jr z, .no
	scf
	ret

.no
	and a
	ret

_TryWildEncounter_BugContest:
	call TryWildEncounter_BugContest
	ret nc
	call ChooseWildEncounter_BugContest
	farcall CheckRepelEffect
	ret

ChooseWildEncounter_BugContest::
; Pick a random mon out of ContestMons.

.loop
	call Random
	cp 100 << 1
	jr nc, .loop
	srl a

	ld hl, ContestMons
	ld de, 4
.CheckMon:
	sub [hl]
	jr c, .GotMon
	add hl, de
	jr .CheckMon

.GotMon:
	inc hl

; Species
	ld a, [hli]
	ld [wTempWildMonSpecies], a

; Min level
	ld a, [hli]
	ld d, a

; Max level
	ld a, [hl]

	sub d
	jr nz, .RandomLevel

; If min and max are the same.
	ld a, d
	jr .GotLevel

.RandomLevel:
; Get a random level between the min and max.
	ld c, a
	inc c
	call Random
	ldh a, [hRandomAdd]
	call SimpleDivide
	add d

.GotLevel:
	ld [wCurPartyLevel], a

	xor a
	ret

TryWildEncounter_BugContest:
	ld a, [wPlayerStandingTile]
	call CheckSuperTallGrassTile
	ld b, 40 percent
	jr z, .ok
	ld b, 20 percent

.ok
	farcall ApplyMusicEffectOnEncounterRate
	farcall ApplyCleanseTagEffectOnEncounterRate
	call Random
	ldh a, [hRandomAdd]
	cp b
	ret c
	ld a, 1
	and a
	ret

INCLUDE "data/wild/bug_contest_mons.asm"

DoBikeStep::
	nop
	nop
	; If the bike shop owner doesn't have our number, or
	; if we've already gotten the call, we don't have to
	; be here.
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BIKE_SHOP_CALL_F, [hl]
	jr z, .NoCall

	; If we have less than 4 badges, we don't have to be here.
	ld hl, wBadges
	ld b, 1
	call CountSetBits
	cp 4
	jr c, .NoCall

	; If we're not on the bike, we don't have to be here.
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .NoCall

	; If we're not in an area of phone service, we don't
	; have to be here.
	call GetMapPhoneService
	and a
	jr nz, .NoCall

	; Check the bike step count and check whether we've
	; taken 65536 of them yet.
	ld hl, wBikeStep
	ld a, [hli]
	ld d, a
	ld e, [hl]
	cp 255
	jr nz, .increment
	ld a, e
	cp 255
	jr z, .dont_increment

.increment
	inc de
	ld [hl], e
	dec hl
	ld [hl], d

.dont_increment
	; If we've taken at least 1024 steps, have the bike
	;  shop owner try to call us.
	ld a, d
	cp HIGH(1024)
	jr c, .NoCall

	; If a call has already been queued, don't overwrite
	; that call.
	ld a, [wSpecialPhoneCallID]
	and a
	jr nz, .NoCall

	; Queue the call.
	ld a, SPECIALCALL_BIKESHOP
	ld [wSpecialPhoneCallID], a
	ld hl, wStatusFlags2
	res STATUSFLAGS2_BIKE_SHOP_CALL_F, [hl]

	; If we are in Goldenrod, we immediately close down the shop.
	ld a, [wMapGroup]
	cp GROUP_GOLDENROD_CITY
	jr nz, .returnCarry

	ld a, [wMapNumber]
	cp MAP_GOLDENROD_CITY
	jr nz, .returnCarry

	; Make the BikeShop door appear instantly.
	; Ex GOLDENRODCITY_BIKESHOP_DOOR
	; changeblock 28, 28, $38
	lb de, 28 + 4, 28 + 4
	call GetBlockLocation
	call GetScriptByte
	ld a, $38
	ld [hl], a
	;call BufferScreen

	; changeblock 30, 28, $39
	lb de, 30 + 4, 28 + 4
	call GetBlockLocation
	call GetScriptByte
	ld a, $39
	ld [hl], a
	call BufferScreen

	;ld a, 18 ; GOLDENRODCITY_BIKESHOP_DOOR - 1
	;call UnmaskCopyMapObjectStruct
	;ldh a, [hMapObjectIndex]
	;ld b, RESET_FLAG
	;call ApplyEventActionAppearDisappear

.returnCarry
	scf
	ret

.NoCall:
	xor a
	ret

INCLUDE "engine/overworld/cmd_queue.asm"
