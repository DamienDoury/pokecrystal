ChadObservingWildText:
if DEF(_FR_FR)
	text "J'observe les"
	line "@"
	text_ram wStringBuffer4
	text_start
	cont "sauvages."
	
	para "De cette manière,"
	line "j'ai appris tout"
	cont "plein de trucs."
	
	para "Je veux être un"
	line "chercheur #MON"
	cont "comme le PROF."
	cont "CHEN."
	done
else
	text "I recently began"
	line "observing wild"
	cont "@"
	text_ram wStringBuffer4
	text "."
	
	para "I've been learning"
	line "all sorts of new"
	
	para "things through my"
	line "observations."
	
	para "I wish I could"
	line "become a #MON"
	
	para "researcher like"
	line "PROF.OAK soon."
	done
endc


ChadDefeatedMonText:
if DEF(_FR_FR)
	text "J'ai réussi à"
	line "battre un"
	cont "@"
	text_ram wStringBuffer4
	text_start
	cont "sauvage."
	
	para "Vu que j'étudie"
	line "comme un fou,"
	cont "c'est normal."
	done
else
	text "Oh yes, I managed"
	line "to knock out a"
	
	para "wild @"
	text_ram wStringBuffer4
	text " a"
	line "while back."
	
	para "Well, considering"
	line "all the studying I"
	
	para "do every day, it"
	line "was inevitable."
	done
endc


ChadLostAMonText:
if DEF(_FR_FR)
	text "J'ai failli attra-"
	line "per un @"
	text_ram wStringBuffer4
	text ","
	cont "mais il est parti."
	
	para "J'ai toujours"
	line "voulu observer"
	cont "un @"
	text_ram wStringBuffer4
	text "."
	done
else
	text "Oh yes, I came"
	line "close to catching"
	
	para "a wild @"
	text_ram wStringBuffer4
	text ","
	line "but it got away."
	
	para "For the longest"
	line "time, I've been"
	
	para "wanting to observe"
	line "@"
	text_ram wStringBuffer4
	text ". Rats…"
	done
endc


ChadBattleRematchText:
if DEF(_FR_FR)
	text "Un combat?"
	line "S'entraîner, c'est"
	cont "la santé."
	
	para "Je suis vers"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
else
	text "Want to battle?"
	line "I have to battle"
	
	para "every so often to"
	line "avoid rusting out."
	
	para "I'll be on"
	line "@"
	text_ram wStringBuffer5
	text "!"
	done
endc


ChadHangUpText:
if DEF(_FR_FR)
	text "A plus tard!"
	done
else
	text "See you later!"
	done
endc


ChadBlueGossipText:
if DEF(_FR_FR)
	text "Tu connais BLUE?"
	
	para "Il est le petit-"
	line "fils du PROF.CHEN"
	
	para "et un ancien"
	line "MAITRE de LIGUE!"
	
	para "C'est un sacré"
	line "dresseur!"
	done
else
	text "Do you know BLUE?"
	
	para "He's PROF.OAK's"
	line "grandson and a"
	
	para "former #MON"
	line "LEAGUE CHAMPION!"
	
	para "He's one super"
	line "#MON trainer!"
	done
endc


ChadDaisyGossipText:
if DEF(_FR_FR)
	text "La petite-fille du"
	line "PROF.CHEN s'appel-"
	cont "le NINA."
	
	para "Elle a le pouvoir"
	line "de calmer même"
	
	para "les #MON les"
	line "plus féroces."
	done
else
	text "PROF.OAK has a"
	line "granddaughter"
	cont "named DAISY."
	
	para "When she's around,"
	line "even the most"
	
	para "ferocious #MON"
	line "calm right down."
	done
endc


ChadProfElmGossipText:
if DEF(_FR_FR)
	text "Tout le monde"
	line "parle du PROF."
	cont "ORME."
	
	para "Il était"
	line "l'assistant du"
	cont "PROF.CHEN!"
	
	para "C'est trop cool!"
	line "Je l'envie!"
	done
else
	text "Everyone's talking"
	line "about PROF.ELM."
	
	para "He used to be an"
	line "assistant to the"
	cont "great PROF.OAK!"
	
	para "That is so cool!"
	line "I envy him!"
	done
endc


ChadProfOaksDreamGossipText:
if DEF(_FR_FR)
	text "Le rêve du"
	line "PROF.CHEN est"
	
	para "d'avoir un"
	line "#DEX complet."
	
	para "Je t'envie de"
	line "faire partie de ce"
	cont "projet..."
	done
else
	text "PROF.OAK's dream"
	line "is to compile a"
	
	para "comprehensive"
	line "#DEX."
	
	para "I envy you for"
	line "taking part in"
	cont "that project…"
	done
endc


ChadKurtGossipText:
if DEF(_FR_FR)
	text "Tu connais FARGAS,"
	line "le créateur de"
	cont "BALLS?"
	
	para "Il connaît le"
	line "PROF.CHEN depuis"
	cont "longtemps."
	
	para "Les grands esprits"
	line "se rencontrent!"
	done
