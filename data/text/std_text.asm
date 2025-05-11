NurseMornText: ; TO TRANSLATE
	text "Good morning!"
	;line "Welcome to our"
	;cont "#MON CENTER."
	done

NurseDayText: ; TO TRANSLATE
	text "Hello!"
	;line "Welcome to our"
	;cont "#MON CENTER."
	done

NurseNiteText: ; TO TRANSLATE
	text "Good evening!"
	;line "You're out late." ; Damien
	
	;para "Welcome to our"
	;line "#MON CENTER."
	done

PokeComNurseMornText:
if DEF(_FR_FR)
	text "Bonjour!"
	
	para "Voici le CENTRE de"
	line "COMMUNICATION"
	
	para "#MON... Ou"
	line "CENTRE #COM."
	done
else
	text "Good morning!"
	
	para "This is the #-"
	line "MON COMMUNICATION"
	
	para "CENTER--or the"
	line "#COM CENTER."
	done
endc


PokeComNurseDayText:
if DEF(_FR_FR)
	text "Bonjour!"
	
	para "Voici le CENTRE de"
	line "COMMUNICATION"
	
	para "#MON... Ou"
	line "CENTRE #COM."
	done
else
	text "Hello!"
	
	para "This is the #-"
	line "MON COMMUNICATION"
	
	para "CENTER--or the"
	line "#COM CENTER."
	done
endc


PokeComNurseNiteText:
if DEF(_FR_FR)
	text "Vous êtes debout"
	line "bien tard!"
	
	para "Voici le CENTRE de"
	line "COMMUNICATION"
	
	para "#MON... Ou"
	line "CENTRE #COM."
	done
else
	text "Good to see you"
	line "working so late."
	
	para "This is the #-"
	line "MON COMMUNICATION"
	
	para "CENTER--or the"
	line "#COM CENTER."
	done
endc


NurseAskHealText: ; TO TRANSLATE
	text "Shall we heal your"
	line "#MON?"
	done

NurseAskTestText: ; TO TRANSLATE
	text "Should we perform"
	line "a PCR test also?"
	
	para "For @"
	text_ram wStringBuffer3 
	text " it costs"
	line "¥@"
	text_ram wStringBuffer3
	text "00."
	done

NurseHealOnlyText: ; TO TRANSLATE
	text "OK, heal only."
	done

NurseThanksText: ; TO TRANSLATE
	text "Thank you."
	done

NurseTakePokemonText: ; TO TRANSLATE
	text "May I see your"
	line "#MON?"
	done

NurseReturnPokemonText: ; TO TRANSLATE
	;text "Thank you for" ; Damien
	;line "waiting."
	
	;para "Your #MON are"
	;line "fully healed."
	done

NurseNotEnoughMoneyText: ; TO TRANSLATE
	text "I am sorry but you"
	line "don't have enough"
	cont "for the PCR test."
	done

NurseBallsDisinfectedText: ; TO TRANSLATE
	text "Your #BALLS"
	line "have been"
	cont "disinfected."
	done

NurseGoodbyeText:: ; TO TRANSLATE
	text "We hope to see you"
	line "again."
	done

NursePCRArrivedText: ; TO TRANSLATE
	text "We would like to"
	line "inform you about"
	cont "a new service in"
	cont "#MON CENTERS."
	
	para "PCR tests have"
	line "arrived!"
	
	para "Their purpose is"
	line "to determine if"
	cont "your #MON are"
	cont "currently infected"
	cont "by the virus."
	
	para "The results are" 
	line "known instantly"
	cont "and it costs only"
	cont "¥100 per #MON."
	
	para "Trainers are ad-"
	line "vised to frequent-"
	cont "ly test their"
	cont "party."
	
	done

NurseTestsNegativeText: ; TO TRANSLATE
	text "All PCR tests are"
	line "negative."
	done

NurseOtherTestsNegativeText: ; TO TRANSLATE
	text "The other PCR"
	line "tests are"
	cont "negative."
	done

NurseCriticallyIllText: ; TO TRANSLATE
	text "Oh my…"
	line " "
	
	para "Your @"
	
	text_ram wStringBuffer1
	text_start
	
	line "is critically ill"
	cont "and needs imme-"
	cont "diate care."
	
	para "It looks like a"
	line "severe form of"
	cont "COVID…"
	
	para "I must send it to"
	line "the hospital right"
	cont "now, before it's"
	cont "too late."
	done

NurseCriticallyIllMail1Text: ; TO TRANSLATE
	text "The @"
	
	text_ram wStringBuffer1
	text " "
	
	line "it was holding"
	cont "has been sent to"
	cont "your MAIL BOX."
	done

