	object_const_def
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST1
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST2
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST3

RuinsOfAlphResearchCenter_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_RUINSOFALPHRESEARCHCENTER_NOTHING
	scene_script .GetUnownDex ; SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .ScientistCallback

.DummyScene0:
	end

.GetUnownDex:
	prioritysjump .GetUnownDexScript
	end

.ScientistCallback:
	checkscene
	ifequal SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX, .ShowScientist
	endcallback

.ShowScientist:
	moveobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 3, 7
	appear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	endcallback

.GetUnownDexScript:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesComputerMovement
	playsound SFX_BOOT_PC
	pause 60
	playsound SFX_SWITCH_POKEMON
	pause 30
	playsound SFX_TALLY
	pause 30
	playsound SFX_TRANSACTION
	pause 30
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	opentext
	writetext RuinsOfAlphResearchCenterModifiedDexText
	waitbutton
	writetext RuinsOfAlphResearchCenterDexUpgradedText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_UNOWN_DEX
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterLeavesPlayerMovement
	setscene SCENE_RUINSOFALPHRESEARCHCENTER_NOTHING
	special RestartMapMusic
	end

RuinsOfAlphResearchCenterScientist3Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	end

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterScientist3_PrinterAvailable
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterScientist1Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
	checkflag ENGINE_UNOWN_DEX
	iftrue .GotUnownDex
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	writetext RuinsOfAlphResearchCenterScientist1Text
	waitbutton
	closetext
	end

.UnownAppeared:
	writetext RuinsOfAlphResearchCenterScientist1Text_UnownAppeared
	waitbutton
	closetext
	end

.GotUnownDex:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotUnownDex
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotAllUnown
	waitbutton
	closetext
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	end

RuinsOfAlphResearchCenterScientist2Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	writetext RuinsOfAlphResearchCenterScientist2Text
	waitbutton
	closetext
	end

.UnownAppeared:
	writetext RuinsOfAlphResearchCenterScientist2Text_UnownAppeared
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterScientist2Text_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterComputer:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
.SkipChecking:
	writetext RuinsOfAlphResearchCenterComputerText
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterComputerText_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterPrinter:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
.SkipChecking:
	writetext RuinsOfAlphResearchCenterPrinterText_DoesntWork
	waitbutton
	closetext
	end

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterUnownPrinterText
	waitbutton
	special UnownPrinter
	closetext
	end

RuinsOfAlphResearchCenterBookshelf:
	jumptext RuinsOfAlphResearchCenterAcademicBooksText

RuinsOfAlphResearchCenterApproachesComputerMovement:
	step UP
	step UP
	step LEFT
	turn_head UP
	step_end

RuinsOfAlphResearchCenterLeavesPlayerMovement:
	turn_head UP
	step_end

RuinsOfAlphResearchCenterModifiedDexText: 
if DEF(_FR_FR)
	text "Fini!"

	para "J'ai modifié ton"
	line "#DEX."

	para "J'ai incorporé un"
	line "autre #DEX"

	para "pour enregistrer"
	line "les données de"

	para "ZARBI dans l'ordre"
	line "où ses formes"
	cont "seront capturées."
else
	text "Done!"

	para "I modified your"
	line "#DEX."

	para "I added an"
	line "optional #DEX"

	para "to store UNOWN"
	line "data."

	para "It records them in"
	line "the sequence that"
	cont "they were caught."
endc

	done

RuinsOfAlphResearchCenterDexUpgradedText: 
if DEF(_FR_FR)
	text "Le #DEX de"
	line "<PLAYER> est"
	cont "amélioré!"
else
	text "<PLAYER>'s #DEX"
	line "was upgraded."
endc

	done

RuinsOfAlphResearchCenterScientist3Text: 
if DEF(_FR_FR)
	text "Les ZARBI capturés"
	line "seront tous enre-"
	cont "gistrés."

	para "Découvrez-les"
	line "tous!"
else
	text "The UNOWN you"
	line "catch will all be"
	cont "recorded."

	para "Check to see how"
	line "many kinds exist."
endc

	done

RuinsOfAlphResearchCenterScientist3_PrinterAvailable: 
if DEF(_FR_FR)
	text "Tu as attrapé tous"
	line "les types de"
	cont "ZARBI?"

	para "Mais c'est super,"
	line "mon bouchon!"

	para "J'ai préparé l'im-"
	line "primante pour les"
	cont "données de ZARBI."

	para "Tu peux l'utiliser"
	line "quand tu veux."
else
	text "You caught all the"
	line "UNOWN variations?"

	para "That's a great"
	line "achievement!"

	para "I've set up the"
	line "printer here for"
	cont "handling UNOWN."

	para "Feel free to use"
	line "it anytime."
endc

	done

RuinsOfAlphResearchCenterScientist1Text: 
if DEF(_FR_FR)
	text "Les RUINES sont"
	line "vieilles d'environ"
	cont "1500 ans."

	para "Personne ne sait"
	line "qui a pu les"
	cont "construire..."
	cont "Ni dans quel but."
else
	text "The RUINS are"
	line "about 1500 years"
	cont "old."

	para "But it's not known"
	line "why they were"
	cont "built--or by whom."
endc

	done

