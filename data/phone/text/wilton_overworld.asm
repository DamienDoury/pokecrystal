WiltonAskNumber1Text:
if DEF(_FR_FR)
	text "Alors ça, c'était"
	line "du beau combat!"
	
	para "En pêchant, je"
	line "trouve souvent"
	cont "des objets."
	
	para "Tu en veux?"
	line "C'est quoi ton"
	cont "numéro?"
	done
else
	text "Eh, our battle was"
	line "fun, I'd say…"
	
	para "When I'm fishing,"
	line "I sometimes snag"
	
	para "items that people"
	line "have dropped."
	
	para "Do you want them?"
	line "What's the number?"
	done
endc


WiltonAskNumber2Text:
if DEF(_FR_FR)
	text "En pêchant, je"
	line "trouve souvent"
	
	para "des objets. "
	line "Tu en veux?"
	cont "C'est quoi ton"
	cont "numéro?"
	done
else
	text "If I snag an item"
	line "while I'm fishing,"
	
	para "it's yours. What's"
	line "your number?"
	done
endc


WiltonNumberAcceptedText:
if DEF(_FR_FR)
	text "Si je trouve quel-"
	line "que chose, je te"
	cont "téléphone."
	done
else
	text "If I snag anything"
	line "good, I'll be sure"
	cont "to let you know."
	done
endc


WiltonNumberDeclinedText:
if DEF(_FR_FR)
	text "D'accord..."
	line "Reviens si tu"
	cont "changes d'avis."
	done
else
	text "All right… Come"
	line "back if you have a"
	cont "change of heart."
	done
endc


WiltonPhoneFullText:
if DEF(_FR_FR)
	text "Tu ne peux plus"
	line "enregistrer de"
	cont "numéros."
	done
else
	text "You can't register"
	line "another number."
	done
endc


WiltonRematchText:
if DEF(_FR_FR)
	text "Argh! Tu as fait"
	line "fuir PTITARD!"
	done
else
	text "Argh! You startled"
	line "POLIWAG into"
	cont "fleeing again!"
	done
endc


WiltonGiftText:
if DEF(_FR_FR)
	text "Voilà pour toi."
	
	para "T'as vu ça?"
	line "Je l'ai trouvé"
	
	para "il n'y a pas si"
	line "longtemps."
	done
else
	text "So here you are."
	
	para "See this?"
	line "I snagged it just"
	
	para "a little while"
	line "ago. It's yours."
	done
endc


WiltonPackFullText:
if DEF(_FR_FR)
	text "Ton SAC est plein?"
	
	para "Je te le donnerai"
	line "plus tard."
	done
else
	text "Your PACK's full?"
	
	para "I'll give it to"
	line "you later."
	done
endc
