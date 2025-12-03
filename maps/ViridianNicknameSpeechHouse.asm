	object_const_def
	const VIRIDIANNICKNAMESPEECHHOUSE_POKEFAN_M
	const VIRIDIANNICKNAMESPEECHHOUSE_TWIN
	const VIRIDIANNICKNAMESPEECHHOUSE_PRIMEAPE
	const VIRIDIANNICKNAMESPEECHHOUSE_SCARF_THE_FURRET

ViridianNicknameSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianNicknameSpeechHousePokefanMScript:
	faceplayer
	opentext
	writetext ViridianNicknameSpeechHousePokefanMText
	waitbutton
	closetext
	turnobject VIRIDIANNICKNAMESPEECHHOUSE_POKEFAN_M, UP
	end

ViridianNicknameSpeechHouseTwinScript:
	checkevent EVENT_LANA_GAVE_VOUCHER
	iftrue .voucher_given

	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iftrue .before_center_opening

	faceplayer
	opentext

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .go

	checkevent EVENT_LANAS_FURRET_WAS_RETURNED
	iftrue .give_voucher

	checkevent EVENT_LANAS_FURRET_GIVEN_TO_PLAYER
	iftrue .check_on_scarf
	
	writetext ViridianNicknameSpeechHouseTwin_AntivaxxerTestText
	yesorno
	iftrue .nevermind

	writetext ViridianNicknameSpeechHouseTwin_AskForVaccineText
	yesorno
	iffalse .refused

	readvar VAR_PARTYCOUNT
	ifgreater 5, .party_full

	givepoke FURRET, 37, BERRY, TRUE, .mon_name, .mon_OT_name
	disappear VIRIDIANNICKNAMESPEECHHOUSE_SCARF_THE_FURRET ; Sets EVENT_LANAS_FURRET_GIVEN_TO_PLAYER.
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.go
	writetext ViridianNicknameSpeechHouseTwin_GoText
	sjump .text_end

.nevermind
	writetext ViridianNicknameSpeechHouseTwin_NevermindText
	sjump .text_end

.before_center_opening
	jumptextfaceplayer ViridianNicknameSpeechHouseTwin_BeforeOpeningText

.voucher_given
	jumptextfaceplayer ViridianNicknameSpeechHouseTwin_VoucherGivenText

.party_full
	farwritetext MountMortarB1FKiyoFullPartyText
	sjump .text_end

.refused
	writetext ViridianNicknameSpeechHouseTwin_RefusesText
.text_end
	waitbutton
.close_text
	closetext
	end

.check_on_scarf
	writetext ViridianNicknameSpeechHouseTwin_CheckingOnFurretText
	yesorno
	iffalse .misses_furret

	farwritetext GoldenrodCityMoveTutorMoveText
	callasm SelectScarfTheVaccinatedFurret
	ifequal -1, .cancelled_check
	ifequal 1, .mission_accomplished
	ifequal 3, .not_vaccinated

.wrong_pokemon
	writetext ViridianNicknameSpeechHouseTwin_WrongPokemonText
	promptbutton
.cancelled_check
	writetext ViridianNicknameSpeechHouseTwin_CancelledCheckText
	sjump .text_end

.not_vaccinated
	writetext ViridianNicknameSpeechHouseTwin_NotVaccinatedYetText
	sjump .text_end

.no_room_for_item
	farwritetext BeverlyPackFullText
	sjump .text_end

.misses_furret
	writetext ViridianNicknameSpeechHouseTwin_MissesFurretText
	sjump .text_end

.mission_accomplished
	callasm DepositCurPartyMon
	appear VIRIDIANNICKNAMESPEECHHOUSE_SCARF_THE_FURRET
	reloadmappart
	writetext ViridianNicknameSpeechHouseTwin_ThanksText
	promptbutton
	setevent EVENT_LANAS_FURRET_WAS_RETURNED
