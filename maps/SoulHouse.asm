	object_const_def
	const SOULHOUSE_MRFUJI
	const SOULHOUSE_TEACHER
	const SOULHOUSE_LASS
	const SOULHOUSE_GRANNY
	const SOULHOUSE_JASMINE
	const SOULHOUSE_LORELEI
	const SOULHOUSE_SURGE

SoulHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	checkevent EVENT_AMPHY_BURIAL_CEREMONY_JUST_FINISHED
	iffalse .HideRegularNPCs
	
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

.HideRegularNPCs
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

MrFuji:
	checkevent EVENT_JASMINE_AT_SOUL_HOUSE
	iffalse .regularDialog

	checkevent EVENT_AMPHY_BURIAL_CEREMONY_JUST_FINISHED
	iftrue .regularDialog
	
	faceplayer
	opentext
	sjump SoulHouseFujiAmphyScript

.regularDialog
	jumptextfaceplayer MrFujiText

SoulHouseTeacherScript:
	jumptextfaceplayer SoulHouseTeacherText

SoulHouseLassScript:
	jumptextfaceplayer SoulHouseLassText

SoulHouseGrannyScript:
	jumptextfaceplayer SoulHouseGrannyText

SoulHouseAmphysGraveScript:
	jumptext AmphyText

MoomoosGraveScript:
	jumptext MoomooText

SoulHouseJasmineScript:
	opentext
	writetext SoulHouseJasmineSobsText
	waitbutton
	closetext

	pause 70
	applymovement SOULHOUSE_JASMINE, SoulHouseJasmineRunsLeftMovement
	follow PLAYER, SOULHOUSE_JASMINE
	applymovement PLAYER, SoulHousePlayerPushedMovement
	stopfollow
	applymovement SOULHOUSE_JASMINE, SoulHouseJasmineRunsDownMovement
	playsound SFX_EXIT_BUILDING
	disappear SOULHOUSE_JASMINE
	clearevent EVENT_JASMINE_AT_FUJIS
	waitsfx
	pause 30
	applymovement SOULHOUSE_MRFUJI, SoulHouseSlowStepDownMovement
	applymovement PLAYER, SoulHouseHeadUpMovement

	opentext
	writetext SoulHouseFujiAmphyText
	promptbutton

SoulHouseFujiAmphyScript:
	writetext SoulHouseFujiAmphy2Text
	waitbutton
	closetext
	end

SoulHouseLoreleiScript:
	faceplayer
	opentext
	writetext SoulHouseLoreleiText
	waitbutton
	closetext
	pause 5
	applymovement SOULHOUSE_LORELEI, SoulHouseHeadUpMovement
	pause 45
	applymovement SOULHOUSE_LORELEI, SoulHouseLoreleiMovement
	pause 3
	playsound SFX_EXIT_BUILDING
	disappear SOULHOUSE_LORELEI
	waitsfx
	end

SoulHouseSurgeScript:
	faceplayer
	opentext
	writetext SoulHouseSurgeText
	waitbutton
	closetext
	pause 15
	applymovement SOULHOUSE_SURGE, SoulHouseSurgeMovement
	playsound SFX_EXIT_BUILDING
	disappear SOULHOUSE_SURGE
	waitsfx
	end

AntonFamilyGraveScript:
	opentext
	writetext SoulHouseAntonsWifeOnlyText
	
	checkevent EVENT_SICK_GENTLEMAN_DIED
	iffalse .end
	
	promptbutton
	pause 15
	writetext SoulHouseFullAntonFamilyText
	
.end
	waitbutton
	closetext
	end

AgathasGraveScript:
	jumptext AgathasGraveText

RedsGraveScript:
	jumptext RedsGraveText

SoulHouseJasmineRunsLeftMovement:
	big_step LEFT
	step_end

SoulHousePlayerPushedMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	turn_head DOWN
	step_end

SoulHouseJasmineRunsDownMovement:
	big_step DOWN
	big_step DOWN
	step_end

SoulHouseSlowStepDownMovement:
	slow_step DOWN
	step_end

SoulHouseHeadUpMovement:
	turn_head UP
	step_end

SoulHouseLoreleiMovement:
	slow_step LEFT
	turn_head DOWN
	step_end

