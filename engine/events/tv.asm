TVShow:
	checkevent EVENT_RED_BEATEN
	iftrue .Phase6
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Phase5
	readvar VAR_BADGES
	ifgreater 6, .Phase4
	readvar VAR_BADGES
	ifgreater 4, .Phase3
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iftrue .Phase2
	checkevent EVENT_GOT_HM01_CUT
	iftrue .FirstLockdownDeclaration
	sjump .Phase1
	end

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
	jumptext .TV_DefaultText
	end

.FirstLockdownDeclaration:
	jumptext .FirstLockdownDeclarationText

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
	jumptext .TV_DefaultText
	end

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
	jumptext .TV_DefaultText
	end

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
	jumptext .TV_DefaultText
	end

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
	jumptext .TV_DefaultText
	end

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
	jumptext .TV_DefaultText
	end














.Phase1Odd1:
	jumptext .Phase1Odd1Text

.Phase1Odd1Text:
	text "INTERNATIONAL"

	para "In another region,"
	line "to slow down the"
	cont "epidemic, men and"
	cont "women are not"
	cont "allowed to go"
	cont "outside on the"
	cont "same day of the"
	cont "week."
	;cont "Are non-binary people allowed to go outside everyday or are they locked inside all the time?"
	done

.Phase1Odd2:
	jumptext .Phase1Odd2Text

.Phase1Odd2Text:
	text "POLITICAL ITW"

	para "“Our region is"
	line "very much prepared"
	cont "against epidemics,"
	cont "and this virus"
	cont "won't affect us."

	para "In 3 months time"
	line "it will be"
	cont "behind us.” -"

	para "said the president"
	line "of another region."
	done

.Phase1Odd3:
	jumptext .Phase1Odd3Text

.Phase1Odd3Text:
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

	para "The best to"
	line "fight a virus"

	para "is to punch it,"
	line "right?"
	done

.Phase1Even1:
	jumptext .Phase1Even1Text

.Phase1Even1Text:
	text "POLITICAL ITW"

	para "“People shouldn't"
	line "wear face masks,"

	para "it is useless if"
	line "you are not sick."

	para "You know, it is"
	line "very hard to put"

	para "on a facemask as"
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
	cont "thinking we are"
	cont "stupid?"

	;cont " A facemask is just a piece of paper with 2 elastics: what's so complicated about it? It blocks viruses from going in and out your mouth and nose: what's so dangerous about it? Does this person think we are stupid? Please fire this spokeperson."
	done

.Phase1Even2:
	jumptext .Phase1Even2Text

.Phase1Even2Text:
	text "INTERNATIONAL"

	para "In another region"
	line "people are allowed"
	cont "to go outside only"
	cont "on weekdays that"
	cont "depend on the last"
	cont "figure of their"
	cont "social security"
	cont "number."
	done

.Phase1Even3:
	jumptext .Phase1Even3Text

.Phase1Even3Text:
	text "INTERNATIONAL"

	para "“The president of"
	line "another region is"
	cont "calling the virus"
	cont "“Kantonese virus”,"
	cont "spreading hate"
	cont "against Kanto"
	cont "natives."

	para "5 assaults have"
	line "since been"
	cont "reported.”"
	done










.Phase2Odd1:
	jumptext .Phase2Odd1Text

.Phase2Odd1Text:
	text "BREAKING NEWS"

	para "“With the lockdown"
	line "now declared in"
	cont "Johto,"

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

.Phase2Odd2:
	jumptext .Phase2Odd2Text

.Phase2Odd2Text:
	text "INTERNATIONAL"

	para "“There are now"
	line "10 000 deaths"
	
	para "worldwide caused"
	line "by the pandemic.”"
	done

.Phase2Even1:
	jumptext .Phase2Even1Text

.Phase2Even1Text:
	text "SOCIETY"

	para "“The declaration"
	line "of the lockdown"
	cont "led consumers to"
	cont "rush for essential"
	cont "goods,"

	para "leading to"
	line "shortages."

	para "Pasta, wheat,"
	line "#BALLs, and"
	cont "toilet paper"

	para "are now the"
	line "most prized"
	cont "possessions.”"
	done

.Phase2Even2:
	jumptext .Phase2Even2Text

.Phase2Even2Text:
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

.Phase2Even3:
	jumptext .Phase2Even3Text

.Phase2Even3Text:
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











.Phase3Odd1:
	jumptext .Phase3Odd1Text

.Phase3Odd1Text:
	text "EVENTS"

	para "“Even though the"
	line "latest #MON"
	cont "Championship had"
	cont "to be cancelled"
	
	para "because of the"
	line "sanitary"
	cont "restrictions,"

	para "The #MON League"
	line "has given"
	cont "1 billion ¥"

	para "to finance"
	line "medical research."

	para "The Championship"
	line "will re-open"
	cont "soon.”"
	done

.Phase3Odd2:
	jumptext .Phase3Odd2Text

.Phase3Odd2Text:
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

.Phase3Odd3:
	jumptext .Phase3Odd3Text

.Phase3Odd3Text:
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

.Phase3Even1:
	jumptext .Phase3Even1Text

.Phase3Even1Text:
	text "INTERNATIONAL"

	para "“The symbolic"
	line "number of 100 000"
	cont "human and #MON"
	cont "death worldwide"
	cont "has been crossed"
	cont "today, and numbers"
	cont "are only growing.”"
	done

.Phase3Even2:
	jumptext .Phase3Even2Text

.Phase3Even2Text:
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
	line "nearly 10% of"
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

.Phase3Even3:
	jumptext .Phase3Even3Text

.Phase3Even3Text:
	text "BUSINESS"

	para "“The lockdown"
	line "is not bad news"
	cont "for everyone."

	para "The biggest games"
	line "and video"
	cont "streaming companies"

	para "have doubled their"
	line "revenue in"
	cont "the last month.”"
	done









