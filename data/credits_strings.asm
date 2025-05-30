CreditsStringsPointers:
; entries correspond to constants/credits_constants.asm
	table_width 2, CreditsStringsPointers
	dw .SatoshiTajiri
	dw .JunichiMasuda
	dw .TetsuyaWatanabe
	dw .ShigekiMorimoto
	dw .SousukeTamada
	dw .TakenoriOota
	dw .KenSugimori
	dw .MotofumiFujiwara
	dw .AtsukoNishida
	dw .MuneoSaito
	dw .SatoshiOota
	dw .RenaYoshikawa
	dw .JunOkutani
	dw .HironobuYoshida
	dw .AsukaIwashita
	dw .GoIchinose
	dw .MorikazuAoki
	dw .KohjiNishino
	dw .KenjiMatsushima
	dw .ToshinobuMatsumiya
	dw .SatoruIwata
	dw .NobuhiroSeya
	dw .KazuhitoSekine
	dw .TetsujiOota
	dw .NclSuperMarioClub
	dw .Sarugakucho
	dw .AkitoMori
	dw .TakahiroHarada
	dw .TohruHashimoto
	dw .NoboruMatsumoto
	dw .TakehiroIzushi
	dw .TakashiKawaguchi
	dw .TsunekazuIshihara
	dw .HiroshiYamauchi
	dw .KenjiSaiki
	dw .AtsushiTada
	dw .NaokoKawakami
	dw .HiroyukiZinnai
	dw .KunimiKawamura
	dw .HisashiSogabe
	dw .KeitaKagaya
	dw .YoshinoriMatsuda
	dw .HitomiSato
	dw .ToruOsawa
	dw .TakaoOhara
	dw .YuichiroIto
	dw .TakaoShimizu
	dw .Planning
	dw .KeitaNakamura
	dw .HirotakaUemura
	dw .HiroakiTamura
	dw .NoriakiSakaguchi
	dw .MiyukiSato
	dw .GakuziNomoto
	dw .AiMashima
	dw .MikihiroIshikawa
	dw .HideyukiHashimoto
	dw .SatoshiYamato
	dw .ShigeruMiyamoto
if DEF(_FR_FR)
	dw .KaiZeh
	dw .HiroyukiUesugi
	dw .TanjaBaar
	dw .KaiNeumann
	dw .MauriceTisdale
	dw .JulienBardakoff
	dw .NicolasRobert
	dw .PatrickThieret
	dw .FrenchTestingTeam
else
	dw .GailTilden
	dw .NobOgasawara
	dw .SethMcMahill
	dw .HirotoAlexander
	dw .TeresaLillygren
	dw .ThomasHertzog
	dw .ErikJohnson
endc
	dw .HiroNakamura
	dw .TerukiMurakawa
	dw .KazuyoshiOsawa
	dw .KimikoNakamichi
	dw .End
	dw .Unknown
	dw .Staff
	dw .Director
	dw .CoDirector
	dw .Programmers
	dw .GraphicsDirector
	dw .MonsterDesign
	dw .GraphicsDesign
	dw .Music
	dw .SoundEffects
	dw .GameDesign
	dw .GameScenario
	dw .ToolProgramming
	dw .ParametricDesign
	dw .ScriptDesign
	dw .MapDataDesign
	dw .MapDesign
	dw .ProductTesting
	dw .SpecialThanks
	dw .Producers
	dw .ExecutiveProducer
	dw .PokemonAnimation
	dw .PokedexText
	dw .MobilePrjLeader
	dw .MobileSystemAd
	dw .MobileStadiumDir
	dw .Coordination
	dw .Copyright

if DEF(_FR_FR)
	dw .EquipeFrance
	dw .CoordinationEurope
	dw .TextesFrancais
	dw .TestProduit
	dw .Relecture
else
	dw .UsVersionStaff
	dw .UsCoordination
	dw .TextTranslation
	dw .PaadTesting
