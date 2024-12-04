	object_const_def
	const CHARCOALKILN_BLACK_BELT
	const CHARCOALKILN_YOUNGSTER
	const CHARCOALKILN_FARFETCHD

CharcoalKiln_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 		  	    	; SCENE_DEFAULT
	scene_script .LockdownFirstDeclarationScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_SPRITES, .MoveCharcoalKilnApprentice
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

.DummyScene0:
	end

.LockdownFirstDeclarationScene:
	prioritysjump LockdownFirstDeclaration
	end

.MoveCharcoalKilnApprentice:
	checkscene
	iffalse .Skip ; if it is SCENE_DEFAULT, then skip.
	moveobject CHARCOALKILN_YOUNGSTER, 0, 4
	turnobject CHARCOALKILN_YOUNGSTER, RIGHT
.Skip:
	endcallback

.TilesLoad
	changeblock  2,  0, $30
	changeblock  6,  0, $1b
	endcallback

LockdownFirstDeclaration:
	setscene SCENE_DEFAULT ; We don't want this script to execute in a loop, so we change the state of the scene.
	turnobject CHARCOALKILN_YOUNGSTER, RIGHT
	turnobject CHARCOALKILN_BLACK_BELT, DOWN
	opentext
	writetext CharcoalKiln_ThanksText
	promptbutton
	verbosegiveitem HM_CUT
	setevent EVENT_GOT_HM01_CUT
	writetext Text_CharcoalMasterOutro
	waitbutton
	closetext
	showemote EMOTE_SHOCK, CHARCOALKILN_BLACK_BELT, 15
	turnobject CHARCOALKILN_BLACK_BELT, UP
	pause 15
	opentext
	writetext CharcoalKiln_SomethingsHappeningOnTVText
	waitbutton
	closetext
	applymovement CHARCOALKILN_YOUNGSTER, CharcoalKiln_AssistantToTVMovement
	applymovement PLAYER, CharcoalKiln_PlayerToTVMovement
	musicfadeout MUSIC_NONE, 31
	opentext
	writetext CharcoalKiln_ProgramInterruptionText
	promptbutton
	farwritetext _FirstLockdownDeclarationText
	waitbutton
	closetext
	pause 30
	musicfadeout MUSIC_AZALEA_TOWN, 4
	turnobject CHARCOALKILN_YOUNGSTER, LEFT
	applymovement PLAYER, CharcoalKiln_PlayerToCornerMovement
	clearevent EVENT_LOCKDOWN_MART_RUSH
	setevent EVENT_EXPLAIN_SHORTAGE_MECHANICS
	pause 60
	opentext
	writetext CharcoalKiln_YoungsterReactionText
	waitbutton
	closetext
	pause 30
	showemote EMOTE_SHOCK, CHARCOALKILN_YOUNGSTER, 20
	opentext 
	writetext CharcoalKiln_YoungsterRushsMartText
	waitbutton
	closetext
	applymovement CHARCOALKILN_YOUNGSTER, CharcoalKiln_ApprenticeRunsToMartMovement
	turnobject PLAYER, DOWN
	playsound SFX_EXIT_BUILDING
	disappear CHARCOALKILN_YOUNGSTER
	setevent EVENT_CHARCOAL_KILN_APPRENTICE
	specialphonecall SPECIALCALL_LOCKDOWN_ANNOUNCEMENT
	waitsfx
	opentext 
	writetext CharcoalKiln_MasterReactionText
	waitbutton
	closetext
	end

CharcoalKilnBoss:
	checkevent EVENT_FIRST_CURFEW_STARTED
	iftrue .Curfew
	checkevent EVENT_LOCKDOWN_MART_RUSH
	iffalse .Panic
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .SavedSlowpoke
	jumptextfaceplayer CharcoalKilnBossText1

.Curfew:
	jumptextfaceplayer CharcoalKilnBossCurfewText

.Panic:
	jumptextfaceplayer CharcoalKilnBossPanicText

.SavedSlowpoke:
	jumptextfaceplayer CharcoalKilnBossText2

CharcoalKilnApprentice:
	checkevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
	iftrue .YoureTheCoolest
	checkevent EVENT_GOT_HM01_CUT
	iftrue .Thanks
	jumptextfaceplayer CharcoalKilnApprenticeText1

.Thanks:
	faceplayer
	opentext
	writetext CharcoalKilnApprenticeText2
	promptbutton
	verbosegiveitem CHARCOAL
	iffalse .Done

	setevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
.Done
	closetext
	end

.YoureTheCoolest:
	jumptextfaceplayer CharcoalKilnApprenticeText3

