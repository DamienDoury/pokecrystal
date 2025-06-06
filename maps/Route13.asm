	object_const_def
	const ROUTE13_YOUNGSTER1
	const ROUTE13_YOUNGSTER2
	const ROUTE13_POKEFAN_M1
	const ROUTE13_POKEFAN_M2
	const ROUTE13_POKEFAN_M3

Route13_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_GOT_COVID_ON_ROUTE_13
	iftrue .end

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the next battle, wherever that battle happens.

.end
	endcallback

TrainerPokefanmAlex:
	trainer POKEFANM, ALEX, EVENT_BEAT_POKEFANM_ALEX, PokefanmAlexSeenText, PokefanmAlexBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_13
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_13

	endifjustbattled
	jumptextfaceplayer PokefanmAlexAfterBattleText

TrainerPokefanmJoshua:
	trainer POKEFANM, JOSHUA, EVENT_BEAT_POKEFANM_JOSHUA, PokefanmJoshuaSeenText, PokefanmJoshuaBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_13
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_13

	endifjustbattled
	jumptextfaceplayer PokefanmJoshuaAfterBattleText

TrainerBirdKeeperPerry:
	trainer BIRD_KEEPER, PERRY, EVENT_BEAT_BIRD_KEEPER_PERRY, BirdKeeperPerrySeenText, BirdKeeperPerryBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_13
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_13

	endifjustbattled
	jumptextfaceplayer BirdKeeperPerryAfterBattleText

TrainerBirdKeeperBret:
	trainer BIRD_KEEPER, BRET, EVENT_BEAT_BIRD_KEEPER_BRET, BirdKeeperBretSeenText, BirdKeeperBretBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_13
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_13

	endifjustbattled
	jumptextfaceplayer BirdKeeperBretAfterBattleText

TrainerHikerKenny:
	trainer HIKER, KENNY, EVENT_BEAT_HIKER_KENNY, HikerKennySeenText, HikerKennyBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_13
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_13

	endifjustbattled
	jumptextfaceplayer HikerKennyAfterBattleText

Route13TrainerTips:
	jumptext Route13TrainerTipsText

Route13Sign:
	jumptext Route13SignText

Route13DirectionsSign:
	jumptext Route13DirectionsSignText

Route13HiddenCalcium:
	hiddenitem CALCIUM, EVENT_ROUTE_13_HIDDEN_CALCIUM

PokefanmAlexSeenText: 
if DEF(_FR_FR)
	text "A genoux devant"
	line "mes #MON!"
else
	text "Bow down before my"
	line "regal #MON!"
endc

	done

PokefanmAlexBeatenText: 
if DEF(_FR_FR)
	text "Comment oses-tu???"
	line "Sacrilège!"
else
	text "How… How dare you"
	line "mock royalty!"
endc

	done

PokefanmAlexAfterBattleText: 
if DEF(_FR_FR)
	text "Un jour je serai"
	line "roi! Oh que oui!"
	cont "Ha ha ha ha ha!"
else
	text "Doesn't everyone"
	line "wish to someday be"
	cont "a king?"
endc

	done

PokefanmJoshuaSeenText: 
if DEF(_FR_FR)
	text "Gnihihi! Tu veux"
	line "te mesurer à mon"
	cont "gang PIKACHU?"
else
	text "Nihihi! Would you"
	line "like to battle my"
	cont "PIKACHU gang?"
endc

	done

PokefanmJoshuaBeatenText: 
if DEF(_FR_FR)
	text "PI-PIKACHU!"
else
	text "PI-PIKACHU!"
endc

	done

PokefanmJoshuaAfterBattleText: 
if DEF(_FR_FR)
	text "Tu dois avoir"
	line "beaucoup de #-"

	para "MON, mais PIKACHU"
	line "est le meilleur."
else
	text "You look like you"
	line "have many #MON,"

	para "but PIKACHU is"
	line "still the best."
endc

	done

BirdKeeperPerrySeenText: 
if DEF(_FR_FR)
	text "L'agilité est LA"
	line "caractéristique"
	cont "des #MON"
	cont "oiseaux."
else
	text "Agility is the key"
	line "attribute of bird"
	cont "#MON."
endc

	done

BirdKeeperPerryBeatenText: 
if DEF(_FR_FR)
	text "Ta vitesse m'a"
	line "blousé..."
else
	text "You beat me with"
	line "your speed…"
endc

	done

BirdKeeperPerryAfterBattleText: 
if DEF(_FR_FR)
	text "Tes #MON sont"
	line "très bien entraî-"
	cont "nés."
else
	text "Your #MON are"
	line "remarkably well-"
	cont "trained."
endc

	done

BirdKeeperBretSeenText: 
if DEF(_FR_FR)
	text "Mate donc mes bô"
	line "#MON. Regarde"

	para "leur joli plumage."
	line "C'est trop cool."
else
	text "Check out my #-"
	line "MON. Just look at"

	para "their coloring and"
	line "their plumage."
endc

	done

BirdKeeperBretBeatenText: 
if DEF(_FR_FR)
	text "Naaaan!"
	line "Pas glop!"
else
	text "Shoot!"
	line "Not good enough!"
endc

	done

BirdKeeperBretAfterBattleText: 
if DEF(_FR_FR)
	text "Occupe-toi de tes"
	line "#MON et ils"
	cont "seront heureux."
else
	text "If you groom them,"
	line "#MON get happy."
endc

	done

HikerKennySeenText: 
if DEF(_FR_FR)
	text "Je vais passer à"
	line "la GROTTE pour"
	cont "choper un ONIX."
else
	text "I should go to"
	line "ROCK TUNNEL to get"
	cont "myself an ONIX."
endc

	done

HikerKennyBeatenText: 
if DEF(_FR_FR)
	text "Perdu..."
else
	text "I lost…"
endc

	done

HikerKennyAfterBattleText: 
if DEF(_FR_FR)
	text "La terre change..."
	line "Petit à petit."

	para "Les montagnes, les"
	line "paysages... Tout"
	cont "évolue."
else
	text "Geological fea-"
	line "tures don't appear"
	cont "to change."

	para "But they actually"
	line "change, little by"
	cont "little."
endc

	done

Route13TrainerTipsText: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Regardez à gauche"
	line "de cette pancarte."
else
	text "TRAINER TIPS"

	para "Look! Right there,"
	line "at the left side"
	cont "of the post."
endc

	done

Route13SignText: 
if DEF(_FR_FR)
	text "ROUTE 13"

	para "Nord du PONT du"
	line "SILENCE"
else
	text "ROUTE 13"

	para "NORTH TO SILENCE"
	line "BRIDGE"
endc

	done

Route13DirectionsSignText: 
if DEF(_FR_FR)
	text "NORD: LAVANVILLE"
	line "OUEST: PARMANIE"
else
	text "NORTH TO LAVENDER"
	line "TOWN"

	para "WEST TO FUCHSIA"
	line "CITY"
endc

	done

Route13_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 29, 13, BGEVENT_READ, Route13TrainerTips
	bg_event 41, 11, BGEVENT_READ, Route13Sign
	bg_event 17, 13, BGEVENT_READ, Route13DirectionsSign
	bg_event 30, 13, BGEVENT_ITEM, Route13HiddenCalcium

	def_object_events
	object_event 42,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperPerry, -1
	object_event 43,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBret, -1
	object_event 32,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanmJoshua, -1
	object_event 14, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerHikerKenny, -1
	object_event 25,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerPokefanmAlex, -1
