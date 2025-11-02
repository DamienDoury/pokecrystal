	object_const_def
	const KARENSROOM_KAREN

KarensRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	callback MAPCALLBACK_TILES, .KarensRoomDoors

.LockDoor:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	prioritysjump .KarensDoorLocksBehindYou
.end
	end

.EnterCallback:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .NoCovid

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the battle.

.NoCovid
	endcallback

.KarensRoomDoors:
	checkevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 14, $2a ; wall
.KeepEntranceOpen:
	checkevent EVENT_KARENS_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 2, $16 ; open door
.KeepExitClosed:
	endcallback

.KarensDoorLocksBehindYou:
	applymovement PLAYER, KarensRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a ; wall
	reloadmappart
	closetext
	setevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

KarenScript_Battle:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_4_KAREN
	iftrue KarenScript_AfterBattle
	writetext KarenScript_KarenBeforeText
	waitbutton
	closetext
	winlosstext KarenScript_KarenBeatenText, 0
	loadtrainer KAREN, KAREN1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ELITE_4_KAREN
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .NoNotification

	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	opentext
	writetext KarenScript_KarenDefeatText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16 ; open door
	reloadmappart
	closetext
	setevent EVENT_KARENS_ROOM_EXIT_OPEN
	waitsfx
	end

KarenScript_AfterBattle:
	writetext KarenScript_KarenDefeatText
	waitbutton
	closetext
	end

KarensRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

KarenScript_KarenBeforeText:
if DEF(_FR_FR)
	text "Mon nom est"
	line "MARION."

	para "À cause du COVID,"
	line "ma grand-mère ne"
	cont "fait désormais"
	cont "plus qu'un avec ses"
	cont "#MON SPECTRE."

	para "J'ai été choisie"
	line "pour perpétuer sa"
	cont "mémoire et son"
	cont "devoir au sein du"
	cont "CONSEIL des 4."

	para "Tu crois connaître"
	line "la souffrance?"

	para "Mes #MON et moi"
	line "allons te montrer"
	cont "les ténèbres du"
	cont "désespoir."
else
	text "My name is KAREN."

	para "Because of COVID,"
	line "my grandmother is"
	cont "now one with her"
	cont "GHOST #MON."

	para "I've been chosen to"
	line "carry on her duty"
	cont "and her memory as"
	cont "a member of the"
	cont "ELITE FOUR."

	para "You think you know"
	line "suffering?"

	para "My #MON and I"
	line "will show you the"
	cont "darkness of"
	cont "despair."
endc
	done

KarenScript_KarenBeatenText:
if DEF(_FR_FR)
	text "Tu as un mental"
	line "solide. J'aime ça"
	cont "chez un dresseur."
else
	text "You have a solid"
	line "mind. I like that"
	cont "in a trainer."
endc
	done

KarenScript_KarenDefeatText:
if DEF(_FR_FR)
	text "Tu as bon coeur,"
	line "et tu n'as pas peur"
	cont "d'affronter le"
	cont "danger."

	para "J'aime ton style."
	line "Tu as compris ce"
	cont "qui compte vrai-"
	cont "ment."

	para "Allez, va..."
	line "Le MAITRE attend."
else
	text "You have a good"
	line "heart, and you"

	para "aren't afraid to"
	line "face reality."

	para "I like your style."
	line "You understand"
	cont "what's important."

	para "Go on--the CHAM-"
	line "PION is waiting."
endc
	done

KarensRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, BRUNOS_ROOM, 3
	warp_event  5, 17, BRUNOS_ROOM, 4
	warp_event  4,  2, LANCES_ROOM, 1
	warp_event  5,  2, LANCES_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_KAREN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, KarenScript_Battle, -1
