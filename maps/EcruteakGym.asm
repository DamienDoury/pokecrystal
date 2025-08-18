	object_const_def
	const ECRUTEAKGYM_MORTY
	const ECRUTEAKGYM_SAGE1
	const ECRUTEAKGYM_SAGE2
	const ECRUTEAKGYM_GRANNY1
	const ECRUTEAKGYM_GRANNY2
	const ECRUTEAKGYM_GYM_GUIDE
	const ECRUTEAKGYM_GRAMPS

EcruteakGym_MapScripts:
	def_scene_scripts
	scene_script .Scene ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.Scene:
	checkevent EVENT_BEAT_MORTY
	iftrue .end

	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall EcruteakGymCheckForbiddenTypes
	iffalse .enter_check

	callstd GymKickPlayerOutAfterEvolution
	sjump .player_leaves

.enter_check
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .end
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	checkevent EVENT_BURNED_TOWER_MORTY
	iftrue .TeamCheck

.ForcedToLeave:
	prioritysjump EcruteakGymClosed
	end

.TeamCheck:
	setval EGG
	special FindPartyMonThatSpecies
	iftrue .egg_found

	scall EcruteakGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked ECRUTEAKGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked ECRUTEAKGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp ECRUTEAK_CITY, 6, 27
.end
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

EcruteakGymCheckForbiddenTypes:
	setval DARK
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

EcruteakGymMortyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .GotShadowBall
	writetext MortyIntroText

	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, ECRUTEAKGYM_MORTY, 20
	opentext
	writetext EcruteakGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext MortyIntroSequelText

	waitbutton
	closetext
	winlosstext MortyWinLossText, 0
	loadtrainer MORTY, MORTY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MORTY
	opentext
	writetext Text_ReceivedFogBadge
	playsound SFX_GET_BADGE
	waitsfx
	readmem wYearMonth
	addval 1
	writemem wYearMonth
	setflag ENGINE_FOGBADGE
	setevent EVENT_RANG_CLEAR_BELL ; This and the 2 following lines will make the Sage take blocks the Tin Tower Entrance permanently IF the player carries the Clear Bell the next time it enters the Tin Tower Entrance. This is vanilla behaviour.
	setevent EVENT_TINTOWER_SAGE_LEFT
	setevent EVENT_TINTOWER_SAGE_RIGHT
	setevent EVENT_BEAT_SAGE_JEFFREY
	setevent EVENT_BEAT_SAGE_PING
	setevent EVENT_BEAT_MEDIUM_MARTHA
	setevent EVENT_BEAT_MEDIUM_GRACE
	writetext MortyText_FogBadgeSpeech
	promptbutton
	farscall NewBadgeObedienceNotification
	writetext MortyText_FogBadgeSpeech2
	promptbutton
	verbosegiveitem TM_SHADOW_BALL
	writetext MortyText_ShadowBallSpeech
	waitbutton
	closetext
	end

.GotShadowBall:
	writetext MortyFightDoneText
	waitbutton
	closetext
	end

EcruteakGymClosed:
	applymovement PLAYER, EcruteakGymPlayerStepUpMovement
	opentext
	writetext EcruteakGymClosedText
	waitbutton
	closetext
	applymovement ECRUTEAKGYM_GRAMPS, EcruteakGymGrampsSlowStepDownMovement
	follow PLAYER, ECRUTEAKGYM_GRAMPS
	applymovement PLAYER, EcruteakGymPlayerSlowStepDownMovement
	stopfollow
	special FadeOutPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	warp ECRUTEAK_CITY, 6, 27
	end

TrainerSageJeffrey:
	trainer SAGE, JEFFREY, EVENT_BEAT_SAGE_JEFFREY, SageJeffreySeenText, SageJeffreyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SageJeffreyAfterBattleText

TrainerSagePing:
	trainer SAGE, PING, EVENT_BEAT_SAGE_PING, SagePingSeenText, SagePingBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SagePingAfterBattleText

