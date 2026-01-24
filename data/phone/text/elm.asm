ElmPhoneHealYourMonText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "Fais bien"
	line "attention..."
	
	para "Soigne bien tes"
	line "#MON s'ils sont"
	cont "blessés."
	done
else
	text "Hello, <PLAY_G>?"
	
	para "Try not to overdo"
	line "it."
	
	para "Be sure to heal"
	line "your #MON if"
	cont "they are hurt."
	done
endc


ElmPhoneSawMrPokemonText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "As-tu rencontré M."
	line "#MON? Super!"
	cont "Reviens vite!"
	done
else
	text "Hello, <PLAY_G>?"
	
	para "Did you meet MR."
	line "#MON? Great!"
	cont "Come back safely!"
	done
endc


ElmPhonePokemonStolenText:
if DEF(_FR_FR)
	text "<PLAY_G>? Je"
	line "suis bien triste."
	
	para "Un #MON nous"
	line "a été volé."
	
	para "Qui a bien pu"
	line "faire ça?"
	done
else
	text "<PLAY_G>? I'm very"
	line "upset now."
	
	para "We had a #MON"
	line "stolen from here."
	
	para "How could anyone"
	line "do that?"
	done
endc


ElmPhoneThanksSampleText:
if DEF(_FR_FR)
	text "Allô, <PLAY_G>?"

	para "J'avance beaucoup"
	line "dans ma recherche"
	cont "grâce à l'échan-"
	cont "tillon que tu"
	cont "m'as apporté."
	done
else
	text "Hello, <PLAY_G>?"

	para "I'm making a lot"
	line "of progress on my"
	cont "research thanks"
	cont "to OAK's sample"
	cont "you brought me."
	done
endc

ElmPhonePokerusMutationText:
if DEF(_FR_FR)
	text "Allô, <PLAY_G>?"

	para "Je viens de faire"
	line "une découverte."

	para "J'ai confirmé que"
	line "le virus du COVID"
	cont "est une mutation"
	cont "du POKéRUS, le"
	cont "virus #MON."
	done
else
	text "Hello, <PLAY_G>?"

	para "I just made a new"
	line "discovery."

	para "I confirmed the"
	line "virus that gives"
	cont "COVID is a mutated"
	cont "version of the"
	cont "POKéRUS, the"
	cont "#MON virus."
	done
endc

ElmPhoneBallsPermeableToVirusText:
if DEF(_FR_FR)
	text "Allô, <PLAY_G>?"

	para "J'ai étudié la"
	line "résistance d'une"
	cont "#BALL face au"
	cont "virus."

	para "Mes résultats"
	line "montrent qu'une"
	cont "#BALL est"
	cont "100<PERCENT> imperméable"
	cont "au virus."

	para "Un #MON gardé"
	line "dedans ne peut"
	cont "ni attraper, ni"
	cont "transmettre le"
	cont "virus."

	para "Bon à savoir,"
	line "pas vrai?"
	done
else
	text "Hello, <PLAY_G>?"

	para "I studied the"
	line "resistance of a"
	cont "#BALL against"
	cont "the virus."

	para "My results show"
	line "that a #BALL is"
	cont "fully impermeable"
	cont "to the virus."

	para "A #MON that"
	line "stays within it"
	cont "can neither catch"
	cont "nor spread the"
	cont "virus."

	para "Good to know,"
	line "right?"
	done
endc

ElmPhoneDiscoveredPokerusText:
if DEF(_FR_FR)
	text "Salut <PLAY_G>."

	para "Le CENTRE #MON"
	line "m'a appelé au sujet"
	cont "de ton #MON"
	cont "infecté."

	para "C'est un sujet"
	line "à ne pas prendre"
	cont "à la légère."

	para "Le COVID est"
	line "dangereux et se"
	cont "propage vite."

	para "J'ai récemment"
	line "fait une"
	cont "découverte qui"
	cont "te sera utile:"
	
	para "le virus persiste"
	line "dans l'air pendant"
	cont "plusieurs minutes."

	para "N'envoie pas un"
	line "#MON infecté"
	cont "au combat!"

	para "Il pourrait conta-"
	line "miner ceux qui"
	cont "passent après lui."

	para "Je sais que tu"
	line "vas gérer!"

	para "Prends soin"
	line "de toi!"
	done
