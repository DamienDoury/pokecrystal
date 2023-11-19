	object_const_def
	const EARLSPOKEMONACADEMY_EARL
	const EARLSPOKEMONACADEMY_YOUNGSTER1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID2
	const EARLSPOKEMONACADEMY_YOUNGSTER2
	const EARLSPOKEMONACADEMY_POKEDEX

EarlsPokemonAcademy_MapScripts:
	def_scene_scripts

	def_callbacks

AcademyEarl:
	applymovement EARLSPOKEMONACADEMY_EARL, AcademyEarlSpinMovement
	faceplayer
	opentext
	writetext AcademyEarlIntroText
	promptbutton

	checkevent EVENT_GOT_TOGEPI_EGG
	iffalse .GiveTogepiEgg

	writetext AcademyEarlIntroText2
	yesorno
	iffalse .Part1

	writetext AcademyEarlTeachHowToWinText
	yesorno
	iffalse .Done

.Part1:
	writetext AcademyEarlTeachMoreText
	yesorno
	iffalse .Done
	
	writetext AcademyEarlTeachHowToRaiseWellText
	sjump .TextEnd

.Done:
	writetext AcademyEarlNoMoreToTeachText
	sjump .TextEnd

.GiveTogepiEgg:
	writetext AcademyEarlGiveEggText
	yesorno
	iffalse .RefusedEgg

	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull

	giveegg TOGEPI, EGG_LEVEL
	getstring STRING_BUFFER_4, .EggName
	scall .GiveEgg
	setevent EVENT_GOT_TOGEPI_EGG

	writetext AcademyEarlAfterEggText
	sjump .TextEnd

.EggName:
	db "EGG@"

.GiveEgg:
	jumpstd ReceiveTogepiEggScript
	
.RefusedEgg:
	writetext AcademyEarlRefusedEggText
	sjump .TextEnd

.PartyFull:
	writetext AcademyEarlPartyFullText
.TextEnd
	waitbutton
	closetext
	applymovement EARLSPOKEMONACADEMY_EARL, AcademyEarlSpinMovement
	end

EarlsPokemonAcademyYoungster1Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster1Text

EarlsPokemonAcademyGameboyKid1Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid1Text
	waitbutton
	scall TradebackGuyScript
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID1, DOWN
	end

TradebackGuyScript:
	; Needs to have an opentext.
	farwritetext _TradebackGuyIntroText
	yesorno
	iffalse .refused

	farwritetext _TradebackGuyConfusedText
	promptbutton
	readmem wTradebackSuccessfulTradesCount
	ifgreater 6, .ultraball
	ifgreater 3, .greatball
;.pokeball
	setval POKE_BALL
	sjump .payment_determined

.greatball
	setval GREAT_BALL
	sjump .payment_determined

.ultraball
	setval ULTRA_BALL
.payment_determined
	writemem wTradeGuyItemPayment
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	farwritetext _TradebackGuyDealText
	yesorno
	iffalse .doesnt_want_to_pay

	readmem wTradeGuyItemPayment
	checkitem USE_SCRIPT_VAR
	iffalse .doesnt_have_item

	readmem wTradeGuyItemPayment
	takeitem ITEM_FROM_MEM, 1
	closetext

	opentext
	farwritetext _TradebackPlayerGivesItemText
	waitbutton
	closetext

	opentext
	farwritetext _TradebackGuyDealOkText
	waitbutton

	tradeback
	ifequal $ff, .player_cancelled
	ifequal 0, .no_evo

	readmem wTradebackSuccessfulTradesCount
	ifgreater 254, .no_inc

	addval 1
	writemem wTradebackSuccessfulTradesCount

.no_inc
	farwritetext _TradebackGuyDealEvoText
	sjump .waitbutton

.player_cancelled
	farwritetext _TradebackGuyKeepPaymentText
	sjump .waitbutton
	
.no_evo
	farwritetext _TradebackGuyDealNoEvoText
	sjump .waitbutton

.doesnt_have_item
	farwritetext _TradebackGuyDontHaveItemText
	sjump .waitbutton

.doesnt_want_to_pay
	farwritetext _TradebackGuyDealBrokenText
	sjump .waitbutton

.refused
	farwritetext _TradebackGuyAnotherTimeText
.waitbutton
	waitbutton
	closetext
	end

EarlsPokemonAcademyGameboyKid2Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid2Text
	waitbutton
	closetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID2, DOWN
	end

EarlsPokemonAcademyYoungster2Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster2Text