TrainerMediumMartha:
	trainer MEDIUM, MARTHA, EVENT_BEAT_MEDIUM_MARTHA, MediumMarthaSeenText, MediumMarthaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer MediumMarthaAfterBattleText

TrainerMediumGrace:
	trainer MEDIUM, GRACE, EVENT_BEAT_MEDIUM_GRACE, MediumGraceSeenText, MediumGraceBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer MediumGraceAfterBattleText

EcruteakGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .EcruteakGymGuideWinScript
	writetext EcruteakGymGuideText
	waitbutton
	closetext
	end

.EcruteakGymGuideWinScript:
	writetext EcruteakGymGuideWinText
	waitbutton
	closetext
	end

EcruteakGymStatue:
	checkflag ENGINE_FOGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, MORTY, MORTY1
	jumpstd GymStatue2Script

EcruteakGymPlayerStepUpMovement:
	step UP
	step_end

EcruteakGymPlayerSlowStepDownMovement:
	fix_facing
	slow_step DOWN
	remove_fixed_facing
	step_end

EcruteakGymGrampsSlowStepDownMovement:
	slow_step DOWN
	step_end

MortyIntroText:
if DEF(_FR_FR)
	text "Bienvenue."
else
	text "Good of you to"
	line "have come."
endc
	done

MortyIntroSequelText:
if DEF(_FR_FR)
	text "Ici à ROSALIA,"
	line "les #MON sont"
	cont "vénérés."

	para "On dit qu'un"
	line "#MON aux cou-"

	para "leurs de l'arc-en-"
	line "ciel apparaîtra"

	para "face à un dresseur"
	line "d'exception."

	para "C'est pourquoi je"
	line "m'entraîne à fond"
	cont "les bananes."

	para "Je peux voir ce"
	line "que d'autres ne"
	cont "voient pas."

	para "En cet instant,"
	line "je veux voir"
	cont "comment tes"
	cont "#MON réagiront"
	cont "face à la peur."

	para "Seuls les #MON"
	line "de type SPECTRE"
	cont "peuvent voir à"
	cont "travers l'obs-"
	cont "curité de cette"
	cont "effrayante ARENE."

	para "Voyons à quel"
	line "point ton esprit"
	cont "est puissant."
else
	text "Here in ECRUTEAK,"
	line "#MON have been"
	cont "revered."

	para "It's said that a"
	line "rainbow-colored"

	para "#MON will come"
	line "down to appear"

	para "before a truly"
	line "powerful trainer."

	para "I believed that"
	line "tale, so I have"

	para "secretly trained"
	line "here all my life."

	para "At this moment"
	line "I want to see how"
	cont "your #MON will"
	cont "react to fear."

	para "Only GHOST type"
	line "#MON can see"
	cont "through the dark-"
	cont "ness of this"
	cont "spooky GYM."

	para "Let's see how"
	line "powerful your"
	cont "mind is."
endc
	done

EcruteakGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

MortyWinLossText: 
if DEF(_FR_FR)
	text "Je ne suis pas"
	line "encore assez bon."
	cont "Je ne vois rien."
	cont "Il me faut des"
	cont "lunettes!!"

	para "Bon allez, ce"
	line "BADGE est à toi."
else
	text "I'm not good"
	line "enough yet…"

	para "All right. This"
	line "BADGE is yours."
endc

	done

Text_ReceivedFogBadge: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE BRUME."
else
	text "<PLAYER> received"
	line "FOGBADGE."
endc

	done

MortyText_FogBadgeSpeech:
if DEF(_FR_FR)
	text "En obtenant le"
	line "BADGE BRUME, tu"

	para "as prouvé que"
	line "rien ne t'effraie."
else
	text "By obtaining FOG-"
	line "BADGE, you proved"

	para "nothing can"
	line "scare you."
endc
	done

MortyText_FogBadgeSpeech2:
if DEF(_FR_FR)
	text "Je veux aussi"
	line "te donner ceci."
else
	text "I want you to have"
	line "this too."
endc
	done

Obey50:
if DEF(_FR_FR)
	text "Les #MON éch-"
	line "angés jusqu'au"
	cont "niveau 50"

	para "t'obéiront avec ce"
	line "cinquième badge."
