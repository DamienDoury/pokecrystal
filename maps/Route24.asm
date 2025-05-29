	object_const_def
	const ROUTE24_TRAINER1
	const ROUTE24_TRAINER2
	const ROUTE24_TRAINER3
	const ROUTE24_TRAINER4
	const ROUTE24_TRAINER5
	const ROUTE24_TRAINER6
	const ROUTE24_TRAINER7
	const ROUTE24_TRAINER8

Route24_MapScripts:
	def_scene_scripts

	def_callbacks

Route24_TrainerCale:
	trainer BUG_CATCHER, CALE, EVENT_BEAT_NUGGET_BRIDGE_CALE, Route24Trainer1SeenText, Route24Trainer1BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple1Anim

Route24_TrainerAli:
	trainer LASS, ALI, EVENT_BEAT_NUGGET_BRIDGE_ALI, Route24Trainer2SeenText, Route24Trainer2BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple1Anim

Route24_TrainerTimmy:
	trainer YOUNGSTER, TIMMY, EVENT_BEAT_NUGGET_BRIDGE_TIMMY, Route24Trainer3SeenText, Route24Trainer3BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple2Anim

Route24_TrainerReli:
	trainer LASS, RELI, EVENT_BEAT_NUGGET_BRIDGE_RELI, Route24Trainer4SeenText, Route24Trainer4BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple2Anim

Route24_TrainerKevin:
	trainer CAMPER, KEVIN_BIS, EVENT_BEAT_NUGGET_BRIDGE_KEVIN, Route24Trainer5SeenText, Route24Trainer5BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple3Anim

Route24_TrainerShane:
	trainer CAMPER, SHANE_BIS, EVENT_BEAT_NUGGET_BRIDGE_SHANE, Route24Trainer6SeenText, Route24Trainer6BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple3Anim

Route24_TrainerOlly:
	trainer BUG_CATCHER, OLLY, EVENT_BEAT_NUGGET_BRIDGE_OLLY, Route24Trainer7SeenText, Route24Trainer7BeatenText, 0, .Script
.Script:
	endifjustbattled
	sjump Route24Couple4Anim

Route24_TrainerSummer:
	trainer LASS, SUMMER, EVENT_BEAT_NUGGET_BRIDGE_SUMMER, Route24Trainer8SeenText, Route24Trainer8BeatenText, 0, .Script
.Script:
	readmem wRunningTrainerBattleScript
	ifequal 0, Route24Couple4Anim
	; fallthrough.

AugmentKantoDifficultyLevel::
	checkevent EVENT_RED_BEATEN
	iffalse .end

	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
.end
	end

GotNewKantoBadge::
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	scall GotBadgeNoTrainerCard
	scall AugmentKantoDifficultyLevel

	readvar VAR_BADGES
	ifequal 10, .skip_month_elapsing

	readmem wYearMonth
	addval 1
	writemem wYearMonth

.skip_month_elapsing
	readvar VAR_BADGES
	ifequal 14, .fourteen
	ifequal 15, .fifteen
	end

.fourteen
	specialphonecall SPECIALCALL_BOOSTER_SHOT_AVAILABLE ; Chief Nurse Joy Special Call.
	end

.fifteen
	setevent EVENT_SECOND_SHOT_REQUIRED
	end

GotBadgeNoTrainerCard:
	checkflag ENGINE_TRAINER_CARD
	iftrue .end

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iffalse .skip_front_promptbutton

	promptbutton
.skip_front_promptbutton
	writetext GotBadgeNoTrainerCardText
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .end

	promptbutton
.end
	end

GotBadgeNoTrainerCardText: ; TO TRANSLATE
	text "Oh, you don't have"
	line "your TRAINER CARD?"

	para "Don't worry, it'll"
	line "be updated with"
	cont "this BADGE once"
	cont "you get it back."
	done


Route24HiddenPPUp:
	hiddenitem PP_UP, EVENT_ROUTE_24_HIDDEN_PP_UP

Route24HiddenHPUp:
	hiddenitem HP_UP, EVENT_ROUTE_24_HIDDEN_HP_UP

Route24HiddenToiletPaper:
	hiddenitem TOILET_PAPER, EVENT_ROUTE_24_HIDDEN_TOILET_PAPER

Route24Couple1Anim:
	turnobject ROUTE24_TRAINER1, RIGHT
	turnobject ROUTE24_TRAINER2, LEFT
	showemote EMOTE_SAD, ROUTE24_TRAINER1, 15
	opentext
	writetext Route24Trainer1SeenText
	waitbutton
	closetext

	showemote EMOTE_SAD, ROUTE24_TRAINER2, 15
	opentext
	writetext Route24Trainer2SeenText
	waitbutton
	closetext
	showemote EMOTE_SAD, ROUTE24_TRAINER1, 15
	showemote EMOTE_SAD, ROUTE24_TRAINER2, 15
	end

Route24Couple2Anim:
	turnobject ROUTE24_TRAINER3, RIGHT
	turnobject ROUTE24_TRAINER4, LEFT
	applymovement ROUTE24_TRAINER3, Route24StompRightMovement
	opentext
	writetext Route24Trainer3SeenText
	waitbutton
	closetext

	applymovement ROUTE24_TRAINER4, Route24StompLeftMovement
	opentext
	writetext Route24Trainer4SeenText
	waitbutton
	closetext
	end

Route24Couple3Anim:
	turnobject ROUTE24_TRAINER5, RIGHT
	turnobject ROUTE24_TRAINER6, LEFT
	applymovement ROUTE24_TRAINER5, Route24StompRightMovement
	opentext
	writetext Route24Trainer5SeenText
	waitbutton
	closetext

	applymovement ROUTE24_TRAINER6, Route24StompLeftMovement
	opentext
	writetext Route24Trainer6SeenText
	waitbutton
	closetext
	end

