_OakText6::
	text "Now, what did you"
	line "say your name was?"
	prompt

_OakText7::
	text "<PLAYER>, are you"
	line "ready?"

	para "Your very own"
	line "#MON story is"
	cont "about to unfold."

	para "You'll face fun"
	line "times and tough"
	cont "challenges."

	para "A world of dreams"
	line "and adventures"

	para "with #MON"
	line "awaits! Let's go!"

	para "I'll be seeing you"
	line "later!"
	done

_ClockTimeMayBeWrongText::
	text "The clock's time"
	line "may be wrong."

	para "Please reset the"
	line "time."
	prompt

_ClockSetWithControlPadText::
	text "Set with the"
	line "Control Pad."

	para "Confirm: A Button"
	line "Cancel:  B Button"
	done

_ClockIsThisOKText::
	text "Is this OK?"
	done

_ClockHasResetText::
	text "The clock has been"
	line "reset."
	done

_LinkTimeoutText::
	text "Too much time has"
	line "elapsed. Please"
	cont "try again."
	prompt

_LinkTradeCantBattleText::
	text "If you trade that"
	line "#MON, you won't"
	cont "be able to battle."
	prompt

_LinkAbnormalMonText::
	text "Your friend's"
	line "@"
	text_ram wStringBuffer1
	text " appears"
	cont "to be abnormal!"
	prompt

_LinkAskTradeForText::
	text "Trade @"
	text_ram wBufferTrademonNickname
	text_start
	line "for @"
	text_ram wStringBuffer1
	text "?"
	done

_MobileBattleMustPickThreeMonText::
	text "To enter a mobile"
	line "battle, you must"

	para "pick a team of"
	line "three #MON."

	para "Is that OK?"
	done

_MobileBattleMoreInfoText::
	text "Need more info on"
	line "mobile battles?"
	done

_MobileBattleRulesText::
	text "For a mobile"
	line "battle, choose"
	cont "three #MON."

	para "The maximum daily"
	line "play time is ten"

	para "minutes for each"
	line "linked player."

	para "If a battle isn't"
	line "finished within"

	para "the time limit,"
	line "the player with"

	para "the fewest fainted"
	line "#MON wins."

	para "If tied, the team"
	line "that lost the"

	para "least amount of HP"
	line "wins."
	done

_WouldYouLikeToMobileBattleText::
	text "Today's remaining"
	line "time is @"
	text_decimal wStringBuffer2, 1, 2
	text " min."

	para "Would you like to"
	line "battle?"
	done

_WantAQuickMobileBattleText::
	text "There are only @"
	text_decimal wStringBuffer2, 1, 2
	text_start
	line "min. left today."

	para "Want a quick"
	line "battle?"
	done

_WantToRushThroughAMobileBattleText::
	text "There is only"
	line "1 min. left today!"

	para "Want to rush"
	line "through a battle?"
	done

_PleaseTryAgainTomorrowText::
	text "There is less than"
	line "1 min. left today!"

	para "Please try again"
	line "tomorrow."
	done

_TryAgainUsingSameSettingsText::
	text "Try again using"
	line "the same settings?"
	done

_MobileBattleLessThanOneMinuteLeftText::
	text "There is less than"
	line "1 min. left today!"
	done

_MobileBattleNoTimeLeftForLinkingText::
	text "No time left for"
	line "linking today."
	done

_PickThreeMonForMobileBattleText::
	text "Pick three #MON"
	line "for battle."
	done

_MobileBattleRemainingTimeText::
	text "Today's remaining"
	line "time is @"
	text_decimal wStringBuffer2, 1, 2
	text " min."
	done

_WouldYouLikeToSaveTheGameText::
	text "Would you like to"
	line "save the game?"
	done

_SavedTheGameText::
	text "<PLAYER> saved"
	line "the game."
	done

_AnotherSaveFileText::
	text "There is another"
	line "save file. Is it"
	cont "OK to overwrite?"
	done

_SaveFileCorruptedText::
	text "The save file is"
	line "corrupted!"
	prompt

_ChangeBoxSaveText::
	text "When you change a"
	line "#MON BOX, data"
	cont "will be saved. OK?"
	done

_MoveMonWOMailSaveText::
	text "Each time you move"
	line "a #MON, data"
	cont "will be saved. OK?"
	done

_WindowPoppingErrorText::
	text "No windows avail-"
	line "able for popping."
	done

_ObjectEventText::
	text "Object event"
	done

_ReceivedItemText::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer4
	text "."
	done

_ReceivedMultipleItemText::
	text "<PLAYER> received"
	line "@"
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer4
	text "."
	done

_PutItemInPocketText::
	text "<PLAYER> put the"
	line "@"
	text_ram wStringBuffer1
	text " in"
	cont "the @"
	text_ram wStringBuffer3
	text "."
	prompt

_PocketIsFullText::
	text "The @"
	text_ram wStringBuffer3
	text_start
	line "is full…"
	prompt

_SeerSeeAllText::
	text "I see all."
	line "I know all…"

	para "Certainly, I know"
	line "of your #MON!"
	done

_SeerCantTellAThingText::
	text "Whaaaat? I can't"
	line "tell a thing!"

	para "How could I not"
	line "know of this?"
	done

_SeerNameLocationText::
	text "Hm… I see you met"
	line "@"
	text_ram wSeerNickname
	text " here:"
	cont "@"
	text_ram wSeerCaughtLocation
	text "!"
	prompt

_SeerTimeLevelText::
	text "The time was"
	line "@"
	text_ram wSeerTimeOfDay
	text "!"

	para "Its level was @"
	text_ram wSeerCaughtLevelString
	text "!"

	para "Am I good or what?"
	prompt

_SeerTradeText::
	text "Hm… @"
	text_ram wSeerNickname
	text_start
	line "came from @"
	text_ram wSeerOT
	text_start
	cont "in a trade?"

	para "@"
	text_ram wSeerCaughtLocation
	text_start
	line "was where @"
	text_ram wSeerOT
	text_start
	cont "met @"
	text_ram wSeerNickname
	text "!"
	prompt

_SeerNoLocationText::
	text "What!? Incredible!"

	para "I don't understand"
	line "how, but it is"

	para "incredible!"
	line "You are special."

	para "I can't tell where"
	line "you met it, but it"
	cont "was at level @"
	text_ram wSeerCaughtLevelString
	text "."

	para "Am I good or what?"
	prompt

_SeerEggText::
	text "Hey!"

	para "That's an EGG!"

	para "You can't say that"
	line "you've met it yet…"
	done

_SeerDoNothingText::
	text "Fufufu! I saw that"
	line "you'd do nothing!"
	done

_SeerMoreCareText::
	text "Incidentally…"

	para "It would be wise"
	line "to raise your"

	para "#MON with a"
	line "little more care."
	done

_SeerMoreConfidentText::
	text "Incidentally…"

	para "It seems to have"
	line "grown a little."

	para "@"
	text_ram wSeerNickname
	text " seems"
	line "to be becoming"
	cont "more confident."
	done

_SeerMuchStrengthText::
	text "Incidentally…"

	para "@"
	text_ram wSeerNickname
	text " has"
	line "grown. It's gained"
	cont "much strength."
	done

_SeerMightyText::
	text "Incidentally…"

	para "It certainly has"
	line "grown mighty!"

	para "This @"
	text_ram wSeerNickname
	text_start
	line "must have come"

	para "through numerous"
	line "#MON battles."

	para "It looks brimming"
	line "with confidence."
	done

_SeerImpressedText::
	text "Incidentally…"

	para "I'm impressed by"
	line "your dedication."

	para "It's been a long"
	line "time since I've"

	para "seen a #MON as"
	line "mighty as this"
	cont "@"
	text_ram wSeerNickname
	text "."

	para "I'm sure that"
	line "seeing @"
	text_ram wSeerNickname
	text_start

	para "in battle would"
	line "excite anyone."
	done

_CongratulationsYourPokemonText::
	text "Congratulations!"
	line "Your @"
	text_ram wStringBuffer2
	text_end

_EvolvedIntoText::
	text_start

	para "evolved into"
	line "@"
	text_ram wStringBuffer1
	text "!"
	done

_StoppedEvolvingText::
	text "Huh? @"
	text_ram wStringBuffer2
	text_start
	line "stopped evolving!"
	prompt

_EvolvingText::
	text "What? @"
	text_ram wStringBuffer2
	text_start
	line "is evolving!"
	done

_MartHowManyText::
	text "How many?"
	done

