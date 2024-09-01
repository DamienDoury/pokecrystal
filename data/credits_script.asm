CreditsScript:

; Clear the banner.
	db CREDITS_CLEAR

; Play the credits music.
	db CREDITS_MUSIC

; Pokemon Crystal Version Staff
	db                STAFF, 0

	db   CREDITS_WAIT, 10

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 0 ; Bellossom

	db             DIRECTOR, 2
	db       SATOSHI_TAJIRI, 4

	db CREDITS_WAIT, 11

	db           CODIRECTOR, 2
	db       JUNICHI_MASUDA, 4

	db CREDITS_WAIT, 11

	db          PROGRAMMERS, 0
	db       SOUSUKE_TAMADA, 2
	db       HISASHI_SOGABE, 3
	db         KEITA_KAGAYA, 4
	db    YOSHINORI_MATSUDA, 5

	db CREDITS_WAIT, 11

	db          PROGRAMMERS, 0
	db     SHIGEKI_MORIMOTO, 2
	db     TETSUYA_WATANABE, 3
	db        TAKENORI_OOTA, 4

	db CREDITS_WAIT, 11

	db    GRAPHICS_DIRECTOR, 2
	db         KEN_SUGIMORI, 4

	db CREDITS_WAIT, 11

	db       MONSTER_DESIGN, 0
	db         KEN_SUGIMORI, 2
	db    MOTOFUMI_FUJIWARA, 3
	db     SHIGEKI_MORIMOTO, 4
	db       MONSTER_DESIGN, 5
	db     HIRONOBU_YOSHIDA, 6
	
	db CREDITS_WAIT, 11
	
	db       MONSTER_DESIGN, 0
	db         SATOSHI_OOTA, 2
	db       ATSUKO_NISHIDA, 3
	db          MUNEO_SAITO, 4
	db       RENA_YOSHIKAWA, 5

	db CREDITS_WAIT, 11

	db    POKEMON_ANIMATION, 1
	db     HIRONOBU_YOSHIDA, 3
	db          JUN_OKUTANI, 4

	db CREDITS_WAIT, 11

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 1 ; Smoochum

	db      GRAPHICS_DESIGN, 0
	db     HIRONOBU_YOSHIDA, 2
	db          JUN_OKUTANI, 3
	db       ASUKA_IWASHITA, 4
	db     TETSUYA_WATANABE, 5

	db CREDITS_WAIT, 10

	db         CREDIT_MUSIC, 0
	db       JUNICHI_MASUDA, 2
	db        MORIKAZU_AOKI, 3
	db          GO_ICHINOSE, 4

	db CREDITS_WAIT, 10

	db CREDIT_SOUND_EFFECTS, 0
	db        MORIKAZU_AOKI, 2
	db       JUNICHI_MASUDA, 3
	db     TETSUYA_WATANABE, 4

	db CREDITS_WAIT, 10

	db          GAME_DESIGN, 0
	db       JUNICHI_MASUDA, 2
	db     SHIGEKI_MORIMOTO, 3
	db        KOHJI_NISHINO, 4

	db CREDITS_WAIT, 10

	db          GAME_DESIGN, 0
	db         TETSUJI_OOTA, 2
	db          HITOMI_SATO, 3
	db     KENJI_MATSUSHIMA, 4

	db CREDITS_WAIT, 10

	db        GAME_SCENARIO, 1
	db       JUNICHI_MASUDA, 3
	db        KOHJI_NISHINO, 4

	db CREDITS_WAIT, 10

	db        GAME_SCENARIO, 1
	db  TOSHINOBU_MATSUMIYA, 3
	db     KENJI_MATSUSHIMA, 4

	db CREDITS_WAIT, 10

	db         POKEDEX_TEXT, 2
	db  TOSHINOBU_MATSUMIYA, 4

	db CREDITS_WAIT, 10

	db     TOOL_PROGRAMMING, 1
	db       SOUSUKE_TAMADA, 3
	db        TAKENORI_OOTA, 4

	db CREDITS_WAIT, 10

	db    PARAMETRIC_DESIGN, 2
	db        KOHJI_NISHINO, 4

	db CREDITS_WAIT, 10

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 2 ; Ditto

	db        SCRIPT_DESIGN, 1
	db         TETSUJI_OOTA, 3
	db        NOBUHIRO_SEYA, 4

	db CREDITS_WAIT, 11

	db      MAP_DATA_DESIGN, 1
	db         TETSUJI_OOTA, 3
	db      KAZUHITO_SEKINE, 4

	db CREDITS_WAIT, 11

	db           MAP_DESIGN, 0
	db         TETSUJI_OOTA, 2
	db        KOHJI_NISHINO, 3
	db        NOBUHIRO_SEYA, 4

	db CREDITS_WAIT, 11

	db         COORDINATION, 2
	db      HIROYUKI_ZINNAI, 4

	db CREDITS_WAIT, 11

	db            PRODUCERS, 0
	db         SATORU_IWATA, 2
	db       SATOSHI_YAMATO, 3
	db     SHIGERU_MIYAMOTO, 4
	db   TSUNEKAZU_ISHIHARA, 5

	db CREDITS_WAIT, 11

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 3 ; Togepi

	db     US_VERSION_STAFF, 2

	db CREDITS_WAIT, 10

	db      US_COORDINATION, 0
	db          GAIL_TILDEN, 2
	db        HIRO_NAKAMURA, 3
	db       JUNICHI_MASUDA, 4
	
	db CREDITS_WAIT, 10
	
	db      US_COORDINATION, 0
	db        SETH_MCMAHILL, 2
	db     HIROTO_ALEXANDER, 3
	db     TERESA_LILLYGREN, 4

	db CREDITS_WAIT, 10

	db     TEXT_TRANSLATION, 2
	db        NOB_OGASAWARA, 4

	db CREDITS_WAIT, 10

	db          PROGRAMMERS, 1
	db      TERUKI_MURAKAWA, 3
	db      KAZUYOSHI_OSAWA, 4

	db CREDITS_WAIT, 10

	db         PAAD_TESTING, 1
	db       THOMAS_HERTZOG, 3
	db         ERIK_JOHNSON, 4

	db CREDITS_WAIT, 10

	db      PRODUCT_TESTING, 0
	db             PLANNING, 2

	db CREDITS_WAIT, 10

	db      PRODUCT_TESTING, 0
	db       KEITA_NAKAMURA, 2
	db      HIROTAKA_UEMURA, 3
	db       HIROAKI_TAMURA, 4
	db    NORIAKI_SAKAGUCHI, 5

	db CREDITS_WAIT, 10

	db      PRODUCT_TESTING, 0
	db NCL_SUPER_MARIO_CLUB, 2
	db          KENJI_SAIKI, 3
	db         ATSUSHI_TADA, 4
	db          MIYUKI_SATO, 5

	db CREDITS_WAIT, 11

	db       SPECIAL_THANKS, 0
	db     KIMIKO_NAKAMICHI, 2
	db           AKITO_MORI, 3
	db        GAKUZI_NOMOTO, 4
	db           AI_MASHIMA, 5
	
	db CREDITS_WAIT, 10
	
	db       SPECIAL_THANKS, 0
	db      KUNIMI_KAWAMURA, 2
	db    MIKIHIRO_ISHIKAWA, 3
	db   HIDEYUKI_HASHIMOTO, 4

	db CREDITS_WAIT, 10

	db   EXECUTIVE_PRODUCER, 2
	db     HIROSHI_YAMAUCHI, 4

	db CREDITS_WAIT, 11

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 4 ; igglybuff

	db     ROM_HACKING, 2

	db CREDITS_WAIT, 11

	db        DISASSEMBLY, 2
	db               PRET, 4

	db CREDITS_WAIT, 11

	db      GAME_SCENARIO, 0
	db        GAME_DESIGN, 1
	db        PROGRAMMING, 2
	db       DAMIEN_DOURY, 4

	db CREDITS_WAIT, 11

	db    GRAPHICS_DESIGN, 0
	db          DARKSHADE, 2
	db 			SOURAPPLE, 3
	db       DAMIEN_DOURY, 4

	db CREDITS_WAIT, 11

	db       CREDIT_MUSIC, 1
	db       TRITEHEXAGON, 3

	db CREDITS_WAIT, 11

	db    PRODUCT_TESTING, 0
	db       DAMIEN_DOURY, 2
	db             VOLOGT, 3
	db             GARVEY, 4
	db      BASTIEN_MAUBE, 5

	db CREDITS_WAIT, 11

	db      CREDITS_EMPTY, 0

	db CREDITS_WAIT, 1

	db          COPYRIGHT, 1

	db CREDITS_WAIT, 11

	db      CREDITS_EMPTY, 0

	db CREDITS_WAIT, 2

; Display "The End" graphic.
	db CREDITS_THEEND

	db CREDITS_WAIT, 15

	db CREDITS_END
