	object_const_def
	const ECRUTEAKLUGIASPEECHHOUSE_GRAMPS
	const ECRUTEAKLUGIASPEECHHOUSE_YOUNGSTER

EcruteakLugiaSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject ECRUTEAKLUGIASPEECHHOUSE_GRAMPS, 7, 3
	moveobject ECRUTEAKLUGIASPEECHHOUSE_YOUNGSTER, 7, 5
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT
.end
	endcallback

EcruteakLugiaSpeechHouseGrampsScript:
	jumptextfaceplayer EcruteakLugiaSpeechHouseGrampsText

EcruteakLugiaSpeechHouseYoungsterScript:
	jumptextfaceplayer EcruteakLugiaSpeechHouseYoungsterText

LugiaSpeechHouseRadio:
	jumpstd Radio2Script

EcruteakLugiaSpeechHouseGrampsText: 
if DEF(_FR_FR)
	text "Ca s'est passé"
	line "lorsque j'étais"
	cont "jeune."

	para "Le ciel est"
	line "soudainement deve-"

	para "nu noir. Un #-"
	line "MON gigantesque"
	cont "cachait les rayons"
	cont "du soleil."

	para "Je me demande quel"
	line "#MON c'était..."

	para "C'était comme un"
	line "oiseau ou un"
	cont "dragon."
else
	text "This happened when"
	line "I was young."

	para "The sky suddenly"
	line "turned black. A"

	para "giant flying #-"
	line "MON was blocking"
	cont "out the sun."

	para "I wonder what that"
	line "#MON was? "

	para "It was like a bird"
	line "and a dragon."
endc

	done

EcruteakLugiaSpeechHouseYoungsterText: 
if DEF(_FR_FR)
	text "Existe-t-il un"
	line "#MON aussi"

	para "grand? Si c'est le"
	line "cas, il doit être"
	cont "puissant."
else
	text "Is there really a"
	line "#MON that big?"

	para "If it exists, it"
	line "must be powerful."
endc

	done

EcruteakLugiaSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 7
	warp_event  4,  7, ECRUTEAK_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, LugiaSpeechHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakLugiaSpeechHouseGrampsScript, -1
	object_event  5,  4, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakLugiaSpeechHouseYoungsterScript, -1
