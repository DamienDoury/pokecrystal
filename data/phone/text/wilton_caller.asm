WiltonMonHasGrownText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "a bien grandi!"
	
	para "Je suis un sacré"
	line "pêcheur!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text "'s"
	line "grown impressive!"
	
	para "My fishing skills"
	line "have improved too!"
	done
endc


WiltonDefeatedMonText:
if DEF(_FR_FR)
	text "On a battu un"
	line "@"
	text_ram wStringBuffer4
	text "…"
	
	para "Tu sais, la pêche,"
	line "je trouve ça plus"
	cont "marrant."
	done
else
	text "We beat a wild"
	line "@"
	text_ram wStringBuffer4
	text "…"
	
	para "You know, I have"
	line "more fun fishing"
	
	para "than beating wild"
	line "#MON."
	done
endc


WiltonLostAMonText:
if DEF(_FR_FR)
	text "L'autre jour,"
	line "j'ai failli pêcher"
	
	para "un énorme"
	line "@"
	text_ram wStringBuffer4
	text "."
	
	para "Enorme, il était."
	line "J'te jure!"
	done
else
	text "But a while back,"
	line "we came this close"
	
	para "to landing a wild"
	line "@"
	text_ram wStringBuffer4
	text "."
	
	para "I tell you, it was"
	line "huge. Believe me."
	done
endc


WiltonBattleRematchText:
if DEF(_FR_FR)
	text "Je pêche vers"
	line "@"
	text_ram wStringBuffer5
	text ","
	
	para "mais ça ne mord"
	line "pas."
	
	para "Il faut qu'on se"
	line "batte pour faire"
	cont "passer le temps."
	done
else
	text "I'm fishing on"
	line "@"
	text_ram wStringBuffer5
	text ","
	
	para "but nothing's"
	line "biting today."
	
	para "Help me while my"
	line "time away, come"
	cont "over for a battle."
	done
endc


WiltonHangUpText:
if DEF(_FR_FR)
	text "A plus tard."
	done
else
	text "All right, later."
	done
endc


WiltonFoundItemText:
if DEF(_FR_FR)
	text "J'ai eu un objet"
	line "en pêchant."
	
	para "Viens le prendre"
	line "vers..."
	cont "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "I snagged an item"
	line "while fishing."
	
	para "Come pick it up on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


WiltonHaventFoundAnythingText:
if DEF(_FR_FR)
	text "Non. Je n'ai rien"
	line "trouvé d'intéres-"
	cont "sant."
	
	para "Tu dois encore"
	line "attendre."
	done
else
	text "Nah, I haven't"
	line "found anything"
	
	para "that's worth your"
	line "time."
	
	para "You have to have"
	line "patience."
	done
endc


WiltonNotBitingText:
if DEF(_FR_FR)
	text "Pfff..."
	line "Ca mord plus."
	
	para "Pas comme vers"
	line "@"
	text_ram wStringBuffer5
	text "…"
	
	para "Il faut qu'on"
	line "se batte!"
	done
else
	text "Sigh…"
	line "They're not biting"
	
	para "like before on"
	line "@"
	text_ram wStringBuffer5
	text "…"
	
	para "You have to come"
	line "for a battle!"
	done
endc


WiltonWantThisText:
if DEF(_FR_FR)
	text "Tu ne veux pas de"
	line "cet objet?"
	
	para "Quoi? Tu ne sais"
	line "pas où?"
	
	para "@"
	text_ram wStringBuffer5
	text "…"
	line "Va d'ACAJOU vers"
	cont "EBENELLE!"
	done
else
	text "Don't you want"
	line "this item?"
	
	para "Hah? You don't"
	line "know where?"
	
	para "@"
	text_ram wStringBuffer5
	text "…"
	line "Just head from"
	
	para "MAHOGANY toward"
	line "BLACKTHORN!"
	done
endc
