	object_const_def
	const DAYCARE_GRAMPS
	const DAYCARE_GRANNY

DayCare_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EggCheckCallback

.EggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

DayCareManScript_Inside:
	faceplayer
	opentext
	checkflag ENGINE_PLAYER_SCARED_DAYCARE
	iftrue .DayCareManScared
	checkevent EVENT_GOT_ODD_EGG
	iftrue .AlreadyHaveOddEgg
	writetext DayCareManText_GiveOddEgg
	promptbutton
	closetext
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	special GiveOddEgg
	opentext
	writetext DayCareText_GotOddEgg
	playsound SFX_KEY_ITEM
	waitsfx
	writetext DayCareText_DescribeOddEgg
	waitbutton
	closetext
	setevent EVENT_GOT_ODD_EGG
	end

.PartyFull:
	opentext
	writetext DayCareText_PartyFull
	waitbutton
	closetext
	end

.AlreadyHaveOddEgg:
	special DayCareMan
	ifequal 42, PlayerHasShownInfectedPkmnToDaycare
	waitbutton
	closetext
	end

.DayCareManScared:
	writetext DayCare_ScaredManText
	sjump PlayerHasShownInfectedPkmnToDaycare

DayCareLadyScript:
	faceplayer
	opentext
	checkflag ENGINE_PLAYER_SCARED_DAYCARE
	iftrue .DayCareLadyScared
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .HusbandWasLookingForYou
	special DayCareLady
	ifequal 42, PlayerHasShownInfectedPkmnToDaycare
	waitbutton
	closetext
	end

.HusbandWasLookingForYou:
	writetext Text_GrampsLookingForYou
	waitbutton
	closetext
	end

.DayCareLadyScared:
	writetext DayCare_ScaredLadyText
	sjump PlayerHasShownInfectedPkmnToDaycare

PlayerHasShownInfectedPkmnToDaycare:
	setflag ENGINE_PLAYER_SCARED_DAYCARE
	waitbutton
	closetext
	showemote EMOTE_BOLT, LAST_TALKED, 10
	readvar VAR_FACING
	ifequal UP, .DayCareManStepDown
	ifequal DOWN, .DayCareManStepUp
	ifequal LEFT, .DayCareManStepRight
	applymovementlasttalked DayCareStepLeftMovement
	sjump DayCare_PlayerRunsAway
	end

.DayCareManStepDown:
	applymovementlasttalked DayCareStepDownMovement
	sjump DayCare_PlayerRunsAway

.DayCareManStepUp:
	applymovementlasttalked DayCareStepUpMovement
	sjump DayCare_PlayerRunsAway

.DayCareManStepRight:
	applymovementlasttalked DayCareStepRightMovement
	sjump DayCare_PlayerRunsAway

DayCare_PlayerRunsAway:
	follow PLAYER, LAST_TALKED
	readvar VAR_XCOORD
	ifequal 7, .DayCare_Path6
	ifequal 2, .DayCareManColumn
	ifequal 5, .DayCareLadyColumn
	applymovement PLAYER, DayCarePlayerRunsAway1Movement
	sjump PlayersGoesThroughDoor

.DayCareManColumn:
	readvar VAR_YCOORD
	ifequal 1, .DayCare_Path2
	applymovement PLAYER, DayCarePlayerRunsAway3Movement
	sjump PlayersGoesThroughDoor

.DayCare_Path2:
	applymovement PLAYER, DayCarePlayerRunsAway2Movement
	applymovement PLAYER, DayCarePlayerRunsAway3Movement
	sjump PlayersGoesThroughDoor

.DayCare_Path3:
	applymovement PLAYER, DayCarePlayerRunsAway3Movement
	sjump PlayersGoesThroughDoor

.DayCareLadyColumn:
	readvar VAR_YCOORD
	ifequal 1, .DayCare_Path4
	applymovement PLAYER, DayCarePlayerRunsAway5Movement
	sjump PlayersGoesThroughDoor

.DayCare_Path4:
	applymovement PLAYER, DayCarePlayerRunsAway2Movement
	applymovement PLAYER, DayCarePlayerRunsAway5Movement
	sjump PlayersGoesThroughDoor

.DayCare_Path5:
	applymovement PLAYER, DayCarePlayerRunsAway5Movement
	sjump PlayersGoesThroughDoor

.DayCare_Path6:
	applymovement PLAYER, DayCarePlayerRunsAway6Movement
	applymovement PLAYER, DayCarePlayerRunsAway5Movement
	sjump PlayersGoesThroughDoor

PlayersGoesThroughDoor:
	stopfollow
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	warpfacing LEFT, ROUTE_34, 11, 15
	end

DayCareBookshelf:
	jumpstd DifficultBookshelfScript

DayCareStepUpMovement:
	step UP
	step_end

DayCareStepDownMovement:
	step DOWN
	step_end

DayCareStepLeftMovement:
	step LEFT
	step_end

DayCareStepRightMovement:
	step RIGHT
	step_end

DayCarePlayerRunsAway1Movement:
	step DOWN
	step DOWN
	step DOWN
	turn_head LEFT
	step_end

DayCarePlayerRunsAway2Movement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

DayCarePlayerRunsAway3Movement:
	step DOWN
	step LEFT
	step LEFT
	step_end

DayCarePlayerRunsAway5Movement:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

DayCarePlayerRunsAway6Movement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step_end

Text_GrampsLookingForYou: ; AUTOTRAD
	text "Gramps was looking"
	line "for you."
	done

DayCareManText_GiveOddEgg: ; AUTOTRAD
	text "I'm the DAY-CARE"
	line "MAN."

	para "Do you know about"
	line "EGGS?"

	para "I was raising"
	line "#MON with my"
	cont "wife, you see."

	para "We were shocked to"
	line "find an EGG!"

	para "How incredible is"
	line "that?"

	para "Well, wouldn't you"
	line "like this EGG?"

	para "Then fine, this is"
	line "yours to keep!"
	done

DayCareText_ComeAgain: ; unreferenced
	text "Come again."
	done

DayCareText_GotOddEgg: ; AUTOTRAD
	text "<PLAYER> received"
	line "ODD EGG!"
	done

DayCareText_DescribeOddEgg: ; AUTOTRAD
	text "I found that when"
	line "I was caring for"

	para "someone's #MON"
	line "before."

	para "But the trainer"
	line "didn't want the"

	para "EGG, so I'd kept"
	line "it around."
	done

DayCareText_PartyFull: ; AUTOTRAD
	text "You've no room for"
	line "this."
	done

DayCare_ScaredManText: ; TO TRANSLATE
	text "Go away, you and"
	line "your infected"
	cont "#MON."
	done

DayCare_ScaredLadyText: ; TO TRANSLATE
	text "Are you trying to"
	line "contaminate us??"

	para "Don't come back"
	line "until you are not"
	cont "contagious"
	cont "anymore."
	done

DayCare_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  5, ROUTE_34, 3
	warp_event  0,  6, ROUTE_34, 4
	warp_event  2,  7, ROUTE_34, 5
	warp_event  3,  7, ROUTE_34, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, DayCareBookshelf
	bg_event  1,  1, BGEVENT_READ, DayCareBookshelf

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Inside, EVENT_DAY_CARE_MAN_IN_DAY_CARE
	object_event  5,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DayCareLadyScript, -1
