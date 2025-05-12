MomPhoneGreetingText:
if DEF(_FR_FR)
	text "Bonjour?"
	
	para "Oh, salut,"
	line "<PLAYER>!"
	cont "Ca bosse dur?"
	done
else
	text "Hello?"
	
	para "Oh, hi, <PLAYER>!"
	line "Working hard?"
	done
endc


MomPhoneLandmarkText:
if DEF(_FR_FR)
	text "Oh, tu es vers"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Il y a"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "par-là, non?"
	done
else
	text "Oh, so you're in"
	line "@"
	text_ram wStringBuffer3
	text "…"
	
	para "Isn't that where"
	line "@"
	text_ram wStringBuffer4
	text_start
	para "is? Did you go"
	line "take a look?"
	done
endc


MomPhoneGenericAreaText:
if DEF(_FR_FR)
	text "Tu es vers"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "Je ne connais pas"
	line "ce coin. Tu as de"
	cont "la chance <PLAYER>."
	done
else
	text "Really, you're in"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "I've never gone"
	line "there. That's kind"
	cont "of neat, <PLAYER>."
	done
endc


MomPhoneNewBarkText:
if DEF(_FR_FR)
	text "Quoi? Tu es vers"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "Passe voir ta"
	line "maman des fois!"
	done
else
	text "What? You're in"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "Come see your MOM"
	line "sometime!"
	done
endc


MomPhoneCherrygroveText:
if DEF(_FR_FR)
	text "Coucou !"

	para "J'ai entendu à la"
	line "télé que le COVID"
	cont "se transmet par"
	cont "gouttelettes"
	cont "respiratoires."

	para "Sois prudent et"
	line "respecte la dis-"
	cont "tance sociale."
	done
else
	text "Hello!"
	
	para "I have heard on"
	line "TV that COVID is"
	cont "transmitted via"
	cont "respiratory"
	cont "droplets."
	
	para "Be careful and"
	line "respect social"
	cont "distancing."
	done
endc


MomOtherAreaText:
if DEF(_FR_FR)
	text "Oh! Tu es vers"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "Bonne chance pour"
	line "ta quête #MON!"
	done
else
	text "Wow, you're in"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "Good luck on your"
	line "#MON quest!"
	done
endc


MomDeterminedText:
if DEF(_FR_FR)
	text "Ca a l'air vrai-"
	line "ment coriace."
	
	para "Mais <PLAYER>, je"
	line "sais que tu as du"
	
	para "courage. Tout"
	line "ira bien, pas"
	cont "vrai?"
	done
else
	text "That sounds really"
	line "tough."
	
	para "But, <PLAYER>, I"
	line "know you're really"
	
	para "determined. You'll"
	line "be OK, right?"
	done
endc


MomCheckBalanceText:
if DEF(_FR_FR)
	text "Au fait, tu m'as"
	line "envoyé @"
	text_ram wStringBuffer3
	text "¥."

	para "Es-tu encore en"
	line "mesure de m'aider"
	cont "financièrement?"
	done
else
	text "By the way, you've"
	line "sent me ¥@"
	text_ram wStringBuffer3
	text "."
	
	para "Are you still"
	line "able to"
	cont "financially help"
	cont "me?"
	done
endc


MomImportantToSaveText:
if DEF(_FR_FR)
	text "L'argent que tu"
	line "envoies m'aide"
	cont "énormément."

	para "C'est toujours bon?"
	done
else
	text "Sending money"
	line "helps me a ton."
	
	para "Is it still ok?"
	done
endc


MomYoureNotSavingText:
if DEF(_FR_FR)
	text "Oh, <PLAYER>,"
	line "tu peux continuer"
	cont "à m'envoyer un peu"

	para "d'argent le temps"
	line "que je trouve un"
	cont "nouveau travail?"
	done
else
	text "Oh, <PLAYER>,"
	line "is it ok for you"
	cont "to send me money"
	
	para "until I can find"
	line "a new job?"
	done
endc


MomYouveSavedText:
if DEF(_FR_FR)
	text "Au fait, tu m'as"
	line "envoyé @"
	text_ram wStringBuffer3
	text "¥."

	para "Tu pourrais en"
	line "partager un peu"
	cont "avec moi?"
	done
else
	text "By the way, you've"
	line "sent me ¥@"
	text_ram wStringBuffer3
	text "."
	
	para "Could you share"
	line "some of the money"
	cont "you make with me?"
	done
