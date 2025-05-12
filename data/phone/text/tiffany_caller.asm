TiffanyMonIsAdorableText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est adorable, non?"
	
	para "Je dors toujours"
	line "avec lui..."
	cont "Il est si doux!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text "'s"
	line "adorable, don't"
	
	para "you think so?"
	line "I always sleep"
	
	para "with it--it's so"
	line "fluffy and warm!"
	done
endc


TiffanyDefeatedMonText:
if DEF(_FR_FR)
	text "Oh, on s'est battu"
	line "contre un"
	cont "@"
	text_ram wStringBuffer4
	text "…"
	
	para "Mon MELOFEE a"
	line "failli être K.O!"
	
	para "C'est affreux!"
	
	para "Je hais les"
	line "@"
	text_ram wStringBuffer4
	text "!"
	done
else
	text "Oh, and we had to"
	line "battle a wild"
	
	para "@"
	text_ram wStringBuffer4
	text " a while"
	line "ago…"
	
	para "My CLEFAIRY came"
	line "close to fainting!"
	
	para "Isn't that awful?"
	
	para "I hate those nasty"
	line "@"
	text_ram wStringBuffer4
	text "!"
	done
endc


TiffanyLostAMonText:
if DEF(_FR_FR)
	text "Oh, on s'est battu"
	line "contre un"
	cont "@"
	text_ram wStringBuffer4
	text "…"
	
	para "Mon MELOFEE a eu"
	line "peur alors on"
	cont "s'est enfui!"
	
	para "J'ai si peur pour"
	line "mon MELOFEE."
	done
else
	text "Oh, and we had to"
	line "battle a wild"
	
	para "@"
	text_ram wStringBuffer4
	text " a while"
	line "ago…"
	
	para "My CLEFAIRY got"
	line "frightened, so we"
	
	para "ran away as fast"
	line "as we could!"
	
	para "I just can't help"
	line "feeling protective"
	cont "of my CLEFAIRY."
	done
endc


TiffanyBattleRematchText:
if DEF(_FR_FR)
	text "Excuse-moi de te"
	line "demander mais..."
	
	para "Tu veux te battre"
	line "contre moi?"
	
	para "J'attends avec"
	line "MELOFEE vers"
	cont "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "I know this might"
	line "surprise you, but"
	
	para "would you like to"
	line "battle?"
	
	para "I'll be waiting"
	line "with CLEFAIRY on"
	cont "@"
	text_ram wStringBuffer5
	text "."
	done
endc


TiffanyItsAwfulText:
if DEF(_FR_FR)
	text_ram wStringBuffer4
	text "!"
	
	para "C'est affreux."
	line "Mon MELOFEE..."
	
	para "Hein? <PLAY_G>?"
	
	para "Oh, pardon..."
	line "Je..."
	
	para "Au revoir!"
	line "Tchao!"
	done
else
	text_ram wStringBuffer4
	text "!"
	
	para "It's awful."
	line "My CLEFAIRY…"
	
	para "Huh? <PLAY_G>?"
	
	para "Oh, sorry! I was"
	line "in a hurry, and I…"
	
	para "I have to go!"
	line "Bye-bye!"
	done
endc


TiffanyHangUpText:
if DEF(_FR_FR)
	text "Salut!"
	done
else
	text "Bye-bye!"
	done
endc


TiffanyFoundItemText:
if DEF(_FR_FR)
	text "J'ai pris des"
	line "RUBANS ROSES au"
	cont "CENTRE COMMERCIAL"
	cont "de DOUBLONVILLE"
	cont "pour mon MELOFEE."
	
	para "J'en ai trop! Je"
	line "t'en donne un!"
	
	para "Viens vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "I bought some PINK"
	line "BOWS at GOLDENROD"
	
	para "DEPT.STORE for my"
	line "CLEFAIRY."
	
	para "I got too many, so"
	line "I'll give you one!"
	
	para "Come collect it on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


TiffanyNoItemText:
if DEF(_FR_FR)
	text "J'adore habiller"
	line "mon MELOFEE!"
	done
else
	text "I love dressing up"
	line "my CLEFAIRY!"
	done
endc


TiffanyAsleepText:
if DEF(_FR_FR)
	text "Bah alors?"
	line "Tu viens?"
	
	para "MELOFEE s'est"
	line "endormi. Si je le"
	cont "réveille..."
	
	para "Viens vite vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "What's wrong?"
	line "Can't you visit?"
	
	para "CLEFAIRY got tired"
	line "and fell asleep."
	
	para "I'm not sure if I"
	line "can wake it up…"
	
	para "Please hurry to"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


TiffanyHurryText:
if DEF(_FR_FR)
	text "Bah alors?"
	line "Tu viens?"
	
	para "J'ai un truc pour"
	line "ton MELOFEE."
	
	para "Viens vite vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "What's wrong?"
	line "Can't you visit?"
	
	para "I'm sure this will"
	line "look good on your"
	cont "CLEFAIRY."
	
	para "Please hurry to"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc
