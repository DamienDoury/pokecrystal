	object_const_def
	const BATTLETOWER1F_RECEPTIONIST
	const BATTLETOWER1F_YOUNGSTER
	const BATTLETOWER1F_COOLTRAINER_F
	const BATTLETOWER1F_BUG_CATCHER
	const BATTLETOWER1F_GRANNY

BattleTower1F_MapScripts:
	def_scene_scripts
	scene_script .Scene0 ; SCENE_DEFAULT
	scene_script .Scene1 ; SCENE_FINISHED

	def_callbacks

.Scene0:
	setval BATTLETOWERACTION_CHECKSAVEFILEISYOURS
	special BattleTowerAction
	iffalse .SkipEverything
	setval BATTLETOWERACTION_GET_CHALLENGE_STATE ; readmem sBattleTowerChallengeState
	special BattleTowerAction
	ifequal $0, .SkipEverything
	ifequal $2, .LeftWithoutSaving
	ifequal $3, .SkipEverything
	ifequal $4, .SkipEverything
	opentext
	writetext Text_WeveBeenWaitingForYou
	waitbutton
	closetext
	prioritysjump Script_ResumeBattleTowerChallenge
	end

.LeftWithoutSaving
	prioritysjump BattleTower_LeftWithoutSaving
	setval BATTLETOWERACTION_CHALLENGECANCELED
	special BattleTowerAction
	setval BATTLETOWERACTION_06
	special BattleTowerAction
.SkipEverything:
	setscene SCENE_FINISHED
.Scene1:
	end

BattleTower1FRulesSign:
	opentext
	writetext Text_ReadBattleTowerRules
	yesorno
	iffalse .skip
	writetext Text_BattleTowerRules
	waitbutton
.skip:
	closetext
	end

BattleTower1FReceptionistScript:
	setval BATTLETOWERACTION_GET_CHALLENGE_STATE ; readmem sBattleTowerChallengeState
	special BattleTowerAction
	ifequal $3, Script_BeatenAllTrainers2 ; maps/BattleTowerBattleRoom.asm
	opentext
	writetext Text_BattleTowerWelcomesYou
	promptbutton
	setval BATTLETOWERACTION_CHECK_EXPLANATION_READ ; if new save file: bit 1, [sBattleTowerSaveFileFlags]
	special BattleTowerAction
	ifnotequal $0, Script_Menu_ChallengeExplanationCancel
	sjump Script_BattleTowerIntroductionYesNo

Script_Menu_ChallengeExplanationCancel:
	writetext Text_WantToGoIntoABattleRoom
	setval TRUE
	special Menu_ChallengeExplanationCancel
	ifequal 1, Script_ChooseChallenge
	ifequal 2, Script_BattleTowerExplanation
	sjump Script_BattleTowerHopeToServeYouAgain

Script_ChooseChallenge:
	setval BATTLETOWERACTION_RESETDATA ; ResetBattleTowerTrainerSRAM
	special BattleTowerAction
	special CheckForBattleTowerRules
	ifnotequal FALSE, Script_WaitButton
	writetext Text_SaveBeforeEnteringBattleRoom
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene SCENE_DEFAULT
	special TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene SCENE_FINISHED
	setval BATTLETOWERACTION_SET_EXPLANATION_READ ; set 1, [sBattleTowerSaveFileFlags]
	special BattleTowerAction
	special BattleTowerRoomMenu
	ifequal $a, Script_Menu_ChallengeExplanationCancel
	ifnotequal $0, Script_MobileError
	setval BATTLETOWERACTION_11
	special BattleTowerAction
	writetext Text_RightThisWayToYourBattleRoom
	waitbutton
	closetext
	setval BATTLETOWERACTION_CHOOSEREWARD
	special BattleTowerAction
	sjump Script_WalkToBattleTowerElevator

Script_ResumeBattleTowerChallenge:
	closetext
	setval BATTLETOWERACTION_LOADLEVELGROUP ; load choice of level group
	special BattleTowerAction
Script_WalkToBattleTowerElevator:
	musicfadeout MUSIC_NONE, 8
	setmapscene BATTLE_TOWER_BATTLE_ROOM, SCENE_DEFAULT
	setmapscene BATTLE_TOWER_ELEVATOR, SCENE_DEFAULT
	setmapscene BATTLE_TOWER_HALLWAY, SCENE_DEFAULT
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	stopfollow
	disappear BATTLETOWER1F_RECEPTIONIST
	applymovement PLAYER, MovementData_BattleTower1FPlayerWalksToElevator
	setval BATTLETOWERACTION_0A
	special BattleTowerAction
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applymovement PLAYER, MovementData_BattleTowerHallwayPlayerEntersBattleRoom
	warpcheck
	end

