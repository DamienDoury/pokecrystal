RalphAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui? Ah, <PLAY_G>."
	
	para "Merci de dire ton"
	line "nom quand tu"
	cont "m'appelles..."
	done
else
	text "Yes? Ah, <PLAY_G>."
	
	para "You're courteous"
	line "enough to state"
	
	para "your name when you"
	line "call on the phone."
	done
endc


RalphAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui? Ah, <PLAY_G>."
	
	para "Merci de dire ton"
	line "nom quand tu"
	cont "m'appelles..."
	done
else
	text "Yes? Ah, <PLAY_G>."
	
	para "You're courteous"
	line "enough to state"
	
	para "your name when you"
	line "call on the phone."
	done
endc


RalphAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui? Ah, <PLAY_G>."
	
	para "Merci de dire ton"
	line "nom quand tu"
	cont "m'appelles..."
	done
else
	text "Yes? Ah, <PLAY_G>."
	
	para "You're courteous"
	line "enough to state"
	
	para "your name when you"
	line "call on the phone."
	done
endc


RalphGreetText:
if DEF(_FR_FR)
	text "Salut, c'est pépé"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Hiya, it's Uncle"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc


RalphGreetDayText:
if DEF(_FR_FR)
	text "Salut, c'est pépé"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Hiya, it's Uncle"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc


RalphGreetNiteText:
if DEF(_FR_FR)
	text "Salut, c'est pépé"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Hiya, it's Uncle"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc


RalphGenericText:
if DEF(_FR_FR)
	text "Tu prends soin de"
	line "tes #MON?"
	
	para "Sois sympa avec"
	line "tes petits amis!"
	done
else
	text "Are you taking"
	line "good care of your"
	
	para "#MON? You have"
	line "to be good to your"
	cont "partners!"
	done
endc
