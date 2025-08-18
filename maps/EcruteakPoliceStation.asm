	object_const_def
	const ECRUTEAKPOLICESTATION_RECEPTIONIST

EcruteakPoliceStation_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	readvar VAR_YCOORD
	ifequal 5, .got_arrested
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

.got_arrested
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

EcruteakPoliceStationReceptionistScript:
	faceplayer
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .got_arrested
	jumptext EcruteakPoliceStationReceptionistText

.got_arrested
	jumptext EcruteakPoliceStationReceptionistShooText

EcruteakPoliceStationBriefing1Script:
	faceplayer
	jumptext EcruteakPoliceStationBriefingText1

EcruteakPoliceStationBriefing2Script:
	faceplayer
	jumptext EcruteakPoliceStationBriefingText2

EcruteakPoliceStationBriefing3Script:
	faceplayer
	jumptext EcruteakPoliceStationBriefingText3

EcruteakPoliceStationBriefing4Script:
	faceplayer
	jumptext EcruteakPoliceStationBriefingText4

EcruteakPoliceStationOutfitScript:
	faceplayer
	jumptext EcruteakPoliceStationOutfitText

EcruteakPoliceStationPrisonerScript:
	faceplayer
	jumptext EcruteakPoliceStationPrisonerText

EcruteakPoliceStationPrisoner2Script:
	faceplayer
	jumptext EcruteakPoliceStationPrisoner2Text

EcruteakPoliceStationBurnOutScript:
	jumptext EcruteakPoliceStationBurnOutText

EcruteakPoliceDoorLockedScript:
	farjumptext GoldenrodUndergroundTheDoorsLockedText

EcruteakPoliceStationCustodyCellScript:
	jumptext EcruteakPoliceStationCustodyCellText

EcruteakPoliceStationPhoneScript:
	jumptext EcruteakPoliceStationPhoneText

EcruteakPoliceStationTrainingSign:
	jumptext EcruteakPoliceStationTrainingSignText

EcruteakPoliceStationReceptionistText:
if DEF(_FR_FR)
	text "Bienvenue au"
	line "commissariat."

	para "Que puis-je"
	line "faire pour toi?"
else
	text "Welcome to the"
	line "police station."

	para "What can I do"
	line "for you?"
endc
	done

EcruteakPoliceStationReceptionistShooText:
if DEF(_FR_FR)
	text "Je ne veux plus"
	line "jamais te revoir"
	cont "ici. Ouste!"
else
	text "I don't want to"
	line "see you here ever"
	cont "again. Shoo!"
endc
	done

EcruteakPoliceStationOutfitText:
if DEF(_FR_FR)
	text "Que penses-tu"
	line "de mon uniforme?"
	
	para "Il est FAN-TAS-"
	line "TIQUE, pas vrai?"
	
	para "On ne me laisse"
	line "pas le porter..."
else
	text "What do you think"
	line "of my outfit?"
	
	para "It's A-MA-ZING,"
	line "right?"
	
	para "They don't allow"
	line "me to wear it…"
endc
	done

EcruteakPoliceStationBriefingText1:
if DEF(_FR_FR)
	text "Nous avons tant"
	line "à faire en ce"
	cont "moment..."
else
	text "We've got so much"
	line "to do these days…"
endc
	done

EcruteakPoliceStationBriefingText2:
if DEF(_FR_FR)
	text "Ne devrais-tu pas"
	line "être chez toi?"
else
	text "Shouldn't you"
	line "be home?"
endc
	done

EcruteakPoliceStationBriefingText3:
if DEF(_FR_FR)
	text "Je fais un"
	line "briefing à mes"
	cont "collègues."
else
	text "I'm briefing"
	line "my colleagues."
endc
	done

EcruteakPoliceStationBriefingText4:
if DEF(_FR_FR)
	text "..."
else
	text "…"
endc
	done

EcruteakPoliceStationPrisonerText:
if DEF(_FR_FR)
	text "J'aurais dû por-"
	line "ter mon masque"
	cont "correctement, pas"
	cont "sous le menton."

	para "Je suis dans de"
	line "beau draps"
	cont "maintenant!"
else
	text "I should've worn"
	line "my face mask"
	cont "properly, not"
	cont "under the chin."

	para "I'm in deep"
	line "trouble now!"
endc
	done

