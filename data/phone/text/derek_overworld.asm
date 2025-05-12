DerekAskNumber1Text:
if DEF(_FR_FR)
	text "Oh! PIKACHU!"
	line "Il est tout mimi!"
	cont "Il est tout doux!"
	
	para "Soyons amis! Les"
	line "fans de PIKACHU"
	cont "sont trop cool!"
	
	para "On va parler de"
	line "PIKACHU!"
	
	para "Je peux avoir ton"
	line "numéro?"
	done
else
	text "Oh, wow! PIKACHU!"
	line "It's so soft and"
	cont "furry! How cute!"
	
	para "Let's be friends!"
	line "PIKACHU-lovers are"
	cont "never bad people!"
	
	para "Let's chat about"
	line "PIKACHU!"
	
	para "Can I get your"
	line "phone number?"
	done
endc


DerekAskNumber2Text:
if DEF(_FR_FR)
	text "On va parler de"
	line "PIKACHU!"
	
	para "Je peux avoir ton"
	line "numéro?"
	done
else
	text "Let's chat about"
	line "PIKACHU!"
	
	para "Can I get your"
	line "phone number?"
	done
endc


DerekNumberAcceptedText:
if DEF(_FR_FR)
	text "PIKACHU est le"
	line "meilleur! Si j'ai"
	
	para "du nouveau, je"
	line "t'appelle."
	done
else
	text "PIKACHU is the"
	line "one! If anything"
	
	para "comes up, I'll"
	line "give you a jingle."
	done
endc


DerekNumberDeclinedText:
if DEF(_FR_FR)
	text "Toi..."
	
	para "Je suis sûr que"
	line "tu n'aimes pas"
	cont "vraiment PIKACHU."
	done
else
	text "You…"
	
	para "I bet you don't"
	line "even like PIKACHU…"
	done
endc


DerekPhoneFullText:
if DEF(_FR_FR)
	text "Attends! Ton télé-"
	line "phone est plein!"
	done
else
	text "Wait a sec! Your"
	line "phone list's full!"
	done
endc


DerekGiftText:
if DEF(_FR_FR)
	text "Je te cherchais!"
	line "Regarde ça!"
	
	para "Ton PIKACHU va"
	line "adorer mon joli"
	cont "cadeau!"
	done
else
	text "I've been looking"
	line "for you! Here, see"
	cont "this? This is it!"
	
	para "I'm certain your"
	line "PIKACHU will love"
	cont "my gift too!"
	done
endc


DerekPackFullText:
if DEF(_FR_FR)
	text "Dommage."
	line "Tu n'as plus de"
	
	para "place. Reviens"
	line "plus tard."
	done
else
	text "Uh-oh, too bad."
	line "You don't have any"
	
	para "room. Be sure to"
	line "get it later."
	done
endc
