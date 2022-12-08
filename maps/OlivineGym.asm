	object_const_def
	const OLIVINEGYM_JASMINE
	const OLIVINEGYM_GYM_GUIDE

OlivineGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_DEFAULT
	scene_script .TeamCheck ; SCENE_FINISHED

	def_callbacks

.TeamCheck:
	checkevent EVENT_BEAT_JASMINE
	iftrue .no_check

	checkevent EVENT_OLIVINE_GYM_JASMINE
	iftrue .no_check

	setval EGG
	special FindPartyMonThatSpecies
	iftrue .egg_found

	setval GROUND
	special CheckTypePresenceInParty
	iftrue .do_check
	setval FIRE
	special CheckTypePresenceInParty
	iftrue .do_check
	setval FIGHTING
	special CheckTypePresenceInParty
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

OlivineGymJasmineScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .FightDone
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
	setflag ENGINE_MINERALBADGE
	scall CheckWorkVisaCall
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue .GotIronTail
	writetext Jasmine_BadgeSpeech
	promptbutton
	verbosegiveitem TM_IRON_TAIL
	iffalse .NoRoomForIronTail
	setevent EVENT_GOT_TM23_IRON_TAIL
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
.NoRoomForIronTail:
	closetext
	end

CheckWorkVisaCall:
	readvar VAR_BADGES
	ifequal 8, .WorkVisaCall
	end

.WorkVisaCall:
	specialphonecall SPECIALCALL_MASTERBALL
	end 
	
CheckRocketsActivation:
	loadmem wTempByteValue, 0
	checkevent EVENT_ICE_PATH_EXPLORED ; This event is set only once, when Ice Path B2F Mahogany side has been reached.
	iffalse .skipAdd1
	loadmem wTempByteValue, 1
.skipAdd1
	checkevent EVENT_JASMINE_RETURNED_TO_GYM ; This event is set only once, when Amphy's mission is done.
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

Jasmine_SteelTypeIntroText:
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
	done

Jasmine_SteelTypeIntroSequelText:
	text "I will test you to"
	line "see how well you"

	para "do when your team"
	line "is outnumbered."
	done

OlivineGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

Jasmine_TeamTooBigText:
	text "…You can have"
	line "up to 3 #MON."

	para "Please go deposit"
	line "some into a PC."
	done

Jasmine_ValidatesTeamText:
	text "…Um… May I begin?"
	done

Jasmine_BetterTrainer:
	text "…You are a better"
	line "trainer than me,"

	para "in both skill and"
	line "kindness."

	para "In accordance with"
	line "LEAGUE rules, I"

	para "confer upon you"
	line "this BADGE."
	done

Text_ReceivedMineralBadge:
	text "<PLAYER> received"
	line "MINERALBADGE."
	done

Jasmine_BadgeSpeech:
	text "…Um… Please take"
	line "this too…"
	done

Text_ReceivedTM09: ; unreferenced
	text "<PLAYER> received"
	line "TM09."
	done

Jasmine_IronTailSpeech:
	text "…You could use"
	line "that TM to teach"
	cont "IRON TAIL."
	done

Jasmine_GoodLuck:
	text "Um… I don't know"
	line "how to say this,"
	cont "but good luck…"
	done

OlivineGymGuideText:
	text "JASMINE uses the"
	line "newly discovered"
	cont "steel-type."

	para "I don't know very"
	line "much about it."
	done

OlivineGymGuideWinText:
	text "That was awesome."

	para "The steel-type,"
	line "huh?"

	para "That was a close"
	line "encounter of an"
	cont "unknown kind!"
	done

OlivineGymGuidePreText:
	text "JASMINE, the GYM"
	line "LEADER, is at the"
	cont "LIGHTHOUSE."

	para "She's been tending"
	line "to a sick #MON."

	para "A strong trainer"
	line "has to be compas-"
	cont "sionate."
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
