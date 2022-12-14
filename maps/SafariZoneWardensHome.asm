	object_const_def
	const SAFARIZONEWARDENSHOME_LASS
	const SAFARIZONEWARDENSHOME_NEIGHBOR

SafariZoneWardensHome_MapScripts:
	def_scene_scripts

	def_callbacks

WardensGranddaughter:
	faceplayer
	opentext

	checkevent EVENT_GOT_SAFARI_KEY_2
	iftrue .DefaultText

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

WardenPhoto:
	jumptext WardenPhotoText

SafariZonePhoto:
	jumptext SafariZonePhotoText

WardensHomeBookshelf:
	jumpstd PictureBookshelfScript

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

WardensNeighbor_LadyGoHome1Text:
	text "You were able to"
	line "move the neighbor's"
	cont "boulder out of"
	cont "the way?"
	done

WardensNeighbor_LadyGoHome2Text:
	text "Did you hear that,"
	line "mister?"

	para "This nice person"
	line "moved the boulder."
	
	para "You can go back"
	line "home now!"
	done

WardensNeighbor_ManGoHomeText:
	text "You… you moved"
	line "the boulder that"
	cont "was blocking my"
	cont "house?"

	para "I guess I'm going"
	line "back to living"
	cont "next door."
	done

GiveFirstSafariKeyText:
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

GiveFirstSafariKeyAfterText:
	text "I have plenty of"
	line "those: it is one"
	cont "of the old"
	cont "employee keys."

	para "They are so old"
	line "they often break."
	done

SafariZoneTrustText:
	text "I trust you to be"
	line "respectful in the"
	cont "SAFARI ZONE."
	done

SecondSafariKeyText:
	text "Did you lose or"
	line "break the SAFARI"
	cont "KEY I gave you?"

	para "All right, I'm"
	line "giving you one"
	cont "more, but this is"
	cont "the last one."
	done

WardensGranddaughterText:
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

WardenNeighborText:
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

WardenPhotoText:
	text "It's a photo of a"
	line "grinning old man"

	para "who's surrounded"
	line "by #MON."
	done

SafariZonePhotoText:
	text "It's a photo of a"
	line "huge grassy plain"

	para "with rare #MON"
	line "frolicking in it."
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
	object_event  2,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensGranddaughter, -1
	object_event  2,  2, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensNeighbor, EVENT_WARDENS_NEIGHBOR_AT_NEIGHBORS
