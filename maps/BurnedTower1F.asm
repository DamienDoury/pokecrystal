	object_const_def
	const BURNEDTOWER1F_ROCK
	const BURNEDTOWER1F_EUSINE
	const BURNEDTOWER1F_SILVER
	const BURNEDTOWER1F_MORTY
	const BURNEDTOWER1F_POKE_BALL

BurnedTower1F_MapScripts:
	def_scene_scripts
	scene_script .EusineScene ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_BURNEDTOWER1F_RIVAL_BATTLE
	scene_script .DummyScene2 ; SCENE_BURNEDTOWER1F_NOTHING

	def_callbacks
	callback MAPCALLBACK_TILES, .HoleAndLadder

.EusineScene:
	prioritysjump .MeetEusine
.DummyScene1:
.DummyScene2:
	end

.HoleAndLadder:
	checkevent EVENT_HOLE_IN_BURNED_TOWER
	iftrue .KeepHoleOpen
	changeblock  8, 8, $37 ; floor
	changeblock 10, 8, $38 ; floor
.KeepHoleOpen:
	checkevent EVENT_BURNED_TOWER_1F_EUSINE
	iftrue .HideBasement
	changeblock 6, 14, $09 ; ladder
.HideBasement:
	endcallback

.MeetEusine:
	turnobject BURNEDTOWER1F_EUSINE, DOWN
	showemote EMOTE_SHOCK, BURNEDTOWER1F_EUSINE, 15
	applymovement BURNEDTOWER1F_EUSINE, BurnedTower1FEusineMovement
	opentext
	writetext BurnedTower1FEusineIntroText
	waitbutton
	closetext
	moveobject BURNEDTOWER1F_EUSINE, 9, 14
	setscene SCENE_BURNEDTOWER1F_RIVAL_BATTLE
	end

BurnedTowerRivalBattleScript:
	showemote EMOTE_SHOCK, BURNEDTOWER1F_SILVER, 15
	special FadeOutMusic
	pause 15
	turnobject BURNEDTOWER1F_SILVER, RIGHT
	pause 15
	applymovement PLAYER, BurnedTowerMovement_PlayerWalksToSilver
	applymovement BURNEDTOWER1F_SILVER, BurnedTowerMovement_SilverWalksToPlayer
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext BurnedTowerSilver_BeforeText
	waitbutton
	closetext
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .chikorita
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_3_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.totodile
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_3_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.chikorita
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_3_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.returnfrombattle
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext BurnedTowerSilver_AfterText1
	waitbutton
	closetext
	setscene SCENE_BURNEDTOWER1F_NOTHING
	setevent EVENT_RIVAL_BURNED_TOWER
	special FadeOutMusic
	pause 15
	earthquake 50
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	waitsfx
	changeblock  8, 8, $39 ; hole border
	changeblock 10, 8, $25 ; hole
	reloadmappart
	pause 15
	applymovement PLAYER, BurnedTower1FMovement_PlayerStartsToFall
	playsound SFX_KINESIS
	showemote EMOTE_SHOCK, BURNEDTOWER1F_SILVER, 20
	opentext
	writetext BurnedTowerSilver_AfterText2
	waitbutton
	closetext
	setevent EVENT_HOLE_IN_BURNED_TOWER
	pause 15
	warpcheck
	end

BurnedTower1FEusineScript:
	jumptextfaceplayer BurnedTower1FEusineText

BurnedTower1FMortyScript:
	jumptextfaceplayer BurnedTower1FMortyText

BurnedTower1FRock:
	jumpstd SmashRockScript

BurnedTower1FHiddenEther:
	hiddenitem ETHER, EVENT_BURNED_TOWER_1F_HIDDEN_ETHER

BurnedTower1FHiddenUltraBall:
	hiddenitem ULTRA_BALL, EVENT_BURNED_TOWER_1F_HIDDEN_ULTRA_BALL

BurnedTower1FHPUp:
	itemball HP_UP

BurnedTowerMovement_PlayerWalksToSilver:
	step LEFT
	step_end

BurnedTowerMovement_SilverWalksToPlayer:
	step RIGHT
	step_end

BurnedTower1FMovement_PlayerStartsToFall:
	skyfall_top
	step_end

BurnedTower1FEusineMovement:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step_end

BurnedTowerSilver_BeforeText: 
if DEF(_FR_FR)
	text "<……> <……> <……>"

	para "...Oh, c'est toi."

	para "Je suis venu pour"
	line "trouver une sorte"

	para "de #MON légen-"
	line "daire..."

	para "Mais y'a rien ici!"

	para "Venir dans ce trou"
	line "paumé pour rien"

	para "trouver, moi ça"
	line "m'énerve la tête!"

	para "Je vais t'en faire"
	line "baver!"
else
	text "<……> <……> <……>"

	para "…Oh, it's you."

	para "I came looking for"
	line "some legendary"

	para "#MON that they"
	line "say roosts here."

	para "But there's"
	line "nothing here!"

	para "Nothing after all"
	line "the trouble of"

	para "coming to this"
	line "dump? No way!"

	para "It's all your"
	line "fault!"
