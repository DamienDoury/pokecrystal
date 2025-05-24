	object_const_def
	const ROUTE9_YOUNGSTER1
	const ROUTE9_LASS1
	const ROUTE9_YOUNGSTER2
	const ROUTE9_LASS2
	const ROUTE9_POKEFAN_M1
	const ROUTE9_POKEFAN_M2
	const ROUTE9_COOLTRAINER_F
	const ROUTE9_COOLTRAINER_M
	const ROUTE9_ESCORT
	const ROUTE9_COOLTRAINER_ANDRIY

Route9_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerCamperDean:
	trainer CAMPER, DEAN, EVENT_BEAT_CAMPER_DEAN, CamperDeanSeenText, CamperDeanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CamperDeanAfterBattleText

TrainerPicnickerHeidi:
	trainer PICNICKER, HEIDI, EVENT_BEAT_PICNICKER_HEIDI, PicnickerHeidiSeenText, PicnickerHeidiBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PicnickerHeidiAfterBattleText

TrainerCamperSid:
	trainer CAMPER, SID, EVENT_BEAT_CAMPER_SID, CamperSidSeenText, CamperSidBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CamperSidAfterBattleText

TrainerPicnickerEdna:
	trainer PICNICKER, EDNA, EVENT_BEAT_PICNICKER_EDNA, PicnickerEdnaSeenText, PicnickerEdnaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PicnickerEdnaAfterBattleText

TrainerHikerTim:
	trainer HIKER, TIM, EVENT_BEAT_HIKER_TIM, HikerTimSeenText, HikerTimBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer HikerTimAfterBattleText

TrainerHikerSidney:
	trainer HIKER, SIDNEY, EVENT_BEAT_HIKER_SIDNEY, HikerSidneySeenText, HikerSidneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer HikerSidneyAfterBattleText

TrainerCooltrainerFMaria:
	trainer COOLTRAINERF, MARIA, EVENT_BEAT_COOLTRAINERF_MARIA, CooltrainerFMariaSeenText, CooltrainerFMariaBeatenText, 0, .Script

.Script:
	loadmem wMap7ObjectMovement, SPRITEMOVEDATA_SPINRANDOM_SLOW
	applymovement ROUTE9_COOLTRAINER_F, Route9_SleepMovement
	endifjustbattled
	jumptextfaceplayer CooltrainerFMariaAfterBattleText

Route9_SleepMovement:
	step_sleep 1
	step_end

TrainerCooltrainerMFred:
	trainer COOLTRAINERM, FRED, EVENT_BEAT_COOLTRAINERM_FRED, CooltrainerMFredSeenText, CooltrainerMFredBeatenText, 0, .Script

.Script:
	loadmem wMap8ObjectMovement, SPRITEMOVEDATA_SPINRANDOM_SLOW
	applymovement ROUTE9_COOLTRAINER_M, Route9_SleepMovement
	endifjustbattled
	jumptextfaceplayer CooltrainerMFredAfterBattleText

TrainerCooltrainerMAndriy:
	trainer COOLTRAINERM, ANDRIY, EVENT_BEAT_COOLTRAINERM_ANDRIY, CooltrainerMAndriySeenText, CooltrainerMAndriyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerMAndriyAfterBattleText

Route9_EscortGirlScript:
	readvar VAR_XCOORD
	ifnotequal 39, .direct_follow

	turnobject ROUTE9_ESCORT, UP
	opentext
	writetext Route9_QuestIntroText
	waitbutton
	closetext
	
	pause 5
	faceplayer
	pause 5
	
	opentext
	writetext Route9_QuestIntroSequelText
	yesorno
	iffalse .close_text_turn_up

	writetext Route9_QuestAcceptedText
	waitbutton
	closetext
	callasm StartEscortTimer
.direct_follow
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	farsjump NPCFollowsPlayer

.close_text_turn_up
	closetext
	turnobject ROUTE9_ESCORT, UP
	end

