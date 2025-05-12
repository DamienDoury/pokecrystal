RalphAskNumber1Text:
if DEF(_FR_FR)
	text "Les jeunes ne"
	line "pêchent plus,"
	cont "ou bien?"
	
	para "Moi j'ai vu des"
	line "#MON rares en"
	cont "pêchant..."
	
	para "Les jeunes, ça"
	line "aime ça, non?"
	
	para "On échange nos"
	line "numéros?"
	
	para "J'te préviens si"
	line "je vois un truc."
	done
else
	text "Don't young people"
	line "fish anymore?"
	
	para "I've seen rare"
	line "#MON while I've"
	cont "been fishing…"
	
	para "You young people"
	line "like that, right?"
	
	para "Want to trade"
	line "phone numbers?"
	
	para "I'll let you know"
	line "if I see anything."
	done
endc


RalphAskNumber2Text:
if DEF(_FR_FR)
	text "Hmm? Tu veux que"
	line "j'appelle si je"
	cont "vois un #MON"
	cont "rare, alors?"
	done
else
	text "Hm? So you do want"
	line "me to phone if I"
	cont "see rare #MON?"
	done
endc


RalphNumberAcceptedText:
if DEF(_FR_FR)
	text "OK. J'appelle si"
	line "je vois un"
	cont "#MON rare."
	
	para "Pas de lézard!"
	line "J'oublierai pas!"
	done
else
	text "Yep, phone if I"
	line "see rare #MON."
	
	para "Don't worry, I"
	line "won't forget!"
	done
endc


RalphNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh..."
	line "Même mes enfants"
	
	para "ne veulent pas me"
	line "donner leur numéro"
	cont "de téléphone..."
	
	para "C'est ça la jeu-"
	line "nesse?"
	done
else
	text "Oh…"
	line "My own kids won't"
	
	para "even give me their"
	line "phone numbers…"
	
	para "Is that how young"
	line "people are today?"
	done
endc


RalphPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone est"
	line "plein."
	
	para "Les jeunes, ça"
	line "fait n'importe"
	cont "quoi."
	done
else
	text "Your phone's"
	line "memory is full."
	
	para "It seems that"
	line "young people all"
	cont "have #GEAR."
	done
endc


RalphRematchText:
if DEF(_FR_FR)
	text "Hé, ma puce!"
	
	para "J'perds pas"
	line "aujourd'hui!"
	done
else
	text "Hey, kid!"
	
	para "No losing for me"
	line "this day!"
	done
endc
