BattleCommand_StartRain:
; startrain
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jp z, BattleCommand_StartSandstorm.failed

	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	call GetWeatherMoveDuration
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, DownpourText
	jmp StdBattleTextbox