endc

	; Romhacking.
	dw .Romhacking
	dw .Disassembly
	dw .Programming
	dw .Pret
	dw .DamienDoury
	dw .Darkshade
	dw .SourApple
	dw .TriteHexagon
	dw .VoloGT
	dw .Garvey
	dw .BastienMaube
	dw .Empty
	assert_table_length NUM_CREDITS_STRINGS

.SatoshiTajiri:       db "   SATOSHI TAJIRI@"         ; "たじり　さとし@"
.JunichiMasuda:       db "   JUNICHI MASUDA@"         ; "ますだ　じゅんいち@"
.TetsuyaWatanabe:     db "  TETSUYA WATANABE@"        ; "わたなべ　てつや@"
.ShigekiMorimoto:     db "  SHIGEKI MORIMOTO@"        ; "もりもと　しげき@"
.SousukeTamada:       db "   SOUSUKE TAMADA@"         ; "たまだ　そうすけ@"
.TakenoriOota:        db "   TAKENORI OOTA@"          ; "おおた　たけのり@"
.KenSugimori:         db "    KEN SUGIMORI@"          ; "すぎもり　けん@"
.MotofumiFujiwara:    db " MOTOFUMI FUJIWARA@"        ; "ふじわら　もとふみ@"
.AtsukoNishida:       db "   ATSUKO NISHIDA@"         ; "にしだ　あつこ@"
.MuneoSaito:          db "    MUNEO SAITO@"           ; "さいとう　むねお@"
.SatoshiOota:         db "    SATOSHI OOTA@"          ; "おおた　さとし@"
.RenaYoshikawa:       db "   RENA YOSHIKAWA@"         ; "よしかわ　れな@"
.JunOkutani:          db "    JUN OKUTANI@"           ; "おくたに　じゅん@"
.HironobuYoshida:     db "  HIRONOBU YOSHIDA@"        ; "よしだ　ひろのぶ@"
.AsukaIwashita:       db "   ASUKA IWASHITA@"         ; "いわした　あすか@"
.GoIchinose:          db "    GO ICHINOSE@"           ; "いちのせ　ごう@"
.MorikazuAoki:        db "   MORIKAZU AOKI@"          ; "あおき　もりかず@"
.KohjiNishino:        db "   KOHJI NISHINO@"          ; "にしの　こうじ@"
.KenjiMatsushima:     db "  KENJI MATSUSHIMA@"        ; "まつしま　けんじ@"
.ToshinobuMatsumiya:  db "TOSHINOBU MATSUMIYA@"       ; "まつみや　としのぶ@"
.SatoruIwata:         db "    SATORU IWATA@"          ; "いわた　さとる@"
.NobuhiroSeya:        db "   NOBUHIRO SEYA@"          ; "せや　のぶひろ@"
.KazuhitoSekine:      db "  KAZUHITO SEKINE@"         ; "せきね　かずひと@"
.TetsujiOota:         db "    TETSUJI OOTA@"          ; "おおた　てつじ@"
.NclSuperMarioClub:   db "NCL SUPER MARIO CLUB@"      ; "スーパーマりオクラブ@"
.Sarugakucho:         db "    SARUGAKUCHO@"           ; "さるがくちょう@"
.AkitoMori:           db "     AKITO MORI@"           ; "もり　あきと@"
.TakahiroHarada:      db "  TAKAHIRO HARADA@"         ; "はらだ　たかひろ@"
.TohruHashimoto:      db "  TOHRU HASHIMOTO@"         ; "はしもと　とおる@"
.NoboruMatsumoto:     db "  NOBORU MATSUMOTO@"        ; "まつもと　のぼる@"
.TakehiroIzushi:      db "  TAKEHIRO IZUSHI@"         ; "いずし　たけひろ@"
.TakashiKawaguchi:    db " TAKASHI KAWAGUCHI@"        ; "かわぐち　たかし@"
.TsunekazuIshihara:   db " TSUNEKAZU ISHIHARA@"       ; "いしはら　つねかず@"
.HiroshiYamauchi:     db "  HIROSHI YAMAUCHI@"        ; "やまうち　ひろし@"
.KenjiSaiki:          db "    KENJI SAIKI@"           ; "さいき　けんじ@"
.AtsushiTada:         db "    ATSUSHI TADA@"          ; "ただ　あつし@"
.NaokoKawakami:       db "   NAOKO KAWAKAMI@"         ; "かわかみ　なおこ@"
.HiroyukiZinnai:      db "  HIROYUKI ZINNAI@"         ; "じんない　ひろゆき@"
.KunimiKawamura:      db "  KUNIMI KAWAMURA@"         ; "かわむら　くにみ@"
.HisashiSogabe:       db "   HISASHI SOGABE@"         ; "そがべ　ひさし@"
.KeitaKagaya:         db "    KEITA KAGAYA@"          ; "かがや　けいた@"
.YoshinoriMatsuda:    db " YOSHINORI MATSUDA@"        ; "まつだ　よしのり@"
.HitomiSato:          db "    HITOMI SATO@"           ; "さとう　ひとみ@"
.ToruOsawa:           db "     TORU OSAWA@"           ; "おおさわ　とおる@"
.TakaoOhara:          db "    TAKAO OHARA@"           ; "おおはら　たかお@"
.YuichiroIto:         db "    YUICHIRO ITO@"          ; "いとう　ゆういちろう@"
.TakaoShimizu:        db "   TAKAO SHIMIZU@"          ; "しみず　たかお@"
.Planning:            db " SPECIAL PRODUCTION"
                    next "      PLANNING"             ; "きかくかいはつぶ@"
                    next " & DEVELOPMENT DEPT.@"