Route9_WrongWayScript:
	setlasttalked ROUTE9_ESCORT
	farscall WaitForFollowMovementToEnd
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Waiting
	turnobject ROUTE9_ESCORT, LEFT
	applymovement ROUTE9_ESCORT, Route9_SlowStepBackLeftMovement
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; stop follow.
	stopfollow

	scall Route9_FollowerAndPlayerFaceEachOtherScript
	
	opentext
	writetext Route9_WrongWayText
	waitbutton
	closetext

	applymovement ROUTE9_ESCORT, Route9_SlowStepBackLeftMovement
	loadmem wMap9ObjectMovement, SPRITEMOVEDATA_STANDING_RIGHT
	end

Route9_BreakLinkScript:
	disappear ROUTE9_ESCORT
	moveobject ROUTE9_ESCORT, 39, 6
	appear ROUTE9_ESCORT
Route9_BreakLink_NoTeleportScript:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	loadmem wMap9ObjectMovement, SPRITEMOVEDATA_STANDING_UP
	end

Route9_TowardsCeruleanScript:
	setlasttalked ROUTE9_ESCORT
	farscall WaitForFollowMovementToEnd
	stopfollow

	scall Route9_FollowerAndPlayerFaceEachOtherScript
	applymovement ROUTE9_ESCORT, Route9_SlowStepBackRightMovement
	
	opentext
	writetext Route9_AbandonmentQuestionText
	yesorno
	iftrue .bye

	writetext Route9_BackOnTrackText
	waitbutton
	closetext

	; switch positions.
	applymovement ROUTE9_ESCORT, Route9_StepLeftMovement
	follow PLAYER, ROUTE9_ESCORT
	applymovement PLAYER, Route9_StepRightMovement
	faceplayer
	end

.bye
	farwritetext SwimmerfChelanBeatenText
	waitbutton
	closetext

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; stop follow.
	applymovement ROUTE9_ESCORT, Route9_ByeMovement
	disappear ROUTE9_ESCORT
	appear ROUTE9_ESCORT
	reloadmappart
	end

Route9_DestinationScript:
	applymovement PLAYER, Route9_StepRightMovement
	setlasttalked ROUTE9_ESCORT
	farscall WaitForFollowMovementToEnd
	stopfollow
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; stop follow.
	applymovement ROUTE9_ESCORT, Route9_DestinationMovement
	scall Route9_FollowerAndPlayerFaceEachOtherScript
	callasm GetEscortDurationInSeconds

	opentext
	writetext Route9_DestinationReachedText
	promptbutton

	ifgreater 239, .too_long

	writetext Route9_DisplayHikeDurationText
	promptbutton

	ifgreater 60, .be_way_faster
	ifgreater 22, .be_faster

	writetext Route9_CongratsText
	promptbutton
	checkevent EVENT_ROUTE9_ESCORT_GAVE_VOUCHER
	iftrue .do_it_again

	writetext Route9_ForYourEffortText
	promptbutton
	verbosegiveitem VOUCHER
	iffalse .do_it_again

	setevent EVENT_ROUTE9_ESCORT_GAVE_VOUCHER
	sjump .do_it_again

.be_way_faster
	writetext Route9_BeWayFasterText
	promptbutton
	sjump .do_it_again

.be_faster
	writetext Route9_BeFasterText
	promptbutton
	sjump .do_it_again

.too_long
	writetext Route9_TooLongText
	promptbutton
.do_it_again
	writetext Route9_DoItAgainText
	waitbutton
	closetext

	pause 5
	turnobject ROUTE9_ESCORT, DOWN
	pause 5
	
	opentext
	writetext Route9_YahooText
	pause 15
	closetext

	turnobject ROUTE9_ESCORT, DOWN
	pause 15
	playsound SFX_JUMP_OVER_LEDGE
	pause 3
	applymovement ROUTE9_ESCORT, Route9_JumpDownMovement
	loadmem wMap9ObjectMovement, SPRITEMOVEDATA_STANDING_UP
	end

Route9_FollowerAndPlayerFaceEachOtherScript:
	setlasttalked ROUTE9_ESCORT
	farscall WaitForFollowMovementToEnd
	faceplayer
	faceobject PLAYER, ROUTE9_ESCORT
	end

Route9Sign:
	jumptext Route9SignText

