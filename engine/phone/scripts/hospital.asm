HospitalCalleeScript:
HospitalCallerScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_RECOVER_HOSPITAL, .recover

	farwritetext HospitalPhoneReleaseText
	specialphonecall SPECIALCALL_NONE
	end

.recover
	farwritetext HospitalPhoneRecoverText
	specialphonecall SPECIALCALL_NONE
	end