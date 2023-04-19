; AutomaticWeatherEffects indexes
	const_def 1
	const AUTOMATIC_SUN
	const AUTOMATIC_RAIN
	const AUTOMATIC_SANDSTORM
	const AUTOMATIC_HAIL

AutomaticWeatherMaps:
auto_weather_map: MACRO
	map_id \1 ; map
	db \2 ; Time of day (MORN, DAY, NITE or a combination like ANYTIME)
	db \3 ; AUTOMATIC_* weather index
ENDM
	; Johto
	auto_weather_map TIN_TOWER_ROOF, 		ANYTIME, 		AUTOMATIC_SUN ; Note: only Ho-Oh can be battled here.
	auto_weather_map ROUTE_43, 				NITE,			AUTOMATIC_RAIN 
	auto_weather_map LAKE_OF_RAGE, 			ANYTIME,		AUTOMATIC_RAIN 
	auto_weather_map ROUTE_41, 				ANYTIME,		AUTOMATIC_RAIN 
	auto_weather_map ROUTE_35, 				DAY,			AUTOMATIC_SUN 	
	auto_weather_map NATIONAL_PARK, 		MORN | DAY,		AUTOMATIC_SUN 	
	auto_weather_map ROUTE_36, 				MORN,			AUTOMATIC_SUN 	
	auto_weather_map ROUTE_44, 				NITE,			AUTOMATIC_HAIL 
	auto_weather_map ROUTE_45, 				ANYTIME,		AUTOMATIC_SANDSTORM
	auto_weather_map SILVER_CAVE_ROOM_3, 	ANYTIME,		AUTOMATIC_RAIN 
	auto_weather_map SILVER_CAVE_OUTSIDE, 	ANYTIME,		AUTOMATIC_HAIL

	; Kanto 
	auto_weather_map ROUTE_28, 				NITE | MORN,	AUTOMATIC_HAIL 
	auto_weather_map ROUTE_26, 				NITE,			AUTOMATIC_HAIL 
	auto_weather_map ROUTE_11, 				MORN,			AUTOMATIC_SUN 	
	auto_weather_map VERMILION_CITY, 		MORN | DAY,		AUTOMATIC_SUN 	
	auto_weather_map ROUTE_6, 				DAY,			AUTOMATIC_SUN 	
	auto_weather_map ROUTE_20, 				MORN,			AUTOMATIC_SUN 	
	auto_weather_map CINNABAR_ISLAND, 		MORN | DAY,		AUTOMATIC_SUN 	
	auto_weather_map ROUTE_21, 				DAY,			AUTOMATIC_SUN 	
	auto_weather_map ROUTE_24, 				MORN | NITE,	AUTOMATIC_RAIN 
	auto_weather_map CERULEAN_CITY, 		MORN | NITE,	AUTOMATIC_RAIN 
	auto_weather_map ROUTE_25, 				MORN | NITE,	AUTOMATIC_RAIN 
	auto_weather_map ROUTE_3, 				MORN | DAY,		AUTOMATIC_SANDSTORM
	auto_weather_map ROUTE_9, 				NITE,			AUTOMATIC_SANDSTORM
	auto_weather_map SEAFOAM_B5F, 			ANYTIME,		AUTOMATIC_SUN
	auto_weather_map SEAFOAM_B6F, 			ANYTIME,		AUTOMATIC_SUN
	db 0 ; end
