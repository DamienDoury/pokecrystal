HospitalCalleeScript:
HospitalCallerScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_RECOVER_HOSPITAL, .recover
	ifequal SPECIALCALL_BOOSTER_SHOT_AVAILABLE, .second_shot_available

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