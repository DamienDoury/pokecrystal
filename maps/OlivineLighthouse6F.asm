	object_const_def
	const OLIVINELIGHTHOUSE6F_JASMINE
	const OLIVINELIGHTHOUSE6F_AMPHAROS_SICK
	const OLIVINELIGHTHOUSE6F_POKE_BALL

OlivineLighthouse6F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	
.EnterCallback:
	checkevent EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	iftrue .HideJasmine

	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

.HideJasmine
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.EndCallback:
	endcallback

OlivineLighthouseJasmine:
	faceplayer
	opentext
	checkitem CHLOROQUINE
	iftrue .BroughtSecretpotion
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue .ExplainedSickness
	writetext JasmineCianwoodPharmacyText
	promptbutton
	farscall IncMonthAndTryTriggeringCurfew
.ExplainedSickness:
	writetext JasmineGetSomeMedicineText
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue .SkipSurf

	setevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	promptbutton
	writetext JasmineOverTheSeaText
	promptbutton
	verbosegiveitem HM_SURF
	writetext JasminePleaseHelpText

	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel

.SkipSurf:
	waitbutton
	closetext
	end

.BroughtSecretpotion:
	writetext JasmineCureAmphyText
	yesorno
	iffalse .Refused
	writetext PlayerHandedSecretpotionText
	promptbutton
	takeitem CHLOROQUINE
	writetext JasmineDontBeOffendedText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
;	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, LEFT
	opentext
	playmusic MUSIC_HEAL
	writetext JasmineAmphyHowAreYouFeelingText
	promptbutton
	closetext
	pause 30
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, UP
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, DOWN
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, UP
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, DOWN
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, UP
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, DOWN
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, UP
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, DOWN
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, UP
	pause 1
	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, DOWN
	pause 90
	;cry AMPHAROS
	special FadeOutPalettes
	disappear OLIVINELIGHTHOUSE6F_AMPHAROS_SICK
	pause 30
	special FadeInPalettes
	pause 150
	opentext
	writetext JasmineThankYouText
	waitbutton
	closetext
	pause 90
	opentext
	writetext JasmineBackToGymText
	waitbutton
	closetext
	setevent EVENT_JASMINE_RETURNED_TO_GYM
	clearevent EVENT_OLIVINE_GYM_JASMINE
	farscall CheckRocketsActivation
	readvar VAR_FACING
	ifequal DOWN, .FacingDown
	ifequal RIGHT, .FacingRight
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesUpMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	pause 30
	;special RestartMapMusic
	end

.FacingDown:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesDownMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

.FacingRight:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesRightMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

.Refused:
	writetext JasmineISeeText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
;	turnobject OLIVINELIGHTHOUSE6F_AMPHAROS_SICK, LEFT
	opentext
	writetext JasmineAmphyHangOnText
	waitbutton
	closetext
	end

OlivineLighthouseAmphy:
	;faceplayer
	opentext
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	writetext AmphyPalPalooText
	setval AMPHAROS
	special PlaySlowCry
	promptbutton
	writetext AmphyBreathingLaboredText
	waitbutton
	closetext
	end

OlivineLighthouse6FSuperPotion:
	itemball SUPER_POTION

OlivineLighthouseJasmineLeavesUpMovement:
	slow_step UP
	slow_step UP
	slow_step RIGHT
	slow_step UP
	slow_step UP
	step_sleep 8
	step_sleep 8
	step_end

OlivineLighthouseJasmineLeavesDownMovement:
	slow_step DOWN
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	step_end

OlivineLighthouseJasmineLeavesRightMovement:
	slow_step UP
	slow_step UP
	slow_step RIGHT
	slow_step UP
	slow_step UP
	slow_step UP
	step_sleep 8
	step_end

JasmineCianwoodPharmacyText:
if DEF(_FR_FR)
	text "JASMINE: ...Ce"
	line "#MON gardait la"

	para "mer éclairée toute"
	line "la nuit."

	para "...Mais il est"
	line "tombé malade... Il"
	cont "manque d'air..."

	para "On dit qu'il y a"
	line "une bonne PHARMA-"
	cont "CIE à IRISIA..."

	para "Mais je ne peux"
	line "laisser PHARY"
	cont "seul..."
