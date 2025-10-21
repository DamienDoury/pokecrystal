	object_const_def
	const GOLDENRODDEPTSTOREROOF_CLERK
	const GOLDENRODDEPTSTOREROOF_POKEFAN_F
	const GOLDENRODDEPTSTOREROOF_FISHER
	const GOLDENRODDEPTSTOREROOF_TWIN
	const GOLDENRODDEPTSTOREROOF_SUPER_NERD
	const GOLDENRODDEPTSTOREROOF_POKEFAN_M
	const GOLDENRODDEPTSTOREROOF_TEACHER
	const GOLDENRODDEPTSTOREROOF_BUG_CATCHER

GoldenrodDeptStoreRoof_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .CheckSaleChangeBlock
	callback MAPCALLBACK_OBJECTS, .CheckSaleChangeClerk

.CheckSaleChangeBlock:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .SaleIsOn
	endcallback

.SaleIsOn:
	changeblock 0, 2, $3f ; cardboard boxes
	changeblock 0, 4, $0f ; vendor booth
	endcallback

.CheckSaleChangeClerk:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .ChangeClerk
	setevent EVENT_GOLDENROD_SALE_OFF
	clearevent EVENT_GOLDENROD_SALE_ON
	endcallback

.ChangeClerk:
	clearevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_GOLDENROD_SALE_ON
	endcallback

GoldenrodDeptStoreRoofClerkScript:
	opentext
	pokemart MARTTYPE_ROOFTOP, 0
	closetext
	end

GoldenrodDeptStoreRoofPokefanFScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofPokefanFText

GoldenrodDeptStoreRoofFisherScript:
	faceplayer
	opentext
	writetext GoldenrodDeptStoreRoofFisherText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_FISHER, UP
	end

GoldenrodDeptStoreRoofTwinScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofTwinText

GoldenrodDeptStoreRoofSuperNerdScript:
	opentext
	writetext GoldenrodDeptStoreRoofSuperNerdOhWowText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_SUPER_NERD, UP
	opentext
	writetext GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_SUPER_NERD, RIGHT
	end

GoldenrodDeptStoreRoofPokefanMScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofPokefanMText

GoldenrodDeptStoreRoofTeacherScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofTeacherText

GoldenrodDeptStoreRoofBugCatcherScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofBugCatcherText

Binoculars1:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, BinocularsNight
	jumptext Binoculars1Text

Binoculars2:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, BinocularsNight
	jumptext Binoculars2Text

Binoculars3:
	readvar VAR_TIMEOFDAY
	ifequal NITE_F, BinocularsNight
	jumptext Binoculars3Text

BinocularsNight:
	jumptext BinocularsNightText

PokeDollVendingMachine:
	jumptext PokeDollVendingMachineText

GoldenrodDeptStoreRoofPokefanFText: 
if DEF(_FR_FR)
	text "Fouiiii!"

	para "Je vais souvent"
	line "sur le toit pour"

	para "me reposer après"
	line "les courses."
else
	text "Whew, I'm tired."

	para "I sometimes come"
	line "up to the rooftop"

	para "to take a break"
	line "from shopping."
endc

	done

GoldenrodDeptStoreRoofFisherText: 
if DEF(_FR_FR)
	text "Pardon?"
	line "Comment ça un"
	cont "adulte n'a pas le"
	cont "droit de faire ça?"

	para "Je veux toutes"
	line "les poupées!"
else
	text "Pardon? Who says"
	line "an adult can't get"
	cont "into this?"

	para "I'm going to be"
	line "back every day to"

	para "collect all the"
	line "dolls!"
endc

	done

GoldenrodDeptStoreRoofTwinText: 
if DEF(_FR_FR)
	text "Ils font des"
	line "prix spéciaux ici"
	cont "de temps en temps."
else
	text "They have bargain"
	line "sales here every"
	cont "so often."
endc

	done

GoldenrodDeptStoreRoofSuperNerdOhWowText: 
if DEF(_FR_FR)
	text "Oh!"
else
	text "Oh, wow!"
endc

	done

GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText: 
if DEF(_FR_FR)
	text "Tu me lâches,"
	line "ouais?"
else
	text "Will you quit"
	line "bothering me?"
endc

	done

GoldenrodDeptStoreRoofPokefanMText: 
if DEF(_FR_FR)
	text "Je veux acheter un"
	line "truc mais je n'ai"

	para "pas assez d'argent"
	line "sur moi..."

	para "Je vais peut-être"
	line "vendre les BAIES"
	cont "que j'ai trouvées."
