	object_const_def
	const VIOLETGYM_FALKNER
	const VIOLETGYM_YOUNGSTER2
	const VIOLETGYM_YOUNGSTER1
	const VIOLETGYM_GYM_GUIDE

VioletGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_FALKNER
	iftrue .no_check
	
	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall VioletGymCheckForbiddenTypes
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

	scall VioletGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked VIOLETGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked VIOLETGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp VIOLET_CITY, 18, 17
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

VioletGymCheckForbiddenTypes:
	setval ELECTRIC
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval ICE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval ROCK
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

VioletGymFalknerScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .FightDone
	writetext FalknerIntroText
	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, VIOLETGYM_FALKNER, 20
	opentext
	writetext VioletGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext FalknerIntroSequelText
	promptbutton
	
	special CheckAllFlyingTypeParty
	iftrue .ProceedToBattle

; The player doesn't have an appropriate team.
	writetext FalknerAllFlyingTypeText
	waitbutton
	closetext
	end

.ProceedToBattle:
	writetext FalknerValidatesTeam
	waitbutton
	closetext
	winlosstext FalknerWinLossText, 0
	loadtrainer FALKNER, FALKNER1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_FALKNER
	opentext
	writetext ReceivedZephyrBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_ZEPHYRBADGE
.FightDone:
	checkitem TM_MUD_SLAP
	iftrue .SpeechAfterTM
	setevent EVENT_BEAT_BIRD_KEEPER_ROD
	setevent EVENT_BEAT_BIRD_KEEPER_ABE
	writetext FalknerZephyrBadgeText
	promptbutton
	farscall NewBadgeObedienceNotification
	writetext FalknerZephyrBadgeText2
	promptbutton
	verbosegiveitem TM_MUD_SLAP
	writetext FalknerTMMudSlapText
	waitbutton
	closetext
	end

.SpeechAfterTM:
	writetext FalknerFightDoneText
	waitbutton
	closetext
	end

TrainerBirdKeeperRod:
	trainer BIRD_KEEPER, ROD, EVENT_BEAT_BIRD_KEEPER_ROD, BirdKeeperRodSeenText, BirdKeeperRodBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperRodAfterBattleText

TrainerBirdKeeperAbe:
	trainer BIRD_KEEPER, ABE, EVENT_BEAT_BIRD_KEEPER_ABE, BirdKeeperAbeSeenText, BirdKeeperAbeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperAbeAfterBattleText

VioletGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .VioletGymGuideWinScript
	writetext VioletGymGuideText
	waitbutton
	closetext
	end

.VioletGymGuideWinScript:
	writetext VioletGymGuideWinText
	waitbutton
	closetext
	end

VioletGymStatue:
	checkflag ENGINE_ZEPHYRBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, FALKNER, FALKNER1
	jumpstd GymStatue2Script

FalknerIntroText: ; TO TRANSLATE
	text "I'm FALKNER, the"
	line "VIOLET #MON GYM"
	cont "leader!"
	done

FalknerIntroSequelText: ; TO TRANSLATE
	text "Have you ever felt"
	line "the thrill of a"

	para "#MON battle on"
	line "the cliff of a"
	cont "high mountain?"	
	done

VioletGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

FalknerAllFlyingTypeText: ; TO TRANSLATE
	text "In such environ-"
	line "ment, only FLYING"

	para "type #MON can"
	line "be used."

	para "This is this"
	line "GYM's test."

	para "Come back with a"
	line "team of FLYING"

	para "types if you want"
	line "to challenge my"
	
	para "majestic bird"
	line "#MON."
	done

FalknerValidatesTeam: ; TO TRANSLATE
	text "It is where"
	line "FLYING #MON"
	cont "truly shine."

	para "I'll show you the"
	line "real power of the"

	para "magnificent bird"
	line "#MON!"
	done

FalknerWinLossText: 
if DEF(_FR_FR)
	text "...Zut de flûte!"
	line "Les #MON adorés"
	cont "de mon papa..."

	para "Très bien."
	line "Prends ceci."

	para "C'est le BADGE"
	line "ZEPHYR officiel de"
	cont "la LIGUE #MON."
else
	text "…Darn! My dad's"
	line "cherished bird"
	cont "#MON…"

	para "All right."
	line "Take this."

	para "It's the official"
	line "#MON LEAGUE"
	cont "ZEPHYRBADGE."
endc

	done

ReceivedZephyrBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE ZEPHYR."
else
	text "<PLAYER> received"
	line "ZEPHYRBADGE."
endc

	done

FalknerZephyrBadgeText: ; TO TRANSLATE
	text "ZEPHYRBADGE is a"
	line "recognition of"
	cont "your worth as a"
	cont "trainer."
	done

