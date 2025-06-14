	object_const_def
	const SAFFRONGYM_SABRINA
	const SAFFRONGYM_GRANNY1
	const SAFFRONGYM_YOUNGSTER1
	const SAFFRONGYM_GRANNY2
	const SAFFRONGYM_YOUNGSTER2
	const SAFFRONGYM_GYM_GUIDE

SaffronGym_MapScripts:
	def_scene_scripts

	def_callbacks

SaffronGymSabrinaScript:
	faceplayer
	opentext
	checkflag ENGINE_MARSHBADGE
	iftrue .FightDone
	writetext SabrinaIntroText
	yesorno
	iffalse .RefusedSabrinasChallenge
	writetext SabrinaIntroSequelText
	waitbutton
	closetext
	winlosstext SabrinaWinLossText, 0
	loadtrainer SABRINA, SABRINA1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_MEDIUM_REBECCA
	setevent EVENT_BEAT_MEDIUM_DORIS
	setevent EVENT_BEAT_PSYCHIC_FRANKLIN
	setevent EVENT_BEAT_PSYCHIC_JARED
	opentext
	writetext ReceivedMarshBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MARSHBADGE
	farscall GotNewKantoBadge
	writetext SabrinaMarshBadgeText
	waitbutton
	closetext
	end

.RefusedSabrinasChallenge:
	writetext SabrinaChallengeRefusedText
	waitbutton
	closetext
	end

.FightDone:
	writetext SabrinaFightDoneText
	waitbutton
	closetext
	end

TrainerMediumRebecca:
	trainer MEDIUM, REBECCA, EVENT_BEAT_MEDIUM_REBECCA, MediumRebeccaSeenText, MediumRebeccaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer MediumRebeccaAfterBattleText

TrainerPsychicFranklin:
	trainer PSYCHIC_T, FRANKLIN, EVENT_BEAT_PSYCHIC_FRANKLIN, PsychicFranklinSeenText, PsychicFranklinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicFranklinAfterBattleText

TrainerMediumDoris:
	trainer MEDIUM, DORIS, EVENT_BEAT_MEDIUM_DORIS, MediumDorisSeenText, MediumDorisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer MediumDorisAfterBattleText

TrainerPsychicJared:
	trainer PSYCHIC_T, JARED, EVENT_BEAT_PSYCHIC_JARED, PsychicJaredSeenText, PsychicJaredBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicJaredAfterBattleText

SaffronGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_SABRINA
	iftrue .SaffronGymGuideWinScript
	showemote EMOTE_SHOCK, SAFFRONGYM_GYM_GUIDE, 15
	opentext
	writetext SaffronGymGuideText
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	farscall GotBadgeNoTrainerCard
	waitbutton
	closetext
	end

.SaffronGymGuideWinScript:
	opentext
	writetext SaffronGymGuideWinText
	waitbutton
	closetext
	end

SaffronGymStatue:
	checkflag ENGINE_MARSHBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, SABRINA, SABRINA1
	jumpstd GymStatue2Script

SabrinaIntroText: ; TO TRANSLATE
	text "SABRINA: I knew"
	line "you were coming…"

	para "Three years ago I"
	line "had a vision of"
	cont "your arrival."

	para "You're after my"
	line "BADGE."

	para "I don't enjoy bat-"
	line "tling, but it's my"
	cont "duty as a LEADER."

	para "I like to teach"
	line "trainers that"

	para "they can't always"
	line "be victorious by"
	cont "using brut force."

	para "Show me that you"
	line "can win a battle"

	para "with your greatest"
	line "weapon: your mind."

	para "You won't be able"
	line "to use neither"
	
	para "PHYSICAL nor"
	line "SPECIAL moves"
	cont "against me."

	para "Are you feeling"
	line "ready?"
	done

SabrinaIntroSequelText: ; TO TRANSLATE
	text "Since you wish it,"
	line "I will show you my"
	cont "psychic powers!"
	done

