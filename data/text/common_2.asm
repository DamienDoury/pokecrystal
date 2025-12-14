_NoPhotoText::
if DEF(_FR_FR)
	text "Pas de photo?"
	line "A plus tard!"
	done
else
	text "Oh, no picture?"
	line "Come again, OK?"
	done
endc

_EggPhotoText::
if DEF(_FR_FR)
	text "Un OEUF? Je peux"
	line "pas faire de l'art"
	cont "avec ça..."
	done
else
	text "An EGG? My talent"
	line "is worth more…"
	done
endc

_MonNotCuteText::
if DEF(_FR_FR)
	text "Nan. Certains de"
	line "tes #MON ne"
	cont "sont pas mignons."
	prompt
else
	text "Nah. Some of your"
	line "#MON aren't"
	cont "cute."
	prompt
endc

_MonNotCuteInstanceSingleText::
if DEF(_FR_FR)
	text "Je n'aime pas"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "I don't like"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_MonNotCuteInstanceFirstText::
if DEF(_FR_FR)
	text "Je n'aime pas"
	line "@"
	text_ram wStringBuffer1
	text ","
	prompt
else
	text "I don't like"
	line "@"
	text_ram wStringBuffer1
	text ","
	prompt
endc

_MonNotCuteInstance2Text::
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer2
	text ","
	line "@"
	text_ram wStringBuffer1
	text ","
	prompt
else
	text "@"
	text_ram wStringBuffer2
	text ","
	line "@"
	text_ram wStringBuffer1
	text ","
	prompt
endc

_MonNotCuteInstanceLast1Text::
if DEF(_FR_FR)
	text "et @"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "and @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_MonNotCuteInstanceLast2Text::
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer2
	text ","
	line "et @"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "@"
	text_ram wStringBuffer2
	text ","
	line "and @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_MonNotCuteEndText::
if DEF(_FR_FR)
	text "La flemme d'expli-"
	line "quer ce qui fait"
	
	para "qu'un #MON"
	line "est mignon."

	para "Demande au GUIDE"
	line "à l'entrée."

	para "Reviens avec une"
	line "équipe mignonne,"

	para "ou je refuserai"
	line "de t'affronter."
	done
else
	text "I won't bother"
	line "explaining what"
	cont "makes a #MON"
	cont "cute."

	para "Ask the GYM GUIDE"
	line "at the entrance."

	para "Come back with a"
	line "party of cuties,"

	para "or I won't accept"
	line "your challenge."
	done
endc	

_NameRaterHelloText::
if DEF(_FR_FR)
	text "B'jour! Je suis le"
	line "SPECIALISTE des"
	
	para "NOMS. Je donne mon"
	line "avis sur les noms"
	cont "des #MON."
	
	para "Veux-tu que je te"
	line "donne mon avis sur"
	cont "tes noms?"
	done
else
	text "Hello, hello! I'm"
	line "the NAME RATER."
	
	para "I rate the names"
	line "of #MON."
	
	para "Would you like me"
	line "to rate names?"
	done
endc

_NameRaterWhichMonText::
if DEF(_FR_FR)
	text "Le nom de quel"
	line "#MON veux-tu"
	cont "que j'étudie?"
	prompt
else
	text "Which #MON's"
	line "nickname should I"
	cont "rate for you?"
	prompt
endc

_NameRaterBetterNameText::
if DEF(_FR_FR)
	text "Hmm... @"
	text_ram wStringBuffer1
	text "."
	line "C'est un nom"
	cont "ma foi correct."
	
	para "Mais pourquoi ne"
	line "pas lui donner"
	cont "plus de pêche?"
	
	para "Veux-tu lui donner"
	line "un autre nom?"
	done
else
	text "Hm… @"
	text_ram wStringBuffer1
	text "…"
	line "That's a fairly"
	cont "decent name."
	
	para "But, how about a"
	line "slightly better"
	cont "nickname?"
	
	para "Want me to give it"
	line "a better name?"
	done
endc

_NameRaterWhatNameText::
if DEF(_FR_FR)
	text "OK. Comment"
	line "allons-nous le"
	cont "nommer?"
	prompt
else
	text "All right. What"
	line "name should we"
	cont "give it, then?"
	prompt
endc

_NameRaterFinishedText::
if DEF(_FR_FR)
	text "C'est bien mieux"
	line "qu'avant!"
	
	para "Bien joué!"
	done
else
	text "That's a better"
	line "name than before!"
	
	para "Well done!"
	done
endc

_NameRaterComeAgainText::
if DEF(_FR_FR)
	text "OK. Reviens une"
	line "autre fois."
	done
else
	text "OK, then. Come"
	line "again sometime."
	done
endc

_NameRaterPerfectNameText::
if DEF(_FR_FR)
	text "Hmm... @"
	text_ram wStringBuffer1
	text "?"
	line "C'est un super"
	cont "nom! Terrible!"
	
	para "Prends bien soin"
	line "de @"
	text_ram wStringBuffer1
	text "."
	done
else
	text "Hm… @"
	text_ram wStringBuffer1
	text "?"
	line "What a great name!"
	cont "It's perfect."
	
	para "Treat @"
	text_ram wStringBuffer1
	text_start
	line "with loving care."
	done
endc

_NameRaterEggText::
if DEF(_FR_FR)
	text "Whoa! C'est juste"
	line "un OEUF."
	done
else
	text "Whoa… That's just"
	line "an EGG."
	done
endc

_NameRaterSameNameText::
if DEF(_FR_FR)
	text "Ca ressemble un"
	line "peu à l'ancien..."
	
	para "Mais c'est mieux"
	line "qu'avant!"
	
	para "Bien joué!"
	done
else
	text "It might look the"
	line "same as before,"
	
	para "but this new name"
	line "is much better!"
	
	para "Well done!"
	done
endc

_NameRaterNamedText::
if DEF(_FR_FR)
	text "Parfait. Ce"
	line "#MON s'appelle"
	cont "donc @"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "All right. This"
	line "#MON is now"
	cont "named @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

Text_Earned::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " prend@"
	text_end
else
	text_ram wStringBuffer1
	text " earned@"
	text_end
endc

Text_Gained::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " gagne@"
	text_end
else
	text_ram wStringBuffer1
	text " gained@"
	text_end
endc

Text_No_Xp_Gained::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " se sent"
	line "trop mal pour"
	cont "gagner de l'EXP..."
	prompt
else
	text_ram wStringBuffer1
	text " doesn't"
	line "feel good enough"
	cont "to gain any EXP.…"
	prompt
endc

_BoostedExpPointsText::
if DEF(_FR_FR)
	; BUG: Five-digit experience gain is printed incorrectly (see docs/bugs_and_glitches.md)
	text_start
	line "un bonus de"
	cont "@"
	text_decimal wStringBuffer2, 2, 5
	text " Points EXP!"
	prompt
else
	; BUG: Five-digit experience gain is printed incorrectly (see docs/bugs_and_glitches.md)
	text_start
	line "a boosted"
	cont "@"
	text_decimal wStringBuffer2, 2, 5
	text " EXP. Points!"
	prompt
endc

_ExpPointsText::
if DEF(_FR_FR)
	; BUG: Five-digit experience gain is printed incorrectly (see docs/bugs_and_glitches.md)
	text_start
	line "@"
	text_decimal wStringBuffer2, 2, 5
	text " Points EXP!"
	prompt
else
	; BUG: Five-digit experience gain is printed incorrectly (see docs/bugs_and_glitches.md)
	text_start
	line "@"
	text_decimal wStringBuffer2, 2, 5
	text " EXP. Points!"
	prompt
endc

_GoMonText::
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text "! Go!@"
	text_end
else
	text "Go! @"
	text_end
endc

_DoItMonText::
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text "! Fonce!@"
	text_end
else
	text "Do it! @"
	text_end
endc

_GoForItMonText::
if DEF(_FR_FR)
	text "En avant,"
	line "@"
	text_ram wBattleMonNickname
	text "!@"
	text_end
else
	text "Go for it,"
	line "@"
	text_end
endc

_YourFoesWeakGetmMonText::
if DEF(_FR_FR)
	text "Attaque,"
	line "@"
	text_ram wBattleMonNickname
	text "!@"
	text_end
else
	text "Your foe's weak!"
	line "Get'm, @"
	text_end
endc

_BattleMonNicknameText::
if DEF(_FR_FR)
	text_start
	done
else
	text_ram wBattleMonNickname
	text "!"
	done
endc

_BattleMonNickCommaText::
	text_ram wBattleMonNickname
	text ",@"
	text_end

_ThatsEnoughComeBackText::
if DEF(_FR_FR)
	text_start
	line "reviens!@"
	text_end
else
	text " that's"
	line "enough! Come back!@"
	text_end
endc

_OKComeBackText::
if DEF(_FR_FR)
	text_start
	line "ça suffit!@"
	text_end
else
	text " OK!"
	line "Come back!@"
	text_end
endc

_GoodComeBackText::
if DEF(_FR_FR)
	text_start
	line "reviens!@"
	text_end
else
	text " good!"
	line "Come back!@"
	text_end
endc

_ComeBackText::
if DEF(_FR_FR)
	text_start
	line "reviens!"
	done
else
	text " come"
	line "back!"
	done
endc

_ContainedMoveText::
if DEF(_FR_FR)
	text "Enseigner"
	line "@"
	text_ram wStringBuffer2
	text "?"
	done
else
	text "Teach @"
	text_ram wStringBuffer2
	text_start
	line "to a #MON?"
	done
endc

_TMHMNotCompatibleText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " n'est"
	line "pas compatible"
	cont "avec @"
	text_ram wStringBuffer1
	text "."
	
	para "Il ne peut pas"
	line "apprendre"
	cont "@"
	text_ram wStringBuffer2
	text "."
	prompt