.give_voucher
	writetext ViridianNicknameSpeechHouseTwin_GiveVoucherText
	promptbutton
	verbosegiveitem VOUCHER
	iffalse .no_room_for_item

	setevent EVENT_LANA_GAVE_VOUCHER
	sjump .close_text

.mon_name:
if DEF(_FR_FR)
	db "ECHARPE@"
else
	db "SCARF@"
endc

.mon_OT_name:
if DEF(_FR_FR)
	db "LINA@"
else
	db "LANA@"
endc

ViridianPrimeapeScript:
	opentext
	writetext ViridianPrimeapeText
	cry PRIMEAPE
	waitbutton
	closetext
	end

ViridianScarfScript:
	opentext
	writetext ViridianScarfText
	cry FURRET
	waitbutton
	closetext
	end

ViridianNicknameSpeechHouseRadio:
	jumpstd Radio3Script

ViridianNicknameSpeechHousePokefanMText:
if DEF(_FR_FR)
	text "Crois-moi bien:"
	line "personne dans ma"
	cont "famille ne se fera"

	para "injecter dans ses"
	line "veines ce poison"
	cont "nommé “vaccin”."

	para "On n'est pas des"
	line "cobayes!"
else
	text "Trust me--no one"
	line "in this family"
	
	para "will get injected"
	line "with the poison"
	cont "they call vaccine."

	para "We're no test"
	line "subjects!"
endc
	done

ViridianNicknameSpeechHouseTwin_BeforeOpeningText:
if DEF(_FR_FR)
	text "Un centre de"
	line "vaccination pour"
	cont "#MON va bientôt"
	cont "ouvrir à SAFRANIA."

	para "Quand ce sera le"
	line "cas, reviens me"
	cont "voir."
else
	text "A #MON"
	line "vaccination center"
	
	para "is about to open"
	line "in SAFFRON CITY."

	para "When it does, pay"
	line "me a visit."
endc
	done

ViridianNicknameSpeechHouseTwin_AntivaxxerTestText:
if DEF(_FR_FR)
	text "Faut être débile"
	line "pour faire vacci-"
	cont "ner un #MON,"
	cont "pas vrai?"
else
	text "You gotta be dumb"
	line "to get a #MON"
	cont "vaccinated, right?"
endc
	done

ViridianNicknameSpeechHouseTwin_NevermindText:
if DEF(_FR_FR)
	text "Ouais! Toi tu"
	line "piges!"
else
	text "Yeah! You get it!"
endc
	done

ViridianNicknameSpeechHouseTwin_AskForVaccineText:
if DEF(_FR_FR)
	text "Chut! Moins fort!"

	para "Mon père est un"
	line "antivax pur & dur."

	para "Il s'énerve lorsqu'"
	line "il entend une opi-"
	cont "nion contraire à"
	cont "la sienne."

	para "Quand j'lui ai"
	line "demandé de m'amener"
	cont "à SAFRANIA pour"

	para "faire vacciner"
	line "FOUINAR, il m'a"
	cont "battu..."

	para "Tu pourrais faire"
	line "vacciner mon #-"
	cont "MON discrètement?"
else
	text "Shush! Keep it"
	line "down!"
	
	para "My dad is a pure"
	line "antivaxxer breed."

	para "He'll get mad if he"
	line "hears any opposing"
	cont "opinions."

	para "When I asked him"
	line "to take me to"
	cont "SAFFRON CITY to"
	
	para "get FURRET a shot,"
	line "dad beat me down…"

	para "Could you get my"
	line "#MON vaccinated"
	cont "discreetly?"
endc
	done

ViridianNicknameSpeechHouseTwin_RefusesText:
if DEF(_FR_FR)
	text "J'peux pas fuir"
	line "cette prison."
	cont "J't'en supplie..."
else
	text "You're my only way"
	line "out of this"
	cont "prison. I'm"
	cont "begging you…"
endc
	done

ViridianNicknameSpeechHouseTwin_GoText:
if DEF(_FR_FR)
	text "Vite! Pars avant"
	line "que papa ne"
	cont "remarque!"
else
	text "Now go before"
	line "daddy notices!"
endc
	done

ViridianNicknameSpeechHouseTwin_CheckingOnFurretText:
if DEF(_FR_FR)
	text "Comment ça s'est"
	line "passé la vaccina-"
	cont "tion d'ECHARPE?"

	para "J'peux le"
	line "reprendre?"
else
	text "How is it going"
	line "with SCARF's"
	cont "vaccination?"
	cont "Can I get it back?"
endc
	done

ViridianNicknameSpeechHouseTwin_MissesFurretText:
if DEF(_FR_FR)
	text "Mon FOUINAR me"
	line "manque..."
else
	text "I miss my FURRET…"
endc
	done

ViridianNicknameSpeechHouseTwin_CancelledCheckText:
if DEF(_FR_FR)
	text "Où qu'il est mon"
	line "FOUINAR?"
else
	text "Where's my FURRET?"
endc
	done

ViridianNicknameSpeechHouseTwin_WrongPokemonText:
if DEF(_FR_FR)
	text "Hé! C'est pas mon"
	line "FOUINAR!"
else
	text "Hey this isn't"
	line "my FURRET!"
endc
	done

ViridianNicknameSpeechHouseTwin_NotVaccinatedYetText:
if DEF(_FR_FR)
	text "Il n'est pas encore"
	line "vacciné. S'il te"
	cont "plaît, fais-le"
	cont "pour moi..."
else
	text "It's not vaccinated"
	line "yet. Please do it"
	cont "for me…"
endc
	done

ViridianNicknameSpeechHouseTwin_ThanksText:
if DEF(_FR_FR)
	text "J'suis tellement"
	line "soulagée!"
	cont "Mille mercis!"
else
	text "I'm so relieved!"
	line "Thanks!"
endc
	done

ViridianNicknameSpeechHouseTwin_GiveVoucherText:
if DEF(_FR_FR)
	text "Comme j'peux pas"
	line "aller à SAFRANIA,"
	
	para "j'peux pas retirer"
	line "le gain de mon"
	cont "TICK.GAGNANT."

	para "J'veux pas le"
	line "laisser se perdre."
	cont "Sauve-le."
else
	text "As I can't go to"
	line "SAFFRON CITY, I"
	cont "can't redeem this"
	cont "VOUCHER."
	
	para "I can't let it"
	line "go to waste."
	cont "You deserve it."
endc
	done

ViridianNicknameSpeechHouseTwin_VoucherGivenText:
if DEF(_FR_FR)
	text "Merci de faire ta"
	line "part contre le"
	cont "COVID, soldat."

	para "Espérons qu'"
	line "ECHARPE ne tombe"
	cont "jamais malade."
else
	text "Thanks for doing"
	line "your part against"
	cont "COVID, soldier."

	para "Hopefully SCARF"
	line "never gets sick."
endc
	done

ViridianPrimeapeText:
if DEF(_FR_FR)
	text "COLOKATERE: Singe!"
else
	text "JAPE PAUL: Prime!"
endc
	done

ViridianScarfText:
if DEF(_FR_FR)
	text "ECHARPE: FOOOOUI-"
else
	text "SCARF: FUUUUUU-"
endc
	done

ViridianNicknameSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, VIRIDIAN_CITY, 2
	warp_event  3,  7, VIRIDIAN_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, ViridianNicknameSpeechHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianNicknameSpeechHousePokefanMScript, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ViridianNicknameSpeechHouseTwinScript, -1
	object_event  5,  2, SPRITE_PRIMEAPE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ViridianPrimeapeScript, -1
	object_event  6,  3, SPRITE_FURRET, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ViridianScarfScript, EVENT_LANAS_FURRET_GIVEN_TO_PLAYER
