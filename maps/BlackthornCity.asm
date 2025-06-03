	object_const_def
	const BLACKTHORNCITY_TRAVEL_CONTROLLER
	const BLACKTHORNCITY_GRAMPS1
	const BLACKTHORNCITY_GRAMPS2
	const BLACKTHORNCITY_BLACK_BELT
	const BLACKTHORNCITY_COOLTRAINER_F1
	const BLACKTHORNCITY_YOUNGSTER1
	const BLACKTHORNCITY_SANTOS
	const BLACKTHORNCITY_COOLTRAINER_F2
	;const BLACKTHORNCITY_MOVEDELETER_DOOR

BlackthornCity_MapScripts:
	def_scene_scripts
	scene_script .AppearFromDragonShrine ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .Santos

.AppearFromDragonShrine:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iffalse .end

	; The player when out of the Dragon's Den while the Gramps is blocking the entrance.
	; So we play an animation to avoid the overlap.
	
	prioritysjump DragonsDenCutscene
.end
	end

.FlyPoint:
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .FlyPointSequel

	setflag ENGINE_FLYPOINT_BLACKTHORN
	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel
.FlyPointSequel
	readvar VAR_YCOORD
	ifgreater 4, .EndCallback

	checkevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	iftrue .EndCallback

	readmem wCurFreedomState
	ifequal 1 << CURFEW, .EndCallback

	; The player when out of the Dragon's Den while the Gramps is blocking the entrance.
	; So we play an animation to avoid the overlap.

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	moveobject BLACKTHORNCITY_GRAMPS1, 21, 2
	
.EndCallback
	endcallback

.TilesLoad:
	; Move Deleter's House
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock  8, 30, $30 ; Move deleter's house.

	ifnotequal 1 << CURFEW, .EndTilesCallback
	changeblock 14, 28, $38 ; Mart.

.EndTilesCallback
	endcallback

.Santos:
	readvar VAR_WEEKDAY
	ifequal SATURDAY, .SantosAppears
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; BLACKTHORNCITY_SANTOS
	endcallback

.SantosAppears:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; BLACKTHORNCITY_SANTOS
	endcallback

DragonsDenCutscene:
	applymovement PLAYER, BlackthornCity_StepDownMovement
	follow PLAYER, BLACKTHORNCITY_GRAMPS1
	applymovement PLAYER, BlackthornCity_StepDownMovement
	stopfollow
	end

BlackthornGramps1Script:
	faceplayer
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .violated_dragons_den

	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	jumptext BlackthornGrampsRefusesEntryText

.lockdown
	jumptext BlackthornGrampsLockdownText

.violated_dragons_den
	jumptext BlackthornGrampsViolationText

BlackthornGramps2Script:
	faceplayer
	jumptext BlackthornGrampsGrantsEntryText

BlackthornBlackBeltScript:
	checkevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	iftrue .ClearedRadioTower
	jumptextfaceplayer BlackBeltText_WeirdRadio

.ClearedRadioTower:
	jumptextfaceplayer BlackBeltText_VoicesInMyHead

BlackthornCooltrainerF1Script:
	jumptextfaceplayer BlackthornCooltrainerF1Text

BlackthornYoungsterScript:
	faceplayer
	jumptext BlackthornYoungsterText

BlackthornCooltrainerF2Script:
	checkitem TM_HAIL
	iffalse .cant_get_hail

	jumptextfaceplayer BlackthornCooltrainerF2Text

.cant_get_hail
	jumptextfaceplayer BlackthornCooltrainerF2HailText

SantosScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	iftrue .Saturday
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, .NotSaturday
	checkevent EVENT_MET_SANTOS_OF_SATURDAY
	iftrue .MetSantos
	writetext MeetSantosText
	promptbutton
	setevent EVENT_MET_SANTOS_OF_SATURDAY
.MetSantos:
	writetext SantosGivesGiftText
	promptbutton
	verbosegiveitem SPELL_TAG
	iffalse .Done
	setevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	writetext SantosGaveGiftText
	waitbutton
	closetext
	end

.Saturday:
	writetext SantosSaturdayText
	waitbutton
.Done:
	closetext
	end

.NotSaturday:
	writetext SantosNotSaturdayText
	waitbutton
	closetext
	end

BlackthornCitySign:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	setevent EVENT_LORELEI_WANTS_TO_TALK
	clearevent EVENT_RED_BEATEN
endc
	jumptext BlackthornCitySignText

