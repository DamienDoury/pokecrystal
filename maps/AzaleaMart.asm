	object_const_def
	const AZALEAMART_CLERK
	const AZALEAMART_VP_CONTROLLER
	const AZALEAMART_COOLTRAINER_M
	const AZALEAMART_BUG_CATCHER

AzaleaMart_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

AzaleaMartClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_AZALEA
	closetext
	end

AzaleaMartCooltrainerMScript:
	jumptextfaceplayer AzaleaMartCooltrainerMText

AzaleaMartBugCatcherScript:
	jumptextfaceplayer AzaleaMartBugCatcherText

AzaleaMartShelfItem1Script:
	shelfitem 1, TOILET_PAPER, 150

AzaleaMartCooltrainerMText:
if DEF(_FR_FR)
	text "Il n'y a pas de"
	line "SUPER BALLS ici."

	para "J'aimerais que"
	line "FARGAS me fabri-"
	cont "que quelques unes"
	cont "de ses BALLS"
	cont "artisanales."
	done
else
	text "There's no GREAT"
	line "BALL here."

	para "I wish KURT would"
	line "make me some of"
	cont "his custom BALLS."
	done
endc

AzaleaMartBugCatcherText: 
if DEF(_FR_FR)
	text "Une SUPER BALL est"
	line "plus efficace"
	cont "qu'une # BALL"
	cont "pour attraper les"
	cont "#MON."

	para "Mais celles de"
	line "FARGAS sont plus"
	cont "efficaces quelque-"
	cont "fois."
else
	text "A GREAT BALL is"
	line "better for catch-"
	cont "ing #MON than a"
	cont "# BALL."

	para "But KURT's might"
	line "be better some-"
	cont "times."
endc

	done

AzaleaMart_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, AZALEA_TOWN, 3
	warp_event  3,  7, AZALEA_TOWN, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaMartClerkScript, -1
	object_event  5,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  2,  5, SPRITE_COOLTRAINER_M, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaMartCooltrainerMScript, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaMartBugCatcherScript, -1
	object_event  4,  5, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaMartShelfItem1Script, EVENT_MART_AZALEA_MISSED