else
	text "Hello <PLAY_G>."

	para "The #MON CENTER"
	line "called about your"
	cont "infected #MON."

	para "It is a matter"
	line "you should not"
	cont "underestimate."

	para "COVID is dangerous"
	line "and spreads fast."

	para "I recently made"
	line "a discovery that"

	para "can help you go"
	line "through this: the"

	para "virus can float"
	line "in the air for a"
	cont "few minutes."

	para "Don't send your"
	line "infected #MON"
	cont "to battle!"

	para "It could infect"
	line "#MONs sent to"
	cont "battle afterwards."

	para "I'm sure you can"
	line "handle it!"

	para "Take care!"
	done
endc

ElmPhoneDisasterText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	line "C'est..."
	cont "C'est terrible!"
	
	para "C'est..."
	line "AFFREUX!"
	
	para "Que faire?"
	line "Oh, non..."
	
	para "Reviens vite!"
	done
else
	text "H-hello? <PLAY_G>?"
	line "It's a disaster!"
	
	para "Uh, um, it's just"
	line "terrible!"
	
	para "What should I do?"
	line "It… Oh, no…"
	
	para "Please get back"
	line "here now!"
	done
endc


ElmPhonePokemaskBeforeText:
if DEF(_FR_FR)
	text "<PLAY_G>!"
	line "Tout va bien?"

	para "Tu viens juste"
	line "d'arriver à"
	cont "OLIVILLE?"

	para "Sacrée"
	line "coïncidence!"

	para "Je t'appelle car"
	line "j'attends une"

	para "livraison de la"
	line "SYLPHE SARL."

	para "La grande société"
	line "basée à KANTO,"
	cont "tu vois?"

	para "Mon colis est"
	line "retenu à la"
	cont "douane du PORT."

	para "Puisque tu es sur"
	line "place, tu peux"
	
	para "le récupérer pour"
	line "moi stp?"

	para "A très vite!"
	done
else
	text "<PLAY_G>!"
	line "Doing good?"

	para "You've just rea-"
	line "ched OLIVINE CITY?"

	para "What a"
	line "coincidence!"

	para "I'm calling because"
	line "I've been waiting"

	para "for a delivery"
	line "from SILPH CO."

	para "You know, the big"
	line "company based in"
	cont "KANTO?"

	para "Apparently my"
	line "parcel is being"

	para "held by the"
	line "customs in"
	cont "OLIVINE PORT."

	para "Since you're there"
	line "could you grab it"
	cont "for me?"

	para "See you soon!"
	done
endc

ElmPhonePokemaskAfterText:
if DEF(_FR_FR)
	text "Salut <PLAY_G>,"
	line "c'est encore moi."

	para "J'ai reçu un texto"
	line "disant que tu as"
	cont "récupéré le colis."

	para "Cet objet s'appelle"
	line "un #MASQUE."

	para "C'est un prototype"
	line "de la SYLPHE SARL"

	para "qui a coûté des"
	line "millions à créer."

	para "C'est un masque"
	line "fabriqué d'un tissu"
	cont "haute-technologie,"
	cont "qui se plie comme"
	cont "un origami, pour"

	para "s'adapter à la"
	line "bouche et au nez"
	cont "de n'importe quel"
	cont "#MON!"

	para "Il protège le"
	line "porteur des virus"
	cont "et des spores."

	para "Et le tissu est"
	line "auto-nettoyant."

	para "J'ai été désigné" 
	line "pour le tester"
	cont "sur le terrain."

	para "Comme je suis"
	line "coincé au labo,"
	cont "je comptais te"
	cont "le confier."

	para "C'est précieux et"
	line "fragile, fais-y"
	cont "attention."

	para "Je file. Merci"
	line "pour ton aide!"
	done
