	object_const_def
	const ROUTE36_POLICE_1_1
	const ROUTE36_POLICE_1_2
	const ROUTE36_POLICE_1_3

	const ROUTE36_POLICE_2_1
	const ROUTE36_POLICE_2_2
	const ROUTE36_POLICE_2_3
	const ROUTE36_POLICE_2_4

	const ROUTE36_POLICE_3_1
	const ROUTE36_POLICE_3_2
	const ROUTE36_POLICE_3_3

	const ROUTE36_POLICE_4_1
	const ROUTE36_POLICE_4_2
	const ROUTE36_POLICE_4_3
	const ROUTE36_POLICE_4_4

	const ROUTE36_YOUNGSTER1
	const ROUTE36_YOUNGSTER2
	const ROUTE36_WEIRD_TREE
	const ROUTE36_LASS1
	const ROUTE36_FISHER
	const ROUTE36_FRUIT_TREE
	const ROUTE36_ARTHUR
	const ROUTE36_FLORIA
	const ROUTE36_SUICUNE

Route36_MapScripts:
	def_scene_scripts
	scene_script .Route36_GateClosedCheck ; SCENE_ROUTE36_NOTHING
	scene_script .Route36_GateClosedCheck ; SCENE_ROUTE36_SUICUNE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .ArthurCallback
	callback MAPCALLBACK_TILES, .TilesLoad

.Route36_GateClosedCheck:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	readmem wCurFreedomState
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	readvar VAR_XCOORD
	ifnotequal 18, .end

	prioritysjump Route36_PlayerStepsRight

.end
	end

.ArthurCallback:
	readvar VAR_WEEKDAY
	ifequal THURSDAY, .ArthurAppears
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; ROUTE36_ARTHUR
	endcallback

.ArthurAppears:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; ROUTE36_ARTHUR
	endcallback

.TilesLoad:
	; National Park - East Entrance.
	readmem wCurFreedomState
	ifequal 1 << FREE, .EndTilesCallback
	ifequal 1 << VACCINE_PASSPORT, .EndTilesCallback

	changeblock 14,  8, $77
	changeblock 16,  8, $5f

.EndTilesCallback
	endcallback

Route36_PlayerStepsRight:
	applymovement PLAYER, Route36_StepRightMovement
	end

Route36SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	turnobject PLAYER, UP
	applymovement ROUTE36_SUICUNE, Route36SuicuneMovement
	disappear ROUTE36_SUICUNE
	turnobject PLAYER, DOWN
	pause 10
	setscene SCENE_ROUTE36_NOTHING
	clearevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setmapscene CIANWOOD_CITY, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE
	end

SudowoodoScript:
	checkitem SQUIRTBOTTLE
	iftrue .Fight

	waitsfx
	playsound SFX_SANDSTORM
	applymovement ROUTE36_WEIRD_TREE, SudowoodoShakeMovement
	end

.Fight:
	opentext
	writetext UseSquirtbottleText
	yesorno
	iffalse DidntUseSquirtbottleScript
	closetext
WateredWeirdTreeScript:: ; export (for when you use Squirtbottle from pack)
	farscall Script_PullOutSquirtbottle
	waitsfx
	playsound SFX_SANDSTORM
	applymovement ROUTE36_WEIRD_TREE, SudowoodoShakeMovement
	opentext
	writetext SudowoodoAttackedText
	waitbutton
	closetext
	loadmem wAssaultBattle, $ff
	loadwildmon SUDOWOODO, 20
	startbattle
	ifequal DRAW, DidntCatchSudowoodo
	disappear ROUTE36_WEIRD_TREE
	reloadmapafterbattle
	end

DidntUseSquirtbottleScript:
	closetext
	end

DidntCatchSudowoodo:
	reloadmapafterbattle
	applymovement ROUTE36_WEIRD_TREE, WeirdTreeMovement_Flee
	disappear ROUTE36_WEIRD_TREE
	end

Route36FloriaScript:
	faceplayer
	opentext
	writetext FloriaText1
	promptbutton
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .stay_at_home

	writetext FloriaText2
	sjump .floria_leaves

.stay_at_home
	writetext FloriaStayAtHomeText

.floria_leaves
	waitbutton
	closetext
	clearevent EVENT_FLORIA_AT_FLOWER_SHOP
	applymovement ROUTE36_FLORIA, FloriaMovement
	disappear ROUTE36_FLORIA
	end

Route36RockSmashGuyScript:
	faceplayer
	opentext
	checkevent EVENT_ROUTE_36_SUDOWOODO
	iffalse .DidntClearedSudowoodo

	checkitem TM_ROCK_SMASH
	iftrue .AlreadyGotRockSmash
	
