	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	opentext
	checkevent EVENT_ROUTE_36_SUDOWOODO
	iftrue .Lalala
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
	waitbutton
	closetext
	end

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	writetext GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText
	waitbutton
	closetext
	end

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
	end

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

GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText:
	text "All my plants died"
	line "during the lock-"
	cont "down, I'm sad."
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
