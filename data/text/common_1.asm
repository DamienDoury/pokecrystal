_FruitBearingTreeText::
	text "It's a fruit-"
	line "bearing tree."
	done

_HeyItsFruitText::
	text "Hey! It's @"
	text_ram wStringBuffer4
	text_start 
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

_PickUpFruitsText::
	text "Do you want to"
	line "pick these up?"
	done

_ObtainedFruitText::
	text "Obtained @"
	text_ram wStringBuffer4
	text_start 
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

_FruitPackIsFullText::
	text "But the PACK is"
	line "full…"
	done

_NothingHereText::
	text "There's nothing"
	line "here…"
	done

_DrySoilText::
	text "The soil is dry."
	done

_WetSoilText::
	text "The soil is nice"
	line "and moist!"
	done

_AskWaterSoilText::
	text "Water it with the"
	line "SQUIRTBOTTLE?"
	done

_FruitTreeGotStrongerText::
	text "The tree should"
	line "grow more fruits!"
	done

_FruitPlentyOfWaterText::
	text "The fruit tree has"
	line "plenty of water."
	done

_WhichApricornText::
	text "Which APRICORN"
	line "should I use?"
	done

_HowManyShouldIMakeText::
	text "How many should I"
	line "make?"
	done

_RecoveredSomeHPText::
	text_ram wStringBuffer1
	text_start
	line "recovered @"
	text_decimal wCurHPAnimDeltaHP, 2, 3
	text "HP!"
	done

_CuredOfPoisonText::
	text_ram wStringBuffer1
	text "'s"
	line "cured of poison."
	done

_RidOfParalysisText::
	text_ram wStringBuffer1
	text "'s"
	line "rid of paralysis."
	done

_BurnWasHealedText::
	text_ram wStringBuffer1
	text "'s"
	line "burn was healed."
	done

_WasDefrostedText::
	text_ram wStringBuffer1
	text_start
	line "was defrosted."
	done

_WokeUpText::
	text_ram wStringBuffer1
	text_start
	line "woke up."
	done

_HealthReturnedText::
	text_ram wStringBuffer1
	text "'s"
	line "health returned."
	done

_RevitalizedText::
	text_ram wStringBuffer1
	text_start
	line "is revitalized."
	done

_GrewToLevelText::
	text_ram wStringBuffer1
	text " grew to"
	line "level @"
	text_decimal wCurPartyLevel, 1, 3
	text "!@"
	sound_dex_fanfare_50_79 ; plays SFX_DEX_FANFARE_50_79, identical to SFX_LEVEL_UP
	text_promptbutton
	text_end

_CameToItsSensesText::
	text_ram wStringBuffer1
	text " came"
	line "to its senses."
	done

_EnterNewPasscodeText::
	text "Please enter any"
	line "four-digit number."
	done

_ConfirmPasscodeText::
	text "Enter the same"
	line "number to confirm."
	done

_PasscodesNotSameText::
	text "That's not the"
	line "same number."
	done

_PasscodeSetText::
	text "Your PASSCODE has"
	line "been set."

	para "Enter this number"
	line "next time to open"
	cont "the CARD FOLDER."

	para ""
	done

_FourZerosInvalidText::
	text "0000 is invalid!"

	para ""
	done

_EnterPasscodeText::
	text "Enter the CARD"
	next "FOLDER PASSCODE."
	done

_IncorrectPasscodeText::
	text "Incorrect"
	line "PASSCODE!"

	para ""
	done

_CardFolderOpenText::
	text "CARD FOLDER open.@"
	text_end

_OakTimeWokeUpText::
	text "<……><……><……><……><……><……>"
	line "<……><……><……><……><……><……>"

	para "Zzz… Hm? Wha…?"
	line "You woke me up!"

	para "Will you check the"
	line "clock for me?"
	prompt

_OakTimeWhatTimeIsItText::
	text "What time is it?"
	done

_OakTimeWhatHoursText::
	text "What?@"
	text_end

_OakTimeHoursQuestionMarkText::
	text "?"
	done

_OakTimeHowManyMinutesText::
	text "How many minutes?"
	done

_OakTimeWhoaMinutesText::
	text "Whoa!@"
	text_end

_OakTimeMinutesQuestionMarkText::
	text "?"
	done

_OakTimeOversleptText::
	text "!"
	line "I overslept!"
	done

_OakTimeYikesText::
	text "!"
	line "Yikes! I over-"
	cont "slept!"
	done

_OakTimeSoDarkText::
	text "!"
	line "No wonder it's so"
	cont "dark!"
	done

_OakTimeWhatDayIsItText::
	text "What day is it?"
	done

_OakTimeIsItText::
	text ", is it?"
	done

; Mobile Adapter

_ThereIsNothingConnectedText:: ; unreferenced
	text "There is nothing"
	line "connected."
	done

_CheckCellPhoneAdapterText:: ; unreferenced
	text "Check cell phone"
	line "adapter."
	done

_CheckCDMAAdapterText:: ; unreferenced
	text "Check CDMA"
	line "adapter."
	done

_CheckDOCOMOPHSAdapterText:: ; unreferenced
	text "Check DOCOMO PHS"
	line "adapter."
	done

_CheckDDIPHSAdapterText:: ; unreferenced
	text "Check DDI PHS"
	line "adapter."
	done

_CheckMobileAdapterText:: ; unreferenced
	text "Check unlimited"
	line "battle mobile"
	cont "adapter."
	done

; Mobile Adapter End

_ThePasswordIsText:: ; unreferenced
	text "The password is:"
	line ""
	done

_IsThisOKText:: ; unreferenced
	text "Is this OK?"
	done

_EnterTheIDNoText:: ; unreferenced
	text "Enter the"
	line "ID no."
	done

_EnterTheAmountText:: ; unreferenced
	text "Enter the"
	line "amount."
	done

_NothingToChooseText::
	text "There's nothing to"
	line "choose."
	prompt