;.ClearedSudowoodo:
	writetext RockSmashGuyText2
	promptbutton
	verbosegiveitem TM_ROCK_SMASH
	iffalse .NoRoomForTM
.AlreadyGotRockSmash:
	writetext RockSmashGuyText3
	waitbutton
.NoRoomForTM:
	closetext
	end

.DidntClearedSudowoodo
	writetext RockSmashGuyText1
	waitbutton
	closetext
	end

Route36LassScript:
	faceplayer
	opentext
	checkevent EVENT_ROUTE_36_SUDOWOODO
	iftrue .ClearedSudowoodo
	writetext Route36LassText
	waitbutton
	closetext
	end

.ClearedSudowoodo:
	writetext Route36LassText_ClearedSudowoodo
	waitbutton
	closetext
	end

TrainerSchoolboyAlan1:
	trainer SCHOOLBOY, ALAN1, EVENT_BEAT_SCHOOLBOY_ALAN, SchoolboyAlan1SeenText, SchoolboyAlan1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_SCHOOLBOY_ALAN
	endifjustbattled
	opentext
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftrue .ChooseRematch
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue .GiveFireStone
	checkcellnum PHONE_SCHOOLBOY_ALAN
	iftrue .NumberAccepted
	checkevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgainForPhoneNumber
	writetext SchoolboyAlanBooksText
	promptbutton
	setevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .ContinueAskForPhoneNumber

.AskAgainForPhoneNumber:
	scall .AskNumber2
.ContinueAskForPhoneNumber:
	askforphonenumber PHONE_SCHOOLBOY_ALAN
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, SCHOOLBOY, ALAN1
	scall .RegisteredNumber
	sjump .NumberAccepted

.ChooseRematch:
	scall .Rematch
	winlosstext SchoolboyAlan1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
	loadtrainer SCHOOLBOY, ALAN1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, ALAN2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, ALAN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, ALAN4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, ALAN5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.GiveFireStone:
	scall .Gift
	verbosegiveitem FIRE_STONE
	iffalse .BagFull
	clearflag ENGINE_ALAN_HAS_FIRE_STONE
	setevent EVENT_ALAN_GAVE_FIRE_STONE
	sjump .NumberAccepted

.BagFull:
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

TrainerPsychicMark:
	trainer PSYCHIC_T, MARK, EVENT_BEAT_PSYCHIC_MARK, PsychicMarkSeenText, PsychicMarkBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicMarkAfterBattleText
	waitbutton
	closetext
	end

ArthurScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	iftrue .AlreadyGotStone
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, ArthurNotThursdayScript
	checkevent EVENT_MET_ARTHUR_OF_THURSDAY
	iftrue .MetArthur
	writetext MeetArthurText
	promptbutton
	setevent EVENT_MET_ARTHUR_OF_THURSDAY
.MetArthur:
	writetext ArthurGivesGiftText
	promptbutton
	verbosegiveitem HARD_STONE
	iffalse .BagFull
	setevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	writetext ArthurGaveGiftText
	waitbutton
	closetext
	end

.AlreadyGotStone:
	writetext ArthurThursdayText
	waitbutton
.BagFull:
	closetext
	end

ArthurNotThursdayScript:
	writetext ArthurNotThursdayText
	waitbutton
	closetext
	end

Route36Sign:
	jumptext Route36SignText

RuinsOfAlphNorthSign:
	jumptext RuinsOfAlphNorthSignText

Route36TrainerTips1:
	jumptext Route36TrainerTips1Text

Route36TrainerTips2:
	jumptext Route36TrainerTips2Text

Route36FruitTree:
	fruittree FRUITTREE_ROUTE_36

Route36_DoorScript:
	jumpstd LockdownCurfewClosedDoor

SudowoodoShakeMovement:
	tree_shake
	step_end

WeirdTreeMovement_Flee:
	fast_jump_step UP
	fast_jump_step UP
	step_end

FloriaMovement:
	step DOWN
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

Route36SuicuneMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	remove_sliding
	step_end

Route36_StepRightMovement:
	step RIGHT
	step_end

UseSquirtbottleText: 
if DEF(_FR_FR)
	text "Un arbre bizarre."
	line "Utiliser la"
	cont "CARAPUCE A O?"
else
	text "It's a weird tree."
	line "Use SQUIRTBOTTLE?"
endc

	done

SudowoodoAttackedText: 
if DEF(_FR_FR)
	text "L'arbre bizarre"
	line "n'aime pas la"
	cont "CARAPUCE A O!"

	para "L'arbre bizarre"
	line "attaque!"
else
	text "The weird tree"
	line "doesn't like the"
	cont "SQUIRTBOTTLE!"

	para "The weird tree"
	line "attacked!"
