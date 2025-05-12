BillPhoneMornGreetingText:
if DEF(_FR_FR)
	text "Bonjour!"
	
	para "Voici le SERVICE"
	line "D'ADMINISTRATION"
	
	para "DU SYSTEME DE"
	line "STOCKAGE DE"
	cont "#MON."
	done
else
	text "Good morning!"
	
	para "This is the #-"
	line "MON STORAGE SYSTEM"
	
	para "ADMINISTRATION"
	line "SERVICE."
	done
endc


BillPhoneDayGreetingText:
if DEF(_FR_FR)
	text "Bonjour!"
	
	para "Voici le SERVICE"
	line "D'ADMINISTRATION"
	
	para "DU SYSTEME DE"
	line "STOCKAGE DE"
	cont "#MON."
	done
else
	text "Good day!"
	
	para "This is the #-"
	line "MON STORAGE SYSTEM"
	
	para "ADMINISTRATION"
	line "SERVICE."
	done
endc


BillPhoneNiteGreetingText:
if DEF(_FR_FR)
	text "Bonsoir!"
	
	para "Voici le SERVICE"
	line "D'ADMINISTRATION"
	
	para "DU SYSTEME DE"
	line "STOCKAGE DE"
	cont "#MON."
	done
else
	text "Good evening!"
	
	para "This is the #-"
	line "MON STORAGE SYSTEM"
	
	para "ADMINISTRATION"
	line "SERVICE."
	done
endc


BillPhoneGenericText:
if DEF(_FR_FR)
	text "Qui est-ce?"
	
	para "<PLAY_G>?"
	line "Une seconde..."
	
	para "<……>"
	line "<……>"
	done
else
	text "Who's calling?"
	
	para "<PLAY_G>, is it?"
	line "Hang on a sec…"
	
	para "<……>"
	line "<……>"
	done
endc


BillPhoneNotFullText:
if DEF(_FR_FR)
	text "Merci d'avoir"
	line "attendu!"
	
	para "<PLAY_G>, ta BOITE"
	line "a de la place pour"
	cont "encore @"
	text_ram wStringBuffer3
	text_start
	cont "#MON."
	
	para "Va en choper!"
	done
else
	text "Thanks for"
	line "waiting!"
	
	para "<PLAY_G>, your BOX"
	line "has room for @"
	text_ram wStringBuffer3
	text_start
	cont "more #MON."
	
	para "Get out there and"
	line "fill it up!"
	done
endc


BillPhoneNearlyFullText:
if DEF(_FR_FR)
	text "Merci d'avoir"
	line "attendu!"
	
	para "<PLAY_G>, ta BOITE"
	line "a de la place pour"
	cont "encore @"
	text_ram wStringBuffer3
	text_start
	cont "#MON."
	
	para "Tu devrais changer"
	line "de BOITE."
	done
else
	text "Thanks for"
	line "waiting!"
	
	para "<PLAY_G>, your BOX"
	line "has room for only"
	cont "@"
	text_ram wStringBuffer3
	text " more #MON."
	
	para "Maybe you should"
	line "switch your BOX."
	done
endc


BillPhoneFullText:
if DEF(_FR_FR)
	text "Merci d'avoir"
	line "attendu!"
	
	para "<PLAY_G>, ta BOITE"
	line "est pleine!"
	
	para "Tu devrais changer"
	line "de BOITE pour"
	cont "attraper d'autres"
	cont "#MON."
	done
else
	text "Thanks for"
	line "waiting!"
	
	para "<PLAY_G>, your BOX"
	line "is full!"
	
	para "You'll have to"
	line "switch BOXES if"
	
	para "you want to catch"
	line "more #MON."
	done
endc


BillPhoneNewlyFullText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	line "C'est moi! LEO!"
	
	para "Merci d'utiliser"
	line "le SYSTEME de"
	cont "STOCKAGE."
	
	para "Le dernier #MON"
	line "envoyé a rempli"
	cont "ta BOITE."
	
	para "Il faut changer de"
	line "BOITE pour attra-"
	
	para "per d'autres"
	line "#MON."
	
	para "Salut!"
	done
else
	text "Hi, <PLAY_G>?"
	line "It's me, BILL!"
	
	para "Thanks for using"
	line "my STORAGE SYSTEM."
	
	para "That last #MON"
	line "you sent filled"
	cont "your BOX up."
	
	para "You'll have to"
	line "switch BOXES if"
	
	para "you want to catch"
	line "more #MON."
	
	para "Bye now!"
	done
endc
