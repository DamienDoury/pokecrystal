BED_PRICE EQU 5000

	object_const_def
	const BEDSHOP_SELLER
	const BEDSHOP_BED_2
	const BEDSHOP_BED_2_BIS
	const BEDSHOP_BED_3
	const BEDSHOP_BED_3_BIS
	const BEDSHOP_BED_4
	const BEDSHOP_BED_4_BIS

BedShop_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .DisplayBeds

.DisplayBeds:
	setlasttalked 0

; polkadot bed
	checkevent EVENT_DECO_BED_3
	iffalse .pikachu_bed

	scall BedShop_HidePolkadotBed

.pikachu_bed
	checkevent EVENT_DECO_BED_4
	iffalse .pink_bed

	scall BedShop_HidePikachuBed

.pink_bed
	checkevent EVENT_DECO_BED_2
	iffalse .end

	scall BedShop_HidePinkBed

.end
	endcallback

BedShop_HidePolkadotBed:
	changeblock 2, 2, $01 ; floor
	end

BedShop_HidePikachuBed:
	changeblock 0, 2, $01 ; floor
	end

BedShop_HidePinkBed:
	changeblock 4, 2, $01 ; floor
	end

BedShop_SellerScript:
	faceobject BEDSHOP_SELLER, PLAYER
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .skip_welcome

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	writetext BedShop_WelcomeText
	promptbutton

.skip_welcome
	readmem hLastTalked
	ifequal BEDSHOP_BED_2 - 1,     .polkadot
	ifequal BEDSHOP_BED_2_BIS - 1, .polkadot
	ifequal BEDSHOP_BED_3 - 1,     .pikachu
	ifequal BEDSHOP_BED_3_BIS - 1, .pikachu
	ifequal BEDSHOP_BED_4 - 1,     .pink
	ifequal BEDSHOP_BED_4_BIS - 1, .pink

; No bed was looked at.
	checkevent EVENT_DECO_BED_2
	iffalse .look_around

	checkevent EVENT_DECO_BED_3
	iffalse .look_around

	checkevent EVENT_DECO_BED_4
	iffalse .look_around

; Nothing else to sell.
	writetext BedShop_SoldOutText
	sjump .text_end

.look_around
	writetext BedShop_LookAroundText
.text_end
	waitbutton
	closetext
.end
	end

.polkadot
	setval DECO_POLKADOT_BED
	sjump .offer

.pikachu
	setval DECO_PIKACHU_BED
	sjump .offer

.pink
	setval DECO_PINK_BED
	
.offer
	callasm GetDecorationNameFromScript
	writetext BedShop_OfferText
	setval BED_PRICE / 1000
	farscall Akiba1F_BuyingProcess
;	appear LAST_TALKED
	iffalse .end

	; If the transaction was successfull, we need to hide the bed.
	readmem hLastTalked
	ifequal BEDSHOP_BED_2 - 1,     .hide_polkadot
	ifequal BEDSHOP_BED_2_BIS - 1, .hide_polkadot
	ifequal BEDSHOP_BED_3 - 1,     .hide_pikachu
	ifequal BEDSHOP_BED_3_BIS - 1, .hide_pikachu
	ifequal BEDSHOP_BED_4 - 1,     .hide_pink
	ifequal BEDSHOP_BED_4_BIS - 1, .hide_pink
	sjump .end

.hide_polkadot
	disappear BEDSHOP_BED_2
	disappear BEDSHOP_BED_2_BIS
	scall BedShop_HidePolkadotBed
	sjump .reload_map

.hide_pikachu
	disappear BEDSHOP_BED_3
	disappear BEDSHOP_BED_3_BIS
	scall BedShop_HidePikachuBed
	sjump .reload_map

.hide_pink
	disappear BEDSHOP_BED_4
	disappear BEDSHOP_BED_4_BIS
	scall BedShop_HidePinkBed
	sjump .reload_map

.reload_map
	reloadmappart
	setlasttalked BEDSHOP_SELLER
	sjump .end

BedShop_Poster:
	jumptext BedShop_PosterText

BedShop_PolkadotBedScript:
	setval DECO_POLKADOT_BED
	farsjump DisplayDecoNameScript

BedShop_PikachuBedScript:
	setval DECO_PIKACHU_BED
	farsjump DisplayDecoNameScript

BedShop_PinkBedScript:
	setval DECO_PINK_BED
	farsjump DisplayDecoNameScript
	
BedShop_OfferText: ; TO TRANSLATE
	text "So you like the"
	line "@"
	text_ram wStringBuffer2
	text "!"

	para "It's my favorite"
	line "too!"

	para "It's priced at"
	line "¥{d:BED_PRICE}."
	done

BedShop_WelcomeText: ; TO TRANSLATE
	text "Welcome to our"
	line "store!"
	done

BedShop_LookAroundText: ; TO TRANSLATE
	text "Please check out"
	line "our beds, then"

	para "come back to tell"
	line "me which one"
	cont "you prefer."
	done

BedShop_SoldOutText: ; TO TRANSLATE
	text "We are thrilled by"
	line "our success!"
	cont "We are sold out!"
	done

BedShop_PosterText: ; TO TRANSLATE
	text "Best beds in town!"
	done

BedShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 10
	warp_event  3,  7, CELADON_CITY, 10

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, BedShop_Poster
	bg_event  5,  6, BGEVENT_READ, BedShop_SellerScript
	bg_event  4,  7, BGEVENT_READ, BedShop_SellerScript

	def_object_events
	object_event  5,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  2,  2, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BedShop_PolkadotBedScript, EVENT_DECO_BED_3
	object_event  2,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BedShop_PolkadotBedScript, EVENT_DECO_BED_3
	object_event  0,  2, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BedShop_PikachuBedScript, EVENT_DECO_BED_4
	object_event  0,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BedShop_PikachuBedScript, EVENT_DECO_BED_4
	object_event  4,  2, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BedShop_PinkBedScript, EVENT_DECO_BED_2
	object_event  4,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BedShop_PinkBedScript, EVENT_DECO_BED_2
