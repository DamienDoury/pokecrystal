	object_const_def
	const LAKEOFRAGE_POLICE_1_1
	const LAKEOFRAGE_POLICE_1_2
	const LAKEOFRAGE_POLICE_1_3
	const LAKEOFRAGE_POLICE_1_4
	const LAKEOFRAGE_POLICE_2_1
	const LAKEOFRAGE_POLICE_2_2
	const LAKEOFRAGE_POLICE_2_3
	const LAKEOFRAGE_POLICE_3_1
	const LAKEOFRAGE_POLICE_4_1
	const LAKEOFRAGE_POLICE_4_2
	const LAKEOFRAGE_POLICE_4_3
	const LAKEOFRAGE_POLICE_4_4

	const LAKEOFRAGE_LANCE
	const LAKEOFRAGE_GRAMPS
	const LAKEOFRAGE_SUPER_NERD1
	const LAKEOFRAGE_COOLTRAINER_F1
	const LAKEOFRAGE_FISHER1
	const LAKEOFRAGE_FISHER2
	const LAKEOFRAGE_COOLTRAINER_M
	const LAKEOFRAGE_COOLTRAINER_F2
	const LAKEOFRAGE_GYARADOS
	const LAKEOFRAGE_WESLEY
	const LAKEOFRAGE_POKE_BALL1
	const LAKEOFRAGE_POKE_BALL2

LakeOfRage_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_OBJECTS, .Wesley

.FlyPoint:
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel
.endcallback
	endcallback

.Wesley:
	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .WesleyAppears
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; LAKEOFRAGE_WESLEY
	endcallback

.WesleyAppears:
	endcallback

LakeOfRageLanceScript:
	checkevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	iftrue .AskAgainForHelp
	opentext
	writetext LakeOfRageLanceForcedToEvolveText
	promptbutton
	faceplayer
	writetext LakeOfRageLanceIntroText
	yesorno
	iffalse .RefusedToHelp
.AgreedToHelp:
	writetext LakeOfRageLanceRadioSignalText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement LAKEOFRAGE_LANCE, LakeOfRageLanceTeleportIntoSkyMovement
	disappear LAKEOFRAGE_LANCE
	clearevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_DECIDED_TO_HELP_LANCE
	setmapscene MAHOGANY_MART_1F, SCENE_MAHOGANYMART1F_LANCE_UNCOVERS_STAIRS
	end

.RefusedToHelp:
	writetext LakeOfRageLanceRefusedText
	waitbutton
	closetext
	setevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	end

.AskAgainForHelp:
	faceplayer
	opentext
	writetext LakeOfRageLanceAskHelpText
	yesorno
	iffalse .RefusedToHelp
	sjump .AgreedToHelp

RedGyarados:
	opentext
	writetext LakeOfRageGyaradosCryText
	pause 15
	cry GYARADOS
	closetext
	loadwildmon GYARADOS, 40
	loadvar VAR_BATTLETYPE, BATTLETYPE_SHINY
	startbattle
	ifequal LOSE, .NotBeaten
	disappear LAKEOFRAGE_GYARADOS
.NotBeaten:
	reloadmapafterbattle
	opentext
	giveitem RED_SCALE
	waitsfx
	writetext LakeOfRageGotRedScaleText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	appear LAKEOFRAGE_LANCE
	end

LakeOfRageGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	writetext LakeOfRageGrampsText
	waitbutton
	closetext
	end

.ClearedRocketHideout:
	writetext LakeOfRageGrampsText_ClearedRocketHideout
	waitbutton
	closetext
	end

LakeOfRageSuperNerdScript:
	jumptextfaceplayer LakeOfRageSuperNerdText

LakeOfRageCooltrainerFScript:
	jumptextfaceplayer LakeOfRageCooltrainerFText

LakeOfRageSign:
	jumptext LakeOfRageSignText

MagikarpHouseSignScript:
	opentext
	writetext FishingGurusHouseSignText
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .MagikarpLengthRecord
	waitbutton
	closetext
	end

.MagikarpLengthRecord:
	promptbutton
	special MagikarpHouseSign
	closetext
	end

TrainerFisherAndre:
	trainer FISHER, ANDRE, EVENT_BEAT_FISHER_ANDRE, FisherAndreSeenText, FisherAndreBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherAndreAfterBattleText

TrainerFisherRaymond:
	trainer FISHER, RAYMOND, EVENT_BEAT_FISHER_RAYMOND, FisherRaymondSeenText, FisherRaymondBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherRaymondAfterBattleText

TrainerCooltrainermAaron:
	trainer COOLTRAINERM, AARON, EVENT_BEAT_COOLTRAINERM_AARON, CooltrainermAaronSeenText, CooltrainermAaronBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainermAaronAfterBattleText

TrainerCooltrainerfLois:
	trainer COOLTRAINERF, LOIS, EVENT_BEAT_COOLTRAINERF_LOIS, CooltrainerfLoisSeenText, CooltrainerfLoisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerfLoisAfterBattleText

WesleyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	iftrue WesleyWednesdayScript
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, WesleyNotWednesdayScript
	checkevent EVENT_MET_WESLEY_OF_WEDNESDAY
	iftrue .MetWesley
	writetext MeetWesleyText
	promptbutton
	setevent EVENT_MET_WESLEY_OF_WEDNESDAY
.MetWesley:
	writetext WesleyGivesGiftText
	promptbutton
	verbosegiveitem BLACKBELT_I
	iffalse WesleyDoneScript
	setevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	writetext WesleyGaveGiftText
	waitbutton
	closetext
	end

WesleyWednesdayScript:
	writetext WesleyWednesdayText
	waitbutton
WesleyDoneScript:
	closetext
	end

WesleyNotWednesdayScript:
	writetext WesleyNotWednesdayText
	waitbutton
	closetext
	end

LakeOfRageElixer:
	itemball ELIXER

LakeOfRageRareCandy:
	itemball RARE_CANDY

LakeOfRageHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE

LakeOfRageHiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY

LakeOfRageHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION

LakeOfRageLanceTeleportIntoSkyMovement:
	teleport_from
	step_end

LakeOfRageLanceForcedToEvolveText: 
if DEF(_FR_FR)
	text "Ce LAC est rempli"
	line "de LEVIATOR et"
	cont "rien d'autre..."

	para "Les MAGICARPE ont"
	line "été forcés"
	cont "d'évoluer..."
else
	text "This lake is full"
	line "of GYARADOS but"
	cont "nothing else…"

	para "So the MAGIKARP"
	line "are being forced"
	cont "to evolve…"
endc

	done

LakeOfRageLanceIntroText: 
if DEF(_FR_FR)
	text "Es-tu ici à cause"
	line "de la rumeur?"

	para "Tu es <PLAYER>?"
	line "Moi c'est PETER,"
	cont "un dresseur comme"
	cont "toi."

	para "J'ai entendu"
	line "certaines informa-"
	cont "tions et je suis"
	cont "venu faire mon"
	cont "enquête..."

	para "Je t'ai vu com-"
	line "battre, <PLAY_G>."

	para "On peut dire que"
	line "tu as du talent."

	para "Ca te dirait de"
	line "me donner un coup"
	cont "de main?"
else
	text "Did you come here"
	line "because of the"
	cont "rumors?"

	para "You're <PLAYER>?"
	line "I'm LANCE, a"
	cont "trainer like you."

	para "I heard some ru-"
	line "mors, so I came to"
	cont "investigate…"

	para "I saw the way you"
	line "battled earlier,"
	cont "<PLAY_G>."

	para "I can tell that"
	line "you're a trainer"

	para "with considerable"
	line "skill."

	para "If you don't mind,"
	line "could you help me"
	cont "investigate?"
endc

	done

LakeOfRageLanceRadioSignalText: 
if DEF(_FR_FR)
	text "PETER: Excellent!"

	para "On dirait que"
	line "quelque chose"
	cont "force les"
	cont "MAGICARPE du LAC"
	cont "à évoluer."

	para "Un mystérieux"
	line "signal radio vient"
	cont "d'ACAJOU."

	para "Je t'y attendrai,"
	line "<PLAY_G>."
else
	text "LANCE: Excellent!"

	para "It seems that the"
	line "LAKE's MAGIKARP"

	para "are being forced"
	line "to evolve."

	para "A mysterious radio"
	line "broadcast coming"

	para "from MAHOGANY is"
	line "the cause."

	para "I'll be waiting"
	line "for you, <PLAY_G>."
endc

	done

LakeOfRageLanceRefusedText: 
if DEF(_FR_FR)
	text "Oh... Bon, si tu"
	line "changes d'avis,"
	cont "tu pourras"
	cont "m'aider."
else
	text "Oh… Well, if you"
	line "change your mind,"
	cont "please help me."
endc

	done

LakeOfRageLanceAskHelpText: 
if DEF(_FR_FR)
	text "PETER: Hum? Vas-tu"
	line "m'aider?"
else
	text "LANCE: Hm? Are you"
	line "going to help me?"
endc

	done

LakeOfRageGyaradosCryText: 
if DEF(_FR_FR)
	text "LEVIATOR: Tttooor!"
else
	text "GYARADOS: Gyashaa!"
