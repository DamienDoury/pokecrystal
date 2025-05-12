JackAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour,"
	line "<PLAY_G>!"
	done
else
	text "Hello. This is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Good morning,"
	line "<PLAY_G>!"
	done
endc


JackAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour,"
	line "<PLAY_G>!"
	done
else
	text "Hello. This is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "How's it going,"
	line "<PLAY_G>?"
	done
endc


JackAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonsoir,"
	line "<PLAY_G>!"
	done
else
	text "Hello. This is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Good evening,"
	line "<PLAY_G>!"
	done
endc


JackGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>,"
	line "bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Ca va bien?"
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


JackGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>, salut!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Il fait beau, non?"
	done
else
	text "<PLAY_G>, howdy!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "Isn't it nice out?"
	done
endc


JackGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>,"
	line "bonsoir!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'as une minute?"
	done
else
	text "<PLAY_G>, good"
	line "evening!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "Got a minute?"
	done
endc


JackGenericText:
if DEF(_FR_FR)
	text "Ca va tes"
	line "#MON?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est bizarre."
	
	para "Il est peut-être"
	line "comme moi..."
	done
else
	text "How are your"
	line "#MON doing?"
	
	para "My @"
	text_ram wStringBuffer4
	text " is"
	line "so curious, it's a"
	
	para "problem. Maybe"
	line "it's like me…"
	done
endc
