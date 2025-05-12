DanaTakingPhotosText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est tout chou!"
	
	para "J'ai pris plein"
	line "de photos!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text " is"
	line "getting prettier!"
	
	para "I've been taking"
	line "photos galore!"
	done
endc


DanaDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai mis K.O. en"
	line "une seconde un"
	cont "@"
	text_ram wStringBuffer4
	text "."
	
	para "Tes conseils ont"
	line "bien marché."
	done
else
	text "It took only an"
	line "instant to KO a"
	cont "wild @"
	text_ram wStringBuffer4
	text "."
	
	para "It must be because"
	line "you gave me some"
	
	para "battling tips last"
	line "time."
	done
endc


DanaLostAMonText:
if DEF(_FR_FR)
	text "Tu sais quoi?"
	line "Un @"
	text_ram wStringBuffer4
	text_start
	
	para "m'a encore"
	line "échappé."
	
	para "Il s'en est fallu"
	line "de si peu..."
	done
else
	text "You know what?"
	line "A wild @"
	text_ram wStringBuffer4
	text_start
	para "got away from me"
	line "again."
	
	para "It was so close!"
	line "Really, just a"
	
	para "little bit more,"
	line "and I would've…"
	done
endc


DanaBattleRematchText:
if DEF(_FR_FR)
	text "Je suis vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Si tu es dans le"
	line "coin, COMBAT!"
	cont "Je t'attends!"
	done
else
	text "Right now, I'm on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "If you're close"
	line "by, let's battle!"
	
	para "I'll be waiting"
	line "for you!"
	done
endc


DanaHangUpText:
if DEF(_FR_FR)
	text "Salut!"
	done
else
	text "See you!"
	done
endc


DanaFoundItemText:
if DEF(_FR_FR)
	text "Tu sais quoi?"
	line "J'ai un cadeau!"
	
	para "Et comme promis,"
	line "c'est pour toi!"
	
	para "Viens le chercher"
	line "vers..."
	cont "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "You know what?"
	line "I got a good gift!"
	
	para "As I promised,"
	line "it's yours!"
	
	para "I'm sure you'd"
	line "like it. Come get"
	
	para "it! I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


DanaCanYouWaitABitLongerText:
if DEF(_FR_FR)
	text "Oh! Tu voulais"
	line "un cadeau?"
	
	para "Je veux le garder"
	line "celui-ci."
	
	para "Tu peux encore"
	line "attendre un peu?"
	done
else
	text "Oh! You wanted a"
	line "gift, right?"
	
	para "I got one, but I"
	line "want to keep this."
	
	para "Can you wait a bit"
	line "longer?"
	done
endc


DanaReminderText:
if DEF(_FR_FR)
	text "Hé! Tu as oublié"
	line "notre combat!"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Hi! You haven't"
	line "forgotten about"
	
	para "your promise to"
	line "battle me?"
	
	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


DanaComePickUpText:
if DEF(_FR_FR)
	text "Allô?"
	
	para "Si tu ne viens pas"
	line "chercher ton ca-"
	
	para "deau très vite,"
	line "je le garde."
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Hello?"
	
	para "If you don't come"
	line "get your present"
	
	para "soon, I'll give it"
	line "to someone else."
	
	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc
