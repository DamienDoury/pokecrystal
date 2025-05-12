BeverlyMadeMonEvenCuterText:
if DEF(_FR_FR)
	text "J'ai toiletté mon"
	line "@"
	text_ram wStringBuffer4
	text " et"
	cont "il est super mimi!"
	done
else
	text "I fancied up my"
	line "@"
	text_ram wStringBuffer4
	text " and"
	
	para "made it even cuter"
	line "than before!"
	done
endc


BeverlyDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai croisé un"
	line "SNUBBULL sauvage."
	
	para "Mon SNUBBULL à"
	line "moi était bien"
	cont "plus joli."
	done
else
	text "I happened to come"
	line "across a wild"
	cont "SNUBBULL recently."
	
	para "My SNUBBULL, I"
	line "assure you, was"
	
	para "far cuter than the"
	line "wild one."
	done
endc


BeverlyLostAMonText:
if DEF(_FR_FR)
	text "J'ai croisé un"
	line "MARILL sauvage"
	
	para "l'autre jour."
	line "Mais en fait..."
	
	para "En regardant de"
	line "près, c'était un"
	para "@"
	text_ram wStringBuffer4
	text "."
	line "Dingue!"
	done
else
	text "I happened to see"
	line "a wild MARILL the"
	
	para "other day."
	line "Or so I thought."
	
	para "A closer look"
	line "showed it was"
	
	para "@"
	text_ram wStringBuffer4
	text ". I was"
	line "quite miffed."
	done
endc


BeverlyHangUpText:
if DEF(_FR_FR)
	text "Je vais bientôt"
	line "t'appeler."
	done
else
	text "You can expect a"
	line "call from me."
	done
endc


BeverlyFoundItemText:
if DEF(_FR_FR)
	text "Mon mari a plein"
	line "de ROULEAU d'PQ."

	para "Si tu veux, je"
	line "peux t'en donner"

	para "un pour te"
	line "remercier."

	para "Je suis vers"
	line "@"
	text_ram wStringBuffer5
	text "."

	para "Passe donc me"
	line "voir."
	done
else
	text "My husband got"
	line "some TOILET PAPER."
	
	para "If you'd like, you"
	line "could have one"
	
	para "roll as thanks for"
	line "helping me out."
	
	para "I'll be at"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Please come see me"
	line "when you can."
	done
endc

BeverlyLetsChatAboutMonAgainText:
if DEF(_FR_FR)
	text "Tes #MON"
	line "sont en forme?"
	
	para "On en parlera plus"
	line "tard."
	done
else
	text "Are your #MON"
	line "in prime form?"
	
	para "Let's chat about"
	line "#MON again."
	done
endc


BeverlyComePickUpText:
if DEF(_FR_FR)
	text "Pardon? Oh,"
	line "le ROULEAU d'PQ?"

	para "Y'a pas le feu!"
	line "Viens me voir à"

	para "@"
	text_ram wStringBuffer5
	text_start
	line "quand tu le peux."
	done
else
	text "Pardon?"
	line "Oh, the"
	cont "TOILET PAPER?"
	
	para "There's no need to"
	line "hurry. Come see me"
	
	para "in @"
	text_ram wStringBuffer5
	text_start
	line "when you can."
	done
endc