AlreadyHaveTMText::
	text "You already own"
	line "that TM."
	done

_MartFinalPriceText::
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer2
	text "(S)"
	line "will be ¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."
	done

_HerbShopLadyIntroText::
	text "Hello, dear."

	para "I sell inexpensive"
	line "herbal medicine."

	para "They're good, but"
	line "a trifle bitter."

	para "Your #MON may"
	line "not like them."

	para "Hehehehe…"
	done

_HerbalLadyThanksText::
	text "Thank you, dear."
	line "Hehehehe…"
	done

_HerbalLadyPackFullText::
	text "Oh? Your PACK is"
	line "full, dear."
	done

_HerbalLadyNoMoneyText::
	text "Hehehe… You don't"
	line "have the money."
	done

_HerbalLadyComeAgainText::
	text "Come again, dear."
	line "Hehehehe…"
	done

_StoneShopIntroText::
	text "Stone healing is"
	line "an ancestral"
	cont "practice."
	
	para "There is a stone"
	line "for every need."
	done

_StoneShopThanksText::
	text "Great choice. You"
	line "won't regret it."
	done

_StoneShopNoMoneyText::
	text "My premium stones"
	line "come at a price"
	cont "you can't afford…"
	done

_StoneShopComeAgainText::
	text "May you find peace"
	line "in the stones."
	done

_JadeCrystalSellPitchText::
	text "My best seller."

	para "There is nothing a"
	line "stone can't heal."

	para "And COVID is no"
	line "exception."

	para "Have your #MON"
	line "hold it, and it"
	cont "won't get sick."
	done
	
_StarPieceSellPitchText::
	text "What is the effect"
	line "of this one you"
	cont "may ask?"

	para "This one"
	line "sparks joy."
	done
	
_EverstoneSellPitchText::
	text "EVIOSTONE is the"
	line "contraction of"
	cont "EVIOLITE and"
	cont "EVERSTONE."

	para "It holds the pro-"
	line "perties of both"
	cont "stones."

	para "Give it to a #-"
	line "MON that can still"
	cont "evolve."

	para "It will boost its"
	line "DEF and SPCL.DEF"
	cont "by 50<PERCENT> but prevent"
	cont "it from evolving."
	done

_LastEverstoneText::
	text "Lucky you!"
	line "You bought my very"
	cont "last EVIOSTONE!"
	done

_BargainShopIntroText::
	text "Hiya! Care to see"
	line "some bargains?"

	para "I sell rare items"
	line "that nobody else"

	para "carries--but only"
	line "one of each item."
	done

_BargainShopFinalPriceText::
	text_ram wStringBuffer2
	text " costs"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text ". Want it?"
	done

_BargainShopThanksText::
	text "Thanks."
	done

_BargainShopPackFullText::
	text "Uh-oh, your PACK"
	line "is chock-full."
	done

_BargainShopSoldOutText::
	text "You bought that"
	line "already. I'm all"
	cont "sold out of it."
	done

_BargainShopNoFundsText::
	text "Uh-oh, you're"
	line "short on funds."
	done

_BargainShopComeAgainText::
	text "Come by again"
	line "sometime."
	done

_PharmacyIntroText::
	text "What's up? Need"
	line "some medicine?"
	done

_PharmacyFinalPriceText::
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer2
	text "(S)"
	line "will cost ¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."
	done

_PharmacyThanksText::
	text "Thanks much!"
	done

_PharmacyPackFullText::
	text "You don't have any"
	line "more space."
	done

_PharmacyNoMoneyText::
	text "Huh? That's not"
	line "enough money."
	done

_PharmacyComeAgainText::
	text "All right."
	line "See you around."
	done

_MartSellPriceText::
	text "I can pay you"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."

	para "Is that OK?"
	done

_MartWelcomeText::
	text "Welcome! How may I"
	line "help you?"
	done

_ShortageExplanationText::
	text "Hello, dear"
	line "customer!"

	para "As you can tell by"
	line "the look of my"

	para "shelves, there is"
	line "a significant"
	cont "shortage."

	para "The sudden rush"
	line "of customers,"
	
	para "the closure of"
	line "the borders,"
	
	para "and the decrease"
	line "of the workforce"
	cont "all lead to this."

	para "My supply is limi-"
	line "ted and prices"
	cont "have gone up."

	para "If you don't find"
	line "what you want here"
	
	para "you can try an-"
	line "other #MART,"
	
	para "or come back"
	line "tomorrow as I may"

	para "get a new"
	line "delivery."

	para "Let's see if I have"
	line "anything you need."
	done