else
	text_ram wStringBuffer2
	text " is"
	line "not compatible"
	cont "with @"
	text_ram wStringBuffer1
	text "."
	
	para "It can't learn"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
endc

_MysteryGiftCanceledText::
if DEF(_FR_FR)
	text "La connexion a"
	line "été perdue."
	prompt
else
	text "The link has been"
	line "cancelled."
	prompt
endc

_MysteryGiftCommErrorText::
if DEF(_FR_FR)
	text "Erreur"
	line "communication."
	prompt
else
	text "Communication"
	line "error."
	prompt
endc

_RetrieveMysteryGiftText::
if DEF(_FR_FR)
	text "CADEAU à récupérer"
	line "au CENTRE #MON."
	prompt
else
	text "Must retrieve GIFT"
	line "at #MON CENTER."
	prompt
endc

_YourFriendIsNotReadyText::
if DEF(_FR_FR)
	text "Votre ami(e) n'est"
	line "pas prêt(e)."
	prompt
else
	text "Your friend isn't"
	line "ready."
	prompt
endc

_MysteryGiftFiveADayText::
if DEF(_FR_FR)
	text "Seulement 5"
	line "CADEAUX par jour."
	prompt
else
	text "Sorry--only five"
	line "GIFTS a day."
	prompt
endc

_MysteryGiftOneADayText::
if DEF(_FR_FR)
	text "Seulement 1 CADEAU"
	line "par jour et par"
	cont "personne."
	prompt
else
	text "Sorry. One GIFT"
	line "a day per person."
	prompt
endc

_MysteryGiftSentText::
if DEF(_FR_FR)
	text_ram wMysteryGiftPartnerName
	text " envoie"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text_ram wMysteryGiftPartnerName
	text " sent"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_MysteryGiftSentHomeText::
if DEF(_FR_FR)
	text_ram wMysteryGiftPartnerName
	text " envoie"
	line "@"
	text_ram wStringBuffer1
	text_start
	cont "chez @"
	text_ram wMysteryGiftPlayerName
	text "."
	prompt
else
	text_ram wMysteryGiftPartnerName
	text " sent"
	line "@"
	text_ram wStringBuffer1
	text_start
	cont "to @"
	text_ram wMysteryGiftPlayerName
	text "'s home."
	prompt
endc

_NameCardReceivedCardText::
if DEF(_FR_FR)
	text_start
	prompt
else
	text "Received"
	line "@"
	text_ram wMysteryGiftCardHolderName
	text "'s CARD."
	prompt
endc

_NameCardListedCardText::
if DEF(_FR_FR)
	text_start
	prompt
else
	text_ram wMysteryGiftCardHolderName
	text "'s CARD was"
	line "listed as no.@"
	text_decimal wTextDecimalByte, 1, 2
	text "."
	prompt
endc

_NameCardNotRegisteredCardText::
if DEF(_FR_FR)
	text_start
	prompt
else
	text "The CARD was not"
	line "registered."
	prompt
endc

_NameCardLinkCancelledText::
if DEF(_FR_FR)
	text "La connexion a"
	line "été perdue."
	prompt
else
	text "The link has been"
	line "cancelled."
	prompt
endc

_NameCardLinkCommErrorText::
if DEF(_FR_FR)
	text "Erreur"
	line "communication."
	prompt
else
	text "Communication"
	line "error."
	prompt
endc

_HMRequiredText::
if DEF(_FR_FR)
	text "Désolé! Vous devez"
	line "posséder la CS."
	prompt
else
	text "Sorry! You must"
	line "own the HM."
	prompt
endc

_CantUseItemText::
if DEF(_FR_FR)
	text "Impossible d'uti-"
	line "liser ça ici."
	prompt
else
	text "Can't use that"
	line "here."
	prompt
endc

_UseCutText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance COUPE!"
	prompt
else
	text_ram wStringBuffer2
	text " used"
	line "CUT!"
	prompt
endc

_CutNothingText::
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "à COUPER ici."
	prompt
else
	text "There's nothing to"
	line "CUT here."
	prompt
endc

_BlindingFlashText::
if DEF(_FR_FR)
	text "Un FLASH illumine"
	line "les environs!@"
	text_promptbutton
	text_end
else
	text "A blinding FLASH"
	line "lights the area!@"
	text_promptbutton
	text_end
endc

_AutoFlashText::
if DEF(_FR_FR)
	text "Le FLASH de"
	line "@"
	text_ram wStringBuffer2
	text_start
	cont "illumine la zone!@"
	text_promptbutton
	text_end
else
	text_ram wStringBuffer2
	text "'s FLASH"
	line "lit up the area!@"
	text_promptbutton
	text_end
endc

_UsedSurfText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance SURF!"
	done
else
	text_ram wStringBuffer2
	text " used"
	line "SURF!"
	done
endc

_CantSurfText::
if DEF(_FR_FR)
	text "On ne peut pas"
	line "SURFER ici."
	prompt
else
	text "You can't SURF"
	line "here."
	prompt
endc

_AlreadySurfingText::
if DEF(_FR_FR)
	text "Vous êtes déjà en"
	line "train de SURFER!"
	prompt
else
	text "You're already"
	line "SURFING."
	prompt
endc

_AskSurfText::
if DEF(_FR_FR)
	text "L'eau est calme..."
	line "Un coup de SURF?"
	done
else
	text "The water is calm."
	line "Want to SURF?"
	done
endc

_UseWaterfallText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance CASCADE!"
	done
else
	text_ram wStringBuffer2
	text " used"
	line "WATERFALL!"
	done
endc

_HugeWaterfallText::
if DEF(_FR_FR)
	text "Oh! Une énorme"
	line "cascade."
	done
else
	text "Wow, it's a huge"
	line "waterfall."
	done
endc

_AskWaterfallText::
if DEF(_FR_FR)
	text "Voulez-vous uti-"
	line "liser CASCADE?"
	done
else
	text "Do you want to use"
	line "WATERFALL?"
	done
endc

_UseDigText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance TUNNEL!"
	done
else
	text_ram wStringBuffer2
	text " used"
	line "DIG!"
	done
endc

_UseEscapeRopeText::
if DEF(_FR_FR)
	text "<PLAYER> utilise"
	line "une CORDE SORTIE."
	done
else
	text "<PLAYER> used an"
	line "ESCAPE ROPE."
	done
endc

_WantToUseDigText::
if DEF(_FR_FR)
	text "Voulez-vous que"
	line "@"
	text_ram wStringBuffer2
	text_start
	cont "utilise TUNNEL?"
	done
else
	text "Want @"
	text_ram wStringBuffer2
	text_start
	line "to use DIG?"
	done
endc

_WantToUseEscapeRopeText::
if DEF(_FR_FR)
	text "Utiliser une"
	line "CORDE SORTIE?"
	done
else
	text "Do you want to use"
	line "an ESCAPE ROPE?"
	done
endc

_CantUseDigText::
if DEF(_FR_FR)
	text "Impossible d'uti-"
	line "liser ça ici."
	done
else
	text "Can't use that"
	line "here."
	done
endc

_TeleportReturnText::
if DEF(_FR_FR)
	text "Retour au dernier"
	line "CENTRE #MON."
	done
else
	text "Return to the last"
	line "#MON CENTER."
	done
endc

_WantToUseTeleportText::
if DEF(_FR_FR)
	text "Voulez-vous que"
	line "@"
	text_ram wStringBuffer2
	text_start
	cont "utilise TELEPORT?"
	done
else
	text "Should @"
	text_ram wStringBuffer2
	text_start
	line "use TELEPORT?"
	done
endc

	

_CantUseTeleportText::
if DEF(_FR_FR)
	text "Impossible d'uti-"
	line "liser ça ici."
	prompt
else
	text "Can't use that"
	line "here."
	
	para ""
	done
endc

_UseStrengthText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance FORCE!"
	done
else
	text_ram wStringBuffer2
	text " used"
	line "STRENGTH!"
	done
endc

_MoveBoulderText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " peut"
	line "déplacer les"
	cont "rochers."
	prompt
else
	text_ram wStringBuffer1
	text " can"
	line "move boulders."
	prompt
endc

_AskStrengthText::
if DEF(_FR_FR)
	text "Un #MON peut"
	line "déplacer ça."
	
	para "Voulez-vous utili-"
	line "ser FORCE?"
	done
else
	text "A #MON may be"
	line "able to move this."
	
	para "Want to use"
	line "STRENGTH?"
	done
endc

_BouldersMoveText::
if DEF(_FR_FR)
	text "Les rochers peu-"
	line "vent être mainte-"
	cont "nant déplacés!"
	done
else
	text "Boulders may now"
	line "be moved!"
	done
endc

_BouldersMayMoveText::
if DEF(_FR_FR)
	text "Un #MON peut"
	line "déplacer ceci."
	done
else
	text "A #MON may be"
	line "able to move this."
	done
endc

_UseWhirlpoolText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance SIPHON!"
	prompt
else
	text_ram wStringBuffer2
	text " used"
	line "WHIRLPOOL!"
	prompt
endc

_MayPassWhirlpoolText::
if DEF(_FR_FR)
	text "C'est un terrible"
	line "siphon!"
	
	para "Un #MON peut"
	line "le traverser."
	done
else
	text "It's a vicious"
	line "whirlpool!"
	
	para "A #MON may be"
	line "able to pass it."
	done
endc

_AskWhirlpoolText::
if DEF(_FR_FR)
	text "Un siphon est sur"
	line "la route."
	
	para "Lancer"
	line "SIPHON?"
	done
else
	text "A whirlpool is in"
	line "the way."
	
	para "Want to use"
	line "WHIRLPOOL?"
	done
endc

_UseHeadbuttText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " donne"
	line "un COUP D'BOULE!"
	prompt
else
	text_ram wStringBuffer2
	text " did a"
	line "HEADBUTT!"
	prompt
