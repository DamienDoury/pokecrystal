TVShow:
	; opentext
	; writetext .Phase1Even1Text
	; waitbutton

	; writetext .Phase1Even2Text
	; waitbutton

	; writetext .Phase1Even3Text
	; waitbutton

	; writetext .Phase1Odd1Text
	; waitbutton

	; writetext .Phase1Odd2Text
	; waitbutton

	; writetext .Phase1Odd3Text
	; waitbutton

	; writetext .Phase2Even1Text
	; waitbutton

	; writetext .Phase2Even2Text
	; waitbutton

	; writetext .Phase2Even3Text
	; waitbutton

	; writetext .Phase2Odd1Text
	; waitbutton

	; writetext .Phase2Odd2Text
	; waitbutton

	; farwritetext TV_FirstCovidShowText
	; waitbutton

	; writetext .Phase3Even1Text
	; waitbutton

	; writetext .Phase3Even2Text
	; waitbutton

	; writetext .Phase3Even3Text
	; waitbutton

	; writetext .Phase3Odd1Text
	; waitbutton

	; writetext .Phase3Odd2Text
	; waitbutton

	; writetext .Phase3Odd3Text
	; waitbutton

	; writetext .Phase4Even1Text
	; waitbutton

	; writetext .Phase4Even2Text
	; waitbutton

	; writetext .Phase4Even3Text
	; waitbutton

	; writetext .Phase4Odd1Text
	; waitbutton

	; writetext .Phase4Odd2Text
	; waitbutton

	; writetext .Phase4Odd3Text
	; waitbutton


	; writetext .Phase5Even1Text
	; waitbutton

	; writetext .Phase5Even2Text
	; waitbutton

	; writetext .Phase5Even3Text
	; waitbutton

	; writetext .Phase5Odd1Text
	; waitbutton

	; writetext .Phase5Odd2Text
	; waitbutton

	; writetext .Phase5Odd3Text
	; waitbutton

	; farwritetext Phase6Even3Text
	; waitbutton

	; writetext .Phase6Odd2Text
	; waitbutton

	; closetext
	; end

	checkevent EVENT_RED_BEATEN
	iffalse .Phase6
	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iffalse .Phase5
	readvar VAR_BADGES
	ifgreater 6, .Phase4
	readvar VAR_BADGES
	ifgreater 4, .Phase3
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iftrue .Phase2
	checkevent EVENT_GOT_HM01_CUT
	iftrue .FirstLockdownDeclaration
	sjump .Phase1

.Phase1:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .TV_FirstCovidShow
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Phase1OddDays
	ifequal WEDNESDAY, .Phase1OddDays
	ifequal FRIDAY, .Phase1OddDays
	ifequal SUNDAY, .Phase1OddDays
; Phase 1 even days.
	checktime MORN
	iftrue .Phase1Even1
	checktime DAY
	iftrue .Phase1Even2
	checktime NITE
	iftrue .Phase1Even3

.Phase1OddDays:
	checktime MORN
	iftrue .Phase1Odd1
	checktime DAY
	iftrue .Phase1Odd2
	checktime NITE
	iftrue .Phase1Odd3
	farjumptext TVText

.FirstLockdownDeclaration:
	farjumptext _FirstLockdownDeclarationText

.Phase2:
	readvar VAR_HOUR
	ifodd .Phase2OddHours
; Phase 2 even hours.
	checktime MORN
	iftrue .Phase2Even1
	checktime DAY
	iftrue .Phase2Even2
	checktime NITE
	iftrue .Phase2Even3

.Phase2OddHours:
	checktime MORN
	iftrue .Phase2Odd1
	checktime DAY
	iftrue .Phase2Odd1
	checktime NITE
	iftrue .Phase2Odd2
	farjumptext TVText

.Phase3:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Phase3OddDays
	ifequal WEDNESDAY, .Phase3OddDays
	ifequal FRIDAY, .Phase3OddDays
	ifequal SUNDAY, .Phase3OddDays
; Phase 3 even days.
	checktime MORN
	iftrue .Phase3Even1
	checktime DAY
	iftrue .Phase3Even2
	checktime NITE
	iftrue .Phase3Even3

.Phase3OddDays:
	checktime MORN
	iftrue .Phase3Odd1
	checktime DAY
	iftrue .Phase3Odd2
	checktime NITE
	iftrue .Phase3Odd3
	farjumptext TVText

.Phase4:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Phase4OddDays
	ifequal WEDNESDAY, .Phase4OddDays
	ifequal FRIDAY, .Phase4OddDays
	ifequal SUNDAY, .Phase4OddDays
; Phase 4 even days.
	checktime MORN
	iftrue .Phase4Even1
	checktime DAY
	iftrue .Phase4Even2
	checktime NITE
	iftrue .Phase4Even3

.Phase4OddDays:
	checktime MORN
	iftrue .Phase4Odd1
	checktime DAY
	iftrue .Phase4Odd2
	checktime NITE
	iftrue .Phase4Odd3
	farjumptext TVText

.Phase5:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Phase5OddDays
	ifequal WEDNESDAY, .Phase5OddDays
	ifequal FRIDAY, .Phase5OddDays
	ifequal SUNDAY, .Phase5OddDays
; Phase 5 even days.
	checktime MORN
	iftrue .Phase5Even1
	checktime DAY
	iftrue .Phase5Even2
	checktime NITE
	iftrue .Phase5Even3

.Phase5OddDays:
	checktime MORN
	iftrue .Phase5Odd1
	checktime DAY
	iftrue .Phase5Odd2
	checktime NITE
	iftrue .Phase5Odd3
	farjumptext TVText

.Phase6:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Phase6OddDays
	ifequal WEDNESDAY, .Phase6OddDays
	ifequal FRIDAY, .Phase6OddDays
	ifequal SUNDAY, .Phase6OddDays
; Phase 6 even days.
	checktime MORN
	iftrue .Phase6Even3
	checktime DAY
	iftrue .Phase6Even3
	checktime NITE
	iftrue .Phase6Even3

.Phase6OddDays:
	checktime MORN
	iftrue .Phase6Odd2
	checktime DAY
	iftrue .Phase6Odd2
	checktime NITE
	iftrue .Phase6Odd2
	farjumptext TVText














.Phase1Odd1:
	jumptext .Phase1Odd1Text

.Phase1Odd1Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "Dans une autre"
	line "région, pour"
	cont "ralentir l'épidé-"
	cont "mie, les hommes et"
	cont "les femmes ne sont"
	cont "pas autorisés à"
	cont "sortir le même"
	cont "jour de la"
	cont "semaine."

	para "Cela me fait"
	line "me demander..."

	para "Les personnes"
	line "non binaires"
	cont "peuvent-elles"
	cont "sortir chaque"
	cont "jour ou bien"
	cont "jamais?"
	done
else
	text "INTERNATIONAL"

	para "In another region,"
	line "to slow down the"
	cont "epidemic, men and"
	cont "women are not"
	cont "allowed to go"
	cont "outside on the"
	cont "same day of the"
	cont "week."

	para "This makes we"
	line "wonder…"

	para "Are non-binary"
	line "people allowed to"
	cont "go outside every-"
	cont "day or are they"
	cont "locked inside all"
	cont "the time?"
	done
endc


.Phase1Odd2:
	jumptext .Phase1Odd2Text

.Phase1Odd2Text:
if DEF(_FR_FR)
	text "ITW POLITIQUE"

	para "“Notre pays est"
	line "parfaitement pré-"
	cont "paré à faire face"
	cont "à une épidémie."

	para "Ce virus ne nous"
	line "atteindra pas."

	para "Dans trois mois"
	line "tout sera"
	cont "derrière nous.” -"

	para "annonce le chef"
	line "politique d'une"
	cont "autre région."
	done
else
	text "POLITICAL ITW"

	para "“Our region is"
	line "very much prepared"
	cont "against epidemics,"
	cont "and this virus"
	cont "won't affect us."

	para "In 3 months time"
	line "it will be"
	cont "behind us.” -"

	para "says the leader"
	line "of another region."
	done
endc


.Phase1Odd3:
	jumptext .Phase1Odd3Text

.Phase1Odd3Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“En tant que"
	line "président, je vous"
	cont "encourage à vivre"
	cont "et sortir comme"
	cont "avant."

	para "Nous sommes un"
	line "peuple fort et"
	cont "fier. Ce"
	cont "virus ne nous"
	cont "affectera pas.”"

	para "..."

	para "Ce président doit"
	line "être le genre de"
	cont "personne qui pense"
	cont "qu'on peut battre"
	cont "un virus en le"
	cont "frappant avec ses"
	cont "poings..."
	done
else
	text "INTERNATIONAL"

	para "“As the president"
	line "of this region, I"
	cont "encourage people"
	cont "to keep going out"
	cont "& live as before."

	para "We are a strong"
	line "and proud"
	cont "population, and"
	cont "this virus won't"
	cont "affect us.”"

	para "…"

	para "This president"
	line "must also think"
	
	para "that the best way"
	line "to fight a virus"
	
	para "is to punch it in"
	line "the face."
	done
endc


.Phase1Even1:
	jumptext .Phase1Even1Text

.Phase1Even1Text:
if DEF(_FR_FR)
	text "ITW POLITIQUE"

	para "“Les masques ne"
	line "sont pas néces-"
	cont "saires pour tout"
	cont "le monde."

	para "Et vous savez"
	line "quoi? Moi je sais"
	cont "pas utiliser un"
	cont "masque."

	para "J'pourrais dire"
	line "“Je suis ministre"
	cont "j'me mets un"
	cont "masque” mais"
	cont "en fait je sais"
	cont "pas l'utiliser."
	
	para "L'utilisation d'un"
	line "masque, ce sont"
	cont "des gestes tech-"
	cont "niques précis."

	para "Sinon on se gratte"
	line "le nez sous le"
	cont "masque, et bah en"
	cont "fait on a du"
	cont "virus sur les"
	cont "mains."

	para "Sinon on a une"
	line "utilisation qui"
	cont "n'est pas bonne,"

	para "et ça peut être"
	line "même contre-"
	cont "productif.”"

	para "..."

	para "La porte parole du"
	line "gouvernement nous"
	cont "prendrait-elle"
	cont "pour des abrutis?"
	done