Route9HiddenEther:
	hiddenitem ETHER, EVENT_ROUTE_9_HIDDEN_ETHER

Route9_SlowStepBackLeftMovement:
	fix_facing
	slow_step LEFT
	remove_fixed_facing
	step_end

Route9_SlowStepBackRightMovement:
	fix_facing
	slow_step RIGHT
	remove_fixed_facing
	step_end

Route9_StepLeftMovement:
	step LEFT
	step_end

Route9_DestinationMovement:
	step DOWN
	step DOWN
Route9_StepRightMovement:
	step RIGHT
	step_end

Route9_ByeMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

Route9_JumpDownMovement:
	jump_step DOWN
	step_end

CamperDeanSeenText: ; AUTOTRAD
	text "I came to explore"
	line "ROCK TUNNEL."
	done

CamperDeanBeatenText: ; AUTOTRAD
	text "Whoa! Danger, man."
	done

CamperDeanAfterBattleText: ; AUTOTRAD
	text "My #MON were"
	line "hurt before even"

	para "entering ROCK"
	line "TUNNEL."

	para "I'd better take"
	line "them to a #MON"
	cont "CENTER right away."
	done

PicnickerHeidiSeenText: ; AUTOTRAD
	text "Have you ever been"
	line "to a picnic?"

	para "They're so much"
	line "fun!"
	done

PicnickerHeidiBeatenText: ; AUTOTRAD
	text "Ohhhh!"
	done

PicnickerHeidiAfterBattleText: ; AUTOTRAD
	text "We bake lots of"
	line "goodies and share"

	para "them all around."
	line "They're delicious!"
	done

CamperSidSeenText: ; AUTOTRAD
	text "Hey, you!"
	line "Don't litter!"
	done

CamperSidBeatenText: ; AUTOTRAD
	text "I was just point-"
	line "ing out…"
	done

CamperSidAfterBattleText: ; AUTOTRAD
	text "Sorry. You weren't"
	line "littering. It was"
	cont "my mistake."
	done

PicnickerEdnaSeenText: ; AUTOTRAD
	text "People shouldn't"
	line "leave any litter"
	cont "behind."
	done

PicnickerEdnaBeatenText: ; AUTOTRAD
	text "Ohh… I lost…"
	done

PicnickerEdnaAfterBattleText: ; AUTOTRAD
	text "Conserving energy"
	line "is important, but"

	para "the environment is"
	line "even more vital."
	done

HikerTimSeenText: ; AUTOTRAD
	text "She'll be coming"
	line "'round MT.SILVER"
	cont "when she comes…"

	para "MT.SILVER is in"
	line "JOHTO, right?"
	done

HikerTimBeatenText: ; AUTOTRAD
	text "I was too busy"
	line "singing…"
	done

HikerTimAfterBattleText: ; AUTOTRAD
	text "Battles are about"
	line "concentration."
	done

HikerSidneySeenText: ; AUTOTRAD
	text "I'll tell you a"
	line "secret."

	para "But first, we"
	line "battle!"
	done

HikerSidneyBeatenText: ; AUTOTRAD
	text "Oh, dang!"
	line "I lost that…"
	done

HikerSidneyAfterBattleText: ; AUTOTRAD
	text "The POWER PLANT is"
	line "across a small"
	cont "river."
	done

CooltrainerFMariaSeenText: ; TO TRANSLATE
	text "It's a good place"
	line "to do some"
	cont "exercise."
	done

CooltrainerFMariaBeatenText: ; TO TRANSLATE
	text "Mamma mia!"
	done

CooltrainerFMariaAfterBattleText: ; TO TRANSLATE
	text "In the morning,"
	line "some rare #MON"
	cont "exercise here."
	done

CooltrainerMFredSeenText: ; TO TRANSLATE
	text "I run in here"
	line "everyday."
	done

CooltrainerMFredBeatenText: ; TO TRANSLATE
	text "I was looking at"
	line "my girlfriend…"
	done

CooltrainerMFredAfterBattleText: ; TO TRANSLATE
	text "Some FIGHTING"
	line "TYPE #MON keep"
	cont "smashing the rocks"
	cont "which remodels the"
	cont "surroundings."
	done