endc

_HeadbuttNothingText::
if DEF(_FR_FR)
	text "Nope. Rien dans"
	line "cet arbre..."
	done
else
	text "Nope. Nothing"
	line "in this tree…"
	done
endc

_AskHeadbuttText::
if DEF(_FR_FR)
	text "Un #MON peut"
	line "être dans l'arbre."
	
	para "Voulez-vous donner"
	line "un COUP D'BOULE?"
	done
else
	text "A #MON could be"
	line "in this tree."
	
	para "Want to HEADBUTT"
	line "it?"
	done
endc

_UseRockSmashText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "lance ECLATE-ROC!"
	prompt
else
	text_ram wStringBuffer2
	text " used"
	line "ROCK SMASH!"
	prompt
endc

_MaySmashText::
if DEF(_FR_FR)
	text "Un #MON peut"
	line "le briser."
	done
else
	text "Maybe a #MON"
	line "can break this."
	done
endc

_AskRockSmashText::
if DEF(_FR_FR)
	text "Ce rocher a l'air"
	line "cassable."
	
	para "Voulez-vous utili-"
	line "ser ECLATE-ROC?"
	done
else
	text "This rock looks"
	line "breakable."
	
	para "Want to use ROCK"
	line "SMASH?"
	done
endc

_RodBiteText::
if DEF(_FR_FR)
	text "Oh!"
	line "Ca mord!"
	prompt
else
	text "Oh!"
	line "A bite!"
	prompt
endc

_RodNothingText::
if DEF(_FR_FR)
	text "Rien du tout!"
	prompt
else
	text "Not even a nibble!"
	prompt
endc

_CantGetOffBikeText::
if DEF(_FR_FR)
	text "Vous ne pouvez"
	line "pas descendre ici!"
	done
else
	text "You can't get off"
	line "here!"
	done
endc

_GotOnBikeText::
if DEF(_FR_FR)
	text "<PLAYER> monte sur:"
	line "@"
	text_ram wStringBuffer2
	text "."
	done
else
	text "<PLAYER> got on the"
	line "@"
	text_ram wStringBuffer2
	text "."
	done
endc

_GotOffBikeText::
if DEF(_FR_FR)
	text "<PLAYER> descend"
	line "de: @"
	text_ram wStringBuffer2
	text "."
	done
else
	text "<PLAYER> got off"
	line "the @"
	text_ram wStringBuffer2
	text "."
	done
endc

_AskCutText::
if DEF(_FR_FR)
	text "Cet arbre peut"
	line "être COUPE!"
	
	para "Lancer COUPE?"
	done
else
	text "This tree can be"
	line "CUT!"
	
	para "Want to use CUT?"
	done
endc

_CanCutText::
if DEF(_FR_FR)
	text "Cet arbre peut"
	line "être COUPE!"
	done
else
	text "This tree can be"
	line "CUT!"
	done
endc

_CantCarryItemText::
if DEF(_FR_FR)
	text "Mais <PLAYER> ne"
	line "peut plus rien"
	cont "porter!"
	done
else
	text "But <PLAYER> can't"
	line "carry any more"
	cont "items."
	done
endc

_WhitedOutText::
if DEF(_FR_FR)
	text "<PLAYER> n'a plus"
	line "de #MON en"
	cont "forme..."
	prompt
else
	text "<PLAYER> is out of"
	line "useable #MON…"
	prompt
endc

_LostMoneyText::
if DEF(_FR_FR)
	text "<PLAYER> a perdu"
	line "@"
	text_ram wStringBuffer3
	text "¥ dans la"
	cont "panique..."

	para "<PLAYER> est"
	line "hors-jeu!"
	done
else
	text "<PLAYER> dropped"
	line "¥@"
	text_ram wStringBuffer3
	text " in panic…"

	para "<PLAYER> whited"
	line "out!"
	done
endc

_SurrendMoneyText::
if DEF(_FR_FR)
	text "<PLAYER> a donné"
	line "@"
	text_ram wStringBuffer3
	text "¥ au"
	cont "vainqueur."

	para "<PLAYER> est"
	line "hors-jeu!"
	done
else
	text "<PLAYER> gave"
	line "¥@"
	text_ram wStringBuffer3
	text " to the"
	cont "winner."

	para "<PLAYER> is"
	line "overwhelmed by"
	cont "the defeat!"
	done
endc

_FinedText::
if DEF(_FR_FR)
	text "<PLAYER> écope de"
	line "@"
	text_ram wStringBuffer3
	text "¥ d'amende."

	para "<PLAYER> est"
	line "escorté vers un"
	cont "CENTRE #MON."
	done
else
	text "<PLAYER> is fined"
	line "¥@"
	text_ram wStringBuffer3
	text "."

	para "<PLAYER> is"
	line "escorted to a"
	cont "#MON CENTER."
	done
endc	

_ItemfinderItemNearbyText::
if DEF(_FR_FR)
	text "Le CHERCH'OBJET"
	line "indique la présen-"
	cont "ce d'un objet!"
	prompt
else
	text "Yes! ITEMFINDER"
	line "indicates there's"
	cont "an item nearby."
	prompt
endc

_ItemfinderNopeText::
if DEF(_FR_FR)
	text "Le CHERCH'OBJET"
	line "n'a rien trouvé..."
	cont "Dommage!"
	prompt
else
	text "Nope! ITEMFINDER"
	line "isn't responding."
	prompt
endc

_PoisonFaintText::
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "est K.O!"
	prompt
else
	text_ram wStringBuffer3
	text_start
	line "fainted!"
	prompt
endc

_PoisonWhiteoutText::
if DEF(_FR_FR)
	text "<PLAYER> n'a plus"
	line "de #MON en"
	cont "forme!"
	
	para "<PLAYER> est"
	line "hors-jeu!"
	prompt
else
	text "<PLAYER> is out of"
	line "useable #MON!"
	
	para "<PLAYER> whited"
	line "out!"
	prompt
endc

_UseSweetScentText::
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "lance DOUX PARFUM!"
	done
else
	text_ram wStringBuffer3
	text " used"
	line "SWEET SCENT!"
	done
endc

_SweetScentNothingText::
if DEF(_FR_FR)
	text "Il n'y a rien"
	line "dans le coin..."
	done
else
	text "Looks like there's"
	line "nothing here…"
	done
endc

_SquirtbottleUseText::
if DEF(_FR_FR)
	text "<PLAYER> arrose"
	line "le sol."
	done
else
	text "<PLAYER> sprinkled"
	line "water."
	done
endc

_SquirtbottleNothingText::
if DEF(_FR_FR)
	text "Mais rien ne"
	line "se passe..."
	done
else
	text "But nothing"
	line "happened…"
	done
endc

_UseSacredAshText::
if DEF(_FR_FR)
	text "Les #MON de"
	line "<PLAYER> sont tous"
	cont "soignés!"
	done
else
	text "<PLAYER>'s #MON"
	line "were all healed!"
	done
endc

_AnEggCantHoldAnItemText::
if DEF(_FR_FR)
	text "Un OEUF ne peut"
	line "rien porter."
	prompt
else
	text "An EGG can't hold"
	line "an item."
	prompt
endc

_PackNoItemText::
if DEF(_FR_FR)
	text "Aucun objet."
	done
else
	text "No items."
	done
endc

_AskThrowAwayText::
if DEF(_FR_FR)
	text "En jeter"
	line "combien?"
	done
else
	text "Throw away how"
	line "many?"
	done
endc

_AskQuantityThrowAwayText::
if DEF(_FR_FR)
	text "Jeter @"
	text_decimal wItemQuantityChange, 1, 2
	text_start
	line "@"
	text_ram wStringBuffer2
	text "?"
	done
else
	text "Throw away @"
	text_decimal wItemQuantityChange, 1, 2
	text_start
	line "@"
	text_ram wStringBuffer2
	text "(S)?"
	done
endc

_ThrewAwayText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "à la poubelle!"
	prompt
else
	text "Threw away"
	line "@"
	text_ram wStringBuffer2
	text "(S)."
	prompt
endc

_OakThisIsntTheTimeText::
if DEF(_FR_FR)
	text "CHEN: <PLAYER>!"
	line "Ce n'est pas le"
	cont "moment d'utiliser"
	cont "ce truc!"
	prompt
else
	text "OAK: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt
endc

_YouDontHaveAMonText::
if DEF(_FR_FR)
	text "Vous n'avez pas"
	line "de #MON!"
	prompt
else
	text "You don't have a"
	line "#MON!"
	prompt
endc

_RegisteredItemText::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text_start
	line "enregistré(e)."
	prompt
else
	text "Registered the"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
endc

_CantRegisterText::
if DEF(_FR_FR)
	text "On ne peut enre-"
	line "gistrer cet objet."
	prompt
else
	text "You can't register"
	line "that item."
	prompt
endc

_AskItemMoveText::
if DEF(_FR_FR)
	text "Où déplacer"
	line "ceci?"
	done
else
	text "Where should this"
	line "be moved to?"
	done
endc

_PackEmptyText::
	text_start
	done

_YouCantUseItInABattleText::
if DEF(_FR_FR)
	text "C'est inutilisable"
	line "en combat."
	prompt
else
	text "You can't use it"
	line "in a battle."
	prompt
endc

_AreYouABoyOrAreYouAGirlText::
if DEF(_FR_FR)
	text "Etes-vous un gar-"
	line "çon ou une fille?"
	done
else
	text "Are you a boy?"
	line "Or are you a girl?"
	done
endc

Text_BattleEffectActivate::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " de"
	line "<USER>@"
	text_end
else
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer2
	text_end
endc

_BattleStatWentWayUpText::
if DEF(_FR_FR)
	text_pause
	text "<SCROLL>monte à fond!"
	prompt
else
	text_pause
	text "<SCROLL>went way up!"
	prompt
endc

