TVShow:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .TV_FirstCovidShow
	jumptext .TV_DefaultText
	end

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