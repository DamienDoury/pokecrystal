	object_const_def
	const ROUTE27_COOLTRAINER_M1
	const ROUTE27_COOLTRAINER_M2
	const ROUTE27_COOLTRAINER_F1
	const ROUTE27_COOLTRAINER_F2
	const ROUTE27_YOUNGSTER1
	const ROUTE27_YOUNGSTER2
	const ROUTE27_POKE_BALL1
	const ROUTE27_POKE_BALL2
	const ROUTE27_FISHER
	const ROUTE27_FISHER_2

Route27_MapScripts:
	def_scene_scripts

	def_callbacks

FirstStepIntoKantoScene:
	setlasttalked ROUTE27_FISHER
	
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .alreadyWarned

	scall Route27StepBackIfNeeded

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	showemote EMOTE_SHOCK, ROUTE27_FISHER, 15
	faceobject PLAYER, ROUTE27_FISHER
	faceplayer

	opentext
	checkevent EVENT_PLAYER_STEP_FOOT_IN_KANTO
	iftrue .SkipKantoTalk
	writetext Route27FisherText
	promptbutton
.SkipKantoTalk
	setevent EVENT_PLAYER_STEP_FOOT_IN_KANTO

	checkflag ENGINE_TRAINER_CARD
	iffalse .SkipVaccinePassportCheck

	checkevent EVENT_PLAYER_VACCINATED_ONCE
	iftrue .allowPassage

.SkipVaccinePassportCheck
	writetext Route27BorderClosedText
	waitbutton
	closetext

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

	checkitem WORK_VISA
	iffalse .end

	readmem wYearMonth
	ifgreater $0f, Route27FisherScript.visaExpired

	pause 2
	showemote EMOTE_QUESTION, ROUTE27_FISHER, 15

	opentext 
	writetext Route27BorderLetterText
	promptbutton
	writetext Route27EntranceText
.openBorder
	waitbutton
	closetext

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	applymovement ROUTE27_FISHER, Route27_HeadDownMovement
	setval SPRITEMOVEDATA_STANDING_DOWN
	writemem wMap9ObjectMovement
	applymovement ROUTE27_FISHER_2, Route27_AllowEntranceIntoKantoMovement
	setval SPRITEMOVEDATA_STANDING_UP
	writemem wMap10ObjectMovement
	moveobject ROUTE27_FISHER_2, 21, 12
.end
	end

.alreadyWarned:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .end

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4 ; Prevents the warning from being displayed twice in a row.
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .end

	random 4
	ifnotequal FALSE, .end
	scall Route27StepBackIfNeeded
	faceobject PLAYER, ROUTE27_FISHER
	faceobject ROUTE27_FISHER_2, PLAYER
	faceplayer
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	jumptext Route27BorderArrestText

.allowPassage:
	writetext Route27_VaccinationPassText
	promptbutton
	checkevent EVENT_GOT_FAKE_ID
	iftrue .fakeID

	writetext Route27_VaccinationPassValidText
	sjump .openBorder

.fakeID
	clearevent EVENT_GOT_FAKE_ID
	clearflag ENGINE_TRAINER_CARD
	writetext Route27_FakeIDText
	waitbutton
	closetext
	end

Route27StepBackIfNeeded:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .dontStepBack

	readvar VAR_XCOORD
	ifnotequal 22, .dontStepBack

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement ROUTE27_FISHER, Route27_SocialDistancingMovement
	moveobject ROUTE27_FISHER, 20, 10
.dontStepBack
	end

Route27FisherScript:
	faceplayer

	checkflag ENGINE_TRAINER_CARD
	iffalse .skipVaccinePassportCheck

	checkevent EVENT_PLAYER_VACCINATED_ONCE
	iftrue .allowPassage

.skipVaccinePassportCheck
	checkitem WORK_VISA
	iffalse .blockPassage

	readmem wYearMonth
	ifgreater $0f, .visaExpired
	
.allowPassage
	opentext
	writetext Route27EntranceText
	waitbutton
	closetext
	applymovement ROUTE27_FISHER, Route27_HeadDownMovement
	end

.blockPassage
	jumptext Route27BorderArrestText

.visaExpired
	jumptext Route27VisaExpiredText

TrainerPsychicGilbert:
	trainer PSYCHIC_T, GILBERT, EVENT_BEAT_PSYCHIC_GILBERT, PsychicGilbertSeenText, PsychicGilbertBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicGilbertAfterBattleText

TrainerBirdKeeperJose2:
	trainer BIRD_KEEPER, JOSE2, EVENT_BEAT_BIRD_KEEPER_JOSE2, BirdKeeperJose2SeenText, BirdKeeperJose2BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BIRDKEEPER_JOSE
	endifjustbattled
	opentext
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftrue .HasStarPiece
	checkcellnum PHONE_BIRDKEEPER_JOSE
	iftrue .NumberAccepted
	checkevent EVENT_JOSE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BirdKeeperJose2AfterBattleText
	promptbutton
	setevent EVENT_JOSE_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_BIRDKEEPER_JOSE
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, BIRD_KEEPER, JOSE2
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext BirdKeeperJose2BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer BIRD_KEEPER, JOSE2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOSE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BIRD_KEEPER, JOSE1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOSE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BIRD_KEEPER, JOSE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOSE_READY_FOR_REMATCH
	end

.HasStarPiece:
	scall .Gift
	verbosegiveitem STAR_PIECE
	iffalse .NoRoom
	clearflag ENGINE_JOSE_HAS_STAR_PIECE
	sjump .NumberAccepted

.NoRoom:
	sjump .PackFull

.AskNumber1:
	jumpstd AskNumber1MScript

.AskNumber2:
	jumpstd AskNumber2MScript

.RegisteredNumber:
	jumpstd RegisteredNumberMScript

.NumberAccepted:
	jumpstd NumberAcceptedMScript

.NumberDeclined:
	jumpstd NumberDeclinedMScript

.PhoneFull:
	jumpstd PhoneFullMScript

.Rematch:
	jumpstd RematchMScript

.Gift:
	jumpstd GiftMScript

.PackFull:
	jumpstd PackFullMScript

TrainerCooltrainermBlake:
	trainer COOLTRAINERM, BLAKE, EVENT_BEAT_COOLTRAINERM_BLAKE, CooltrainermBlakeSeenText, CooltrainermBlakeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainermBlakeAfterBattleText

TrainerCooltrainermBrian:
	trainer COOLTRAINERM, BRIAN, EVENT_BEAT_COOLTRAINERM_BRIAN, CooltrainermBrianSeenText, CooltrainermBrianBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainermBrianAfterBattleText

TrainerCooltrainerfReena:
	trainer COOLTRAINERF, REENA1, EVENT_BEAT_COOLTRAINERF_REENA, CooltrainerfReenaSeenText, CooltrainerfReenaBeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERF_REENA
	endifjustbattled
	opentext
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERF_REENA
	iftrue .NumberAccepted
	checkevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainerfReenaAfterBattleText
	promptbutton
	setevent EVENT_REENA_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERF_REENA
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, COOLTRAINERF, REENA1
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainerfReenaBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
	loadtrainer COOLTRAINERF, REENA1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERF, REENA2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERF, REENA3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_REENA_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1FScript

.AskNumber2:
	jumpstd AskNumber2FScript

.RegisteredNumber:
	jumpstd RegisteredNumberFScript

.NumberAccepted:
	jumpstd NumberAcceptedFScript

.NumberDeclined:
	jumpstd NumberDeclinedFScript

.PhoneFull:
	jumpstd PhoneFullFScript

.Rematch:
	jumpstd RematchFScript

TrainerCooltrainerfMegan:
	trainer COOLTRAINERF, MEGAN, EVENT_BEAT_COOLTRAINERF_MEGAN, CooltrainerfMeganSeenText, CooltrainerfMeganBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerfMeganAfterBattleText

TohjoFallsSign:
	jumptext TohjoFallsSignText

Route27PPUp:
	hiddenitem PP_UP, ROUTE_27_PP_UP

Route27TMSolarbeam:
	itemball TM_SOLARBEAM

Route27RareCandy:
	itemball RARE_CANDY

Route27_HeadDownMovement:
	turn_head DOWN
	step_end

Route27_AllowEntranceIntoKantoMovement:
	turn_head UP
	fix_facing
	step DOWN
	step_end

Route27_SocialDistancingMovement:
	turn_head RIGHT
	fix_facing
	step LEFT
	step_end

Route27FisherText:
if DEF(_FR_FR)
	text "Hé!"
	
	para "Tu sais ce que tu"
	line "viens de faire?"

	para "Tu viens de faire"
	line "ton premier pas à"
	cont "KANTO..."

	para "Regarde la CARTE"
	line "de ton #MATOS!"
else
	text "Hey!"

	para "Do you know what"
	line "you just did?"

	para "You've stepped"
	line "foot in KANTO."

	para "Check your #-"
	line "GEAR MAP and see."
endc
	done

Route27BorderClosedText:
if DEF(_FR_FR)
	text "La frontière est"
	line "fermée à cause de"
	cont "la pandémie."
	
	para "Tu dois faire"
	line "demi-tour."
else
	text "The border is"
	line "closed because"
	cont "of the pandemic."

	para "You must turn"
	line "back."
endc
	done

