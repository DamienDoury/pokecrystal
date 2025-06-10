	object_const_def
	const GOLDENRODCLAPHOUSE_CLAP_MASTER
	const GOLDENRODCLAPHOUSE_HUSBAND

GoldenrodClapHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .SecondWindow
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.SecondWindow:
	changeblock 2, 0, $05 ; window.
	endcallback

.CheckClapping:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Hide instructions book.
	
	readmem wYearMonth
	ifgreater $07, .done_with_instructions
	
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Show instructions in bookshelves.

	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .done_with_instructions

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Show instructions book.

.done_with_instructions
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject GOLDENRODCLAPHOUSE_CLAP_MASTER, 5, 1
	moveobject GOLDENRODCLAPHOUSE_HUSBAND, 4, 2
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

GoldenrodClapHouse_ClapMasterScript:	
	faceplayer
	opentext
	
	readmem wYearMonth
	ifgreater $12, .long_after ; If scenario date is greater than March 2021.
	ifgreater $07, .after

	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .before_lockdown
	
; Active clapping era: during lockdown and curfew.
	checkevent EVENT_CLAPPING_EXPLAINED
	iftrue .skip_explanation

	setevent EVENT_CLAPPING_EXPLAINED
	writetext GoldenrodClapHouse_ExplanationText
	promptbutton

.skip_explanation
	callasm IsClappingAuthorizedScript
	iffalse .wait_for_8pm

	; ACTIVE CLAPPING PERIOD!
	callasm HasPlayerClappedALotInThisRoom
	iffalse .clap_along

	writetext GoldenrodClapHouse_LoveYourClappingText
	promptbutton
	writetext GoldenrodClapHouse_MasterShowHandsText
	promptbutton

	callasm CheckClapCap
	scall GiftOrClapCount
	ifnotequal 0, .close_text
	sjump .turn_up_end_text

.clap_along
	writetext GoldenrodClapHouse_ClapAlongText
.turn_up_end_text
	waitbutton
.close_text
	closetext
	turnobject GOLDENRODCLAPHOUSE_CLAP_MASTER, UP
	end

.wait_for_8pm
	callasm CheckClapCap
	iffalse .during_never_clapped

	writetext GoldenrodClapHouse_MasterShowHandsText
	promptbutton

	scall OfferClappingGift
	ifnotequal 0, .hyped

	scall DisplayClapCount
	promptbutton

.hyped
.during_never_clapped
	writetext GoldenrodClapHouse_HypedText
	sjump .text_end

.after
	writetext GoldenrodClapHouse_MasterTrendVanishedText

	callasm CheckClapCap
	iffalse .text_end

	promptbutton
	scall GiftOrClapCount
	ifnotequal 0, .close_text
	sjump .text_end

.long_after
	checkitem TM_ENCORE
	iftrue .skip_encore_second_chance

	writetext GoldenrodClapHouse_MasterEncoreSecondChanceText
	promptbutton
	verbosegiveitem TM_ENCORE ; No issue with a full pack when giving out a TM, as it's a bit field.
	setevent EVENT_GOT_CLAPPING_GIFT_3 ; Prevents the item from being obtainable once more, from the OfferClappingGift function.
	sjump .close_text
		
.skip_encore_second_chance
	callasm CheckClapCap
	iffalse .long_after_skip_clap

	writetext GoldenrodClapHouse_MasterTrendVanishedText
	promptbutton

	scall OfferClappingGift
	ifnotequal 0, .close_text

	writetext GoldenrodClapHouse_MasterThanksLookbackText
	promptbutton
	scall DisplayClapCount
	sjump .text_end

.long_after_skip_clap
	writetext GoldenrodClapHouse_MasterPokeathlonText
.text_end
	waitbutton
	closetext
	end

.before_lockdown
	writetext GoldenrodClapHouse_MasterBeforeLockdownText
	sjump .text_end

; Must be called after the result of CheckClapCap is stored in wScriptVar.
GiftOrClapCount:
	scall OfferClappingGift
	ifnotequal 0, .end

	scall DisplayClapCount
	promptbutton
	writetext GoldenrodClapHouse_MasterThanksLookbackText
	setval 0
.end
	end	

