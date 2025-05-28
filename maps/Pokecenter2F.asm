	object_const_def
	const POKECENTER2F_TRADE_RECEPTIONIST
	const POKECENTER2F_BATTLE_RECEPTIONIST
	const POKECENTER2F_TIME_CAPSULE_RECEPTIONIST
	const POKECENTER2F_OFFICER

Pokecenter2F_MapScripts:
	def_scene_scripts
	scene_script .Scene0 ; SCENE_DEFAULT
	scene_script .Scene1 ; SCENE_POKECENTER2F_LEAVE_TRADE_CENTER
	scene_script .Scene2 ; SCENE_POKECENTER2F_LEAVE_COLOSSEUM
	scene_script .Scene3 ; SCENE_POKECENTER2F_LEAVE_MOBILE_TRADE_ROOM
	scene_script .Scene4 ; SCENE_POKECENTER2F_LEAVE_MOBILE_BATTLE_ROOM

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RaveParty

.RaveParty:
	farscall RavePartyFlag
	endcallback

.Scene0:
	special CheckMysteryGift
	ifequal $0, .Scene0Done
	clearevent EVENT_MYSTERY_GIFT_DELIVERY_GUY
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; Notifies that a Mystery Gift must be delivered.
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Scene0Done
	prioritysjump Pokecenter2F_AppearMysteryGiftDeliveryGuy

.Scene0Done:
	end

.Scene1:
	prioritysjump Script_LeftCableTradeCenter
	end

.Scene2:
	prioritysjump Script_LeftCableColosseum
	end

.Scene3:
	prioritysjump Script_LeftMobileTradeRoom
	end

.Scene4:
	prioritysjump Script_LeftMobileBattleRoom
	end

Pokecenter2F_AppearMysteryGiftDeliveryGuy:
	appear POKECENTER2F_OFFICER
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	end

Script_TradeCenterClosed:
	faceplayer
	opentext
	writetext Text_TradeRoomClosed
	waitbutton
	closetext
	end

Script_BattleRoomClosed:
	faceplayer
	opentext
	writetext Text_BattleRoomClosed
	waitbutton
	closetext
	end

LinkReceptionistScript_Trade:
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iffalse Script_TradeCenterClosed
	opentext
	writetext Text_TradeReceptionistIntro
	yesorno
	iffalse .Cancel

	special SilphCo_GetTestSubjectProgress
	ifequal FALSE, .NoSilphMonInParty

	writetext Text_TradeReceptionistSilphCo
	waitbutton
	closetext
	end

.NoSilphMonInParty:
	callasm IsRedsPikachuIsPlayerParty
	ifequal FALSE, .NoRedsPikachuInParty

	cry PIKACHU
	pause 15
	writetext Text_TradeReceptionistPikachuRefusal
	waitbutton
	closetext
	end

.NoRedsPikachuInParty
	special SetBitsForLinkTradeRequest
	writetext Text_PleaseWait
	special WaitForLinkedFriend
	iffalse .FriendNotReady
	writetext Text_MustSaveGame
	yesorno
	iffalse .DidNotSave
	special TryQuickSave
	iffalse .DidNotSave
	writetext Text_PleaseWait
	special CheckLinkTimeout_Receptionist
	iffalse .LinkTimedOut
	readmem wOtherPlayerLinkMode
	iffalse .LinkedToFirstGen
	special CheckBothSelectedSameRoom
	iffalse .IncompatibleRooms
	writetext Text_PleaseComeIn
	waitbutton
	closetext
	scall Pokecenter2F_CheckGender
	warpcheck
	end

.FriendNotReady:
	special WaitForOtherPlayerToExit
	writetext YourFriendIsNotReadyText
	closetext
	end

.LinkedToFirstGen:
	special FailedLinkToPast
	writetext Text_CantLinkToThePast
	special CloseLink
	closetext
	end

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special CloseLink
	closetext
	end

.LinkTimedOut:
	writetext Text_LinkTimedOut
	sjump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	closetext
	end

.Mobile:
	scall .Mobile_TrySave
	iftrue .Mobile_Abort
	scall BattleTradeMobile_WalkIn
	warpcheck
	end

.Mobile_Abort:
	end

.Mobile_TrySave:
	writetext Text_MustSaveGame
	yesorno
	iffalse .Mobile_DidNotSave
	special TryQuickSave
	iffalse .Mobile_DidNotSave
	special Function1011f1
	writetext Text_PleaseComeIn
	waitbutton
	closetext
	setval FALSE
	end

