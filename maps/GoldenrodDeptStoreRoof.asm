	object_const_def
	const GOLDENRODDEPTSTOREROOF_CLERK
	const GOLDENRODDEPTSTOREROOF_POKEFAN_F
	const GOLDENRODDEPTSTOREROOF_FISHER
	const GOLDENRODDEPTSTOREROOF_TWIN
	const GOLDENRODDEPTSTOREROOF_SUPER_NERD
	const GOLDENRODDEPTSTOREROOF_POKEFAN_M
	const GOLDENRODDEPTSTOREROOF_TEACHER
	const GOLDENRODDEPTSTOREROOF_BUG_CATCHER

GoldenrodDeptStoreRoof_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .CheckSaleChangeBlock
	callback MAPCALLBACK_OBJECTS, .CheckSaleChangeClerk

.CheckSaleChangeBlock:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .SaleIsOn
	endcallback

.SaleIsOn:
	changeblock 0, 2, $3f ; cardboard boxes
	changeblock 0, 4, $0f ; vendor booth
	endcallback

.CheckSaleChangeClerk:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .ChangeClerk
	setevent EVENT_GOLDENROD_SALE_OFF
	clearevent EVENT_GOLDENROD_SALE_ON
	endcallback

.ChangeClerk:
	clearevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_GOLDENROD_SALE_ON
	endcallback

GoldenrodDeptStoreRoofClerkScript:
	opentext
	pokemart MARTTYPE_ROOFTOP, 0
	closetext
	end

GoldenrodDeptStoreRoofPokefanFScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofPokefanFText

GoldenrodDeptStoreRoofFisherScript:
	faceplayer
	opentext
	writetext GoldenrodDeptStoreRoofFisherText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_FISHER, UP
	end

GoldenrodDeptStoreRoofTwinScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofTwinText

GoldenrodDeptStoreRoofSuperNerdScript:
	opentext
	writetext GoldenrodDeptStoreRoofSuperNerdOhWowText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_SUPER_NERD, UP
	opentext
	writetext GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_SUPER_NERD, RIGHT
	end

GoldenrodDeptStoreRoofPokefanMScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofPokefanMText

GoldenrodDeptStoreRoofTeacherScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofTeacherText

GoldenrodDeptStoreRoofBugCatcherScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofBugCatcherText

Binoculars1:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, BinocularsNight
	jumptext Binoculars1Text

Binoculars2:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, BinocularsNight
	jumptext Binoculars2Text

Binoculars3:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, BinocularsNight
	jumptext Binoculars3Text

BinocularsNight:
	jumptext BinocularsNightText

Gasha0Name:
if DEF(_FR_FR)
	db "JOUR DE PLAGE@"
else
	db "BEACH TIME@"
endc

Gasha1Name:
if DEF(_FR_FR)
	db "FORET KAWAII@"
else
	db "KAWAII FOREST@"
endc

Gasha2Name:
if DEF(_FR_FR)
	db "CLUB BASTON@"
else
	db "FIGHT CLUB@"
endc

PokeDollVendingMachine0:
	loadmem wGashaID, 0
	getstring STRING_BUFFER_3, Gasha0Name
	sjump GoldenrodDeptStoreRoof_GashaScript

PokeDollVendingMachine1:
	loadmem wGashaID, 1
	getstring STRING_BUFFER_3, Gasha1Name
	sjump GoldenrodDeptStoreRoof_GashaScript

PokeDollVendingMachine2:
	loadmem wGashaID, 2
	getstring STRING_BUFFER_3, Gasha2Name
	; fallthrough.

GoldenrodDeptStoreRoof_GashaScript:
	opentext
	writetext PokeDollVendingMachineText
	yesorno
	iffalse .CloseText

.Choose:
	special PlaceMoneyTopRight
	loadmenu .MenuHeader
	callasm GetCurrentGashaCapsulesCount
	scall Gasha_QuantityIndication

	farwritetext _PlayersPCAskWhatDoText
	verticalmenu
	closewindow
	ifequal 1, .Play
	ifequal 2, .Read
	; Option3: leave.
.CloseText
	closetext
	end

