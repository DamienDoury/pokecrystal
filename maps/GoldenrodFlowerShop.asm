PLANT_PRICE EQU 2000

	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA
	const GOLDENRODFLOWERSHOP_MAGNAPLANT
	const GOLDENRODFLOWERSHOP_TROPICPLANT
	const GOLDENRODFLOWERSHOP_JUMBOPLANT

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .DisplayPlants

.DisplayPlants:
	setlasttalked 0
	loadmem wSelectedPlant, 0

	checkevent EVENT_ROUTE_36_SUDOWOODO
	iffalse .hide_all

; magna plant
	checkevent EVENT_DECO_PLANT_1
	iffalse .tropic_plant

	scall GoldenrodFlowerShop_HideMagnaPlant

.tropic_plant
	checkevent EVENT_DECO_PLANT_2
	iffalse .jumbo_plant

	scall GoldenrodFlowerShop_HideTropicPlant

.jumbo_plant
	checkevent EVENT_DECO_PLANT_3
	iffalse .end

	scall GoldenrodFlowerShop_HideJumboPlant

.end
	endcallback

.hide_all
	scall GoldenrodFlowerShop_HideMagnaPlant
	scall GoldenrodFlowerShop_HideTropicPlant
	scall GoldenrodFlowerShop_HideJumboPlant
	endcallback

GoldenrodFlowerShop_HideMagnaPlant:
	disappear GOLDENRODFLOWERSHOP_MAGNAPLANT
	changeblock 2, 2, $0f
	end

GoldenrodFlowerShop_HideTropicPlant:
	disappear GOLDENRODFLOWERSHOP_TROPICPLANT
	changeblock 0, 6, $06
	end

GoldenrodFlowerShop_HideJumboPlant:
	disappear GOLDENRODFLOWERSHOP_JUMBOPLANT
	changeblock 6, 2, $2f
	changeblock 6, 4, $07
	end

FlowerShopTeacherScript:
	opentext
	checkevent EVENT_ROUTE_36_SUDOWOODO
	iftrue .PostLockdown

	faceplayer
	checkitem SQUIRTBOTTLE
	iftrue .GotSquirtbottle
	checkevent EVENT_MET_FLORIA
	iffalse .HaventMetFloria

	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .CloseShopText

	writetext GoldenrodFlowerShopTeacherHeresTheSquirtbottleText
	sjump .GiveBottle

.CloseShopText:
	writetext GoldenrodFlowerShopTeacherCloseShopText

.GiveBottle:
	promptbutton
	verbosegiveitem SQUIRTBOTTLE
	writetext GoldenrodFlowerShopSquirtbottleAdviceText
	sjump .EndText

.GotSquirtbottle:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .GoHomeText
	ifequal 1 << CURFEW, .GoHomeText

	writetext GoldenrodFlowerShopTeacherDontDoAnythingDangerousText
	sjump .EndText

.GoHomeText:
	writetext GoldenrodFlowerShopTeacherGoHomeText
	sjump .EndText

.HaventMetFloria:
	writetext GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndText
	ifequal 1 << VACCINE_PASSPORT, .EndText	

	promptbutton
	writetext GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36StayAtHomeText

.EndText:
	waitbutton
	closetext
.End:
	end

.PostLockdown:
	checkevent EVENT_ALL_PLANTS_DIED_DURING_LOCKDOWN
	iftrue .CheckPlantSelection

	setevent EVENT_ALL_PLANTS_DIED_DURING_LOCKDOWN
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	writetext GoldenrodFlowerShopTeacherAllPlantsDiedText
	promptbutton
	pause 15
	
.CheckPlantSelection:
	faceobject GOLDENRODFLOWERSHOP_TEACHER, PLAYER
	checkevent EVENT_DECO_PLANT_1
	iffalse .PlantsForSales
	checkevent EVENT_DECO_PLANT_2
	iffalse .PlantsForSales
	checkevent EVENT_DECO_PLANT_3
	iffalse .PlantsForSales

;.SoldOut
	writetext GoldenrodFlowerShopTeacherSoldOutText
	sjump .EndText

.PlantsForSales:
	readmem wSelectedPlant
	setlasttalked ITEM_FROM_MEM
	ifequal GOLDENRODFLOWERSHOP_MAGNAPLANT, .FlowerShopTryBuyMagnaPlant
	ifequal GOLDENRODFLOWERSHOP_TROPICPLANT, .FlowerShopTryBuyTropicPlant
	ifequal GOLDENRODFLOWERSHOP_JUMBOPLANT, .FlowerShopTryBuyJumboPlant

;.AskToChoosePlant
	writetext GoldenrodFlowerShopTeacherChooseAPlantText
	sjump .EndText

.FlowerShopTryBuyMagnaPlant:
	setval DECO_MAGNAPLANT
	sjump .Offer

