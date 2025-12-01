UNDERGROUNDPATH_FAKE_ID_PRICE   EQU 60000
UNDERGROUNDPATH_VOUCHER_PRICE   EQU 40000

	object_const_def
	const UNDERGROUNDPATH_BURGLAR

UndergroundPath_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .DisplayVoucherSeller

.DisplayVoucherSeller:
	farscall Akiba3F_HaveAllBigDollsBeenSold
	iffalse .end_callback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Show the voucher seller.

.end_callback
	endcallback

UndergroundPathTrainerBurglarEddy:
	trainer BURGLAR, EDDY, EVENT_BEAT_BURGLAR_EDDY, BurglarEddySeenText, BurglarEddyBeatenText, 0, .Script

.Script:
	;endifjustbattled
	opentext
	writetext BurglarEddySellText
	promptbutton

	checkflag ENGINE_TRAINER_CARD ; Note that EVENT_GOT_FAKE_ID sets the ENGINE_TRAINER_CARD flag.
	iftrue .GotYourOwn
	
	special PlaceMoneyTopRight
	writetext BurglarEddySellText2
	yesorno
	iffalse .Refused

	checkmoney YOUR_MONEY, UNDERGROUNDPATH_FAKE_ID_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney

	takemoney YOUR_MONEY, UNDERGROUNDPATH_FAKE_ID_PRICE
	waitsfx
	playsound SFX_TRANSACTION
	pause 15
	special PlaceMoneyTopRight

	getstring STRING_BUFFER_4, .FakeIDText
	callstd ReceiveItemScript

	setevent EVENT_GOT_FAKE_ID
	setflag ENGINE_TRAINER_CARD
	writetext BurglarEddySoldText
	waitbutton
	closetext

	readvar VAR_FACING
	ifnotequal DOWN, .TeleportOut

	applymovement UNDERGROUNDPATH_BURGLAR, .StepLeftMovement
.TeleportOut
	playsound SFX_WARP_TO
	applymovement UNDERGROUNDPATH_BURGLAR, .TeleportMovement
	disappear UNDERGROUNDPATH_BURGLAR
	end

.StepLeftMovement
	step LEFT
	step_end

.TeleportMovement
	teleport_from
	step_end

.GotYourOwn
	writetext BurglarEddyWrongClientText
.WaitCloseText
	waitbutton
	closetext
	end

.FakeIDText
if DEF(_FR_FR)
	db "FAUSSE CARTE ID@"
else
	db "FAKE TRAINER CARD@"
endc

.NotEnoughMoney
	writetext BurglarEddyNotEnoughMoneyText
	sjump .WaitCloseText

.Refused
	writetext BurglarEddyTurnedDownText
	sjump .WaitCloseText

UndergroundPathVoucherSellerScript:
	faceplayer
	opentext
	writetext VoucherSellerIntroText
	promptbutton
	special PlaceMoneyTopRight
	writetext VoucherSellerPriceText
	yesorno
	iffalse .Refused

	checkmoney YOUR_MONEY, UNDERGROUNDPATH_VOUCHER_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney

	giveitem VOUCHER
	iffalse .NoRoom

	takemoney YOUR_MONEY, UNDERGROUNDPATH_VOUCHER_PRICE
	waitsfx
	playsound SFX_TRANSACTION
	pause 15
	special PlaceMoneyTopRight

	getitemname STRING_BUFFER_4, VOUCHER
	callstd ReceiveItemScript

	writetext VoucherSellerFewMoreText
.TextEnd
	waitbutton
.CloseText
	closetext
	end

.NoRoom
	farwritetext CeladonPrizeRoom_NotEnoughRoomText
	sjump .TextEnd

.NotEnoughMoney
	farwritetext Akiba1F_NotEnoughMoneyText
	sjump .TextEnd

.Refused
	writetext VoucherSellerRefusedText
	sjump .TextEnd

BurglarEddySeenText:
if DEF(_FR_FR)
	text "Montre-moi"
	line "c'que t'as."
else
	text "Show me what"
	line "you got."
endc
	done

BurglarEddyBeatenText:
if DEF(_FR_FR)
	text "Je devais m'assurer"
	line "que t'étais pas de"
	cont "la police."
