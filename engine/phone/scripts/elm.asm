ElmPhoneCalleeScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_POKERUS, .pokerus
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue .discovery
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse .next
	checkevent EVENT_TOGEPI_HATCHED
	iftrue .egghatched
.next
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue .eggunhatched
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .checkingegg
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .stolen
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue .sawmrpokemon
	farwritetext ElmPhoneHealYourMonText
	end

.sawmrpokemon
	farwritetext ElmPhoneSawMrPokemonText
	end

.stolen
	farwritetext ElmPhonePokemonStolenText
	end

.checkingegg
	farwritetext ElmPhoneCheckingTheEggText
	end

.eggunhatched
	farwritetext ElmPhoneHowIsTheEggText
	end

.egghatched
	farwritetext ElmPhoneEggHatchedText
	setevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	end

.discovery
	random 2
	ifequal 0, .nextdiscovery
	farwritetext ElmPhoneDiscoveredHatchTimeText
	end

.nextdiscovery
	farwritetext ElmPhoneInvestigatingEggMovesText
	end

.pokerus
	farwritetext ElmPhoneDiscoveredPokerusText
	specialphonecall SPECIALCALL_NONE
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

.neat ; unreferenced
	farwritetext ElmPhoneGotAholdOfSomethingNeatText
	specialphonecall SPECIALCALL_NONE
	end
