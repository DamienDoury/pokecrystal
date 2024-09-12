	object_const_def
	const AKIBA1F_FAMICOM
	const AKIBA1F_VBOY
	const AKIBA1F_SNES
	const AKIBA1F_N64
	const AKIBA1F_SELLER
	const AKIBA1F_NOTE
	const AKIBA1F_REPAIR_N64

Akiba1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .LoadTiles

.LoadTiles:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue .endcallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.endcallback
	endcallback

Akiba1F_FamicomBuyScript:
	jumptext Akiba1F_FamicomBuyText

Akiba1F_SNESBuyScript:
	jumptext Akiba1F_SNESBuyText

Akiba1F_VirtualBoyBuyScript:
	jumptext Akiba1F_VirtualBoyBuyText

Akiba1F_N64BuyScript:
	jumptext Akiba1F_N64BuyText

Akiba1F_BeRightBackScript:
	jumptext Akiba1F_BeRightBackText

Akiba1F_Seller_Script:
	faceplayer
	opentext
	writetext Akiba1F_Seller_HiText
	promptbutton

	checkflag ENGINE_RADIO_CARD
	iftrue .SkipRadioGift

	checkevent EVENT_FETCH_RADIO_CARD
	iftrue .FetchRadio

.SkipRadioGift
	writetext Akiba1F_Seller_HiEndText
	waitbutton
	closetext
	pause 10
	turnobject AKIBA1F_SELLER, UP
	end

.FetchRadio
	closetext
	pause 5
	showemote EMOTE_QUESTION, AKIBA1F_SELLER, 15
	pause 5
	opentext
	writetext Akiba1F_Seller_RadioText
	promptbutton
	getstring STRING_BUFFER_4, .RadioCardText
	callstd ReceiveItemScript
	farwritetext RadioTower1FPokegearIsARadioText
	waitbutton
	setflag ENGINE_RADIO_CARD
	clearevent EVENT_FETCH_RADIO_CARD
	closetext
	end

.RadioCardText:
	db "RADIO CARD@"

Akiba1F_FamicomBuyText:
	text "Famicom"
	done

Akiba1F_SNESBuyText:
	text "Super NES"
	done

Akiba1F_VirtualBoyBuyText:
	text "Virtual Boy"
	done

Akiba1F_N64BuyText:
	text "Nintendo 64"
	done

Akiba1F_BeRightBackText:
	text "I'm in CELADON,"
	line "I'll be right back."
	done

Akiba1F_Seller_HiText:
	text "Oh hi!"

	para "We met at "
	line "GAME FREAK's,"
	cont "remember me?"
	done

Akiba1F_Seller_HiEndText:
	text "Feel free to snoop"
	line "around my shop!"
	done

Akiba1F_Seller_RadioText:
	text "My friend the"
	line "MUSIC DIRECTOR"
	cont "sent you? I see."

	para "Here's a RADIO CARD"
	line "for your #GEAR,"
	cont "free of charge!"
	done

Akiba1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, SAFFRON_CITY, 18
	warp_event  7,  9, SAFFRON_CITY, 18
	warp_event 11,  0, AKIBA_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  2, SPRITE_FAMICOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_FamicomBuyScript, -1
	object_event  1,  3, SPRITE_VIRTUAL_BOY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_VirtualBoyBuyScript, -1
	object_event  6,  3, SPRITE_SNES, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_SNESBuyScript, -1
	object_event  3,  3, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_N64BuyScript, -1
	object_event  4,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba1F_Seller_Script, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  5,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_BeRightBackScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4,  1, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CONSOLE_SELLER_BACK_IN_STORE
