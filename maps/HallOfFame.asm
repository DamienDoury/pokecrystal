	object_const_def
	const HALLOFFAME_LANCE

HallOfFame_MapScripts:
	def_scene_scripts
	scene_script .EnterHallOfFame ; SCENE_ALWAYS

	def_callbacks

.EnterHallOfFame:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	prioritysjump .EnterHallOfFameScript
.end
	end

.EnterHallOfFameScript:
	;follow HALLOFFAME_LANCE, PLAYER
	applymovement PLAYER, HallOfFame_WalkUp
	;stopfollow
	turnobject PLAYER, RIGHT
	turnobject HALLOFFAME_LANCE, LEFT
	opentext
	writetext HallOfFame_LanceText
	waitbutton
	closetext
	turnobject HALLOFFAME_LANCE, UP
	applymovement PLAYER, HallOfFame_SlowlyApproachMachine
	pause 15
	setval HEALMACHINE_HALL_OF_FAME
	special HealMachineAnim
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_TELEPORT_GUY
	setevent EVENT_RIVAL_SPROUT_TOWER
	setevent EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	clearevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	special HealParty
	checkevent EVENT_ELM_ENCOURAGED_TO_GET_VACCINATED
	iftrue .SkipPhoneCall
	readmem wHallOfFameCount
	ifgreater 0, .SkipPhoneCall
	setflag ENGINE_DISPLAY_YEAR_AT_START
	specialphonecall SPECIALCALL_SSTICKET
.SkipPhoneCall:
	halloffame
	end

HallOfFame_WalkUp:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

HallOfFame_SlowlyApproachMachine:
	slow_step UP
	slow_step UP
	slow_step UP
	step_end

HallOfFame_LanceText:
	text "LANCE: It's been a"
	line "long time since I"
	cont "last came here."

	para "This is where we"
	line "honor the LEAGUE"

	para "CHAMPIONS for all"
	line "eternity."

	para "Their courageous"
	line "#MON are also"
	cont "inducted."

	para "Here today, we"
	line "witnessed the rise"

	para "of a new LEAGUE"
	line "CHAMPION--a"

	para "trainer who feels"
	line "compassion for,"

	para "and trust toward,"
	line "all #MON."

	para "A trainer who"
	line "succeeded through"

	para "perseverance and"
	line "determination."

	para "The new LEAGUE"
	line "CHAMPION who has"

	para "all the makings"
	line "of greatness!"

	para "<PLAY_G>, allow me"
	line "to register you"

	para "and your partners"
	line "as CHAMPIONS!"
	done

HallOfFame_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 15, LANCES_ROOM, 3
	warp_event  6, 15, LANCES_ROOM, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  8, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
