HueyAnswerPhoneText:
if DEF(_FR_FR)
	text "Ouais! C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Ca boume,"
	line "<PLAYER>?"
	done
else
	text "Yeah, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Huh? What's up,"
	line "<PLAYER>?"
	done
endc


HueyAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Ouais! C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Ca boume,"
	line "<PLAYER>?"
	done
else
	text "Yeah, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Huh? What's up"
	line "<PLAYER>?"
	done
endc


HueyAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Ouais! C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Ca boume,"
	line "<PLAYER>?"
	done
else
	text "Yeah, this is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Huh? What's up"
	line "<PLAYER>?"
	done
endc


HueyGreetText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"
	line "T'es debout?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Ca va-t-y?"
	done
else
	text "Yo, <PLAYER>!"
	line "You awake?"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "!"
	line "How's it going?"
	done
endc


HueyGreetDayText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"
	line "T'as une minute?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Ca va-t-y?"
	done
else
	text "Yo, <PLAYER>! You"
	line "free right now?"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "!"
	line "How's it going?"
	done
endc


HueyGreetNiteText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"
	line "Tu dormais?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Ca va-t-y?"
	done
else
	text "Yo, <PLAYER>!"
	line "Were you asleep?"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "!"
	line "How's it going?"
	done
endc
