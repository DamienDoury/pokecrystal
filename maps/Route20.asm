	object_const_def
	const ROUTE20_SWIMMER_GIRL1
	const ROUTE20_SWIMMER_GIRL2
	const ROUTE20_SWIMMER_GUY
	const ROUTE20_ESCORT_SWIMMER
	const ROUTE20_TEACHER_SARAH
	const ROUTE20_SWIMMER_GUY2

Route20_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RavePartyCheck

.RavePartyCheck:
	farscall RavePartyFlag
	checkevent EVENT_CINNABAR_RAVE_PARTY
	clearevent EVENT_CINNABAR_RAVE_PARTY
	iffalse .endcallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
.endcallback
	endcallback

TrainerSwimmerfNicole:
	trainer SWIMMERF, NICOLE, EVENT_BEAT_SWIMMERF_NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfNicoleAfterBattleText

TrainerSwimmerfLori:
	trainer SWIMMERF, LORI, EVENT_BEAT_SWIMMERF_LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfLoriAfterBattleText

TrainerSwimmermCameron:
	trainer SWIMMERM, CAMERON, EVENT_BEAT_SWIMMERM_CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermCameronAfterBattleText

TrainerTeacherSarah:
	trainer TEACHER, SARAH, EVENT_BEAT_TEACHER_SARAH, TeacherSarahSeenText, TeacherSarahBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TeacherSarahAfterBattleText

TrainerSwimmerMFinn:
	trainer SWIMMERM, FINN, EVENT_BEAT_SWIMMER_FINN, SwimmerMFinnSeenText, SwimmerMFinnBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerMFinnAfterBattleText

WaitForFollowMovementToEnd:
	callasm ResetStepVector
	readmem wObjectFollow_Follower
	ifequal  0, .break_loop
	ifequal -1, .break_loop

.loop
	callasm HandleLastTalkedStep
	callasm NextOverworldFrame
	callasm HandleMapBackground
	pause 1
	callasm GetFollowerAction ; Returns the follower's action in wScriptVar.
	ifnotequal OBJECT_ACTION_STAND, .loop

.break_loop
	end

Route20_DeadEndScript:
	setlasttalked ROUTE20_ESCORT_SWIMMER
	scall WaitForFollowMovementToEnd
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; When true, it means the player is stuck in a dead-end, and the follower is waiting for the player to leave it.
Route20_StopFollowScript:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	stopfollow
	end

Route20_LeavingDeadEndScript_TowardsTop:
	applymovement ROUTE20_ESCORT_SWIMMER, JoinPlayerBeforeFollowing.FollowRightMovement
	sjump Route20_JustFollowScript

Route20_LeavingDeadEndScript_TowardsLeft:
	applymovement ROUTE20_ESCORT_SWIMMER, JoinPlayerBeforeFollowing.FollowDownMovement

Route20_JustFollowScript:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setlasttalked ROUTE20_ESCORT_SWIMMER
	sjump Route20_FollowScript

Route20_EscortScript:
	faceplayer
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .behind_you

	opentext
	writetext Route20_EscortQuestIntroText
	promptbutton
	writetext Route20_BehindYouText
	waitbutton
	closetext

	scall NPCFollowsPlayer
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; When true, the player is being actively followed.
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; When true, the player escort quest is active.
.end
	end

.behind_you
	jumptext Route20_BehindYouText

Route20_SeafoamDialogScript:
	setlasttalked ROUTE20_ESCORT_SWIMMER
	scall WaitForFollowMovementToEnd
	faceplayer
	showemote EMOTE_SHOCK, ROUTE20_ESCORT_SWIMMER, 15
	faceobject PLAYER, ROUTE20_ESCORT_SWIMMER
	opentext
	writetext Route20_EscortSeafoamText
	waitbutton
	closetext
	applymovement ROUTE20_ESCORT_SWIMMER, JoinPlayerBeforeFollowing.FollowLeftMovement
	end

Route20_ReachedDestinationScript_FromTop:
	applymovement PLAYER, JoinPlayerBeforeFollowing.DownRightMovement
	setlasttalked ROUTE20_ESCORT_SWIMMER
	scall WaitForFollowMovementToEnd
	scall Route20_StopFollowScript
	applymovement PLAYER, Route20_TurnHeadLeftMovement
	applymovement ROUTE20_ESCORT_SWIMMER, Route20_MoveLeftThenFacePlayerMovement
	sjump Route20_ReachedDestinationScript

