	object_const_def
	const PEWTERGYM_BROCK
	const PEWTERGYM_YOUNGSTER
	const PEWTERGYM_GYM_GUIDE

PewterGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_BROCK
	iftrue .no_check

	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall PewterGymCheckForbiddenTypes
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

	scall PewterGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked PEWTERGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.do_check
	setlasttalked PEWTERGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp PEWTER_CITY, 16, 17
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

PewterGymCheckForbiddenTypes:
	setval FIGHTING
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval GRASS
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval WATER
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval GROUND
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval STEEL
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

PewterGymBrockScript:
	faceplayer
	opentext
	checkflag ENGINE_BOULDERBADGE
	iftrue .FightDone
	writetext BrockIntroText
	waitbutton
	closetext
	winlosstext BrockWinLossText, 0
	loadtrainer BROCK, BROCK1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BROCK
	setevent EVENT_BEAT_CAMPER_JERRY
	opentext
	writetext ReceivedBoulderBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_BOULDERBADGE
	farscall GotNewKantoBadge
	writetext BrockBoulderBadgeText
	waitbutton
	closetext
	end

.FightDone:
	writetext BrockFightDoneText
	waitbutton
	closetext
	end

TrainerCamperJerry:
	trainer CAMPER, JERRY, EVENT_BEAT_CAMPER_JERRY, CamperJerrySeenText, CamperJerryBeatenText, 0, .Script

.Script:
	endifjustbattled
	checkevent EVENT_BROCK_BACK_IN_GYM
	iftrue .brock_location
	opentext
	writetext CamperJerryAfterBattleText
	waitbutton
	closetext
	end

.brock_location:
	jumptextfaceplayer CamperJerryBrockLocationText

PewterGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BROCK
	iftrue .PewterGymGuideWinScript
	writetext PewterGymGuideText
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	farscall GotBadgeNoTrainerCard
	waitbutton
	closetext
	end

.PewterGymGuideWinScript:
	writetext PewterGymGuideWinText
	waitbutton
	closetext
	end

PewterGymStatue:
	checkflag ENGINE_BOULDERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, BROCK, BROCK1
	jumpstd GymStatue2Script

BrockIntroText:
if DEF(_FR_FR)
	text "PIERRE: C'est pas"
	line "tous les jours"

	para "qu'on reçoit de la"
	line "visite de quelqu'"
	cont "un de JOHTO."

	para "Moi c'est PIERRE,"
	line "le CHAMPION de"
	cont "l'ARENE d'ARGENTA."

	para "Je suis né et ai"
	line "grandi dans cette"
	cont "montagne rocheuse,"
	
	para "et je me suis lié"
	line "d'amitié avec les"
	cont "#MON de type"
	cont "ROCHE."

	para "Ils s'épanouissent"
	line "ici car les tempê-"
	cont "tes de sable"
	cont "soufflent souvent."

	para "Je reconnaîtrai ta"
	line "valeur si tu me"
	cont "bats sous ce"
	cont "climat."

	para "C'est parti!"
else
	text "BROCK: Wow, it's"
	line "not often that we"

	para "get a challenger"
	line "from JOHTO."

	para "I'm BROCK, the"
	line "PEWTER GYM LEADER."

	para "I was born & rai-"
	line "sed in this rocky"
	cont "mountain, and"
	
	para "became friend with"
	line "ROCK type #MON."

	para "They strive in"
	line "this area because"
	cont "sandstorms often"
	cont "arise."

	para "I will recognize"
	line "your worth if you"
	cont "can beat me under"
	cont "this weather."

	para "Come on!"
endc
	done

BrockWinLossText: 
if DEF(_FR_FR)
	text "PIERRE: Tes #-"
	line "MON ont pu passer"
	cont "ma défense de"
	cont "pierre..."

	para "Tu es plus balèze"
	line "que je ne le"
	cont "pensais..."

	para "Tiens... Prends"
	line "ce BADGE."
else
	text "BROCK: Your #-"
	line "MON's powerful at-"
	cont "tacks overcame my"
	cont "rock-hard defense…"

	para "You're stronger"
	line "than I expected…"

	para "Go ahead--take"
	line "this BADGE."
endc

	done

ReceivedBoulderBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE ROCHE."
else
	text "<PLAYER> received"
	line "BOULDERBADGE."
endc

	done

