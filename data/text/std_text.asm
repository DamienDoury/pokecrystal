NurseMornText:
if DEF(_FR_FR)
	text "Bien le bonjour!"
	done
else
	text "Good morning!"
	;line "Welcome to our"
	;cont "#MON CENTER."
	done
endc


NurseDayText:
if DEF(_FR_FR)
	text "Salut!"
	done
else
	text "Hello!"
	;line "Welcome to our"
	;cont "#MON CENTER."
	done
endc
	

NurseNiteText:
if DEF(_FR_FR)
	text "Bonsoir!"
	done
else
	text "Good evening!"
	;line "You're out late." ; Damien

	;para "Welcome to our"
	;line "#MON CENTER."
	done
endc
	

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


NurseAskHealText:
if DEF(_FR_FR)
	text "Dois-je soigner"
	line "vos #MON?"
	done
else
	text "Shall we heal your"
	line "#MON?"
	done
endc


NurseAskTestText:
if DEF(_FR_FR)
	text "Voulez-vous aussi"
	line "des tests PCR?"

	para "Pour @"
	text_ram wStringBuffer3
	text ", le montant"
	line "est de @"
	text_ram wStringBuffer3
	text "00¥."
	done
else
	text "Should we perform"
	line "a PCR test also?"
	
	para "For @"
	text_ram wStringBuffer3 
	text " it costs"
	line "¥@"
	text_ram wStringBuffer3
	text "00."
	done
endc

NurseHealOnlyText:
if DEF(_FR_FR)
	text "OK, seulement"
	line "le soin."
	done
else
	text "OK, heal only."
	done
endc

NurseThanksText:
if DEF(_FR_FR)
	text "Merci."
	done
else
	text "Thank you."
	done
endc

NurseTakePokemonText:
if DEF(_FR_FR)
	text "Puis-je voir"
	line "vos #MON?"
	done
else
	text "May I see your"
	line "#MON?"
	done
endc

NurseNotEnoughMoneyText:
if DEF(_FR_FR)
	text "Désolé, vous n'avez"
	line "assez pour couvrir"
	cont "les tests PCR."
	done
else
	text "I am sorry but you"
	line "don't have enough"
	cont "for the PCR test."
	done
endc

NurseBallsDisinfectedText:
if DEF(_FR_FR)
	text "Vos #BALLS ont"
	line "été désinfectées."
	done
else
	text "Your #BALLS"
	line "have been"
	cont "disinfected."
	done
endc

NurseGoodbyeText::
if DEF(_FR_FR)
	text "Encore merci et"
	line "à bientôt!"
	done
else
	text "We hope to see you"
	line "again."
	done
endc

NursePCRArrivedText:
if DEF(_FR_FR)
	text "Nous vous"
	line "informons d'un"
	cont "nouveau service"
	cont "dans les"
	cont "CENTRES #MON."
	
	para "Les tests PCR"
	line "sont arrivés!"
	
	para "Ils permettent de"
	line "détecter si vos"
	cont "#MON sont actu-"
	cont "ellement infectés"
	cont "par le virus."

	para "Les résultats sont"
	line "immédiats, et le"
	cont "tarif est fixé à"
	cont "100¥ par #MON."

	para "Il est conseillé"
	line "aux dresseurs de"
	cont "fréquemment tester"
	cont "leur équipe."
	done
else
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
endc

NurseTestsNegativeText:
if DEF(_FR_FR)
	text "Tous les tests"
	line "PCR sont négatifs."
	done
else
	text "All PCR tests are"
	line "negative."
	done
endc

NurseOtherTestsNegativeText:
if DEF(_FR_FR)
	text "Les autres tests"
	line "PCR sont négatifs."
	done
else
	text "The other PCR"
	line "tests are"
	cont "negative."
	done
endc

NurseCriticallyIllText:
if DEF(_FR_FR)
	text "Oh non..."
	line " "

	para "Votre @"
	
	text_ram wStringBuffer1
	text_start
	
	line "est gravement"
	cont "malade et a besoin"
	cont "de soins urgents."

	para "Ca ressemble à une"
	line "forme sévère"
	cont "de COVID..."

	para "Je dois l'envoyer"
	line "immédiatement à"
	cont "l'hôpital, avant"
	cont "qu'il ne soit trop"
	cont "tard."
	done
else
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
endc

NurseCriticallyIllMail1Text:
if DEF(_FR_FR)
	text "La @"
	
	text_ram wStringBuffer1
	text " "
	
	line "qu'il tenait a été"
	cont "envoyée dans votre"
	cont "BOITE LETTRES."
	done
else
	text "The @"
	
	text_ram wStringBuffer1
	text " "
	
	line "it was holding"
	cont "has been sent to"
	cont "your MAIL BOX."
	done
endc

NurseCriticallyIllMail2Text:
if DEF(_FR_FR)
	text "Je n'ai pas réussi"
	line "à envoyer sa"
	cont "@"
	
	text_ram wStringBuffer1
	text " au PC,"
	
	cont "du coup le message"
	cont "a été perdu."

	para "Vous pouvez quand"
	line "même la reprendre."
	done
else
	text "I couldn't send its"
	line "@"
	
	text_ram wStringBuffer1
	text " to the"
	
	cont "PC so its message"
	cont "has been lost."
	
	para "You can have it"
	line "back though."
	done
endc

