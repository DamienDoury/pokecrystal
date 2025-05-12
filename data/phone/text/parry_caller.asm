ParryNothingCanMatchText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "c'est le top."
	done
else
	text "Nothing can match"
	line "my @"
	text_ram wStringBuffer4
	text " now."
	done
endc


ParryDefeatedMonText:
if DEF(_FR_FR)
	text "On a mis K.O."
	line "un @"
	text_ram wStringBuffer4
	text_start
	cont "sauvage!"
	
	para "En fait je voulais"
	line "l'attraper…"
	done
else
	text "Yeah, we KO'd a"
	line "wild @"
	text_ram wStringBuffer4
	text "!"
	
	para "That was OK, but I"
	line "wanted to get it…"
	done
endc


ParryLostAMonText:
if DEF(_FR_FR)
	text "Hier, on a vu"
	line "un @"
	text_ram wStringBuffer4
	text_start
	
	para "sauvage."
	line "On savait pas s'il"
	
	para "fallait l'attraper"
	line "ou le battre."
	
	para "Et puis un type"
	line "est arrivé et l'a"
	
	para "chopé!"
	line "Tu le crois ça?"
	done
else
	text "And yesterday, we"
	line "spotted a wild"
	
	para "@"
	text_ram wStringBuffer4
	text "."
	line "We were debating"
	
	para "whether to catch"
	line "it or beat it."
	
	para "When along came"
	line "another guy who"
	
	para "caught it!"
	line "How about that!"
	done
endc


ParryBattleRematchText:
if DEF(_FR_FR)
	text "Tu veux te battre"
	line "contre moi, non?"
	
	para "J'ai bon?"
	line "Hein?"
	
	para "On s'retrouve vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "You're thinking"
	line "you'd like to"
	
	para "battle me. Am I"
	line "right or what?"
	
	para "Yep! We'll meet on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


ParryHangUpText:
if DEF(_FR_FR)
	text "OK, rappelle-moi"
	line "vite!"
	done
else
	text "OK, give me a call"
	line "again!"
	done
endc


ParryBattleWithMeText:
if DEF(_FR_FR)
	text "Tu vas encore"
	line "m'affronter, non?"
	done
else
	text "You'll battle with"
	line "me again, right?"
	done
endc


ParryHaventYouGottenToText:
if DEF(_FR_FR)
	text "Tu as visité"
	line "@"
	text_ram wStringBuffer5
	text "?"
	
	para "J'attends là."
	line "Je veux combattre!"
	done
else
	text "Haven't you gotten"
	line "to @"
	text_ram wStringBuffer5
	text "?"
	
	para "Waiting here isn't"
	line "bad, but I'd sure"
	cont "like to battle!"
	done
endc
