	object_const_def
	const SAFARIZONEWARDENSHOME_LASS
	const SAFARIZONEWARDENSHOME_NEIGHBOR
	const SAFARIZONEWARDENSHOME_DOCUMENT

SafariZoneWardensHome_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	checkevent EVENT_SAFARI_PARK_EMPLOYEES
	iftrue .end

	scall WardensHouse_DisplayDocument

.end
	endcallback

WardensGranddaughter:
	faceplayer
	opentext

	checkevent EVENT_GOT_SAFARI_KEY_2
	iftrue .CheckBuyPark

	checkevent EVENT_GOT_SAFARI_KEY_1
	iftrue .CheckIfNeedSecondKey

	checkevent EVENT_WARDENS_NEIGHBOR_BACK_INTO_HOUSE
	iffalse .CheckGiveFirstKey ; The neighbor left this house.

	checkevent EVENT_WARDENS_NEIGHBOR_BOULDER_CLEARED
	iffalse .GoHomeCutScene ; The boulder has been cleared.

	; fallthrough

.DefaultText
	writetext WardensGranddaughterText
.WaitButton
	waitbutton
.CloseText
	closetext
	end

.GoHomeCutScene
	writetext  WardensNeighbor_LadyGoHome1Text
	promptbutton
	closetext

	pause 3
	faceobject SAFARIZONEWARDENSHOME_NEIGHBOR, SAFARIZONEWARDENSHOME_LASS
	faceobject SAFARIZONEWARDENSHOME_LASS, SAFARIZONEWARDENSHOME_NEIGHBOR
	faceobject SAFARIZONEWARDENSHOME_NEIGHBOR, PLAYER
	pause 3

	opentext
	writetext WardensNeighbor_LadyGoHome2Text
	promptbutton
	closetext

	scall WardensNeighborGoesHomeScript

	faceobject SAFARIZONEWARDENSHOME_NEIGHBOR, PLAYER
	faceplayer
	opentext

	; fallthrough

.CheckGiveFirstKey
	checkitem SAFARI_KEY
	iftrue .ThankfulText

	writetext GiveFirstSafariKeyText
	promptbutton
	verbosegiveitem SAFARI_KEY
	iffalse .CloseText

	writetext GiveFirstSafariKeyAfterText
	promptbutton
	writetext SafariZoneTrustText
	waitbutton
	setevent EVENT_GOT_SAFARI_KEY_1
	sjump .CloseText

.CheckIfNeedSecondKey
	checkitem SAFARI_KEY
	iftrue .ThankfulText

	writetext SecondSafariKeyText
	promptbutton
	verbosegiveitem SAFARI_KEY
	iffalse .CloseText

	setevent EVENT_GOT_SAFARI_KEY_2
	sjump .CloseText

.ThankfulText
	writetext SafariZoneTrustText
	sjump .WaitButton

.RefusalText
	writetext WardensGranddaughter_RefusalText
	sjump .WaitButton

.CheckBuyPark
	checkitem SAFARI_KEY
	iftrue .ThankfulText

	writetext WardensGranddaughter_ForSaleText
	yesorno
	iffalse .RefusalText

	checkmoney YOUR_MONEY, 999999
	ifequal HAVE_LESS, .NotEnough

	; Deal accepted.
	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 999999
	waitsfx
	closetext

	pause 3
	applymovement SAFARIZONEWARDENSHOME_LASS, WardensHome_SignMovement
	pause 3
	scall WardensHouse_DisplayDocument
	pause 10

	opentext
	writetext WardensGranddaughter_SignText
	waitbutton
	closetext

	readvar VAR_YCOORD
	ifequal 4, .move_right
	ifequal 6, .last_step

; y = 2
	applymovement PLAYER, WardensHouse_PlayerDownMovement
	sjump .down

.move_right
	applymovement PLAYER, WardensHouse_PlayerRightMovement
.down
	applymovement PLAYER, WardensHouse_PlayerRight2Movement
.last_step
	applymovement PLAYER, WardensHouse_PlayerLastStepMovement

	pause 15

	opentext
	writetext WardensGranddaughter_OwnText
	playsound SFX_CAUGHT_MON
	pause 30
	waitbutton
	waitsfx
	closetext

	pause 8
	
	opentext
	writetext WardensGranddaughter_PlansText
	waitbutton
	closetext

	turnobject PLAYER, DOWN
	applymovement SAFARIZONEWARDENSHOME_LASS, WardensHouse_OutMovement
	warpsound
	disappear SAFARIZONEWARDENSHOME_LASS
	appear SAFARIZONEWARDENSHOME_DOCUMENT
	waitsfx
	end

.NotEnough
	writetext WardensGranddaughter_NotEnoughText
	sjump .WaitButton

WardensNeighbor:
	checkevent EVENT_WARDENS_NEIGHBOR_BOULDER_CLEARED
	iftrue .DefaultText ; The boulder has not been cleared yet.

	faceplayer
	opentext
	writetext WardensNeighbor_ManGoHomeText
	waitbutton
	closetext 

	sjump WardensNeighborGoesHomeScript

.DefaultText
	jumptextfaceplayer WardenNeighborText

WardensNeighborGoesHomeScript:
	applymovement SAFARIZONEWARDENSHOME_NEIGHBOR, NeighborGoesHomeMovement
	pause 3
	warpsound
	disappear SAFARIZONEWARDENSHOME_NEIGHBOR ; also does: setevent EVENT_WARDENS_NEIGHBOR_AT_NEIGHBORS.
	clearevent EVENT_WARDENS_NEIGHBOR_BACK_INTO_HOUSE
	waitsfx
	end

WardensHouse_DisplayDocument:
	changeblock  2,  4, $34 ; Displays a books with a pencil.
	end

WardenPhoto:
	jumptext WardenPhotoText

SafariZonePhoto:
	jumptext SafariZonePhotoText

WardensHomeBookshelf:
	jumpstd PictureBookshelfScript

WardensHouseLegalDocument:
	jumptext SafariZoneOwnerText

NeighborGoesHomeMovement:
	slow_step LEFT
	slow_step DOWN
	slow_step DOWN
	slow_step DOWN
	slow_step DOWN
	slow_step DOWN
	slow_step RIGHT
	turn_head DOWN
	step_end

WardensHome_SignMovement:
	slow_step DOWN
	turn_head RIGHT
	step_end

WardensHouse_OutMovement:
	slow_step DOWN
	slow_step DOWN
	step_end

WardensHouse_PlayerDownMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

WardensHouse_PlayerRightMovement:
	step RIGHT
	step_end

WardensHouse_PlayerRight2Movement:
	step DOWN
	step DOWN
	step RIGHT
	step_end

WardensHouse_PlayerLastStepMovement:
	step RIGHT
	turn_head UP
	step_end
	
WardensNeighbor_LadyGoHome1Text: ; TO TRANSLATE
	text "You were able to"
	line "move the neighbor's"
	cont "boulder out of"
	cont "the way?"
	done

WardensNeighbor_LadyGoHome2Text: ; TO TRANSLATE
	text "Did you hear that,"
	line "mister?"

	para "This nice person"
	line "moved the boulder."
	
	para "You can go back"
	line "home now!"
	done

WardensNeighbor_ManGoHomeText: ; TO TRANSLATE
	text "You… you moved"
	line "the boulder that"
	cont "was blocking my"
	cont "house?"

	para "I guess I'm going"
	line "back to living"
	cont "next door."
	done

GiveFirstSafariKeyText: ; TO TRANSLATE
	text "Thank you so much"
	line "for removing this"
	cont "boulder!"

	para "I couldn't bear"
	line "the neighbor"
	cont "anymore, I thought"
	cont "he was never going"
	cont "to leave!"

	para "Here is a valuable"
	line "present for"
	cont "freeing me."
	done

GiveFirstSafariKeyAfterText: ; TO TRANSLATE
	text "I have plenty of"
	line "those: it is one"
	cont "of the old"
	cont "employee keys."

	para "They are so old"
	line "and rusty that"
	cont "they often break."
	done

SafariZoneTrustText: ; TO TRANSLATE
	text "I trust you to be"
	line "respectful in the"
	cont "SAFARI ZONE."
	done

