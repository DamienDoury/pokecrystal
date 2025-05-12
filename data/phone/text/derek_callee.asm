DerekAnswerPhoneText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Bonjour pika."
	line "Ca va pika?"
	done
else
	text "Hi, <PLAY_G>?"
	
	para "Good morning pika."
	line "What's up pika?"
	done
endc


DerekAnswerPhoneDayText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Bonjour pika."
	line "Ca va pika?"
	done
else
	text "Hi, <PLAY_G>?"
	
	para "Good day pika,"
	line "what's up pika?"
	done
endc


DerekAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Bonsoir pika."
	line "Ca va pika?"
	done
else
	text "Hi, <PLAY_G>?"
	
	para "Good evening pika,"
	line "what's up pika?"
	done
endc


DerekGreetText:
if DEF(_FR_FR)
	text "<PLAY_G> pika,"
	line "bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text ","
	line "ça va pika?"
	done
else
	text "<PLAY_G> pika, good"
	line "morning!"
	
	para "It's @"
	text_ram wStringBuffer3
	text ", how"
	line "pika are you?"
	done
endc


DerekGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G> pika,"
	line "bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text ","
	line "ça va pika?"
	done
else
	text "<PLAY_G> pika, good"
	line "pika day!"
	
	para "It's @"
	text_ram wStringBuffer3
	text ", how"
	line "pika are you?"
	done
endc


DerekGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G> pika,"
	line "bonsoir!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text ","
	line "ça va pika?"
	done
else
	text "<PLAY_G> pika, good"
	line "evening!"
	
	para "It's @"
	text_ram wStringBuffer3
	text ". Were"
	line "you pika awake?"
	done
endc


DerekGenericText:
if DEF(_FR_FR)
	text "Ecoute ça!"
	line "Mon adorable"
	
	para "@"
	text_ram wStringBuffer4
	text " m'a"
	line "fait un sourire!"
	
	para "Il m'aime!"
	line "Il m'aiiiiime!"
	done
else
	text "You have to hear"
	line "this! My lovable"
	
	para "@"
	text_ram wStringBuffer4
	text " looked"
	line "at me and grinned!"
	
	para "It must be because"
	line "our hearts beat"
	cont "together as one!"
	done
endc
