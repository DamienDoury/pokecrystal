	object_const_def
	const GOLDENRODCITY_TRAVEL_CONTROLLER
	const GOLDENRODCITY_POKEFAN_M1
	const GOLDENRODCITY_YOUNGSTER1
	const GOLDENRODCITY_COOLTRAINER_F1
	const GOLDENRODCITY_COOLTRAINER_F2
	const GOLDENRODCITY_YOUNGSTER2
	const GOLDENRODCITY_LASS
	const GOLDENRODCITY_GRAMPS
	const GOLDENRODCITY_ROCKETSCOUT
	const GOLDENRODCITY_ROCKET1
	const GOLDENRODCITY_ROCKET2
	const GOLDENRODCITY_ROCKET3
	const GOLDENRODCITY_ROCKET4
	const GOLDENRODCITY_ROCKET5
	const GOLDENRODCITY_ROCKET6
	const GOLDENRODCITY_MOVETUTOR
	const GOLDENRODCITY_BEATER
	const GOLDENRODCITY_MARTRUSH_1
	const GOLDENRODCITY_MARTRUSH_2
	const GOLDENRODCITY_MARTRUSH_3
	const GOLDENRODCITY_MARTRUSH_4

GoldenrodCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .MoveTutor

.FlyPoint:
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_REACHED_GOLDENROD
	
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iffalse .EndTilesCallback ; When Goldenrod's invasion is happening, the travel controller is absent.
	
	checkevent EVENT_TRAVEL_CONTROL
	iftrue .EndTilesCallback ; Outside of the travel control period, the travel controller is absent.

	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

.TilesLoad:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	changeblock 24, 14, $1a ; Door to Hall Of Fame.
endc
	; Casino
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .BikeShop

	changeblock 14, 20, $34
	changeblock 16, 20, $37

.BikeShop
	checkevent GOLDENROD_BIKE_SHOP_CLOSED
	iftrue .FlowerShop

	changeblock 28, 28, $38
	changeblock 30, 28, $39

.FlowerShop
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	readmem wCurFreedomState
	ifequal 1 << FREE, .NameRater
	ifequal 1 << CURFEW, .CloseFlowerShop
	ifequal 1 << VACCINE_PASSPORT, .NameRater

	; Here we managed the special case of the lockdown: the flower shop stays open during the lockdown until the player gets the squirtbottle.
	checkitem SQUIRTBOTTLE
	iffalse .NameRater

.CloseFlowerShop
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	changeblock 28,  4, $2b

.NameRater
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock 14,  6, $38 ; Name Rater.
	changeblock 16,  6, $39 ; Name Rater.

	changeblock 22, 22, $30 ; Dept. Store.
	changeblock 24, 22, $31 ; Dept. Store.
	changeblock 26, 22, $32 ; Dept. Store.
	changeblock 22, 24, $30 ; Dept. Store.
	changeblock 24, 24, $31 ; Dept. Store.
	changeblock 26, 24, $32 ; Dept. Store.

.EndTilesCallback
	endcallback

.MoveTutor:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse .MoveTutorDone
	checkitem COIN_CASE
	iffalse .MoveTutorDisappear
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	sjump .MoveTutorAppear
endc
	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .MoveTutorAppear
	ifequal SATURDAY, .MoveTutorAppear
.MoveTutorDisappear:
	disappear GOLDENRODCITY_MOVETUTOR
	endcallback

.MoveTutorAppear:
	checkflag ENGINE_DAILY_MOVE_TUTOR
	iftrue .MoveTutorDone
	appear GOLDENRODCITY_MOVETUTOR
.MoveTutorDone:
	endcallback

MoveTutorScript:
	faceplayer
	opentext
	writetext GoldenrodCityMoveTutorAskTeachAMoveText
	yesorno
	iffalse .Refused
	special DisplayCoinCaseBalance
	writetext GoldenrodCityMoveTutorAsk4000CoinsOkayText
	yesorno
	iffalse .Refused2
	checkcoins 4000
	ifequal HAVE_LESS, .NotEnoughMoney
	writetext GoldenrodCityMoveTutorWhichMoveShouldITeachText
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal MOVETUTOR_FLAMETHROWER, .Flamethrower
	ifequal MOVETUTOR_THUNDERBOLT, .Thunderbolt
	ifequal MOVETUTOR_ICE_BEAM, .IceBeam
	sjump .Incompatible

