	object_const_def
	const GOLDENRODGYM_WHITNEY
	const GOLDENRODGYM_MILTANK
	const GOLDENRODGYM_LASS1
	const GOLDENRODGYM_LASS2
	const GOLDENRODGYM_BEAUTY1
	const GOLDENRODGYM_BEAUTY2
	const GOLDENRODGYM_GYM_GUIDE

GoldenrodGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_WHITNEY
	iftrue .no_check
	
	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall GoldenrodGymCheckForbiddenTypes
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

	scall GoldenrodGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked GOLDENRODGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked GOLDENRODGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp GOLDENROD_CITY, 24, 7
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

GoldenrodGymCheckForbiddenTypes:
	setval FIGHTING
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end


GoldenrodGymWhitneyScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .FightDone
	opentext
	writetext WhitneyBeforeText
	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, GOLDENRODGYM_WHITNEY, 10
	showemote EMOTE_QUESTION, GOLDENRODGYM_MILTANK, 10
	opentext
	writetext GoldenrodGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext WhitneySequelText
	promptbutton
	special CheckCuteParty
	iffalse .PartyIsNotCute
	writetext WhitneyValidsCutenessText
	waitbutton
	closetext
	winlosstext WhitneyShouldntBeSoSeriousText, 0
	loadtrainer WHITNEY, WHITNEY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_MADE_WHITNEY_CRY
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	setevent EVENT_BEAT_LASS_CARRIE
	setevent EVENT_BEAT_LASS_BRIDGET
.FightDone:
	opentext
	checkevent EVENT_MADE_WHITNEY_CRY
	iffalse .StoppedCrying
	writetext WhitneyYouMeanieText
	waitbutton
	closetext
	end

.PartyIsNotCute:
	waitbutton
	closetext
	end

.StoppedCrying:
	checkevent EVENT_GOT_TM45_ATTRACT
	iftrue .GotAttract
	checkflag ENGINE_PLAINBADGE
	iftrue .GotPlainBadge
	writetext WhitneyWhatDoYouWantText
	promptbutton
	waitsfx
	writetext PlayerReceivedPlainBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_PLAINBADGE
.GotPlainBadge:
	writetext WhitneyPlainBadgeText
	promptbutton
	farscall NewBadgeObedienceNotification
	writetext WhitneyPlainBadgeText2
	promptbutton
	verbosegiveitem TM_ATTRACT
	iffalse .NoRoomForAttract
	setevent EVENT_GOT_TM45_ATTRACT
	writetext WhitneyAttractText
	waitbutton
	closetext
	end

.GotAttract:
	writetext WhitneyGoodCryText
	waitbutton
.NoRoomForAttract:
	closetext
	end

TrainerLassCarrie:
	trainer LASS, CARRIE, EVENT_BEAT_LASS_CARRIE, LassCarrieSeenText, LassCarrieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassCarrieAfterBattleText
	waitbutton
	closetext
	end

WhitneyCriesScript:
	showemote EMOTE_SHOCK, GOLDENRODGYM_LASS2, 15
	turnobject PLAYER, RIGHT
	opentext
	writetext BridgetWhitneyCriesText
	waitbutton
	closetext
	clearevent EVENT_MADE_WHITNEY_CRY
	end

TrainerLassBridget:
	trainer LASS, BRIDGET, EVENT_BEAT_LASS_BRIDGET, LassBridgetSeenText, LassBridgetBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassBridgetAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautyVictoria:
	trainer BEAUTY, VICTORIA, EVENT_BEAT_BEAUTY_VICTORIA, BeautyVictoriaSeenText, BeautyVictoriaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautyVictoriaAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautySamantha:
	trainer BEAUTY, SAMANTHA, EVENT_BEAT_BEAUTY_SAMANTHA, BeautySamanthaSeenText, BeautySamanthaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautySamanthaAfterBattleText
	waitbutton
	closetext
	end

GoldenrodGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .GoldenrodGymGuideWinScript
	opentext
	writetext GoldenrodGymGuideText
	waitbutton
	closetext
	end

.GoldenrodGymGuideWinScript:
	opentext
	writetext GoldenrodGymGuideWinText
	waitbutton
	closetext
	end

GoldenrodGymStatue:
	checkflag ENGINE_PLAINBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, WHITNEY, WHITNEY1
	jumpstd GymStatue2Script

GoldenrodGymMiltankScript:
	opentext
	writetext GoldenrodGymMiltankText
	cry MILTANK
	pause 5
	cry MILTANK
	waitbutton
	closetext
	end

WhitneyBeforeText: ; TO TRANSLATE
	text "Hi! I'm WHITNEY!"
	done

