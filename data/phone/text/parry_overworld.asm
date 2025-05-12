ParryAskNumber1Text:
if DEF(_FR_FR)
	text "Ouaiiiis!"
	line "T'es fortiche, ma"
	
	para "parole! Il faut se"
	line "refaire ça!"
	
	para "Tu me donnes ton"
	line "numéro?"
	done
else
	text "Sheesh, the way"
	line "you attacked! That"
	
	para "was something! We"
	line "should meet again!"
	
	para "How about giving"
	line "me your number?"
	done
endc


ParryAskNumber2Text:
if DEF(_FR_FR)
	text "Tu veux enregis-"
	line "trer mon numéro"
	
	para "pour combattre à"
	line "nouveau?"
	done
else
	text "So you want to"
	line "register my phone"
	
	para "number for a re-"
	line "match, huh?"
	done
endc


ParryNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si"
	line "je veux encore"
	cont "combattre!"
	done
else
	text "I'll call you"
	line "whenever I feel"
	cont "like battling!"
	done
endc


ParryNumberDeclinedText:
if DEF(_FR_FR)
	text "Non? Bien."
	
	para "Pas cool."
	line "Pas glop."
	
	para "Reviens me voir si"
	line "tu veux combattre"
	cont "à nouveau."
	done
else
	text "No? That's fine."
	
	para "A definite no is"
	line "easy to take!"
	
	para "I'll be right here"
	line "when you're ready"
	cont "for a rematch."
	done
endc


ParryPhoneFullText:
if DEF(_FR_FR)
	text "Oh? Il n'y a plus"
	line "de place pour mon"
	cont "numéro."
	done
else
	text "Oh? There's no"
	line "room to register"
	cont "my phone number."
	done
endc


ParryRematchText:
if DEF(_FR_FR)
	text "Te voilà, mon"
	line "bouchon! Allez!"
	
	para "C'est parti pour"
	line "une super attaque!"
	done
else
	text "Hey, here comes"
	line "the kid! Let's go!"
	
	para "Ready for my usual"
	line "no-brainer, all-"
	cont "out offense?"
	done
endc


ParryPackFullText:
if DEF(_FR_FR)
	text "Ton SAC a l'air"
	line "super plein!"
	
	para "Je ne peux rien"
	line "te donner."
	done
else
	text "Your PACK looks"
	line "stuffed full!"
	
	para "You can't have"
	line "this now."
	done
endc


ParryRematchGiftText:
if DEF(_FR_FR)
	text "Tu n'es pas comme"
	line "les autres..."
	
	para "J'aurais dû com-"
	line "mencer à m'entraî-"
	cont "ner plus jeune..."
	
	para "Je te souhaite"
	line "tant de succès..."
	
	para "Prends ceci..."
	line "J'y tiens."
	done
else
	text "Well, you're"
	line "special all right."
	
	para "If only I'd begun"
	line "#MON when I was"
	cont "a tad younger…"
	
	para "I want you to work"
	line "and succeed for"
	
	para "the both of us."
	line "So take this, OK?"
	done
endc
