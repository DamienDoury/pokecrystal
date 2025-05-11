_FruitBearingTreeText::
if DEF(_FR_FR)
	text "C'est un arbre à"
	line "fruits."
	done
else
	text "It's a fruit-"
	line "bearing tree."
	done
endc

_HeyItsFruitText::
if DEF(_FR_FR)
	text "Hé! C'est un(e)"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hey! It's"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc

_PickUpFruitsText:: ; TO TRANSLATE
	text "Do you want to"
	line "pick these up?"
	done

_ObtainedFruitText::
if DEF(_FR_FR)
	text "Obtenu:"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Obtained"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc

_FruitPackIsFullText::
if DEF(_FR_FR)
	text "Mais le SAC"
	line "est plein..."
	done
else
	text "But the PACK is"
	line "full…"
	done
endc

_NothingHereText::
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "ici..."
	done
else
	text "There's nothing"
	line "here…"
	done
endc

_DrySoilText:: ; TO TRANSLATE
	text "The soil is dry."
	done

_WetSoilText:: ; TO TRANSLATE
	text "The soil is nice"
	line "and moist!"
	done

_AskWaterSoilText:: ; TO TRANSLATE
	text "Water it with the"
	line "SQUIRTBOTTLE?"
	done

_FruitTreeGotStrongerText:: ; TO TRANSLATE
	text "The tree should"
	line "grow more fruits!"
	done

_FruitPlentyOfWaterText:: ; TO TRANSLATE
	text "The fruit tree has"
	line "plenty of water."
	done

_WhichApricornText::
if DEF(_FR_FR)
	text "Quel NOIGRUME"
	line "dois-je utiliser?"
	done
else
	text "Which APRICORN"
	line "should I use?"
	done
endc

_HowManyShouldIMakeText::
if DEF(_FR_FR)
	text "Combien dois-je"
	line "en créer?"
	done
else
	text "How many should I"
	line "make?"
	done
endc

_RecoveredSomeHPText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "regagne @"
	text_decimal wCurHPAnimDeltaHP, 2, 3
	text "PV!"
	done
else
	text_ram wStringBuffer1
	text_start
	line "recovered @"
	text_decimal wCurHPAnimDeltaHP, 2, 3
	text "HP!"
	done
endc

_CuredOfPoisonText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " n'est"
	line "plus empoisonné."
	done
else
	text_ram wStringBuffer1
	text "'s"
	line "cured of poison."
	done
endc

_RidOfParalysisText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " n'est"
	line "plus paralysé."
	done
else
	text_ram wStringBuffer1
	text "'s"
	line "rid of paralysis."
	done
endc

_BurnWasHealedText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "ne brûle plus."
	done
else
	text_ram wStringBuffer1
	text "'s"
	line "burn was healed."
	done
endc

_WasDefrostedText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "n'est plus gelé."
	done
else
	text_ram wStringBuffer1
	text_start
	line "was defrosted."
	done
endc

_WokeUpText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "se réveille."
	done
else
	text_ram wStringBuffer1
	text_start
	line "woke up."
	done
endc

_HealthReturnedText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " regagne"
	line "son énergie."
	done
else
	text_ram wStringBuffer1
	text "'s"
	line "health returned."
	done
endc

_RevitalizedText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " est"
	line "revitalisé."
	done
else
	text_ram wStringBuffer1
	text_start
	line "is revitalized."
	done
endc

_GrewToLevelText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " monte"
	line "au niveau @"
	text_decimal wCurPartyLevel, 1, 3
	text "!@"
	sound_dex_fanfare_50_79 ; plays SFX_DEX_FANFARE_50_79, identical to SFX_LEVEL_UP
	text_promptbutton
	text_end
else
	text_ram wStringBuffer1
	text " grew to"
	line "level @"
	text_decimal wCurPartyLevel, 1, 3
	text "!@"
	sound_dex_fanfare_50_79 ; plays SFX_DEX_FANFARE_50_79, identical to SFX_LEVEL_UP
	text_promptbutton
	text_end
endc

_CameToItsSensesText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " revient"
	line "à lui."
	done
else
	text_ram wStringBuffer1
	text " came"
	line "to its senses."
	done
endc

_EnterNewPasscodeText::
if DEF(_FR_FR)
	text "Entrez un nombre"
	line "à 4 chiffres."
	done
else
	text "Please enter any"
	line "four-digit number."
	done
endc

_ConfirmPasscodeText::
if DEF(_FR_FR)
	text "Entrez le même No."
	line "pour confirmation."
	done
else
	text "Enter the same"
	line "number to confirm."
	done
endc

_PasscodesNotSameText::
if DEF(_FR_FR)
	text "Ce n'est pas le"
	line "même numéro."
	done
else
	text "That's not the"
	line "same number."
	done
endc

_PasscodeSetText::
if DEF(_FR_FR)
	text "CODE SECRET"
	line "défini."
	
	para "Entrez ce No. la"
	line "prochaine fois"
	cont "pour ouvrir le"
	cont "FICHIER CARTE."
	
	para ""
	done
else
	text "Your PASSCODE has"
	line "been set."
	
	para "Enter this number"
	line "next time to open"
	cont "the CARD FOLDER."
	
	para ""
	done
endc

_FourZerosInvalidText::
if DEF(_FR_FR)
	text "0000 invalide!"
	prompt
else
	text "0000 is invalid!"
	
	para ""
	done
endc

_EnterPasscodeText::
if DEF(_FR_FR)
	text "Entrez le CODE du"
	next "FICHIER CARTE."
	done
else
	text "Enter the CARD"
	next "FOLDER PASSCODE."
	done
endc

_IncorrectPasscodeText::
if DEF(_FR_FR)
	text "CODE SECRET"
	line "incorrect!"
	prompt
else
	text "Incorrect"
	line "PASSCODE!"
	
	para ""
	done
endc

_CardFolderOpenText::
if DEF(_FR_FR)
	text "FICHIER CARTE"
	line "ouvert.@"
	text_end
else
	text "CARD FOLDER open.@"
	text_end
endc

_OakTimeWokeUpText::
if DEF(_FR_FR)
	text "<……><……><……><……><……><……>"
	line "<……><……><……><……><……><……>"
	
	para "Zzz...Hm? Quoi...?"
	line "Tu m'as réveillé!"
	
	para "Mais quelle heure"
	line "est-il?"
	prompt
else
	text "<……><……><……><……><……><……>"
	line "<……><……><……><……><……><……>"
	
	para "Zzz… Hm? Wha…?"
	line "You woke me up!"
	
	para "Will you check the"
	line "clock for me?"
	prompt
endc

_OakTimeWhatTimeIsItText::
if DEF(_FR_FR)
	text "Quelle heure"
	line "est-il?"
	done
else
	text "What time is it?"
	done
endc

_OakTimeWhatHoursText::
if DEF(_FR_FR)
	text "Quoi?@"
	text_end
else
	text "What?@"
	text_end
endc

_OakTimeHoursQuestionMarkText::
	text "?"
	done

_OakTimeHowManyMinutesText::
if DEF(_FR_FR)
	text "Combien de"
	line "minutes?"
	done
else
	text "How many minutes?"
	done
endc

_OakTimeWhoaMinutesText::
	text "Whoa!@"
	text_end

_OakTimeMinutesQuestionMarkText::
	text "?"
	done

_OakTimeOversleptText::
if DEF(_FR_FR)
	text "!"
	line "J'suis en retard!"
	done
else
	text "!"
	line "I overslept!"
	done
endc

_OakTimeYikesText::
if DEF(_FR_FR)
	text "!"
	line "Non! J'suis en"
	cont "retard!"
	done
else
	text "!"
	line "Yikes! I over-"
	cont "slept!"
	done
endc

_OakTimeSoDarkText::
if DEF(_FR_FR)
	text "!"
	line "C'est normal qu'il"
	cont "fasse nuit!"
	done
else
	text "!"
	line "No wonder it's so"
	cont "dark!"
	done
endc

_OakTimeWhatDayIsItText::
if DEF(_FR_FR)
	text "Quel jour?"
	done
else
	text "What day is it?"
	done
endc

_OakTimeIsItText::
if DEF(_FR_FR)
	text "?"
	done
else
	text ", is it?"
	done
endc

_NothingToChooseText::
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "à choisir."
	prompt
else
	text "There's nothing to"
	line "choose."
	prompt
endc

_WhichSidePutOnText::
if DEF(_FR_FR)
	text "Mettre de quel"
	line "côté?"
	done
else
	text "Which side do you"
	line "want to put it on?"
	done
endc

_WhichSidePutAwayText::
if DEF(_FR_FR)
	text "Ranger de quel"
	line "côté?"
	done
else
	text "Which side do you"
	line "want to put away?"
	done
endc

_PutAwayTheDecoText::
if DEF(_FR_FR)
	text "Rangé:"
	line "@"
	text_ram wStringBuffer3
	text "."
	prompt
else
	text "Put away the"
	line "@"
	text_ram wStringBuffer3
	text "."
	prompt
endc

_NothingToPutAwayText::
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "à ranger."
	prompt