_BattleStatWentUpText::
if DEF(_FR_FR)
	text_start
	cont "augmente!"
	prompt
else
	text " went up!"
	prompt
endc

Text_BattleFoeEffectActivate::
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " de"
	line "<TARGET>@"
	text_end
else
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer2
	text_end
endc

_BattleStatSharplyFellText::
if DEF(_FR_FR)
	text_pause
	text "<SCROLL>diminue à fond!"
	prompt
else
	text_pause
	text "<SCROLL>sharply fell!"
	prompt
endc

_BattleStatFellText::
if DEF(_FR_FR)
	text_start
	cont "diminue!"
	prompt
else
	text " fell!"
	prompt
endc

Text_BattleUser::
	text "<USER>@"
	text_end

_BattleMadeWhirlwindText::
if DEF(_FR_FR)
	text_start
	line "crée un cyclone!"
	prompt
else
	text_start
	line "made a whirlwind!"
	prompt
endc

_BattleTookSunlightText::
if DEF(_FR_FR)
	text_start
	line "rayonne!"
	prompt
else
	text_start
	line "took in sunlight!"
	prompt
endc

_BattleLoweredHeadText::
if DEF(_FR_FR)
	text_start
	line "baisse la tête!"
	prompt
else
	text_start
	line "lowered its head!"
	prompt
endc

_BattleGlowingText::
if DEF(_FR_FR)
	text_start
	line "brille!"
	prompt
else
	text_start
	line "is glowing!"
	prompt
endc

_BattleFlewText::
if DEF(_FR_FR)
	text_start
	line "s'envole!"
	prompt
else
	text_start
	line "flew up high!"
	prompt
endc

_BattleDugText::
if DEF(_FR_FR)
	text_start
	line "creuse un trou!"
	prompt
else
	text_start
	line "dug a hole!"
	prompt
endc

_ActorNameText::
	text "<USER>@"
	text_end

_FeelsWeakText::
if DEF(_FR_FR)
	text "<USER> se"
	line "sent faible..."
	para "@"
	text_end
else
	text "<USER> feels"
	line "weak…"
	para "@"
	text_end
endc

_FeelsWeakText1::
if DEF(_FR_FR)
	text "<USER> se sent"
else
	text "<USER> feels"
endc

_FeelsWeakText2::
if DEF(_FR_FR)
	line "faible..."
	para "@"
	text_end
else
	line "weak…"
	para "@"
	text_end
endc

_FeelsWeakText3::
if DEF(_FR_FR)
	line "épuisé..."
	para "@"
	text_end
else
	line "exhausted…"
	para "@"
	text_end
endc

_FeelsWeakText4::
if DEF(_FR_FR)
	line "à bout..."
	para "@"
	text_end
else
	line "out of energy…"
	para "@"
	text_end
endc		

_UsedMoveText::
if DEF(_FR_FR)
	text_start
	line "lance"
	cont "@"
	text_end
else
	text_start
	line "used @"
	text_end
endc

if DEF(_FR_FR)
_UserLaunchesOneLinerText::
	text " lance"
	line "@"
	text_end

_UsedMoveOneLinerText::
	text_start
	line "lance @"
	text_end
endc

_UsedInsteadText::
if DEF(_FR_FR)
	text "à la place,"
	cont "@"
	text_end
else
	text "instead,"
	cont "@"
	text_end
endc

_MoveNameText::
	text_ram wStringBuffer2
	text "!"
	done

Text_BreedHuh::
if DEF(_FR_FR)
	text "Hein?"
	
	para "@"
	text_end
else
	text "Huh?"
	
	para "@"
	text_end
endc

_BreedClearboxText::
	text_start
	done

_BreedEggHatchText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " sort"
	line "de son OEUF!@"
	sound_caught_mon
	text_promptbutton
	text_end
else
	text_ram wStringBuffer1
	text " came"
	line "out of its EGG!@"
	sound_caught_mon
	text_promptbutton
	text_end
endc

_BreedAskNicknameText::
if DEF(_FR_FR)
	text "Donner un surnom"
	line "à @"
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

_LeftWithDayCareLadyText::
if DEF(_FR_FR)
	text "C'est @"
	text_ram wBreedMon2Nickname
	text_start
	line "qui a été laissé"
	cont "chez la dame de la"
	cont "PENSION."
	done
else
	text "It's @"
	text_ram wBreedMon2Nickname
	text_start
	line "that was left with"
	cont "the DAY-CARE LADY."
	done
endc

_LeftWithDayCareManText::
if DEF(_FR_FR)
	text "C'est @"
	text_ram wBreedMon1Nickname
	text_start
	line "qui a été laissé"
	cont "chez l'homme de la"
	cont "PENSION."
	done
else
	text "It's @"
	text_ram wBreedMon1Nickname
	text_start
	line "that was left with"
	cont "the DAY-CARE MAN."
	done
endc

_BreedBrimmingWithEnergyText::
if DEF(_FR_FR)
	text "Il déborde"
	line "d'énergie."
	prompt
else
	text "It's brimming with"
	line "energy."
	prompt
endc

_BreedNoInterestText::
if DEF(_FR_FR)
	text "Il se fiche de"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "It has no interest"
	line "in @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_BreedAppearsToCareForText::
if DEF(_FR_FR)
	text "Il aime bien"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "It appears to care"
	line "for @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_BreedFriendlyText::
if DEF(_FR_FR)
	text "Il est amical avec"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "It's friendly with"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_BreedShowsInterestText::
if DEF(_FR_FR)
	text "Il s'intéresse à"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "It shows interest"
	line "in @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_EmptyMailboxText::
if DEF(_FR_FR)
	text "Il n'y a pas de"
	line "LETTRE ici."
	prompt
else
	text "There's no MAIL"
	line "here."
	prompt
endc

_MailClearedPutAwayText::
if DEF(_FR_FR)
	text "Le COURRIER a été"
	line "rangé."
	prompt
else
	text "The cleared MAIL"
	line "was put away."
	prompt
endc

_MailPackFullText::
if DEF(_FR_FR)
	text "Le SAC est plein."
	prompt
else
	text "The PACK is full."
	prompt
endc

_MailMessageLostText::
if DEF(_FR_FR)
	text "Le message de la"
	line "LETTRE sera perdu."
	cont "OK?"
	done
else
	text "The MAIL's message"
	line "will be lost. OK?"
	done
endc

_MailAlreadyHoldingItemText::
if DEF(_FR_FR)
	text "Il porte déjà"
	line "un objet."
	prompt
else
	text "It's already hold-"
	line "ing an item."
	prompt
endc

_MailEggText::
if DEF(_FR_FR)
	text "Un OEUF ne peut"
	line "porter une LETTRE!"
	prompt
else
	text "An EGG can't hold"
	line "any MAIL."
	prompt
endc

_MailMovedFromBoxText::
if DEF(_FR_FR)
	text "Cette LETTRE vient"
	line "de la BOITE AUX"
	cont "LETTRES."
	prompt
else
	text "The MAIL was moved"
	line "from the MAILBOX."
	prompt
endc

_WasSentToBillsPCText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "va au PC de LEO."
	prompt
else
	text_ram wStringBuffer1
	text " was"
	line "sent to BILL's PC."
	prompt
endc

_PCGottaHavePokemonText::
if DEF(_FR_FR)
	text "Il faut des"
	line "#MON à appeler!"
	prompt
else
	text "You gotta have"
	line "#MON to call!"
	prompt
endc

_PCWhatText::
if DEF(_FR_FR)
	text "Que faire?"
	done
else
	text "What?"
	done
endc

_PC404Text::
if DEF(_FR_FR)
	text "404: NOT FOUND."
	line "Limité mode local."
	prompt
else
	text "404: NOT FOUND."
	line "Local mode only."
	prompt
endc

_PCMonHoldingMailText::
if DEF(_FR_FR)
	text "Il y a un #MON"
	line "tenant une LETTRE."
	
	para "Enlevez la LETTRE"
	line "s'il vous plaît."
	prompt
else
	text "There is a #MON"
	line "holding MAIL."
	
	para "Please remove the"
	line "MAIL."
	prompt
endc

_ContestCaughtMonText::
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "capturé!"
	prompt
else
	text "Caught @"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

_ContestAskSwitchText::
if DEF(_FR_FR)
	text "Changer de"
	line "#MON?"
	done
else
	text "Switch #MON?"
	done
endc

_ContestAlreadyCaughtText::
if DEF(_FR_FR)
	text "Vous avez déjà"
	line "un @"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "You already caught"
	line "a @"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_ContestJudging_FirstPlaceText::
if DEF(_FR_FR)
	text "Le gagnant du"
	line "Concours de"
	cont "Capture est@"
	text_pause
	text "..."
	
	para "@"
	text_ram wBugContestWinnerName
	text ","
	line "qui a capturé un"
	cont "@"
	text_ram wStringBuffer1
	text "!@"
	text_end
else
	text "This Bug-Catching"
	line "Contest winner is@"
	text_pause
	text "…"
	
	para "@"
	text_ram wBugContestWinnerName
	text ","
	line "who caught a"
	cont "@"
	text_ram wStringBuffer1
	text "!@"
	text_end
endc

_ContestJudging_FirstPlaceScoreText::
if DEF(_FR_FR)
	text_start
	
	para "Le score gagnant"
	line "est de @"
	text_decimal wBugContestFirstPlaceScore, 2, 3
	text " pts!"
	prompt
else
	text_start
	
	para "The winning score"
	line "was @"
	text_decimal wBugContestFirstPlaceScore, 2, 3
	text " points!"
	prompt
endc

_ContestJudging_SecondPlaceText::
if DEF(_FR_FR)
	text "En deuxième place:"
	line "@"
	text_ram wBugContestWinnerName
	text ","
	
	para "qui a capturé un"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	text_end
