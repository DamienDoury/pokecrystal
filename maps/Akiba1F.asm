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
	waitbutton
	closetext
	pause 10
	turnobject AKIBA1F_SELLER, UP
	end

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
	text "Be right back."
	done

Akiba1F_Seller_HiText:
	text "Oh hi!"
	done

Akiba1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  9, SAFFRON_CITY, 18
	warp_event  4,  9, SAFFRON_CITY, 18
	warp_event  0,  0, AKIBA_3F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  2, SPRITE_FAMICOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_FamicomBuyScript, -1
	object_event  7,  3, SPRITE_VIRTUAL_BOY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_VirtualBoyBuyScript, -1
	object_event  5,  3, SPRITE_SNES, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_SNESBuyScript, -1
	object_event  9,  3, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_N64BuyScript, -1
	object_event  6,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba1F_Seller_Script, -1
	object_event  4,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_BeRightBackScript, -1
	object_event  6,  1, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
