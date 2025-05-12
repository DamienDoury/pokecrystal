ArnieAskNumber1Text:
if DEF(_FR_FR)
	text "Tu n'as pas"
	line "l'impression qu'il"
	
	para "y a plus de #-"
	line "MON rares dans le"
	cont "coin?"
	
	para "Moi, je les cher-"
	line "che tout le temps."
	
	para "Si j'en trouve un,"
	line "je fais passer"
	
	para "l'information..."
	
	para "Je sais! Donne"
	line "ton numéro!"
	done
else
	text "Do you get the"
	line "feeling that there"
	
	para "are more rare"
	line "#MON around?"
	
	para "I'm positive there"
	line "are, so I look all"
	cont "the time."
	
	para "If I find one, I"
	line "want to share the"
	
	para "good news with"
	line "everyone I know."
	
	para "I know! Give me"
	line "your phone number."
	done
endc


ArnieAskNumber2Text:
if DEF(_FR_FR)
	text "J'aime prévenir"
	line "tout le monde si"
	cont "je vois un #MON"
	cont "rare."
	
	para "Donne-moi donc"
	line "ton numéro!"
	done
else
	text "I want to let"
	line "people know if I"
	cont "see rare #MON."
	
	para "Please give me"
	line "your phone number!"
	done
endc


ArnieNumberAcceptedText:
if DEF(_FR_FR)
	text "Si je rencontre un"
	line "#MON spécial,"
	
	para "je t'appelle tout"
	line "de suite!"
	done
else
	text "If I spot any"
	line "awesome #MON,"
	
	para "I'll be sure to"
	line "give you a call!"
	done
endc


ArnieNumberDeclinedText:
if DEF(_FR_FR)
	text "Aaaaah!!!"
	line "J'ai pas d'amis!"
	done
else
	text "Aww! I want to"
	line "tell someone about"
	cont "my discoveries!"
	done
endc


ArniePhoneFullText:
if DEF(_FR_FR)
	text "Tu n'as plus de"
	line "place pour mon"
	cont "numéro."
	
	para "Fais de la place"
	line "et reviens!"
	done
else
	text "There's no space"
	line "for my number."
	
	para "If you make room,"
	line "register me!"
	done
endc


ArnieRematchText:
if DEF(_FR_FR)
	text "C'est mon tour de"
	line "gagner!"
	
	para "J'ai trop fait de"
	line "progrès!"
	done
else
	text "It's my turn to"
	line "win now!"
	
	para "I've turned over a"
	line "new leaf!"
	done
endc
