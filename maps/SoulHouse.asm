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

MrFujiText: 
if DEF(_FR_FR)
	text "M.FUJI:"
	line "Bienvenue à toi."

	para "Hmm... Tu as l'air"
	line "d'être un dresseur"

	para "de #MON doux"
	line "et attentionné."

	para "Ceux qui aiment"
	line "les #MON vien-"

	para "nent ici saluer"
	line "leur âme."

	para "Tu peux présenter"
	line "ici tes condoléan-"
	cont "ces."

	para "Cela leur fera"
	line "plaisir."
else
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
endc

	done

SoulHouseTeacherText: 
if DEF(_FR_FR)
	text "Il y a d'autres"
	line "tombes de #MON"
	cont "ici, je crois."

	para "Beaucoup de pièces"
	line "ne sont réservées"
	cont "qu'à M.FUJI."
else
	text "There are other"
	line "graves of #MON"
	cont "here, I think."

	para "There are many"
	line "chambers that only"
	cont "MR.FUJI may enter."
endc

	done

SoulHouseLassText: 
if DEF(_FR_FR)
	text "J'suis venue avec"
	line "ma môman pour voir"
	cont "les tombes de"
	cont "#MON..."
else
	text "I came with my mom"
	line "to visit #MON"
	cont "graves…"
endc

	done

SoulHouseGrannyText: 
if DEF(_FR_FR)
	text "Les #MON que"
	line "j'ai perdus..."

	para "Je les aimais com-"
	line "me mes petits-"
	cont "enfants..."
else
	text "The #MON that"
	line "lived with me…"

	para "I loved them like"
	line "my grandchildren…"
endc

	done

AmphyText:
if DEF(_FR_FR)
	text "“Pardonne-moi”"

	para "PHARY"
else
	text "“Forgive me”"

	para "AMPHY"
endc
	done

MoomooText:
if DEF(_FR_FR)
	text "Ici repose la"
	line "bien-aimée MEUMEU."
else
	text "Here lies the"
	line "beloved"
	cont "MOOMOO."
endc
	done

SoulHouseJasmineSobsText:
if DEF(_FR_FR)
	text "JASMINE: (snif)"
else
	text "JASMINE: (sob)"
endc
	done

SoulHouseFujiAmphyText:
if DEF(_FR_FR)
	text "M.FUJI: Elle a"
	line "besoin de temps"
	cont "pour faire son"
	cont "deuil."
	
	para "..."
	
	para "Je suis M.FUJI."
	
	para "Je gère cet en-"
	line "droit, ainsi que"
	cont "le BENEVOLAT de"
	cont "LAVANVILLE à côté."
else
	text "MR.FUJI: She needs"
	line "time to mourn."

	para "…"

	para "I'm MR.FUJI."
	
	para "I run this place,"
	line "as well as the"
	cont "VOLUNTEER HOUSE"
	cont "next door."
endc
	done

SoulHouseFujiAmphy2Text:
if DEF(_FR_FR)
	text "JASMINE loge chez"
	line "moi pour le"
	cont "moment."
	
	para "Elle soutient"
	line "toujours les"
	cont "autres, mais au-"
	cont "jourd'hui c'est"
	cont "elle qui a besoin"
	cont "de soutien."
else
	text "JASMINE resides"
	line "at my place for"
	cont "the time being."

	para "She always sup-"
	line "ports others, but"
	cont "at this time she's"
	cont "the one that needs"
	cont "support."
endc
	done

SoulHouseLoreleiText:
if DEF(_FR_FR)
	text "OLGA: Je viens ici"
	line "trop souvent ces"
	cont "derniers temps."
	
	para "Trop d'amis partis"
	line "trop tôt..."
else
	text "LORELEI: I've been"
	line "coming to this"
	cont "place too often"
	cont "recently."
	
	para "Too many friends"
	line "gone too soon…"
endc
	done

SoulHouseSurgeText:
if DEF(_FR_FR)
	text "BOB: Quand j'étais"
	line "gamin, j'admirais"
	cont "ce #MON."
	
	para "C'est lui qui m'a"
	line "donné le goût des"
	cont "types ELECTRIK."
	
	para "Bon, faut que je"
	line "retourne aider à"
	cont "la CENTRALE."
else
	text "SURGE: Back when"
	line "I was a brat,"
	
	para "I looked up to"
	line "this #MON."

	para "He got me into"
	line "ELECTRIC types."
	
	para "Anyway, I gotta"
	line "go back helping at"
	cont "the POWER PLANT."
endc
	done

SoulHouseFullAntonFamilyText:
if DEF(_FR_FR)
	text "“Fondateur de"
	line "l'usine à SUPER"
	cont "BONBON”"

	para "M.ANTON"
else
	text "“Founder of the"
	line "RARE CANDY"
	cont "factory”"

	para "MR.ANTON"
endc
	done

SoulHouseAntonsWifeOnlyText:
if DEF(_FR_FR)
	text "“Tu resteras dans"
	line "les mémoires”"

	para "MME.ANTON"
else
	text "“You will be"
	line "remembered”"

	para "MRS.ANTON"
endc
	done

AgathasGraveText:
if DEF(_FR_FR)
	text "“Elle ne fait plus"
	line "qu'un avec ses"
	cont "#MON SPECTRE”"

	para "CONSEIL 4 AGATHA"
else
	text "“She is one with"
	line "her GHOST #MON”"

	para "ELITE 4 AGATHA"
endc
	done

RedsGraveText:
if DEF(_FR_FR)
	text "“...”"

	para "MAITRE RED"
else
	text "“...”"

	para "CHAMPION RED"
endc
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
