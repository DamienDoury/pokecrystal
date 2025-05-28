	object_const_def
	const CERULEANGYM_ROCKET
	const CERULEANGYM_MISTY
	const CERULEANGYM_SWIMMER_GIRL1
	const CERULEANGYM_SWIMMER_GIRL2
	const CERULEANGYM_SWIMMER_GUY
	const CERULEANGYM_GYM_GUIDE

CeruleanGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_CERULEANGYM_NOTHING
	scene_script .GruntRunsOut ; SCENE_CERULEANGYM_GRUNT_RUNS_OUT

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_MISTY
	iftrue .no_check

	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iftrue .no_check

	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall CeruleanGymCheckForbiddenTypes
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

	scall CeruleanGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked CERULEANGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked CERULEANGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp CERULEAN_CITY, 30, 23
.no_check
	end

.GruntRunsOut:
	prioritysjump .GruntRunsOutScript
	end

.GruntRunsOutScript:
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsDownMovement
	playsound SFX_TACKLE
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsIntoYouMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext CeruleanGymGruntIntroText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, CERULEANGYM_ROCKET, 15
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntBacksAwayMovement
	clearflag ENGINE_TRAINER_CARD
	opentext
	writetext CeruleanGymGruntBigMistakeText
	waitbutton
	closetext
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntMovesCloseMovement
	opentext
	writetext CeruleanGymGruntByeText
	waitbutton
	closetext
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsOutMovement
	playsound SFX_EXIT_BUILDING
	disappear CERULEANGYM_ROCKET
	setevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	clearevent EVENT_CERULEAN_HOUSE_ROCKET
	clearevent EVENT_ROUTE_25_MISTY_BOYFRIEND
	setscene SCENE_CERULEANGYM_NOTHING
	setmapscene ROUTE_25, SCENE_ROUTE25_MISTYS_DATE
	setmapscene POWER_PLANT, SCENE_POWERPLANT_NOTHING
	waitsfx
	special RestartMapMusic
	pause 15
	turnobject PLAYER, DOWN
	pause 15

	showemote EMOTE_QUESTION, PLAYER, 20
	pause 15
	jumptext CeruleanGymTrainerCardGoneText

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

CeruleanGymCheckForbiddenTypes:
	setval GRASS
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval ELECTRIC
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

CeruleanGymMistyScript:
	faceplayer
	opentext
	checkflag ENGINE_CASCADEBADGE
	iftrue .FightDone
	writetext MistyIntroText
	promptbutton

	special CheckAllFlyingOrWaterTypeParty
	iftrue .ProceedToBattle

; The player doesn't have an appropriate team.
	writetext MistyOnlyWaterOrFlyingTypeText
	waitbutton
	closetext
	end

.ProceedToBattle:
	writetext MistyValidatesTeamText
	waitbutton
	closetext
	loadmem wBattlePokerusSeed, TRUE
	winlosstext MistyWinLossText, 0
	loadtrainer MISTY, MISTY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MISTY
	setevent EVENT_BEAT_SWIMMERF_DIANA
	setevent EVENT_BEAT_SWIMMERF_BRIANA
	setevent EVENT_BEAT_SWIMMERM_PARKER
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
	opentext
	writetext ReceivedCascadeBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_CASCADEBADGE
	farscall GotNewKantoBadge
.FightDone:
	checkevent EVENT_RED_BEATEN
	iffalse .RedBeaten
	writetext MistyFightDoneText
	sjump .EndText

.RedBeaten
	writetext MistyRedDeadText

.EndText
	waitbutton
	closetext
	end

TrainerSwimmerfDiana:
	trainer SWIMMERF, DIANA, EVENT_BEAT_SWIMMERF_DIANA, SwimmerfDianaSeenText, SwimmerfDianaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfDianaAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfBriana:
	trainer SWIMMERF, BRIANA, EVENT_BEAT_SWIMMERF_BRIANA, SwimmerfBrianaSeenText, SwimmerfBrianaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfBrianaAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermParker:
	trainer SWIMMERM, PARKER, EVENT_BEAT_SWIMMERM_PARKER, SwimmermParkerSeenText, SwimmermParkerBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermParkerAfterBattleText
	waitbutton
	closetext
	end

CeruleanGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MISTY
	iftrue .CeruleanGymGuideWinScript
	writetext CeruleanGymGuideText
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	farscall GotBadgeNoTrainerCard
	waitbutton
	closetext
	end

.CeruleanGymGuideWinScript:
	writetext CeruleanGymGuideWinText
	waitbutton
	closetext
	end

CeruleanGymHiddenMachinePart:
	hiddenitem MACHINE_PART, EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM

CeruleanGymStatue1:
	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iffalse CeruleanGymStatue
	opentext
	writetext CeruleanGymNote1Text
	waitbutton
	closetext
	end

CeruleanGymStatue2:
	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iffalse CeruleanGymStatue
	opentext
	writetext CeruleanGymNote2Text
	waitbutton
	closetext
	end

CeruleanGymStatue:
	checkflag ENGINE_CASCADEBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, MISTY, MISTY1
	jumpstd GymStatue2Script

CeruleanGymGruntRunsDownMovement:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

CeruleanGymGruntRunsOutMovement:
	big_step DOWN
	big_step RIGHT
	big_step DOWN
	turn_head LEFT
	step_sleep 8
	turn_head DOWN
	step_sleep 8
	step_end

CeruleanGymGruntRunsIntoYouMovement:
	fix_facing
	set_sliding
	jump_step UP
	remove_sliding
	remove_fixed_facing
	step_sleep 8
	step_sleep 8
	step DOWN
	step_end

CeruleanGymGruntMovesCloseMovement:
	big_step DOWN
	step_end

CeruleanGymGruntBacksAwayMovement:
	fix_facing
	slow_step UP
	remove_fixed_facing
	step_end

CeruleanGymGruntIntroText: 
if DEF(_FR_FR)
	text "Oups!"
	line "Pardon!"
	cont "Tu vas bien?"

	para "J'suis occupé."
	line "Pas le temps."
	cont "Au revoir."
	cont "Tu m'as pas vu,"
	cont "OK?"
else
	text "Oops! I so sorry!"
	line "You not hurt,"
	cont "okay?"

	para "I very busy."
	line "No time for talk-"
	cont "ing with you. Not"
	cont "good for me if"
	cont "seen by somebody."
endc

	done

CeruleanGymGruntBigMistakeText: 
if DEF(_FR_FR)
	text "Oh! Tu m'as vu!"
	line "C'est pas bon, ça!"
else
	text "Oh no! You seen"
	line "me already! I make"
	cont "big mistake!"
endc

	done

CeruleanGymGruntByeText: 
if DEF(_FR_FR)
	text "Hé toi! Tu oublies"
	line "que tu m'as vu,"

	para "OK? Allez..."
	line "Adieu!"

	para "Adieuuuu!"
else
	text "Hey, you! Forget"
	line "you see me, okay?"

	para "You see, hear,"
	line "know nothing,"

	para "okay?"
	line "Bye, kid! Nothing!"

	para "Bye-bye a go-go!"
endc

	done

CeruleanGymNote1Text: 
if DEF(_FR_FR)
	text "Sortie pour un"
	line "moment..."
	cont "ONDINE, CHAMPIONNE"
else
	text "Sorry, I'll be out"
	line "for a while."
	cont "MISTY, GYM LEADER"
endc

	done

CeruleanGymNote2Text: 
if DEF(_FR_FR)
	text "ONDINE est partie,"
	line "alors nous aussi."
	cont "Les DRESSEURS de"
	cont "l'ARENE"
else
	text "Since MISTY's out,"
	line "we'll be away too."
	cont "GYM TRAINERS"
endc

	done

MistyIntroText: ; TO TRANSLATE
	text "MISTY: I was ex-"
	line "pecting you, you"
	cont "pest!"

	para "You may have a"
	line "lot of JOHTO GYM"

	para "BADGES, but in"
	line "this GYM we play"
	cont "by my rules."

	para "This pool repli-"
	line "cates the rough"
	cont "conditions of an"
	cont "ocean storm I once"
	cont "fought in."	
	done

MistyOnlyWaterOrFlyingTypeText: ; TO TRANSLATE
	text "Only WATER and"
	line "FLYING #MON"

	para "can endure such"
	line "a storm. (cough)"

	para "Your current team"
	line "is not fit for"
	cont "this challenge."

	para "So go fix it,"
	line "you pest! Quick!"
	done

MistyValidatesTeamText: ; TO TRANSLATE
	text "That'll show you"
	line "the true power of"
	cont "WATER #MON."

	para "Let's see what"
	line "you're made of!"
	done

MistyWinLossText: 
if DEF(_FR_FR)
	text "ONDINE: OK. T'es"
	line "pas naze..."

	para "Je le reconnais..."

	para "Tiens. V'là le"
	line "BADGECASCADE."
else
	text "MISTY: You really"
	line "are good…"

	para "I'll admit that"
	line "you are skilled…"

	para "Here you go. It's"
	line "CASCADEBADGE."
endc

	done

ReceivedCascadeBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGECASCADE."
else
	text "<PLAYER> received"
	line "CASCADEBADGE."