.Mobile_DidNotSave:
	writetext Text_PleaseComeAgain
	closetext
	setval TRUE
	end

BattleTradeMobile_WalkIn:
	applymovementlasttalked Pokecenter2FMobileMobileMovementData_ReceptionistWalksUpAndLeft_LookDown
	applymovement PLAYER, Pokecenter2FMobileMovementData_PlayerWalksIntoMobileBattleRoom
	end

LinkReceptionistScript_Battle:
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iffalse Script_BattleRoomClosed
	opentext
	writetext Text_BattleReceptionistIntro
	yesorno
	iffalse .Cancel
	special Mobile_DummyReturnFalse ; always returns false
	iffalse .NoMobile
	writetext Text_BattleReceptionistMobile
	special AskMobileOrCable
	iffalse .Cancel
	ifequal $1, .Mobile
.NoMobile:
	special SetBitsForBattleRequest
	writetext Text_PleaseWait
	special WaitForLinkedFriend
	iffalse .FriendNotReady
	writetext Text_MustSaveGame
	yesorno
	iffalse .DidNotSave
	special TryQuickSave
	iffalse .DidNotSave
	writetext Text_PleaseWait
	special CheckLinkTimeout_Receptionist
	iffalse .LinkTimedOut
	readmem wOtherPlayerLinkMode
	iffalse .LinkedToFirstGen
	special CheckBothSelectedSameRoom
	iffalse .IncompatibleRooms
	writetext Text_PleaseComeIn
	waitbutton
	closetext
	scall Pokecenter2F_CheckGender
	warpcheck
	end

.FriendNotReady:
	special WaitForOtherPlayerToExit
	writetext YourFriendIsNotReadyText
	closetext
	end

.LinkedToFirstGen:
	special FailedLinkToPast
	writetext Text_CantLinkToThePast
	special CloseLink
	closetext
	end

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special CloseLink
	closetext
	end

.LinkTimedOut:
	writetext Text_LinkTimedOut
	sjump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	closetext
	end

.Mobile:
	scall .SelectThreeMons
	iffalse .Mobile_Abort
	scall .Mobile_TrySave
	iftrue .Mobile_Abort
	scall BattleTradeMobile_WalkIn
	warpcheck
	end

.Mobile_Abort:
	end

.Mobile_TrySave:
	writetext Text_MustSaveGame
	yesorno
	iffalse .Mobile_DidNotSave
	special Function103780
	iffalse .Mobile_DidNotSave
	special Function1011f1
	writetext Text_PleaseComeIn
	waitbutton
	closetext
	setval FALSE
	end

.Mobile_DidNotSave:
	writetext Text_PleaseComeAgain
	closetext
	setval TRUE
	end

.SelectThreeMons:
	special Mobile_SelectThreeMons
	iffalse .Mobile_DidNotSelect
	ifequal $1, .Mobile_OK
	ifequal $2, .Mobile_OK
	ifequal $3, .Mobile_InvalidParty
	sjump .Mobile_DidNotSelect

.Mobile_InvalidParty:
	writetext Text_BrokeStadiumRules
	waitbutton
.Mobile_DidNotSelect:
	closetext
	setval FALSE
	end

.Mobile_OK:
	setval TRUE
	end

Script_TimeCapsuleClosed:
	jumptext Text_TimeCapsuleClosed

LinkReceptionistScript_TimeCapsule:
	checkevent EVENT_MET_BILL
	iftrue Script_TimeCapsuleClosed
	jumptext Text_TimeCapsuleReceptionistIntro

Script_LeftCableTradeCenter:
	special WaitForOtherPlayerToExit
	scall Script_WalkOutOfLinkTradeRoom
	setscene SCENE_DEFAULT
	end

Script_LeftMobileTradeRoom:
	special Function101220
	scall Script_WalkOutOfMobileTradeRoom
	setscene SCENE_DEFAULT
	setmapscene MOBILE_TRADE_ROOM, SCENE_DEFAULT
	end

Script_WalkOutOfMobileTradeRoom:
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, Pokecenter2FMobileMovementData_ReceptionistWalksUpAndLeft
	applymovement PLAYER, Pokecenter2FMovementData_PlayerWalksOutOfMobileRoom
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, Pokecenter2FMobileMovementData_ReceptionistWalksRightAndDown
	end

Script_LeftCableColosseum:
	special WaitForOtherPlayerToExit
	scall Script_WalkOutOfLinkBattleRoom
	setscene SCENE_DEFAULT
	setmapscene COLOSSEUM, SCENE_DEFAULT
	end

Script_LeftMobileBattleRoom:
	special Function101220
	scall Script_WalkOutOfMobileBattleRoom
	setscene SCENE_DEFAULT
	setmapscene MOBILE_BATTLE_ROOM, SCENE_DEFAULT
	end

Script_WalkOutOfMobileBattleRoom:
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, Pokecenter2FMobileMovementData_ReceptionistWalksUpAndLeft
	applymovement PLAYER, Pokecenter2FMovementData_PlayerWalksOutOfMobileRoom
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, Pokecenter2FMobileMovementData_ReceptionistWalksRightAndDown
	end

Pokecenter2F_CheckGender:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female
	applymovementlasttalked Pokecenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, Pokecenter2FMovementData_PlayerTakesFourStepsUp
	end

.Female:
	applymovementlasttalked Pokecenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, Pokecenter2FMovementData_PlayerTakesThreeStepsUp
	opentext
	writetext Text_OhPleaseWait
	waitbutton
	closetext
	applymovementlasttalked Pokecenter2FMovementData_ReceptionistLooksRight
	turnobject PLAYER, LEFT
	opentext
	writetext Text_ChangeTheLook
	waitbutton
	closetext
	playsound SFX_TINGLE
	applymovement PLAYER, Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	setval (PAL_NPC_RED << 4)
	special SetPlayerPalette
	applymovement PLAYER, Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	setflag ENGINE_KRIS_IN_CABLE_CLUB
	special UpdatePlayerSprite
	opentext
	writetext Text_LikeTheLook
	waitbutton
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, Pokecenter2FMovementData_PlayerTakesOneStepUp
	end

Script_WalkOutOfLinkTradeRoom:
	setlasttalked POKECENTER2F_TRADE_RECEPTIONIST
	sjump Script_WalkOutOfLinkRoom

Script_WalkOutOfLinkBattleRoom:
	setlasttalked POKECENTER2F_BATTLE_RECEPTIONIST
Script_WalkOutOfLinkRoom:
	applymovementlasttalked Pokecenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, Pokecenter2FMovementData_PlayerTakesFourStepsDown

	checkflag ENGINE_KRIS_IN_CABLE_CLUB
	iffalse .DoneWithGenderSwap

; If female:
	applymovementlasttalked Pokecenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, Pokecenter2FMovementData_PlayerTakesOneStepDown
	clearflag ENGINE_KRIS_IN_CABLE_CLUB
	playsound SFX_TINGLE
	applymovement PLAYER, Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	setval (PAL_NPC_BLUE << 4)
	special SetPlayerPalette
	applymovement PLAYER, Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special UpdatePlayerSprite
	applymovement PLAYER, Pokecenter2FMovementData_PlayerTakesThreeStepsDown

.DoneWithGenderSwap
	applymovementlasttalked Pokecenter2FMovementData_ReceptionistStepsRightAndDown
	end

Pokecenter2FLinkRecordSign:
	refreshscreen
	special DisplayLinkRecord
	closetext
	end

Pokecenter2FOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_MYSTERY_GIFT_DELIVERY_GUY
	iftrue .AlreadyGotGift

	writetext Text_MysteryGiftDeliveryGuy_Intro
	promptbutton

;.CheckEmergencyPokeballDelivery:
	checkevent EVENT_ANTI_SOFTLOCK_DELIVERY
	iffalse .MomGiftsOrMysteryGift

	writetext EmergencyBallReceptionText
	promptbutton

	verbosegiveitem POKE_BALL, 1
	iffalse .BagIsFull
	
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; True if a Mystery Gift is available.
	iftrue .ThatsNotAll

	readmem wWhichMomItem
	ifgreater $f, .ThatsNotAll

	sjump .EndDelivery

.ThatsNotAll
	writetext ButThatsNotAllText
	promptbutton

.MomGiftsOrMysteryGift:
	readmem wWhichMomItem
	ifless $10, .MysteryGiftCheck

	writetext Text_MysteryGiftDeliveryGuy_MomDeliveryIntro
	promptbutton