.Play
	checkmoney YOUR_MONEY, 500
	ifequal HAVE_LESS, .NotEnoughMoney

	waitsfx
	takemoney YOUR_MONEY, 500
	special PlaceMoneyTopRight
	playsound SFX_TRANSACTION
	pause 15
	writetext Gasha_RotateCrank
	waitbutton
	closetext

	; Crank homemade SFX.
	waitsfx
	playsound SFX_POUND
	pause 2
	playsound SFX_POUND
	pause 2
	playsound SFX_POUND
	pause 2
	playsound SFX_POUND
	waitsfx
	pause 10
	playsound SFX_POUND
	pause 2
	playsound SFX_POUND
	pause 2
	playsound SFX_POUND
	pause 2
	playsound SFX_POUND
	waitsfx
	pause 10
	

	

	random 70
	ifequal 0, .Clogged

	callasm CurrentGashaHasRemainingCapsules
	iffalse .MachineWasEmpty
	
	callasm ReturnWonGasha
	callasm GetDecorationNameFromScript

	waitsfx
	playsound SFX_ENTER_DOOR
	pause 10

	callasm AddDecorationIfNotOwned
	opentext
	iffalse .AlreadyOwned

	; The player got a capsule they didn't own before.

	writetext Gasha_NewDecorationText
	promptbutton

	callasm GetGashaRarityInStringBuffer4
	readmem wScriptVar2
	ifequal 0, .NewSecretRarePrize
	ifequal 1, .NewGoldRarePrize
	ifequal 2, .NewSilverRarePrize

	; Common prize
	setval SFX_ITEM
	sjump .GetNewPrize

.NewSecretRarePrize
	setval SFX_GET_BADGE
	sjump .GetNewPrize

.NewGoldRarePrize
	setval SFX_GET_TM
	sjump .GetNewPrize

.NewSilverRarePrize
	setval SFX_CAUGHT_MON
	; fallthrough.

.GetNewPrize
	waitsfx
	playsound SFX_FROM_MEM
	writetext Gasha_NewDecorationSequelText
	pause 10
	waitsfx
	promptbutton

	writetext Gasha_DollSentHomeText
	promptbutton
	sjump .Choose

.AlreadyOwned
	writetext Gasha_RevealCapsuleText
	promptbutton
	sjump .Choose

.Read
	callasm GetCommonPrizesNames
	writetext Gasha_InstructionsText1
	promptbutton

	callasm GetCommonPrizesNamesSequel
	writetext Gasha_InstructionsText2
	promptbutton

	callasm GetRarePrizesNames
	writetext Gasha_InstructionsText3
	waitbutton
	sjump .Choose

.NotEnoughMoney
	farwritetext CoinVendor_NotEnoughMoneyText
	waitbutton
	sjump .CloseText

.MachineWasEmpty
	opentext
	sjump .NothingCameOut

.Clogged
	pause 20
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 5
	opentext
	writetext Gasha_CloggedText
	promptbutton
.NothingCameOut
	writetext Gasha_NothingCameOut
	waitbutton
	sjump .Choose

.MenuHeader:
	db MENU_BACKUP_TILES ; flags

if DEF(_FR_FR)
	menu_coords 11, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
else
	menu_coords 12, 3, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
if DEF(_FR_FR)
	db "JOUER@"
	db "LIRE@"
	db "PARTIR@"
else
	db "PLAY@"
	db "READ@"
	db "LEAVE@"
endc

Gasha_QuantityIndication:
	getstring STRING_BUFFER_4, .the_machine_is

	ifequal 0, .empty
	ifless 10, .almost_empty
	ifless 40, .mostly_empty
	ifless 55, .half_empty
	ifless 75, .mostly_full
	ifless 101, .almost_full
	; full
	
	writetext Gasha_FullText
	sjump .quit

.empty
	writetext Gasha_EmptyText
	sjump .quit

.almost_empty
	writetext Gasha_AlmostEmptyText
	sjump .quit

.mostly_empty
	writetext Gasha_MostlyEmptyText
	sjump .quit

.half_empty
	writetext Gasha_HalfEmptyText
	sjump .quit

.mostly_full
	writetext Gasha_MostlyFullText
	sjump .quit

.almost_full
	writetext Gasha_AlmostFullText
	; fallthrough.

.quit
	promptbutton
	end

.the_machine_is
if DEF(_FR_FR)
	db "La machine est@"
else
	db "The machine is@"
endc

GoldenrodDeptStoreRoofPokefanFText: 
if DEF(_FR_FR)
	text "Fouiiii!"

	para "Je vais souvent"
	line "sur le toit pour"

	para "me reposer après"
	line "les courses."
else
	text "Whew, I'm tired."

	para "I sometimes come"
	line "up to the rooftop"

	para "to take a break"
	line "from shopping."
endc

	done

GoldenrodDeptStoreRoofFisherText: 
if DEF(_FR_FR)
	text "Pardon?"
	line "Comment ça un"
	cont "adulte n'a pas le"
	cont "droit de faire ça?"

	para "Je veux toutes"
	line "les poupées!"
else
	text "Pardon? Who says"
	line "an adult can't get"
	cont "into this?"

	para "I'm going to be"
	line "back every day to"

	para "collect all the"
	line "dolls!"