endc

	done

FloriaText1: ; TO TRANSLATE
	text "I'm the FLOWER"
	line "SHOP's FLORIA!"

	para "Listen, listen!"

	para "When I sprinkled"
	line "water on that"

	para "wiggly tree, it"
	line "jumped right up!"

	para "It just has to be"
	line "a #MON."

	para "I bet it would be"
	line "shocked out of its"

	para "disguise if you"
	line "soaked it!"
	done

FloriaStayAtHomeText: ; TO TRANSLATE
	text "Wait what?"

	para "The lockdown has"
	line "started already?"

	para "I should get home."
	done

FloriaText2: ; TO TRANSLATE
	text "I know! I'll tell"
	line "my sis and borrow"
	cont "her water bottle!"
	done

RockSmashGuyText1: ; TO TRANSLATE
	text "Wa-hey!"

	para "I was going to"
	line "snap that tree"

	para "with my straight-"
	line "arm punch."

	para "But I couldn't! It's"
	line "as hard as a rock!"
	done

RockSmashGuyText2: 
if DEF(_FR_FR)
	text "Tu as battu"
	line "l'arbre?"

	para "Impressionnant!"
	line "Tu as bien mérité"
	cont "ça."
else
	text "Did you clear that"
	line "wretched tree?"

	para "I'm impressed!"
	line "I want you to"
	cont "have this."
endc

	done

RockSmashGuyText3: ; TO TRANSLATE
	text "With ROCK SMASH"
	line "you can shatter"
	cont "rocks with just a"

	para "single well-aimed"
	line "smack."

	para "If any rocks are"
	line "in your way, just"
	cont "smash 'em up!"
	done

Route36LassText: 
if DEF(_FR_FR)
	text "Un drôle d'arbre"
	line "bloque le passage"
	cont "vers DOUBLONVILLE."

	para "Je peux pas faire"
	line "mes courses."

	para "On devrait faire"
	line "quelque chose."
else
	text "An odd tree is"
	line "blocking the way"
	cont "to GOLDENROD CITY."

	para "It's preventing"
	line "me from shopping."

	para "Something should"
	line "be done about it."
endc

	done

Route36LassText_ClearedSudowoodo: 
if DEF(_FR_FR)
	text "L'arbre bizarre a"
	line "disparu..."

	para "Oh! C'était un"
	line "#MON?"
	cont "Vraiment?"
else
	text "That odd tree dis-"
	line "appeared without a"
	cont "trace."

	para "Oh! That tree was"
	line "really a #MON?"
endc

	done

PsychicMarkSeenText: 
if DEF(_FR_FR)
	text "Je suis..."
	line "Puissant!"
else
	text "I'm going to read"
	line "your thoughts!"
endc

	done

PsychicMarkBeatenText: 
if DEF(_FR_FR)
	text "J'suis une tache!"
else
	text "I misread you!"
endc

	done

PsychicMarkAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai des pouvoirs"
	line "psychiques mais..."

	para "Je sais pas com-"
	line "ment m'en servir."
else
	text "I'd be strong if"
	line "only I could tell"

	para "what my opponent"
	line "was thinking."
endc

	done

SchoolboyAlan1SeenText: 
if DEF(_FR_FR)
	text "J'ai étudié et je"
	line "suis incollable!"
	cont "A l'attaque!"
else
	text "Thanks to my stud-"
	line "ies, I'm ready for"
	cont "any #MON!"
endc

	done

SchoolboyAlan1BeatenText: 
if DEF(_FR_FR)
	text "Oups! Me serais-je"
	line "trompé?"
else
	text "Oops! Computation"
	line "error?"
endc

	done

SchoolboyAlanBooksText: 
if DEF(_FR_FR)
	text "Pfff. J'étudie 5"
	line "heures par jour."

	para "Lire des livres"
	line "ça suffit pas..."
	cont "Apparemment..."
else
	text "Darn. I study five"
	line "hours a day too."

	para "There's more to"
	line "learning than just"
	cont "reading books."
endc

	done

MeetArthurText: 
if DEF(_FR_FR)
	text "JEROME: Qui es-tu?"

	para "Moi c'est JEROME"
	line "du jeudi."
else
	text "ARTHUR: Who are"
	line "you?"

	para "I'm ARTHUR of"
	line "Thursday."
endc

	done

ArthurGivesGiftText: 
if DEF(_FR_FR)
	text "Tiens. Voilà pour"
	line "toi."
else
	text "Here. You can have"
	line "this."
endc

	done

ArthurGaveGiftText: 
if DEF(_FR_FR)
	text "JEROME: C'est pour"
	line "un #MON avec"

	para "des capacités du"
	line "type ROCHE."

	para "Cela va améliorer"
	line "ses attaques."