else
	text "POLITICAL ITW"

	para "“People shouldn't"
	line "wear face masks,"

	para "it is useless if"
	line "you are not sick."

	para "You know, it is"
	line "very hard to put"

	para "on a face mask as"
	line "it requires"

	para "medical technical"
	line "knowledge."

	para "If you do not"
	line "handle it"

	para "carefully,"
	line "you could get in"

	para "contact with"
	line "the virus."

	para "I personally don't"
	line "know how to"

	para "properly handle a"
	line "face mask.”"

	para "…"

	para "… Wait, what did"
	line "I just hear?"

	para "Is this"
	line "spokeperson"
	cont "calling us"
	cont "stupid?"

	;cont " A face mask is just a piece of paper with 2 elastics: what's so complicated about it? It blocks viruses from going in and out your mouth and nose: what's so dangerous about it? Does this person think we are stupid? Please fire this spokeperson."
	done
endc


.Phase1Even2:
	jumptext .Phase1Even2Text

.Phase1Even2Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "Dans une autre"
	line "région, les gens"
	cont "sont autorisés à"
	cont "sortir seulement"
	cont "certains jours de"
	cont "la semaine qui"
	cont "sont définis par"
	cont "le dernier chiffre"
	cont "de leur numéro ID."
	done
else
	text "INTERNATIONAL"

	para "In another region"
	line "people are allowed"
	cont "to go outside only"
	cont "on weekdays that"
	cont "depend on the last"
	cont "figure of their"
	cont "TRAINER ID."
	done
endc


.Phase1Even3:
	jumptext .Phase1Even3Text

.Phase1Even3Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“Le président"
	line "d'Unys qualifie"
	cont "le virus de"
	cont "“virus Kantonais”,"
	cont "suscitant la haine"
	cont "contre Kanto."

	para "Neuf agressions"
	line "contre des"
	cont "immigrés de Kanto"
	cont "ont depuis été"
	cont "signalées à Unys.”"
	done
else
	text "INTERNATIONAL"

	para "“The president of"
	line "Unova is calling"
	cont "the virus the"
	cont "“Kantonese virus”,"
	cont "spreading hate"
	cont "against Kanto"
	cont "natives."

	para "9 assaults against"
	line "Kanto immigrants"
	cont "have since been"
	cont "reported in"
	cont "Unova.”"
	done
endc











.Phase2Odd1:
	jumptext .Phase2Odd1Text

.Phase2Odd1Text:
if DEF(_FR_FR)
	text "FLASH SPECIAL"

	para "“Avec le confine-"
	line "ment maintenant"
	cont "décrété à JOHTO,"
	
	para "seuls les commer-"
	line "ces essentiels"
	cont "sont autorisés à"
	cont "rester ouverts,"

	para "s'ils respectent"
	line "les mesures"
	cont "sanitaires."

	para "Les commerces non"
	line "essentiels sont:"

	para "arts,"
	line "loisirs,"

	para "sports,"
	line "voyages,"

	para "tourisme,"
	line "restaurants,"

	para "centres"
	line "commerciaux,"
	cont "etc."

	para "Pour savoir si"
	line "votre activité"
	cont "est autorisée,"

	para "consultez la liste"
	line "complète sur notre"
	cont "site internet.”"
	done
else
	text "BREAKING NEWS"

	para "“With the lockdown"
	line "now declared in"
	cont "JOHTO,"

	para "only essential"
	line "businesses are"
	cont "allowed to stay"
	cont "open,"

	para "with some sanitary" 
	line "restrictions."

	para "Non-essential"
	line "businesses are:"

	para "art,"
	line "entertainment,"

	para "sports,"
	line "travel,"

	para "tourism,"
	line "restaurants,"

	para "malls,"
	line "etc."

	para "To find out if"
	line "your business is"
	cont "allowed to remain"
	cont "open,"

	para "read the full list"
	line "on our website.”"
	done
endc


.Phase2Odd2:
	jumptext .Phase2Odd2Text

.Phase2Odd2Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“Nous avons"
	line "franchi le cap de"
	cont "10 000 décès liés"
	cont "à la pandémie"
	cont "dans le monde.”"
	done
else
	text "INTERNATIONAL"

	para "“There are now"
	line "10 000 deaths"
	
	para "worldwide caused"
	line "by the pandemic.”"
	done
endc


.Phase2Even1:
	jumptext .Phase2Even1Text

.Phase2Even1Text:
if DEF(_FR_FR)
	text "SOCIETE"

	para "“L'annonce du"
	line "confinement a"
	cont "poussé les"
	cont "consommateurs à"
	cont "se ruer sur les"
	cont "produits de"
	cont "première nécéssité"

	para "entrainant des"
	line "pénuries."

	para "Pâtes, farine,"
	line "#BALLs, et"
	cont "papier toilette"

	para "sont les biens"
	line "les plus prisés.”"
	done
