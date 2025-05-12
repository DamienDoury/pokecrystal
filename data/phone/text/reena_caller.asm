ReenaMonsIsAPerfectMatchText:
if DEF(_FR_FR)
	text "Ecoute..."
	
	para "Tu te souviens de"
	line "@"
	text_ram wStringBuffer4
	text "?"
	
	para "Mon joli petit"
	line "@"
	text_ram wStringBuffer4
	text "."
	
	para "Tu le trouves"
	line "joli, non?"
	done
else
	text "Listen, dear…"
	
	para "Do you recall my"
	line "@"
	text_ram wStringBuffer4
	text "?"
	
	para "Yes, exactly. That"
	line "lovely @"
	text_ram wStringBuffer4
	text "."
	
	para "Wouldn't you agree"
	line "it's a perfect"
	cont "match for me?"
	done
endc


ReenaDefeatedMonText:
if DEF(_FR_FR)
	text "Quoi? Si j'ai déjà"
	line "vu un @"
	text_ram wStringBuffer4
	text "?"
	
	para "Tu me prends pour"
	line "qui?"
	
	para "J'en ai battu des"
	line "tas!"
	done
else
	text "Have I ever faced"
	line "a wild @"
	text_ram wStringBuffer4
	text "?"
	
	para "You need to ask?"
	
	para "@"
	text_ram wStringBuffer4
	text " I've"
	line "beaten on numerous"
	cont "occasions!"
	done
endc


ReenaLostAMonText:
if DEF(_FR_FR)
	text "Si j'ai déjà loupé"
	line "un #MON?"
	
	para "Tu me prends pour"
	line "qui?"
	
	para "Moi je manque ja-"
	line "mais d'attraper un"
	
	para "@"
	text_ram wStringBuffer4
	text_start
	line "sauvage! Et ouais!"
	done
else
	text "Have I ever failed"
	line "to catch a wild"
	cont "#MON?"
	
	para "You need to ask?"
	
	para "I would never fail"
	line "to catch a wild"
	
	para "@"
	text_ram wStringBuffer4
	text "…"
	line "Oh! Never mind!"
	done
endc


ReenaBattleRematchText:
if DEF(_FR_FR)
	text "On va se faire"
	line "un combat!"
	
	para "Vers..."
	line "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Ne me fais pas"
	line "attendre, OK?"
	done
else
	text "We are going to"
	line "battle!"
	
	para "The place shall be"
	line "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Don't make me"
	line "wait! Got it?"
	done
endc


ReenaHangUpText:
if DEF(_FR_FR)
	text "OK. Tchao."
	done
else
	text "Fine, you may go."
	done
endc


ReenaForwardText:
if DEF(_FR_FR)
	text "Ne crâne pas si tu"
	line "as pu me battre!"
	
	para "C'est bas!"
	done
else
	text "Don't be too proud"
	line "just because you"
	
	para "happened to beat"
	line "me… "
	
	para "It was a fluke!"
	done
endc


ReenaHurryText:
if DEF(_FR_FR)
	text "Qu'est-ce que tu"
	line "fabriques?"
	
	para "Viens vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	cont "T'as peur?"
	done
else
	text "What are you"
	line "doing?"
	
	para "I told you that"
	line "the place was"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "Don't try to run!"
	done
endc
