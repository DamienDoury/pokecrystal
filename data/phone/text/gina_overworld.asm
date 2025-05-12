GinaAskNumber1Text:
if DEF(_FR_FR)
	text "Si je vois un bon"
	line "dresseur, je veux"
	
	para "l'encourager de"
	line "tout mon coeur."
	
	para "Au fait, moi je"
	line "trouve beaucoup"
	cont "d'objets."
	
	para "Je pourrais même"
	line "t'en donner!"
	
	para "Tu veux me donner"
	line "ton numéro?"
	
	para "Je te préviens si"
	line "je trouve un truc."
	done
else
	text "Whenever I see a"
	line "strong trainer, I"
	
	para "want to be their"
	line "cheerleader."
	
	para "When I'm on my"
	line "walk, I sometimes"
	cont "pick up items."
	
	para "If I get anything,"
	line "you can have it!"
	
	para "Want to give me"
	line "your number?"
	
	para "I'll call as soon"
	line "as I get anything."
	done
endc


GinaAskNumber2Text:
if DEF(_FR_FR)
	text "Si je trouve un"
	line "objet, il est pour"
	cont "toi!"
	
	para "Tu veux me donner"
	line "ton numéro?"
	done
else
	text "If I find an item,"
	line "you can have it!"
	
	para "Want to give me"
	line "your number?"
	done
endc


GinaNumberAcceptedText:
if DEF(_FR_FR)
	text "Je te préviens si"
	line "je trouve un truc."
	done
else
	text "I'll call as soon"
	line "as I get anything!"
	done
endc


GinaNumberDeclinedText:
if DEF(_FR_FR)
	text "Ah bon?"
	line "Bah, dommage!"
	done
else
	text "Is that so? Well,"
	line "I'll still be"
	cont "rooting for you!"
	done
endc


GinaPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone est"
	line "plein!"
	done
else
	text "But your phone is"
	line "all filled up!"
	done
endc


GinaRematchText:
if DEF(_FR_FR)
	text "Je t'attendais!"
	para "J'ai fait des"
	line "progrès!"
	done
else
	text "I've been waiting!"
	
	para "I've gotten a bit"
	line "better at this!"
	done
endc


GinaGiftText:
if DEF(_FR_FR)
	text "Enfin! T'as"
	line "pris ton temps!"
	
	para "Ceci va te faire"
	line "plaisir."
	done
else
	text "So you're finally"
	line "here!"
	
	para "I think this will"
	line "make you happy."
	done
endc


GinaPackFullText:
if DEF(_FR_FR)
	text "Ton SAC est plein"
	line "à craquer."
	
	para "Je vais garder ça"
	line "pour toi."
	done
else
	text "Your PACK looks"
	line "completely full."
	
	para "I'll have to hold"
	line "on to this."
	done
endc