.FlowerShopTryBuyTropicPlant:
	setval DECO_TROPICPLANT
	sjump .Offer

.FlowerShopTryBuyJumboPlant:
	setval DECO_JUMBOPLANT
.Offer:
	callasm GetDecorationNameFromScript
	writetext GoldenrodFlowerShopTeacherWantThisOneText
	setval PLANT_PRICE / 1000
	farscall Akiba1F_BuyingProcess
	iffalse .End

	readmem wSelectedPlant
	ifequal GOLDENRODFLOWERSHOP_MAGNAPLANT, .BuyAndHideMagnaPlant
	ifequal GOLDENRODFLOWERSHOP_TROPICPLANT, .BuyAndHideTropicPlant
	ifequal GOLDENRODFLOWERSHOP_JUMBOPLANT, .BuyAndHideJumboPlant
	sjump .End

.BuyAndHideMagnaPlant:
	setevent EVENT_DECO_PLANT_1
	scall GoldenrodFlowerShop_HideMagnaPlant
	sjump .ReloadMap

.BuyAndHideTropicPlant:
	setevent EVENT_DECO_PLANT_2
	scall GoldenrodFlowerShop_HideTropicPlant
	sjump .ReloadMap

.BuyAndHideJumboPlant:
	setevent EVENT_DECO_PLANT_3
	scall GoldenrodFlowerShop_HideJumboPlant
.ReloadMap:
	reloadmappart
	setlasttalked 0
	loadmem wSelectedPlant, 0
	sjump .End

FlowerShopFloriaScript:
	faceplayer
	opentext

	checkevent EVENT_ROUTE_36_SUDOWOODO
	iftrue .FoughtSudowoodo

	checkitem SQUIRTBOTTLE
	iftrue .GotSquirtbottle

	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .PoliceText

	writetext GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText
	sjump FlowerShopTeacherScript.EndText

.PoliceText:
	writetext GoldenrodFlowerShopFloriaPoliceText
	sjump FlowerShopTeacherScript.EndText

.GotSquirtbottle:
	writetext GoldenrodFlowerShopFloriaYouBeatWhitneyText
	waitbutton
	closetext
	end

.FoughtSudowoodo:
	writetext GoldenrodFlowerShopFloriaItReallyWasAMonText
	waitbutton
	closetext
	end

FlowerShop_MagnaPlantScript:
	loadmem wSelectedPlant, GOLDENRODFLOWERSHOP_MAGNAPLANT
	setval DECO_MAGNAPLANT
	sjump DisplayDecoNameScript

FlowerShop_TropicPlantScript:
	loadmem wSelectedPlant, GOLDENRODFLOWERSHOP_TROPICPLANT
	setval DECO_TROPICPLANT
	sjump DisplayDecoNameScript

FlowerShop_JumboPlantScript:
	loadmem wSelectedPlant, GOLDENRODFLOWERSHOP_JUMBOPLANT
	setval DECO_JUMBOPLANT
DisplayDecoNameScript:
	callasm GetDecorationNameFromScript
	jumptext DecoNameText

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text:
if DEF(_FR_FR)
	text "As-tu vu l'arbre"
	line "qui gigote sur la"
	cont "ROUTE 36?"

	para "Ma petite soeur"
	line "a absolument tenu"
	cont "à aller le voir..."
else
	text "Have you seen that"
	line "wiggly tree that's"

	para "growing on ROUTE"
	line "36?"

	para "My little sister"
	line "got all excited"

	para "and went to see"
	line "it…"
endc
	done

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36StayAtHomeText:
if DEF(_FR_FR)
	text "Ca m'inquiète..."

	para "Avec le confine-"
	line "ment, elle devrait"
	cont "déjà être rentrée."
else
	text "I'm worried…"

	para "Because of the"
	line "stay-at-home order"
	
	para "she should be"
	line "here by now…"
endc
	done

GoldenrodFlowerShopTeacherHeresTheSquirtbottleText:
if DEF(_FR_FR)
	text "Tu veux aussi"
	line "emprunter mon"
	cont "arrosoir?"

	para "Tu as plusieurs"
	line "BADGES, tu dois"
	cont "être balèze."

	para "Tu es digne de"
	line "mon arrosoir."
else
	text "Do you want to"
	line "borrow the water"
	cont "bottle too?"

	para "You have several"
	line "GYM BADGES, you"
	cont "must be strong."

	para "You are worthy"
	line "of my bottle."
endc
	done

GoldenrodFlowerShopSquirtbottleAdviceText:
if DEF(_FR_FR)
	text "Utilise-le pour"
	line "arroser les arbres"
	cont "à baies. Quelques"
	cont "gouttes suffisent."
else
	text "Use it to water"
	line "fruit trees. Just"
	cont "a little water is"
	cont "enough."
