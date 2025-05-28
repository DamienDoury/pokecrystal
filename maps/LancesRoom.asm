	object_const_def
	const LANCESROOM_LANCE
	const LANCESROOM_MARY
	const LANCESROOM_OAK

LancesRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_TILES, .LancesRoomDoors

.LockDoor:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	prioritysjump .LancesDoorLocksBehindYou
.end
	end

.LancesRoomDoors:
	checkevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 22, $34 ; wall
.KeepEntranceOpen:
	checkevent EVENT_LANCES_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 0, $0b ; open door
.KeepExitClosed:
	endcallback

.LancesDoorLocksBehindYou:
	applymovement PLAYER, LancesRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 22, $34 ; wall
	reloadmappart
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	end

Script_ApproachLanceFromRight:
	applymovement PLAYER, MovementData_ApproachLanceFromRight

Script_ApproachLanceFromLeft:
	special FadeOutMusic
	applymovement PLAYER, MovementData_PlayerPreparesForBattle
LancesRoomLanceScript:
	turnobject LANCESROOM_LANCE, LEFT
	opentext
	writetext LanceBattleIntroText
	waitbutton
	closetext
	applymovement LANCESROOM_LANCE, MovementData_LanceStepsBack
	opentext
	writetext LanceBattleIntroEndText
	waitbutton
	closetext
	winlosstext LanceBattleWinText, 0
	setlasttalked LANCESROOM_LANCE
	loadtrainer CHAMPION, LANCE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	setevent EVENT_BEAT_CHAMPION_LANCE
	opentext
	writetext LanceBattleAfterText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 0, $0b ; open door
	reloadmappart
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	musicfadeout MUSIC_BEAUTY_ENCOUNTER, 16
	pause 30
	showemote EMOTE_SHOCK, LANCESROOM_LANCE, 15
	turnobject LANCESROOM_LANCE, DOWN
	pause 10
	turnobject PLAYER, DOWN
	appear LANCESROOM_MARY
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRushesIn
	pause 10
	opentext
	writetext LancesRoomMaryOhNoOakText
	waitbutton
	closetext
	appear LANCESROOM_OAK
	applymovement LANCESROOM_OAK, LancesRoomMovementData_OakWalksInStart
	follow LANCESROOM_MARY, LANCESROOM_OAK
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryYieldsToOak
	stopfollow
	applymovement LANCESROOM_OAK, LancesRoomMovementData_OakWalksInEnd
	turnobject LANCESROOM_LANCE, LEFT
	opentext
	writetext LancesRoomOakCongratulationsText
	waitbutton
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryInterviewChampion
	turnobject PLAYER, RIGHT
	opentext
	writetext LancesRoomMaryInterviewText
	waitbutton
	closetext
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway
	turnobject PLAYER, UP
	opentext
	writetext LancesRoomNoisyText
	waitbutton
	closetext
	;follow LANCESROOM_LANCE, PLAYER
	turnobject LANCESROOM_MARY, UP
	turnobject LANCESROOM_OAK, UP
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LanceLeadsPlayerToHallOfFame
	pause 15
	;stopfollow
	playsound SFX_EXIT_BUILDING
	disappear LANCESROOM_LANCE
	applymovement PLAYER, LancesRoomMovementData_PlayerExits
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryTriesToFollow
	showemote EMOTE_SHOCK, LANCESROOM_MARY, 15
	opentext
	writetext LancesRoomMaryNoInterviewText
	pause 30
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRunsBackAndForth
	special FadeOutPalettes
	pause 15
	warpfacing UP, HALL_OF_FAME, 5, 15
	end

LancesRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

MovementData_ApproachLanceFromRight:
	step LEFT
	step_end

MovementData_LanceStepsBack:
	turn_head LEFT
	fix_facing
	step RIGHT
	turn_head LEFT
	remove_fixed_facing
	step_end

MovementData_PlayerPreparesForBattle:
	step UP
	step LEFT
	step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryRushesIn:
	big_step UP
	big_step UP
	big_step UP
	turn_head DOWN
	step_end

LancesRoomMovementData_OakWalksInStart:
	step UP
	step UP
	step_end

LancesRoomMovementData_OakWalksInEnd:
	step UP
	step_end

LancesRoomMovementData_MaryYieldsToOak:
	step RIGHT
	turn_head LEFT
	step_end

LancesRoomMovementData_MaryInterviewChampion:
	big_step UP
	big_step UP
	turn_head LEFT
	step_end

LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway:
	step UP
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

LancesRoomMovementData_LanceLeadsPlayerToHallOfFame:
	turn_head UP
	step_end

LancesRoomMovementData_PlayerExits:
	step RIGHT
	step UP
	step_end

LancesRoomMovementData_MaryTriesToFollow:
	step UP
	step LEFT
	turn_head UP
	step_end

LancesRoomMovementData_MaryRunsBackAndForth:
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	turn_head UP
	step_end

