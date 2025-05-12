JackAskNumber1Text:
if DEF(_FR_FR)
	text "Tu en connais un"
	line "rayon!"
	
	para "C'est bien!"
	
	para "On échange des"
	line "astuces?"
	
	para "Je t'appelle si"
	line "j'ai du nouveau."
	
	para "Tu me donnes ton"
	line "numéro?"
	done
else
	text "Your knowledge is"
	line "impressive!"
	
	para "I like that!"
	
	para "Want to trade"
	line "battle tips?"
	
	para "I'll phone if I"
	line "get good info."
	
	para "Would you tell me"
	line "your number?"
	done
endc


JackAskNumber2Text:
if DEF(_FR_FR)
	text "On échange des"
	line "astuces?"
	
	para "Je t'appelle si"
	line "j'ai du nouveau."
	
	para "Tu me donnes ton"
	line "numéro?"
	done
else
	text "Want to trade"
	line "battle tips?"
	
	para "I'll phone if I"
	line "get good info."
	
	para "Would you tell me"
	line "your number?"
	done
endc


JackNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si"
	line "j'ai du nouveau."
	done
else
	text "I'll call you if I"
	line "hear anything!"
	done
endc


JackNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh, OK. Dommage."
	
	para "Si tu veux mon"
	line "numéro, viens me"
	cont "voir, OK?"
	done
else
	text "Oh, OK. Too bad…"
	
	para "Well, if you ever"
	line "want my number,"
	cont "come see me, OK?"
	done
endc


JackPhoneFullText:
if DEF(_FR_FR)
	text "Oh?"
	line "Ton téléphone"
	cont "est plein."
	
	para "Tu ne peux pas en-"
	line "registrer mon No."
	done
else
	text "Oh?"
	line "Your phone's full."
	
	para "It can't register"
	line "my number."
	done
endc


JackRematchText:
if DEF(_FR_FR)
	text "Hé!"
	line "Je t'attendais!"
	
	para "Allez, hop!"
	line "On commence!"
	done
else
	text "Hi, I was waiting"
	line "for you to show!"
	
	para "Let's get started"
	line "right away!"
	done
endc