else
	text "Hi <PLAY_G>, it's"
	line "me again."

	para "I just received a"
	line "text confirming"
	cont "you got the"
	cont "package."

	para "This item is"
	line "called a #MASK."

	para "It's a prototype"
	line "from SILPH CO."

	para "that cost millions"
	line "to develop."

	para "It is a high-tech"
	line "face mask that"
	cont "uses a smart-"
	cont "fabric that folds"
	cont "like an origami,"

	para "to fit itself onto"
	line "the mouth and nose"
	cont "of any #MON!"

	para "The wearer is pro-"
	line "tected from vi-"
	cont "ruses and spores."

	para "Also, the fabric"
	line "is self cleaning."

	para "I've been assigned"
	line "to test it on the"
	cont "field."

	para "As I'm stuck in my"
	line "lab, you guessed"
	cont "it, I was going"
	cont "to give it to you."

	para "It's very expensive"
	line "and fragile, so"
	cont "be cautious."

	para "Gotta go. Thanks"
	line "for your help!"
	done
endc

ElmPhoneRadioTowerRocketTakeoverText:
if DEF(_FR_FR)
	text "<PLAY_G>, comment"
	line "ça va bien?"
	
	para "Je t'appelle à"
	line "propos des émis-"
	
	para "sions radio."
	line "Quelque chose ne"
	cont "va pas."
	
	para "Elles parlent de"
	line "la TEAM ROCKET."
	
	para "<PLAY_G>, es-tu"
	line "au courant de"
	cont "tout ceci?"
	
	para "La TEAM ROCKET est"
	line "peut-être de"
	cont "retour."
	
	para "Ca paraît dingue,"
	line "quand même!"
	done
else
	text "<PLAY_G>, how are"
	line "things going?"
	
	para "I called because"
	line "something weird is"
	
	para "happening with the"
	line "radio broadcasts."
	
	para "They were talking"
	line "about TEAM ROCKET."
	
	para "<PLAY_G>, do you"
	line "know anything"
	cont "about it?"
	
	para "Maybe TEAM ROCKET"
	line "has returned. No,"
	
	para "that just can't"
	line "be true."
	
	para "Sorry to bug you."
	line "Take care!"
	done
endc


ElmPhoneGiftText:
if DEF(_FR_FR)
	text "<PLAY_G>?"
	
	para "J'ai quelque chose"
	line "pour toi."
	
	para "Tu peux passer"
	line "au LABO?"
	
	para "A bientôt!"
	done
else
	text "Hello, <PLAY_G>?"
	
	para "I have something"
	line "here for you."
	
	para "Could you swing by"
	line "my LAB?"
	
	para "See you later!"
	done
endc


ElmPhoneQuickCallText:
if DEF(_FR_FR)
	text "Hey <PLAYER>."
	line "Faut qu'on parle."

	para "Tu sais où me"
	line "trouver."
	done
else
	text "Hey <PLAYER>."
	line "We have to talk."

	para "You know where"
	line "to find me."
	done
endc


ElmPhoneSomethingToTellText:
if DEF(_FR_FR)
	text "Allô, <PLAY_G>?"

	para "Je dois te dire"
	line "quelque chose"
	cont "d'important."

	para "Viens me voir au"
	line "LABO je te prie."
	done
else
	text "Hello, <PLAY_G>?"

	para "There is something"
	line "important I need"
	cont "to tell you."

	para "Come see me in"
	line "my LAB, will you?"
	done
endc


