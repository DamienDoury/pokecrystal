_OakText6::
if DEF(_FR_FR)
	text "Heu... C'est quoi"
	line "ton nom?"
	prompt
else
	text "Now, what did you"
	line "say your name was?"
	prompt
endc

_OakText7::
if DEF(_FR_FR)
	text "<PLAYER>, ta quête"
	line "est sur le point"
	cont "de commencer."
	
	para "Joies et périls"
	line "paveront ta"
	cont "route..."
	
	para "Un monde de rêve,"
	line "de dangers et de"
	
	para "#MON t'attend!"
	line "En avant!"
	
	para "..."
	line "A plus tard."
	done
else
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
endc

_ClockTimeMayBeWrongText::
if DEF(_FR_FR)
	text "L'horloge est"
	line "peut-être fausse."
	
	para "Régler l'heure"
	line "s.v.p."
	prompt
else
	text "The clock's time"
	line "may be wrong."
	
	para "Please reset the"
	line "time."
	prompt
endc

_ClockSetWithControlPadText::
if DEF(_FR_FR)
	text "Régler avec la"
	line "manette."
	
	para "Choix:   Bouton A"
	line "Retour:  Bouton B"
	done
else
	text "Set with the"
	line "Control Pad."
	
	para "Confirm: A Button"
	line "Cancel:  B Button"
	done
endc

_ClockIsThisOKText::
if DEF(_FR_FR)
	text "Est-ce correct?"
	done
else
	text "Is this OK?"
	done
endc

_ClockHasResetText::
if DEF(_FR_FR)
	text "L'horloge a été"
	line "réinitialisée."
	done
else
	text "The clock has been"
	line "reset."
	done
endc

_LinkTimeoutText::
if DEF(_FR_FR)
	text "Trop de temps"
	line "s'est écoulé."
	cont "Essayer à nouveau."
	prompt
else
	text "Too much time has"
	line "elapsed. Please"
	cont "try again."
	prompt
endc

_LinkTradeCantBattleText::
if DEF(_FR_FR)
	text "Vous ne pourrez"
	line "pas combattre si"
	cont "vous échangez ce"
	cont "#MON."
	prompt
else
	text "If you trade that"
	line "#MON, you won't"
	cont "be able to battle."
	prompt
endc

_LinkAbnormalMonText::
if DEF(_FR_FR)
	text "Le @"
	text_ram wStringBuffer1
	text_start
	line "de votre ami(e) a"
	cont "l'air bizarre!"
	prompt
else
	text "Your friend's"
	line "@"
	text_ram wStringBuffer1
	text " appears"
	cont "to be abnormal!"
	prompt
endc

_LinkAskTradeForText::
if DEF(_FR_FR)
	text_ram wBufferTrademonNickname
	text_start
	line "contre @"
	text_ram wStringBuffer1
	text "?"
	done
else
	text "Trade @"
	text_ram wBufferTrademonNickname
	text_start
	line "for @"
	text_ram wStringBuffer1
	text "?"
	done
endc

_MobileBattleMustPickThreeMonText::
if DEF(_FR_FR)
	text_start
	done
else
	text "To enter a mobile"
	line "battle, you must"
	
	para "pick a team of"
	line "three #MON."
	
	para "Is that OK?"
	done
endc

_MobileBattleMoreInfoText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Need more info on"
	line "mobile battles?"
	done
endc

_MobileBattleRulesText::
if DEF(_FR_FR)
	text_start
	done
else
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
endc

_WouldYouLikeToMobileBattleText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Today's remaining"
	line "time is @"
	text_decimal wStringBuffer2, 1, 2
	text " min."
	
	para "Would you like to"
	line "battle?"
	done
endc

_WantAQuickMobileBattleText::
if DEF(_FR_FR)
	text_start
	done
else
	text "There are only @"
	text_decimal wStringBuffer2, 1, 2
	text_start
	line "min. left today."
	
	para "Want a quick"
	line "battle?"
	done
endc

_WantToRushThroughAMobileBattleText::
if DEF(_FR_FR)
	text_start
	done
else
	text "There is only"
	line "1 min. left today!"
	
	para "Want to rush"
	line "through a battle?"
	done
endc

_PleaseTryAgainTomorrowText::
if DEF(_FR_FR)
	text_start
	done
else
	text "There is less than"
	line "1 min. left today!"
	
	para "Please try again"
	line "tomorrow."
	done
endc

_TryAgainUsingSameSettingsText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Try again using"
	line "the same settings?"
	done
endc

_MobileBattleLessThanOneMinuteLeftText::
if DEF(_FR_FR)
	text_start
	done
else
	text "There is less than"
	line "1 min. left today!"
	done
endc

_MobileBattleNoTimeLeftForLinkingText::
if DEF(_FR_FR)
	text_start
	done
else
	text "No time left for"
	line "linking today."
	done
endc

_PickThreeMonForMobileBattleText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Pick three #MON"
	line "for battle."
	done
endc

_MobileBattleRemainingTimeText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Today's remaining"
	line "time is @"
	text_decimal wStringBuffer2, 1, 2
	text " min."
	done
endc

_WouldYouLikeToSaveTheGameText::
if DEF(_FR_FR)
	text "Voulez-vous sauve-"
	line "garder la partie?"
	done
else
	text "Would you like to"
	line "save the game?"
	done
endc

_SavedTheGameText::
if DEF(_FR_FR)
	text "<PLAYER> sauve"
	line "la partie."
	done
else
	text "<PLAYER> saved"
	line "the game."
	done
endc

_AnotherSaveFileText::
if DEF(_FR_FR)
	text "Il y a une autre"
	line "sauvegarde. La"
	cont "remplacer?"
	done
else
	text "There is another"
	line "save file. Is it"
	cont "OK to overwrite?"
	done
endc

_SaveFileCorruptedText::
if DEF(_FR_FR)
	text "La sauvegarde"
	line "est corrompue!"
	prompt
else
	text "The save file is"
	line "corrupted!"
	prompt
endc

_ChangeBoxSaveText::
if DEF(_FR_FR)
	text "En changeant de"
	line "BOITE #MON,"
	cont "les données sont"
	cont "sauvegardées. OK?"
	done
else
	text "When you change a"
	line "#MON BOX, data"
	cont "will be saved. OK?"
	done
endc

_MoveMonWOMailSaveText::
if DEF(_FR_FR)
	text "A chaque déplace-"
	line "ment de #MON,"
	cont "les données sont"
	cont "sauvegardées. OK?"
	done
else
	text "Each time you move"
	line "a #MON, data"
	cont "will be saved. OK?"
	done
endc

_WindowPoppingErrorText::
if DEF(_FR_FR)
	text "Pas de fenêtre"
	line "pour apparition."
	done
else
	text "No windows avail-"
	line "able for popping."
	done
endc

_ObjectEventText::
if DEF(_FR_FR)
	text "Cas objet."
	done
else
	text "Object event"
	done
endc

_ReceivedItemText::
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

_ReceivedMultipleItemText::
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "@"
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer4
	text "."
	done
else
	text "<PLAYER> received"
	line "@"
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer4
	text "."
	done
endc

_PutItemInPocketText::
if DEF(_FR_FR)
	text "<PLAYER> met"
	line "@"
	text_ram wStringBuffer1
	text " dans"
	cont "@"
	text_ram wStringBuffer3
	text "."
	prompt
else
	text "<PLAYER> put the"
	line "@"
	text_ram wStringBuffer1
	text " in"
	cont "the @"
	text_ram wStringBuffer3
	text "."
	prompt
endc

_PocketIsFullText::
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text ":"
	line "complet!"
	prompt
else
	text "The @"
	text_ram wStringBuffer3
	text_start
	line "is full…"
	prompt
endc

_SeerSeeAllText::
if DEF(_FR_FR)
	text "Je sais tout."
	line "Je vois tout."
	
	para "Je sais tout de"
	line "tes #MON!"
	done
else
	text "I see all."
	line "I know all…"
	
	para "Certainly, I know"
	line "of your #MON!"
	done
