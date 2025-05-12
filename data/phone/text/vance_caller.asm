VanceMonHasBecomeTougherText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est super fort."
	
	para "Une vraie terreur!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text "'s"
	line "become tougher."
	
	para "We've achieved"
	line "liftoff!"
	done
endc


VanceDefeatedMonText:
if DEF(_FR_FR)
	text "On peut battre"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "Hein? Toi aussi?"
	line "Formidable!"
	done
else
	text "We can easily beat"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "…Huh? You too?"
	line "Isn't that great?"
	done
endc


VanceLostAMonText:
if DEF(_FR_FR)
	text "Ecoute ça,"
	line "un @"
	text_ram wStringBuffer4
	text_start
	cont "m'a échappé."
	
	para "Je voulais lui"
	line "VOLER après..."
	done
else
	text "But get this, a"
	line "wild @"
	text_ram wStringBuffer4
	text_start
	para "just barely eluded"
	line "us."
	
	para "I wanted to FLY"
	line "after it…"
	done
endc


VanceBattleRematchText:
if DEF(_FR_FR)
	text "Je suis vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Là où on s'est"
	line "rencontré!"
	
	para "On s'bat?"
	line "Je t'attends."
	done
else
	text "Right now, I'm on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "You know, where I"
	line "first met you?"
	
	para "Want to battle?"
	line "I'll wait here."
	done
endc


VanceHangUpText:
if DEF(_FR_FR)
	text "OK, à bientôt!"
	done
else
	text "OK, bye for now!"
	done
endc


VanceLookingForwardText:
if DEF(_FR_FR)
	text "J'attends notre"
	line "prochain combat!"
	done
else
	text "I'll be looking"
	line "forward to our"
	cont "next battle!"
	done
endc


VanceHurryHurryText:
if DEF(_FR_FR)
	text "Oh, <PLAY_G>!"
	line "Vite!"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "VOLE! Viens!"
	done
else
	text "Oh, <PLAY_G>!"
	line "Hurry, hurry!"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "FLY over now!"
	done
endc