NurseCriticallyIllMail2Text: ; TO TRANSLATE
	text "I couldn't send its"
	line "@"
	
	text_ram wStringBuffer1
	text " to the"
	
	cont "PC so its message"
	cont "has been lost."
	
	para "You can have it"
	line "back though."
	done

NurseCriticallyIllMail3Text: ; TO TRANSLATE
	text "Your MAIL BOX and"
	line "your PACK are full"
	cont "so I will keep the"
	cont "@"
	
	text_ram wStringBuffer1
	
	text " your"
	cont "#MON held."
	done

NurseCriticallyIll2Text: ; TO TRANSLATE
	text "You can go check"
	line "on your #MON"
	cont "at GOLDENROD"
	cont "NATIONAL HOSPITAL."
	done

NurseMildIllnessText: ; TO TRANSLATE
	text "Some of your"
	line "#MON had a mild"
	cont "illness, but they"
	cont "have been taken"
	cont "care of and they"
	cont "are now cured!"
	done

NursePokerusReaction: ; TO TRANSLATE
	text "Some of your"
	line "#MON appear"
	
	para "to be infected"
	line "by the virus."
	done

NursePokerusLongTextStart: ; TO TRANSLATE
	text "They may feel"
	line "exhausted and may"
	cont "have headaches."
	
	para "We don't know"
	line "yet how to heal"
	cont "the disease."
	
	para "Your #MON"
	line "should get better"
	cont "within 5 days."
	done

NursePokerusRecommendsVaccinationText: ; TO TRANSLATE
	text "Once the symptoms"
	line "are gone, you can"
	cont "get your #MON"
	cont "vaccinated at"
	cont "SAFFRON CITY's"
	cont "vaccination"
	cont "center."
	done

NursePokerusEssentialText: ; TO TRANSLATE
	text "Please keep them"
	line "confined inside"
	cont "their #BALL"
	cont "until they"
	cont "feel better."
	done

NursePokerusLongTextEnd: ; TO TRANSLATE
	text "Once cured, they"
	line "should be immuned"
	cont "for a long time."
	done

NurseAbandonedMonText: ; TO TRANSLATE
	text "Wait!!"
	
	para "You no longer have"
	line "a #MON and you"
	cont "can't go out"
	cont "without one!"
	
	para "#MON CENTERs"
	line "accommodate"
	cont "abandoned #MON"
	cont "waiting to be"
	cont "rehomed with a"
	cont "new trainer."
	
	para "Please take care"
	line "of this one."
	done

DifficultBookshelfText:
if DEF(_FR_FR)
	text "C'est rempli de"
	line "livres compliqués."
	done
else
	text "It's full of"
	line "difficult books."
	done
endc


PictureBookshelfText:
if DEF(_FR_FR)
	text "Une collection de"
	line "livres d'images"
	cont "#MON!"
	done
else
	text "A whole collection"
	line "of #MON picture"
	cont "books!"
	done
endc


MagazineBookshelfText:
if DEF(_FR_FR)
	text "Magazines #MON…"
	line "STYLO #MON,"
	
	para "CAHIER #MON,"
	line "GRAPH #MON..."
	done
else
	text "#MON magazines…"
	line "#MON PAL,"
	
	para "#MON HANDBOOK,"
	line "#MON GRAPH…"
	done
endc


TeamRocketOathText: ; TO TRANSLATE
	text "TEAM ROCKET OATH"
	
	para "Steal #MON for"
	line "profit!"
	
	para "Fight for"
	line "freedom!"
	
	para "The world"
	line "belongs to"
	cont "TEAM ROCKET!"
	done

IncenseBurnerText:
if DEF(_FR_FR)
	text "C'est quoi donc?"
	
	para "Oh, c'est un"
	line "brûleur d'encens!"
	done
else
	text "What is this?"
	
	para "Oh, it's an"
	line "incense burner!"
	done
endc


MerchandiseShelfText:
if DEF(_FR_FR)
	text "Tout plein de"
	line "trucs #MON!"
	done
else
	text "Lots of #MON"
	line "merchandise!"
	done
endc


MerchandiseGoneText: ; TO TRANSLATE
	text "Everything of"
	line "interest is gone…"
	done

LookTownMapText:
if DEF(_FR_FR)
	text "C'est la CARTE."
	done
else
	text "It's the TOWN MAP."
	done
endc


WindowText:
if DEF(_FR_FR)
	text "Oh..."
	line "Que c'est beau!"
	done
else
	text "My reflection!"
	line "Lookin' good!"
	done
endc


WindowClappingText: ; TO TRANSLATE
	text "People are"
	line "clapping at their"
	cont "window from all"
	cont "directions."
	done

