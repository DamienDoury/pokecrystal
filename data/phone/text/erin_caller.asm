ErinMonIsMuchStrongerText:
if DEF(_FR_FR)
	text_ram wStringBuffer4
	text " de @"
	text_ram wStringBuffer3
	text_start
	line "est mieux"
	cont "qu'avant!"
	done
else
	text_ram wStringBuffer3
	text "'s @"
	text_ram wStringBuffer4
	text_start
	line "is much stronger"
	cont "than before!"
	done
endc


ErinDefeatedMonText:
if DEF(_FR_FR)
	text "Et…"
	line "Je viens de battre"
	cont "@"
	text_ram wStringBuffer4
	text "!"
	
	para "J'entraîne bien"
	line "mes #MON!"
	done
else
	text "And, and…"
	line "I just battled and"
	cont "beat @"
	text_ram wStringBuffer4
	text "!"
	
	para "I've raised my"
	line "#MON properly!"
	done
endc


ErinLostAMonText:
if DEF(_FR_FR)
	text "Mais…"
	
	para "Un @"
	text_ram wStringBuffer4
	text_start
	line "sauvage m'a"
	
	para "encore échappé."
	line "C'est pas juste!"
	done
else
	text "But, but…"
	
	para "A wild @"
	text_ram wStringBuffer4
	text_start
	line "got away from me"
	
	para "again. It's just"
	line "not fair!"
	done
endc


ErinBattleRematchText:
if DEF(_FR_FR)
	text "Tu veux"
	line "m'affronter?"
	
	para "Je ne perdrai pas"
	line "cette fois!"
	
	para "Je t'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "I'm ERIN. Want to"
	line "battle me again?"
	
	para "I won't lose this"
	line "time!"
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


ErinHangUpText:
if DEF(_FR_FR)
	text "A bientôt!"
	done
else
	text "See you. Bye-bye!"
	done
endc


ErinWorkingHardText:
if DEF(_FR_FR)
	text "J'entraîne à fond"
	line "mes #MON!"
	
	para "Reviens pour"
	line "m'affronter!"
	done
else
	text "I'm working hard"
	line "to raise my"
	cont "#MON!"
	
	para "Come back for"
	line "another battle!"
	done
endc


ErinComeBattleText:
if DEF(_FR_FR)
	text "Oh, <PLAY_G>!"
	line "Viens te battre"
	cont "contre ERIN!"
	
	para "Je t'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Oh, <PLAY_G>!"
	line "Come battle ERIN!"
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc
