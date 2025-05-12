GinaAnswerPhoneText:
if DEF(_FR_FR)
	text "Allô? C'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>!"
	line "Good morning!"
	done
endc


GinaAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Allô? C'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>!"
	line "Ca va?"
	done
else
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>!"
	line "Hi, how are you?"
	done
endc


GinaAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Allô? C'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>!"
	line "Bonsoir!"
	done
else
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>!"
	line "Good evening!"
	done
endc


GinaGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Bonjour!"
	done
else
	text "<PLAY_G>?"
	
	para "It's @"
	text_ram wStringBuffer3
	text "."
	line "Good morning!"
	done
endc


GinaGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Je te dérange?"
	done
else
	text "<PLAY_G>?"
	
	para "It's @"
	text_ram wStringBuffer3
	text ". Is"
	line "this a bad time?"
	done
endc


GinaGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'as une minute?"
	done
else
	text "<PLAY_G>?"
	
	para "It's @"
	text_ram wStringBuffer3
	text "."
	line "Got time to chat?"
	done
endc


GinaGenericText:
if DEF(_FR_FR)
	text "Tes #MON sont"
	line "toujours aussi"
	cont "puissants?"
	
	para "J'entraîne à fond"
	line "mon @"
	text_ram wStringBuffer4
	text_start
	cont "tous les jours."
	done
else
	text "Are your #MON"
	line "still tough?"
	
	para "I train every day"
	line "with @"
	text_ram wStringBuffer4
	text "."
	done
endc
