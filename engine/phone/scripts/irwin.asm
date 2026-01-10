IrwinPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, JUGGLER, IRWIN1
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .Rockets

	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .Lockdown

	farsjump IrwinRandomTextScript

.Rockets:
	farsjump IrwinRocketRumorScript

.Lockdown:
	farwritetext IrwinLockdownText
	promptbutton
	farsjump PhoneScript_HangUpText_Male

IrwinPhoneCallerScript:
	gettrainername STRING_BUFFER_3, JUGGLER, IRWIN1
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .Rockets
	farsjump IrwinRumorScript

.Rockets:
	farsjump IrwinRocketRumorScript