endc

	done

LakeOfRageGotRedScaleText: 
if DEF(_FR_FR)
	text "<PLAYER> obtient"
	line "une ECAILLEROUGE."
else
	text "<PLAYER> obtained a"
	line "RED SCALE."
endc

	done

LakeOfRageGrampsText: 
if DEF(_FR_FR)
	text "Les LEVIATOR sont"
	line "en colère!"

	para "Mauvais présage!"
else
	text "The GYARADOS are"
	line "angry!"

	para "It's a bad omen!"
endc

	done

LakeOfRageGrampsText_ClearedRocketHideout: 
if DEF(_FR_FR)
	text "Hahah! Les"
	line "MAGICARPE mordent!"
else
	text "Hahah! The MAGI-"
	line "KARP are biting!"
endc

	done

LakeOfRageSuperNerdText: 
if DEF(_FR_FR)
	text "On dit que ce LAC"
	line "a été fait par"
	cont "le déchaînement de"
	cont "LEVIATOR."

	para "Je me demande"
	line "s'il y a un lien"

	para "avec leur colère?"
else
	text "I heard this lake"
	line "was made by ram-"
	cont "paging GYARADOS."

	para "I wonder if there"
	line "is any connection"

	para "to their mass out-"
	line "break now?"
endc

	done

LakeOfRageCooltrainerFText: 
if DEF(_FR_FR)
	text "J'ai la berlue ou"
	line "quoi? J'ai vu un"
	cont "LEVIATOR rouge"
	cont "dans le LAC..."

	para "Je croyais qu'il"
	line "n'y avait que des"
	cont "LEVIATOR bleus?"
else
	text "Did my eyes de-"
	line "ceive me? I saw a"

	para "red GYARADOS in"
	line "the LAKE…"

	para "But I thought"
	line "GYARADOS were"
	cont "usually blue?"
endc

	done

FisherAndreSeenText: 
if DEF(_FR_FR)
	text "Laisse-moi donc"
	line "combattre avec le"
	cont "#MON que je"
	cont "viens d'attraper!"
else
	text "Let me battle with"
	line "the #MON I just"
	cont "caught!"
endc

	done

FisherAndreBeatenText: 
if DEF(_FR_FR)
	text "J'suis peut-être"
	line "un bon pêcheur"

	para "mais j'suis un"
	line "mauvais dresseur."
else
	text "I might be an ex-"
	line "pert angler, but"

	para "I stink as a #-"
	line "MON trainer…"
endc

	done

FisherAndreAfterBattleText: 
if DEF(_FR_FR)
	text "J'suis un bon"
	line "pêcheur, moi."
	cont "Et j'attrape des"
	cont "#MON!"
else
	text "I won't lose as an"
	line "angler! I catch"
	cont "#MON all day."
endc

	done

FisherRaymondSeenText: 
if DEF(_FR_FR)
	text "Qu'importe ce que"
	line "je fais, j'attrape"

	para "toujours le même"
	line "#MON..."
else
	text "No matter what I"
	line "do, all I catch"

	para "are the same #-"
	line "MON…"
endc

	done

FisherRaymondBeatenText: 
if DEF(_FR_FR)
	text "Ma ligne est toute"
	line "emmêlée..."
else
	text "My line's all"
	line "tangled up…"
endc

	done

FisherRaymondAfterBattleText: 
if DEF(_FR_FR)
	text "Pourquoi je ne"
	line "peux pas attraper"
	cont "de bons #MON?"
else
	text "Why can't I catch"
	line "any good #MON?"
endc

	done

CooltrainermAaronSeenText: 
if DEF(_FR_FR)
	text "Si un dresseur"
	line "éclabousse un"

	para "autre dresseur, ça"
	line "fini en duel."

	para "C'est la loi."
else
	text "If a trainer spots"
	line "another trainer,"

	para "he has to make a"
	line "challenge."

	para "That is our"
	line "destiny."
endc

	done

CooltrainermAaronBeatenText: 
if DEF(_FR_FR)
	text "Whaa..."
	line "Bon combat!"
else
	text "Whew…"
	line "Good battle."
endc

	done

CooltrainermAaronAfterBattleText: 
if DEF(_FR_FR)
	text "Les #MON et"
	line "leur dresseur"

	para "deviennent forts"
	line "en combattant"
	cont "régulièrement."
else
	text "#MON and their"
	line "trainer become"

	para "powerful through"
	line "constant battling."
endc

	done

CooltrainerfLoisSeenText: 
if DEF(_FR_FR)
	text "Qu'est-il arrivé"
	line "au LEVIATOR rouge?"

	para "Il est parti?"

	para "Oh, zut! Je suis"
	line "venue pour rien?"

	para "Bon..."
	line "COMBAT!"