else
	text "Traded #MON up"
	line "to L50 will obey"
	
	para "you with this"
	line "fifth badge."
endc
	done

MortyText_ShadowBallSpeech: 
if DEF(_FR_FR)
	text "C'est BALL'OMBRE."
	line "Elle cause"

	para "des dégâts et peut"
	line "réduire la DEFENSE"
	cont "SPE."

	para "Utilise-la et tu"
	line "verras!"
else
	text "It's SHADOW BALL."
	line "It causes damage"

	para "and may reduce"
	line "SPCL.DEF."

	para "Use it if it"
	line "appeals to you."
endc

	done

MortyFightDoneText: 
if DEF(_FR_FR)
	text "Je vois..."

	para "Ta journée a été"
	line "longue et"
	cont "mouvementée."

	para "Tu as fait plein"
	line "de trucs super"
	cont "géniaux."

	para "Je t'envie pour"
	line "ça..."
else
	text "I see…"

	para "Your journey has"
	line "taken you to far-"
	cont "away places."

	para "And you have wit-"
	line "nessed much more"
	cont "than I."

	para "I envy you for"
	line "that…"
endc

	done

SageJeffreySeenText: 
if DEF(_FR_FR)
	text "J'ai passé tout le"
	line "printemps avec mes"

	para "#MON et puis"
	line "aussi l'été et"
	cont "surtout l'hiver..."

	para "Lorsque le prin-"
	line "temps revint,"

	para "nous avions passé"
	line "de longs moments"
	cont "ensemble."
else
	text "I spent the spring"
	line "with my #MON."

	para "Then summer, fall"
	line "and winter…"

	para "Then spring came"
	line "again. We have"

	para "lived together"
	line "for a long time."
endc

	done

SageJeffreyBeatenText: 
if DEF(_FR_FR)
	text "J'ai appris à"
	line "gagner et à"
	cont "perdre."
else
	text "Wins and losses, I"
	line "experienced both."
endc

	done

SageJeffreyAfterBattleText: 
if DEF(_FR_FR)
	text "D'où viennent les"
	line "#MON?"
else
	text "Where did #MON"
	line "come from?"
endc

	done

SagePingSeenText: 
if DEF(_FR_FR)
	text "Peux-tu infliger"
	line "des dégâts à nos"
	cont "#MON?"
else
	text "Can you inflict"
	line "any damage on our"
	cont "#MON?"
endc

	done

SagePingBeatenText: 
if DEF(_FR_FR)
	text "Ah! Bien joué!"
else
	text "Ah! Well done!"
endc

	done

SagePingAfterBattleText: 
if DEF(_FR_FR)
	text "On n'utilise que"
	line "les #MON de"
	cont "type SPECTRE."

	para "Aucune attaque"
	line "de type NORMAL"
	cont "ne peut les"
	cont "inquiéter!"
else
	text "We use only ghost-"
	line "type #MON."

	para "No normal-type"
	line "attack can harm"
	cont "them!"
endc

	done

MediumMarthaSeenText: 
if DEF(_FR_FR)
	text "Je vais gagner!"
else
	text "I shall win!"
endc

	done

MediumMarthaBeatenText: 
if DEF(_FR_FR)
	text "Et bah non, j'ai"
	line "perdu!"
else
	text "I, I, I lost!"
endc

	done

MediumMarthaAfterBattleText: 
if DEF(_FR_FR)
	text "Celui qui veut et"
	line "bah, il peut!"
else
	text "The one who wants"
	line "to win most--will!"
endc

	done

MediumGraceSeenText: 
if DEF(_FR_FR)
	text "Ah! Ca te fait"
	line "peur le sol"

	para "invisible, hein?"
	line "Tu n'as plus qu'à"
	cont "me battre et je te"
	cont "file un conseil!"
else
	text "Stumped by our in-"
	line "visible floor?"

	para "Defeat me if you"
	line "want a hint!"
endc

	done

MediumGraceBeatenText: 
if DEF(_FR_FR)
	text "Kk-kkoi?"