.Flamethrower:
	setval MOVETUTOR_FLAMETHROWER
	writetext GoldenrodCityMoveTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Incompatible

.Thunderbolt:
	setval MOVETUTOR_THUNDERBOLT
	writetext GoldenrodCityMoveTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Incompatible

.IceBeam:
	setval MOVETUTOR_ICE_BEAM
	writetext GoldenrodCityMoveTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Incompatible

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
if DEF(_FR_FR)
	db "LANCE-FLAMME@"
	db "TONNERRE@"
	db "LASER GLACE@"
	db "RETOUR@"
else
	db "FLAMETHROWER@"
	db "THUNDERBOLT@"
	db "ICE BEAM@"
	db "CANCEL@"
endc

.Refused:
	writetext GoldenrodCityMoveTutorAwwButTheyreAmazingText
	waitbutton
	closetext
	end

.Refused2:
	writetext GoldenrodCityMoveTutorHmTooBadText
	waitbutton
	closetext
	end

.TeachMove:
	writetext GoldenrodCityMoveTutorIfYouUnderstandYouveMadeItText
	promptbutton
	takecoins 4000
	waitsfx
	playsound SFX_TRANSACTION
	special DisplayCoinCaseBalance
	writetext GoldenrodCityMoveTutorFarewellKidText
	waitbutton
	closetext
	applymovement GOLDENRODCITY_MOVETUTOR, GoldenrodCityMoveTutorEnterGameCornerMovement
	playsound SFX_ENTER_DOOR
	disappear GOLDENRODCITY_MOVETUTOR
	clearevent EVENT_GOLDENROD_GAME_CORNER_MOVE_TUTOR
	setflag ENGINE_DAILY_MOVE_TUTOR
	waitsfx
	end

.Incompatible:
	writetext GoldenrodCityMoveTutorBButText
	waitbutton
	closetext
	end

.NotEnoughMoney:
	writetext GoldenrodCityMoveTutorYouDontHaveEnoughCoinsText
	waitbutton
	closetext
	end

GoldenrodCityPokefanMScript:
	jumptextfaceplayer GoldenrodCityPokefanMText

GoldenrodCityYoungster1Script:
	jumptextfaceplayer GoldenrodCityYoungster1Text

GoldenrodCityCooltrainerF1Script:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .ClearedRadioTower
	jumptextfaceplayer GoldenrodCityCooltrainerF1Text

.ClearedRadioTower:
	jumptextfaceplayer GoldenrodCityCooltrainerF1Text_ClearedRadioTower

GoldenrodCityCooltrainerF2Script:
	checkflag ENGINE_RADIO_CARD
	iftrue .GotRadioCard

	jumptextfaceplayer GoldenrodCityCooltrainerF2Text

.GotRadioCard:
	jumptextfaceplayer GoldenrodCityCooltrainerF2Text_GotRadioCard

GoldenrodCityYoungster2Script:
	jumptextfaceplayer GoldenrodCityYoungster2Text

GoldenrodCityLassScript:
	jumptextfaceplayer GoldenrodCityLassText

GoldenrodCityGrampsScript:
	jumptextfaceplayer GoldenrodCityGrampsText

GoldenrodCityRocketScoutScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	opentext
	writetext GoldenrodCityRocketScoutText1
	promptbutton
	faceplayer
	writetext GoldenrodCityRocketScoutText2
	waitbutton
	closetext
	turnobject GOLDENRODCITY_ROCKETSCOUT, UP
	end

.lockdown
	jumptextfaceplayer GoldenrodCityRocketScoutLockdownText

GoldenrodCityRocket1Script:
	faceplayer
	jumptext GoldenrodCityRocket1Text

GoldenrodCityRocket2Script:
	faceplayer
	jumptext GoldenrodCityRocket2Text

GoldenrodCityRocket3Script:
	faceplayer
	jumptext GoldenrodCityRocket3Text

GoldenrodCityRocket4Script:
	faceplayer
	jumptext GoldenrodCityRocket4Text

GoldenrodCityRocket5Script:
	faceplayer
	jumptext GoldenrodCityRocket5Text

GoldenrodCityRocket6Script:
	faceplayer
	jumptext GoldenrodCityRocket6Text

GoldenrodCityMarketRush1Script:
	jumptext GoldenrodCityMarketRush1Text

GoldenrodCityMarketRush2Script:
	jumptext GoldenrodCityMarketRush2Text

GoldenrodCityMarketRush3Script:
	jumptext GoldenrodCityMarketRush3Text

