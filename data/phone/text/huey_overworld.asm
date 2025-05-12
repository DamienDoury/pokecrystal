HueyAskNumber1Text:
if DEF(_FR_FR)
	text "Cool! Ca faisait"
	line "longtemps que j'"
	cont "avais pas perdu!"
	
	para "Hé! File-moi ton"
	line "numéro."
	
	para "Je t'appelle quand"
	line "j'aurai fait des"
	
	para "progrès..."
	line "Ca marche?"
	done
else
	text "Cool! That's the"
	line "first time I've"
	cont "lost in a while!"
	
	para "Hey, give me your"
	line "phone number."
	
	para "You'd be fun to"
	line "battle, so I'll"
	
	para "call you when I"
	line "get stronger!"
	done
endc


HueyAskNumber2Text:
if DEF(_FR_FR)
	text "Hé! File-moi ton"
	line "numéro."
	
	para "Je t'appelle quand"
	line "j'aurai fait des"
	
	para "progrès..."
	line "Ca marche?"
	done
else
	text "Hey, give me your"
	line "phone number."
	
	para "You'd be fun to"
	line "battle, so I'll"
	
	para "call you when I"
	line "get stronger!"
	done
endc


HueyNumberAcceptedText:
if DEF(_FR_FR)
	text "On combat quand"
	line "tu veux!"
	done
else
	text "Hey, let's battle"
	line "again!"
	done
endc


HueyNumberDeclinedText:
if DEF(_FR_FR)
	text "T'as l'air d'une"
	line "mauviette..."
	done
else
	text "Looks like you're"
	line "a wimp…"
	done
endc


HueyPhoneFullText:
if DEF(_FR_FR)
	text "Hé! Ton téléphone"
	line "est plein!"
	done
else
	text "Hey! Your phone's"
	line "already full!"
	done
endc


HueyRematchText:
if DEF(_FR_FR)
	text "Hé! J'en ai marre"
	line "de t'attendre!"
	done
else
	text "Hey! I'm tired of"
	line "waiting for you!"
	done
endc


HueyPackFullText:
if DEF(_FR_FR)
	text "Oh... Ton SAC est"
	line "plein. Je te le"
	cont "donnerai plus"
	cont "tard..."
	done
else
	text "Oh… Your PACK's"
	line "full. I'll give it"
	cont "to you later."
	done
endc


HueyRematchGiftText:
if DEF(_FR_FR)
	text "Fouiii! Tu es de"
	line "plus en plus"
	cont "fortiche!"
	
	para "Je te lance des"
	line "défis sans arrêt"
	
	para "mais tu gagnes à"
	line "chaque fois."
	
	para "J'ai acheté tout"
	line "plein de trucs"
	
	para "pour booster mes"
	line "#MON mais..."
	
	para "Les objets seuls"
	line "ne suffisent pas."
	
	para "Il doit y avoir"
	line "autre chose."
	
	para "Tiens, voilà pour"
	line "toi, <PLAYER>."
	
	para "Je n'en ai plus"
	line "besoin..."
	done
else
	text "Man! You're as"
	line "tough as ever!"
	
	para "I've battled you"
	line "over and over, but"
	
	para "<PLAYER>, I haven't"
	line "won once."
	
	para "I bought tons of"
	line "items to toughen"
	
	para "up my #MON, but"
	line "to no avail…"
	
	para "Items alone aren't"
	line "the answer."
	
	para "That must be what"
	line "it is…"
	
	para "Here, take this,"
	line "<PLAYER>."
	
	para "I won't be needing"
	line "it anymore…"
	done
endc
