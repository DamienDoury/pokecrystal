	object_const_def
	const NATIONALPARKBUGCONTEST_YOUNGSTER1
	const NATIONALPARKBUGCONTEST_YOUNGSTER2
	const NATIONALPARKBUGCONTEST_ROCKER
	const NATIONALPARKBUGCONTEST_POKEFAN_M
	const NATIONALPARKBUGCONTEST_YOUNGSTER3
	const NATIONALPARKBUGCONTEST_YOUNGSTER4
	const NATIONALPARKBUGCONTEST_LASS
	const NATIONALPARKBUGCONTEST_YOUNGSTER5
	const NATIONALPARKBUGCONTEST_YOUNGSTER6
	const NATIONALPARKBUGCONTEST_YOUNGSTER7
	const NATIONALPARKBUGCONTEST_POKE_BALL1
	const NATIONALPARKBUGCONTEST_POKE_BALL2

NationalParkBugContest_MapScripts:
	def_scene_scripts

	def_callbacks

BugCatchingContestant1AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant1AText
	waitbutton
	closetext
	end

BugCatchingContestant2AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant2AText
	waitbutton
	closetext
	end

BugCatchingContestant3AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant3AText
	waitbutton
	closetext
	end

BugCatchingContestant4AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant4AText
	waitbutton
	closetext
	end

BugCatchingContestant5AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant5AText
	waitbutton
	closetext
	end

BugCatchingContestant6AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant6AText
	waitbutton
	closetext
	end

BugCatchingContestant7AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant7AText
	waitbutton
	closetext
	end

BugCatchingContestant8AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant8AText
	waitbutton
	closetext
	end

BugCatchingContestant9AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant9AText
	waitbutton
	closetext
	end

BugCatchingContestant10AScript:
	faceplayer
	opentext
	writetext BugCatchingContestant10AText
	waitbutton
	closetext
	end

NationalParkBugContestRelaxationSquareSign:
	jumptext NationalParkBugContestRelaxationSquareText

NationalParkBugContestBattleNoticeSign:
	jumptext NationalParkBugContestBattleNoticeText

NationalParkBugContestTrainerTipsSign:
	jumptext NationalParkBugContestTrainerTipsText

NationalParkBugContestParlyzHeal:
	itemball PARLYZ_HEAL

NationalParkBugContestTMDig:
	itemball TM_DIG

NationalParkBugContestHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

BugCatchingContestant1AText: 
if DEF(_FR_FR)
	text "JEAN-RAOUL: Je"
	line "vais gagner! Viens"
	cont "pas m'embêter."
else
	text "DON: I'm going to"
	line "win! Don't bother"
	cont "me."
endc

	done

BugCatchingContestant2AText: 
if DEF(_FR_FR)
	text "ODILON: Mon"
	line "PARASECT endort"
	cont "avec SPORE."
else
	text "ED: My PARASECT"
	line "puts #MON to"
	cont "sleep with SPORE."
endc

	done

BugCatchingContestant3AText: 
if DEF(_FR_FR)
	text "NICK: J'élève des"
	line "#MON rapides"
	cont "pour le combat."
else
	text "NICK: I'm raising"
	line "fast #MON for"
	cont "battles."
endc

	done

BugCatchingContestant4AText: 
if DEF(_FR_FR)
	text "MARCEL: Gagner ne"
	line "m'intéresse pas"
	cont "vraiment."

	para "Je cherche juste"
	line "les #MON rares."
else
	text "WILLIAM: I'm not"
	line "concerned about"
	cont "winning."

	para "I'm just looking"
	line "for rare #MON."
endc

	done

BugCatchingContestant5AText: 
if DEF(_FR_FR)
	text "FOULQUE: Chut! Tu"
	line "vas faire fuir"

	para "INSECATEUR. Parle-"
	line "moi plus tard."
else
	text "BENNY: Ssh! You'll"
	line "scare off SCYTHER."

	para "I'll talk to you"
	line "later."
endc

	done

BugCatchingContestant6AText: 
if DEF(_FR_FR)
	text "RENE: Il faut"
	line "d'abord affaiblir"

	para "un #MON insecte"
	line "puis lancer une"
	cont "# BALL."
else
	text "BARRY: You should"
	line "weaken bug #MON"

	para "first, then throw"
	line "a BALL."
endc

	done

