KenjiAskNumber1Text:
if DEF(_FR_FR)
	text "Notre combat était"
	line "magnifique!"
	
	para "Je veux que tu me"
	line "laisses un petit"
	cont "souvenir!"
	
	para "Ton numéro de"
	line "téléphone!"
	
	para "Je ne pourrai pas"
	line "trop discuter pen-"
	cont "dant des heures..."
	done
else
	text "Our battle was"
	line "remarkable!"
	
	para "I wish for some-"
	line "thing to remember"
	cont "you by!"
	
	para "Perhaps your phone"
	line "number will do?"
	
	para "My training makes"
	line "it impossible to"
	cont "chat much, but…"
	done
endc


KenjiAskNumber2Text:
if DEF(_FR_FR)
	text "Je m'entraîne"
	line "beaucoup mais"
	
	para "veux-tu mon numéro"
	line "de téléphone?"
	done
else
	text "My training makes"
	line "chatting tough,"
	
	para "but will you take"
	line "down my number?"
	done
endc


KenjiNumberAcceptedText:
if DEF(_FR_FR)
	text "Je dois continuer"
	line "à m'entraîner!"
	done
else
	text "I must train"
	line "harder to become"
	cont "the mightiest!"
	done
endc


KenjiNumberDeclinedText:
if DEF(_FR_FR)
	text "Si tu veux mon"
	line "numéro, viens me"
	cont "voir."
	done
else
	text "If you decide you"
	line "want my number,"
	cont "come see me."
	done
endc


KenjiPhoneFullText:
if DEF(_FR_FR)
	text "Ton répertoire est"
	line "plein à craquer."
	
	para "Reviens plus tard!"
	done
else
	text "Your phone appears"
	line "to be full."
	
	para "Come back later!"
	done
endc


KenjiGiftText:
if DEF(_FR_FR)
	text "Je tiens à te dire"
	line "merci, <PLAYER>!"
	
	para "Je m'entraînais"
	line "en solitaire..."
	
	para "Merci d'avoir"
	line "appelé..."
	
	para "Voilà pour toi!"
	done
else
	text "I wish to thank"
	line "you, <PLAYER>!"
	
	para "I've been training"
	line "all alone…"
	
	para "I was happy that"
	line "you cared to call…"
	
	para "I want you to have"
	line "this!"
	done
endc


KenjiPackFullText:
if DEF(_FR_FR)
	text "Tu ne peux plus"
	line "rien porter, mon"
	
	para "poussin!"
	line "Je vais garder ça."
	
	para "Vide donc ton SAC!"
	done
else
	text "Your strength will"
	line "not let you carry"
	
	para "another thing!"
	line "I will hold this"
	
	para "till you lighten"
	line "your PACK!"
	done
endc