LanceBattleIntroText: ; TO TRANSLATE
	text "LANCE: I've been"
	line "waiting for you."

	para "<PLAY_G>!"

	para "I knew that you,"
	line "with your skills,"

	para "would eventually"
	line "reach me here."

	para "There's no need"
	line "for words now."

	para "We will battle to"
	line "determine who is"

	para "the stronger of"
	line "the two of us."

	para "As the most power-"
	line "ful trainer and as"

	para "the #MON LEAGUE"
	line "CHAMPION…"
	done

LanceBattleIntroEndText: ; TO TRANSLATE
	text "I, LANCE the Drag-"
	line "on master, accept"
	cont "your challenge!"
	done

LanceBattleWinText: 
if DEF(_FR_FR)
	text "...C'est fini."

	para "Je me sens..."
	line "Bizarre..."

	para "Je ne suis pas"
	line "fâché mais..."
	cont "Plutôt heureux."

	para "Heureux d'être le"
	line "témoin de la nais-"

	para "sance d'un nouveau"
	line "MAITRE!"
else
	text "…It's over."

	para "But it's an odd"
	line "feeling."

	para "I'm not angry that"
	line "I lost. In fact, I"
	cont "feel happy."

	para "Happy that I"
	line "witnessed the rise"

	para "of a great new"
	line "CHAMPION!"
endc

	done

LanceBattleAfterText: 
if DEF(_FR_FR)
	text "...Fouiii!"

	para "Tu as fait de gros"
	line "progrès, <PLAY_G>."

	para "Toi et tes #MON"
	line "êtes en parfaite"

	para "harmonie."
	line "C'est bien, ça."

	para "Je suis sûr que tu"
	line "continueras à"
	cont "progresser."
else
	text "…Whew."

	para "You have become"
	line "truly powerful,"
	cont "<PLAY_G>."

	para "Your #MON have"
	line "responded to your"

	para "strong and up-"
	line "standing nature."

	para "As a trainer, you"
	line "will continue to"

	para "grow strong with"
	line "your #MON."
endc

	done

LancesRoomMaryOhNoOakText: 
if DEF(_FR_FR)
	text "LULA: Oh, non!"
	line "C'est fini! PROF."

	para "CHEN, vous êtes"
	line "trop lent..."
else
	text "MARY: Oh, no!"
	line "It's all over!"

	para "PROF.OAK, if you"
	line "weren't so slow…"
endc

	done

LancesRoomOakCongratulationsText: 
if DEF(_FR_FR)
	text "CHEN: Ah, <PLAY_G>!"
	line "Ca faisait bien"
	cont "longtemps."

	para "Tu as changé, ma"
	line "parole."

	para "Ta victoire sur la"
	line "LIGUE est ma foi"
	cont "impressionnante!"

	para "Ton amour et ton"
	line "dévouement pour"

	para "tes #MON en"
	line "sont la cause."

	para "Tes #MON ont"
	line "aussi fait du beau"
	cont "boulot."

	para "Ils ont reconnu"
	line "en toi un être"

	para "et un dresseur"
	line "d'exception."

	para "Encore bravo,"
	line "<PLAY_G>!"
else
	text "PROF.OAK: Ah,"
	line "<PLAY_G>!"

	para "It's been a long"
	line "while."

	para "You certainly look"
	line "more impressive."

	para "Your conquest of"
	line "the LEAGUE is just"
	cont "fantastic!"

	para "Your dedication,"
	line "trust and love for"

	para "your #MON made"
	line "this happen."

	para "Your #MON were"
	line "outstanding too."

	para "Because they be-"
	line "lieved in you as a"

	para "trainer, they per-"
	line "severed."

	para "Congratulations,"
	line "<PLAY_G>!"
endc

	done

LancesRoomMaryInterviewText: 
if DEF(_FR_FR)
	text "LULA: Faisons une"
	line "interview du nou-"
	cont "veau MAITRE!"
else
	text "MARY: Let's inter-"
	line "view the brand new"
	cont "CHAMPION!"
endc

	done

LancesRoomNoisyText: 
if DEF(_FR_FR)
	text "PETER: Tout ça est"
	line "trop bruyant pour"
	cont "moi..."

	para "<PLAY_G>,"
	line "suis-moi."
else
	text "LANCE: This is"
	line "getting to be a"
	cont "bit too noisy…"

	para "<PLAY_G>, could you"
	line "come with me?"
endc

	done

LancesRoomMaryNoInterviewText: 
if DEF(_FR_FR)
	text "LULA: Attendez!"
	line "On n'a pas encore"
	cont "fait l'interview!"
else
	text "MARY: Oh, wait!"
	line "We haven't done"
	cont "the interview!"
endc

	done

LancesRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 23, KARENS_ROOM, 3
	warp_event  5, 23, KARENS_ROOM, 4

	def_coord_events
	coord_event  4,  5, CE_SCENE_ID, SCENE_ALWAYS, Script_ApproachLanceFromLeft
	coord_event  5,  5, CE_SCENE_ID, SCENE_ALWAYS, Script_ApproachLanceFromRight

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LancesRoomLanceScript, -1
	object_event  4,  8, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
	object_event  4,  8, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