else
	text "There's nothing to"
	line "put away."
	prompt
endc

_SetUpTheDecoText::
if DEF(_FR_FR)
	text "Installé:"
	line "@"
	text_ram wStringBuffer3
	text "."
	prompt
else
	text "Set up the"
	line "@"
	text_ram wStringBuffer3
	text "."
	prompt
endc

_PutAwayAndSetUpText::
if DEF(_FR_FR)
	text "Rangé:"
	line "@"
	text_ram wStringBuffer3
	text_start
	
	para "et installé:"
	line "@"
	text_ram wStringBuffer4
	text "."
	prompt
else
	text "Put away the"
	line "@"
	text_ram wStringBuffer3
	text_start
	
	para "and set up the"
	line "@"
	text_ram wStringBuffer4
	text "."
	prompt
endc

_AlreadySetUpText::
if DEF(_FR_FR)
	text "C'est déjà"
	line "installé."
	prompt
else
	text "That's already set"
	line "up."
	prompt
endc

_LookTownMapText::
if DEF(_FR_FR)
	text "C'est la CARTE."
	done
else
	text "It's the TOWN MAP."
	done
endc

_LookPikachuPosterText::
if DEF(_FR_FR)
	text "C'est un poster du"
	line "mignon PIKACHU."
	done
else
	text "It's a poster of a"
	line "cute PIKACHU."
	done
endc

_LookClefairyPosterText::
if DEF(_FR_FR)
	text "C'est un poster du"
	line "mignon MELOFEE."
	done
else
	text "It's a poster of a"
	line "cute CLEFAIRY."
	done
endc

_LookJigglypuffPosterText::
if DEF(_FR_FR)
	text "C'est un poster du"
	line "mignon RONDOUDOU."
	done
else
	text "It's a poster of a"
	line "cute JIGGLYPUFF."
	done
endc

_LookAdorableDecoText::
if DEF(_FR_FR)
	text "Un(e) superbe"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "It's an adorable"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc

_LookGiantDecoText::
if DEF(_FR_FR)
	text "Une poupée géante!"
	line "C'est super doux."
	done
else
	text "A giant doll! It's"
	line "fluffy and cuddly."
	done
endc

_MomHiHowAreYouText::
if DEF(_FR_FR)
	text "Salut, <PLAYER>!"
	line "Ca va bien?"
	prompt
else
	text "Hi, <PLAYER>!"
	line "How are you?"
	prompt
endc

_MomFoundAnItemText::
if DEF(_FR_FR)
	text "J'ai trouvé un bel"
	line "objet à acheter..."
	prompt
else
	text "I found a useful"
	line "item shopping, so"
	prompt
endc

_MomItsInPCText::
if DEF(_FR_FR)
	text "C'est dans ton PC."
	line "Ca va te plaire!"
	done
else
	text "It's in your PC."
	line "You'll like it!"
	done
endc

_MomReceivedItemFromNeighborText:: ; TO TRANSLATE
	text "The neighbor gave"
	line "me @"
	text_decimal wStringBuffer2, 1, 1
	text " @"
	text_ram wStringBuffer1
	text "."
	prompt

_MomWontNeedText:: ; TO TRANSLATE
	text "She said she won't"
	line "need it now that"
	cont "we're stuck home."
	prompt

_MomDontHaveAUseText:: ; TO TRANSLATE
	text "I don't have"
	line "a use for it."
	prompt

_MomShippedText:: ; TO TRANSLATE
	text "So I shipped it"
	line "to you."
	prompt

_MonWasSentToText::
if DEF(_FR_FR)
	text_ram wPlayerTrademonSpeciesName
	text " est"
	line "envoyé à @"
	text_ram wOTTrademonSenderName
	text "."
	done
else
	text_ram wPlayerTrademonSpeciesName
	text " was"
	line "sent to @"
	text_ram wOTTrademonSenderName
	text "."
	done
endc

_MonNameSentToText::
	text_start
	done

_BidsFarewellToMonText::
if DEF(_FR_FR)
	text_ram wOTTrademonSenderName
	text " dit"
	line "adieu à"
	done
else
	text_ram wOTTrademonSenderName
	text " bids"
	line "farewell to"
	done
endc

_MonNameBidsFarewellText::
	text_ram wOTTrademonSpeciesName
	text "."
	done

_TakeGoodCareOfMonText::
if DEF(_FR_FR)
	text "Prends soin de"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
else
	text "Take good care of"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
endc

_ForYourMonSendsText::
if DEF(_FR_FR)
	text "Contre @"
	text_ram wPlayerTrademonSpeciesName
	text_start
	line "de @"
	text_ram wPlayerTrademonSenderName
	text ","
	done
else
	text "For @"
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text ","
	done
endc

_OTSendsText::
if DEF(_FR_FR)
	text_ram wOTTrademonSenderName
	text " envoie"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
else
	text_ram wOTTrademonSenderName
	text " sends"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
endc

_WillTradeText::
if DEF(_FR_FR)
	text_ram wOTTrademonSenderName
	text " va échan-"
	line "ger @"
	text_ram wOTTrademonSpeciesName
	text_end
else
	text_ram wOTTrademonSenderName
	text " will"
	line "trade @"
	text_ram wOTTrademonSpeciesName
	text_end
endc

_ForYourMonWillTradeText::
if DEF(_FR_FR)
	text "contre @"
	text_ram wPlayerTrademonSpeciesName
	text_start
	line "de @"
	text_ram wPlayerTrademonSenderName
	text "."
	done
else
	text "for @"
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text "."
	done
endc

_MobilePlayerWillTradeMonText::
if DEF(_FR_FR)
	text_ram wPlayerTrademonSenderName
	text " va échan-"
	line "ger @"
	text_ram wPlayerTrademonSpeciesName
	text_end
else
	text_ram wPlayerTrademonSenderName
	text " will"
	line "trade @"
	text_ram wPlayerTrademonSpeciesName
	text_end
endc

_MobileForPartnersMonText::
if DEF(_FR_FR)
	text "contre @"
	text_ram wOTTrademonSpeciesName
	text_start
	line "de @"
	text_ram wOTTrademonSenderName
	text "."
	done
else
	text "for @"
	text_ram wOTTrademonSenderName
	text "'s"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
endc

_MobilePlayersMonTradeText::
if DEF(_FR_FR)
	text "Echange @"
	text_ram wPlayerTrademonSpeciesName
	text_start
	line "de @"
	text_ram wPlayerTrademonSenderName
	text "…"
	done
else
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text " trade…"
	done
endc

_MobileTakeGoodCareOfMonText::
if DEF(_FR_FR)
	text "Prends soin de"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
else
	text "Take good care of"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
endc

_MobilePlayersMonTrade2Text::
if DEF(_FR_FR)
	text "Echange @"
	text_ram wPlayerTrademonSpeciesName
	text_start
	line "de @"
	text_ram wPlayerTrademonSenderName
	text "…"
	done
else
	text_ram wPlayerTrademonSenderName
	text "'s"
	line "@"
	text_ram wPlayerTrademonSpeciesName
	text " trade…"
	done
endc

_MobileTakeGoodCareOfText::
if DEF(_FR_FR)
	text "Prends soin de"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
else
	text "Take good care of"
	line "@"
	text_ram wOTTrademonSpeciesName
	text "."
	done
endc

_MobileTradeCameBackText::
if DEF(_FR_FR)
	text_ram wOTTrademonSpeciesName
	text_start
	line "revient!"
	done
	
	; Oak's Pokémon Talk
else
	text_ram wOTTrademonSpeciesName
	text " came"
	line "back!"
	done
	
	; Oak's Pokémon Talk
endc

_OPT_IntroText1::
if DEF(_FR_FR)
	text_start
	line "LULA: CHRONIQUE"
	done
else
	text_start
	line "MARY: PROF.OAK'S"
	done
endc

_OPT_IntroText2::
if DEF(_FR_FR)
	text_start
	line "DU PROF.CHEN!"
	done
else
	text_start
	line "#MON TALK!"
	done
endc

_OPT_IntroText3::
if DEF(_FR_FR)
	text_start
	line "Avec moi, LULA!"
	done
else
	text_start
	line "With me, MARY!"
	done
endc

_OPT_OakText1::
if DEF(_FR_FR)
	text_start
	line "CHEN: @"
	text_ram wMonOrItemNameBuffer
	text_end
else
	text_start
	line "OAK: @"
	text_ram wMonOrItemNameBuffer
	text_end
endc

_OPT_OakText2::
if DEF(_FR_FR)
	text_start
	line "est près de:"
	done
else
	text_start
	line "may be seen around"
	done
endc

_OPT_OakText3::
	text_start
	line "@"
	text_ram wStringBuffer1
	text "."
	done

_OPT_MaryText1::
if DEF(_FR_FR)
	text_start
	line "LULA: @"
	text_ram wStringBuffer1
	text_end
else
	text_start
	line "MARY: @"
	text_ram wStringBuffer1
	text "'s"
	done
endc

