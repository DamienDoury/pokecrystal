BattleCommand_StartSandstorm:
; startsandstorm

	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr z, .failed

	ld a, WEATHER_SANDSTORM
	ld [wBattleWeather], a
	call GetWeatherMoveDuration
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, SandstormBrewedText
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
