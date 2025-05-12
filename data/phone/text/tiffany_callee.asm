TiffanyAnswerPhoneText:
if DEF(_FR_FR)
	text "Oui? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Bonjour."
	done
else
	text "Yes? This is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Good morning."
	done
endc


TiffanyAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Oui? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Bonjour."
	done
else
	text "Yes? This is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Hello."
	done
endc


TiffanyAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Oui? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>."
	line "Bonsoir."
	done
else
	text "Yes? This is"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "Oh, <PLAY_G>, good"
	line "evening."
	done
endc


TiffanyGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Bonjour. Ici"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Is this <PLAY_G>?"
	
	para "Good morning. This"
	line "is @"
	text_ram wStringBuffer3
	text "."
	done
endc


TiffanyGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Bonjour. Ici"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Is this <PLAY_G>?"
	
	para "Hi, it's @"
	text_ram wStringBuffer3
	text "."
	done
endc


TiffanyGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Bonsoir. Ici"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Is this <PLAY_G>?"
	
	para "Good evening. This"
	line "is @"
	text_ram wStringBuffer3
	text "."
	done
endc


TiffanyGenericText:
if DEF(_FR_FR)
	text "Tes #MON"
	line "vont bien?"
	
	para "Tu les amènes au"
	line "CENTRE #MON"
	cont "tous les jours?"
	
	para "Vas-y mollo avec"
	line "eux."
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est tout mimi."
	
	para "Je le porte au"
	line "CENTRE #MON"
	cont "tous les jours."
	done
else
	text "Are your #MON"
	line "doing well?"
	
	para "I hope you take"
	line "them to a #MON"
	cont "CENTER every day."
	
	para "Don't push them"
	line "too hard."
	
	para "My @"
	text_ram wStringBuffer4
	text " is"
	line "cute and lively"
	
	para "precisely because"
	line "I take it to a"
	
	para "#MON CENTER"
	line "every day."
	done
endc
