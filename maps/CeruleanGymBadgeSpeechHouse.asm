	object_const_def
	const CERULEANGYMBADGESPEECHHOUSE_POKEFAN_M
	const CERULEANGYMBADGESPEECHHOUSE_ROCKET

CeruleanGymBadgeSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	changeblock  2,  6, $1b
	endcallback

CeruleanGymBadgeSpeechHousePokefanMScript:
	checkevent EVENT_CERULEAN_HOUSE_ROCKET
	iffalse .HoldUp

	checkevent EVENT_ROCKET_THIEF_CERULEAN_CITY_GARDEN
	iffalse .HeldUp

	checkevent EVENT_ROCKET_THIEF_ROUTE_4_SOUTH
	iffalse .HeldUp

	jumptextfaceplayer CeruleanGymBadgeSpeechHousePokefanMText
.HoldUp
	jumptextfaceplayer CeruleanGymBadgeSpeechHousePokefanMHoldUpText
.HeldUp
	jumptextfaceplayer CeruleanGymBadgeSpeechHousePokefanMHeldUpText

CeruleanGymBadgeSpeechHouseRocketFleesScript:
	faceplayer
	opentext
	writetext CeruleanGymBadgeSpeechHouseRocketText
	waitbutton
	closetext
	readvar VAR_XCOORD
	ifequal 2, .flee_movement_bis
	applymovement CERULEANGYMBADGESPEECHHOUSE_ROCKET, CeruleanGymBadgeSpeechHouseFleeMovement
	sjump .flee_movement_done
	
.flee_movement_bis
	applymovement CERULEANGYMBADGESPEECHHOUSE_ROCKET, CeruleanGymBadgeSpeechHouseFleeBisMovement
.flee_movement_done
	warpsound
	disappear CERULEANGYMBADGESPEECHHOUSE_ROCKET
	clearevent EVENT_ROCKET_THIEF_CERULEAN_CITY_GARDEN
	end

CeruleanGymBadgeSpeechHouseFleeMovement:
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	step_end

CeruleanGymBadgeSpeechHouseFleeBisMovement:
	big_step UP
	big_step UP
	big_step LEFT
	big_step UP
	step_end

CeruleanGymBadgeSpeechHousePokefanMText:
if DEF(_FR_FR)
	text "Avant, il y avait"
	line "des SABELETTE à"
	cont "l'ouest d'ici."

	para "Je n'en ai pas vu"
	line "un depuis le début"
	cont "de la pandémie."

	para "J'aime penser"
	line "qu'ils sont partis"
	cont "vers un lieu sûr!"
	done
else
	text "There used to be"
	line "SANDSHREWs west"
	cont "of here."

	para "I haven't seen"
	line "any since the"
	cont "pandemic started."

	para "I like to think"
	line "they went"
	cont "somewhere safer!"
	done
endc

CeruleanGymBadgeSpeechHousePokefanMHoldUpText:
if DEF(_FR_FR)
	text "Je ne comprends"
	line "pas un mot de cet"
	cont "homme. J'ai peur!"
	done
else
	text "I don't understand"
	line "a word from this"
	cont "man. I'm scared!"
	done
endc

CeruleanGymBadgeSpeechHousePokefanMHeldUpText:
if DEF(_FR_FR)
	text "Se faire prendre"
	line "en otage par ce"
	
	para "voleur, c'était une"
	line "sacrée expérience."

	para "J'espère que la"
	line "police va"
	cont "l'attraper."
	done
else
	text "Being held up"
	line "by this thief"
	
	para "was quite an"
	line "experience."

	para "I hope the police"
	line "catches him."
	done
endc

CeruleanGymBadgeSpeechHouseRocketText:
if DEF(_FR_FR)
	text "VOUS ATTRAPER"
	line "JAMAIS MOI!"
	done
else
	text "YOU CATCH ME"
	line "NEVER!"
	done
endc

CeruleanGymBadgeSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 1
	warp_event  3,  7, CERULEAN_CITY, 1
	warp_event  2,  0, CERULEAN_CITY, 9

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanGymBadgeSpeechHousePokefanMScript, -1
	object_event  3,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanGymBadgeSpeechHouseRocketFleesScript, EVENT_CERULEAN_HOUSE_ROCKET
