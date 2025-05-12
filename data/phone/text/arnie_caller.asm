ArnieMonIsSoCuteText:
if DEF(_FR_FR)
	text "J'ai toujours mon"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "Il est trop chou!"
	line "Je l'aime!"
	done
else
	text "I'm always with my"
	line "@"
	text_ram wStringBuffer4
	text "!"
	
	para "It's so cute!"
	line "I just love it!"
	done
endc


ArnieDefeatedMonText:
if DEF(_FR_FR)
	text "Au fait..."
	line "J'ai vu un"
	
	para "@"
	text_ram wStringBuffer4
	text " pour"
	line "la première fois."
	
	para "Il est assez faci-"
	line "le à battre."
	done
else
	text "Changing the topic"
	line "here, I saw this"
	
	para "@"
	text_ram wStringBuffer4
	text " for the"
	line "first time."
	
	para "It was easy to"
	line "beat, actually."
	done
endc


ArnieLostAMonText:
if DEF(_FR_FR)
	text "Dis donc..."
	line "Tu as un"
	cont "@"
	text_ram wStringBuffer4
	text "?"
	
	para "J'arrive pas à en"
	line "choper un."
	
	para "C'est quoi sa"
	line "faiblesse?"
	done
else
	text "I was wondering,"
	line "do you happen to"
	cont "have @"
	text_ram wStringBuffer4
	text "?"
	
	para "I can't seem to"
	line "catch one. What is"
	
	para "its weakness, I"
	line "wonder."
	done
endc


ArnieBattleRematchText:
if DEF(_FR_FR)
	text "Hé! Faisons un"
	line "combat!"
	
	para "Je ne vais pas"
	line "perdre! Ni en"
	cont "combat, ni au"
	cont "Concours de"
	cont "Capture!"
	
	para "Je suis vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Hey, let's battle"
	line "our #MON!"
	
	para "I won't lose to"
	line "you battling or in"
	
	para "the Bug-Catching"
	line "Contest!"
	
	para "I'll be here on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


ArnieHangUpText:
if DEF(_FR_FR)
	text "On se parle"
	line "bientôt, OK?"
	done
else
	text "Let's talk again,"
	line "huh?"
	done
endc


ArnieSwarmText:
if DEF(_FR_FR)
	text "Je suis content"
	line "de t'avoir!"
	
	para "Un tas de"
	line "@"
	text_ram wStringBuffer4
	text " est"
	
	para "apparu vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	
	para "Il faut que tu"
	line "voies ça!"
	done
else
	text "Boy, am I glad I"
	line "caught you!"
	
	para "A whole bunch of"
	line "@"
	text_ram wStringBuffer4
	text " have"
	
	para "appeared around"
	line "@"
	text_ram wStringBuffer5
	text "!"
	
	para "You have to see"
	line "this!"
	done
endc


ArnieHaventSeenRareMonText:
if DEF(_FR_FR)
	text "Je n'ai pas vu de"
	line "#MON rares"
	cont "dernièrement..."
	
	para "Mais ils ne sont"
	line "pas loin!"
	done
else
	text "I haven't had any"
	line "luck seeing rare"
	cont "#MON lately…"
	
	para "But I know they're"
	line "out there!"
	done
endc


ArnieReminderText:
if DEF(_FR_FR)
	text "Hé! Tu es où?"
	
	para "On va s'battre."
	line "Je t'attends vers"
	cont "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Hey, where are you"
	line "now?"
	
	para "Let's battle. I'll"
	line "be waiting for you"
	cont "on @"
	text_ram wStringBuffer5
	text "!"
	done
endc


ArnieHurryText:
if DEF(_FR_FR)
	text "Allô? Tu viens"
	line "oui ou zut?"
	
	para "Tu vas voir un"
	line "YANMA!"
	
	para "Viens sur la ROUTE"
	line "35 maintenant!"
	done
else
	text "Hello? Are you"
	line "coming or what?"
	
	para "You're missing out"
	line "on seeing YANMA!"
	
	para "Get down to ROUTE"
	line "35 right now!"
	done
endc