_OPT_SweetAdorablyText::
if DEF(_FR_FR)
	text_start
	line "est adorable et"
	done
else
	text_start
	line "sweet and adorably"
	done
endc

_OPT_WigglySlicklyText::
if DEF(_FR_FR)
	text_start
	line "est mou et"
	done
else
	text_start
	line "wiggly and slickly"
	done
endc

_OPT_AptlyNamedText::
if DEF(_FR_FR)
	text_start
	line "bien nommé et"
	done
else
	text_start
	line "aptly named and"
	done
endc

_OPT_UndeniablyKindOfText::
if DEF(_FR_FR)
	text_start
	line "est vraiment"
	done
else
	text_start
	line "undeniably kind of"
	done
endc

_OPT_UnbearablyText::
if DEF(_FR_FR)
	text_start
	line "est très"
	done
else
	text_start
	line "so, so unbearably"
	done
endc

_OPT_WowImpressivelyText::
if DEF(_FR_FR)
	text_start
	line "est super"
	done
else
	text_start
	line "wow, impressively"
	done
endc

_OPT_AlmostPoisonouslyText::
if DEF(_FR_FR)
	text_start
	line "est toxique et"
	done
else
	text_start
	line "almost poisonously"
	done
endc

_OPT_SensuallyText::
if DEF(_FR_FR)
	text_start
	line "est sensuel et"
	done
else
	text_start
	line "ooh, so sensually"
	done
endc

_OPT_MischievouslyText::
if DEF(_FR_FR)
	text_start
	line "est vicieux et"
	done
else
	text_start
	line "so mischievously"
	done
endc

_OPT_TopicallyText::
if DEF(_FR_FR)
	text_start
	line "est célèbre et"
	done
else
	text_start
	line "so very topically"
	done
endc

_OPT_AddictivelyText::
if DEF(_FR_FR)
	text_start
	line "est très"
	done
else
	text_start
	line "sure addictively"
	done
endc

_OPT_LooksInWaterText::
if DEF(_FR_FR)
	text_start
	line "dans l'eau est"
	done
else
	text_start
	line "looks in water is"
	done
endc

_OPT_EvolutionMustBeText::
if DEF(_FR_FR)
	text_start
	line "évolué est"
	done
else
	text_start
	line "evolution must be"
	done
endc

_OPT_ProvocativelyText::
if DEF(_FR_FR)
	text_start
	line "est provoquant et"
	done
else
	text_start
	line "provocatively"
	done
endc

_OPT_FlippedOutText::
if DEF(_FR_FR)
	text_start
	line "est fou et"
	done
else
	text_start
	line "so flipped out and"
	done
endc

_OPT_HeartMeltinglyText::
if DEF(_FR_FR)
	text_start
	line "est tellement"
	done
else
	text_start
	line "heart-meltingly"
	done
endc

_OPT_CuteText::
if DEF(_FR_FR)
	text_start
	line "mignon."
	done
else
	text_start
	line "cute."
	done
endc

_OPT_WeirdText::
if DEF(_FR_FR)
	text_start
	line "bizarre."
	done
else
	text_start
	line "weird."
	done
endc

_OPT_PleasantText::
if DEF(_FR_FR)
	text_start
	line "agréable."
	done
else
	text_start
	line "pleasant."
	done
endc

_OPT_BoldSortOfText::
if DEF(_FR_FR)
	text_start
	line "courageux."
	done
else
	text_start
	line "bold, sort of."
	done
endc

_OPT_FrighteningText::
if DEF(_FR_FR)
	text_start
	line "effrayant."
	done
else
	text_start
	line "frightening."
	done
endc

_OPT_SuaveDebonairText::
if DEF(_FR_FR)
	text_start
	line "rapide!"
	done
else
	text_start
	line "suave & debonair!"
	done
endc

_OPT_PowerfulText::
if DEF(_FR_FR)
	text_start
	line "puissant."
	done
else
	text_start
	line "powerful."
	done
endc

_OPT_ExcitingText::
if DEF(_FR_FR)
	text_start
	line "vigoureux."
	done
else
	text_start
	line "exciting."
	done
endc

_OPT_GroovyText::
if DEF(_FR_FR)
	text_start
	line "cool!"
	done
else
	text_start
	line "groovy!"
	done
endc

_OPT_InspiringText::
if DEF(_FR_FR)
	text_start
	line "exaltant."
	done
else
	text_start
	line "inspiring."
	done
endc

_OPT_FriendlyText::
if DEF(_FR_FR)
	text_start
	line "amical."
	done
else
	text_start
	line "friendly."
	done
endc

_OPT_HotHotHotText::
if DEF(_FR_FR)
	text_start
	line "chaud!"
	done
else
	text_start
	line "hot, hot, hot!"
	done
endc

_OPT_StimulatingText::
if DEF(_FR_FR)
	text_start
	line "stimulant."
	done
else
	text_start
	line "stimulating."
	done
endc

_OPT_GuardedText::
if DEF(_FR_FR)
	text_start
	line "protégé."
	done
else
	text_start
	line "guarded."
	done
endc

_OPT_LovelyText::
if DEF(_FR_FR)
	text_start
	line "gracieux."
	done
else
	text_start
	line "lovely."
	done
endc

_OPT_SpeedyText::
if DEF(_FR_FR)
	text_start
	line "rapide."
	done
else
	text_start
	line "speedy."
	done
endc

_OPT_PokemonChannelText::
	text "#MON"
	done

_PokedexShowText::
	text_start
	line "@"
	text_ram wStringBuffer1
	text_end

; Pokémon Music Channel / Pokémusic

_BenIntroText1::
if DEF(_FR_FR)
	text_start
	line "BEN: ANTENNE"
	done
else
	text_start
	line "BEN: #MON MUSIC"
	done
endc

_BenIntroText2::
if DEF(_FR_FR)
	text_start
	line "MUSIQUE PKMN!"
	done
else
	text_start
	line "CHANNEL!"
	done
endc

_BenIntroText3::
if DEF(_FR_FR)
	text_start
	line "C'est moi, DJ BEN!"
	done
else
	text_start
	line "It's me, DJ BEN!"
	done
endc

_FernIntroText1::
if DEF(_FR_FR)
	text_start
	line "SEB: #MUSIQUE!"
	done
else
	text_start
	line "FERN: #MUSIC!"
	done
endc

_FernIntroText2::
if DEF(_FR_FR)
	text_start
	line "Avec DJ SEB!"
	done
else
	text_start
	line "With DJ FERN!"
	done
endc

_BenFernText1::
if DEF(_FR_FR)
	text_start
	line "Ce @"
	text_today
	text ","
	done
else
	text_start
	line "Today's @"
	text_today
	text ","
	done
endc

_BenFernText2A::
if DEF(_FR_FR)
	text_start
	line "on s'écoute"
	done
else
	text_start
	line "so let us jam to"
	done
endc

_BenFernText2B::
if DEF(_FR_FR)
	text_start
	line "on s'la donne avec"
	done
else
	text_start
	line "so chill out to"
	done
endc

_BenFernText3A::
if DEF(_FR_FR)
	text_start
	line "la fanfare PKMN!"
	done
else
	text_start
	line "#MON March!"
	done
endc

_BenFernText3B::
if DEF(_FR_FR)
	text_start
	line "la berceuse PKMN!"
	done
	
	; Lucky Channel
else
	text_start
	line "#MON Lullaby!"
	done
	
	; Lucky Channel
endc

_LC_Text1::
if DEF(_FR_FR)
	text_start
	line "SAM: Yeah! Comment"
	done
else
	text_start
	line "REED: Yeehaw! How"
	done
endc

_LC_Text2::
if DEF(_FR_FR)
	text_start
	line "ça gaze les gars?"
	done
else
	text_start
	line "y'all doin' now?"
	done
endc

_LC_Text3::
if DEF(_FR_FR)
	text_start
	line "Si t'as la pêche"
	done
else
	text_start
	line "Whether you're up"
	done
endc

_LC_Text4::
if DEF(_FR_FR)
	text_start
	line "ou pas le moral,"
	done
else
	text_start
	line "or way down low,"
	done
endc

_LC_Text5::
if DEF(_FR_FR)
	text_start
	line "ne rate jamais le"
	done
else
	text_start
	line "don't you miss the"
	done
endc

_LC_Text6::
if DEF(_FR_FR)
	text_start
	line "BON NUMERO!"
	done
else
	text_start
	line "LUCKY NUMBER SHOW!"
	done
endc

_LC_Text7::
if DEF(_FR_FR)
	text_start
	line "Cette semaine le"
	done
else
	text_start
	line "This week's Lucky"
	done
endc

_LC_Text8::
if DEF(_FR_FR)
	text_start
	line "No. est @"
	text_pause
	text_ram wStringBuffer1
	text "!"
	done
else
	text_start
	line "Number is @"
	text_pause
	text_ram wStringBuffer1
	text "!"
	done
endc

_LC_Text9::
if DEF(_FR_FR)
	text_start
	line "Je répète..."
	done
else
	text_start
	line "I'll repeat that!"
	done
endc

