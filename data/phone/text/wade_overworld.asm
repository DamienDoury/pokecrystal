WadeAskNumber1Text:
if DEF(_FR_FR)
	text "T'es terrible!"
	line "Je t'aime!"
	
	para "Je cherche des"
	line "#MON ici"
	cont "tous les jours."
	
	para "Dans l'herbe je"
	line "trouve plein de"
	cont "BAIES."
	
	para "Si tu veux, je"
	line "peux t'en donner."
	
	para "Tu me donnes ton"
	line "numéro?"
	done
else
	text "You're awesome!"
	line "I like you!"
	
	para "I look for #MON"
	line "here every day."
	
	para "When I'm in the"
	line "grass, I find all"
	cont "kinds of BERRIES."
	
	para "If you'd like,"
	line "I'll share some."
	
	para "Could I get your"
	line "phone number?"
	done
endc


WadeAskNumber2Text:
if DEF(_FR_FR)
	text "Dans l'herbe je"
	line "trouve plein de"
	cont "BAIES."
	
	para "Si tu veux, je"
	line "peux t'en donner."
	
	para "Tu me donnes ton"
	line "numéro?"
	done
else
	text "When I'm in the"
	line "grass, I find all"
	cont "kinds of BERRIES."
	
	para "If you'd like,"
	line "I'll share some."
	
	para "Could I get your"
	line "phone number?"
	done
endc


WadeNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si je"
	line "trouve un truc"
	cont "cool."
	done
else
	text "You'll hear from"
	line "me as soon as I"
	
	para "find anything that"
	line "you might like."
	done
endc


WadeNumberDeclinedText:
if DEF(_FR_FR)
	text "Ne sois pas timide"
	line "si tu veux mon"
	cont "numéro."
	done
else
	text "Oh well. Don't be"
	line "shy if you want to"
	cont "get my number."
	done
endc


WadePhoneFullText:
if DEF(_FR_FR)
	text "Y'a plus de place"
	line "sur ton téléphone"
	cont "pour mon numéro."
	done
else
	text "Your phone list"
	line "has no room for my"
	cont "number."
	done
endc


WadeRematchText:
if DEF(_FR_FR)
	text "Je t'attendais..."
	line "COMBAT!"
	done
else
	text "I was waiting for"
	line "you. Let's battle!"
	done
endc


WadeGiftText:
if DEF(_FR_FR)
	text "Bonjour toi!"
	line "Voilà ce que j'ai"
	
	para "trouvé."
	line "C'est pour toi!"
	done
else
	text "Good to see you!"
	line "See? This is what"
	
	para "I found."
	line "It's for you!"
	done
endc


WadePackFullText:
if DEF(_FR_FR)
	text "Ton SAC est plein."
	line "Dommage, ça."
	
	para "Reviens plus tard,"
	line "mon amour."
	done
else
	text "Oops, your PACK's"
	line "full. Too bad."
	
	para "You should come"
	line "back for it later."
	done
endc