GoldenrodCityMarketRush4Script:
	jumptext GoldenrodCityMarketRush4Text

GoldenrodCityStationSign:
	jumptext GoldenrodCityStationSignText

GoldenrodCityRadioTowerSign:
	jumptext GoldenrodCityRadioTowerSignText

GoldenrodDeptStoreSign:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
.item_loop
	readmem wNumItems
	ifequal MAX_ITEMS, .medicine_loop
	ifgreater MAX_ITEMS, .medicine_loop
	giveitem MAX_REPEL, 99
	sjump .item_loop

.medicine_loop
	readmem wNumMeds
	ifequal MAX_MEDS, .balls_loop
	ifgreater MAX_MEDS, .balls_loop
	giveitem FULL_RESTORE, 99
	sjump .medicine_loop

.balls_loop
	readmem wNumBalls
	ifequal MAX_BALLS, .berries_loop
	ifgreater MAX_BALLS, .berries_loop
	giveitem MASTER_BALL, 99
	sjump .balls_loop

.berries_loop
	readmem wNumBerries
	ifequal MAX_BERRIES, .end_loop
	ifgreater MAX_BERRIES, .end_loop
	giveitem GOLD_BERRY, 99
	sjump .berries_loop

.end_loop
endc
	jumptext GoldenrodDeptStoreSignText

GoldenrodGymSign:
	jumptext GoldenrodGymSignText

GoldenrodCitySign:
	jumptext GoldenrodCitySignText

GoldenrodCityBikeShopSign:
	checkevent GOLDENROD_BIKE_SHOP_CLOSED
	iffalse .closed
	jumptext GoldenrodCityBikeShopSignText

.closed
	farjumptext CeruleanBikeShopSignText

GoldenrodCityGameCornerSign:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	setevent EVENT_CINNABAR_ROCKS_CLEARED
endc
	jumptext GoldenrodCityGameCornerSignText

GoldenrodCityNameRaterSign:
	jumptext GoldenrodCityNameRaterSignText

GoldenrodCityUndergroundSignNorth:
	jumptext GoldenrodCityUndergroundSignNorthText

GoldenrodCityUndergroundSignSouth:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	setevent EVENT_POKEGEAR_CONTACT_TRACING_MODULE
endc
	jumptext GoldenrodCityUndergroundSignNorthText

GoldenrodCityPokecenterSign:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	readmem wParkBallsRemaining
	addval 1
	writemem wPartySpecies
	addval 1
	writemem wPartySpecies + 1
	addval 1
	writemem wPartySpecies + 2
	addval 1
	writemem wPartySpecies + 3
	addval 1
	writemem wPartySpecies + 4
	addval 1
	writemem wPartySpecies + 5
	writemem wParkBallsRemaining
	end
endc
	jumpstd PokecenterSignScript

GoldenrodCityFlowerShopSign:
	jumptext GoldenrodCityFlowerShopSignText

GoldenrodHospitalSign:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	loadmem wYearMonth, 3
	setevent EVENT_SICK_CATERPIE
	setevent EVENT_LOCKDOWN_MART_RUSH ; Stops the rush.
	setevent EVENT_FIRST_LOCKDOWN_STARTED
	;clearevent EVENT_TRAVEL_CONTROL
	clearevent EVENT_MART_CHERRYGROVE_MISSED
	clearevent EVENT_MART_VIOLET_MISSED
	clearevent EVENT_MART_AZALEA_MISSED
	clearevent EVENT_CHARCOAL_KILN_APPRENTICE
	clearevent EVENT_GOLDENROD_BEATER
	;loadmem wCurFreedomState, 1 << LOCKDOWN
	setscene SCENE_GOLDENROD_HOSPITAL_NO_SEARCH
endc
	jumptext GoldenrodHospitalSignText

GoldenrodFlowerShopDoorScript:
GoldenrodNameRaterDoorScript:
	jumpstd LockdownCurfewClosedDoor

GoldenrodCasinoDoorScript:
	jumpstd ClosedBusinessScript

GoldenrodCasinoWindowScript:
	conditional_event EVENT_BROCK_BACK_IN_GYM, .Script ; Opposite of EVENT_CINNABAR_ROCKS_CLEARED.

.Script:
	checkitem COIN_CASE
	iftrue .found_hidden_casino

	jumptext GoldenrodCasinoWindowText
.found_hidden_casino
	jumptext GoldenrodCasinoWindowKnownSecretText