.KeitaNakamura:       db "   KEITA NAKAMURA@"         ; "なかむら　けいた@"
.HirotakaUemura:      db "  HIROTAKA UEMURA@"         ; "うえむら　ひろたか@"
.HiroakiTamura:       db "   HIROAKI TAMURA@"         ; "たむら　ひろあき@"
.NoriakiSakaguchi:    db " NORIAKI SAKAGUCHI@"        ; "さかぐち　のりあき@"
.MiyukiSato:          db "    MIYUKI SATO@"           ; "さとう　みゆき@"
.GakuziNomoto:        db "   GAKUZI NOMOTO@"          ; "のもと　がくじ@"
.AiMashima:           db "     AI MASHIMA@"           ; "ましま　あい@"
.MikihiroIshikawa:    db " MIKIHIRO ISHIKAWA@"        ; "いしかわ　みきひろ@"
.HideyukiHashimoto:   db " HIDEYUKI HASHIMOTO@"       ; "はしもと　ひでゆき@"
.SatoshiYamato:       db "   SATOSHI YAMATO@"         ; "やまと　さとし@"
.ShigeruMiyamoto:     db "  SHIGERU MIYAMOTO@"        ; "みやもと　しげる@"
.End:                 db "        END@"               ; "おしまい@"
.Unknown:             db "      ????????@"            ; "？？？？？？？？@"

if DEF(_FR_FR)
.KaiZeh:              db "      KAI ZEH@"
.HiroyukiUesugi:      db "  HIROYUKI UESUGI@"
.TanjaBaar:           db "     TANJA BAAR@"
.KaiNeumann:          db "    KAI NEUMANN@"
.MauriceTisdale:      db "  MAURICE TISDALE@"
.JulienBardakoff:     db "  JULIEN BARDAKOFF@"
.NicolasRobert:       db "   NICOLAS ROBERT@"
.PatrickThieret:      db "  PATRICK THIERET@"
.FrenchTestingTeam:   db "FRENCH TESTING TEAM@"
else
.GailTilden:          db "    GAIL TILDEN@"
.NobOgasawara:        db "   NOB OGASAWARA@"
.SethMcMahill:        db "   SETH McMAHILL@"
.HirotoAlexander:     db "  HIROTO ALEXANDER@"
.TeresaLillygren:     db "  TERESA LILLYGREN@"
.ThomasHertzog:       db "   THOMAS HERTZOG@"
.ErikJohnson:         db "    ERIK JOHNSON@"
endc