Route27BorderLetterText:
if DEF(_FR_FR)
	text "C'est un VISA de"
	line "TRAVAIL?"
	cont "Laisse-moi voir."
	
	para "..."
	
	para "Tout semble être"
	line "en ordre."
else
	text "Is that a WORK"
	line "VISA?"
	cont "Let me see it."

	para "…"

	para "Everything looks"
	line "in order."
endc
	done

Route27EntranceText:
if DEF(_FR_FR)
	text "Tu peux passer"
	line "la frontière."
else
	text "You may cross"
	line "the border." 
endc
	done

Route27BorderArrestText:
if DEF(_FR_FR)
	text "Retourne d'où tu"
	line "viens avant qu'on"
	cont "t'arrête."
else
	text "Go back were you"
	line "came from, before"
	cont "we arrest you."
endc
	done

Route27VisaExpiredText:
if DEF(_FR_FR)
	text "Ton VISA de"
	line "TRAVAIL a expiré."
	cont "Je ne te laisserai"
	cont "pas passer."
else
	text "Your WORK VISA is"
	line "expired. I won't"
	cont "let you through."
endc
	done

Route27_VaccinationPassText:
if DEF(_FR_FR)
	text "Montre ta CARTE"
	line "de DRESSEUR."
	
	para "..."
else
	text "Please show your"
	line "TRAINER CARD."

	para "…"
endc
	done

Route27_VaccinationPassValidText:
if DEF(_FR_FR)
	text "Je vois que tu as"
	line "reçu le vaccin,"
	cont "tu peux passer."
else
	text "I see you're"
	line "vaccinated, you"
	cont "can go through."
endc
	done

Route27_FakeIDText:
if DEF(_FR_FR)
	text "Quoi! C'est une"
	line "fausse CARTE"
	cont "DRESSEUR!"
	
	para "C'est une blague?"
	
	para "Cette imitation"
	line "est si mauvaise!"
	
	para "Elle ne trompera"
	line "personne."
	
	para "Je la confisque."
	
	para "Maintenant,"
	line "dégage."
else
	text "Hey! It's a fake"
	line "TRAINER CARD!"

	para "Is it a joke?"

	para "It's such a bad"
	line "fake! You won't"
	cont "fool anyone with"
	cont "it."

	para "I'm keeping it."
	line "Now get lost."
endc
	done

CooltrainermBlakeSeenText: 
if DEF(_FR_FR)
	text "Tu as l'air"
	line "fort."
	cont "COMBAAAT!"
else
	text "You look pretty"
	line "strong."
	cont "Let me battle you!"
endc

	done

CooltrainermBlakeBeatenText: 
if DEF(_FR_FR)
	text "Huf!"
else
	text "Yow!"
endc

	done

CooltrainermBlakeAfterBattleText: 
if DEF(_FR_FR)
	text "Enfant du soleil,"
	line "tu parcours la"
	cont "terre, le ciel..."

	para "Cherche ton che-"
	line "min, c'est ta vie,"
	cont "c'est ton destin."
else
	text "If you prevail on"
	line "this harsh trek,"

	para "the truth will be"
	line "revealed!"

	para "Heh, sorry, I just"
	line "wanted to say"
	cont "something cool."
endc

	done

CooltrainermBrianSeenText: 
if DEF(_FR_FR)
	text "Hm? Bonjour?"
	line "Alors combat?"
else
	text "Hm? You're good,"
	line "aren't you?"
endc

	done

CooltrainermBrianBeatenText: 
if DEF(_FR_FR)
	text "Merci bien!"
else
	text "Just as I thought!"
endc

	done

CooltrainermBrianAfterBattleText: 
if DEF(_FR_FR)
	text "Les meilleurs sa-"
	line "vent se reconnaî-"
	cont "tre."
else
	text "A good trainer can"
	line "recognize other"
	cont "good trainers."
endc

	done

CooltrainerfReenaSeenText: 
if DEF(_FR_FR)
	text "Tu devrais faire"
	line "attention aux"

	para "#MON sauvages"
	line "du coin."
else
	text "You shouldn't"
	line "underestimate the"

	para "wild #MON in"
	line "these parts."
endc

	done

CooltrainerfReenaBeatenText: 
if DEF(_FR_FR)
	text "Oh!"
	line "Pas glop!"
else
	text "Oh! You're much"
	line "too strong!"
endc

	done

CooltrainerfReenaAfterBattleText: 
if DEF(_FR_FR)
	text "T'es jeune,"
	line "mais..."

	para "T'es balèze!"
	line "Oh que oui!"
else
	text "You're just a kid,"
	line "but you're not to"

	para "be underestimated"
	line "either."
endc

	done

CooltrainerfMeganSeenText: 
if DEF(_FR_FR)
	text "C'est rare de voir"
	line "quelqu'un ici."

	para "Tu t'entraînes"
	line "en solitaire?"