endc

	done

BurnedTowerSilver_WinText: 
if DEF(_FR_FR)
	text "...Pfff!"
	para "Aucun intérêt."
else
	text "…Humph!"

	para "This is why I hate"
	line "battling wimps."

	para "There's no"
	line "challenge in it."
endc

	done

BurnedTowerSilver_AfterText1: 
if DEF(_FR_FR)
	text "Pff...minable."

	para "T'auras jamais un"
	line "#MON légendaire"

	para "de toute façon."
	line "T'es zéro."
else
	text "…Aw, whatever."

	para "You would never be"
	line "able to catch a"

	para "legendary #MON"
	line "anyway."
endc

	done

BurnedTowerSilver_LossText: 
if DEF(_FR_FR)
	text "...Pff!"

	para "Voilà pourquoi"
	line "j'aime pas me"

	para "battre contre les"
	line "nuls: c'est une"
	cont "perte de temps."
else
	text "…Humph!"

	para "This is why I hate"
	line "battling wimps."

	para "It's just a waste"
	line "of my time."
endc

	done

BurnedTowerSilver_AfterText2: 
if DEF(_FR_FR)
	text "...Pfff!"

	para "Tu tombes dans les"
	line "trous?"

	para "T'es pas trop"
	line "bête, c'est bien."

	para "Minable!"
else
	text "Humph!"

	para "What are you doing"
	line "falling into a"

	para "hole? Some genius"
	line "you are!"

	para "Serves you right!"
endc

	done

BurnedTower1FEusineIntroText: 
if DEF(_FR_FR)
	text "EUSINE: Mon nom"
	line "est EUSINE."

	para "Je poursuis un"
	line "#MON du nom de"
	cont "SUICUNE."

	para "Et toi c'est quoi?"

	para "<PLAYER>? Ravi"
	line "de te connaître!"

	para "On raconte que"
	line "SUICUNE est dans"

	para "cette TOUR CEN-"
	line "DREE..."

	para "Mais où???"
else
	text "EUSINE: My name's"
	line "EUSINE."

	para "I'm on the trail"
	line "of a #MON named"
	cont "SUICUNE."

	para "And you are…?"

	para "<PLAYER>? Glad to"
	line "meet you!"

	para "I heard rumors"
	line "that SUICUNE is in"

	para "this BURNED TOWER,"
	line "so I came to look."

	para "But where exactly"
	line "could it be?"
endc

	done

BurnedTower1FEusineText: 
if DEF(_FR_FR)
	text "On raconte que"
	line "SUICUNE est dans"

	para "cette TOUR CEN-"
	line "DREE..."

	para "Mais où???"
else
	text "EUSINE: I heard"
	line "that SUICUNE is in"

	para "this BURNED TOWER,"
	line "so I came to look."

	para "But where exactly"
	line "could it be?"
endc

	done

BurnedTower1FMortyText: 
if DEF(_FR_FR)
	text "MORTIMER: Le CHAM-"
	line "PION de ROSALIA"

	para "doit étudier les"
	line "#MON légen-"

	para "daires: SUICUNE,"
	line "ENTEI et RAIKOU."

	para "EUSINE est ici."
	line "J'ai décidé de"

	para "fouiller la TOUR"
	line "avec lui."
else
	text "MORTY: ECRUTEAK's"
	line "GYM LEADER has to"

	para "study what are"
	line "said to be the"

	para "legendary #MON"
	line "--SUICUNE, ENTEI"
	cont "and RAIKOU."

	para "EUSINE is here, so"
	line "I've decided to"

	para "investigate the"
	line "TOWER with him."
endc

	done

BurnedTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, ECRUTEAK_CITY, 13
	warp_event 10, 15, ECRUTEAK_CITY, 13
	warp_event 10,  9, BURNED_TOWER_B1F, 1
	warp_event  7, 15, BURNED_TOWER_B1F, 2

	def_coord_events
	coord_event 11,  9, CE_EVENT_FLAG_CLEARED, EVENT_RIVAL_BURNED_TOWER, BurnedTowerRivalBattleScript

	def_bg_events
	bg_event  8,  7, BGEVENT_ITEM, BurnedTower1FHiddenEther
	bg_event 13, 11, BGEVENT_ITEM, BurnedTower1FHiddenUltraBall

	def_object_events
	object_event 15,  4, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BurnedTower1FRock, -1
	object_event 12, 12, SPRITE_EUSINE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, BurnedTower1FEusineScript, EVENT_BURNED_TOWER_1F_EUSINE
	object_event  8,  9, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, ObjectEvent, EVENT_RIVAL_BURNED_TOWER
	object_event 14, 14, SPRITE_MORTY, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BurnedTower1FMortyScript, EVENT_BURNED_TOWER_MORTY
	object_event 14,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BurnedTower1FHPUp, EVENT_BURNED_TOWER_1F_HP_UP
