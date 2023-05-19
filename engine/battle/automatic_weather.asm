GetAutomaticBattleWeather::
	xor a
	ldh [hFarByte], a ; Setting the return value as "false".

; First we check the gym leaders.	
	ld a, [wOtherTrainerClass]
	cp PRYCE
	jr nz, .brock

	ld a, AUTOMATIC_HAIL
	jr .weather_found

.brock
	ld a, [wOtherTrainerClass]
	cp BROCK
	jr nz, .misty

	ld a, AUTOMATIC_SANDSTORM
	jr .weather_found

.misty
	ld a, [wOtherTrainerClass]
	cp MISTY
	jr nz, .blaine

	ld a, AUTOMATIC_RAIN
	jr .weather_found

.blaine
	ld a, [wOtherTrainerClass]
	cp BLAINE
	jr nz, .check_viridian_forest

	ld a, AUTOMATIC_SUN
	jr .weather_found

.check_viridian_forest
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	jr nz, .check_landmarks

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	jr nz, .check_landmarks

	ld b, CHECK_FLAG
	ld de, EVENT_FOUGHT_ZAPDOS
	call EventFlagAction
	ld a, c
	and a
	jr nz, .check_landmarks

	; Rain in Viridian Forest until Zapdos has been beaten.
	ld a, AUTOMATIC_RAIN
	jr .weather_found

.check_landmarks
	ld hl, AutomaticWeatherMaps
	ld d, 1
	ld a, [wTimeOfDay]
	cp 0
	jr z, .get_map_group

.bit_shift_loop
	sla d
	dec a
	jr nz, .bit_shift_loop

.get_map_group
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
.loop
	ld a, [hli] ; group
	and a
	ret z ; end
	cp b
	jr nz, .wrong_group
	ld a, [hli] ; map
	cp c
	jr nz, .wrong_map
	ld a, [hli] ; time of day
	and d
	jr z, .wrong_time_of_day
	ld a, [hl] ; load weather
.weather_found
	ldh [hFarByte], a ; return weather in memory because of farcall that destroys a.
	ret

.wrong_group:
	inc hl ; skip map
.wrong_map
	inc hl ; skip time of day
.wrong_time_of_day
	inc hl ; skip weather
	jr .loop

WeatherMovesInSpecificGyms::
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SUNNY_DAY
	jr z, .check_gym_leader
	cp EFFECT_RAIN_DANCE
	jr z, .check_gym_leader
	cp EFFECT_SANDSTORM
	jr z, .check_gym_leader
	cp EFFECT_HAIL
	jr z, .check_gym_leader
	ret

.check_gym_leader
	; At this point, we know we are using a weather move.

	ld a, [wOtherTrainerClass]
	cp BROCK
	jr z, .miss
	cp PRYCE
	jr z, .miss
	cp MISTY
	jr z, .miss
	cp BLAINE
	jr z, .miss
	ret

.miss
	ld a, 1
	ld [wAttackMissed], a
	ret

INCLUDE "data/battle/weather_forecast.asm"