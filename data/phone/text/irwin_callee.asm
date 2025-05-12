IrwinAnswerPhoneText:
if DEF(_FR_FR)
	text "Allô? @"
	text_ram wStringBuffer3
	text_start
	line "à l'appareil..."
	
	para "Hé, <PLAY_G>!"
	done
else
	text "Hello? @"
	text_ram wStringBuffer3
	text_start
	line "here…"
	
	para "Hey, <PLAY_G>!"
	done
endc


IrwinAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Allô? @"
	text_ram wStringBuffer3
	text_start
	line "à l'appareil..."
	
	para "Yo! <PLAY_G>!"
	done
else
	text "Hello? @"
	text_ram wStringBuffer3
	text_start
	line "here…"
	
	para "Wow, <PLAY_G>!"
	done
endc


IrwinAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Allô? @"
	text_ram wStringBuffer3
	text_start
	line "à l'appareil..."
	
	para "Ah! <PLAY_G>!"
	done
else
	text "Hello? @"
	text_ram wStringBuffer3
	text_start
	line "here…"
	
	para "Yippee, <PLAY_G>!"
	done
endc


IrwinGreetText:
if DEF(_FR_FR)
	text "Heu... Allô,"
	line "<PLAY_G>?"
	
	para "C'est moi!"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Uh, hello."
	line "<PLAY_G>?"
	
	para "It's your pal,"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc


IrwinGreetDayText:
if DEF(_FR_FR)
	text "Heu... Allô,"
	line "<PLAY_G>?"
	
	para "C'est ton pote"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Uh, hello,"
	line "<PLAY_G>?"
	
	para "It's your buddy"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc


IrwinGreetNiteText:
if DEF(_FR_FR)
	text "Heu... Allô,"
	line "<PLAY_G>?"
	
	para "C'est ton ami"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Uh, hello,"
	line "<PLAY_G>?"
	
	para "It's your sidekick"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done
endc