_LC_Text10::
if DEF(_FR_FR)
	text_start
	line "Gagne et va vite"
	done
else
	text_start
	line "Match it and go to"
	done
endc

_LC_Text11::
if DEF(_FR_FR)
	text_start
	line "à la TOUR RADIO!"
	done
else
	text_start
	line "the RADIO TOWER!"
	done
endc

_LC_DragText1::
if DEF(_FR_FR)
	text_start
	line "J'aime pas trop"
	done
else
	text_start
	line "…Repeating myself"
	done
endc

_LC_DragText2::
if DEF(_FR_FR)
	text_start
	line "répéter..."
	done
	
	; Places and People
else
	text_start
	line "gets to be a drag…"
	done
	
	; Places and People
endc

_PnP_Text1::
if DEF(_FR_FR)
	text_start
	line "SOCIO FM!"
	done
else
	text_start
	line "PLACES AND PEOPLE!"
	done
endc

_PnP_Text2::
if DEF(_FR_FR)
	text_start
	line "Présenté par"
	done
else
	text_start
	line "Brought to you by"
	done
endc

_PnP_Text3::
if DEF(_FR_FR)
	text_start
	line "moi, DJ PETRA!"
	done
else
	text_start
	line "me, DJ LILY!"
	done
endc

_PnP_Text4::
if DEF(_FR_FR)
	text_start
	line "@"
	text_ram wStringBuffer1
	text " @"
	text_ram wStringBuffer2
	text_end
else
	text_start
	line "@"
	text_ram wStringBuffer2
	text " @"
	text_ram wStringBuffer1
	text_end
endc

_PnP_CuteText::
if DEF(_FR_FR)
	text_start
	line "est adorable."
	done
else
	text_start
	line "is cute."
	done
endc

_PnP_LazyText::
if DEF(_FR_FR)
	text_start
	line "est cool."
	done
else
	text_start
	line "is sort of lazy."
	done
endc

_PnP_HappyText::
if DEF(_FR_FR)
	text_start
	line "est en joie."
	done
else
	text_start
	line "is always happy."
	done
endc

_PnP_NoisyText::
if DEF(_FR_FR)
	text_start
	line "fait du bruit."
	done
else
	text_start
	line "is quite noisy."
	done
endc

_PnP_PrecociousText::
if DEF(_FR_FR)
	text_start
	line "est calme."
	done
else
	text_start
	line "is precocious."
	done
endc

_PnP_BoldText::
if DEF(_FR_FR)
	text_start
	line "est difficile."
	done
else
	text_start
	line "is somewhat bold."
	done
endc

_PnP_PickyText::
if DEF(_FR_FR)
	text_start
	line "est difficile!"
	done
else
	text_start
	line "is too picky!"
	done
endc

_PnP_SortOfOKText::
if DEF(_FR_FR)
	text_start
	line "est pas mal."
	done
else
	text_start
	line "is sort of OK."
	done
endc

_PnP_SoSoText::
if DEF(_FR_FR)
	text_start
	line "est OK."
	done
else
	text_start
	line "is just so-so."
	done
endc

_PnP_GreatText::
if DEF(_FR_FR)
	text_start
	line "est super!"
	done
else
	text_start
	line "is actually great."
	done
endc

_PnP_MyTypeText::
if DEF(_FR_FR)
	text_start
	line "est trop cool."
	done
else
	text_start
	line "is just my type."
	done
endc

_PnP_CoolText::
if DEF(_FR_FR)
	text_start
	line "est cool, non?"
	done
else
	text_start
	line "is so cool, no?"
	done
endc

_PnP_InspiringText::
if DEF(_FR_FR)
	text_start
	line "est terrible!"
	done
else
	text_start
	line "is inspiring!"
	done
endc

_PnP_WeirdText::
if DEF(_FR_FR)
	text_start
	line "est étrange."
	done
else
	text_start
	line "is kind of weird."
	done
endc

_PnP_RightForMeText::
if DEF(_FR_FR)
	text_start
	line "est formidable."
	done
else
	text_start
	line "is right for me?"
	done
endc

_PnP_OddText::
if DEF(_FR_FR)
	text_start
	line "est bizarre!"
	done
else
	text_start
	line "is definitely odd!"
	done
endc

_PnP_Text5::
	text_start
	line "@"
	text_ram wStringBuffer1
	text_end

_RocketRadioText1::
if DEF(_FR_FR)
	text_start
	line "...Heu...on est"
	done
else
	text_start
	line "… …Ahem, we are"
	done
endc

_RocketRadioText2::
if DEF(_FR_FR)
	text_start
	line "la TEAM ROCKET!"
	done
else
	text_start
	line "TEAM ROCKET!"
	done
endc

_RocketRadioText3::
if DEF(_FR_FR)
	text_start
	line "Après trois ans"
	done
else
	text_start
	line "After three years"
	done
endc

_RocketRadioText4::
if DEF(_FR_FR)
	text_start
	line "d'attente, on"
	done
else
	text_start
	line "of preparation, we"
	done
endc

_RocketRadioText5::
if DEF(_FR_FR)
	text_start
	line "est de retour"
	done
else
	text_start
	line "have risen again"
	done
endc

_RocketRadioText6::
if DEF(_FR_FR)
	text_start
	line "pour de bon!"
	done
else
	text_start
	line "from the ashes!"
	done
endc

_RocketRadioText7::
if DEF(_FR_FR)
	text_start
	line "GIOVANNI! @"
	text_pause
	text "Chef!"
	done
else
	text_start
	line "GIOVANNI! @"
	text_pause
	text "Can you"
	done
endc

_RocketRadioText8::
if DEF(_FR_FR)
	text_start
	line "On a réussi!"
	done
else
	text_start
	line "hear?@"
	text_pause
	text " We did it!"
	done
endc

_RocketRadioText9::
if DEF(_FR_FR)
	text_start
	line "@"
	text_pause
	text "Où est notre chef?"
	done
else
	text_start
	line "@"
	text_pause
	text "Where is our boss?"
	done
endc

_RocketRadioText10::
if DEF(_FR_FR)
	text_start
	line "@"
	text_pause
	text "Il nous écoute?"
	done
else
	text_start
	line "@"
	text_pause
	text "Is he listening?"
	done
endc

_RocketRadioText11:: ; TO TRANSLATE
	text_start
	line "SUBMITTING!"
	done

_RocketRadioText12:: ; TO TRANSLATE
	text_start
	line "COVID is a lie!"
	done

_RocketRadioText13:: ; TO TRANSLATE
	text_start
	line "Go out and find"
	done

_RocketRadioText14:: ; TO TRANSLATE
	text_start
	line "out for yourself!"
	done





_BuenaRadioText1::
if DEF(_FR_FR)
	text_start
	line "BUENA: Ici BUENA!"
	done
else
	text_start
	line "BUENA: BUENA here!"
	done
endc

_BuenaRadioText2::
if DEF(_FR_FR)
	text_start
	line "Le mot de passe!"
	done
else
	text_start
	line "Today's password!"
	done
endc

_BuenaRadioText3::
if DEF(_FR_FR)
	text_start
	line "C'est..."
	done
else
	text_start
	line "Let me think… It's"
	done
endc

_BuenaRadioText4::
	text_start
	line "@"
	text_ram wStringBuffer1
	text "!"
	done

_BuenaRadioText5::
if DEF(_FR_FR)
	text_start
	line "Souvenez-vous en!"
	done
else
	text_start
	line "Don't forget it!"
	done
endc

_BuenaRadioText6::
if DEF(_FR_FR)
	text_start
	line "Je suis à la RADIO"
	done
else
	text_start
	line "I'm in GOLDENROD's"
	done
endc

_BuenaRadioText7::
if DEF(_FR_FR)
	text_start
	line "de DOUBLONVILLE!"
	done
else
	text_start
	line "RADIO TOWER!"
	done
endc

_BuenaRadioMidnightText1::
if DEF(_FR_FR)
	text_start
	line "BUENA: Oh…"
	done
else
	text_start
	line "BUENA: Oh my…"
	done
endc

_BuenaRadioMidnightText2::
if DEF(_FR_FR)
	text_start
	line "Il est minuit!"
	done
else
	text_start
	line "It's midnight! I"
	done
endc

_BuenaRadioMidnightText3::
if DEF(_FR_FR)
	text_start
	line "C'est la fin!"
	done
else
	text_start
	line "have to shut down!"
	done
endc

_BuenaRadioMidnightText4::
if DEF(_FR_FR)
	text_start
	line "Merci d'avoir"
	done
else
	text_start
	line "Thanks for tuning"
	done
endc

_BuenaRadioMidnightText5::
if DEF(_FR_FR)
	text_start
	line "écouté aujourd'hui"
	done
else
	text_start
	line "in to the end! But"
	done
endc

_BuenaRadioMidnightText6::
if DEF(_FR_FR)
	text_start
	line "et allez au dodo!"
	done
else
	text_start
	line "don't stay up too"
	done
endc

_BuenaRadioMidnightText7::
if DEF(_FR_FR)
	text_start
	line "C'était DJ BUENA"
	done
