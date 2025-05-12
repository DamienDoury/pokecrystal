GavenMonGreaterThanImaginedText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est plus fort que"
	cont "je le pensais."
	
	para "Y'a pas de"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "mieux que le mien."
	done
else
	text "My @"
	text_ram wStringBuffer4
	text_start
	line "might be greater"
	cont "than I imagined."
	
	para "I doubt I'll see a"
	line "@"
	text_ram wStringBuffer4
	text " that's"
	cont "better than mine."
	done
endc


GavenDefeatedMonText:
if DEF(_FR_FR)
	text "Oh, j'ai eu du mal"
	line "à battre"
	
	para "@"
	text_ram wStringBuffer4
	text_start
	line "l'autre jour."
	
	para "Je n'avais jamais"
	line "vu de @"
	text_ram wStringBuffer4
	text_start
	cont "aussi fort..."
	
	para "On devrait tou-"
	line "jours faire"
	cont "attention."
	done
else
	text "Oh, and I managed"
	line "to barely defeat"
	
	para "@"
	text_ram wStringBuffer4
	text " the"
	line "other day."
	
	para "I've never seen a"
	line "@"
	text_ram wStringBuffer4
	text " get"
	cont "that strong…"
	
	para "You shouldn't let"
	line "your guard down,"
	
	para "even against a"
	line "#MON you're"
	cont "used to seeing."
	done
endc


GavenLostAMonText:
if DEF(_FR_FR)
	text "L'autre fois, j'ai"
	line "voulu attraper un"
	cont "@"
	text_ram wStringBuffer4
	text "."
	
	para "Mais il m'a"
	line "échappé."
	
	para "Y faut toujours"
	line "faire attention."
	done
else
	text "And a while back,"
	line "I tried to catch a"
	cont "wild @"
	text_ram wStringBuffer4
	text "."
	
	para "But it managed to"
	line "elude me."
	
	para "One wrong decision"
	line "could mean total"
	
	para "failure… You ought"
	line "to be careful too."
	done
endc


GavenBattleRematchText:
if DEF(_FR_FR)
	text "Combat!"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Appelle si tu es"
	line "dans le coin."
	done
else
	text "Let's battle!"
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Give me a shout"
	line "when you're close."
	done
endc


GavenHangUpText:
if DEF(_FR_FR)
	text "OK, à bientôt!"
	done
else
	text "OK, I'll talk to"
	line "you soon!"
	done
endc


GavenHangUpNotThursdayText:
if DEF(_FR_FR)
	text "Je veux te battre!"
	done
else
	text "I obsess over how"
	line "to beat you."
	done
endc


GavenReminderText:
if DEF(_FR_FR)
	text "<PLAY_G>,"
	line "où es-tu?"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "J'vais t'écraser!"
	done
else
	text "<PLAY_G>, why"
	line "aren't you here?"
	
	para "I'll take you down"
	line "with @"
	text_ram wStringBuffer5
	text "!"
	done
endc
