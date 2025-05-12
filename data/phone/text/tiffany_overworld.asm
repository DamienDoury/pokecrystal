TiffanyAskNumber1Text:
if DEF(_FR_FR)
	text "Hé! Toi aussi tu"
	line "aimes MELOFEE?"
	
	para "Il est troooooop"
	line "mignon, non?"
	
	para "On s'entend bien,"
	line "tu trouves pas?"
	
	para "Je veux ton numéro"
	line "de téléphone!"
	
	para "On parlera de"
	line "MELOFEE!"
	done
else
	text "Hi! You like"
	line "CLEFAIRY too?"
	
	para "They're so very"
	line "cute, aren't they?"
	
	para "I think we can be"
	line "good friends!"
	
	para "I want to know"
	line "your phone number!"
	
	para "Let's talk about"
	line "CLEFAIRY!"
	done
endc


TiffanyAskNumber2Text:
if DEF(_FR_FR)
	text "Je veux ton numéro"
	line "de téléphone!"
	
	para "On parlera de"
	line "MELOFEE!"
	done
else
	text "I want to know"
	line "your phone number!"
	
	para "Let's talk about"
	line "CLEFAIRY!"
	done
endc


TiffanyNumberAcceptedText:
if DEF(_FR_FR)
	text "Mon MELOFEE est"
	line "siiiiiii mimi!"
	done
else
	text "Isn't my CLEFAIRY"
	line "super-adorable?"
	done
endc


TiffanyNumberDeclinedText:
if DEF(_FR_FR)
	text "Bon."
	line "Viens me parler si"
	cont "tu changes d'avis."
	done
else
	text "Aww… Oh well."
	line "Look for me if you"
	
	para "want to talk about"
	line "CLEFAIRY."
	done
endc


TiffanyPhoneFullText:
if DEF(_FR_FR)
	text "Oh? Ton téléphone"
	line "est plein."
	done
else
	text "Oh? Your phone"
	line "registry is full."
	done
endc


TiffanyRematchText:
if DEF(_FR_FR)
	text "Te voilà!"
	
	para "MELOFEE, fais de"
	line "ton mieux!"
	done
else
	text "There you are!"
	
	para "CLEFAIRY, I want"
	line "you to try hard!"
	done
endc


TiffanyGiftText:
if DEF(_FR_FR)
	text "Tu as pris ton"
	line "temps. Tu vois ça?"
	
	para "C'est mignon, non?"
	line "C'est un RUBAN"
	cont "ROSE."
	done
else
	text "You took a long"
	line "time. See this?"
	
	para "Isn't it cute?"
	line "It's a PINK BOW."
	done
endc


TiffanyPackFullText:
if DEF(_FR_FR)
	text "Oups. Ton SAC est"
	line "super plein."
	done
else
	text "Uh-oh. Your PACK"
	line "is crammed full."
	done
endc