endc


MomOKIllSaveText:
if DEF(_FR_FR)
	text "Merci! Ca va"
	line "beaucoup m'aider!"
	done
else
	text "Thanks! It will"
	line "help me a lot!"
	done
endc


MomPhoneWontSaveMoneyText:
if DEF(_FR_FR)
	text "OK. Je vais"
	line "essayer de me"
	cont "débrouiller avec"
	cont "mes économies."
	done
else
	text "OK. I'll try to"
	line "make do with my"
	cont "own savings."
	done
endc


MomPhoneHangUpText:
if DEF(_FR_FR)
	text "<PLAYER>, continue"
	line "comme ça! Je suis"
	cont "avec toi, poussin!"
	done
else
	text "<PLAYER>, keep it"
	line "up! I'm rooting"
	cont "for you, baby!"
	done
endc


MomPhoneNoPokemonText:
if DEF(_FR_FR)
	text "Allô?"
	
	para "Bonjour <PLAYER>!"
	line "Le PROF.ORME"
	cont "t'attend, non?"
	done
else
	text "Hello?"
	
	para "Oh, hi, <PLAYER>!"
	line "Wasn't PROF.ELM"
	cont "waiting for you?"
	done
endc


MomPhoneNoPokedexText:
if DEF(_FR_FR)
	text "Allô?"
	
	para "Bonjour <PLAYER>!"
	line "Le PROF.ORME"
	cont "compte sur toi!"
	cont "C'est bien!"
	done
else
	text "Hello?"
	
	para "Oh, hi, <PLAYER>!"
	line "You're on a big"
	
	para "mission for PROF."
	line "ELM? Be good!"
	done
endc


MomPhoneNoGymQuestText:
if DEF(_FR_FR)
	text "Allô?"
	
	para "Salut, <PLAYER>!"
	line "Si ta course est"
	
	para "finie, rentre à la"
	line "maison."
	done
else
	text "Hello?"
	
	para "Hi, <PLAYER>! If"
	line "you're done with"
	
	para "your errand come"
	line "on home, dear."
	done
endc


MomPhoneLectureText:
if DEF(_FR_FR)
	text "Allô?"

	para "... <PLAYER>?"
	line "Tu as la forme?"

	para "..."

	para "Tant mieux!"

	para "..."

	para "Écoute. Je ne sais"
	line "pas comment te le"
	cont "dire... J'ai une"
	cont "mauvaise nouvelle."

	para "Mon employeur"
	line "vient d'appeler."

	para "A cause de la si-"
	line "tuation sanitaire,"

	para "les frontières sont"
	line "désormais fermées."

	para "Mon entreprise n'a"
	line "pas d'autre choix"
	
	para "que de fermer et"
	line "me licencier."

	para "..."

	para "Je vais chercher"
	line "un nouveau emploi,"

	para "mais ça risque de"
	line "prendre du temps"

	para "vu les conditions"
	line "actuelles."

	para "Ca m'embête de"
	line "demander, mais"

	para "si tu pouvais"
	line "partager un petit"
	cont "peu de l'argent"
	cont "que tu gagnes,"

	para "ce serait très"
	line "généreux de ta"
	cont "part, <PLAYER>."

	para "Est-ce que"
	line "ça te va?"
	done
else
	text "Hello?"
	
	para "…… <PLAYER>?"
	line "Are you in good"
	cont "shape?"
	
	para "…"
	
	para "Good!"
	
	para "…"
	
	para "Listen. I don't"
	line "know how to tell"
	cont "you… I have bad"
	cont "news."
	
	para "My employer just"
	line "called me."
	
	para "Because of the"
	line "sanitary situation"
	
	para "borders are now"
	line "closed, which"
	
	para "forces the company"
	line "I work for to"
	
	para "shutdown and"
	line "lay me off."
	
	para "…"
	
	para "I will be looking"
	line "for a new job,"
	
	para "but it may take a"
	line "while to find one"
	
	para "in the current"
	line "circumstances."
	
	para "It bothers me to"
	line "ask, but"
	
	para "if you could share"
	line "with me a small"
	cont "amount of the"
	cont "money you make,"
	
	para "it would be very"
	line "generous of you,"
	cont "<PLAYER>."
	
	para "Is it ok?"
	done
