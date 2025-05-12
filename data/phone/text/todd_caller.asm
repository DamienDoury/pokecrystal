ToddLooksCuteLikeMeText:
if DEF(_FR_FR)
	text "Mon @"
	text_ram wStringBuffer4
	text_start
	line "me ressemble de"
	
	para "plus en plus!"
	line "Il est trop mimi!"
	done
else
	text "My @"
	text_ram wStringBuffer4
	text " is"
	line "looking more and"
	
	para "more like me. It's"
	line "getting cuter!"
	done
endc


ToddDefeatedMonText:
if DEF(_FR_FR)
	text "Tu sais quoi?"
	
	para "On peut battre"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "facilement."
	
	para "Je devrais aller à"
	line "l'ARENE de"
	cont "DOUBLONVILLE."
	done
else
	text "And, you know?"
	
	para "Now we can KO"
	line "@"
	text_ram wStringBuffer4
	text " easily."
	
	para "I should challenge"
	line "the GOLDENROD GYM."
	done
endc


ToddLostAMonText:
if DEF(_FR_FR)
	text "Tu sais quoi?"
	line "J'ai pas réussi à"
	
	para "battre @"
	text_ram wStringBuffer4
	text_start
	line "de peu."
	
	para "On dirait que mes"
	line "#MON n'ont pas"
	cont "encore le niveau."
	done
else
	text "And, you know?"
	line "We just failed to"
	
	para "beat @"
	text_ram wStringBuffer4
	text " by"
	line "a tiny margin."
	
	para "I'm guessing my"
	line "#MON's levels"
	
	para "aren't high enough"
	line "yet…"
	done
endc


ToddBattleRematchText:
if DEF(_FR_FR)
	text "Tu as dû faire des"
	line "progrès, non?"
	
	para "Ca te dirait de me"
	line "montrer tout ça en"
	cont "combat?"
	
	para "J'attends vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "You must be a lot"
	line "better now, huh?"
	
	para "How about showing"
	line "me your technique"
	
	para "in a real battle"
	line "with me?"
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


ToddHangUpText:
if DEF(_FR_FR)
	text "A plus tard!"
	done
else
	text "See you later!"
	done
endc


ToddDepartmentStoreBargainSaleText:
if DEF(_FR_FR)
	text "Ca y est!"
	line "Enfin!"
	
	para "Le CENTRE COMMER-"
	line "CIAL de DOUBLON-"
	cont "VILLE fait des"
	cont "soldes!"
	
	para "Pas cher!"
	line "Tout neuf!"
	
	para "Faut aller à"
	line "DOUBLONVILLE!"
	
	para "Quoi? Mais non je"
	line "travaille pas chez"
	cont "eux!"
	
	para "Je veux faire de"
	line "la pub plus tard."
	
	para "En tout cas,"
	line "vas-y, ça vaut le"
	cont "coup!"
	done
else
	text "This is it--the"
	line "one we've all been"
	cont "waiting for!"
	
	para "GOLDENROD DEPT."
	line "STORE's bargain"
	cont "sale is on now!"
	
	para "Want it cheap?"
	line "Want it lots?"
	
	para "Don't miss this"
	line "GOLDENROD chance!"
	
	para "Huh? I sound like"
	line "a huckster?"
	
	para "Well, yeah. I was"
	line "mimicking them…"
	
	para "Anyway, you've got"
	line "to get there as"
	cont "soon as you can!"
	done
endc


ToddSavingUpForBargainSaleText:
if DEF(_FR_FR)
	text "J'économise pour"
	line "les prochaines"
	
	para "soldes. C'est pour"
	line "quand?"
	done
else
	text "I'm saving up for"
	line "the next bargain"
	
	para "sale. When's the"
	line "next one?"
	done
endc


ToddLookingForwardToBattleText:
if DEF(_FR_FR)
	text "Tu es où?"
	
	para "Faisons un match!"
	line "J'attends vers"
	cont "@"
	text_ram wStringBuffer5
	text "."
	done
else
	text "Where are you?"
	
	para "Let's have our"
	line "battle soon!"
	
	para "I'll be waiting on"
	line "@"
	text_ram wStringBuffer5
	text "."
	done
endc


ToddHaveYouGoneToDepartmentStoreText:
if DEF(_FR_FR)
	text "Tu as visité le"
	line "CENTRE COMMERCIAL"
	
	para "de DOUBLONVILLE?"
	line "Ils font des super"
	cont "soldes!"
	
	para "Tu devrais y"
	line "aller."
	done
else
	text "Haven't you gone"
	line "to GOLDENROD DEPT."
	
	para "STORE? I've scoped"
	line "it out already!"
	
	para "They had some real"
	line "bargains."
	
	para "You should get"
	line "there quickly."
	done
endc
