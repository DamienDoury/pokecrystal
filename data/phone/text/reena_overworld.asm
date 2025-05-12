ReenaAskNumber1Text:
if DEF(_FR_FR)
	text "Pas mal..."
	line "Tu as du mérite"
	
	para "d'avoir gagné..."
	line "C'est pas donné à"
	cont "tout le monde..."
	
	para "J't'aime bien!"
	line "Donne ton numéro!"
	
	para "Toi et moi on"
	line "sera potes!"
	done
else
	text "Not bad…"
	line "It's something to"
	
	para "beat me, even by"
	line "an unlikely fluke…"
	
	para "I like you! Give"
	line "me your number!"
	
	para "You can be my"
	line "practice partner!"
	done
endc


ReenaAskNumber2Text:
if DEF(_FR_FR)
	text "J't'aime bien!"
	line "Donne ton numéro!"
	
	para "Toi et moi on"
	line "sera potes!"
	done
else
	text "Give me your phone"
	line "number!"
	
	para "You are going to"
	line "be my practice"
	cont "partner!"
	done
endc


ReenaNumberAcceptedText:
if DEF(_FR_FR)
	text "Ne te vante pas"
	line "trop!"
	
	para "Ca donne des"
	line "boutons!"
	done
else
	text "Don't be too proud"
	line "about beating me!"
	
	para "It was a fluke!"
	done
endc


ReenaNumberDeclinedText:
if DEF(_FR_FR)
	text "Incroyable!"
	line "Ca, mon bijou, tu"
	cont "vas le regretter!"
	done
else
	text "I don't believe"
	line "it! You're going"
	cont "to regret this!"
	done
endc


ReenaPhoneFullText:
if DEF(_FR_FR)
	text "Hein? Ton télépho-"
	line "ne est plein!"
	done
else
	text "What? Your phone"
	line "list has no room!"
	done
endc


ReenaRematchText:
if DEF(_FR_FR)
	text "Bah alors?"
	line "T'en as mis du"
	cont "temps!"
	done
else
	text "What took you?"
	line "Start right away!"
	done
endc
