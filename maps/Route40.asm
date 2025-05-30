	object_const_def
	const ROUTE40_OLIVINE_RIVAL1
	const ROUTE40_OLIVINE_RIVAL2
	const ROUTE40_SWIMMER_GIRL1
	const ROUTE40_SWIMMER_GIRL2
	const ROUTE40_ROCK1
	const ROUTE40_ROCK2
	const ROUTE40_ROCK3
	const ROUTE40_LASS1
	const ROUTE40_MONICA
	const ROUTE40_POKEFAN_M
	const ROUTE40_LASS2

Route40_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .MonicaCallback
	callback MAPCALLBACK_TILES, .TilesLoad

.MonicaCallback:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .MonicaAppears
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE40_MONICA
	endcallback

.MonicaAppears:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE40_MONICA
	endcallback

.TilesLoad:
	; Battle Tower.
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .EndTilesCallback

	changeblock  8,  4, $12
	changeblock 10,  4, $33

.EndTilesCallback
	endcallback

TrainerSwimmerfElaine:
	trainer SWIMMERF, ELAINE, EVENT_BEAT_SWIMMERF_ELAINE, SwimmerfElaineSeenText, SwimmerfElaineBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfElaineAfterBattleText

TrainerSwimmerfPaula:
	trainer SWIMMERF, PAULA, EVENT_BEAT_SWIMMERF_PAULA, SwimmerfPaulaSeenText, SwimmerfPaulaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfPaulaAfterBattleText

TrainerSwimmermSimon:
	trainer SWIMMERM, SIMON, EVENT_BEAT_SWIMMERM_SIMON, SwimmermSimonSeenText, SwimmermSimonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermSimonAfterBattleText

TrainerSwimmermRandall:
	trainer SWIMMERM, RANDALL, EVENT_BEAT_SWIMMERM_RANDALL, SwimmermRandallSeenText, SwimmermRandallBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermRandallAfterBattleText

Route40Lass1Script:
	jumptextfaceplayer Route40Lass1Text

Route40PokefanMScript:
	special Mobile_DummyReturnFalse
	iftrue .mobile
	jumptextfaceplayer Route40PokefanMText

.mobile
	jumptextfaceplayer Route40PokefanMText_Mobile

Route40Lass2Script:
	jumptextfaceplayer Route40Lass2Text

MonicaScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	iftrue .Monday
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NotMonday
	checkevent EVENT_MET_MONICA_OF_MONDAY
	iftrue .MetMonica
	writetext MeetMonicaText
	promptbutton
	setevent EVENT_MET_MONICA_OF_MONDAY
.MetMonica:
	writetext MonicaGivesGiftText
	promptbutton
	verbosegiveitem SHARP_BEAK
	iffalse .done
	setevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	writetext MonicaGaveGiftText
	waitbutton
	closetext
	end

.Monday:
	writetext MonicaMondayText
	waitbutton
.done:
	closetext
	end

.NotMonday:
	writetext MonicaNotMondayText
	waitbutton
	closetext
	end

Route40Sign:
	jumptext Route40SignText

Route40Rock:
	jumpstd SmashRockScript

Route40HiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_ROUTE_40_HIDDEN_HYPER_POTION

Route40_DoorScript:
	jumpstd ClosedBusinessScript

SwimmermSimonSeenText: 
if DEF(_FR_FR)
	text "Il faut s'échauf-"
	line "fer avant de se"
	cont "baigner."

	para "Tout le monde sait"
	line "ça!"
else
	text "You have to warm"
	line "up before going"
	cont "into the water."

	para "That's basic."
endc

	done

SwimmermSimonBeatenText: 
if DEF(_FR_FR)
	text "Aïe! Une crampe!"
else
	text "OK! Uncle! I give!"
endc

	done

SwimmermSimonAfterBattleText: 
if DEF(_FR_FR)
	text "IRISIA est assez"
	line "loin d'ici."
else
	text "CIANWOOD CITY is"
	line "a good distance"
	cont "away from here."
endc

	done

SwimmermRandallSeenText: 
if DEF(_FR_FR)
	text "T'as la flemme ou"
	line "quoi?"

	para "Nage au lieu de"
	line "monter sur ton"
	cont "#MON!"
else
	text "Hey, you're young"
	line "and fit!"

	para "Don't ride your"
	line "#MON! Swim!"
endc

	done

SwimmermRandallBeatenText: 
if DEF(_FR_FR)
	text "Zut de flûte."
else
	text "Uh-oh. I lost…"
endc

	done

SwimmermRandallAfterBattleText: 
if DEF(_FR_FR)
	text "Nager, c'est bon"
	line "pour la santé."
else
	text "Swimming exercises"
	line "your entire body."
	cont "It's healthy."
endc

	done

SwimmerfElaineSeenText: 
if DEF(_FR_FR)
	text "Tu vas à IRISIA?"

	para "On s'bat d'abord?"
else
	text "Are you going to"
	line "CIANWOOD?"

	para "How about a quick"
	line "battle first?"
endc

	done

SwimmerfElaineBeatenText: 
if DEF(_FR_FR)
	text "C'est perdu!"
