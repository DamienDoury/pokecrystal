	object_const_def
	const PEWTERNIDORANSPEECHHOUSE_SUPER_NERD
	const PEWTERNIDORANSPEECHHOUSE_NIDORAN_M

PewterNidoranSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

PewterNidoranSpeechHouseSuperNerdScript:
	jumptextfaceplayer PewterNidoranSpeechHouseSuperNerdText

PewterNidoran:
	opentext
	writetext PewterNidoranText
	cry NIDORAN_M
	waitbutton
	closetext
	end

PewterNidoranSpeechHouseSuperNerdText: 
if DEF(_FR_FR)
	text "NIDORAN, couché!"
else
	text "NIDORAN, shake!"
endc

	done

PewterNidoranText: 
if DEF(_FR_FR)
	text "NIDORAN: Nidôô!"
else
	text "NIDORAN: Gau gau!"
endc

	done

PewterNidoranSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, PEWTER_CITY, 1
	warp_event  3,  7, PEWTER_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PewterNidoranSpeechHouseSuperNerdScript, -1
	object_event  4,  5, SPRITE_NIDORAN_M, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, PewterNidoran, -1