else
	text "SOCIETY"

	para "“The declaration"
	line "of the lockdown"
	cont "led consumers to"
	cont "rush for essential"
	cont "goods,"

	para "leading to"
	line "shortages."

	para "Pasta, wheat,"
	line "#BALLs, wet"
	cont "wipes and"
	cont "TOILET PAPER"

	para "are now the"
	line "most prized"
	cont "possessions.”"
	done
endc


.Phase2Even2:
	jumptext .Phase2Even2Text

.Phase2Even2Text:
if DEF(_FR_FR)
	text "REVUE SCIENTIFIQUE"

	para "“La communauté"
	line "médicale est"
	cont "divisée sur la"
	cont "CHLOROQUINE."

	para "Certains l'esti-"
	line "ment efficace,"
	cont "d'autres craignent"
	cont "des effets"
	cont "secondaires"
	cont "mortels."

	para "Un test clinique"
	line "débute sur des"
	cont "humains et #MON"
	cont "volontaires.”"
	done
else
	text "SCIENTIFIC REVIEW"

	para "“The medical"
	line "community is"
	cont "divided on this"
	cont "medication called"
	cont "Chloroquine."

	para "Some say it can"
	line "cure the disease"
	cont "caused by the"
	cont "virus,"

	para "others say it"
	line "could have bad"
	cont "secondary effects"
	cont "on the patient"
	cont "which could lead"
	cont "to death."

	para "Tests are starting"
	line "on human and"
	cont "#MON"
	cont "volunteers.”"
	done
endc


.Phase2Even3:
	jumptext .Phase2Even3Text

.Phase2Even3Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“Les fausses"
	line "informations se"
	cont "répandent à"
	cont "vitesse grand V."

	para "Merci de garder un"
	line "esprit critique,"

	para "vérifiez toujours"
	line "les sources,"

	para "et assurez-vous de"
	line "la fiabilité des"
	
	para "sources avant de"
	line "partager l'info.”"

	para " "

	para "“Et ne faites"
	line "jamais confiance"
	cont "à quelqu'un qui"
	cont "parle trop et qui"
	cont "porte un costume."

	para "Un costume est une"
	line "ruse servant à"
	cont "impressionner pour"
	cont "faire passer"
	cont "n'importe quoi"
	cont "pour vérité.”"

	para " "

	para "“Sauf à un"
	line "mariage, dans ce"
	cont "cas c'est ok.”"
	done
else
	text "INTERNATIONAL"

	para "“Fake information"
	line "is running wild"
	cont "at the moment."

	para "Please make your"
	line "own critical mind,"

	para "always double"
	line "check the info,"

	para "and look for"
	line "trusted sources"

	para "before spreading"
	line "news.”"

	para " "

	para "“Also,"

	para "never trust"
	line "someone with a"
	cont "loud voice and"
	cont "a suit."

	para "A suit's purpose"
	line "is to trick people"
	
	cont "into believing the"
	cont "wearer is more"
	cont "important than"
	cont "them, in order to"
	cont "make people accept"
	cont "what the wearer"
	cont "says as truth.”"

	para " "

	para "“Unless it's at"
	line "a wedding,"
	cont "then it's ok.”"
	done
endc












.Phase3Odd1:
	jumptext .Phase3Odd1Text

.Phase3Odd1Text:
if DEF(_FR_FR)
	text "EVENEMENTS"

	para "“Bien que le"
	line "dernier Champion-"
	cont "nat #MON ait"
	cont "été annulé à cause"
	cont "des restrictions"
	cont "sanitaires,"

	para "la LIGUE #MON"
	line "a versé"
	cont "1 milliard ¥"
	cont "pour financer"
	cont "la recherche"
	cont "médicale."

	para "Le Championnat"
	line "rouvrira bientôt.”"
	done
else
	text "EVENTS"

	para "“Even though the"
	line "latest #MON"
	cont "Championship had"
	cont "to be cancelled"
	
	para "because of the"
	line "sanitary"
	cont "restrictions,"

	para "the #MON LEAGUE"
	line "has given"
	cont "¥1 billion"

	para "to finance"
	line "medical research."

	para "The Championship"
	line "will re-open"
	cont "soon.”"
	done
endc


.Phase3Odd2:
	jumptext .Phase3Odd2Text

.Phase3Odd2Text:
if DEF(_FR_FR)
	text "REVUE SCIENTIFIQUE"

	para "“Des chercheurs"
	line "ont découvert"
	cont "un nouveau"
	cont "variant du virus."

	para "Cette souche"
	line "mutée provoque"
	cont "de nouveaux"
	cont "symptômes aux"
	cont "#MON."

	para "Elle se propage"
	line "vite et devrait"
	cont "bientôt devenir le"
	cont "variant dominant.”"
	done