EcruteakPoliceStationPrisoner2Text:
if DEF(_FR_FR)
	text "Laisse-moi te"
	line "raconter mon"
	cont "histoire."

	para "J'allais à la"
	line "BOUTIQUE faire des"
	cont "des courses quand"
	cont "la police m'a"
	cont "contrôlé."

	para "J'ai montré mon"
	line "auto-attestation:"
	cont "tout était en"
	cont "règle."

	para "Puis ils m'ont"
	line "demandé où j'ha-"
	cont "bite. Et ils me"
	cont "répondent que la"
	cont "BOUTIQUE où je"
	cont "comptais aller"
	cont "n'était pas la"
	cont "plus proche de"
	cont "chez moi."

	para "J'ai dit que la"
	line "plus proche était"
	cont "en rupture, mais"
	cont "ils n'ont rien"
	cont "voulu savoir et"
	cont "m'ont arrêté!"

	para "Tu y crois??"
else
	text "Let me tell you"
	line "my story."

	para "I was going to the"
	line "MART to do groce-"
	cont "ries and got con-"
	cont "trolled by the"
	cont "police."

	para "I showed them my"
	line "self-made attesta-"
	cont "tion: everything"
	cont "was in order."

	para "Then they asked me"
	line "where I live, and"
	cont "their answer was"
	cont "that the #MART"
	cont "I was going to"
	cont "wasn't the closest"
	cont "one to my house."

	para "I told them that"
	line "the closest one"
	cont "was in short"
	cont "supply, but they"
	cont "didn't wanna hear"
	cont "it and I got"
	cont "arrested!"

	para "Can you believe"
	line "it??"
endc
	done

EcruteakPoliceStationBurnOutText:
if DEF(_FR_FR)
	text "Je n'en peux"
	line "plus..."

	para "J'ai choisi ce"
	line "métier pour pro-"
	cont "téger les civils"
	cont "des criminels."

	para "Maintenant ma"
	line "seule mission est"
	cont "d'arrêter ceux"
	cont "qui ne portent"
	cont "pas de masque..."

	para "Qu'est-ce que je"
	line "suis en train de"
	cont "faire?"
else
	text "I can't do it"
	line "anymore…"

	para "I applied to this"
	line "job to protect"
	cont "civilians from"
	cont "dangerous indivi-"
	cont "duals."

	para "Now my only"
	line "mission is to"
	cont "arrest people"
	cont "not wearing a"
	cont "face mask…"

	para "What am I doing?"
endc
	done

EcruteakPoliceStationCustodyCellText:
if DEF(_FR_FR)
	text "Une cellule."
else
	text "A custody cell."
endc
	done

EcruteakPoliceStationPhoneText:
if DEF(_FR_FR)
	text "Un téléphone pour"
	line "ceux qui n'ont"
	cont "pas de #GEAR."
else
	text "There's a phone for"
	line "those who don't"
	cont "have a #GEAR."
endc
	done

EcruteakPoliceStationTrainingSignText:
if DEF(_FR_FR)
	text "TERRAIN D'ENTRAI-"
	line "NEMENT DE LA"
	cont "POLICE"
else
	text "POLICE TRAINING"
	line "FIELD"
endc
	done	

EcruteakPoliceStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, ECRUTEAK_CITY, 17
	warp_event  7,  9, ECRUTEAK_CITY, 17
	warp_event  0,  0, BATTLE_TOWER_1F, 1

	def_coord_events

	def_bg_events
	bg_event  1,  0, BGEVENT_READ, EcruteakPoliceStationTrainingSign
	bg_event  9,  1, BGEVENT_READ, EcruteakPoliceStationPhoneScript
	bg_event  3,  0, BGEVENT_READ, EcruteakPoliceStationCustodyCellScript
	bg_event  5,  0, BGEVENT_READ, EcruteakPoliceStationCustodyCellScript
	bg_event  7,  0, BGEVENT_READ, EcruteakPoliceStationCustodyCellScript

	def_object_events
	object_event  9,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationReceptionistScript, -1
	object_event  0,  0, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceDoorLockedScript, -1
	object_event  4,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing1Script, -1
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | MORN, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing2Script, -1
	object_event  4,  5, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing3Script, -1
	object_event  3,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, %11100000 | MORN, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBriefing4Script, -1
	object_event  9,  2, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 1, -1, %11100000 | MORN | DAY, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationOutfitScript, -1
	object_event  4,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY | NITE, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationPrisonerScript, -1
	object_event  9,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationPrisoner2Script, -1
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPoliceStationBurnOutScript, -1
