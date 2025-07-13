	object_const_def
	const CIANWOODLUGIASPEECHHOUSE_TEACHER
	const CIANWOODLUGIASPEECHHOUSE_LASS
	const CIANWOODLUGIASPEECHHOUSE_TWIN
	const CIANWOODLUGIASPEECHHOUSE_TEACHER_LOCKDOWN
	const CIANWOODLUGIASPEECHHOUSE_COMPUTER

CianwoodLugiaSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject CIANWOODLUGIASPEECHHOUSE_LASS, 5, 1
	moveobject CIANWOODLUGIASPEECHHOUSE_TWIN, 6, 1
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	loadmem wMap3ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	endcallback

.TilesLoad
	readmem wCurFreedomState
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	changeblock  4,  2, $35
.end
	endcallback

CianwoodLugiaSpeechHouseTeacherScript:
	faceplayer
	jumptext CianwoodLugiaSpeechHouseTeacherText

CianwoodLugiaSpeechHouseTeacherLockdownScript:
	faceplayer
	opentext
	writetext CianwoodLugiaSpeechHouseTeacherLockdownText
	waitbutton
	closetext
	turnobject CIANWOODLUGIASPEECHHOUSE_TEACHER_LOCKDOWN, LEFT
	end

CianwoodLugiaSpeechHouseLassScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseLassText

.lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseLassLockdownText

CianwoodLugiaSpeechHouseTwinScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseTwinText

.lockdown
	jumptextfaceplayer CianwoodLugiaSpeechHouseTwinLockdownText

CianwoodLugiaSpeechHouseComputerScript:
	jumptext CianwoodLugiaSpeechHouseComputerText

CianwoodLugiaSpeechHouseBookshelf:
	jumpstd PictureBookshelfScript

CianwoodLugiaSpeechHouseTeacherText: 
if DEF(_FR_FR)
	text "Tu viens"
	line "d'OLIVILLE?"

	para "Tu te rappelles"
	line "des quatre îles"
	cont "sur la route?"

	para "J'ai entendu dire"
	line "qu'une créature"
	cont "marine mythique"
	cont "s'y cache."
else
	text "You came from"
	line "OLIVINE?"

	para "Do you remember"
	line "the four islands"
	cont "along the way?"

	para "I heard that a "
	line "mythical sea crea-"
	cont "ture is hiding in"
	cont "them."
endc

	done

CianwoodLugiaSpeechHouseLassText:
if DEF(_FR_FR)
	text "J'ai lu que l'on"
	line "ne voit la créa-"

	para "marine seulement"
	line "avec une AILE"
	cont "ARGENT."

	para "Elle doit avoir la"
	line "même odeur que la"
	cont "créature."
	done
else
	text "I read that you"
	line "can only see the"

	para "sea creature if"
	line "you have a SILVER"
	cont "WING."

	para "It must have the"
	line "same scent as the"
	cont "creature."
	done
endc

CianwoodLugiaSpeechHouseLassLockdownText:
if DEF(_FR_FR)
	text "“L'air de la mer"
	line "te fera du bien”"
	cont "a dit maman."

	para "Je ne connais"
	line "personne ici et"
	cont "je ne peux même"

	para "pas suivre les"
	line "cours en ligne."

	para "C'est la vraie"
	line "definition d'une"
	cont "quarantaine."
	done
else
	text "“The air from the"
	line "sea will be good"
	cont "for you” said mom."

	para "I know no one"
	line "around, and I can't"
	
	para "even follow the"
	line "online class."

	para "This is the true"
	line "definition of a"
	cont "quarantine."
	done
endc

CianwoodLugiaSpeechHouseTwinText:
if DEF(_FR_FR)
	text "J'ai lu que les"
	line "tourbillons autour"

	para "des îles sont"
	line "provoqués par la"
	cont "créature des"
	cont "profondeurs."

	para "Faut peut-être"
	line "une CS spéciale"
	cont "pour passer."
	done
else
	text "I've read that"
	line "the whirlpools"

	para "around the islands"
	line "are caused by the"
	cont "sea creature."

	para "You might need a"
	line "special move to"
	cont "get past them."
	done
endc

CianwoodLugiaSpeechHouseTwinLockdownText:
if DEF(_FR_FR)
	text "Maman n'a pas"
	line "pensé au débit"
	
	para "internet avant de"
	line "nous installer"
	cont "ici."

	para "C'est la chose la"
	line "plus vitale en"
	line "cette période!"

	para "Me voilà coincée à"
	line "lire des livres..."
	done
else
	text "Mom didn't think"
	line "about the internet"
	
	para "connexion quality"
	line "before moving us"
	cont "here."
	
	para "It's the number one"
	line "most important"
	
	para "thing in this"
	line "period!"
	
	para "Here I am, stuck"
	line "reading books…"
	done
endc

CianwoodLugiaSpeechHouseTeacherLockdownText:
if DEF(_FR_FR)
	text "Lors de l'annonce"
	line "du premier confi-"
	cont "nement, j'ai vite"
	cont "déplacé ma famille"
	cont "depuis SAFRANIA"
	cont "vers cette maison"
	cont "de vacances."

	para "Je suis censée"
	line "télétravailler,"
	cont "mais..."

	para "C'est gênant..."

	para "Regarde mon"
	line "écran..."
	done
else
	text "So when the first"
	line "lockdown was ann-"
	cont "ounced, I quickly"
	cont "moved my family"
	cont "from SAFFRON CITY"
	cont "to this vacation"
	cont "house we own."

	para "I am supposed to"
	line "work remotely but…"

	para "This is embarras-"
	line "sing…"
	cont "Look at my screen…"
	done
endc

CianwoodLugiaSpeechHouseComputerText:
if DEF(_FR_FR)
	text "Un appel vidéo"
	line "tourne à la"
	cont "vitesse fulgurante"
	cont "de 20 images par"

	para "minute."
	done
else
	text "A video call run-"
	line "ning at a whopping"
	cont "20 frames per"
	
	para "minute."
	done
endc

CianwoodLugiaSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 6
	warp_event  3,  7, CIANWOOD_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CianwoodLugiaSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CianwoodLugiaSpeechHouseBookshelf

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseTeacherScript, -1
	object_event  6,  5, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseLassScript, -1
	object_event  0,  2, SPRITE_TWIN, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseTwinScript, -1
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseTeacherLockdownScript, -1
	object_event  4,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodLugiaSpeechHouseComputerScript, -1
