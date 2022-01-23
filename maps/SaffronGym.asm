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
	opentext
	writetext MediumRebeccaAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicFranklin:
	trainer PSYCHIC_T, FRANKLIN, EVENT_BEAT_PSYCHIC_FRANKLIN, PsychicFranklinSeenText, PsychicFranklinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicFranklinAfterBattleText
	waitbutton
	closetext
	end

TrainerMediumDoris:
	trainer MEDIUM, DORIS, EVENT_BEAT_MEDIUM_DORIS, MediumDorisSeenText, MediumDorisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumDorisAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicJared:
	trainer PSYCHIC_T, JARED, EVENT_BEAT_PSYCHIC_JARED, PsychicJaredSeenText, PsychicJaredBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicJaredAfterBattleText
	waitbutton
	closetext
	end

SaffronGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_SABRINA
	iftrue .SaffronGymGuideWinScript
	showemote EMOTE_SHOCK, SAFFRONGYM_GYM_GUIDE, 15
	opentext
	writetext SaffronGymGuideText
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

SabrinaIntroText:
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

SabrinaIntroSequelText:
	text "Since you wish it,"
	line "I will show you my"
	cont "psychic powers!"
	done

SabrinaChallengeRefusedText:
	text "I foresee that"
	line "our paths will"
	cont "cross again."
	done

SabrinaWinLossText:
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
	done

ReceivedMarshBadgeText:
	text "<PLAYER> received"
	line "MARSHBADGE."
	done

SabrinaMarshBadgeText:
	text "SABRINA: MARSH-"
	line "BADGE draws out"

	para "your subliminal"
	line "powers…"

	para "Although I failed"
	line "to accurately pre-"
	cont "dict your power,"
	cont "this much I know"
	cont "to be true."

	para "You will become a"
	line "celebrated and"
	cont "beloved CHAMPION!"
	done

SabrinaFightDoneText:
	text "SABRINA: The power"
	line "of your mind"

	para "overwhelmed my"
	line "psychic power…"

	para "You showed me new"
	line "paths…"
	done

MediumRebeccaSeenText:
	text "The power of all"
	line "those you defeated"
	cont "comes to me!"
	done

MediumRebeccaBeatenText:
	text "Strong…"
	line "Far too strong…"
	done

MediumRebeccaAfterBattleText:
	text "What is the source"
	line "of your power?"
	done

PsychicFranklinSeenText:
	text "Psychic power is"
	line "the power of your"
	cont "soul."
	done

PsychicFranklinBeatenText:
	text "Your soul has more"
	line "power than mine!"
	done

PsychicFranklinAfterBattleText:
	text "You made your soul"
	line "stronger, not just"
	cont "your abilities."
	done

MediumDorisSeenText:
	text "Fufufufu…"
	line "I see it clearly."

	para "I can see into"
	line "your soul!"
	done

MediumDorisBeatenText:
	text "Though I read you,"
	line "I still lost…"
	done

MediumDorisAfterBattleText:
	text "Darn! I forgot"
	line "that I predicted I"
	cont "would lose to you."
	done

PsychicJaredSeenText:
	text "The FIGHTING DOJO"
	line "next door was once"
	cont "this city's GYM."
	done

PsychicJaredBeatenText:
	text "I was no match…"
	done

PsychicJaredAfterBattleText:
	text "KARATE KING, the"
	line "master of the"

	para "FIGHTING DOJO, was"
	line "just destroyed by"
	cont "SABRINA."
	done

SaffronGymGuideText:
	text "Hello <PLAYER>…"

	para "SABRINA told me"
	line "you would be"
	cont "coming today…"

	para "It feels weird"
	line "that it's actual-"
	cont "ly happening!"

	para "Normally GHOST and"
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

SaffronGymGuideWinText:
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
