CustomOBJPalMapList:
custom_map_objects_pals: MACRO
	map_id \1 	; map
	dw \2		; palette address
ENDM
	custom_map_objects_pals VERMILION_CITY, MapObjectsPalVermilion ; Special case, because Machoke (silver) and Snorlax (purple) on the same screen.
	custom_map_objects_pals GOLDENROD_DEPT_STORE_B1F, MapObjectsPalVermilion
	custom_map_objects_pals ROUTE_19, MapObjectsPalRoute19 ; Onix (silver).
	custom_map_objects_pals VIRIDIAN_NICKNAME_SPEECH_HOUSE, MapObjectPalsPurple
	custom_map_objects_pals ROUTE_30, MapObjectPalsPurple
	custom_map_objects_pals MR_FUJIS_HOUSE, MapObjectPalsFuji
	custom_map_objects_pals PEWTER_NIDORAN_SPEECH_HOUSE, MapObjectPalsPurple
	custom_map_objects_pals DANCE_THEATRE, MapObjectPalsPurple
	custom_map_objects_pals ROUTE_34_ILEX_FOREST_GATE, MapObjectPalsPurple
	custom_map_objects_pals PLAYERS_HOUSE_2F, MapObjectsPalVermilion
	custom_map_objects_pals CERULEAN_CAVE_B3F, MapObjectPalsPurple
	custom_map_objects_pals PEWTER_MUSEUM_2F, MapObjectPalsPurple
	custom_map_objects_pals VIRIDIAN_FOREST, MapObjectPalsGSBall
	custom_map_objects_pals BURNED_TOWER_B1F, MapObjectPalsYellowish
	custom_map_objects_pals TIN_TOWER_1F, MapObjectPalsYellowish
	custom_map_objects_pals REDS_HOUSE_2F, MapObjectPalsYellowish
	custom_map_objects_pals OLIVINE_LIGHTHOUSE_6F, MapObjectPalsYellowish
	custom_map_objects_pals SILVER_CAVE_ROOM_3, MapObjectPalsYellowish
	custom_map_objects_pals GOLDENROD_GAME_CORNER, MapObjectPalsYellowish
	custom_map_objects_pals INDIGO_PLATEAU_POKECENTER_1F, MapObjectPalsYellowish
	custom_map_objects_pals POWER_PLANT, MapObjectPalsYellowish
	custom_map_objects_pals GOLDENROD_HOSPITAL_ROOM, MapObjectPalsYellowishOnRock ; Needs pink for Nurses, yellowish for Abra, and leave the Tree palette for the player's sick mon.
	custom_map_objects_pals GOLDENROD_CLAP_HOUSE, MapObjectsPalVermilion
	custom_map_objects_pals AKIBA_3F, MapObjectsPalVermilion ; Big Snorlax and Big Onix.
	db 0 ; end
