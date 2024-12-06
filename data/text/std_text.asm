NurseMornText:
	text "Good morning!"
	;line "Welcome to our"
	;cont "#MON CENTER."
	done

NurseDayText:
	text "Hello!"
	;line "Welcome to our"
	;cont "#MON CENTER."
	done

NurseNiteText:
	text "Good evening!"
	;line "You're out late." ; Damien

	;para "Welcome to our"
	;line "#MON CENTER."
	done

PokeComNurseMornText:
	text "Good morning!"

	para "This is the #-"
	line "MON COMMUNICATION"

	para "CENTER--or the"
	line "#COM CENTER."
	done

PokeComNurseDayText:
	text "Hello!"

	para "This is the #-"
	line "MON COMMUNICATION"

	para "CENTER--or the"
	line "#COM CENTER."
	done

PokeComNurseNiteText:
	text "Good to see you"
	line "working so late."

	para "This is the #-"
	line "MON COMMUNICATION"

	para "CENTER--or the"
	line "#COM CENTER."
	done

NurseAskHealText:
	text "Shall we heal your"
	line "#MON?"
	done

NurseAskTestText:
	text "Should we perform"
	line "a PCR test also?"

	para "For @"
	text_ram wStringBuffer3 
	text " it costs"
	line "¥@"
	text_ram wStringBuffer3
	text "00."
	done

NurseHealOnlyText:
	text "OK, heal only."
	done

NurseThanksText:
	text "Thank you."
	done

NurseTakePokemonText:
	text "May I see your"
	line "#MON?"
	done

NurseReturnPokemonText:
	;text "Thank you for" ; Damien
	;line "waiting."

	;para "Your #MON are"
	;line "fully healed."
	done

NurseNotEnoughMoneyText:
	text "I am sorry but you"
	line "don't have enough"
	cont "for the PCR test."
	done

NurseBallsDisinfectedText:
	text "Your #BALLS"
	line "have been"
	cont "disinfected."
	done

NurseGoodbyeText::
	text "We hope to see you"
	line "again."
	done

NursePCRArrivedText:
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

NurseTestsNegativeText:
	text "All PCR tests are"
	line "negative."
	done

NurseOtherTestsNegativeText:
	text "The other PCR"
	line "tests are"
	cont "negative."
	done

NurseCriticallyIllText:
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

NurseCriticallyIllMail1Text:
	text "The @"

	text_ram wStringBuffer1
	text " "

	line "it was holding"
	cont "has been sent to"
	cont "your MAIL BOX."
	done

NurseCriticallyIllMail2Text:
	text "I couldn't send its"
	line "@"

	text_ram wStringBuffer1
	text " to the"

	cont "PC so its message"
	cont "has been lost."

	para "You can have it"
	line "back though."
	done

NurseCriticallyIllMail3Text:
	text "Your MAIL BOX and"
	line "your PACK are full"
	cont "so I will keep the"
	cont "@"

	text_ram wStringBuffer1

	text " your"
	cont "#MON held."
	done

NurseCriticallyIll2Text:
	text "You can go check"
	line "on your #MON"
	cont "at GOLDENROD"
	cont "NATIONAL HOSPITAL."
	done

NurseMildIllnessText:
	text "Some of your"
	line "#MON had a mild"
	cont "illness, but they"
	cont "have been taken"
	cont "care of and they"
	cont "are now cured!"
	done

NursePokerusReaction:
	text "Some of your"
	line "#MON appear"

	para "to be infected"
	line "by the virus."
	done

NursePokerusLongTextStart:
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

NursePokerusRecommendsVaccinationText:
	text "Once the symptoms"
	line "are gone, you can"
	cont "get your #MON"
	cont "vaccinated at"
	cont "SAFFRON CITY's"
	cont "vaccination"
	cont "center."
	done

NursePokerusEssentialText:
	text "Please keep them"
	line "confined inside"
	cont "their #BALL"
	cont "until they"
	cont "feel better."
	done

NursePokerusLongTextEnd:
	text "Once cured, they"
	line "should be immuned"
	cont "for a long time."
	done

NurseAbandonedMonText:
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
	text "It's full of"
	line "difficult books."
	done

PictureBookshelfText:
	text "A whole collection"
	line "of #MON picture"
	cont "books!"
	done

