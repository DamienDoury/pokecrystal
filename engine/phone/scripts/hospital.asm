HospitalCalleeScript:
HospitalCallerScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_RECOVER_HOSPITAL, .recover
	ifequal SPECIALCALL_BOOSTER_SHOT_AVAILABLE, .second_shot_available
	ifequal SPECIALCALL_CONTACT_TRACING_AVAILABLE, .contact_tracing_available

	farwritetext HospitalPhoneReleaseText
	specialphonecall SPECIALCALL_NONE
	end

.recover
	farwritetext HospitalPhoneRecoverText
	specialphonecall SPECIALCALL_NONE
	end

.second_shot_available
	setevent EVENT_PLAYER_CAN_GET_ITS_SECOND_SHOT
	farwritetext HospitalSecondShotAvailableText
	specialphonecall SPECIALCALL_NONE
	end

.contact_tracing_available
	setevent EVENT_CONTACT_TRACING_MODULE_AVAILABLE
	specialphonecall SPECIALCALL_NONE
	writetext .HospitalContactTracingAvailableText
	promptbutton
	checkevent EVENT_MET_BILL
	iffalse .metBill
	writetext .HospitalContactTracingAvailableEcruteakText
	end

.metBill
	writetext .HospitalContactTracingAvailableGoldenrodText
	end

.HospitalContactTracingAvailableText
	text "Good news <PLAYER>!"
	line "We have a new"
	cont "weapon against"
	cont "the pandemic!"

	para "A genius named"
	line "BILL developed a"
	cont "new #GEAR CARD."

	para "Once installed, it"
	line "tracks your path"
	cont "all day long and"
	cont "stores the info."

	para "If a person or"
	line "their #MON is"
	cont "found to have been"
	cont "contaminated,"

	para "the app will trace"
	line "back the user's"
	cont "journey to find"
	cont "with whom they've"
	cont "been in contact."

	para "Those people can"
	line "then be notified."

	para "This is called"
	line "CONTACT TRACING."

	para "The more people"
	line "use it, the more"
	cont "effective."

	para "You should get"
	line "this CARD."
	done

.HospitalContactTracingAvailableEcruteakText
	text "BILL is currently"
	line "working in ECRU-"
	cont "TEAK CITY."
	done

.HospitalContactTracingAvailableGoldenrodText
	text "BILL is staying in"
	line "GOLDENROD CITY."
	done