WiltonAnswerPhoneText:
if DEF(_FR_FR)
	text "Allô..."
	line "Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAY_G>."
	done
else
	text "Hello, you have"
	line "reached @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAY_G>."
	done
endc


WiltonAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Allô..."
	line "Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAY_G>."
	done
else
	text "Hello, you have"
	line "reached @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAY_G>, is"
	line "it?"
	done
endc


WiltonAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Allô..."
	line "Ici @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, <PLAY_G>."
	done
else
	text "Hello, you have"
	line "reached @"
	text_ram wStringBuffer3
	text "…"
	
	para "Ah, if it isn't"
	line "<PLAY_G>."
	done
endc


WiltonGreetText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "…"
	
	para "Tu as un moment?"
	done
else
	text "Ah, it's @"
	text_ram wStringBuffer3
	text "…"
	
	para "Have you got a"
	line "moment?"
	done
endc


WiltonGreetDayText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "…"
	
	para "Tu as un moment?"
	done
else
	text "Ah, it's @"
	text_ram wStringBuffer3
	text "…"
	
	para "Can you talk now?"
	done
endc


WiltonGreetNiteText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text "…"
	
	para "Il est trop tard?"
	done
else
	text "Ah, it's @"
	text_ram wStringBuffer3
	text "…"
	
	para "Sorry for calling"
	line "so late."
	done
endc


WiltonGenericText:
if DEF(_FR_FR)
	text "Tes #MON"
	line "ont grandi?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "s'est développé."
	done
else
	text "Have your #MON"
	line "grown any?"
	
	para "My @"
	text_ram wStringBuffer4
	text " has"
	line "grown quite a bit."
	done
endc
