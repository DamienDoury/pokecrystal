BattleCommand_StartSun:
; startsun
	ld a, WEATHER_SUN
	ld [wBattleWeather], a
	call GetWeatherMoveDuration
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, SunGotBrightText
	jp StdBattleTextbox

; Output: duration of the weather (5 or 8) in A.
GetWeatherMoveDuration:
	call GetUserItem
	ld a, [hl]
	cp WEATHER_ROCK
	ld a, 8
	ret z

	ld a, 5
	ret