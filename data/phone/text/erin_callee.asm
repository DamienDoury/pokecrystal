ErinAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui, c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh. <PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Yes, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh. Hi, <PLAY_G>!"
	line "Good morning!"
	done
endc


ErinAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui, c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh. <PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Yes, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, hi, <PLAY_G>!"
	line "Yahoo!"
	done
endc


ErinAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui, c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh. <PLAY_G>!"
	line "Salut!"
	done
else
	text "Yes, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, hi, <PLAY_G>!"
	done
endc


ErinGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Bonjour!"
	done
else
	text "<PLAY_G>!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "!"
	line "Good morning!"
	done
endc


ErinGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Ca bosse dur?"
	done
else
	text "<PLAY_G>!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "!"
	line "Working hard?"
	done
endc


ErinGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "T'es debout?"
	done
else
	text "<PLAY_G>!"
	
	para "It's @"
	text_ram wStringBuffer3
	text "!"
	line "Were you up?"
	done
endc


ErinGenericText:
if DEF(_FR_FR)
	text "Tu entraînes bien"
	line "tes #MON?"
	
	para "Le @"
	text_ram wStringBuffer4
	text_start
	line "de @"
	text_ram wStringBuffer3
	text_start
	cont "est trop fort!"
	done
else
	text "Are you raising"
	line "your #MON?"
	
	para "Hey, @"
	text_ram wStringBuffer3
	text "'s"
	line "@"
	text_ram wStringBuffer4
	text " is"
	cont "looking good!"
	done
endc
