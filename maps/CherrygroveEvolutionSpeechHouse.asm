	object_const_def
	const CHERRYGROVEEVOLUTIONSPEECHHOUSE_LASS
	const CHERRYGROVEEVOLUTIONSPEECHHOUSE_YOUNGSTER

CherrygroveEvolutionSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject CHERRYGROVEEVOLUTIONSPEECHHOUSE_LASS, 6, 1
	moveobject CHERRYGROVEEVOLUTIONSPEECHHOUSE_YOUNGSTER, 5, 1
	;loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	;loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

CherrygroveEvolutionSpeechHouseYoungsterScript:
	jumptextfaceplayer CherrygroveEvolutionSpeechHouseYoungsterText

CherrygroveEvolutionSpeechHouseLassScript:
	jumptextfaceplayer CherrygroveEvolutionSpeechHouseLassText

CherrygroveEvolutionSpeechHouseBookshelf:
	jumpstd MagazineBookshelfScript

CherrygroveEvolutionSpeechHouseYoungsterText: 
if DEF(_FR_FR)
	text "Les #MON"
	line "gagnent de l'expé-"

	para "rience et évoluent"
	line "en combattant."
else
	text "#MON gain expe-"
	line "rience in battle"

	para "and change their"
	line "form."
endc

	done

CherrygroveEvolutionSpeechHouseLassText: 
if DEF(_FR_FR)
	text "Les #MON"
	line "évoluent?"

	para "Je serais curieuse"
	line "de voir ça!"
else
	text "#MON change?"

	para "I would be shocked"
	line "if one did that!"
endc

	done

CherrygroveEvolutionSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 5
	warp_event  3,  7, CHERRYGROVE_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CherrygroveEvolutionSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CherrygroveEvolutionSpeechHouseBookshelf

	def_object_events
	object_event  3,  5, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CherrygroveEvolutionSpeechHouseLassScript, -1
	object_event  2,  5, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveEvolutionSpeechHouseYoungsterScript, -1
