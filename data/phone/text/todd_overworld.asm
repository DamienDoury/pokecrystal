ToddAskNumber1Text:
if DEF(_FR_FR)
	text "D'ici, je peux"
	line "voir le CENTRE"
	
	para "COMMERCIAL de DOU-"
	line "BLONVILLE. Il y a"
	
	para "des offres spécia-"
	line "les sur le toit de"
	cont "temps en temps."
	
	para "Je peux avoir ton"
	line "numéro?"
	
	para "Je te préviens"
	line "s'il s'y passe"
	cont "quelque chose."
	done
else
	text "From here, I can"
	line "see GOLDENROD's"
	
	para "DEPT.STORE. They"
	line "have bargain sales"
	
	para "up on the rooftop"
	line "every so often."
	
	para "Could I get your"
	line "phone number?"
	
	para "I'll call you when"
	line "they have a sale."
	done
endc


ToddAskNumber2Text:
if DEF(_FR_FR)
	text "Donne-moi ton nu-"
	line "méro et je te pré-"
	
	para "viendrai s'il y a"
	line "une offre spé-"
	cont "ciale."
	done
else
	text "If you give me"
	line "your number, I'll"
	
	para "call you when they"
	line "have a sale."
	done
endc


ToddNumberAcceptedText:
if DEF(_FR_FR)
	text "Je jette un oeil"
	line "au CENTRE COMMER-"
	
	para "CIAL de DOUBLON-"
	line "VILLE tous les"
	cont "jours. Je sais ce"
	cont "qu'il s'y passe."
	done
else
	text "I check GOLDENROD"
	line "DEPT.STORE every"
	
	para "day, so I know"
	line "when there's a"
	cont "sale."
	done
endc


ToddNumberDeclinedText:
if DEF(_FR_FR)
	text "Enfin bref..."
	
	para "S'il te manque des"
	line "sous, prends mon"
	cont "numéro."
	
	para "Je t'appelle s'il"
	line "y a une offre"
	cont "spéciale."
	done
else
	text "Anyway…"
	
	para "If you're short on"
	line "money, take down"
	cont "my number."
	
	para "I'll call you when"
	line "there's a sale."
	done
endc


ToddPhoneFullText:
if DEF(_FR_FR)
	text "Ton téléphone"
	line "n'a plus de mémoi-"
	cont "re pour des No."
	cont "supplémentaires."
	done
else
	text "Your phone doesn't"
	line "have enough memory"
	cont "for more numbers."
	done
endc


ToddRematchText:
if DEF(_FR_FR)
	text "Je t'attendais!"
	line "J'ai arrêté mon"
	
	para "shopping pour"
	line "entraîner mes"
	cont "#MON!"
	done
	
	ToddSaleText: ; unreferenced
	; This is a duplicate of CamperToddSaleText in maps/Route34.asm.
	text "Du shopping sous"
	line "le ciel!"
	
	para "Etre sur le toit,"
	line "c'est top."
	done
else
	text "I waited for you!"
	line "I even cut back my"
	
	para "shopping to raise"
	line "my #MON better!"
	done
	
	ToddSaleText: ; unreferenced
	; This is a duplicate of CamperToddSaleText in maps/Route34.asm.
	text "Shopping under the"
	line "sky!"
	
	para "It feels so nice"
	line "up on a rooftop."
	done
endc
