AnthonyMonAteSomeBerriesText:
if DEF(_FR_FR)
	text "L'autre jour j'ai"
	line "vu @"
	text_ram wStringBuffer4
	text_start
	cont "manger des BAIES."
	
	para "Il avait l'air"
	line "d'aimer ça, alors"
	
	para "j'ai décidé d'y"
	line "goûter."
	
	para "Je ne sais pas si"
	line "c'est bon pour la"
	
	para "santé, mais c'est"
	line "délicieux!"
	done
else
	text "The other day, I"
	line "was watching my"
	
	para "@"
	text_ram wStringBuffer4
	text " eat"
	line "some BERRIES."
	
	para "It looked like it"
	line "was enjoying its"
	
	para "meal, so I decided"
	line "to try some."
	
	para "I'm not sure if"
	line "people should eat"
	
	para "that stuff, but it"
	line "was delicious!"
	done
endc


AnthonyDefeatedMonText:
if DEF(_FR_FR)
	text "En ce moment, je"
	line "vois beaucoup de"
	
	para "@"
	text_ram wStringBuffer4
	text_start
	line "sauvages."
	
	para "On peut les battre"
	line "facilement."
	done
else
	text "Lately, I've been"
	line "running across"
	
	para "wild @"
	text_ram wStringBuffer4
	text_start
	line "quite often."
	
	para "They're easily"
	line "taken care of."
	done
endc


AnthonyLostAMonText:
if DEF(_FR_FR)
	text "Au fait, j'ai"
	line "combattu un"
	
	para "@"
	text_ram wStringBuffer4
	text_start
	line "l'autre jour..."
	
	para "J'ai été dis-"
	line "trait par un"
	cont "CANON qui passait."
	
	para "Comme quoi..."
	line "Y'a des filles,"
	
	para "faut pas les"
	line "regarder..."
	cont "Ca fait trop mal!"
	done
else
	text "Oh yeah, I was"
	line "battling this"
	
	para "@"
	text_ram wStringBuffer4
	text " the"
	line "other day…"
	
	para "It took off when I"
	line "got distracted by"
	cont "a passing BEAUTY."
	
	para "Learn from my"
	line "mistake--always"
	
	para "stay focused on"
	line "the job at hand!"
	done
endc


AnthonyBattleRematchText:
if DEF(_FR_FR)
	text "Allez! On va se"
	line "battre!"
	
	para "@"
	text_ram wStringBuffer5
	text ","
	line "c'est là où je"
	
	para "suis. Viens me"
	line "rejoindre!"
	done
else
	text "Come on--let's"
	line "battle right now!"
	
	para "@"
	text_ram wStringBuffer5
	text " is"
	line "where I am."
	
	para "Come on down if"
	line "you feel up to it!"
	done
endc


AnthonyHangUpText:
if DEF(_FR_FR)
	text "Allez hop!"
	line "A la prochaine!"
	done
else
	text "All right then!"
	line "Be good!"
	done
endc


AnthonySwarmText:
if DEF(_FR_FR)
	text "<PLAYER>!"
	line "C'est dingue!"
	
	para "Je suis allé vers"
	line "@"
	text_ram wStringBuffer5
	text_start
	cont "hier..."
	
	para "Il y a plein de"
	line "@"
	text_ram wStringBuffer4
	text_start
	para "dans ce coin!"
	line "Faut voir ça!"
	
	para "J'ai l'impression"
	line "que @"
	text_ram wStringBuffer4
	text_start
	para "est timide."
	line "J'en ai pas vu là"
	
	para "où il y a des"
	line "#MON puissants."
	done
else
	text "<PLAYER>! It's"
	line "mind-blowing!"
	
	para "I took a hike in"
	line "@"
	text_ram wStringBuffer5
	text_start
	cont "yesterday, see?"
	
	para "Well, there were"
	line "tons of @"
	text_ram wStringBuffer4
	text_start
	para "around! You have"
	line "to see it!"
	
	para "I get this feeling"
	line "that @"
	text_ram wStringBuffer4
	text_start
	para "may be timid."
	line "I didn't see any"
	
	para "where there are"
	line "strong #MON."
	done
endc


AnthonyWasntPayingAttentionText:
if DEF(_FR_FR)
	text "Des #MON rares?"
	
	para "Désolé!"
	line "Je ne fais pas"
	
	para "attention quand je"
	line "me balade."
	done
else
	text "Rare #MON?"
	
	para "Hey, sorry! I was"
	line "too focused on my"
	
	para "hike, so I wasn't"
	line "paying attention."
	done
endc


AnthonyReminderText:
if DEF(_FR_FR)
	text "Hé! Tu as oublié"
	line "notre combat?"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "J'attends!"
	done
else
	text "Hello! You haven't"
	line "forgotten about"
	
	para "our battle, have"
	line "you?"
	
	para "@"
	text_ram wStringBuffer5
	text "!"
	line "I'm waiting!"
	done
endc


AnthonyHurryText:
if DEF(_FR_FR)
	text "Allô? Quoi? Où"
	line "est INSOLOURDO?"
	
	para "ANTRE NOIRE! Vite!"
	
	para "Il n'apparaît pas"
	line "s'il y a trop de"
	
	para "#MON puissants"
	line "dans le coin."
	done
else
	text "Hello? What? Where"
	line "is DUNSPARCE?"
	
	para "DARK CAVE! Hurry!"
	
	para "I know I've said"
	line "it before, but"
	
	para "DUNSPARCE don't"
	line "appear when there"
	
	para "are strong #MON"
	line "around."
	done
endc
