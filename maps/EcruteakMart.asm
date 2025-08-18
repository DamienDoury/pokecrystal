	object_const_def
	const ECRUTEAKMART_CLERK
	const ECRUTEAKMART_VP_CONTROLLER
	const ECRUTEAKMART_SUPER_NERD
	const ECRUTEAKMART_GRANNY

EcruteakMart_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

EcruteakMartClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_ECRUTEAK
	closetext
	end

EcruteakMartSuperNerdScript:
	jumptextfaceplayer EcruteakMartSuperNerdText

EcruteakMartGrannyScript:
	jumptextfaceplayer EcruteakMartGrannyText

EcruteakMartCooltrainerFScript:
	jumptextfaceplayer EcruteakMartCooltrainerFText

EcruteakMartShelfItem1Script:
	shelfitem 1, ULTRA_BALL, 1200

EcruteakMartSuperNerdText: 
if DEF(_FR_FR)
	text "Mon EVOLI a évolué"
	line "en MENTALI."

	para "Mais l'EVOLI de"
	line "mon copain a"
	cont "évolué en NOCTALI."

	para "Je me demande"
	line "pourquoi? On a"

	para "tous les deux"
	line "élevé notre EVOLI"
	cont "de la même façon!"
else
	text "My EEVEE evolved"
	line "into an ESPEON."

	para "But my friend's"
	line "EEVEE turned into"
	cont "an UMBREON."

	para "I wonder why? We"
	line "both were raising"

	para "our EEVEE in the"
	line "same way…"
endc

	done

EcruteakMartGrannyText: 
if DEF(_FR_FR)
	text "Si tu utilises"
	line "RAPPEL, le #MON"

	para "K.O. reviendra à"
	line "lui."
else
	text "If you use REVIVE,"
	line "a #MON that's"

	para "fainted will wake"
	line "right up."
endc

	done

EcruteakMartCooltrainerFText:
if DEF(_FR_FR)
	text "Je n'y crois pas!"

	para "Je vais de"
	line "magasin en"
	cont "magasin,"

	para "et quand enfin je"
	line "réussis à trouver"
	cont "des # BALLS,"

	para "leur prix a"
	line "augmenté!"

	para "Ça me rend folle"
	line "de ne pas en"
	cont "trouver au prix"
	cont "habituel!"
else
	text "I can't believe it!"
	
	para "I'm going from"
	line "mart to mart,"

	para "and when I manage"
	line "to find some #"

	para "BALLS, then their"
	line "price has gone up!"

	para "It's driving me"
	line "crazy not to find"
	
	para "any at the regular"
	line "price!"
endc
	done


EcruteakMart_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ECRUTEAK_CITY, 9
	warp_event  3,  7, ECRUTEAK_CITY, 9

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakMartClerkScript, -1
	object_event  1,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  5,  2, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakMartSuperNerdScript, -1
	object_event  6,  6, SPRITE_GRANNY, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakMartGrannyScript, -1
	object_event  8,  3, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EcruteakMartCooltrainerFScript, -1
	object_event  1,  5, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakMartShelfItem1Script, EVENT_MART_ECRUTEAK_MISSED
