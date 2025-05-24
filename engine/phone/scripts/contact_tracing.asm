ContactTracingCalleeScript:
ContactTracingCallerScript:
	specialphonecall SPECIALCALL_NONE
	writetext .ContactTracingNotificationText1
	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .skip_pcr

	promptbutton
	writetext .ContactTracingNotificationText2

.skip_pcr
	promptbutton
	writetext .ContactTracingNotificationText3
	end

.ContactTracingNotificationText1:
if DEF(_FR_FR)
	text "Bonjour <PLAYER>."

	para "Un dresseur que"
	line "vous avez affronté"
	cont "récemment a été"
	cont "testé positif"
	cont "au COVID."

	para "Vous et vos #-"
	line "MON devez suivre"
	cont "5 jours de"
	cont "quarantaine."

	para "Soyez attentif"
	line "aux symptômes."
	done
else
	text "Hello <PLAYER>."

	para "A trainer you"
	line "recently battled"
	cont "has been tested"
	cont "positive to COVID."
	
	para "You and your #-"
	line "MON must begin a"
	cont "5-day quarantine."
	
	para "Watch out for"
	line "symptoms."
	done
endc

.ContactTracingNotificationText2:
if DEF(_FR_FR)
	text "En cas de doute,"
	line "faites un test PCR"
	cont "au plus vite."
	done
else
	text "If any doubt, do a"
	line "PCR test as soon"
	cont "as possible."
	done
endc

.ContactTracingNotificationText3:
if DEF(_FR_FR)
	text "Nous vous souhai-"
	line "tons bonne santé."
	done
else
	text "We wish you"
	line "good health."
	done
endc

	