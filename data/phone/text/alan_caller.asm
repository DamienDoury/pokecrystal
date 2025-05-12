AlanGettingStrongerText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est très fort!"
	cont "Je l'avais prévu!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text "'s"
	line "getting stronger,"
	
	para "exactly as I"
	line "calculated!"
	done
endc


AlanDefeatedMonText:
if DEF(_FR_FR)
	text "Au fait, j'ai"
	line "battu un"
	
	para "@"
	text_ram wStringBuffer4
	text_start
	line "l'autre jour."
	
	para "S'entraîner, ça"
	line "paye!"
	done
else
	text "By the way, we"
	line "knocked out a wild"
	
	para "@"
	text_ram wStringBuffer4
	text " just"
	line "the other day."
	
	para "Studying up in"
	line "advance worked!"
	done
endc


AlanLostAMonText:
if DEF(_FR_FR)
	text "Au fait, un"
	line "@"
	text_ram wStringBuffer4
	text " m'a"
	cont "échappé hier."
	
	para "Une erreur de"
	line "tactique..."
	done
else
	text "By the way, a wild"
	line "@"
	text_ram wStringBuffer4
	text " escaped"
	cont "on me yesterday."
	
	para "A computational"
	line "error on my part…"
	done
endc


AlanBattleRematchText:
if DEF(_FR_FR)
	text "J'ai bien étudié"
	line "et j'ai fait de"
	cont "gros progrès!"
	
	para "Je suis vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Tu viens te faire"
	line "un p'tit combat?"
	done
else
	text "I've studied quite"
	line "a bit since then,"
	
	para "and I've gotten a"
	line "lot better!"
	
	para "I'm hanging out on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Can you come down"
	line "for a battle?"
	done
endc


AlanHangUpText:
if DEF(_FR_FR)
	text "A plus tard!"
	done
else
	text "See you later!"
	done
endc


AlanFoundItemText:
if DEF(_FR_FR)
	text "J'ai trouvé un"
	line "truc chouette!"
	
	para "C'est pour toi!"
	line "Tu viens vers"
	
	para "@"
	text_ram wStringBuffer5
	text_start
	line "pour le prendre?"
	done
else
	text "Hehehe, I picked"
	line "up something nice!"
	
	para "You can have it!"
	line "Why don't you come"
	
	para "to @"
	text_ram wStringBuffer5
	text_start
	line "and pick it up?"
	done
endc


AlanHaventPickedUpAnythingText:
if DEF(_FR_FR)
	text "Je n'ai encore"
	line "rien trouvé."
	
	para "Je t'appelle si"
	line "j'ai du nouveau."
	done
else
	text "I haven't picked"
	line "up anything yet."
	
	para "I'll call you if I"
	line "find something."
	done
endc


AlanReminderText:
if DEF(_FR_FR)
	text "Y faut qu'on se"
	line "batte! Je vais"
	cont "oublier ma super"
	cont "stratégie!"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "If we don't battle"
	line "soon, I'll forget"
	cont "my strategy!"
	
	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


AlanComePickUpGiftText:
if DEF(_FR_FR)
	text "J'ai des devoirs à"
	line "faire. Tu peux"
	
	para "venir prendre ton"
	line "cadeau maintenant?"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "I have to do my"
	line "homework, so can"
	
	para "you come get your"
	line "gift right away?"
	
	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc
