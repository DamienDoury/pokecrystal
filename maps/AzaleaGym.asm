	object_const_def
	const AZALEAGYM_BUGSY
	const AZALEAGYM_BUG_CATCHER2
	const AZALEAGYM_BUG_CATCHER1
	const AZALEAGYM_BUG_CATCHER3
	const AZALEAGYM_TWIN1
	const AZALEAGYM_TWIN2
	const AZALEAGYM_GYM_GUIDE

AzaleaGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_BUGSY
	iftrue .no_check
	
	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall AzaleaGymCheckForbiddenTypes
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

	scall AzaleaGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked AZALEAGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked AZALEAGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp AZALEA_TOWN, 10, 15
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

AzaleaGymCheckForbiddenTypes:
	setval FIRE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval FLYING
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval ROCK
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

AzaleaGymBugsyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BUGSY
	iftrue .FightDone
	writetext BugsyText_INeverLose
	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, AZALEAGYM_BUGSY, 20
	opentext
	writetext AzaleaGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext BugsyText_INeverLoseSequel
	waitbutton
	closetext
	winlosstext BugsyText_ResearchIncomplete, 0
	loadtrainer BUGSY, BUGSY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BUGSY
	opentext
	writetext Text_ReceivedHiveBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_HIVEBADGE
.FightDone:
	checkitem TM_FURY_CUTTER
	iftrue .GotFuryCutter
	setevent EVENT_BEAT_TWINS_AMY_AND_MAY
	setevent EVENT_BEAT_BUG_CATCHER_BENNY
	setevent EVENT_BEAT_BUG_CATCHER_AL
	setevent EVENT_BEAT_BUG_CATCHER_JOSH
	scall NewBadgeObedienceNotification
	writetext BugsyText_HiveBadgeSpeech
	promptbutton
	verbosegiveitem TM_FURY_CUTTER
	iffalse .NoRoomForFuryCutter
	writetext BugsyText_FuryCutterSpeech
	waitbutton
	closetext
	end

.GotFuryCutter:
	writetext BugsyText_BugMonsAreDeep
	waitbutton
.NoRoomForFuryCutter:
	closetext
	end

TrainerTwinsAmyandmay1:
	trainer TWINS, AMYANDMAY1, EVENT_BEAT_TWINS_AMY_AND_MAY, TwinsAmyandmay1SeenText, TwinsAmyandmay1BeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	jumptextfaceplayer TwinsAmyandmay1AfterBattleText

TrainerTwinsAmyandmay2:
	trainer TWINS, AMYANDMAY2, EVENT_BEAT_TWINS_AMY_AND_MAY, TwinsAmyandmay2SeenText, TwinsAmyandmay2BeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	jumptextfaceplayer TwinsAmyandmay2AfterBattleText

TrainerBugCatcherBenny:
	trainer BUG_CATCHER, BUG_CATCHER_BENNY, EVENT_BEAT_BUG_CATCHER_BENNY, BugCatcherBennySeenText, BugCatcherBennyBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	jumptextfaceplayer BugCatcherBennyAfterBattleText

TrainerBugCatcherAl:
	trainer BUG_CATCHER, AL, EVENT_BEAT_BUG_CATCHER_AL, BugCatcherAlSeenText, BugCatcherAlBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	jumptextfaceplayer BugCatcherAlAfterBattleText

TrainerBugCatcherJosh:
	trainer BUG_CATCHER, JOSH, EVENT_BEAT_BUG_CATCHER_JOSH, BugCatcherJoshSeenText, BugCatcherJoshBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	jumptextfaceplayer BugCatcherJoshAfterBattleText

AzaleaGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_BUGSY
	iftrue .AzaleaGymGuideWinScript
	opentext
	writetext AzaleaGymGuideText
	waitbutton
	closetext
	end

.AzaleaGymGuideWinScript:
	opentext
	writetext AzaleaGymGuideWinText
	waitbutton
	closetext
	end

AzaleaGymStatue:
	checkflag ENGINE_HIVEBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, BUGSY, BUGSY1
	jumpstd GymStatue2Script

NewBadgeObedienceNotification:
	readvar VAR_BADGES
	ifgreater 8, .end
	
	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel

	readvar VAR_BADGES
	ifequal 8, .obey100
	ifequal 7, .obey60
	ifequal 5, .obey50
	ifequal 3, .obey40
	ifequal 1, .obey30
.end
	end

.obey100
	clearevent EVENT_EXPLAIN_SHORTAGE_MECHANICS
	specialphonecall SPECIALCALL_WORK_VISA

	farwritetext Obey100
	promptbutton
	end

