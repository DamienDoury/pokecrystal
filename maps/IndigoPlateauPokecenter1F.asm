	object_const_def
	const INDIGOPLATEAUPOKECENTER1F_NURSE
	const INDIGOPLATEAUPOKECENTER1F_CLERK
	const INDIGOPLATEAUPOKECENTER1F_COOLTRAINER_M
	const INDIGOPLATEAUPOKECENTER1F_SILVER
	const INDIGOPLATEAUPOKECENTER1F_GRAMPS
	const INDIGOPLATEAUPOKECENTER1F_ABRA

IndigoPlateauPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .PrepareElite4
	callback MAPCALLBACK_OBJECTS, .IndigoPlateauPokecenter1F_AntiSoftLock

.PrepareElite4:
	clearevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_WILLS_ROOM_EXIT_OPEN
	clearevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KOGAS_ROOM_EXIT_OPEN
	clearevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	clearevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KARENS_ROOM_EXIT_OPEN
	clearevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_LANCES_ROOM_EXIT_OPEN
	clearevent EVENT_BEAT_ELITE_4_WILL
	clearevent EVENT_BEAT_ELITE_4_KOGA
	clearevent EVENT_BEAT_ELITE_4_BRUNO
	clearevent EVENT_BEAT_ELITE_4_KAREN
	clearevent EVENT_BEAT_CHAMPION_LANCE
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	endcallback

.IndigoPlateauPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

PlateauRivalBattle1:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue PlateauRivalScriptDone
	readvar VAR_WEEKDAY
	ifequal SUNDAY, PlateauRivalScriptDone
	ifequal TUESDAY, PlateauRivalScriptDone
	ifequal THURSDAY, PlateauRivalScriptDone
	ifequal FRIDAY, PlateauRivalScriptDone
	ifequal SATURDAY, PlateauRivalScriptDone
	moveobject INDIGOPLATEAUPOKECENTER1F_SILVER, 17, 9
	appear INDIGOPLATEAUPOKECENTER1F_SILVER
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalMovement1
	playmusic MUSIC_RIVAL_ENCOUNTER
	turnobject PLAYER, RIGHT
	sjump PlateauRivalBattleCommon

PlateauRivalBattle2:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue PlateauRivalScriptDone
	readvar VAR_WEEKDAY
	ifequal SUNDAY, PlateauRivalScriptDone
	ifequal TUESDAY, PlateauRivalScriptDone
	ifequal THURSDAY, PlateauRivalScriptDone
	ifequal FRIDAY, PlateauRivalScriptDone
	ifequal SATURDAY, PlateauRivalScriptDone
	appear INDIGOPLATEAUPOKECENTER1F_SILVER
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalMovement2
	playmusic MUSIC_RIVAL_ENCOUNTER
	turnobject PLAYER, LEFT
PlateauRivalBattleCommon:
	opentext
	writetext PlateauRivalText1
	waitbutton
	closetext
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	; Cyndaquil
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, RIVAL2_2_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump PlateauRivalPostBattle

.Totodile:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, RIVAL2_2_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump PlateauRivalPostBattle

.Chikorita:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, RIVAL2_2_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump PlateauRivalPostBattle

PlateauRivalPostBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext PlateauRivalText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalLeavesMovement
	disappear INDIGOPLATEAUPOKECENTER1F_SILVER
	playmapmusic
	setflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
PlateauRivalScriptDone:
	end

IndigoPlateauPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

IndigoPlateauPokecenter1FClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_INDIGO_PLATEAU
	closetext
	end

IndigoPlateauPokecenter1FCooltrainerMScript:
	jumptextfaceplayer IndigoPlateauPokecenter1FCooltrainerMText

TeleportGuyScript:
	jumptextfaceplayer TeleportGuyText1

AbraScript:
	opentext
	writetext AbraText
	cry ABRA
	waitbutton
	closetext
	end

IndigoPlateauGymGuideScript:
	jumptextfaceplayer IndigoPlateauGymGuideText

PlateauRivalMovement1:
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head LEFT
	step_end

PlateauRivalMovement2:
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

PlateauRivalLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

IndigoPlateauPokecenter1FCooltrainerMText: 
if DEF(_FR_FR)
	text "A la LIGUE #MON"
	line "tu rencontreras le"

	para "terrible CONSEIL"
	line "des 4."

	para "Tu devras battre"
	line "les 4 chefs ou tu"

	para "devras tout recom-"
	line "mencer!"
else
	text "At the #MON"
	line "LEAGUE, you'll get"

	para "tested by the"
	line "ELITE FOUR."

	para "You have to beat"
	line "them all. If you"

	para "lose, you have to"
	line "start all over!"
endc

	done

PlateauRivalText1: 
if DEF(_FR_FR)
	text "Minute!"

	para "Tu vas relever le"
	line "défi de la LIGUE"
	cont "#MON?"

	para "T'es pas bien dans"
	line "ta tête, toi?"

	para "Mes #MON sur-"
	line "entraînés vont te"

	para "casser les reins."
	line "C'est bon?"

	para "<PLAYER>!"
	line "COMBAAAAT!"
else
	text "Hold it."

	para "You're going to"
	line "take the #MON"

	para "LEAGUE challenge"
	line "now?"

	para "That's not going"
	line "to happen."

	para "My super-well-"
	line "trained #MON"

	para "are going to pound"
	line "you."

	para "<PLAYER>!"
	line "I challenge you!"
endc

	done

PlateauRivalWinText: 
if DEF(_FR_FR)
	text "......"

	para "OK. J'ai perdu..."
else
	text "…"

	para "OK--I lost…"
endc

	done

PlateauRivalText2: 
if DEF(_FR_FR)
	text "....ZUT...."
	line "Encore perdu."

	para "Y'a un truc que"
	line "je comprends pas."
	cont "Faut qu'je pense."

	para "Et penser..."
	line "Moi j'aime pas."
else
	text "…Darn… I still"
	line "can't win…"

	para "I… I have to think"
	line "more about my"
	cont "#MON…"

	para "Humph! Try not to"
	line "lose!"
endc

	done

PlateauRivalLoseText: 
if DEF(_FR_FR)
	text "..."

	para "Avec mes copains,"
	line "je vais devenir"
	cont "un MAITRE!"
else
	text "…"

	para "Whew…"
	line "With my partners,"

	para "I'm going to be"
	line "the CHAMPION!"
endc

	done

TeleportGuyText1:
if DEF(_FR_FR)
	text "Ah! Tu défies le"
	line "CONSEIL des 4?"

	para "Stylé!"
	line "J'offrais autre-"
	cont "fois un service"

	para "de TELEPORTATION,"
	line "mais maintenant"
	cont "c'est interdit à"

	para "cause des mesures"
	line "sanitaires..."

	para "Du coup je suis"
	line "coincé ici."
else
	text "Ah! You're chal-"
	line "lenging the ELITE"

	para "FOUR? How nice!"
	line "I used to offer"

	para "a TELEPORT serv-"
	line "ice but now it's"

	para "forbidden because"
	line "of the sanitary"

	para "restrictions…"

	para "I'm stuck here."
endc
	done

AbraText: 
if DEF(_FR_FR)
	text "ABRA: Aabra..."
else
	text "ABRA: Aabra…"
endc

	done

IndigoPlateauGymGuideText:
if DEF(_FR_FR)
	text "Salutations,"
	line "challenger."
	
	para "Au-delà de ces"
	line "escaliers se"
	cont "trouve la LIGUE"
	cont "#MON."

	para "C'est le plus"
	line "grand défi de"
	cont "JOHTO et KANTO."

	para "Tout comme les"
	line "CHAMPIONS D'ARENE,"
	cont "ils utilisent un"
	cont "LIMITEUR DE FORCE."

	para "Cela abaisse le"
	line "niveau de leur"
	cont "équipe jusqu'à"

	para "40 niveaux pour"
	line "égaler ton #MON"
	cont "le plus fort."

	para "Contrairement aux"
	line "CHAMPIONS D'ARENE,"
	cont "ils n'ont pas de"
	cont "challenge spécial."

	para "Il n'y a qu'une"
	line "règle:"

	para "Bats les 4 membres"
	line "du CONSEIL et le"
	cont "MAITRE d'affilé."

	para "Si tu perds, il"
	line "faut recommencer"
	cont "du début."

	para "Bonne chance!"
else
	text "Hello trainer."
	
	para "Beyond these"
	line "stairs is the"
	cont "Elite 4."

	para "It is JOHTO's and"
	line "KANTO's greatest"
	cont "challenge."

	para "Just like GYM"
	line "LEADERS, they are"
	cont "using a POWER RES-"
	cont "TRAINER."
	
	para "It lowers the"
	line "level of their"
	cont "party by up to"
	
	para "40 levels to match"
	line "your highest level"
	cont "#MON."

	para "Unlike GYM LEADERS"
	line "they don't have"
	cont "specific chal-"
	cont "lenges."

	para "There is only"
	line "1 rule:"

	para "Defeat the 4 trai-"
	line "ners and the CHAM-"
	cont "PION in a row."
	
	para "If you lose, you"
	line "have to start all"
	cont "over again."

	para "Good luck!"
endc
	done

IndigoPlateauPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 13, ROUTE_23, 1
	warp_event  6, 13, ROUTE_23, 2
	warp_event  0, 13, POKECENTER_2F, 1
	warp_event 14,  3, WILLS_ROOM, 1

	def_coord_events
	coord_event 16,  4, CE_SCENE_ID, SCENE_ALWAYS, PlateauRivalBattle1
	coord_event 17,  4, CE_SCENE_ID, SCENE_ALWAYS, PlateauRivalBattle2

	def_bg_events

	def_object_events
	object_event  3,  7, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauPokecenter1FNurseScript, -1
	object_event 11,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauPokecenter1FClerkScript, -1
	object_event 11, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauPokecenter1FCooltrainerMScript, -1
	object_event 16,  9, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	object_event  1,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeleportGuyScript, EVENT_TELEPORT_GUY
	object_event  0,  9, SPRITE_ABRA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, AbraScript, EVENT_TELEPORT_GUY
	object_event 16,  1, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauGymGuideScript, EVENT_BEAT_ELITE_FOUR