_WhichSidePutOnText::
	text "Which side do you"
	line "want to put it on?"
	done

_WhichSidePutAwayText::
	text "Which side do you"
	line "want to put away?"
	done

_PutAwayTheDecoText::
	text "Put away the"
	line "@"
	text_ram wStringBuffer3
	text "."
	prompt

_NothingToPutAwayText::
	text "There's nothing to"
	line "put away."
	prompt

_SetUpTheDecoText::
	text "Set up the"
	line "@"
	text_ram wStringBuffer3
	text "."
	prompt

_PutAwayAndSetUpText::
	text "Put away the"
	line "@"
	text_ram wStringBuffer3
	text_start

	para "and set up the"
	line "@"
	text_ram wStringBuffer4
	text "."
	prompt

_AlreadySetUpText::
	text "That's already set"
	line "up."
	prompt

_LookTownMapText::
	text "It's the TOWN MAP."
	done

_LookPikachuPosterText::
	text "It's a poster of a"
	line "cute PIKACHU."
	done

_LookClefairyPosterText::
	text "It's a poster of a"
	line "cute CLEFAIRY."
	done

_LookJigglypuffPosterText::
	text "It's a poster of a"
	line "cute JIGGLYPUFF."
	done

_LookAdorableDecoText::
	text "It's an adorable"
	line "@"
	text_ram wStringBuffer3
	text "."
	done

_LookGiantDecoText::
	text "A giant doll! It's"
	line "fluffy and cuddly."
	done

_MomHiHowAreYouText::
	text "Hi, <PLAYER>!"
	line "How are you?"
	prompt

_MomFoundAnItemText::
	text "While doing groce-"
	line "ries, I found a"
	
	para "lost item at the"
	line "back of a shelf."
	
	para "It was a pack of"

	line "@"
	text_decimal wStringBuffer2, 1, 1
	text " @"
	text_ram wStringBuffer1
	text ""

	cont "for ¥@"
	text_decimal wStringBuffer3, 3, 5
	text "."

	para "It's a rare deal,"
	line "so I bought it"
	
	para "with your money &"
	line "sent it to you."
	prompt

_MomItsInPCText::
	text "The delivery guy"
	line "will be waiting"
	
	para "for you at the"
	line "second floor of"
	cont "a #CENTER."
	done

_MomReceivedItemFromNeighborText::
	text "The neighbor gave"
	line "me @"
	text_decimal wStringBuffer2, 1, 1
	text " @"
	text_ram wStringBuffer1
	text "."
	prompt

_MomWontNeedText::
	text "She said she won't"
	line "need it now that"
	cont "we're stuck home."
	prompt

_MomDontHaveAUseText::
	text "I don't have"
	line "a use for it."
	prompt

_MomShippedText::
	text "So I shipped it"
	line "to you."
	prompt

_MonWasSentToText::
	text_ram wPlayerTrademonSpeciesName
	text " was"
	line "sent to @"
	text_ram wOTTrademonSenderName
	text "."
	done

_MonNameSentToText::
	text_start
	done

_BidsFarewellToMonText::
	text_ram wOTTrademonSenderName
	text " bids"
	line "farewell to"
	done

_MonNameBidsFarewellText::
	text_ram wOTTrademonSpeciesName
	text "."
	done

_TakeGoodCareOfMonText::
	text "Take good care of"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done

_ForYourMonSendsText::
	text "For @"
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text ","
	done

_OTSendsText::
	text_ram wOTTrademonSenderName
	text " sends"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done

_WillTradeText::
	text_ram wOTTrademonSenderName
	text " will"
	line "trade @"
	text_ram wOTTrademonSpeciesName
	text_end

	text_end ; unreferenced

_ForYourMonWillTradeText::
	text "for @"
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text "."
	done

_MobilePlayerWillTradeMonText::
	text_ram wPlayerTrademonSenderName
	text " will"
	line "trade @"
	text_ram wPlayerTrademonSpeciesName
	text_end

	text_end ; unreferenced

_MobileForPartnersMonText::
	text "for @"
	text_ram wOTTrademonSenderName
	text "'s"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done

_MobilePlayersMonTradeText::
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text " trade…"
	done

_MobileTakeGoodCareOfMonText::
	text "Take good care of"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done

_MobilePlayersMonTrade2Text::
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text " trade…"
	done

_MobileTakeGoodCareOfText::
	text "Take good care of"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done

_MobileTradeCameBackText::
	text_ram wOTTrademonSpeciesName
	text " came"
	line "back!"
	done

; Oak's Pokémon Talk

_OPT_IntroText1::
	text_start
	line "MARY: PROF.OAK'S"
	done

_OPT_IntroText2::
	text_start
	line "#MON TALK!"
	done

_OPT_IntroText3::
	text_start
	line "With me, MARY!"
	done

_OPT_OakText1::
	text_start
	line "OAK: @"
	text_ram wMonOrItemNameBuffer
	text_end

_OPT_OakText2::
	text_start
	line "may be seen around"
	done

_OPT_OakText3::
	text_start
	line "@"
	text_ram wStringBuffer1
	text "."
	done

_OPT_MaryText1::
	text_start
	line "MARY: @"
	text_ram wStringBuffer1
	text "'s"
	done

_OPT_SweetAdorablyText::
	text_start
	line "sweet and adorably"
	done

_OPT_WigglySlicklyText::
	text_start
	line "wiggly and slickly"
	done

_OPT_AptlyNamedText::
	text_start
	line "aptly named and"
	done

_OPT_UndeniablyKindOfText::
	text_start
	line "undeniably kind of"
	done

_OPT_UnbearablyText::
	text_start
	line "so, so unbearably"
	done

_OPT_WowImpressivelyText::
	text_start
	line "wow, impressively"
	done

_OPT_AlmostPoisonouslyText::
	text_start
	line "almost poisonously"
	done

_OPT_SensuallyText::
	text_start
	line "ooh, so sensually"
	done

_OPT_MischievouslyText::
	text_start
	line "so mischievously"
	done