AcademyBlackboard:
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse AcademyStatusLesson

	opentext
	writetext AcademyBlackboardText
;.CovidLesson
.Loop:
	loadmenu .BlackboardMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .Healthy
	ifequal 2, .Sick
	ifequal 3, .Incub
	ifequal 4, .Covid
	ifequal 5, .Immune
	closetext
	end

.Healthy:
	writetext AcademyHealthyText
	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .HealthyEnd

	promptbutton
	writetext AcademyHealthyPCRText

.HealthyEnd
	waitbutton
	sjump .Loop

.Sick:
	writetext AcademySickText
	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .SickEnd

	promptbutton
	writetext AcademySickSequelText

.SickEnd
	waitbutton
	sjump .Loop

.Incub:
	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .IncubNext
	
	writetext AcademyIncubStartText
	promptbutton

.IncubNext:
	writetext AcademyIncubText
	waitbutton
	sjump .Loop

.Covid:
	checkevent EVENT_PCR_TEST_PRESENTATION
	iffalse .CovidNext
	
	writetext AcademyIncubStartText
	promptbutton

.CovidNext:
	writetext AcademyCovidText
	promptbutton
	writetext AcademyCovidEndText
	waitbutton
	sjump .Loop

.Immune:
	writetext AcademyImmuneText
	promptbutton

	checkevent EVENT_BEAT_ELITE_FOUR 
	iftrue .ImmuneStudies

	writetext AcademyImmuneBeforeStudiesText
	sjump .ImmuneEnd

.ImmuneStudies
	writetext AcademyImmuneStudiesText

.ImmuneEnd:
	promptbutton
	writetext AcademyImmuneSequelText
	waitbutton
	sjump .Loop

.BlackboardMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 17, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	dn 3, 2 ; rows, columns
	db 9 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "HEALTHY@"
	db "SICK@"
	db "INCUB.@"
	db "COVID@"
	db "IMMUNE@"
	db "QUIT@"

AcademyStatusLesson:
	opentext
	writetext AcademyBlackboardStatusText
.Loop:
	loadmenu .BlackboardMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .Poison
	ifequal 2, .Paralysis
	ifequal 3, .Sleep
	ifequal 4, .Burn
	ifequal 5, .Freeze
	closetext
	end

.Poison:
	writetext AcademyPoisonText
	waitbutton
	sjump .Loop

.Paralysis:
	writetext AcademyParalysisText
	waitbutton
	sjump .Loop

.Sleep:
	writetext AcademySleepText
	waitbutton
	sjump .Loop

.Burn:
	writetext AcademyBurnText
	waitbutton
	sjump .Loop

.Freeze:
	writetext AcademyFreezeText
	waitbutton
	sjump .Loop

.BlackboardMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 11, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	dn 3, 2 ; rows, columns
	db 5 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "PSN@"
	db "PAR@"
	db "SLP@"
	db "BRN@"
	db "FRZ@"
	db "QUIT@"

AcademyNotebook:
	opentext
	writetext AcademyNotebookText
	yesorno
	iffalse .Done
	writetext AcademyNotebookText1
	yesorno
	iffalse .Done
	writetext AcademyNotebookText2
	yesorno
	iffalse .Done
	writetext AcademyNotebookText3
	waitbutton
.Done:
	closetext
	end

AcademyBookshelf:
	jumpstd DifficultBookshelfScript

AcademyEarlSpinMovement:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	step_end

AcademyEarlIntroText:
	text "EARL, I am!"

	para "Wonderful are"
	line "#MON, yes!"
	
	para "Teach you I will"
	line "to be a better"
	cont "trainer!"
	done

AcademyEarlIntroText2:
	text "What you want to"
	line "know? Want to be"
	cont "a winner is you?"
	done

AcademyEarlTeachHowToWinText:
	text "Good! Teach you,"
	line "I will!"

	para "In battle, #MON"
	line "top on list jump"
	cont "out first!"

	para "Change order in"
	line "list, make battle"
	cont "easy, maybe!"

	para "More from me you"
	line "want to hear?"
	done

AcademyEarlTeachMoreText:
	text "So, want to know"
	line "how to raise"
	cont "#MON well?"
	done

AcademyEarlTeachHowToRaiseWellText:
	text "Fine! Teach you,"
	line "I will!"

	para "If #MON come"
	line "out in battle even"

	para "briefly, some EXP."
	line "Points it gets."

	para "At top of list put"
	line "weak #MON."

	para "Switch in battle"
	line "quick!"

	para "This way, weak"
	line "#MON strong"
	cont "become!"
	done

