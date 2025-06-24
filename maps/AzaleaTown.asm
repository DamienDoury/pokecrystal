	object_const_def
	const AZALEATOWN_TRAVEL_CONTROLLER
	const AZALEATOWN_AZALEA_ROCKET1
	const AZALEATOWN_GRAMPS
	const AZALEATOWN_TEACHER
	const AZALEATOWN_YOUNGSTER
	const AZALEATOWN_SLOWPOKE1
	const AZALEATOWN_SLOWPOKE2
	const AZALEATOWN_SLOWPOKE3
	const AZALEATOWN_SLOWPOKE4
	const AZALEATOWN_FRUIT_TREE
	const AZALEATOWN_SILVER
	const AZALEATOWN_AZALEA_ROCKET3
	const AZALEATOWN_KURT_OUTSIDE
	const AZALEATOWN_GRAMPS_MART_RUSH
	const AZALEATOWN_TEACHER_MART_RUSH
	const AZALEATOWN_YOUNGSTER_MART_RUSH
	const AZALEATOWN_POKEFAN_MART_RUSH
	const AZALEATOWN_APPRENTICE_MART_RUSH

AzaleaTown_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_AZALEATOWN_NOTHING
	scene_script .DummyScene1 ; SCENE_AZALEATOWN_RIVAL_BATTLE
	scene_script .DummyScene2 ; SCENE_AZALEATOWN_KURT_RETURNS_GS_BALL

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .Flypoint
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .AzaleaHideCharacters

.DummyScene0:
	end

.DummyScene1:
	end

.DummyScene2:
	end

.AzaleaHideCharacters:
	checkevent EVENT_LOCKDOWN_MART_RUSH
	iftrue .NormalScene
	moveobject AZALEATOWN_GRAMPS, 0, 0
	moveobject AZALEATOWN_TEACHER, 0, 0
	moveobject AZALEATOWN_YOUNGSTER, 0, 0
.NormalScene:
	endcallback

.Flypoint:
	checkflag ENGINE_FLYPOINT_AZALEA
	iftrue .FlyPointDone

	loadmem wYearMonth, 2
	setflag ENGINE_FLYPOINT_AZALEA
.FlyPointDone
	endcallback

.TilesLoad:
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock  8,  4, $2b ; Kurt's House.
	changeblock 20, 12, $2b ; Charcoal Kiln.

	ifnotequal 1 << CURFEW, .EndTilesCallback
	changeblock 20,  4, $3f ; Mart.

.EndTilesCallback
	endcallback

AzaleaTownRivalBattleScene1:
	moveobject AZALEATOWN_SILVER, 11, 11
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear AZALEATOWN_SILVER
	applymovement AZALEATOWN_SILVER, AzaleaTownRivalBattleApproachMovement1
	turnobject PLAYER, DOWN
	sjump AzaleaTownRivalBattleScript

AzaleaTownRivalBattleScene2:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear AZALEATOWN_SILVER
	applymovement AZALEATOWN_SILVER, AzaleaTownRivalBattleApproachMovement2
	turnobject PLAYER, UP
AzaleaTownRivalBattleScript:
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext AzaleaTownRivalBeforeText
	waitbutton
	closetext
	setevent EVENT_RIVAL_AZALEA_TOWN
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_2_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.Totodile:
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_2_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.Chikorita:
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_2_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.AfterBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext AzaleaTownRivalAfterText
	waitbutton
	closetext
	turnobject PLAYER, LEFT
	applymovement AZALEATOWN_SILVER, AzaleaTownRivalBattleExitMovement
	playsound SFX_EXIT_BUILDING
	disappear AZALEATOWN_SILVER
	setscene SCENE_AZALEATOWN_NOTHING
	waitsfx
	playmapmusic
	end

AzaleaTownRocket1Script:
	faceplayer
	jumptext AzaleaTownRocket1Text

AzaleaTownRocket2Script:
	faceplayer
	jumptext AzaleaTownRocket2Text

AzaleaTownGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .ClearedWell
	writetext AzaleaTownGrampsTextBefore
	waitbutton
	closetext
	end

