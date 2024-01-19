	object_const_def
	const VIRIDIANGYM_BLUE
	const VIRIDIANGYM_GYM_GUIDE

ViridianGym_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianGymBlueScript:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftrue .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, BLUE1
	startbattle
	reloadmapafterbattle
	farscall AugmentKantoDifficultyLevel
	setevent EVENT_BEAT_BLUE
	opentext
	writetext Text_ReceivedEarthBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_EARTHBADGE
	writetext LeaderBlueAfterText
	waitbutton
	closetext
	end

.FightDone:
	checkevent EVENT_RED_BEATEN
	iffalse .RedBeaten
	writetext LeaderBlueEpilogueText
	.end:
	waitbutton
	closetext
	end

.RedBeaten:
	writetext LeaderBlueRivalText
	sjump .end

ViridianGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BLUE
	iftrue .ViridianGymGuideWinScript
	writetext ViridianGymGuideText
	waitbutton
	closetext
	turnobject VIRIDIANGYM_GYM_GUIDE, UP
	pause 5
	showemote EMOTE_HEART, VIRIDIANGYM_GYM_GUIDE, 20
	end

.ViridianGymGuideWinScript:
	writetext ViridianGymGuideWinText
	waitbutton
	closetext
	end

ViridianGymStatue:
	checkflag ENGINE_EARTHBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script

.Beaten:
	gettrainername STRING_BUFFER_4, BLUE, BLUE1
	jumpstd GymStatue2Script

LeaderBlueBeforeText:
	text "BLUE: Yo! Finally"
	line "got here, huh?"

	para "…"

	para "You're telling me"
	line "you conquered all"
	cont "the GYMS in JOHTO?"

	para "Heh! JOHTO's GYMS"
	line "must be pretty"
	cont "pathetic then."

	para "I bet you already"
	line "knew the GYM LEA-"
	cont "DER's party before"
	cont "the battle even"
	cont "started! Tsk!"

	para "I would know. I"
	line "was a simple trai-"
	cont "ner like you not"
	cont "long ago, y'know?"

	para "But now that I'm"
	line "on the other side,"
	cont "I'm not making"
	cont "other GYM LEADERS'"
	cont "stupid mistake."

	para "I've travelled a"
	line "lot and captured"
	cont "many strong"
	cont "#MON."

	para "No one can ever"
	line "predict my game…"

	para "Ready for a real"
	line "challenge, JOHTO"
	cont "CHAMP?"
	done

LeaderBlueWinText:
	text "BLUE: What?"

	para "How the heck did I"
	line "lose to you?"

	para "…"

	para "Tch, all right…"
	line "Here, take this--"
	cont "it's EARTHBADGE."
	done

Text_ReceivedEarthBadge:
	text "<PLAYER> received"
	line "EARTHBADGE."
	done

LeaderBlueAfterText:
	text "BLUE: …"

	para "All right, I was"
	line "wrong. You're the"

	para "real deal. You are"
	line "a good trainer."

	para "But I'm going to"
	line "beat you someday."

	para "Don't you forget"
	line "it!"
	done

LeaderBlueEpilogueText:
	text "BLUE: Listen, you."

	para "You'd better not"
	line "lose until I beat"
	cont "you. Got it?"
	done

LeaderBlueRivalText:
	text "BLUE: Now that RED"
	line "is gone, I have"
	cont "no rival."

	para "I don't know how"
	line "to feel about it."

	para "I'll have to find"
	line "a new purpose…"
	done

ViridianGymGuideText:
	text "Yo, CHAMP!"

	para "How's it going?"
	line "Looks like you're"
	cont "on a roll."

	para "The GYM LEADER is"
	line "the guy who was"

	para "the CHAMPION three"
	line "years ago."

	para "And you know what?"

	para "All #MON types"
	line "are allowed in"
	cont "his GYM!"

	para "That's unheard of,"
	line "right?"

	;para "That's the"
	;line "challenge of"
	;cont "VIRIDIAN's GYM:"
	;
	;para "tables are turned"
	;line "and you're in for"
	;cont "a surprise!"

	para "BLUE fears no one"
	line "and no #MON."

	para "He's so cool!!"

	done

ViridianGymGuideWinText:
	text "Man, you are truly"
	line "tough…"

	para "That was a heck of"
	line "an inspirational"

	para "battle. It brought"
	line "tears to my eyes."
	done

ViridianGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, VIRIDIAN_CITY, 1
	warp_event  5, 17, VIRIDIAN_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, ViridianGymStatue
	bg_event  6, 13, BGEVENT_READ, ViridianGymStatue

	def_object_events
	object_event  5,  3, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianGymBlueScript, EVENT_VIRIDIAN_GYM_BLUE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianGymGuideScript, EVENT_VIRIDIAN_GYM_BLUE
