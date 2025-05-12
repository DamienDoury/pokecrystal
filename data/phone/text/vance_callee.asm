VanceAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui, allô?"
	line "Ici @"
	text_ram wStringBuffer3
	text "!"
	
	para "Bonjour, <PLAY_G>!"
	
	para "Tu aimes les"
	line "#MON oiseaux?"
	done
else
	text "Yes, hello?"
	line "@"
	text_ram wStringBuffer3
	text " here!"
	
	para "Morning, <PLAY_G>!"
	
	para "Are you using bird"
	line "#MON?"
	done
endc


VanceAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui, allô?"
	line "Ici @"
	text_ram wStringBuffer3
	text "!"
	
	para "Bonjour, <PLAY_G>!"
	
	para "Tu aimes les"
	line "#MON oiseaux?"
	done
else
	text "Yes, hello?"
	line "@"
	text_ram wStringBuffer3
	text " here!"
	
	para "Hi, <PLAY_G>!"
	
	para "Are your bird"
	line "#MON flying?"
	done
endc


VanceAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui, allô?"
	line "Ici @"
	text_ram wStringBuffer3
	text "!"
	
	para "Bonsoir, <PLAY_G>!"
	
	para "Tu aimes les"
	line "#MON oiseaux?"
	done
else
	text "Yes, hello?"
	line "@"
	text_ram wStringBuffer3
	text " here!"
	
	para "Evening, <PLAY_G>!"
	line "Are you letting"
	
	para "your bird #MON"
	line "see some action?"
	done
endc


VanceGreetText:
if DEF(_FR_FR)
	text "Salut,"
	line "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Bonjour!"
	done
else
	text "Good morning,"
	line "<PLAY_G>!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "!"
	line "Good morning!"
	done
endc


VanceGreetDayText:
if DEF(_FR_FR)
	text "Salut, <PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Tu te souviens?"
	done
else
	text "Hi, <PLAY_G>!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "!"
	line "Remember me?"
	done
endc


VanceGreetNiteText:
if DEF(_FR_FR)
	text "Bonsoir,"
	line "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "T'as une minute?"
	done
else
	text "Good evening,"
	line "<PLAY_G>!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "!"
	line "Are you free now?"
	done
endc


VanceGenericText:
if DEF(_FR_FR)
	text "Toi et tes #MON"
	line "allez bien?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est assez fort"
	
	para "pour affronter les"
	line "#MON oiseaux"
	cont "légendaires!"
	done
else
	text "Are you and your"
	line "#MON fine?"
	
	para "My @"
	text_ram wStringBuffer4
	text_start
	line "looks like it will"
	
	para "get tough enough"
	line "to face and beat"
	
	para "the legendary bird"
	line "#MON!"
	done
endc
