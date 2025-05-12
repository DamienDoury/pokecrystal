ArnieAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui, allô?"
	line "C'est @"
	text_ram wStringBuffer3
	text "."
	
	para "Heu... <PLAY_G>?"
	done
else
	text "Yeah, hello."
	line "This is @"
	text_ram wStringBuffer3
	text "."
	
	para "…Huh, <PLAY_G>? Yo!"
	done
endc


ArnieAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui, allô?"
	line "C'est @"
	text_ram wStringBuffer3
	text "."
	
	para "Heu... <PLAY_G>?"
	done
else
	text "Yeah, hello, you"
	line "got @"
	text_ram wStringBuffer3
	text "."
	
	para "…Huh, <PLAY_G>? Yo!"
	done
endc


ArnieAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui, allô?"
	line "C'est @"
	text_ram wStringBuffer3
	text "."
	
	para "Heu... <PLAY_G>?"
	done
else
	text "Yeah, hello, you"
	line "got @"
	text_ram wStringBuffer3
	text "."
	
	para "…Huh, <PLAY_G>? Yo!"
	done
endc


ArnieGreetText:
if DEF(_FR_FR)
	text "Oui? Allô?"
	line "Ici @"
	text_ram wStringBuffer3
	text "."
	
	para "Comment ça va,"
	line "<PLAY_G>?"
	done
else
	text "Yeah, hello?"
	line "@"
	text_ram wStringBuffer3
	text " calling."
	
	para "What are you up"
	line "to, <PLAY_G>?"
	done
endc


ArnieGreetDayText:
if DEF(_FR_FR)
	text "Oui? Allô?"
	line "Ici @"
	text_ram wStringBuffer3
	text "."
	
	para "Tu es où,"
	line "<PLAY_G>?"
	done
else
	text "Yeah, hello?"
	line "@"
	text_ram wStringBuffer3
	text " calling."
	
	para "Where are you now,"
	line "<PLAY_G>?"
	done
endc


ArnieGreetNiteText:
if DEF(_FR_FR)
	text "Oui? Allô?"
	line "Ici @"
	text_ram wStringBuffer3
	text "."
	
	para "Comment ça va,"
	line "<PLAY_G>?"
	done
else
	text "Yeah, hello?"
	line "@"
	text_ram wStringBuffer3
	text " calling."
	
	para "Are you awake now,"
	line "<PLAY_G>?"
	done
endc


ArnieGenericText:
if DEF(_FR_FR)
	text "Tes #MON sont"
	line "encore plus forts"
	cont "je parie."
	done
else
	text "I bet your #MON"
	line "are a lot stronger"
	cont "than before."
	done
endc
