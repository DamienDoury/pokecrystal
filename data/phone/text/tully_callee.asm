TullyAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, bonjour,"
	line "<PLAY_G>."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, Good morning,"
	line "<PLAY_G>."
	done
endc


TullyAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "C'est..."
	line "<PLAY_G>?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "That voice…"
	line "<PLAY_G>, right?"
	done
endc


TullyAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "C'est..."
	line "<PLAY_G>?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "This must be"
	line "<PLAY_G>!"
	done
endc


TullyGreetText:
if DEF(_FR_FR)
	text "Allô!"
	line "Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour!"
	line "Il fait beau!"
	done
else
	text "Hello!"
	line "@"
	text_ram wStringBuffer3
	text " here…"
	
	para "Good morning! The"
	line "weather's great!"
	done
endc


TullyGreetDayText:
if DEF(_FR_FR)
	text "Allô!"
	line "Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour!"
	line "Vive la pêche!"
	done
else
	text "Hello!"
	line "@"
	text_ram wStringBuffer3
	text " here…"
	
	para "What a perfect day"
	line "for fishing!"
	done
endc


TullyGreetNiteText:
if DEF(_FR_FR)
	text "Allô!"
	line "Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour!"
	line "Vive la pêche!"
	done
else
	text "Hello!"
	line "@"
	text_ram wStringBuffer3
	text " here…"
	
	para "It's a great night"
	line "for fishing!"
	done
endc


TullyGenericText:
if DEF(_FR_FR)
	text "Ca va ton"
	line "p'tit voyage?"
	
	para "Moi la pêche..."
	line "Ca marche!"
	done
else
	text "How's your trip"
	line "coming along?"
	
	para "I can't complain"
	line "about my fishing!"
	done
endc
