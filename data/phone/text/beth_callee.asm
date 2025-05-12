BethAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut, c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Bonjour."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Good morning."
	
	para ""
	done
endc


BethAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut, c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Bonjour."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh. Hi, <PLAY_G>."
	done
endc


BethAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut, c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Bonsoir."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Good evening."
	done
endc


BethGreetText:
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Tu dormais?"
	done
else
	text "Good morning,"
	line "<PLAY_G>!"
	
	para "This is @"
	text_ram wStringBuffer3
	text "."
	line "Were you sleeping?"
	done
endc


BethGreetDayText:
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Tu as une seconde?"
	done
else
	text "<PLAY_G>, hi!"
	line "This is @"
	text_ram wStringBuffer3
	text "."
	
	para "Do you have some"
	line "time?"
	done
endc


BethGreetNiteText:
if DEF(_FR_FR)
	text "Salut <PLAY_G>."
	line "Bonsoir."
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	
	para "T'es debout?"
	done
else
	text "Hi, <PLAY_G>."
	line "Good evening."
	
	para "This is @"
	text_ram wStringBuffer3
	text "."
	
	para "I hope you were"
	line "awake."
	done
endc


BethGenericText:
if DEF(_FR_FR)
	text "Tu vas dans les"
	line "CENTRES #MON"
	cont "souvent?"
	
	para "Moi j'y vais tous"
	line "les jours."
	
	para "Faire attention"
	line "à la santé de ses"
	cont "#MON, c'est la"
	cont "base du succès."
	done
else
	text "Are you the kind"
	line "of person who goes"
	
	para "to #MON CENTERS"
	line "often?"
	
	para "I go every day."
	line "Watching out for"
	
	para "the health of your"
	line "#MON is a basic"
	
	para "part of being a"
	line "#MON trainer."
	done
endc