else
	text "It's rare to see"
	line "anyone come here."

	para "Are you training"
	line "on your own?"
endc

	done

CooltrainerfMeganBeatenText: 
if DEF(_FR_FR)
	text "Ben ça alors!"
else
	text "Oh! You're really"
	line "strong!"
endc

	done

CooltrainerfMeganAfterBattleText: 
if DEF(_FR_FR)
	text "Moi j'étudie les"
	line "formes antérieures"
	cont "et postérieures"
	cont "aux évolutions des"
	cont "#MON."

	para "Un #MON évolué"
	line "est toujours plus"
	cont "fort."

	para "Mais il apprend"
	line "des capacités plus"
	cont "tardivement."
else
	text "I'm checking out"
	line "pre- and post-"
	cont "evolution #MON."

	para "Evolution really"
	line "does make #MON"
	cont "stronger."

	para "But evolved forms"
	line "also learn moves"
	cont "later on."
endc

	done

PsychicGilbertSeenText: 
if DEF(_FR_FR)
	text "Ne dis rien!"

	para "Je vais lire dans"
	line "tes pensées..."

	para "Mmmmmmm..."

	para "Je sais! Tu veux"
	line "te mesurer à la"
	cont "LIGUE #MON!"
else
	text "Don't say a thing!"

	para "Let me guess what"
	line "you're thinking."

	para "Mmmmmmm…"

	para "I got it! You're"
	line "on the #MON"
	cont "LEAGUE challenge!"
endc

	done

PsychicGilbertBeatenText: 
if DEF(_FR_FR)
	text "Je le savais!"
else
	text "You're too much!"
endc

	done

PsychicGilbertAfterBattleText: 
if DEF(_FR_FR)
	text "Tu vas cartonner"
	line "à la LIGUE..."
	cont "C'est sûr!"

	para "Je le sais."
	line "Je le sens."
else
	text "With your skills,"
	line "you'll do well at"
	cont "the LEAGUE."

	para "That's what my"
	line "premonition says."
endc

	done

BirdKeeperJose2SeenText: 
if DEF(_FR_FR)
	text "Piou! Piou!"
	line "Piouuu!"
else
	text "Tweet! Tweet!"
	line "Tetweet!"
endc

	done

BirdKeeperJose2BeatenText: 
if DEF(_FR_FR)
	text "Piou!"
else
	text "Tweet!"
endc

	done

BirdKeeperJose2AfterBattleText: 
if DEF(_FR_FR)
	text "Les ORNITHOLOGUES"
	line "aiment siffler"

	para "comme les oiseaux"
	line "pour parler aux"
	cont "#MON."
else
	text "BIRD KEEPERS like"
	line "me mimic bird"

	para "whistles to com-"
	line "mand #MON."
endc

	done

TohjoFallsSignText: 
if DEF(_FR_FR)
	text "CHUTES TOHJO"

	para "Le lien entre"
	line "KANTO et JOHTO"
else
	text "TOHJO FALLS"

	para "THE LINK BETWEEN"
	line "KANTO AND JOHTO"
endc

	done

Route27_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 33,  7, ROUTE_27_SANDSTORM_HOUSE, 1
	warp_event 26,  5, TOHJO_FALLS, 1
	warp_event 36,  5, TOHJO_FALLS, 2

	def_coord_events
	coord_event 18, 10, CE_SCENE_ID, SCENE_ALWAYS, FirstStepIntoKantoScene
	coord_event 19, 10, CE_SCENE_ID, SCENE_ALWAYS, FirstStepIntoKantoScene
	coord_event 23, 10, CE_SCENE_ID, SCENE_ALWAYS, FirstStepIntoKantoScene
	coord_event 22, 10, CE_SCENE_ID, SCENE_ALWAYS, FirstStepIntoKantoScene
	coord_event 23, 11, CE_SCENE_ID, SCENE_ALWAYS, FirstStepIntoKantoScene

	def_bg_events
	bg_event 25,  7, BGEVENT_READ, TohjoFallsSign
	bg_event 21, 13, BGEVENT_ITEM, Route27PPUp

	def_object_events
	object_event 48,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermBlake, -1
	object_event 58,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainermBrian, -1
	object_event 72, 10, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfReena, -1
	object_event 37,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainerfMegan, -1
	object_event 65,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicGilbert, -1
	object_event 58, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperJose2, -1
	object_event 60, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route27TMSolarbeam, EVENT_ROUTE_27_TM_SOLARBEAM
	object_event 53, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route27RareCandy, EVENT_ROUTE_27_RARE_CANDY
	object_event 21, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route27FisherScript, -1
	object_event 21, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route27FisherScript, -1