.ClearedWell:
	writetext AzaleaTownGrampsTextAfter
	waitbutton
	closetext
	end

AzaleaTownTeacherScript:
	jumptextfaceplayer AzaleaTownTeacherText

AzaleaTownYoungsterScript:
	jumptextfaceplayer AzaleaTownYoungsterText

AzaleaTownSlowpokeScript:
	opentext
	writetext AzaleaTownSlowpokeText1
	pause 60
	writetext AzaleaTownSlowpokeText2
	cry SLOWPOKE
	waitbutton
	closetext
	end

AzaleaTownCelebiScene:
	applymovement PLAYER, AzaleaTownPlayerLeavesKurtsHouseMovement
	opentext
	writetext AzaleaTownKurtText1
	promptbutton
	turnobject AZALEATOWN_KURT_OUTSIDE, DOWN
	writetext AzaleaTownKurtText2
	promptbutton
	writetext AzaleaTownKurtText3
	waitbutton
	verbosegiveitem GS_BALL
	turnobject AZALEATOWN_KURT_OUTSIDE, LEFT
	setflag ENGINE_FOREST_IS_RESTLESS
	clearevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	setscene SCENE_AZALEATOWN_NOTHING
	closetext
	end

AzaleaTownKurtScript:
	faceplayer
	opentext
	writetext AzaleaTownKurtText3
	waitbutton
	turnobject AZALEATOWN_KURT_OUTSIDE, LEFT
	closetext
	end

AzaleaTownSign:
	jumptext AzaleaTownSignText

KurtsHouseSign:
	jumptext KurtsHouseSignText

AzaleaGymSign:
	jumptext AzaleaGymSignText

SlowpokeWellSign:
	jumptext SlowpokeWellSignText

CharcoalKilnSign:
	jumptext CharcoalKilnSignText

AzaleaTownIlextForestSign:
	jumptext AzaleaTownIlexForestSignText

AzaleaTownPokecenterSign:
	jumpstd PokecenterSignScript

AzaleaTownMartSign:
	jumpstd MartSignScript

WhiteApricornTree:
	fruittree FRUITTREE_AZALEA_TOWN

AzaleaTownHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

AzaleaTownTeacherRush:
	jumptext AzaleaTownTeacherRushText

AzaleaTownGrampsRush:
	faceplayer
	jumptext AzaleaTownGrampsRushText

AzaleaTownPokefanRush:
	jumptext AzaleaTownPokefanRushText

AzaleaTownApprenticeRush:
	jumptextfaceplayer AzaleaTownApprenticeRushText

AzaleaTown_DoorScript:
	jumpstd LockdownCurfewClosedDoor

AzaleaTownRivalBattleApproachMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

AzaleaTownRivalBattleApproachMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AzaleaTownRivalBattleExitMovement:
	step LEFT
	step LEFT
	step LEFT
	step_end

AzaleaTownPlayerLeavesKurtsHouseMovement:
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

AzaleaTownRivalBeforeText: 
if DEF(_FR_FR)
	text "...Dis-moi quelque"
	line "chose, p'tit"
	cont "bouchon..."

	para "Est-ce vrai que la"
	line "TEAM ROCKET est de"
	cont "retour?"

	para "Quoi? Tu les as"
	line "battus? Hah!"
	cont "Arrête de mentir."

	para "Naan, t'aimes"
	line "pas crâner, toi!"
	cont "Allez, baston..."
else
	text "…Tell me some-"
	line "thing."

	para "Is it true that"
	line "TEAM ROCKET has"
	cont "returned?"

	para "What? You beat"
	line "them? Hah! Quit"
	cont "lying."

	para "You're not joking?"
	line "Then let's see how"
	cont "good you are."
endc

	done

AzaleaTownRivalWinText: 
if DEF(_FR_FR)
	text "...Humpff! Vilains"
	line "#MON!"

	para "Ouvre bien tes"
	line "oreilles mon p'tit"

	para "chat, t'as gagné"
	line "parce que mes"
	cont "#MON se sont"
	cont "couchés tard..."
else
	text "… Humph! Useless"
	line "#MON!"

	para "Listen, you. You"
	line "only won because"

	para "my #MON were"
	line "weak."