Script_GivePlayerHisPrize:
	setval BATTLETOWERACTION_1C
	special BattleTowerAction
	setval BATTLETOWERACTION_GIVEREWARD
	special BattleTowerAction
	ifequal POTION, Script_YourPackIsStuffedFull
	getitemname STRING_BUFFER_4, USE_SCRIPT_VAR
	giveitem ITEM_FROM_MEM, 5
	writetext Text_PlayerGotFive
	setval BATTLETOWERACTION_1D
	special BattleTowerAction
	closetext
	end

Script_YourPackIsStuffedFull:
	writetext Text_YourPackIsStuffedFull
	waitbutton
	closetext
	end

Script_BattleTowerIntroductionYesNo:
	writetext Text_WouldYouLikeToHearAboutTheBattleTower
	yesorno
	iffalse Script_BattleTowerSkipExplanation
Script_BattleTowerExplanation:
	writetext Text_BattleTowerIntroduction_2
Script_BattleTowerSkipExplanation:
	setval BATTLETOWERACTION_SET_EXPLANATION_READ
	special BattleTowerAction
	sjump Script_Menu_ChallengeExplanationCancel

Script_BattleTowerHopeToServeYouAgain:
	writetext Text_WeHopeToServeYouAgain
	waitbutton
	closetext
	end

Script_WaitButton:
	waitbutton
	closetext
	end

Script_AMonLevelExceeds:
	writetext Text_AMonLevelExceeds
	waitbutton
	sjump Script_Menu_ChallengeExplanationCancel

Script_MayNotEnterABattleRoomUnderL70:
	writetext Text_MayNotEnterABattleRoomUnderL70
	waitbutton
	sjump Script_Menu_ChallengeExplanationCancel

Script_MobileError:
	special BattleTowerMobileError
	closetext
	end

BattleTower_LeftWithoutSaving:
	opentext
	writetext Text_BattleTower_LeftWithoutSaving
	waitbutton
	sjump Script_BattleTowerHopeToServeYouAgain

BattleTower1FYoungsterScript:
	faceplayer
	opentext
	writetext Text_BattleTowerYoungster
	waitbutton
	closetext
	turnobject BATTLETOWER1F_YOUNGSTER, RIGHT
	end

BattleTower1FCooltrainerFScript:
	jumptextfaceplayer Text_BattleTowerCooltrainerF

BattleTower1FBugCatcherScript:
	jumptextfaceplayer Text_BattleTowerBugCatcher

BattleTower1FGrannyScript:
	jumptextfaceplayer Text_BattleTowerGranny

MovementData_BattleTower1FWalkToElevator:
	step UP
	step UP
	step UP
	step UP
	step UP
MovementData_BattleTower1FPlayerWalksToElevator:
MovementData_BattleTowerHallwayPlayerEntersBattleRoom:
	step UP
	step_end

MovementData_BattleTowerElevatorReceptionistExitsElevator:
	step DOWN
	step LEFT
	turn_head DOWN
	step_end

MovementData_BattleTowerHallwayRightRooms:
	step RIGHT
	step RIGHT
	step UP
	step UP
	step_end

MovementData_BattleTowerHallwayLeftRooms:
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

MovementData_BattleTowerHallwayWalkTo1020Room:
	step RIGHT
	step RIGHT
MovementData_BattleTowerHallwayWalkTo3040Room:
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

MovementData_BattleTowerHallwayWalkTo90100Room:
	step LEFT
	step LEFT
MovementData_BattleTowerHallwayWalkTo7080Room:
	step LEFT
	step LEFT
MovementData_BattleTowerHallwayWalkTo5060Room:
	step LEFT
	step LEFT
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomPlayerWalksIn:
	step UP
	step UP
	step LEFT
	step UP
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksIn:
	slow_step DOWN
	slow_step DOWN
	slow_step RIGHT
	slow_step DOWN
	slow_step DOWN
	turn_head LEFT
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksOut:
	turn_head UP
	slow_step UP
	slow_step UP
	slow_step LEFT
	slow_step UP
	slow_step UP
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer:
	slow_step LEFT
	slow_step UP
	slow_step UP
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksAway:
	slow_step DOWN
	slow_step DOWN
	slow_step RIGHT
	step_end

MovementData_BattleTowerElevatorPlayerExitsElevator:
	step DOWN
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceReceptionist:
	turn_head LEFT
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceNextOpponent:
	turn_head RIGHT
	step_end

