GavenAskNumber1Text:
if DEF(_FR_FR)
	text "T'es fortiche."
	line "Je n'ai pas vu ça"
	cont "depuis longtemps."
	
	para "Je peux avoir ton"
	line "numéro?"
	
	para "J'aimerais encore"
	line "me battre quand"
	cont "j'aurai soigné"
	
	para "@"
	text_ram wStringBuffer4
	text " et les"
	line "autres."
	done
else
	text "Wow, you're tough."
	line "I haven't battled"
	
	para "that seriously in"
	line "a long time."
	
	para "Could I get your"
	line "phone number?"
	
	para "I'd like to battle"
	line "again when I heal"
	
	para "@"
	text_ram wStringBuffer4
	text " and the"
	line "rest of my team."
	done
endc


GavenAskNumber2Text:
if DEF(_FR_FR)
	text "Je peux avoir ton"
	line "numéro?"
	
	para "J'aimerais encore"
	line "me battre quand"
	cont "j'aurai soigné"
	
	para "@"
	text_ram wStringBuffer4
	text " et les"
	line "autres."
	done
else
	text "Could I get your"
	line "phone number?"
	
	para "I'd like to battle"
	line "again when I heal"
	
	para "@"
	text_ram wStringBuffer4
	text " and the"
	line "rest of my team."
	done
endc


GavenNumberAcceptedText:
if DEF(_FR_FR)
	text "Comment je peux te"
	line "battre?"
	
	para "Hein? Tu peux"
	line "me le dire?"
	done
else
	text "How should I beat"
	line "you? I'm tormented"
	
	para "by those thoughts"
	line "all the time…"
	done
endc


GavenNumberDeclinedText:
if DEF(_FR_FR)
	text "OK. Je comprends."
	line "Si tu changes"
	
	para "d'avis, viens me"
	line "voir."
	done
else
	text "OK… I understand…"
	line "But if you change"
	
	para "your mind, give me"
	line "a shout anytime."
	done
endc


GavenPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone est"
	line "plein. Tu ne peux"
	
	para "plus enregistrer"
	line "de numéros."
	done
else
	text "Your phone's"
	line "memory is full."
	
	para "You can't register"
	line "my number."
	done
endc


GavenRematchText:
if DEF(_FR_FR)
	text "Hé!"
	line "Je t'attendais!"
	
	para "Cette fois je vais"
	line "gagner!"
	done
else
	text "Hi! I've been"
	line "waiting for you!"
	
	para "This time, I'm"
	line "going to win!"
	done
endc
