	object_const_def
	const CIANWOODGYM_CHUCK
	const CIANWOODGYM_BLACK_BELT1
	const CIANWOODGYM_BLACK_BELT2
	const CIANWOODGYM_BLACK_BELT3
	const CIANWOODGYM_BLACK_BELT4
	const CIANWOODGYM_BOULDER1
	const CIANWOODGYM_BOULDER2
	const CIANWOODGYM_BOULDER3
	const CIANWOODGYM_BOULDER4
	const CIANWOODGYM_BOULDER5
	const CIANWOODGYM_BOULDER6
	const CIANWOODGYM_GYM_GUIDE

CianwoodGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_CHUCK
	iftrue .no_check
	
	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall CianwoodGymCheckForbiddenTypes
	iffalse .enter_check

	callstd GymKickPlayerOutAfterEvolution
	sjump .player_leaves

.enter_check
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .no_check
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	setval EGG
	special FindPartyMonThatSpecies
	iftrue .egg_found

	scall CianwoodGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked CIANWOODGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	writetext CianwoodGymGuideEggText
	waitbutton
	closetext
	
	sjump .player_leaves

.do_check
	setlasttalked CIANWOODGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp CIANWOOD_CITY, 8, 43
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

CianwoodGymCheckForbiddenTypes:
	setval FLYING
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval PSYCHIC_TYPE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval GHOST
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

CianwoodGymChuckScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .AlreadyGotTM
	writetext ChuckIntroText1

	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, CIANWOODGYM_CHUCK, 20
	opentext
	writetext CianwoodGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext ChuckIntroSequelText

	waitbutton
	closetext
	turnobject CIANWOODGYM_CHUCK, RIGHT
	opentext
	writetext ChuckIntroText2
	waitbutton
	closetext
	applymovement CIANWOODGYM_BOULDER1, CianwoodGymMovement_ChuckChucksBoulder
	playsound SFX_STRENGTH
	earthquake 80
	disappear CIANWOODGYM_BOULDER1
	pause 30
	faceplayer
	opentext
	writetext ChuckIntroText3
	waitbutton
	closetext
	winlosstext ChuckLossText, 0
	loadtrainer CHUCK, CHUCK1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CHUCK
	opentext
	writetext GetStormBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	readmem wYearMonth
	addval 1
	writemem wYearMonth
	setflag ENGINE_STORMBADGE
	setevent EVENT_BEAT_BLACKBELT_YOSHI
	setevent EVENT_BEAT_BLACKBELT_LAO
	setevent EVENT_BEAT_BLACKBELT_NOB
	setevent EVENT_BEAT_BLACKBELT_LUNG
	writetext ChuckExplainBadgeText
	promptbutton
	farscall NewBadgeObedienceNotification
	writetext ChuckExplainBadgeText2
	promptbutton
	verbosegiveitem TM_DYNAMICPUNCH
	writetext ChuckExplainTMText
	waitbutton
	closetext
	end

.AlreadyGotTM:
	writetext ChuckAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltYoshi:
	trainer BLACKBELT_T, YOSHI, EVENT_BEAT_BLACKBELT_YOSHI, BlackbeltYoshiSeenText, BlackbeltYoshiBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BlackbeltYoshiAfterText

TrainerBlackbeltLao:
	trainer BLACKBELT_T, LAO, EVENT_BEAT_BLACKBELT_LAO, BlackbeltLaoSeenText, BlackbeltLaoBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BlackbeltLaoAfterText

TrainerBlackbeltNob:
	trainer BLACKBELT_T, NOB, EVENT_BEAT_BLACKBELT_NOB, BlackbeltNobSeenText, BlackbeltNobBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BlackbeltNobAfterText

TrainerBlackbeltLung:
	trainer BLACKBELT_T, LUNG, EVENT_BEAT_BLACKBELT_LUNG, BlackbeltLungSeenText, BlackbeltLungBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BlackbeltLungAfterText

CianwoodGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .CianwoodGymGuideWinScript
	writetext CianwoodGymGuideText
	waitbutton
	closetext
	end

.CianwoodGymGuideWinScript:
	writetext CianwoodGymGuideWinText
	waitbutton
	closetext
	end

CianwoodGymBoulder:
	jumpstd StrengthBoulderScript

CianwoodGymStatue:
	checkflag ENGINE_STORMBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, CHUCK, CHUCK1
	jumpstd GymStatue2Script

CianwoodGymMovement_ChuckChucksBoulder:
	set_sliding
	big_step LEFT
	big_step UP
	fast_jump_step RIGHT
	remove_sliding
	step_end

ChuckIntroText1:
if DEF(_FR_FR)
	text "WAHAHAH!"

	para "Alors te voilà"
	line "ici!"
	done
else
	text "WAHAHAH!"

	para "So you've come"
	line "this far!"
	done
endc

ChuckIntroSequelText:
if DEF(_FR_FR)
	text "Laisse-moi te dire"
	line "que je suis une"
	cont "bête!"

	para "Mes #MON"
	line "explosent la roche"
	cont "et fracassent les"
	cont "os!"

	para "Regarde ça!"
	done