endc

_SeerCantTellAThingText::
if DEF(_FR_FR)
	text "Hein? Je n'arrive"
	line "pas à voir!"
	
	para "Comment ça se fait"
	line "tout ça?"
	done
else
	text "Whaaaat? I can't"
	line "tell a thing!"
	
	para "How could I not"
	line "know of this?"
	done
endc

_SeerNameLocationText::
if DEF(_FR_FR)
	text "Hmm... Tu as vu"
	line "@"
	text_ram wSeerNickname
	text " ici:"
	cont "@"
	text_ram wSeerCaughtLocation
	text "!"
	prompt
else
	text "Hm… I see you met"
	line "@"
	text_ram wSeerNickname
	text " here:"
	cont "@"
	text_ram wSeerCaughtLocation
	text "!"
	prompt
endc

_SeerTimeLevelText::
if DEF(_FR_FR)
	text "Il était"
	line "@"
	text_ram wSeerTimeOfDay
	text "!"
	
	para "Son niveau: @"
	text_ram wSeerCaughtLevelString
	text "!"
	
	para "Magie!"
	prompt
else
	text "The time was"
	line "@"
	text_ram wSeerTimeOfDay
	text "!"
	
	para "Its level was @"
	text_ram wSeerCaughtLevelString
	text "!"
	
	para "Am I good or what?"
	prompt
endc

_SeerTradeText::
if DEF(_FR_FR)
	text "Hmm... @"
	text_ram wSeerNickname
	text_start
	line "vient de @"
	text_ram wSeerOT
	text_start
	cont "et d'un échange?"
	
	para "A @"
	text_ram wSeerCaughtLocation
	text ","
	line "@"
	text_ram wSeerOT
	text_start
	cont "a vu @"
	text_ram wSeerNickname
	text "!"
	prompt
else
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
endc

_SeerNoLocationText::
if DEF(_FR_FR)
	text "Quoi!? Incroyable!"
	
	para "Je comprends pas"
	line "trop pourquoi mais"
	
	para "c'est incroyable!"
	line "Tu as quelque"
	cont "chose de spécial."
	
	para "Je ne sais pas où"
	line "tu l'as vu mais"
	cont "c'était au niveau"
	cont "@"
	text_ram wSeerCaughtLevelString
	text "."
	
	para "Pas mal, non?"
	prompt
else
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
endc

_SeerEggText::
if DEF(_FR_FR)
	text "Hé!"
	
	para "C'est un OEUF!"
	
	para "On ne peut encore"
	line "rien dire dessus."
	done
else
	text "Hey!"
	
	para "That's an EGG!"
	
	para "You can't say that"
	line "you've met it yet…"
	done
endc

_SeerDoNothingText::
if DEF(_FR_FR)
	text "Pfff! Je savais"
	line "que t'allais dire"
	cont "ça!"
	done
else
	text "Fufufu! I saw that"
	line "you'd do nothing!"
	done
endc

_SeerMoreCareText::
if DEF(_FR_FR)
	text "Dis donc..."
	
	para "Il serait sage de"
	line "prendre plus soin"
	cont "de tes #MON."
	done
else
	text "Incidentally…"
	
	para "It would be wise"
	line "to raise your"
	
	para "#MON with a"
	line "little more care."
	done
endc

_SeerMoreConfidentText::
if DEF(_FR_FR)
	text "Dis donc..."
	
	para "Il a l'air d'avoir"
	line "grandi."
	
	para "@"
	text_ram wSeerNickname
	text_start
	line "semble avoir"
	cont "confiance en lui."
	done
else
	text "Incidentally…"
	
	para "It seems to have"
	line "grown a little."
	
	para "@"
	text_ram wSeerNickname
	text " seems"
	line "to be becoming"
	cont "more confident."
	done
endc

_SeerMuchStrengthText::
if DEF(_FR_FR)
	text "Dis donc..."
	
	para "@"
	text_ram wSeerNickname
	text_start
	line "semble être"
	cont "plus fort."
	done
else
	text "Incidentally…"
	
	para "@"
	text_ram wSeerNickname
	text " has"
	line "grown. It's gained"
	cont "much strength."
	done
endc

_SeerMightyText::
if DEF(_FR_FR)
	text "Dis donc..."
	
	para "Il a l'air d'avoir"
	line "pris du muscle."
	
	para "@"
	text_ram wSeerNickname
	text_start
	line "semble avoir"
	cont "confiance en lui."
	cont "Il a dû gagner"
	cont "plein de combats!"
	done
else
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
endc

_SeerImpressedText::
if DEF(_FR_FR)
	text "Dis donc..."
	
	para "Tes efforts"
	line "m'impressionnent."
	
	para "Cela faisait long-"
	line "temps que je n'a-"
	
	para "vais pas vu un"
	line "#MON aussi fort"
	cont "que ce @"
	text_ram wSeerNickname
	text "."
	
	para "Le voir en combat"
	line "doit être plutôt"
	cont "impressionnant."
	done
else
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
endc

_CongratulationsYourPokemonText::
if DEF(_FR_FR)
	text "Félicitations!"
	line "Votre @"
	text_ram wStringBuffer2
	text_end
else
	text "Congratulations!"
	line "Your @"
	text_ram wStringBuffer2
	text_end
endc

_EvolvedIntoText::
if DEF(_FR_FR)
	text_start
	
	para "évolue en"
	line "@"
	text_ram wStringBuffer1
	text "!"
	done
else
	text_start
	
	para "evolved into"
	line "@"
	text_ram wStringBuffer1
	text "!"
	done
endc

_StoppedEvolvingText::
if DEF(_FR_FR)
	text "Hein? @"
	text_ram wStringBuffer2
	text_start
	line "n'évolue plus!"
	prompt
else
	text "Huh? @"
	text_ram wStringBuffer2
	text_start
	line "stopped evolving!"
	prompt
endc

_EvolvingText::
if DEF(_FR_FR)
	text "Quoi? @"
	text_ram wStringBuffer2
	text_start
	line "évolue!"
	done
else
	text "What? @"
	text_ram wStringBuffer2
	text_start
	line "is evolving!"
	done
endc

_MartHowManyText::
if DEF(_FR_FR)
	text "Combien?"
	done
else
	text "How many?"
	done
endc

AlreadyHaveTMText::
if DEF(_FR_FR)
	text "Vous possédez déjà"
	line "cette CT."
	done
else
	text "You already own"
	line "that TM."
	done
endc

_MartFinalPriceText::
if DEF(_FR_FR)
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer2
	text_start
	line "pour @"
	text_decimal hMoneyTemp, 3, 6
	text "¥."
	done
else
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer2
	text "(S)"
	line "will be ¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."
	done
endc

_HerbShopLadyIntroText::
if DEF(_FR_FR)
	text "Bonjour toi."
	
	para "Je vends des"
	line "herbes médicinales"
	cont "à bon marché."
	
	para "C'est bien bon"
	line "mais un peu amer."
	
	para "Ton #MON ne va"
	line "peut-être pas"
	cont "aimer."
	
	para "Héhéhéhéhé..."
	done
else
	text "Hello, dear."
	
	para "I sell inexpensive"
	line "herbal medicine."
	
	para "They're good, but"
	line "a trifle bitter."
	
	para "Your #MON may"
	line "not like them."
	
	para "Hehehehe…"
	done
endc

_HerbalLadyThanksText::
if DEF(_FR_FR)
	text "Merci."
	line "Héhéhéhéhé..."
	done
else
	text "Thank you, dear."
	line "Hehehehe…"
	done
endc

_HerbalLadyPackFullText::
if DEF(_FR_FR)
	text "Ton SAC est"
	line "plein."
	done
else
	text "Oh? Your PACK is"
	line "full, dear."
	done
endc

_HerbalLadyNoMoneyText::
if DEF(_FR_FR)
	text "Pas assez de sous!"
	line "Héhéhéhéhéhé!"
	done
