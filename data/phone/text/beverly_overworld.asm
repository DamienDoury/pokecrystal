BeverlyAskNumber1Text:
if DEF(_FR_FR)
	text "Ton MARILL est si"
	line "mignon!"
	
	para "Tu aimes les #-"
	line "MON comme moi!"
	
	para "On échange nos"
	line "numéros?"
	
	para "On va se parler!"
	line "C'est marrant!"
	done
else
	text "Your MARILL is so"
	line "cute and adorable!"
	
	para "You love #MON"
	line "just like I do!"
	
	para "Want to trade"
	line "phone numbers?"
	
	para "Let's chat! It'll"
	line "be so much fun!"
	done
endc


BeverlyAskNumber2Text:
if DEF(_FR_FR)
	text "Ton MARILL est si"
	line "mignon!"
	
	para "On échange nos"
	line "numéros?"
	
	para "On va se parler!"
	line "C'est marrant!"
	done
else
	text "Your MARILL is so"
	line "cute and adorable!"
	
	para "We should chat, it"
	line "will be fun."
	
	para "Can I have your"
	line "phone number?"
	done
endc


BeverlyNumberAcceptedText:
if DEF(_FR_FR)
	text "En fait, je veux"
	line "un MARILL."
	
	para "Mais je me dé-"
	line "brouille avec"
	cont "SNUBBULL."
	done
else
	text "To be honest, I"
	line "want a MARILL."
	
	para "But I make do with"
	line "my cute SNUBBULL."
	done
endc


BeverlyNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh..."
	line "Quel dommage..."
	
	para "Adieu, MARILL..."
	done
else
	text "Oh… That's"
	line "disappointing…"
	
	para "Goodbye, MARILL…"
	done
endc


BeverlyPhoneFullText:
if DEF(_FR_FR)
	text "Oh? Ton téléphone"
	line "est plein."
	done
else
	text "Oh? Your phone's"
	line "memory is full."
	done
endc


BeverlyGiftText:
if DEF(_FR_FR)
	text "Oh? <PLAYER>? "
	line "Je t'attendais."
	
	para "J'ai un cadeau"
	line "pour toi."
	done
else
	text "Oh? <PLAYER>? "
	line "I waited here for"
	
	para "you. I brought you"
	line "a little gift."
	done
endc


BeverlyPackFullText::
if DEF(_FR_FR)
	text "Oh? Tu n'as"
	line "plus de place."

	para "Reviens plus"
	line "tard."
	done
else
	text "Oh?"
	line "You have no room."
	
	para "Please come back"
	line "for it later."
	done
endc