else
	text "Placing second was"
	line "@"
	text_ram wBugContestWinnerName
	text ","
	
	para "who caught a"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	text_end
endc

_ContestJudging_SecondPlaceScoreText::
if DEF(_FR_FR)
	text_start
	
	para "Le score est de"
	line "@"
	text_decimal wBugContestSecondPlaceScore, 2, 3
	text " points!"
	prompt
else
	text_start
	
	para "The score was"
	line "@"
	text_decimal wBugContestSecondPlaceScore, 2, 3
	text " points!"
	prompt
endc

_ContestJudging_ThirdPlaceText::
if DEF(_FR_FR)
	text "En troisième:"
	line "@"
	text_ram wBugContestWinnerName
	text ","
	
	para "qui a capturé un"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	text_end
else
	text "Placing third was"
	line "@"
	text_ram wBugContestWinnerName
	text ","
	
	para "who caught a"
	line "@"
	text_ram wStringBuffer1
	text "!@"
	text_end
endc

_ContestJudging_ThirdPlaceScoreText::
if DEF(_FR_FR)
	text_start
	
	para "Le score est de"
	line "@"
	text_decimal wBugContestThirdPlaceScore, 2, 3
	text " points!"
	prompt
else
	text_start
	
	para "The score was"
	line "@"
	text_decimal wBugContestThirdPlaceScore, 2, 3
	text " points!"
	prompt
endc

_MagikarpGuruMeasureText::
if DEF(_FR_FR)
	text "Je vais mesurer"
	line "ce MAGICARPE."
	
	para "Hmm... Il mesure"
	line "@"
	text_ram wStringBuffer1
	text "cm."
	prompt
else
	text "Let me measure"
	line "that MAGIKARP."
	
	para "…Hm, it measures"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_KarpGuruRecordText::
if DEF(_FR_FR)
	text "RECORD ACTUEL"
	
	para "@"
	text_ram wStringBuffer1
	text "cm par"
	line "@"
	text_ram wMagikarpRecordHoldersName
	text_promptbutton
	text_end
else
	text "CURRENT RECORD"
	
	para "@"
	text_ram wStringBuffer1
	text " caught by"
	line "@"
	text_ram wMagikarpRecordHoldersName
	text_promptbutton
	text_end
endc

_LuckyNumberMatchPartyText::
if DEF(_FR_FR)
	text "Félicitations!"
	
	para "Le No. ID de votre"
	line "@"
	text_ram wStringBuffer1
	text " dans"
	
	para "votre équipe"
	line "correspond."
	prompt
else
	text "Congratulations!"
	
	para "We have a match"
	line "with the ID number"
	
	para "of @"
	text_ram wStringBuffer1
	text " in"
	line "your party."
	prompt
endc

_LuckyNumberMatchPCText::
if DEF(_FR_FR)
	text "Félicitations!"
	
	para "Le No. ID de votre"
	line "@"
	text_ram wStringBuffer1
	text " dans"
	
	para "votre BOITE PC"
	line "correspond."
	prompt
else
	text "Congratulations!"
	
	para "We have a match"
	line "with the ID number"
	
	para "of @"
	text_ram wStringBuffer1
	text " in"
	line "your PC BOX."
	prompt
endc

_CaughtAskNicknameText::
if DEF(_FR_FR)
	text "Donner un surnom"
	line "au @"
	text_ram wStringBuffer1
	text_start
	cont "reçu?"
	done
else
	text "Give a nickname to"
	line "the @"
	text_ram wStringBuffer1
	text " you"
	cont "received?"
	done
endc

_PokecenterPCCantUseText::
if DEF(_FR_FR)
	text "Bzzzzt! Il faut un"
	line "#MON pour"
	cont "utiliser ça!"
	prompt
else
	text "Bzzzzt! You must"
	line "have a #MON to"
	cont "use this!"
	prompt
endc

_PlayersPCTurnOnText::
if DEF(_FR_FR)
	text "<PLAYER> allume"
	line "le PC."
	prompt
else
	text "<PLAYER> turned on"
	line "the PC."
	prompt
endc

_PlayersPCAskWhatDoText::
if DEF(_FR_FR)
	text "Que voulez-vous"
	line "faire?"
	done
else
	text "What do you want"
	line "to do?"
	done
endc

if DEF(_FR_FR)
_PlayersPCSanitizerText::
_PlayersPCSanitizerFemaleText::
	text "<PLAYER> se lave"
	line "les mains au gel"
	cont "hydroalcoolique."
	prompt
else
_PlayersPCSanitizerText::
	text "<PLAYER> washes his"
	line "hands with some"
	cont "hand sanitizer."
	prompt

_PlayersPCSanitizerFemaleText::
	text "<PLAYER> washes her"
	line "hands with some"
	cont "hand sanitizer."
	prompt
endc

_PokecenterPCTurnOnText::
if DEF(_FR_FR)
	text "<PLAYER> allume"
	line "le PC."
	prompt
else
	text "<PLAYER> turned on"
	line "the PC."
	prompt
endc

_PokecenterPCWhoseText::
if DEF(_FR_FR)
	text "Accéder à quel PC?"
	done
else
	text "Access whose PC?"
	done
endc

_PokecenterBillsPCText::
if DEF(_FR_FR)
	text "PC de LEO"
	line "connecté."
	
	para "Gestion Stocks"
	line "de #MON."
	prompt
else
	text "BILL's PC"
	line "accessed."
	
	para "#MON Storage"
	line "System opened."
	prompt
endc

_PokecenterPlayersPCText::
if DEF(_FR_FR)
	text "PC personnel"
	line "connecté."
	
	para "Gestion Stocks"
	line "d'objets."
	prompt
else
	text "Accessed own PC."
	
	para "Item Storage"
	line "System opened."
	prompt
endc

_PokecenterPCClosedText::
if DEF(_FR_FR)
	text "..."
	line "Déconnexion..."
	done
else
	text "…"
	line "Link closed…"
	done
endc

_OakPCText2::
if DEF(_FR_FR)
	text "Niveau #DEX"
	line "actuel:"
	prompt
else
	text "Current #DEX"
	line "completion level:"
	prompt
endc

_OakPCText3::
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text " #MON vus"
	line "@"
	text_ram wStringBuffer4
	text " #MON pris"
	
	para "Evaluation"
	line "PROF.CHEN:"
	done
else
	text_ram wStringBuffer3
	text " #MON seen"
	line "@"
	text_ram wStringBuffer4
	text " #MON owned"
	
	para "PROF.OAK's"
	line "Rating:"
	done
endc

_OakRating01::
if DEF(_FR_FR)
	text "Cherche des #-"
	line "MON dans les"
	
	para "hautes herbes!"
	done
else
	text "Look for #MON"
	line "in grassy areas!"
	done
endc

_OakRating02::
if DEF(_FR_FR)
	text "Bien. Je vois que"
	line "tu sais te servir"
	
	para "des # BALLS."
	done
else
	text "Good. I see you"
	line "understand how to"
	
	para "use # BALLS."
	done
endc

_OakRating03::
if DEF(_FR_FR)
	text "Tu t'améliores"
	line "mais il te reste"
	
	para "beaucoup de choses"
	line "à découvrir."
	done
else
	text "You're getting"
	line "good at this."
	
	para "But you have a"
	line "long way to go."
	done
endc

_OakRating04::
if DEF(_FR_FR)
	text "Tu dois remplir"
	line "ton #DEX."
	
	para "Attrape plusieurs"
	line "types de #MON!"
	done
else
	text "You need to fill"
	line "up the #DEX."
	
	para "Catch different"
	line "kinds of #MON!"
	done
endc

_OakRating05::
if DEF(_FR_FR)
	text "Tu te donnes du"
	line "mal, ça se voit."
	
	para "Ton #DEX se"
	line "remplit doucement."
	done
else
	text "You're trying--I"
	line "can see that."
	
	para "Your #DEX is"
	line "coming together."
	done
endc

_OakRating06::
if DEF(_FR_FR)
	text "Certains #MON"
	line "évoluent seuls,"
	
	para "d'autres ont be-"
	line "soin de PIERRES."
	done
else
	text "To evolve, some"
	line "#MON grow,"
	
	para "others use the"
	line "effects of STONES."
	done
endc

_OakRating07::
if DEF(_FR_FR)
	text "Est-ce que tu as"
	line "une CANNE? Tu"
	
	para "peux pêcher des"
	line "#MON!"
	done
else
	text "Have you gotten a"
	line "fishing ROD? You"
	
	para "can catch #MON"
	line "by fishing."
	done
endc

_OakRating08::
if DEF(_FR_FR)
	text "Super! Tu aimes"
	line "collectionner"
	
	para "des trucs, hein?"
	done
else
	text "Excellent! You"
	line "seem to like"
	
	para "collecting things!"
	done
endc

_OakRating09::
if DEF(_FR_FR)
	text "Certains #MON"
	line "n'apparaissent"
	
	para "qu'à certains"
	line "moments de la"
	
	para "journée."
	done
else
	text "Some #MON only"
	line "appear during"
	
	para "certain times of"
	line "the day."
	done
endc

_OakRating10::
if DEF(_FR_FR)
	text "Ton #DEX se"
	line "remplit."
	
	para "C'est bien!"
	done
else
	text "Your #DEX is"
	line "filling up."
	
	para "Keep up the"
	line "good work!"
	done
endc

_OakRating11::
if DEF(_FR_FR)
	text "Impressionnant!"
	line "Tu fais évoluer"
	
	para "tes #MON!"
	line "Bravo!"
	done
else
	text "I'm impressed."
	line "You're evolving"
	
	para "#MON, not just"
	line "catching them."
	done
endc

_OakRating12::
if DEF(_FR_FR)
	text "Tu connais"
	line "FARGAS?"
	
	para "Il fabrique"
	line "des BALLS!"
	done
