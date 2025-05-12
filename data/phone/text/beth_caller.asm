BethExhilaratingRideText:
if DEF(_FR_FR)
	text "Tu te souviens de"
	line "mon @"
	text_ram wStringBuffer4
	text "?"
	
	para "@"
	text_ram wStringBuffer4
	text " court"
	line "très vite."
	
	para "C'est rigolo de"
	line "monter sur son"
	cont "dos."
	done
else
	text "Do you remember my"
	line "sweet @"
	text_ram wStringBuffer4
	text "?"
	
	para "@"
	text_ram wStringBuffer4
	text " runs"
	line "very fast."
	
	para "It's exhilarating"
	line "to ride on its"
	
	para "back when it"
	line "really gets going."
	done
endc


BethDefeatedMonText:
if DEF(_FR_FR)
	text "Oh, as-tu déjà vu"
	line "un @"
	text_ram wStringBuffer4
	text "?"
	
	para "Je viens d'en"
	line "affronter un..."
	
	para "Il était super"
	line "rapide!"
	
	para "Mais j'ai gagné,"
	line "bien sûr."
	done
else
	text "Oh, have you ever"
	line "seen a @"
	text_ram wStringBuffer4
	text_start
	cont "before?"
	
	para "I just battled"
	line "one…"
	
	para "It was much faster"
	line "than I expected."
	
	para "I was a little"
	line "shocked."
	
	para "I still won, of"
	line "course."
	done
endc


BethLostAMonText:
if DEF(_FR_FR)
	text "Je viens de voir"
	line "un @"
	text_ram wStringBuffer4
	text "."
	
	para "J'ai voulu l'at-"
	line "traper mais je"
	
	para "n'avais plus de"
	line "# BALLS."
	
	para "Comme quoi, il"
	line "faut toujours"
	
	para "vérifier son"
	line "équipement."
	done
else
	text "Oh, I just saw a"
	line "wild @"
	text_ram wStringBuffer4
	text "."
	
	para "I was trying to"
	line "catch it when I"
	
	para "noticed that I was"
	line "all out of #"
	cont "BALLS."
	
	para "If you don't check"
	line "your items, you"
	
	para "may run out at the"
	line "worst time."
	
	para "I hope you learn"
	line "from my mistake."
	done
endc


BethBattleRematchText:
if DEF(_FR_FR)
	text "Tu veux combattre?"
	line "Je gagnerai cette"
	cont "fois!"
	
	para "Je t'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "Do you want to"
	line "battle? I'm going"
	cont "to win this time!"
	
	para "I'll be waiting"
	line "for you around"
	
	para "@"
	text_ram wStringBuffer5
	text "."
	line "Look for me, OK?"
	done
endc


BethHangUpText:
if DEF(_FR_FR)
	text "OK, salut!"
	done
else
	text "OK, bye-bye!"
	done
endc


BethLetsBattleAgainSometimeText:
if DEF(_FR_FR)
	text "Faisons un match"
	line "un de ces jours!"
	done
else
	text "Let's battle again"
	line "sometime!"
	done
endc


BethReminderText:
if DEF(_FR_FR)
	text "Heu... <PLAY_G>?"
	line "Bah alors?"
	
	para "Tu as oublié notre"
	line "rendez-vous?"
	
	para "@"
	text_ram wStringBuffer5
	text "."
	
	para "C'est là où"
	line "je poireaute."
	done
else
	text "Um… <PLAY_G>?"
	line "What's wrong?"
	
	para "Did you forget our"
	line "deal?"
	
	para "@"
	text_ram wStringBuffer5
	text "."
	
	para "That's where I'm"
	line "waiting."
	done
endc