else
	text "JASMINE: … This"
	line "#MON always"

	para "kept the sea lit"
	line "at night."

	para "…But it suddenly"
	line "got sick… It's"
	cont "gasping for air…"

	para "…I understand"
	line "that there is a"

	para "wonderful PHARMACY"
	line "in CIANWOOD…"

	para "And I can't leave"
	line "AMPHY unattended…"
endc
	done

JasmineGetSomeMedicineText: 
if DEF(_FR_FR)
	text "...Peux-tu aller"
	line "chercher des médi-"
	cont "caments? Pitié?"
else
	text "…May I ask you to"
	line "get some medicine"
	cont "for me? Please?"
endc

	done

JasmineOverTheSeaText:
if DEF(_FR_FR)
	text "Mais c'est à l'au-"
	line "tre bout des mers!"

	para "Tu auras besoin"
	line "de ceci..."
else
	text "But that's across"
	line "the sea…"

	para "You will need"
	line "this…"
endc
	done

JasminePleaseHelpText:
if DEF(_FR_FR)
	text "...J'ai besoin de"
	line "ton aide."
else
	text "…I need your help."
endc
	done

JasmineCureAmphyText:
if DEF(_FR_FR)
	text "JASMINE: ...Est-ce"
	line "que la CHLOROQUINE"
	cont "va guérir PHARY?"
else
	text "JASMINE: …Will"
	line "the CHLOROQUINE"
	cont "cure AMPHY?"
endc
	done

PlayerHandedSecretpotionText:
if DEF(_FR_FR)
	text "<PLAYER> donne la"
	line "CHLOROQUINE à"
	cont "JASMINE."
else
	text "<PLAYER> handed the"
	line "CHLOROQUINE to"
	cont "JASMINE."
endc
	done

JasmineDontBeOffendedText: 
if DEF(_FR_FR)
	text "JASMINE: Heu..."
	line "Le prends pas mal"
	cont "mais..."

	para "PHARY n'accepte"
	line "que ce que JE lui"
	cont "donne..."
else
	text "JASMINE: …Um,"
	line "please don't be"
	cont "offended…"

	para "…AMPHY will not"
	line "take anything from"
	cont "anyone but me…"
endc

	done

JasmineAmphyHowAreYouFeelingText: 
if DEF(_FR_FR)
	text "JASMINE: ..."

	para "PHARY, comment te"
	line "sens-tu?"
else
	text "JASMINE: …"

	para "AMPHY, how are you"
	line "feeling?"
endc

	done

JasmineThankYouText:
if DEF(_FR_FR)
	text "JASMINE: ...Oh,"
	line "je..."
	
	para "..."
	line "..."
	
	para "Nous avons fait de"
	line "notre mieux..."
else
	text "JASMINE: …Oh, I'm"
	line "…"

	para "…"
	line "…"

	para "We did our best…"
endc
	done

JasmineBackToGymText:
if DEF(_FR_FR)
	text "... Je rentre"
	line "à l'ARENE..."
else
	text "…I will return to"
	line "the GYM…"
endc
	done

JasmineISeeText: 
if DEF(_FR_FR)
	text "JASMINE: Je vois."
else
	text "JASMINE: …I see…"
endc

	done

JasmineAmphyHangOnText: 
if DEF(_FR_FR)
	text "Courage, PHARY!"
else
	text "…AMPHY, hang on!"
endc

	done

AmphyPalPalooText: 
if DEF(_FR_FR)
	text "PHARY: ..."
	line "...Pha! Phaaa..."
else
	text "AMPHY: …"
	line "…Pa… paloo…"
endc

	done

AmphyBreathingLaboredText: 
if DEF(_FR_FR)
	text "Il respire avec"
	line "difficulté..."
else
	text "Its breathing is"
	line "terribly labored…"
endc

	done

OlivineLighthouse6F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, OLIVINE_LIGHTHOUSE_5F, 1
	warp_event 16,  5, OLIVINE_LIGHTHOUSE_5F, 6
	warp_event 17,  5, OLIVINE_LIGHTHOUSE_5F, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  8, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseJasmine, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  9,  8, SPRITE_AMPHAROS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseAmphy, EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	object_event  3,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse6FSuperPotion, EVENT_OLIVINE_LIGHTHOUSE_6F_SUPER_POTION
