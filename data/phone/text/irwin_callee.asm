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

IrwinLockdownText:
if DEF(_FR_FR)
	text "Je m'ennuie trop"
	line "dans mon petit"
	cont "appart. Et toi?"

	para "Quoi? Tu continues"
	line "de sortir?"

	para "Avec la police et"
	line "tout? T'es ouf!!"

	para "J'aimerais faire"
	line "comme toi, mais"
	cont "j'ai trop peur de"
	cont "me faire chopper!"
	done
else
	text "I'm so bored in my"
	line "little apartment."
	cont "What about you?"
	
	para "What? You're still"
	line "going outside?"

	para "With the police"
	line "and everything?"
	cont "You're crazy!!"

	para "I'd love to be"
	line "like you, but I'm"
	cont "too scared to"
	cont "get caught!"
	done
endc