else
	text_start
	line "late! Presented to"
	done
endc

_BuenaRadioMidnightText8::
if DEF(_FR_FR)
	text_start
	line "en direct!"
	done
else
	text_start
	line "you by DJ BUENA!"
	done
endc

_BuenaRadioMidnightText9::
if DEF(_FR_FR)
	text_start
	line "Au revoir!"
	done
else
	text "I'm outta here!"
	done
endc

_BuenaRadioMidnightText10::
if DEF(_FR_FR)
	text_start
	line "…"
	done
else
	text "…"
	done
endc

_BuenaOffTheAirText::
	text_start
	line ""
	done

_EnemyWithdrewText::
if DEF(_FR_FR)
	text "<ENEMY>"
	line "retire"
	cont "@"
	text_ram wEnemyMonNickname
	text "!"
	prompt
else
	text "<ENEMY>"
	line "withdrew"
	cont "@"
	text_ram wEnemyMonNickname
	text "!"
	prompt
endc

_EnemyUsedOnText::
if DEF(_FR_FR)
	text "<ENEMY>"
	line "utilise"
	cont "@"
	text_ram wMonOrItemNameBuffer
	text " sur"
	cont "@"
	text_ram wEnemyMonNickname
	text "!"
	prompt
else
	text "<ENEMY>"
	line "used @"
	text_ram wMonOrItemNameBuffer
	text_start
	cont "on @"
	text_ram wEnemyMonNickname
	text "!"
	prompt
endc

_NewCardArrivedText::
if DEF(_FR_FR)
	text_start
	done
else
	text "A new CARD arrived"
	line "from @"
	text_ram wStringBuffer2
	text "."
	done
endc

_PutCardInCardFolderText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Put this CARD in"
	line "the CARD FOLDER?"
	done
endc

_CardWasListedText::
if DEF(_FR_FR)
	text_start
	prompt
else
	text_ram wStringBuffer2
	text "'s CARD was"
	line "listed as no.@"
	text_decimal wStringBuffer1, 1, 2
	text "."
	prompt
endc

_StartingLinkText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Starting link."
	done
endc

_LinkTerminatedText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Link terminated."
	done
endc

_ClosingLinkText::
if DEF(_FR_FR)
	text_start
	done
else
	text "Closing link."
	done
endc

_TradingMonForOTMonText::
if DEF(_FR_FR)
	text "Echange @"
	text_ram wStringBuffer2
	text_start
	line "contre @"
	text_ram wStringBuffer1
	text "…"
	done
else
	text "Trading @"
	text_ram wStringBuffer2
	text_start
	line "for @"
	text_ram wStringBuffer1
	text "…"
	done
endc

_AskFloorElevatorText::
if DEF(_FR_FR)
	text "Quel étage?"
	done
else
	text "Which floor?"
	done
endc

_BugCatchingContestTimeUpText::
if DEF(_FR_FR)
	text "PRESENTATEUR: BIP!"
	
	para "Temps écoulé!"
	done
else
	text "ANNOUNCER: BEEEP!"
	
	para "Time's up!"
	done
endc

_BugCatchingContestIsOverText::
if DEF(_FR_FR)
	text "PRESENTATEUR: Le"
	line "concours est fini!"
	done
else
	text "ANNOUNCER: The"
	line "Contest is over!"
	done
endc

_RepelWoreOffText::
if DEF(_FR_FR)
	text "Effet du REPOUSSE"
	line "terminé."
	done
else
	text "REPEL's effect"
	line "wore off."
	done
endc

_UseAnotherRepelText:: ; TO TRANSLATE
	text "@"
	text_ram wStringBuffer3
	text "'s"
	line "effect wore off."

	para "Use another?"
	done

_PlayerFoundItemText::
if DEF(_FR_FR)
	text "<PLAYER> trouve"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "<PLAYER> found"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc

_ButNoSpaceText::
if DEF(_FR_FR)
	text "Mais <PLAYER> n'a"
	line "plus de place..."
	done
else
	text "But <PLAYER> has"
	line "no space left…"
	done
endc

_JustSawSomeRareMonText::
if DEF(_FR_FR)
	text "J'ai vu un"
	line "@"
	text_ram wStringBuffer1
	text " rare"
	cont "vers @"
	text_ram wStringBuffer2
	text "."
	
	para "Je t'appelle si je"
	line "vois un autre"
	cont "#MON rare, OK?"
	prompt
else
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
endc

_SavingRecordText::
if DEF(_FR_FR)
	text "SAUVEGARDE..."
	line "NE PAS ETEINDRE!"
	done
else
	text "SAVING RECORD…"
	line "DON'T TURN OFF!"
	done
endc

_ReceiveItemText::
if DEF(_FR_FR)
	text_ram wPlayerName
	text " reçoit"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	sound_item
	text_promptbutton
	text_end
else
	text_ram wPlayerName
	text " received"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	sound_item
	text_promptbutton
	text_end
endc

_NoCoinsText::
if DEF(_FR_FR)
	text "Vous n'avez pas de"
	line "jetons."
	prompt
else
	text "You have no coins."
	prompt
endc

_NoCoinCaseText::
if DEF(_FR_FR)
	text "Vous n'avez pas de"
	line "BOITE JETON."
	prompt
else
	text "You don't have a"
	line "COIN CASE."
	prompt
endc

_NPCTradeCableText::
if DEF(_FR_FR)
	text "OK, connectez le"
	line "Câble Game Link."
	prompt
else
	text "OK, connect the"
	line "Game Link Cable."
	prompt
endc

Text_NPCTraded::
if DEF(_FR_FR)
	text "<PLAYER> échange"
	line "@"
	text_ram wStringBuffer2
	text " contre"
	cont "@"
	text_ram wMonOrItemNameBuffer
	text ".@"
	text_end
else
	text "<PLAYER> traded"
	line "@"
	text_ram wMonOrItemNameBuffer
	text " for"
	cont "@"
	text_ram wStringBuffer2
	text ".@"
	text_end
endc

_NPCTradeFanfareText::
	sound_dex_fanfare_80_109
	text_pause
	text_end

_NPCTradeIntroText1::
if DEF(_FR_FR)
	text "Je collectionne"
	line "les #MON. As-tu"
	cont "@"
	text_ram wStringBuffer1
	text "?"
	
	para "Tu veux l'échanger"
	line "contre @"
	text_ram wStringBuffer2
	text "?"
	done
else
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
endc

_NPCTradeCancelText1::
if DEF(_FR_FR)
	text "Pas d'échange?"
	line "Maiiiiiis!!!"
	done
else
	text "You don't want to"
	line "trade? Aww…"
	done
endc

_NPCTradeWrongText1::
if DEF(_FR_FR)
	text "Hein? C'est pas"
	line "@"
	text_ram wStringBuffer1
	text ". "
	cont "Tu plaisantes...?"
	done
else
	text "Huh? That's not"
	line "@"
	text_ram wStringBuffer1
	text ". "
	cont "What a letdown…"
	done
endc

_NPCTradeCompleteText1::
if DEF(_FR_FR)
	text "Ouais! J'ai un"
	line "@"
	text_ram wStringBuffer1
	text "!"
	cont "Cool!"
	done
else
	text "Yay! I got myself"
	line "@"
	text_ram wStringBuffer1
	text "!"
	cont "Thanks!"
	done
endc

_NPCTradeAfterText1::
if DEF(_FR_FR)
	text "Comment va mon"
	line "@"
	text_ram wStringBuffer2
	text "?"
	done
else
	text "Hi, how's my old"
	line "@"
	text_ram wStringBuffer2
	text " doing?"
	done
endc

_NPCTradeIntroText2::
if DEF(_FR_FR)
	text "Salut! Je cherche"
	line "ce #MON."
	
	para "Si tu as"
	line "@"
	text_ram wStringBuffer1
	text ","
	
	para "peux-tu l'échanger"
	line "contre @"
	text_ram wStringBuffer2
	text "?"
	done
else
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
endc

_NPCTradeCancelText2::
if DEF(_FR_FR)
	text "T'en as pas non"
	line "plus?"
	
	para "Pfff...."
	line "Et zut..."
	done
else
	text "You don't have"
	line "one either?"
	
	para "Gee, that's really"
	line "disappointing…"
	done
endc

_NPCTradeWrongText2::
if DEF(_FR_FR)
	text "Tu n'as pas"
	line "@"
	text_ram wStringBuffer1
	text "?"
	cont "C'est dommage."
	done
else
	text "You don't have"
	line "@"
	text_ram wStringBuffer1
	text "? That's"
	cont "too bad, then."
	done
endc

_NPCTradeCompleteText2::
if DEF(_FR_FR)
	text "Cool! Merci!"
	
	para "J'ai enfin"
	line "@"
	text_ram wStringBuffer1
	text "."
	done
else
	text "Great! Thank you!"
	
	para "I finally got"
	line "@"
	text_ram wStringBuffer1
	text "."
	done
endc

_NPCTradeAfterText2::
if DEF(_FR_FR)
	text "Salut! @"
	text_ram wMonOrItemNameBuffer
	text_start
	line "est en pleine for-"
	cont "me! Merci encore!"
	done
