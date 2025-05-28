	object_const_def
	const SPROUTTOWER2F_SAGE1
	const SPROUTTOWER2F_POKE_BALL
	const SPROUTTOWER2F_SAGE2

SproutTower2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	
.EnterCallback:
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.EndCallback:
	endcallback

TrainerSageNico:
	trainer SAGE, NICO, EVENT_BEAT_SAGE_NICO, SageNicoSeenText, SageNicoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageNicoAfterBattleText
	waitbutton
	closetext
	end

TrainerSageEdmond:
	trainer SAGE, EDMOND, EVENT_BEAT_SAGE_EDMOND, SageEdmondSeenText, SageEdmondBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageEdmondAfterBattleText
	waitbutton
	closetext
	end

SproutTower2FStatue:
	jumptext SproutTower2FStatueText

SproutTower2FXAccuracy:
	itemball X_ACCURACY

SageNicoSeenText: 
if DEF(_FR_FR)
	text "Toutefois, la TOUR"
	line "ne cédera pas même"
	cont "lors d'un grand et"
	cont "rude combat."
else
	text "However hard we"
	line "battle, the TOWER"
	cont "will stand strong."
endc

	done

SageNicoBeatenText: 
if DEF(_FR_FR)
	text "J'ai perdu..."
	line "Je suis faible."
else
	text "I fought hard but"
	line "I'm too weak."
endc

	done

SageNicoAfterBattleText: 
if DEF(_FR_FR)
	text "Le pilier flexible"
	line "protège la TOUR de"

	para "tout, même des"
	line "séismes."
else
	text "The flexible pil-"
	line "lar protects the"

	para "TOWER, even from"
	line "earthquakes."
endc

	done

SageEdmondSeenText: 
if DEF(_FR_FR)
	text "Volez comme vents"
	line "et feuilles!"
	cont "Combat!"
else
	text "…Sway like leaves"
	line "in the wind…"
endc

	done

SageEdmondBeatenText: 
if DEF(_FR_FR)
	text "Oh! Perdu!"
else
	text "Oh, I'm weak!"
endc

	done

SageEdmondAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai essayé de"
	line "copier les mouve-"

	para "ments de CHETIFLOR"
	line "en combat..."

	para "Mais je manque"
	line "d'entraînement."
else
	text "I tried to copy"
	line "BELLSPROUT's"

	para "gentle movements"
	line "for battle…"

	para "But I didn't train"
	line "well enough."
endc

	done

SproutTower2FStatueText: 
if DEF(_FR_FR)
	text "Une statue de"
	line "#MON..."

	para "Ca a l'air cher"
	line "et raffiné."
else
	text "A #MON statue…"

	para "It looks very"
	line "distinguished."
endc

	done

SproutTower2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  4, SPROUT_TOWER_1F, 3
	warp_event  2,  6, SPROUT_TOWER_1F, 4
	warp_event 17,  3, SPROUT_TOWER_1F, 5
	warp_event 10, 14, SPROUT_TOWER_3F, 1

	def_coord_events

	def_bg_events
	bg_event 12, 15, BGEVENT_READ, SproutTower2FStatue

	def_object_events
	object_event 12,  3, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSageNico, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower2FXAccuracy, EVENT_SPROUT_TOWER_2F_X_ACCURACY
	object_event  9, 14, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerSageEdmond, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
