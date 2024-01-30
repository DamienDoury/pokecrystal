ContactTracingCalleeScript:
ContactTracingCallerScript:
	writetext .ContactTracingNotificationText
	specialphonecall SPECIALCALL_NONE
	clearevent EVENT_CONTACT_TRACING_NOTIFICATION
	end

.ContactTracingNotificationText:
	text "Hello <PLAYER>."

	para "A trainer you"
	line "recently battled"
	cont "with, has been"
	cont "tested positive"
	cont "to COVID."
	
	para "You and your #-"
	line "MON must begin a"
	cont "5-day quarantine."
	
	para "Watch out for"
	line "symptoms."
	
	para "If any doubt, do a"
	line "PCR test as soon"
	cont "as possible."
	
	para "We wish you"
	line "good health."
	done
	