else
	text "Have you met KURT?"
	line "His custom BALLS"
	
	para "should help."
	done
endc

_OakRating13::
if DEF(_FR_FR)
	text "Oh! Tu as trouvé"
	line "plus de #MON"
	
	para "qu'au dernier"
	line "recensement du"
	
	para "#DEX."
	done
else
	text "Wow. You've found"
	line "more #MON than"
	
	para "the last #DEX"
	line "research project."
	done
endc

_OakRating14::
if DEF(_FR_FR)
	text "Echanges-tu tes"
	line "#MON? Il"
	
	para "faut se faire"
	line "des amis!"
	done
else
	text "Are you trading"
	line "your #MON?"
	
	para "It's tough to do"
	line "this alone!"
	done
endc

_OakRating15::
if DEF(_FR_FR)
	text "Whoa! T'as passé"
	line "la barre des 200!"
	
	para "Ton #DEX est"
	line "mortel!"
	done
else
	text "Wow! You've hit"
	line "200! Your #DEX"
	
	para "is looking great!"
	done
endc

_OakRating16::
if DEF(_FR_FR)
	text "Tu as trouvé tant"
	line "de #MON!"
	
	para "Tu aides vraiment"
	line "mes recherches!"
	done
else
	text "You've found so"
	line "many #MON!"
	
	para "You've really"
	line "helped my studies!"
	done
endc

_OakRating17::
if DEF(_FR_FR)
	text "Magnifique! Tu"
	line "peux devenir un"
	
	para "PROF. #MON"
	line "dès maintenant!"
	done
else
	text "Magnificent! You"
	line "could become a"
	
	para "#MON professor"
	line "right now!"
	done
endc

_OakRating18::
if DEF(_FR_FR)
	text "Ton #DEX est"
	line "incroyable! Tu"
	
	para "vas devenir un"
	line "professionnel!"
	done
else
	text "Your #DEX is"
	line "amazing! You're"
	
	para "ready to turn"
	line "professional!"
	done
endc

_OakRating19::
if DEF(_FR_FR)
	text "Whoa! Un #DEX"
	line "parfait! Mon rêve"
	
	para "devient réalité!"
	line "Bravo! Bravo!"
	done
else
	text "Whoa! A perfect"
	line "#DEX! I've"
	
	para "dreamt about this!"
	line "Congratulations!"
	done
endc

_MemoryGameYeahText::
if DEF(_FR_FR)
	text ", ouais!"
	done
else
	text " , yeah!"
	done
endc

_MemoryGameDarnText::
if DEF(_FR_FR)
	text "Zut..."
	done
else
	text "Darn…"
	done
endc

_StartMenuContestEndText::
if DEF(_FR_FR)
	text "Voulez-vous arrê-"
	line "ter le concours?"
	done
else
	text "Would you like to"
	line "end the Contest?"
	done
endc

_ItemsOakWarningText::
if DEF(_FR_FR)
	text "CHEN: <PLAYER>!"
	line "Ce n'est pas le"
	cont "moment d'utiliser"
	cont "ce truc!"
	done
else
	text "OAK: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	done
endc

_PokemonSwapItemText::
if DEF(_FR_FR)
	text "Pris @"
	text_ram wStringBuffer1
	text_start
	line "de @"
	text_ram wMonOrItemNameBuffer
	text " et"
	
	para "fait tenir"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
else
	text "Took @"
	text_ram wMonOrItemNameBuffer
	text "'s"
	line "@"
	text_ram wStringBuffer1
	text " and"
	
	para "made it hold"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
endc

_PokemonHoldItemText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text " tient"
	line "@"
	text_ram wStringBuffer2
	text "."
	prompt
else
	text "Made @"
	text_ram wMonOrItemNameBuffer
	text_start
	line "hold @"
	text_ram wStringBuffer2
	text "."
	prompt
endc

_PokemonRemoveMailText::
if DEF(_FR_FR)
	text "Enlever la"
	line "LETTRE d'abord."
	prompt
else
	text "Please remove the"
	line "MAIL first."
	prompt
endc

_PokemonNotHoldingText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text " ne"
	line "tient rien."
	prompt
else
	text_ram wMonOrItemNameBuffer
	text " isn't"
	line "holding anything."
	prompt
endc

_ItemStorageFullText::
if DEF(_FR_FR)
	text "Espace de stockage"
	line "d'objets complet."
	prompt
else
	text "Item storage space"
	line "full."
	prompt
endc

_PokemonTookItemText::
if DEF(_FR_FR)
	text "Pris @"
	text_ram wStringBuffer1
	text_start
	line "de @"
	text_ram wMonOrItemNameBuffer
	text "."
	prompt
else
	text "Took @"
	text_ram wStringBuffer1
	text_start
	line "from @"
	text_ram wMonOrItemNameBuffer
	text "."
	prompt
endc

_PokemonAskSwapItemText::
if DEF(_FR_FR)
	text_ram wMonOrItemNameBuffer
	text_start
	line "tient déjà"
	
	para "@"
	text_ram wStringBuffer1
	text "."
	line "Changer d'objet?"
	done
else
	text_ram wMonOrItemNameBuffer
	text " is"
	line "already holding"
	
	para "@"
	text_ram wStringBuffer1
	text "."
	line "Switch items?"
	done
endc

_ItemCantHeldText::
if DEF(_FR_FR)
	text "Cet objet ne peut"
	line "être tenu."
	prompt
else
	text "This item can't be"
	line "held."
	prompt
endc

_MailLoseMessageText::
if DEF(_FR_FR)
	text "La LETTRE perdra"
	line "son message. OK?"
	done
else
	text "The MAIL will lose"
	line "its message. OK?"
	done
endc

_MailDetachedText::
if DEF(_FR_FR)
	text "LETTRE enlevée de"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "MAIL detached from"
	line "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

_MailNoSpaceText::
if DEF(_FR_FR)
	text "Pas de place pour"
	line "enlever la LETTRE."
	prompt
else
	text "There's no space"
	line "for removing MAIL."
	prompt
endc

_MailAskSendToPCText::
if DEF(_FR_FR)
	text "Envoyer la LETTRE"
	line "enlevée au PC?"
	done
else
	text "Send the removed"
	line "MAIL to your PC?"
	done
endc

_MailboxFullText::
if DEF(_FR_FR)
	text "La BOITE AUX LET-"
	line "TRES du PC est"
	cont "pleine."
	prompt
else
	text "Your PC's MAILBOX"
	line "is full."
	prompt
endc

_MailSentToPCText::
if DEF(_FR_FR)
	text "La LETTRE a été"
	line "envoyée au PC."
	prompt
else
	text "The MAIL was sent"
	line "to your PC."
	prompt
endc

_PokemonNotEnoughHPText::
if DEF(_FR_FR)
	text "Pas assez de PV!"
	prompt
else
	text "Not enough HP!"
	prompt
endc

_OakText1::
if DEF(_FR_FR)
	text "Bonjour! Désolé de"
	line "l'attente!"
	
	para "Bienvenue dans le"
	line "monde de #MON!"
	
	para "Mon nom est CHEN."
	
	para "Mais on m'appelle"
	line "le PROF.#MON."
	prompt
else
	text "Hello! Sorry to"
	line "keep you waiting!"
	
	para "Welcome to the"
	line "world of #MON!"
	
	para "My name is OAK."
	
	para "People call me the"
	line "#MON PROF."
	prompt
endc

_OakText2::
if DEF(_FR_FR)
	text "Ce monde est peu-"
	line "plé de créatures"
	cont "appelées #MON.@"
	text_end
else
	text "This world is in-"
	line "habited by crea-"
	cont "tures that we call"
	cont "#MON.@"
	text_end
endc

_OakText3::
	text_promptbutton
	text_end

_OakText4::
if DEF(_FR_FR)
	text "Humains et #MON"
	line "vivent en parfaite"
	cont "harmonie..."
	
	para "Certains jouent"
	line "avec les #MON,"
	cont "d'autres font des"
	cont "combats avec eux."
	prompt
else
	text "People and #MON"
	line "live together by"
	
	para "supporting each"
	line "other."
	
	para "Some people play"
	line "with #MON, some"
	cont "battle with them."
	prompt
endc

_OakText5::
if DEF(_FR_FR)
	text "Mais il reste"
	line "beaucoup à appren-"
	cont "dre sur nos amis"
	cont "les #MON."
	
	para "De nombreux mystè-"
	line "res planent à leur"
	cont "sujet."
	
	para "Et c'est pourquoi"
	line "j'étudie les"
	cont "#MON tous les"
	cont "jours."
	prompt
else
	text "But we don't know"
	line "everything about"
	cont "#MON yet."
	
	para "There are still"
	line "many mysteries to"
	cont "solve."
	
	para "That's why I study"
	line "#MON every day."
	prompt
endc

GymGuideRefusesEntranceEndText::
if DEF(_FR_FR)
	text "Reviens avec une"
	line "équipe appropriée."
	done
else
	text "Come back with an"
	line "appropriate team."
	done
endc	

GymKickPlayerOutAfterEvolutionText::
if DEF(_FR_FR)
	text "Haut-parleur: Nous"
	line "avons détecté un"
	cont "#MON évoluer"
	cont "en un type"
	cont "interdit dans"
	cont "cette ARENE."

	para "Son dresseur est"
	line "prié de quitter"
	cont "les lieux."
	done
else
	text "PA system: We have"
	line "detected a #MON"
	cont "evolve into a type"
	cont "forbidden into"
	cont "this GYM."

	para "Its trainer is"
	line "asked to leave"
	cont "now."
	done
endc	