SabrinaChallengeRefusedText: ; TO TRANSLATE
	text "I foresee that"
	line "our paths will"
	cont "cross again."
	done

SabrinaWinLossText: 
if DEF(_FR_FR)
	text "MORGANE: Ta force"
	line "est grande..."

	para "Je ne l'avais pas"
	line "prévu. Zut."

	para "Prédire le futur"
	line "c'est pas si"

	para "facile! Ne te"
	line "moque pas trop..."

	para "Bon. Tu as bien"
	line "mérité le BADGE"
	cont "MARAIS."
else
	text "SABRINA: Your"
	line "power…"

	para "It far exceeds"
	line "what I foresaw…"

	para "Maybe it isn't"
	line "possible to fully"

	para "predict what the"
	line "future holds…"

	para "OK, you win. You"
	line "earned yourself"
	cont "MARSHBADGE."
endc

	done

ReceivedMarshBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE MARAIS."
else
	text "<PLAYER> received"
	line "MARSHBADGE."
endc

	done

SabrinaMarshBadgeText: ; TO TRANSLATE
	text "SABRINA: Although"
	line "I failed to"
	cont "accurately predict"
	cont "your power, this"
	cont "much I know"
	cont "to be true."

	para "You will become a"
	line "celebrated and"
	cont "beloved CHAMPION!"
	done

SabrinaFightDoneText: ; TO TRANSLATE
	text "SABRINA: The power"
	line "of your mind"

	para "overwhelmed my"
	line "psychic power…"

	para "You showed me new"
	line "paths…"
	done

MediumRebeccaSeenText: 
if DEF(_FR_FR)
	text "Que la force soit"
	line "avec moi!"
else
	text "The power of all"
	line "those you defeated"
	cont "comes to me!"
endc

	done

MediumRebeccaBeatenText: 
if DEF(_FR_FR)
	text "Bah alors?"
else
	text "Strong…"
	line "Far too strong…"
endc

	done

MediumRebeccaAfterBattleText: 
if DEF(_FR_FR)
	text "Quelle est la"
	line "source de ta"
	cont "force?"
else
	text "What is the source"
	line "of your power?"
endc

	done

PsychicFranklinSeenText: 
if DEF(_FR_FR)
	text "Je vais prendre"
	line "ton âme!"
else
	text "Psychic power is"
	line "the power of your"
	cont "soul."
endc

	done

PsychicFranklinBeatenText: 
if DEF(_FR_FR)
	text "Pourquoi tant de"
	line "haine?"
else
	text "Your soul has more"
	line "power than mine!"
endc

	done

PsychicFranklinAfterBattleText: ; TO TRANSLATE
	text "SABRINA's powers"
	line "are terrifying."
	
	para "Her psychic aura"
	line "radiates outside"
	
	para "the bounds of"
	line "this building."
	
	para "I have frequent"
	line "headaches when I'm"

	para "here, and I feel"
	line "better when I go"

	para "far away from"
	line "this GYM."

	para "Oh man, I wouldn't"
	line "want to live close"
	cont "to this building."
	done

MediumDorisSeenText: 
if DEF(_FR_FR)
	text "Gnihihihihi!"
	line "Forces occultes!"

	para "Ténèbres..."
	line "Pâté de foie!"
else
	text "Fufufufu…"
	line "I see it clearly."

	para "I can see into"
	line "your soul!"
endc

	done

MediumDorisBeatenText: 
if DEF(_FR_FR)
	text "J'aime le paranor-"
	line "mal, oui, mais la"
	cont "charcuterie aussi!"
else
	text "Though I read you,"
	line "I still lost…"
endc

	done

MediumDorisAfterBattleText: 
if DEF(_FR_FR)
	text "Le psychisme,"
	line "c'est dur à dire."
else
	text "Darn! I forgot"
	line "that I predicted I"
	cont "would lose to you."
endc

	done