endc

	done

MistyFightDoneText: ; TO TRANSLATE
	text "MISTY: Are there"
	line "many strong train-"
	cont "ers in JOHTO? Like"
	cont "you, I mean."

	para "(cough)"

	para "I'm going to"
	line "travel one day, so"

	para "I can battle some"
	line "skilled trainers."
	done

MistyRedDeadText: ; TO TRANSLATE
	text "MISTY: (weeping)"
	line "Poor him…"
	cont "…I'm sure it's his"
	cont "SANDSLASH that"
	cont "gave it to him…"

	para "The one he caught"
	line "in this cave…"

	para "I thought the"
	line "entrance had"
	cont "collapsed under"
	cont "water…"
	
	para "…yet he and his"
	line "#MON found a"
	cont "way in…"

	para "(weeping)"

	para "I wish I knew"
	line "where the entrance"
	cont "is, so I could"
	cont "condemn it…"
	done

SwimmerfDianaSeenText: 
if DEF(_FR_FR)
	text "Désolée d'avoir"
	line "été absente."
	cont "On y va!"
else
	text "Sorry about being"
	line "away. Let's get on"
	cont "with it!"
endc

	done

SwimmerfDianaBeatenText: 
if DEF(_FR_FR)
	text "OK!"
	line "T'as gagné!"
else
	text "I give up! You're"
	line "the winner!"
endc

	done

SwimmerfDianaAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais nager"
	line "tranquillement."
else
	text "I'll be swimming"
	line "quietly."
endc

	done

SwimmerfBrianaSeenText: 
if DEF(_FR_FR)
	text "Je nage trop bien."
	line "Ca t'énerve?"
else
	text "Don't let my ele-"
	line "gant swimming un-"
	cont "nerve you."
endc

	done

SwimmerfBrianaBeatenText: 
if DEF(_FR_FR)
	text "Ooh!"
	line "Impressionnant!"
else
	text "Ooh, you calmly"
	line "disposed of me…"
endc

	done

SwimmerfBrianaAfterBattleText: 
if DEF(_FR_FR)
	text "Ne crâne pas"
	line "trop..."

	para "ONDINE va te faire"
	line "mal..."
else
	text "Don't be too smug"
	line "about beating me."

	para "MISTY will destroy"
	line "you if you get"
	cont "complacent."
endc

	done

SwimmermParkerSeenText: 
if DEF(_FR_FR)
	text "Gloups..."

	para "A l'attaque!"
	line "Glouarps!"
else
	text "Glub…"

	para "I'm first! Come"
	line "and get me!"
endc

	done

SwimmermParkerBeatenText: 
if DEF(_FR_FR)
	text "Impossible..."
else
	text "This can't be…"
endc

	done

SwimmermParkerAfterBattleText: 
if DEF(_FR_FR)
	text "ONDINE s'est bien"
	line "améliorée depuis"
	cont "un certain temps."

	para "Fais bien atten-"
	line "tion, ou tu vas"
	cont "le regretter!"
else
	text "MISTY has gotten"
	line "much better in the"
	cont "past few years."

	para "Don't let your"
	line "guard down, or"
	cont "you'll be crushed!"
endc

	done

CeruleanGymGuideText: ; TO TRANSLATE
	text "Yo CHAMP!"

	para "Since MISTY was"
	line "away, I went out"

	para "for some fun too."
	line "He-he-he."
	done

CeruleanGymGuideWinText: 
if DEF(_FR_FR)
	text "Whoa! Tu es un"
	line "p'tit tigre!"

	para "Quel beau combat!"
	line "Comme toujours,"
	cont "quoi!"
else
	text "Hoo, you showed me"
	line "how tough you are."

	para "As always, that"
	line "was one heck of a"
	cont "great battle!"
endc

	done

CeruleanGymTrainerCardGoneText: ; TO TRANSLATE
	text "What?!"

	para "Your TRAINER CARD"
	line "is gone…"
	done

CeruleanGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, CERULEAN_CITY, 5
	warp_event  5, 15, CERULEAN_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  7, 10, BGEVENT_ITEM, CeruleanGymHiddenMachinePart
	bg_event  2, 13, BGEVENT_READ, CeruleanGymStatue1
	bg_event  6, 13, BGEVENT_READ, CeruleanGymStatue2

	def_object_events
	object_event  4, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_GYM_ROCKET
	object_event  5,  2, SPRITE_MISTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanGymMistyScript, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  4,  6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfDiana, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  1,  9, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerSwimmerfBriana, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  8,  9, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermParker, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanGymGuideScript, EVENT_TRAINERS_IN_CERULEAN_GYM