_OPT_TopicallyText::
	text_start
	line "so very topically"
	done

_OPT_AddictivelyText::
	text_start
	line "sure addictively"
	done

_OPT_LooksInWaterText::
	text_start
	line "looks in water is"
	done

_OPT_EvolutionMustBeText::
	text_start
	line "evolution must be"
	done

_OPT_ProvocativelyText::
	text_start
	line "provocatively"
	done

_OPT_FlippedOutText::
	text_start
	line "so flipped out and"
	done

_OPT_HeartMeltinglyText::
	text_start
	line "heart-meltingly"
	done

_OPT_CuteText::
	text_start
	line "cute."
	done

_OPT_WeirdText::
	text_start
	line "weird."
	done

_OPT_PleasantText::
	text_start
	line "pleasant."
	done

_OPT_BoldSortOfText::
	text_start
	line "bold, sort of."
	done

_OPT_FrighteningText::
	text_start
	line "frightening."
	done

_OPT_SuaveDebonairText::
	text_start
	line "suave & debonair!"
	done

_OPT_PowerfulText::
	text_start
	line "powerful."
	done

_OPT_ExcitingText::
	text_start
	line "exciting."
	done

_OPT_GroovyText::
	text_start
	line "groovy!"
	done

_OPT_InspiringText::
	text_start
	line "inspiring."
	done

_OPT_FriendlyText::
	text_start
	line "friendly."
	done

_OPT_HotHotHotText::
	text_start
	line "hot, hot, hot!"
	done

_OPT_StimulatingText::
	text_start
	line "stimulating."
	done

_OPT_GuardedText::
	text_start
	line "guarded."
	done

_OPT_LovelyText::
	text_start
	line "lovely."
	done

_OPT_SpeedyText::
	text_start
	line "speedy."
	done

_OPT_PokemonChannelText::
	text "#MON"
	done

_PokedexShowText::
	text_start
	line "@"
	text_ram wStringBuffer1
	text_end

	text_end ; unreferenced

; Pokémon Music Channel / Pokémusic

_BenIntroText1::
	text_start
	line "BEN: #MON MUSIC"
	done

_BenIntroText2::
	text_start
	line "CHANNEL!"
	done

_BenIntroText3::
	text_start
	line "It's me, DJ BEN!"
	done

_FernIntroText1::
	text_start
	line "FERN: #MUSIC!"
	done

_FernIntroText2::
	text_start
	line "With DJ FERN!"
	done

_BenFernText1::
	text_start
	line "Today's @"
	text_today
	text ","
	done

_BenFernText2A::
	text_start
	line "so let us jam to"
	done

_BenFernText2B::
	text_start
	line "so chill out to"
	done

_BenFernText3A::
	text_start
	line "#MON March!"
	done

_BenFernText3B::
	text_start
	line "#MON Lullaby!"
	done

; Lucky Channel

_LC_Text1::
	text_start
	line "REED: Yeehaw! How"
	done

_LC_Text2::
	text_start
	line "y'all doin' now?"
	done

_LC_Text3::
	text_start
	line "Whether you're up"
	done

_LC_Text4::
	text_start
	line "or way down low,"
	done

_LC_Text5::
	text_start
	line "don't you miss the"
	done

_LC_Text6::
	text_start
	line "LUCKY NUMBER SHOW!"
	done

_LC_Text7::
	text_start
	line "Today's Lucky"
	done

_LC_Text8::
	text_start
	line "Number is @"
	text_pause
	text_ram wStringBuffer1
	text "!"
	done

_LC_Text9::
	text_start
	line "I'll repeat that!"
	done

_LC_Text10::
	text_start
	line "Match it and go to"
	done

_LC_Text11::
	text_start
	line "the RADIO TOWER!"
	done

_LC_DragText1::
	text_start
	line "…Repeating myself"
	done

_LC_DragText2::
	text_start
	line "gets to be a drag…"
	done

; Places and People

_PnP_Text1::
	text_start
	line "PLACES AND PEOPLE!"
	done

_PnP_Text2::
	text_start
	line "Brought to you by"
	done

_PnP_Text3::
	text_start
	line "me, DJ LILY!"
	done

_PnP_Text4::
	text_start
	line "@"
	text_ram wStringBuffer2
	text " @"
	text_ram wStringBuffer1
	text_end

	text_end ; unreferenced

_PnP_CuteText::
	text_start
	line "is cute."
	done

_PnP_LazyText::
	text_start
	line "is sort of lazy."
	done

_PnP_HappyText::
	text_start
	line "is always happy."
	done

_PnP_NoisyText::
	text_start
	line "is quite noisy."
	done

_PnP_PrecociousText::
	text_start
	line "is precocious."
	done

_PnP_BoldText::
	text_start
	line "is somewhat bold."
	done

_PnP_PickyText::
	text_start
	line "is too picky!"
	done

_PnP_SortOfOKText::
	text_start
	line "is sort of OK."
	done

_PnP_SoSoText::
	text_start
	line "is just so-so."
	done

_PnP_GreatText::
	text_start
	line "is actually great."
	done

_PnP_MyTypeText::
	text_start
	line "is just my type."
	done

_PnP_CoolText::
	text_start
	line "is so cool, no?"
	done

_PnP_InspiringText::
	text_start
	line "is inspiring!"
	done

_PnP_WeirdText::
	text_start
	line "is kind of weird."
	done

_PnP_RightForMeText::
	text_start
	line "is right for me?"
	done

_PnP_OddText::
	text_start
	line "is definitely odd!"
	done

_PnP_Text5::
	text_start
	line "@"
	text_ram wStringBuffer1
	text_end

_RocketRadioText1::
	text_start
	line "… …Ahem, we are"
	done

_RocketRadioText2::
	text_start
	line "TEAM ROCKET!"
	done

_RocketRadioText3::
	text_start
	line "Listen people!"
	done

_RocketRadioText4::
	text_start
	line "The government is"
	done

