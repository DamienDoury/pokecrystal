CuteMons:
	table_width 1, CuteMons ; A Pokemon is cute if it is non-evolved (except if prior evolution is a baby pokemon) and less than 1m/3"3', except for pink pkmn that can be up to 1.2m/3"11').
	db CHIKORITA
	db CYNDAQUIL
	db TOTODILE
	db PIDGEY
	db SPEAROW
	db HOOTHOOT
	db RATTATA
	db SENTRET
	db PICHU 		; baby
	db PIKACHU		; has baby
	db CATERPIE		; bug
	db WEEDLE		; poison
	db LEDYBA		; bug
	db SPINARAK		; bug, poison
	db GEODUDE
	db ZUBAT		; poison
	db CLEFFA		; baby
	db CLEFAIRY		; has baby
	db IGGLYBUFF	; baby
	db JIGGLYPUFF	; has baby
	db TOGEPI		; baby
	db TOGETIC		; has baby
	db SANDSHREW
	db MAREEP
	db WOOPER
	db UNOWN
	db BELLSPROUT	; poison
	db HOPPIP
	db PARAS		; bug
	db POLIWAG
	db MAGIKARP
	db GOLDEEN
	db SLOWPOKE		; pink too tall
	db ODDISH		; poison
	db DROWZEE		
	db ABRA
	db DITTO
	db PINECO
	db NIDORAN_F	; poison
	db NIDORAN_M	; poison
	db SUNKERN
	db EXEGGCUTE
	db VENONAT		; poison
	db KOFFING		; poison
	db GRIMER		; poison
	db MAGNEMITE
	db VOLTORB
	db AIPOM
	db SNUBBULL
	db VULPIX
	db GROWLITHE
	db MARILL
	db DIGLETT
	db MANKEY		; fighting
	db MEOWTH
	db PSYDUCK
	db MACHOP		; fighting
	db TYROGUE		; baby, fighting
	db MILTANK		; pink too tall
	db MAGBY		
	db SMOOCHUM		; baby
	db ELEKID		; baby
	db FARFETCH_D
	db NATU
	db QWILFISH		; poison
	db TENTACOOL	; poison
	db KRABBY
	db SHUCKLE
	db STARYU
	db SHELLDER
	db CORSOLA
	db REMORAID
	db CHINCHOU
	db LICKITUNG	; pink too tall
	db TANGELA
	db EEVEE
	db HORSEA
	db DELIBIRD
	db SWINUB
	db TEDDIURSA
	db PHANPY
	db PONYTA
	db CUBONE
	db RHYHORN
	db MURKROW		; dark
	db HOUNDOUR		; dark
	db SLUGMA
	db SNEASEL		; dark
	db MISDREAVUS	; ghost
	db PORYGON
	db CHANSEY		; pink too tall
	db OMANYTE
	db KABUTO
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db LARVITAR
	db MEW
	db CELEBI
	db -1
	assert_table_length 100