else
	text "Wha-what?"
endc

	done

MediumGraceAfterBattleText: 
if DEF(_FR_FR)
	text "Très bien. Je vais"
	line "te donner un truc"

	para "à propos du sol"
	line "invisible."

	para "Le bon chemin est"
	line "devant nos yeux!"
else
	text "Fine. I shall tell"
	line "you the secret of"

	para "the invisible"
	line "floor."

	para "The path is right"
	line "before our eyes!"
endc

	done

EcruteakGymGuideText: 
if DEF(_FR_FR)
	text "Les dresseurs d'ici"
	line "ont un truc"
	cont "secret."

	para "Si tu gagnes, ils"
	line "te parleront peut-"

	para "être du fameux"
	line "secret de ROSALIA."
else
	text "The trainers here"
	line "have secret mo-"
	cont "tives."

	para "If you win, they"
	line "may tell you some"

	para "deep secrets about"
	line "ECRUTEAK."
endc

	done

EcruteakGymGuideWinText: 
if DEF(_FR_FR)
	text "Whaou, <PLAYER>!"
	line "Bien joué!"

	para "J'étais caché dans"
	line "un coin tant"
	cont "j'étais mort de"
	cont "trouille!"
else
	text "Whew, <PLAYER>."
	line "You did great!"

	para "I was cowering in"
	line "the corner out of"
	cont "pure terror!"
endc

	done

EcruteakGymClosedText: 
if DEF(_FR_FR)
	text "MORTIMER, le CHAM-"
	line "PION, est absent."

	para "Tu dois partir."

	para "Hohohoho."
else
	text "MORTY, the GYM"
	line "LEADER, is absent."

	para "Sorry, but you'll"
	line "have to leave."

	para "Hohohoho."
endc

	done

EcruteakGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 10
	warp_event  5, 17, ECRUTEAK_CITY, 10
	warp_event  4, 14, ECRUTEAK_GYM, 4
	warp_event  7, 12, ECRUTEAK_GYM, 3
	warp_event  5,  4, ECRUTEAK_GYM, 3
	warp_event  4,  4, ECRUTEAK_GYM, 3
	warp_event  3,  4, ECRUTEAK_GYM, 3
	warp_event  7,  4, ECRUTEAK_GYM, 3
	warp_event  3,  5, ECRUTEAK_GYM, 3
	warp_event  4,  6, ECRUTEAK_GYM, 3
	warp_event  6,  6, ECRUTEAK_GYM, 3
	warp_event  3,  9, ECRUTEAK_GYM, 3
	warp_event  5,  8, ECRUTEAK_GYM, 3
	warp_event  6,  8, ECRUTEAK_GYM, 3
	warp_event  4,  8, ECRUTEAK_GYM, 3
	warp_event  7, 13, ECRUTEAK_GYM, 3
	warp_event  3, 10, ECRUTEAK_GYM, 3
	warp_event  5, 10, ECRUTEAK_GYM, 3
	warp_event  2, 12, ECRUTEAK_GYM, 3
	warp_event  3, 12, ECRUTEAK_GYM, 3
	warp_event  4, 12, ECRUTEAK_GYM, 3
	warp_event  2,  4, ECRUTEAK_GYM, 3
	warp_event  7, 10, ECRUTEAK_GYM, 3
	warp_event  7, 11, ECRUTEAK_GYM, 3
	warp_event  5, 12, ECRUTEAK_GYM, 3
	warp_event  5, 11, ECRUTEAK_GYM, 3

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, EcruteakGymStatue
	bg_event  6, 15, BGEVENT_READ, EcruteakGymStatue

	def_object_events
	object_event  5,  1, SPRITE_MORTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakGymMortyScript, -1
	object_event  2,  7, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSageJeffrey, -1
	object_event  3, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSagePing, -1
	object_event  7,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerMediumMartha, -1
	object_event  7,  9, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerMediumGrace, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakGymGuideScript, -1
	object_event  4, 14, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ECRUTEAK_GYM_GRAMPS
