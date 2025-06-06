	object_const_def
	const OLIVINELIGHTHOUSE4F_SAILOR
	const OLIVINELIGHTHOUSE4F_LASS

OlivineLighthouse4F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	
.EnterCallback:
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.EndCallback:
	endcallback

TrainerLassConnie:
	trainer LASS, CONNIE1, EVENT_BEAT_LASS_CONNIE, LassConnie1SeenText, LassConnie1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer LassConnie1AfterBattleText

TrainerSailorKent:
	trainer SAILOR, KENT, EVENT_BEAT_SAILOR_KENT, SailorKentSeenText, SailorKentBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorKentAfterBattleText

SailorKentSeenText: 
if DEF(_FR_FR)
	text "JASMINE doit"
	line "s'inquiéter à pro-"
	cont "pos du #MON."

	para "Elle ne sourit"
	line "même plus."
else
	text "JASMINE must be"
	line "worried sick about"
	cont "the #MON here."

	para "She won't even"
	line "smile these days."
endc

	done

SailorKentBeatenText: 
if DEF(_FR_FR)
	text "Moi non plus..."
	line "J'souris plus..."
else
	text "I can't manage a"
	line "smile either…"
endc

	done

SailorKentAfterBattleText: 
if DEF(_FR_FR)
	text "Au fait, je crois"
	line "qu'il y a une bon-"

	para "ne PHARMACIE à"
	line "IRISIA."
else
	text "Speaking of sick,"
	line "I've heard there's"

	para "a good PHARMACY in"
	line "CIANWOOD."
endc

	done

LassConnie1SeenText: 
if DEF(_FR_FR)
	text "JASMINE est la"
	line "CHAMPIONNE de"
	cont "cette ville."

	para "Et moi j'suis plus"
	line "forte qu'elle."

	para "Et ça... Tu vas"
	line "le comprendre!"
else
	text "JASMINE is this"
	line "city's GYM LEADER."

	para "I mean to bring"
	line "her back with me."

	para "Nobody had better"
	line "get in my way!"
endc

	done

LassConnie1BeatenText: 
if DEF(_FR_FR)
	text "Aaah! Mes #MON!"
else
	text "Aaack! My #MON!"
endc

	done

LassConnie1AfterBattleText: ; TO TRANSLATE
	text "Did you know that"
	line "the number of"
	cont "abandonned #MON"
	cont "has risen since"
	cont "the start of the"
	cont "pandemic?"

	para "It's a NURSE that"
	line "works at a #MON"
	cont "CENTER that"
	cont "told me."

	para "She takes most"
	line "of them in."
	done

OlivineLighthouse4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13,  3, OLIVINE_LIGHTHOUSE_3F, 1
	warp_event  3,  5, OLIVINE_LIGHTHOUSE_5F, 2
	warp_event  9,  7, OLIVINE_LIGHTHOUSE_5F, 3
	warp_event  9,  5, OLIVINE_LIGHTHOUSE_3F, 3
	warp_event 16,  9, OLIVINE_LIGHTHOUSE_3F, 6
	warp_event 17,  9, OLIVINE_LIGHTHOUSE_3F, 7
	warp_event  8,  3, OLIVINE_LIGHTHOUSE_3F, 8
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_3F, 9
	warp_event 16,  7, OLIVINE_LIGHTHOUSE_5F, 4
	warp_event 17,  7, OLIVINE_LIGHTHOUSE_5F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7, 14, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSailorKent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 11,  2, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerLassConnie, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
