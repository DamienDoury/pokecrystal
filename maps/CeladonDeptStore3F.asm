	object_const_def
	const CELADONDEPTSTORE3F_CLERK
	const CELADONDEPTSTORE3F_YOUNGSTER
	const CELADONDEPTSTORE3F_GAMEBOY_KID1
	const CELADONDEPTSTORE3F_GAMEBOY_KID2
	const CELADONDEPTSTORE3F_SUPER_NERD

CeladonDeptStore3F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonDeptStore3FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_CELADON_3F
	closetext
	end

CeladonDeptStore3FYoungsterScript:
	jumptextfaceplayer CeladonDeptStore3FYoungsterText

CeladonDeptStore3FGameboyKid1Script:
	faceplayer
	opentext
	writetext CeladonDeptStore3FGameboyKid1Text
	waitbutton
	closetext
	turnobject CELADONDEPTSTORE3F_GAMEBOY_KID1, DOWN
	end

CeladonDeptStore3FGameboyKid2Script:
	faceplayer
	opentext
	writetext CeladonDeptStore3FGameboyKid2Text
	waitbutton
	closetext
	turnobject CELADONDEPTSTORE3F_GAMEBOY_KID2, DOWN
	end

CeladonDeptStore3FSuperNerdScript:
	jumptextfaceplayer CeladonDeptStore3FSuperNerdText

CeladonDeptStore3FElevatorButton:
	jumpstd ElevatorButtonScript

CeladonDeptStore3FDirectory:
	jumptext CeladonDeptStore3FDirectoryText

CeladonDeptStore3FShelfItem1Script:
	shelfitem 8, CALCIUM, 62720

CeladonDeptStore3FYoungsterText:
if DEF(_FR_FR)
	text "Quel bonheur"
	line "d'être vacciné"

	para "et de pouvoir"
	line "faire du shopping!"

	para "J'aimerais que ma"
	line "copine se fasse"
	cont "vacciner aussi..."
	done
else
	text "It feels great"
	line "to be vaccinated"

	para "and be allowed to"
	line "do shopping!"

	para "I wish my girl-"
	line "friend would get"
	cont "vaccinated too…"
	done
endc

CeladonDeptStore3FGameboyKid1Text: 
if DEF(_FR_FR)
	text "Oh! J'ai échangé"
	line "mon #MON sans"

	para "lui enlever mon"
	line "EVOLUTOR!"
else
	text "Uh-oh! I traded my"
	line "#MON without"

	para "removing the UP-"
	line "GRADE from it."
endc

	done

CeladonDeptStore3FGameboyKid2Text: 
if DEF(_FR_FR)
	text "Ouais! Enfin j'ai"
	line "un PORYGON!"

	para "Moi j'aime pas les"
	line "machines à sous."

	para "J'avais jamais"
	line "assez de jetons..."

	para "...Hein???"

	para "Le PORYGON échangé"
	line "s'est transformé"
	cont "en un autre #-"
	cont "MON!"
else
	text "Yeah! I'm finally"
	line "getting a PORYGON!"

	para "I'm no good at the"
	line "slots, so I could"

	para "never get enough"
	line "coins…"

	para "…Huh?"

	para "The traded PORYGON"
	line "turned into a dif-"
	cont "ferent #MON!"
endc

	done

CeladonDeptStore3FSuperNerdText:
if DEF(_FR_FR)
	text "Le MARCHE AUX CT"
	line "vend des capacités"
	cont "assez rares"
	cont "...quand ils ne"
	cont "sont pas en"
	cont "rupture de stock."
	done
else
	text "The TM SHOP sells"
	line "some rare moves…"
	cont "…when their stock"
	cont "isn't empty."
	done
endc

CeladonDeptStore3FDirectoryText: 
if DEF(_FR_FR)
	text "2EME: MARCHE AUX"
	line "      CT"

	para "Renforcez vos"
	line "#MON!"
else
	text "3F: TM SHOP"

	para "Make Your #MON"
	line "Stronger!"
endc

	done

CeladonDeptStore3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  0, CELADON_DEPT_STORE_2F, 1
	warp_event 15,  0, CELADON_DEPT_STORE_4F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, CeladonDeptStore3FDirectory
	bg_event  3,  0, BGEVENT_READ, CeladonDeptStore3FElevatorButton

	def_object_events
	object_event  7,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FClerkScript, -1
	object_event  6,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FYoungsterScript, -1
	object_event  9,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FGameboyKid1Script, -1
	object_event 10,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FGameboyKid2Script, -1
	object_event 13,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FSuperNerdScript, -1
	object_event 12,  7, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FShelfItem1Script, EVENT_MART_CELADON_3F_MISSED