endc


MomCurfewStartedText:
if DEF(_FR_FR)
	text "Salut, <PLAYER>!"
	line "Ils viennent"

	para "d'annoncer une"
	line "grande nouvelle à"
	
	para "la télé... Il faut"
	line "que tu saches!"

	para "Le confinement a"
	line "fonctionné, et les"
	cont "restrictions vont"
	cont "être allégées!"

	para "Désormais, la"
	line "nouvelle règle"
	cont "est le couvre-feu."

	para "Les gens peuvent"
	line "sortir en journée,"

	para "mais personne n'est"
	line "autorisé dehors"

	para "après la tombée"
	line "du soleil."

	para "Certains commerces"
	line "rouvriront le jour"
	cont "également!"

	para "Les déplacements à"
	line "longue distance"
	cont "restent interdits."

	para "Où que tu sois,"
	line "reste prudent."
	done
else
	text "Hi, <PLAYER>! They"
	line "just announced"
	
	para "great news on TV…"
	line "you need to know!"
	
	para "The quarantine at"
	line "home has been"
	
	para "effective, and the"
	line "restrictions can"
	cont "be relaxed!"
	
	para "From now on, the"
	line "new rule is the"
	cont "curfew."
	
	para "People are allowed"
	line "to go out during"
	cont "the day, but"
	
	para "no one is"
	line "allowed out"
	cont "after dark."
	
	para "Some establish-"
	line "ments will re-open"
	cont "during the day"
	cont "as well!"
	
	para "Long-distance"
	line "travel is still"
	cont "banned though."
	
	para "Wherever you are,"
	line "be safe."
	done
endc


MomLockdownStartedText:
if DEF(_FR_FR)
	text "<PLAYER> ! Tu as"
	line "entendu la"
	cont "nouvelle..."

	para "N'aie pas peur,"
	line "tout ira bien."

	para "Tu ne peux pas"
	line "poursuivre ton"
	cont "voyage, tu risques"
	cont "l'arrestation."

	para "Tu devrais rentrer"
	line "à la maison pour"
	cont "qu'on passe le"
	cont "confinement"
	cont "ensemble."

	para "Tu veux bien?"

	para "Quoi que tu fasses"
	line "je te soutiens"
	cont "pleinement."

	para "Je t'aime."
	done
else
	text "<PLAYER>! You've"
	line "heard the news…"
	
	para "Don't be scared,"
	line "it's gonna be"
	cont "all right."
	
	para "You cannot stay on"
	line "the road, you will"
	cont "get arrested."
	
	para "You should come"
	line "home so we can"
	cont "spend the lock-"
	cont "down together."
	
	para "Will you?"
	
	para "Whatever you do,"
	line "you know you have"
	cont "my full support."
	
	para "Love you."
	done
endc


MomVaccinePassportText:
if DEF(_FR_FR)
	text "Coucou mon sucre!"
	line "Ca fait longtemps!"

	para "J'espère que KANTO"
	line "est à la hauteur"
	cont "de tes espérances."

	para "Comme tu es à"
	line "l'étranger, tu as"
	cont "sûrement raté"
	cont "l'info..."

	para "On en a enfin"
	line "fini avec le"
	cont "couvre-feu!"

	para "On va utiliser le"
	line "PASS VACCINAL,"
	cont "comme à KANTO."

	para "J'espère que ça"
	line "m'aidera à trouver"
	cont "un nouvel emploi"
	cont "plus facilement."

	para "Un travail avec"
	line "un vrai sens."

	para "J'espère aussi que"
	line "ça te permettra de"
	cont "me rendre visite!"

	para "Bisous!"
	done
else
	text "Hi sweetie!"
	line "It's been a while!"
	
	para "I hope KANTO is"
	line "living up to your"
	cont "expectations."
	
	para "As you are abroad"
	line "you probably"
	cont "missed the news…"
	
	para "We are finally"
	line "done with the"
	cont "curfew!"
	
	para "We're moving on to"
	line "a VACCINE PASSPORT"
	cont "just like they do"
	cont "in KANTO."
	
	para "I hope it'll allow"
	line "me to find a new"
	cont "job soon."
	
	para "A job with a"
	line "noble purpose."
	
	para "I also hope this"
	line "will allow you to"
	cont "visit me soon!"
	
	para "Bye!"
	done
endc
