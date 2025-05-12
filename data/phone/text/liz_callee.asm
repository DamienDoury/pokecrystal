LizAnswerPhoneText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "à l'appareil."
	
	para "Oh, <PLAY_G>."
	line "Bonjour."
	done
else
	text "Hello, @"
	text_ram wStringBuffer3
	text_start
	line "speaking."
	
	para "Oh, <PLAY_G>."
	line "Good morning."
	done
endc


LizAnswerPhoneDayText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "à l'appareil."
	
	para "Oh, <PLAY_G>."
	line "Ca va?"
	done
else
	text "Hello, @"
	text_ram wStringBuffer3
	text_start
	line "speaking."
	
	para "Oh, <PLAY_G>."
	line "How are you?"
	done
endc


LizAnswerPhoneNiteText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "à l'appareil."
	
	para "Oh, <PLAY_G>."
	line "Bonsoir."
	done
else
	text "Hello, @"
	text_ram wStringBuffer3
	text_start
	line "speaking."
	
	para "Oh, <PLAY_G>."
	line "Good evening."
	done
endc


LizGreetText:
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>."
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Tu dormais?"
	done
else
	text "Good morning,"
	line "<PLAY_G>."
	
	para "This is @"
	text_ram wStringBuffer3
	text "."
	line "Were you sleeping?"
	done
endc


LizGreetDayText:
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>."
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Ca va bien?"
	done
else
	text "Hi, <PLAY_G>."
	line "This is @"
	text_ram wStringBuffer3
	text "."
	
	para "How are things"
	line "going for you?"
	done
endc


LizGreetNiteText:
if DEF(_FR_FR)
	text "Bonsoir,"
	line "<PLAY_G>."
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'étais debout?"
	done
else
	text "Good evening,"
	line "<PLAY_G>."
	
	para "This is @"
	text_ram wStringBuffer3
	text "."
	line "Are you awake?"
	done
endc


LizGenericText:
if DEF(_FR_FR)
	text "J'ai du temps a-"
	line "lors je t'appelle."
	
	para "Au fait, comment"
	line "vont tes #MON?"
	
	para "Moi j'emmène mon"
	line "@"
	text_ram wStringBuffer4
	text " au"
	
	para "CENTRE #MON"
	line "de MAUVILLE tous"
	cont "les jours!"
	
	para "La réceptionniste"
	line "est mon amie!"
	done
else
	text "I had some time,"
	line "so I called you."
	
	para "So anyway, how are"
	line "your #MON?"
	
	para "Me, I take my"
	line "@"
	text_ram wStringBuffer4
	text " to the"
	
	para "#MON CENTER in"
	line "VIOLET every day,"
	
	para "so it's doing just"
	line "fantastic!"
	
	para "I'm friends with"
	line "the receptionist!"
	done
endc
