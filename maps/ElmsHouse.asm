	object_const_def
	const ELMSHOUSE_ELMS_WIFE
	const ELMSHOUSE_ELMS_SON

ElmsHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject ELMSHOUSE_ELMS_WIFE, 1, 1
	moveobject ELMSHOUSE_ELMS_SON, 2, 1
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

ElmsWife:
	jumptextfaceplayer ElmsWifeText

ElmsSon:
	jumptextfaceplayer ElmsSonText

ElmsHousePC:
	jumptext ElmsHousePCText

ElmsHouseBookshelf:
	jumpstd DifficultBookshelfScript

ElmsWifeText:
if DEF(_FR_FR)
	text "Salut <PLAY_G>!"
	line "Mon mari est tou-"

	para "jours occupé..."
	line "J'espère qu'il va"
	cont "bien."

	para "Quand il est pris"
	line "dans ses recher-"
	cont "ches sur le virus,"

	para "il oublie même"
	line "de manger."
else
	text "Hi, <PLAY_G>! My"
	line "husband's always"

	para "so busy--I hope"
	line "he's OK."

	para "When he's caught"
	line "up in his virus"

	para "research, he even"
	line "forgets to eat."
endc
	done

ElmsSonText:
if DEF(_FR_FR)
	text "Quand je serai"
	line "grand, j'aiderai"
	cont "mon papa!"

	para "Je serai un sacré"
	line "professeur!"
else
	text "When I grow up,"
	line "I'm going to help"
	cont "my dad!"

	para "I'm going to be a"
	line "great professor!"
endc
	done

ElmsHousePCText:
if DEF(_FR_FR)
	text "“...D'où"
	line "vient-il?"

	para "Pourquoi a-t-il"
	line "des effets néga-"
	cont "tifs?"

	para "Comment infecte-"
	line "t-il les humains?"

	para "Nous devons le"
	line "découvrir. Je vais"
	cont "consacrer ma vie"

	para "à l'étude de la"
	line "VIROLOGIE des"
	cont "#MON!”"

	para "..."

	para "Cela fait partie"
	line "des notes de"
	cont "recherche du"
	cont "PROF.ORME."
else
	text "“…Where"
	line "does it come from?"

	para "Why does it have"
	line "negative effects?"

	para "How does it"
	line "infect humans?"

	para "We need to know. I"
	line "will dedicate my"

	para "life to the study"
	line "of #MON"
	cont "VIROLOGY!”"

	para "…"

	para "It's a part of"
	line "PROF.ELM's re-"
	cont "search papers."
endc
	done

ElmsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, NEW_BARK_TOWN, 4
	warp_event  3,  7, NEW_BARK_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, ElmsHousePC
	bg_event  6,  1, BGEVENT_READ, ElmsHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, ElmsHouseBookshelf

	def_object_events
	object_event  1,  5, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ElmsWife, -1
	object_event  5,  4, SPRITE_BUG_CATCHER, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsSon, -1
