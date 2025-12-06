DerekCheekPinchingText:
if DEF(_FR_FR)
	text "Ecoute ça."
	line "Mon @"
	text_ram wStringBuffer4
	text_start
	
	para "sourit quand je"
	line "lui pince la"
	cont "joue."
	
	para "Mais il ne fait"
	line "ça qu'avec moi."
	
	para "Il est spécial."
	done
else
	text "Listen to this."
	line "My @"
	text_ram wStringBuffer4
	text_start
	para "grins happily when"
	line "I pinch its cheek."
	
	para "But it never grins"
	line "for anyone else."
	
	para "I must be special."
	done
endc


DerekDefeatedMonText:
if DEF(_FR_FR)
	text "Oh, dernièrement"
	line "mon PIKACHU a"
	cont "battu un"
	cont "@"
	text_ram wStringBuffer4
	text "!"
	
	para "Un @"
	text_ram wStringBuffer4
	text ","
	line "j'te jure!"
	
	para "C'est dingue, non?"
	
	para "Mon PIKACHU est"
	line "trop fort!"
	
	para "Mon PIKACHU est le"
	line "plus grand!"
	done
else
	text "Oh, and recently,"
	line "my PIKACHU beat a"
	cont "wild @"
	text_ram wStringBuffer4
	text "!"
	
	para "A wild @"
	text_ram wStringBuffer4
	text ","
	line "I tell you!"
	
	para "Don't you think"
	line "that's astounding?"
	
	para "My PIKACHU is"
	line "awesome!"
	
	para "My PIKACHU is the"
	line "greatest!"
	done
endc


DerekLostAMonText:
if DEF(_FR_FR)
	text "J'ai vu un"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "y'a pas longtemps."
	
	para "Mais il n'était"
	line "pas mignon, alors"
	
	para "je l'ai laissé..."
	line "Moi j'aime que"
	
	para "ceux qui sont"
	line "mignons."
	done
else
	text "Oh, and I saw a"
	line "wild @"
	text_ram wStringBuffer4
	text " a"
	cont "little while ago."
	
	para "But it wasn't very"
	line "cute, so I left"
	
	para "it…"
	line "#MON have to be"
	
	para "cute. They're no"
	line "good otherwise."
	done
endc


DerekHangUpText:
if DEF(_FR_FR)
	text "A la prochaine!"
	done
else
	text "Well, let's talk"
	line "again!"
	done
endc


DerekBugCatchingContestText:
if DEF(_FR_FR)
	text "Le Concours de"
	line "Capture, c'est"
	cont "aujourd'hui."
	
	para "Tu y vas, toi?"
	
	para "Je vais y aller"
	line "avec PIKACHU pour"
	cont "montrer sa jolie"
	cont "frimousse."
	done
else
	text "Did you remember?"
	line "The Bug-Catching"
	cont "Contest is today."
	
	para "You're going to"
	line "go, aren't you?"
	
	para "I think I'll"
	line "participate with"
	
	para "PIKACHU to show"
	line "off its cuteness."
	done
endc


DerekFoundItemText:
if DEF(_FR_FR)
	text "J'ai un ROULEAU"
	line "d'PQ pour toi."

	para "De la top qualité,"
	line "triple épaisseur,"
	cont "et super doux."

	para "Pas de doute, tu"
	line "vas l'adorer!"
	done
else
	text "I'd like you to"
	line "have some"
	cont "TOILET PAPER."
	
	para "It's top quality,"
	line "3-ply sheet, and"
	cont "super soft."
	
	para "I'm certain you'll"
	line "love it!"
	done
endc


DerekLetsGetTogetherText:
if DEF(_FR_FR)
	text "Comment va ton"
	line "PIKACHU?"
	
	para "On se voit et on"
	line "parle de PIKACHU,"
	cont "OK?"
	done
else
	text "How is your"
	line "PIKACHU doing?"
	
	para "Let's get together"
	line "and brag about our"
	cont "PIKACHU!"
	done
endc


DerekComePickUpText:
if DEF(_FR_FR)
	text "Bah alors?"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Viens chercher"
	line "ton truc."
	done
else
	text "What's wrong?"
	
	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Come pick this up"
	line "anytime."
	done
endc
