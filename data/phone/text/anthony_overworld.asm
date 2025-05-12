AnthonyAskNumber1Text:
if DEF(_FR_FR)
	text "Au fait, je suis"
	line "un MONTAGNARD. Je"
	
	para "vais donc sur les"
	line "chemins et dans"
	cont "les grottes."
	
	para "Ca m'arrive de"
	line "voir des #MON"
	cont "rares."
	
	para "Je peux t'appeler"
	line "et te prévenir si"
	cont "j'en vois un."
	
	para "On échange nos"
	line "numéros?"
	done
else
	text "By the way, I'm a"
	line "HIKER, so I often"
	
	para "go to mountains"
	line "and caves."
	
	para "I occasionally see"
	line "rare #MON."
	
	para "I could call you"
	line "the next time I"
	cont "see one."
	
	para "Feel like swapping"
	line "phone numbers?"
	done
endc


AnthonyAskNumber2Text:
if DEF(_FR_FR)
	text "Je peux t'appeler"
	line "et te prévenir si"
	cont "j'en vois un."
	
	para "On échange nos"
	line "numéros?"
	done
else
	text "I could call you"
	line "when I see some"
	cont "rare #MON."
	
	para "Feel like swapping"
	line "phone numbers?"
	done
endc


AnthonyNumberAcceptedText:
if DEF(_FR_FR)
	text "Attends voir. Je"
	line "vais trouver des"
	cont "#MON rares"
	cont "pour toi!"
	done
else
	text "Be patient. I'll"
	line "find some rare"
	cont "#MON for you!"
	done
endc


AnthonyNumberDeclinedText:
if DEF(_FR_FR)
	text "Bon."
	line "Je retourne dans"
	cont "mes montagnes..."
	done
else
	text "You're cold. I may"
	line "as well head to"
	cont "the mountains…"
	done
endc


AnthonyPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone est"
	line "plein."
	
	para "Tu ne peux pas"
	line "enregistrer mon"
	cont "numéro."
	done
else
	text "Your phone's full."
	
	para "It can't register"
	line "my phone number."
	done
endc


AnthonyRematchText:
if DEF(_FR_FR)
	text "Ca marche!"
	
	para "Moi et mes #MON"
	line "sommes prêts!"
	done
else
	text "All righty, then!"
	
	para "My #MON and I"
	line "are raring to go!"
	done
endc
