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

OlivinePortSailorGetOnBoardText: 
if DEF(_FR_FR)
	text "Le départ est"
	line "proche. Tout le"
	cont "monde à bord."
else
	text "We're departing"
	line "soon. Please get"
	cont "on board."
endc

	done

OlivinePortCantBoardText: 
if DEF(_FR_FR)
	text "On ne monte plus"
	line "à bord."
else
	text "Sorry. You can't"
	line "board now."
endc

	done

OlivinePortAskBoardText: 
if DEF(_FR_FR)
	text "Bienvenue sur le"
	line "BATEAU EXPRESS:"
	cont "L'AQUARIA."

	para "Allez-vous monter"
	line "à bord?"
else
	text "Welcome to FAST"
	line "SHIP S.S.AQUA."

	para "Will you be board-"
	line "ing today?"
endc

	done

OlivinePortAskTicketText: 
if DEF(_FR_FR)
	text "Puis-je voir votre"
	line "PASSE BATEAU?"
else
	text "May I see your"
	line "S.S.TICKET?"
endc

	done

OlivinePortFlashTicketText: 
if DEF(_FR_FR)
	text "<PLAYER> montre"
	line "son PASSE BATEAU."

	para "Parfait."
	line "Merci bien!"
else
	text "<PLAYER> flashed"
	line "the S.S.TICKET."

	para "That's it."
	line "Thank you!"
endc

	done

OlivinePortAskPassportText:
if DEF(_FR_FR)
	text "J'ai aussi besoin"
	line "de voir ta CARTE"
	cont "DRESSEUR."
else
	text "I also need to see"
	line "your TRAINER CARD."
endc
	done

OlivinePortFakeIDText:
if DEF(_FR_FR)
	text "Quoi? C'est la"
	line "photo de quelqu'un"
	cont "d'autre sur cette"
	cont "CARTE!"

	para "Fuis avant que"
	line "j'appelle la"
	cont "police!"
else
	text "What? It's the pic-"
	line "ture of someone"
	cont "else on the CARD!"

	para "Run away before I"
	line "call the police!"
endc
	done

OlivinePortFlashPassportText:
if DEF(_FR_FR)
	text "Tout est en ordre."
	line "Tu peux passer!"
else
	text "Everything is in"
	line "order. You can"
	cont "go on!"
endc
	done

OlivinePortNoTicketText: 
if DEF(_FR_FR)
	text "<PLAYER> voudrait"
	line "bien montrer son"
	cont "PASSE BATEAU..."

	para "Mais..."
	line "Pas de TICKET!"

	para "Désolé!"
	line "On ne monte à bord"

	para "que sur présenta-"
	line "tion d'un PASSE."
else
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "TICKET…"

	para "…But no TICKET!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.TICKET."
endc

	done

OlivinePortCantShowPassportText:
if DEF(_FR_FR)
	text "<PLAYER> tente de"
	line "montrer sa CARTE"
	cont "DRESSEUR..."
	
	para "...Mais ne"
	line "l'a pas!"
else
	text "<PLAYER> tried to"
	line "show the TRAINER"
	cont "CARD…"

	para "…But doesn't"
	line "have it!"
endc
	done

OlivinePortShowPassportText:
if DEF(_FR_FR)
	text "<PLAYER> montre sa"
	line "CARTE DRESSEUR."
else
	text "<PLAYER> flashed"
	line "the TRAINER CARD."
endc
	done

OlivinePortPassportInvalidText:
if DEF(_FR_FR)
	text "Désolé!"
	
	para "Tu dois montrer"
	line "une CARTE DRESSEUR"
	
	para "avec un PASS"
	line "VACCINAL valide."
else
	text "Sorry!"
	
	para "You need to show"
	line "a TRAINER CARD"

	para "with a valid "
	line "VACCINE PASSPORT."
endc
	done

OlivinePortPassportNoBoosterText:
if DEF(_FR_FR)
	text "Désolé! Ton PASS"
	line "VACCINAL a expiré."

	para "Une dose de rappel"
	line "est désormais"
	cont "requise."
else
	text "Sorry!"
	line "Your VACCINE PASS-"
	cont "PORT is expired."

	para "A booster dose is"
	line "now required."
endc
	done

OlivinePortMondayShipText: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "partira lundi"
	cont "prochain."
else
	text "The FAST SHIP will"
	line "sail next Monday."
endc

	done

OlivinePortWednesdayShipText:
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "partira mercredi"
	cont "prochain."
else
	text "The FAST SHIP will"
	line "sail on Wednesday."
endc
	done

OlivinePortFridayShipText: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "partira vendredi"
	cont "prochain."
else
	text "The FAST SHIP will"
	line "sail next Friday."
endc

	done

OlivinePortSundayShipText:
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "partira dimanche"
	cont "prochain."
else
	text "The FAST SHIP will"
	line "sail next Sunday."
endc
	done

OlivinePortFishingGuru1Text: 
if DEF(_FR_FR)
	text "Les KOKIYAS sont"
	line "faciles à choper"

	para "dans le coin. Ils"
	line "sont plus rares"
	cont "ailleurs."
else
	text "SHELLDER are easy"
	line "to catch here."

	para "They're kind of"
	line "rare elsewhere."
endc

	done

OlivinePortFishingGuru2Text: 
if DEF(_FR_FR)
	text "Combien de CANNES"
	line "as-tu?"

	para "Des CANNES diffé-"
	line "rentes attrapent"
	cont "des #MON diffé-"
	cont "rents."
else
	text "How many RODS do"
	line "you have?"

	para "Different RODS"
	line "catch different"
	cont "#MON."
endc

	done

OlivinePortYoungsterText: 
if DEF(_FR_FR)
	text "L'AQUARIA a des"
	line "propulseurs pour"
	cont "foncer sur l'eau!"
else
	text "S.S.AQUA uses jets"
	line "to skim over the"
	cont "waves!"
endc

	done

OlivinePortCooltrainerFText: 
if DEF(_FR_FR)
	text "Il y a plein de"
	line "#MON à KANTO."

	para "J'aimerais tant"
	line "y aller..."
else
	text "There are lots of"
	line "#MON in KANTO."

	para "I wish I could go…"
endc

	done

OlivinePortSailorBeforeHOFText: 
if DEF(_FR_FR)
	text "On ne veut pas que"
	line "tu tombes à l'eau"

	para "alors tu ne peux"
	line "pas passer."
else
	text "We don't want you"
	line "to fall into the"

	para "sea, so you're not"
	line "allowed in."
endc

	done

OlivinePortAttentionSeekerText:
if DEF(_FR_FR)
	text "Je n'ai pas le"
	line "droit de nager"
	cont "ici."

	para "Je le fais parce"
	line "que j'aime attirer"
	cont "l'attention."

	para "Merci pour ton"
	line "attention!"
else
	text "I'm not allowed"
	line "to swim here."

	para "I do it because"
	line "I'm an attention"
	cont "seeker."

	para "Thanks for your"
	line "attention!"
endc
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
