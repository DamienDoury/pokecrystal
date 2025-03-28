scene_var: MACRO
; map, variable
	map_id \1
	dw \2
ENDM

MapScenes::
	scene_var POKECENTER_2F,                               wPokecenter2FSceneID	; 5 values
	scene_var COLOSSEUM,                                   wColosseumSceneID
	scene_var POWER_PLANT,                                 wPowerPlantSceneID
	scene_var CERULEAN_GYM,                                wCeruleanGymSceneID
	scene_var ROUTE_25,                                    wRoute25SceneID
	scene_var ELMS_LAB,                                    wElmsLabSceneID ; 6 values
	scene_var ROUTE_35_NATIONAL_PARK_GATE,                 wRoute35NationalParkGateSceneID ; 3 values
	scene_var ROUTE_36,                                    wRoute36SceneID
	scene_var ROUTE_36_NATIONAL_PARK_GATE,                 wRoute36NationalParkGateSceneID ; 3 values
	scene_var AZALEA_TOWN,                                 wAzaleaTownSceneID ; 3 values
	scene_var ROUTE_42,                                    wRoute42SceneID
	scene_var CIANWOOD_CITY,                               wCianwoodCitySceneID
	scene_var BATTLE_TOWER_1F,                             wBattleTower1FSceneID
	scene_var BATTLE_TOWER_BATTLE_ROOM,                    wBattleTowerBattleRoomSceneID
	scene_var BATTLE_TOWER_ELEVATOR,                       wBattleTowerElevatorSceneID
	scene_var BATTLE_TOWER_HALLWAY,                        wBattleTowerHallwaySceneID
	scene_var TIN_TOWER_1F,                                wTinTower1FSceneID
	scene_var BURNED_TOWER_1F,                             wBurnedTower1FSceneID ; 3 values
	scene_var RUINS_OF_ALPH_OUTSIDE,                       wRuinsOfAlphOutsideSceneID
	scene_var RUINS_OF_ALPH_RESEARCH_CENTER,               wRuinsOfAlphResearchCenterSceneID
	scene_var RUINS_OF_ALPH_HO_OH_CHAMBER,                 wRuinsOfAlphHoOhChamberSceneID
	scene_var RUINS_OF_ALPH_KABUTO_CHAMBER,                wRuinsOfAlphKabutoChamberSceneID
	scene_var RUINS_OF_ALPH_OMANYTE_CHAMBER,               wRuinsOfAlphOmanyteChamberSceneID
	scene_var RUINS_OF_ALPH_AERODACTYL_CHAMBER,            wRuinsOfAlphAerodactylChamberSceneID
	scene_var RUINS_OF_ALPH_INNER_CHAMBER,                 wRuinsOfAlphInnerChamberSceneID
	scene_var MAHOGANY_MART_1F,                            wMahoganyMart1FSceneID
	scene_var TEAM_ROCKET_BASE_B1F,                        wTeamRocketBaseB1FSceneID
	scene_var TEAM_ROCKET_BASE_B2F,                        wTeamRocketBaseB2FSceneID ; 4 values
	scene_var TEAM_ROCKET_BASE_B3F,                        wTeamRocketBaseB3FSceneID ; 4 values
	scene_var GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, wGoldenrodUndergroundSwitchRoomEntrancesSceneID
	scene_var VICTORY_ROAD,                                wVictoryRoadSceneID
	scene_var DRAGONS_DEN_B1F,                             wDragonsDenB1FSceneID
	scene_var DRAGON_SHRINE,                               wDragonShrineSceneID
	scene_var OLIVINE_PORT,                                wOlivinePortSceneID
	scene_var VERMILION_PORT,                              wVermilionPortSceneID
	scene_var FAST_SHIP_1F,                                wFastShip1FSceneID ; 3 values
	scene_var FAST_SHIP_B1F,                               wFastShipB1FSceneID
	scene_var MOUNT_MOON_SQUARE,                           wMountMoonSquareSceneID
	scene_var MOBILE_TRADE_ROOM,                           wMobileTradeRoomSceneID
	scene_var MOBILE_BATTLE_ROOM,                          wMobileBattleRoomSceneID
	scene_var CHARCOAL_KILN,                       		   wCharcoalKilnSceneID
	
	scene_var GOLDENROD_HOSPITAL_1F,               	       wGoldenrodHospitalReceptionSceneID
	scene_var GOLDENROD_HOSPITAL_ROOM,               	   wGoldenrodHospitalCorridorsAndRoomsSceneID ; 11 values
	scene_var GOLDENROD_HOSPITAL_CORRIDOR,                 wGoldenrodHospitalCorridorsAndRoomsSceneID ; 11 values
	scene_var VACCINATION_CENTER_1F,					   wVaccinationCenterSceneID ; 3 values
	scene_var VACCINATION_CENTER_CORRIDOR,				   wVaccinationCenterSceneID ; 3 values
	db -1 ; end