TVText:
if DEF(_FR_FR)
	text "C'est la TV."
	done
else
	text "It's a TV."
	done
endc


HomepageText:
if DEF(_FR_FR)
	text "JOURNAL #MON:"
	line "HOME PAGE…"
	
	para "Ce n'est pas"
	line "mis à jour…"
	done
	
	; not used
	text "#MON RADIO!"
	
	para "Appelez-nous et"
	line "faites passer un"
	cont "tube!"
	done
else
	text "#MON JOURNAL"
	line "HOME PAGE…"
	
	para "It hasn't been"
	line "updated…"
	done
	
	; not used
	text "#MON RADIO!"
	
	para "Call in with your"
	line "requests now!"
	done
endc


TrashCanText:
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "là-dedans…"
	done
	
	; not used
	text "Un #MON"
	line "pourrait sûrement"
	cont "déplacer ça."
	done
	
	; not used
	text "Un #MON"
	line "pourrait peut-être"
	cont "casser ça."
	done
else
	text "There's nothing in"
	line "here…"
	done
	
	; not used
	text "A #MON may be"
	line "able to move this."
	done
	
	; not used
	text "Maybe a #MON"
	line "can break this."
	done
endc


PokecenterSignText:
if DEF(_FR_FR)
	text "Soignez donc vos"
	line "#MON au... "
	cont "CENTRE #MON!!!"
	done
else
	text "Heal Your #MON!"
	line "#MON CENTER"
	done
endc


MartSignText:
if DEF(_FR_FR)
	text "Pour tout acheter,"
	line "pour tout trouver:"
	
	para "BOUTIQUE #MON!"
	done
else
	text "For All Your"
	line "#MON Needs"
	
	para "#MON MART"
	done
endc


ContestResults_ReadyToJudgeText:
if DEF(_FR_FR)
	text "On va maintenant"
	line "juger vos #MON"
	cont "capturés."
	
	para "<……>"
	line "<……>"
	
	para "Nous avons choisi"
	line "les vainqueurs!"
	
	para "Vous êtes prêts?"
	done
else
	text "We will now judge"
	line "the #MON you've"
	cont "caught."
	
	para "<……>"
	line "<……>"
	
	para "We have chosen the"
	line "winners!"
	
	para "Are you ready for"
	line "this?"
	done
endc


ContestResults_PlayerWonAPrizeText:
if DEF(_FR_FR)
	text "Le No. @"
	text_ram wStringBuffer3
	text_start
	line "<PLAYER> gagne:"
	cont "@"
	text_ram wStringBuffer4
	text "!"
	done
else
	text "<PLAYER>, the No.@"
	text_ram wStringBuffer3
	text_start
	line "finisher, wins"
	cont "@"
	text_ram wStringBuffer4
	text "!"
	done
endc


ReceivedItemText:
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "@"
	text_ram wStringBuffer4
	text "."
	done
else
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer4
	text "."
	done
endc


ContestResults_JoinUsNextTimeText:
if DEF(_FR_FR)
	text "A la prochaine"
	line "pour un autre"
	cont "concours!"
	done
else
	text "Please join us for"
	line "the next Contest!"
	done
endc


ContestResults_ConsolationPrizeText:
if DEF(_FR_FR)
	text "Tout le monde"
	line "gagne une BAIE en"
	cont "lot de"
	cont "consolation!"
	done
else
	text "Everyone else gets"
	line "a BERRY as a con-"
	cont "solation prize!"
	done
endc


ContestResults_DidNotWinText:
if DEF(_FR_FR)
	text "Faites mieux la"
	line "prochaine fois."
	done
else
	text "We hope you do"
	line "better next time."
	done
endc


ContestResults_ReturnPartyText:
if DEF(_FR_FR)
	text "Voici les #MON"
	line "que nous gardions"
	
	para "pour vous."
	line "Merci bien!"
	done
else
	text "We'll return the"
	line "#MON we kept"
	
	para "for you."
	line "Here you go!"
	done
endc


ContestResults_PartyFullText:
if DEF(_FR_FR)
	text "Equipe pleine! Le"
	line "#MON est envoyé"
	
	para "dans la BOITE du"
	line "PC de LEO."
	done
else
	text "Your party's full,"
	line "so the #MON was"
	
	para "sent to your BOX"
	line "in BILL's PC."
	done
endc


GymStatue_CityGymText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "ARENE #MON"
	done
else
	text_ram wStringBuffer3
	text_start
	line "#MON GYM"
	done
endc