SecondSafariKeyText: ; TO TRANSLATE
	text "Did you lose or"
	line "break the SAFARI"
	cont "KEY I gave you?"

	para "All right, I'm"
	line "giving you one"
	cont "more, but this is"
	cont "the last one."
	done

WardensGranddaughterText: ; TO TRANSLATE
	text "My grandpa is the"
	line "SAFARI ZONE WAR-"
	cont "DEN."

	para "At least he was…"

	para "The lockdown"
	line "ruined his"
	cont "business, so he"

	para "took off overseas"
	line "all by himself."

	para "He quit running"
	line "SAFARI ZONE just"
	cont "like that."
	done

WardensGranddaughter_ForSaleText: ; TO TRANSLATE
	text "Hey! You seem to"
	line "enjoy the SAFARI"
	cont "ZONE, right?"
	
	para "Tourists haven't"
	line "come back to"
	cont "FUCHSIA CITY,"
	
	para "so I want to"
	line "get rid of the"
	cont "SAFARI ZONE."
	
	para "I'm selling it"
	line "for ¥999999."
	
	para "It is very cheap"
	line "for a business!"

	para "You could have it"
	line "all for yourself!"

	para "Would you be"
	line "interested in"
	cont "buying it?"
	done

WardensGranddaughter_NotEnoughText: ; TO TRANSLATE
	text "Oh dear, you don't"
	line "have enough."
	done

WardensGranddaughter_RefusalText: ; TO TRANSLATE
	text "You've been there"
	line "several times,"
	
	para "I thought you"
	line "liked it…"
	done

WardensGranddaughter_SignText: ; TO TRANSLATE
	text "Sign here, and"
	line "it's yours."
	done

WardensGranddaughter_OwnText: ; TO TRANSLATE
	text "<PLAYER> owns"
	line "the SAFARI ZONE!"
	done

WardensGranddaughter_PlansText: ; TO TRANSLATE
	text "I have thought"
	line "about it, and I"
	
	para "want to do like"
	line "my grandfather."

	para "That's why I'm"
	line "leaving town."

	para "Good luck"
	line "with your new"
	cont "acquisition!"
	done

WardenNeighborText: ; TO TRANSLATE
	text "I used to live"
	line "next door, but"

	para "the eruption shot"
	line "a boulder that is"
	cont "blocking the front"
	cont "door of my house."

	para "Luckily, my house"
	line "has a backdoor I"
	cont "can use whenever"
	cont "I need my stuff."

	para "This young lady is"
	line "letting me live"
	cont "in her grandpa's" 
	
	para "bedroom until"
	line "my house gets"
	cont "repaired."

	para "Nice, hehe!"
	done

WardenPhotoText: ; AUTOTRAD
	text "It's a photo of a"
	line "grinning old man"

	para "who's surrounded"
	line "by #MON."
	done

SafariZonePhotoText: ; AUTOTRAD
	text "It's a photo of a"
	line "huge grassy plain"

	para "with rare #MON"
	line "frolicking in it."
	done

SafariZoneOwnerText: ; TO TRANSLATE
	text "“This document"
	line "certifies that"
	cont "<PLAYER> is the"
	cont "legal owner of"
	cont "the SAFARI ZONE.”"
	done

SafariZoneWardensHome_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 6
	warp_event  3,  7, FUCHSIA_CITY, 6
	warp_event  3,  0, FUCHSIA_CITY, 13

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, WardensHomeBookshelf
	bg_event  1,  1, BGEVENT_READ, WardensHomeBookshelf
	bg_event  7,  0, BGEVENT_READ, WardenPhoto
	bg_event  9,  0, BGEVENT_READ, SafariZonePhoto

	def_object_events
	object_event  2,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensGranddaughter, EVENT_BOUGHT_SAFARI_PARK
	object_event  2,  2, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensNeighbor, EVENT_WARDENS_NEIGHBOR_AT_NEIGHBORS
	object_event  3,  5, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WardensHouseLegalDocument, EVENT_SAFARI_PARK_EMPLOYEES