BrockBoulderBadgeText:
if DEF(_FR_FR)
	text "PIERRE: <PLAY_G>,"
	line "merci. J'ai aimé"

	para "me battre contre"
	line "toi, même si je"
	cont "l'ai mauvaise."

	para "Je vais devoir"
	line "m'entraîner encore"
	cont "plus dur."
else
	text "BROCK: <PLAY_G>,"
	line "thanks. I enjoyed"

	para "battling you, even"
	line "though I am a bit"
	cont "upset."

	para "I'm gonna have to"
	line "train harder."
endc
	done

BrockFightDoneText: 
if DEF(_FR_FR)
	text "PIERRE: Grand est"
	line "le monde. Beaucoup"

	para "de dresseurs tu"
	line "rencontreras."
	cont "Oh que oui."

	para "Tu verras..."
	line "Je vais devenir"
	cont "super balèze."
else
	text "BROCK: The world"
	line "is huge. There are"

	para "still many strong"
	line "trainers like you."

	para "Just wait and see."
	line "I'm going to be-"
	cont "come a lot strong-"
	cont "er too."
endc

	done

CamperJerrySeenText: 
if DEF(_FR_FR)
	text "Les dresseurs de"
	line "cette ARENE utili-"
	cont "sent des #MON"
	cont "du type ROCHE."

	para "Cet élément a une"
	line "grande DEFENSE."

	para "Les combats ris-"
	line "quent de durer"
	cont "super longtemps."
else
	text "The trainers of"
	line "this GYM use rock-"
	cont "type #MON."

	para "The rock-type has"
	line "high DEFENSE."

	para "Battles could end"
	line "up going a long"

	para "time. Are you"
	line "ready for this?"
endc

	done

CamperJerryBeatenText: 
if DEF(_FR_FR)
	text "Il faut que je"
	line "gagne..."
else
	text "I have to win"
	line "these battles…"
endc

	done

CamperJerryAfterBattleText: 
if DEF(_FR_FR)
	text "Hé toi! Dresseur"
	line "de JOHTO! PIERRE"

	para "est super fort! Il"
	line "va te punir la"
	cont "tête!"
else
	text "Hey, you! Trainer"
	line "from JOHTO! BROCK"

	para "is tough. He'll"
	line "punish you if you"

	para "don't take him"
	line "seriously."
endc

	done

CamperJerryBrockLocationText:
if DEF(_FR_FR)
	text "PIERRE est parti"
	line "au sud pour aider"
	cont "avec des travaux"
	cont "routiers qui n'en"
	cont "finisse pas."

	para "Il est parti"
	line "depuis un bon"
	cont "moment."

	para "Tu ferais bien d'y"
	line "aller si tu veux"
	cont "son BADGE."
else
	text "BROCK went south"
	line "to help with some"
	cont "roadwork that was"
	cont "taking forever."

	para "He's been gone for"
	line "quite some time."

	para "You better go"
	line "find him if you"
	cont "want his BADGE."
endc
	done

PewterGymGuideText:
if DEF(_FR_FR)
	text "Hey MAITRE! Tu"
	line "affrontes les"
	
	para "CHAMPIONS de"
	line "KANTO, non?"

	para "Ils sont tout"
	line "aussi forts et"

	para "déterminés que"
	line "ceux de JOHTO."
else
	text "Yo CHAMP! You're"
	line "really rocking."

	para "Are you battling"
	line "the GYM LEADERS of"
	cont "KANTO?"

	para "They're strong and"
	line "dedicated people,"

	para "just like JOHTO's"
	line "GYM LEADERS."
endc
	done

PewterGymGuideWinText: 
if DEF(_FR_FR)
	text "Hé! Graine de"
	line "star! Cette"

	para "ARENE ne t'a pas"
	line "posé trop de"
	cont "problèmes..."

	para "Tu m'as bluffé."
	line "Sérieusement."
else
	text "Yo! CHAMP in"
	line "making! That GYM"

	para "didn't give you"
	line "much trouble."

	para "The way you took"
	line "charge was really"

	para "inspiring. I mean"
	line "that seriously."
endc

	done

PewterGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 13, PEWTER_CITY, 2
	warp_event  5, 13, PEWTER_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 11, BGEVENT_READ, PewterGymStatue
	bg_event  6, 11, BGEVENT_READ, PewterGymStatue

	def_object_events
	object_event  5,  1, SPRITE_BROCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PewterGymBrockScript, EVENT_BROCK_BACK_IN_GYM
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerCamperJerry, -1
	object_event  7, 11, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, PewterGymGuideScript, -1
