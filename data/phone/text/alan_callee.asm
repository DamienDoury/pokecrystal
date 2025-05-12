AlanAnswerPhoneText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "<PLAY_G>?"
	line "Bonjour, toi!"
	done
else
	text "Yup, it's @"
	text_ram wStringBuffer3
	text "!"
	
	para "Is this <PLAY_G>?"
	line "Good morning!"
	done
endc


AlanAnswerPhoneDayText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "<PLAY_G>?"
	done
else
	text "Yup, it's @"
	text_ram wStringBuffer3
	text "!"
	
	para "Is that <PLAY_G>?"
	done
endc


AlanAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "<PLAY_G>?"
	line "Bonsoir, toi!"
	done
else
	text "Yup, it's @"
	text_ram wStringBuffer3
	text "!"
	
	para "Is that <PLAY_G>?"
	line "Good evening!"
	done
endc


AlanGreetText:
if DEF(_FR_FR)
	text "Allô! C'est"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hello! It's me,"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc


AlanGreetDayText:
if DEF(_FR_FR)
	text "Allô! C'est"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hello! It's me,"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc


AlanGreetNiteText:
if DEF(_FR_FR)
	text "Allô! C'est"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hello! It's me,"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc


AlanGenericText:
if DEF(_FR_FR)
	text "<PLAY_G>, tu"
	line "entraînes bien"
	cont "tes #MON?"
	
	para "J'ai lu qu'il faut"
	line "entraîner ses"
	
	para "#MON avec amour"
	line "et attention."
	done
else
	text "<PLAY_G>, are you"
	line "raising your"
	cont "#MON properly?"
	
	para "I read in a book"
	line "that you should"
	
	para "raise any #MON"
	line "you catch with"
	cont "love and care."
	done
endc