else
	text "What happened to"
	line "the red GYARADOS?"

	para "It's gone?"

	para "Oh, darn. I came"
	line "here for nothing?"

	para "I know--let's"
	line "battle!"
endc

	done

CooltrainerfLoisBeatenText: 
if DEF(_FR_FR)
	text "Pas mal!"
else
	text "Good going!"
endc

	done

CooltrainerfLoisAfterBattleText: 
if DEF(_FR_FR)
	text "Au fait..."
	line "J'ai vu un"
	cont "PAPILUSION rose."
else
	text "Come to think of"
	line "it, I've seen a"
	cont "pink BUTTERFREE."
endc

	done

MeetWesleyText: 
if DEF(_FR_FR)
	text "HOMER: Alors,"
	line "comment va?"

	para "Moi c'est HOMER"
	line "du mercredi. Et"

	para "aujourd'hui..."
	line "C'est mercredi!"
else
	text "WESLEY: Well, how"
	line "do you do?"

	para "Seeing as how it's"
	line "Wednesday today,"

	para "I'm WESLEY of"
	line "Wednesday."
endc

	done

WesleyGivesGiftText: 
if DEF(_FR_FR)
	text "Enchanté de faire"
	line "ta connaissance."
	cont "V'là un souvenir."
else
	text "Pleased to meet"
	line "you. Please take a"
	cont "souvenir."
endc

	done

WesleyGaveGiftText: 
if DEF(_FR_FR)
	text "HOMER: La CEINT."
	line "NOIRE renforce le"
	cont "pouvoir des capa-"
	cont "cités de COMBAT."
else
	text "WESLEY: BLACKBELT"
	line "beefs up the power"
	cont "of fighting moves."
endc

	done

WesleyWednesdayText: 
if DEF(_FR_FR)
	text "HOMER: Avant de"
	line "m'avoir trouvé,"

	para "t'as dû rencontrer"
	line "mes frères et"
	cont "soeurs."

	para "Ou alors t'es en"
	line "veine?"
else
	text "WESLEY: Since you"
	line "found me, you must"

	para "have met my broth-"
	line "ers and sisters."

	para "Or did you just"
	line "get lucky?"
endc

	done

WesleyNotWednesdayText: 
if DEF(_FR_FR)
	text "HOMER: On n'est"
	line "pas mercredi!!!"
	cont "Dommage!"
else
	text "WESLEY: Today's"
	line "not Wednesday."
	cont "That's too bad."
endc

	done

LakeOfRageSignText: 
if DEF(_FR_FR)
	text "LAC COLERE,"
	line "aussi connu sous"
	cont "le nom de LAC"
	cont "LEVIATOR."
else
	text "LAKE OF RAGE,"
	line "also known as"
	cont "GYARADOS LAKE."
endc

	done

FishingGurusHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DU MAITRE"
	line "PECHEUR"
else
	text "FISHING GURU'S"
	line "HOUSE"
endc

	done

LakeOfRage_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  3, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, 1
	warp_event 27, 31, LAKE_OF_RAGE_MAGIKARP_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 21, 27, BGEVENT_READ, LakeOfRageSign
	bg_event 25, 31, BGEVENT_READ, MagikarpHouseSignScript
	bg_event 11, 28, BGEVENT_ITEM, LakeOfRageHiddenFullRestore
	bg_event  4,  4, BGEVENT_ITEM, LakeOfRageHiddenRareCandy
	bg_event 35,  5, BGEVENT_ITEM, LakeOfRageHiddenMaxPotion

	def_object_events
	object_event  4, 15, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 30, 24, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  3, 27, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event 24, 30, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1

	object_event 28, 26, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 17,  6, SPRITE_OFFICER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 10, 13, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1

	object_event 16,  4, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 34, 21, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 17, 28, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 26, 29, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 25, 26, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1


	object_event 21, 28, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageLanceScript, EVENT_LAKE_OF_RAGE_LANCE
	object_event 20, 26, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageGrampsScript, -1
	object_event 36, 13, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageSuperNerdScript, -1
	object_event 25, 29, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageCooltrainerFScript, -1
	object_event 30, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerFisherAndre, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 24, 26, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerFisherRaymond, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event  4, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 36,  7, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainerfLois, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 18, 22, SPRITE_GYARADOS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RedGyarados, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	object_event  4,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, WesleyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageElixer, EVENT_LAKE_OF_RAGE_ELIXER
	object_event 35,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageRareCandy, EVENT_LAKE_OF_RAGE_RARE_CANDY
