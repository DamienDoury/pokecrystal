ChadAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "<PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Hi, <PLAY_G>!"
	line "Good morning!"
	done
endc


ChadAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "<PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Hi, <PLAY_G>, good"
	line "day!"
	done
endc


ChadAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "<PLAY_G>!"
	line "Bonsoir!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Hi, <PLAY_G>, good"
	line "evening!"
	done
endc


ChadGreetText:
if DEF(_FR_FR)
	text "Bonjour <PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Comment va?"
	done
else
	text "Hi, <PLAY_G>, good"
	line "morning!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "."
	line "How are you?"
	done
endc


ChadGreetDayText:
if DEF(_FR_FR)
	text "Bonjour <PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Comment va?"
	done
else
	text "Hi, <PLAY_G>, good"
	line "day!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "."
	line "How are you?"
	done
endc


ChadGreetNiteText:
if DEF(_FR_FR)
	text "Bonsoir <PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Comment va?"
	done
else
	text "Hi, <PLAY_G>, good"
	line "evening!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "."
	line "How are you?"
	done
endc


ChadGenericText:
if DEF(_FR_FR)
	text "Comment vont tes"
	line "#MON?"
	
	para "Vu que tu connais"
	line "le PROF.CHEN, tes"
	cont "#MON sont"
	cont "forcément en"
	cont "bonne forme!"
	
	para "Mes #MON vont"
	line "bien."
	
	para "J'essaie aussi de"
	line "devenir un"
	cont "professeur #MON"
	cont "de mon côté."
	done
else
	text "How are your"
	line "#MON doing?"
	
	para "You know PROF.OAK,"
	line "so of course your"
	cont "#MON are fine!"
	
	para "My #MON are"
	line "doing well too."
	
	para "But then, I am"
	line "trying to become a"
	
	para "#MON professor,"
	line "so that shouldn't"
	cont "be a big surprise."
	done
endc
