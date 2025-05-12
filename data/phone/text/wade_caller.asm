WadeAreYourMonGrowingText:
if DEF(_FR_FR)
	text "Tes #MON ont"
	line "progressé?"
	
	para "Les miens font"
	line "trop de progrès!"
	
	para "J'ai du mal à"
	line "suivre!"
	
	para "@"
	text_ram wStringBuffer4
	text_start
	line "surtout..."
	cont "Quelle brute!"
	done
else
	text "Are your #MON"
	line "growing?"
	
	para "My #MON are"
	line "growing a bit too"
	
	para "quickly for me."
	line "It's overwhelming!"
	
	para "@"
	text_ram wStringBuffer4
	text "'s grow-"
	line "ing especially"
	
	para "quickly. I think"
	line "it'll get tough."
	done
endc


WadeDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai mis K.O. un"
	line "@"
	text_ram wStringBuffer4
	text_start
	para "sauvage en un"
	line "coup."
	
	para "J'ai eu de la"
	line "peine pour lui..."
	
	para "Pendant au moins"
	line "deux minutes!"
	done
else
	text "Oh yeah, we KO'd a"
	line "wild @"
	text_ram wStringBuffer4
	text_start
	para "with one hit a"
	line "while back."
	
	para "It went down so"
	line "easily, I felt a"
	
	para "little sorry for"
	line "the poor thing."
	done
endc


WadeLostAMonText:
if DEF(_FR_FR)
	text "Au fait! Un"
	line "@"
	text_ram wStringBuffer4
	text_start
	
	para "sauvage vient de"
	line "m'échapper."
	
	para "Je sais qu'il"
	line "n'est pas rare..."
	
	para "Mais ça m'énerve"
	line "quand ça arrive."
	done
else
	text "Oh yeah, a wild"
	line "@"
	text_ram wStringBuffer4
	text " got"
	
	para "away from me at"
	line "the last second."
	
	para "I know it's a"
	line "common #MON…"
	
	para "But it does annoy"
	line "me that it got"
	
	para "away when I almost"
	line "had it."
	done
endc


WadeBattleRematchText:
if DEF(_FR_FR)
	text "Ca te dit un"
	line "petit combat?"
	
	para "Ca ne se passera"
	line "pas comme la"
	cont "dernière fois!"
	
	para "@"
	text_ram wStringBuffer5
	text_start
	line "est mon terrain."
	
	para "Dis-moi quand tu"
	line "arrives."
	done
else
	text "Do you feel like a"
	line "#MON battle?"
	
	para "It won't be like"
	line "last time!"
	
	para "@"
	text_ram wStringBuffer5
	text "'s"
	line "where I'll be."
	
	para "Let me know when"
	line "you get there."
	done
endc


WadeHangUpText:
if DEF(_FR_FR)
	text "A plus tard!"
	done
else
	text "See you later!"
	done
endc


WadeBugCatchingContestText:
if DEF(_FR_FR)
	text "Il y a le Concours"
	line "de Capture au"
	cont "PARC aujourd'hui."
	
	para "Tu y vas,"
	line "<PLAY_G>?"
	
	para "Moi j'en sais"
	line "rien..."
	done
else
	text "The Bug-Catching"
	line "Contest is at the"
	
	para "NATIONAL PARK"
	line "today."
	
	para "Are you going,"
	line "<PLAY_G>?"
	
	para "I'm trying to make"
	line "up my mind."
	done
endc


WadeFoundItemText:
if DEF(_FR_FR)
	text "J'ai trouvé tout"
	line "plein de BAIES."
	
	para "Je peux t'en"
	line "donner."
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "I found all kinds"
	line "of BERRIES. If you"
	
	para "want, I'll share"
	line "some with you."
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


WadeNoBerriesText:
if DEF(_FR_FR)
	text "Hein? Des BAIES?"
	
	para "J'en ai pas"
	line "encore."
	
	para "Je t'appelle pour"
	line "te prévenir..."
	cont "Attends un peu!"
	done
else
	text "Huh? BERRIES?"
	
	para "Sorry, I haven't"
	line "found any yet."
	
	para "I'll call you if I"
	line "find any. Will you"
	cont "please wait?"
	done
endc


WadeQuickBattleText:
if DEF(_FR_FR)
	text "On se bat ou bien?"
	
	para "@"
	text_ram wStringBuffer5
	text ","
	line "c'est là où je"
	
	para "traîne."
	line "Viens vite!"
	done
else
	text "Let's battle"
	line "already!"
	
	para "@"
	text_ram wStringBuffer5
	text " is"
	line "where I am."
	
	para "Please get here as"
	line "soon as you can!"
	done
endc


WadeComeQuickText:
if DEF(_FR_FR)
	text "Tu fais quoi?"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "Je t'attends!"
	done
else
	text "How come you're"
	line "not here yet?"
	
	para "@"
	text_ram wStringBuffer5
	text " is"
	line "where I am."
	
	para "Please get here as"
	line "soon as you can!"
	done
endc