BlackthornGymSign:
	jumptext BlackthornGymSignText

MoveDeletersHouseSign:
	jumptext MoveDeletersHouseSignText

DragonDensSign:
	jumptext DragonDensSignText

BlackthornCityTrainerTips:
	jumptext BlackthornCityTrainerTipsText

BlackthornCityPokecenterSign:
	jumpstd PokecenterSignScript

BlackthornCityMartSign:
	jumpstd MartSignScript

BlackthornCity_DoorScript:
	jumpstd LockdownCurfewClosedDoor

BlackthornCity_StepDownMovement:
	step DOWN
	step_end

BlackthornGrampsRefusesEntryText: 
if DEF(_FR_FR)
	text "Seuls les dres-"
	line "seurs confirmés"

	para "peuvent s'entraî-"
	line "ner ici. Partez."
else
	text "No. Only chosen"
	line "trainers may train"

	para "here."
	line "Please leave."
endc

	done

BlackthornGrampsLockdownText: ; TO TRANSLATE
	text "I know I shouldn't"
	line "be out. But nei-"
	cont "ther should you."

	para "I'm following"
	line "CLAIR's order."
	done

BlackthornGrampsViolationText: ; TO TRANSLATE
	text "How dared you"
	line "enter this sacred"
	cont "place uninvited!"
	done

BlackthornGrampsGrantsEntryText: 
if DEF(_FR_FR)
	text "Si SANDRA le"
	line "permet, son grand-"
	cont "père, le MAITRE,"
	cont "le permet aussi."

	para "Entrez."
else
	text "If CLAIR allows"
	line "it, her grand-"
	cont "father--our MASTER"
	cont "--will also."

	para "You may enter."
endc

	done

BlackBeltText_WeirdRadio: 
if DEF(_FR_FR)
	text "Ma radio est"
	line "fichue!"
	cont "J'ai reçu un drôle"
	cont "de signal bizarre."
else
	text "My radio's busted?"
	line "Lately, I only get"
	cont "this weird signal."
endc

	done

BlackBeltText_VoicesInMyHead: 
if DEF(_FR_FR)
	text "Aahhhh! Des voix"
	line "dans ma tête!"

	para "Hum? J'écoute ma"
	line "radio!"
else
	text "Arooo! Voices in"
	line "my head!"

	para "Huh? I'm listening"
	line "to my radio!"
endc

	done

BlackthornCooltrainerF1Text: 
if DEF(_FR_FR)
	text "Vas-tu faire"
	line "oublier des"
	cont "capacités à tes"
	cont "#MON?"
else
	text "Are you going to"
	line "make your #MON"
	cont "forget some moves?"
endc

	done

BlackthornYoungsterText: 
if DEF(_FR_FR)
	text "Tous les experts"
	line "en dragons vien-"
	cont "nent d'EBENELLE."
else
	text "Dragon masters all"
	line "come from the city"
	cont "of BLACKTHORN."
endc

	done

MeetSantosText: 
if DEF(_FR_FR)
	text "SAMUEL: ..."

	para "On est samedi..."

	para "Et moi je suis"
	line "plus sympa le"
	cont "samedi."
else
	text "SANTOS: …"

	para "It's Saturday…"

	para "I'm SANTOS of"
	line "Saturday…"
endc

	done

SantosGivesGiftText: 
if DEF(_FR_FR)
	text "Tiens..."
else
	text "You can have this…"
endc

	done

SantosGaveGiftText: 
if DEF(_FR_FR)
	text "SAMUEL: ..."

	para "RUNE SORT..."

	para "Les attaques de"
	line "type SPECTRE"
	cont "sont plus fortes."

	para "Ca va t'effrayer,"
	line "tu verras..."
else
	text "SANTOS: …"

	para "SPELL TAG…"

	para "Ghost-type moves"
	line "get stronger…"

	para "It will frighten"
	line "you…"
endc

	done

SantosSaturdayText: 
if DEF(_FR_FR)
	text "SAMUEL: ..."

	para "A la prochaine, un"
	line "autre samedi..."

	para "Je n'aurai plus"
	line "de cadeaux..."
else
	text "SANTOS: …"

	para "See you again on"
	line "another Saturday…"

	para "I won't have any"
	line "more gifts…"
endc

	done

SantosNotSaturdayText: 
if DEF(_FR_FR)
	text "SAMUEL: On n'est"
	line "pas samedi..."