.HiroNakamura:        db "   HIRO NAKAMURA@"
.TerukiMurakawa:      db "  TERUKI MURAKAWA@"
.KazuyoshiOsawa:      db "  KAZUYOSHI OSAWA@"
.KimikoNakamichi:     db "  KIMIKO NAKAMICHI@"
.Staff:               db "      #MON"                 ; "ポケットモンスター"

if DEF(_FR_FR)
                    next "  Version Cristal"          ; "　　クりスタル　バージョン"
                    next "       Equipe@"             ; "　　　　スタッフ@"
.Director:            db "     Directeur@"            ; "エグゼクティブ　ディレクター@"
.CoDirector:          db "   Sous-directeur@"         ; "ディレクター@"
.Programmers:         db "    Programmeurs@"          ; "プログラム@"
.GraphicsDirector:    db "Directeur graphique@"       ; "グラフィック　ディレクター@"
.MonsterDesign:       db "  Design monstres@"         ; "#　デザイン@"
.GraphicsDesign:      db " Design graphiques@"        ; "グラフィック　デザイン@"
.Music:               db "      Musique@"             ; "おんがく@"
.SoundEffects:        db "   Effets sonores@"         ; "サウンド　エフェクト@"
.GameDesign:          db "     Design jeu@"           ; "ゲームデザイン@"
.GameScenario:        db "      Scénario@"            ; "シナりオ@"
.ToolProgramming:     db " Programme config@"         ; "ツール　プログラム@"
.ParametricDesign:    db " Design paramètres@"        ; "パラメーター　せってい@"
.ScriptDesign:        db "   Design script@"          ; "スクりプト　せってい@"
.MapDataDesign:       db "Design donnée carte@"       ; "マップデータ　せってい@"
.MapDesign:           db "    Design carte@"          ; "マップ　デザイン@"
.ProductTesting:      db "    Test Produit@"          ; "デバッグプレイ@"
.SpecialThanks:       db "  Un grand merci à@"        ; "スぺシャルサンクス@"
.Producers:           db "    Producteurs@"           ; "プロデューサー@"
.ExecutiveProducer:   db "Producteur exécutif@"       ; "エグゼクティブ　プロデューサー@"
.PokemonAnimation:    db " Animation #MON@"           ; "#　アニメーション@"
.PokedexText:         db "   Texte #DEX@"             ; "ずかん　テキスト@"
.MobilePrjLeader:     db "@"                          ; "モバイルプロジェクト　りーダー@"
.MobileSystemAd:      db "@"                          ; "モバイル　システムアドバイザー@"
.MobileStadiumDir:    db "@"                          ; "モバイルスタジアム　ディレクター@"
.Coordination:        db "    Coordination@"          ; "コーディネーター@"
.EquipeFrance:        db "   Equipe France@"
.CoordinationEurope:  db "Coordination Europe@"
.TextesFrancais:      db "  Textes Français@"
.TestProduit:         db "    Test Produit@"
.Relecture:           db "     Relecture@"

else
                    next "  CRYSTAL VERSION"          ; "　　クりスタル　バージョン"
                    next "       STAFF@"              ; "　　　　スタッフ@"