else
	text "Hehehe… You don't"
	line "have the money."
	done
endc

_HerbalLadyComeAgainText::
if DEF(_FR_FR)
	text "A bientôt!"
	line "Héhéhéhéhéhé..."
	done
else
	text "Come again, dear."
	line "Hehehehe…"
	done
endc

_StoneShopIntroText::
if DEF(_FR_FR)
	text "La lithothérapie"
	line "est une pratique"
	cont "ancestrale."

	para "Il existe une"
	line "pierre pour"
	cont "chaque besoin."
	done
else
	text "Stone healing is"
	line "an ancestral"
	cont "practice."

	para "There is a stone"
	line "for every need."
	done
endc

_StoneShopThanksText::
if DEF(_FR_FR)
	text "Excellent choix."
	line "Tu ne le"
	cont "regretteras pas."
	done
else
	text "Great choice. You"
	line "won't regret it."
	done
endc

_StoneShopNoMoneyText::
if DEF(_FR_FR)
	text "Mes pierres haut"
	line "de gamme coûtent"
	cont "trop cher pour"
	cont "toi..."
	done
else
	text "My premium stones"
	line "come at a price"
	cont "you can't afford…"
	done
endc

_StoneShopComeAgainText::
if DEF(_FR_FR)
	text "Puissent les"
	line "pierres t'apporter"
	cont "la paix."
	done
else
	text "May you find peace"
	line "in the stones."
	done
endc

_JadeCrystalSellPitchText::
if DEF(_FR_FR)
	text "Ceci est mon"
	line "produit phare."

	para "Il n'y a rien qu'une"
	line "pierre ne puisse"
	cont "guérir."

	para "Et le COVID ne"
	line "fait pas"
	cont "exception."

	para "En portant cette"
	line "pierre, un #MON"
	cont "ne pourra pas"
	cont "tomber malade."
	done
else
	text "My best seller."

	para "There is nothing a"
	line "stone can't heal."

	para "And COVID is no"
	line "exception."

	para "Have your #MON"
	line "hold it, and it"
	cont "won't get sick."
	done
endc

_StarPieceSellPitchText::
if DEF(_FR_FR)
	text "Quel est l'effet"
	line "de celle-ci, te"
	cont "demandes-tu?"

	para "Celle-ci apporte"
	line "la joie."
	done
else
	text "What is the effect"
	line "of this one you"
	cont "may ask?"

	para "This one"
	line "sparks joy."
	done
endc

_EverstoneSellPitchText::
if DEF(_FR_FR)
	text "ROC STASE est la"
	line "contraction de"
	cont "EVOLUROC et"
	cont "PIERRE STASE."

	para "Cette pierre"
	line "combine les"
	cont "propriétés des"
	cont "deux autres."

	para "Donne-la à un"
	line "#MON qui peut"
	cont "encore évoluer."

	para "Elle augmentera la"
	line "DEF et la DEF.SPE."
	cont "de 50<PERCENT> et bloquera"
	cont "aussi l'évolution."
	done
else
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
endc

_LastEverstoneText::
if DEF(_FR_FR)
	text "Quelle chance!"
	line "Tu as acheté mon"
	cont "tout dernier"
	cont "ROC STASE!"
	done
else
	text "Lucky you!"
	line "You bought my very"
	cont "last EVIOSTONE!"
	done
endc	

_BargainShopIntroText::
if DEF(_FR_FR)
	text "Salut! Tu cherches"
	line "une bonne affaire?"
	
	para "Je vends des ob-"
	line "jets super rares!"
	
	para "Et un de chaque"
	line "type..."
	done
else
	text "Hiya! Care to see"
	line "some bargains?"
	
	para "I sell rare items"
	line "that nobody else"
	
	para "carries--but only"
	line "one of each item."
	done
endc

_BargainShopFinalPriceText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " coûte"
	line "@"
	text_decimal hMoneyTemp, 3, 6
	text "¥. Tu veux?"
	done
else
	text_ram wStringBuffer2
	text " costs"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text ". Want it?"
	done
endc

_BargainShopThanksText::
if DEF(_FR_FR)
	text "Merci."
	done
else
	text "Thanks."
	done
endc

_BargainShopPackFullText::
if DEF(_FR_FR)
	text "Oh! Ton SAC"
	line "est super plein."
	done
else
	text "Uh-oh, your PACK"
	line "is chock-full."
	done
endc

_BargainShopSoldOutText::
if DEF(_FR_FR)
	text "Tu as déjà acheté"
	line "ça. J'en ai"
	cont "plus du tout."
	done
else
	text "You bought that"
	line "already. I'm all"
	cont "sold out of it."
	done
endc

_BargainShopNoFundsText::
if DEF(_FR_FR)
	text "Oh! T'as super"
	line "pas de sous."
	done
else
	text "Uh-oh, you're"
	line "short on funds."
	done
endc

_BargainShopComeAgainText::
if DEF(_FR_FR)
	text "Reviens plus"
	line "tard."
	done
else
	text "Come by again"
	line "sometime."
	done
endc

_PharmacyIntroText::
if DEF(_FR_FR)
	text "Oui? Besoin d'un"
	line "médicament?"
	done
else
	text "What's up? Need"
	line "some medicine?"
	done
endc

_PharmacyFinalPriceText::
if DEF(_FR_FR)
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer2
	text_start
	line "ça fait @"
	text_decimal hMoneyTemp, 3, 6
	text "¥."
	done
else
	text_decimal wItemQuantityChange, 1, 2
	text " @"
	text_ram wStringBuffer2
	text "(S)"
	line "will cost ¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."
	done
endc

_PharmacyThanksText::
if DEF(_FR_FR)
	text "Merci, merci!"
	done
else
	text "Thanks much!"
	done
endc

_PharmacyPackFullText::
if DEF(_FR_FR)
	text "Tu n'as plus de"
	line "place."
	done
else
	text "You don't have any"
	line "more space."
	done
endc

_PharmacyNoMoneyText::
if DEF(_FR_FR)
	text "Hein? C'est pas"
	line "assez."
	done
else
	text "Huh? That's not"
	line "enough money."
	done
endc

_PharmacyComeAgainText::
if DEF(_FR_FR)
	text "Très bien. A la"
	line "prochaine."
	done
else
	text "All right."
	line "See you around."
	done
endc

_MartSellPriceText::
if DEF(_FR_FR)
	text "J'peux t'en donner"
	line "@"
	text_decimal hMoneyTemp, 3, 6
	text "¥."
	
	para "Ca te va?"
	done
else
	text "I can pay you"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."
	
	para "Is that OK?"
	done
endc

_MartWelcomeText::
if DEF(_FR_FR)
	text "Bienvenue! En quoi"
	line "puis-je t'aider?"
	done
else
	text "Welcome! How may I"
	line "help you?"
	done
endc

_ShortageExplanationText::
if DEF(_FR_FR)
	text "Bonjour la"
	line "clientèle!"

	para "Comme tu peux le"
	line "remarquer à mes"
	cont "rayons vides, il"
	cont "y a une grave"
	cont "pénurie."

	para "L'afflux brutal"
	line "de clients,"

	para "la fermeture"
	line "des frontières,"

	para "et la réduction"
	line "de la main-d'oeuvre"
	cont "ont mené à cela."

	para "Mon stock est"
	line "limité, et les"
	cont "prix ont augmenté."

	para "Si tu ne trouves"
	line "pas ton bonheur"
	cont "ici, tu peux essa-"

	para "yer dans une autre"
	line "BOUTIQUE #MON"

	para "ou revenir demain,"
	line "car j'aurai peut-"
	
	para "être reçu une nou-"
	line "velle livraison."

	para "Voyons si j'ai"
	line "ce qu'il te faut."
	done
else
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
endc	

_MartDoMyBest1Text::
if DEF(_FR_FR)
	text "Je t'aiderai autant"
	line "que possible."
	done
else
	text "I'll help you as"
	line "much as I can."
	done
endc

