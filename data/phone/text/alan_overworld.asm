AlanAskNumber1Text:
if DEF(_FR_FR)
	text "Lire les textes,"
	line "c'est important."
	
	para "Je lis et marche"
	line "en même temps."
	cont "Alors je regarde"
	cont "en bas."
	
	para "De cette manière"
	line "je trouve les"
	cont "objets sur le sol."
	
	para "Ma prochaine trou-"
	line "vaille est pour"
	cont "toi!"
	
	para "Je peux avoir ton"
	line "numéro?"
	done
else
	text "Reading textbooks"
	line "is worthwhile"
	cont "every so often."
	
	para "When I'm reading"
	line "and walking, I"
	cont "have to look down."
	
	para "So I notice items"
	line "on the ground."
	
	para "Next time I find"
	line "something, I'll"
	cont "give it to you."
	
	para "May I have your"
	line "phone number?"
	done
endc


AlanAskNumber2Text:
if DEF(_FR_FR)
	text "Ma prochaine trou-"
	line "vaille est pour"
	cont "toi!"
	
	para "Je peux avoir ton"
	line "numéro?"
	done
else
	text "If I find some-"
	line "thing, it's yours."
	
	para "So may I have your"
	line "phone number?"
	done
endc


AlanNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si je"
	line "trouve quelque"
	
	para "chose. Tu peux"
	line "compter sur moi!"
	done
else
	text "I'll call you as"
	line "soon as I find"
	
	para "something. You can"
	line "count on it!"
	done
endc


AlanNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh... Je pensais"
	line "qu'on s'entendait"
	cont "bien..."
	done
else
	text "Oh… I thought it"
	line "would be a good"
	
	para "break to call you"
	line "when I'm studying…"
	done
endc


AlanPhoneFullText:
if DEF(_FR_FR)
	text "Tu n'as plus de"
	line "place pour mon"
	cont "numéro."
	done
else
	text "There's no room"
	line "for my number."
	done
endc


AlanRematchText:
if DEF(_FR_FR)
	text "Je t'attendais,"
	line "mon bouchon!"
	
	para "Tu ne m'auras pas"
	line "aujourd'hui!"
	done
else
	text "I waited around"
	line "for you!"
	
	para "I'm thoroughly"
	line "prepared today!"
	done
endc


AlanGiftText:
if DEF(_FR_FR)
	text "Tiens!"
	line "C'est pour toi!"
	done
else
	text "This, this! This"
	line "is yours! Ta-da!"
	done
endc


AlanPackFullText:
if DEF(_FR_FR)
	text "Oups!"
	
	para "Tu ne peux plus"
	line "rien porter!"
	
	para "Je garde ça pour"
	line "plus tard."
	done
else
	text "Whoops!"
	
	para "You can't carry"
	line "any more items!"
	
	para "I'll hold it until"
	line "next time."
	done
endc
