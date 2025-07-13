	object_const_def
	const CELADONDEPTSTORE4F_CLERK
	const CELADONDEPTSTORE4F_SUPER_NERD
	const CELADONDEPTSTORE4F_YOUNGSTER

CeladonDeptStore4F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonDeptStore4FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_CELADON_4F
	closetext
	end

CeladonDeptStore4FSuperNerdScript:
	jumptextfaceplayer CeladonDeptStore4FSuperNerdText

CeladonDeptStore4FYoungsterScript:
	jumptextfaceplayer CeladonDeptStore4FYoungsterText

CeladonDeptStore4FDirectory:
	jumptext CeladonDeptStore4FDirectoryText

CeladonDeptStore4FElevatorButton:
	jumpstd ElevatorButtonScript

CeladonDeptStore4FSuperNerdText:
if DEF(_FR_FR)
	text "Je viens acheter"
	line "une jolie LETTRE"
	cont "pour l'envoyer à"
	cont "ma petite amie."

	para "Mais je n'en"
	line "trouve aucune."

	para "La pénurie"
	line "va-t-elle briser"
	cont "notre couple?"
	done
else
	text "I'm here to buy a"
	line "LOVELY MAIL to"
	cont "send to my girl-"
	cont "friend."

	para "But I can't"
	line "find any."

	para "Is the shortage"
	line "going to end"
	cont "our couple?"
	done
endc

CeladonDeptStore4FYoungsterText:
if DEF(_FR_FR)
	text "Qu'est-ce que je"
	line "fous ici?"

	para "C'est presque"
	line "vide. C'pas drôle."

	para "Je suis allé à"
	line "une rave l'autre"
	cont "jour. C'était fou!"
	done
else
	text "What am I even"
	line "doing here?"

	para "It's almost empty."
	line "It's no fun."

	para "I went to a rave"
	line "the other day."
	cont "That was lit!"
	done
endc

CeladonDeptStore4FDirectoryText: 
if DEF(_FR_FR)
	text "Offrir, c'est"
	line "merveilleux!"

	para "3EME: CADEAUX DU"
	line "      SAGE"
else
	text "Express Yourself"
	line "With Gifts!"

	para "4F: WISEMAN GIFTS"
endc

	done

CeladonDeptStore4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  0, CELADON_DEPT_STORE_5F, 1
	warp_event 15,  0, CELADON_DEPT_STORE_3F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, CeladonDeptStore4FDirectory
	bg_event  3,  0, BGEVENT_READ, CeladonDeptStore4FElevatorButton

	def_object_events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore4FClerkScript, -1
	object_event  7,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore4FSuperNerdScript, -1
	object_event  8,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore4FYoungsterScript, -1
