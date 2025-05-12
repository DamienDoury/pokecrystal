RalphNeglectingKidsText:
if DEF(_FR_FR)
	text "Je passe plus de"
	line "temps avec mon"
	
	para "@"
	text_ram wStringBuffer4
	text " qu'avec"
	line "mes enfants."
	
	para "C'est triste."
	done
else
	text "I've been spending"
	line "more time with my"
	
	para "@"
	text_ram wStringBuffer4
	text " than I"
	line "have with my kids."
	
	para "That's a bit sad,"
	line "actually."
	done
endc


RalphDefeatedMonText:
if DEF(_FR_FR)
	text "Je viens de battre"
	line "un @"
	text_ram wStringBuffer4
	text "."
	
	para "Je l'ai dit à mon"
	line "gamin, mais il dit"
	cont "avoir fait mieux."
	
	para "Il a un peu la"
	line "grosse tête."
	done
else
	text "I just beat a wild"
	line "@"
	text_ram wStringBuffer4
	text "."
	
	para "I told my kid, but"
	line "he scoffed that he"
	
	para "could do the same"
	line "thing easily."
	
	para "Boy, has he gotten"
	line "cocky…"
	done
endc


RalphLostAMonText:
if DEF(_FR_FR)
	text "Hier, un"
	line "@"
	text_ram wStringBuffer4
	text_start
	
	para "m'a échappé devant"
	line "mon gamin."
	
	para "Alors il m'a donné"
	line "ses # BALLS."
	
	para "Il a grand coeur"
	line "mon moutard!"
	done
else
	text "Yesterday a wild"
	line "@"
	text_ram wStringBuffer4
	text " slipped"
	
	para "away from me, in"
	line "front of my kid."
	
	para "I was feeling down"
	line "about it until he"
	
	para "shared his #"
	line "BALLS with me."
	
	para "Hahah, that sure"
	line "made my day!"
	done
endc


RalphBattleRematchText:
if DEF(_FR_FR)
	text "Ca te dit un"
	line "combat contre moi?"
	
	para "Bien!"
	
	para "T'es sympa, toi."
	
	para "@"
	text_ram wStringBuffer5
	text_start
	line "sera le stade!"
	done
else
	text "What do you say to"
	line "a battle with me?"
	
	para "Good, you're going"
	line "to do it!"
	
	para "For a kid, you're"
	line "quite agreeable."
	
	para "@"
	text_ram wStringBuffer5
	text " is"
	line "the spot!"
	done
endc


RalphHangUpText:
if DEF(_FR_FR)
	text "Appelle ta maman"
	line "plus souvent!"
	done
else
	text "You call your mom"
	line "sometimes too!"
	done
endc


RalphItemText:
if DEF(_FR_FR)
	text "Ecoute... Aïe!"
	
	para "Heu, pardon!"
	line "Les @"
	text_ram wStringBuffer4
	text_start
	
	para "mordent à fond!"
	line "Surtout vers"
	cont "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Aïe! Y'en a un"
	line "qui lutte!"
	
	para "Ils ont la patate,"
	line "ma parole!"
	
	para "<PLAY_G>, il faut"
	line "que tu viennes!"
	done
else
	text "Listen, I… Yowch!"
	
	para "Uh, sorry! See,"
	line "@"
	text_ram wStringBuffer4
	text " are"
	
	para "biting like there"
	line "is no tomorrow"
	
	para "over here on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Aiyee! Ouch!"
	line "One jabbed me!"
	
	para "Heh, they're some"
	line "kind of feisty!"
	
	para "<PLAY_G>, you have"
	line "to see this rare"
	
	para "sight! Get ready"
	line "to fish!"
	done
endc


RalphNoItemText:
if DEF(_FR_FR)
	text "Ouais, je sais."
	
	para "Tu cherches des"
	line "#MON rares."
	
	para "Moi...?"
	line "J'ai attrapé un"
	cont "MAGICARPE."
	done
else
	text "Yeah, I know."
	
	para "You're looking for"
	line "rare #MON."
	
	para "Recently, all I've"
	line "been catching are"
	cont "MAGIKARP, though…"
	done
endc


RalphReminderText:
if DEF(_FR_FR)
	text "Bon t'es où?"
	line "Je t'attends vers"
	cont "@"
	text_ram wStringBuffer5
	text "."
	
	para "Ne fais pas atten-"
	line "dre les anciens!"
	done
else
	text "So where are you?"
	line "I'm waiting for"
	
	para "you to show up on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "You shouldn't make"
	line "your elders wait!"
	done
endc


RalphHurryText:
if DEF(_FR_FR)
	text "C'est quoi ton"
	line "problème?"

	para "Tu viens pêcher"
	line "les STARI?"

	para "Sur la ROUTE 32!"
	line "Magne-toi!"
	done
else
	text "Hey, what's the"
	line "matter with you?"
	
	para "Aren't you coming"
	line "over to fish for"
	cont "STARYU?"
	
	para "I'm on ROUTE 32,"
	line "so hurry up!"
	done
endc
