BattleTowerTrainers:
; The trainer class is not used in Crystal 1.0 due to a bug.
; Instead, the sixth character in the trainer's name is used.
; See BattleTowerText in engine/events/battle_tower/trainer_text.asm.
	table_width (NAME_LENGTH - 1) + 1, BattleTowerTrainers
	; name, class
if DEF(_FR_FR)
	db "PAGNOL@@@@", FISHER
	db "DURAND@@@@", POKEMANIAC
	db "RISOLI@@@@", GUITARIST
	db "MOMO@@@@@@", SCIENTIST
	db "AUBRE@@@@@", POKEFANM
	db "TROGER@@@@", LASS
	db "ANAYA@@@@@", YOUNGSTER
	db "TOPAK@@@@@", HIKER
	db "POUTARD@@@", TEACHER
	db "DARON@@@@@", POKEFANM
	db "ANJU@@@@@@", KIMONO_GIRL
	db "CHARBIT@@@", BOARDER
	db "NIKI@@@@@@", PICNICKER
	db "SOVANET@@@", BIKER
	db "SANCHEZ@@@", JUGGLER
	db "LAMICHE@@@", POKEFANF
	db "PINDER@@@@", FIREBREATHER
	db "ARHAN@@@@@", SWIMMERF
	db "BORG@@@@@@", SWIMMERM
	db "STIFFY@@@@", SKIER
	db "BOLE@@@@@@", CAMPER
	assert_table_length BATTLETOWER_NUM_UNIQUE_MON
; The following can only be sampled in Crystal 1.1.
	db "MINEL@@@@@", GENTLEMAN
	db "SCHIFER@@@", BEAUTY
	db "BRAMAS@@@@", SUPER_NERD
	db "GOKU@@@@@@", BLACKBELT_T
	db "BABOU@@@@@", COOLTRAINERF
	db "ALVES@@@@@", OFFICER
	db "PICHON@@@@", PSYCHIC_T
	db "GANON@@@@@", POKEFANM
	db "BABU@@@@@@", SCIENTIST
	db "DIPASQUALE", BEAUTY
	db "PIOLET@@@@", CAMPER
	db "LAMU@@@@@@", BIRD_KEEPER
	db "PICK@@@@@@", PICNICKER
	db "LATOUR@@@@", POKEMANIAC
	db "BEZU@@@@@@", SCIENTIST
	db "UESUGI@@@@", SAGE
	db "DUVERGER@@", SCHOOLBOY
	db "KERGOAT@@@", FISHER
	db "SUZUKI@@@@", KIMONO_GIRL
	db "MICHEL@@@@", PSYCHIC_T
	db "LECLERC@@@", CAMPER
	db "DUPOND@@@@", LASS
	db "BIGARD@@@@", GENTLEMAN
	db "MICHARD@@@", POKEFANF
	db "PATEL@@@@@", POKEMANIAC
	db "RODRIGUEZ@", YOUNGSTER
	db "LENEUF@@@@", TEACHER
	db "TROADEC@@@", SAILOR
	db "BENRAMOU@@", BLACKBELT_T
	db "COTTEN@@@@", SUPER_NERD
	db "MONDY@@@@@", COOLTRAINERF
	db "ROBERT@@@@", SWIMMERM
	db "PIAF@@@@@@", BIRD_KEEPER
	db "BARKOFF@@@", BOARDER
	db "LAMBLIN@@@", LASS
	db "HUNTER@@@@", OFFICER
	db "KILLY@@@@@", SKIER
	db "GOURIO@@@@", SCHOOLBOY
	db "SCHMITT@@@", SWIMMERF
	db "MARTIN@@@@", YOUNGSTER
	db "OLEG@@@@@@", GUITARIST
	db "LABULLE@@@", BUG_CATCHER
	db "LATRUFFE@@", BUG_CATCHER
	db "FICHER@@@@", POKEMANIAC
	db "PALU@@@@@@", SCIENTIST
	db "FLEURY@@@@", SUPER_NERD
	db "LAARSEN@@@", SWIMMERF
	db "ALIDET@@@@", BIKER
	db "ZAVATA@@@@", FIREBREATHER
else
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
endc
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
	db "KYLE@@@"
	db "STAN@@@"
	db "KENNY@@"
	db "CARTMAN"
	db "JOSEPH@"
	db "JOSHUA@"
	db "JACOB@@"
	db "ANDREW@"
	db "DANIEL@"
	db "TYLER@@"
	db "DIRK@@@"
	db "BRANDON"
	db "DAVID@@"
	db "JAMES@@"
	db "RYAN@@@"
	db "LUKE@@@"
	db "JOHN@@@"
	db "ZACHARY"
	db "JUSTIN@"
	db "WILLIAM"
	db "KEITH@@"
	db "ROBERT@"
	db "AUSTIN@"
	db "ANTHONY"
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
