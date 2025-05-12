UnknownGenericText:
if DEF(_FR_FR)
	text "Comment vont tes"
	line "#MON?"
	
	para "Mes #MON ont"
	line "la super pêche."
	
	para "@"
	text_ram wStringBuffer4
	text ","
	line "en particulier."
	
	para "Il veut toujours"
	line "se battre."
	
	para "C'est trop pour"
	line "moi!"
	done
else
	text "How are your"
	line "#MON doing?"
	
	para "My #MON are a"
	line "bit too energetic."
	
	para "@"
	text_ram wStringBuffer4
	text ","
	line "especially."
	
	para "Every time it"
	line "spots a trainer,"
	cont "it has to battle."
	
	para "It gets to be a"
	line "bit much for me!"
	done
endc


UnknownTougherThanEverText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "est en super"
	cont "forme."
	
	para "Il est plus en"
	line "forme que moi!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text "'s"
	line "looking tougher"
	cont "than ever."
	
	para "It looks even"
	line "tougher than me!"
	done
endc