_MartDoMyBest1Text::
	text "I'll help you as"
	line "much as I can."
	done

_MartDoMyBest2Text::
	text "Let's hope I have"
	line "what you need."
	done

_MartDoMyBest3Text::
	text "I'll do my best"
	line "to serve you."
	done

_MartDoMyBest4Text::
	text "Welcome to my"
	line "almost-empty shop!"
	done
	
_MartThanksText::
	text "Here you are."
	line "Thank you!"
	done

_MartNoMoneyText::
	text "You don't have"
	line "enough money."
	done

_MartPackFullText::
	text "You can't carry"
	line "any more items."
	done

_MartShortageText::
	text "I don't have this"
	line "many articles."
	prompt

_MartCantBuyText::
	text "Sorry, I can't buy"
	line "that from you."
	prompt

_MartComeAgainText::
	text "Please come again!"
	done

_MartComeAnotherDayText::
	text "I restock every-"
	line "day, come again!"
	done

_MartAskMoreText::
	text "Can I do anything"
	line "else for you?"
	done

_MartAllIHaveLeftText::
	text "It's all I got left"
	line "with the shortage."
	done

_MartLastItemText::
	text "This was the last"
	line "of my items."
	done

_MartEmptyStock1Text::
	text "I got nothing else"
	line "to sell today."
	prompt

_MartEmptyStock2Text::
	text "My stock is empty."
	prompt

_MartEmptyStock3Text::
	text "You bought every-"
	line "thing I had!"
	prompt

_MartEmptyStock4Text::
	text "Come back tomorrow"
	line "after I restock."
	prompt

_MartBoughtText::
	text "Got ¥@"
	text_decimal hMoneyTemp, 3, 6
	text " for"
	line "@"
	text_ram wStringBuffer2
	text "(S)."
	done

_SlotsBetHowManyCoinsText::
	text "Bet how many"
	line "coins?"
	done

_SlotsStartText::
	text "Start!"
	done

_SlotsNotEnoughCoinsText::
	text "Not enough"
	line "coins."
	prompt

_SlotsRanOutOfCoinsText::
	text "Darn… Ran out of"
	line "coins…"
	done

_SlotsPlayAgainText::
	text "Play again?"
	done

_SlotsLinedUpText::
	text "lined up!"
	line "Won @"
	text_ram wStringBuffer2
	text " coins!"
	done

_SlotsDarnText::
	text "Darn!"
	done

_MobileStadiumEntryText::
	text "Data for use in"
	line "the MOBILE STADIUM"

	para "of the N64 #MON"
	line "STADIUM 2 can be"
	cont "read here."

	para "Read the data?"
	done

_MobileStadiumSuccessText::
	text "Data transfer is"
	line "complete."

	para "We hope you enjoy"
	line "MOBILE STADIUM"

	para "battles in the N64"
	line "#MON STADIUM 2."

	para ""
	done

_MainMenuTimeUnknownText::
	text "Clock time unknown"
	done

_DeleteSavedLoginPasswordText::
	text "Delete the saved"
	line "LOG-IN PASSWORD?"
	done

_DeletedTheLoginPasswordText::
	text "Deleted the LOG-IN"
	line "PASSWORD."
	done

_MobilePickThreeMonForBattleText::
	text "Pick three #MON"
	line "for battle."
	prompt

_MobileUseTheseThreeMonText::
	text_ram wMobileParticipant1Nickname
	text ","
	line "@"
	text_ram wMobileParticipant2Nickname
	text " and"
	cont "@"
	text_ram wMobileParticipant3Nickname
	text "."

	para "Use these three?"
	done

_MobileOnlyThreeMonMayEnterText::
	text "Only three #MON"
	line "may enter."
	prompt

_MobileCardFolderIntro1Text::
	text "The CARD FOLDER"
	line "stores your and"

	para "your friends'"
	line "CARDS."

	para "A CARD contains"
	line "information like"

	para "the person's name,"
	line "phone number and"
	cont "profile."

	para ""
	done

_MobileCardFolderIntro2Text::
	text "This is your CARD."

	para "Once you've"
	line "entered your phone"

	para "number, you can"
	line "trade CARDS with"
	cont "your friends."

	para ""
	done

_MobileCardFolderIntro3Text::
	text "If you have your"
	line "friend's CARD, you"

	para "can use it to make"
	line "a call from a"

	para "mobile phone on"
	line "the 2nd floor of a"
	cont "#MON CENTER."

	para ""
	done

_MobileCardFolderIntro4Text::
	text "To safely store"
	line "your collection of"

	para "CARDS, you must"
	line "set a PASSCODE for"
	cont "your CARD FOLDER."

	para ""
	done

_MobileCardFolderAskDeleteText::
	text "If the CARD FOLDER"
	line "is deleted, all"

	para "its CARDS and the"
	line "PASSCODE will also"
	cont "be deleted."

	para "Beware--a deleted"
	line "CARD FOLDER can't"
	cont "be restored."

	para "Want to delete"
	line "your CARD FOLDER?"
	done

_MobileCardFolderDeleteAreYouSureText::
	text "Are you sure you"
	line "want to delete it?"
	done

_MobileCardFolderDeletedText::
	text "The CARD FOLDER"
	line "has been deleted."

	para ""
	done

_MobileCardFolderAskOpenOldText::
	text "There is an older"
	line "CARD FOLDER from a"
	cont "previous journey."

	para "Do you want to"
	line "open it?"
	done

_MobileCardFolderAskDeleteOldText::
	text "Delete the old"
	line "CARD FOLDER?"
	done

_MobileCardFolderFinishRegisteringCardsText::
	text "Finish registering"
	line "CARDS?"
	done

_PhoneWrongNumberText::
	text "Huh? Sorry, wrong"
	line "number!"
	done

_PhoneClickText::
	text "Click!"
	done

_PhoneEllipseText::
	text "<……>"
	done

_PhoneOutOfAreaText::
	text "That number is out"
	line "of the area."
	done

_PhoneJustTalkToThemText::
	text "Just go talk to"
	line "that person!"
	done

_PhoneThankYouText::
	text "Thank you!"
	done

_PasswordAskResetText::
	text "Password OK."
	line "Select CONTINUE &"
	cont "reset settings."
	prompt

_PasswordWrongText::
	text "Wrong password!"
	prompt

_PasswordAskResetClockText::
	text "Reset the clock?"
	done

_PasswordAskEnterText::
	text "Please enter the"
	line "password."
	done

_ClearAllSaveDataText::
	text "Clear all save"
	line "data?"
	done

_LearnedMoveText::
	text_ram wMonOrItemNameBuffer
	text " learned"
	line "@"
	text_ram wStringBuffer2
	text "!@"
	sound_dex_fanfare_50_79
	text_promptbutton
	text_end

_MoveAskForgetText::
	text "Which move should"
	next "be forgotten?"
	done

_StopLearningMoveText::
	text "Stop learning"
	line "@"
	text_ram wStringBuffer2
	text "?"
	done

_DidNotLearnMoveText::
	text_ram wMonOrItemNameBuffer
	text_start
	line "did not learn"
	cont "@"
	text_ram wStringBuffer2
	text "."
	prompt

_AskForgetMoveText::
	text "Delete an older"
	line "move to make room"
	cont "for @"
	text_ram wStringBuffer2
	text "?"
	done

_AskForgetMoveLongText::
	text_ram wMonOrItemNameBuffer
	text " is"
	line "trying to learn"
	cont "@"
	text_ram wStringBuffer2
	text "."
	
	para "Delete a move to"
	line "make room for it?"
	done

Text_MoveForgetCount::
	text "1, 2 and…@"
	text_pause
	text_end

_MoveForgotText::
	text " Poof!@"
	text_pause
	text_start

	para "@"
	text_ram wMonOrItemNameBuffer
	text " forgot"
	line "@"
	text_ram wStringBuffer1
	text "."

	para "And…"
	prompt

_MoveCantForgetHMText::
	text "HM moves can't be"
	line "forgotten now."
	prompt

_CardFlipPlayWithThreeCoinsText::
	text "Play with three"
	line "coins?"
	done

_CardFlipNotEnoughCoinsText::
	text "Not enough coins…"
	prompt

_CardFlipChooseACardText::
	text "Choose a card."
	done

_CardFlipPlaceYourBetText::
	text "Place your bet."
	done

_CardFlipPlayAgainText::
	text "Want to play"
	line "again?"
	done

_CardFlipShuffledText::
	text "The cards have"
	line "been shuffled."
	prompt

_CardFlipYeahText::
	text "Yeah!"
	done

_CardFlipDarnText::
	text "Darn…"
	done

_GearEllipseText::
	text "<……>"
	done

_GearOutOfServiceText::
	text "You're out of the"
	line "service area."
	prompt

_PokegearAskWhoCallText::
	text "Whom do you want"
	line "to call?"
	done

_PokegearPressButtonText::
	text "Press any button"
	line "to exit."
	done

_PokegearAskDeleteText::
	text "Delete this stored"
	line "phone number?"
	done

_BuenaAskWhichPrizeText::
	text "Which prize would"
	line "you like?"
	done

_BuenaIsThatRightText::
	text_ram wStringBuffer1
	text "?"
	line "Is that right?"
	done

_BuenaHereYouGoText::
	text "Here you go!"

	para ""
	done

_BuenaNotEnoughPointsText::
	text "You don't have"
	line "enough points."

	para ""
	done

_BuenaNoRoomText::
	text "You have no room"
	line "for it."

	para ""
	done

_BuenaComeAgainText::
	text "Oh. Please come"
	line "back again!"
	done

_BTExcuseMeText::
	text "Excuse me!"

	para ""
	done

_ExcuseMeYoureNotReadyText::
	text "Excuse me."
	line "You're not ready."

	para ""
	done

_BattleTowerReturnWhenReadyText::
	text "Please return when"
	line "you're ready."
	done

_NeedAtLeastThreeMonText::
	text "You need at least"
	line "three #MON."

	para ""
	done

_EggDoesNotQualifyText::
	text "Sorry, an EGG"
	line "doesn't qualify."

	para ""
	done

_OnlyThreeMonMayBeEnteredText::
	text "Only three #MON"
	line "may be entered."

	para ""
	done

_TheMonMustAllBeDifferentKindsText::
	text "The @"
	text_ram wStringBuffer2
	text " #MON"
	line "must all be"
	cont "different kinds."

	para ""
	done

_TheMonMustNotHoldTheSameItemsText::
	text "The @"
	text_ram wStringBuffer2
	text " #MON"
	line "must not hold the"
	cont "same items."

	para ""
	done

_YouCantTakeAnEggText::
	text "You can't take an"
	line "EGG!"

	para ""
	done

_BallDodgedText::
	text "It dodged the"
	line "thrown BALL!"

	para "This #MON"
	line "can't be caught!"
	prompt

_BallMissedText::
	text "You missed the"
	line "#MON!"
	prompt

_BallBrokeFreeText::
	text "Oh no! The #MON"
	line "broke free!"
	prompt

_BallAppearedCaughtText::
	text "Aww! It appeared"
	line "to be caught!"
	prompt

_BallAlmostHadItText::
	text "Aargh!"
	line "Almost had it!"
	prompt

_BallSoCloseText::
	text "Shoot! It was so"
	line "close too!"
	prompt

Text_BallCaught::
	text "Gotcha! @"
	text_ram wEnemyMonNickname
	text_start
	line "was caught!@"
	sound_caught_mon
	text_end

_WaitButtonText::
	text_promptbutton
	text_end

_BallSentToPCText::
	text_ram wMonOrItemNameBuffer
	text " was"
	line "sent to BILL's PC."
	prompt

_NewDexDataText::
	text_ram wEnemyMonNickname
	text "'s data"
	line "was newly added to"
	cont "the #DEX.@"
	sound_slot_machine_start
	text_promptbutton
	text_end

_AskGiveNicknameText::
	text "Give a nickname to"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done

_ItemStatRoseText::
	text_ram wStringBuffer1
	text "'s"
	line "@"
	text_ram wStringBuffer2
	text " rose."
	prompt

_ItemCantUseOnMonText::
	text "That can't be used"
	line "on this #MON."
	prompt

_RepelUsedEarlierIsStillInEffectText::
	text "The REPEL used"
	line "earlier is still"
	cont "in effect."
	prompt

