GavenAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Salut <PLAY_G>!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text " speaking…"
	
	para "Hi, <PLAY_G>!"
	line "Good morning!"
	done
endc


GavenAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Salut <PLAY_G>!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text " speaking…"
	
	para "Hi, <PLAY_G>!"
	done
endc


GavenAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonsoir <PLAY_G>!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text " speaking…"
	
	para "Hi, <PLAY_G>!"
	line "Good evening!"
	done
endc


GavenGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>,"
	line "bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Ca va?"
	done
else
	text "<PLAY_G>, good"
	line "morning!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "How are you doing?"
	done
endc


GavenGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>,"
	line "bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Ca va?"
	done
else
	text "Hi, <PLAY_G>!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "How are you doing?"
	done
endc


GavenGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>,"
	line "bonsoir!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Ca va?"
	done
else
	text "<PLAY_G>, good"
	line "evening!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "How are you doing?"
	done
endc


GavenGenericText:
if DEF(_FR_FR)
	text "Comment vont tes"
	line "#MON?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "va très bien."
	
	para "On va tous devenir"
	line "des CHAMPIONS!"
	done
else
	text "How are your"
	line "#MON doing?"
	
	para "My @"
	text_ram wStringBuffer4
	text "'s"
	line "doing as great as"
	cont "ever."
	
	para "Let's keep at it"
	line "and become #MON"
	cont "CHAMPS!"
	done
endc
