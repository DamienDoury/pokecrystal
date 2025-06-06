	object_const_def
	const RADIOTOWER4F_FISHER
	const RADIOTOWER4F_TEACHER
	const RADIOTOWER4F_GROWLITHE
	const RADIOTOWER4F_ROCKET1
	const RADIOTOWER4F_ROCKET2
	const RADIOTOWER4F_ROCKET_GIRL
	const RADIOTOWER4F_SCIENTIST

RadioTower4F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower4FFisherScript:
	jumptextfaceplayer RadioTower4FFisherText

RadioTower4FDJMaryScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PINK_BOW_FROM_MARY
	iftrue .GotPinkBow
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .ClearedRockets
	writetext RadioTower4FDJMaryText
	waitbutton
	closetext
	end

.ClearedRockets:
	writetext RadioTower4FDJMaryText_ClearedRockets
	promptbutton
	verbosegiveitem PINK_BOW
	iffalse .NoRoom
	writetext RadioTower4FDJMaryText_GivePinkBow
	waitbutton
	closetext
	setevent EVENT_GOT_PINK_BOW_FROM_MARY
	end

.GotPinkBow:
	writetext RadioTower4FDJMaryText_After
	waitbutton
.NoRoom:
	closetext
	end

RadioTowerMeowth:
	opentext
	writetext RadioTowerMeowthText
	cry MEOWTH
	waitbutton
	closetext
	end

TrainerGruntM10:
	trainer GRUNTM, GRUNTM_10, EVENT_BEAT_ROCKET_GRUNTM_10, GruntM10SeenText, GruntM10BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM10AfterBattleText

TrainerExecutivem2:
	trainer EXECUTIVEM, EXECUTIVEM_2, EVENT_BEAT_ROCKET_EXECUTIVEM_2, Executivem2SeenText, Executivem2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer Executivem2AfterBattleText

TrainerGruntF4:
	trainer GRUNTF, GRUNTF_4, EVENT_BEAT_ROCKET_GRUNTF_4, GruntF4SeenText, GruntF4BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntF4AfterBattleText

TrainerScientistRich:
	trainer SCIENTIST, RICH, EVENT_BEAT_SCIENTIST_RICH, ScientistRichSeenText, ScientistRichBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer ScientistRichAfterBattleText

RadioTower4FProductionSign:
	jumptext RadioTower4FProductionSignText

RadioTower4FStudio2Sign:
	jumptext RadioTower4FStudio2SignText

RadioTower4FFisherText: 
if DEF(_FR_FR)
	text "J'écoutais la ra-"
	line "dio tout en visi-"
	cont "tant les RUINES."

	para "J'y ai entendu une"
	line "émission étrange."
else
	text "I listened to the"
	line "radio while I was"
	cont "at the RUINS."

	para "I heard a strange"
	line "broadcast there."
endc

	done

RadioTower4FDJMaryText: 
if DEF(_FR_FR)
	text "LULA: Pourquoi?"
	line "Pourquoi tant de"
	cont "haine?"

	para "MIAOUSS, à l'aide!"
else
	text "MARY: Why? Why do"
	line "I have to suffer"
	cont "through this?"

	para "MEOWTH, help me!"
endc

	done

RadioTower4FDJMaryText_ClearedRockets: 
if DEF(_FR_FR)
	text "LULA: Oh! Tu es"
	line "formidable!"

	para "Veux-tu de ceci"
	line "en remerciement?"
else
	text "MARY: Oh! You're"
	line "my little savior!"

	para "Will you take this"
	line "as my thanks?"
endc

	done

RadioTower4FDJMaryText_GivePinkBow: 
if DEF(_FR_FR)
	text "LULA: C'est pour"
	line "les #MON qui"

	para "connaissent des"
	line "techniques du type"
	cont "NORMAL."
else
	text "MARY: It's just"
	line "right for #MON"

	para "that know normal-"
	line "type moves."
endc

	done

RadioTower4FDJMaryText_After: 
if DEF(_FR_FR)
	text "LULA: Ecoute mon"
	line "émission avec le"

	para "PROF.CHEN: la"
	line "CHRONIQUE #MON."
else
	text "MARY: Please tune"
	line "into me on PROF."

	para "OAK'S #MON TALK"
	line "show."
endc

	done

RadioTowerMeowthText: 
if DEF(_FR_FR)
	text "MIAOUSS: Miaou..."
else
	text "MEOWTH: Meowth…"
endc

	done

GruntM10SeenText: ; TO TRANSLATE
	text "I believe COVID"
	line "is a lie from"
	cont "the government."
	done

GruntM10BeatenText: 
if DEF(_FR_FR)
	text "Incroyable!"
else
	text "No! Unbelievable!"
endc

	done

GruntM10AfterBattleText: 
if DEF(_FR_FR)
	text "Je..."
	line "J'le crois pas!"
else
	text "I don't believe"
	line "it! I was beaten!"
endc

	done

GruntF4SeenText: ; TO TRANSLATE
	text "Living in lockdown"
	line "is not an accep-"
	cont "table way of"
	cont "living!"
	done

GruntF4BeatenText: ; TO TRANSLATE
	text "I should run home!"
	done

GruntF4AfterBattleText: ; TO TRANSLATE
	text "People are getting"
	line "crazy when locked"
	cont "up home."

	para "I say being locked"
	line "up can cause more"
	cont "damage than COVID."
	done

Executivem2SeenText: ; TO TRANSLATE

	text "The lockdowns and"
	line "curfews will"

	para "destroy our"
	line "economy."
	done

Executivem2BeatenText: ; TO TRANSLATE
	text "Please don't take"
	line "my money!"
	done

Executivem2AfterBattleText: ; TO TRANSLATE
	text "The dip in our"
	line "economy will cause"

	para "more damage to our"
	line "society than the"
	cont "disease itself."
	
	para "Wanna bet?"
	done

ScientistRichSeenText: 
if DEF(_FR_FR)
	text "Parfait."

	para "Cette TOUR RADIO"
	line "sera parfaite pour"
	cont "nos plans."
else
	text "Most excellent."

	para "This RADIO TOWER"
	line "will fulfill our"
	cont "grand design."
endc

	done

ScientistRichBeatenText: 
if DEF(_FR_FR)
	text "Hmmm..."

	para "Tout plan comprend"
	line "certains accrocs."
else
	text "Hmmm…"

	para "All grand plans"
	line "come with snags."
endc

	done

ScientistRichAfterBattleText: ; TO TRANSLATE
	text "Do you honestly"
	line "believe the"
	
	para "government is"
	line "trying to save us?"
	done

RadioTower4FProductionSignText: 
if DEF(_FR_FR)
	text "3EME PRODUCTION"
else
	text "4F PRODUCTION"
endc

	done

RadioTower4FStudio2SignText: 
if DEF(_FR_FR)
	text "3EME STUDIO 2"
else
	text "4F STUDIO 2"
endc

	done

RadioTower4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_5F, 1
	warp_event  9,  0, RADIO_TOWER_3F, 2
	warp_event 12,  0, RADIO_TOWER_5F, 2
	warp_event 17,  0, RADIO_TOWER_3F, 3

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_READ, RadioTower4FProductionSign
	bg_event 15,  0, BGEVENT_READ, RadioTower4FStudio2Sign

	def_object_events
	object_event  6,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower4FFisherScript, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 14,  6, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower4FDJMaryScript, -1
	object_event 12,  7, SPRITE_MEOWTH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RadioTowerMeowth, -1
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM10, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerExecutivem2, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  4, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerGruntF4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerScientistRich, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