_MartDoMyBest2Text::
if DEF(_FR_FR)
	text "Espérons que j'ai"
	line "ce qu'il te faut."
	done
else
	text "Let's hope I have"
	line "what you need."
	done
endc

_MartDoMyBest3Text::
if DEF(_FR_FR)
	text "Je ferai au mieux"
	line "pour te servir."
	done
else
	text "I'll do my best"
	line "to serve you."
	done
endc

_MartDoMyBest4Text::
if DEF(_FR_FR)
	text "Bienvenue dans mon"
	line "magasin dévalisé!"
	done
else
	text "Welcome to my"
	line "almost-empty shop!"
	done
endc		

_MartThanksText::
if DEF(_FR_FR)
	text "Et voilà."
	line "Merci!"
	done
else
	text "Here you are."
	line "Thank you!"
	done
endc

_MartNoMoneyText::
if DEF(_FR_FR)
	text "Tu n'as pas assez"
	line "d'argent."
	done
else
	text "You don't have"
	line "enough money."
	done
endc

_MartPackFullText::
if DEF(_FR_FR)
	text "Tu ne peux plus"
	line "rien porter."
	done
else
	text "You can't carry"
	line "any more items."
	done
endc

_MartShortageText::
if DEF(_FR_FR)
	text "Je n'en ai pas"
	line "autant en stock."
	prompt
else
	text "I don't have this"
	line "many articles."
	prompt
endc

_MartCantBuyText::
if DEF(_FR_FR)
	text "Je ne peux pas"
	line "t'acheter ça."
	prompt
else
	text "Sorry, I can't buy"
	line "that from you."
	prompt
endc

_MartComeAgainText::
if DEF(_FR_FR)
	text "A la prochaine!"
	done
else
	text "Please come again!"
	done
endc

_MartComeAnotherDayText::
if DEF(_FR_FR)
	text "Je réassors chaque"
	line "jour, repasse!"
	done
else
	text "I restock every-"
	line "day, come again!"
	done
endc

_MartAskMoreText::
if DEF(_FR_FR)
	text "As-tu besoin"
	line "d'autre chose?"
	done
else
	text "Can I do anything"
	line "else for you?"
	done
endc

_MartAllIHaveLeftText::
if DEF(_FR_FR)
	text "Avec la pénurie,"
	line "j'ai plus que ça."
	done
else
	text "It's all I got left"
	line "with the shortage."
	done
endc

_MartLastItemText::
if DEF(_FR_FR)
	text "C'était le dernier"
	line "de mes articles."
	done
else
	text "This was the last"
	line "of my items."
	done
endc

_MartEmptyStock1Text::
if DEF(_FR_FR)
	text "Plus rien d'autre à"
	line "vendre aujourd'hui."
	prompt
else
	text "I got nothing else"
	line "to sell today."
	prompt
endc

_MartEmptyStock2Text::
if DEF(_FR_FR)
	text "Mon stock est"
	line "vide."
	prompt
else
	text "My stock is empty."
	prompt
endc

_MartEmptyStock3Text::
if DEF(_FR_FR)
	text "Tu as acheté tout"
	line "ce que j'avais!"
	prompt
else
	text "You bought every-"
	line "thing I had!"
	prompt
endc

_MartEmptyStock4Text::
if DEF(_FR_FR)
	text "Nouvel arrivage"
	line "prévu demain."
	prompt
else
	text "Come back tomorrow"
	line "after I restock."
	prompt
endc	

_MartBoughtText::
if DEF(_FR_FR)
	text "Reçu: @"
	text_decimal hMoneyTemp, 3, 6
	text "¥"
	line "pour @"
	text_ram wStringBuffer2
	text "."
	done
else
	text "Got ¥@"
	text_decimal hMoneyTemp, 3, 6
	text " for"
	line "@"
	text_ram wStringBuffer2
	text "(S)."
	done
endc

_SlotsBetHowManyCoinsText::
if DEF(_FR_FR)
	text "Combien"
	line "de jetons?"
	done
else
	text "Bet how many"
	line "coins?"
	done
endc

_SlotsStartText::
if DEF(_FR_FR)
	text "GO!"
	done
else
	text "Start!"
	done
endc

_SlotsNotEnoughCoinsText::
if DEF(_FR_FR)
	text "Pas assez de"
	line "jetons."
	prompt
else
	text "Not enough"
	line "coins."
	prompt
endc

_SlotsRanOutOfCoinsText::
if DEF(_FR_FR)
	text "Zut... plus de"
	line "jetons..."
	done
else
	text "Darn… Ran out of"
	line "coins…"
	done
endc

_SlotsPlayAgainText::
if DEF(_FR_FR)
	text "Jouer encore?"
	done
else
	text "Play again?"
	done
endc

_SlotsLinedUpText::
if DEF(_FR_FR)
	text "en ligne!"
	line "@"
	text_ram wStringBuffer2
	text " jetons!"
	done
else
	text "lined up!"
	line "Won @"
	text_ram wStringBuffer2
	text " coins!"
	done
endc

_SlotsDarnText::
if DEF(_FR_FR)
	text "Et zut!"
	done
else
	text "Darn!"
	done
endc

_MobileStadiumEntryText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Data for use in"
	line "the MOBILE STADIUM"
	
	para "of the N64 #MON"
	line "STADIUM 2 can be"
	cont "read here."
	
	para "Read the data?"
	done
endc

_MobileStadiumSuccessText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Data transfer is"
	line "complete."
	
	para "We hope you enjoy"
	line "MOBILE STADIUM"
	
	para "battles in the N64"
	line "#MON STADIUM 2."
	
	para ""
	done
endc

_DeleteSavedLoginPasswordText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Delete the saved"
	line "LOG-IN PASSWORD?"
	done
endc

_DeletedTheLoginPasswordText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Deleted the LOG-IN"
	line "PASSWORD."
	done
endc

_MobilePickThreeMonForBattleText::
if DEF(_FR_FR)
	text_start
	prompt
else
	text "Pick three #MON"
	line "for battle."
	prompt
endc

_MobileUseTheseThreeMonText::
if DEF(_FR_FR)
	text_start
	done
else
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
endc

_MobileOnlyThreeMonMayEnterText::
if DEF(_FR_FR)
	text_start
	prompt
else
	text "Only three #MON"
	line "may enter."
	prompt
endc

_MobileCardFolderIntro1Text::
if DEF(_FR_FR)
	text_start
	done
else
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
endc

_MobileCardFolderIntro2Text::
if DEF(_FR_FR)
	text_start
	done
else
	text "This is your CARD."
	
	para "Once you've"
	line "entered your phone"
	
	para "number, you can"
	line "trade CARDS with"
	cont "your friends."
	
	para ""
	done
endc

_MobileCardFolderIntro3Text::
if DEF(_FR_FR)
	text_start
	done
else
	text "If you have your"
	line "friend's CARD, you"
	
	para "can use it to make"
	line "a call from a"
	
	para "mobile phone on"
	line "the 2nd floor of a"
	cont "#MON CENTER."
	
	para ""
	done
endc

_MobileCardFolderIntro4Text::
if DEF(_FR_FR)
	text_start
	done
else
	text "To safely store"
	line "your collection of"
	
	para "CARDS, you must"
	line "set a PASSCODE for"
	cont "your CARD FOLDER."
	
	para ""
	done
endc

_MobileCardFolderAskDeleteText::
if DEF(_FR_FR)
	text_start
	done
else
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
endc

_MobileCardFolderDeleteAreYouSureText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Are you sure you"
	line "want to delete it?"
	done
endc

_MobileCardFolderDeletedText::
if DEF(_FR_FR)
	text_start
	done
else
	text "The CARD FOLDER"
	line "has been deleted."
	
	para ""
	done
endc

_MobileCardFolderAskOpenOldText::
if DEF(_FR_FR)
	text_start
	done
else
	text "There is an older"
	line "CARD FOLDER from a"
	cont "previous journey."
	
	para "Do you want to"
	line "open it?"
	done
endc

