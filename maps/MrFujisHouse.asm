	object_const_def
	const MRFUJISHOUSE_SUPER_NERD
	const MRFUJISHOUSE_LASS
	const MRFUJISHOUSE_PSYDUCK
	const MRFUJISHOUSE_NIDORINO
	const MRFUJISHOUSE_PIDGEY
	const MRFUJISHOUSE_JASMINE
	const MRFUJISHOUSE_JASMINES_FRIEND

MrFujisHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MrFujisHouseSuperNerdScript:
	jumptextfaceplayer MrFujisHouseSuperNerdText

MrFujisHouseLassScript:
	jumptextfaceplayer MrFujisHouseLassText

MrFujisPsyduck:
	opentext
	writetext MrFujisPsyduckText
	cry PSYDUCK
	waitbutton
	closetext
	end

MrFujisNidorino:
	opentext
	writetext MrFujisNidorinoText
	cry NIDORINO
	waitbutton
	closetext
	end

MrFujisPidgey:
	opentext
	writetext MrFujisPidgeyText
	cry PIDGEY
	waitbutton
	closetext
	end

MrFujisJasmineScript:
	readvar VAR_FACING
	ifequal DOWN, .FaceDown
	ifequal LEFT, .FaceLeft
	ifequal RIGHT, .FaceRight

;.FaceUp
	applymovement MRFUJISHOUSE_JASMINE, MrFujisHouseFaceUpMovement
	loadmem wMap6ObjectMovement, SPRITEMOVEDATA_STANDING_UP
	;pause 30
	end

.FaceDown
	applymovement MRFUJISHOUSE_JASMINE, MrFujisHouseFaceDownMovement
	loadmem wMap6ObjectMovement, SPRITEMOVEDATA_STANDING_DOWN
	;pause 30
	end

.FaceLeft
	applymovement MRFUJISHOUSE_JASMINE, MrFujisHouseFaceLeftMovement
	loadmem wMap6ObjectMovement, SPRITEMOVEDATA_STANDING_LEFT
	;pause 30
	end

.FaceRight
	applymovement MRFUJISHOUSE_JASMINE, MrFujisHouseFaceRightMovement
	loadmem wMap6ObjectMovement, SPRITEMOVEDATA_STANDING_RIGHT
	;pause 30
	end

MrFujisJasminesFriendScript:
	opentext
	writetext MrFujisJasminesFriendFirstText
	waitbutton
	closetext
	pause 3
	faceplayer
	pause 3
	opentext
	writetext MrFujisJasminesFriendSecondText
	waitbutton
	closetext

	setevent EVENT_AMPHY_BURIAL_CEREMONY_JUST_FINISHED
	setevent EVENT_LORELEI_AT_SOUL_HOUSE
	setevent EVENT_SURGE_AT_SOUL_HOUSE
	applymovement MRFUJISHOUSE_JASMINES_FRIEND, MrFujisHouseFaceLeftMovement
	end

MrFujisHouseBookshelf:
	jumpstd DifficultBookshelfScript

MrFujisHouseFaceDownMovement:
	turn_step DOWN
	step_bump
	step_end

MrFujisHouseFaceUpMovement:
	turn_step UP
	step_bump
	step_end

MrFujisHouseFaceLeftMovement:
	turn_step LEFT
	step_bump
	step_end

MrFujisHouseFaceRightMovement:
	turn_step RIGHT
	step_bump
	step_end

MrFujisHouseSuperNerdText:
	text "MR.FUJI does live"
	line "here, but he's not"

	para "home now."

	para "He should be at"
	line "the SOUL HOUSE."
	done

MrFujisHouseLassText:
	text "Some cold-hearted"
	line "people stop caring"
	cont "for their #MON."

	para "Grandpa takes in"
	line "the poor homeless"

	para "#MON and takes"
	line "care of them."
	done

MrFujisPsyduckText:
	text "PSYDUCK: Gu-guwa?"
	done

MrFujisNidorinoText:
	text "NIDORINO: Gyun!"
	done

MrFujisPidgeyText:
	text "PIDGEY: Pijji!"
	done

MrFujisJasminesFriendFirstText:
	text "Poor JASMINE…"
	done

MrFujisJasminesFriendSecondText:
	text "Thanks for coming"
	line "& showing support,"
	cont "it's heartwarming."

	para "Listen…"

	para "We are supposed to"
	line "be on our way back"
	cont "to JOHTO, but we"
	
	para "are stuck here"
	line "because of the"
	cont "shutdown of the"
	cont "POWER PLANT."
	
	para "JASMINE is in no"
	line "condition to help."
	
	para "As the LEAGUE"
	line "CHAMPION, you"
	cont "should go check"
	
	para "if you could give"
	line "them a hand."
	cont "Please."
	done

MrFujisHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 2
	warp_event  3,  7, LAVENDER_TOWN, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MrFujisHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, MrFujisHouseBookshelf

	def_object_events
	object_event  4,  1, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MrFujisHouseSuperNerdScript, -1
	object_event  7,  5, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MrFujisHouseLassScript, -1
	object_event  7,  3, SPRITE_PSYDUCK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, MrFujisPsyduck, -1
	object_event  5,  5, SPRITE_NIDORINO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, MrFujisNidorino, -1
	object_event  1,  4, SPRITE_PIDGEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MrFujisPidgey, -1
	object_event  2,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MrFujisJasmineScript, EVENT_JASMINE_AT_FUJIS
	object_event  3,  3, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MrFujisJasminesFriendScript, EVENT_JASMINE_AT_FUJIS
