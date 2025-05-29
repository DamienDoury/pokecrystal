	object_const_def
	const REDSHOUSE2F_PIKACHU

RedsHouse2F_MapScripts:
	def_scene_scripts

	def_callbacks

RedsHouse2FPikachuScript:
	setval PIKACHU
	special PlaySlowCry
	waitsfx
	pause 15
	faceplayer
	pause 15
	opentext
	writetext RedsPikachuStaresText

	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .partyfull

	promptbutton
	writetext RedsPikachuTakeText
	yesorno
	iffalse .close_text

	givepoke PIKACHU, 100, LIGHT_BALL, TRUE, AdoptedPikachuName, AdoptedPikachuOTName
	special MakeRedsPikachu

	pause 45
	cry PIKACHU
	pause 15
	setevent EVENT_REDS_PIKACHU_AVAILABLE
	disappear REDSHOUSE2F_PIKACHU
	pause 10
	writetext RedsPikachuJoinsText
	playsound SFX_CAUGHT_MON
	waitsfx

.partyfull:
	waitbutton
.close_text
	closetext
	end

AdoptedPikachuName:
if DEF(_FR_FR)
	db "PIKACHU@"
else
	db "PIKACHU@"
endc

AdoptedPikachuOTName:
if DEF(_FR_FR)
	db "RED@"
else
	db "RED@"
endc

RedsHouse2FN64Script:
	jumptext RedsHouse2FN64Text

RedsHouse2FPCScript:
	jumptext RedsHouse2FPCText

RedsHouse2FN64Text: 
if DEF(_FR_FR)
	text "<PLAYER> joue"
	line "à la N64."

	para "Bon. On y va"
	line "maintenant?"
else
	text "<PLAYER> played the"
	line "N64."

	para "Better get going--"
	line "no time to lose!"
endc

	done

RedsHouse2FPCText: 
if DEF(_FR_FR)
	text "On n'a pas utilisé"
	line "ceci depuis bien"
	cont "longtemps..."
else
	text "It looks like it"
	line "hasn't been used"
	cont "in a long time…"
endc

	done

RedsPikachuStaresText: ; TO TRANSLATE
	text "PIKACHU stares at"
	line "you insistently."

	para "It looks in bad"
	line "health, you should"
	cont "do something"
	cont "about it."
	done

RedsPikachuTakeText: ; TO TRANSLATE
	text "Take it into"
	line "your arms?"
	done

RedsPikachuJoinsText: ; TO TRANSLATE
	text "PIKACHU joins"
	line "<PLAYER>'s party."
	done

RedsHouse2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  0, REDS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  5, BGEVENT_READ, RedsHouse2FN64Script
	bg_event  0,  1, BGEVENT_READ, RedsHouse2FPCScript

	def_object_events
	object_event  1,  5, SPRITE_WALKING_PIKACHU, SPRITEMOVEDATA_STANDING_LEFT, 1, 1, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, RedsHouse2FPikachuScript, EVENT_REDS_PIKACHU_AVAILABLE
