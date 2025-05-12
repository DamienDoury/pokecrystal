WadeAnswerPhoneText:
if DEF(_FR_FR)
	text "Allô? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."
	
	para "Oh. Hi, <PLAY_G>!"
	line "Good morning!"
	done
endc


WadeAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Allô? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>!"
	line "Bonjour!"
	done
else
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."
	
	para "Oh, hi, <PLAY_G>!"
	done
endc


WadeAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Allô? C'est"
	line "@"
	text_ram wStringBuffer3
	text "."
	
	para "<PLAY_G>!"
	line "Bonsoir!"
	done
else
	text "Hello? This is"
	line "@"
	text_ram wStringBuffer3
	text " speaking."
	
	para "Oh, hi, <PLAY_G>!"
	line "Good evening!"
	done
endc


WadeGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	line "Bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Il fait beau!"
	done
else
	text "<PLAY_G>, good"
	line "morning!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "Isn't it nice out?"
	done
endc


WadeGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	line "Bonjour!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "Il fait beau!"
	done
else
	text "<PLAY_G>, howdy!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "Isn't it nice out?"
	done
endc


WadeGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	line "Bonsoir!"
	
	para "C'est @"
	text_ram wStringBuffer3
	text "."
	line "T'es debout?"
	done
else
	text "Good evening,"
	line "<PLAY_G>!"
	
	para "It's me, @"
	text_ram wStringBuffer3
	text "."
	line "Were you awake?"
	done
endc


WadeGenericText:
if DEF(_FR_FR)
	text "Comment vont"
	line "tes #MON?"
	
	para "Mes #MON ont"
	line "trop d'énergie."
	
	para "Ca devient un"
	line "sacré problème."
	
	para "Parmi eux,"
	line "@"
	text_ram wStringBuffer4
	text " est"
	cont "le plus coriace."
	
	para "Ca commence à me"
	line "fatiguer."
	done
else
	text "How are your"
	line "#MON doing?"
	
	para "My #MON have"
	line "too much energy to"
	
	para "burn. It gets to"
	line "be a problem."
	
	para "Of all my #MON,"
	line "@"
	text_ram wStringBuffer4
	text " is the"
	cont "hardest to handle."
	
	para "Working with it is"
	line "exhausting."
	done
endc