.CheckMomDelivery: ; Check gifts from Mom, and delivers the first one from the list.
	special FindNextDeliveryFromMom
	verbosegiveitem ITEM_FROM_MEM, ITEM_QUANTITY_FROM_MEM
	iffalse .BagIsFull

	readmem wWhichMomItem
	addval $f0 ; Subtracts 1 to the number of items to be delivered. Doesn't affect the lower nybble.
	writemem wWhichMomItem
	ifless $10, .EndMomDelivery

	writetext Text_MysteryGiftDeliveryGuy_NextMomPackage
	promptbutton
	sjump .CheckMomDelivery

.EndMomDelivery:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iffalse .EndDelivery

	writetext Text_MysteryGiftDeliveryGuy_AlsoHave
	promptbutton
	sjump .MysteryGiftCheckAfterText
	
.MysteryGiftCheck:
	writetext Text_MysteryGiftDeliveryGuy_IHaveSomething
	promptbutton
.MysteryGiftCheckAfterText:
	waitsfx
	special GetMysteryGiftItem
	iffalse .BagIsFull
	itemnotify
.EndDelivery:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	setevent EVENT_MYSTERY_GIFT_DELIVERY_GUY
.AlreadyGotGift:
	writetext Text_MysteryGiftDeliveryGuy_Outro
	waitbutton
	closetext
	end

.BagIsFull:
	writetext Text_MysteryGiftDeliveryGuy_NoRoom
	waitbutton
	closetext
	end

Pokecenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight:
	slow_step UP
	slow_step LEFT
	turn_head RIGHT
	step_end

Pokecenter2FMobileMobileMovementData_ReceptionistWalksUpAndLeft_LookDown:
	slow_step UP
	slow_step LEFT
	turn_head DOWN
	step_end

Pokecenter2FMovementData_ReceptionistStepsLeftLooksDown:
	slow_step LEFT
	turn_head DOWN
	step_end

Pokecenter2FMovementData_ReceptionistStepsRightLooksDown:
	slow_step RIGHT
	turn_head DOWN
	step_end

Pokecenter2FMovementData_ReceptionistLooksRight:
	turn_head RIGHT
	step_end

Pokecenter2FMovementData_PlayerTakesFourStepsUp:
	step UP
Pokecenter2FMovementData_PlayerTakesThreeStepsUp:
	step UP
Pokecenter2FMovementData_PlayerTakesTwoStepsUp:
	step UP
Pokecenter2FMovementData_PlayerTakesOneStepUp:
	step UP
	step_end

Pokecenter2FMobileMovementData_PlayerWalksIntoMobileBattleRoom:
	step UP
	step UP
	step RIGHT
	step UP
	step_end

Pokecenter2FMovementData_PlayerWalksLeftAndUp:
	step LEFT
	step UP
	step_end

Pokecenter2FMovementData_PlayerWalksRightAndUp:
	step RIGHT
	step UP
	step_end

Pokecenter2FMovementData_PlayerTakesFourStepsDown:
	step DOWN
Pokecenter2FMovementData_PlayerTakesThreeStepsDown:
	step DOWN
Pokecenter2FMovementData_PlayerTakesTwoStepsDown:
	step DOWN
Pokecenter2FMovementData_PlayerTakesOneStepDown:
	step DOWN
	step_end

Pokecenter2FMovementData_ReceptionistStepsRightAndDown:
	slow_step RIGHT
	slow_step DOWN
	step_end

Pokecenter2FMovementData_ReceptionistStepsLeftLooksRight:
	slow_step LEFT
	turn_head RIGHT
	step_end

Pokecenter2FMobileMovementData_ReceptionistWalksUpAndLeft:
	slow_step UP
	slow_step LEFT
	turn_head RIGHT
	step_end

Pokecenter2FMovementData_PlayerWalksOutOfMobileRoom:
	step DOWN
	step LEFT
	step DOWN
	step DOWN
	step_end

Pokecenter2FMobileMovementData_ReceptionistWalksRightAndDown:
	slow_step RIGHT
	slow_step DOWN
	step_end

Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	step_end

Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head LEFT
	step_end

Pokecenter2FMovementData_PlayerSpinsClockwiseEndsFacingDown:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

Pokecenter2FMovementData_PlayerTakesOneStepRight:
	step RIGHT
	step_end

