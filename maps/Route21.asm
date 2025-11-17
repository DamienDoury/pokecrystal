	object_const_def
	const ROUTE21_SWIMMER_GIRL_NIKKI
	const ROUTE21_SWIMMER_GIRL_CHELAN
	const ROUTE21_SWIMMER_GIRL_LULU
	const ROUTE21_FISHER_ARNOLD
	const ROUTE21_FISHER_WADE
	const ROUTE21_FISHER_SKOVORODA
	const ROUTE21_FISHER_MURPHY
	const ROUTE21_SWIMMER_GUY_SETH
	const ROUTE21_SWIMMER_GUY_ESTEBAN
	const ROUTE21_SWIMMER_GUY_TYSON
	const ROUTE21_SWIMMER_GUY_DUANE
	const ROUTE21_BIRDKEEPER_GIDEON
	const ROUTE21_BIRDKEEPER_EASTON
	const ROUTE21_BIRDKEEPER_LEON

Route21_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RaveParty

.RaveParty:
	farscall RavePartyFlag
	endcallback

TrainerSwimmerfNikki:
	trainer SWIMMERF, NIKKI, EVENT_BEAT_SWIMMERF_NIKKI, SwimmerfNikkiSeenText, SwimmerfNikkiBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfNikkiAfterBattleText

TrainerSwimmerfChelan:
	trainer SWIMMERF, CHELAN, EVENT_BEAT_SWIMMERF_CHELAN, SwimmerfChelanSeenText, SwimmerfChelanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfChelanAfterBattleText

TrainerSwimmerfLulu:
	trainer SWIMMERF, LULU, EVENT_BEAT_SWIMMERF_LULU, SwimmerfLuluSeenText, SwimmerfLuluBeatenText, 0, .Script

.Script:
	loadmem wMap3ObjectMovement, SPRITEMOVEDATA_SPINRANDOM_SLOW
	applymovement ROUTE21_SWIMMER_GIRL_LULU, Route21_SleepMovement
	endifjustbattled
	jumptextfaceplayer SwimmerfLuluAfterBattleText

TrainerFisherArnold:
	trainer FISHER, ARNOLD, EVENT_BEAT_FISHER_ARNOLD, FisherArnoldSeenText, FisherArnoldBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherArnoldAfterBattleText

TrainerFisherWade:
	trainer FISHER, WADE, EVENT_BEAT_FISHER_WADE, FisherWadeSeenText, FisherWadeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherWadeAfterBattleText

TrainerFisherSkovoroda:
	trainer FISHER, SKOVORODA, EVENT_BEAT_FISHER_SKOVORODA, FisherSkovorodaSeenText, FisherSkovorodaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherSkovorodaAfterBattleText

TrainerFisherMurphy:
	trainer FISHER, MURPHY, EVENT_BEAT_FISHER_MURPHY, FisherMurphyBattleText, FisherMurphyBattleText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherMurphyBattleText

TrainerSwimmermSeth:
	trainer SWIMMERM, SETH, EVENT_BEAT_SWIMMERM_SETH, SwimmermSethSeenText, SwimmermSethBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermSethAfterBattleText

TrainerSwimmermEsteban:
	trainer SWIMMERM, ESTEBAN, EVENT_BEAT_SWIMMERM_ESTEBAN, SwimmermEstebanSeenText, SwimmermEstebanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermEstebanAfterBattleText

TrainerSwimmermTyson:
	trainer SWIMMERM, TYSON, EVENT_BEAT_SWIMMERM_TYSON, SwimmermTysonSeenText, SwimmermTysonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermTysonAfterBattleText

TrainerSwimmermDuane:
	trainer SWIMMERM, DUANE, EVENT_BEAT_SWIMMERM_DUANE, SwimmermDuaneSeenText, SwimmermDuaneBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermDuaneAfterBattleText

TrainerBirdKeeperGideon:
	trainer BIRD_KEEPER, GIDEON, EVENT_BEAT_BIRDKEEPER_GIDEON, BirdKeeperGideonSeenText, BirdKeeperGideonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperGideonAfterBattleText

TrainerBirdKeeperEaston:
	trainer BIRD_KEEPER, EASTON, EVENT_BEAT_BIRDKEEPER_EASTON, BirdKeeperEastonSeenText, BirdKeeperEastonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperEastonAfterBattleText

TrainerBirdKeeperLeon:
	trainer BIRD_KEEPER, LEON, EVENT_BEAT_BIRDKEEPER_LEON, BirdKeeperLeonSeenText, BirdKeeperLeonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperLeonAfterBattleText

Route21_SleepMovement:
	step_sleep 1
	step_end

SwimmermSethSeenText: 
if DEF(_FR_FR)
	text "Haahahahahhaa!"
	line "C'est la fête!"
else
	text "Land ho! Gotta"
	line "keep going!"
endc

	done

SwimmermSethBeatenText: 
if DEF(_FR_FR)
	text "Glug..."
else
	text "Glug…"
endc

	done

SwimmermSethAfterBattleText: 
if DEF(_FR_FR)
	text "Moi j'aime la"
	line "fête! Yahahahaha!"
	cont "J'suis ouf."
else
	text "This arrogant guy"
	line "was at CINNABAR's"
	cont "volcano."
endc

	done

SwimmermDuaneSeenText:
if DEF(_FR_FR)
	text "Mate mon #MON"
	line "rare!"
else
	text "Check out my rare"
	line "#MON!"
endc
	done

SwimmermDuaneBeatenText:
if DEF(_FR_FR)
	text "T'en penses quoi?"
else
	text "Impressed?"
endc
	done

SwimmermDuaneAfterBattleText:
if DEF(_FR_FR)
	text "Le volcan a rejeté"
	line "des fossiles venus"
	cont "du fond de l'océan."
else
	text "The volcano spat"
	line "some fossils from"
	
	para "the bottom of the"
	line "ocean."
endc
	done

SwimmermTysonSeenText:
if DEF(_FR_FR)
	text "J'étais un sportif"
	line "de haut niveau"
	cont "autrefois..."
else
	text "I used to be"
	line "an athlete…"
endc
	done

SwimmermTysonBeatenText:
if DEF(_FR_FR)
	text "Je me suis"
	line "ramolli..."
else
	text "I got soft…"
endc
	done

SwimmermTysonAfterBattleText:
if DEF(_FR_FR)
	text "Impossible de"
	line "s'entraîner pendant"
	cont "la pandémie."
	
	para "Maintenant je dois"
	line "m'entraîner deux"
	cont "fois plus."
else
	text "I couldn't train"
	line "during the"
	cont "pandemic."

	para "Now I'm training"
	line "twice as much."
endc
	done

SwimmermEstebanSeenText:
if DEF(_FR_FR)
	text "Avant j'étais"
	line "SCIENTIFIQUE au"
	cont "LABO #MON de"
	cont "CRAMOIS'ILE."
else
	text "I used to be a"
	line "SCIENTIST at the"
	cont "CINNABAR LAB."
endc
	done

SwimmermEstebanBeatenText:
if DEF(_FR_FR)
	text "J'ai apprécié ce"
	line "combat. Merci!"
else
	text "I enjoyed this"
	line "battle. Thanks!"
endc
	done

SwimmermEstebanAfterBattleText:
if DEF(_FR_FR)
	text "Mes collègues ont"
	line "été mutés vers"
	cont "d'autres sites"
	cont "après l'éruption."
	
	para "La plupart sont à"
	line "SAFRANIA."
else
	text "My colleagues were"
	line "assigned to other"
	cont "workplaces after"
	cont "the eruption."

	para "Most of them in"
	line "SAFFRON CITY."
endc
	done

SwimmerfNikkiSeenText: 
if DEF(_FR_FR)
	text "Si je gagne, tu me"
	line "passes de la"
	cont "crème!"
else
	text "If I win, you have"
	line "to help me with my"
	cont "suntan lotion!"
endc

	done

SwimmerfNikkiBeatenText: 
if DEF(_FR_FR)
	text "Les coups de"
	line "soleil c'est mal."
else
	text "I'm worried about"
	line "sunburn…"
endc

	done

SwimmerfNikkiAfterBattleText:
if DEF(_FR_FR)
	text "Le jour où le"
	line "volcan de CRAMOIS'"
	cont "ILE est entré en"
	cont "éruption,"
	
	para "j'ai vu un #MON"
	line "volant majestueux"
	cont "de couleur bleu"
	cont "voler par dessus"
	cont "ma tête, venant"
	
	para "en ligne droite"
	line "depuis les ILES"
	cont "ECUME."
