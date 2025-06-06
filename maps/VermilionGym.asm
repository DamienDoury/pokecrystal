	object_const_def
	const VERMILIONGYM_SURGE
	const VERMILIONGYM_GENTLEMAN
	const VERMILIONGYM_ROCKER
	const VERMILIONGYM_SUPER_NERD
	const VERMILIONGYM_GYM_GUIDE

VermilionGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_LTSURGE
	iftrue .no_check

	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall VermilionGymCheckForbiddenTypes
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

	scall VermilionGymCheckForbiddenTypes
	iftrue .do_check
	end
	
.egg_found
	setlasttalked VERMILIONGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked VERMILIONGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp VERMILION_CITY, 10, 19
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

VermilionGymCheckForbiddenTypes:
	setval GROUND
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

VermilionGymSurgeScript:
	faceplayer
	opentext
	checkflag ENGINE_THUNDERBADGE
	iftrue .FightDone
	writetext LtSurgeIntroText
	waitbutton
	closetext
	winlosstext LtSurgeWinLossText, 0
	loadtrainer LT_SURGE, LT_SURGE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LTSURGE
	setevent EVENT_BEAT_GENTLEMAN_GREGORY
	setevent EVENT_BEAT_GUITARIST_VINCENT
	setevent EVENT_BEAT_JUGGLER_HORTON
	opentext
	writetext ReceivedThunderBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_THUNDERBADGE
	farscall GotNewKantoBadge
	writetext LtSurgeThunderBadgeText
	waitbutton
	closetext
	end

.FightDone:
	writetext LtSurgeFightDoneText
	waitbutton
	closetext
	end

TrainerGentlemanGregory:
	trainer GENTLEMAN, GREGORY, EVENT_BEAT_GENTLEMAN_GREGORY, GentlemanGregorySeenText, GentlemanGregoryBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GentlemanGregoryAfterBattleText

TrainerGuitaristVincent:
	trainer GUITARIST, VINCENT, EVENT_BEAT_GUITARIST_VINCENT, GuitaristVincentSeenText, GuitaristVincentBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GuitaristVincentAfterBattleText

TrainerJugglerHorton:
	trainer JUGGLER, HORTON, EVENT_BEAT_JUGGLER_HORTON, JugglerHortonSeenText, JugglerHortonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer JugglerHortonAfterBattleText

VermilionGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_LTSURGE
	iftrue .VermilionGymGuideWinScript
	writetext VermilionGymGuideText
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	farscall GotBadgeNoTrainerCard
	waitbutton
	closetext
	end

.VermilionGymGuideWinScript:
	writetext VermilionGymGuideWinText
	waitbutton
	closetext
	end

VermilionGymTrashCan:
	jumptext VermilionGymTrashCanText

VermilionGymStatue:
	checkflag ENGINE_THUNDERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, LT_SURGE, LT_SURGE1
	jumpstd GymStatue2Script

LtSurgeIntroText: ; TO TRANSLATE
	text "SURGE: Hey, you"
	line "little tyke!"

	para "I have to hand it"
	line "to you. It may not"

	para "be very smart to"
	line "challenge me, but"
	cont "it takes guts!"

	para "When it comes to"
	line "electric #MON,"
	cont "I'm number one!"

	para "You see kiddo,"
	line "that training I"
	cont "just got at the"
	
	para "POWER PLANT super-"
	line "charged my #MON"
	cont "squad!"

	para "It makes their"
	line "ELECTRIC moves"
	cont "stronger and"

	para "causes PARALYSIS"
	line "more frequently."

	para "After all, “All"
	line "is fair in war”,"
	cont "and you're 'bout"

	para "to learn the"
	line "hard way!"

	done

LtSurgeWinLossText: 
if DEF(_FR_FR)
	text "BOB: Arrrgh!"
	line "Trop fort!"

	para "OK. Voilà ton"
	line "BADGE FOUDRE!"
else
	text "SURGE: Arrrgh!"
	line "You are strong!"

	para "OK, kid. You get"
	line "THUNDERBADGE!"
endc

	done

ReceivedThunderBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE FOUDRE."
else
	text "<PLAYER> received"
	line "THUNDERBADGE."
endc

	done

LtSurgeThunderBadgeText: ; TO TRANSLATE
	text "SURGE: Consider it"
	line "proof that you"
	cont "defeated me."

	para "You wear it"
	line "proudly, hear?"
	done

LtSurgeFightDoneText: 
if DEF(_FR_FR)
	text "BOB: Hé toi!"
	line "Tu tiens le coup?"

	para "Moi et mes #MON"
	line "on a la pêche!"