AcademyEarlNoMoreToTeachText:
	text "Oh! Smart student"
	line "you are! Nothing"
	cont "more do I teach!"

	para "Good to #MON"
	line "you must be!"
	done

AcademyEarlGiveEggText:
	text "Each pupil I give"
	line "an EGG!"
	
	para "Good first partner"
	line "it is to learn"
	cont "#MON!"

	para "I give you one?"
	done

AcademyEarlRefusedEggText:
	text "Learn step after"
	line "step is important!"

	para "Come take the egg"
	line "later you can!"
	done

AcademyEarlPartyFullText:
	text "First lesson I"
	line "teach: 6 #MON"
	
	para "is maximum you can"
	line "have on you."
	
	para "EGG count as #-"
	line "MON! Deposit in"

	para "PC at #CENTER"
	line "you must!"
	done

AcademyEarlAfterEggText:
	text "Keep EGG with you"
	line "until it hatch."

	para "Will become a good"
	line "friend, me trust!"
	done

EarlsPokemonAcademyYoungster1Text:
	text "I'm taking notes"
	line "of the teacher's"
	cont "lecture."

	para "I'd better copy"
	line "the stuff on the"
	cont "blackboard too."
	done

EarlsPokemonAcademyGameboyKid1Text:
	text "ROBIN: I traded my"
	line "best #MON to"
	cont "MICKEY beside me."
	done

EarlsPokemonAcademyGameboyKid2Text:
	text "MICKEY: Huh? The"
	line "#MON ROBIN sent"
	cont "is holding some-"
	cont "thing!"
	done

EarlsPokemonAcademyYoungster2Text:
	text "During a battle,"
	line "a #MON can heal"
	
	para "itself with the"
	line "the item it is"
	
	para "holding. Like a"
	line "BERRY for example."

	para "Many other items"
	line "can be held by"
	cont "your #MON."

	para "You can also use"
	line "items from your"
	cont "PACK to heal them."

	para "But a trainer isn't"
	line "allowed to use"

	para "items from the"
	line "PACK when facing"
	cont "an other trainer."

	para "It wouldn't be"
	line "fair."

	para "What would you"
	line "think if you were"
	
	para "facing a rich"
	line "GENTLEMAN, that"
	
	para "kept healing its"
	line "#MON with MAX"
	cont "REVIVES?"

	para "The winner of a"
	line "trainer battle"
	
	para "should be deter-"
	line "mined by skill,"
	cont "not wealth."

	;para "…"

	;para "It sure is tough"
	;line "taking notes…"
	done

AcademyBlackboardText:
	text "The blackboard"
	line "describes #MON"

	para "health status,"
	line "and what we know"
	cont "about the virus."
	done

AcademyHealthyText:
	text "The subject is in"
	line "good shape."
	
	para "The health status"
	line "of a #MON can"
	cont "be found on its"
	cont "STATS screen."
	done

AcademyHealthyPCRText:
	text "It is automati-"
	line "cally updated"
	cont "after each"
	cont "PCR test."
	done

AcademySickText:
	text "Symptoms of a"
	line "disease."
	
	para "It may be COVID,"
	line "or another known"
	cont "disease."
	
	para "Better keep"
	line "the subject"
	cont "quarantined to"
	cont "prevent spreading."
	done

AcademySickSequelText:
	text "The subject should"
	line "do a PCR test at a"
	cont "#MON CENTER to"
	cont "find out if it"
	cont "has COVID."

	para "If detected, known"
	line "diseases can be"
	cont "cured by the"
	cont "healing machine."
	done

AcademyIncubStartText:
	text "The subject has"
	line "been tested"
	cont "positive to COVID."
	done

AcademyIncubText:
	text "The incubation is"
	line "phase 1/3 of the"
	cont "infection by the"
	cont "virus."

	para "During this phase"
	line "the subject won't"
	cont "have any disease"
	cont "symptom."

	para "However, it is"
	line "already contagious"
	cont "and should be kept"
	cont "quarantined."

	para "This phase lasts"
	line "4 to 5 days for"
	cont "a human,"
	cont "and 1 to 2 days"
	cont "for a #MON."
	done

AcademyIncubEndText:
	text "The next phase is"
	line "the appearance"
	cont "of symptoms."
	done

AcademyCovidText:
	text "The disease is"
	line "phase 2/3 of the"
	cont "infection by the"
	cont "virus."

	para "The subject will"
	line "have symptoms"
	cont "of a disease."

	para "The experienced"
	line "symptoms vary"
	cont "between human and"
	cont "#MON."
	done