else
	text "SCIENTIFIC REVIEW"

	para "“Scientists have"
	line "discovered a new"
	cont "COVID variant."

	para "This mutated"
	line "version gives"
	cont "different symptoms"
	cont "to #MON."

	para "It is spreading"
	line "fast and should"
	cont "become the"
	cont "dominant variant"
	cont "quite soon.”"
	done
endc


.Phase3Odd3:
	jumptext .Phase3Odd3Text

.Phase3Odd3Text:
if DEF(_FR_FR)
	text "SOCIETE"

	para "“Les dresseurs"
	line "étant confinés"
	cont "et incapables de"
	cont "faire des combats"
	cont "#MON, le jeu VR"

	para "trainer-simulator"
	line "(.com)"

	para "voit sa popularité"
	line "exploser.”"
	done
else
	text "SOCIETY"

	para "“People being"
	line "stuck at home"

	para "and being unable"
	line "to do #MON"
	cont "battles,"

	para "the VR fangame"
	line "trainer-simulator"
	cont "(.com)"

	para "is rising"
	line "in popularity.”"
	done
endc


.Phase3Even1:
	jumptext .Phase3Even1Text

.Phase3Even1Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“Le cap symbolique"
	line "des 100 000 décès"
	cont "humains et #MON"
	cont "dans le monde"
	cont "est franchi"
	cont "aujourd'hui, et"
	cont "le bilan ne cesse"
	cont "d'augmenter.”"
	done
else
	text "INTERNATIONAL"

	para "“The symbolic"
	line "number of 100 000"
	cont "human and #MON"
	cont "death worldwide"
	cont "has been crossed"
	cont "today, and numbers"
	cont "keep increasing.”"
	done
endc


.Phase3Even2:
	jumptext .Phase3Even2Text

.Phase3Even2Text:
if DEF(_FR_FR)
	text "REVUE SCIENTIFIQUE"

	para "“Le confinement"
	line "n'est qu'une option"
	cont "parmi d'autres pour"
	cont "venir à bout du"
	cont "virus."

	para "Une autre voie"
	line "serait l'immunité"
	cont "collective."

	para "Si la majorité de"
	line "la population"
	cont "attrapait le virus"
	cont "sur une courte"
	cont "période, alors"

	para "les survivants"
	line "seraient immunisés"

	para "ce qui ralentirait"
	line "le virus jusqu'à"
	cont "le stopper net."

	para "Mais cela"
	line "tuerait près de"
	cont "10<PERCENT> de la"
	cont "population."

	para "Le conseil"
	line "scientifique a"
	cont "choisi le"
	cont "confinement pour"
	cont "stopper le virus"
	cont "immédiatement, et"
	cont "éviter la"
	cont "saturation des"
	cont "hôpitaux, ce qui"
	cont "devrait sauver de"
	cont "nombreuses vies."

	para "Cela offre aussi"
	line "du temps aux"
	cont "chercheurs pour"
	cont "étudier le virus"
	cont "et travailler sur"
	cont "un vaccin.”"
	done
else
	text "SCIENTIFIC REVIEW"

	para "“The lockdown is"
	line "only one of the"
	cont "options to try to"
	cont "kill the virus."

	para "Another way would"
	line "be to reach"

	para "collective"
	line "immunity."

	para "If most of the"
	line "population caught"
	cont "the virus in a"
	cont "short time span,"

	para "then the majority"
	line "of us would be"
	cont "immuned,"

	para "which would slow"
	line "down the spread of"
	cont "the virus to"
	cont "a halt."

	para "But this is not a"
	line "long term"
	cont "solution and most"
	cont "importantly,"

	para "it would kill"
	line "nearly 10<PERCENT> of"
	cont "our population."

	para "That is why the"
	line "scientific counsel"
	cont "advised for a"
	cont "lockdown in order"
	cont "to slow down the"
	cont "virus spread"
	cont "immediately,"

	para "which should"
	line "prevent saturation"
	cont "of our healthcare"
	cont "system,"

	para "effectively saving"
	line "lives."

	para "It also gives"
	line "researchers more"
	cont "time to study the"
	cont "virus and work"
	cont "on a vaccine.”"
	done
endc


.Phase3Even3:
	jumptext .Phase3Even3Text

.Phase3Even3Text:
if DEF(_FR_FR)
	text "BUSINESS"

	para "“Le confinement"
	line "n'est pas une"
	cont "mauvaise nouvelle"
	cont "pour tout le"
	cont "monde."

	para "Les géants du"
	line "jeu vidéo et du"
	cont "streaming ont"
	cont "doublé leurs"
	cont "bénéfices ce"
	cont "trimestre.”"
	done
else
	text "BUSINESS"

	para "“The lockdown"
	line "is not bad news"
	cont "for everyone."

	para "The biggest games"
	line "and video stream-"
	cont "ing companies"

	para "have doubled their"
	line "earnings in the"
	cont "last quarter.”"
	done
endc









.Phase4Odd1:
	jumptext .Phase4Odd1Text