NurseCriticallyIllMail3Text:
if DEF(_FR_FR)
	text "Ta BOITE LETTRES"
	line "et ton SAC sont"
	cont "pleins, alors je"
	cont "vais garder la"
	cont "@"
	
	text_ram wStringBuffer1
	
	text " que"
	cont "tenait votre"
	cont "#MON."
	done
else
	text "Your MAIL BOX and"
	line "your PACK are full"
	cont "so I will keep the"
	cont "@"
	
	text_ram wStringBuffer1
	
	text " your"
	cont "#MON held."
	done
endc

NurseCriticallyIll2Text:
if DEF(_FR_FR)
	text "Vous pourrez"
	line "rendre visite à"
	cont "votre #MON à"
	cont "l'HOPITAL NATIONAL"
	cont "de DOUBLONVILLE."
	done
else
	text "You can go check"
	line "on your #MON"
	cont "at GOLDENROD"
	cont "NATIONAL HOSPITAL."
	done
endc

NurseMildIllnessText:
if DEF(_FR_FR)
	text "Certains de vos"
	line "#MON avaient"
	cont "une maladie"
	cont "bénigne,"
	
	para "mais nous les"
	line "avons pris en"
	cont "charge, et ils ont"
	cont "été soignés!"
	done
else
	text "Some of your"
	line "#MON had a mild"
	cont "illness, but they"
	cont "have been taken"
	cont "care of and they"
	cont "are now cured!"
	done
endc

NursePokerusReaction:
if DEF(_FR_FR)
	text "Certains de vos"
	line "#MON sont"
	
	para "infectés par"
	line "le virus."
	done
else
	text "Some of your"
	line "#MON appear"
	
	para "to be infected"
	line "by the virus."
	done
endc

NursePokerusLongTextStart:
if DEF(_FR_FR)
	text "Ils risquent d'être"
	line "fatigués et d'avoir"
	cont "mal à la tête."
	
	para "On ne sait pas"
	line "encore comment"
	cont "guérir la maladie."
	
	para "Vos #MON"
	line "devraient aller"
	cont "mieux sous"
	cont "5 jours."
	done
else
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
endc

NursePokerusRecommendsVaccinationText:
if DEF(_FR_FR)
	text "Une fois les symp-"
	line "tômes dissipés,"
	cont "vous pourrez faire"
	cont "vacciner vos"
	cont "#MON au CENTRE"
	cont "DE VACCINATION"
	cont "de SAFRANIA."
	done
else
	text "Once the symptoms"
	line "are gone, you can"
	cont "get your #MON"
	cont "vaccinated at"
	cont "SAFFRON CITY's"
	cont "vaccination"
	cont "center."
	done
endc

NursePokerusEssentialText:
if DEF(_FR_FR)
	text "Gardez-les confi-"
	line "nés à l'intérieur"
	cont "de leur #BALL"
	cont "jusqu'à leur"
	cont "rétablissement."
	done
else
	text "Please keep them"
	line "confined inside"
	cont "their #BALL"
	cont "until they"
	cont "feel better."
	done
endc

NursePokerusLongTextEnd:
if DEF(_FR_FR)
	text "Une fois guéris,"
	line "ils seront"
	cont "immunisés pour une"
	cont "longue période."
	done
else
	text "Once cured, they"
	line "should be immuned"
	cont "for a long time."
	done
endc

NurseAbandonedMonText:
if DEF(_FR_FR)
	text "Attendez!!"
	
	para "Vous n'avez plus de"
	line "#MON et vous ne"
	cont "pouvez pas partir"
	cont "sans en avoir un!"
	
	para "Les CENTRES #-"
	line "MON recueillent"
	cont "des #MON aban-"
	cont "donnés, attendant"
	cont "d'être adoptés par"
	cont "un nouveau"
	cont "dresseur."
	
	para "Prenez soin de"
	line "celui-ci."
	done
else
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
endc
	

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


TeamRocketOathText:
if DEF(_FR_FR)
	text "SERMENT ROCKET"

	para "Voler les #MON"
	line "pour le pognon!"

	para "Se battre pour"
	line "la liberté!"

	para "Le monde"
	line "appartient à"
	cont "la TEAM ROCKET!"
	done
else
	text "TEAM ROCKET OATH"
	
	para "Steal #MON for"
	line "profit!"
	
	para "Fight for"
	line "freedom!"
	
	para "The world"
	line "belongs to"
	cont "TEAM ROCKET!"
	done
endc


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


MerchandiseGoneText:
if DEF(_FR_FR)
	text "Tout ce qui a le"
	line "moindre intérêt"
	cont "est parti..."
	done
else
	text "Everything of"
	line "interest is gone…"
	done
endc


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


WindowClappingText:
if DEF(_FR_FR)
	text "Les gens"
	line "applaudissent à"
	cont "leurs fenêtres"
	cont "de tous côtés."
	done
else
	text "People are"
	line "clapping at their"
	cont "window from all"
	cont "directions."
	done
endc


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
else
	text "#MON JOURNAL"
	line "HOME PAGE…"
	
	para "It hasn't been"
	line "updated…"
	done
endc


TrashCanText:
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "là-dedans…"
	done
else
	text "There's nothing in"
	line "here…"
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


GymStatue_ChallengeGymText:
if DEF(_FR_FR)
	text "Challenge:"
	line "@"
	text_ram wStringBuffer3
	text " "
	done
else
	text "Challenge:"
	line "@"
	text_ram wStringBuffer3
	text " "
	done
endc

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
