	object_const_def
	const ROUTE16FUCHSIASPEECHHOUSE_SUPER_NERD

Route16FuchsiaSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route16FuchsiaSpeechHouseSuperNerdScript:
	faceplayer
	checkitem TM_ROCK_SMASH
	iffalse .give_rock_smash
	jumptext Route16FuchsiaSpeechHouseSuperNerdText

.give_rock_smash
	opentext
	writetext Route16FuchsiaSpeechHouseSuperNerd_GiveRockSmashText
	promptbutton
	verbosegiveitem TM_ROCK_SMASH
	closetext
	end

Route16FuchsiaSpeechHouseBookshelf:
	jumpstd PictureBookshelfScript

Route16FuchsiaSpeechHouseSuperNerd_GiveRockSmashText:
if DEF(_FR_FR)
	text "L'ancienne"
	line "propriétaire de"
	cont "cette maison"
	
	para "donnait souvent"
	line "des objets utiles"
	cont "aux gens."
	
	para "Je veux faire"
	line "perdurer sa"
	cont "tradition."
else
	text "The previous owner"
	line "of this house used"
	
	para "to give out useful"
	line "items to people."
	
	para "I want to keep her"
	line "tradition alive."
endc
	done

Route16FuchsiaSpeechHouseSuperNerdText:
if DEF(_FR_FR)
	text "J'ai acheté cette"
	line "maison à une"
	cont "célébrité."
	
	para "Dès que le premier"
	line "confinement a été"
	cont "annoncé, elle est"
	
	para "partie s'isoler"
	line "dans une maison"
	
	para "au beau milieu"
	line "d'un trou paumé."
else
	text "I bought this"
	line "house from a"
	cont "top celibrity."
	
	para "As soon as the"
	line "first lockdown"
	cont "was announced,"
	
	para "she moved to an"
	line "isolated country-"
	cont "side house."
endc
	done

Route16FuchsiaSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_16, 1
	warp_event  3,  7, ROUTE_16, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, Route16FuchsiaSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, Route16FuchsiaSpeechHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route16FuchsiaSpeechHouseSuperNerdScript, -1
