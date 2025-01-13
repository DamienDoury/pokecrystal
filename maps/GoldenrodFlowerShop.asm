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
	text "Have you seen that"
	line "wiggly tree that's"

	para "growing on ROUTE"
	line "36?"

	para "My little sister"
	line "got all excited"

	para "and went to see"
	line "it…"
	done

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36StayAtHomeText:
	text "I'm worried…"

	para "Because of the"
	line "stay-at-home order"
	
	para "she should be"
	line "here by now…"
	done

GoldenrodFlowerShopTeacherHeresTheSquirtbottleText:
	text "Do you want to"
	line "borrow the water"
	cont "bottle too?"

	para "You have several"
	line "GYM BADGES, you"
	cont "must be strong."

	para "You are worthy"
	line "of my bottle."
	done

GoldenrodFlowerShopSquirtbottleAdviceText:
	text "Use it to water"
	line "fruit trees. Just"
	cont "a little water is"
	cont "enough."
	done

GoldenrodFlowerShopTeacherCloseShopText:
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
	done

GoldenrodFlowerShopTeacherDontDoAnythingDangerousText:
	text "Don't do anything"
	line "dangerous with"
	cont "the SQUIRTBOTTLE!"
	done

GoldenrodFlowerShopTeacherGoHomeText:
	text "Shouldn't you be"
	line "home with your"
	cont "parents?"
	done

GoldenrodFlowerShopTeacherAllPlantsDiedText:
	text "All my plants died"
	line "during the lock-"
	cont "down. It's sad."

	para "So now I sell"
	line "plants that need"
	cont "no watering."
	done

GoldenrodFlowerShopTeacherChooseAPlantText:
	text "Take a look at my"
	line "plants then tell"
	cont "me the one you"
	cont "want."
	done

GoldenrodFlowerShopTeacherWantThisOneText:
	text "The @"
	text_ram wStringBuffer2
	text ""
	line "you looked at"
	cont "is ¥{d:PLANT_PRICE}. Deal?"
	done

GoldenrodFlowerShopTeacherSoldOutText:
	text "I hope you take"
	line "good care of all"
	cont "the plants you"
	cont "bought me!"
	done

GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText:
	text "Sis doesn't want"
	line "to lend me her"
	cont "bottle."

	para "She says I'm not"
	line "strong enough to"
	cont "carry it."
	done

GoldenrodFlowerShopFloriaPoliceText:
	text "I saw the police"
	line "on the way here."

	para "I'm lucky they"
	line "didn't see me!"
	done

GoldenrodFlowerShopFloriaYouBeatWhitneyText:
	text "You got my sister's"
	line "SQUIRTBOTTLE?"
	cont "I'm jealous!"
	done

GoldenrodFlowerShopFloriaItReallyWasAMonText:
	text "So it really was a"
	line "#MON!"
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
