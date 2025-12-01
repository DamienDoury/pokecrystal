	object_const_def
	const SPROUTTOWER3F_SAGE2
	const SPROUTTOWER3F_SAGE1
	const SPROUTTOWER3F_SAGE3
	const SPROUTTOWER3F_SAGE4
	const SPROUTTOWER3F_POKE_BALL1
	const SPROUTTOWER3F_POKE_BALL2
	const SPROUTTOWER3F_SILVER

SproutTower3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback
	
.EnterCallback:
	checkevent EVENT_RIVAL_SPROUT_TOWER
	iffalse .SilverInSproutTower

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Hides Silver, and disables the coord event.

.SilverInSproutTower
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Hides Silver, and disables the coord event.

.EndCallback:
	endcallback

SproutTower3FRivalScene:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	playsound SFX_TACKLE
	playsound SFX_ELEVATOR
	earthquake 79
	pause 15
	playsound SFX_TACKLE
	playsound SFX_ELEVATOR
	earthquake 79
	applymovement PLAYER, SproutTower3FPlayerApproachesRivalMovement
	applymovement SPROUTTOWER3F_SILVER, SproutTower3FRivalApproachesElderMovement
	opentext
	writetext SproutTowerElderLecturesRivalText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, SPROUTTOWER3F_SILVER, 15
	turnobject SPROUTTOWER3F_SILVER, DOWN
	pause 15
	applymovement SPROUTTOWER3F_SILVER, SproutTower3FRivalLeavesElderMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext SproutTowerRivalOnlyCareAboutStrongText
	waitbutton
	closetext
	turnobject SPROUTTOWER3F_SILVER, UP
	opentext
	writetext SproutTowerRivalUsedEscapeRopeText
	pause 15
	closetext
	playsound SFX_WARP_TO
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear SPROUTTOWER3F_SILVER ; Also sets EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2.
	setevent EVENT_RIVAL_SPROUT_TOWER
	waitsfx
	special FadeInQuickly
	special RestartMapMusic
	end

SageLiScript:
	faceplayer
	opentext
	checkitem HM_FLASH
	iftrue .GotFlash
	writetext SageLiSeenText
	waitbutton
	closetext
	winlosstext SageLiBeatenText, 0
	loadtrainer SAGE, LI
	startbattle
	reloadmapafterbattle
	opentext
	writetext SageLiTakeThisFlashText
	promptbutton
	verbosegiveitem HM_FLASH
	setevent EVENT_BEAT_SAGE_LI
	setmapscene ELMS_LAB, SCENE_ELMSLAB_NOTHING
	writetext SageLiFlashExplanationText
	waitbutton
	closetext
	end

.GotFlash:
	writetext SageLiAfterBattleText
	waitbutton
	closetext
	end

TrainerSageJin:
	trainer SAGE, JIN, EVENT_BEAT_SAGE_JIN, SageJinSeenText, SageJinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SageJinAfterBattleText

TrainerSageTroy:
	trainer SAGE, TROY, EVENT_BEAT_SAGE_TROY, SageTroySeenText, SageTroyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SageTroyAfterBattleText

TrainerSageNeal:
	trainer SAGE, NEAL, EVENT_BEAT_SAGE_NEAL, SageNealSeenText, SageNealBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SageNealAfterBattleText

SproutTower3FPainting:
	jumptext SproutTower3FPaintingText

SproutTower3FStatue:
	jumptext SproutTower3FStatueText

SproutTower3FPotion:
	itemball POTION

SproutTower3FEscapeRope:
	itemball ESCAPE_ROPE

SproutTower3FPlayerApproachesRivalMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

SproutTower3FRivalApproachesElderMovement:
	step UP
	step_end

SproutTower3FRivalLeavesElderMovement:
	step RIGHT
	step DOWN
	step_end

SproutTowerElderLecturesRivalText: 
if DEF(_FR_FR)
	text "ANCIEN: Tu es"
	line "sans conteste un"
	cont "bon dresseur."

	para "Comme promis,"
	line "voici ta CS."

	para "Un conseil toute-"
	line "fois: traite tes"

	para "#MON avec plus"
	line "de gentillesse."

	para "Tu es bien trop"
	line "âpre au combat."

	para "Les #MON ne"
	line "sont pas des"
	cont "engins de guerre."
else
	text "ELDER: You are in-"
	line "deed skilled as a"
	cont "trainer."

	para "As promised, here"
	line "is your HM."

	para "But let me say"
	line "this: You should"

	para "treat your"
	line "#MON better."

	para "The way you battle"
	line "is far too harsh."

	para "#MON are not"
	line "tools of war…"
endc

	done

SproutTowerRivalOnlyCareAboutStrongText: 
if DEF(_FR_FR)
	text "..."
	line "...Pfeuh!"

	para "On l'appelle"
	line "l'ANCIEN mais il"
	cont "est super nul!"

	para "Et il raconte"
	line "n'importe quoi..."

	para "Je ne me ferai"
	line "jamais battre par"

	para "un crétin qui"
	line "conseille d'être"

	para "gentil avec les"
	line "#MON."

	para "Seuls les #MON"
	line "puissants sont"
	cont "importants."

	para "Je me contrefiche"
	line "des #MON mi-"
	cont "gnons et faibles."
else
	text "…"
	line "…Humph!"

	para "He claims to be"
	line "the ELDER but"
	cont "he's weak."

	para "It stands to"
	line "reason."

	para "I'd never lose to"
	line "fools who babble"

	para "about being nice"
	line "to #MON."

	para "I only care about"
	line "strong #MON"
	cont "that can win."

	para "I really couldn't"
	line "care less about"
	cont "weak #MON."
endc

	done

SproutTowerRivalUsedEscapeRopeText: 
if DEF(_FR_FR)
	text "<RIVAL> utilise"
	line "une CORDE SORTIE!"
else
	text "<RIVAL> used an"
	line "ESCAPE ROPE!"
endc

	done

SageLiSeenText: 
if DEF(_FR_FR)
	text "Bienvenue à toi,"
	line "mon poussin!"

	para "La TOUR CHETIFLOR"
	line "est un lieu"
	cont "d'entraînement."

	para "Humains et #MON"
	line "y renforcent leurs"

	para "liens pour des"
	line "lendemains qui"
	cont "chantent."

	para "Je serai ton"
	line "adversaire final."

	para "Permets-moi de"
	line "mettre à l'épreuve"

	para "ton amitié envers"
	line "tes #MON!"
else
	text "So good of you to"
	line "come here!"

	para "SPROUT TOWER is a"
	line "place of training."

	para "People and #MON"
	line "test their bonds"

	para "to build a bright"
	line "future together."

	para "I am the final"
	line "test."

	para "Allow me to check"
	line "the ties between"

	para "your #MON and"
	line "you!"
endc

	done

SageLiBeatenText: 
if DEF(_FR_FR)
	text "Ah, excellent!"
else
	text "Ah, excellent!"
endc

	done

SageLiTakeThisFlashText: 
if DEF(_FR_FR)
	text "Toi et tes #MON"
	line "méritez bien cette"
	cont "nouvelle capacité."

	para "Prends donc cette"
	line "CS FLASH."
else
	text "You and your #-"
	line "MON should have"

	para "no problem using"
	line "this move."

	para "Take this FLASH"
	line "HM."
endc

	done

SageLiFlashExplanationText:
if DEF(_FR_FR)
	text "Le FLASH illumine"
	line "les endroits les"
	cont "plus sombres."
	
	para "Tu peux t'en servir"
	line "dès à présent."
	
	para "Aucun BADGE n'est"
	line "requis pour"
	cont "utiliser les CS."
	
	para "Il suffit de"
	line "posséder la CS,"
	
	para "et de l'enseigner"
	line "à un #MON."
else
	text "FLASH illuminates"
	line "even the darkest"
	cont "of all places."

	para "You can use it"
	line "right away."
	
	para "No BADGE is"
	line "required to"
	cont "use HMs."

	para "You only need to"
	line "own the HM,"

	para "and teach it"
	line "to a #MON."
endc
	done