else
	text "The day CINNABAR's"
	line "volcano erupted,"

	para "I saw a majestic"
	line "blue bird #MON"

	para "fly over my head"
	line "in a straight line"
	
	para "coming from"
	line "SEAFOAM ISLANDS."
endc
	done

SwimmerfChelanSeenText:
if DEF(_FR_FR)
	text "Toi aussi tu viens"
	line "pour ça?"
else
	text "Are you also"
	line "coming for it?"
endc
	done

SwimmerfChelanBeatenText:
if DEF(_FR_FR)
	text "Allez, t'es pas"
	line "drôle."
else
	text "Come on, you're"
	line "no fun."
endc
	done

SwimmerfChelanAfterBattleText:
if DEF(_FR_FR)
	text "J'ai hâte. Tu vois"
	line "de quoi je parle,"
	cont "n'est-ce pas?"
	
	para "Je crois que ça"
	line "commence à 21h."
	
	para "Mais quel jour de"
	line "la semaine déjà?"
else
	text "I'm waiting for it."
	line "You know, right?"

	para "I recall it starts"
	line "at 9 PM. But on"
	cont "what day?"
endc
	done

SwimmerfLuluSeenText:
if DEF(_FR_FR)
	text "Qui aurait cru que"
	line "je deviendrais une"
	cont "aussi bonne"
	cont "NAGEUSE?!"
else
	text "Who knew I could"
	line "become such a"
	cont "good SWIMMER?!"
endc
	done

SwimmerfLuluBeatenText:
if DEF(_FR_FR)
	text "La chance n'était"
	line "pas de mon côté."
else
	text "I'll have better"
	line "luck next time…"
endc
	done

SwimmerfLuluAfterBattleText:
if DEF(_FR_FR)
	text "Je n'avais jamais"
	line "essayé de nager"
	cont "quand j'étais"
	cont "plus jeune."
	
	para "Mais c'est génial!"
	
	para "J'aurais dû"
	line "essayer plus tôt!"

	para "Enfin bon c'est pas"
	line "tout, mais j'ai"
	cont "rdv au CASINO."
else
	text "I never tried"
	line "swimming when I"
	cont "was younger."

	para "It's such a blast!"

	para "I should've tried"
	line "sooner!"
endc
	done

FisherArnoldSeenText: 
if DEF(_FR_FR)
	text "La pêche c'est"
	line "long. COMBAT!"
else
	text "I'm bored by fish-"
	line "ing. Let's battle!"
endc

	done

FisherArnoldBeatenText: 
if DEF(_FR_FR)
	text "Tout perdu..."
else
	text "Utter failure…"
endc

	done

FisherArnoldAfterBattleText: 
if DEF(_FR_FR)
	text "J'vais pêcher"
	line "plutôt..."
else
	text "I'll just go back"
	line "to fishing…"
endc

	done

FisherWadeSeenText:
if DEF(_FR_FR)
	text "J'ai eu une bonne"
	line "prise! Tu veux"
	cont "tester?"
else
	text "I got a big haul!"
	line "Wanna go for it?"
endc
	done

FisherWadeBeatenText:
if DEF(_FR_FR)
	text "Zut! Encore un"
	line "MAGICARPE!"
else
	text "Darn MAGIKARP!"
endc
	done

FisherWadeAfterBattleText:
if DEF(_FR_FR)
	text "J'ai l'impression"
	line "de n'attraper que"
	cont "des MAGICARPE!"
else
	text "I seem to only"
	line "catch MAGIKARP!"
endc
	done

FisherMurphyBattleText:
if DEF(_FR_FR)
	text "Je m'appelle"
	line "MURPHY!"
else
	text "Hi, my name is"
	line "MURPHY!"
endc
	done

FisherSkovorodaSeenText:
if DEF(_FR_FR)
	text "Avant je perdais"
	line "souvent mes"
	cont "combats."
	
	para "Mais ça ne m'a"
	line "jamais découragé."
else
	text "I used to lose"
	line "all battles."

	para "But it didn't"
	line "discourage me."
endc
	done

FisherSkovorodaBeatenText:
if DEF(_FR_FR)
	text "Bien joué! J'ai"
	line "beaucoup appris."
else
	text "Well played!"
	line "I learned a lot."