Route24Couple4Anim:
	turnobject ROUTE24_TRAINER7, RIGHT
	turnobject ROUTE24_TRAINER8, LEFT
	showemote EMOTE_SAD, ROUTE24_TRAINER7, 15
	opentext
	writetext Route24Trainer7SeenText
	waitbutton
	closetext
	showemote EMOTE_SAD, ROUTE24_TRAINER8, 15
	opentext
	writetext Route24Trainer8SeenText
	waitbutton
	closetext
	
	playsound SFX_TACKLE
	applymovement ROUTE24_TRAINER7, Route24FightRightMovement
	
	playsound SFX_HEADBUTT
	applymovement ROUTE24_TRAINER8, Route24FightLeftMovement
	
	playsound SFX_HEADBUTT
	applymovement ROUTE24_TRAINER7, Route24FightRightMovement
	
	playsound SFX_TACKLE
	applymovement ROUTE24_TRAINER8, Route24FightLeftMovement
	end

Route24BridgeItem:
	itemball TOILET_PAPER

Route24StompLeftMovement:
	turn_step LEFT
	step_bump
	step_end

Route24StompRightMovement:
	turn_step RIGHT
	step_bump
	step_end

Route24FightLeftMovement:
	fix_facing
	big_step LEFT
	big_step RIGHT
	remove_fixed_facing
	step_end

Route24FightRightMovement:
	fix_facing
	big_step RIGHT
	big_step LEFT
	remove_fixed_facing
	step_end

; Couple 1)
Route24Trainer1SeenText: ; TO TRANSLATE
	text "Forcing me to get"
	line "vaccinated goes"
	cont "against my"
	cont "freedom!"
	done

Route24Trainer1BeatenText: ; TO TRANSLATE
	text "I'm not telling you"
	line "to not get"
	cont "vaccinated, so"
	
	para "don't tell me to"
	line "get vaccinated!"
	done

Route24Trainer2SeenText: ; TO TRANSLATE
	text "Getting vaccinated"
	line "is not a right."

	para "It's a duty!"
	done

Route24Trainer2BeatenText: ; TO TRANSLATE
	text "This pandemic won't"
	line "stop by itself,"
	
	para "we need to act"
	line "as a group!"
	done
	
; Couple 2)
Route24Trainer3SeenText: ; TO TRANSLATE
	text "You got vaccinated"
	line "against other"
	cont "diseases,"
	
	para "why won't you get"
	line "vaccinated this"
	cont "time?"
	done

Route24Trainer3BeatenText: ; TO TRANSLATE
	text "If our health"
	line "researchers say"
	
	para "the vaccine is"
	line "safe, then it is!"
	
	para "They are more"
	line "qualified than"
	cont "you and I!"
	done

Route24Trainer4SeenText: ; TO TRANSLATE
	text "This vaccine has"
	line "not been tested"
	cont "thoroughly enough!"
	
	para "It could be"
	line "dangerous in"
	cont "the long term!"
	done
	
Route24Trainer4BeatenText: ; TO TRANSLATE
	text "How could this"
	line "vaccine get appro-"
	cont "ved within months"
	
	para "when it takes"
	line "5 to 10 years"
	cont "for the others?"
	done

; Couple 3)
Route24Trainer5SeenText: ; TO TRANSLATE
	text "Studies show the"
	line "vaccine has high"
	cont "odds of giving you"
	cont "a dangerous side"
	cont "effect!"
	done

Route24Trainer5BeatenText: ; TO TRANSLATE
	text "I'd rather take my"
	line "chances to escape"
	cont "the virus,"
	
	para "than injecting"
	line "something poten-"
	cont "tially dangerous"
	cont "into my body."
	done

Route24Trainer6SeenText: ; TO TRANSLATE
	text "It's not getting"
	line "vaccinated that"
	cont "is dangerous!"
	done

Route24Trainer6BeatenText: ; TO TRANSLATE
	text "Not getting vacci-"
	line "nated puts your-"
	cont "self at risk, and"
	cont "helps the virus"
	cont "spread!"

	para "Spreading the"
	line "virus makes you"
	cont "a killer!"
	done

; Couple 4)
Route24Trainer7SeenText: ; TO TRANSLATE
	text "We should kill"
	line "people that refuse"

	para "the vaccine and"
	line "spread the virus."
	done

Route24Trainer7BeatenText: ; TO TRANSLATE
	text "You f*cking"
	line "dumbsh*t!"
	done

Route24Trainer8SeenText: ; TO TRANSLATE
	text "I hope your"
	line "vaccine gives"
	
	para "you cancer, you"
	line "f*cking nazi!"
	done

Route24Trainer8BeatenText: ; TO TRANSLATE
	text "Yeah right"
	line "f*ck you!"
	done

Route24_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 11, 16, BGEVENT_ITEM, Route24HiddenPPUp
	bg_event 12, 17, BGEVENT_ITEM, Route24HiddenToiletPaper
	bg_event 14, 16, BGEVENT_ITEM, Route24HiddenHPUp

	def_object_events	
	object_event 11,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, Route24_TrainerCale, -1
	object_event 13,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, Route24_TrainerAli, -1
	
	object_event 11, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, Route24_TrainerTimmy, -1
	object_event 13, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, Route24_TrainerReli, -1
	
	object_event 11, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, Route24_TrainerKevin, -1
	object_event 13, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, Route24_TrainerShane, -1
	
	object_event 11, 15, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, Route24_TrainerOlly, -1
	object_event 13, 15, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, Route24_TrainerSummer, -1

	object_event 12, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route24BridgeItem, EVENT_CERULEAN_BRIDGE_ITEM