_RocketRadioText5::
	text_start
	line "controlling y'all!"
	done

_RocketRadioText6::
	text_start
	line "Stop staying home"
	done

_RocketRadioText7::
	text_start
	line "and wearing face"
	done

_RocketRadioText8::
	text_start
	line "masks! @"
	text_pause
	text "Get your"
	done

_RocketRadioText9::
	text_start
	line "freedom back!"
	done

_RocketRadioText10::
	text_start
	line "REVOLTE! @"
	text_pause
	text "STOP"
	done

_RocketRadioText11::
	text_start
	line "SUBMITTING!"
	done

_RocketRadioText12::
	text_start
	line "COVID is a lie!"
	done

_RocketRadioText13::
	text_start
	line "Go out and find"
	done

_RocketRadioText14::
	text_start
	line "out for yourself!"
	done

	
	
	

_BuenaRadioText1::
	text_start
	line "BUENA: BUENA here!"
	done

_BuenaRadioText2::
	text_start
	line "Today's password!"
	done

_BuenaRadioText3::
	text_start
	line "Let me think… It's"
	done

_BuenaRadioText4::
	text_start
	line "@"
	text_ram wStringBuffer1
	text "!"
	done

_BuenaRadioText5::
	text_start
	line "Don't forget it!"
	done

_BuenaRadioText6::
	text_start
	line "I'm in GOLDENROD's"
	done

_BuenaRadioText7::
	text_start
	line "RADIO TOWER!"
	done

_BuenaRadioMidnightText1::
	text_start
	line "BUENA: Oh my…"
	done

_BuenaRadioMidnightText2::
	text_start
	line "It's midnight! I"
	done

_BuenaRadioMidnightText3::
	text_start
	line "have to shut down!"
	done

_BuenaRadioMidnightText4::
	text_start
	line "Thanks for tuning"
	done

_BuenaRadioMidnightText5::
	text_start
	line "in to the end! But"
	done

_BuenaRadioMidnightText6::
	text_start
	line "don't stay up too"
	done

_BuenaRadioMidnightText7::
	text_start
	line "late! Presented to"
	done

_BuenaRadioMidnightText8::
	text_start
	line "you by DJ BUENA!"
	done

_BuenaRadioMidnightText9::
	text "I'm outta here!"
	done

_BuenaRadioMidnightText10::
	text "…"
	done

_BuenaOffTheAirText::
	text_start
	line ""
	done

_EnemyWithdrewText::
	text "<ENEMY>"
	line "withdrew"
	cont "@"
	text_ram wEnemyMonNickname
	text "!"
	prompt

_EnemyUsedOnText::
	text "<ENEMY>"
	line "used @"
	text_ram wMonOrItemNameBuffer
	text_start
	cont "on @"
	text_ram wEnemyMonNickname
	text "!"
	prompt

_ThatCantBeUsedRightNowText:: ; unreferenced
	text "That can't be used"
	line "right now."
	prompt

_ThatItemCantBePutInThePackText:: ; unreferenced
	text "That item can't be"
	line "put in the PACK."
	done

_TheItemWasPutInThePackText:: ; unreferenced
	text "The @"
	text_ram wStringBuffer1
	text_start
	line "was put in the"
	cont "PACK."
	done

_RemainingTimeText:: ; unreferenced
	text "Remaining Time"
	done

_YourMonsHPWasHealedText:: ; unreferenced
	text "Your #MON's HP"
	line "was healed."
	prompt

_WarpingText:: ; unreferenced
	text "Warping…"
	done

_ChangeWhichNumberText:: ; unreferenced
	text "Which number"
	line "should be changed?"
	done

_WillYouPlayWithMonText:: ; unreferenced
	text "Will you play with"
	line "@"
	text_ram wStringBuffer2
	text "?"
	done

_YouNeedTwoMonForBreedingText:: ; unreferenced
	text "You need two #-"
	line "MON for breeding."
	prompt

_BreedingIsNotPossibleText:: ; unreferenced
	text "Breeding is not"
	line "possible."
	prompt

_CompatibilityShouldTheyBreedText:: ; unreferenced
	text "The compatibility"
	line "is @"
	text_decimal wBreedingCompatibility, 1, 3
	text "."
	cont "Should they breed?"
	done

_ThereIsNoEggText:: ; unreferenced
	text "There is no EGG."
	line ""
	prompt

_ItsGoingToHatchText:: ; unreferenced
	text "It's going to"
	line "hatch!"
	prompt

_TestEventText:: ; unreferenced
	text "Test event"
	line "@"
	text_decimal wStringBuffer2, 1, 2
	text "?"
	done

_StartText:: ; unreferenced
	text "Start!"
	done

_EndText:: ; unreferenced
	text "End!"
	done

_ForABoyText:: ; unreferenced
	text "For a boy!"
	done

_ForAGirlText:: ; unreferenced
	text "For a girl!"
	done

_DoesntConcernABoyText:: ; unreferenced
	text "This doesn't"
	line "concern a boy!"
	done

_TheBoxIsFullText:: ; unreferenced
	text "The BOX is full!"
	done

; Mobile Adapter

_NewCardArrivedText::
	text "A new CARD arrived"
	line "from @"
	text_ram wStringBuffer2
	text "."
	done

_PutCardInCardFolderText::
	text "Put this CARD in"
	line "the CARD FOLDER?"
	done

_CardWasListedText::
	text_ram wStringBuffer2
	text "'s CARD was"
	line "listed as no.@"
	text_decimal wStringBuffer1, 1, 2
	text "."
	prompt

_StartingLinkText::
	text "Starting link."
	done

_LinkTerminatedText::
	text "Link terminated."
	done

_ClosingLinkText::
	text "Closing link."
	done

_ClearTimeLimitText:: ; unreferenced
	text "Clear the time"
	line "limit?"
	done

_TimeLimitWasClearedText:: ; unreferenced
	text "The time limit was"
	line "cleared."
	done