endc

	done

AzaleaTownRivalAfterText: 
if DEF(_FR_FR)
	text "Je déteste les"
	line "minus."

	para "#MON ou"
	line "dresseur, c'est"
	cont "du kif-kif."

	para "Je vais devenir"
	line "surpuissant et"
	cont "balayer les minus."

	para "Et c'est pareil"
	line "pour la TEAM"
	cont "ROCKET."

	para "Ils sont redoutés"
	line "parce qu'ils agis-"

	para "sent en groupe,"
	line "mais un par un ils"
	cont "sont faibles."

	para "Je les déteste"
	line "tous!"

	para "Hors de ma vue"
	line "minus! Quelqu'un"

	para "comme toi"
	line "ne peut rien"
	cont "m'apporter..."
else
	text "I hate the weak."

	para "#MON, trainers."
	line "It doesn't matter"
	cont "who or what."

	para "I'm going to be"
	line "strong and wipe"
	cont "out the weak."

	para "That goes for TEAM"
	line "ROCKET too."

	para "They act big and"
	line "tough in a group."

	para "But get them"
	line "alone, and they're"
	cont "weak."

	para "I hate them all."

	para "You stay out of my"
	line "way. A weakling"

	para "like you is only a"
	line "distraction."
endc

	done

AzaleaTownRivalLossText: 
if DEF(_FR_FR)
	text "...Humpff! Je me"
	line "doutais bien que"
	cont "tu pipotais..."
else
	text "…Humph! I knew"
	line "you were lying."
endc

	done

AzaleaTownRocket1Text: 
if DEF(_FR_FR)
	text "C'est dangereux"
	line "d'entrer ici, je"
	cont "monte la garde."

	para "J'suis trop cool,"
	line "tu ne trouves pas?"
else
	text "It's unsafe to go"
	line "in there, so I'm"
	cont "standing guard."

	para "Aren't I a good"
	line "Samaritan?"
endc

	done

AzaleaTownRocket2Text: 
if DEF(_FR_FR)
	text "Que sais-tu sur la"
	line "QUEUERAMOLOS? On"
	cont "dit que c'est"
	cont "goûtu!"

	para "C'est trop bien"
	line "de savoir ça, non?"
else
	text "Do you know about"
	line "SLOWPOKETAIL? I"
	cont "heard it's tasty!"

	para "Aren't you glad I"
	line "told you that?"
endc

	done

AzaleaTownGrampsTextBefore: 
if DEF(_FR_FR)
	text "Les RAMOLOSS ont"
	line "déserté la ville."

	para "On dit qu'on vend"
	line "leur QUEUE quelque"
	cont "part."
else
	text "The SLOWPOKE have"
	line "disappeared from"
	cont "town…"

	para "I heard their"
	line "TAILS are being"
	cont "sold somewhere."
endc

	done

AzaleaTownGrampsTextAfter: 
if DEF(_FR_FR)
	text "Les RAMOLOSS sont"
	line "de retour."

	para "A mon avis, ils"
	line "devaient traîner"
	cont "quelque part."
else
	text "The SLOWPOKE have"
	line "returned."

	para "Knowing them, they"
	line "could've just been"

	para "goofing off some-"
	line "where."
endc

	done

AzaleaTownTeacherText: 
if DEF(_FR_FR)
	text "Es-tu ici pour"
	line "FARGAS, celui qui"
	cont "fabrique les"
	cont "BALLS?"

	para "Il n'y a pas que"
	line "toi."
else
	text "Did you come to"
	line "get KURT to make"
	cont "some BALLS?"

	para "A lot of people do"
	line "just that."
endc

	done

AzaleaTownYoungsterText: 
if DEF(_FR_FR)
	text "Passe par ECORCIA"
	line "et tu te retrou-"
	cont "veras au BOIS AUX"
	cont "CHENES."

	para "Mais ces petits"
	line "arbustes bloquent"
	cont "le passage."

	para "Le #MON du"
	line "CHARBONNIER peut"
	cont "couper les arbres."