_MobileCardFolderAskDeleteOldText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Delete the old"
	line "CARD FOLDER?"
	done
endc

_MobileCardFolderFinishRegisteringCardsText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Finish registering"
	line "CARDS?"
	done
endc

_PhoneWrongNumberText::
if DEF(_FR_FR)
	text "Hein? Pardon!"
	line "Mauvais numéro!"
	done
else
	text "Huh? Sorry, wrong"
	line "number!"
	done
endc

_PhoneClickText::
if DEF(_FR_FR)
	text "Clic!"
	done
else
	text "Click!"
	done
endc

_PhoneEllipseText::
	text "<……>"
	done

_PhoneOutOfAreaText::
if DEF(_FR_FR)
	text "Ce numéro est hors"
	line "de la zone."
	done
else
	text "That number is out"
	line "of the area."
	done
endc

_PhoneJustTalkToThemText::
if DEF(_FR_FR)
	text "Va parler à cette"
	line "personne!"
	done
else
	text "Just go talk to"
	line "that person!"
	done
endc

_PhoneThankYouText::
if DEF(_FR_FR)
	text "Merci!"
	done
else
	text "Thank you!"
	done
endc

_PasswordAskResetText::
if DEF(_FR_FR)
	text "Mot de passe OK."
	line "Choisir CONTINUER"
	cont "& réinitialiser"
	cont "les paramètres."
	prompt
else
	text "Password OK."
	line "Select CONTINUE &"
	cont "reset settings."
	prompt
endc

_PasswordWrongText::
if DEF(_FR_FR)
	text "Mauvais mot de"
	line "passe!"
	prompt
else
	text "Wrong password!"
	prompt
endc

_PasswordAskResetClockText::
if DEF(_FR_FR)
	text "Réinitialiser"
	line "l'horloge?"
	done
else
	text "Reset the clock?"
	done
endc

_PasswordAskEnterText::
if DEF(_FR_FR)
	text "Entrer le mot de"
	line "passe."
	done
else
	text "Please enter the"
	line "password."
	done
endc

_ClearAllSaveDataText::
if DEF(_FR_FR)
	text "Effacer zone de"
	line "sauvegarde?"
	done
else
	text "Clear all save"
	line "data?"
	done
endc

_LearnedMoveText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text " apprend"
	line "@"
	text_ram wStringBuffer2
	text "!@"
	sound_dex_fanfare_50_79
	text_promptbutton
	text_end
else
	text_ram wMonOrItemNameBuffer
	text " learned"
	line "@"
	text_ram wStringBuffer2
	text "!@"
	sound_dex_fanfare_50_79
	text_promptbutton
	text_end
endc

_MoveAskForgetText::
if DEF(_FR_FR)
	text "Oublier quelle"
	next "capacité?"
	done
else
	text "Which move should"
	next "be forgotten?"
	done
endc

_StopLearningMoveText::
if DEF(_FR_FR)
	text "Arrêter d'appren-"
	line "dre @"
	text_ram wStringBuffer2
	text "?"
	done
else
	text "Stop learning"
	line "@"
	text_ram wStringBuffer2
	text "?"
	done
endc

_DidNotLearnMoveText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text_start
	line "n'a pas appris"
	cont "@"
	text_ram wStringBuffer2
	text "."
	prompt
else
	text_ram wMonOrItemNameBuffer
	text_start
	line "did not learn"
	cont "@"
	text_ram wStringBuffer2
	text "."
	prompt
endc

_AskForgetMoveText::
if DEF(_FR_FR)
	text "Effacer une"
	line "ancienne capacité"
	cont "pour @"
	text_ram wStringBuffer2
	text "?"
	done
else
	text "Delete an older"
	line "move to make room"
	cont "for @"
	text_ram wStringBuffer2
	text "?"
	done
endc

_AskForgetMoveLongText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text " veut"
	line "apprendre"
	cont "@"
	text_ram wStringBuffer2
	text "."

	para "Effacer une"
	line "ancienne capacité?"
	done
else
	text_ram wMonOrItemNameBuffer
	text " is"
	line "trying to learn"
	cont "@"
	text_ram wStringBuffer2
	text "."

	para "Delete a move to"
	line "make room for it?"
	done
endc	

Text_MoveForgetCount::
if DEF(_FR_FR)
	text "1, 2 et...@"
	text_pause
	text_end
else
	text "1, 2 and…@"
	text_pause
	text_end
endc

_MoveForgotText::
if DEF(_FR_FR)
	text "Tadaa!@"
	text_pause
	text_start
	
	para "@"
	text_ram wMonOrItemNameBuffer
	text " oublie"
	line "@"
	text_ram wStringBuffer1
	text "."
	
	para "Et..."
	prompt
else
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
endc

_MoveCantForgetHMText::
if DEF(_FR_FR)
	text "Les capacités des"
	line "CS ne peuvent être"
	cont "oubliées."
	prompt
else
	text "HM moves can't be"
	line "forgotten now."
	prompt
endc

_CardFlipPlayWithThreeCoinsText::
if DEF(_FR_FR)
	text "Jouer avec 3"
	line "jetons?"
	done
else
	text "Play with three"
	line "coins?"
	done
endc

_CardFlipNotEnoughCoinsText::
if DEF(_FR_FR)
	text "Pas assez de"
	line "jetons."
	prompt
else
	text "Not enough coins…"
	prompt
endc

_CardFlipChooseACardText::
if DEF(_FR_FR)
	text "Choisir une carte."
	done
else
	text "Choose a card."
	done
endc

_CardFlipPlaceYourBetText::
if DEF(_FR_FR)
	text "Parier..."
	done
else
	text "Place your bet."
	done
endc

_CardFlipPlayAgainText::
if DEF(_FR_FR)
	text "Jouer à nouveau?"
	done
else
	text "Want to play"
	line "again?"
	done
endc

_CardFlipShuffledText::
if DEF(_FR_FR)
	text "Les cartes ont été"
	line "mélangées."
	prompt
else
	text "The cards have"
	line "been shuffled."
	prompt
endc

_CardFlipYeahText::
if DEF(_FR_FR)
	text "Ouais!"
	done
else
	text "Yeah!"
	done
endc

_CardFlipDarnText::
if DEF(_FR_FR)
	text "Zut..."
	done
else
	text "Darn…"
	done
endc

_GearEllipseText::
	text "<……>"
	done

_GearOutOfServiceText::
if DEF(_FR_FR)
	text "Vous êtes en"
	line "dehors du réseau."
	prompt
else
	text "You're out of the"
	line "service area."
	prompt
endc

_PokegearAskWhoCallText::
if DEF(_FR_FR)
	text "Qui voulez-vous"
	line "appeler?"
	done
else
	text "Whom do you want"
	line "to call?"
	done
endc

_PokegearPressButtonText::
if DEF(_FR_FR)
	text "Presser un bouton"
	line "pour sortir."
	done
else
	text "Press any button"
	line "to exit."
	done
endc

_PokegearAskDeleteText::
if DEF(_FR_FR)
	text "Effacer ce numéro"
	line "enregistré?"
	done
else
	text "Delete this stored"
	line "phone number?"
	done
endc

_BuenaAskWhichPrizeText::
if DEF(_FR_FR)
	text "Quel prix?"
	done
else
	text "Which prize would"
	line "you like?"
	done
endc

_BuenaIsThatRightText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text "?"
	line "C'est ça?"
	done
else
	text_ram wStringBuffer1
	text "?"
	line "Is that right?"
	done
endc

_BuenaHereYouGoText::
if DEF(_FR_FR)
	text "Voilà!"
	prompt
else
	text "Here you go!"
	
	para ""
	done
endc

_BuenaNotEnoughPointsText::
if DEF(_FR_FR)
	text "Vous n'avez pas"
	line "assez de points."
	prompt
else
	text "You don't have"
	line "enough points."
	
	para ""
	done
endc

_BuenaNoRoomText::
if DEF(_FR_FR)
	text "Vous n'avez pas"
	line "de place."
	prompt