; Input: the result of CheckClapCap in wScriptVar.
; Output: FALSE in wScriptVar if no gift was given. Any other value otherwise.
OfferClappingGift:
	writemem wTempByteValue
	ifless CLAP_CAP_1_RET_VAL, .abandon_gift_giving

	checkevent EVENT_GOT_CLAPPING_GIFT_1
	iffalse .give_gift1

	readmem wTempByteValue
	ifless CLAP_CAP_2_RET_VAL, .abandon_gift_giving

	checkevent EVENT_GOT_CLAPPING_GIFT_2
	iffalse .give_gift2

	readmem wTempByteValue
	ifless CLAP_CAP_3_RET_VAL, .abandon_gift_giving
	
	checkevent EVENT_GOT_CLAPPING_GIFT_3
	iffalse .give_gift3

.abandon_gift_giving
	setval FALSE
	end

.give_gift1
	writetext GoldenrodClapHouse_Gift1Text
	promptbutton
	verbosegiveitem EON_MAIL
	iffalse .end_with_ret_val

	setevent EVENT_GOT_CLAPPING_GIFT_1
	sjump .end_with_ret_val

.give_gift2
	writetext GoldenrodClapHouse_Gift2Text
	promptbutton
	verbosegiveitem BIG_PEARL
	iffalse .end_with_ret_val

	setevent EVENT_GOT_CLAPPING_GIFT_2
	sjump .end_with_ret_val

.give_gift3
	writetext GoldenrodClapHouse_Gift3Text
	promptbutton
	verbosegiveitem TM_ENCORE
	setevent EVENT_GOT_CLAPPING_GIFT_3
.end_with_ret_val
	readmem wTempByteValue
	end

DisplayClapCount:
	readmem wClapCount
	ifgreater $c3, .cant_count

	writetext GoldenrodClapHouse_MasterClapCountText
	end

.cant_count
	writetext GoldenrodClapHouse_MasterHighCountText
	end




GoldenrodClapHouse_HusbandScript:
	checkevent EVENT_FIRST_CURFEW_STARTED
	iftrue .postLockdown

	callasm IsClappingAuthorizedScript
	iftrue .clapping

; before and during lockdown.
	jumptextfaceplayer GoldenrodClapHouse_HusbandLockdownOpportunityText

.postLockdown:
	jumptextfaceplayer GoldenrodClapHouse_HusbandLockdownText

.clapping:
	faceplayer
	callasm HasPlayerClappedALotInThisRoom
	iftrue .best_time

	farjumptext _Clapping1Text

.best_time
	jumptext GoldenrodClapHouse_HusbandClapText



GoldenrodClapHouse_InstructionsScript:
	jumptext GoldenrodClapHouse_InstructionsText
	
GoldenrodClapHouse_Bookshelf:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .std

	opentext
	writetext GoldenrodClapHouse_OldBookText
	yesorno
	iffalse .close_text

	writetext GoldenrodClapHouse_InstructionsText

.text_end
	waitbutton
.close_text
	closetext
	end

.std
	jumpstd MagazineBookshelfScript

GoldenrodClapHouse_Radio:
	jumpstd Radio2Script

GoldenrodClapHouse_HusbandLockdownOpportunityText: ; TO TRANSLATE
	text "This stay at home"
	line "order's a blessing!"

	para "I'll finally have"
	line "time to take care"
	cont "of myself!"

	para "I will do pilates"
	line "every morning,"

	para "read books, and"
	line "learn to bake"
	cont "my own bread!"
	done

GoldenrodClapHouse_HusbandClapText: ; TO TRANSLATE
	text "This is the most"
	line "important time of"
	cont "the day!"

	para "Time to claaaap!"
	done

GoldenrodClapHouse_HusbandLockdownText: ; TO TRANSLATE
	text "All I did during"
	line "the lockdown was"
	
	para "watch TV and"
	line "eat snacks."

	para "Motivation is a"
	line "fragile thing…"
	done






GoldenrodClapHouse_MasterBeforeLockdownText: ; TO TRANSLATE
	text "I'm afraid to stay"
	line "locked at home."

	para "I know! I'll start"
	line "a trend!"

	para "Once the lockdown"
	line "has started, come"
	cont "back right before"
	cont "8 PM."
	done

GoldenrodClapHouse_MasterEncoreSecondChanceText: ; TO TRANSLATE
	text "Window clapping"
	line "appears to be"
	cont "gone for good."

	para "I want an encore."
	line "But it's not going"
	cont "to happen."

	para "I guess you can"
	line "take this."
	done

