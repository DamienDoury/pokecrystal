	object_const_def
	const OLIVINEGYM_JASMINE
	const OLIVINEGYM_GYM_GUIDE

OlivineGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_JASMINE
	iftrue .no_check

	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall OlivineGymCheckForbiddenTypes
	iffalse .enter_check

	callstd GymKickPlayerOutAfterEvolution
	sjump .player_leaves

.enter_check
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .no_check
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	checkevent EVENT_OLIVINE_GYM_JASMINE
	iftrue .no_check

	setval EGG
	special FindPartyMonThatSpecies
	iftrue .egg_found

	scall OlivineGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked OLIVINEGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked OLIVINEGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp OLIVINE_CITY, 10, 11
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

OlivineGymCheckForbiddenTypes:
	setval GROUND
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval FIRE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval FIGHTING
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

OlivineGymJasmineScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .GotIronTail
	writetext Jasmine_SteelTypeIntroText

	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	promptbutton
	closetext
	showemote EMOTE_QUESTION, OLIVINEGYM_JASMINE, 20
	opentext
	writetext OlivineGymPowerRestrainerExplanation
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained
	promptbutton
	writetext Jasmine_SteelTypeIntroSequelText
	promptbutton
	readvar VAR_PARTYCOUNT
	ifgreater 3, .TeamTooBig
	writetext Jasmine_ValidatesTeamText
	waitbutton
	closetext
	winlosstext Jasmine_BetterTrainer, 0
	loadtrainer JASMINE, JASMINE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JASMINE
	opentext
	writetext Text_ReceivedMineralBadge
	playsound SFX_GET_BADGE
	waitsfx
	readmem wYearMonth
	addval 1
	writemem wYearMonth
	setflag ENGINE_MINERALBADGE
	farscall NewBadgeObedienceNotification
	writetext Jasmine_BadgeSpeech
	promptbutton
	verbosegiveitem TM_IRON_TAIL
	writetext Jasmine_IronTailSpeech
	waitbutton
	closetext
	end

.TeamTooBig:
	writetext Jasmine_TeamTooBigText
	waitbutton
	closetext
	end

.GotIronTail:
	writetext Jasmine_GoodLuck
	waitbutton
	closetext
	end
	
CheckRocketsActivation:
	loadmem wTempByteValue, 0
	checkevent EVENT_ICE_PATH_EXPLORED ; This event is set only once, when Ice Path B3F has been reached (which requires Strength, and therefore Surf).
	iffalse .skipAdd1
	loadmem wTempByteValue, 1
.skipAdd1
	checkevent EVENT_JASMINE_RETURNED_TO_GYM ; This event is set only once, when Amphy's mission is done (which requires Surf).
	iffalse .skipAdd2 

	readmem wTempByteValue
	addval 1
	writemem wTempByteValue

.skipAdd2
	readmem wTempByteValue
	loadmem wTempByteValue, 0
	ifequal 2, .RadioTowerRockets
	ifequal 1, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

OlivineGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_JASMINE
	iftrue .OlivineGymGuideWinScript
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse .OlivineGymGuidePreScript
	opentext
	writetext OlivineGymGuideText
	waitbutton
	closetext
	end

.OlivineGymGuideWinScript:
	opentext
	writetext OlivineGymGuideWinText
	waitbutton
	closetext
	end

.OlivineGymGuidePreScript:
	opentext
	writetext OlivineGymGuidePreText
	waitbutton
	closetext
	end

OlivineGymStatue:
	checkflag ENGINE_MINERALBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, JASMINE, JASMINE1
	jumpstd GymStatue2Script

OlivineGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

Jasmine_SteelTypeIntroText:
if DEF(_FR_FR)
	text "...Merci pour ton"
	line "aide au PHARE..."

	para "Mais c'est un peu"
	line "différent."

	para "Permets-moi de me"
	line "présenter."

	para "Je suis JASMINE la"
	line "CHAMPIONNE d'ARENE"
	cont "et j'utilise les"
	cont "#MON de type"
	cont "ACIER."