.Director:            db "      DIRECTOR@"            ; "エグゼクティブ　ディレクター@"
.CoDirector:          db "    CO-DIRECTOR@"           ; "ディレクター@"
.Programmers:         db "    PROGRAMMERS@"           ; "プログラム@"
.GraphicsDirector:    db " GRAPHICS DIRECTOR@"        ; "グラフィック　ディレクター@"
.MonsterDesign:       db "   MONSTER DESIGN@"         ; "#　デザイン@"
.GraphicsDesign:      db "  GRAPHICS DESIGN@"         ; "グラフィック　デザイン@"
.Music:               db "       MUSIC@"              ; "おんがく@"
.SoundEffects:        db "   SOUND EFFECTS@"          ; "サウンド　エフェクト@"
.GameDesign:          db "    GAME DESIGN@"           ; "ゲームデザイン@"
.GameScenario:        db "   GAME SCENARIO@"          ; "シナりオ@"
.ToolProgramming:     db "  TOOL PROGRAMMING@"        ; "ツール　プログラム@"
.ParametricDesign:    db " PARAMETRIC DESIGN@"        ; "パラメーター　せってい@"
.ScriptDesign:        db "   SCRIPT DESIGN@"          ; "スクりプト　せってい@"
.MapDataDesign:       db "  MAP DATA DESIGN@"         ; "マップデータ　せってい@"
.MapDesign:           db "     MAP DESIGN@"           ; "マップ　デザイン@"
.ProductTesting:      db "  PRODUCT TESTING@"         ; "デバッグプレイ@"
.SpecialThanks:       db "   SPECIAL THANKS@"         ; "スぺシャルサンクス@"
.Producers:           db "     PRODUCERS@"            ; "プロデューサー@"
.ExecutiveProducer:   db " EXECUTIVE PRODUCER@"       ; "エグゼクティブ　プロデューサー@"
.PokemonAnimation:    db " #MON ANIMATION@"           ; "#　アニメーション@"
.PokedexText:         db "    #DEX TEXT@"             ; "ずかん　テキスト@"
.MobilePrjLeader:     db " MOBILE PRJ. LEADER@"       ; "モバイルプロジェクト　りーダー@"
.MobileSystemAd:      db " MOBILE SYSTEM AD.@"        ; "モバイル　システムアドバイザー@"
.MobileStadiumDir:    db "MOBILE STADIUM DIR.@"       ; "モバイルスタジアム　ディレクター@"
.Coordination:        db "    COORDINATION@"          ; "コーディネーター@"
.UsVersionStaff:      db "  US VERSION STAFF@"
.UsCoordination:      db "  US COORDINATION@"
.TextTranslation:     db "  TEXT TRANSLATION@"
.PaadTesting:         db "    PAAD TESTING@"
endc

if DEF(_FR_FR)
.Romhacking:		  db "    ROM hacking@"
.Disassembly		  db "   Désassemblage@"
.Programming		  db "   Programmation@"
else
.Romhacking:		  db "    ROM HACKING@"
.Disassembly		  db "    DISASSEMBLY@"
.Programming		  db "    PROGRAMMING@"
endc
.Pret		  		  db "  github.com/pret@"
.DamienDoury:		  db "    DAMIEN DOURY@"
.Darkshade:			  db "     DARKSHADE@"
.SourApple:			  db "     SOURAPPLE@"
.TriteHexagon:		  db "   <AT>TriteHexagon@"
.VoloGT:		 	  db "  ANDRIY SKOVORODA@"
.Garvey:		      db "       Garvey@" ; Vitalien.
.BastienMaube:		  db "    Bastien MAUBE@"
.Empty:				  db "@"

.Copyright:
	;     ©  1  9  9  5 - 2  0  0  1   N  i  n  t  e  n  d  o
	db   $60,$61,$62,$63,$64,$65,$66,  $67,$68,$69,$6a,$6b,$6c
	;     ©  1  9  9  5 - 2  0  0  1   C  r  e  a  t  u  r  e  s     i  n  c .
	next $60,$61,$62,$63,$64,$65,$66,  $6d,$6e,$6f,$70,$71,$72,      $7a,$7b,$7c
	;     ©  1  9  9  5 - 2  0  0  1   G  A  M  E  F  R  E  A  K     i  n  c .
	next $60,$61,$62,$63,$64,$65,$66,  $73,$74,$75,$76,$77,$78,$79,  $7a,$7b,$7c
	; 	  ©  2  0  2  1 - 2  0  2  5   H  e  y  k  i  n  o  x
	next $60,$9d,$9e,$9f,$a0,$a1,$a2,  $a3,$a4,$a5,$a6,$a7,$a8
	db "@"