else
	text "Cut through AZALEA"
	line "and you'll be in"
	cont "ILEX FOREST."

	para "But these skinny"
	line "trees make it"

	para "impossible to get"
	line "through."

	para "The CHARCOAL MAN's"
	line "#MON can CUT"
	cont "down trees."
endc

	done

AzaleaTownSlowpokeText1: 
if DEF(_FR_FR)
	text "RAMOLOSS: ..."

	para ".................."
else
	text "SLOWPOKE: …"

	para "<……> <……> <……>"
endc

	done

AzaleaTownSlowpokeText2: 
if DEF(_FR_FR)
	text ".........gueuh?"
else
	text "<……> <……>Yawn?"
endc

	done

AzaleaTownKurtText1: 
if DEF(_FR_FR)
	text "Le BOIS AUX CHENES"
	line "est agité!"

	para "Que se passe-t-il?"
else
	text "ILEX FOREST is"
	line "restless!"

	para "What is going on?"
endc

	done

AzaleaTownKurtText2: 
if DEF(_FR_FR)
	text "<PLAYER>, voilà"
	line "ta GS BALL!"
else
	text "<PLAYER>, here's"
	line "your GS BALL back!"
endc

	done

AzaleaTownKurtText3: 
if DEF(_FR_FR)
	text "Peux-tu voir pour-"
	line "quoi le BOIS AUX"
	cont "CHENES est si"
	cont "agité?"
else
	text "Could you go see"
	line "why ILEX FOREST is"
	cont "so restless?"
endc

	done

AzaleaTownSignText: 
if DEF(_FR_FR)
	text "ECORCIA"
	line "La ville où les"

	para "gens et les petits"
	line "#MON sont"
	cont "bien contents"
	cont "d'habiter"
else
	text "AZALEA TOWN"
	line "Where People and"

	para "#MON Live in"
	line "Happy Harmony"
endc

	done

KurtsHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DE FARGAS"
else
	text "KURT'S HOUSE"
endc

	done

AzaleaGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "d'ECORCIA: HECTOR"

	para "L'expert des"
	line "#MON insecte!"
else
	text "AZALEA TOWN"
	line "#MON GYM"
	cont "LEADER: BUGSY"

	para "The Walking"
	line "Bug #MON"
	cont "Encyclopedia"
endc

	done

SlowpokeWellSignText: 
if DEF(_FR_FR)
	text "PUITS RAMOLOSS"

	para "Aussi connu sous"
	line "le nom de..."
	cont "PUITS de PLUIE."

	para "Les gens du coin"
	line "pensent que le"
	cont "baillement du"
	cont "RAMOLOSS invoque"
	cont "la pluie."

	para "Les archives"
	line "montrent qu'un"

	para "baillement de"
	line "RAMOLOSS a mis fin"
	cont "à 400 ans de"
	cont "sécheresse."
else
	text "SLOWPOKE WELL"

	para "Also known as the"
	line "RAINMAKER WELL."

	para "Locals believe"
	line "that a SLOWPOKE's"
	cont "yawn summons rain."

	para "Records show that"
	line "a SLOWPOKE's yawn"

	para "ended a drought"
	line "400 years ago."
endc

	done

CharcoalKilnSignText: 
if DEF(_FR_FR)
	text "FOUR A CHARBON"
else
	text "CHARCOAL KILN"
endc

	done

AzaleaTownIlexForestSignText: 
if DEF(_FR_FR)
	text "BOIS AUX CHENES"

	para "On y entre par la"
	line "porte."
else
	text "ILEX FOREST"

	para "Enter through the"
	line "gate."
endc

	done

AzaleaTownTeacherRushText:
if DEF(_FR_FR)
	text "Laissez-"
	para "moi"
	para "ENTREEEEER!!!"
	done
else
	text "Let"
	para "me"
	para "IIIIIIN!"
	done
endc

AzaleaTownGrampsRushText:
if DEF(_FR_FR)
	text "Crois-tu que les"
	line "jeunes laisseront"
	cont "la priorité aux"
	cont "aînés dans cette"
	cont "situation?"
	
	para "Et bien non."
	done
else
	text "Do you think the"
	line "young people would"
	cont "give priority to"
	cont "the elder in this"
	cont "situation?"

	para "Well,"
	line "they don't."
	done