else
	text "You have no room"
	line "for it."
	
	para ""
	done
endc

_BuenaComeAgainText::
if DEF(_FR_FR)
	text "Oh. Revenez"
	line "plus tard!"
	done
else
	text "Oh. Please come"
	line "back again!"
	done
endc

_BTExcuseMeText::
if DEF(_FR_FR)
	text "Excusez-moi!"
	prompt
else
	text "Excuse me!"
	
	para ""
	done
endc

_ExcuseMeYoureNotReadyText::
if DEF(_FR_FR)
	text "Pardon mais..."
	line "Vous n'êtes pas"
	cont "prêt(e)."
	
	para ""
	done
else
	text "Excuse me."
	line "You're not ready."
	
	para ""
	done
endc

_BattleTowerReturnWhenReadyText::
if DEF(_FR_FR)
	text "Revenez une fois"
	line "prêt(e)."
	done
else
	text "Please return when"
	line "you're ready."
	done
endc

_NeedAtLeastThreeMonText::
if DEF(_FR_FR)
	text "Il vous faut au"
	line "moins 3 #MON."
	prompt
else
	text "You need at least"
	line "three #MON."
	
	para ""
	done
endc

_EggDoesNotQualifyText::
if DEF(_FR_FR)
	text "Un OEUF ne peut"
	line "être inscrit."
	prompt
else
	text "Sorry, an EGG"
	line "doesn't qualify."
	
	para ""
	done
endc

_OnlyThreeMonMayBeEnteredText::
if DEF(_FR_FR)
	text "Seuls 3 #MON"
	line "peuvent être"
	cont "enregistrés."
	
	para ""
	done
else
	text "Only three #MON"
	line "may be entered."
	
	para ""
	done
endc

_TheMonMustAllBeDifferentKindsText::
if DEF(_FR_FR)
	text "Les @"
	text_ram wStringBuffer2
	text " #MON"
	line "doivent être de"
	cont "types différents."
	
	para ""
	done
else
	text "The @"
	text_ram wStringBuffer2
	text " #MON"
	line "must all be"
	cont "different kinds."
	
	para ""
	done
endc

_TheMonMustNotHoldTheSameItemsText::
if DEF(_FR_FR)
	text "Les @"
	text_ram wStringBuffer2
	text " #MON"
	line "ne doivent pas"
	cont "tenir les mêmes"
	cont "objets."
	
	para ""
	done
else
	text "The @"
	text_ram wStringBuffer2
	text " #MON"
	line "must not hold the"
	cont "same items."
	
	para ""
	done
endc

_YouCantTakeAnEggText::
if DEF(_FR_FR)
	text "On ne peut pas"
	line "prendre d'OEUF!"
	prompt
else
	text "You can't take an"
	line "EGG!"
	
	para ""
	done
endc

_BallDodgedText::
if DEF(_FR_FR)
	text "Il a évité la"
	line "BALL!"
	
	para "Ce #MON ne se"
	line "laisse pas faire!"
	prompt
else
	text "It dodged the"
	line "thrown BALL!"
	
	para "This #MON"
	line "can't be caught!"
	prompt
endc

_BallMissedText::
if DEF(_FR_FR)
	text "Vous manquez le"
	line "#MON!"
	prompt
else
	text "You missed the"
	line "#MON!"
	prompt
endc

_BallBrokeFreeText::
if DEF(_FR_FR)
	text "Oh non! Le #MON"
	line "s'est libéré!"
	prompt
else
	text "Oh no! The #MON"
	line "broke free!"
	prompt
endc

_BallAppearedCaughtText::
if DEF(_FR_FR)
	text "Raaah! Ca y était"
	line "presque!"
	prompt
else
	text "Aww! It appeared"
	line "to be caught!"
	prompt
endc

_BallAlmostHadItText::
if DEF(_FR_FR)
	text "Aaaaaah!"
	line "Presque!"
	prompt
else
	text "Aargh!"
	line "Almost had it!"
	prompt
endc

_BallSoCloseText::
if DEF(_FR_FR)
	text "Mince! Ca y était"
	line "presque!"
	prompt
else
	text "Shoot! It was so"
	line "close too!"
	prompt
endc

Text_BallCaught::
if DEF(_FR_FR)
	text "Et hop! @"
	text_ram wEnemyMonNickname
	text_start
	line "est attrapé!@"
	sound_caught_mon
	text_end
else
	text "Gotcha! @"
	text_ram wEnemyMonNickname
	text_start
	line "was caught!@"
	sound_caught_mon
	text_end
endc

_WaitButtonText::
	text_promptbutton
	text_end

_BallSentToPCText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text " est en-"
	line "voyé au PC de LEO."
	prompt
else
	text_ram wMonOrItemNameBuffer
	text " was"
	line "sent to BILL's PC."
	prompt
endc

_NewDexDataText::
if DEF(_FR_FR)
	text "Le profil de"
	line "@"
	text_ram wEnemyMonNickname
	text " est"
	cont "ajouté au #DEX.@"
	sound_slot_machine_start
	text_promptbutton
	text_end
else
	text_ram wEnemyMonNickname
	text "'s data"
	line "was newly added to"
	cont "the #DEX.@"
	sound_slot_machine_start
	text_promptbutton
	text_end
endc

_AskGiveNicknameText::
if DEF(_FR_FR)
	text "Donner un surnom à"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done
else
	text "Give a nickname to"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done
endc

_ItemStatRoseText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " de"
	line "@"
	text_ram wStringBuffer1
	text " monte."
	prompt
else
	text_ram wStringBuffer1
	text "'s"
	line "@"
	text_ram wStringBuffer2
	text " rose."
	prompt
endc

_ItemCantUseOnMonText::
if DEF(_FR_FR)
	text "Inutilisable sur"
	line "ce #MON."
	prompt
else
	text "That can't be used"
	line "on this #MON."
	prompt
endc

_RepelUsedEarlierIsStillInEffectText::
if DEF(_FR_FR)
	text "Le REPOUSSE utili-"
	line "sé auparavant est"
	cont "toujours effectif."
	prompt
else
	text "The REPEL used"
	line "earlier is still"
	cont "in effect."
	prompt
endc

_PlayedFluteText::
if DEF(_FR_FR)
	text "Vous jouez de la"
	line "#FLUTE."
	
	para "Ouais..."
	line "Super musique!"
	prompt
else
	text "Played the #"
	line "FLUTE."
	
	para "Now, that's a"
	line "catchy tune!"
	prompt
endc

_FluteWakeUpText::
if DEF(_FR_FR)
	text "Tous les #MON"
	line "endormis se"
	cont "réveillent."
	prompt
else
	text "All sleeping"
	line "#MON woke up."
	prompt
endc

Text_PlayedPokeFlute::
if DEF(_FR_FR)
	text "<PLAYER> joue de la"
	line "#FLUTE.@"
	text_promptbutton
	text_end
else
	text "<PLAYER> played the"
	line "# FLUTE.@"
	text_promptbutton
	text_end
endc

_BlueCardBalanceText::
if DEF(_FR_FR)
	text "Vous avez"
	line "@"
	text_decimal wBlueCardBalance, 1, 2
	text " points."
	done
else
	text "You now have"
	line "@"
	text_decimal wBlueCardBalance, 1, 2
	text " points."
	done
endc

_CoinCaseCountText::
if DEF(_FR_FR)
	text "Jetons:"
	line "@"
	text_decimal wCoins, 2, 4
	text_end
else
	text "Coins:"
	line "@"
	text_decimal wCoins, 2, 4
	text_end
endc

_RaiseThePPOfWhichMoveText::
if DEF(_FR_FR)
	text "Monter les PP de"
	line "quelle capacité?"
	done
else
	text "Raise the PP of"
	line "which move?"
	done
endc

_RestoreThePPOfWhichMoveText::
if DEF(_FR_FR)
	text "Restaurer PP de"
	line "quelle capacité?"
	done
else
	text "Restore the PP of"
	line "which move?"
	done