PsychicJaredSeenText: 
if DEF(_FR_FR)
	text "Le DOJO d'à côté"
	line "était jadis l'ARE-"
	cont "NE de cette ville."
else
	text "The FIGHTING DOJO"
	line "next door was once"
	cont "this city's GYM."
endc

	done

PsychicJaredBeatenText: 
if DEF(_FR_FR)
	text "Tout perdu..."
else
	text "I was no match…"
endc

	done

PsychicJaredAfterBattleText: 
if DEF(_FR_FR)
	text "Le ROI du KARATE,"
	line "le maître du DOJO"

	para "a été battu par"
	line "MORGANE."
else
	text "KARATE KING, the"
	line "master of the"

	para "FIGHTING DOJO, was"
	line "just destroyed by"
	cont "SABRINA."
endc

	done

SaffronGymGuideText: ; TO TRANSLATE
	text "Hello <PLAYER>…"

	para "SABRINA told me"
	line "you would be"
	cont "coming today…"

	para "It feels weird"
	line "that it's actual-"
	cont "ly happening!"

	para "Usually GHOST and"
	line "DARK types are"
	cont "forbidden in this"
	cont "GYM."

	para "But SABRINA said"
	line "that those are"
	cont "allowed today…"

	para "Because she fore-"
	line "saw her victory."

	para "Are you sure you"
	line "still want to"
	cont "challenge her?"
	done

SaffronGymGuideWinText: ; TO TRANSLATE
	text "That was another"
	line "FANTASTIC battle!"
	done

SaffronGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 2
	warp_event  9, 17, SAFFRON_CITY, 2
	warp_event  9, 15, SAFFRON_GYM, 4
	warp_event 15, 11, SAFFRON_GYM, 6
	warp_event 15,  9, SAFFRON_GYM, 7
	warp_event 19,  9, SAFFRON_GYM, 8
	warp_event 19, 11, SAFFRON_GYM, 5
	warp_event  1,  9, SAFFRON_GYM, 6
	warp_event  5,  9, SAFFRON_GYM, 12
	warp_event  1, 11, SAFFRON_GYM, 17
	warp_event  5, 11, SAFFRON_GYM, 7
	warp_event  1,  3, SAFFRON_GYM, 18
	warp_event  5,  3, SAFFRON_GYM, 10
	warp_event  1,  5, SAFFRON_GYM, 4
	warp_event  5,  5, SAFFRON_GYM, 20
	warp_event  1, 15, SAFFRON_GYM, 5
	warp_event  5, 15, SAFFRON_GYM, 8
	warp_event  1, 17, SAFFRON_GYM, 6
	warp_event  5, 17, SAFFRON_GYM, 19
	warp_event  9,  5, SAFFRON_GYM, 26
	warp_event 11,  5, SAFFRON_GYM, 19
	warp_event  9,  3, SAFFRON_GYM, 14
	warp_event 11,  3, SAFFRON_GYM, 9
	warp_event 19, 17, SAFFRON_GYM, 24
	warp_event 15, 17, SAFFRON_GYM, 5
	warp_event 15, 15, SAFFRON_GYM, 20
	warp_event 19, 15, SAFFRON_GYM, 28
	warp_event 15,  5, SAFFRON_GYM, 27
	warp_event 19,  3, SAFFRON_GYM, 32
	warp_event 19,  5, SAFFRON_GYM, 25
	warp_event 15,  3, SAFFRON_GYM, 11
	warp_event 11,  9, SAFFRON_GYM, 3

	

	def_coord_events

	def_bg_events
	bg_event 10, 15, BGEVENT_READ, SaffronGymStatue

	def_object_events
	object_event  9,  8, SPRITE_SABRINA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronGymSabrinaScript, -1
	object_event 17, 16, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerMediumRebecca, -1
	object_event  3, 16, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicFranklin, -1
	object_event  3,  4, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerMediumDoris, -1
	object_event 17,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerPsychicJared, -1
	object_event 11, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SaffronGymGuideScript, -1
