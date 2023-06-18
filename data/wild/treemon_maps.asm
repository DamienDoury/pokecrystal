treemon_map: MACRO
	map_id \1
	db \2 ; treemon set
	db \3 ; level
ENDM

TreeMonJohtoMaps:
	treemon_map ROUTE_29,                  RATTATA,		2
	treemon_map ROUTE_30,                  GLIGAR,		4
	treemon_map ROUTE_31,                  JIGGLYPUFF,	5
	treemon_map ROUTE_32,                  SKIPLOOM,	10
	treemon_map ROUTE_34,                  MURKROW,		15
	treemon_map ROUTE_35,                  BEEDRILL,	19
	treemon_map ROUTE_36,                  BUTTERFREE,	19
	treemon_map ROUTE_37,                  TEDDIURSA,	16
	treemon_map ROUTE_38,                  JUMPLUFF,	27
	treemon_map ROUTE_39,                  JUMPLUFF,	27
	treemon_map ROUTE_42,                  EXEGGCUTE,	20
	treemon_map ROUTE_43,                  MANKEY,		27
	treemon_map ROUTE_44,                  DELIBIRD,	27
	treemon_map NEW_BARK_TOWN,             SENTRET,		2
	treemon_map VIOLET_CITY,               HOOTHOOT,	8
	treemon_map AZALEA_TOWN,               HERACROSS,	12
	treemon_map ECRUTEAK_CITY,             FURRET,		21
	treemon_map MAHOGANY_TOWN,             SNEASEL,		25
	treemon_map LAKE_OF_RAGE,              AIPOM,		30
	treemon_map ILEX_FOREST,               PINECO,		12
	treemon_map SILVER_CAVE_OUTSIDE,       FORRETRESS,	55
	db -1

TreeMonKantoMaps:
	treemon_map ROUTE_26,                  ARIADOS,		40
	treemon_map ROUTE_27,                  FORRETRESS,	42
	treemon_map ROUTE_28,                  FORRETRESS,	50
	treemon_map ROUTE_1,           		   SENTRET,		2
	treemon_map VIRIDIAN_CITY,             HOOTHOOT,	4
	treemon_map ROUTE_2,           		   LEDYBA,	    4
	treemon_map VIRIDIAN_FOREST,           PIKACHU,		5
	treemon_map PEWTER_CITY,           	   GEODUDE,		5
	treemon_map ROUTE_3,           		   GLIGAR,		6
	treemon_map ROUTE_4,           		   EKANS,		15
	treemon_map CERULEAN_CITY,             POLIWAG,		16
	treemon_map ROUTE_25,                  ABRA,		18
	treemon_map ROUTE_9,                   FEAROW,		23
	treemon_map ROUTE_8,                   ARIADOS,		26
	treemon_map ROUTE_11,                  BELLOSSOM,	24
	treemon_map VERMILION_CITY,            MARILL,		21
	treemon_map ROUTE_7,                   GRIMER,		26
	treemon_map CELADON_CITY,              MURKROW,		28
	treemon_map ROUTE_16,                  SPEAROW,		28
	treemon_map ROUTE_18,                  AIPOM,		31
	treemon_map FUCHSIA_CITY,              MANKEY,		24
	treemon_map ROUTE_12,                  SHUCKLE,	    29
	treemon_map ROUTE_13,                  TEDDIURSA,	31
	treemon_map ROUTE_14,                  JUMPLUFF,	36
	treemon_map ROUTE_15,                  FARFETCH_D,	37
	db -1

RockMonJohtoMaps:
	treemon_map CIANWOOD_CITY,             KRABBY,		24
	treemon_map ROUTE_40,                  KRABBY,		23
	treemon_map DARK_CAVE_VIOLET_ENTRANCE, KRABBY,		4
	treemon_map SLOWPOKE_WELL_B1F,         KRABBY,		11
	db -1

RockMonKantoMaps:
	treemon_map FUCHSIA_CITY,              MAGCARGO,	37
	db -1