GoldenrodBikeShopDoorScript:
	farjumptext CeruleanLockedDoorText

GoldenrodCityBeaterScript:
	opentext
	checkevent EVENT_GOLDENROD_BEATER
	iftrue .GetLost
	writetext BeaterText1
	yesorno
	iffalse .GetLost
	writetext BeaterText2
	yesorno
	iftrue .GoodBye
	writetext BeaterText2Bis
	promptbutton

.GoodBye:
	writetext BeaterText3
	waitbutton
	closetext
	setevent EVENT_GOLDENROD_BEATER
	clearevent EVENT_GOLDENROD_ILLEGAL_CASINO
	end

.GetLost:
	writetext GetLostText
	waitbutton
	closetext
	end

GoldenrodCityMoveTutorEnterGameCornerMovement:
	step RIGHT
	step UP
	step_end

GoldenrodCityPokefanMText: 
if DEF(_FR_FR)
	text "Ils ont construit"
	line "une nouvelle TOUR"

	para "RADIO pour rempla-"
	line "cer l'ancienne."
else
	text "They built the new"
	line "RADIO TOWER to"

	para "replace the old,"
	line "creaky one."
endc

	done

GoldenrodCityYoungster1Text: 
if DEF(_FR_FR)
	text "Je sais qu'il y a"
	line "un nouveau CYCLES"

	para "A GOGO, mais je ne"
	line "le trouve pas."
else
	text "I know there's a"
	line "new BIKE SHOP, but"

	para "I can't find it"
	line "anywhere."
endc

	done

GoldenrodCityCooltrainerF1Text: 
if DEF(_FR_FR)
	text "Ce type en noir"
	line "est habillé"

	para "comme un membre de"
	line "la TEAM ROCKET!"
	cont "Quel bêta!"
else
	text "Is that man in"
	line "black dressed up"

	para "like a TEAM ROCKET"
	line "member? How silly!"
endc

	done

GoldenrodCityCooltrainerF1Text_ClearedRadioTower: 
if DEF(_FR_FR)
	text "Cet homme faisait"
	line "vraiment partie de"

	para "la TEAM ROCKET?"
	line "J'y crois pas!"
else
	text "Was that man in"
	line "black really part"

	para "of TEAM ROCKET? I"
	line "can't believe it!"
endc

	done

GoldenrodCityCooltrainerF2Text: 
if DEF(_FR_FR)
	text "La TOUR RADIO de"
	line "DOUBLONVILLE est"
	cont "un point de"
	cont "repère."

	para "Ils organisent une"
	line "campagne promo-"
	cont "tionnelle en ce"
	cont "moment."

	para "Ils te modifieront"
	line "ton #MATOS"

	para "pour t'en servir"
	line "comme radio."
else
	text "The RADIO TOWER in"
	line "GOLDENROD CITY is"
	cont "a landmark."

	para "They're running a"
	line "promotional cam- "
	cont "paign right now."

	para "They'll modify"
	line "your #GEAR,"

	para "so it can also"
	line "serve as a radio."
endc

	done

GoldenrodCityCooltrainerF2Text_GotRadioCard: 
if DEF(_FR_FR)
	text "Oh, ton #MATOS"
	line "fait radio!"
else
	text "Oh, your #GEAR"
	line "works as a radio!"
endc

	done

GoldenrodCityYoungster2Text:
if DEF(_FR_FR)
	text "L'hôpital au nord"
	line "de la ville a été"
	cont "construit en juste"
	cont "10 jours!"

	para "Et sa capacité est"
	line "de 1000 lits!"

	para "Yo, c'est dingo!"
	done
else
	text "The hospital in"
	line "the north of the"
	cont "city has been"
	cont "built in only"
	cont "10 days!"

	para "And it has a capa-"
	line "city of 1000 beds!"

	para "Yo, it's crazy!"
	done
endc

GoldenrodCityLassText: 
if DEF(_FR_FR)
	text "L'homme de cette"
	line "maison note les"
	cont "noms de tes"
	cont "#MON."

	para "Il peut même"
	line "renommer tes"
	cont "#MON."
else
	text "The man at that"
	line "house rates your"
	cont "#MON names."

	para "He can even rename"
	line "your #MON."
endc

	done

GoldenrodCityGrampsText: 
if DEF(_FR_FR)
	text "Whoua! C'est une"
	line "très grosse ville."

	para "Je suis totalement"
	line "perdu ici."
