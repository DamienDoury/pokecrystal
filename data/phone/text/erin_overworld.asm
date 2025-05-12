ErinAskNumber1Text:
if DEF(_FR_FR)
	text "Perdre, c'est pas"
	line "bien. Je dois"
	
	para "encore m'entraîner"
	line "à fond..."
	
	para "Voilà mon numéro."
	line "Moi c'est ERIN."
	
	para "Ne l'oublie pas!"
	line "Tu veux encore"
	cont "combattre?"
	done
else
	text "It really made me"
	line "angry to lose."
	
	para "I'll have to train"
	line "much harder…"
	
	para "Here's my number."
	line "I'm ERIN--don't"
	
	para "forget! Want to"
	line "battle me again?"
	done
endc


ErinAskNumber2Text:
if DEF(_FR_FR)
	text "Je veux encore me"
	line "mesurer à toi."
	
	para "On échange nos"
	line "numéros?"
	done
else
	text "I want to battle"
	line "with you again."
	
	para "Do you want to"
	line "exchange numbers?"
	done
endc


ErinNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle si je"
	line "veux encore me"
	cont "battre!"
	done
else
	text "I'll remember to"
	line "call when I want"
	cont "to battle again!"
	done
endc


ErinNumberDeclinedText:
if DEF(_FR_FR)
	text "Je suis triste..."
	line "Si tu veux encore"
	
	para "combattre, viens"
	line "voir ERIN..."
	cont "C'est moi!"
	done
else
	text "Oh… I'm sad…"
	line "If you do want to"
	
	para "battle, come see"
	line "ERIN--that's me!"
	done
endc


ErinPhoneFullText:
if DEF(_FR_FR)
	text "Oh non. Ton réper-"
	line "toire est plein."
	done
else
	text "Oh no. Your phone"
	line "is all filled up."
	done
endc


ErinRematchText:
if DEF(_FR_FR)
	text "Je t'attendais!"
	line "On commence!"
	done
else
	text "Yay! I waited!"
	line "Let's start now!"
	done
endc


ErinPackFullText:
if DEF(_FR_FR)
	text "Dommage!"
	line "Plus de place..."
	
	para "Je te le donnerai"
	line "une autre fois."
	done
else
	text "That's too bad!"
	line "You have no room…"
	
	para "I'll give it to"
	line "you another time."
	done
endc


ErinRematchGiftText:
if DEF(_FR_FR)
	text "Encore perdu?!"
	
	para "Ca fait combien de"
	line "fois maintenant?"
	
	para "En tout cas, merci"
	line "d'être là!"
	cont "Hop! Cadeau!"
	done
else
	text "Aww… I lost again!"
	
	para "I wonder how many"
	line "times that is…"
	
	para "Thanks for coming!"
	line "Here's a present!"
	done
endc