Text_BattleTowerWelcomesYou: 
if DEF(_FR_FR)
	text "Bienvenue à la"
	line "TOUR DE COMBAT!"

	para "Je peux vous faire"
	line "accéder à une"
	cont "SALLE DE COMBAT."
else
	text "BATTLE TOWER"
	line "welcomes you!"

	para "I could show you"
	line "to a BATTLE ROOM."
endc

	done

Text_WantToGoIntoABattleRoom: 
if DEF(_FR_FR)
	text "Voulez-vous aller"
	line "dans une SALLE"
	cont "DE COMBAT?"
else
	text "Want to go into a"
	line "BATTLE ROOM?"
endc

	done

Text_RightThisWayToYourBattleRoom: 
if DEF(_FR_FR)
	text "Par ici..."
else
	text "Right this way to"
	line "your BATTLE ROOM."
endc

	done

Text_BattleTowerIntroduction_2: 
if DEF(_FR_FR)
	text "La TOUR DE COMBAT"
	line "a été construite"
	cont "pour les matches"
	cont "de #MON."

	para "Divers dresseurs"
	line "viennent s'y af-"

	para "fronter dans les"
	line "SALLES DE COMBAT"
	cont "spéciales."

	para "Il existe beaucoup"
	line "de SALLES diffé-"
	cont "rentes."

	para "Chaque SALLE ren-"
	line "ferme 7 dresseurs."

	para "Il faut tous les"
	line "battre pour gagner"
	cont "un prix."

	para "Pour arrêter une"
	line "session, il faut"

	para "SAUVER. Dans le"
	line "cas contraire, on"

	para "ne peut pas re-"
	line "prendre le défi"
	cont "d'une SALLE."

	para ""
else
	text "BATTLE TOWER is a"
	line "facility made for"
	cont "#MON battles."

	para "Countless #MON"
	line "trainers gather"

	para "from all over to"
	line "hold battles in"

	para "specially designed"
	line "BATTLE ROOMS."

	para "There are many"
	line "BATTLE ROOMS in"
	cont "the BATTLE TOWER."

	para "Each ROOM holds"
	line "seven trainers."

	para "Beat them all, and"
	line "win a prize."

	para "To interrupt a"
	line "session, you must"

	para "SAVE. If not, you"
	line "won't be able to"

	para "resume your ROOM"
	line "challenge."

	para ""
endc

	done

Text_ReceivedAListOfLeadersOnTheHonorRoll: 
if DEF(_FR_FR)
	text "Vous avez reçu une"
	line "liste des CHAM-"
	cont "PIONS sur les TA-"
	cont "BLES de l'HONNEUR."

	para ""
else
	text "Received a list of"
	line "LEADERS on the"
	cont "HONOR ROLL."

	para ""
endc

	done

Text_PleaseConfirmOnThisMonitor: 
if DEF(_FR_FR)
	text "Confirmez sur ce"
	line "moniteur."
else
	text "Please confirm on"
	line "this monitor."
endc

	done

Text_ThanksForVisiting: 
if DEF(_FR_FR)
	text "Merci et à"
	line "bientôt!"
else
	text "Thanks for"
	line "visiting!"
endc

	done

Text_CongratulationsYouveBeatenAllTheTrainers: 
if DEF(_FR_FR)
	text "Félicitations! "
	line "Tous les dresseurs"

	para "ont été vaincus! "
	line "Et hop! Cadeau!"
else
	text "Congratulations!"

	para "You've beaten all"
	line "the trainers!"

	para "For that, you get"
	line "this great prize!"

	para ""
endc

	done

Text_PlayerGotFive: 
if DEF(_FR_FR)
	text "<PLAYER> gagne 5"
	line "@"
	text_ram wStringBuffer4
	text "!@"
else
	text "<PLAYER> got five"
	line "@"
	text_ram wStringBuffer4
	text "!@"
endc

	sound_item
	text_promptbutton
	text_end

Text_YourPackIsStuffedFull: 
if DEF(_FR_FR)
	text "Oups! Le SAC est"
	line "plein."

	para "Il faut faire de"
	line "la place!"
else
	text "Oops, your PACK is"
	line "stuffed full."

	para "Please make room"
	line "and come back."
endc

	done

Text_WeHopeToServeYouAgain: 
if DEF(_FR_FR)
	text "A bientôt,"
	line "j'espère."
else
	text "We hope to serve"
	line "you again."
endc

	done

