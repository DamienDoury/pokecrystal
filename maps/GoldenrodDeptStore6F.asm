GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE EQU 200
GOLDENRODDEPTSTORE6F_SODA_POP_PRICE    EQU 300
GOLDENRODDEPTSTORE6F_LEMONADE_PRICE    EQU 350

	object_const_def
	const GOLDENRODDEPTSTORE6F_LASS
	const GOLDENRODDEPTSTORE6F_SUPER_NERD
	const GOLDENRODDEPTSTORE6F_CARRIE
	const GOLDENRODDEPTSTORE6F_CONE

GoldenrodDeptStore6F_MapScripts:
	def_scene_scripts
	scene_script DeptStoreEnterLockdownCheck ; SCENE_ALWAYS

	def_callbacks

Carrie:
	faceplayer
	opentext
	special GameboyCheck
	ifnotequal GBCHECK_CGB, .NotGBC ; This is a dummy check from Gold/Silver
	writetext GoldenrodDeptStore5FCarrieMysteryGiftExplanationText
	waitbutton
	closetext
	special UnlockMysteryGift
	end

.NotGBC:
	writetext GoldenrodDeptStore5FCarrieMysteryGiftRequiresGBCText
	waitbutton
	closetext
	end

GoldenrodVendingMachine:
	opentext
	writetext GoldenrodVendingText
	loadmem wMenuCursorPositionBackup, 1
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .FreshWater
	ifequal 2, .SodaPop
	ifequal 3, .Lemonade
	closetext
	end

.FreshWater:
	loadmem wMenuCursorPositionBackup, 1
	checkmoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem FRESH_WATER
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE
	getitemname STRING_BUFFER_3, FRESH_WATER
	sjump .VendItem

.SodaPop:
	loadmem wMenuCursorPositionBackup, 2
	checkmoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_SODA_POP_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem SODA_POP
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_SODA_POP_PRICE
	getitemname STRING_BUFFER_3, SODA_POP
	sjump .VendItem

.Lemonade:
	loadmem wMenuCursorPositionBackup, 3
	checkmoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_LEMONADE_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem LEMONADE
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_LEMONADE_PRICE
	getitemname STRING_BUFFER_3, LEMONADE
	sjump .VendItem

.VendItem:
	pause 10
	playsound SFX_ENTER_DOOR
	writetext GoldenrodClangText
	promptbutton
	itemnotify
	sjump .Start

.NotEnoughMoney:
	writetext GoldenrodVendingNoMoneyText
	waitbutton
	sjump .Start

.NotEnoughSpace:
	writetext GoldenrodVendingNoSpaceText
	waitbutton
	sjump .Start

.MenuHeader:
	db MENU_BACKUP_TILES | MENU_USE_BACKUP_AS_START_POS ; flags
	menu_coords 0, 2, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "EAU FRAICHE  {d:GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE}¥@"
	db "RAMUNE       {d:GOLDENRODDEPTSTORE6F_SODA_POP_PRICE}¥@"
	db "THE AU LAIT  {d:GOLDENRODDEPTSTORE6F_LEMONADE_PRICE}¥@"
	db "RETOUR@"
else
	db "FRESH WATER  ¥{d:GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE}@"
	db "RAMUNE       ¥{d:GOLDENRODDEPTSTORE6F_SODA_POP_PRICE}@"
	db "MILK TEA     ¥{d:GOLDENRODDEPTSTORE6F_LEMONADE_PRICE}@"
	db "CANCEL@"
endc

GoldenrodDeptStore6FLassScript:
	jumptextfaceplayer GoldenrodDeptStore6FLassText

GoldenrodDeptStore6FSuperNerdScript:
	jumptextfaceplayer GoldenrodDeptStore6FSuperNerdText

GoldenrodDeptStore6FDirectory:
	jumptext GoldenrodDeptStore6FDirectoryText