.Phase4Odd1Text:
if DEF(_FR_FR)
	text "FAITS DIVERS"

	para "“La LIGUE #MON"
	line "annonce que le"
	cont "MAITRE RED a"
	cont "disparu depuis"
	cont "plusieurs"
	cont "semaines."

	para "Il est remplacé"
	line "temporairement par"
	cont "PETER du"
	cont "CONSEIL des 4."

	para "Le CHAMPION KOGA"
	line "a été promu au"
	cont "CONSEIL des 4"
	cont "pour occuper le"
	cont "poste de PETER.”"
	done
else
	text "AFFAIRS"

	para "“#MON League"
	line "announced today"
	cont "that CHAMPION RED"
	cont "has been missing"
	cont "for weeks."

	para "He will be"
	line "temporarily"
	cont "replaced by"
	cont "ELITE 4 LANCE."

	para "As a result,"
	line "GYM LEADER KOGA"
	cont "has been promoted"
	cont "to the ELITE 4.”"
	done
endc


.Phase4Odd2:
	jumptext .Phase4Odd2Text

.Phase4Odd2Text:
if DEF(_FR_FR)
	text "SOCIETE"

	para "“Vous souvenez-"
	line "vous de votre"
	cont "vieille collection"
	cont "de cartes #MON?"

	para "Vous pourriez être"
	line "assis sur une"
	cont "mine d'or!"

	para "Leur prix grimpe"
	line "depuis des années,"
	cont "et depuis le début"
	cont "de la pandémie,"
	
	para "le prix de"
	line "certaines cartes"
	cont "rares a été"
	cont "multiplié par 10.”"
	done
else
	text "SOCIETY"

	para "“Remember your old"
	line "#MON Trading"
	cont "Card collection?"

	para "You may be sitting"
	line "on a pile of gold!"

	para "The price of those"
	line "cards has been"
	cont "increasing"
	cont "steadily over the"
	cont "years, and since"
	cont "the beginning of"
	cont "the pandemic"

	para "the price of some"
	line "rare cards has"
	cont "been multiplied"
	cont "by 10 or more.”"
	done
endc


.Phase4Odd3:
	jumptext .Phase4Odd3Text

.Phase4Odd3Text:
if DEF(_FR_FR)
	text "ITW POLITIQUE"

	para "“Nous avons des"
	line "preuves solides"
	cont "que ce virus est"
	cont "artificiel et qu'il"
	cont "s'agit d'une attaque"
	cont "contre notre"
	cont "pays.”"

	para "..."

	para "Heu... alors"
	line "pourquoi tous les"
	cont "pays du monde"
	cont "sont-ils touchés?"
	done
else
	text "POLITICAL ITW"

	para "“We have strong"
	line "evidence that this"
	cont "virus is man-made"

	para "and that it is an"
	line "attack against our"
	cont "country.”"

	para "…"

	para "Wait… why are all"
	line "countries affected"
	cont "then?"
	done
endc


.Phase4Even1:
	jumptext .Phase4Even1Text

.Phase4Even1Text:
if DEF(_FR_FR)
	text "NECROLOGIE"

	para "“La membre la plus"
	line "âgée du CONSEIL 4,"
	cont "AGATHA, est"
	cont "décédée."

	para "Elle avait"
	line "contracté le"
	cont "COVID il y a"
	cont "quelques semaines."

	para "Suite à cet événe-"
	line "ment, son amie"
	cont "OLGA a décidé de"
	cont "quitter le"
	cont "CONSEIL des 4.”"
	cont "- rapporte la"
	cont "LIGUE #MON."
	done
else
	text "OBITUARY"

	para "“Oldest ELITE 4"
	line "member, AGATHA,"
	cont "has passed away."

	para "She caught COVID"
	line "a few weeks ago."

	para "Her close friend"
	line "LORELEI decided"
	cont "to quit ELITE 4"
	cont "as a result.”"
	cont "- reports #MON"
	cont "League."
	done
endc


.Phase4Even2:
	jumptext .Phase4Even2Text

.Phase4Even2Text:
if DEF(_FR_FR)
	text "FAITS DIVERS"

	para "“Tandis que les"
	line "restaurants sont"
	cont "fermés, et que la"
	cont "population est"
	cont "tenue de rester"
	cont "à la maison,"
	
	para "les riches"
	line "contournent les"
	cont "restrictions."

	para "Des restaurants"
	line "clandestins tenus"
	cont "par des chefs"
	cont "étoilés ont ouvert"
	cont "dans certaines"
	cont "résidences"
	cont "privées."
	
	para "Le prix d'un repas"
	line "serait de 50 000¥,"
	cont "et un mot de passe"
	cont "serait nécessaire"
	cont "pour y accéder."

	para "Nos sources affir-"
	line "ment que certains"
	cont "hommes politiques"
	cont "hauts placés"
	cont "participent à"
	cont "cette activité"
	cont "illégale.”"
	done