Text_PleaseStepThisWay: 
if DEF(_FR_FR)
	text "Par ici."
else
	text "Please step this"
	line "way."
endc

	done

Text_WouldYouLikeToHearAboutTheBattleTower: 
if DEF(_FR_FR)
	text "Voulez-vous tout"
	line "savoir sur la TOUR"
	cont "DE COMBAT?"
else
	text "Would you like to"
	line "hear about the"
	cont "BATTLE TOWER?"
endc

	done

Text_CantBeRegistered: 
if DEF(_FR_FR)
	text "Votre progression"
	line "dans la dernière"

	para "SALLE DE COMBAT ne"
	line "peut pas être en-"
	cont "registrée. OK?"
else
	text "Your record from"
	line "the previous"

	para "BATTLE ROOM can't"
	line "be registered. OK?"
endc

	done

Text_CantBeRegistered_PreviousRecordDeleted: 
if DEF(_FR_FR)
	text "Votre progression"
	line "dans la dernière"

	para "SALLE DE COMBAT ne"
	line "peut pas être en-"
	cont "registrée."

	para "De plus, la pro-"
	line "gression existante"
	cont "sera effacée. OK?"
else
	text "Your record from"
	line "the previous"

	para "BATTLE ROOM can't"
	line "be registered."

	para "Also, the existing"
	line "record will be"
	cont "deleted. OK?"
endc

	done

Text_ReadBattleTowerRules: 
if DEF(_FR_FR)
	text "Les règles de la"
	line "TOUR DE COMBAT"

	para "Lire?"
else
	text "BATTLE TOWER rules"
	line "are written here."

	para "Read the rules?"
endc

	done

Text_BattleTowerRules: 
if DEF(_FR_FR)
	text "3 #MON peuvent"
	line "participer."

	para "Les 3 doivent être"
	line "différents."

	para "Les objets tenus"
	line "doivent être aussi"
	cont "différents."

	para "Certains #MON"
	line "peuvent avoir des"

	para "restrictions de"
	line "niveau."
else
	text "Three #MON may"
	line "enter battles."

	para "All three must be"
	line "different."

	para "The items they"
	line "hold must also be"
	cont "different."

	para "Certain #MON"
	line "may also have"

	para "level restrictions"
	line "placed on them."
endc

	done

Text_BattleTower_LeftWithoutSaving: 
if DEF(_FR_FR)
	text "Excusez-moi!"
	line "Vous n'avez pas"
	cont "SAUVE avant de"
	cont "quitter la SALLE"
	cont "DE COMBAT."

	para "Votre défi ne sera"
	line "donc pas pris en"
	cont "compte."
else
	text "Excuse me!"
	line "You didn't SAVE"

	para "before exiting"
	line "the BATTLE ROOM."

	para "I'm awfully sorry,"
	line "but your challenge"

	para "will be declared"
	line "invalid."
endc

	done

Text_YourMonWillBeHealedToFullHealth: 
if DEF(_FR_FR)
	text "Nous allons soi-"
	line "gner vos #MON."
else
	text "Your #MON will"
	line "be healed to full"
	cont "health."
endc

	done

Text_NextUpOpponentNo: 
if DEF(_FR_FR)
	text "Prochain adversai-"
	line "re, le no.@"
	text_ram wStringBuffer3
	text ". OK?"
else
	text "Next up, opponent"
	line "no.@"
	text_ram wStringBuffer3
	text ". Ready?"
endc

	done

Text_SaveBeforeEnteringBattleRoom: 
if DEF(_FR_FR)
	text "Avant d'entrer"
	line "dans une SALLE de"

	para "COMBAT, la partie"
	line "sera SAUVEE."
else
	text "Before entering"
	line "the BATTLE ROOM,"

	para "your progress will"
	line "be saved."
endc

	done

Text_SaveAndEndTheSession: 
if DEF(_FR_FR)
	text "SAUVER et arrêter"
	line "la session?"
else
	text "SAVE and end the"
	line "session?"
endc

	done

Text_SaveBeforeReentry: 
if DEF(_FR_FR)
	text "Votre progression"
	line "sera SAUVEE avant"

	para "de retourner dans"
	line "la dernière SALLE."
else
	text "Your record will"
	line "be SAVED before"

	para "you go back into"
	line "the previous ROOM."
endc

	done

Text_CancelYourBattleRoomChallenge: 
if DEF(_FR_FR)
	text "Annuler le défi"
	line "des SALLES DE"
	cont "COMBAT?"
else
	text "Cancel your BATTLE"
	line "ROOM challenge?"