RuinsOfAlphResearchCenterScientist1Text_GotUnownDex: 
if DEF(_FR_FR)
	text "Combien y a-t-il"
	line "de #MON diffé-"
	cont "rents dans les"
	cont "RUINES?"
else
	text "I wonder how many"
	line "kinds of #MON"
	cont "are in the RUINS?"
endc

	done

RuinsOfAlphResearchCenterScientist1Text_UnownAppeared: 
if DEF(_FR_FR)
	text "Des #MON sont"
	line "apparus dans les"
	cont "RUINES?"

	para "Bah ça pour une"
	line "nouvelle!"

	para "Il faut tout de"
	line "suite y aller!"
else
	text "#MON appeared"
	line "in the RUINS?"

	para "That's incredible"
	line "news!"

	para "We'll need to"
	line "investigate this."
endc

	done

RuinsOfAlphResearchCenterScientist1Text_GotAllUnown: 
if DEF(_FR_FR)
	text "Grâce à ton aide,"
	line "notre enquête sur"

	para "les RUINES donne"
	line "enfin des"
	cont "résultats."

	para "Les RUINES sem-"
	line "blent être un re-"

	para "fuge pour les"
	line "#MON."
else
	text "Our investigation,"
	line "with your help, is"

	para "giving us insight"
	line "into the RUINS."

	para "The RUINS appear"
	line "to have been built"

	para "as a habitat for"
	line "#MON."
endc

	done

RuinsOfAlphResearchCenterScientist2Text: 
if DEF(_FR_FR)
	text "Il y a des figures"
	line "étranges sur les"
	cont "murs des RUINES."

	para "Elles doivent être"
	line "la clé du mystère"
	cont "des RUINES."
else
	text "There are odd pat-"
	line "terns drawn on the"

	para "walls of the"
	line "RUINS."

	para "They must be the"
	line "keys for unravel-"
	cont "ing the mystery"
	cont "of the RUINS."
endc

	done

RuinsOfAlphResearchCenterScientist2Text_UnownAppeared: 
if DEF(_FR_FR)
	text "Les étranges #-"
	line "MON des RUINES?"

	para "Ils semblent être"
	line "proches des figu-"
	cont "res sur les murs."

	para "Hmmm..."

	para "Cela veut dire"
	line "qu'il y en a un"
	cont "grand nombre..."
else
	text "The strange #-"
	line "MON you saw in the"
	cont "RUINS?"

	para "They appear to be"
	line "very much like the"

	para "drawings on the"
	line "walls there."

	para "Hmm…"

	para "That must mean"
	line "there are many"
	cont "kinds of them…"
endc

	done

RuinsOfAlphResearchCenterScientist2Text_GotAllUnown: 
if DEF(_FR_FR)
	text "Comment ces drôles"
	line "de figures ont pu"
	cont "apparaître?"
	cont "C'est dingue!"

	para "J'y comprends"
	line "rien..."
else
	text "Why did those"
	line "ancient patterns"

	para "appear on the wall"
	line "now?"

	para "The mystery"
	line "deepens…"
endc

	done

RuinsOfAlphResearchCenterComputerText: 
if DEF(_FR_FR)
	text "RUINES D'ALPHA"

	para "Exploration"
	line "Année 10"
else
	text "RUINS OF ALPH"

	para "Exploration"
	line "Year 10"
endc

	done

RuinsOfAlphResearchCenterComputerText_GotAllUnown: 
if DEF(_FR_FR)
	text "#MON Mystère"
	line "Nom: ZARBI"

	para "Un total de {d:NUM_UNOWN}"
	line "types découverts."
else
	text "Mystery #MON"
	line "Name: UNOWN"

	para "A total of {d:NUM_UNOWN}"
	line "kinds found."
endc

	done

RuinsOfAlphResearchCenterPrinterText_DoesntWork: 
if DEF(_FR_FR)
	text "Cela n'a pas l'air"
	line "de marcher pour"
	cont "l'instant..."
else
	text "This doesn't seem"
	line "to work yet."
endc

	done

RuinsOfAlphResearchCenterUnownPrinterText: 
if DEF(_FR_FR)
	text "ZARBI peut être"
	line "imprimé."
else
	text "UNOWN may be"
	line "printed out."
endc

	done

RuinsOfAlphResearchCenterAcademicBooksText: 
if DEF(_FR_FR)
	text "Il y a beaucoup de"
	line "livres de science."

	para "Anciennes ruines."
	line "Antiques mystères."
else
	text "There are many"
	line "academic books."

	para "Ancient Ruins…"
	line "Mysteries of the"
	cont "Ancients…"
endc

	done

RuinsOfAlphResearchCenter_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, RUINS_OF_ALPH_OUTSIDE, 6
	warp_event  3,  7, RUINS_OF_ALPH_OUTSIDE, 6

	def_coord_events

	def_bg_events
	bg_event  6,  5, BGEVENT_READ, RuinsOfAlphResearchCenterBookshelf
	bg_event  3,  4, BGEVENT_READ, RuinsOfAlphResearchCenterComputer
	bg_event  7,  1, BGEVENT_READ, RuinsOfAlphResearchCenterPrinter

	def_object_events
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist1Script, -1
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 2, 1, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist2Script, -1
	object_event  2,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist3Script, EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