else
	text "Hi! The @"
	text_ram wMonOrItemNameBuffer
	text_start
	line "you traded me is"
	cont "doing great!"
	done
endc

_NPCTradeIntroText3::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text " est"
	line "mignon mais je"
	
	para "l'ai pas. Toi t'as"
	line "@"
	text_ram wStringBuffer1
	text "?"
	
	para "Tu veux l'échanger"
	line "contre @"
	text_ram wStringBuffer2
	text "?"
	done
else
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
endc

_NPCTradeCancelText3::
if DEF(_FR_FR)
	text "Tu veux pas échan-"
	line "ger? Bah mince..."
	done
else
	text "You don't want to"
	line "trade? Oh, darn…"
	done
endc

_NPCTradeWrongText3::
if DEF(_FR_FR)
	text "C'est pas"
	line "@"
	text_ram wStringBuffer1
	text "."
	
	para "Amène-m'en un, par"
	line "pitié!!!"
	done
else
	text "That's not"
	line "@"
	text_ram wStringBuffer1
	text "."
	
	para "Please trade with"
	line "me if you get one."
	done
endc

_NPCTradeCompleteText3::
if DEF(_FR_FR)
	text "Woah! Merci!"
	line "Je voulais tant un"
	cont "@"
	text_ram wMonOrItemNameBuffer
	text "!"
	done
else
	text "Wow! Thank you!"
	line "I always wanted"
	cont "@"
	text_ram wMonOrItemNameBuffer
	text "!"
	done
endc

_NPCTradeAfterText3::
if DEF(_FR_FR)
	text "Comment va mon"
	line "@"
	text_ram wStringBuffer2
	text "?"
	cont "Toujours la pêche?"
	
	para "Ton @"
	text_ram wMonOrItemNameBuffer
	text_start
	line "est si mignon!"
	done
else
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
endc

_NPCTradeCompleteText4::
if DEF(_FR_FR)
	text "Bah alors?"
	done
else
	text "Uh? What happened?"
	done
endc

_NPCTradeAfterText4::
if DEF(_FR_FR)
	text "Echanger c'est"
	line "trop bizarre..."
	
	para "J'ai beaucoup à"
	line "apprendre."
	done
else
	text "Trading is so odd…"
	
	para "I still have a lot"
	line "to learn about it."
	done
endc

_MomLeavingText1::
if DEF(_FR_FR)
	text "Oh! Quel joli"
	line "#MON."
	
	para "Où l'as-tu trouvé?"
	line "Hein? Où ça?"
	
	para "........."
	
	para "Alors t'aimes"
	line "l'aventure, quoi."
	
	para "OK!"
	line "J'vais t'aider."
	
	para "Mais..."
	line "Que faire?"
	
	para "Je sais! Je vais"
	line "économiser pour"
	cont "toi."
	
	para "L'argent, c'est"
	line "important."
	
	para "Veux-tu que j'éco-"
	line "nomise pour toi?"
	done
else
	text "Wow, that's a cute"
	line "#MON."
	
	para "Where did you get"
	line "it?"
	
	para "…"
	
	para "So, you're leaving"
	line "on an adventure…"
	
	para "OK!"
	line "I'll help too."
	
	para "But what can I do"
	line "for you?"
	
	para "I know! I'll save"
	line "money for you."
	
	para "On a long journey,"
	line "money's important."
	
	para "Do you want me to"
	line "save your money?"
	done
endc

_MomLeavingText2::
if DEF(_FR_FR)
	text "OK, je vais m'oc-"
	line "cuper de tes sous."
	
	para ".................."
	prompt
else
	text "OK, I'll take care"
	line "of your money."
	
	para "<……><……><……>"
	prompt
endc

_MomLeavingText3::
if DEF(_FR_FR)
	text "Fais attention."
	
	para "Les #MON sont"
	line "tes amis. Il faut"
	cont "les aimer aussi."
	
	para "En route!"
	done
else
	text "Be careful."
	
	para "#MON are your"
	line "friends. You need"
	cont "to work as a team."
	
	para "Now, go on!"
	done
endc

_MomIsThisAboutYourMoneyText::
if DEF(_FR_FR)
	text "Bienvenue!"
	line "Tu fais des"
	cont "efforts... C'est"
	cont "dur l'aventure!"
	
	para "J'ai rangé ta"
	line "chambre."
	
	para "Est-ce à propos"
	line "de l'argent?"
	done
else
	text "Hi! Welcome home!"
	line "You're trying very"
	cont "hard, I see."
	
	para "I've kept your"
	line "room tidy."
	
	para "Or is this about"
	line "your money?"
	done
endc

_MomBankWhatDoYouWantToDoText::
if DEF(_FR_FR)
	text "Que veux-tu"
	line "faire?"
	done
else
	text "What do you want"
	line "to do?"
	done
endc

_MomStoreMoneyText::
if DEF(_FR_FR)
	text "Combien veux-tu"
	line "économiser?"
	done
else
	text "How much do you"
	line "want to save?"
	done
endc

_MomTakeMoneyText::
if DEF(_FR_FR)
	text "Combien veux-tu"
	line "prendre?"
	done
else
	text "How much do you"
	line "want to take?"
	done
endc

_MomSaveMoneyText::
if DEF(_FR_FR)
	text "Veux-tu économiser"
	line "de l'argent?"
	done
else
	text "Do you want to"
	line "save some money?"
	done
endc

_MomHaventSavedThatMuchText::
if DEF(_FR_FR)
	text "Tu n'as pas écono-"
	line "misé autant."
	prompt
else
	text "You haven't saved"
	line "that much."
	prompt
endc

_MomNotEnoughRoomInWalletText::
if DEF(_FR_FR)
	text "Tu ne peux en"
	line "prendre autant."
	prompt
else
	text "You can't take"
	line "that much."
	prompt
endc

_MomInsufficientFundsInWalletText::
if DEF(_FR_FR)
	text "Tu n'en as pas"
	line "autant."
	prompt
else
	text "You don't have"
	line "that much."
	prompt
endc

_MomNotEnoughRoomInBankText::
if DEF(_FR_FR)
	text "Tu ne peux en"
	line "économiser autant."
	prompt
else
	text "You can't save"
	line "that much."
	prompt
endc

_MomStartSavingMoneyText::
if DEF(_FR_FR)
	text "OK, je vais écono-"
	line "miser ton argent."
	cont "Aie confiance!"
	
	para "<PLAYER>,"
	line "tiens bon!"
	done
else
	text "OK, I'll save your"
	line "money. Trust me!"
	
	para "<PLAYER>, stick"
	line "with it!"
	done
endc

_MomStoredMoneyText::
if DEF(_FR_FR)
	text "Je m'occupe de tes"
	line "sous! Va!"
	done
else
	text "Your money's safe"
	line "here! Get going!"
	done
endc

_MomTakenMoneyText::
if DEF(_FR_FR)
	text "<PLAYER>,"
	line "courage!"
	done
else
	text "<PLAYER>, don't"
	line "give up!"
	done
endc

_MomJustDoWhatYouCanText::
if DEF(_FR_FR)
	text "Fais de ton"
	line "mieux."
	done
else
	text "Just do what"
	line "you can."
	done
endc

_DaycareDummyText::
	text_start
	done

_DayCareManIntroText::
if DEF(_FR_FR)
	text "Je m'occupe de la"
	line "PENSION. Veux-tu"
	cont "que j'entraîne un"
	cont "#MON?"
	done
else
	text "I'm the DAY-CARE"
	line "MAN. Want me to"
	cont "raise a #MON?"
	done
endc

_DayCareManIntroEggText::
if DEF(_FR_FR)
	text "Je m'occupe de la"
	line "PENSION. Connais-"
	cont "tu les OEUFS?"
	
	para "J'élevais des"
	line "#MON avec"
	cont "ma femme et..."
	
	para "Surprise! On a"
	line "trouvé un OEUF!"
	
	para "C'est super dingue"
	line "comme truc!"
	
	para "Alors tu veux que"
	line "j'entraîne un"
	cont "#MON?"
	done
else
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
endc

_DayCareLadyIntroText::
if DEF(_FR_FR)
	text "Je suis la femme"
	line "du type qui"
	cont "s'occupe de la"
	cont "PENSION."
	
	para "Veux-tu que"
	line "j'entraîne un"
	cont "#MON?"
	done
else
	text "I'm the DAY-CARE"
	line "LADY."
	
	para "Should I raise a"
	line "#MON for you?"
	done
endc

_DayCareLadyIntroEggText::
if DEF(_FR_FR)
	text "Je suis la femme"
	line "du type qui"
	cont "s'occupe de la"
	cont "PENSION. Connais-"
	cont "tu les OEUFS?"
	
	para "J'élevais des"
	line "#MON avec"
	cont "mon mari et..."
	
	para "Surprise! On a"
	line "trouvé un OEUF!"
	
	para "C'est super dingue"
	line "comme truc!"
	
	para "Alors tu veux que"
	line "j'entraîne un"
	cont "#MON?"
	done