AcademyCovidEndText:
	text "This phase lasts"
	line "5 to 14 days for"
	cont "a human,"
	cont "and 3 days for"
	cont "a #MON."
	
	para "Keep the subject"
	line "quarantined to"
	cont "prevent spreading"
	cont "of the virus, and"
	cont "keep up with the"
	cont "latest news."
	done

AcademyImmuneText:
	text "The subject has"
	line "recovered from"
	cont "COVID."

	para "The immunity is"
	line "phase 3/3 of the"
	cont "infection by the"
	cont "virus."
	done

AcademyImmuneBeforeStudiesText:
	text "This phase should"
	line "last a long time."
	done

AcademyImmuneStudiesText:
	text "This phase lasts"
	line "at least 6 months"
	cont "for a human,"
	cont "and 10 days for"
	cont "a #MON."
	done
	
AcademyImmuneSequelText:
	text "Meanwhile, the"
	line "odds of the"
	cont "subject catching"
	cont "or spreading the"
	cont "virus are"
	cont "extremely low."

	para "At this point,"
	line "the quarantine"
	cont "can be ended."
	done

AcademyNotebookText:
	text "It's this kid's"
	line "notebook…"

	para "“It's almost impos-"
	line "sible to catch a"
	cont "healthy #MON."

	para "Before throwing a"
	line "# BALL, weaken"
	cont "the target first."

	para "Ideally, leave the"
	line "target at 1 HP.”"

	para "Keep reading?"
	done

AcademyNotebookText1:
	text "“Paralyzing or"
	line "freezing a #MON"
	cont "multiplies your"
	cont "odds of success."

	para "Some statuses are"
	line "more effective"
	cont "than others.”"

	para "Keep reading?"
	done

AcademyNotebookText2:
	text "“Lowering a"
	line "#MON's stats"
	cont "also helps."

	para "It's particularly"
	line "useful with in-"
	cont "flexible species."

	para "Combining this"
	line "with a status"
	cont "ailment can be"
	cont "very efficient.”"

	para "Keep reading?"
	done

AcademyNotebookText3:
	text "“Once your party"
	line "reaches the limit"
	cont "of 6 #MON,"

	para "further captures"
	line "are sent to a BOX"
	cont "in the PC."

	para "Once the BOX is"
	line "filled with 20"
	cont "#MON, you can't"
	cont "capture anymore."

	para "A good trainer"
	line "always switches"
	cont "to an empty BOX"
	cont "before going on"
	cont "an adventure.”"

	para "The next page"
	line "is… Blank!"
	done

AcademyBlackboardStatusText:
	text "The blackboard"
	line "describes #MON"

	para "status changes in"
	line "battle."
	done

AcademyPoisonText:
	text "If poisoned, a"
	line "#MON steadily"
	cont "loses HP."

	para "Poison lingers"
	line "after the battle,"

	para "and HP is lost as"
	line "you walk."

	para "To cure it, use an"
	line "ANTIDOTE."
	done

AcademyParalysisText:
	text "Paralysis reduces"
	line "speed and may"
	cont "prevent movement."

	para "It remains after"
	line "battle, so use"
	cont "a PARLYZ HEAL."
	done

AcademySleepText:
	text "If asleep, your"
	line "#MON can't make"
	cont "a move."

	para "A sleeping #MON"
	line "doesn't wake up"
	cont "after battle."

	para "Wake it up with"
	line "an AWAKENING."
	done

AcademyBurnText:
	text "A burn steadily"
	line "consumes HP."

	para "It also reduces"
	line "attack power."

	para "A burn lingers"
	line "after battle."

	para "Use a BURN HEAL as"
	line "the cure."
	done

AcademyFreezeText:
	text "If your #MON is"
	line "frozen, it can't"
	cont "do a thing."

	para "It remains frozen"
	line "after battle."

	para "Thaw it out with"
	line "an ICE HEAL."
	done

EarlsPokemonAcademy_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 15, VIOLET_CITY, 3
	warp_event  4, 15, VIOLET_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, AcademyBookshelf
	bg_event  1,  1, BGEVENT_READ, AcademyBookshelf
	bg_event  2,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  3,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  4,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  5,  0, BGEVENT_READ, AcademyBlackboard

	def_object_events
	object_event  4,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AcademyEarl, EVENT_EARLS_ACADEMY_EARL
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster1Script, -1
	object_event  3, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid1Script, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid2Script, -1
	object_event  4,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster2Script, -1
	object_event  2,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AcademyNotebook, -1