endc

	done

Text_WeveBeenWaitingForYou: 
if DEF(_FR_FR)
	text "Nous vous atten-"
	line "dions. Par ici"

	para "pour une SALLE DE"
	line "COMBAT."
else
	text "We've been waiting"
	line "for you. This way"

	para "to a BATTLE ROOM,"
	line "please."
endc

	done

Text_FiveDayBattleLimit_Mobile: 
if DEF(_FR_FR)
	text "Vous ne pouvez"
	line "accéder qu'à 5"
	cont "SALLES DE COMBAT"
	cont "par jour."

	para "Revenez demain."
else
	text "You may enter only"
	line "five BATTLE ROOMS"
	cont "each day."

	para "Please come back"
	line "tomorrow."
endc

	done

Text_TooMuchTimeElapsedNoRegister: 
if DEF(_FR_FR)
	text "Il est impossible"
	line "d'enregistrer"

	para "votre progression"
	line "au CENTRE: trop de"

	para "temps s'est écoulé"
	line "depuis le début de"
	cont "votre défi."
else
	text "Sorry, but it's"
	line "not possible to"

	para "register your"
	line "current record at"

	para "the CENTER because"
	line "too much time has"

	para "elapsed since the"
	line "start of your"
	cont "challenge."
endc

	done

Text_AMonLevelExceeds: 
if DEF(_FR_FR)
	text "Un de vos #MON"
	line "ou plus a un ni-"
	cont "veau au-dessus de"
	cont "@"
	text_decimal wScriptVar, 1, 3
	text "."
else
	text "One or more of"
	line "your #MON's"
	cont "levels exceeds @"
	text_decimal wScriptVar, 1, 3
	text "."
endc

	done

Text_MayNotEnterABattleRoomUnderL70: 
if DEF(_FR_FR)
	text_ram wcd49
	text " ne"
	line "peut pas entrer"
	cont "dans une SALLE DE"
	cont "COMBAT avant le"
	cont "N70."

	para "Cette SALLE est"
	line "pour les N@"
	text_decimal wScriptVar, 1, 3
	text "."
else
	text_ram wcd49
	text " may not"
	line "enter a BATTLE"
	cont "ROOM under L70."

	para "This BATTLE ROOM"
	line "is for L@"
	text_decimal wScriptVar, 1, 3
	text "."
endc

	done

Text_BattleTowerYoungster: 
if DEF(_FR_FR)
	text "Détruit par le"
	line "premier adversai-"
	cont "re... Je suis nul!"
else
	text "Destroyed by the"
	line "first opponent in"

	para "no time at all…"
	line "I'm no good…"
endc

	done

Text_BattleTowerCooltrainerF: 
if DEF(_FR_FR)
	text "Il y a plein de"
	line "SALLES DE COMBAT!"
	cont "Mais je vais"
	cont "gagner!"
else
	text "There are lots of"
	line "BATTLE ROOMS, but"

	para "I'm going to win"
	line "them all!"
endc

	done

Text_BattleTowerGranny: 
if DEF(_FR_FR)
	text "C'est difficile de"
	line "se passer d'objets"

	para "pendant les"
	line "combats..."

	para "Faire tenir un ob-"
	line "jet à son #MON"
	cont "ça aide..."
else
	text "It's a grueling"
	line "task, not being"

	para "able to use items"
	line "in battle."

	para "Making your"
	line "#MON hold items"

	para "is the key to"
	line "winning battles."
endc

	done

Text_BattleTowerBugCatcher: 
if DEF(_FR_FR)
	text "J'essaie de voir"
	line "jusqu'où on peut"

	para "aller en n'utili-"
	line "sant que des"
	cont "#MON insecte."

	para "Du moment qu'il"
	line "n'y a pas de"
	cont "#MON de feu..."
else
	text "I'm trying to see"
	line "how far I can go"

	para "using just bug"
	line "#MON."

	para "Don't let there be"
	line "any fire #MON…"
endc

	done

BattleTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  9, BATTLE_TOWER_OUTSIDE, 3
	warp_event  8,  9, BATTLE_TOWER_OUTSIDE, 4
	warp_event  7,  0, BATTLE_TOWER_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, BattleTower1FRulesSign

	def_object_events
	object_event  7,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower1FReceptionistScript, -1
	object_event 14,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BattleTower1FYoungsterScript, -1
	object_event  4,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTower1FCooltrainerFScript, -1
	object_event  1,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattleTower1FBugCatcherScript, -1
	object_event 14,  3, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower1FGrannyScript, -1
