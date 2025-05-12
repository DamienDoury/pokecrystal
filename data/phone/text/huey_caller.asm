HueyBattleRematchText:
if DEF(_FR_FR)
	text "Je te lance un"
	line "défi!"
	
	para "Et c'est sérieux"
	line "cette fois!"
	
	para "@"
	text_ram wStringBuffer5
	text_start
	line "sera le champ"
	cont "de bataille!"
	done
else
	text "Hey, I challenge"
	line "you to a battle!"
	
	para "It won't be like"
	line "last time!"
	
	para "@"
	text_ram wStringBuffer5
	text "'s"
	line "where I'm waiting"
	
	para "for you. Hustle"
	line "over here pronto!"
	done
endc


HueyHangUpText:
if DEF(_FR_FR)
	text "A plus!"
	done
else
	text "See ya!"
	done
endc


HueyWeHaveToBattleAgainSometimeText:
if DEF(_FR_FR)
	text "Il faut se refaire"
	line "un combat."
	
	para "Je te lâcherai pas"
	line "tant que je"
	cont "n'aurai pas gagné."
	done
else
	text "We have to battle"
	line "again sometime."
	
	para "You can bet I'm"
	line "going to keep"
	
	para "challenging you"
	line "till I win."
	done
endc


HueyReminderText:
if DEF(_FR_FR)
	text "Hé! T'as oublié"
	line "notre combat?"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Viens vite!"
	line "Je t'attends!"
	done
else
	text "Hey, you'd better"
	line "not have forgotten"
	cont "about our battle!"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Hustle over quick!"
	line "I'm waiting!"
	done
endc
