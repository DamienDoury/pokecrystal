KenjiAnswerPhoneText:
if DEF(_FR_FR)
	text "Ici @"
	text_ram wStringBuffer3
	text "..........."
	
	para "<PLAYER>! Quelle"
	line "belle journée!"
	done
else
	text_ram wStringBuffer3
	text " here…"
	
	para "<PLAYER>! Beautiful"
	line "morning, hey?"
	done
endc


KenjiAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Ici @"
	text_ram wStringBuffer3
	text "..........."
	
	para "<PLAYER>! Quelle"
	line "belle journée!"
	done
else
	text_ram wStringBuffer3
	text " here…"
	
	para "<PLAYER>! Beautiful"
	line "weather, hey?"
	done
endc


KenjiAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Ici @"
	text_ram wStringBuffer3
	text "...."
	
	para "<PLAYER>! Quelle"
	line "belle soirée!"
	done
else
	text_ram wStringBuffer3
	text " here…"
	
	para "<PLAYER>! Beautiful"
	line "moonlight, hey?"
	done
endc


KenjiGreetText:
if DEF(_FR_FR)
	text "Hé! <PLAYER>!"
	line "C'est @"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hey, <PLAYER>!"
	line "This is @"
	text_ram wStringBuffer3
	text "!"
	done
endc


KenjiGreetDayText:
if DEF(_FR_FR)
	text "Hé! <PLAYER>!"
	line "C'est @"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hey, <PLAYER>!"
	line "This is @"
	text_ram wStringBuffer3
	text "!"
	done
endc


KenjiGreetNiteText:
if DEF(_FR_FR)
	text "Hé! <PLAYER>!"
	line "C'est @"
	text_ram wStringBuffer3
	text "!"
	done
else
	text "Hey, <PLAYER>!"
	line "This is @"
	text_ram wStringBuffer3
	text "!"
	done
endc