endc

AzaleaTownPokefanRushText:
if DEF(_FR_FR)
	text "Je ne suis pas sûr"
	line "de la distancia-"
	cont "tion sociale."
	
	para "Je peux pousser"
	line "un peu plus?"
	done
else
	text "I'm not sure about"
	line "social distancing."

	para "Can I push people"
	line "a little more?"
	done
endc

AzaleaTownApprenticeRushText:
if DEF(_FR_FR)
	text "APPRENTI: Je ne"
	line "pourrai jamais"
	cont "entrer dans la"
	cont "BOUTIQUE #MON"
	cont "avant qu'il ne"
	cont "soit trop tard..."
	done
else
	text "APPRENTICE: There"
	line "is no way I will"
	cont "be able to get"
	cont "into the #MON"
	cont "MART before it's"
	cont "too late…"
	done
endc

AzaleaTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 15,  9, AZALEA_POKECENTER_1F, 1
	warp_event 21, 13, CHARCOAL_KILN, 1
	warp_event 21,  5, AZALEA_MART, 2
	warp_event  9,  5, KURTS_HOUSE, 1
	warp_event 10, 15, AZALEA_GYM, 1
	warp_event 31,  7, SLOWPOKE_WELL_B1F, 1
	warp_event  2, 10, ILEX_FOREST_AZALEA_GATE, 3
	warp_event  2, 11, ILEX_FOREST_AZALEA_GATE, 4

	def_coord_events
	coord_event  5, 10, CE_SCENE_ID, SCENE_AZALEATOWN_RIVAL_BATTLE, AzaleaTownRivalBattleScene1
	coord_event  5, 11, CE_SCENE_ID, SCENE_AZALEATOWN_RIVAL_BATTLE, AzaleaTownRivalBattleScene2
	coord_event  9,  6, CE_SCENE_ID, SCENE_AZALEATOWN_KURT_RETURNS_GS_BALL, AzaleaTownCelebiScene

	def_bg_events
	bg_event 19,  9, BGEVENT_READ, AzaleaTownSign
	bg_event 10,  9, BGEVENT_READ, KurtsHouseSign
	bg_event 14, 15, BGEVENT_READ, AzaleaGymSign
	bg_event 29,  7, BGEVENT_READ, SlowpokeWellSign
	bg_event 19, 13, BGEVENT_READ, CharcoalKilnSign
	bg_event 16,  9, BGEVENT_READ, AzaleaTownPokecenterSign
	bg_event 22,  5, BGEVENT_READ, AzaleaTownMartSign
	bg_event  3,  9, BGEVENT_READ, AzaleaTownIlextForestSign
	bg_event 31,  6, BGEVENT_ITEM, AzaleaTownHiddenFullHeal
	bg_event  9,  5, BGEVENT_CLOSED_DOOR, AzaleaTown_DoorScript
	bg_event 21, 13, BGEVENT_CLOSED_DOOR, AzaleaTown_DoorScript
	bg_event 21,  5, BGEVENT_CLOSED_DOOR, AzaleaTown_DoorScript

	def_object_events
	object_event 17, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | MORN, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event 31,  9, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownRocket1Script, EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	object_event 21,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	object_event 15, 13, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, AzaleaTownTeacherScript, -1
	object_event  7,  9, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaTownYoungsterScript, -1
	object_event  8, 17, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 18,  9, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 29,  9, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 15, 15, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event  8,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WhiteApricornTree, -1
	object_event 11, 10, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_AZALEA_TOWN
	object_event 10, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownRocket2Script, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  6,  4, SPRITE_KURT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
	object_event 20,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownGrampsRush, EVENT_LOCKDOWN_MART_RUSH
	object_event 22,  6, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownTeacherRush, EVENT_LOCKDOWN_MART_RUSH
	object_event 21,  6, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaTownTeacherRush, EVENT_LOCKDOWN_MART_RUSH
	object_event 21,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownPokefanRush, EVENT_LOCKDOWN_MART_RUSH
	object_event 22,  9, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, AzaleaTownApprenticeRush, EVENT_LOCKDOWN_MART_RUSH
	
