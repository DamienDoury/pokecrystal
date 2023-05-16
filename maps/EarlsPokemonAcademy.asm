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
	waitbutton
	closetext
	end

.Done:
	writetext AcademyEarlNoMoreToTeachText
	waitbutton
	closetext
	end

EarlsPokemonAcademyYoungster1Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster1Text

EarlsPokemonAcademyGameboyKid1Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid1Text
	waitbutton
	closetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID1, DOWN
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
	opentext
	writetext AcademyBlackboardText
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
	waitbutton
	sjump .Loop

.Sick:
	writetext AcademySickText
	waitbutton
	sjump .Loop

.Incub:
	writetext AcademyIncubText
	waitbutton
	sjump .Loop

.Covid:
	writetext AcademyCovidText
	waitbutton
	sjump .Loop

.Immune:
	writetext AcademyImmuneText
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

AcademyStickerMachine: ; unreferenced
	jumptext AcademyStickerMachineText

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
	turn_head DOWN
	step_end

AcademyEarlIntroText:
	text "EARL, I am!"

	para "Wonderful are"
	line "#MON, yes!"

	para "Teach you I will"
	line "to be a better"
	cont "trainer!"

	para "What you want to"
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

EarlsPokemonAcademyYoungster1Text:
	text "I'm taking notes"
	line "of the teacher's"
	cont "lecture."

	para "I'd better copy"
	line "the stuff on the"
	cont "blackboard too."
	done

EarlsPokemonAcademyGameboyKid1Text:
	text "I traded my best"
	line "#MON to the"
	cont "guy beside me."
	done

EarlsPokemonAcademyGameboyKid2Text:
	text "Huh? The #MON I"
	line "just got is hold-"
	cont "ing something!"
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

AcademyBlackboardText2: ; unreferenced
	text "Read which topic?"
	done

AcademyHealthyText:
	text "The #MON is in"
	line "good shape."
	cont "Nothing to report."
	done

AcademySickText:
	text "Symptoms of a"
	line "disease. Better"
	cont "keep the #MON"
	cont "quarantined to"
	cont "prevent spreading."

	para "Test the #MON"
	line "at a #MON"
	cont "CENTER to find out"
	cont "if it's a disease"
	cont "that they can"
	cont "cure, or if it is"
	cont "COVID."
	done

AcademyIncubText:
	text "The #MON has"
	line "been tested"
	cont "positive to COVID."

	para "The incubation is"
	line "phase 1/3 of the"
	cont "infection by the"
	cont "virus."

	para "During this phase"
	line "the #MON won't"
	cont "have any disease"
	cont "symptom."

	para "However, it is"
	line "already contagious"
	cont "and should be kept"
	cont "quarantined."

	para "The next phase is"
	line "the appearance"
	cont "of symptoms."
	done

AcademyCovidText:
	text "The #MON has"
	line "been tested"
	cont "positive to COVID."

	para "The disease is"
	line "phase 2/3 of the"
	cont "infection by the"
	cont "virus."

	para "The #MON will"
	line "have symptoms"
	cont "of a disease."

	para "We don't know"
	line "exactly what those"
	cont "symptoms are, and"
	cont "how long they"
	cont "last."

	para "Keep the #MON"
	line "quarantined to"
	cont "prevent spreading"
	cont "of the virus, and"
	cont "keep up with the"
	cont "latest news."
	done

AcademyImmuneText:
	text "The #MON has"
	line "recovered from"
	cont "COVID."

	para "The immunity is"
	line "phase 3/3 of the"
	cont "infection by the"
	cont "virus."

	para "This phase should"
	line "last a long time."

	para "Meanwhile, the"
	line "#MON can"
	cont "neither catch nor"
	cont "spread the virus."

	para "At this point,"
	line "the quarantine"
	cont "can be ended."
	done

AcademyNotebookText:
	text "It's this kid's"
	line "notebook…"

	para "It's almost impos-"
	line "sible to catch a"
	cont "healthy #MON."

	para "Before throwing a"
	line "# BALL, weaken"
	cont "the target first."

	para "The pandemic makes"
	line "wild #MON agi-"
	cont "tated and harder"
	cont "to catch."

	para "Ideally, leave the"
	line "target at 1 HP."

	para "Keep reading?"
	done

AcademyNotebookText1:
	text "Paralyzing or"
	line "freezing a #MON"
	cont "multiplies your"
	cont "odds of success."

	para "Some statuses are"
	line "more effective"
	cont "than others."

	para "Keep reading?"
	done

AcademyNotebookText2:
	text "Lowering a #MON"
	line "stats also helps."

	para "It's particularly"
	line "useful with in-"
	cont "flexible species."

	para "Combining this"
	line "with a status"
	cont "ailment can be"
	cont "very efficient."

	para "Keep reading?"
	done

AcademyNotebookText3:
	text "Once your party"
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
	cont "an adventure."

	para "The next page"
	line "is… Blank!"
	done

AcademyStickerMachineText:
	text "This super machine"
	line "prints data out as"

	para "stickers!"
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
	bg_event  3,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  4,  0, BGEVENT_READ, AcademyBlackboard

	def_object_events
	object_event  4,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AcademyEarl, EVENT_EARLS_ACADEMY_EARL
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster1Script, -1
	object_event  3, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid1Script, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid2Script, -1
	object_event  4,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster2Script, -1
	object_event  2,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AcademyNotebook, -1