else
	text "SANTOS: Today's"
	line "not Saturday…"
endc

	done

BlackthornCooltrainerF2Text: 
if DEF(_FR_FR)
	text "Alors comme ça"
	line "l'objet au fond de"
	cont "la ROUTE DE GLACE"
	cont "c'était la CT"
	cont "GRELE! Balèze!"
else
	text "So in the end"
	line "the item at the"
	cont "bottom of the ICE"
	cont "PATH was the TM"
	cont "HAIL! Badass!"
endc

	done

BlackthornCooltrainerF2HailText:
if DEF(_FR_FR)
	text "T'as vu l'objet"
	line "au fond de la"
	cont "ROUTE DE GLACE?"

	para "J'ai pas réussi"
	line "à l'attraper."

	para "Je me demande bien"
	line "ce que c'est."
else
	text "Did you see the"
	line "item at the bottom"
	cont "of the ICE PATH?"

	para "I couldn't manage"
	line "to grab it."

	para "I wonder what"
	line "it could be."
endc

	done

BlackthornCitySignText: 
if DEF(_FR_FR)
	text "EBENELLE"

	para "Une montagne calme"
	line "et retirée du"
	cont "reste du monde"
else
	text "BLACKTHORN CITY"

	para "A Quiet Mountain"
	line "Retreat"
endc

	done

BlackthornGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "d'EBENELLE: SANDRA"

	para "La détentrice de"
	line "#MON dragon"
else
	text "BLACKTHORN CITY"
	line "#MON GYM"
	cont "LEADER: CLAIR"

	para "The Blessed User"
	line "of Dragon #MON"
endc

	done

MoveDeletersHouseSignText: 
if DEF(_FR_FR)
	text "CHEZ L'EFFACEUR DE"
	line "CAPACITES"
else
	text "MOVE DELETER'S"
	line "HOUSE"
endc

	done

DragonDensSignText: 
if DEF(_FR_FR)
	text "ANTRE DU DRAGON"
	line "TOUT DROIT"
else
	text "DRAGON'S DEN"
	line "AHEAD"
endc

	done

BlackthornCityTrainerTipsText: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Un #MON tenant"
	line "une BAIE MIRACLE"

	para "se soignera tout"
	line "seul de n'importe"
	cont "quel état."
else
	text "TRAINER TIPS"

	para "A #MON holding"
	line "a MIRACLEBERRY"

	para "will cure itself"
	line "of any status"
	cont "problem."
endc

	done

BlackthornCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 18, 11, BLACKTHORN_GYM_1F, 1
	warp_event 13, 21, BLACKTHORN_DRAGON_SPEECH_HOUSE, 1
	warp_event 29, 23, BLACKTHORN_EMYS_HOUSE, 1
	warp_event 15, 29, BLACKTHORN_MART, 2
	warp_event 21, 29, BLACKTHORN_POKECENTER_1F, 1
	warp_event  9, 31, MOVE_DELETERS_HOUSE, 1
	warp_event 36,  9, ICE_PATH_1F, 2
	warp_event 20,  1, DRAGONS_DEN_1F, 1

	def_coord_events

	def_bg_events
	bg_event 34, 24, BGEVENT_READ, BlackthornCitySign
	bg_event 17, 13, BGEVENT_READ, BlackthornGymSign
	bg_event  7, 31, BGEVENT_READ, MoveDeletersHouseSign
	bg_event 21,  3, BGEVENT_READ, DragonDensSign
	bg_event  5, 25, BGEVENT_READ, BlackthornCityTrainerTips
	bg_event 16, 29, BGEVENT_READ, BlackthornCityMartSign
	bg_event 22, 29, BGEVENT_READ, BlackthornCityPokecenterSign
	bg_event  9, 31, BGEVENT_CLOSED_DOOR, BlackthornCity_DoorScript
	bg_event 15, 29, BGEVENT_CLOSED_DOOR, BlackthornCity_DoorScript

	def_object_events
	object_event 23, 30, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | MORN | DAY, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event 20,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGramps1Script, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	object_event 22,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGramps2Script, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	object_event 24, 31, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornBlackBeltScript, -1
	object_event  9, 25, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornCooltrainerF1Script, -1
	object_event 13, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornYoungsterScript, -1
	object_event 22, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, SantosScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 35, 19, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BlackthornCooltrainerF2Script, -1
	;object_event  9, 31, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornCity_DoorScript, -1