else
	text "There's something"
	line "I really want, but"

	para "I don't have the"
	line "necessary cash…"

	para "Maybe I'll sell"
	line "off the BERRIES"
	cont "I've collected…"
endc

	done

GoldenrodDeptStoreRoofTeacherText:
if DEF(_FR_FR)
	text "Oh! Tout est si"
	line "attrayant!"

	para "Mon SAC est plein"
	line "à craquer!"
	done
else
	text "Oh, everything is"
	line "interesting!"

	para "I bought so much,"
	line "my PACK's crammed!"
	done
endc

GoldenrodDeptStoreRoofBugCatcherText: 
if DEF(_FR_FR)
	text "Mes #MON sont"
	line "toujours empoison-"

	para "nés ou paralysés"
	line "au mauvais moment."

	para "Je vais donc ache-"
	line "ter TOTAL SOIN."

	para "Il en reste,"
	line "tu crois?"
else
	text "My #MON always"
	line "get paralyzed or"

	para "poisoned when the"
	line "chips are down…"

	para "So I came to buy"
	line "some FULL HEAL."

	para "I wonder if"
	line "there's any left?"
endc

	done

Binoculars1Text: 
if DEF(_FR_FR)
	text "Je vois loin avec"
	line "ces jumelles."

	para "Je vois presque"
	line "ma maison."

	para "C'est celle avec"
	line "le toit vert?"
else
	text "These binoculars"
	line "let me see far"

	para "away. Maybe I can"
	line "see my own house."

	para "Is it the one with"
	line "the green roof?"
endc

	done

Binoculars2Text: 
if DEF(_FR_FR)
	text "Hé! Des dresseurs"
	line "se battent sur"
	cont "la route!"

	para "Un #MON crache"
	line "des feuilles!"

	para "Ca me donne envie"
	line "de combattre!"
else
	text "Hey! Some trainers"
	line "are battling on"
	cont "the road!"

	para "A #MON fired a"
	line "flurry of leaves!"

	para "That makes me feel"
	line "like battling"
	cont "right now!"
endc

	done

BinocularsNightText:
if DEF(_FR_FR)
	text "Il fait trop"
	line "sombre pour y"
	cont "voir..."
	done
else
	text "It's too dark"
	line "to see anything…"
	done
endc

Binoculars3Text: 
if DEF(_FR_FR)
	text "Un PECHEUR a"
	line "attrapé des"
	cont "MAGICARPE..."

	para "Ils font tous"
	line "TREMPETTE!"

	para "Y'a de l'eau"
	line "partout!"
else
	text "A FISHER caught a"
	line "lot of MAGIKARP…"

	para "They're SPLASHing"
	line "at the same time!"

	para "Look at the water"
	line "going everywhere!"
endc

	done

PokeDollVendingMachineText: 
if DEF(_FR_FR)
	text "Une machine à"
	line "poupées #MON?"

	para "Mettre des sous"
	line "et tourner..."

	para "C'est presque"
	line "vide..."
else
	text "A vending machine"
	line "for #MON dolls?"

	para "Insert money, then"
	line "turn the crank…"

	para "But it's almost"
	line "empty…"
endc

	done

GoldenrodDeptStoreRoof_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13,  1, GOLDENROD_DEPT_STORE_6F, 3

	def_coord_events

	def_bg_events
	bg_event 15,  3, BGEVENT_RIGHT, Binoculars1
	bg_event 15,  5, BGEVENT_RIGHT, Binoculars2
	bg_event 15,  6, BGEVENT_RIGHT, Binoculars3
	bg_event  3,  0, BGEVENT_UP, PokeDollVendingMachine
	bg_event  2,  0, BGEVENT_UP, PokeDollVendingMachine
	bg_event  1,  1, BGEVENT_LEFT, PokeDollVendingMachine

	def_object_events
	object_event  1,  4, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofClerkScript, EVENT_GOLDENROD_SALE_OFF
	object_event 10,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofPokefanFScript, -1
	object_event  2,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, DAY | NITE, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofFisherScript, -1
	object_event  3,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofTwinScript, EVENT_GOLDENROD_SALE_ON
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofSuperNerdScript, EVENT_GOLDENROD_SALE_ON
	object_event  7,  0, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofPokefanMScript, EVENT_GOLDENROD_SALE_OFF
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofTeacherScript, EVENT_GOLDENROD_SALE_OFF
	object_event  1,  6, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofBugCatcherScript, EVENT_GOLDENROD_SALE_OFF
