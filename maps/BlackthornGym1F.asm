	object_const_def
	const BLACKTHORNGYM1F_CLAIR
	const BLACKTHORNGYM1F_COOLTRAINER_M1
	const BLACKTHORNGYM1F_COOLTRAINER_M2
	const BLACKTHORNGYM1F_COOLTRAINER_F
	const BLACKTHORNGYM1F_GYM_GUIDE

BlackthornGym1F_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	callback MAPCALLBACK_TILES, .Boulders

.TeamCheck:
	checkevent EVENT_BEAT_CLAIR
	iftrue .no_check
	
	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall BlackthornGymCheckForbiddenTypes
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

	scall BlackthornGymCheckForbiddenTypes
	iftrue .do_check
	end
	
.egg_found
	setlasttalked BLACKTHORNGYM1F_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked BLACKTHORNGYM1F_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves	
	callstd GymGuidePlayerLeavesScript
	warp BLACKTHORN_CITY, 18, 11
.no_check	
	end

.Boulders:
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	iffalse .skip1
	changeblock 8, 2, $3b ; fallen boulder 2
.skip1
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	iffalse .skip2
	changeblock 2, 4, $3a ; fallen boulder 1
.skip2
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	iffalse .skip3
	changeblock 8, 6, $3b ; fallen boulder 2
.skip3
	endcallback

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

BlackthornGymCheckForbiddenTypes:
	setval ICE
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

BlackthornGymClairScript:
	faceplayer
	opentext
	checkflag ENGINE_RISINGBADGE
	iftrue .AlreadyGotBadge
	checkevent EVENT_BEAT_CLAIR
	iftrue .FightDone
	writetext ClairIntroText

	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, BLACKTHORNGYM1F_CLAIR, 20
	opentext
	writetext BlackthornGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext ClairIntroTextSequel

	yesorno
	iffalse .RefusesClairsChallenge
	writetext ClairIntroSequelText
	waitbutton
	closetext
	winlosstext ClairWinText, 0
	loadtrainer CLAIR, CLAIR1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CLAIR
	opentext
	writetext ClairText_GoToDragonsDen
	waitbutton
	closetext
	readmem wYearMonth
	addval 1
	writemem wYearMonth
	setevent EVENT_BEAT_COOLTRAINERM_PAUL
	setevent EVENT_BEAT_COOLTRAINERM_CODY
	setevent EVENT_BEAT_COOLTRAINERM_MIKE
	setevent EVENT_BEAT_COOLTRAINERF_FRAN
	setevent EVENT_BEAT_COOLTRAINERF_LOLA
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	clearevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	end

.RefusesClairsChallenge:
	writetext RefusesClairsChallengeText
	waitbutton
	closetext
	end

.FightDone:
	writetext ClairText_TooMuchToExpect
	waitbutton
	closetext
	end

.AlreadyGotBadge:
	checkevent EVENT_GOT_TM24_DRAGONBREATH
	iftrue .GotTM24
	writetext BlackthornGymClairText_YouKeptMeWaiting
	promptbutton
	giveitem TM_DRAGONBREATH
	iffalse .BagFull
	getitemname STRING_BUFFER_3, TM_DRAGONBREATH
	writetext BlackthornGymText_ReceivedTM24
	playsound SFX_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_TM24_DRAGONBREATH
	writetext BlackthornGymClairText_DescribeTM24
	promptbutton
	sjump .GotTM24

.BagFull:
	writetext BlackthornGymClairText_BagFull
	waitbutton
	closetext
	end

.GotTM24:
	writetext BlackthornGymClairText_League
	waitbutton
	closetext
	end

TrainerCooltrainermPaul:
	trainer COOLTRAINERM, PAUL, EVENT_BEAT_COOLTRAINERM_PAUL, CooltrainermPaulSeenText, CooltrainermPaulBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermPaulAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermMike:
	trainer COOLTRAINERM, MIKE, EVENT_BEAT_COOLTRAINERM_MIKE, CooltrainermMikeSeenText, CooltrainermMikeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermMikeAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfLola:
	trainer COOLTRAINERF, LOLA, EVENT_BEAT_COOLTRAINERF_LOLA, CooltrainerfLolaSeenText, CooltrainerfLolaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfLolaAfterBattleText
	waitbutton
	closetext
	end

BlackthornGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CLAIR
	iftrue .BlackthornGymGuideWinScript
	writetext BlackthornGymGuideText
	waitbutton
	closetext
	end

.BlackthornGymGuideWinScript:
	writetext BlackthornGymGuideWinText
	waitbutton
	closetext
	end

BlackthornGymStatue:
	checkflag ENGINE_RISINGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, CLAIR, CLAIR1
	jumpstd GymStatue2Script

BlackthornGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end
	
ClairIntroText: ; TO TRANSLATE
	text "I am CLAIR."

	para "The world's best"
	line "dragon master."
	done

ClairIntroTextSequel: ; TO TRANSLATE
	text "I can hold my own"
	line "against even the"

	para "#MON LEAGUE's"
	line "ELITE FOUR."

	para "Get ready for a"
	line "brut force battle!"

	para "STATUS moves are"
	line "forbidden in"
	cont "this battle."

	para "Do you still want"
	line "to take me on?"
	done

ClairIntroSequelText: ; TO TRANSLATE
	text "…Fine."
	line "Let's do it!"

	para "As a GYM LEADER,"
	line "I will use my full"

	para "power against any"
	line "opponent!"
	done

RefusesClairsChallengeText: ; TO TRANSLATE
	text "Afraid of me"
	line "I guess."

	para "It is wise of"
	line "you."
	done

ClairWinText: 
if DEF(_FR_FR)
	text "Perdu?"

	para "J'y crois pas!!"
	line "Il y a sûrement"
	cont "une erreur..."
else
	text "I lost?"

	para "I don't believe"
	line "it. There must be"
	cont "some mistake…"
endc

	done

ClairText_GoToDragonsDen: ; TO TRANSLATE
	text "I won't admit"
	line "this."

	para "I know. You should"
	line "take the dragon"
	cont "user challenge."

	para "Behind this GYM is"
	line "a place called"
	cont "DRAGON'S DEN."

	para "There is a small"
	line "shrine at its"

	para "center."
	line "Go there."

	para "If you can prove"
	line "that you've lost"

	para "your lazy ideals,"
	line "I will recognize"

	para "you as a trainer"
	line "worthy of a GYM"
	cont "BADGE!"
	done

ClairText_TooMuchToExpect: 
if DEF(_FR_FR)
	text "Et alors?"

	para "On a peur"
	line "maintenant?"
else
	text "What's the matter?"

	para "Is it too much to"
	line "expect of you?"
endc

	done

BlackthornGymClairText_YouKeptMeWaiting: 
if DEF(_FR_FR)
	text "Tu en as mis du"
	line "temps!"

	para "Tiens! Prends ça!"
else
	text "You've kept me"
	line "waiting!"

	para "Here! Take this!"
endc

	done

BlackthornGymText_ReceivedTM24: ; TO TRANSLATE
	text "<PLAYER> received"
	line "TM24 DRAGONBREATH."
	done

BlackthornGymClairText_DescribeTM24: 
if DEF(_FR_FR)
	text "Elle contient"
	line "DRACOSOUFFLE."

	para "Non, cela n'a rien"
	line "à voir avec mon"
	cont "haleine..."

	para "Si tu n'en veux"
	line "pas, c'est pas"
	cont "la peine."
else
	text "That contains"
	line "DRAGONBREATH."

	para "No, it doesn't"
	line "have anything to"
	cont "do with my breath."

	para "If you don't want"
	line "it, you don't have"
	cont "to take it."
endc

	done

BlackthornGymClairText_BagFull: 
if DEF(_FR_FR)
	text "Bah alors? Tu n'as"
	line "pas de place?"
else
	text "What is this? You"
	line "don't have room?"
endc

	done

BlackthornGymClairText_League: ; TO TRANSLATE
	text "I'm so mad about"
	line "having lost"
	cont "to you!"
	done

CooltrainermPaulSeenText: 
if DEF(_FR_FR)
	text "C'est ton premier"
	line "combat face à des"
	cont "dragons?"

	para "Je vais te montrer"
	line "leur résistance"
	cont "suprême!"