Pokecenter2FMovementData_PlayerTakesOneStepLeft:
	step LEFT
	step_end

Text_BattleReceptionistMobile: 
if DEF(_FR_FR)
else
	text "Would you like to"
	line "battle over a GAME"

	para "LINK cable or by"
	line "mobile phone?"
endc

	done

Text_TradeReceptionistMobile: 
if DEF(_FR_FR)
else
	text "Would you like to"
	line "trade over a GAME"

	para "LINK cable or by"
	line "mobile phone?"
endc

	done

Text_ThisWayToMobileRoom: ; unreferenced
	text "This way to the"
	line "MOBILE ROOM."
	done

Text_BattleReceptionistIntro: 
if DEF(_FR_FR)
	text "Bienvenue au"
	line "COLISEE du CLUB"
	cont "LINK."

	para "Vous pouvez y"
	line "affronter un(e)"
	cont "ami(e)."

	para "Voulez-vous"
	line "combattre?"
else
	text "Welcome to CABLE"
	line "CLUB COLOSSEUM."

	para "You may battle a"
	line "friend here."

	para "Would you like to"
	line "battle?"
endc

	done

Text_TradeReceptionistIntro: 
if DEF(_FR_FR)
	text "Bienvenue au"
	line "CENTRE TROC."

	para "Vous pouvez y"
	line "faire des échanges"
	cont "de #MON avec"
	cont "un(e) ami(e)."

	para "Voulez-vous"
	line "échanger?"
else
	text "Welcome to CABLE"
	line "TRADE CENTER."

	para "You may trade your"
	line "#MON here with"
	cont "a friend."

	para "Would you like to"
	line "trade?"
endc

	done

Text_TradeReceptionistPikachuRefusal: ; TO TRANSLATE
	text "PIKACHU refuses"
	line "to go in there."
	
	para "You should deposit"
	line "it first."
	done

Text_TradeReceptionistSilphCo: ; TO TRANSLATE
	text "You have a #MON"
	line "that is SILPH CO's"
	cont "property in your"
	cont "party."
	
	para "You are not"
	line "allowed to enter"
	cont "with a #MON"
	cont "you do not own."
	done

Text_TimeCapsuleReceptionistIntro: ; TO TRANSLATE
	text "The CABLE CLUB"
	line "TIME CAPSULE has"
	cont "been closed"
	cont "permanently."

	para "We can't risk"
	line "sending the virus"
	cont "back in time."
	done

YourFriendIsNotReadyText: 
if DEF(_FR_FR)
	text "Votre ami(e) n'est"
	line "pas prêt(e)."
else
	text "Your friend is not"
	line "ready."
endc

	prompt

Text_MustSaveGame: 
if DEF(_FR_FR)
	text "Avant toute conne-"
	line "xion, vous devez"
	cont "sauvegarder."
else
	text "Before opening the"
	line "link, you must"
	cont "save your game."
endc

	done

Text_PleaseWait: 
if DEF(_FR_FR)
	text "Attendre s.v.p."
else
	text "Please wait."
endc

	done

Text_LinkTimedOut: 
if DEF(_FR_FR)
	text "Pas de réponse:"
	line "la connexion a été"
	cont "fermée."

	para "Contactez votre"
	line "ami(e) et recom-"
	cont "mencez plus tard."
else
	text "The link has been"
	line "closed because of"
	cont "inactivity."

	para "Please contact"
	line "your friend and"
	cont "come again."
endc

	prompt

Text_PleaseComeAgain: 
if DEF(_FR_FR)
	text "A bientôt."
else
	text "Please come again."
endc

	prompt

Text_PleaseComeInDuplicate: ; unreferenced
	text "Please come in."
	prompt

Text_TemporaryStagingInLinkRoom: ; unreferenced
	text "We'll put you in"
	line "the link room for"
	cont "the time being."
	done

Text_CantLinkToThePast: 
if DEF(_FR_FR)
	text "Vous ne pouvez pas"
	line "vous connecter au"
	cont "passé ici."
else
	text "You can't link to"
	line "the past here."
endc

	prompt

Text_IncompatibleRooms: 
if DEF(_FR_FR)
	text "Votre ami(e) a"
	line "choisi une salle"
	cont "différente."
else
	text "Incompatible rooms"
	line "were chosen."
endc

	prompt

Text_PleaseComeIn: 
if DEF(_FR_FR)
	text "Entrez s.v.p."