else
	text "Whew! This is one"
	line "big town. I don't"

	para "know where any-"
	line "thing is."
endc

	done

GoldenrodCityRocketScoutText1: 
if DEF(_FR_FR)
	text "C'est donc ça la"
	line "TOUR RADIO..."
else
	text "So this is the"
	line "RADIO TOWER…"
endc

	done

GoldenrodCityRocketScoutText2: 
if DEF(_FR_FR)
	text "Que veux-tu petit"
	line "scarabée? Gage-dé!"
else
	text "What do you want,"
	line "you pest? Scram!"
endc

	done

GoldenrodCityRocketScoutLockdownText:
if DEF(_FR_FR)
	text "Sortir dehors est"
	line "contraire à"
	cont "la loi..."

	para "T'as l'esprit"
	line "rebel, c'est ça?"

	para "Rejoins donc la"
	line "TEAM ROCKET!"
	
	para "On a de grandes"
	line "ambitions!"
	done
else
	text "Going outside"
	line "against the law…"

	para "You're a little"
	line "outlaw, eh?"

	para "You should join"
	line "TEAM ROCKET! We've"
	cont "got big plans!"
	done
endc

GoldenrodCityRocket1Text: 
if DEF(_FR_FR)
	text "Reste hors de mon"
	line "chemin! Dégage!!"
else
	text "Stay out of the"
	line "way! Beat it!"
endc

	done

GoldenrodCityRocket2Text: 
if DEF(_FR_FR)
	text "Envahir la TOUR"
	line "RADIO..."

	para "Quoi? Mais c'est"
	line "pas tes oignons!"
else
	text "Take over the"
	line "RADIO TOWER…"

	para "What? It's none of"
	line "your business!"
endc

	done

GoldenrodCityRocket3Text: 
if DEF(_FR_FR)
	text "Les #MON? Ils"
	line "ne servent qu'à"

	para "amasser des tonnes"
	line "de #thunes!"
else
	text "#MON? They're"
	line "nothing more than"

	para "tools for making"
	line "money!"
endc

	done

GoldenrodCityRocket4Text: 
if DEF(_FR_FR)
	text "Notre rêve va"
	line "bientôt devenir"
	cont "réalité..."

	para "C'était une si"
	line "longue lutte..."
else
	text "Our dream will"
	line "soon come true…"

	para "It was such a long"
	line "struggle…"
endc

	done

GoldenrodCityRocket5Text: 
if DEF(_FR_FR)
	text "Hé, toi! T'es"
	line "pas de la bande!"
	cont "Bouge de là!"
else
	text "Hey, brat! You"
	line "don't belong here!"
	cont "Get lost!"
endc

	done

GoldenrodCityRocket6Text: 
if DEF(_FR_FR)
	text "Viens te frotter à"
	line "la terreur de la"
	cont "TEAM ROCKET!"
else
	text "Come taste the"
	line "true terror of"
	cont "TEAM ROCKET!"
endc

	done

GoldenrodCityStationSignText: 
if DEF(_FR_FR)
	text "STATION de"
	line "DOUBLONVILLE"
else
	text "GOLDENROD CITY"
	line "STATION"
endc

	done

GoldenrodCityRadioTowerSignText: 
if DEF(_FR_FR)
	text "TOUR RADIO de"
	line "DOUBLONVILLE"
else
	text "GOLDENROD CITY"
	line "RADIO TOWER"
endc

	done

GoldenrodDeptStoreSignText: 
if DEF(_FR_FR)
	text "Marchandises de"
	line "premier choix pour"
	cont "#MON!"

	para "CENTRE COMMERCIAL"
	line "de DOUBLONVILLE"
else
	text "Full Selection of"
	line "#MON Goods!"

	para "GOLDENROD CITY"
	line "DEPT.STORE"
endc

	done

GoldenrodGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "de DOUBLONVILLE:"
	cont "BLANCHE"

	para "La fille qui est"
	line "trop, trop bien!"
else
	text "GOLDENROD CITY"
	line "#MON GYM"
	cont "LEADER: WHITNEY"

	para "The Incredibly"
	line "Pretty Girl!"
endc

	done

GoldenrodCitySignText: 
if DEF(_FR_FR)
	text "DOUBLONVILLE"

	para "La ville festive"
	line "qui fleure bon la"
	cont "bonne humeur"
else
	text "GOLDENROD CITY"

	para "The Festive City"
	line "of Opulent Charm"
