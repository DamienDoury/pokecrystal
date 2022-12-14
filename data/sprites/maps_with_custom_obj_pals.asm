CustomOBJPalMapList:
custom_map_objects_pals: MACRO
	map_id \1 	; map
	dw \2		; palette address
ENDM
	custom_map_objects_pals VERMILION_CITY, MapObjectsPalVermilion ; Special case, because Machoke (silver) and Snorlax (purple) on the same screen.
	custom_map_objects_pals ROUTE_19, MapObjectsPalRoute19 ; Onix (silver).
	custom_map_objects_pals VIRIDIAN_NICKNAME_SPEECH_HOUSE, MapObjectPalsPurple
	custom_map_objects_pals ROUTE_30, MapObjectPalsPurple
	custom_map_objects_pals MR_FUJIS_HOUSE, MapObjectPalsPurple
	custom_map_objects_pals PEWTER_NIDORAN_SPEECH_HOUSE, MapObjectPalsPurple
	custom_map_objects_pals DANCE_THEATRE, MapObjectPalsPurple
	custom_map_objects_pals ROUTE_34_ILEX_FOREST_GATE, MapObjectPalsPurple
	custom_map_objects_pals PLAYERS_HOUSE_2F, MapObjectPalsPurple
	custom_map_objects_pals CERULEAN_CAVE_B3F, MapObjectPalsPurple
	db 0 ; end
