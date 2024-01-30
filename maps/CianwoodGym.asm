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
	opentext
	writetext BlackbeltYoshiAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltLao:
	trainer BLACKBELT_T, LAO, EVENT_BEAT_BLACKBELT_LAO, BlackbeltLaoSeenText, BlackbeltLaoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltLaoAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltNob:
	trainer BLACKBELT_T, NOB, EVENT_BEAT_BLACKBELT_NOB, BlackbeltNobSeenText, BlackbeltNobBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltNobAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltLung:
	trainer BLACKBELT_T, LUNG, EVENT_BEAT_BLACKBELT_LUNG, BlackbeltLungSeenText, BlackbeltLungBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltLungAfterText
	waitbutton
	closetext
	end

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
	text "WAHAHAH!"

	para "So you've come"
	line "this far!"
	done

ChuckIntroSequelText:
	text "Let me tell you,"
	line "I'm tough!"

	para "My #MON will"
	line "crush stones and"
	cont "shatter bones!"

	para "Watch this!"
	done

ChuckIntroText2:
	text "CHUCK: Urggh!"
	line "…"

	para "Oooarrgh!"
	done

CianwoodGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

ChuckIntroText3:
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

ChuckLossText:
	text "Wha? Huh?"
	line "I lost?"

	para "How about that!"
	line "You're worthy of"
	cont "STORMBADGE!"
	done

GetStormBadgeText:
	text "<PLAYER> received"
	line "STORMBADGE."
	done

ChuckExplainBadgeText:
	text "STORMBADGE is"
	line "only given to"

	para "the toughest"
	line "of trainers."
	done

ChuckExplainBadgeText2:
	text "Here, take this"
	line "too!"
	done

Obey40:
	text "This third badge"
	line "lets all traded"

	para "#MON up to L40"
	line "obey."
	done

Obey60:
	text "The seventh badge"
	line "you just earned"
	cont "make #MON obey"
	
	para "as long as they"
	line "are under L60."
	done

ChuckExplainTMText:
	text "That is DYNAMIC-"
	line "PUNCH."

	para "It doesn't always"
	line "hit, but when it"

	para "does, it causes"
	line "confusion!"
	done

ChuckAfterText:
	text "WAHAHAH! I enjoyed"
	line "battling you!"

	para "But a loss is a"
	line "loss!"

	para "From now on, I'm"
	line "going to train 24"
	cont "hours a day!"
	done

BlackbeltYoshiSeenText:
	text "Do you know what"
	line "toughness is?"
	done

BlackbeltYoshiBeatenText:
	text "Toughness is not"
	line "being afraid."
	done

BlackbeltYoshiAfterText:
	text "I'm not afraid of"
	line "COVID!"
	
	para "I'm super tough!"
	done

BlackbeltLaoSeenText:
	text "If using a TM"
	line "replenished PPs,"
	
	para "I would be able to"
	line "fight all day!"
	done

BlackbeltLaoBeatenText:
	text "Enough for today."
	done

BlackbeltLaoAfterText:
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

BlackbeltNobSeenText:
	text "Words are useless."
	line "Let your fists do"
	cont "the talking!"
	done

BlackbeltNobBeatenText:
	text "…"
	done

BlackbeltNobAfterText:
	text "I lost! "
	line "I'm speechless!"
	done

BlackbeltLungSeenText:
	text "My raging fists"
	line "will shatter your"
	cont "#MON!"
	done

BlackbeltLungBeatenText:
	text "I got shattered!"
	done

BlackbeltLungAfterText:
	text "My #MON lost…"
	line "My… my pride is"
	cont "shattered…"
	done

CianwoodGymGuideText:
	text "Yo!"

	para "This GYM is all"
	line "about muscles."

	para "Show us a good"
	line "fight!"
	done

CianwoodGymGuideWinText:
	text "What a fight!"
	line "That was epic!"
	
	para "You showed us"
	line "how it's done!"

	para "Do you even lift"
	line "bro?"

	done

CianwoodGymGuideEggText:
	text "HEY YO!"
	
	para "What are you gon'"
	line "do with an EGG in"
	cont "this GYM?"

	para "An omelette"
	line "du fromage?"

	para "Get out of my"
	line "sight, you clown."
	done

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
