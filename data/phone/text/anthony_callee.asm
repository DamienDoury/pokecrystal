AnthonyAnswerPhoneText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text_start
	line "le MONTAGNARD."
	
	para "Ah, <PLAYER>!"
	done
else
	text "Yeah, @"
	text_ram wStringBuffer3
	text " the"
	line "HIKER here."
	
	para "Ah, <PLAYER>!"
	done
endc


AnthonyAnswerPhoneDayText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text_start
	line "le MONTAGNARD."
	
	para "Ah, <PLAYER>!"
	done
else
	text "Yeah, @"
	text_ram wStringBuffer3
	text " the"
	line "HIKER here."
	
	para "Ah, <PLAYER>,"
	line "right?"
	done
endc


AnthonyAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "C'est @"
	text_ram wStringBuffer3
	text_start
	line "le MONTAGNARD."
	
	para "Ah, <PLAYER>!"
	done
else
	text "Yeah, @"
	text_ram wStringBuffer3
	text " the"
	line "HIKER here."
	
	para "Ah, <PLAYER>, isn't"
	line "it?"
	done
endc


AnthonyGreetText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text_start
	line "le MONTAGNARD!"
	done
else
	text "Yo, <PLAYER>?"
	
	para "This is @"
	text_ram wStringBuffer3
	text_start
	line "the HIKER!"
	done
endc


AnthonyGreetDayText:
if DEF(_FR_FR)
	text "Yo, <PLAYER>?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text_start
	line "le MONTAGNARD!"
	done
else
	text "Hey, is this"
	line "<PLAYER>?"
	
	para "This is @"
	text_ram wStringBuffer3
	text_start
	line "the HIKER!"
	done
endc


AnthonyGreetNiteText:
if DEF(_FR_FR)
	text "<PLAYER>?"
	line "T'es debout?"
	
	para "C'est @"
	text_ram wStringBuffer3
	text_start
	line "le MONTAGNARD!"
	done
else
	text "<PLAYER>, you still"
	line "awake?"
	
	para "This is @"
	text_ram wStringBuffer3
	text_start
	line "the HIKER!"
	done
endc


AnthonyGenericText:
if DEF(_FR_FR)
	text "Tes #MON sont"
	line "toujours aussi"
	cont "sympatoches?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text " et"
	line "moi, on est trop"
	
	para "heureux. On"
	line "arpente les"
	
	para "montagnes et on"
	line "s'entraîne."
	done
else
	text "Are your #MON"
	line "as feisty as ever?"
	
	para "My @"
	text_ram wStringBuffer4
	text " and"
	line "me--we have energy"
	
	para "to burn. We hike"
	line "up mountains every"
	
	para "day to work out"
	line "all our energy."
	done
endc

AnthonyLockdownText:
if DEF(_FR_FR)
	text "Dis, si tu peux"
	line "éviter de m'appeler"
	cont "ça m'arrangerait."

	para "Je... heu..."

	para "J'ai pas supporté"
	line "de rester enfermé,"
	cont "alors je suis"
	cont "parti en rando"
	cont "furtive."

	para "Je voudrais pas"
	line "que la sonnerie"
	cont "de mon #GEAR"
	cont "attire la police."
	done
else
	text "Hey, if you can"
	line "avoid calling me,"
	cont "that'd be great."	

	para "I... uh..."

	para "I couldn't stand"
	line "being cooped up,"
	cont "so I went on a"
	cont "stealth hike."

	para "I wouldn't want"
	line "the ringtone on"
	cont "my #GEAR to"
	cont "attract the cops."
	done
endc