WhitneySequelText: ; TO TRANSLATE
	text "Everyone was into"
	line "#MON, so I got"
	cont "into it too!"

	para "#MON are"
	line "super-cute!"

	para "My grand-parents"
	line "run a DAY-CARE"
	cont "service and"

	para "I love playing"
	line "with their lovely"
	cont "baby #MON!"

	para "I am here to test"
	line "your ability with"
	cont "cute #MON!"
	
	para "Let me see your"
	line "party."

	para "……"
	line "……"
	done

WhitneyValidsCutenessText: ; TO TRANSLATE
	text "Oooh! Your team"
	line "is so cuuuute--!"

	para "You want to bat-"
	line "tle? I'm warning"
	cont "you--I'm good!"
	done

GoldenrodGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

WhitneyShouldntBeSoSeriousText: 
if DEF(_FR_FR)
	text "Sniff-sniff..."

	para "...Waaaaaaah!"
	line "T'es un peu nul!"

	para "Tu ne devrais pas"
	line "te prendre au"
	cont "sérieux! Tu es"
	cont "très jeune après"
	cont "tout!"
else
	text "Sob…"

	para "…Waaaaaaah!"
	line "You're mean!"

	para "You shouldn't be"
	line "so serious! You…"
	cont "you child, you!"
endc

	done

WhitneyYouMeanieText: 
if DEF(_FR_FR)
	text "Waouaouah!"

	para "Waaaaah!"

	para "Sniff et re-sniff"
	line "...T'es pas cool!"
else
	text "Waaaaah!"

	para "Waaaaah!"

	para "…Snivel, hic…"
	line "…You meanie!"
endc

	done

WhitneyWhatDoYouWantText: 
if DEF(_FR_FR)
	text "...sniff..."

	para "Quoi? Qu'est-ce"
	line "que tu veux?"
	cont "Un BADGE?"

	para "Oh, d'accord."
	line "J'avais oublié."
	cont "Prends le BADGE"
	cont "PLAINE."
else
	text "…Sniff…"

	para "What? What do you"
	line "want? A BADGE?"

	para "Oh, right."
	line "I forgot. Here's"
	cont "PLAINBADGE."
endc

	done

PlayerReceivedPlainBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE PLAINE."
else
	text "<PLAYER> received"
	line "PLAINBADGE."
endc

	done

WhitneyPlainBadgeText: ; TO TRANSLATE
	text "PLAINBADGE isn't"
	line "given to a lot"
	cont "trainers."
	done

WhitneyPlainBadgeText2: ; TO TRANSLATE
	text "Oh, you can have"
	line "this too!"
	done

WhitneyAttractText: 
if DEF(_FR_FR)
	text "C'est ATTRACTION!"
	line "Cela développe le"

	para "charme et le pou-"
	line "voir d'attraction"
	cont "des #MON."

	para "N'est-ce pas en"
	line "parfaite harmonie"
	cont "avec mon gentil"
	cont "caractère?"
else
	text "It's ATTRACT!"
	line "It makes full use"

	para "of a #MON's"
	line "charm."

	para "Isn't it just per-"
	line "fect for a cutie"
	cont "like me?"
endc

	done

WhitneyGoodCryText: 
if DEF(_FR_FR)
	text "Ah, ça fait du"
	line "bien de pleurer!"

	para "Reviens-me voir"
	line "quand tu veux!"
	cont "Tchao!"
else
	text "Ah, that was a"
	line "good cry!"

	para "Come for a visit"
	line "again! Bye-bye!"
endc

	done

LassCarrieSeenText: 
if DEF(_FR_FR)
	text "Y sont mignons"
	line "mes #MON!"

	para "Y sont terribles"
	line "itou!"
else
	text "Don't let my"
	line "#MON's cute"

	para "looks fool you."
	line "They can whip you!"
endc

	done

LassCarrieBeatenText: 
if DEF(_FR_FR)
	text "Zut... Je croyais"
	line "que tu étais"
	cont "faible..."
else
	text "Darn… I thought"
	line "you were weak…"
endc

	done

LassCarrieAfterBattleText: 
if DEF(_FR_FR)
	text "Et moi, j'suis"
	line "mimi?"
else
	text "Do my #MON"
	line "think I'm cute?"
endc

	done

LassBridgetSeenText: 
if DEF(_FR_FR)
	text "Je préfère les"
	line "#MON mignons"
	cont "plutôt que les"
	cont "#MON forts."

	para "Mais j'en ai un"
	line "multifonction, il"
	cont "est mignon et fort"
	cont "à la fois!"
else
	text "I like cute #-"
	line "MON better than"
	cont "strong #MON."

	para "But I have strong"
	line "and cute #MON!"
endc

	done

LassBridgetBeatenText: 
if DEF(_FR_FR)
	text "Oh, non, non, non!"
else
	text "Oh, no, no, no!"