else
	text "AFFAIRS"

	para "“While restaurants"
	line "are closed and"
	cont "people must stay"
	cont "home,"

	para "rich people have"
	line "found a way to"
	cont "circumvent these"
	cont "restrictions."

	para "Indeed, undercover"
	line "restaurants held"
	cont "by famous Chefs"
	cont "opened in resi-"
	cont "dential homes."

	para "The price for a"
	line "meal is ¥50 000"
	cont "and you need a"
	cont "password from an"
	cont "insider to get in."

	para "Our sources told"
	line "us that some of"
	cont "our most important"
	cont "politicians are"
	cont "participating in"
	cont "this illegal"
	cont "activity.”"
	done
endc


.Phase4Even3:
	jumptext .Phase4Even3Text

.Phase4Even3Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“Le nombre de"
	line "décès dans le"
	cont "monde a atteint"
	cont "1 million.”"
	done
else
	text "INTERNATIONAL"

	para "The number of"
	line "deaths around the"

	para "world has now"
	line "reached 1 million."
	done
endc














.Phase5Odd1:
	jumptext .Phase5Odd1Text

.Phase5Odd1Text:
if DEF(_FR_FR)
	text "FAITS DIVERS"

	para "“Pas le meilleur"
	line "moment pour être"
	cont "jeune."

	para "Entre écoles"
	line "fermées, et vie"
	cont "sociale à l'arrêt,"

	para "les jeunes sont"
	line "désespérés."

	para "Des raves party"
	line "illégales sont"
	cont "organisées dans"
	cont "des lieux isolés,"

	para "malgré les"
	line "restrictions et"
	cont "le risque de"
	cont "propager le virus."

	para "Une rave party au"
	line "MUSEE D'ARGENTA"
	cont "a été récemment"
	cont "interrompue par la"
	cont "POLICE D'AZURIA.”"
	done
else
	text "AFFAIRS"

	para "“Not a good time"
	line "to be young."

	para "Because of closed"
	line "schools and social"
	cont "life down,"

	para "young people are"
	line "desperate."

	para "They are now"
	line "organizing illegal"
	cont "dance parties in"
	cont "remote areas,"

	para "despite the"
	line "sanitary"
	cont "restrictions"

	para "and the risk of"
	line "catching and"
	cont "spreading the"
	cont "virus."

	para "An illegal rave"
	line "in PEWTER MUSEUM"
	cont "was recently shut"
	cont "down by CERULEAN"
	cont "CITY POLICE.”"
	done
endc


.Phase5Odd2:
	jumptext .Phase5Odd2Text

.Phase5Odd2Text:
if DEF(_FR_FR)
	text "REVUE SCIENTIFIQUE"

	para "“Les vaccins"
	line "sont gratuits"
	cont "pour les #MON!"

	para "C'est notre"
	line "meilleure arme"
	cont "contre le virus!"

	para "Prenez rendez-vous"
	line "pour un vaccin au"
	cont "CENTRE DE"
	cont "VACCINATION"
	cont "SYLPHE SARL"
	cont "à SAFRANIA.”"
	done
else
	text "SCIENTIFIC REVIEW"

	para "“Vaccines are now"
	line "available for free"
	cont "for #MONs!"

	para "This is our best"
	line "weapon to beat"
	cont "the virus!"

	para "Take an appoint-"
	line "ment to get them"
	cont "vaccinated at the"
	cont "SILPH CO. VACCINA-"
	cont "TION CENTER"
	cont "in SAFFRON CITY.”"
	done
endc


.Phase5Odd3:
	jumptext .Phase5Odd3Text

.Phase5Odd3Text:
if DEF(_FR_FR)
	text "INTERNATIONAL"

	para "“Il y a désormais"
	line "plus de 5 millions"
	cont "de décès liés au"
	cont "virus."

	para "Faites-vous"
	line "vacciner pour"
	cont "sauver des vies.”"
	done
else
	text "INTERNATIONAL"

	para "“There are now"
	line "more than"

	para "5 million deaths"
	line "caused directly"
	cont "by the virus."

	para "Please get"
	line "vaccinated to save"
	cont "lives.”"
	done
endc


.Phase5Even1:
	jumptext .Phase5Even1Text

.Phase5Even1Text:
if DEF(_FR_FR)
	text "PEOPLE"

	para "“KANTO et JOHTO"
	line "pourraient avoir"
	cont "un nouveau"
	cont "MAITRE #MON!"

	para "Le MAITRE PETER,"
	line "remplaçant par"
	cont "intérim du"
	cont "MAITRE en titre"
	cont "RED, a été vaincu"
	cont "par le dresseur"
	cont "<PLAYER>."

	para "L'appartenance du"
	line "titre de MAITRE au"
	cont "dresseur <PLAYER>"
	cont "reste contestée,"
	cont "tant que le"
	cont "titulaire RED n'a"
	cont "pas été vaincu.”"
	done
else
	text "PEOPLE"

	para "“KANTO and JOHTO"
	line "may have a new"
	cont "#MON CHAMPION!"

	para "CHAMPION LANCE"
	line "that replaces"
	cont "CHAMPION in title"
	cont "RED,"

	para "has been defeated"
	line "by #MON trainer"
	cont "<PLAYER>."

	para "It is unclear if"
	line "<PLAYER> owns the"
	cont "title, as the"
	cont "CHAMPION in title"
	cont "has not been"
	cont "defeated.”"
	done