else
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
endc

_WhatShouldIRaiseText::
if DEF(_FR_FR)
	text "Qui veux-tu que"
	line "j'entraîne?"
	prompt
else
	text "What should I"
	line "raise for you?"
	prompt
endc

_OnlyOneMonText::
if DEF(_FR_FR)
	text "Oh? Mais tu n'as"
	line "qu'un #MON."
	prompt
else
	text "Oh? But you have"
	line "just one #MON."
	prompt
endc

_CantAcceptEggText::
if DEF(_FR_FR)
	text "Ah... Je n'accepte"
	line "pas les OEUFS."
	prompt
else
	text "Sorry, but I can't"
	line "accept an EGG."
	prompt
endc

_RemoveMailText::
if DEF(_FR_FR)
	text "Enlève les LETTRES"
	line "avant de me voir."
	prompt
else
	text "Remove MAIL before"
	line "you come see me."
	prompt
endc

_LastHealthyMonText::
if DEF(_FR_FR)
	text "Si tu me le donnes"
	line "qui va combattre"
	cont "pour toi?"
	prompt
else
	text "If you give me"
	line "that, what will"
	cont "you battle with?"
	prompt
endc

_IllRaiseYourMonText::
if DEF(_FR_FR)
	text "Entendu. Je vais"
	line "entraîner ton"
	cont "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "OK. I'll raise"
	line "your @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_ComeBackLaterText::
if DEF(_FR_FR)
	text "Reviens le prendre"
	line "plus tard."
	done
else
	text "Come back for it"
	line "later."
	done
endc

_AreWeGeniusesText::
if DEF(_FR_FR)
	text "On est trop bon!"
	line "Tu veux voir"
	cont "ton @"
	text_ram wStringBuffer1
	text "?"
	done
else
	text "Are we geniuses or"
	line "what? Want to see"
	cont "your @"
	text_ram wStringBuffer1
	text "?"
	done
endc

_YourMonHasGrownText::
if DEF(_FR_FR)
	text "Ton @"
	text_ram wStringBuffer1
	text_start
	line "a bien grandi."
	
	para "Il a gagné"
	line "@"
	text_decimal wStringBuffer2 + 1, 1, 3
	text " niveau(x)."
	
	para "Si tu veux récupé-"
	line "rer ton #MON,"
	cont "tu dois payer"
	cont "@"
	text_decimal wStringBuffer2 + 2, 3, 4
	text "¥."
	done
else
	text "Your @"
	text_ram wStringBuffer1
	text_start
	line "has grown a lot."
	
	para "By level, it's"
	line "grown by @"
	text_decimal wStringBuffer2 + 1, 1, 3
	text "."
	
	para "If you want your"
	line "#MON back, it"
	cont "will cost ¥@"
	text_decimal wStringBuffer2 + 2, 3, 4
	text "."
	done
endc

_PerfectHeresYourMonText::
if DEF(_FR_FR)
	text "Parfait! Voilà"
	line "ton #MON."
	prompt
else
	text "Perfect! Here's"
	line "your #MON."
	prompt
endc

_GotBackMonText::
if DEF(_FR_FR)
	text "<PLAYER> récupère"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "<PLAYER> got back"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_BackAlreadyText::
if DEF(_FR_FR)
	text "Hein? Déjà?"
	line "Ton @"
	text_ram wStringBuffer1
	text_start
	para "a besoin de plus"
	line "de temps! Pour"
	
	para "récupérer ton"
	line "#MON, tu dois"
	cont "payer 100¥."
	done
else
	text "Huh? Back already?"
	line "Your @"
	text_ram wStringBuffer1
	text_start
	para "needs a little"
	line "more time with us."
	
	para "If you want your"
	line "#MON back, it"
	cont "will cost ¥100."
	done
endc

_HaveNoRoomText::
if DEF(_FR_FR)
	text "Tu n'as pas de"
	line "place."
	prompt
else
	text "You have no room"
	line "for it."
	prompt
endc

_NotEnoughMoneyText::
if DEF(_FR_FR)
	text "Tu n'as pas assez"
	line "d'argent."
	prompt
else
	text "You don't have"
	line "enough money."
	prompt
endc

_OhFineThenText::
if DEF(_FR_FR)
	text "Très bien."
	prompt
else
	text "Oh, fine then."
	prompt
endc

_ComeAgainText::
if DEF(_FR_FR)
	text "A bientôt."
	done
else
	text "Come again."
	done
endc

_DayCare_RumorsText:: ; TO TRANSLATE
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

_DayCare_LooksLikeVirusText:: ; TO TRANSLATE
	text "This #MON"
	line "looks like a giant"
	cont "virus, and I'm"
	cont "superstitious…"

	para "I can't raise this"
	line "#MON, sorry."
	prompt

_DayCare_BadShapeText:: ; TO TRANSLATE
	text "Your #MON"
	line "appears to be"
	cont "sick. I can't"
	cont "take care of it."
	prompt

_DayCare_HasCovidText:: ; TO TRANSLATE
	text "Wait…"

	para "Your #MON is"
	line "infected by the"
	cont "virus?!?"

	para "GET OUT OF"
	line "MY HOUSE, NOW!"
	done

_NotYetText::
if DEF(_FR_FR)
	text "Pas encore..."
	done
else
	text "Not yet…"
	done
endc

_FoundAnEggText::
if DEF(_FR_FR)
	text "Ah, c'est toi!"
	
	para "On entraînait ton"
	line "#MON, et..."
	cont "Surprise totale!"
	
	para "Ton #MON a"
	line "pondu un OEUF!"
	
	para "On sait pas trop"
	line "comment mais..."
	
	para "Il est là en tout"
	line "cas. Tu le veux?"
	done
else
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
endc

_ReceivedEggText::
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "l'OEUF!"
	done
else
	text "<PLAYER> received"
	line "the EGG!"
	done
endc

_TakeGoodCareOfEggText::
if DEF(_FR_FR)
	text "Prends-en soin!"
	done
else
	text "Take good care of"
	line "it."
	done
endc

_IllKeepItThanksText::
if DEF(_FR_FR)
	text "Bon ben..."
	line "J'le garde. Merci!"
	done
else
	text "Well then, I'll"
	line "keep it. Thanks!"
	done
endc

_NoRoomForEggText::
if DEF(_FR_FR)
	text "Tu n'as pas de"
	line "place dans ton"
	cont "équipe..."
	done
else
	text "You have no room"
	line "in your party."
	cont "Come back later."
	done
endc

_WhichMonPhotoText::
if DEF(_FR_FR)
	text "Quel #MON"
	line "dois-je photogra-"
	cont "phier?"
	prompt
else
	text "Which #MON"
	line "should I photo-"
	cont "graph?"
	prompt
endc

_HoldStillText::
if DEF(_FR_FR)
	text "Parfait. Parfait."
	line "On ne bouge plus."
	prompt
else
	text "All righty. Hold"
	line "still for a bit."
	prompt
endc

_PrestoAllDoneText::
if DEF(_FR_FR)
	text "Fini! Terminé!"
	line "A bientôt!"
	done
else
	text "Presto! All done."
	line "Come again, OK?"
	done
endc

_GymGuideEggText:: ; TO TRANSLATE
	text "EGGS are not"
	line "allowed in a GYM."

	para "We never know"
	line "what could hatch"
	cont "from it."
	done

_MissedItemText:: ; TO TRANSLATE
	text "Hey! There's a"
	line "lone item in the"
	cont "back of the shelf!"
	prompt

_MissedItemSingle:: ; TO TRANSLATE
	text "It's a single"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt

_MissedItemBundle:: ; TO TRANSLATE
	text "It's a pack of"
	line "@"
	text_ram wStringBuffer2
	text " @"
	text_ram wStringBuffer1
	text "S."
	prompt

_MissedItemPrice:: ; TO TRANSLATE
	text "The price is only"
	line "@"
	text_ram wStringBuffer3
	text "! Buy it?"
	done


; Mewtwo dialogs in Cerulean Cave.

; B1F, in order. Theme = asking politely to leave.
; Shortest path = 121 steps.

_MewtwoB1FText1:: ; TO TRANSLATE
	text "I can feel your"
	line "presence."

	para "The outside world"
	line "is not allowed in"
	cont "here."

	para "Go back where"
	line "you came from."
	done

_MewtwoB1FText2:: ; TO TRANSLATE
	text "I know why you"
	line "came."

	para "You will only"
	line "find regrets."
	done

_MewtwoB1FText3:: ; TO TRANSLATE
	text "Leave this place"
	line "at once."

	para "You have been"
	line "warned."
	done

_MewtwoB1FText4:: ; TO TRANSLATE
	text "If you keep going"
	line "forward, there"

	para "will be no way"
	line "out for you."
	done

; B2F, in order. Theme = big reveals. Beginning threats.
; Shortest path = 73 steps.
_MewtwoB2FText1:: ; TO TRANSLATE
	text "I made this place"
	line "collapse so I"
	cont "could be"
	cont "contained."

	para "No one should come"
	line "in or go out of"
	cont "this place."
	done

_MewtwoB2FText2:: ; TO TRANSLATE
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

_MewtwoB2FText3:: ; TO TRANSLATE
	text "I sent the avatar"
	line "of fire to unleash"
	cont "the volcano's power"
	cont "and destroy their"
	cont "laboratory."

	para "Don't force me to"
	line "destroy you."
	done

_MewtwoB2FText4:: ; TO TRANSLATE
	text "Another one came"
	line "before you."

	para "He brought doom"
	line "on himself."

	para "Don't make the"
	line "same mistake."
	done

; B3F, random. Theme = discouraging fight with threats. Trying to be convincing by showing good intentions.
; Shortest path = 123 steps.
_MewtwoB3FText1:: ; TO TRANSLATE
	text "Don't approach me,"
	line "I am dangerous."
	done

_MewtwoB3FText2:: ; TO TRANSLATE
	text "I don't want to"
	line "fight you."

	para "For your own"
	line "protection."
	done

_MewtwoB3FText3:: ; TO TRANSLATE
	text "Why don't you"
	line "listen to me?"

	para "I will show you"
	line "no mercy."
	done

_MewtwoB3FText4:: ; TO TRANSLATE
	text "They built me as a"
	line "weapon of mass"
	cont "destruction."

	para "I just want peace."
	line "Leave me."
	done

_MewtwoB3FText5:: ; TO TRANSLATE
	text "Stop chasing me."

	para "You will forever"
	line "regret it."
	done

_MewtwoB3FText6:: ; TO TRANSLATE
	text "I will be your"
	line "end, and you will"
	cont "be the end of"
	cont "yours species."

	para "This is my curse."
	done

_MewtwoB3FText7:: ; TO TRANSLATE
	text "Go out of this"
	line "cave. Now."

	para "Don't make your"
	line "#MON suffer."
	done

_MewtwoB3FText8:: ; TO TRANSLATE
	text "Tame your primal"
	line "instincts, human."

	para "For you own good."

	para "Your greed for"
	line "power will be"
	cont "your downfall."
	done

_WeakGroundText:: ; TO TRANSLATE
	text "The ground's weak."
	para "Enough weight over"
	line "it will make it"
	cont "collapse."
	done

_WeakGroundCollapsedText:: ; TO TRANSLATE
	text "The weak ground"
	line "collapsed under"
	cont "the weight of"
	cont "the boulders."
	done

_TradebackGuyIntroText:: ; TO TRANSLATE
	text "Hey wanna trade"
	line "with me?"

	para "Send me a #MON,"
	line "and I'll send it"
	cont "right back at ya'."
	done

_TradebackGuyAnotherTimeText:: ; TO TRANSLATE
	text "Maybe another day."
	done

_TradebackGuyConfusedText:: ; TO TRANSLATE
	text "Oh… really?"
	line "Phat!"

	para "… I mean… I'm"
	line "making you a favor"
	cont "and I think I"
	cont "deserve a…"

	para "Uh…"

	para "Let me think."
	done

_TradebackGuyDealText:: ; TO TRANSLATE
	text "I want a"
	line "@"
	text_ram wStringBuffer3
	text "."

	para "Give me one, and"
	line "we have a deal."
	done

_TradebackGuyDealBrokenText:: ; TO TRANSLATE
	text "Shoot! I should've"
	line "asked for some-"
	cont "thing cheaper."
	done

_TradebackGuyDontHaveItemText:: ; TO TRANSLATE
	text "But you don't"
	line "have one!"

	para "I thought you were"
	line "a real trainer…"
	done

_TradebackPlayerGivesItemText:: ; TO TRANSLATE
	text "<PLAYER> gave 1"
	line "@"
	text_ram wStringBuffer3
	text "."
	done

_TradebackGuyDealOkText:: ; TO TRANSLATE
	text "For real? I can"
	line "have it?"
	cont "Thanks!"

	para "Let's do it then!"
	done

_TradebackGuyKeepPaymentText:: ; TO TRANSLATE
	text "Changed your"
	line "mind?"

	para "Your problem!"

	para "I'm keeping your"
	line "gift, thanks."
	done

_TradebackGuyDealNoEvoText:: ; TO TRANSLATE
	text "It didn't evolve."
	line "Boring."
	done

_TradebackGuyDealEvoText:: ; TO TRANSLATE
	text "Wow!"
	line "This evolution"
	cont "was the bomb!"

	para "I can't wait to"
	line "tell MICKEY"
	cont "about it!"
	done

ClosedBusinessText:: ; TO TRANSLATE
	text "There is a notice"
	line "on the door…"

	para "“Due to the"
	line "sanitary crisis,"

	para "our establishment"
	line "must remain closed"

	para "until further"
	line "notice.”"
	done

ClosedBusinessCurfewText:: ; TO TRANSLATE
	text "There is a notice"
	line "on the door…"

	para "“Our establishment"
	line "will reopen tomor-"

	para "row morning, after"
	line "the curfew.”"
	done

ElmsLabBookshelf1Text:: ; TO TRANSLATE
	text "TRAINER TIPS"

	para "Keep the Down"
	line "button pressed"
	cont "to fast forward"
	cont "dialogs!"
	done

ElmsLabBookshelf2Text:: ; TO TRANSLATE
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

ElmsLabBookshelf3Text:: ; TO TRANSLATE
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

ElmsLabBookshelf4Text:: ; TO TRANSLATE
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

ElmsLabBookshelf5Text:: ; TO TRANSLATE
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

ElmsLabBookshelf6Text:: ; TO TRANSLATE
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

ElmsLabBookshelf7Text:: ; TO TRANSLATE
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

ElmsLabBookshelf8Text:: ; TO TRANSLATE
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

_RTCErrorText:: ; TO TRANSLATE
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

Pokecenter1F_ThanksForSupport:: ; TO TRANSLATE
	text "Thank you for"
	line "your support to"
	cont "the healthcare"
	cont "personnel."
	done

FreePCRTestAfterClappingText:: ; TO TRANSLATE
	text "… but testing is"
	line "important."
	para "It's on me."
	done

GoldenrodHospital1F_ClappedText:: ; TO TRANSLATE
	text "In the name of"
	line "all employees of"
	cont "this hospital,"

	para "thank you for"
	line "showing support."

	para "It helps us all"
	line "to stay motivated"
	cont "in these difficult"
	cont "times."
	done

GoldenrodHospitalCorridorNurse1ClappedText:: ; TO TRANSLATE
	text "Thanks for showing"
	line "support."

	para "But this is not"
	line "helping. Taking"
	cont "action would help."
	done

GoldenrodHospitalRoom7PatientClapText:: ; TO TRANSLATE
	text "Stop clapping!"
	line "You're making me"
	cont "blush!"
	done

GoldenrodHospitalRoom7VisitorClapText:: ; TO TRANSLATE
	text "Your support is"
	line "appreciated!"
	done

GoldenrodHospitalRoom7VisitorClap2Text:: ; TO TRANSLATE
	text "I want to match"
	line "your kindness!"
	done

GoldenrodHospitalRoom13VisitorClapText:: ; TO TRANSLATE
	text "Thank you for the"
	line "cheering! I'll keep"
	cont "working very hard."
	done

_Clapping1Text:: ; TO TRANSLATE
	text "*clap* *clap*"
	line " *clap* *clap*"
	done

_Clapping2Text:: ; TO TRANSLATE
	text " *clap* *clap*"
	line "*clap* *clap*"
	done

_Clapping3Text:: ; TO TRANSLATE
	text "*clap* *clap*"

	para "I wonder how long"
	line "this clapping"
	cont "will last."
	done

_Clapping4Text:: ; TO TRANSLATE
	text "*clap* *clap*"

	para "If you support"
	line "healthcare workers"
	cont "then clap along!"
	done

_Clapping5Text:: ; TO TRANSLATE
	text "*clap* *clap*"

	para "My hands hurt."
	done

_Clapping6Text:: ; TO TRANSLATE
	text "*clap* *clap*"

	para "Why are we all"
	line "clapping already?"
	done

_Clapping7Text:: ; TO TRANSLATE
	text "*clap* *clap*"

	para "Clapping may not"
	line "be helpful… but"
	cont "it sure is fun!"
	done

_Clapping8Text:: ; TO TRANSLATE
	text "*clap* *clap*"

	para "Healthcare workers"
	line "are the frontline"
	cont "in the war against"
	cont "COVID."

	para "Everyday they risk"
	line "their lives with"
	cont "the virus."

	para "True heroes."
	done

ItemfinderExplanationText:: ; TO TRANSLATE
	text "There are many"
	line "items lying about"

	para "that aren't ob-"
	line "vious."

	para "Use ITEMFINDER to"
	line "check if there is"

	para "an item on the"
	line "ground near you."

	para "It doesn't show"
	line "the exact spot,"

	para "but the closer you"
	line "get, the faster"
	cont "it beeps!"

	para "Oh yeah--I heard"
	line "there are items"

	para "in ECRUTEAK's"
	line "BURNED TOWER."
	done
