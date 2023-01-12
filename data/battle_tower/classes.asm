BattleTowerTrainers:
; The trainer class is not used in Crystal 1.0 due to a bug.
; Instead, the sixth character in the trainer's name is used.
; See BattleTowerText in engine/events/battle_tower/trainer_text.asm.
	table_width (NAME_LENGTH - 1) + 1, BattleTowerTrainers
	; name, class
	db "HANSON@@@@", FISHER
	db "SAWYER@@@@", POKEMANIAC
	db "MASUDA@@@@", GUITARIST
	db "NICKEL@@@@", SCIENTIST
	db "OLSON@@@@@", POKEFANM
	db "ZABOROWSKI", LASS
	db "WRIGHT@@@@", YOUNGSTER
	db "ALEXANDER@", HIKER
	db "KAWAKAMI@@", TEACHER
	db "BICKETT@@@", POKEFANM
	db "SAITO@@@@@", KIMONO_GIRL
	db "CRAWFORD@@", BOARDER
	db "DIAZ@@@@@@", PICNICKER
	db "ERICKSON@@", BIKER
	db "FAIRFIELD@", JUGGLER
	db "HUNTER@@@@", POKEFANF
	db "HILL@@@@@@", FIREBREATHER
	db "JAVIER@@@@", SWIMMERF
	db "KAUFMAN@@@", SWIMMERM
	db "LANCASTER@", SKIER
	db "McMAHILL@@", CAMPER
	assert_table_length BATTLETOWER_NUM_UNIQUE_MON
; The following can only be sampled in Crystal 1.1.
	db "OBRIEN@@@@", GENTLEMAN
	db "FROST@@@@@", BEAUTY
	db "MORSE@@@@@", SUPER_NERD
	db "YUFUNE@@@@", BLACKBELT_T
	db "RAJAN@@@@@", COOLTRAINERF
	db "RODRIGUEZ@", OFFICER
	db "SANTIAGO@@", PSYCHIC_T
	db "STOCK@@@@@", POKEFANM
	db "THURMAN@@@", SCIENTIST
	db "VALENTINO@", BEAUTY
	db "WAGNER@@@@", CAMPER
	db "YATES@@@@@", BIRD_KEEPER
	db "ANDREWS@@@", PICNICKER
	db "BAHN@@@@@@", POKEMANIAC
	db "MORI@@@@@@", SCIENTIST
	db "BUCKMAN@@@", SAGE
	db "COBB@@@@@@", SCHOOLBOY
	db "HUGHES@@@@", FISHER
	db "ARITA@@@@@", KIMONO_GIRL
	db "EASTON@@@@", PSYCHIC_T
	db "FREEMAN@@@", CAMPER
	db "GIESE@@@@@", LASS
	db "HATCHER@@@", GENTLEMAN
	db "JACKSON@@@", POKEFANF
	db "KAHN@@@@@@", POKEMANIAC
	db "LEONG@@@@@", YOUNGSTER
	db "MARINO@@@@", TEACHER
	db "NEWMAN@@@@", SAILOR
	db "NGUYEN@@@@", BLACKBELT_T
	db "OGDEN@@@@@", SUPER_NERD
	db "PARK@@@@@@", COOLTRAINERF
	db "RAINE@@@@@", SWIMMERM
	db "SELLS@@@@@", BIRD_KEEPER
	db "ROCKWELL@@", BOARDER
	db "THORNTON@@", LASS
	db "TURNER@@@@", OFFICER
	db "VAN DYKE@@", SKIER
	db "WALKER@@@@", SCHOOLBOY
	db "MEYER@@@@@", SWIMMERF
	db "JOHNSON@@@", YOUNGSTER
	db "ADAMS@@@@@", GUITARIST
	db "SMITH@@@@@", BUG_CATCHER
	db "TAJIRI@@@@", BUG_CATCHER
	db "BAKER@@@@@", POKEMANIAC
	db "COLLINS@@@", SCIENTIST
	db "SMART@@@@@", SUPER_NERD
	db "DYKSTRA@@@", SWIMMERF
	db "EATON@@@@@", BIKER
	db "WONG@@@@@@", FIREBREATHER
	assert_table_length BATTLETOWER_NUM_UNIQUE_TRAINERS

PoliceTrainers:
	table_width POLICE_NAME_LENGTH, PoliceTrainers
	db "CHUCK@@"
	db "NORRIS@"
	db "HOOVER@"
	db "TED@@@@"
	db "GENE@@@"
	db "ERIK@@@"
	db "DREDD@@"
	db "VINCENT"
	db "BULLITT"
	db "HARRY@@"
	db "FOLEY@@"
	db "ED TOM@"
	db "POPEYE@"
	db "HANK@@@"
	db "BILLY@@"
	db "VIRGIL@"
	db "MARTIN@"
	db "RIGGS@@"
	db "SAMUEL@"
	db "GERARD@"
	db "SCOTTIE"
	db "JOHNNY@"
	db "McCLANE"
	db "MICHAEL"
	db "MATTHEW"
	db "KEITH@@"
	db "DIRK@@@"
	db "JOSHUA@"
	db "JACOB@@"
	db "ANDREW@"
	db "DANIEL@"
	db "TYLER@@"
	db "JOSEPH@"
	db "BRANDON"
	db "DAVID@@"
	db "JAMES@@"
	db "RYAN@@@"
	db "LUKE@@@"
	db "JOHN@@@"
	db "ZACHARY"
	db "JUSTIN@"
	db "WILLIAM"
	db "ANTHONY"
	db "ROBERT@"
	db "AUSTIN@"
	db "KYLE@@@"
	db "KEVIN@@"
	db "THOMAS@"
	db "CODY@@@"
	db "JORDAN@"
	db "ERIC@@@"
	db "AARON@@"
	db "DYLAN@@"
	db "STEVEN@"
	db "BRIAN@@"
	db "JOSE@@@"
	db "TIMOTHY"
	db "NATHAN@"
	db "ADAM@@@"
	db "SHOTA@@"
	db "TAKUYA@"
	db "KENTA@@"
	db "GUNPEI@"
	db "JUN@@@@"
	db "ANTONIO"
	db "PIERO@@"
	db "MATTEO@"
	db "VLAD@@@"
	db "RINALDO"
	db "LORENZO"
	db "SERGIO@"
	db "CARLOS@"
	db "PABLO@@"
	db "JAVIER@"
	db "ALVARO@"
	db "IVAN@@@"
	db "JULIAN@"
	db "KEN@@@@"
	db "LAURENT"
	db "THOMAS@"
	db "GUY@@@@"
	db "MANUEL@"
	db "MAXIME@"
	db "BASTIEN"
	db "JEROME@"
	db "ISAYA@@"
	db "ROMAIN@"
	assert_table_length NUM_POLICE_NAMES
