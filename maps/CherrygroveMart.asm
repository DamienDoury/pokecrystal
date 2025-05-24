	object_const_def
	const CHERRYGROVEMART_CLERK
	const CHERRYGROVEMART_VP_CONTROLLER
	const CHERRYGROVEMART_COOLTRAINER_M
	const CHERRYGROVEMART_YOUNGSTER

CherrygroveMart_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

CherrygroveMartClerkScript:
	opentext
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .PokeBallsInStock
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE
	closetext
	end

.PokeBallsInStock:
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE_DEX
	closetext
	end

CherrygroveMartCooltrainerMScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .PokeBallsInStock
	writetext CherrygroveMartCooltrainerMText
	waitbutton
	closetext
	end

.PokeBallsInStock:
	writetext CherrygroveMartCooltrainerMText_PokeBallsInStock
	waitbutton
	closetext
	end

CherrygroveMartYoungsterScript:
	jumptextfaceplayer CherrygroveMartYoungsterText

CherrygroveMartShelfItem1Script:
	shelfitem 4, MAX_REPEL, 2800

CherrygroveMartCooltrainerMText: ; AUTOTRAD
	text "They're fresh out"
	line "of # BALLS!"

	para "When will they get"
	line "more of them?"
	done

CherrygroveMartCooltrainerMText_PokeBallsInStock: ; AUTOTRAD
	text "# BALLS are in"
	line "stock! Now I can"
	cont "catch #MON!"
	done

CherrygroveMartYoungsterText: ; TO TRANSLATE
	text "When I was walking"
	line "in the grass, a"

	para "#MON poisoned"
	line "my #MON!"

	para "I just kept going,"
	line "but then my"
	cont "#MON fainted."

	para "You should keep an"
	line "ANTIDOTE with you."
	done

CherrygroveMart_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 1
	warp_event  3,  7, CHERRYGROVE_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartClerkScript, -1
	object_event  1,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartCooltrainerMScript, -1
	object_event  2,  5, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveMartYoungsterScript, -1
	object_event  1,  5, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartShelfItem1Script, EVENT_MART_CHERRYGROVE_MISSED