else
	text "Your first battle"
	line "against dragons?"

	para "I'll show you how"
	line "tough they are!"
endc

	done

CooltrainermPaulBeatenText: 
if DEF(_FR_FR)
	text "Mes #MON"
	line "dragon ont perdu?"
else
	text "My dragon #MON"
	line "lost?"
endc

	done

CooltrainermPaulAfterBattleText: 
if DEF(_FR_FR)
	text "PETER voulait te"
	line "revoir?"
	cont "Mensonge!"
else
	text "LANCE told you"
	line "that he'd like to"

	para "see you again?"
	line "Not a chance!"
endc

	done

CooltrainermMikeSeenText: 
if DEF(_FR_FR)
	text "Mes chances de"
	line "perdre? Même pas"
	cont "une pour mille!"
else
	text "My chance of"
	line "losing? Not even"
	cont "one percent!"
endc

	done

CooltrainermMikeBeatenText: 
if DEF(_FR_FR)
	text "Je ne suis plus"
	line "très bon en"
	cont "maths."
else
	text "That's odd."
endc

	done

CooltrainermMikeAfterBattleText: 
if DEF(_FR_FR)
	text "Je connais mes"
	line "défauts..."

	para "On recommence?"
	line "Non? Bon et bien"
	cont "merci pour la"
	cont "leçon..."
else
	text "I know my short-"
	line "comings now."

	para "Thanks for showing"
	line "me!"
endc

	done

CooltrainerfLolaSeenText: 
if DEF(_FR_FR)
	text "Les dragons sont"
	line "des #MON"

	para "sacrés. Ils sont"
	line "plein de vie."

	para "Si tu ne fais pas"
	line "attention, tu ne"

	para "pourras pas en"
	line "venir à bout."
else
	text "Dragons are sacred"
	line "#MON."

	para "They are full of"
	line "life energy."

	para "If you're not"
	line "serious, you won't"

	para "be able to beat"
	line "them."
endc

	done

CooltrainerfLolaBeatenText: 
if DEF(_FR_FR)
	text "Bien joué!"
else
	text "Way to go!"
endc

	done

CooltrainerfLolaAfterBattleText: 
if DEF(_FR_FR)
	text "Les dragons sont"
	line "faibles face aux"
	cont "attaques de type"
	cont "DRAGON."
else
	text "Dragons are weak"
	line "against dragon-"
	cont "type moves."
endc

	done

BlackthornGymGuideText: ; TO TRANSLATE
	text "Yo! CHAMP in"
	line "making!"

	para "CLAIR uses the"
	line "mythical and sac-"
	cont "red dragon-type"
	cont "#MON."

	para "You can't damage"
	line "them very easily."

	para "But you know,"
	line "they're supposed"

	para "to be weak against"
	line "ice-type moves."
	done

BlackthornGymGuideWinText: 
if DEF(_FR_FR)
	text "Bien joué!"
	line "Beau combat!"

	para "Il ne reste plus"
	line "que le challenge"
	cont "de la LIGUE"
	cont "#MON."

	para "Tu es sur le"
	line "point de devenir"
	cont "MAITRE #MON!"
else
	text "You were great to"
	line "beat CLAIR!"

	para "All that's left is"
	line "the #MON LEAGUE"
	cont "challenge."

	para "You're on the way"
	line "to becoming the"
	cont "#MON CHAMPION!"
endc

	done

BlackthornGym1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, BLACKTHORN_CITY, 1
	warp_event  5, 17, BLACKTHORN_CITY, 1
	warp_event  1,  7, BLACKTHORN_GYM_2F, 1
	warp_event  7,  9, BLACKTHORN_GYM_2F, 2
	warp_event  2,  6, BLACKTHORN_GYM_2F, 3
	warp_event  7,  7, BLACKTHORN_GYM_2F, 4
	warp_event  7,  6, BLACKTHORN_GYM_2F, 5

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, BlackthornGymStatue
	bg_event  6, 15, BGEVENT_READ, BlackthornGymStatue

	def_object_events
	object_event  5,  3, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornGymClairScript, -1
	object_event  6,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermMike, -1
	object_event  1, 14, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermPaul, -1
	object_event  9,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainerfLola, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornGymGuideScript, -1