else
	text "…Thank you for"
	line "your help at the"
	cont "LIGHTHOUSE…"

	para "But this is"
	line "different."

	para "Please allow me to"
	line "introduce myself."

	para "I am JASMINE, a"
	line "GYM LEADER. I use"
	cont "the steel-type."
endc
	done

Jasmine_SteelTypeIntroSequelText:
if DEF(_FR_FR)
	text "Je vais tester ta"
	line "performance quand"
	
	para "ton équipe est"
	line "en infériorité"
	cont "numérique."
else
	text "I will test you to"
	line "see how well you"

	para "do when your team"
	line "is outnumbered."
endc
	done

Jasmine_TeamTooBigText:
if DEF(_FR_FR)
	text "...Tu n'as droit"
	line "qu'à 3 #MON."

	para "Va en déposer"
	line "dans un PC."
else
	text "…You can have"
	line "up to 3 #MON."

	para "Please go deposit"
	line "some into a PC."
endc
	done

Jasmine_ValidatesTeamText:
if DEF(_FR_FR)
	text "Hum...? Je peux"
	line "commencer?"
else
	text "…Um… May I begin?"
endc
	done

Jasmine_BetterTrainer: 
if DEF(_FR_FR)
	text "...Bon bah t'es"
	line "meilleur dresseur"

	para "que moi, en"
	line "compétence et en"
	cont "gentillesse."

	para "En accord avec les"
	line "règles de la"

	para "LIGUE, je te"
	line "confie ce BADGE."
else
	text "…You are a better"
	line "trainer than me,"

	para "in both skill and"
	line "kindness."

	para "In accordance with"
	line "LEAGUE rules, I"

	para "confer upon you"
	line "this BADGE."
endc

	done

Text_ReceivedMineralBadge: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGEMINERAL."
else
	text "<PLAYER> received"
	line "MINERALBADGE."
endc

	done

Jasmine_BadgeSpeech:
if DEF(_FR_FR)
	text "Prends donc ceci"
	line "aussi..."
else
	text "…Um… Please take"
	line "this too…"
endc
	done

Jasmine_IronTailSpeech: 
if DEF(_FR_FR)
	text "Tu peux utiliser"
	line "cette CT pour"
	cont "apprendre QUEUE DE"
	cont "FER à un #MON."
else
	text "…You could use"
	line "that TM to teach"
	cont "IRON TAIL."
endc

	done

Jasmine_GoodLuck: 
if DEF(_FR_FR)
	text "Hum... Je ne sais"
	line "comment dire..."
	cont "Mais bonne chance!"
else
	text "Um… I don't know"
	line "how to say this,"
	cont "but good luck…"
endc

	done

OlivineGymGuideText: 
if DEF(_FR_FR)
	text "JASMINE utilise le"
	line "tout nouveau type"
	cont "ACIER."

	para "Je ne sais pas"
	line "grand chose là-"
	cont "dessus."
else
	text "JASMINE uses the"
	line "newly discovered"
	cont "steel-type."

	para "I don't know very"
	line "much about it."
endc

	done

OlivineGymGuideWinText: 
if DEF(_FR_FR)
	text "C'est très étrange"

	para "le type ACIER,"
	line "hein?"

	para "C'est la rencon-"
	line "tre d'un nouveau"
	cont "genre!"
else
	text "That was awesome."

	para "The steel-type,"
	line "huh?"

	para "That was a close"
	line "encounter of an"
	cont "unknown kind!"
endc

	done

OlivineGymGuidePreText: 
if DEF(_FR_FR)
	text "JASMINE, la"
	line "CHAMPIONNE d'ARENE"
	cont "est au PHARE."

	para "Elle s'occupe du"
	line "#MON malade."

	para "Un dresseur"
	line "puissant doit"
	cont "avoir un coeur"
	cont "charitable et être"
	cont "bienveillant."
else
	text "JASMINE, the GYM"
	line "LEADER, is at the"
	cont "LIGHTHOUSE."

	para "She's been tending"
	line "to a sick #MON."

	para "A strong trainer"
	line "has to be compas-"
	cont "sionate."
endc

	done

OlivineGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, OlivineGymStatue
	bg_event  6, 13, BGEVENT_READ, OlivineGymStatue

	def_object_events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymJasmineScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymGuideScript, -1