SageLiAfterBattleText: 
if DEF(_FR_FR)
	text "Va, vole et"
	line "apprends la vie"
	cont "grâce aux #MON."
else
	text "I hope you learn"
	line "and grow from your"
	cont "journey."
endc

	done

SageJinSeenText: 
if DEF(_FR_FR)
	text "Je m'entraîne pour"
	line "trouver la voie du"
	cont "#MON!"
else
	text "I train to find"
	line "enlightenment in"
	cont "#MON!"
endc

	done

SageJinBeatenText: 
if DEF(_FR_FR)
	text "Mon entraînement"
	line "est insuffisant."
else
	text "My training is"
	line "incomplete…"
endc

	done

SageJinAfterBattleText: 
if DEF(_FR_FR)
	text "Quand un #MON"
	line "gagne en puissance"
	cont "son dresseur"
	cont "devient plus fort."

	para "Non, attends..."
	line "C'est le contraire"

	para "je crois..."
	line "Je sais plus."
else
	text "As #MON grow"
	line "stronger, so does"
	cont "the trainer."

	para "No, wait. As the"
	line "trainer grows"

	para "stronger, so do"
	line "the #MON."
endc

	done

SageTroySeenText: 
if DEF(_FR_FR)
	text "Montre-moi à quel"
	line "point tu fais"
	cont "confiance à tes"
	cont "#MON."
else
	text "Let me see how"
	line "much you trust"
	cont "your #MON."
endc

	done

SageTroyBeatenText: 
if DEF(_FR_FR)
	text "Ta confiance est"
	line "totale! Bien!"
else
	text "Yes, your trust is"
	line "real!"
endc

	done

SageTroyAfterBattleText: 
if DEF(_FR_FR)
	text "L'ANCIEN n'est"
	line "plus très loin."
else
	text "It is not far to"
	line "the ELDER."
endc

	done

SageNealSeenText: 
if DEF(_FR_FR)
	text "La CS de l'ANCIEN"
	line "éclaire même les"
	cont "sombres cavernes."
else
	text "The ELDER's HM"
	line "lights even pitch-"
	cont "black darkness."
endc

	done

SageNealBeatenText: 
if DEF(_FR_FR)
	text "J'en ai pris plein"
	line "la tête!"
else
	text "It is my head that"
	line "is bright!"
endc

	done

SageNealAfterBattleText: 
if DEF(_FR_FR)
	text "Que ta voie soit"
	line "douce et claire."
else
	text "Let there be light"
	line "on your journey."
endc

	done

SproutTower3FPaintingText: 
if DEF(_FR_FR)
	text "Une belle peinture"
	line "d'un majestueux"
	cont "CHETIFLOR."
else
	text "It's a powerful"
	line "painting of a"
	cont "BELLSPROUT."
endc

	done

SproutTower3FStatueText: 
if DEF(_FR_FR)
	text "Une statue de"
	line "#MON..."

	para "Ca a l'air cher"
	line "et raffiné."
else
	text "A #MON statue…"

	para "It looks very"
	line "distinguished."
endc

	done

SproutTower3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 10, 14, SPROUT_TOWER_2F, 4

	def_coord_events
	coord_event 11,  9, CE_EVENT_FLAG_CLEARED, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2, SproutTower3FRivalScene

	def_bg_events
	bg_event  8,  1, BGEVENT_READ, SproutTower3FStatue
	bg_event 11,  1, BGEVENT_READ, SproutTower3FStatue
	bg_event  9,  0, BGEVENT_READ, SproutTower3FPainting
	bg_event 10,  0, BGEVENT_READ, SproutTower3FPainting
	bg_event  5, 15, BGEVENT_READ, SproutTower3FStatue
	bg_event 14, 15, BGEVENT_READ, SproutTower3FStatue

	def_object_events
	object_event  8,  8, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerSageTroy, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  8, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSageJin, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 10,  2, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SageLiScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 11, 11, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSageNeal, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower3FPotion, EVENT_SPROUT_TOWER_3F_POTION
	object_event 14,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower3FEscapeRope, EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE
	object_event 10,  4, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