FalknerZephyrBadgeText2: ; TO TRANSLATE
	text "Here--take this."
	done

FalknerTMMudSlapText: ; TO TRANSLATE
	text "By using a TM, a"
	line "#MON will"

	para "instantly learn a"
	line "new move."

	para "A TM can be used"
	line "as many times as"
	cont "you like."

	para "TM31 contains"
	line "MUD-SLAP."

	para "It reduces the"
	line "enemy's accuracy"

	para "while it causes"
	line "damage."

	para "In other words, it"
	line "is both defensive"
	cont "and offensive."
	done

FalknerFightDoneText: 
if DEF(_FR_FR)
	text "Il y a des ARENES"
	line "#MON dans"
	cont "les alentours."

	para "Tu devrais tester"
	line "ton habileté dans"
	cont "ces ARENES."

	para "Je vais m'entraî-"
	line "ner plus dur pour"

	para "devenir le plus"
	line "grand!"
else
	text "There are #MON"
	line "GYMS in cities and"
	cont "towns ahead."

	para "You should test"
	line "your skills at"
	cont "these GYMS."

	para "I'm going to train"
	line "harder to become"

	para "the greatest bird"
	line "master!"
endc

	done

BirdKeeperRodSeenText: 
if DEF(_FR_FR)
	text "Le mot clé est..."
	line "Le cran!"

	para "Ceux d'ici s'en-"
	line "traînent nuit et"

	para "jour pour devenir"
	line "maître des"
	cont "#MON volants."

	para "Allez!"
else
	text "The keyword is"
	line "guts!"

	para "Those here are"
	line "training night and"

	para "day to become bird"
	line "#MON masters."

	para "Come on!"
endc

	done

BirdKeeperRodBeatenText: 
if DEF(_FR_FR)
	text "Yaaah!"
else
	text "Gaaah!"
endc

	done

BirdKeeperRodAfterBattleText: 
if DEF(_FR_FR)
	text "L'habileté"
	line "d'ALBERT est"
	cont "bien réelle!"

	para "Si tu as les"
	line "chevilles qui"
	cont "enflent, change"
	cont "de baskets!"
else
	text "FALKNER's skills"
	line "are for real!"

	para "Don't get cocky"
	line "just because you"
	cont "beat me!"
endc

	done

BirdKeeperAbeSeenText: 
if DEF(_FR_FR)
	text "Montre-moi si tu"
	line "as les épaules"
	cont "pour battre"
	cont "ALBERT!"
else
	text "Let me see if you"
	line "are good enough to"
	cont "face FALKNER!"
endc

	done

BirdKeeperAbeBeatenText: 
if DEF(_FR_FR)
	text "Saperlipopette!"
	line "C'est impossible!"
else
	text "This can't be"
	line "true!"
endc

	done

BirdKeeperAbeAfterBattleText: 
if DEF(_FR_FR)
	text "C'est pathétique"
	line "de perdre contre"
	cont "toi..."
else
	text "This is pathetic,"
	line "losing to some"
	cont "rookie trainer…"
endc

	done

VioletGymGuideText: 
if DEF(_FR_FR)
	text "Hé toi! Je ne"
	line "suis pas un"
	cont "dresseur mais"
	cont "je peux te donner"
	cont "quelques conseils!"

	para "Crois-moi!"
	line "Tes rêves de"

	para "star peuvent"
	line "se réaliser."

	para "T'y crois?"
	line "Alors écoute bien."

	para "Les plantes sont"
	line "faibles contre les"

	para "volants. Garde ça"
	line "en mémoire."
else
	text "Hey! I'm no train-"
	line "er but I can give"
	cont "some advice!"

	para "Believe me!"
	line "If you believe, a"

	para "championship dream"
	line "can come true."

	para "You believe?"
	line "Then listen."

	para "The grass-type is"
	line "weak against the"

	para "flying-type. Keep"
	line "this in mind."
endc

	done

VioletGymGuideWinText: 
if DEF(_FR_FR)
	text "Beau combat! Ne"
	line "lâche pas prise et"

	para "tu deviendras sans"
	line "problème une"
	cont "star!"
else
	text "Nice battle! Keep"
	line "it up, and you'll"

	para "be the CHAMP in no"
	line "time at all!"
endc

	done

VioletGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, VIOLET_CITY, 2
	warp_event  5, 15, VIOLET_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, VioletGymStatue
	bg_event  6, 13, BGEVENT_READ, VioletGymStatue

	def_object_events
	object_event  4,  2, SPRITE_FALKNER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VioletGymFalknerScript, -1
	object_event  2, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperAbe, -1
	object_event  7,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperRod, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletGymGuideScript, -1
