BeverlyAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh! Bonjour,"
	line "<PLAYER>."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh! Good morning,"
	line "<PLAYER>."
	done
endc


BeverlyAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh! Bonjour,"
	line "<PLAYER>."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh! Good day,"
	line "<PLAYER>."
	done
endc


BeverlyAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh! Bonsoir,"
	line "<PLAYER>."
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh! Good evening,"
	line "<PLAYER>."
	done
endc


BeverlyGreetText:
if DEF(_FR_FR)
	text "Salut, <PLAYER>."
	line "Bonjour."
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Tu dormais?"
	done
else
	text "Hello, <PLAYER>."
	line "Good morning."
	
	para "This is @"
	text_ram wStringBuffer3
	text "."
	line "Were you asleep?"
	done
endc


BeverlyGreetDayText:
if DEF(_FR_FR)
	text "Salut <PLAYER>."
	line "C'est @"
	text_ram wStringBuffer3
	text "."
	
	para "Comment tu vas?"
	done
else
	text "Hi, <PLAYER>."
	line "This is @"
	text_ram wStringBuffer3
	text "."
	
	para "How are you doing?"
	done
endc


BeverlyGreetNiteText:
if DEF(_FR_FR)
	text "Salut <PLAYER>."
	line "C'est @"
	text_ram wStringBuffer3
	text "."
	
	para "Tu dormais?"
	done
else
	text "Hi, <PLAYER>."
	line "This is @"
	text_ram wStringBuffer3
	text "."
	
	para "Were you awake?"
	done
endc


BeverlyGenericText:
if DEF(_FR_FR)
	text "Tes #MON"
	line "sont heureux?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est en forme."
	cont "Il bouffe bien."
	done
else
	text "Keeping your"
	line "#MON happy?"
	
	para "My @"
	text_ram wStringBuffer4
	text " is"
	line "healthy. It eats a"
	cont "lot every day."
	done
endc
