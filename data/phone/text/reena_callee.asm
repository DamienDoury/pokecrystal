ReenaAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour <PLAYER>."
	line "Ca gaze?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh. Hi, <PLAYER>."
	line "What's up?"
	done
endc


ReenaAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour <PLAYER>."
	line "Ca gaze?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, hi, <PLAYER>,"
	line "what's up?"
	done
endc


ReenaAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Bonjour <PLAYER>."
	line "Ca gaze?"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, hi, <PLAYER>,"
	line "what's up?"
	done
endc


ReenaGreetText:
if DEF(_FR_FR)
	text "Hé! Tu réponds?"
	line "Allô?!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "You're slow! Hurry"
	line "up and answer!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "!"
	done
endc


ReenaGreetDayText:
if DEF(_FR_FR)
	text "Hé! Tu réponds?"
	line "Allô?!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "You're slow! Hurry"
	line "up and answer!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "!"
	done
endc


ReenaGreetNiteText:
if DEF(_FR_FR)
	text "Hé! Tu réponds?"
	line "Allô?!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "You're slow! Hurry"
	line "up and answer!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "!"
	done
endc


ReenaGenericText:
if DEF(_FR_FR)
	text "Hé! Ca va tes"
	line "#MON?"
	
	para "Quoi? Super?"
	line "Je vois..."
	
	para "Quoi? Mes #MON?"
	
	para "Bien sûr qu'ils"
	line "vont bien! C'est"
	
	para "quoi cette"
	line "question?"
	done
else
	text "Hey, how are your"
	line "#MON doing?"
	
	para "What? Great?"
	line "I see…"
	
	para "What? My #MON?"
	
	para "Of course they're"
	line "doing great! What"
	
	para "kind of a question"
	line "is that?"
	done
endc
