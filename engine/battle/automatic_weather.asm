GetAutomaticBattleWeather::
	xor a
	ldh [hFarByte], a ; Setting the return value as "false".

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
	ld a, [hl] ; weather
	ldh [hFarByte], a
	ret

.wrong_group:
	inc hl ; skip map
.wrong_map
	inc hl ; skip time of day
.wrong_time_of_day
	inc hl ; skip weather
	jr .loop

INCLUDE "data/battle/weather_forecast.asm"