.obey60
	farwritetext Obey60
	promptbutton
	end

.obey50
	setevent EVENT_FIRST_CURFEW_STARTED
	specialphonecall SPECIALCALL_CURFEW_STARTED

	farwritetext Obey50
	promptbutton
	end

.obey40
	farwritetext Obey40
	promptbutton
	end

.obey30
	writetext Obey30
	promptbutton
	end


BugsyText_INeverLose: ; TO TRANSLATE
	text "I'm BUGSY!"
	line "I never lose when"

	para "it comes to bug"
	line "#MON."
	done

BugsyText_INeverLoseSequel: ; TO TRANSLATE
	text "My research is"
	line "going to make me"

	para "the authority on"
	line "bug #MON!"

	para "You know, ILEX"
	line "FOREST is full of"
	cont "#MON webs."

	para "An expert like me"
	line "knows how to react"
	cont "if my #MON"
	cont "ever got stuck"
	cont "into one!"

	para "Will you?"
	done

AzaleaGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

BugsyText_ResearchIncomplete: 
if DEF(_FR_FR)
	text "Whaou, dingue!"
	line "Tu connais bien"
	cont "les #MON!"

	para "Mes recherches ne"
	line "sont pas finies."

	para "OK, tu as gagné."
	line "Prends ce BADGE."
else
	text "Whoa, amazing!"
	line "You're an expert"
	cont "on #MON!"

	para "My research isn't"
	line "complete yet."

	para "OK, you win. Take"
	line "this BADGE."
endc

	done

Text_ReceivedHiveBadge: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE ESSAIM."
else
	text "<PLAYER> received"
	line "HIVEBADGE."
endc

	done

Obey30: ; TO TRANSLATE
	text "With this first"
	line "badge in hand,"
	
	para "#MON up to L30"
	line "will obey you."
	done

BugsyText_HiveBadgeSpeech: ; TO TRANSLATE
	text "Here, I also want"
	line "you to have this."
	done

BugsyText_FuryCutterSpeech: 
if DEF(_FR_FR)
	text "La CT49 contient"
	line "TAILLADE."

	para "Si tu ne manques"
	line "pas ton coup,"
	cont "la puissance au-"
	cont "gmente à chaque"
	cont "tour."

	para "Plus le combat est"
	line "long, plus le coup"
	cont "est puissant."

	para "C'est pas super"
	line "ça? Et c'est moi"
	cont "qui l'ai trouvée!"
else
	text "TM49 contains"
	line "FURY CUTTER."

	para "If you don't miss,"
	line "it gets stronger"
	cont "every turn."

	para "The longer your"
	line "battle goes, the"
	cont "better it gets."

	para "Isn't that great?"
	line "I discovered it!"
endc

	done

BugsyText_BugMonsAreDeep: 
if DEF(_FR_FR)
	text "Les #MON"
	line "insecte ont des"

	para "talents cachés. Il"
	line "faudra encore du"
	cont "temps pour tous"
	cont "les découvrir."

	para "Etudie-les"
	line "minutieusement."
else
	text "Bug #MON are"
	line "deep. There are"

	para "many mysteries to"
	line "be explored."

	para "Study your favor-"
	line "ites thoroughly."
endc

	done

BugCatcherBennySeenText: 
if DEF(_FR_FR)
	text "Les #MON"
	line "insecte évoluent"

	para "rapidement. Ils"
	line "deviennent forts"
	cont "plus vite."
else
	text "Bug #MON evolve"
	line "young. So they get"

	para "stronger that much"
	line "faster."
endc

	done

BugCatcherBennyBeatenText: 
if DEF(_FR_FR)
	text "Faire évoluer un"
	line "#MON n'est pas"
	cont "suffisant!"
else
	text "Just evolving"
	line "isn't enough!"
endc

	done

BugCatcherBennyAfterBattleText: 
if DEF(_FR_FR)
	text "Les #MON"
	line "deviennent plus"
	cont "forts en évoluant!"
else
	text "#MON become"
	line "stronger if they"
	cont "evolve. Really!"
endc

	done

BugCatcherAlSeenText: 
if DEF(_FR_FR)
	text "Les #MON"
	line "insecte sont trop"

	para "cool et trop"
	line "résistants! Je"
	cont "vais trop te le"
	cont "prouver!"
else
	text "Bug #MON are"
	line "cool and tough!"

	para "I'll prove it to"
	line "you!"
endc

	done

BugCatcherAlBeatenText: 
if DEF(_FR_FR)
	text "T'as prouvé à"
	line "quel point t'es"
	cont "balèze!..."
else
	text "You proved how"
	line "tough you are…"
endc

	done