SoulHouseSurgeMovement:
	slow_step RIGHT
	slow_step DOWN
	slow_step DOWN
	step_end

MrFujiText: ; AUTOTRAD
	text "MR.FUJI: Welcome."

	para "Hmm… You appear to"
	line "be raising your"

	para "#MON in a kind"
	line "and loving manner."

	para "#MON lovers"
	line "come here to pay"

	para "their respects to"
	line "departed #MON."

	para "Please offer con-"
	line "dolences for the"

	para "souls of the de-"
	line "parted #MON."

	para "I'm sure that will"
	line "make them happy."
	done

SoulHouseTeacherText: ; AUTOTRAD
	text "There are other"
	line "graves of #MON"
	cont "here, I think."

	para "There are many"
	line "chambers that only"
	cont "MR.FUJI may enter."
	done

SoulHouseLassText: ; AUTOTRAD
	text "I came with my mom"
	line "to visit #MON"
	cont "graves…"
	done

SoulHouseGrannyText: ; AUTOTRAD
	text "The #MON that"
	line "lived with me…"

	para "I loved them like"
	line "my grandchildren…"
	done

AmphyText: ; TO TRANSLATE
	text "“Forgive me”"

	para "AMPHY"
	done

MoomooText: ; TO TRANSLATE
	text "Here lies the"
	line "beloved"
	cont "MOOMOO."
	done

SoulHouseJasmineSobsText: ; TO TRANSLATE
	text "JASMINE: (sob)"
	done

SoulHouseFujiAmphyText: ; TO TRANSLATE
	text "MR.FUJI: She needs"
	line "time to mourn."

	para "…"

	para "I'm MR.FUJI."
	
	para "I run this place,"
	line "as well as the"
	cont "VOLUNTEER HOUSE"
	cont "next door."
	done

SoulHouseFujiAmphy2Text: ; TO TRANSLATE
	text "JASMINE resides"
	line "at my place for"
	cont "the time being."

	para "She always sup-"
	line "ports others, but"
	cont "at this time she's"
	cont "the one that needs"
	cont "support."
	done

SoulHouseLoreleiText: ; TO TRANSLATE
	text "LORELEI: I've been"
	line "coming to this"
	cont "place too often"
	cont "recently."
	
	para "Too many friends"
	line "gone too soon…"
	done

SoulHouseSurgeText: ; TO TRANSLATE
	text "SURGE: Back when"
	line "I was a brat,"
	
	para "I looked up to"
	line "this #MON."

	para "He got me into"
	line "ELECTRIC types."
	
	para "Anyway, I gotta"
	line "go back helping at"
	cont "the POWER PLANT."
	done

SoulHouseFullAntonFamilyText: ; TO TRANSLATE
	text "“Founder of the"
	line "RARE CANDY"
	cont "factory”"

	para "MR.ANTON"
	done

SoulHouseAntonsWifeOnlyText: ; TO TRANSLATE
	text "“You will be"
	line "remembered”"

	para "MRS.ANTON"
	done

AgathasGraveText: ; TO TRANSLATE
	text "“She is one with"
	line "her GHOST #MON”"

	para "ELITE 4 AGATHA"
	done

RedsGraveText: ; TO TRANSLATE
	text "“...”"

	para "CHAMPION RED"
	done

SoulHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  7, LAVENDER_TOWN, 6
	warp_event  5,  7, LAVENDER_TOWN, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MrFuji, -1
	object_event  8,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SoulHouseTeacherScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  2,  5, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SoulHouseLassScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  1,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SoulHouseGrannyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  5, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SoulHouseJasmineScript, EVENT_JASMINE_AT_SOUL_HOUSE
	object_event  6,  7, SPRITE_LORELEI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SoulHouseLoreleiScript, EVENT_LORELEI_AT_SOUL_HOUSE
	object_event  3,  5, SPRITE_SURGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SoulHouseSurgeScript, EVENT_SURGE_AT_SOUL_HOUSE
	object_event  7,  4, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SoulHouseAmphysGraveScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  2,  6, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MoomoosGraveScript, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	object_event  7,  2, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AgathasGraveScript, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event  9,  6, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AntonFamilyGraveScript, -1
	object_event  3,  4, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RedsGraveScript, EVENT_RED_BEATEN