endc

	done

GoldenrodDeptStoreRoofTwinText: 
if DEF(_FR_FR)
	text "Ils font des"
	line "prix spéciaux ici"
	cont "de temps en temps."
else
	text "They have bargain"
	line "sales here every"
	cont "so often."
endc

	done

GoldenrodDeptStoreRoofSuperNerdOhWowText: 
if DEF(_FR_FR)
	text "Oh!"
else
	text "Oh, wow!"
endc

	done

GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText: 
if DEF(_FR_FR)
	text "Tu me lâches,"
	line "ouais?"
else
	text "Will you quit"
	line "bothering me?"
endc

	done

GoldenrodDeptStoreRoofPokefanMText: 
if DEF(_FR_FR)
	text "Je veux acheter un"
	line "truc mais je n'ai"

	para "pas assez d'argent"
	line "sur moi..."

	para "Je vais peut-être"
	line "vendre les BAIES"
	cont "que j'ai trouvées."
else
	text "There's something"
	line "I really want, but"

	para "I don't have the"
	line "necessary cash…"

	para "Maybe I'll sell"
	line "off the BERRIES"
	cont "I've collected…"
endc

	done

GoldenrodDeptStoreRoofTeacherText:
if DEF(_FR_FR)
	text "Oh! Tout est si"
	line "attrayant!"

	para "Mon SAC est plein"
	line "à craquer!"
	done
else
	text "Oh, everything is"
	line "interesting!"

	para "I bought so much,"
	line "my PACK's crammed!"
	done
endc

GoldenrodDeptStoreRoofBugCatcherText: 
if DEF(_FR_FR)
	text "Mes #MON sont"
	line "toujours empoison-"

	para "nés ou paralysés"
	line "au mauvais moment."

	para "Je vais donc ache-"
	line "ter TOTAL SOIN."

	para "Il en reste,"
	line "tu crois?"
else
	text "My #MON always"
	line "get paralyzed or"

	para "poisoned when the"
	line "chips are down…"

	para "So I came to buy"
	line "some FULL HEAL."

	para "I wonder if"
	line "there's any left?"
endc

	done

Binoculars1Text: 
if DEF(_FR_FR)
	text "Je vois loin avec"
	line "ces jumelles."

	para "Je vois presque"
	line "ma maison."

	para "C'est celle avec"
	line "le toit vert?"
else
	text "These binoculars"
	line "let me see far"

	para "away. Maybe I can"
	line "see my own house."

	para "Is it the one with"
	line "the green roof?"
endc

	done

Binoculars2Text: 
if DEF(_FR_FR)
	text "Hé! Des dresseurs"
	line "se battent sur"
	cont "la route!"

	para "Un #MON crache"
	line "des feuilles!"

	para "Ca me donne envie"
	line "de combattre!"
else
	text "Hey! Some trainers"
	line "are battling on"
	cont "the road!"

	para "A #MON fired a"
	line "flurry of leaves!"

	para "That makes me feel"
	line "like battling"
	cont "right now!"
endc

	done

BinocularsNightText:
if DEF(_FR_FR)
	text "Il fait trop"
	line "sombre pour y"
	cont "voir..."
	done
else
	text "It's too dark"
	line "to see anything…"
	done
endc

Binoculars3Text: 
if DEF(_FR_FR)
	text "Un PECHEUR a"
	line "attrapé des"
	cont "MAGICARPE..."

	para "Ils font tous"
	line "TREMPETTE!"

	para "Y'a de l'eau"
	line "partout!"
else
	text "A FISHER caught a"
	line "lot of MAGIKARP…"

	para "They're SPLASHing"
	line "at the same time!"

	para "Look at the water"
	line "going everywhere!"
endc

	done

PokeDollVendingMachineText: 
if DEF(_FR_FR)
	text "Une machine à"
	line "poupées #MON"
	cont "“@"
	text_ram wStringBuffer3
	text "”."

	para "Voulez-vous tenter"
	line "votre chance?"
else
	text "A vending machine"
	line "for #MON dolls"
	cont "“@"
	text_ram wStringBuffer3
	text "”."

	para "Do you want to"
	line "try your luck?"
endc

	done

Gasha_EmptyText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "vide..."
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "empty…"
endc
	done

Gasha_AlmostEmptyText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "presque vide!"
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "almost empty!"
endc
	done

Gasha_MostlyEmptyText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "assez vide."
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "mostly empty."
endc
	done

Gasha_HalfEmptyText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "à moitié vide."
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "half empty."
endc
	done

Gasha_MostlyFullText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "assez pleine."
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "mostly full."
endc
	done