GoldenrodDeptStore6FElevatorButton:
	jumpstd ElevatorButtonScript

GoldenrodVendingText: 
if DEF(_FR_FR)
	text "Un distributeur"
	line "automatique!"
	cont "Voilà le menu."
else
	text "A vending machine!"
	line "Here's the menu."
endc

	done

GoldenrodClangText: 
if DEF(_FR_FR)
	text "Cling!"
	line "Une boîte de"
	cont "@"
	text_ram wStringBuffer3
	text_start
	cont "est sortie!"
else
	text "Clang! A can of"
	line "@"
	text_ram wStringBuffer3
	text_start
	cont "popped out!"
endc

	done

GoldenrodVendingNoMoneyText: 
if DEF(_FR_FR)
	text "Oups, pas assez"
	line "d'argent."
else
	text "Oops, not enough"
	line "money."
endc

	done

GoldenrodVendingNoSpaceText: 
if DEF(_FR_FR)
	text "Il n'y a plus de"
	line "place."
else
	text "There's no more"
	line "room for stuff."
endc

	done

GoldenrodDeptStore6FLassText: 
if DEF(_FR_FR)
	text "Ecoutes-tu"
	line "L'ANTENNE DE LA"
	cont "CHANCE?"

	para "Si tu veux gagner,"
	line "échange un maximum"

	para "de #MON avec le"
	line "plus de personnes"

	para "possibles pour"
	line "avoir un max de"
	cont "numéros ID"
	cont "différents."
else
	text "Do you listen to"
	line "LUCKY CHANNEL?"

	para "If you want to"
	line "win, trade #MON"

	para "with as many peo-"
	line "ple as possible to"

	para "get different ID"
	line "numbers."
endc

	done

GoldenrodDeptStore6FSuperNerdText: 
if DEF(_FR_FR)
	text "Si tu es naze,"
	line "sers-toi du"
	cont "distributeur auto-"
	cont "matique."

	para "Ton #MON"
	line "appréciera aussi."
else
	text "If you're tired,"
	line "try the vending"
	cont "machine's drinks."

	para "Your #MON will"
	line "love them too."
endc

	done

GoldenrodDeptStore6FDirectoryText: 
if DEF(_FR_FR)
	text "Une petite pause!"

	para "5EME COIN"
	line "     TRANQUILLE"
else
	text "Take a Break from"
	line "Shopping!"

	para "6F TRANQUIL SQUARE"
endc

	done

GoldenrodDeptStore5FCarrieMysteryGiftExplanationText: 
if DEF(_FR_FR)
	text "Le CADEAU MYSTERE."

	para "Au bip..."
	line "Un cadeau!"
else
	text "MYSTERY GIFT."

	para "With just a"
	line "little beep, you"
	cont "get a gift."
endc

	done

GoldenrodDeptStore5FCarrieMysteryGiftRequiresGBCText: 
if DEF(_FR_FR)
	text "L'option CADEAU"
	line "MYSTERE nécessite"
	cont "une GameBoy Color."
else
	text "The MYSTERY GIFT"
	line "option requires a"
	cont "Game Boy Color."
endc

	done

GoldenrodDeptStore6F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 15,  0, GOLDENROD_DEPT_STORE_5F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1
	warp_event 13,  0, GOLDENROD_DEPT_STORE_ROOF, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore6FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore6FElevatorButton
	bg_event  8,  1, BGEVENT_UP, GoldenrodVendingMachine
	bg_event  9,  1, BGEVENT_UP, GoldenrodVendingMachine
	bg_event 10,  1, BGEVENT_UP, GoldenrodVendingMachine
	bg_event 11,  1, BGEVENT_UP, GoldenrodVendingMachine

	def_object_events
	object_event 10,  2, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore6FLassScript, -1
	object_event  8,  2, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore6FSuperNerdScript, -1
	object_event  6,  1, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Carrie, -1
	object_event 15,  1, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore_Lockdown, -1