endc

	done

LassBridgetAfterBattleText: 
if DEF(_FR_FR)
	text "J'essaie de battre"
	line "BLANCHE mais..."
	cont "C'est déprimant."

	para "Je suis relax! Si"
	line "je perds, je"

	para "travaillerai dur"
	line "pour la prochaine"
	cont "fois!"
else
	text "I'm trying to beat"
	line "WHITNEY, but…"
	cont "It's depressing."

	para "I'm okay! If I"
	line "lose, I'll just"

	para "try harder next"
	line "time!"
endc

	done

BridgetWhitneyCriesText: 
if DEF(_FR_FR)
	text "Oh, non. Tu as"
	line "fait pleurer"
	cont "BLANCHE."

	para "C'est bon, elle va"
	line "bientôt se calmer."

	para "Elle pleure à"
	line "chaque fois"
	cont "qu'elle perd."
else
	text "Oh, no. You made"
	line "WHITNEY cry."

	para "It's OK. She'll"
	line "stop soon. She"

	para "always cries when"
	line "she loses."
endc

	done

BeautyVictoriaSeenText: 
if DEF(_FR_FR)
	text "Oh, tu es un sacré"
	line "numéro, toi!"

	para "Mimi en plus!"
	line "Je t'aime bien"
	cont "mais tu ne passe-"
	cont "ras pas comme ça!"
else
	text "Oh, you are a cute"
	line "little trainer! "

	para "I like you, but I"
	line "won't hold back!"
endc

	done

BeautyVictoriaBeatenText: 
if DEF(_FR_FR)
	text "Voyons voir..."
	line "Oups, c'est fini?"
else
	text "Let's see… Oops,"
	line "it's over?"
endc

	done

BeautyVictoriaAfterBattleText: 
if DEF(_FR_FR)
	text "Whaou, tu dois"
	line "être cool pour me"
	cont "battre comme ça!"
	cont "Continue!"
else
	text "Wow, you must be"
	line "good to beat me!"
	cont "Keep it up!"
endc

	done

BeautySamanthaSeenText: 
if DEF(_FR_FR)
	text "Fais de ton mieux"
	line "ou je t'aurai!"
else
	text "Give it your best"
	line "shot, or I'll take"
	cont "you down!"
endc

	done

BeautySamanthaBeatenText: 
if DEF(_FR_FR)
	text "Noon! Oh, MIAOUSS,"
	line "je suis désolée!"
else
	text "No! Oh, MEOWTH,"
	line "I'm so sorry!"
endc

	done

BeautySamanthaAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai appris à"
	line "MIAOUSS des"
	cont "attaques pour"
	cont "parer chaque type."
else
	text "I taught MEOWTH"
	line "moves for taking"
	cont "on any type…"
endc

	done

GoldenrodGymGuideText: ; TO TRANSLATE
	text "Yo! CHAMP in"
	line "making!"

	para "This GYM is home"
	line "to normal-type"
	cont "#MON trainers."

	para "WHITNEY only"
	line "trains cute"
	cont "#MON."

	para "She considers a"
	line "#MON cute if it"
	cont "is a baby or evo-"
	cont "lution of a baby,"
	
	para "as long as it is"
	line "up to 1 meter or"
	cont "3'3” feet tall."

	para "She also has a"
	line "thing for pink."

	para "She will tolerate"
	line "a height of up to"
	cont "1.2 meter or"
	cont "3'11” feet for"
	cont "pink #MON."
	done

GoldenrodGymGuideWinText: 
if DEF(_FR_FR)
	text "T'as gagné? Super!"
	line "J'étais occupé à"
	cont "mater ces jolies"
	cont "filles."
else
	text "You won? Great! I"
	line "was busy admiring"
	cont "the ladies here."
endc

	done

GoldenrodGymMiltankText: ; TO TRANSLATE
	text "MILTANK:"
	line "Moo! MOO!"
	done

GoldenrodGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 17, GOLDENROD_CITY, 1
	warp_event  3, 17, GOLDENROD_CITY, 1

	def_coord_events
	coord_event  8,  6, CE_EVENT_FLAG_SET, EVENT_MADE_WHITNEY_CRY, WhitneyCriesScript

	def_bg_events
	bg_event  1, 15, BGEVENT_READ, GoldenrodGymStatue
	bg_event  4, 15, BGEVENT_READ, GoldenrodGymStatue

	def_object_events
	object_event  8,  3, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodGymWhitneyScript, -1
	object_event  9,  3, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodGymMiltankScript, -1
	object_event  9, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerLassCarrie, -1
	object_event 10,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerLassBridget, -1
	object_event  0,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBeautyVictoria, -1
	object_event 19,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBeautySamantha, -1
	object_event  5, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymGuideScript, -1
