TVShow:
	sjump .Phase1

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

.Phase2:
	end

.Phase3:
	end

.Phase4:
	end

.Phase5:
	end

.Phase6:
	jumptext .TV_RedsDeathText


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
	text ""
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

.TV_RedsDeathText:
	text "OBITUARY"

	para "“Beloved Champion"
	line "Red that had been"
	cont "missing for months"
	cont "has succumbed to"
	cont "the virus."

	para "<PLAYER> who was"
	line "co-champion is now"
	cont "officially the"
	cont "sole Champion.”"
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