specialcall: MACRO
; condition, contact, script
	dw \1
	db \2
	dba \3
ENDM

SpecialPhoneCallList:
; entries correspond to SPECIALCALL_* constants
	table_width SPECIALCALL_SIZE, SpecialPhoneCallList
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_BIKESHOP, BikeShopPhoneCallerScript
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_MOM,      MomPhoneLectureScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_MOM,      MomLockdownDeclaredScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_MOM,      MomCurfewStartedScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_MOM,      MomVaccinePassportScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_HOSPITAL, HospitalCallerScript
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_HOSPITAL, HospitalCallerScript
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_CREATOR,  CreatorCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM, 	   ElmPhoneCallerScript
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_HOSPITAL, HospitalCallerScript
	assert_table_length NUM_SPECIALCALLS
