BrentAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui? Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAYER>."
	line "Qu'est-ce que tu"
	cont "veux?"
	done
else
	text "Yes? @"
	text_ram wStringBuffer3
	text " here…"
	
	para "Ah, <PLAYER>. What"
	line "can I do for you?"
	done
endc


BrentAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui? Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAYER>."
	line "Qu'est-ce que tu"
	cont "veux?"
	done
else
	text "Yes? @"
	text_ram wStringBuffer3
	text " here…"
	
	para "Ah, <PLAYER>. What"
	line "can I do for you?"
	done
endc


BrentAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui? Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAYER>."
	line "Qu'est-ce que tu"
	cont "veux?"
	done
else
	text "Yes? @"
	text_ram wStringBuffer3
	text " here…"
	
	para "Ah, <PLAYER>. What"
	line "can I do for you?"
	done
endc


BrentGreetText:
if DEF(_FR_FR)
	text "Salut, <PLAYER>."
	line "Ca va bien?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hiya, <PLAYER>. How"
	line "are you doing?"
	
	para "Hey! It's me,"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc


BrentGreetDayText:
if DEF(_FR_FR)
	text "Salut, <PLAYER>."
	line "Ca va bien?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hiya, <PLAYER>, how"
	line "are you doing?"
	
	para "Hey, it's me,"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc


BrentGreetNiteText:
if DEF(_FR_FR)
	text "Salut, <PLAYER>."
	line "Ca va bien?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hiya, <PLAYER>, how"
	line "are you doing?"
	
	para "Hey, it's me,"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc


BrentGenericText:
if DEF(_FR_FR)
	text "J'ai vu que tu"
	line "sortais du"
	
	para "CENTRE #MON"
	line "l'autre jour."
	
	para "Tu aimes soigner"
	line "tes #MON?"
	cont "C'est bien, ça."
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "pète la forme."
	
	para "Il a pas besoin"
	line "des CENTRES"
	cont "#MON!"
	done
else
	text "Oh yeah, I saw you"
	line "coming out of a"
	
	para "#MON CENTER the"
	line "other day."
	
	para "You heal your"
	line "#MON regularly,"
	
	para "don't you?"
	line "I'm impressed."
	
	para "Heh, my @"
	text_ram wStringBuffer4
	text_start
	line "is so tough, it"
	
	para "doesn't need to go"
	line "to #MON CENTERS"
	cont "often. Heheh!"
	done
endc