_PlayedFluteText::
	text "Played the #"
	line "FLUTE."

	para "Now, that's a"
	line "catchy tune!"
	prompt

_FluteWakeUpText::
	text "All sleeping"
	line "#MON woke up."
	prompt

Text_PlayedPokeFlute::
	text "<PLAYER> played the"
	line "# FLUTE.@"
	text_promptbutton
	text_end

_BlueCardBalanceText::
	text "You now have"
	line "@"
	text_decimal wBlueCardBalance, 1, 2
	text " points."
	done

_CoinCaseCountText::
	text "Coins:"
	line "@"
	text_decimal wCoins, 2, 4
	text_end

_RaiseThePPOfWhichMoveText::
	text "Raise the PP of"
	line "which move?"
	done

_RestoreThePPOfWhichMoveText::
	text "Restore the PP of"
	line "which move?"
	done

_PPIsMaxedOutText::
	text_ram wStringBuffer2
	text "'s PP"
	line "is maxed out."
	prompt

_PPsIncreasedText::
	text_ram wStringBuffer2
	text "'s PP"
	line "increased."
	prompt

_PPRestoredText::
	text "PP was restored."
	prompt

_SentTrophyHomeText::
	text "There was a trophy"
	line "inside!@"
	sound_dex_fanfare_50_79
	text_start

	para "@"
	text_ram wPlayerName
	text " sent the"
	line "trophy home."
	prompt

_ItemLooksBitterText::
	text "It looks bitter…"
	prompt

_ItemCantUseOnEggText::
	text "That can't be used"
	line "on an EGG."
	prompt

_ItemWontHaveEffectText::
	text "It won't have any"
	line "effect."
	prompt

_BallBlockedText::
	text "The trainer"
	line "blocked the BALL!"
	prompt

_BallDontBeAThiefText::
	text "Don't be a thief!"
	prompt

_BallBoxFullText::
	text "The #MON BOX"
	line "is full. That"
	cont "can't be used now."
	prompt

_ItemUsedText::
	text "<PLAYER> used the@"
	text_low
	text_ram wStringBuffer2
	text "."
	done

_ItemUsedButNopeText::
	text "MEWTWO won't"
	line "let you use this."
	done

_MewtwoRetreatText::
	text "MEWTWO"
	line "retreats."
	done

_KnowsMoveText::
	text_ram wStringBuffer1
	text " knows"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt

_MoveKnowsOneText::
	text "That #MON knows"
	line "only one move."
	done

_AskDeleteMoveText::
	text "Oh, make it forget"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done

_DeleterForgotMoveText::
	text "Done! Your #MON"
	line "forgot the move."
	done

_DeleterPikachuRefuses::
	text "Uh?"

	para "PIKACHU refused"
	line "to forget SURF."

	para "It probably has"
	line "good reasons."
	done

_DeleterEggText::
	text "An EGG doesn't"
	line "know any moves!"
	done

_DeleterNoComeAgainText::
	text "No? Come visit me"
	line "again."
	done

_DeleterAskWhichMoveText::
	text "Which move should"
	line "it forget, then?"
	prompt

_DeleterIntroText::
	text "Um… Oh, yes, I'm"
	line "the MOVE DELETER."

	para "I can make #MON"
	line "forget moves."

	para "Shall I make a"
	line "#MON forget?"
	done

_DeleterAskWhichMonText::
	text "Which #MON?"
	prompt

_DSTIsThatOKText::
	text " DST,"
	line "is that OK?"
	done

_TimeAskOkayText::
	text ","
	line "is that OK?"
	done

_TimesetAskDSTText::
	text "Do you want to"
	line "switch to Daylight"
	cont "Saving Time?"
	done

_TimesetDSTText::
	text "I set the clock"
	line "forward by one"
	cont "hour."
	prompt

_TimesetAskNotDSTText::
	text "Is Daylight Saving"
	line "Time over?"
	done

_TimesetNotDSTText::
	text "I put the clock"
	line "back one hour."
	prompt

_TimesetAskAdjustDSTText::
	text "Do you want to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time?"
	done

_MomLostGearBookletText::
	text "I lost the in-"
	line "struction booklet"
	cont "for the #GEAR."

	para "Come back again in"
	line "a while."
	prompt