endc
	done

FisherSkovorodaAfterBattleText:
if DEF(_FR_FR)
	text "La victoire vient"
	line "à ceux qui"
	cont "persévèrent."
	
	para "Attendre qu'elle"
	line "vienne d'elle-même"
	cont "ne sert à rien."
	
	para "Sauf quand on"
	line "pêche."
else
	text "Victory comes"
	line "to those who"
	cont "persevere."

	para "Waiting for vic-"
	line "tory to happen"
	cont "is useless."

	para "Except when"
	line "fishing."
endc
	done

BirdKeeperGideonSeenText:
if DEF(_FR_FR)
	text "Regarder mes"
	line "#MON voler en"
	cont "rond me donne"
	cont "le tournis."
	
	para "Je dois fixer un"
	line "point immobile."
	cont "Ce sera toi."
else
	text "Looking at my"
	line "#MON flying"
	cont "in circles is"
	cont "making me dizzy."

	para "I need to focus my"
	line "gaze on a fixed"
	cont "point."
	cont "It'll be you."
endc
	done

BirdKeeperGideonBeatenText:
if DEF(_FR_FR)
	text "J'ai encore plus"
	line "le tournis."
else
	text "I'm feeling even"
	line "more dizzy now."
endc
	done

BirdKeeperGideonAfterBattleText:
if DEF(_FR_FR)
	text "Le ciel est si"
	line "beau ici."
	
	para "Il m'avait manqué"
	line "pendant le"
	cont "confinement."
else
	text "The sky is so"
	line "beautiful here."

	para "I missed it during"
	line "the lockdown."
endc
	done

BirdKeeperEastonSeenText:
if DEF(_FR_FR)
	text "Voler dans le ciel"
	line "bleu, c'est le"
	cont "symbole de la"
	cont "liberté pour moi."
	
	para "Mais c'est aussi"
	line "dangereux."
else
	text "Flying in the"
	line "blue sky is"
	cont "freedom to me."

	para "But it's dangerous."
endc
	done

BirdKeeperEastonBeatenText:
if DEF(_FR_FR)
	text "La vie continue."
else
	text "Life goes on."
endc
	done

BirdKeeperEastonAfterBattleText:
if DEF(_FR_FR)
	text "La sécurité vaut-"
	line "elle qu'on sacri-"
	cont "fie la liberté?"
else
	text "Is security worth"
	line "sacrificing"
	cont "freedom?"
endc
	done

BirdKeeperLeonSeenText:
if DEF(_FR_FR)
	text "Je collectionne"
	line "les #MON VOL"
	cont "colorés."
	
	para "J'te montre?"
else
	text "I collect colorful"
	line "FLYING #MON."

	para "Wanna see'em?"
endc
	done

BirdKeeperLeonBeatenText:
if DEF(_FR_FR)
	text "Hmmm... il s'est"
	line "passé quoi?"
else
	text "Hmmm… what"
	line "happened?"
endc
	done

BirdKeeperLeonAfterBattleText:
if DEF(_FR_FR)
	text "S'occuper de tous"
	line "mes #MON VOL,"
	cont "c'est du boulot."
	
	para "Mais voir toutes"
	line "ces couleurs vire-"
	cont "volter, ça en vaut"
	cont "la peine."
	cont "Olé ben beau!"
else
	text "Taking care of all"
	line "my FLYING #MON"
	cont "is hard work."

	para "But looking at all"
	line "these colors fly-"
	cont "ing around makes"
	cont "it worth it!"
endc
	done

Route21_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11, 16, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfNikki, -1
	object_event 11, 84, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfChelan, EVENT_CINNABAR_RAVE_PARTY
	object_event 14, 66, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 1, 4, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfLulu, -1
	object_event 14, 60, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerFisherArnold, -1
	object_event  6, 27, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFisherWade, -1
	object_event  4, 26, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerFisherSkovoroda, -1
	object_event  8,  9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerFisherMurphy, -1
	object_event  1, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermSeth, -1
	object_event 14, 29, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerSwimmermEsteban, -1
	object_event  6, 45, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerSwimmermTyson, -1
	object_event  7, 49, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerSwimmermDuane, -1
	object_event 10,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperGideon, -1
	object_event  7, 26, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerBirdKeeperEaston, -1
	object_event 15, 61, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperLeon, -1