endc

_PPIsMaxedOutText::
if DEF(_FR_FR)
	text "PP de @"
	text_ram wStringBuffer2
	text_start
	line "au max."
	prompt
else
	text_ram wStringBuffer2
	text "'s PP"
	line "is maxed out."
	prompt
endc

_PPsIncreasedText::
if DEF(_FR_FR)
	text "PP de @"
	text_ram wStringBuffer2
	text_start
	line "augmentés."
	prompt
else
	text_ram wStringBuffer2
	text "'s PP"
	line "increased."
	prompt
endc

_PPRestoredText::
if DEF(_FR_FR)
	text "PP restaurés."
	prompt
else
	text "PP was restored."
	prompt
endc

_SentTrophyHomeText::
if DEF(_FR_FR)
	text "Il y a un trophée"
	line "à l'intérieur!@"
	sound_dex_fanfare_50_79
	text_start
	
	para "@"
	text_ram wPlayerName
	text " envoie"
	line "le trophée à la"
	cont "maison."
	prompt
else
	text "There was a trophy"
	line "inside!@"
	sound_dex_fanfare_50_79
	text_start
	
	para "@"
	text_ram wPlayerName
	text " sent the"
	line "trophy home."
	prompt
endc

_ItemLooksBitterText::
if DEF(_FR_FR)
	text "Ca a l'air amer..."
	prompt
else
	text "It looks bitter…"
	prompt
endc

_ItemCantUseOnEggText::
if DEF(_FR_FR)
	text "C'est inutilisable"
	line "sur un OEUF."
	prompt
else
	text "That can't be used"
	line "on an EGG."
	prompt
endc

_ItemWontHaveEffectText::
if DEF(_FR_FR)
	text "Ca n'a aucun"
	line "effet."
	prompt
else
	text "It won't have any"
	line "effect."
	prompt
endc

_BallBlockedText::
if DEF(_FR_FR)
	text "Le dresseur"
	line "détourne la BALL!"
	prompt
else
	text "The trainer"
	line "blocked the BALL!"
	prompt
endc

_BallDontBeAThiefText::
if DEF(_FR_FR)
	text "Voler c'est mal!"
	prompt
else
	text "Don't be a thief!"
	prompt
endc

_BallBoxFullText::
if DEF(_FR_FR)
	text "La BOITE #MON"
	line "est pleine. C'est"
	cont "inutilisable pour"
	cont "l'instant."
	prompt
else
	text "The #MON BOX"
	line "is full. That"
	cont "can't be used now."
	prompt
endc

_ItemUsedText::
if DEF(_FR_FR)
	text "<PLAYER> utilise:"
	line "@"
	text_ram wStringBuffer2
	text "."
	done
else
	text "<PLAYER> used the@"
	text_low
	text_ram wStringBuffer2
	text "."
	done
endc

_KnowsMoveText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " connaît"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
else
	text_ram wStringBuffer1
	text " knows"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
endc

_MoveKnowsOneText::
if DEF(_FR_FR)
	text "Ce #MON ne"
	line "connaît qu'une"
	cont "seule capacité."
	done
else
	text "That #MON knows"
	line "only one move."
	done
endc

_AskDeleteMoveText::
if DEF(_FR_FR)
	text "Lui faire oublier"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done
else
	text "Oh, make it forget"
	line "@"
	text_ram wStringBuffer1
	text "?"
	done
endc

_DeleterForgotMoveText::
if DEF(_FR_FR)
	text "Le #MON a ou-"
	line "blié la capacité!"
	done
else
	text "Done! Your #MON"
	line "forgot the move."
	done
endc

_DeleterPikachuRefuses::
if DEF(_FR_FR)
	text "Comment?"

	para "PIKACHU a refusé"
	line "d'oublier SURF."

	para "Il a sans doute"
	line "une bonne raison."
	done
else
	text "Uh?"

	para "PIKACHU refused"
	line "to forget SURF."

	para "It probably has"
	line "good reasons."
	done
endc

_DeleterEggText::
if DEF(_FR_FR)
	text "Un OEUF n'a pas de"
	line "capacité!"
	done
else
	text "An EGG doesn't"
	line "know any moves!"
	done
endc

_DeleterNoComeAgainText::
if DEF(_FR_FR)
	text "Ah?"
	line "A la prochaine."
	done
else
	text "No? Come visit me"
	line "again."
	done
endc

_DeleterAskWhichMoveText::
if DEF(_FR_FR)
	text "Quelle capacité"
	line "doit-il oublier?"
	prompt
else
	text "Which move should"
	line "it forget, then?"
	prompt
endc

_DeleterIntroText::
if DEF(_FR_FR)
	text "Et oui! Moi j'suis"
	line "le TYPE QUI EFFACE"
	cont "LES CAPACITES!!!"
	
	para "Je peux persuader"
	line "les #MON"
	cont "d'oublier leurs"
	cont "capacités."
	
	para "Dois-je m'occuper"
	line "de l'un de tes"
	cont "#MON?"
	done
else
	text "Um… Oh, yes, I'm"
	line "the MOVE DELETER."
	
	para "I can make #MON"
	line "forget moves."
	
	para "Shall I make a"
	line "#MON forget?"
	done
endc

_DeleterAskWhichMonText::
if DEF(_FR_FR)
	text "Quel #MON?"
	prompt
else
	text "Which #MON?"
	prompt
endc

_DSTIsThatOKText::
if DEF(_FR_FR)
	text_start
	line "OK?"
	done
else
	text " DST,"
	line "is that OK?"
	done
endc

_TimeAskOkayText::
if DEF(_FR_FR)
	text ","
	line "OK?"
	done
else
	text ","
	line "is that OK?"
	done
endc

_TimesetAskDSTText::
if DEF(_FR_FR)
	text "C'est déjà l'heure"
	line "d'été?"
	done
else
	text "Do you want to"
	line "switch to Daylight"
	cont "Saving Time?"
	done
endc

_TimesetDSTText::
if DEF(_FR_FR)
	text "J'avance la"
	line "montre d'une"
	cont "heure."
	prompt
else
	text "I set the clock"
	line "forward by one"
	cont "hour."
	prompt
endc

_TimesetAskNotDSTText::
if DEF(_FR_FR)
	text "On est à l'heure"
	line "d'hiver?"
	done
else
	text "Is Daylight Saving"
	line "Time over?"
	done
endc

_TimesetNotDSTText::
if DEF(_FR_FR)
	text "Je recule la"
	line "montre d'une"
	cont "heure."
	prompt
else
	text "I put the clock"
	line "back one hour."
	prompt
endc

_TimesetAskAdjustDSTText::
if DEF(_FR_FR)
	text "Veux-tu"
	line "ajuster la"
	
	para "montre au change-"
	line "ment d'heure?"
	done
else
	text "Do you want to"
	line "adjust your clock"
	
	para "for Daylight"
	line "Saving Time?"
	done
endc

_MomLostGearBookletText::
if DEF(_FR_FR)
	text "J'ai perdu la"
	line "notice du"
	cont "#MATOS."
	cont "Reviens plus tard."
	prompt
else
	text "I lost the in-"
	line "struction booklet"
	cont "for the #GEAR."
	
	para "Come back again in"
	line "a while."
	prompt
endc

_GymPowerRestrainerFirstExplanation::
if DEF(_FR_FR)
	text "Oh! C'est la"
	line "première fois"
	cont "que tu défies un"
	cont "CHAMPION D'ARENE?"

	para "Je vois."

	para "Laisse-moi t'expli-"
	line "quer comment ça"
	cont "se passe."

	para "Mon but est de"
	line "juger avec équité"
	cont "tes talents de"
	cont "dresseur."

	para "Les CHAMPIONS"
	line "utilisent un"
	cont "LIMITEUR DE FORCE"
	cont "sur leurs #MON."

	para "Il peut réduire"
	line "de 40 niveaux"
	cont "maximum le niveau"
	cont "de nos #MON."

	para "Je vais ajuster"
	line "le niveau de mon"
	cont "équipe sur ton"
	cont "#MON le plus"
	cont "fort."

	para "Si ton niveau est"
	line "supérieur au"
	cont "mien, je n'aurais"
	cont "pas besoin du"
	cont "LIMITEUR DE FORCE."

	para "Chaque CHAMPION"
	line "fixe aussi des"
	cont "règles spéciales,"

	para "afin de tester ta"
	line "capacité à gérer"
	cont "des situations"
	cont "inattendues."

	para "Et c'est tout."
	line "Revenons à moi."
	done
