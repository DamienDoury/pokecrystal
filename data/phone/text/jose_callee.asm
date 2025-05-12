JoseAnswerPhoneText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>?"
	line "Bonjour!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>?"
	line "Good morning!"
	done
endc


JoseAnswerPhoneDayText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>?"
	line "Bonjour!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>? Hi!"
	done
endc


JoseAnswerPhoneNiteText:
if DEF(_FR_FR)
	text "Salut c'est"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>?"
	line "Bonsoir!"
	done
else
	text "Hello, this is"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Oh, <PLAY_G>?"
	line "Good evening!"
	done
endc


JoseGreetText:
if DEF(_FR_FR)
	text "Oh, <PLAY_G>?"
	
	para "Yo! C'est moi,"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Oh, <PLAY_G>?"
	
	para "Tweet! Yeah, it's"
	line "me, @"
	text_ram wStringBuffer3
	text "."
	done
endc


JoseGreetDayText:
if DEF(_FR_FR)
	text "Oh, <PLAY_G>?"
	
	para "Yo! C'est moi,"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Oh, <PLAY_G>?"
	
	para "Tweet! Yeah, it's"
	line "me, @"
	text_ram wStringBuffer3
	text "."
	done
endc


JoseGreetNiteText:
if DEF(_FR_FR)
	text "Oh, <PLAY_G>?"
	
	para "Yo! C'est moi,"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
else
	text "Oh, <PLAY_G>?"
	
	para "Tweet! Yeah, it's"
	line "me, @"
	text_ram wStringBuffer3
	text "."
	done
endc


JoseGenericText:
if DEF(_FR_FR)
	text "Tes #MON"
	line "sont en forme?"
	
	para "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est trop fort."
	
	para "S'il part, c'est"
	line "toujours pour un"
	cont "moment."
	done
else
	text "Are your #MON"
	line "still cooking?"
	
	para "My @"
	text_ram wStringBuffer4
	text " has"
	line "too much energy."
	
	para "Once it takes off,"
	line "it won't come back"
	cont "for a while."
	done
endc
