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
	
.ContactTracingNotificationText2:
	text "If any doubt, do a"
	line "PCR test as soon"
	cont "as possible."
	done
	
.ContactTracingNotificationText3:
	text "We wish you"
	line "good health."
	done
	