else
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

	para "That's all."
	line "Back to me."
	done
endc	

TV_FirstCovidShowText::
if DEF(_FR_FR)
	text "Au journal TV,"
	line "un médecin débat"
	cont "avec un politicien"
	cont "au sujet d'un"
	cont "nouveau virus."

	para "Le médecin semble"
	line "nerveux."

	para "Le politicien rit"
	line "et dit qu'il n'y a"

	para "aucune raison"
	line "de paniquer."

	para "..."

	para "Je ferais mieux"
	line "de sortir."
	done
else
	text "On the news,"
	line "a doctor debates"
	cont "with a politician"
	cont "about a newly"
	cont "discovered virus."

	para "The doctor seems"
	line "nervous."

	para "The politician"
	line "laughes and says"

	para "there is no need"
	line "to panic."

	para "…"

	para "I better"
	line "get going."
	done
endc

_FirstLockdownDeclarationText::
if DEF(_FR_FR)
	text "FLASH SPECIAL"

	para "“Face à la forte"
	line "hausse des cas"
	cont "quotidiens de"
	cont "contamination,"

	para "à partir de demain"
	line "un confinement"
	cont "sera instauré."

	para "#MON et humains"
	line "ne sont pas auto-"
	cont "risés à quitter"
	cont "leur domicile."

	para "Les exceptions"
	line "sont:"
	cont "courses, travail,"
	cont "et soins."

	para "Chaque sortie"
	line "exige une auto-"
	cont "attestation écrite"
	cont "à la main."

	para "Le port du masque"
	line "sera obligatoire."

	para "Des contrôles de"
	line "police seront"
	cont "organisés."

	para "Les infractions"
	line "seront verbalisées"
	cont "et vous serez re-"
	cont "conduis à domicile"
	cont "ou au CENTRE"
	cont "#MON le plus"
	cont "proche."

	para "-"

	para "Soyez responsable,"
	line "sauvez des vies,"
	cont "restez prudents.”"
	done
else
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
endc

Phase6Even3Text::
if DEF(_FR_FR)
	text "NECROLOGIE"

	para "“Le bien-aimé"
	line "MAITRE RED, porté"
	cont "disparu depuis"
	cont "plusieurs mois,"
	cont "a succombé au"
	cont "virus."

	para "<PLAYER> devient"
	line "le MAITRE #MON"
	cont "officiel.”"
	done
else
	text "OBITUARY"

	para "“Beloved CHAMPION"
	line "RED that had been"
	cont "missing for months"
	cont "has succumbed to"
	cont "the virus."

	para "<PLAYER> who was"
	line "co-CHAMPION is now"
	cont "the official"
	cont "CHAMPION.”"
	done
endc




_HospitalVisitHappiness0Text::
if DEF(_FR_FR)
	text "Ton @"
	text_ram wStringBuffer1
	text_start
	line "t'ignore..."
	prompt
else
	text "Your @"
	text_ram wStringBuffer1
	text " is"
	line "ignoring you…"
	prompt
endc

_HospitalVisitHappiness1Text::
if DEF(_FR_FR)
	text "Ton @"
	text_ram wStringBuffer1
	text ""
	line "ne s'attendait"
	cont "pas à te voir."
	prompt
else
	text "Your @"
	text_ram wStringBuffer1
	text ""
	line "didn't expect you."
	prompt
endc

_HospitalVisitHappiness2Text::
if DEF(_FR_FR)
	text "Ton @"
	text_ram wStringBuffer1
	text " est"
	line "content de te"
	cont "voir."
	prompt
else
	text "Your @"
	text_ram wStringBuffer1
	text " is"
	line "glad to see you."
	prompt
endc

_HospitalVisitHappiness3Text::
if DEF(_FR_FR)
	text "Ton @"
	text_ram wStringBuffer1
	text " est"
	line "très heureux"
	cont "de te revoir!"
	prompt
else
	text "Your @"
	text_ram wStringBuffer1
	text " is"
	line "happy to see you"
	cont "once again!"
	prompt
endc



_HospitalVisitDuration0Text::
if DEF(_FR_FR)
	text "Il semble en"
	line "pleine forme"
	cont "et prêt à sortir!"
	done
else
	text "It looks in per-"
	line "fect shape and"
	cont "ready to go out!"
	done
endc

_HospitalVisitDuration1Text::
if DEF(_FR_FR)
	text "Il va mieux et"
	line "devrait bientôt"
	cont "pouvoir sortir."
	done
else
	text "It appears to feel"
	line "better and should"
	cont "be able to leave"
	cont "soon."
	done
endc

_HospitalVisitDuration2Text::
if DEF(_FR_FR)
	text "Il faudra encore"
	line "pas mal de temps"
	cont "avant qu'il ne"
	cont "puisse sortir..."
	done
else
	text "Quite some time"
	line "will be necessary"
	cont "before it can"
	cont "leave this room…"
	done
endc



_MoveReminderIntro::
if DEF(_FR_FR)
	text "Tu ne me reconnais"
	line "pas? Je suis le"
	cont "MAITRE DES"
	cont "CAPACITES!"

	para "Je peux réappren-"
	line "dre à un #MON"

	para "une capacité"
	line "déjà oubliée."

	para "Le tarif de mon"
	line "service est 500¥."
	cont "C'est parti?"
	done
else
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
endc

_MoveReminderWhichMon::
if DEF(_FR_FR)
	text "Montre-moi le"
	line "#MON!"
	done
else
	text "Show me the"
	line "#MON!"
	done
endc

_MoveReminderWhichMove::
if DEF(_FR_FR)
	text "Quelle attaque"
	next "réapprendre?"
	done
else
	text "Which move should"
	next "it relearn?"
	done
endc

_MoveReminderCancel::
if DEF(_FR_FR)
	text "Reviens quand tu"
	line "veux."
	done
else
	text "Come back anytime."
	done
endc

_MoveReminderEgg::
if DEF(_FR_FR)
	text "Je suis censé"
	line "faire quoi avec"
	cont "un OEUF?"
	done
else
	text "What am I"
	line "supposed to do"
	cont "with an EGG?"
	done
endc

_MoveReminderNoPay::
if DEF(_FR_FR)
	text "Hmm. Tu n'as pas"
	line "assez d'argent."

	para "La prochaine fois,"
	line "pense à apporter"
	cont "de quoi payer."
	done
else
	text "Hm. You don't"
	line "have enough."

	para "Next time you come"
	line "remember to bring"
	cont "in some money."
	done
endc

_MoveReminderNoMon::
if DEF(_FR_FR)
	text "Tu n'as aucun"
	line "#MON qui puisse"
	cont "se souvenir d'une"
	cont "capacité."
	done
else
	text "You don't have a"
	line "#MON that can"
	cont "remember a move."
	done
endc

_MoveReminderNoMoves::
if DEF(_FR_FR)
	text "Ce #MON n'a"
	line "aucune capacité"
	cont "à réapprendre."
	done
else
	text "There are no moves"
	line "for this #MON"
	cont "to remember."
	done
endc

_MoveReminderTakeMoney::
if DEF(_FR_FR)
	text "Un plaisir de"
	line "faire affaire"
	cont "avec toi!"
	done
else
	text "Pleasure doing"
	line "business with you!"
	done
endc

_MoveReminderThanks::
if DEF(_FR_FR)
	text "Je ne l'oublierai"
	line "pas!"
	done
else
	text "I won't forget it!"
	done
endc
	