GymStatue_ChallengeGymText: ; TO TRANSLATE
	text "Challenge:"
	line "@"
	text_ram wStringBuffer3
	text " "
	done

GymStatue_WinningTrainersText:
if DEF(_FR_FR)
	text "CHAMPION:"
	line "@"
	text_ram wStringBuffer4
	text_start
	para "DRESSEURS"
	line "VAINQUEURS:"
	cont "<PLAYER>"
	done
else
	text "LEADER: @"
	text_ram wStringBuffer4
	text_start
	para "WINNING TRAINERS:"
	line "<PLAYER>"
	done
endc


CoinVendor_WelcomeText:
if DEF(_FR_FR)
	text "Bienvenue au"
	line "CASINO."
	done
else
	text "Welcome to the"
	line "GAME CORNER."
	done
endc


CoinVendor_NoCoinCaseText:
if DEF(_FR_FR)
	text "Voulez-vous des"
	line "jetons?"
	
	para "Mais...! Vous"
	line "n'avez pas de"
	cont "BOITE JETON!"
	done
else
	text "Do you need game"
	line "coins?"
	
	para "Oh, you don't have"
	line "a COIN CASE for"
	cont "your coins."
	done
endc


CoinVendor_IntroText:
if DEF(_FR_FR)
	text "Voulez-vous des"
	line "jetons?"
	
	para "C'est 1000¥ pour"
	line "50 jetons. Ca vous"
	cont "tente toujours?"
	done
else
	text "Do you need some"
	line "game coins?"
	
	para "It costs ¥1000 for"
	line "50 coins. Do you"
	cont "want some?"
	done
endc


CoinVendor_Buy50CoinsText:
if DEF(_FR_FR)
	text "Merci!"
	line "Voici 50 jetons."
	done
else
	text "Thank you!"
	line "Here are 50 coins."
	done
endc


CoinVendor_Buy500CoinsText:
if DEF(_FR_FR)
	text "Merci! Voici"
	line "500 jetons."
	done
else
	text "Thank you! Here"
	line "are 500 coins."
	done
endc


CoinVendor_NotEnoughMoneyText:
if DEF(_FR_FR)
	text "Vous n'avez pas"
	line "assez de sous."
	done
else
	text "You don't have"
	line "enough money."
	done
endc


CoinVendor_CoinCaseFullText:
if DEF(_FR_FR)
	text "Houlà! Votre BOITE"
	line "JETON est pleine."
	done
else
	text "Whoops! Your COIN"
	line "CASE is full."
	done
endc


CoinVendor_CancelText:
if DEF(_FR_FR)
	text "Pas de jetons?"
	line "Alors à bientôt!"
	done
else
	text "No coins for you?"
	line "Come again!"
	done
endc


BugContestPrizeNoRoomText:
if DEF(_FR_FR)
	text "Votre SAC"
	line "est plein!!!"
	
	para "Nous allons garder"
	line "ceci pour vous."
	
	para "Faites de la place"
	line "et revenez."
	done
else
	text "Oh? Your PACK is"
	line "full."
	
	para "We'll keep this"
	line "for you today, so"
	
	para "come back when you"
	line "make room for it."
	done
endc


HappinessText3:
if DEF(_FR_FR)
	text "Woah! Toi et ton"
	line "#MON êtes"
	cont "super proches!"
	done
else
	text "Wow! You and your"
	line "#MON are really"
	cont "close!"
	done
endc


HappinessText2:
if DEF(_FR_FR)
	text "Les #MON de-"
	line "viennent plus ami-"
	
	para "caux en passant du"
	line "temps avec eux."
	done
else
	text "#MON get more"
	line "friendly if you"
	
	para "spend time with"
	line "them."
	done
endc


HappinessText1:
if DEF(_FR_FR)
	text "Tu n'as pas"
	line "apprivoisé ton"
	cont "#MON."
	
	para "Si tu n'es pas"
	line "sympa, il fera la"
	cont "tête."
	done
else
	text "You haven't tamed"
	line "your #MON."
	
	para "If you aren't"
	line "nice, it'll pout."
	done
endc


RegisteredNumber1Text:
if DEF(_FR_FR)
	text "<PLAYER> enregistre"
	line "le No. de @"
	text_ram wStringBuffer3
	text "."
	done
else
	text "<PLAYER> registered"
	line "@"
	text_ram wStringBuffer3
	text "'s number."
	done
endc


RegisteredNumber2Text:
if DEF(_FR_FR)
	text "<PLAYER> enregistre"
	line "le No. de @"
	text_ram wStringBuffer3
	text "."
	done
else
	text "<PLAYER> registered"
	line "@"
	text_ram wStringBuffer3
	text "'s number."
	done
endc