ElmPhoneHospital1Text:
if DEF(_FR_FR)
	text "Salut <PLAY_G>."
	line "Tu es près de"

	para "l'HOPITAL NATIONAL"
	line "de DOUBLONVILLE?"

	para "C'est ma collègue"
	line "et amie proche,"

	para "l'INFIRMIERE EN"
	line "CHEF JOELLE, qui"
	cont "le dirige!"

	para "D'une certaine ma-"
	line "nière, elle prend"
	cont "soin de #MON,"

	para "tout comme ses"
	line "parents le font"
	cont "à la PENSION,"

	para "mais à plus"
	line "grande échelle."

	para "Sa fille n'a pas"
	line "choisi la même"

	para "voie, mais elle a"
	line "les mêmes goûts"

	para "en #MON que sa"
	line "mère haha!"
	done
else
	text "Hello <PLAY_G>."
	line "You are close by"
	
	para "GOLDENROD NATIONAL"
	line "HOSPITAL?"
	
	para "It is my colleague"
	line "and good friend"
	
	para "CHIEF NURSE JOY"
	line "who runs it!"
	
	para "In a way, she's"
	line "taking care of"
	
	para "#MON just like"
	line "her parents do at"
	
	para "the DAY CARE, but"
	line "at a larger scale."
	
	para "Her daughter didn't"
	line "follow the same"
	
	para "path, but she's got"
	line "the same taste in"
	
	para "#MON as her"
	line "mother haha!"
	done
endc


ElmPhoneHospital2Text:
if DEF(_FR_FR)
	text "Quoi qu'il en soit,"
	line "si le patient zéro"

	para "était dans son"
	line "hôpital, elle"
	cont "m'aurait prévenu."
	done
else
	text "Anyway, if patient"
	line "zero was in her"

	para "hospital, she"
	line "would've told me."
	done
endc

ElmPhoneSayHiToHerText:
if DEF(_FR_FR)
	text "Passe-lui le"
	line "bonjour de ma"
	cont "part, veux-tu?"
	done
else
	text "Say hi to her for"
	line "me, will you?"
	done
endc

ElmPhoneMeetMeText:
if DEF(_FR_FR)
	text "Bonjour, <PLAY_G>."

	para "Viens me voir"
	line "au labo."
	done
else
	text "Hello, <PLAY_G>."

	para "Come meet me"
	line "at the lab."
	done
endc

ElmPhoneEncourageFirstShotText:
if DEF(_FR_FR)
	text "Salut <PLAYER>!"
	line "Alors, tu as"

	para "décidé si tu"
	line "veux te faire"
	
	para "vacciner par l'"
	line "INFIRMIERE JOELLE?"
	
	para "Tu me diras!"
	done
else
	text "Hi <PLAYER>!"
	line "Have you decided"

	para "if you want to get"
	line "vaccinated by"

	para "CHIEF NURSE JOY?"
	line "Let me know."
	done
endc

ElmPhoneKantoText:
if DEF(_FR_FR)
	text "Oh salut <PLAYER>!"

	para "Le PROF.CHEN a"
	line "dit que tu étais"
	cont "arrivé à KANTO."

	para "C'est de moins en"
	line "moins important,"
	cont "mais..."

	para "Tu penses trouver"
	line "le patient zéro"
	cont "là-bas?"

	para "Je reste curieux."
	line "Tiens-moi au"
	cont "courant!"
	done
else
	text "Oh hi <PLAYER>!"

	para "PROF.OAK said you"
	line "arrived in KANTO."

	para "It matters less"
	line "and less, but…"

	para "Any luck finding"
	line "patient zero over"

	para "there? I'm still"
	line "curious. Keep me"
	cont "informed!"
	done
endc

ElmEmergencyPokeballDeliveryText:
if DEF(_FR_FR)
	text "Salut <PLAYER>."
	line "Tu sembles être en"
	cont "mauvaise posture."

	para "Je ne vais pas"
	line "te laisser tomber."

	para "Je t'envoie une"
	line "#BALL."
	done
else
	text "Hello <PLAYER>."
	line "You seem to be in"
	cont "a dire situation."

	para "I can't let"
	line "you down."

	para "I'm sending you"
	line "1 #BALL."
	done
endc