ToddAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>!"
	done
else
	text "Yes? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."
	
	para "Hey, <PLAY_G>!"
	done
endc


ToddAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>?"
	done
else
	text "Yes? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."
	
	para "This must be"
	line "<PLAY_G>."
	done
endc


ToddAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>!"
	done
else
	text "Yes? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."
	
	para "Ah, <PLAY_G>!"
	done
endc


ToddGreetText:
if DEF(_FR_FR)
	text "Allô, c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>, right?"
	done
endc


ToddGreetDayText:
if DEF(_FR_FR)
	text "Allô, c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>?"
	line "Ca va?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>, what are"
	line "you doing?"
	done
endc


ToddGreetNiteText:
if DEF(_FR_FR)
	text "Allô, c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>?"
	line "Il est trop tard?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>, sorry to"
	line "call you so late."
	done
endc


ToddGenericText:
if DEF(_FR_FR)
	text "Comment entraînes-"
	line "tu tes #MON?"
	
	para "Moi j'utilise en-"
	line "tre autres des"
	
	para "objets et je les"
	line "laisse souvent à"
	cont "la PENSION."
	done
else
	text "How do you raise"
	line "your #MON?"
	
	para "I do all sorts"
	line "of things, like"
	
	para "leaving them in"
	line "DAY-CARE and"
	
	para "toughening them up"
	line "with items."
	done
endc

ToddLockdownText:
if DEF(_FR_FR)
	text "Raaah, j'ai trop"
	line "la rage que le"
	cont "CENTRE COMMERCIAL"
	cont "soit fermé..."

	para "Les soldes me"
	line "manquent."
	done
else
	text "Gaaah, I'm so"
	line "bummed the"
	cont "DEPARTMENT STORE"
	cont "is closed..."

	para "I miss all the"
	line "great sales."
	done
endc