Gasha_AlmostFullText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "presque pleine."
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "almost full."
endc
	done

Gasha_FullText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "pleine!"
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "full!"
endc
	done

Gasha_InstructionsText1:
if DEF(_FR_FR)
	text "500¥ / capsule."
	
	para "“@"
	text_ram wStringBuffer3
	text "”"
	line "contient:"

	para "88 capsules"
	line "communes"
	cont "-@"
	text_ram wStringBuffer4
	text_start
else
	text "¥500 / capsule."
	
	para "“@"
	text_ram wStringBuffer3
	text "”"
	line "contains:"

	para "88 common capsules"
	line "-@"
	text_ram wStringBuffer4
	text_start
endc
	cont "-@"
	text_ram wStringBuffer5
	text_start
	done

Gasha_InstructionsText2:
	text "-@"
	text_ram wStringBuffer4
	text_start
	line "-@"
	text_ram wStringBuffer5
	text_start
	done

Gasha_InstructionsText3:
if DEF(_FR_FR)
	text "8 capsules de"
	line "rareté argent"
	cont "-@"
	text_ram wStringBuffer4
	text_start

	para "3 capsules de"
	line "rareté or"
	cont "-@"
	text_ram wStringBuffer5
	text_start

	para "1 capsule secrète"
	line "-???"
else
	text "8 silver rare"
	line "capsules"
	cont "-@"
	text_ram wStringBuffer4
	text_start

	para "3 gold rare"
	line "capsules"
	cont "-@"
	text_ram wStringBuffer5
	text_start

	para "1 secret rare"
	line "capsule"
	cont "-???"
endc
	done

Gasha_RotateCrank:
if DEF(_FR_FR)
	text "<PLAYER> tourne"
	line "la manivelle."
else
	text "<PLAYER> turns"
	line "the crank."
endc
	done

Gasha_CloggedText:
if DEF(_FR_FR)
	text "Hé! La machine"
	line "s'est coincée!"
else
	text "Hey! The machine"
	line "jammed!"
endc
	done

Gasha_NothingCameOut:
if DEF(_FR_FR)
	text "Rien n'est sorti."
else
	text "Nothing came out."
endc
	done

Gasha_RevealCapsuleText:
if DEF(_FR_FR)
	text "Poc! C'est une"
	line "@"
	text_ram wStringBuffer2
	text "."
else
	text "Plop! It's a"
	line "@"
	text_ram wStringBuffer2
	text "."
endc
	done

Gasha_NewDecorationText:
if DEF(_FR_FR)
	text "Poc!"
	line "... Hé!"
	
	para "C'est une"
	line "nouvelle!"
else
	text "Plop!"
	line "... Hey!"

	para "You didn't have"
	line "this one!"
endc
	done

Gasha_NewDecorationSequelText:
if DEF(_FR_FR)
	text "@"
	text_ram wStringBuffer4
	text_start
	line "@"
	text_ram wStringBuffer2
	text "!"
else
	text "@"
	text_ram wStringBuffer4
	text_start
	line "@"
	text_ram wStringBuffer2
	text "!"
endc
	done

Gasha_DollSentHomeText:
if DEF(_FR_FR)
	text "Elle a été envoyée"
	line "au PC à la maison."
else
	text "It's been sent to"
	line "your home PC."
endc
	done

GoldenrodDeptStoreRoof_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13,  1, GOLDENROD_DEPT_STORE_6F, 3

	def_coord_events

	def_bg_events
	bg_event 15,  3, BGEVENT_RIGHT, Binoculars1
	bg_event 15,  5, BGEVENT_RIGHT, Binoculars2
	bg_event 15,  6, BGEVENT_RIGHT, Binoculars3
	bg_event  1,  1, BGEVENT_LEFT, PokeDollVendingMachine0
	bg_event  2,  0, BGEVENT_UP, PokeDollVendingMachine1
	bg_event  3,  0, BGEVENT_UP, PokeDollVendingMachine2

	def_object_events
	object_event  1,  4, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofClerkScript, EVENT_GOLDENROD_SALE_OFF
	object_event 10,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofPokefanFScript, -1
	object_event  2,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, DAY, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofFisherScript, -1
	object_event  3,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofTwinScript, EVENT_GOLDENROD_SALE_ON
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofSuperNerdScript, EVENT_GOLDENROD_SALE_ON
	object_event  7,  0, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofPokefanMScript, EVENT_GOLDENROD_SALE_OFF
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofTeacherScript, EVENT_GOLDENROD_SALE_OFF
	object_event  1,  6, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofBugCatcherScript, EVENT_GOLDENROD_SALE_OFF
