ChadAskNumber1Text:
if DEF(_FR_FR)
	text "De quoi? Ce truc"
	line "c'est un #DEX?"
	cont "Tu as vu le PROF."
	cont "CHEN?"
	
	para "C'est vrai? "
	line "Trop cool!"
	
	para "Moi aussi je veux"
	line "être un chercheur"
	
	para "comme le célèbre"
	line "PROF.CHEN."
	
	para "Je peux avoir ton"
	line "numéro?"
	
	para "On parlera du"
	line "PROF.CHEN."
	
	para "On va bien"
	line "s'amuser!"
	done
else
	text "Huh? Is that thing"
	line "a #DEX? Have"
	cont "you met PROF.OAK?"
	
	para "Huh? You have? "
	line "That's way cool!"
	
	para "I have a dream of"
	line "becoming a #MON"
	
	para "researcher like"
	line "PROF.OAK."
	
	para "May I please have"
	line "your phone number?"
	
	para "We should chat"
	line "about PROF.OAK."
	
	para "I'm sure it will"
	line "be loads of fun!"
	done
endc


ChadAskNumber2Text:
if DEF(_FR_FR)
	text "Je peux avoir ton"
	line "numéro?"
	
	para "On parlera du"
	line "PROF.CHEN."
	
	para "On va bien"
	line "s'amuser!"
	done
else
	text "May I please have"
	line "your phone number?"
	
	para "We should chat"
	line "about PROF.OAK."
	
	para "I'm sure it will"
	line "be loads of fun!"
	done
endc


ChadNumberAcceptedText:
if DEF(_FR_FR)
	text "Tu écoutes la"
	line "CHRONIQUE PKMN du"
	cont "PROF.CHEN, non?"
	done
else
	text "You must listen to"
	line "PROF.OAK'S #MON"
	cont "TALK, right?"
	done
endc


ChadNumberDeclinedText:
if DEF(_FR_FR)
	text "Oh... J'aurais"
	line "bien aimé rencon-"
	cont "trer le PROF..."
	done
else
	text "Oh… I wish I had a"
	line "chance to meet"
	cont "PROF.OAK…"
	done
endc


ChadPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone est"
	line "complet!"
	done
else
	text "Your phone list is"
	line "completely full!"
	done
endc


ChadRematchText:
if DEF(_FR_FR)
	text "Je t'attendais!"
	line "COMBAT!"
	done
else
	text "I've been waiting!"
	line "Let's battle now!"
	done
endc