_PickErrorPacketText:: ; unreferenced
	text "Pick which packet"
	line "as an error?"
	done

_TradingMonForOTMonText::
	text "Trading @"
	text_ram wStringBuffer2
	text_start
	line "for @"
	text_ram wStringBuffer1
	text "…"
	done

; Mobile Adapter End

_AskFloorElevatorText::
	text "Which floor?"
	done

_BugCatchingContestTimeUpText::
	text "ANNOUNCER: BEEEP!"

	para "Time's up!"
	done

_BugCatchingContestIsOverText::
	text "ANNOUNCER: The"
	line "Contest is over!"
	done

_RepelWoreOffText::
	text "REPEL's effect"
	line "wore off."
	done

_UseAnotherRepelText::
	text "@"
	text_ram wStringBuffer3
	text "'s"
	line "effect wore off."

	para "Use another?"
	done

_PlayerFoundItemText::
	text "<PLAYER> found"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

_ButNoSpaceText::
	text "But <PLAYER> has"
	line "no space left…"
	done

_JustSawSomeRareMonText::
	text "I just saw some"
	line "rare @"
	text_ram wStringBuffer1
	text " in"
	cont "@"
	text_ram wStringBuffer2
	text "."

	para "I'll call you if I"
	line "see another rare"
	cont "#MON, OK?"
	prompt

_SavingRecordText::
	text "SAVING RECORD…"
	line "DON'T TURN OFF!"
	done

_ReceiveItemText::
	text_ram wPlayerName
	text " received"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	sound_item
	text_promptbutton
	text_end

_NoCoinsText::
	text "You have no coins."
	prompt

_NoCoinCaseText::
	text "You don't have a"
	line "COIN CASE."
	prompt

_NPCTradeCableText::
	text "OK, connect the"
	line "Game Link Cable."
	prompt

Text_NPCTraded::
	text "<PLAYER> traded"
	line "@"
	text_ram wMonOrItemNameBuffer
	text " for"
	cont "@"
	text_ram wStringBuffer2
	text ".@"
	text_end

_NPCTradeFanfareText::
	sound_dex_fanfare_80_109
	text_pause
	text_end

	text_end ; unreferenced

_NPCTradeIntroText1::
	text "I collect #MON."
	line "Do you have"
	cont "@"
	text_ram wStringBuffer1
	text "?"

	para "Want to trade it"
	line "for my @"
	text_ram wStringBuffer2
	text "?"
	done

_NPCTradeCancelText1::
	text "You don't want to"
	line "trade? Aww…"
	done

_NPCTradeWrongText1::
	text "Huh? That's not"
	line "@"
	text_ram wStringBuffer1
	text ". "
	cont "What a letdown…"
	done

_NPCTradeCompleteText1::
	text "Yay! I got myself"
	line "@"
	text_ram wStringBuffer1
	text "!"
	cont "Thanks!"
	done

_NPCTradeAfterText1::
	text "Hi, how's my old"
	line "@"
	text_ram wStringBuffer2
	text " doing?"
	done

_NPCTradeIntroText2::
	text "Hi, I'm looking"
	line "for this #MON."

	para "If you have"
	line "@"
	text_ram wStringBuffer1
	text ", would"

	para "you trade it for"
	line "my @"
	text_ram wStringBuffer2
	text "?"
	done

_NPCTradeCancelText2::
	text "You don't have"
	line "one either?"

	para "Gee, that's really"
	line "disappointing…"
	done

_NPCTradeWrongText2::
	text "You don't have"
	line "@"
	text_ram wStringBuffer1
	text "? That's"
	cont "too bad, then."
	done

_NPCTradeCompleteText2::
	text "Great! Thank you!"

	para "I finally got"
	line "@"
	text_ram wStringBuffer1
	text "."
	done

_NPCTradeAfterText2::
	text "Hi! The @"
	text_ram wMonOrItemNameBuffer
	text_start
	line "you traded me is"
	cont "doing great!"
	done

_NPCTradeIntroText3::
	text_ram wMonOrItemNameBuffer
	text "'s cute,"
	line "but I don't have"

	para "it. Do you have"
	line "@"
	text_ram wStringBuffer1
	text "?"

	para "Want to trade it"
	line "for my @"
	text_ram wStringBuffer2
	text "?"
	done

_NPCTradeCancelText3::
	text "You don't want to"
	line "trade? Oh, darn…"
	done

_NPCTradeWrongText3::
	text "That's not"
	line "@"
	text_ram wStringBuffer1
	text "."

	para "Please trade with"
	line "me if you get one."
	done

_NPCTradeCompleteText3::
	text "Wow! Thank you!"
	line "I always wanted"
	cont "@"
	text_ram wMonOrItemNameBuffer
	text "!"
	done

_NPCTradeAfterText3::
	text "How is that"
	line "@"
	text_ram wStringBuffer2
	text " I"
	cont "traded you doing?"

	para "Your @"
	text_ram wMonOrItemNameBuffer
	text "'s"
	line "so cute!"
	done

_NPCTradeCompleteText4::
	text "Uh? What happened?"
	done

_NPCTradeAfterText4::
	text "Trading is so odd…"

	para "I still have a lot"
	line "to learn about it."
	done

_MomLeavingText1::
	text "Wow, that's a cute"
	line "#MON."

	para "Where did you get"
	line "it?"

	para "…"

	para "So, you're leaving"
	line "on an adventure…"

	para "Helping fight this"
	line "virus is very"
	cont "honorable of you."

	para "OK!"
	line "I also want"
	cont "to help!"

	para "Take anything you"
	line "need in the fridge"
	
	para "I will go grocery"
	line "shopping everyday."

	para "Watch TV often"
	line "to stay informed"
	cont "on the latest"
	cont "news about COVID."

	para "Don't forget to"
	line "call your Mom!"
	done

_MomLeavingText2::
	text "OK, I'll take care"
	line "of your money."

	para "<……><……><……>"
	prompt

_MomLeavingText3::
	text "Be careful."

	para "#MON are your"
	line "friends. You need"
	cont "to work as a team."

	para "Now, go on!"
	done

_MomIsThisAboutYourMoneyText::
	text "Hi! Welcome home!"
	line "You're trying very"
	cont "hard, I see."

	para "I've kept your"
	line "room tidy."

	para "Or is this about"
	line "your money?"
	done

_MomBankWhatDoYouWantToDoText::
	text "What do you want"
	line "to do?"
	done

_MomStoreMoneyText::
	text "How much do you"
	line "want to give?"
	done

_MomTakeMoneyText::
	text "How much do you"
	line "want to take?"
	done

_MomSaveMoneyText::
	text "Do you want to"
	line "send me some of"
	cont "the money you"
	cont "earn?"
	done

_MomHaventSavedThatMuchText::
	text "MOM doesn't have"
	line "that much."
	prompt

_MomNotEnoughRoomInWalletText::
	text "You can't take"
	line "that much."
	prompt

_MomInsufficientFundsInWalletText::
	text "You don't have"
	line "that much."
	prompt

_MomNotEnoughRoomInBankText::
	text "You can't give"
	line "that much."
	prompt

_MomStartSavingMoneyText::
	text "OK, I'll take your"
	line "money. Thanks!"

	para "<PLAYER>, stick"
	line "with it!"
	done

_MomStoredMoneyText::
	text "It's very generous"
	line "of you! Get going!"
	done

_MomTakenMoneyText::
	text "<PLAYER>, don't"
	line "give up!"
	done

_MomJustDoWhatYouCanText::
	text "Just do what"
	line "you can."
	done

_DaycareDummyText::
	text_start
	done

_DayCareManIntroText::
	text "I'm the DAY-CARE"
	line "MAN. Want me to"
	cont "raise a #MON?"
	done

_DayCareManIntroEggText::
	text "I'm the DAY-CARE"
	line "MAN. Do you know"
	cont "about EGGS?"

	para "I was raising"
	line "#MON with my"
	cont "wife, you see."

	para "We were shocked to"
	line "find an EGG!"

	para "How incredible is"
	line "that?"

	para "So, want me to"
	line "raise a #MON?"
	done

_DayCareLadyIntroText::
	text "I'm the DAY-CARE"
	line "LADY."

	para "Should I raise a"
	line "#MON for you?"
	done

_DayCareLadyIntroEggText::
	text "I'm the DAY-CARE"
	line "LADY. Do you know"
	cont "about EGGS?"

	para "My husband and I"
	line "were raising some"
	cont "#MON, you see."

	para "We were shocked to"
	line "find an EGG!"

	para "How incredible"
	line "could that be?"

	para "Should I raise a"
	line "#MON for you?"
	done

_WhatShouldIRaiseText::
	text "What should I"
	line "raise for you?"
	prompt

_OnlyOneMonText::
	text "Oh? But you have"
	line "just one #MON."
	prompt

_CantAcceptEggText::
	text "Sorry, but I can't"
	line "accept an EGG."
	prompt

_RemoveMailText::
	text "Remove MAIL before"
	line "you come see me."
	prompt

_LastHealthyMonText::
	text "If you give me"
	line "that, what will"
	cont "you battle with?"
	prompt

_IllRaiseYourMonText::
	text "OK. I'll raise"
	line "your @"
	text_ram wStringBuffer1
	text "."
	prompt

_ComeBackLaterText::
	text "Come back for it"
	line "later."
	done

_AreWeGeniusesText::
	text "Are we geniuses or"
	line "what? Want to see"
	cont "your @"
	text_ram wStringBuffer1
	text "?"
	done

_YourMonHasGrownText::
	text "Your @"
	text_ram wStringBuffer1
	text_start
	line "has grown a lot."

	para "By level, it's"
	line "grown by @"
	text_decimal wStringBuffer2 + 1, 1, 3
	text " and"
	cont "is now level @"
	text_decimal wStringBuffer2 + 5, 1, 3
	text "."

	para "If you want your"
	line "#MON back, it"
	cont "will cost ¥@"
	text_decimal wStringBuffer2 + 2, 3, 5
	text "."
	done

_PerfectHeresYourMonText::
	text "Perfect! Here's"
	line "your #MON."
	prompt

_GotBackMonText::
	text "<PLAYER> got back"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt

_BackAlreadyText::
	text "Huh? Back already?"
	line "Your @"
	text_ram wStringBuffer1
	text_start
	para "needs a little"
	line "more time with us."

	para "If you want your"
	line "#MON back, it"
	cont "will cost ¥200."
	done

_HaveNoRoomText::
	text "You have no room"
	line "for it."
	prompt

_NotEnoughMoneyText::
	text "You don't have"
	line "enough money."
	prompt

_OhFineThenText::
	text "Oh, fine then."
	prompt

_ComeAgainText::
	text "Come again."
	done

_DayCare_RumorsText::
	text "I've heard some"
	line "rumors saying that"
	cont "this #MON"
	cont "species might be"
	cont "at the origin"
	cont "of the virus."

	para "I don't want to"
	line "take the risk of"
	cont "getting infected."

	para "I won't raise"
	line "this one. Sorry."
	prompt

_DayCare_LooksLikeVirusText::
	text "This #MON"
	line "looks like a giant"
	cont "virus, and I'm"
	cont "superstitious…"

	para "I can't raise this"
	line "#MON, sorry."
	prompt

_DayCare_BadShapeText::
	text "Your #MON"
	line "appears to be"
	cont "sick. I can't"
	cont "take care of it."
	prompt

_DayCare_HasCovidText::
	text "Wait…"
	
	para "Your #MON is"
	line "infected by the"
	cont "virus?!?"

	para "GET OUT OF"
	line "MY HOUSE, NOW!"
	done

_NotYetText::
	text "Not yet…"
	done

_FoundAnEggText::
	text "Ah, it's you!"

	para "We were raising"
	line "your #MON, and"

	para "my goodness, were"
	line "we surprised!"

	para "Your #MON had"
	line "an EGG!"

	para "We don't know how"
	line "it got there, but"

	para "your #MON had"
	line "it. You want it?"
	done

_ReceivedEggText::
	text "<PLAYER> received"
	line "the EGG!"
	done

_TakeGoodCareOfEggText::
	text "Take good care of"
	line "it."
	done

_IllKeepItThanksText::
	text "Well then, I'll"
	line "keep it. Thanks!"
	done

_NoRoomForEggText::
	text "You have no room"
	line "in your party."
	cont "Come back later."
	done

_WhichMonPhotoText::
	text "Which #MON"
	line "should I photo-"
	cont "graph?"
	prompt

_HoldStillText::
	text "All righty. Hold"
	line "still for a bit."
	prompt

_PrestoAllDoneText::
	text "Presto! All done."
	line "Come again, OK?"
	done

_GymGuideEggText::
	text "EGGS are not"
	line "allowed in a GYM."

	para "We never know"
	line "what could hatch"
	cont "from it."
	done

_MissedItemText::
	text "Hey! There's a"
	line "lone item in the"
	cont "back of the shelf!"
	prompt

_MissedItemSingle::
	text "It's a single"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt

_MissedItemBundle::
	text "It's a pack of"
	line "@"
	text_ram wStringBuffer2
	text " @"
	text_ram wStringBuffer1
	text "S."
	prompt

_MissedItemPrice::
	text "The price is only"
	line "@"
	text_ram wStringBuffer3
	text "! Buy it?"
	done


; Mewtwo dialogs in Cerulean Cave.

; B1F, in order. Theme = asking politely to leave.
; Shortest path = 121 steps.

_MewtwoB1FText1::
	text "I can feel your"
	line "presence."

	para "The outside world"
	line "is not allowed in"
	cont "here."
	
	para "Go back where"
	line "you came from."
	done
	
_MewtwoB1FText2::
	text "I know why you"
	line "came."
	
	para "You will only"
	line "find regrets."
	done
	
_MewtwoB1FText3::
	text "Leave this place"
	line "at once."
	
	para "You have been"
	line "warned."
	done

_MewtwoB1FText4::
	text "If you keep going"
	line "forward, there"
	
	para "will be no way"
	line "out for you."
	done
	
; B2F, in order. Theme = big reveals. Beginning threats.
; Shortest path = 73 steps.
_MewtwoB2FText1::
	text "I made this place"
	line "collapse so I"
	cont "could be"
	cont "contained."

	para "No one should come"
	line "in or go out of"
	cont "this place."
	done

_MewtwoB2FText2::
	text "The poor #MON"
	line "of this cave…"
	
	para "I am responsible"
	line "for what is"
	cont "happening to them."

	para "But I can't let"
	line "them out of here."

	para "It would only"
	line "cause more"
	cont "suffering."
	
	para "My creators left"
	line "me no choice."
	done

_MewtwoB2FText3::
	text "I sent the avatar"
	line "of fire to unleash"
	cont "the volcano's power"
	cont "and destroy their"
	cont "laboratory."

	para "Don't force me to"
	line "destroy you."
	done

_MewtwoB2FText4::
	text "Another one came"
	line "before you."
	
	para "He brought doom"
	line "on himself."

	para "Don't make the"
	line "same mistake."
	done
	
; B3F, random. Theme = discouraging fight with threats. Trying to be convincing by showing good intentions.
; Shortest path = 123 steps.
_MewtwoB3FText1::
	text "Don't approach me,"
	line "I am dangerous."
	done

_MewtwoB3FText2::
	text "I don't want to"
	line "fight you."
	
	para "For your own"
	line "protection."
	done

_MewtwoB3FText3::
	text "Why don't you"
	line "listen to me?"
	
	para "I will show you"
	line "no mercy."
	done

_MewtwoB3FText4::
	text "They built me as a"
	line "weapon of mass"
	cont "destruction."
	
	para "I just want peace."
	line "Leave me."
	done

_MewtwoB3FText5::
	text "Stop chasing me."

	para "You will forever"
	line "regret it."
	done

_MewtwoB3FText6::
	text "I will be your"
	line "end, and you will"
	cont "be the end of"
	cont "yours species."

	para "This is my curse."
	done

_MewtwoB3FText7::
	text "Go out of this"
	line "cave. Now."

	para "Don't make your"
	line "#MON suffer."
	done

_MewtwoB3FText8::
	text "Tame your primal"
	line "instincts, human."

	para "For you own good."

	para "Your greed for"
	line "power will be"
	cont "your downfall."
	done

_WeakGroundText::
	text "The ground's weak."
	para "Enough weight over"
	line "it will make it"
	cont "collapse."
	done

_WeakGroundCollapsedText::
	text "The weak ground"
	line "collapsed under"
	cont "the weight of"
	cont "the boulders."
	done

_TradebackGuyIntroText::
	text "Hey wanna trade"
	line "with me?"

	para "Send me a #MON,"
	line "and I'll send it"
	cont "right back at ya'."
	done

_TradebackGuyAnotherTimeText::
	text "Maybe another day."
	done

_TradebackGuyConfusedText::
	text "Oh… really?"
	line "Phat!"

	para "… I mean… I'm"
	line "making you a favor"
	cont "and I think I"
	cont "deserve a…"

	para "Uh…"

	para "Let me think."
	done

_TradebackGuyDealText::
	text "I want a"
	line "@"
	text_ram wStringBuffer3
	text "."

	para "Give me one, and"
	line "we have a deal."
	done

_TradebackGuyDealBrokenText::
	text "Shoot! I should've"
	line "asked for some-"
	cont "thing cheaper."
	done

_TradebackGuyDontHaveItemText::
	text "But you don't"
	line "have one!"

	para "I thought you were"
	line "a real trainer…"
	done

_TradebackPlayerGivesItemText::
	text "<PLAYER> gave 1"
	line "@"
	text_ram wStringBuffer3
	text "."
	done