.Phase4Odd1:
	jumptext .Phase4Odd1Text

.Phase4Odd1Text:
	text "AFFAIRS"

	para "“#MON League"
	line "announced today"
	cont "that Champion Red"
	cont "has been missing"
	cont "for weeks."

	para "He will be"
	line "temporarily"
	cont "replaced by"
	cont "Elite 4 Lance."

	para "As a result,"
	line "Gym Leader Koga"
	cont "has been promoted"
	cont "to Elite 4.”"
	done

.Phase4Odd2:
	jumptext .Phase4Odd2Text

.Phase4Odd2Text:
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
	cont "rave parties in"
	cont "remote areas,"

	para "despite the"
	line "sanitary"
	cont "restrictions"

	para "and the risk of"
	line "catching and"
	cont "spreading the"
	cont "virus."

	para "An illegal rave"
	line "party in Jade"
	cont "Forest was"
	cont "recently shut"
	cont "down by Viridian"
	cont "City Police.”"
	done

.Phase4Odd3:
	jumptext .Phase4Odd3Text

.Phase4Odd3Text:
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

.Phase4Even1:
	jumptext .Phase4Even1Text

.Phase4Even1Text:
	text "OBITUARY"

	para "“Oldest Elite 4"
	line "member, Agatha,"
	cont "has passed away."

	para "She caught COVID"
	line "a few weeks ago.”"

	para "Her close friend"
	line "Lorelei decided"
	cont "to quit Elite 4"
	cont "as a result."
	cont "- reports #MON"
	cont "League."
	done

.Phase4Even2:
	jumptext .Phase4Even2Text

.Phase4Even2Text:
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
	cont "opened in large"
	cont "private apartments"
	cont "in Celadon City."

	para "The price for a"
	line "meal is 50 000¥"
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

.Phase4Even3:
	jumptext .Phase4Even3Text

.Phase4Even3Text:
	text "INTERNATIONAL"

	para "The number of"
	line "deaths around the"

	para "world has now"
	line "reached 1 million."
	done













.Phase5Odd1:
	jumptext .Phase5Odd1Text

.Phase5Odd1Text:
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

.Phase5Odd2:
	jumptext .Phase5Odd2Text

.Phase5Odd2Text:
	text "SCIENTIFIC REVIEW"

	para "“Vaccines are now"
	line "available for free"
	cont "for #MONs!"

	para "This is our best"
	line "weapon to beat"
	cont "the virus!"

	para "Take an"
	line "appointment to get"
	cont "vaccinated at the"
	cont "Silph Co. center"
	cont "in Saffron City.”"
	done


.Phase5Odd3:
	jumptext .Phase5Odd3Text

.Phase5Odd3Text:
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


.Phase5Even1:
	jumptext .Phase5Even1Text

.Phase5Even1Text:
	text "PEOPLE"

	para "“Kanto and Johto"
	line "may have a new"
	cont "#MON Champion!"

	para "Champion Lance"
	line "that replaces"
	cont "Champion in title"
	cont "Red,"

	para "has been defeated"
	line "by #MON trainer"
	cont "<PLAYER>."

	para "It is unclear if"
	line "<PLAYER> owns the"
	cont "title, as the"
	cont "Champion in title"
	cont "has not been"
	cont "defeated.”"
	done


.Phase5Even2:
	jumptext .Phase5Even2Text

.Phase5Even2Text:
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

.Phase5Even3:
	jumptext .Phase5Even3Text

.Phase5Even3Text:
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
	line "reach 99% of"
	cont "vaccination"

	para "before the end of"
	line "the year.”"
	done







.Phase6Odd2:
	jumptext .Phase6Odd2Text

.Phase6Odd2Text:
	text "VACCINATION"

	para "“Our vaccination"
	line "level is now at"
	cont "90 percent but"
	cont "won't go above."

	para "Indeed a lot of"
	line "people are afraid"
	cont "to vaccinate them"
	cont "or their #MON."

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


.Phase6Even3:
	jumptext .Phase6Even3Text

.Phase6Even3Text:
	text "OBITUARY"

	para "“Beloved Champion"
	line "Red that had been"
	cont "missing for months"
	cont "has succumbed to"
	cont "the virus."

	para "<PLAYER> who was"
	line "co-champion is now"
	cont "the official"
	cont "Champion.”"
	done











.FirstLockdownDeclarationText:
	text "INTERVENTION"

	para "“Due to the rise"
	line "in daily new cases"
	cont "of contamination,"

	para "starting tomorrow"
	line "a lockdown will be"
	cont "declared for 2 days"
	cont "of application."

	para "#MON and people"
	line "are not allowed"
	cont "to leave home."

	para "The only"
	line "exceptions are:"

	para "groceries, work,"
	line "& medical reasons."

	para "Each trip outside"
	line "requires a"
	cont "self-made written"
	cont "attestation."

	para "There will be"
	line "police controls."

	para "Illegal situations"
	line "will be fined, and"
	cont "you will be"
	cont "reconducted home"
	cont "or to the nearest"
	cont "#MON center."

	para " "

	para "Be responsible,"
	line "save lives,"
	cont "stay safe.”"
	done

.TV_FirstCovidShow:
	jumptext .TV_FirstCovidShowText
	
.TV_FirstCovidShowText:
	text "On the news,"
	line "a doctor debates"
	cont "with a politician"
	cont "about a newly"
	cont "discovered virus."

	para "The doctor seems"
	line "nervous."

	para "The politician"
	line "laughes and says"

	para "there is no need"
	line "to panic."

	para "…"

	para "I better"
	line "get going."
	done

.TV_DefaultText:
	text "It's a TV."
	done