BugCatcherAlAfterBattleText: 
if DEF(_FR_FR)
	text "Ils sont trop"
	line "cool mais la"

	para "plupart des filles"
	line "n'aiment pas les"
	cont "#MON insecte."

	para "Je ne sais pas"
	line "pourquoi..."
else
	text "They're so cool,"
	line "but most girls"

	para "don't like bug"
	line "#MON."

	para "I don't know why…"
endc

	done

BugCatcherJoshSeenText: 
if DEF(_FR_FR)
	text "Tu as sauvé tous"
	line "les RAMOLOSS? T'es"
	cont "super balèze toi!"

	para "Mais mes #MON"
	line "adultes sont aussi"
	cont "un peu balèzes je"
	cont "crois!"
else
	text "You saved all the"
	line "SLOWPOKE? Whew,"
	cont "you're mighty!"

	para "But my grown-up"
	line "#MON are pretty"
	cont "tough too!"
endc

	done

BugCatcherJoshBeatenText: 
if DEF(_FR_FR)
	text "Aarrgggh!"
else
	text "Urrgggh!"
endc

	done

BugCatcherJoshAfterBattleText: 
if DEF(_FR_FR)
	text "Je crois que j'ai"
	line "oublié de leur"
	cont "apprendre un truc!"
else
	text "I guess I should"
	line "teach them better"
	cont "moves…"
endc

	done

TwinsAmyandmay1SeenText: 
if DEF(_FR_FR)
	text "PIM: Salut!"
	line "Tu veux battre le"
	cont "CHAMPION? Oh non!"
else
	text "AMY: Hi! Are you"
	line "challenging the"
	cont "LEADER? No way!"
endc

	done

TwinsAmyandmay1BeatenText: 
if DEF(_FR_FR)
	text "PIM & PAM: Oh,"
	line "double zut!"
else
	text "AMY & MAY: Oh,"
	line "double goodness!"
endc

	done

TwinsAmyandmay1AfterBattleText: 
if DEF(_FR_FR)
	text "PIM: Et paf!"
else
	text "AMY: You're"
	line "really strong!"
endc

	done

TwinsAmyandmay2SeenText: 
if DEF(_FR_FR)
	text "PAM: Tu veux voir"
	line "le CHAMPION?"
	cont "Pas tout de suite!"
else
	text "MAY: You want to"
	line "see the LEADER?"
	cont "We come first!"
endc

	done

TwinsAmyandmay2BeatenText: ; TO TRANSLATE
	text "MAY & AMY: Oh,"
	line "double goodness!"
	done

TwinsAmyandmay2AfterBattleText: ; TO TRANSLATE
	text "MAY: Our BUG #-"
	line "MON lost! Oh, what"
	cont "a shame."
	done

AzaleaGymGuideText: 
if DEF(_FR_FR)
	text "Yo, toi!"

	para "HECTOR est jeune"
	line "mais ses connais-"

	para "sances en matière"
	line "de #MON sont"
	cont "vastes."

	para "Ca risque d'être"
	line "difficile sans mes"
	cont "conseils."

	para "Voyons voir... Les"
	line "#MON insecte"
	cont "sont vulnérables"
	cont "au feu."

	para "Les attaques des"
	line "#MON volants"
	cont "sont aussi très"
	cont "efficaces."
else
	text "Yo, challenger!"

	para "BUGSY's young, but"
	line "his knowledge of"

	para "bug #MON is for"
	line "real."

	para "It's going to be"
	line "tough without my"
	cont "advice."

	para "Let's see… Bug"
	line "#MON don't like"
	cont "fire."

	para "Flying-type moves"
	line "are super-effec-"
	cont "tive too."
endc

	done

AzaleaGymGuideWinText: 
if DEF(_FR_FR)
	text "Bien joué! Voilà"
	line "une bonne leçon."

	para "Avec des gens"
	line "comme toi, l'ave-"
	cont "nir des #MON"
	cont "sera brillant!"
else
	text "Well done! That"
	line "was a great clash"

	para "of talented young"
	line "trainers."

	para "With people like"
	line "you, the future of"
	cont "#MON is bright!"
endc

	done

AzaleaGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, AZALEA_TOWN, 5
	warp_event  5, 15, AZALEA_TOWN, 5

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, AzaleaGymStatue
	bg_event  6, 13, BGEVENT_READ, AzaleaGymStatue

	def_object_events
	object_event  5,  7, SPRITE_BUGSY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaGymBugsyScript, -1
	object_event  8,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherAl, -1
	object_event  5,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBugCatcherBenny, -1
	object_event  0,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherJosh, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAmyandmay1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAmyandmay2, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaGymGuideScript, -1