BugCatchingContestant7AText: 
if DEF(_FR_FR)
	text "SANDY: Pardon?"

	para "Tu trouves ça bi-"
	line "zarre qu'une fille"

	para "attrape des #-"
	line "MON insecte?"
else
	text "CINDY: I love bug"
	line "#MON."

	para "I guess you must"
	line "like them too."
endc

	done

BugCatchingContestant8AText: 
if DEF(_FR_FR)
	text "ARNAUD: Je collec-"
	line "tionne les #MON"

	para "insecte depuis ma"
	line "tendre enfance."

	para "Ma défaite est"
	line "impossible!"
else
	text "JOSH: I've been"
	line "collecting bug"

	para "#MON since I"
	line "was just a baby."

	para "There's no way I'm"
	line "going to lose!"
endc

	done

BugCatchingContestant9AText: 
if DEF(_FR_FR)
	text "GONTRAND: Si tu as"
	line "le temps de parler"

	para "va chercher des"
	line "#MON insecte."
else
	text "SAMUEL: If you've"
	line "got the time to"

	para "chat, go find some"
	line "bug #MON."
endc

	done

BugCatchingContestant10AText: 
if DEF(_FR_FR)
	text "CYRIL: J'ai étudié"
	line "les #MON insec-"
	cont "te à fond."

	para "Je vais gagner..."
	line "C'est sûr."
else
	text "KIPP: I've studied"
	line "about bug #MON"
	cont "a lot."

	para "I'm going to win"
	line "for sure."
endc

	done

NationalParkBugContestRelaxationSquareText: 
if DEF(_FR_FR)
	text "AIRE DE REPOS du"
	line "PARC NATUREL"
else
	text "RELAXATION SQUARE"
	line "NATIONAL PARK"
endc

	done

NationalParkBugContestBattleNoticeText: 
if DEF(_FR_FR)
	text "C'est quoi cette"
	line "affiche?"

	para "Se battre unique-"
	line "ment dans l'herbe."

	para "LE GARDIEN DU"
	line "PARC NATUREL"
else
	text "What is this"
	line "notice?"

	para "Please battle only"
	line "in the grass."

	para "NATIONAL PARK"
	line "WARDEN'S OFFICE"
endc

	done

NationalParkBugContestTrainerTipsText: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Imprimer les"
	line "LETTRES en les"
	cont "ouvrant et appuyer"
	cont "sur START."
else
	text "TRAINER TIPS"

	para "Print out MAIL by"
	line "opening it then"
	cont "pressing START."
endc

	done

NationalParkBugContest_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 33, 18, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 33, 19, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 10, 47, ROUTE_35_NATIONAL_PARK_GATE, 1
	warp_event 11, 47, ROUTE_35_NATIONAL_PARK_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 14, 44, BGEVENT_READ, NationalParkBugContestRelaxationSquareSign
	bg_event 27, 31, BGEVENT_READ, NationalParkBugContestBattleNoticeSign
	bg_event  6, 47, BGEVENT_ITEM, NationalParkBugContestHiddenFullHeal
	bg_event 12,  4, BGEVENT_READ, NationalParkBugContestTrainerTipsSign

	def_object_events
	object_event 19, 29, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant1AScript, EVENT_BUG_CATCHING_CONTESTANT_1A
	object_event 28, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant2AScript, EVENT_BUG_CATCHING_CONTESTANT_2A
	object_event  9, 18, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant3AScript, EVENT_BUG_CATCHING_CONTESTANT_3A
	object_event  7, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant4AScript, EVENT_BUG_CATCHING_CONTESTANT_4A
	object_event 23,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant5AScript, EVENT_BUG_CATCHING_CONTESTANT_5A
	object_event 27, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant6AScript, EVENT_BUG_CATCHING_CONTESTANT_6A
	object_event  7, 23, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant7AScript, EVENT_BUG_CATCHING_CONTESTANT_7A
	object_event 11, 27, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant8AScript, EVENT_BUG_CATCHING_CONTESTANT_8A
	object_event 16,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant9AScript, EVENT_BUG_CATCHING_CONTESTANT_9A
	object_event 17, 34, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant10AScript, EVENT_BUG_CATCHING_CONTESTANT_10A
	object_event 35, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkBugContestParlyzHeal, EVENT_NATIONAL_PARK_PARLYZ_HEAL
	object_event  1, 43, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkBugContestTMDig, EVENT_NATIONAL_PARK_TM_DIG