endc

	done

GoldenrodCityBikeShopSignText: 
if DEF(_FR_FR)
	text "Dans la vie pour"
	line "avancer faut"
	cont "pédaler!"
	cont "CYCLES A GOGO"
else
	text "The World is a"
	line "Cycle Path!"
	cont "BIKE SHOP"
endc

	done

GoldenrodCityGameCornerSignText: 
if DEF(_FR_FR)
	text "Votre espace de"
	line "jeux!"

	para "CASINO de"
	line "DOUBLONVILLE"
else
	text "Your Playground!"

	para "GOLDENROD CITY"
	line "GAME CORNER"
endc

	done

GoldenrodCityNameRaterSignText: 
if DEF(_FR_FR)
	text "LE NOTEUR DE NOM"

	para "Evaluez le surnom"
	line "de votre #MON"
else
	text "NAME RATER"

	para "Get Your #MON"
	line "Nicknames Rated"
endc

	done

GoldenrodCityUndergroundSignNorthText: 
if DEF(_FR_FR)
	text "ENTREE du"
	line "SOUTERRAIN"
else
	text "UNDERGROUND"
	line "ENTRANCE"
endc

	done

GoldenrodCityFlowerShopSignText: 
if DEF(_FR_FR)
	text "Une fleur, la vie!"
	line "FLEURISTE"
else
	text "Blooming Beautiful"
	line "FLOWER SHOP"
endc

	done

GoldenrodHospitalSignText:
if DEF(_FR_FR)
	text "HOPITAL NATIONAL"
	line "DE DOUBLONVILLE"
	done
else
	text "GOLDENROD NATIONAL"
	line "HOSPITAL"
	done
endc

GoldenrodCityMoveTutorAskTeachAMoveText: 
if DEF(_FR_FR)
	text "Je peux apprendre"
	line "à tes #MON de"
	cont "super capacités."

	para "Ca t'intéresse?"
else
	text "I can teach your"
	line "#MON amazing"

	para "moves if you'd"
	line "like."

	para "Should I teach a"
	line "new move?"
endc

	done

GoldenrodCityMoveTutorAsk4000CoinsOkayText: 
if DEF(_FR_FR)
	text "Ca te coûtera"
	line "4000 jetons. OK?"
else
	text "It will cost you"
	line "4000 coins. Okay?"
endc

	done

GoldenrodCityMoveTutorAwwButTheyreAmazingText: 
if DEF(_FR_FR)
	text "Dommage pour toi."
else
	text "Aww… But they're"
	line "amazing…"
endc

	done

GoldenrodCityMoveTutorWhichMoveShouldITeachText: 
if DEF(_FR_FR)
	text "Wahahah! Tu ne le"
	line "regretteras pas!"

	para "Quelle capacité"
	line "veux-tu apprendre?"
else
	text "Wahahah! You won't"
	line "regret it!"

	para "Which move should"
	line "I teach?"
endc

	done

GoldenrodCityMoveTutorHmTooBadText: 
if DEF(_FR_FR)
	text "Dommage."
	line "Il me faut de"
	cont "l'argent..."
else
	text "Hm, too bad. I'll"
	line "have to get some"
	cont "cash from home…"
endc

	done

GoldenrodCityMoveTutorIfYouUnderstandYouveMadeItText: 
if DEF(_FR_FR)
	text "Si tu peux com-"
	line "prendre à quel"

	para "point cette capa-"
	line "cité est terrible,"
	cont "tu peux te vanter"
	cont "d'être balèze."
else
	text "If you understand"
	line "what's so amazing"

	para "about this move,"
	line "you've made it as"
	cont "a trainer."
endc

	done

GoldenrodCityMoveTutorFarewellKidText: 
if DEF(_FR_FR)
	text "Wahahah!"
	line "Adieu!"
else
	text "Wahahah!"
	line "Farewell, kid!"
endc

	done

GoldenrodCityMoveTutorBButText: 
if DEF(_FR_FR)
	text "M...mais!"
else
	text "B-but…"
endc

	done

GoldenrodCityMoveTutorYouDontHaveEnoughCoinsText: 
if DEF(_FR_FR)
	text "Pas assez de"
	line "jetons..."
else
	text "…You don't have"
	line "enough coins here…"
endc

	done