_TradebackGuyDealOkText::
	text "For real? I can"
	line "have it?"
	cont "Thanks!"

	para "Let's do it then!"
	done

_TradebackGuyKeepPaymentText::
	text "Changed your"
	line "mind?"

	para "Your problem!"

	para "I'm keeping your"
	line "gift, thanks."
	done

_TradebackGuyDealNoEvoText::
	text "It didn't evolve."
	line "Boring."
	done

_TradebackGuyDealEvoText::
	text "Wow!"
	line "This evolution"
	cont "was the bomb!"

	para "I can't wait to"
	line "tell MICKEY"
	cont "about it!"
	done

ClosedBusinessText::
	text "There is a notice"
	line "on the door…"

	para "“Due to the"
	line "sanitary crisis,"

	para "our establishment"
	line "must remain closed"

	para "until further"
	line "notice.”"
	done

ClosedBusinessCurfewText::
	text "There is a notice"
	line "on the door…"

	para "“Our establishment"
	line "will reopen tomor-"

	para "row morning, after"
	line "the curfew.”"
	done

ElmsLabBookshelf1Text::
	text "TRAINER TIPS"
	
	para "Keep the Down"
	line "button pressed"
	cont "to fast forward"
	cont "dialogs!"
	done
	
ElmsLabBookshelf2Text::
	text "STATS SCREEN"

	para "The ! symbol next"
	line "to a stat means"
	cont "that it has the"
	cont "maximum potential."

	para "The <EMPTY_STAR> symbol at"
	line "the left of a stat"
	cont "means that it is"
	cont "fully trained, and"
	cont "will only grow by"
	cont "leveling up."
	done

ElmsLabBookshelf3Text::
	text "START MENU"

	para "Press Start to"
	line "display the Start"
	cont "menu."

	para "Long press the"
	line "Start button to"
	cont "quickly access"
	cont "the SAVE menu."

	para "The SAVE menu al-"
	line "lows you to save"
	cont "your progress"
	cont "before turning off"
	cont "your console."

	para "The OPTIONS menu"
	line "allows you to"
	cont "customize your"
	cont "experience."

	para "More info on this"
	line "menu in the next"
	cont "bookshelves to"
	cont "the right."
	done

ElmsLabBookshelf4Text::
	text "FAST BOOT"

	para "OFF mode:"
	line "The game starts"
	cont "normally."
	
	para "ON mode:"
	line "The game skips the"
	cont "intro and starts"
	cont "directly into the"
	cont "world."

	para "If you want to"
	line "admire the intro-"
	cont "duction, or access"
	cont "the NEW GAME menu,"
	cont "set the FAST BOOT"
	cont "option to OFF,"
	cont "save your game,"
	cont "then reboot your"
	cont "console."
	done

ElmsLabBookshelf5Text::
	text "WORLD ACTIONS"
	line "Tome 1/3"
	
	para "LEGACY mode:"
	line "Interact in the"
	cont "same way as in"
	cont "the original game."

	para "SHORTCUT mode:"
	line "In addition to the"
	cont "legacy interac-"
	cont "tions, this mode"
	cont "aims to offer a"
	cont "fluid experience"
	cont "by minimizing"
	cont "button presses."

	para "More info on the"
	line "next shelf."
	done
	
ElmsLabBookshelf6Text::
	text "WORLD ACTIONS"
	line "Tome 2/3"

	para "SHORTCUTS mode:"
	line "In this mode, pick"
	cont "up items by walk-"
	cont "ing towards them."

	para "Auto-trigger field"
	line "moves by bumping"
	cont "in cutable trees,"
	cont "breakable rocks,"
	cont "boulders,"
	cont "waterfalls,"
	cont "and whirlpools."

	para "FLASH triggers"
	line "automatically in"
	cont "dark areas."

	para "You still have to"
	line "press A to"
	cont "HEADBUTT a tree."

	para "You can trigger"
	line "more field moves"
	cont "by long-pressing"
	cont "other buttons."

	para "More info on the"
	line "next shelf."
	done

ElmsLabBookshelf7Text::
	text "WORLD ACTIONS"
	line "Tome 3/3"
	
	para "SHORTCUTS mode:"
	line "Long press the A"
	cont "button to trigger"
	cont "a field move."
	
	para "It triggers CUT"
	line "while facing tall"
	cont "grass."
	
	para "When inside of"
	line "it, it triggers"
	cont "SWEET SCENT."

	para "Long press B to"
	line "leave the current"
	cont "area."
	
	para "After confirmation"
	line "it will trigger"
	cont "either FLY, DIG or"
	cont "TELEPORT, depen-"
	cont "ding on the area."
	
	para "ESCAPE ROPE can be"
	line "used this way as"
	cont "well."

	para "The SELECT button"
	line "also has magic"
	cont "shortcuts."

	para "More info on the"
	line "next shelf."
	done

ElmsLabBookshelf8Text::
	text "TRAINER TIPS"

	para "You can use KEY"
	line "ITEMS quickly by"
	cont "pressing Select."

	para "Facing water will"
	line "use a ROD."
	
	para "The registered one"
	line "will be chosen in"
	cont "priority. Or else,"
	cont "the one placed the"
	cont "highest in the KEY"
	cont "ITEMS pocket."

	para "Facing a fruit"
	line "tree will use the"
	cont "SQUIRTBOTTLE."

	para "In other situa-"
	line "tions, it uses"
	cont "the BICYCLE."

	para "A long press uses"
	line "the ITEMFINDER."
	done

_RTCErrorText::
	text "This game requires"
	line "a Real-Time Clock."
	
	para "If you are using a"
	line "game cartridge,"
	cont "the coin battery"
	cont "may be depleted."

	para "If using an"
	line "emulator, check"
	cont "its parameters or"
	cont "use another one."
	prompt

_Clapping1Text::
	text "*clap* *clap*"
	line " *clap* *clap*"
	done