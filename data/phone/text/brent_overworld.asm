BrentAskNumber1Text:
if DEF(_FR_FR)
	text "Au fait..."
	line "T'es #MANIAC?"
	
	para "Ca se voit."
	line "Ca crève les yeux."
	
	para "Mais t'en sais pas"
	line "assez!"
	
	para "Tu connais LEO?"
	line "C'est un sacré"
	
	para "#MANIAC."
	line "Je l'aime."
	
	para "Je peux tout te"
	line "dire sur lui..."
	
	para "Alors laisse-moi"
	line "ton numéro."
	done
else
	text "By the way, you're"
	line "a #MANIAC…"
	
	para "I can tell."
	line "Yes, you are."
	
	para "But your knowledge"
	line "is shallow still!"
	
	para "Do you know BILL?"
	line "He's an incredible"
	
	para "#MANIAC."
	line "I revere him."
	
	para "I'll teach you all"
	line "I know about BILL,"
	
	para "so leave me your"
	line "phone number."
	done
endc


BrentAskNumber2Text:
if DEF(_FR_FR)
	text "Je peux tout te"
	line "dire sur LEO..."
	
	para "Alors laisse-moi"
	line "ton numéro."
	done
else
	text "I'll teach you all"
	line "I know about BILL,"
	
	para "so leave me your"
	line "phone number."
	done
endc


BrentNumberAcceptedText:
if DEF(_FR_FR)
	text "LEO..."
	line "Il est trop fort!"
	
	para "Je veux être un"
	line "#MANIAC"
	cont "comme lui..."
	
	para "C'est mon rêve."
	done
else
	text "BILL--he's more"
	line "than amazing!"
	
	para "To be a #MANIAC"
	line "like him someday…"
	
	para "That's my dream."
	done
endc


BrentNumberDeclinedText:
if DEF(_FR_FR)
	text "Tu vas le"
	line "regretter..."
	
	para "Oh que oui..."
	done
else
	text "You're going to"
	line "regret it…"
	
	para "And I won't care…"
	done
endc


BrentPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone est"
	line "plein."
	
	para "Fais plus atten-"
	line "tion, voyons!"
	done
else
	text "Huh? Your phone"
	line "list's full."
	
	para "A #MANIAC has"
	line "to be more tidy!"
	done
endc


BrentRematchText:
if DEF(_FR_FR)
	text "Je t'attendais."
	
	para "Mate donc mes"
	line "#MON!"
	done
else
	text "I've been waiting."
	
	para "Look, check out my"
	line "#MON!"
	done
endc
