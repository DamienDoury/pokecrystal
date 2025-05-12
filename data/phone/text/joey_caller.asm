JoeyMonLookingSharperText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est en méga super"
	cont "forme!"
	
	para "J'pense que t'en"
	line "as pas des #MON"
	cont "comme le mien!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text "'s"
	line "looking sharper"
	cont "than before!"
	
	para "I doubt there's a"
	line "#MON as cool as"
	
	para "this guy in your"
	line "party!"
	done
endc


JoeyDefeatedMonText:
if DEF(_FR_FR)
	text "Oh! J'ai battu"
	line "un @"
	text_ram wStringBuffer4
	text_start
	para "sauvage l'autre"
	line "jour."
	
	para "Trop facile."
	line "Normal."
	cont "J'suis une brute."
	done
else
	text "Oh yeah, I took"
	line "down a @"
	text_ram wStringBuffer4
	text_start
	para "in the wild the"
	line "other day."
	
	para "It was a cakewalk."
	line "Well, I guess it"
	
	para "can't be helped,"
	line "us being so tough."
	done
endc


JoeyLostAMonText:
if DEF(_FR_FR)
	text "Oh! J'ai vu un"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "J'ai voulu le"
	line "choper, mais"
	
	para "finalement j'ai"
	line "préféré lui mettre"
	cont "une rouste."
	done
else
	text "Oh yeah, I saw a"
	line "wild @"
	text_ram wStringBuffer4
	text "!"
	
	para "I thought about"
	line "going for it, but"
	
	para "I decided to work"
	line "with my one-and-"
	
	para "only right to the"
	line "extreme end."
	done
endc


JoeyBattleRematchText:
if DEF(_FR_FR)
	text "On se fait un"
	line "combat?"
	
	para "J'ai changé, tu"
	line "verras!"
	
	para "@"
	text_ram wStringBuffer5
	text ","
	line "c'est là où je"
	cont "suis."
	
	para "Appelle si tu es"
	line "dans le coin."
	done
else
	text "Let's get together"
	line "and battle!"
	
	para "I promise things"
	line "will be different!"
	
	para "@"
	text_ram wStringBuffer5
	text "'s"
	line "where I'll be."
	
	para "Give me a shout"
	line "when you come."
	done
endc


JoeyHangUpText:
if DEF(_FR_FR)
	text "A plus tard!"
	done
else
	text "All right. Later!"
	done
endc


JoeyDevisingStrategiesText:
if DEF(_FR_FR)
	text "J'analyse"
	line "@"
	text_ram wStringBuffer4
	text_start
	
	para "et j'élabore des"
	line "stratégies."
	
	para "Si j'en trouve une"
	line "bonne, on se fait"
	cont "un combat!"
	done
else
	text "I'm checking out"
	line "@"
	text_ram wStringBuffer4
	text "'s moves"
	
	para "and devising some"
	line "strategies."
	
	para "When I come up"
	line "with a good one,"
	cont "let's battle!"
	done
endc


JoeyReminderText:
if DEF(_FR_FR)
	text "Je t'attends,"
	line "<PLAYER>!"
	
	para "On se le fait ce"
	line "combat ou bien?"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "What's keeping"
	line "you, <PLAYER>!"
	
	para "Let's get down and"
	line "battle already!"
	
	para "I'm waiting on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc
