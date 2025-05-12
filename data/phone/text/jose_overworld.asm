JoseAskNumber1Text:
if DEF(_FR_FR)
	text "Si mon @"
	text_ram wStringBuffer4
	text_start
	line "vois un truc joli,"
	cont "il va le prendre."
	
	para "Tu aimes les trucs"
	line "jolis?"
	
	para "Je peux t'en filer"
	line "si j'en ai trop."
	
	para "C'est quoi ton"
	line "numéro?"
	
	para "Ne t'attends pas"
	line "à grand-chose, OK?"
	done
else
	text "If my @"
	text_ram wStringBuffer4
	text_start
	line "sees anything"
	
	para "pretty, it goes"
	line "and gets it."
	
	para "Do you like pretty"
	line "things?"
	
	para "I could share if"
	line "it gets some more."
	
	para "What's your phone"
	line "number? I'll call."
	
	para "Don't expect a"
	line "whole lot, OK?"
	done
endc


JoseAskNumber2Text:
if DEF(_FR_FR)
	text "Tu aimes les trucs"
	line "jolis?"
	
	para "Je peux partager"
	line "si CANARTICHO en"
	cont "trouve d'autres."
	
	para "C'est quoi ton"
	line "numéro?"
	done
else
	text "Do you like pretty"
	line "things?"
	
	para "I could share if"
	line "FARFETCH'D goes"
	cont "and gets more."
	
	para "What's your phone"
	line "number? I'll call."
	done
endc


JoseNumberAcceptedText:
if DEF(_FR_FR)
	text "Je t'appelle s'il"
	line "trouve quelque"
	cont "chose de joli."
	done
else
	text "I'll call you as"
	line "soon as I get"
	cont "something pretty."
	done
endc


JoseNumberDeclinedText:
if DEF(_FR_FR)
	text "Vraiment? Bon."
	line "Préviens-moi si tu"
	cont "changes d'avis."
	done
else
	text "You sure? Well,"
	line "tell me if you"
	cont "change your mind."
	done
endc


JosePhoneFullText:
if DEF(_FR_FR)
	text "Oh? Ton téléphone"
	line "est plein."
	done
else
	text "Huh? Your phone"
	line "list is full."
	done
endc


JoseRematchText:
if DEF(_FR_FR)
	text "Cui! Cuuuiiii!"
	
	para "J't'attendais!"
	line "Allez, CANARTICHO!"
	done
else
	text "Tweet! Tweeeet!"
	
	para "Kept me waiting!"
	line "Go, FARFETCH'D!"
	done
endc


JoseGiftText:
if DEF(_FR_FR)
	text "Je t'attendais!"
	line "...Voilà!"
	
	para "Alors?"
	line "C'est joli?"
	done
else
	text "Kept me waiting!"
	line "Look, this is it!"
	
	para "See? Isn't it some"
	line "kind of pretty?"
	done
endc


JosePackFullText:
if DEF(_FR_FR)
	text "Hein? Tu n'as plus"
	line "de place. Tu vas"
	
	para "devoir revenir une"
	line "prochaine fois."
	done
else
	text "Huh? You don't"
	line "have anywhere to"
	
	para "put this. Better"
	line "come back for it."
	done
endc