else
	text "Let me tell you,"
	line "I'm tough!"

	para "My #MON will"
	line "crush stones and"
	cont "shatter bones!"

	para "Watch this!"
	done
endc

ChuckIntroText2: 
if DEF(_FR_FR)
	text "CHUCK: Blurrp!"
	line "............."

	para "Aaaarrgh!"
else
	text "CHUCK: Urggh!"
	line "…"

	para "Oooarrgh!"
endc

	done

CianwoodGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

ChuckIntroText3:
if DEF(_FR_FR)
	text "Alors t'as peur ou"
	line "faut crier plus"
	cont "fort?"

	para "De quoi?"
	line "Ca n'a rien à voir"

	para "avec les #MON?"
	line "Je sais!"

	para "C'est une affaire"
	line "de force propre."

	para "Un dresseur"
	line "solide doit"
	cont "comprendre ça."

	para "C'est pourquoi"
	line "on va se battre"
	cont "un contre un."

	para "Interdit de chan-"
	line "ger de #MON."

	para "Voyons jusqu'où"
	line "tu pousses tes"
	cont "#MON..."

	para "On y va!"
	done
else
	text "There! Scared now,"
	line "are you?"

	para "What?"
	line "It has nothing to"

	para "do with #MON?"
	line "That's true!"

	para "It's about one's"
	line "own strength."

	para "A strong trainer"
	line "must understand"
	cont "this. That's why"

	para "we're going to"
	line "fight one on one."

	para "I forbid you from"
	line "switching out."

	para "We'll see how far"
	line "you can push your"
	cont "#MON…"

	para "Let's do this!"
	done
endc

ChuckLossText: 
if DEF(_FR_FR)
	text "Hein? Koi? Méheeuu"
	line "j'ai pas gagné là?"

	para "A propos, je peux"
	line "te dire un truc?"
	cont "Je pense que tu"
	cont "mérites le bon"
	cont "vieux BADGE CHOC!"
else
	text "Wha? Huh?"
	line "I lost?"

	para "How about that!"
	line "You're worthy of"
	cont "STORMBADGE!"
endc

	done

GetStormBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE CHOC."
else
	text "<PLAYER> received"
	line "STORMBADGE."
endc

	done

ChuckExplainBadgeText:
if DEF(_FR_FR)
	text "Le BADGE CHOC"
	line "est remis"

	para "aux dresseurs"
	line "les plus solides."
	done
else
	text "STORMBADGE is"
	line "only given to"

	para "the toughest"
	line "of trainers."
	done
endc

ChuckExplainBadgeText2:
if DEF(_FR_FR)
	text "Tiens, attrapes"
	line "ça aussi!"
	done
else
	text "Here, take this"
	line "too!"
	done
endc

Obey40:
if DEF(_FR_FR)
	text "Ce 3e badge fait"
	line "obéir les"

	para "#MON échangés"
	line "jusqu'au niveau 40."
	done
else
	text "This third badge"
	line "lets all traded"

	para "#MON up to L40"
	line "obey."
	done
endc

Obey60:
if DEF(_FR_FR)
	text "Le 7e badge que tu"
	line "viens de gagner"
	cont "fait obéir tes"

	para "#MON tant"
	line "qu'ils sont sous"
	cont "le niveau 60."
	done
else
	text "The seventh badge"
	line "you just earned"
	cont "make #MON obey"
	
	para "as long as they"
	line "are under L60."
	done
endc

ChuckExplainTMText: 
if DEF(_FR_FR)
	text "C'est DYNAMOPOING."

	para "Ca ne touche pas"
	line "toujours mais"

	para "lorsque le coup"
	line "est porté, il"
	cont "entraîne la confu-"
	cont "sion!"
else
	text "That is DYNAMIC-"
	line "PUNCH."

	para "It doesn't always"
	line "hit, but when it"

	para "does, it causes"
	line "confusion!"
endc

	done

ChuckAfterText: 
if DEF(_FR_FR)
	text "WAHAHAH! J'ai aimé"
	line "me battre contre"
	cont "toi!"

	para "Mais une défaite"
	line "signifie le plus"
	cont "souvent qu'on a"
	cont "perdu!"

	para "Donc dorénavant je"
	line "vais m'entraîner"
	cont "24 heures sur 24!"
else
	text "WAHAHAH! I enjoyed"
	line "battling you!"

	para "But a loss is a"
	line "loss!"

	para "From now on, I'm"
	line "going to train 24"
	cont "hours a day!"
endc

	done

BlackbeltYoshiSeenText:
if DEF(_FR_FR)
	text "Sais-tu ce que"
	line "c'est la force?"
	done
else
	text "Do you know what"
	line "toughness is?"
	done
endc

BlackbeltYoshiBeatenText:
if DEF(_FR_FR)
	text "La force c'est"
	line "ne pas avoir peur."
	done
else
	text "Toughness is not"
	line "being afraid."
	done
endc

BlackbeltYoshiAfterText:
if DEF(_FR_FR)
	text "Je n'ai pas peur"
	line "du COVID!"
	
	para "Je suis super"
	line "fort!"
	done
