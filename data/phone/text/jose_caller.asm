JoseMonsStickHasADeliciousAromaText:
if DEF(_FR_FR)
	text "Hé! Le bâton de"
	line "mon @"
	text_ram wStringBuffer4
	text_start
	cont "sent super bon."
	
	para "Ca me donne faim!"
	done
else
	text "Hey listen, my"
	line "@"
	text_ram wStringBuffer4
	text "'s stick"
	
	para "has this really"
	line "delicious aroma."
	
	para "That aroma gets my"
	line "appetite going!"
	done
endc


JoseDefeatedMonText:
if DEF(_FR_FR)
	text "L'autre fois, mon"
	line "CANARTICHO a mis"
	cont "K.O. un"
	cont "@"
	text_ram wStringBuffer4
	text "."
	
	para "Avec son bâton,"
	line "mon CANARTICHO est"
	cont "trop bô!"
	done
else
	text "A while ago, my"
	line "FARFETCH'D KO'd"
	cont "this @"
	text_ram wStringBuffer4
	text "."
	
	para "You should have"
	line "seen FARFETCH'D"
	
	para "wield that stick."
	line "Amazing stuff!"
	done
endc


JoseLostAMonText:
if DEF(_FR_FR)
	text "J'ai vu un"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "sauvage..."
	
	para "J'ai voulu l'at-"
	line "traper mais il"
	
	para "s'est enfui super"
	line "vite!"
	done
else
	text "I ran into a wild"
	line "@"
	text_ram wStringBuffer4
	text "…"
	
	para "I was trying to"
	line "catch it, but it"
	
	para "took off faster"
	line "than I thought it"
	
	para "would. It was a"
	line "bit disappointing."
	done
endc


JoseBattleRematchText:
if DEF(_FR_FR)
	text "Tu veux te refaire"
	line "un match?"
	
	para "Mon CANARTICHO en"
	line "redemande!"
	
	para "@"
	text_ram wStringBuffer5
	text ","
	line "c'est là où je"
	
	para "suis..."
	line "Viens me chercher!"
	done
else
	text "Want to battle"
	line "again?"
	
	para "For some reason,"
	line "my FARFETCH'D is"
	
	para "all worked up and"
	line "raring to go."
	
	para "@"
	text_ram wStringBuffer5
	text "'s"
	line "where I'm at."
	
	para "Keep an eye out"
	line "for me, OK?"
	done
endc


JoseHangUpText:
if DEF(_FR_FR)
	text "A plus tard!"
	done
else
	text "Be seeing you!"
	done
endc


JoseFoundItemText:
if DEF(_FR_FR)
	text "Mon CANARTICHO"
	line "avait un drôle de"
	cont "truc dans le bec."
	
	para "Tu peux l'avoir."
	
	para "Viens vers"
	line "@"
	text_ram wStringBuffer5
	text ","
	cont "et c'est à toi."
	done
else
	text "My FARFETCH'D had"
	line "something pretty"
	cont "in its beak."
	
	para "Like I promised,"
	line "you can have it."
	
	para "Catch up to me on"
	line "@"
	text_ram wStringBuffer5
	text ","
	
	para "and I'll let you"
	line "have it."
	done
endc


JoseHaventGottenItemYetText:
if DEF(_FR_FR)
	text "Je n'ai pas encore"
	line "ce que je t'ai"
	cont "promis."
	
	para "Je t'appelle si"
	line "je l'ai."
	cont "Attends un peu!"
	done
else
	text "I haven't gotten"
	line "what I promised"
	cont "you yet."
	
	para "I'll call you as"
	line "soon as I get it,"
	
	para "so could you wait"
	line "a little longer?"
	done
endc


JoseReminderText:
if DEF(_FR_FR)
	text "<PLAY_G>, peux-tu"
	line "venir?"
	
	para "CANARTICHO est"
	line "très agité."
	
	para "Viens vite ou il"
	line "va me donner un"
	cont "coup de bâton!"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Viens vite!"
	done
else
	text "<PLAY_G>, could you"
	line "hurry over?"
	
	para "FARFETCH'D is"
	line "agitated."
	
	para "If you don't come"
	line "soon, it might"
	
	para "smack me with its"
	line "stick!"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Please come as"
	line "soon as you can!"
	done
endc


JoseComePickUpText:
if DEF(_FR_FR)
	text "Ben alors?"
	
	para "Tu ne veux pas de"
	line "mon cadeau?"
	
	para "Viens vers"
	line "@"
	text_ram wStringBuffer5
	text_start
	cont "et c'est à toi."
	done
else
	text "What's wrong?"
	
	para "Don't you want"
	line "this gift?"
	
	para "Catch up to me on"
	line "@"
	text_ram wStringBuffer5
	text ","
	
	para "and I'll let you"
	line "have it."
	done
endc
