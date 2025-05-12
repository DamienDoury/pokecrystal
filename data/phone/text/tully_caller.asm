TullyMonHasGrownText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text " a"
	line "encore grandi."
	
	para "Il était si"
	line "petit quand je"
	cont "l'avais attrapé."
	done
else
	text "My @"
	text_ram wStringBuffer4
	text " has"
	line "grown again."
	
	para "It was only about"
	line "so big when I"
	
	para "caught it, but now"
	line "it's way bigger."
	done
endc


TullyDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai mis K.O. un"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "Il était"
	line "ENORME!"
	
	para "Par téléphone,"
	line "c'est dur à"
	cont "décrire..."
	done
else
	text "Oh yeah, I KO'd a"
	line "wild @"
	text_ram wStringBuffer4
	text "."
	
	para "It was huge, like"
	line "this big even."
	
	para "Heh, I guess you"
	line "can't tell over"
	cont "the phone…"
	done
endc


TullyLostAMonText:
if DEF(_FR_FR)
	text "J'ai perdu un"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "Il était"
	line "ENORME!"
	
	para "Par téléphone,"
	line "c'est dur à"
	cont "décrire..."
	done
else
	text "Oh yeah, I lost a"
	line "wild @"
	text_ram wStringBuffer4
	text "."
	
	para "It was huge, like"
	line "this big even."
	
	para "Heh, I guess you"
	line "can't tell over"
	cont "the phone…"
	done
endc


TullyBattleRematchText:
if DEF(_FR_FR)
	text "Il faut qu'on se"
	line "batte!"
	
	para "Je pêche vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Viens si tu as"
	line "le temps."
	done
else
	text "We should get a"
	line "battle going!"
	
	para "I'll be fishing on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Swing by if you"
	line "have the time."
	done
endc


TullyHangUpText:
if DEF(_FR_FR)
	text "A plus tard."
	done
else
	text "Well, I'll be"
	line "seeing you."
	done
endc


TullyFoundItemText:
if DEF(_FR_FR)
	text "J'ai trouvé un"
	line "truc près de"
	cont "l'eau."
	
	para "Comme promis,"
	line "c'est pour toi."
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "I picked up a good"
	line "little thing at"
	cont "the water's edge."
	
	para "Like I promised,"
	line "it's yours."
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


TullyNoItemText:
if DEF(_FR_FR)
	text "Si j'ai trouvé"
	line "quelque chose?"
	
	para "Pas encore."
	
	para "Patience,"
	line "jeune poussin."
	done
else
	text "Have I found"
	line "anything good?"
	
	para "Nope, not yet."
	
	para "It's like fishing,"
	line "you need patience."
	done
endc


TullyForwardText:
if DEF(_FR_FR)
	text "Ici AMEDEE..."
	
	para "<PLAY_G>? Quoi?"
	line "T'es où?"
	
	para "Notre combat:"
	line "vers @"
	text_ram wStringBuffer5
	text "."
	done
else
	text "Yup, TULLY here…"
	
	para "<PLAY_G>? What?"
	line "You're lost?"
	
	para "Our battle will be"
	line "on @"
	text_ram wStringBuffer5
	text "."
	done
endc


TullyHurryText:
if DEF(_FR_FR)
	text "J'ai quelque chose"
	line "pour toi."
	
	para "Viens vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "I've got something"
	line "good for you."
	
	para "Hustle over to"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc
