_InitializeStartDay:
	jmp InitializeStartDay

ClearDailyTimers:
	xor a
	ld [wLuckyNumberDayTimer], a
	ld [wDailyResetTimer], a
	ret

InitCallReceiveDelay::
	xor a
	ld [wTimeCyclesSinceLastCall], a

NextCallReceiveDelay:
	ld a, [wTimeCyclesSinceLastCall]
	cp 3
	jr c, .okay
	ld a, 3

.okay
	ld e, a
	ld d, 0
	ld hl, .ReceiveCallDelays
	add hl, de
	ld a, [hl]
if DEF(_DEBUG)
	ld h, a
	ld a, BANK(sDebugTimeCyclesSinceLastCall)
	call OpenSRAM
	ld a, [sDebugTimeCyclesSinceLastCall]
	call CloseSRAM
	dec a
	cp 2
	jr nc, .debug_ok
	xor 1
	ld h, a
.debug_ok
	ld a, h
endc
	jmp RestartReceiveCallDelay

.ReceiveCallDelays:
	db 20, 10, 5, 3

CheckReceiveCallTimer:
	call CheckReceiveCallDelay ; check timer
	ret nc
	ld hl, wTimeCyclesSinceLastCall
	ld a, [hl]
	cp 3
	jr nc, .ok
	inc [hl]

.ok
	call NextCallReceiveDelay ; restart timer
	scf
	ret

InitOneDayCountdown:
	ld a, 1

InitNDaysCountdown:
	ld [hl], a
	push hl
	call UpdateTime
	pop hl
	inc hl
	call CopyDayToHL
	ret

CheckDayDependentEventHL:
	inc hl
	push hl
	call CalcDaysSince
	call GetDaysSince
	pop hl
	dec hl
	jmp UpdateTimeRemaining

RestartReceiveCallDelay:
	ld hl, wReceiveCallDelay_MinsRemaining
	ld [hl], a
	call UpdateTime
	ld hl, wReceiveCallDelay_StartTime
	call CopyDayHourMinToHL
	ret

CheckReceiveCallDelay:
	ld hl, wReceiveCallDelay_StartTime
	call CalcMinsHoursDaysSince
	call GetMinutesSinceIfLessThan60
	ld hl, wReceiveCallDelay_MinsRemaining
	jmp UpdateTimeRemaining

RestartDailyResetTimer:
	ld hl, wDailyResetTimer
	jmp InitOneDayCountdown