CharcoalKilnFarfetchd:
	faceplayer
	opentext
	writetext FarfetchdText
	cry FARFETCH_D
	waitbutton
	closetext
	end

CharcoalKilnBookshelf:
	jumpstd MagazineBookshelfScript

CharcoalKilnRadio:
	jumpstd Radio2Script

CharcoalKiln_AssistantToTVMovement:
	step RIGHT
	step UP
	step UP
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

CharcoalKiln_PlayerToTVMovement:
	step LEFT
	step UP
	step UP
	step_end

CharcoalKiln_PlayerToCornerMovement:
	slow_step UP
	turn_head RIGHT
	step_end

CharcoalKiln_ApprenticeRunsToMartMovement:
	big_step RIGHT
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step LEFT
	big_step LEFT
	big_step DOWN
	big_step DOWN
	step_end

CharcoalKilnBossText1:
	text "All the SLOWPOKE"
	line "have disappeared"
	cont "from the town."

	para "The forest's pro-"
	line "tector may be"
	cont "angry with us…"

	para "It may be a bad"
	line "omen. We should"
	cont "stay in."
	done

CharcoalKilnBossText2:
	text "The SLOWPOKE have"
	line "returned…"

	para "But my APPRENTICE"
	line "hasn't come back"
	cont "from ILEX FOREST."

	para "Where in the world"
	line "is that lazy guy?"
	done

CharcoalKilnBossCurfewText:
	text "I've visited my"
	line "family in"
	cont "ECRUTEAK CITY."

	para "I missed them so"
	line "much during the"
	cont "lockdown!"
	done

CharcoalKilnApprenticeText1:
	text "APPRENTICE: Where"
	line "have all the"
	cont "SLOWPOKE gone?"

	para "Are they out play-"
	line "ing somewhere?"
	done

CharcoalKilnApprenticeText2:
	text "APPRENTICE: I'm"
	line "sorry--I forgot"
	cont "to thank you."

	para "This is CHARCOAL"
	line "that I made."

	para "Fire-type #MON"
	line "would be happy to"
	cont "hold that."
	done

CharcoalKilnApprenticeText3:
	text "APPRENTICE: The"
	line "SLOWPOKE came"
	cont "back, and you even"
	cont "found FARFETCH'D."

	para "You're the cool-"
	line "est, man!"
	done

FarfetchdText:
	text "FARFETCH'D: Kwaa!"
	done

CharcoalKiln_ThanksText:
	text "To thank you for"
	line "helping us, I'd"
	cont "like you to have"
	cont "this."
	done

Text_CharcoalMasterOutro:
	text "That's the CUT HM."
	line "Teach that to a"

	para "#MON to clear"
	line "small trees."
	done

CharcoalKiln_SomethingsHappeningOnTVText:
	text "What's happening?"

	para "An important"
	line "announcement is"
	cont "about to start on"
	cont "TV. We should"
	cont "watch it!"
	done

CharcoalKiln_ProgramInterruptionText:
	text "“We interrupt"
	line "your program for"
	cont "an official"
	cont "declaration.”"

	para "…"

	done

CharcoalKiln_YoungsterReactionText:
	text "APPRENTICE: Well,"
	line "that's something…"
	done

CharcoalKiln_YoungsterRushsMartText:
	text "I gotta go to the"
	line "#MON MART"
	cont "before we can't!"
	done

CharcoalKiln_MasterReactionText:
	text "How can we manage"
	line "to stay inside?"

	para "Should I join"
	line "my family in"
	cont "ECRUTEAK CITY?"
	done

CharcoalKilnBossPanicText:
	text "How does the"
	line "self-made written"
	cont "attestation work?"
	done

CharcoalKiln_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, AZALEA_TOWN, 2
	warp_event  3,  7, AZALEA_TOWN, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CharcoalKilnBookshelf
	bg_event  1,  1, BGEVENT_READ, CharcoalKilnBookshelf
	bg_event  6,  1, BGEVENT_READ, CharcoalKilnBookshelf
	bg_event  7,  1, BGEVENT_READ, CharcoalKilnBookshelf

	def_object_events
	object_event  2,  3, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CharcoalKilnBoss, EVENT_CHARCOAL_KILN_BOSS
	object_event  5,  3, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CharcoalKilnApprentice, EVENT_CHARCOAL_KILN_APPRENTICE
	object_event  5,  6, SPRITE_FARFETCH_D, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CharcoalKilnFarfetchd, EVENT_CHARCOAL_KILN_FARFETCH_D
