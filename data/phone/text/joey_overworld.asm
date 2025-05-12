JoeyAskNumber1Text:
if DEF(_FR_FR)
	text "Heu... Je peux"
	line "avoir ton numéro?"
	
	para "Je t'appellerai"
	line "pour combattre."
	
	para "Je débute, moi"
	line "aussi. Ca nous"
	cont "entraînera..."
	done
else
	text "Listen, can I get"
	line "your phone number?"
	
	para "I'll ring you for"
	line "some battles."
	
	para "I'm a rookie too, "
	line "so I think it'd be"
	cont "a good motivator."
	done
endc


JoeyAskNumber2Text:
if DEF(_FR_FR)
	text "Je peux avoir ton"
	line "numéro?"
	
	para "Je ne veux pas me"
	line "faire battre tout"
	cont "le temps!"
	
	para "On doit remettre"
	line "ça, OK?"
	done
else
	text "Can I get your"
	line "phone number?"
	
	para "I don't want to"
	line "lose against you!"
	
	para "We have to battle"
	line "again, OK?"
	done
endc


JoeyNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si"
	line "j'veux me battre."
	done
else
	text "I'll ring you"
	line "whenever I get the"
	cont "urge to battle!"
	done
endc


JoeyNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh, très bien..."
	
	para "Mais tu ne me"
	line "battras plus!"
	done
else
	text "Oh, all right…"
	
	para "But I won't lose"
	line "to you again!"
	done
endc


JoeyPhoneFullText:
if DEF(_FR_FR)
	text "Hein? La mémoire"
	line "de ton téléphone"
	cont "est pleine."
	done
else
	text "Huh, what? Your"
	line "phone's full."
	done
endc


JoeyRematchText:
if DEF(_FR_FR)
	text "Je t'attendais!"
	line "COMBAT!"
	done
else
	text "I've been waiting!"
	line "Let's battle now!"
	done
endc


JoeyPackFullText:
if DEF(_FR_FR)
	text "Attends! Ton SAC"
	line "est super plein!"
	
	para "On fait ça une"
	line "prochaine fois."
	done
else
	text "Hey, wait! Your"
	line "PACK is stuffed!"
	
	para "Well, we'll leave"
	line "it till next time."
	done
endc


JoeyRematchGiftText:
if DEF(_FR_FR)
	text "Et j'ai encore"
	line "perdu..."
	
	para "OK. D'accord."
	line "T'es fortiche."
	
	para "Se faire battre de"
	line "cette façon n'est"
	cont "pas si terrible!"
	
	para "Prends ça. "
	line "Avec ça tu devien-"
	
	para "dras encore plus"
	line "balèze!"
	done
else
	text "And yet another"
	line "loss…"
	
	para "No doubt about"
	line "it--you're tough."
	
	para "Being beaten this"
	line "often actually"
	cont "feels good now!"
	
	para "Here, take this. "
	line "Use it to get even"
	
	para "tougher. That will"
	line "toughen me up too!"
	done
endc
