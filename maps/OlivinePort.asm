	object_const_def
	const OLIVINEPORT_SAILOR1
	const OLIVINEPORT_SAILOR2
	const OLIVINEPORT_SAILOR3
	const OLIVINEPORT_FISHING_GURU1
	const OLIVINEPORT_FISHING_GURU2
	const OLIVINEPORT_YOUNGSTER
	const OLIVINEPORT_COOLTRAINER_F

OlivinePort_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .LeaveFastShip ; SCENE_OLIVINEPORT_LEAVE_SHIP

	def_callbacks

.DummyScene0:
	end

.LeaveFastShip:
	prioritysjump .LeaveFastShipScript
	end

.LeaveFastShipScript:
	applymovement PLAYER, OlivinePortLeaveFastShipMovement
	appear OLIVINEPORT_SAILOR1
	setscene SCENE_DEFAULT
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod OLIVINE_CITY
	end

OlivinePortSailorAtGangwayScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue OlivinePortAlreadyRodeScript
	writetext OlivinePortSailorGetOnBoardText
	waitbutton
	closetext
	turnobject OLIVINEPORT_SAILOR1, DOWN
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear OLIVINEPORT_SAILOR1
	waitsfx
	applymovement PLAYER, OlivinePortEnterFastShipMovement
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse .FirstTime
	clearevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	setevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	clearevent EVENT_BEAT_COOLTRAINERM_SEAN
	clearevent EVENT_BEAT_COOLTRAINERF_CAROL
	clearevent EVENT_BEAT_GENTLEMAN_EDWARD
	clearevent EVENT_BEAT_BEAUTY_CASSIE
	clearevent EVENT_BEAT_PSYCHIC_RODNEY
	clearevent EVENT_BEAT_SUPER_NERD_SHAWN
	clearevent EVENT_BEAT_SAILOR_GARRETT
	clearevent EVENT_BEAT_FISHER_JONAH
	clearevent EVENT_BEAT_BLACKBELT_WAI
.FirstTime:
	clearevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear OLIVINEPORT_SAILOR1
	setmapscene FAST_SHIP_1F, SCENE_FASTSHIP1F_ENTER_SHIP
	warp FAST_SHIP_1F, 25, 1
	end

OlivinePortAlreadyRodeScript:
	writetext OlivinePortCantBoardText
	waitbutton
	closetext
	end

OlivinePortBoardingCheck:
	readvar VAR_MAPNUMBER
	ifequal MAP_VERMILION_PORT, .Kanto

	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse .DayOK

	readvar VAR_WEEKDAY
	ifequal SUNDAY, .NextShipMonday
	ifequal SATURDAY, .NextShipMonday
	ifequal TUESDAY, .NextShipFriday
	ifequal WEDNESDAY, .NextShipFriday
	ifequal THURSDAY, .NextShipFriday
	sjump .DayOK

.Kanto:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .NextShipWednesday
	ifequal TUESDAY, .NextShipWednesday
	ifequal THURSDAY, .NextShipSunday
	ifequal FRIDAY, .NextShipSunday
	ifequal SATURDAY, .NextShipSunday

.DayOK:
	writetext OlivinePortAskBoardText
	yesorno
	iffalse .NotRidingScript

	writetext OlivinePortAskTicketText
	promptbutton
	checkitem S_S_TICKET
	iffalse .NoTicket

	writetext OlivinePortFlashTicketText

.VaccinePassportCheckStart: ; Used by Train Station agents.
	readmem wCurFreedomState
	ifnotequal 1 << VACCINE_PASSPORT, .SkipVaccinePassportCheck

	promptbutton
	writetext OlivinePortAskPassportText
	promptbutton

	callstd IsVaccinePassportValid
	ifequal 1, .NoTrainerCard

	writetext OlivinePortShowPassportText
	promptbutton

	checkevent EVENT_GOT_FAKE_ID
	iftrue .FakeID
	
	callstd IsVaccinePassportValid
	ifequal 2, .PassportInvalid
	ifequal 3, .NoBooster

	writetext OlivinePortFlashPassportText

.SkipVaccinePassportCheck
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; When set, prevents the player from being checked again when boarding a ship. No effect in Train Stations.

	readvar VAR_MAPGROUP
	ifnotequal GROUP_OLIVINE_PORT, .SkipClosingText ; GROUP_OLIVINE_PORT is the same as GROUP_VERMILION_PORT, but does contain any train station.

	waitbutton
	closetext
.SkipClosingText
	setval TRUE ; The player can board the transport.
	end