Route20_ReachedDestinationScript_FromRight:
	setlasttalked ROUTE20_ESCORT_SWIMMER
	scall WaitForFollowMovementToEnd
	scall Route20_StopFollowScript
	applymovement PLAYER, Route20_TurnHeadLeftMovement
	applymovement ROUTE20_ESCORT_SWIMMER, Route20_SMovement

Route20_ReachedDestinationScript:
	showemote EMOTE_HAPPY, ROUTE20_ESCORT_SWIMMER, 15
	pause 10

	farscall RavePartyFlag
	checkevent EVENT_CINNABAR_RAVE_PARTY
	clearevent EVENT_CINNABAR_RAVE_PARTY
	opentext
	iftrue .rave_ongoing

	writetext Route20_SwimmerRescueEpilogueText
	sjump .sequel

.rave_ongoing
	writetext Route20_SwimmerRaveOngoingText
.sequel
	waitbutton
	closetext

	applymovement ROUTE20_ESCORT_SWIMMER, Route20_BacktrackMovement
	disappear ROUTE20_ESCORT_SWIMMER
	reloadmappart
	end

Route20_SeafoamDirectionScript_VeryTop:
	scall Route20_SeafoamDialogScript
	applymovement ROUTE20_ESCORT_SWIMMER, JoinPlayerBeforeFollowing.FollowDown2Movement
	sjump Route20_SeafoamBacktrackScript

Route20_SeafoamDirectionScript_Top:
	scall Route20_SeafoamDialogScript
	applymovement ROUTE20_ESCORT_SWIMMER, JoinPlayerBeforeFollowing.FollowDownMovement
	sjump Route20_SeafoamBacktrackScript

Route20_SeafoamDirectionScript_Bot:
	scall Route20_SeafoamDialogScript
	applymovement ROUTE20_ESCORT_SWIMMER, JoinPlayerBeforeFollowing.FollowUpMovement
	sjump Route20_SeafoamBacktrackScript

Route20_SeafoamDirectionScript:
	scall Route20_SeafoamDialogScript

Route20_SeafoamBacktrackScript:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	scall Route20_StopFollowScript

	readvar VAR_FACING
	ifequal DOWN, .long_backtrack
	applymovement ROUTE20_ESCORT_SWIMMER, Route20_BacktrackMovement
	sjump .disappear

.long_backtrack
	applymovement ROUTE20_ESCORT_SWIMMER, Route20_BacktrackFurtherMovement
.disappear
	disappear ROUTE20_ESCORT_SWIMMER
	appear ROUTE20_ESCORT_SWIMMER
	reloadmappart
	end

NPCFollowsPlayer:
	scall JoinPlayerBeforeFollowing
Route20_FollowScript:
	follow PLAYER, LAST_TALKED
	end

JoinPlayerBeforeFollowing:
	readvar VAR_FACING
	ifequal LEFT, .FollowRight
	ifequal RIGHT, .FollowLeft
	ifequal UP, .FollowDown

	; ifequal DOWN
	applymovementlasttalked .FollowUpMovement
	end

.FollowRight
	applymovementlasttalked .FollowRightMovement
	end

.FollowLeft
	applymovementlasttalked .FollowLeftMovement
	end

.FollowDown
	applymovementlasttalked .FollowDownMovement
	end

.DownRightMovement
	step DOWN
.FollowRightMovement
	step RIGHT
	step_end

.FollowLeftMovement
	step LEFT
	step_end

.FollowDown2Movement
	step DOWN
.FollowDownMovement
	step DOWN
	step_end

.FollowUpMovement
	step UP
	step_end

Route20_BacktrackFurtherMovement:
	step LEFT
Route20_BacktrackMovement:
	step LEFT
	step LEFT
	step LEFT
	step_end

Route20_SMovement:
	step LEFT
	step DOWN
Route20_MoveLeftThenFacePlayerMovement:
	step LEFT
	turn_head RIGHT
	step_end

Route20_TurnHeadLeftMovement:
	turn_head LEFT
	step_end