else
	text "I'm not afraid of"
	line "COVID!"
	
	para "I'm super tough!"
	done
endc

BlackbeltLaoSeenText:
if DEF(_FR_FR)
	text "Si utiliser une CT"
	line "rendait des PP,"
	
	para "je pourrais me"
	line "battre toute la"
	cont "journée!"
	done
else
	text "If using a TM"
	line "replenished PPs,"
	
	para "I would be able to"
	line "fight all day!"
	done
endc

BlackbeltLaoBeatenText:
if DEF(_FR_FR)
	text "Assez pour"
	line "aujourd'hui."
	done
else
	text "Enough for today."
	done
endc

BlackbeltLaoAfterText:
if DEF(_FR_FR)
	text "Imagine t'as 2 CT"
	line "et tu les apprends"
	
	para "en boucle à tes"
	line "#MON."
	
	para "Tu finirais avec"
	line "une réserve"
	
	para "illimitée de PP,"
	line "si les CT les"
	cont "rechargeaient."
	
	para "Ce serait beaucoup"
	line "trop puissant."
	done
else
	text "Can you imagine"
	line "having 2 TMs and"
	
	para "teaching those to"
	line "your #MON in a"
	cont "loop?"
	
	para "You would end up"
	line "with an infinite"
	
	para "sustain of PP if"
	line "they were"
	cont "replenished."
	
	para "That would be"
	line "overpowered."
	done
endc

BlackbeltNobSeenText: 
if DEF(_FR_FR)
	text "Je ne parle pas la"
	line "bouche pleine"
	cont "sinon ça fait"
	cont "heu-gneu-gneu-heu."
	cont "Alors je me sers"
	cont "de mes poings!"
else
	text "Words are useless."
	line "Let your fists do"
	cont "the talking!"
endc

	done

BlackbeltNobBeatenText:
	text "…"
	done

BlackbeltNobAfterText: 
if DEF(_FR_FR)
	text "Hein? J'ai perdu!"
	line "J'sais pas quoi"
	cont "dire!"
else
	text "I lost! "
	line "I'm speechless!"
endc

	done

BlackbeltLungSeenText: 
if DEF(_FR_FR)
	text "Mes poings de ouf"
	line "vont terrasser tes"
	cont "#MON!"
else
	text "My raging fists"
	line "will shatter your"
	cont "#MON!"
endc

	done

BlackbeltLungBeatenText: 
if DEF(_FR_FR)
	text "Bon, je suis nul!"
else
	text "I got shattered!"
endc

	done

BlackbeltLungAfterText: 
if DEF(_FR_FR)
	text "Mes #MON ont"
	line "perdu, ma fierté"
	cont "en a pris un coup!"
else
	text "My #MON lost…"
	line "My… my pride is"
	cont "shattered…"
endc

	done

CianwoodGymGuideText:
if DEF(_FR_FR)
	text "Yo!"
	
	para "Cette ARENE, c'est"
	line "tout pour le"
	cont "muscle."

	para "En période de"
	line "sèche ou prise"
	cont "de masse."
	
	para "Montre-nous"
	line "un beau combat!"
	done
else
	text "Yo!"

	para "This GYM is all"
	line "about muscles."

	para "Show us a good"
	line "fight!"
	done
endc

CianwoodGymGuideWinText:
if DEF(_FR_FR)
	text "Quel combat!"
	line "C'était épique!"
	
	para "Tu nous as montré"
	line "comment ça s'passe!"
	
	para "Tu soulèves"
	line "au moins?"
	done
else
	text "What a fight!"
	line "That was epic!"
	
	para "You showed us"
	line "how it's done!"

	para "Do you even lift"
	line "bro?"

	done
endc

CianwoodGymGuideEggText:
if DEF(_FR_FR)
	text "HEY YO!"
	
	para "Qu'es'tu viens faire"
	line "avec un OEUF dans"
	cont "c't'ARENE?"
	
	para "Une omelette?"
	
	para "Dégage de ma"
	line "vue, guignol."
	done
else
	text "HEY YO!"
	
	para "What are you gon'"
	line "do with an EGG in"
	cont "this GYM?"
	
	para "An omelette"
	line "du fromage?"
	
	para "Get out of my"
	line "sight, you clown."
	done
endc

CianwoodGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 19, CIANWOOD_CITY, 2
	warp_event  5, 19, CIANWOOD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 17, BGEVENT_READ, CianwoodGymStatue
	bg_event  6, 17, BGEVENT_READ, CianwoodGymStatue

	def_object_events
	object_event  4,  1, SPRITE_CHUCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CianwoodGymChuckScript, -1
	object_event  2, 14, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBlackbeltYoshi, -1
	object_event  7, 14, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBlackbeltLao, -1
	object_event  3, 11, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBlackbeltNob, -1
	object_event  5,  7, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerBlackbeltLung, -1
	object_event  5,  1, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  3,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  4,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  5,  9, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  2,  1, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  6,  1, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  5, 16, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN,  0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymGuideScript, -1