CooltrainerMAndriySeenText: ; TO TRANSLATE
	text "I saw a man in"
	line "black running"
	cont "towards CERULEAN"
	cont "CITY."
	done

CooltrainerMAndriyBeatenText: ; TO TRANSLATE
	text "Well played!"
	done

CooltrainerMAndriyAfterBattleText: ; TO TRANSLATE
	text "The man in black"
	line "drew my attention"
	cont "because he didn't"
	cont "wear a face mask."
	done

Route9SignText: ; AUTOTRAD
	text "ROUTE 9"

	para "CERULEAN CITY -"
	line "ROCK TUNNEL"
	done

Route9_QuestIntroText: ; TO TRANSLATE
	text "How fast could we"
	line "reach the top of"
	cont "this ledge?"
	done

Route9_QuestIntroSequelText: ; TO TRANSLATE
	text "How about you"
	line "take me there?"
	done

Route9_QuestAcceptedText: ; TO TRANSLATE
	text "Cool! I'll make an"
	line "exception to"
	cont "social distancing,"
	
	para "but we both wear"
	line "a face mask, and"
	
	para "I'm behind you"
	line "so it's safe."
	
	para "Now let's see how"
	line "fast you can go!"
	done

Route9_WrongWayText: ; TO TRANSLATE
	text "That's the wrong"
	line "way! Come back!"
	done

Route9_AbandonmentQuestionText: ; TO TRANSLATE
	text "Are you"
	line "abandoning me?"
	done
	
Route9_BackOnTrackText: ; TO TRANSLATE
	text "Then let's get"
	line "back on track!"
	done

Route9_DestinationReachedText: ; TO TRANSLATE
	text "We've made it!"
	line "That was a"
	cont "fun hike!"
	done

Route9_DisplayHikeDurationText: ; TO TRANSLATE
	text "It took you"
	line "@"
	text_decimal wScriptVar, 1, 3
	text " seconds to"
	cont "reach the end!"
	done

Route9_BeWayFasterText: ; TO TRANSLATE
	text "I'm sure you can do"
	line "it in less time."
	done

Route9_BeFasterText: ; TO TRANSLATE
	text "Be a little faster"
	line "and I'll show"
	cont "recognition."
	done

Route9_CongratsText: ; TO TRANSLATE
	text "What an impres-"
	line "sive performance!"
	done

Route9_ForYourEffortText: ; TO TRANSLATE
	text "Take this for"
	line "your effort."
	done

Route9_TooLongText: ; TO TRANSLATE
	text "It took you for-"
	line "ever to reach the"
	cont "end. I'm sure you"
	cont "can do better!"
	done

Route9_DoItAgainText: ; TO TRANSLATE
	text "If you wanna do it"
	line "again I'll be here!"
	done

Route9_YahooText: ; TO TRANSLATE
	text "Yahoo!"
	done

Route9_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 46, 15, ROCK_TUNNEL_1F, 1

	def_coord_events
	coord_event 44,  8, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route9_WrongWayScript
	coord_event 44,  9, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route9_WrongWayScript
	coord_event  1,  4, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route9_TowardsCeruleanScript
	coord_event 38,  2, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route9_DestinationScript
	coord_event 46,  8, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2, Route9_BreakLinkScript
	coord_event 46,  6, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2, Route9_BreakLinkScript
	coord_event 46,  7, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2, Route9_BreakLinkScript
	coord_event 14,  6, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2, Route9_BreakLink_NoTeleportScript

	def_bg_events
	bg_event 29,  5, BGEVENT_READ, Route9Sign
	bg_event 41, 15, BGEVENT_ITEM, Route9HiddenEther

	def_object_events
	object_event 23, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperDean, -1
	object_event 40,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerPicnickerHeidi, -1
	object_event 10,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerCamperSid, -1
	object_event  8, 14, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerEdna, -1
	object_event 37,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerTim, -1
	object_event 37, 14, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerHikerSidney, -1
	object_event 29,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerFMaria, -1
	object_event 33,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerMFred, -1
	object_event 39,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 3, Route9_EscortGirlScript, -1
	object_event  8, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 1, 1, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerMAndriy, -1
