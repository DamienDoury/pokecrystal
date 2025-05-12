DanaAnswerPhoneText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "à l'appareil."
	
	para "C'est <PLAY_G>!"
	done
else
	text "Hi, @"
	text_ram wStringBuffer3
	text " on the"
	line "line."
	
	para "Hey! It's <PLAY_G>!"
	done
endc


DanaAnswerPhoneDayText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "à l'appareil."
	
	para "C'est <PLAY_G>!"
	done
else
	text "Hi, @"
	text_ram wStringBuffer3
	text " on the"
	line "line."
	
	para "I know!"
	line "It's <PLAY_G>!"
	done
endc


DanaAnswerPhoneNiteText:
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text_start
	line "à l'appareil."
	
	para "<PLAY_G>, ça va?"
	done
else
	text "Hi, @"
	text_ram wStringBuffer3
	text " on the"
	line "line."
	
	para "<PLAY_G>?"
	line "What's up?"
	done
endc


DanaGreetText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Uh, <PLAY_G>?"
	
	para "It's me!"
	line "It's me, @"
	text_ram wStringBuffer3
	text "!"
	done
endc


DanaGreetDayText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Uh, <PLAY_G>?"
	
	para "It's me!"
	line "It's me, @"
	text_ram wStringBuffer3
	text "!"
	done
endc


DanaGreetNiteText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Uh, <PLAY_G>?"
	
	para "It's me!"
	line "It's me, @"
	text_ram wStringBuffer3
	text "!"
	done
endc


DanaGenericText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est si actif, que"
	
	para "ça m'file la"
	line "trouille."
	
	para "Et tes #MON,"
	line "ça va?"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text " is"
	line "so full of energy,"
	
	para "it's a little"
	line "scary."
	
	para "How are your"
	line "#MON doing?"
	done
endc