else
	text "Do you know KURT,"
	line "the BALL creator?"
	
	para "He and PROF.OAK go"
	line "back a long way."
	
	para "I guess great"
	line "people attract one"
	cont "another!"
	done
endc


ChadLeagueGossipText:
if DEF(_FR_FR)
	text "La LIGUE #MON"
	line "est le centre le"
	cont "plus visité par"
	
	para "des dresseurs en"
	line "quête de victoire."
	
	para "Le PROF.CHEN est"
	line "un consultant aux"
	
	para "quartiers généraux"
	line "de la LIGUE."
	
	para "Il est si"
	line "merveilleux."
	done
else
	text "#MON LEAGUE is"
	line "the great gather-"
	cont "ing place for all"
	
	para "trainers who wish"
	line "to become CHAMP."
	
	para "PROF.OAK acts as"
	line "an advisor to the"
	
	para "#MON LEAGUE's"
	line "headquarters."
	
	para "He really is a"
	line "great man."
	done
endc


ChadPokemonTalkGossipText:
if DEF(_FR_FR)
	text "La CHRONIQUE"
	line "#MON du PROF."
	cont "CHEN est une"
	cont "émission de radio,"
	cont "d'accord?"
	
	para "Tu savais que"
	line "cette émission ne"
	
	para "pouvait pas passer"
	line "à l'antenne?"
	
	para "Mais LULA a été si"
	line "persuasive que la"
	cont "direction a"
	cont "accepté."
	
	para "Remercions tous"
	line "LULA!"
	done
else
	text "PROF.OAK'S #MON"
	line "TALK is a popular"
	cont "radio show, right?"
	
	para "Did you know that"
	line "he was going to"
	
	para "turn down the show"
	line "at first?"
	
	para "But MARY's energy"
	line "and persistence"
	cont "wore him down."
	
	para "So we have MARY to"
	line "thank for it!"
	done
endc


ChadProfOakTrainerGossipText:
if DEF(_FR_FR)
	text "Le PROF.CHEN"
	line "était un dresseur"
	cont "il y a longtemps."
	
	para "Mais il n'était"
	line "pas très porté sur"
	cont "les combats."
	
	para "Il a alors arrêté"
	line "son entraînement"
	
	para "pour devenir un"
	line "chercheur."
	done
else
	text "PROF.OAK used to"
	line "be a trainer a"
	cont "long time ago."
	
	para "But rather than"
	line "battling, he found"
	
	para "#MON themselves"
	line "to be interesting."
	
	para "So he abandoned"
	line "his training to"
	
	para "focus on becoming"
	line "a researcher."
	done
endc


ChadDaisyTeaGossipText:
if DEF(_FR_FR)
	text "Le PROF.CHEN a une"
	line "petite-fille du"
	cont "nom de NINA."
	
	para "Elle aime boire du"
	line "thé vers 3 heures"
	cont "de l'après-midi."
	
	para "J'aimerais être"
	line "de la fête et"
	
	para "parler avec le"
	line "PROF.CHEN."
	done
else
	text "PROF.OAK has a"
	line "granddaughter"
	cont "named DAISY."
	
	para "She has tea every"
	line "day for an hour"
	
	para "from three in the"
	line "afternoon."
	
	para "I wish I could"
	line "join her for tea"
	
	para "and chat about"
	line "PROF.OAK."
	done
endc


ChadProfOakTravelingGossipText:
if DEF(_FR_FR)
	text "Le savais-tu?"
	line "Le PROF.CHEN a"
	
	para "fait le tour du"
	line "monde étant jeune."
	
	para "Il a dû en appren-"
	line "dre beaucoup sur"
	cont "les #MON."
	
	para "Comme je l'envie!"
	done
else
	text "Did you know?"
	line "PROF.OAK traveled"
	
	para "all over the world"
	line "when he was young."
	
	para "While traveling,"
	line "he must've learned"
	
	para "about #MON"
	line "naturally."
	
	para "I envy him…"
	line "I'd like to travel"
	
	para "and learn about"
	line "things too…"
	done
endc


ChadGoingToStudyHardText:
if DEF(_FR_FR)
	text "Je vais étudier"
	line "pour devenir"
	
	para "l'assistant du"
	line "PROF.CHEN!"
	done
else
	text "I'm going to study"
	line "hard so PROF.OAK"
	
	para "will make me his"
	line "assistant!"
	done
endc


ChadReminderText:
if DEF(_FR_FR)
	text "Tu te souviens de"
	line "notre combat?"
	
	para "C'était vers"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Viens vite!"
	line "Je t'attends."
	done
else
	text "Do you remember"
	line "about our battle?"
	
	para "The place is"
	line "@"
	text_ram wStringBuffer5
	text "."
	
	para "Hurry over--I'm"
	line "waiting."
	done
endc