endc
	done

GoldenrodFlowerShopTeacherCloseShopText:
if DEF(_FR_FR)
	text "Maintenant que ma"
	line "soeur est rentrée,"

	para "je peux fermer la"
	line "boutique."

	para "Je n'aurai plus"
	line "besoin de la"
	cont "CARAPUCE A O"
	cont "je suppose."
	cont "Tu peux la garder!"
else
	text "Now that sis is"
	line "back, I can"
	cont "close the shop."

	para "It's already past"
	line "time, we could"
	cont "get into trouble."

	para "I won't need the"
	line "SQUIRTBOTTLE any-"
	cont "more I guess."
	cont "You can have it!"
endc
	done

GoldenrodFlowerShopTeacherDontDoAnythingDangerousText:
if DEF(_FR_FR)
	text "Ne fais rien de"
	line "dangereux avec"
	cont "la CARAPUCE A O!"
else
	text "Don't do anything"
	line "dangerous with"
	cont "the SQUIRTBOTTLE!"
endc
	done

GoldenrodFlowerShopTeacherGoHomeText:
if DEF(_FR_FR)
	text "Tu ne devrais pas"
	line "être chez toi avec"
	cont "tes parents?"
else
	text "Shouldn't you be"
	line "home with your"
	cont "parents?"
endc
	done

GoldenrodFlowerShopTeacherAllPlantsDiedText:
if DEF(_FR_FR)
	text "Toutes mes plantes"
	line "sont mortes pen-"
	cont "dant le confine-"
	cont "ment. Trop triste."

	para "Je vends mainte-"
	line "nant des plantes"
	cont "qui n'ont pas"
	cont "besoin d'eau."
else
	text "All my plants died"
	line "during the lock-"
	cont "down. It's sad."

	para "So now I sell"
	line "plants that need"
	cont "no watering."
endc
	done

GoldenrodFlowerShopTeacherChooseAPlantText:
if DEF(_FR_FR)
	text "Jette un oeil à"
	line "mes plantes, et"
	cont "dis-moi celle"
	cont "que tu veux."
else
	text "Take a look at my"
	line "plants then tell"
	cont "me the one you"
	cont "want."
endc
	done

GoldenrodFlowerShopTeacherWantThisOneText:
if DEF(_FR_FR)
	text "La"
	line "@"
	text_ram wStringBuffer2
	text ""
	cont "que tu as choisi"
	cont "coûte {d:PLANT_PRICE}¥."
	cont "Affaire conclue?"
else
	text "The @"
	text_ram wStringBuffer2
	text ""
	line "you looked at"
	cont "is ¥{d:PLANT_PRICE}. Deal?"
endc
	done

GoldenrodFlowerShopTeacherSoldOutText:
if DEF(_FR_FR)
	text "J'espère que tu"
	line "prends bien soin"
	cont "de toutes les"
	cont "plantes que tu"
	cont "as acheté!"
else
	text "I hope you take"
	line "good care of all"
	cont "the plants you"
	cont "bought me!"
endc
	done

GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText:
if DEF(_FR_FR)
	text "Ma soeur ne veut"
	line "pas me prêter son"
	cont "arrosoir."

	para "Elle dit que je ne"
	line "suis pas assez"
	cont "forte pour le"
	cont "porter."
else
	text "Sis doesn't want"
	line "to lend me her"
	cont "bottle."

	para "She says I'm not"
	line "strong enough to"
	cont "carry it."
endc
	done

GoldenrodFlowerShopFloriaPoliceText:
if DEF(_FR_FR)
	text "J'ai croisé la"
	line "police en venant"
	cont "ici."

	para "J'ai de la chance"
	line "qu'ils ne m'aient"
	cont "pas vue!"
else
	text "I saw the police"
	line "on the way here."

	para "I'm lucky they"
	line "didn't see me!"
endc
	done

GoldenrodFlowerShopFloriaYouBeatWhitneyText:
if DEF(_FR_FR)
	text "Tu as obtenu"
	line "la CARAPUCE A O"
	cont "de ma soeur?"
	cont "Je suis jalouse!"
else
	text "You got my sister's"
	line "SQUIRTBOTTLE?"
	cont "I'm jealous!"
endc
	done

GoldenrodFlowerShopFloriaItReallyWasAMonText: 
if DEF(_FR_FR)
	text "Alors c'était"
	line "vraiment un"
	cont "#MON!"
else
	text "So it really was a"
	line "#MON!"
endc

	done

DecoNameText:
	text "@"
	text_ram wStringBuffer2
	text ""
	done

GoldenrodFlowerShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, EVENT_FLORIA_AT_FLOWER_SHOP
	object_event  2,  2, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShop_MagnaPlantScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  1,  6, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShop_TropicPlantScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  6,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShop_JumboPlantScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
