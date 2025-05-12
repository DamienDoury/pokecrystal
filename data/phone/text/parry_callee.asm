ParryAnswerPhoneText:
if DEF(_FR_FR)
	text "Et ouais!"
	line "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "Te voilà,"
	line "<PLAY_G>!"
	done
else
	text "Yup, yup!"
	line "It's @"
	text_ram wStringBuffer3
	text "!"
	
	para "Hah, and here's"
	line "<PLAY_G>!"
	done
endc


ParryAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Et ouais!"
	line "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "Te voilà,"
	line "<PLAY_G>!"
	done
else
	text "Yup, yup!"
	line "It's @"
	text_ram wStringBuffer3
	text "!"
	
	para "Hah, and here's"
	line "<PLAY_G>!"
	done
endc


ParryAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Et ouais!"
	line "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "Te voilà,"
	line "<PLAY_G>!"
	done
else
	text "Yup, yup!"
	line "It's @"
	text_ram wStringBuffer3
	text "!"
	
	para "Hah, and here's"
	line "<PLAY_G>!"
	done
endc


ParryGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>, c'est"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Tu as pris ton"
	line "p'tit déj?"
	done
else
	text "<PLAY_G>, it's"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Have you had a"
	line "proper breakfast?"
	done
endc


ParryGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>, c'est"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Tu as déjà"
	line "déjeuné?"
	done
else
	text "<PLAY_G>, it's"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Have you had a"
	line "proper lunch?"
	done
endc


ParryGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>, c'est"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Tu as déjà"
	line "dîné?"
	done
else
	text "<PLAY_G>, it's"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Have you had a"
	line "proper dinner?"
	done
endc


ParryGenericText:
if DEF(_FR_FR)
	text "Tes #MON"
	line "ont la pêche?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text " et"
	line "moi-même, c'est la"
	
	para "super joie!"
	line "Hahahah!"
	done
else
	text "Are your #MON"
	line "looking good?"
	
	para "My @"
	text_ram wStringBuffer4
	text " and"
	line "me--we're looking"
	
	para "mighty dandy!"
	line "Hahahah!"
	done
endc
