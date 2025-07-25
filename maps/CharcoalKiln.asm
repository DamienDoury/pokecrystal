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

.LockdownFirstDeclarationScene:
	prioritysjump LockdownFirstDeclaration
.DummyScene0:
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
if DEF(_FR_FR)
	text "Tous les RAMOLOSS"
	line "ont disparu"
	cont "de la ville."

	para "On risque d'avoir"
	line "des ennuis avec"
	cont "le protecteur de"
	cont "la forêt..."

	para "C'est peut-être un"
	line "mauvais présage."
	cont "On devrait rester"
	cont "chez soi."
else
	text "All the SLOWPOKE"
	line "have disappeared"
	cont "from the town."

	para "The forest's pro-"
	line "tector may be"
	cont "angry with us…"

	para "It may be a bad"
	line "omen. We should"
	cont "stay in."
endc

	done

CharcoalKilnBossText2: 
if DEF(_FR_FR)
	text "Les RAMOLOSS sont"
	line "de retour..."

	para "Mais mon APPRENTI"
	line "n'est pas revenu"
	cont "du BOIS AUX"
	cont "CHENES."

	para "Où est donc ce"
	line "dresseur de"
	cont "troisième zone?"
else
	text "The SLOWPOKE have"
	line "returned…"

	para "But my APPRENTICE"
	line "hasn't come back"
	cont "from ILEX FOREST."

	para "Where in the world"
	line "is that lazy guy?"
endc

	done

CharcoalKilnBossCurfewText:
if DEF(_FR_FR)
	text "J'ai rendu visite"
	line "à ma famille à"
	cont "ROSALIA."

	para "Ils m'ont tant"
	line "manqué durant"
	cont "le confinement!"
	done
else
	text "I've visited my"
	line "family in"
	cont "ECRUTEAK CITY."

	para "I missed them so"
	line "much during the"
	cont "lockdown!"
	done
endc

CharcoalKilnApprenticeText1:
if DEF(_FR_FR)
	text "APPRENTI: Où sont"
	line "passés les"
	cont "RAMOLOSS?"

	para "Sont-ils dehors en"
	line "train de traîner?"
	done
else
	text "APPRENTICE: Where"
	line "have all the"
	cont "SLOWPOKE gone?"

	para "Are they out play-"
	line "ing somewhere?"
	done
endc

CharcoalKilnApprenticeText2:
if DEF(_FR_FR)
	text "APPRENTI: Pardonne"
	line "moi, j'ai oublié"
	cont "de te remercier."

	para "J'ai produit ce"
	line "CHARBON."

	para "Les #MON de feu"
	line "seront contents"
	cont "d'en tenir un."
	done
else
	text "APPRENTICE: I'm"
	line "sorry--I forgot"
	cont "to thank you."

	para "This is CHARCOAL"
	line "that I made."

	para "Fire-type #MON"
	line "would be happy to"
	cont "hold that."
	done
endc

CharcoalKilnApprenticeText3:
if DEF(_FR_FR)
	text "APPRENTI: Les"
	line "RAMOLOSS sont"
	cont "revenus, et tu as"
	cont "même retrouvé"
	cont "CANARTICHO."

	para "Trop classe!"
	done
else
	text "APPRENTICE: The"
	line "SLOWPOKE came"
	cont "back, and you even"
	cont "found FARFETCH'D."

	para "You're the cool-"
	line "est, man!"
	done
endc

FarfetchdText: 
if DEF(_FR_FR)
	text "CANARTICHO: Ticho!"
else
	text "FARFETCH'D: Kwaa!"
endc

	done

CharcoalKiln_ThanksText:
if DEF(_FR_FR)
	text "Pour te remercier,"
	line "j'aimerais que tu"
	cont "prennes ceci."
	done
else
	text "To thank you for"
	line "helping us, I'd"
	cont "like you to have"
	cont "this."
	done
endc

Text_CharcoalMasterOutro:
if DEF(_FR_FR)
	text "C'est la CS COUPE."
	line "Apprends-la à"

	para "un #MON pour"
	line "couper les petits"
	cont "arbres."
	done
else
	text "That's the CUT HM."
	line "Teach that to a"

	para "#MON to clear"
	line "small trees."
	done
endc

CharcoalKiln_SomethingsHappeningOnTVText:
if DEF(_FR_FR)
	text "Que se passe-t-il?"

	para "Une annonce"
	line "importante va"
	cont "commencer à la"
	cont "TV. Regardons!"
	done
else
	text "What's happening?"

	para "An important"
	line "announcement is"
	cont "about to start on"
	cont "TV. We should"
	cont "watch it!"
	done
endc

CharcoalKiln_ProgramInterruptionText:
if DEF(_FR_FR)
	text "“Nous interrompons"
	line "votre programme"
	cont "pour une"
	cont "déclaration"
	cont "officielle.”"

	para "..."
	done
else
	text "“We interrupt"
	line "your program for"
	cont "an official"
	cont "declaration.”"

	para "…"

	done
endc

CharcoalKiln_YoungsterReactionText:
if DEF(_FR_FR)
	text "APPRENTI: Eh bien,"
	line "c'est pas rien..."
	done
else
	text "APPRENTICE: Well,"
	line "that's something…"
	done
endc

CharcoalKiln_YoungsterRushsMartText:
if DEF(_FR_FR)
	text "Je fonce à la"
	line "BOUTIQUE #MON"
	cont "avant qu'il soit"
	cont "trop tard!"
	done
else
	text "I gotta go to the"
	line "#MON MART"
	cont "before we can't!"
	done
endc

CharcoalKiln_MasterReactionText:
if DEF(_FR_FR)
	text "Comment va-t-on"
	line "pouvoir rester"
	cont "enfermés?"

	para "Dois-je rejoindre"
	line "ma famille à"
	cont "ROSALIA?"
	done
else
	text "How can we manage"
	line "to stay inside?"

	para "Should I join"
	line "my family in"
	cont "ECRUTEAK CITY?"
	done
endc

CharcoalKilnBossPanicText:
if DEF(_FR_FR)
	text "Comment marche"
	line "l'attestation"
	cont "manuscrite?"
	done
else
	text "How does the"
	line "self-made written"
	cont "attestation work?"
	done
endc

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
