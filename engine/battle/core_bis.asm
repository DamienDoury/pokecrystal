_StartAutomaticBattleWeather::
	callfar GetAutomaticBattleWeather
	ldh a, [hFarByte]
	and a
	ret z
; get current AutomaticWeatherEffects entry
	dec a
; fallthrough

;ForceBattleWeather:
	ld hl, AutomaticWeatherEffects
	ld bc, 5 ; size of one entry
	call AddNTimes
; [wBattleWeather] = weather
	ld a, [hli]
	ld [wBattleWeather], a
; de = animation
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; hl = text pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; start weather for 255 turns
	ld a, 255
	ld [wWeatherCount], a
	push hl
	farcall Call_PlayBattleAnim ; uses de
	pop hl
	rla ; Unsets Z flag, fastest instruction I could find to do this. Z flag is the return value of this function.
	ret

INCLUDE "data/battle/automatic_weather_anims.asm"