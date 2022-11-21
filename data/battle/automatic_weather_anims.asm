AutomaticWeatherEffects:
; entries correspond to AUTOMATIC_* constants
auto_weather_effect: MACRO
	db \1 ; battle weather
	dw \2 ; animation
	dw \3 ; text
ENDM
	auto_weather_effect WEATHER_SUN, SUNNY_DAY, BattleText_TheSunlightIsStrong
	auto_weather_effect WEATHER_RAIN, RAIN_DANCE, BattleText_RainContinuesToFall
	auto_weather_effect WEATHER_SANDSTORM, ANIM_IN_SANDSTORM, BattleText_TheSandstormRages
	auto_weather_effect WEATHER_HAIL, ANIM_IN_HAIL, BattleText_HailContinuesToFall
