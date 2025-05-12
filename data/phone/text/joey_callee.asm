JoeyAnswerPhoneText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "Oh, <PLAYER>?"
	line "Ca va?"
	done
else
	text "Hi, @"
	text_ram wStringBuffer3
	text " here!"
	
	para "Oh, <PLAYER>? You"
	line "doing well?"
	done
endc


JoeyAnswerPhoneDayText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "Oh, <PLAYER>?"
	line "Ca va?"
	done
else
	text "Hi, @"
	text_ram wStringBuffer3
	text " here!"
	
	para "Oh, <PLAYER>? You"
	line "doing well?"
	done
endc


JoeyAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "!"
	
	para "Oh, <PLAYER>?"
	line "Ca va?"
	done
else
	text "Hi, @"
	text_ram wStringBuffer3
	text " here!"
	
	para "Oh, <PLAYER>? You"
	line "doing well?"
	done
endc


JoeyGreetText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"
	line "Ca boume?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'as une minute?"
	done
else
	text "Yo, <PLAYER>!"
	line "How're you doing?"
	
	para "This is @"
	text_ram wStringBuffer3
	text ","
	line "got a minute?"
	done
endc


JoeyGreetDayText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"
	line "Ca boume?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'as une minute?"
	done
else
	text "Yo, <PLAYER>! How's"
	line "it going?"
	
	para "This is @"
	text_ram wStringBuffer3
	text "."
	line "Got a minute?"
	done
endc


JoeyGreetNiteText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"
	line "Ca boume?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'as une minute?"
	done
else
	text "Yo, <PLAYER>!"
	line "How're you doing?"
	
	para "This is @"
	text_ram wStringBuffer3
	text ","
	line "got a minute?"
	done
endc


JoeyGenericText:
if DEF(_FR_FR)
	text "Comment vont tes"
	line "#MON?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "a la patate!"
	cont "Comme toujours."
	
	para "Je n'ai que"
	line "celui-ci. Je vais"
	
	para "l'entraîner à"
	line "fond!"
	done
else
	text "How are your"
	line "#MON doing?"
	
	para "My @"
	text_ram wStringBuffer4
	text "'s"
	line "raring to go, just"
	cont "like always."
	
	para "It's the only one"
	line "I have. I'm going"
	
	para "to become a great"
	line "trainer with it!"
	done
endc