MagazineBookshelfText:
	text "#MON magazines…"
	line "#MON PAL,"

	para "#MON HANDBOOK,"
	line "#MON GRAPH…"
	done

TeamRocketOathText:
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
	text "What is this?"

	para "Oh, it's an"
	line "incense burner!"
	done

MerchandiseShelfText:
	text "Lots of #MON"
	line "merchandise!"
	done

MerchandiseGoneText:
	text "Everything of"
	line "interest is gone…"
	done

LookTownMapText:
	text "It's the TOWN MAP."
	done

WindowText:
	text "My reflection!"
	line "Lookin' good!"
	done

WindowClappingText:
	text "People are"
	line "clapping at their"
	cont "window from all"
	cont "directions."
	done

TVText:
	text "It's a TV."
	done

HomepageText:
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

TrashCanText:
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

PokecenterSignText:
	text "Heal Your #MON!"
	line "#MON CENTER"
	done

MartSignText:
	text "For All Your"
	line "#MON Needs"

	para "#MON MART"
	done

ContestResults_ReadyToJudgeText:
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

ContestResults_PlayerWonAPrizeText:
	text "<PLAYER>, the No.@"
	text_ram wStringBuffer3
	text_start
	line "finisher, wins"
	cont "@"
	text_ram wStringBuffer4
	text "!"
	done

ReceivedItemText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer4
	text "."
	done

ContestResults_JoinUsNextTimeText:
	text "Please join us for"
	line "the next Contest!"
	done

ContestResults_ConsolationPrizeText:
	text "Everyone else gets"
	line "a BERRY as a con-"
	cont "solation prize!"
	done

ContestResults_DidNotWinText:
	text "We hope you do"
	line "better next time."
	done

ContestResults_ReturnPartyText:
	text "We'll return the"
	line "#MON we kept"

	para "for you."
	line "Here you go!"
	done

ContestResults_PartyFullText:
	text "Your party's full,"
	line "so the #MON was"

	para "sent to your BOX"
	line "in BILL's PC."
	done

GymStatue_CityGymText:
	text_ram wStringBuffer3
	text_start
	line "#MON GYM"
	done

GymStatue_ChallengeGymText:
	text "Challenge:"
	line "@"
	text_ram wStringBuffer3
	text " "
	done

GymStatue_WinningTrainersText:
	text "LEADER: @"
	text_ram wStringBuffer4
	text_start
	para "WINNING TRAINERS:"
	line "<PLAYER>"
	done

CoinVendor_WelcomeText:
	text "Welcome to the"
	line "GAME CORNER."
	done

CoinVendor_NoCoinCaseText:
	text "Do you need game"
	line "coins?"

	para "Oh, you don't have"
	line "a COIN CASE for"
	cont "your coins."
	done

CoinVendor_IntroText:
	text "Do you need some"
	line "game coins?"

	para "It costs ¥1000 for"
	line "50 coins. Do you"
	cont "want some?"
	done

CoinVendor_Buy50CoinsText:
	text "Thank you!"
	line "Here are 50 coins."
	done

CoinVendor_Buy500CoinsText:
	text "Thank you! Here"
	line "are 500 coins."
	done

CoinVendor_NotEnoughMoneyText:
	text "You don't have"
	line "enough money."
	done

CoinVendor_CoinCaseFullText:
	text "Whoops! Your COIN"
	line "CASE is full."
	done

CoinVendor_CancelText:
	text "No coins for you?"
	line "Come again!"
	done

BugContestPrizeNoRoomText:
	text "Oh? Your PACK is"
	line "full."

	para "We'll keep this"
	line "for you today, so"

	para "come back when you"
	line "make room for it."
	done

HappinessText3:
	text "Wow! You and your"
	line "#MON are really"
	cont "close!"
	done

HappinessText2:
	text "#MON get more"
	line "friendly if you"

	para "spend time with"
	line "them."
	done

HappinessText1:
	text "You haven't tamed"
	line "your #MON."

	para "If you aren't"
	line "nice, it'll pout."
	done

RegisteredNumber1Text:
	text "<PLAYER> registered"
	line "@"
	text_ram wStringBuffer3
	text "'s number."
	done

RegisteredNumber2Text:
	text "<PLAYER> registered"
	line "@"
	text_ram wStringBuffer3
	text "'s number."
	done