GGTCVioletText::
if DEF(_FR_FR)
	text "Salutations, jeune"
	line "dresseur qui prend"
	cont "son envol!"

	para "Voici l'ARENE"
	line "VOL de JOHTO."

	para "Tu n'as pas le"
	line "droit d'entrer avec"
	cont "un #MON de type"
	cont "ELECTRIK, GLACE"
	cont "ou ROCHE, ça va à"
	cont "l'encontre des"
	cont "règles."

	para "Ce ne serait pas"
	line "équitable pour les"
	cont "dresseurs de cette"
	cont "ARENE, je suis sûr"
	cont "que tu comprends."
	done
else
	text "Yo CHAMP in"
	line "making!"

	para "This is JOHTO's"
	line "FLYING type GYM."

	para "You can't enter"
	line "with ELECTRIC,"
	cont "ICE or ROCK type"

	para "#MON, that's"
	line "against the rules."

	para "It wouldn't be fair"
	line "battles, I'm sure"
	cont "you understand."
	done
endc

GGTCAzaText::
if DEF(_FR_FR)
	text "Yo CHAMPION en"
	line "herbe!"

	para "Ici, aucun #MON"
	line "de type FEU, VOL"
	cont "ni ROCHE!"

	para "Ils nuiraient à"
	line "cet écosystème"
	cont "fragile."

	para "Seul HECTOR peut"
	line "les utiliser, car"
	cont "c'est un expert."
	done
else
	text "Yo CHAMP in"
	line "making!"

	para "No FIRE, FLYING"
	line "or ROCK #MON"
	cont "in here!"

	para "They are a danger"
	line "to this fragile"
	cont "ecosystem."

	para "Only BUGSY is"
	line "allowed to carry"
	cont "those, as he is"
	cont "an expert."
	done
endc

GGTCGoldText::
if DEF(_FR_FR)
	text "Yo CHAMPION"
	line "en devenir!"

	para "Je vois un #MON"
	line "de type COMBAT"
	cont "dans ton équipe."

	para "BLANCHE n'approu-"
	line "verait pas."
	done
else
	text "Yo CHAMP in"
	line "making!"

	para "I see you carry"
	line "a FIGHTING type"
	cont "#MON."

	para "WHITNEY doesn't"
	line "approve."
	done
endc

GGTCEcruText::
if DEF(_FR_FR)
	text "Yo futur CHAMPION!"

	para "Bien que le type"
	line "SPECTRE soit"
	cont "autorisé ici,"

	para "ce n'est pas le cas"
	line "du type TENEBRES."
	done
else
	text "Yo CHAMP in"
	line "making!"

	para "Even though GHOST"
	line "types are allowed"
	cont "in this place,"
	cont "DARK types aren't."
	done
endc

GGTCCianText::
if DEF(_FR_FR)
	text "ARRETE-TOI LA!"

	para "Qui t'a dit que"
	line "tu pouvais entrer"
	cont "avec des #MON"
	cont "de type VOL, PSY"
	cont "ou SPECTRE?"

	para "On tolère pas"
	line "ça ici."

	para "Casse-toi."
	done
else
	text "WAIT RIGHT HERE!"

	para "Who told you you"
	line "could bring any"
	cont "FLYING, PSYCHIC"
	cont "or GHOST #MON"
	cont "in this GYM?"

	para "We don't tolerate"
	line "those here."

	para "Go back out."
	done
endc

GGTCOlivText::
if DEF(_FR_FR)
	text "Merci d'avoir aidé"
	line "JASMINE plus tôt."

	para "Elle va mieux."

	para "J'aimerais pouvoir"
	line "te laisser entrer"
	cont "avec des #MON"
	cont "de type FEU, SOL"
	cont "ou COMBAT."
	
	para "Mais tu comprends,"
	line "ce ne serait pas"
	cont "un affrontement"
	cont "équitable."

	para "JASMINE s'autorise"
	line "une exception pour"
	cont "son propre"
	cont "STEELIX."
	done
else
	text "Thanks for helping"
	line "JASMINE earlier."

	para "She is getting"
	line "better."

	para "I wish I could let"
	line "you in with any"
	cont "FIRE, FIGHTING or"
	cont "GROUND #MON,"
	cont "but you know, it"

	para "wouldn't be a fair"
	line "battle, I'm sure"
	cont "you understand."

	para "JASMINE only makes"
	line "an exception for"
	cont "her own STEELIX."
	done
endc

GGTCMahoText::
if DEF(_FR_FR)
	text "Salut, DRESSEUR"
	line "d'avenir!"

	para "Les types COMBAT,"
	line "ACIER, ROCHE & FEU"
	cont "sont dangereux"
	cont "pour la GLACE"
	cont "de cette ARENE."

	para "Ils ne peuvent"
	line "pas entrer."
	done
else
	text "Hello, CHAMP in"
	line "making!"

	para "FIRE, FIGHTING,"
	line "ROCK and STEEL"
	cont "type #MON are"
	cont "dangerous for the"
	cont "ICE in this GYM."

	para "They cannot stay"
	line "inside."
	done
endc

GGTCBlackText::
if DEF(_FR_FR)
	text "Yo futur CHAMPION!"

	para "C'est quoi ça"
	line "dans ton équipe?"

	para "Un type DRAGON ce"
	line "serait ok. Mais un"
	cont "type GLACE c'est de"
	cont "la triche!"
	done
else
	text "Yo future CHAMP!"

	para "What's that in"
	line "your team?"

	para "A DRAGON type"
	line "would be accepted,"

	para "but an ICE type"
	line "is cheating!"
	done
endc

GGTCPewText::
if DEF(_FR_FR)
	text "Yo CHAMPION"
	line "en titre!"

	para "Tu es arrivé jusqu'"
	line "ici, c'est génial!"

	para "Toutefois, pour"
	line "entrer dans cette"
	cont "ARENE, tu dois te"
	cont "débarrasser des"
	cont "types EAU, PLANTE,"
	cont "COMBAT, ACIER et"
	cont "SOL."

	para "Je suis d'accord,"
	line "la liste est"
	cont "un peu longue."

	para "Mais c'est pas moi"
	line "qui l'ai édité!"
	
	para "C'est PIERRE."

	para "Et pourtant, je"
	line "peux te dire qu'il"
	cont "est bien loin de"
	cont "la respecter..."
	done
else
	text "Yo actual CHAMP!"

	para "You made it up"
	line "here! Amazing!"

	para "However, to enter"
	line "this GYM, you"
	cont "must dismiss any"
	cont "WATER, GRASS,"
	cont "FIGHTING, GROUND,"
	cont "or STEEL #MON."

	para "I agree, it is a"
	line "long list, but"

	para "I wasn't the one"
	line "who came up"
	cont "with it!"

	para "That was BROCK."

	para "And oh boy, he"
	line "sure doesn't"
	cont "follow his"
	cont "own rules…"
	done
endc

GGTCCeruText::
if DEF(_FR_FR)
	text "Hé toi!"

	para "Comment ça a pu te"
	line "passer par la tête"
	cont "de venir ici avec"
	cont "un #MON PLANTE"
	cont "ou ELECTRIK?"

	para "Tu connais pas"
	line "la musique?"

	para "C'est pas parce qu'"
	line "ONDINE utilise un"
	cont "type ELECTRIK dans"
	cont "son équipe que ça"
	cont "te donne le droit!"

	para "Ces types ne sont"
	line "pas adaptés à"
	cont "cette piscine."
	done
else
	text "Hey you!"

	para "Why would you even"
	line "bring any GRASS or"
	cont "ELECTRIC type"
	cont "in here?"

	para "Don't you know"
	line "the drill?"

	para "Because MISTY uses"
	line "an ELECTRIC type"
	cont "doesn't mean you"
	cont "can as well!"

	para "Those are not"
	line "suitable around"
	cont "this pool."
	done
endc

GGTCVermiText::
if DEF(_FR_FR)
	text "Yo CHAMPION!"

	para "Tu es bien loin"
	line "de JOHTO!"

	para "Oh..."

	para "Tu as apporté un"
	line "#MON de type"
	cont "SOL dans une ARENE"
	cont "ELECTRIK?"

	para "Tu vaux mieux"
	line "que ça!"
	done
else
	text "Yo CHAMP!"

	para "You're far"
	line "from JOHTO!"

	para "Oh…"

	para "You came with a"
	line "GROUND #MON to"
	cont "this ELECTRIC-"
	cont "type GYM?"

	para "You're better"
	line "than that!"
	done
endc

GGTCCelaText::
if DEF(_FR_FR)
	text "Bonjour et"
	line "bienvenue!"

	para "Je suis désolée,"
	line "mais les types"
	
	para "FEU, GLACE, VOL,"
	line "INSECTE et POISON"
	
	para "n'ont pas le droit"
	line "d'entrer ici pour"
	
	para "des raisons de"
	line "sécurité."

	para "(atchoum)"

	para "Sauf les 3 recuei-"
	line "llis par ERIKA."

	para "(atchi)"
	done
else
	text "Hello dear,"
	line "and welcome!"

	para "I am sorry but"
	line "FIRE, ICE, FLYING,"

	para "BUG and POISON"
	line "type #MON"

	para "cannot enter"
	line "this place for"
	cont "safety reasons."

	para "(achii)"

	para "Except for the 3"
	line "rescued by ERIKA."

	para "(achii)"
	done
endc

GGTCFuchText::
if DEF(_FR_FR)
	text "Yo CHAMPION!"

	para "Ton équipe est"
	line "illégale dans"
	cont "cette ARENE."

	para "Je te prie de"
	line "retirer les types"
	cont "PSY, SOL et ACIER"
	cont "de ton équipe."

	para "Je sais que c'est"
	line "frustrant, alors"
	cont "je te donne un"
	cont "bon tuyau--"

	para "JEANNINE contourne"
	line "cette règle pour"
	cont "1 membre de son"
	cont "équipe."
	done
