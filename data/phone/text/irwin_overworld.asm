IrwinAskNumber1Text:
if DEF(_FR_FR)
	text "Alors ça!"
	line "Toi t'es fortiche!"
	
	para "Quoi? C'est toi?"
	line "Tu as sauvé les"
	cont "RAMOLOSS, non?"
	
	para "Voilà pourquoi"
	line "t'es aussi balèze!"
	
	para "Je peux avoir ton"
	line "numéro?"
	
	para "Je veux savoir"
	line "tout ce que tu"
	cont "fais!"
	done
else
	text "You're the best"
	line "I've ever battled!"
	
	para "Huh? You're the"
	line "one who saved all"
	cont "the SLOWPOKE?"
	
	para "Well, no wonder I"
	line "couldn't beat you!"
	
	para "Would it be OK to"
	line "get your number?"
	
	para "I don't want to"
	line "miss anything you"
	cont "do from now on!"
	done
endc


IrwinAskNumber2Text:
if DEF(_FR_FR)
	text "Tu veux bien me"
	line "donner ton numéro?"
	done
else
	text "You will tell me"
	line "your phone number?"
	done
endc


IrwinNumberAcceptedText:
if DEF(_FR_FR)
	text "OUAIS! Trop fort!"
	line "Je peux t'appeler"
	
	para "tout le temps"
	line "maintenant!"
	
	para "On va être trop"
	line "potes!"
	done
else
	text "Wow! Gee, thanks!"
	line "Now I can call you"
	
	para "anytime, whether"
	line "anything's up or"
	
	para "not. You know,"
	line "just to chat!"
	done
endc


IrwinNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh, mais..."
	line "Je suis pas"
	cont "bizarre, tu sais!"
	
	para "Je veux juste"
	line "parler..."
	
	para "C'est tout!"
	line "J'te jure!"
	done
else
	text "Oh, but…"
	line "I'm not dangerous!"
	
	para "I just want to"
	line "call and chat"
	
	para "about everything"
	line "and nothing!"
	done
endc


IrwinPhoneFullText:
if DEF(_FR_FR)
	text "La mémoire de ton"
	line "téléphone est"
	cont "pleine..."
	
	para "Tu es trop"
	line "populaire..."
	done
else
	text "Your phone list is"
	line "already full…"
	
	para "You must be really"
	line "popular…"
	done
endc