GoldenrodCasinoWindowText:
if DEF(_FR_FR)
	text "Le CASINO a oublié"
	line "d'éteindre ses"

	para "lumières avant de"
	line "fermer."

	para "Quelqu'un va avoir"
	line "une facture d'élec-"
	cont "tricité salée!"
else
	text "The GAME CORNER"
	line "forgot to turn"
	
	para "off the lights"
	line "before closing."

	para "Someone's gonna get"
	line "a spicy electri-"
	cont "city bill!"
endc
	done

GoldenrodCasinoWindowKnownSecretText:
if DEF(_FR_FR)
	text "Le CASINO a oublié"
	line "de fermer quelques"

	para "rideaux alors qu'il"
	line "est illégalement"
	cont "ouvert en secret."

	para "Mieux vaut garder"
	line "ça sous silence."
else
	text "The GAME CORNER"
	line "forgot to close"
	
	para "some curtains"
	line "while operating"
	cont "secretly."

	para "Better to keep"
	line "it a secret."
endc
	done

BeaterText1:
if DEF(_FR_FR)
	text "Hé gamin."

	para "Tu veux t'amuser"
	line "un peu?"
else
	text "Hey kid."

	para "Wanna have"
	line "some fun?"
endc
	done

BeaterText2:
if DEF(_FR_FR)
	text "Très bien."

	para "Va dans le souter-"
	line "rain juste après"
	cont "la tombée de la"

	para "nuit et parle à"
	line "mon collègue."

	para "Montre-lui un"
	line "CORNEBRE et un"
	cont "NOSFERAPTI pour"
	cont "qu'il sache que"
	cont "c'est moi qui"
	cont "t'envoie."

	para "Aucun autre que"
	line "ces deux-là dans"
	cont "ton équipe, c'est"
	cont "le code secret."

	para "Apporte du fric."
	line "3000¥ minimum."

	para "Compris?"
else
	text "All right."

	para "Go in the"
	line "underground just"
	cont "after nightfall"

	para "and talk to my"
	line "colleague."

	para "You show him a"
	line "MURKROW & a ZUBAT"
	cont "so he knows I sent"
	cont "you."

	para "No other #MON"
	line "than those two in"
	cont "your party,"
	cont "that's the code."

	para "Bring some cash."
	line "¥3000 at least."

	para "Got it?"
endc
	done

BeaterText2Bis:
if DEF(_FR_FR)
	text "Souterrain. A la"
	line "tombée de la nuit."

	para "Apporte seulement"
	line "CORNEBRE et NOS-"
	cont "FERAPTI et 3000¥."
else
	text "Underground. Just"
	line "after nightfall."

	para "Bring only"
	line "MURKROW & ZUBAT"
	cont "and ¥3000 cash."
endc
	done

BeaterText3:
if DEF(_FR_FR)
	text "Maintenant"
	line "dégage."
else
	text "Now bounce."
endc
	done

GetLostText:
if DEF(_FR_FR)
	text "Casse-toi,"
	line "sale mioche..."
else
	text "Get lost kiddo…"
endc
	done

GoldenrodCityMarketRush1Text:
if DEF(_FR_FR)
	text "On a besoin de"
	line "ROULEAUX d'PQ!"

	para "Qui sait combien"
	line "de temps durera"
	cont "le confinement?"

	para "Prenons des"
	line "dizaines de"
	cont "rouleaux!"
else
	text "We need TOILET"
	line "PAPER!"
	
	para "Who knows how long"
	line "the lockdown will"
	cont "be enforced?"

	para "Let's get dozens"
	line "of rolls!"
endc
	done

GoldenrodCityMarketRush2Text:
if DEF(_FR_FR)
	text "Maman, j'ai peur,"
	line "j'veux rentrer."
else
	text "Mom I'm scared,"
	line "I wanna go home."
endc
	done

GoldenrodCityMarketRush3Text:
if DEF(_FR_FR)
	text "Il se dit que le"
	line "CENTRE COMMERCIAL"
	cont "est presque"
	cont "à court de"
	cont "marchandises..."
else
	text "People say the"
	line "DEPT.STORE is al-"
	cont "most out of goods…"
endc
	done

GoldenrodCityMarketRush4Text:
if DEF(_FR_FR)
	text "Je veux faire du"
	line "shopping une"
	cont "dernière fois..."
else
	text "I want to shop"
	line "once last…"
endc
	done

GoldenrodCityMoveTutorMoveText:
	text_start
	done

GoldenrodCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 24,  7, GOLDENROD_GYM, 1
	warp_event 29, 29, GOLDENROD_BIKE_SHOP, 1
	warp_event 31, 21, GOLDENROD_HAPPINESS_RATER, 1
	warp_event  5, 25, BILLS_FAMILYS_HOUSE, 1
	warp_event  9, 13, GOLDENROD_MAGNET_TRAIN_STATION, 2
	warp_event 29,  5, GOLDENROD_FLOWER_SHOP, 1
	warp_event 33,  9, GOLDENROD_PP_SPEECH_HOUSE, 1
	warp_event 15,  7, GOLDENROD_NAME_RATER, 1
	warp_event 24, 27, GOLDENROD_DEPT_STORE_1F, 1
	warp_event 14, 21, GOLDENROD_GAME_CORNER, 2
	warp_event  5, 15, RADIO_TOWER_1F, 1
	warp_event 19,  1, ROUTE_35_GOLDENROD_GATE, 3
	warp_event  9,  5, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 8
	warp_event 11, 29, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 5
	warp_event 15, 27, GOLDENROD_POKECENTER_1F, 1
	warp_event 33,  5, GOLDENROD_HOSPITAL_1F, 1
	warp_event 29, 15, GOLDENROD_CLAP_HOUSE, 1
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	warp_event 25, 15, HALL_OF_FAME, 1
endc

	def_coord_events

	def_bg_events
	bg_event 10, 14, BGEVENT_READ, GoldenrodCityStationSign
	bg_event  4, 17, BGEVENT_READ, GoldenrodCityRadioTowerSign
	bg_event 26, 27, BGEVENT_READ, GoldenrodDeptStoreSign
	bg_event 26,  9, BGEVENT_READ, GoldenrodGymSign
	bg_event 22, 18, BGEVENT_READ, GoldenrodCitySign
	bg_event 28, 30, BGEVENT_READ, GoldenrodCityBikeShopSign
	bg_event 16, 22, BGEVENT_READ, GoldenrodCityGameCornerSign
	bg_event 12,  7, BGEVENT_READ, GoldenrodCityNameRaterSign
	bg_event  8,  6, BGEVENT_READ, GoldenrodCityUndergroundSignNorth
	bg_event 12, 30, BGEVENT_READ, GoldenrodCityUndergroundSignSouth
	bg_event 16, 27, BGEVENT_UP, GoldenrodCityPokecenterSign
	bg_event 30,  6, BGEVENT_READ, GoldenrodCityFlowerShopSign
	bg_event 34,  5, BGEVENT_READ, GoldenrodHospitalSign
	bg_event 14, 21, BGEVENT_CLOSED_DOOR, GoldenrodCasinoDoorScript
	bg_event 29, 29, BGEVENT_CLOSED_DOOR, GoldenrodBikeShopDoorScript
	bg_event 29,  5, BGEVENT_CLOSED_DOOR, GoldenrodFlowerShopDoorScript
	bg_event 15,  7, BGEVENT_CLOSED_DOOR, GoldenrodNameRaterDoorScript
	bg_event 12, 21, BGEVENT_IFSET, GoldenrodCasinoWindowScript
	bg_event 13, 21, BGEVENT_IFSET, GoldenrodCasinoWindowScript

	def_object_events
	object_event 17, 28, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | DAY | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7, 18, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityPokefanMScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 30, 17, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityYoungster1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 12, 16, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodCityCooltrainerF1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 20, 26, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityCooltrainerF2Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 19, 17, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodCityYoungster2Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17, 10, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodCityLassScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 11, 27, SPRITE_GRAMPS, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityGrampsScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  4, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocketScoutScript, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	object_event 27, 17, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket1Script, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event  8, 15, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket2Script, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event 16, 23, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket3Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 27, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket4Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 29,  7, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket5Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 31, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket6Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 13, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MoveTutorScript, EVENT_GOLDENROD_CITY_MOVE_TUTOR
	object_event 34, 24, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityBeaterScript, EVENT_GOLDENROD_BEATER
	object_event 24, 28, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodCityMarketRush1Script, EVENT_LOCKDOWN_MART_RUSH
	object_event 25, 28, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodCityMarketRush2Script, EVENT_LOCKDOWN_MART_RUSH
	object_event 24, 29, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodCityMarketRush3Script, EVENT_LOCKDOWN_MART_RUSH
	object_event 23, 30, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodCityMarketRush4Script, EVENT_LOCKDOWN_MART_RUSH
