specialcall: MACRO
; condition, contact, script
	dw \1
	db \2
	dba \3
ENDM

SpecialPhoneCallList:
; entries correspond to SPECIALCALL_* constants
	table_width SPECIALCALL_SIZE, SpecialPhoneCallList
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_POKERUS
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_ROBBED
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_ASSISTANT
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_POKEMASK_BEFORE
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_POKEMASK_AFTER
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_WEIRDBROADCAST
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_SSTICKET
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_BIKESHOP, BikeShopPhoneCallerScript ; SPECIALCALL_BIKESHOP
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_MOM,      MomPhoneLectureScript ; SPECIALCALL_WORRIED
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_MOM,      MomLockdownDeclaredScript ; SPECIALCALL_LOCKDOWN_ANNOUNCEMENT
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_MOM,      MomCurfewStartedScript ; SPECIALCALL_CURFEW_STARTED
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_WORK_VISA
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_MOM,      MomVaccinePassportScript ; SPECIALCALL_VACCINE_PASSPORT
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_HOSPITAL, HospitalCallerScript ; SPECIALCALL_RECOVER_HOSPITAL
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_HOSPITAL, HospitalCallerScript ; SPECIALCALL_RELEASE_HOSPITAL
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_CREATOR,  CreatorCallerScript ; SPECIALCALL_DAILY_EVENTS_RESET
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_ELM, 	   ElmPhoneCallerScript ; SPECIALCALL_MISSION_COMPLETE
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_HOSPITAL, HospitalCallerScript ; SPECIALCALL_BOOSTER_SHOT_AVAILABLE
	specialcall SpecialCallOnlyWhenOutside, PHONECONTACT_HOSPITAL, HospitalCallerScript ; SPECIALCALL_CONTACT_TRACING_AVAILABLE
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_TRACING,  ContactTracingCallerScript ; SPECIALCALL_CONTACT_TRACING_NOTIFICATION
	specialcall SpecialCallWhereverYouAre,  PHONECONTACT_ELM,      ElmPhoneCallerScript ; SPECIALCALL_ANTI_SOFTLOCK_POKEBALL
	assert_table_length NUM_SPECIALCALLS
