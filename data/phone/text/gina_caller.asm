GinaGettingInSyncWithMonText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "et moi, on est en"
	cont "pleine harmonie."
	done
else
	text "My @"
	text_ram wStringBuffer4
	text " and"
	line "I are getting more"
	
	para "in sync with each"
	line "other."
	done
endc


GinaDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai combattu un"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "sauvage..."
	
	para "C'était trop beau!"
	done
else
	text "We battled a wild"
	line "@"
	text_ram wStringBuffer4
	text " and"
	
	para "managed to drop it"
	line "in a close match."
	
	para "We're getting into"
	line "the groove!"
	done
endc


GinaLostAMonText:
if DEF(_FR_FR)
	text "Tu sais quoi?"
	
	para "J'ai toujours pas"
	line "attrapé de"
	cont "@"
	text_ram wStringBuffer4
	text "."
	
	para "Ca devient un peu"
	line "agaçant..."
	done
else
	text "But, you know?"
	
	para "I still haven't"
	line "caught @"
	text_ram wStringBuffer4
	text "."
	
	para "It's getting past"
	line "frustrating…"
	done
endc


GinaBattleRematchText:
if DEF(_FR_FR)
	text "Ca te dirait de"
	line "t'entraîner avec"
	cont "moi?"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "...Vas-y doucement"
	line "avec moi, OK?"
	done
else
	text "Would you be my"
	line "practice partner"
	cont "again sometime?"
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "…Could you take it"
	line "a little easier on"
	cont "me next time?"
	done
endc


GinaHangUpText:
if DEF(_FR_FR)
	text "On se reparle"
	line "plus tard!"
	done
else
	text "Bye! Let's chat"
	line "again!"
	done
endc


GinaRocketTakeoverRumorText:
if DEF(_FR_FR)
	text "As-tu appris pour"
	line "la TEAM ROCKET?"
	
	para "Ils ont envahi la"
	line "TOUR RADIO de"
	cont "DOUBLONVILLE."
	
	para "Les gens sont-ils"
	line "en sécurité?"
	done
else
	text "Have you heard"
	line "about TEAM ROCKET?"
	
	para "They've taken over"
	line "the RADIO TOWER in"
	cont "GOLDENROD."
	
	para "Are the people"
	line "inside safe?"
	done
endc


GinaFoundItemText:
if DEF(_FR_FR)
	text "J'ai trouvé un"
	line "truc joli."
	
	para "Je veux que tu"
	line "l'acceptes!"
	
	para "Alors viens le"
	line "chercher!"
	
	para "@"
	text_ram wStringBuffer5
	text ","
	line "c'est là où je"
	cont "suis."
	done
else
	text "I picked up some-"
	line "thing nice today."
	
	para "I want you to have"
	line "it, so I called!"
	
	para "You will come for"
	line "it, won't you?"
	
	para "@"
	text_ram wStringBuffer5
	text " is"
	line "where I am."
	done
endc


GinaHaventFoundAnythingYetText:
if DEF(_FR_FR)
	text "Je n'ai encore"
	line "rien trouvé de"
	
	para "spécial..."
	line "Si je trouve quel-"
	
	para "que chose, c'est"
	line "pour toi!"
	done
else
	text "Sorry, I haven't"
	line "found anything"
	
	para "useful yet…"
	line "I promise, if I"
	
	para "find anything, you"
	line "can have it!"
	done
endc


GinaReminderText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	line "On se voit pour"
	cont "notre combat?"
	
	para "N'oublie pas:"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Oh, <PLAY_G>!"
	line "How soon can I"
	
	para "expect to see you"
	line "for our battle?"
	
	para "Don't forget,"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


GinaComePickUpText:
if DEF(_FR_FR)
	text "Tu me fais"
	line "poireauter!"
	
	para "Vite!"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "I'm getting really"
	line "impatient, waiting"
	
	para "to give you my"
	line "present!"
	
	para "Hurry over to"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc
