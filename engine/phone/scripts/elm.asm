ElmPhoneCalleeScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_POKERUS, .pokerus
	readmem wMapGroup
	ifnotequal GROUP_GOLDENROD_CITY, .next_checks

	readmem wMapNumber
	ifnotequal MAP_GOLDENROD_CITY, .next_checks

	sjump .hospital

.next_checks
	checkevent EVENT_RED_BEATEN
	iftrue .before_red_beaten

	checkevent EVENT_ELM_MISSION_COMPLETE_SPEECH
	iftrue .final_call

	farwritetext ElmPhoneMeetMeText
	end

.before_red_beaten
	checkevent EVENT_MET_OAK_IN_SAFFRON
	iffalse .before_kanto

	farwritetext ElmPhoneKantoText
	end

.before_kanto
	checkevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	iftrue .encourage_first_shot

	readvar VAR_BADGES
	ifnotequal 8, .not_8_badges

	checkevent EVENT_GOT_WORK_VISA_FROM_ELM
	iftrue .not_8_badges

	farwritetext ElmPhoneMeetMeText
	end

.not_8_badges
	checkevent EVENT_ELMS_AIDE_IN_VIOLET
	iftrue .discovery
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .thanks_sample
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .stolen
	checkevent EVENT_GOT_COVID_SAMPLE_FROM_MR_POKEMON
	iftrue .sawmrpokemon
	farwritetext ElmPhoneHealYourMonText
	end

.sawmrpokemon
	farwritetext ElmPhoneSawMrPokemonText
	end

.stolen
	farwritetext ElmPhonePokemonStolenText
	end

.thanks_sample
	farwritetext ElmPhoneThanksSampleText
	end

.discovery
	random 2
	ifequal 0, .nextdiscovery
	farwritetext ElmPhonePokerusMutationText
	end

.nextdiscovery
	farwritetext ElmPhoneBallsPermeableToVirusText
	end

.pokerus
	farwritetext ElmPhoneDiscoveredPokerusText
	specialphonecall SPECIALCALL_NONE
	end

.encourage_first_shot
	farwritetext ElmPhoneEncourageFirstShotText
	end

.hospital
	farwritetext ElmPhoneHospital1Text
	promptbutton

	checkevent EVENT_RED_BEATEN
	iffalse .hospital_end

	farwritetext ElmPhoneHospital2Text
	promptbutton

.hospital_end
	farwritetext ElmPhoneSayHiToHerText
	end

.final_call:
	farwritetext ElmFinalText2
	end

ElmPhoneCallerScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_ROBBED, .disaster
	ifequal SPECIALCALL_POKEMASK_BEFORE, .go_get_pokemask
	ifequal SPECIALCALL_POKEMASK_AFTER, .pokemask_description
	ifequal SPECIALCALL_WEIRDBROADCAST, .rocket
	ifequal SPECIALCALL_SSTICKET, .something_important
	ifequal SPECIALCALL_WORK_VISA, .gift
	ifequal SPECIALCALL_MISSION_COMPLETE, .mission_complete
	ifequal SPECIALCALL_ANTI_SOFTLOCK_POKEBALL, .anti_softlock_pokeball
	farwritetext ElmPhoneDiscoveredPokerusText
	specialphonecall SPECIALCALL_NONE
	end

.disaster
	farwritetext ElmPhoneDisasterText
	specialphonecall SPECIALCALL_NONE
	setevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	end

.go_get_pokemask
	farwritetext ElmPhonePokemaskBeforeText
	specialphonecall SPECIALCALL_NONE
	end

.pokemask_description
	farwritetext ElmPhonePokemaskAfterText
	specialphonecall SPECIALCALL_NONE
	end

.rocket
	farwritetext ElmPhoneRadioTowerRocketTakeoverText
	specialphonecall SPECIALCALL_NONE
	end

.gift
	farwritetext ElmPhoneGiftText
	specialphonecall SPECIALCALL_NONE
	end

.mission_complete
	farwritetext ElmPhoneQuickCallText
	specialphonecall SPECIALCALL_NONE
	end

.something_important
	farwritetext ElmPhoneSomethingToTellText
	specialphonecall SPECIALCALL_NONE
	end

.anti_softlock_pokeball:
	specialphonecall SPECIALCALL_NONE
	setevent EVENT_ANTI_SOFTLOCK_DELIVERY
	setflag ENGINE_FREE_EMERGENCY_POKEBALL_SENT
	clearevent EVENT_MYSTERY_GIFT_DELIVERY_GUY
	farwritetext ElmEmergencyPokeballDeliveryText
	promptbutton
	farwritetext _MomItsInPCText
	end