CinnabarGymSign:
	jumptext CinnabarGymSignText

SwimmerfNicoleSeenText:
	text "I feel so much"
	line "lighter in water."
	done

SwimmerfNicoleBeatenText:
	text "Oh, no!"
	done

SwimmerfNicoleAfterBattleText:
	text "Swimming exercises"
	line "your full body."

	para "It's really good"
	line "for you."
	done

SwimmerfLoriSeenText:
	text "What an impressive"
	line "collection of GYM"

	para "BADGES. We should"
	line "battle!"
	done

SwimmerfLoriBeatenText:
	text "No!"
	done

SwimmerfLoriAfterBattleText:
	text "SURF is no longer"
	line "the only HM move"
	cont "you use in water."
	done

SwimmermCameronSeenText:
	text "I guess it's im-"
	line "possible to swim"

	para "all the way to"
	line "JOHTO."
	done

SwimmermCameronBeatenText:
	text "Aiyah!"
	done

SwimmermCameronAfterBattleText:
	text "Besides the sea, I"
	line "can also swim in"
	cont "ponds and rivers."
	done

TeacherSarahSeenText:
	text "How did I end"
	line "up here?"
	done

TeacherSarahBeatenText:
	text "My head hurts…"
	done

TeacherSarahAfterBattleText:
	text "What happened?"
	done

SwimmerMFinnSeenText:
	text "Woah! Did you"
	line "traverse the"
	cont "SEAFOAM ISLANDS?"
	done

SwimmerMFinnBeatenText:
	text "No wonder you went"
	line "through."
	done

SwimmerMFinnAfterBattleText:
	text "Have you been to"
	line "the very bottom?"

	para "I've heard you can"
	line "see the inside of"
	cont "the volcano."
	done

CinnabarGymSignText:
	text "SEAFOAM ISLANDS"

	para "DANGER OF"
	line "COLLAPSE"

	para "DO NOT ENTER"
	done

Route20_EscortQuestIntroText:
	text "I'm lost."
	line "Help me!"
	done

Route20_BehindYouText:
	text "I need to go to"
	line "CINNABAR ISLAND."
	cont "Lead the way!"
	done

Route20_EscortSeafoamText:
	text "These are the"
	line "SEAFOAM ISLANDS!"

	para "You're getting me"
	line "even more lost!"

	para "Plus, this place"
	line "is dangerous."

	para "I'm backtracking to"
	line "to where we met."
	done

Route20_SwimmerRescueEpilogueText:
	text "You did it!"

	para "I must've drifted"
	line "from here after"
	cont "the last rave."

	para "Maybe I'll see you"
	line "at the next one!"
	done

Route20_SwimmerRaveOngoingText:
	text "We're right on"
	line "time! The party's"
	cont "raging!"

	para "Come with me!"
	done


Route20_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 50,  5, SEAFOAM_W1F, 2
	warp_event 58,  7, SEAFOAM_E1F, 2

	def_coord_events
	coord_event 54, 12, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_SeafoamDirectionScript_VeryTop
	coord_event 55, 13, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_SeafoamDirectionScript_Top
	coord_event 56, 14, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_SeafoamDirectionScript
	coord_event 57, 15, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_SeafoamDirectionScript_Bot
	coord_event 58, 16, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_SeafoamDirectionScript_Bot
	coord_event 39, 16, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_DeadEndScript
	coord_event  1, 16, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_ReachedDestinationScript_FromRight
	coord_event  0, 15, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, Route20_ReachedDestinationScript_FromTop
	coord_event 38, 16, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3, Route20_LeavingDeadEndScript_TowardsLeft
	coord_event 39, 15, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3, Route20_LeavingDeadEndScript_TowardsTop

	def_bg_events
	bg_event 59,  9, BGEVENT_READ, CinnabarGymSign

	def_object_events
	object_event 72,  8, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfNicole, -1
	object_event 65, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfLori, -1
	object_event 37,  7, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermCameron, -1
	object_event 45,  3, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route20_EscortScript, EVENT_SWIMMER_RESCUE
	object_event 29, 15, SPRITE_TEACHER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_TRAINER, 2, TrainerTeacherSarah, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	object_event 89,  5, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 5, TrainerSwimmerMFinn, -1