_GymPowerRestrainerFirstExplanation::
	text "Oh! It's the first"
	line "time you challenge"
	cont "a GYM leader?"

	para "I see."

	para "Let me tell you"
	line "how it goes."

	para "My goal is to"
	line "fairly judge your"
	cont "trainer skills"
	cont "through battle."

	para "That's why"
	line "GYM leaders use a"
	cont "POWER RESTRAINER"
	cont "on their #MON."

	para "It enables our"
	line "#MON to lower"
	cont "their level by up"
	cont "to 40."
	
	para "I will adjust the"
	line "level of my team"
	cont "based on your"
	cont "strongest #MON."

	para "Of course, if your"
	line "strongest one has"
	cont "a higher level"
	cont "than mine, I won't"
	cont "need to use the"
	cont "POWER RESTRAINER."

	para "Also, each GYM"
	line "LEADER sets some"
	cont "special rules for"
	cont "their battle,"

	para "in order to"
	line "find out how well"
	cont "challengers handle"
	cont "unexpected"
	cont "situations."

;	para "Have you checked"
;	line "them on the"
;	cont "pillars at the "
;	cont "entrance?"

	para "That's all."
	line "Back to me." ; Damien.

	done

_FirstLockdownDeclarationText::
	text "INTERVENTION"

	para "“Due to the rise"
	line "in daily new cases"
	cont "of contamination,"

	para "starting tomorrow"
	line "a lockdown will be"
	cont "enforced."

	para "#MON and people"
	line "are not allowed"
	cont "to leave home."

	para "The only"
	line "exceptions are:"

	para "groceries, work,"
	line "& medical reasons."

	para "Each trip outside"
	line "requires a"
	cont "self-made written"
	cont "attestation."

	para "Wearing a face"
	line "mask is mandatory."

	para "There will be"
	line "police controls."

	para "Illegal situations"
	line "will be fined, and"
	cont "you will be"
	cont "reconducted home"
	cont "or to the nearest"
	cont "#MON center."

	para "-"

	para "Be responsible,"
	line "save lives,"
	cont "stay safe.”"
	done




_HospitalVisitHappiness0Text::
	text "Your @"
	text_ram wStringBuffer1
	text " is"
	line "ignoring you…"
	prompt

_HospitalVisitHappiness1Text::
	text "Your @"
	text_ram wStringBuffer1
	text ""
	line "didn't expect you."
	prompt

_HospitalVisitHappiness2Text::
	text "Your @"
	text_ram wStringBuffer1
	text " is"
	line "glad to see you."
	prompt

_HospitalVisitHappiness3Text::
	text "Your @"
	text_ram wStringBuffer1
	text " is"
	line "happy to see you"
	cont "once again!"
	prompt




_HospitalVisitDuration0Text::
	text "It looks in per-"
	line "fect shape and"
	cont "ready to go out!"
	done

_HospitalVisitDuration1Text::
	text "It appears to feel"
	line "better and should"
	cont "be able to leave"
	cont "soon."
	done

_HospitalVisitDuration2Text::
	text "Quite some time"
	line "will be necessary"
	cont "before it can"
	cont "leave this room…"
	done



	
_MoveReminderIntro::
    text "Don't you know me?"
	line "I'm the MOVE"
    cont "REMINDER!"

    para "I can teach your"
    line "#MON a move it"

    para "has learned pre-"
    line "viously."

	para "For the service,"
	line "I charge ¥500."
	cont "Deal?"
    done

_MoveReminderWhichMon::
    text "Show me the"
	line "#MON!"
    done

_MoveReminderWhichMove::
    text "Which move should"
    next "it relearn?"
    done

_MoveReminderCancel::
    text "Come back anytime."
    done

_MoveReminderEgg::
    text "What am I"
    line "supposed to do"
    cont "with an EGG?"
    done

_MoveReminderNoPay::
    text "Hm. You don't"
	line "have enough."
    
	para "Next time you come"
	line "remember to bring"
	cont "in some money."
    done

_MoveReminderNoMon::
    text "You don't have a"
    line "#MON that can"
    cont "remember a move."
    done

_MoveReminderNoMoves::
    text "There are no moves"
    line "for this #MON"
    cont "to remember."
    done

_MoveReminderTakeMoney::
    text "Pleasure doing"
	line "business with you!"
	done

_MoveReminderThanks::
    text "I won't forget it!"
    done