CheckDailyResetTimer::
	ld hl, wDailyResetTimer
	call CheckDayDependentEventHL
	ret nc
	xor a
	ld hl, wDailyFlags1
	ld [hli], a ; wDailyFlags1
	ld [hli], a ; wDailyFlags2
	ld [hli], a ; wDailyFlags3
	ld [hli], a ; wSwarmFlags
	ld [hl], a  ; wSwarmFlags + 1
	ld [wLuckyNumberShowFlag], a ; Lottery Corner (Buena's Password).
	ld hl, wDailyRematchFlags
rept 4
	ld [hli], a
endr
	ld hl, wDailyPhoneItemFlags
rept 4
	ld [hli], a
endr
	ld hl, wDailyPhoneTimeOfDayFlags
rept 4
	ld [hli], a
endr
	ld hl, wKenjiBreakTimer
	ld a, [hl]
	and a
	jr z, .RestartKenjiBreakCountdown
	dec [hl]
	jr nz, .DontRestartKenjiBreakCountdown
.RestartKenjiBreakCountdown:
	call SampleKenjiBreakCountdown
.DontRestartKenjiBreakCountdown:
	jr RestartDailyResetTimer

SampleKenjiBreakCountdown:
; Generate a random number between 3 and 6
	call Random
	and %11
	add 3
	ld [wKenjiBreakTimer], a
	ret

CheckBugContestTimer::
	ld hl, wBugContestStartTime + 3
	call CalcSecsMinsHoursDaysSince
	ld a, [wDaysSince]
	and a
	jr nz, .timed_out
	ld a, [wHoursSince]
	and a
	jr nz, .timed_out
	ld a, [wSecondsSince]
	ld b, a
	ld a, [wBugContestSecsRemaining]
	sub b
	jr nc, .okay
	add 60

.okay
	ld [wBugContestSecsRemaining], a
	ld a, [wMinutesSince]
	ld b, a
	ld a, [wBugContestMinsRemaining]
	sbc b
	ld [wBugContestMinsRemaining], a
	jr c, .timed_out
	and a
	ret

.timed_out
	xor a
	ld [wBugContestMinsRemaining], a
	ld [wBugContestSecsRemaining], a
	scf
	ret

InitializeStartDay:
	call UpdateTime
	ld hl, wTimerEventStartDay
	call CopyDayToHL
	ret

CheckPokerusTickAndHospitalVisits::
	ld hl, wTimerEventStartDay
	call CalcDaysSince
	call GetDaysSince
	and a
	jr z, .done ; not even a day has passed since game start
	ld b, a
	farcall DayCareXPBonus
	farcall GrowBerries
	farcall ResetHospitalVisits
	farcall ApplyPokerusTick
	farcall ResetVaccinationAvailability
	farcall RestockMarts
	farcall ResetWantedLevelsTheNextDay
	xor a
	ld [wActivePlaytimePoints], a ; We don't want this to happen twice in a short period of time.
.done
	xor a
	ret

RestartLuckyNumberCountdown:
	call .GetDaysUntilNextFriday
	ld hl, wLuckyNumberDayTimer
	jmp InitNDaysCountdown

.GetDaysUntilNextFriday:
	call GetWeekday
	ld c, a
	ld a, FRIDAY
	sub c
	jr z, .friday_saturday
	jr nc, .earlier ; could have done "ret nc"

.friday_saturday
	add 7

.earlier
	ret

_CheckLuckyNumberShowFlag:
	ld hl, wLuckyNumberDayTimer
	jmp CheckDayDependentEventHL

DoMysteryGiftIfDayHasPassed:
	ld a, BANK(sMysteryGiftTimer)
	call OpenSRAM
	ld hl, sMysteryGiftTimer
	ld a, [hli]
	ld [wTempMysteryGiftTimer], a
	ld a, [hl]
	ld [wTempMysteryGiftTimer + 1], a
	call CloseSRAM

	ld hl, wTempMysteryGiftTimer
	call CheckDayDependentEventHL
	jr nc, .not_timed_out
	ld hl, wTempMysteryGiftTimer
	call InitOneDayCountdown
	call CloseSRAM
	farcall ResetDailyMysteryGiftLimitIfUnlocked

.not_timed_out
	ld a, BANK(sMysteryGiftTimer)
	call OpenSRAM
	ld hl, wTempMysteryGiftTimer
	ld a, [hli]
	ld [sMysteryGiftTimer], a
	ld a, [hl]
	ld [sMysteryGiftTimer + 1], a
	call CloseSRAM
	ret

UpdateTimeRemaining:
; If the amount of time elapsed exceeds the capacity of its
; unit, skip this part.
	cp -1
	jr z, .set_carry
	ld c, a
	ld a, [hl] ; time remaining
	sub c
	jr nc, .ok
	xor a

.ok
	ld [hl], a
	jr z, .set_carry
	xor a
	ret

.set_carry
	xor a
	ld [hl], a
	scf
	ret

GetMinutesSinceIfLessThan60:
	ld a, [wDaysSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wHoursSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wMinutesSince]
	ret

GetDaysSince:
	ld a, [wDaysSince]
	ret

GetTimeElapsed_ExceedsUnitLimit:
	ld a, -1
	ret

CalcDaysSince:
	xor a
	jr _CalcDaysSince

CalcMinsHoursDaysSince:
	inc hl
	inc hl
	xor a
	jr _CalcMinsHoursDaysSince

GetTimeSinceTimerStartDuration:
	call UpdateTime
	ld hl, wBugContestStartTime + 3
	; fallthrough.

CalcSecsMinsHoursDaysSince:
	ldh a, [hSeconds]
	ld c, a
	sub [hl]
	jr nc, .skip
	add 60
.skip
	ld [hl], c ; current seconds
	dec hl
	ld [wSecondsSince], a ; seconds since

_CalcMinsHoursDaysSince:
	ldh a, [hMinutes]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 60
.skip
	ld [hl], c ; current minutes
	dec hl
	ld [wMinutesSince], a ; minutes since

_CalcHoursDaysSince:
	ldh a, [hHours]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 24
.skip
	ld [hl], c ; current hours
	dec hl
	ld [wHoursSince], a ; hours since

_CalcDaysSince:
	ld a, [wCurDay]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 20 * 7
.skip
	ld [hl], c ; current days
	ld [wDaysSince], a ; days since
	ret

StartEscortTimer::
StartBugContestTimer:
	ld a, BUG_CONTEST_MINUTES
	ld [wBugContestMinsRemaining], a
	ld a, BUG_CONTEST_SECONDS
	ld [wBugContestSecsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	; fallthrough.

CopyDayHourMinSecToHL:
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ret

; Input: none.
; Output: number of seconds in wScriptVar. Fits within 1 byte (max 255 seconds).
GetEscortDurationInSeconds::
	ld a, -1
	ld [wScriptVar], a
	call GetTimeSinceTimerStartDuration
	ld a, [wDaysSince]
	and a
	ret nz

	ld a, [wHoursSince]
	and a
	ret nz

	ld a, [wMinutesSince]
	cp 3
	ret nc

	ld c, 60
	call SimpleMultiply
	ld c, a

	ld a, [wSecondsSince]
	add c
	ld [wScriptVar], a
	ret

CopyDayToHL:
	ld a, [wCurDay]
	ld [hl], a
	ret

CopyDayHourMinToHL:
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ret

; Covid takes days to spread.
; Hardcore players that play for a whole day at once will miss most of the Covid features.
; For example, the player could get all badges in 1 day while its Pokémon is still in incubation state.
; -------------------------
; For this reason, we accelerate covid-related features based on "active" play time.
; This function should be called every 2.5 hours on average, for a player that rushes the content.
; As it is based on "active" play time, players will have a harder time abusing this feature to take advantage of it.
TriggerDailyEventResetSpecialCall::
	ldh a, [hHours]
	cp 23
	ret z ; No daily events refresh at 11 pm, because it's too close to the natural refresh that occurs at midnight.
	
	ld a, SPECIALCALL_DAILY_EVENTS_RESET
	ld [wSpecialPhoneCallID], a
	ret

ResetDailyCovidEvents::
	ld b, 1 ; 1 day has passed. Parameter used by the following functions.
	farcall ResetHospitalVisits
	farcall ApplyPokerusTick ; Also calls DecreaseHospitalMonsDuration.
	farcall ResetVaccinationAvailability
	farcall RestockMarts
	farcall GrowBerries ; This is not exactly covid related, but it's my present to the player!
	ret
