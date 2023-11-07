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

	checkevent EVENT_PLAYER_VACCINATED_ONCE
	iftrue .allowPassage

	writetext Route27BorderClosedText
	waitbutton
	closetext

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

	checkitem WORK_VISA
	iffalse .end

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
	sjump .openBorder

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
	checkevent EVENT_PLAYER_VACCINATED_ONCE
	iftrue .allowPassage

	checkitem WORK_VISA
	iffalse .blockPassage
	
.allowPassage
	opentext
	writetext Route27EntranceText
	waitbutton
	closetext
	applymovement ROUTE27_FISHER, Route27_HeadDownMovement
	end

.blockPassage
	jumptext Route27BorderArrestText

TrainerPsychicGilbert:
	trainer PSYCHIC_T, GILBERT, EVENT_BEAT_PSYCHIC_GILBERT, PsychicGilbertSeenText, PsychicGilbertBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicGilbertAfterBattleText
	waitbutton
	closetext
	end

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
	end

.AskNumber2:
	jumpstd AskNumber2MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.Rematch:
	jumpstd RematchMScript
	end

.Gift:
	jumpstd GiftMScript
	end

.PackFull:
	jumpstd PackFullMScript
	end

TrainerCooltrainermBlake:
	trainer COOLTRAINERM, BLAKE, EVENT_BEAT_COOLTRAINERM_BLAKE, CooltrainermBlakeSeenText, CooltrainermBlakeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermBlakeAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermBrian:
	trainer COOLTRAINERM, BRIAN, EVENT_BEAT_COOLTRAINERM_BRIAN, CooltrainermBrianSeenText, CooltrainermBrianBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermBrianAfterBattleText
	waitbutton
	closetext
	end

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
	end

.AskNumber2:
	jumpstd AskNumber2FScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.PhoneFull:
	jumpstd PhoneFullFScript
	end

.Rematch:
	jumpstd RematchFScript
	end

TrainerCooltrainerfMegan:
	trainer COOLTRAINERF, MEGAN, EVENT_BEAT_COOLTRAINERF_MEGAN, CooltrainerfMeganSeenText, CooltrainerfMeganBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfMeganAfterBattleText
	waitbutton
	closetext
	end

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
	text "Hey!"

	para "Do you know what"
	line "you just did?"

	para "You've stepped"
	line "foot in KANTO."

	para "Check your #-"
	line "GEAR MAP and see."
	done

Route27BorderClosedText:
	text "The border is"
	line "closed because"
	cont "of the pandemic."

	para "You must turn"
	line "back."
	done

Route27BorderLetterText:
	text "Is that a WORK"
	line "VISA?"
	cont "Let me see it."

	para "…"

	para "Everything looks"
	line "in order."
	done

Route27EntranceText:	
	text "You may cross"
	line "the border." 
	done

Route27BorderArrestText:
	text "Go back were you"
	line "came from, before"
	cont "we arrest you."
	done

Route27_VaccinationPassText:
	text "Please show your"
	line "TRAINER CARD."

	para "…"
	
	para "I see you're"
	line "vaccinated, you"
	cont "can go through."
	done

CooltrainermBlakeSeenText:
	text "You look pretty"
	line "strong."
	cont "Let me battle you!"
	done

CooltrainermBlakeBeatenText:
	text "Yow!"
	done

CooltrainermBlakeAfterBattleText:
	text "If you prevail on"
	line "this harsh trek,"

	para "the truth will be"
	line "revealed!"

	para "Heh, sorry, I just"
	line "wanted to say"
	cont "something cool."
	done

CooltrainermBrianSeenText:
	text "Hm? You're good,"
	line "aren't you?"
	done

CooltrainermBrianBeatenText:
	text "Just as I thought!"
	done

CooltrainermBrianAfterBattleText:
	text "A good trainer can"
	line "recognize other"
	cont "good trainers."
	done

CooltrainerfReenaSeenText:
	text "You shouldn't"
	line "underestimate the"

	para "wild #MON in"
	line "these parts."
	done

CooltrainerfReenaBeatenText:
	text "Oh! You're much"
	line "too strong!"
	done

CooltrainerfReenaAfterBattleText:
	text "You're just a kid,"
	line "but you're not to"

	para "be underestimated"
	line "either."
	done

CooltrainerfMeganSeenText:
	text "It's rare to see"
	line "anyone come here."

	para "Are you training"
	line "on your own?"
	done

CooltrainerfMeganBeatenText:
	text "Oh! You're really"
	line "strong!"
	done

CooltrainerfMeganAfterBattleText:
	text "I'm checking out"
	line "pre- and post-"
	cont "evolution #MON."

	para "Evolution really"
	line "does make #MON"
	cont "stronger."

	para "But evolved forms"
	line "also learn moves"
	cont "later on."
	done

PsychicGilbertSeenText:
	text "Don't say a thing!"

	para "Let me guess what"
	line "you're thinking."

	para "Mmmmmmm…"

	para "I got it! You're"
	line "on the #MON"
	cont "LEAGUE challenge!"
	done

PsychicGilbertBeatenText:
	text "You're too much!"
	done

PsychicGilbertAfterBattleText:
	text "With your skills,"
	line "you'll do well at"
	cont "the LEAGUE."

	para "That's what my"
	line "premonition says."
	done

BirdKeeperJose2SeenText:
	text "Tweet! Tweet!"
	line "Tetweet!"
	done

BirdKeeperJose2BeatenText:
	text "Tweet!"
	done

BirdKeeperJose2AfterBattleText:
	text "BIRD KEEPERS like"
	line "me mimic bird"

	para "whistles to com-"
	line "mand #MON."
	done

TohjoFallsSignText:
	text "TOHJO FALLS"

	para "THE LINK BETWEEN"
	line "KANTO AND JOHTO"
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
