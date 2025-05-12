BethAskNumber1Text:
if DEF(_FR_FR)
	text "Je n'avais pas"
	line "perdu depuis un"
	cont "bout de temps..."
	
	para "Tu as du talent,"
	line "c'est évident."
	
	para "On devrait remet-"
	line "tre ça un jour."
	
	para "Je crois que c'est"
	line "un bon entraîne-"
	
	para "ment de se battre"
	line "contre toi."
	
	para "Alors ça te dit?"
	
	para "Tu veux me donner"
	line "ton numéro?"
	done
else
	text "It's been a while"
	line "since I lost…"
	
	para "You're very good"
	line "at battling."
	
	para "We should battle"
	line "again sometime."
	
	para "By challenging a"
	line "tough trainer like"
	
	para "you, I think I can"
	line "get better too."
	
	para "So how about it?"
	
	para "Would you give me"
	line "your phone number?"
	done
endc


BethAskNumber2Text:
if DEF(_FR_FR)
	text "Je crois que c'est"
	line "un bon entraîne-"
	
	para "ment de se battre"
	line "contre toi."
	
	para "Alors ça te dit?"
	
	para "Tu veux me donner"
	line "ton numéro?"
	done
else
	text "By challenging a"
	line "tough trainer like"
	
	para "you, I think I can"
	line "get better too."
	
	para "So how about it?"
	
	para "Would you give me"
	line "your phone number?"
	done
endc


BethNumberAcceptedText:
if DEF(_FR_FR)
	text "On se refait ça"
	line "quand tu veux!"
	done
else
	text "Let's battle again"
	line "sometime!"
	done
endc


BethNumberDeclinedText:
if DEF(_FR_FR)
	text "Dommage..."
	
	para "Préviens-moi si tu"
	line "changes d'avis."
	done
else
	text "That's too bad…"
	
	para "Let me know if you"
	line "change your mind."
	done
endc


BethPhoneFullText:
if DEF(_FR_FR)
	text "Oh! Ton téléphone"
	line "est plein!"
	done
else
	text "Oh no. Your phone"
	line "is out of memory."
	done
endc


BethRematchText:
if DEF(_FR_FR)
	text "J't'attends depuis"
	line "longtemps!"
	done
else
	text "You sure kept me"
	line "waiting! Let's go!"
	done
endc