else
	text "I needed to make"
	line "sure you're no"
	cont "police member."
endc
	done

BurglarEddySellText:
if DEF(_FR_FR)
	text "Ca t'intéresse une"
	line "CARTE DRESSEUR"
	cont "avec un PASS"
	cont "VACCINAL?"
else
	text "Want a TRAINER"
	line "CARD with a"
	cont "VACCINE PASSPORT?"
endc
	done

BurglarEddyWrongClientText:
if DEF(_FR_FR)
	text "Ah, t'as déjà la"
	line "tienne, je vois."
	cont "T'es pas ma cible."
else
	text "Oh, you've got your"
	line "own, I see."
	cont "Wrong client."
endc
	done

BurglarEddySellText2:
if DEF(_FR_FR)
	text "Je la vends pour"
	line "{d:UNDERGROUNDPATH_FAKE_ID_PRICE}¥."
else
	text "I'm selling it for"
	line "¥{d:UNDERGROUNDPATH_FAKE_ID_PRICE}."
endc
	done

BurglarEddyTurnedDownText:
if DEF(_FR_FR)
	text "Si tu connais des"
	line "antivax intéressés"
	
	para "dis-leur que je"
	line "suis ici."
else
	text "If you know anti-"
	line "vaxxers that are"

	para "interested, tell"
	line "them I'm here."
endc
	done

BurglarEddyNotEnoughMoneyText:
if DEF(_FR_FR)
	text "J'suis pas une"
	line "oeuvre de charité!"
	
	para "Va récolter du"
	line "fric."
else
	text "I'm not a charity."
	line "Get enough money."
endc
	done

BurglarEddySoldText:
if DEF(_FR_FR)
	text "Y'a mon nom dessus"
	line "mais... ça devrait"
	cont "passer dans la"
	cont "plupart des cas."
	
	para "Bon, faut que"
	line "j'aille ferrer"
	cont "un autre antivax."
else
	text "It's my name on it"
	line "but… you'll be fine"
	cont "in most cases."

	para "Okay, gotta go"
	line "find another"
	cont "anti-vaxxer."
endc
	done

VoucherSellerIntroText:
if DEF(_FR_FR)
	text "Hey! Tu veux un"
	line "TICK.GAGNANT?"
else
	text "Hey! Want a"
	line "VOUCHER?"
endc
	done

VoucherSellerPriceText:
if DEF(_FR_FR)
	text "{d:UNDERGROUNDPATH_VOUCHER_PRICE}¥ pour un."
	line "T'en dis quoi?"
else
	text "¥{d:UNDERGROUNDPATH_VOUCHER_PRICE} for one."
	line "What do you say?"
endc
	done

VoucherSellerRefusedText:
if DEF(_FR_FR)
	text "Mon prix est"
	line "honnête."
	
	para "Ces tickets sont"
	line "super rares, et"
	
	para "ils ne sont plus"
	line "distribués."
else
	text "My price is fair."

	para "These are super"
	line "rare, and you can't"
	cont "win them anymore."
endc
	done

VoucherSellerFewMoreText:
if DEF(_FR_FR)
	text "Si t'en veux un"
	line "autre, il m'en"
	
	para "reste encore"
	line "quelques-uns."
else
	text "If you need an"
	line "other one, I still"
	cont "have a few more."
endc
	done

UndergroundPathHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_UNDERGROUND_PATH_HIDDEN_FULL_RESTORE

UndergroundPathHiddenXSpecial:
	hiddenitem X_SPECIAL, EVENT_UNDERGROUND_PATH_HIDDEN_X_SPECIAL

UndergroundPath_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  2, ROUTE_5_UNDERGROUND_PATH_ENTRANCE, 3
	warp_event  3, 36, ROUTE_6_UNDERGROUND_PATH_ENTRANCE, 3

	def_coord_events

	def_bg_events
	bg_event  1, 14, BGEVENT_ITEM, UndergroundPathHiddenFullRestore
	bg_event  1, 38, BGEVENT_ITEM, UndergroundPathHiddenXSpecial

	def_object_events
	object_event  4, 19, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, UndergroundPathTrainerBurglarEddy, EVENT_BURGLAR_EDDY_LEFT
	object_event  1, 30, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, UndergroundPathVoucherSellerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
