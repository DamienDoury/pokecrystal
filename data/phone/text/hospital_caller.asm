HospitalPhoneRecoverText:
if DEF(_FR_FR)
	text "Bonjour <PLAY_G>."
	line "Bonne nouvelle!"

	para "Nous avons réussi"
	line "à sauver certains"
	cont "de tes #MON!"
	
	para "Ils t'attendent"
	line "impatiemment."

	para "Tu peux venir les"
	line "récupérer dès"
	cont "maintenant à"
	cont "l'HOPITAL NATIONAL"
	cont "de DOUBLONVILLE."

	para "A très bientôt."
	done
else
	text "Hello <PLAY_G>."
	line "Good news!"

	para "We were able to"
	line "save some of your"
	cont "#MON!"
	
	para "They are waiting"
	line "for you."

	para "You can come and"
	line "get them now at"
	cont "GOLDENROD NATIONAL"
	cont "HOSPITAL."

	para "See you soon."
	done
endc


HospitalPhoneReleaseText:
if DEF(_FR_FR)
	text "Bonjour <PLAY_G>."

	para "Certains de tes"
	line "#MON attendent"
	cont "depuis un moment"
	cont "que tu viennes"
	cont "les chercher à"
	cont "l'HOPITAL NATIONAL"
	cont "de DOUBLONVILLE."

	para "Nous manquons de"
	line "lits et nous"
	cont "DEVONS libérer"
	cont "des chambres."

	para "Si tu ne viens"
	line "pas les récupérer,"
	cont "nous serons forcés"
	cont "de les relâcher."

	para "Je dois y aller."
	line "Viens vite!"
	done
else
	text "Hello <PLAY_G>."

	para "Some of your"
	line "#MON have been"
	cont "waiting for you to"
	cont "pick them up at"
	cont "GOLDENROD NATIONAL"
	cont "HOSPITAL for quite"
	cont "some time."

	para "We don't have"
	line "enough beds for"
	cont "everyone and we"
	cont "NEED to free up"
	cont "some rooms."

	para "If you are not"
	line "coming to take out"
	cont "your #MON, we"
	cont "will be forced to"
	cont "release them."

	para "I gotta go. Please"
	line "come quickly!"
	done
endc


HospitalSecondShotAvailableText:
if DEF(_FR_FR)
	text "Salut CHAMPION!"
	line "Info importante."

	para "De nouvelles"
	line "études ont montré"
	
	para "qu'une seule dose"
	line "de vaccin ne"

	para "suffit pas à"
	line "offrir une protec-"
	cont "tion durable."

	para "Bientôt, une dose"
	line "de rappel sera"
	cont "obligatoire."

	para "Sans elle, ton"
	line "PASS VACCINAL"

	para "sera considéré"
	line "comme expiré et"
	cont "invalide."

	para "Je suis prêt à"
	line "t'injecter."

	para "Promis, pas de"
	line "médias cette fois!"

	para "Viens vite me voir!"
	done
else
	text "Hi CHAMP!"
	line "Here's a heads up."

	para "New studies have"
	line "shown that a"

	para "single vaccine"
	line "dose doesn't"

	para "provide long"
	line "term protection."

	para "Soon, a booster"
	line "dose will be"
	cont "required."

	para "If you don't take"
	line "it, your VACCINE"
	
	para "PASSPORT will be"
	line "considered expired"
	cont "and invalidated."

	para "I'm ready to do"
	line "the injection."

	para "No media this"
	line "time, I promise!"

	para "Come see me soon!"
	done
endc