else
	text "ARTHUR: A #MON"
	line "that uses rock-"

	para "type moves should"
	line "hold on to that."

	para "It pumps up rock-"
	line "type attacks."
endc

	done

ArthurThursdayText: 
if DEF(_FR_FR)
	text "JEROME: Moi c'est"
	line "JEROME du jeudi,"

	para "le deuxième fils"
	line "des sept enfants."
else
	text "ARTHUR: I'm ARTHUR"
	line "of Thursday. I'm"

	para "the second son out"
	line "of seven children."
endc

	done

ArthurNotThursdayText: 
if DEF(_FR_FR)
	text "JEROME: On n'est"
	line "pas jeudi aujourd'"
	cont "hui. Dommage."
else
	text "ARTHUR: Today's"
	line "not Thursday. How"
	cont "disappointing."
endc

	done

Route36SignText: 
if DEF(_FR_FR)
	text "ROUTE 36"
else
	text "ROUTE 36"
endc

	done

RuinsOfAlphNorthSignText: 
if DEF(_FR_FR)
	text "RUINES D'ALPHA"
	line "ENTREE NORD"
else
	text "RUINS OF ALPH"
	line "NORTH ENTRANCE"
endc

	done

Route36TrainerTips1Text: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Les statistiques"
	line "des #MON"
	cont "varient, même dans"
	cont "la même espèce."

	para "Et même si au dé-"
	line "but deux #MON"
	cont "se ressemblent..."

	para "En grandissant ils"
	line "n'auront pas les"

	para "mêmes forces et"
	line "faiblesses."
else
	text "TRAINER TIPS"

	para "#MON stats"
	line "vary--even within"
	cont "the same species."

	para "Their stats may be"
	line "similar at first."

	para "However, differ-"
	line "ences will become"

	para "pronounced as the"
	line "#MON grow."
endc

	done

Route36TrainerTips2Text: ; TO TRANSLATE
	text "TRAINER TIPS"

	para "Use DIG to return"
	line "to the entrance of"
	cont "some places."

	para "It is convenient"
	line "for exploring"

	para "caves and other"
	line "landmarks."
	done

;Route36_Lockdown1Text:
;	text "The NATIONAL PARK"
;	line "is closed because"
;	cont "of the sanitary"
;	cont "restrictions."
;	done
;
;Route36_Lockdown2Text:
;	text "Hey! You!"
;
;	para "You should be"
;	line "quarantined"
;	cont "right now!"
;
;	para "Get lost before"
;	line "I arrest you!"
;	done

Route36_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 18,  8, ROUTE_36_NATIONAL_PARK_GATE, 3
	warp_event 18,  9, ROUTE_36_NATIONAL_PARK_GATE, 4
	warp_event 47, 13, ROUTE_36_RUINS_OF_ALPH_GATE, 1
	warp_event 48, 13, ROUTE_36_RUINS_OF_ALPH_GATE, 2

	def_coord_events
	coord_event 20,  7, CE_SCENE_ID, SCENE_ROUTE36_SUICUNE, Route36SuicuneScript
	coord_event 22,  7, CE_SCENE_ID, SCENE_ROUTE36_SUICUNE, Route36SuicuneScript

	def_bg_events
	bg_event 29,  1, BGEVENT_READ, Route36TrainerTips2
	bg_event 45, 11, BGEVENT_READ, RuinsOfAlphNorthSign
	bg_event 55,  7, BGEVENT_READ, Route36Sign
	bg_event 21,  7, BGEVENT_READ, Route36TrainerTips1

	def_object_events
	object_event 49, 10, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 30,  6, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event 22, 12, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 32,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 23, 15, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 27,  8, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 54, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 52,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 40,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 20, 12, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 50,  9, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 44,  6, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 2, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 39,  9, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 27, 15, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1



	object_event 20, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicMark, -1
	object_event 31, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerSchoolboyAlan1, -1
	object_event 35,  9, SPRITE_SUDOWOODO, SPRITEMOVEDATA_SUDOWOODO, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SudowoodoScript, EVENT_ROUTE_36_SUDOWOODO
	object_event 51,  8, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Route36LassScript, -1
	object_event 44,  9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Route36RockSmashGuyScript, -1
	object_event 21,  4, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route36FruitTree, -1
	object_event 46,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, ArthurScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 35, 12, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route36FloriaScript, EVENT_MET_FLORIA
	object_event 21,  6, SPRITE_SUICUNE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_36
	object_event 18,  8, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, Route36_DoorScript, -1
	object_event 18,  9, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, Route36_DoorScript, -1