.FakeID:
	writetext OlivinePortFakeIDText
	sjump .TextEndCantEnter

.NotRidingScript:
	farwritetext NurseGoodbyeText
	sjump .TextEndCantEnter

.NoTicket:
	writetext OlivinePortNoTicketText
	sjump .TextEndCantEnter

.NoTrainerCard:
	writetext OlivinePortCantShowPassportText
	promptbutton
	writetext OlivinePortPassportInvalidText
	sjump .TextEndCantEnter

.PassportInvalid:
	writetext OlivinePortPassportInvalidText
	sjump .TextEndCantEnter

.NoBooster:
	writetext OlivinePortPassportNoBoosterText
	sjump .TextEndCantEnter

.NextShipMonday:
	writetext OlivinePortMondayShipText
	sjump .TextEndCantEnter

.NextShipWednesday:
	writetext OlivinePortWednesdayShipText
	sjump .TextEndCantEnter

.NextShipFriday:
	writetext OlivinePortFridayShipText
	sjump .TextEndCantEnter

.NextShipSunday:
	writetext OlivinePortSundayShipText
	sjump .TextEndCantEnter

.TextEndCantEnter
	waitbutton
	closetext

	readvar VAR_MAPGROUP
	ifnotequal GROUP_OLIVINE_PORT, .DontMove ; GROUP_OLIVINE_PORT is the same as GROUP_VERMILION_PORT, but does contain any train station.

	readvar VAR_XCOORD
	ifnotequal 7, .DontMove

	readvar VAR_YCOORD
	ifnotequal 15, .DontMove
	
	applymovement PLAYER, OlivinePortCannotEnterFastShipMovement
.DontMove
	setval FALSE ; The player is not allowed to board the ship.
	end





OlivinePortWalkUpToShipScript:
	turnobject OLIVINEPORT_SAILOR3, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .skip
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .skip
	turnobject PLAYER, LEFT
	opentext
	
	scall OlivinePortBoardingCheck
	iffalse .skip

	applymovement PLAYER, OlivinePortApproachFastShipFirstTimeMovement
	sjump OlivinePortSailorAtGangwayScript

.skip:
	end

OlivinePortSailorAfterHOFScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue OlivinePortAlreadyRodeScript

	scall OlivinePortBoardingCheck
	iffalse .skip

	applymovement PLAYER, OlivinePortApproachFastShipAfterHOFMovement
	applymovement PLAYER, OlivinePortApproachFastShipFirstTimeMovement
	sjump OlivinePortSailorAtGangwayScript

.skip
	end

OlivinePortSailorBeforeHOFScript:
	jumptextfaceplayer OlivinePortSailorBeforeHOFText

OlivinePortFishingGuru1Script:
	faceplayer
	opentext
	writetext OlivinePortFishingGuru1Text
	waitbutton
	closetext
	turnobject OLIVINEPORT_FISHING_GURU1, UP
	end

OlivinePortFishingGuru2Script:
	faceplayer
	opentext
	writetext OlivinePortFishingGuru2Text
	waitbutton
	closetext
	turnobject OLIVINEPORT_FISHING_GURU2, UP
	end

OlivinePortYoungsterScript:
	faceplayer
	opentext
	writetext OlivinePortYoungsterText
	waitbutton
	closetext
	turnobject OLIVINEPORT_YOUNGSTER, DOWN
	end

OlivinePortCooltrainerFScript:
	faceplayer
	opentext
	writetext OlivinePortCooltrainerFText
	waitbutton
	closetext
	turnobject OLIVINEPORT_COOLTRAINER_F, DOWN
	end

OlivinePortAttentionSeekerScript:
	jumptextfaceplayer OlivinePortAttentionSeekerText

OlivinePortHiddenProtein:
	hiddenitem PROTEIN, EVENT_OLIVINE_PORT_HIDDEN_PROTEIN

OlivinePortEnterFastShipMovement:
	step DOWN
	step DOWN
	step_end

OlivinePortLeaveFastShipMovement:
	step UP
	step UP
	step_end

OlivinePortCannotEnterFastShipMovement:
	step RIGHT
	turn_head LEFT
	step_end

OlivinePortApproachFastShipFirstTimeMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

OlivinePortApproachFastShipAfterHOFMovement:
	step LEFT
	step_end

OlivinePortSailorGetOnBoardText: ; AUTOTRAD
	text "We're departing"
	line "soon. Please get"
	cont "on board."
	done

OlivinePortCantBoardText: ; AUTOTRAD
	text "Sorry. You can't"
	line "board now."
	done

OlivinePortAskBoardText: ; AUTOTRAD
	text "Welcome to FAST"
	line "SHIP S.S.AQUA."

	para "Will you be board-"
	line "ing today?"
	done

OlivinePortAskTicketText: ; AUTOTRAD
	text "May I see your"
	line "S.S.TICKET?"
	done

OlivinePortFlashTicketText: ; AUTOTRAD
	text "<PLAYER> flashed"
	line "the S.S.TICKET."

	para "That's it."
	line "Thank you!"
	done

OlivinePortAskPassportText: ; TO TRANSLATE
	text "I also need to see"
	line "your TRAINER CARD."
	done

OlivinePortFakeIDText: ; TO TRANSLATE
	text "What? It's the pic-"
	line "ture of someone"
	cont "else on the CARD!"

	para "Run away before I"
	line "call the police!"
	done

OlivinePortFlashPassportText: ; TO TRANSLATE
	text "Everything is in"
	line "order. You can"
	cont "go on!"
	done

OlivinePortNoTicketText: ; AUTOTRAD
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "TICKET…"

	para "…But no TICKET!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.TICKET."
	done

OlivinePortCantShowPassportText: ; TO TRANSLATE
	text "<PLAYER> tried to"
	line "show the TRAINER"
	cont "CARD…"

	para "…But doesn't"
	line "have it!"
	done

OlivinePortShowPassportText: ; TO TRANSLATE
	text "<PLAYER> flashed"
	line "the TRAINER CARD."
	done

OlivinePortPassportInvalidText: ; TO TRANSLATE
	text "Sorry!"
	
	para "You need to show"
	line "a TRAINER CARD"

	para "with a valid "
	line "VACCINE PASSPORT."
	done

OlivinePortPassportNoBoosterText: ; TO TRANSLATE
	text "Sorry!"
	line "Your VACCINE PASS-"
	cont "PORT is expired."

	para "A booster dose is"
	line "now required."
	done

OlivinePortMondayShipText: ; AUTOTRAD
	text "The FAST SHIP will"
	line "sail next Monday."
	done

OlivinePortWednesdayShipText: ; TO TRANSLATE
	text "The FAST SHIP will"
	line "sail on Wednesday."
	done

OlivinePortFridayShipText: ; AUTOTRAD
	text "The FAST SHIP will"
	line "sail next Friday."
	done

OlivinePortSundayShipText: ; TO TRANSLATE
	text "The FAST SHIP will"
	line "sail next Sunday."
	done

OlivinePortFishingGuru1Text: ; AUTOTRAD
	text "SHELLDER are easy"
	line "to catch here."

	para "They're kind of"
	line "rare elsewhere."
	done

OlivinePortFishingGuru2Text: ; AUTOTRAD
	text "How many RODS do"
	line "you have?"

	para "Different RODS"
	line "catch different"
	cont "#MON."
	done

OlivinePortYoungsterText: ; AUTOTRAD
	text "S.S.AQUA uses jets"
	line "to skim over the"
	cont "waves!"
	done

OlivinePortCooltrainerFText: ; AUTOTRAD
	text "There are lots of"
	line "#MON in KANTO."

	para "I wish I could go…"
	done

OlivinePortSailorBeforeHOFText: ; AUTOTRAD
	text "We don't want you"
	line "to fall into the"

	para "sea, so you're not"
	line "allowed in."
	done

OlivinePortAttentionSeekerText: ; TO TRANSLATE
	text "I'm not allowed"
	line "to swim here."

	para "I do it because"
	line "I'm an attention"
	cont "seeker."

	para "Thanks for your"
	line "attention!"
	done

OlivinePort_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11,  7, OLIVINE_PORT_PASSAGE, 5
	warp_event  7, 23, FAST_SHIP_1F, 1

	def_coord_events
	coord_event  7, 15, CE_SCENE_ID, SCENE_DEFAULT, OlivinePortWalkUpToShipScript

	def_bg_events
	bg_event  1, 22, BGEVENT_ITEM, OlivinePortHiddenProtein

	def_object_events
	object_event  7, 23, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorAtGangwayScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	object_event  7, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorBeforeHOFScript, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  5, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailorAfterHOFScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event  3, 14, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortFishingGuru1Script, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event 13, 14, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortFishingGuru2Script, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  3, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortYoungsterScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event 11, 15, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortCooltrainerFScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event  5, 13, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortAttentionSeekerScript, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
