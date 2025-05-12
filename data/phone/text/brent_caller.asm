BrentRareTradeText:
if DEF(_FR_FR)
	text "Oh! J'ai eu un"
	line "#MON super"
	cont "rare en faisant"
	cont "un échange."
	
	para "Tu veux savoir ce"
	line "que c'est?"
	
	para "C'est..."
	line "Un secret!"
	done
else
	text "Oh yeah, I got an"
	line "extremely rare"
	
	para "#MON in a trade"
	line "a while back."
	
	para "Do you want to"
	line "know what it is?"
	
	para "Hehe, I'm keeping"
	line "it a secret!"
	done
endc


BrentDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai battu un"
	line "@"
	text_ram wStringBuffer4
	text "."
	cont "Il était pas rare"
	cont "alors je l'ai pas"
	cont "attrapé."
	done
else
	text "Oh yeah, I took"
	line "down this wild"
	
	para "@"
	text_ram wStringBuffer4
	text "."
	line "It wasn't rare"
	
	para "enough to bother"
	line "catching."
	done
endc


BrentLostAMonText:
if DEF(_FR_FR)
	text "Oh! J'ai vu mon"
	line "premier #MON"
	cont "rare il y"
	cont "a une heure."
	
	para "Manque de pot..."
	line "Je n'avais plus de"
	cont "# BALLS..."
	
	para "LEO se ficherait"
	line "bien de moi!"
	done
else
	text "Oh yeah, I saw a"
	line "rare #MON about"
	cont "an hour ago."
	
	para "It was my first"
	line "sighting. But I"
	
	para "didn't have any"
	line "# BALLS…"
	
	para "Would BILL laugh"
	line "at my mistakes?"
	done
endc


BrentBattleRematchText:
if DEF(_FR_FR)
	text "Tu as une minute?"
	line "Un combat ça te"
	cont "tente?"
	
	para "Tu verras alors"
	line "mon #MON rare!"
	
	para "Viens vers..."
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "You've got time"
	line "like usual, right?"
	
	para "Feel like having a"
	line "battle?"
	
	para "It'll be a chance"
	line "to see my rare"
	
	para "#MON. It'll be"
	line "worth your time!"
	
	para "You know where--"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


BrentHangUpText:
if DEF(_FR_FR)
	text "Très bien."
	done
else
	text "So that's it then."
	done
endc


BrentFatherGossipText:
if DEF(_FR_FR)
	text "Tu savais que le"
	line "père de LEO était"
	cont "un #MANIAC?"
	done
else
	text "Did you know…?"
	line "BILL's father is"
	
	para "supposed to be a"
	line "great #MANIAC."
	done
endc


BrentGrandpaGossipText:
if DEF(_FR_FR)
	text "Tu savais que le"
	line "grand-père de LEO"
	
	para "n'était pas un"
	line "#MANIAC?"
	done
else
	text "Did you know…?"
	line "Apparently BILL's"
	
	para "grandpa isn't a"
	line "#MANIAC."
	done
endc


BrentGoldenrodGossipText:
if DEF(_FR_FR)
	text "Tu savais que LEO"
	line "était né à"
	cont "DOUBLONVILLE?"
	done
else
	text "Did you know…?"
	line "BILL's originally"
	cont "from GOLDENROD."
	done
endc


BrentRoute25GossipText:
if DEF(_FR_FR)
	text "Tu savais que LEO"
	line "vivait sur la"
	cont "ROUTE 25 à KANTO?"
	done
else
	text "Did you know…?"
	line "BILL evidently"
	
	para "lives on ROUTE 25"
	line "in KANTO."
	done
endc


BrentAbraGossipText:
if DEF(_FR_FR)
	text "Tu savais que le"
	line "premier #MON"
	cont "de LEO a attrapé"
	cont "est un ABRA?"
	done
else
	text "Did you know…?"
	line "ABRA was the first"
	
	para "#MON that BILL"
	line "ostensibly caught."
	done
endc


BrentSisterGossipText:
if DEF(_FR_FR)
	text "Tu savais que LEO"
	line "avait une petite"
	cont "soeur?"
	done
else
	text "Did you know…?"
	line "BILL's younger"
	
	para "sister apparently"
	line "can't wink."
	done
endc


BrentMilkGossipText:
if DEF(_FR_FR)
	text "Tu savais que LEO"
	line "détestait le LAIT?"
	done
else
	text "Did you know…?"
	line "BILL supposedly"
	
	para "hates milk and"
	line "can't drink it."
	done
endc


BrentBattlingGossipText:
if DEF(_FR_FR)
	text "Tu savais que LEO"
	line "était une tache en"
	cont "combat?"
	done
else
	text "Did you know…?"
	line "Evidently, BILL"
	
	para "isn't very good at"
	line "battling."
	done
endc


BrentFlowerShopGossipText:
if DEF(_FR_FR)
	text "Tu savais que LEO"
	line "draguait la"
	cont "FLEURISTE?"
	done
else
	text "Did you know…?"
	line "BILL appears to"
	
	para "like the lady at"
	line "the FLOWER SHOP."
	done
endc


BrentKimonoGirlGossipText:
if DEF(_FR_FR)
	text "Tu savais que la"
	line "mère de LEO était"
	cont "une KIMONO?"
	done
else
	text "Did you know…?"
	line "BILL's mother is"
	
	para "said to have been"
	line "a KIMONO GIRL."
	done
endc


BrentSorryImTooBusyText:
if DEF(_FR_FR)
	text "Tu veux en savoir"
	line "plus sur LEO?"
	
	para "Je suis trop"
	line "occupé."
	
	para "Je t'appelle plus"
	line "tard."
	done
else
	text "You wanted to hear"
	line "about BILL?"
	
	para "Sorry, but I'm too"
	line "busy for you."
	
	para "I'll call when I"
	line "have time."
	done
endc


BrentReminderText:
if DEF(_FR_FR)
	text "Tu veux voir mes"
	line "#MON rares?"
	
	para "Viens vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "You want to see my"
	line "rare #MON."
	
	para "Hurry over to"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc
