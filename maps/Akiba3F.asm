	object_const_def
	const AKIBA3F_SELLER
	const AKIBA3F_SNORLAX_DOLL
	const AKIBA3F_ONIX_DOLL
	const AKIBA3F_LAPRAS_DOLL
	const AKIBA3F_CLIENT_1
	const AKIBA3F_CLIENT_TWIN

Akiba3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .DisplayDolls

.DisplayDolls:
	; Hide all 3 dolls.
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3

	scall Akiba3F_HaveAllBigDollsBeenSold
	iffalse .skip_hide_twin

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

.skip_hide_twin
	; Display today's available Big Doll, or nothing if the player already bought them all.
	readmem wJustWonBigDoll
	iftrue .end_callback

	callasm DisplayTodaysBigDoll
.end_callback
	endcallback

Akiba3F_HaveAllBigDollsBeenSold:	
	checkevent EVENT_DECO_BIG_SNORLAX_DOLL
	iffalse .end

	checkevent EVENT_DECO_BIG_ONIX_DOLL
	iffalse .end

	checkevent EVENT_DECO_BIG_LAPRAS_DOLL
.end
	end

Akiba3F_DollNameDisplayScript:
	readmem wTodaysBigDollID
	callasm GetDecorationNameFromScript
	jumptext Akiba3F_DecoNameText

Akiba3F_SellerScript:
	faceplayer
	opentext

	readmem wJustWonBigDoll
	iftrue .just_won

	readmem wTodaysBigDollIndex
	ifgreater 2, .lottery_over

	readmem wTodaysBigDollID
	callasm GetDecorationNameFromScript
	writetext Akiba3F_BigPriceAnnoucementText
	promptbutton
	getitemname STRING_BUFFER_3, VOUCHER
	checkitem VOUCHER
	iffalse .instructions

	writetext Akiba3F_VoucherDetectedText
	yesorno
	iffalse .come_back_later

	; The player decided to redeem its voucher for today's prize.
	takeitem VOUCHER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	disappear AKIBA3F_SNORLAX_DOLL
	disappear AKIBA3F_ONIX_DOLL
	disappear AKIBA3F_LAPRAS_DOLL
	writetext Akiba3F_ShippingText
	promptbutton

	readmem wTodaysBigDollEventFlag + 1
	writemem wScriptVar2
	readmem wTodaysBigDollEventFlag
	setevent EVENT_FROM_MEM
	loadmem wJustWonBigDoll, TRUE
	
	scall Akiba3F_HaveAllBigDollsBeenSold
	iffalse .skip_hide_twin

	disappear AKIBA3F_CLIENT_TWIN

.skip_hide_twin
	; Get doll.
	callasm GetTodaysBigDoll ; This is used to refresh wTodaysBigDollIndex, in order to display the proper text whether there are more dolls to win, or it was the last one.

.just_won
	readmem wTodaysBigDollIndex
	ifless 3, .come_back_later

.lottery_over
	writetext Akiba3F_LotteryDoneText
	sjump .end_text

.instructions
	writetext Akiba3F_InstructionsText
	sjump .end_text

.come_back_later
	writetext Akiba3F_ComeBackLaterText
.end_text
	waitbutton
	closetext
	end

Akiba3F_Client1Script:
	scall Akiba3F_HaveAllBigDollsBeenSold
	iftrue .no_dolls

	jumptextfaceplayer Akiba3F_Client1Text

.no_dolls
	jumptextfaceplayer Akiba3F_Client1BisText

Akiba3F_Client2Script:
	jumptextfaceplayer Akiba3F_Client2Text

Akiba3F_DecoNameText:
if DEF(_FR_FR)
	text "POUPEE"
	line "@"
	text_ram wStringBuffer2
	text ""
	done
else
	text "@"
	text_ram wStringBuffer2
	text " DOLL"
	done
endc

Akiba3F_ComeBackLaterText:
if DEF(_FR_FR)
	text "Reviens un autre"
	line "jour pour de"
	cont "nouveaux lots!"
	done
else
	text "Come back another"
	line "day for new"
	cont "prizes!"
	done
endc

Akiba3F_LotteryDoneText:
if DEF(_FR_FR)
	text "Notre grand jeu"
	line "est fini."
	
	para "Félicitations"
	line "pour tes gains!"
	done
else
	text "Our great giveaway"
	line "is over."

	para "Congratulations"
	line "on your gains!"
	done
endc

Akiba3F_BigPriceAnnoucementText:
if DEF(_FR_FR)
	text "Le gros lot du"
	line "@"
	text_today
	text " est un"
	cont "@"
	text_ram wStringBuffer2
	text "!"
	done
else
	text "@"
	text_today
	text "'s grand"
	line "prize is a"
	cont "@"
	text_ram wStringBuffer2
	text " DOLL!"
	done
endc

Akiba3F_InstructionsText:
if DEF(_FR_FR)
	text "Montre-moi un"
	line "@"
	text_ram wStringBuffer3
	text " et"
	cont "ce lot est à toi!"
	done
else
	text "Show me a @"
	text_ram wStringBuffer3
	text ""
	line "and it's yours!"
	done
endc

Akiba3F_VoucherDetectedText:
if DEF(_FR_FR)
	text "Je vois que tu as"
	line "un @"
	text_ram wStringBuffer3
	text "!"
	
	para "Veux-tu l'échanger"
	line "contre le lot"
	cont "du jour?"
	done
else
	text "I see you own a"
	line "@"
	text_ram wStringBuffer3
	text "!"
	
	para "Do you want to"
	line "redeem it for"
	cont "today's prize?"
	done
endc

Akiba3F_ShippingText:
if DEF(_FR_FR)
	text "Félicitations!"
	
	para "Il sera livré"
	line "chez toi sans"
	cont "délai!"
	done
else
	text "Congratulations!"

	para "It will be"
	line "shipped right to"
	cont "your home!"
	done
endc

Akiba3F_Client1Text:
if DEF(_FR_FR)
	text "Les tickets ont"
	line "été distribués par"
	cont "tirage au sort."
	
	para "Les gagnants les"
	line "revendent à un"
	cont "prix absurde."
	done
else
	text "The vouchers were"
	line "distributed"
	cont "through a lottery."

	para "Winners are"
	line "selling theirs"
	cont "for an absurd"
	cont "price."
	done
endc

Akiba3F_Client1BisText:
if DEF(_FR_FR)
	text "Si seulement"
	line "j'avais obtenu"
	cont "un ticket..."
	
	para "Trop tard"
	line "maintenant."
	done
else
	text "I wish I had"
	line "obtained a"
	cont "VOUCHER. But now"
	cont "it's too late."
	done
endc

Akiba3F_Client2Text:
if DEF(_FR_FR)
	text "Même COPIEUSE"
	line "n'a pas d'aussi"
	cont "belles poupées!"
	done
else
	text "Even COPYCAT"
	line "doesn't have such"
	cont "pretty dolls!"
	done
endc

Akiba3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, AKIBA_2F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba3F_SellerScript, -1
	object_event  4,  4, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_BIGDOLLSYM, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, Akiba3F_DollNameDisplayScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4,  4, SPRITE_BIG_ONIX, SPRITEMOVEDATA_BIGDOLLASYM, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Akiba3F_DollNameDisplayScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  4,  4, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_BIGDOLLSYM, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba3F_DollNameDisplayScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event  9,  1, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba3F_Client1Script, -1
	object_event  1,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba3F_Client2Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