else
	text "SURGE: Hey, kid!"
	line "Still slugging and"
	cont "chugging away?"

	para "My #MON and I"
	line "are still at it!"
endc

	done

GentlemanGregorySeenText: 
if DEF(_FR_FR)
	text "Tu viens défier le"
	line "MAJOR BOB?"

	para "C'est ce qu'on va"
	line "voir!"
else
	text "You're here to"
	line "defeat LT.SURGE?"

	para "Not if I can help"
	line "it!"
endc

	done

GentlemanGregoryBeatenText: 
if DEF(_FR_FR)
	text "Pardon, MAJOR"
	line "BOB!"
else
	text "Sorry I failed"
	line "you, LT.SURGE,"
	cont "sir!"
endc

	done

GentlemanGregoryAfterBattleText: 
if DEF(_FR_FR)
	text "A l'armée, le"
	line "MAJOR BOB m'a"
	cont "sauvé la vie."
else
	text "When I was still"
	line "in the army, LT."

	para "SURGE saved my"
	line "life."
endc

	done

GuitaristVincentSeenText: 
if DEF(_FR_FR)
	text "Le MAJOR BOB a foi"
	line "en mes talents de"

	para "dresseur de #-"
	line "MON électriques."

	para "Tu crois pouvoir"
	line "me battre?"
else
	text "LT.SURGE recog-"
	line "nized my potential"

	para "with electric"
	line "#MON."

	para "Think you can beat"
	line "me?"
endc

	done

GuitaristVincentBeatenText: 
if DEF(_FR_FR)
	text "Ooh, sous le choc!"
else
	text "Ooh, how shocking!"
endc

	done

GuitaristVincentAfterBattleText: 
if DEF(_FR_FR)
	text "Si les pièges de"
	line "l'ARENE marchaient"
	cont "tu en aurais bavé!"
else
	text "If the GYM's traps"
	line "were working, you"

	para "would have been"
	line "toast…"
endc

	done

JugglerHortonSeenText: 
if DEF(_FR_FR)
	text "J'vais t'allonger!"
	line "Oh que oui!"
else
	text "I'm going to take"
	line "you down! Prepare"
	cont "to be shocked!"
endc

	done

JugglerHortonBeatenText: 
if DEF(_FR_FR)
	text "Gwaaah!"
	line ""
else
	text "Gwaaah!"
	line "I was overpowered…"
endc

	done

JugglerHortonAfterBattleText: 
if DEF(_FR_FR)
	text "Ne te réjouis pas"
	line "trop de m'avoir"

	para "battu. Le MAJOR"
	line "BOB, c'est pas la"
	cont "même limonade."
else
	text "Don't get too com-"
	line "fortable about"

	para "beating me…"
	line "LT.SURGE is tough."
endc

	done

VermilionGymGuideText: ; TO TRANSLATE
	text "Yo CHAMP!"

	para "You lucked out"
	line "this time."

	para "LT.SURGE is very"
	line "cautious. He has"

	para "traps set all over"
	line "the GYM."

	para "But--he-heh--the"
	line "traps aren't"
	cont "active right now."

	para "You'll have no"
	line "problem getting to"
	cont "LT.SURGE."
	done

VermilionGymGuideWinText: 
if DEF(_FR_FR)
	text "Fouii! C'était une"
	line "sacrée rencontre!"

	para "Ca m'a tout"
	line "retourné."
else
	text "Whew! That was an"
	line "electrifying bout!"

	para "It sure made me"
	line "nervous."
endc

	done

VermilionGymTrashCanText: 
if DEF(_FR_FR)
	text "Mmmm! Une bonne"
	line "poubelle dégueue."
else
	text "Nope! Nothing here"
	line "but trash."
endc

	done

VermilionGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, VERMILION_CITY, 7
	warp_event  5, 17, VERMILION_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  1,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  5,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  7,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  9,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  1,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  5,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  7,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  9,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  1, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  5, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  7, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  9, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3, 15, BGEVENT_READ, VermilionGymStatue
	bg_event  6, 15, BGEVENT_READ, VermilionGymStatue

	def_object_events
	object_event  5,  2, SPRITE_SURGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VermilionGymSurgeScript, EVENT_TRAIN_STATION_POPULATION
	object_event  8,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerGentlemanGregory, -1
	object_event  4,  7, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 3, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerGuitaristVincent, -1
	object_event  0, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerJugglerHorton, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, VermilionGymGuideScript, -1