else
	text "I lost that one!"
endc

	done

SwimmerfElaineAfterBattleText: 
if DEF(_FR_FR)
	text "En tout cas, je"
	line "nage mieux que"
	cont "toi. Ouais!"
else
	text "I'd say I'm a bet-"
	line "ter swimmer than"
	cont "you. Yeah!"
endc

	done

SwimmerfPaulaSeenText: 
if DEF(_FR_FR)
	text "J'adore les #-"
	line "MON marins!"
else
	text "No inner tube for"
	line "me."

	para "I'm hanging on to"
	line "a sea #MON!"
endc

	done

SwimmerfPaulaBeatenText: 
if DEF(_FR_FR)
	text "Oups!"
else
	text "Ooh, I'm feeling"
	line "dizzy!"
endc

	done

SwimmerfPaulaAfterBattleText: 
if DEF(_FR_FR)
	text "Je me laisse"
	line "porter par les"
	cont "vagues."
else
	text "While I float like"
	line "this, the waves"
	cont "carry me along."
endc

	done

Route40Lass1Text: 
if DEF(_FR_FR)
	text "IRISIA est de"
	line "l'autre côté de la"
	cont "mer."
else
	text "Although you can't"
	line "see it from here,"

	para "CIANWOOD is across"
	line "the sea."
endc

	done

Route40PokefanMText: 
if DEF(_FR_FR)
	text "Hmm! Il y a un"
	line "grand immeuble"
	cont "droit devant!"

	para "C'est quoi donc?"
else
	text "Hm! There's a big"
	line "building up ahead!"

	para "What is it?"
endc

	done

Route40PokefanMText_Mobile: 
if DEF(_FR_FR)
	text "Hmm! Tu as vu tous"
	line "les dresseurs"
	cont "qui sont entrés?"

	para "C'est quoi donc?"
else
	text "Hm! Look at all"
	line "those serious-"
	cont "looking trainers"
	cont "streaming in."

	para "What? What?"
endc

	done

Route40Lass2Text: ; TO TRANSLATE
	text "I came to OLIVINE"
	line "by ship the day"
	cont "before the lock-"
	cont "down was enforced,"
	
	para "to see the sights"
	line "and soak up the"
	cont "atmosphere."

	para "Being a port, it"
	line "feels so different"
	cont "from a big city."
	done

MeetMonicaText: 
if DEF(_FR_FR)
	text "LUCIE: Bonjour!"
	line "Je suis LUCIE du"

	para "lundi."
else
	text "MONICA: Glad to"
	line "meet you. I'm"

	para "MONICA of Monday."
endc

	done

MonicaGivesGiftText: 
if DEF(_FR_FR)
	text "Puisqu'on est des"
	line "potes, voilà un"
	cont "petit cadeau!"
else
	text "As a token of our"
	line "friendship, I have"
	cont "a gift for you!"
endc

	done

MonicaGaveGiftText: 
if DEF(_FR_FR)
	text "LUCIE: C'est un"
	line "objet qui améliore"

	para "les capacités du"
	line "type VOL."

	para "Tu devrais le don-"
	line "ner à un #MON"
	cont "oiseau."
else
	text "MONICA: It's an"
	line "item that raises"

	para "the power of fly-"
	line "ing-type moves."

	para "You should equip a"
	line "bird #MON with"
	cont "that item."
endc

	done

MonicaMondayText: 
if DEF(_FR_FR)
	text "LUCIE: Mes frères"
	line "et soeurs sont un"
	cont "peu partout."

	para "Trouve-les tous!"
else
	text "MONICA: My broth-"
	line "ers and sisters"

	para "are all over the"
	line "place."

	para "See if you could"
	line "find them all!"
endc

	done

MonicaNotMondayText: 
if DEF(_FR_FR)
	text "LUCIE: On est pas"
	line "lundi aujourd'hui!"
	cont "Dommage..."
else
	text "MONICA: I don't"
	line "think today is"
	cont "Monday. How sad…"
endc

	done

Route40SignText: 
if DEF(_FR_FR)
	text "ROUTE 40"

	para "IRISIA -"
	line "OLIVILLE"
else
	text "ROUTE 40"

	para "CIANWOOD CITY -"
	line "OLIVINE CITY"
endc

	done

Route40_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  5, ROUTE_40_BATTLE_TOWER_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 14, 10, BGEVENT_READ, Route40Sign
	bg_event  6,  9, BGEVENT_ITEM, Route40HiddenHyperPotion

	def_object_events
	object_event 14, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 2, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerSwimmermSimon, -1
	object_event 18, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerSwimmermRandall, -1
	object_event  3, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerSwimmerfElaine, -1
	object_event 10, 25, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 2, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerSwimmerfPaula, -1
	object_event  7, 11, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  6,  9, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event  7,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event 11, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Lass1Script, -1
	object_event  8, 10, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, MonicaScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40PokefanMScript, -1
	object_event 13,  4, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route40Lass2Script, -1
	object_event  9,  5, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40_DoorScript, EVENT_RETURNED_MACHINE_PART
