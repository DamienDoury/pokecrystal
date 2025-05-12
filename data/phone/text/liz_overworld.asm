LizAskNumber1Text:
if DEF(_FR_FR)
	text "Oh? Tu visites?"
	line "C'est bien, ça!"
	
	para "Soyons potes!"
	line "Je peux avoir ton"
	cont "numéro?"
	
	para "Je veux savoir"
	line "tout ce que tu"
	cont "découvres!"
	done
else
	text "Oh? You're on a"
	line "big journey to see"
	cont "the sights? Neat!"
	
	para "Let's be friends!"
	line "Can I have your"
	cont "phone number?"
	
	para "I want to hear"
	line "about everything"
	cont "you've seen!"
	done
endc


LizAskNumber2Text:
if DEF(_FR_FR)
	text "Soyons potes!"
	line "Je peux avoir ton"
	cont "numéro?"
	
	para "Je veux savoir"
	line "tout ce que tu"
	cont "découvres!"
	done
else
	text "Let's be friends!"
	line "Can I have your"
	cont "phone number?"
	
	para "I want to hear"
	line "about everything"
	cont "you've seen!"
	done
endc


LizNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si"
	line "j'apprends quelque"
	cont "chose."
	done
else
	text "I'll telephone you"
	line "if I hear anything"
	cont "interesting."
	done
endc


LizNumberDeclinedText:
if DEF(_FR_FR)
	text "Aaahhhh..."
	line "Pourquoi tant de"
	cont "haine?"
	done
else
	text "Aww… You won't be"
	line "my friend?"
	done
endc


LizPhoneFullText:
if DEF(_FR_FR)
	text "Minute! Ta mémoire"
	line "est pleine!"
	done
else
	text "Wait! Your phone"
	line "list is filled up!"
	done
endc


LizRematchText:
if DEF(_FR_FR)
	text "Tu es en retard!"
	line "C'est parti!"
	done
else
	text "You're late! Let's"
	line "get started now!"
	done
endc