GoldenrodClapHouse_MasterPokeathlonText: ; TO TRANSLATE
	text "I wish I could be"
	line "clapping at the"
	cont "#ATHLON."
	
	para "But after being"
	line "postponed, it was"
	cont "closed to the"
	cont "public."
	done

GoldenrodClapHouse_MasterTrendVanishedText: ; TO TRANSLATE
	text "Unfortunately, the"
	line "window clapping"
	cont "trend slowly"
	cont "vanished."
	done

GoldenrodClapHouse_LoveYourClappingText: ; TO TRANSLATE
	text "I love the way"
	line "you clap!"
	done

GoldenrodClapHouse_MasterShowHandsText: ; TO TRANSLATE
	text "By looking at your"
	line "hands, I can tell…"
	done

GoldenrodClapHouse_MasterThanksLookbackText: ; TO TRANSLATE
	text "Thanks for taking"
	line "part in the window"
	cont "clapping movement!"
	done

GoldenrodClapHouse_MasterClapCountText: ; TO TRANSLATE
	text "You've clapped"
	line "@"
	text_decimal wClapCount, 2, 5
	text " times."
	done

GoldenrodClapHouse_MasterHighCountText: ; TO TRANSLATE
	text "You've clapped more"
	line "than I can count!"

	para "Did you cheat or"
	line "something?"
	done

GoldenrodClapHouse_Gift1Text: ; TO TRANSLATE
	text "You've clapped"
	line "more than {d:CLAP_CAP_1_AMOUNT}"
	cont "times!"
	
	para "Here's a present"
	line "for your effort."
	done

GoldenrodClapHouse_Gift2Text: ; TO TRANSLATE
	text "Wow! You've clapped"
	line "more than {d:CLAP_CAP_2_AMOUNT}"
	cont "times!"
	
	para "Let's celebrate"
	line "with a present."
	done

GoldenrodClapHouse_Gift3Text: ; TO TRANSLATE
	text "Wow! You've clapped"
	line "more than {d:CLAP_CAP_3_AMOUNT}"
	cont "times! Impressive!"

	para "I should call you"
	line "sensei. Here's a"
	cont "present worthy of"
	cont "your strong hands."
	done

GoldenrodClapHouse_ExplanationText: ; TO TRANSLATE
	text "The trend I start-"
	line "ed has picked up!"

	para "Everyday at 8 PM,"
	line "locked down people"
	
	para "are clapping at"
	line "their window"

	para "as a way to show"
	line "their support"

	para "to the healthcare"
	line "workers that are"

	para "overwhelmed with"
	line "the pandemic."

	para "The media relayed"
	line "the trend, and now"
	
	para "all major cities"
	line "are doing it!"
	done

GoldenrodClapHouse_ClapAlongText: ; TO TRANSLATE
	text "Come on! Please"
	line "clap along!"
	cont "You can do it!"
	done

GoldenrodClapHouse_HypedText: ; TO TRANSLATE
	text "I'm really amped"
	line "for 8 PM!"
	done




GoldenrodClapHouse_OldBookText: ; TO TRANSLATE
	text "There's an old copy"
	line "of The Book of"
	cont "Clapping."
	
	para "Do you want"
	line "to read it?"
	done

GoldenrodClapHouse_InstructionsText: ; TO TRANSLATE
	text "“The Book of"
	line "Clapping”"

	para "By the self-"
	line "proclaimed"
	cont "CLAP MASTER."

	para "When to clap?"
	line "<EMPTY_STAR> Starts at 8 PM"

	para "Where to clap?"
	line "<EMPTY_STAR> Mostly in cities"

	para "How to clap?"
	line "<EMPTY_STAR> Tinker around!"
	cont "You can figure it"
	cont "out on your own ;)"
	done

GoldenrodClapHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 17
	warp_event  3,  7, GOLDENROD_CITY, 17

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, GoldenrodClapHouse_Bookshelf
	bg_event  1,  1, BGEVENT_READ, GoldenrodClapHouse_Bookshelf
	bg_event  7,  1, BGEVENT_READ, GoldenrodClapHouse_Radio

	def_object_events
	object_event  6,  2, SPRITE_RECEPTIONIST, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodClapHouse_ClapMasterScript, -1
	object_event  1,  3, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodClapHouse_HusbandScript, -1
	object_event  4,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodClapHouse_InstructionsScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