endc


.Phase5Even2:
	jumptext .Phase5Even2Text

.Phase5Even2Text:
if DEF(_FR_FR)
	text "BUSINESS"

	para "“Les pénuries de"
	line "cartes graphiques"
	cont "sont peut-être"
	cont "influencées par"
	cont "la pandémie,"

	para "mais les études"
	line "montrent que c'est"
	cont "la hausse du prix"
	cont "des cryptomonnaies"
	cont "qui en est le"
	cont "principal facteur."

	para "Il a fallu des"
	line "mois à notre"
	cont "journaliste pour"
	cont "se procurer une"
	cont "carte graphique"
	cont "en magasin."

	para "Le marché de"
	line "l'occasion se"
	cont "porte bien: les"
	cont "GPU d'occasion"
	cont "se vendent le"
	cont "double du prix du"
	cont "neuf, au lieu de"
	cont "la moitié"
	cont "habituellement."

	para "Pour le moment,"
	line "la GAME BOY,"
	cont "vieille de plu-"
	cont "sieurs décennies"
	cont "et increvable,"
	cont "reste sans doute"
	cont "la meilleure"
	cont "solution pour"
	cont "les développeurs"
	cont "et les joueurs.”"
	done
else
	text "BUSINESS"

	para "“GPU shortages may"
	line "be influenced by"
	cont "the pandemic, but"

	para "studies shows it"
	line "is mostly due to"
	cont "the rise in"
	cont "price of"
	cont "cryptocurrencies."

	para "It literally took"
	line "our reporter"
	cont "months to get one"
	cont "from retail."

	para "The used market is"
	line "doing well: used"
	cont "GPUs are now"
	cont "selling for double"
	cont "their original"
	cont "price, instead"
	cont "of half."

	para "At the moment, the"
	line "decades-old"
	cont "unkillable console"
	cont "GAME BOY seems to"
	cont "be the best"
	cont "solution for game"
	cont "developers and"
	cont "players alike.”"
	done
endc


.Phase5Even3:
	jumptext .Phase5Even3Text

.Phase5Even3Text:
if DEF(_FR_FR)
	text "VACCINATION"

	para "“La promesse de"
	line "vaccination rapide"
	cont "à grande échelle"
	cont "semble s'estomper,"
	
	para "alors que les"
	line "vaccins subissent"
	cont "de gros retards de"
	cont "production."

	para "La promesse"
	line "initiale était"
	cont "irréaliste,"
	
	para "mais on attend"
	line "tout de même 99<PERCENT>"
	cont "de vaccination"
	cont "avant la fin"
	cont "de l'année.”"
	done
else
	text "VACCINATION"

	para "“Promises of"
	line "everyone getting"
	
	para "vaccinated soon"
	line "seem to vanish as"
	
	para "the vaccines are"
	line "hitting big"
	cont "production delays."

	para "The promises made"
	line "by our authorities"
	cont "were unrealistic"

	para "but we should"
	line "reach 99<PERCENT> of"
	cont "vaccination"

	para "before the end of"
	line "the year.”"
	done
endc







.Phase6Odd2:
	jumptext .Phase6Odd2Text

.Phase6Odd2Text:
if DEF(_FR_FR)
	text "VACCINATION"

	para "“Le taux de"
	line "vaccination peine"
	cont "à dépasser 80<PERCENT> de"
	cont "la population."

	para "En effet,"
	line "beaucoup de gens"
	cont "craignent de se"
	cont "faire vacciner"
	cont "eux-mêmes ou"
	cont "leurs #MON."

	para "Ces antivax se"
	line "mettent en danger"
	cont "eux-mêmes, ainsi"
	cont "que le reste de la"
	cont "population, en"
	cont "laissant le virus"
	cont "se propager."

	para "Pour accélérer le"
	line "taux de vacci-"
	cont "nation, un cadeau"
	cont "est offert pour"
	cont "chaque #MON"
	cont "vacciné.”"
	done
else
	text "VACCINATION"

	para "“Our vaccination"
	line "level is strug-"
	cont "gling to go beyond"
	cont "80<PERCENT> of the total"
	cont "population."

	para "Indeed a lot of"
	line "people are afraid"
	cont "to vaccinate"
	cont "themselves or"
	cont "their #MON."

	para "These anti-vaxxers"
	line "are putting at"
	cont "risk not only"
	cont "themselves but"
	cont "also the rest of"
	cont "the population by"
	cont "allowing the virus"
	cont "to spread."

	para "To boost"
	line "vaccinations,"
	cont "a gift is offered"
	cont "for every #MON"
	cont "you vaccinate.”"
	done
endc



.Phase6Even3:
	farjumptext Phase6Even3Text

.TV_FirstCovidShow:
	farjumptext TV_FirstCovidShowText
	