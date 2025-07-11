	object_const_def
	const SPROUTTOWER1F_SAGE1
	const SPROUTTOWER1F_VP_CONTROLLER
	const SPROUTTOWER1F_SAGE2
	const SPROUTTOWER1F_GRANNY
	const SPROUTTOWER1F_TEACHER
	const SPROUTTOWER1F_SAGE3
	const SPROUTTOWER1F_POKE_BALL

SproutTower1F_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	
.VaccinePassport:
	jumpstd VaccinePassCheckpoint

.EnterCallback:
	readvar VAR_YCOORD
	ifnotequal 15, .CheckCurfewWhenEntered

	readmem wCurFreedomState
	writemem wFreedomStateWhenEntered

.CheckCurfewWhenEntered
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.EndCallback:
	endcallback

SproutTower1FSage1Script:
	jumptextfaceplayer SproutTower1FSage1Text

SproutTower1FSage2Script:
	jumptextfaceplayer SproutTower1FSage2Text

SproutTower1FGrannyScript:
	jumptextfaceplayer SproutTower1FGrannyText

SproutTower1FTeacherScript:
	jumptextfaceplayer SproutTower1FTeacherText

TrainerSageChow:
	trainer SAGE, CHOW, EVENT_BEAT_SAGE_CHOW, SageChowSeenText, SageChowBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SageChowAfterBattleText

SproutTower1FParlyzHeal:
	itemball PARLYZ_HEAL

SproutTower1FStatue:
	jumptext SproutTower1FStatueText

SageChowSeenText: 
if DEF(_FR_FR)
	text "Nous montons la"
	line "garde dans cette"
	cont "tour."

	para "Nous y exprimons"
	line "notre gratitude"
	cont "envers tous les"
	cont "#MON."
else
	text "We stand guard in"
	line "this tower."

	para "Here, we express"
	line "our gratitude to"
	cont "honor all #MON."
endc

	done

SageChowBeatenText: 
if DEF(_FR_FR)
	text "M--Merci!"
else
	text "Th-Thank you!"
endc

	done

SageChowAfterBattleText: 
if DEF(_FR_FR)
	text "Tous les êtres"
	line "vivent grâce à une"
	cont "entente."

	para "Coopération, sym-"
	line "biose: la vie."
else
	text "All living beings"
	line "coexist through"
	cont "cooperation."

	para "We must always be"
	line "thankful for this."
endc

	done

SproutTower1FSage1Text: 
if DEF(_FR_FR)
	text "Celui ou celle ar-"
	line "rivant au sommet"
	cont "recevra une CS."
else
	text "Only if you reach"
	line "the top will you"
	cont "obtain an HM."
endc

	done

SproutTower1FSage2Text: 
if DEF(_FR_FR)
	text "La TOUR CHETIFLOR"
	line "a été construite"

	para "il y a longtemps"
	line "pour entraîner les"
	cont "#MON."
else
	text "SPROUT TOWER was"
	line "built long ago"

	para "as a place for"
	line "#MON training."
endc

	done

SproutTower1FGrannyText: 
if DEF(_FR_FR)
	text "Un CHETIFLOR haut"
	line "de 30 mètres..."

	para "On raconte que"
	line "c'est en fait le"
	cont "pilier central."
else
	text "A BELLSPROUT over"
	line "100 feet tall…"

	para "People say that it"
	line "became the center"
	cont "pillar here."
endc

	done

SproutTower1FTeacherText: 
if DEF(_FR_FR)
	text "Vois-tu le pilier"
	line "trembler?"

	para "On s'entraîne sec"
	line "au-dessus."
else
	text "See the pillar"
	line "shaking?"

	para "People are train-"
	line "ing upstairs."
endc

	done

SproutTower1FStatueText: 
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

SproutTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, VIOLET_CITY, 7
	warp_event 10, 15, VIOLET_CITY, 7
	warp_event  6,  4, SPROUT_TOWER_2F, 1
	warp_event  2,  6, SPROUT_TOWER_2F, 2
	warp_event 17,  3, SPROUT_TOWER_2F, 3

	def_coord_events

	def_bg_events
	bg_event  7, 15, BGEVENT_READ, SproutTower1FStatue
	bg_event 12, 15, BGEVENT_READ, SproutTower1FStatue

	def_object_events
	object_event  7,  4, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SproutTower1FSage1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  9, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  6,  7, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SproutTower1FSage2Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 11, 12, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SproutTower1FGrannyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  9,  9, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SproutTower1FTeacherScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSageChow, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 16,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower1FParlyzHeal, EVENT_SPROUT_TOWER_1F_PARLYZ_HEAL