else
	text "Yo CHAMP!"

	para "Your party is not"
	line "legal in this GYM."

	para "Please remove any"
	line "PSYCHIC, GROUND"
	cont "or STEEL types."

	para "I know it's frus-"
	line "trating, so I'm"
	cont "giving you a free"

	para "tip--JANINE breaks"
	line "this rule for 1 of"
	cont "her #MON."
	done
endc

GGTCSaffText::
if DEF(_FR_FR)
	text ""
	done
else
	text ""
	done
endc

GGTCCinnaText::
if DEF(_FR_FR)
	text ""
	done
else
	text ""
	done
endc

GGTCViriText::
if DEF(_FR_FR)
	text ""
	done
else
	text ""
	done
endc	

OfferGoodRodText::
if DEF(_FR_FR)
	text "OLIVILLE est sur"
	line "la mer!"

	para "Et si c'est sur la"
	line "mer... C'est"
	cont "qu'on peut pêcher!"

	para "Ca fait 30 ans que"
	line "je pêche ici mon"
	cont "bouchon."

	para "La pêche c'est mon"
	line "hobby, même que"
	cont "des fois et bah ça"
	cont "mord... Et hop une"
	cont "chaussure trouée!"
	cont "Tu veux essayer?"
	done
else
	text "OLIVINE is on the"
	line "sea!"

	para "And if it's on the"
	line "sea, there are"
	cont "bound to be fish!"

	para "I've fished here"
	line "for 30 years."

	para "Would you like to"
	line "face the sea and"
	cont "fish?"
	done
endc






_News1_Topic0_Line0::
if DEF(_FR_FR)
	text_start
	line "L'info du jour:"
	done
else
	text_start
	line "Breaking news:"
	done
endc

_News1_Topic0_Line1::
if DEF(_FR_FR)
	text_start
	line "un confinement"
	done
else
	text_start
	line "a lockdown starts"
	done
endc

_News1_Topic0_Line2::
if DEF(_FR_FR)
	text_start
	line "démarre dans"
	done
else
	text_start
	line "in a few hours."
	done
endc

_News1_Topic0_Line3::
if DEF(_FR_FR)
	text_start
	line "quelques heures."
	done
endc

_News1_Topic1_Line0::
_News1_Topic2_Line0::
_News1_Topic3_Line0::
_News1_Topic4_Line0::
_News1_Topic5_Line0::
if DEF(_FR_FR)
	text_start
	line "...sans transition"
	done
else
	text_start
	line "…moving on"
	done
endc

_News1_Topic1_Line1::
_News1_Topic2_Line1::
_News1_Topic3_Line1::
_News1_Topic4_Line1::
if DEF(_FR_FR)
	text_start
	line "il est rappelé que"
	done
else
	text_start
	line "we remind you that"
	done
endc

_News1_Topic1_Line2::
if DEF(_FR_FR)
	text_start
	line "le confinement est"
	done
else
	text_start
	line "the lockdown is"
	done
endc

_News1_Topic1_Line3::
if DEF(_FR_FR)
	text_start
	line "en vigueur."
	done
else
	text_start
	line "in effect."
	done
endc

_News1_Topic1_Line4::
if DEF(_FR_FR)
	text_start
	line "Interdiction de"
	done
else
	text_start
	line "Leaving home with-"
	done
endc

_News1_Topic1_Line5::
if DEF(_FR_FR)
	text_start
	line "sortir de chez soi"
	done
else
	text_start
	line "out a valid reason"
	done
endc

_News1_Topic1_Line6::
if DEF(_FR_FR)
	text_start
	line "sans justificatif."
	done
else
	text_start
	line "is prohibited."
	done
endc

_News1_Topic2_Line2::
if DEF(_FR_FR)
	text_start
	line "le couvre-feu est"
	done
else
	text_start
	line "the curfew is"
	done
endc

_News1_Topic2_Line3::
if DEF(_FR_FR)
	text_start
	line "en vigueur de 18h"
	done
else
	text_start
	line "enforced from"
	done
endc

_News1_Topic2_Line4::
if DEF(_FR_FR)
	text_start
	line "à 4h du matin."
	done
else
	text_start
	line "6 PM to 4 AM."
	done
endc

_News1_Topic2_Line5::
if DEF(_FR_FR)
	text_start
	line "Interdiction"
	done
else
	text_start
	line "A complete ban on"
	done
endc

_News1_Topic2_Line6::
if DEF(_FR_FR)
	text_start
	line "totale de sortir"
	done
else
	text_start
	line "going out is in"
	done
endc

_News1_Topic2_Line7::
if DEF(_FR_FR)
	text_start
	line "durant cette"
	done
else
	text_start
	line "place during this"
	done
endc

_News1_Topic2_Line8::
if DEF(_FR_FR)
	text_start
	line "période."
	done
else
	text_start
	line "period."
	done
endc

_News1_Topic3_Line2::
if DEF(_FR_FR)
	text_start
	line "le pass vaccinal"
	done
else
	text_start
	line "the vaccine pass-"
	done
endc

_News1_Topic3_Line3::
if DEF(_FR_FR)
	text_start
	line "est en vigueur."
	done
else
	text_start
	line "port is in effect."
	done
endc

_News1_Topic3_Line4::
if DEF(_FR_FR)
	text_start
	line "Comme notre MAITRE"
	done
else
	text_start
	line "Like our CHAMPION"
	done
endc

_News1_Topic3_Line5::
if DEF(_FR_FR)
	text_start
	line "<PLAYER>, faites-"
	done
else
	text_start
	line "<PLAYER>, obtain it"
	done
endc

_News1_Topic3_Line6::
if DEF(_FR_FR)
	text_start
	line "vous vacciner pour"
	done
else
	text_start
	line "by getting vacci-"
	done
endc

_News1_Topic3_Line7::
if DEF(_FR_FR)
	text_start
	line "l'obtenir et ainsi"
	done
else
	text_start
	line "nated, and get"
	done
endc

_News1_Topic3_Line8::
if DEF(_FR_FR)
	text_start
	line "accéder aux lieux"
	done
else
	text_start
	line "access to reopened"
	done
endc

_News1_Topic3_Line9::
if DEF(_FR_FR)
	text_start
	line "publics rouverts."
	done
else
	text_start
	line "public places."
	done
endc

_News1_Topic4_Line2::
if DEF(_FR_FR)
	text_start
	line "le port du masque"
	done
else
	text_start
	line "wearing a face"
	done
endc

_News1_Topic4_Line3::
if DEF(_FR_FR)
	text_start
	line "dans les espaces"
	done
else
	text_start
	line "mask is still"
	done
endc

_News1_Topic4_Line4::
if DEF(_FR_FR)
	text_start
	line "publics reste"
	done
else
	text_start
	line "mandatory in"
	done
endc

_News1_Topic4_Line5::
if DEF(_FR_FR)
	text_start
	line "obligatoire."
	done
else
	text_start
	line "public areas."
	done
endc

_News1_Topic5_Line1::
if DEF(_FR_FR)
	text_start
	line "malgré un faible"
	done
else
	text_start
	line "despite a low"
	done
endc

_News1_Topic5_Line2::
if DEF(_FR_FR)
	text_start
	line "taux de COVID,"
	done
else
	text_start
	line "COVID rate,"
	done
endc

_News1_Topic5_Line3::
if DEF(_FR_FR)
	text_start
	line "les experts"
	done
else
	text_start
	line "experts are afraid"
	done
endc

_News1_Topic5_Line4::
if DEF(_FR_FR)
	text_start
	line "s'inquiètent"
	done
else
	text_start
	line "it may rebound."
	done
endc

_News1_Topic5_Line5::
if DEF(_FR_FR)
	text_start
	line "de son retour."
	done
endc





_News3_Topic0_Line0::
if DEF(_FR_FR)
	text_start
	line "Le nombre du jour:"
	done
else
	text_start
	line "Today's figure:"
	done
endc

_News3_Topic0_Line1::
if DEF(_FR_FR)
	text_start
	line "plus de @"
	text_decimal wStringBuffer2, 2, 4
	text "000"
	done
else
	text_start
	line "more than @"
	text_decimal wStringBuffer2, 2, 4
	text "000"
	done
endc

_News3_Topic0_Line2::
if DEF(_FR_FR)
	text_start
	line "personnes sont"
	done
else
	text_start
	line "deaths from COVID"
	done
endc

_News3_Topic0_Line3::
if DEF(_FR_FR)
	text_start
	line "décédées du COVID"
	done
else
	text_start
	line "since the start"
	done
endc

_News3_Topic0_Line4::
if DEF(_FR_FR)
	text_start
	line "depuis le début"
	done
else
	text_start
	line "of the pandemic."
	done
endc

_News3_Topic0_Line5::
if DEF(_FR_FR)
	text_start
	line "de la pandémie."
	done
endc

_News3_Topic1_Line0::
if DEF(_FR_FR)
	text_start
	line "Pouvoir d'achat:"
	done
else
	text_start
	line "Purchasing power:"
	done
endc

_News3_Topic1_Line1::
if DEF(_FR_FR)
	text_start
	line "l'inflation s'est"
	done
else
	text_start
	line "inflation keeps"
	done
endc

_News3_Topic1_Line2::
if DEF(_FR_FR)
	text_start
	line "encore accélérée"
	done
else
	text_start
	line "rising this month."
	done
endc

_News3_Topic1_Line3::
if DEF(_FR_FR)
	text_start
	line "ce mois-ci."
	done
else
	text_start
	line "Experts hope for"
	done
endc

_News3_Topic1_Line4::
if DEF(_FR_FR)
	text_start
	line "Une stabilisation"
	done
else
	text_start
	line "stabilization by"
	done
endc

_News3_Topic1_Line5::
if DEF(_FR_FR)
	text_start
	line "en fin d'année est"
	done
else
	text_start
	line "the end of the"
	done
endc

_News3_Topic1_Line6::
if DEF(_FR_FR)
	text_start
	line "attendue."
	done
else
	text_start
	line "year."
	done
endc
