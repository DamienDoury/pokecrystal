VanceAskNumber1Text:
if DEF(_FR_FR)
	text "Tu as un certain"
	line "talent, toi."
	
	para "Je suis plutôt"
	line "impressionné..."
	
	para "Je sais! On de-"
	line "vrait échanger nos"
	
	para "numéros! On fera"
	line "d'autres combats!"
	done
else
	text "You know, you are"
	line "really strong."
	
	para "But I don't want"
	line "to just slink off…"
	
	para "I know! Could I"
	line "get your number?"
	
	para "Let's meet up for"
	line "more battles!"
	done
endc


VanceAskNumber2Text:
if DEF(_FR_FR)
	text "Je veux affronter"
	line "les meilleurs"
	cont "dresseurs!"
	
	para "Je peux avoir ton"
	line "numéro?"
	
	para "On combattra"
	line "une autre fois!"
	done
else
	text "I want to battle"
	line "tough trainers as"
	cont "often as I can!"
	
	para "Could I get your"
	line "number?"
	
	para "Let's meet up for"
	line "more battles!"
	done
endc


VanceNumberAcceptedText:
if DEF(_FR_FR)
	text "N'oublie pas de"
	line "venir me voir si"
	cont "je te lance un"
	cont "défi!"
	done
else
	text "Don't forget to"
	line "come see me when I"
	cont "challenge you!"
	done
endc


VanceNumberDeclinedText:
if DEF(_FR_FR)
	text "Etre pote avec les"
	line "fans des oiseaux,"
	cont "c'est bien..."
	
	para "Ca te tente?"
	done
else
	text "A bird-user friend"
	line "isn't a bad thing"
	cont "to have, I think…"
	
	para "Won't you"
	line "reconsider?"
	done
endc


VancePhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone n'a"
	line "plus de mémoire."
	cont "Efface et reviens!"
	done
else
	text "Your phone's out"
	line "of memory. Delete"
	cont "a number for me!"
	done
endc


VanceRematchText:
if DEF(_FR_FR)
	text "J'suis content de"
	line "te voir! Attaque!"
	done
else
	text "Am I happy to see"
	line "you! I won't lose!"
	done
endc


VancePackFullText:
if DEF(_FR_FR)
	text "Oh, Dommage."
	line "Plus de place."
	
	para "A la prochaine."
	line "Reviens me voir!"
	done
else
	text "Oh, too bad. You"
	line "don't have room."
	
	para "I'll give it to"
	line "you next time!"
	done
endc


VanceRematchGiftText:
if DEF(_FR_FR)
	text "Alors toi,"
	line "t'es pas mal!"
	
	para "J'en ai appris des"
	line "trucs avec toi!"
	
	para "Merci!"
	line "Merci!"
	
	para "Voilà pour toi..."
	line "Petit cadeau!"
	done
else
	text "You are really,"
	line "really strong!"
	
	para "Thanks for taking"
	line "me on so often--I"
	
	para "learned a whole"
	line "lot from you."
	
	para "I know! This will"
	line "do as my thanks!"
	done
endc