else
	text "Please come in."
endc

	done

Text_RejectMonWithMail: 
if DEF(_FR_FR)
	text "Vous ne pouvez pas"
	line "prendre @"
	text_ram wStringBuffer1
else
	text "You can't take the"
	line "@"
	text_ram wStringBuffer1
	text " that"
	cont "has MAIL with you."
endc

	prompt

Text_TimeCapsuleClosed: 
if DEF(_FR_FR)
	text "Le BLOC TEMPOREL"
	line "est en réparation."
else
	text "I'm sorry--the"
	line "TIME CAPSULE is"
	cont "being adjusted."
endc

	done

Text_TradeRoomClosed: 
if DEF(_FR_FR)
	text "La MACHINE à"
	line "ECHANGES est en"
	cont "réparation."
else
	text "I'm sorry--the"
	line "TRADE MACHINE is"
	cont "being adjusted."
endc

	done

Text_BattleRoomClosed: 
if DEF(_FR_FR)
	text "La MACHINE à"
	line "COMBATS est en"
	cont "réparation."
else
	text "I'm sorry--the"
	line "BATTLE MACHINE is"
	cont "being adjusted."
endc

	done

Text_MysteryGiftDeliveryGuy_Intro: ; TO TRANSLATE
	text "Hello! You're"
	line "<PLAYER>, right?"
	done

Text_MysteryGiftDeliveryGuy_MomDeliveryIntro: ; TO TRANSLATE
	text "Your mom delivered"
	line "this!"
	done

Text_MysteryGiftDeliveryGuy_NextMomPackage: ; TO TRANSLATE
	text "And also this…"
	done

Text_MysteryGiftDeliveryGuy_IHaveSomething: ; TO TRANSLATE
	text "I have a package"
	line "for you."

	para "Here you go!"
	done

Text_MysteryGiftDeliveryGuy_AlsoHave: ; TO TRANSLATE
	text "And I also have"
	line "this package for"
	cont "you. Here you go!"
	done

Text_MysteryGiftDeliveryGuy_Outro: 
if DEF(_FR_FR)
	text "A bientôt."
else
	text "We hope to serve"
	line "you again."
endc

	done

Text_MysteryGiftDeliveryGuy_NoRoom: 
if DEF(_FR_FR)
	text "Oh, tu n'as pas"
	line "de place."

	para "Va dans un CENTRE"
	line "#MON pour"

	para "le récupérer."
else
	text "Oh, you have no"
	line "space for this."

	para "Stop in at any"
	line "#MON CENTER"

	para "across the country"
	line "to pick it up."
endc

	done

Text_OhPleaseWait: 
if DEF(_FR_FR)
	text "Oh, un moment."
else
	text "Oh, please wait."
endc

	done

Text_ChangeTheLook: 
if DEF(_FR_FR)
	text "Il faut changer"
	line "le décor..."
else
	text "We need to change"
	line "the look here…"
endc

	done

Text_LikeTheLook: 
if DEF(_FR_FR)
	text "Le décor vous"
	line "plaît-il?"
else
	text "How does this"
	line "style look to you?"
endc

	done

Text_BrokeStadiumRules: 
if DEF(_FR_FR)
else
	text "Excuse me!"

	para "For STADIUM rules,"
	line "please bring six"

	para "different #MON,"
	line "excluding EGGS."

	para "The six #MON"
	line "must be different."

	para "Also, they must"
	line "not be holding"
	cont "identical items."

	para "Please come back"
	line "when you're ready."
endc

	done

EmergencyBallReceptionText: ; TO TRANSLATE
	text "You have a parcel"
	line "from PROF.ELM."
	done

ButThatsNotAllText: ; TO TRANSLATE
	text "That's not all!"
	done

Pokecenter2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  7, POKECENTER_2F, -1
	warp_event  5,  0, TRADE_CENTER, 1
	warp_event  9,  0, COLOSSEUM, 1
	warp_event  6,  0, MOBILE_TRADE_ROOM, 1
	warp_event 10,  0, MOBILE_BATTLE_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  7,  3, BGEVENT_READ, Pokecenter2FLinkRecordSign

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_Trade, -1
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_Battle, -1
	object_event 13,  3, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_TimeCapsule, -1
	object_event  1,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Pokecenter2FOfficerScript, EVENT_MYSTERY_GIFT_DELIVERY_GUY
