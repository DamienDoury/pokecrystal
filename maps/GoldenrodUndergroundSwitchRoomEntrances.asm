; block ids
UNDERGROUND_DOOR_CLOSED1 EQU $2a
UNDERGROUND_DOOR_CLOSED2 EQU $3e
UNDERGROUND_DOOR_CLOSED3 EQU $3f
UNDERGROUND_DOOR_OPEN1   EQU $2d
UNDERGROUND_DOOR_OPEN2   EQU $3d

ugdoor: MACRO
UGDOOR_\1_XCOORD EQU \2
UGDOOR_\1_YCOORD EQU \3
ENDM

	;      id,  x,  y
	ugdoor  1,  6, 16
	ugdoor  2,  6, 10
	ugdoor  3,  6,  2
	ugdoor  4, 10,  2
	ugdoor  5, 10, 10
	ugdoor  6, 10, 16
	ugdoor  7,  6, 12
	ugdoor  8,  8, 12
	ugdoor  9,  6,  6
	ugdoor 10,  8,  6
	ugdoor 11, 10, 12
	ugdoor 12, 12, 12
	ugdoor 13, 10,  6
	ugdoor 14, 12,  6
	ugdoor 15, 10, 18
	ugdoor 16, 12, 18

doorstate: MACRO
	changeblock UGDOOR_\1_YCOORD, UGDOOR_\1_XCOORD, UNDERGROUND_DOOR_\2
ENDM

	object_const_def
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_PHARMACIST1
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_PHARMACIST2
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_ROCKET1
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_ROCKET2
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_ROCKET3
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_ROCKET_GIRL
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_TEACHER
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SUPER_NERD
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_POKE_BALL1
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_POKE_BALL2
	const GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER

GoldenrodUndergroundSwitchRoomEntrances_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .UpdateDoorPositions

.DummyScene0:
	end

.DummyScene1:
	end

.UpdateDoorPositions:
	readvar VAR_YCOORD
	ifless 28, .dept_store_checkpoint_done

	loadmem wAvoidedControlCheckpoint, AVOIDED_DEPT_STORE_PASSPORT_CONTROL_CHECKPOINT

.dept_store_checkpoint_done
	checkevent EVENT_SWITCH_4
	iffalse .false4
	doorstate 1, OPEN1
.false4
	checkevent EVENT_SWITCH_5
	iffalse .false5
	doorstate 2, OPEN1
.false5
	checkevent EVENT_SWITCH_6
	iffalse .false6
	doorstate 3, OPEN1
.false6
	checkevent EVENT_SWITCH_7
	iffalse .false7
	doorstate 4, OPEN1
.false7
	checkevent EVENT_SWITCH_8
	iffalse .false8
	doorstate 5, OPEN1
.false8
	checkevent EVENT_SWITCH_9
	iffalse .false9
	doorstate 6, OPEN1
.false9
	checkevent EVENT_SWITCH_10
	iffalse .false10
	doorstate 7, CLOSED1
	doorstate 8, OPEN1
.false10
	checkevent EVENT_SWITCH_11
	iffalse .false11
	doorstate 9, CLOSED1
	doorstate 10, OPEN1
.false11
	checkevent EVENT_SWITCH_12
	iffalse .false12
	doorstate 11, CLOSED1
	doorstate 12, OPEN1
.false12
	checkevent EVENT_SWITCH_13
	iffalse .false13
	doorstate 13, CLOSED1
	doorstate 14, OPEN1
.false13
	checkevent EVENT_SWITCH_14
	iffalse .false14
	doorstate 15, CLOSED1
	doorstate 16, OPEN1
.false14
	endcallback

GoldenrodUndergroundSwitchRoomEntrancesSuperNerdScript:
	checkevent EVENT_FIRST_LOCKDOWN_STARTED
	iffalse .before_lockdown
	
	checkevent EVENT_GOLDENROD_ILLEGAL_CASINO
	iffalse .illegal_casino

	checkevent EVENT_GOLDENROD_BEATER
	iffalse .illegal_casino

	jumptextfaceplayer GoldenrodUndergroundSwitchRoomEntrances_SuperNerdText

.illegal_casino:
	jumptextfaceplayer GoldenrodUndergroundSwitchRoomEntrances_SuperNerdShadyDudeText

.before_lockdown:
	jumptextfaceplayer GoldenrodUndergroundSwitchRoomEntrances_SuperNerdBeforeLockdownText

GoldenrodUndergroundSwitchRoomEntrancesTeacherScript:
	jumptextfaceplayer GoldenrodUndergroundSwitchRoomEntrances_TeacherText

UndergroundSilverScene1:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_EXIT_BUILDING
	appear GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	waitsfx
	applymovement GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER, UndergroundSilverApproachMovement1
	turnobject PLAYER, RIGHT
	scall UndergroundSilverBattleScript
	applymovement GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER, UndergroundSilverRetreatMovement1
	playsound SFX_EXIT_BUILDING
	disappear GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	setscene SCENE_FINISHED
	waitsfx
	playmapmusic
	end

UndergroundSilverScene2:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_EXIT_BUILDING
	appear GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	waitsfx
	applymovement GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER, UndergroundSilverApproachMovement2
	turnobject PLAYER, RIGHT
	scall UndergroundSilverBattleScript
	applymovement GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER, UndergroundSilverRetreatMovement2
	playsound SFX_EXIT_BUILDING
	disappear GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	setscene SCENE_FINISHED
	waitsfx
	playmapmusic
	end

UndergroundSilverBattleScript:
	setevent EVENT_HOLE_IN_BURNED_TOWER
	setevent EVENT_RIVAL_BURNED_TOWER
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext UndergroundSilverBeforeText
	waitbutton
	closetext
	setevent EVENT_RIVAL_GOLDENROD_UNDERGROUND
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext UndergroundSilverWinText, UndergroundSilverLossText
	setlasttalked GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	loadtrainer RIVAL1, RIVAL1_4_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .FinishRivalBattle

.Totodile:
	winlosstext UndergroundSilverWinText, UndergroundSilverLossText
	setlasttalked GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	loadtrainer RIVAL1, RIVAL1_4_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .FinishRivalBattle

.Chikorita:
	winlosstext UndergroundSilverWinText, UndergroundSilverLossText
	setlasttalked GOLDENRODUNDERGROUNDSWITCHROOMENTRANCES_SILVER
	loadtrainer RIVAL1, RIVAL1_4_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .FinishRivalBattle

.FinishRivalBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext UndergroundSilverAfterText
	waitbutton
	closetext
	end

TrainerGruntM11:
	trainer GRUNTM, GRUNTM_11, EVENT_BEAT_ROCKET_GRUNTM_11, GruntM11SeenText, GruntM11BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM11AfterBattleText

TrainerGruntM25:
	trainer GRUNTM, GRUNTM_25, EVENT_BEAT_ROCKET_GRUNTM_25, GruntM25SeenText, GruntM25BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM25AfterBattleText

TrainerBurglarDuncan:
	trainer BURGLAR, DUNCAN, EVENT_BEAT_BURGLAR_DUNCAN, BurglarDuncanSeenText, BurglarDuncanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BurglarDuncanAfterBattleText

TrainerBurglarEddie:
	trainer BURGLAR, EDDIE, EVENT_BEAT_BURGLAR_EDDIE, BurglarEddieSeenText, BurglarEddieBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BurglarEddieAfterBattleText

TrainerGruntM13:
	trainer GRUNTM, GRUNTM_13, EVENT_BEAT_ROCKET_GRUNTM_13, GruntM13SeenText, GruntM13BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM13AfterBattleText

TrainerGruntF3:
	trainer GRUNTF, GRUNTF_3, EVENT_BEAT_ROCKET_GRUNTF_3, GruntF3SeenText, GruntF3BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntF3AfterBattleText

Switch1Script:
	opentext
	writetext SwitchRoomText_Switch1
	promptbutton
	checkevent EVENT_SWITCH_1
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval 1
	writemem wUndergroundSwitchPositions
	setevent EVENT_SWITCH_1
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval -1
	writemem wUndergroundSwitchPositions
	clearevent EVENT_SWITCH_1
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

Switch2Script:
	opentext
	writetext SwitchRoomText_Switch2
	promptbutton
	checkevent EVENT_SWITCH_2
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval 2
	writemem wUndergroundSwitchPositions
	setevent EVENT_SWITCH_2
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval -2
	writemem wUndergroundSwitchPositions
	clearevent EVENT_SWITCH_2
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

Switch3Script:
	opentext
	writetext SwitchRoomText_Switch3
	promptbutton
	checkevent EVENT_SWITCH_3
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval 3
	writemem wUndergroundSwitchPositions
	setevent EVENT_SWITCH_3
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval -3
	writemem wUndergroundSwitchPositions
	clearevent EVENT_SWITCH_3
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

EmergencySwitchScript:
	opentext
	writetext SwitchRoomText_Emergency
	promptbutton
	checkevent EVENT_EMERGENCY_SWITCH
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	setval 7
	writemem wUndergroundSwitchPositions
	setevent EVENT_EMERGENCY_SWITCH
	setevent EVENT_SWITCH_1
	setevent EVENT_SWITCH_2
	setevent EVENT_SWITCH_3
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse GoldenrodUndergroundSwitchRoomEntrances_DontToggle
	setval 0
	writemem wUndergroundSwitchPositions
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	sjump GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors

GoldenrodUndergroundSwitchRoomEntrances_DontToggle:
	closetext
	end

GoldenrodUndergroundSwitchRoomEntrances_UpdateDoors:
	readmem wUndergroundSwitchPositions
	ifequal 0, .Position0
	ifequal 1, .Position1
	ifequal 2, .Position2
	ifequal 3, .Position3
	ifequal 4, .Position4
	ifequal 5, .Position5
	ifequal 6, .Position6
	ifequal 7, .EmergencyPosition
.Position0:
	playsound SFX_ENTER_DOOR
	scall .Clear4
	scall .Clear5
	scall .Clear6
	scall .Clear7
	scall .Clear8
	scall .Clear9
	scall .Clear10
	scall .Clear11
	scall .Clear12
	scall .Clear13
	scall .Clear14
	reloadmappart
	closetext
	end

.Position1:
	playsound SFX_ENTER_DOOR
	scall .Set4
	scall .Set10
	scall .Set13
	scall .Clear9
	scall .Clear11
	scall .Clear12
	scall .Clear14
	reloadmappart
	closetext
	end

.Position2:
	playsound SFX_ENTER_DOOR
	scall .Set5
	scall .Set11
	scall .Set12
	scall .Clear8
	scall .Clear10
	scall .Clear13
	scall .Clear14
	reloadmappart
	closetext
	end

.Position3:
	playsound SFX_ENTER_DOOR
	scall .Set6
	scall .Set10
	scall .Set13
	scall .Clear7
	scall .Clear11
	scall .Clear12
	scall .Clear14
	reloadmappart
	closetext
	end

.Position4:
	playsound SFX_ENTER_DOOR
	scall .Set7
	scall .Set11
	scall .Set12
	scall .Clear6
	scall .Clear10
	scall .Clear13
	scall .Clear14
	reloadmappart
	closetext
	end

.Position5:
	playsound SFX_ENTER_DOOR
	scall .Set8
	scall .Set10
	scall .Set13
	scall .Clear5
	scall .Clear11
	scall .Clear12
	scall .Clear14
	reloadmappart
	closetext
	end

.Position6:
	playsound SFX_ENTER_DOOR
	scall .Set9
	scall .Set11
	scall .Set12
	scall .Set14
	scall .Clear4
	scall .Clear10
	scall .Clear13
	reloadmappart
	closetext
	end

.EmergencyPosition:
	playsound SFX_ENTER_DOOR
	scall .Clear4
	scall .Clear5
	scall .Set6
	scall .Clear7
	scall .Set8
	scall .Set9
	scall .Clear10
	scall .Set11
	scall .Set12
	scall .Clear13
	scall .Set14
	reloadmappart
	closetext
	setval 6
	writemem wUndergroundSwitchPositions
	end

.Set4:
	doorstate 1, OPEN1
	setevent EVENT_SWITCH_4
	end

.Set5:
	doorstate 2, OPEN1
	setevent EVENT_SWITCH_5
	end

.Set6:
	doorstate 3, OPEN1
	setevent EVENT_SWITCH_6
	end

.Set7:
	doorstate 4, OPEN1
	setevent EVENT_SWITCH_7
	end

.Set8:
	doorstate 5, OPEN1
	setevent EVENT_SWITCH_8
	end

.Set9:
	doorstate 6, OPEN1
	setevent EVENT_SWITCH_9
	end

.Set10:
	doorstate 7, CLOSED1
	doorstate 8, OPEN1
	setevent EVENT_SWITCH_10
	end

.Set11:
	doorstate 9, CLOSED1
	doorstate 10, OPEN1
	setevent EVENT_SWITCH_11
	end

.Set12:
	doorstate 11, CLOSED1
	doorstate 12, OPEN1
	setevent EVENT_SWITCH_12
	end

.Set13:
	doorstate 13, CLOSED1
	doorstate 14, OPEN1
	setevent EVENT_SWITCH_13
	end

.Set14:
	doorstate 15, CLOSED1
	doorstate 16, OPEN1
	setevent EVENT_SWITCH_14
	end

.Clear4:
	doorstate 1, CLOSED2
	clearevent EVENT_SWITCH_4
	end

.Clear5:
	doorstate 2, CLOSED2
	clearevent EVENT_SWITCH_5
	end

.Clear6:
	doorstate 3, CLOSED2
	clearevent EVENT_SWITCH_6
	end

.Clear7:
	doorstate 4, CLOSED2
	clearevent EVENT_SWITCH_7
	end

.Clear8:
	doorstate 5, CLOSED2
	clearevent EVENT_SWITCH_8
	end

.Clear9:
	doorstate 6, CLOSED2
	clearevent EVENT_SWITCH_9
	end

.Clear10:
	doorstate 7, CLOSED3
	doorstate 8, OPEN2
	clearevent EVENT_SWITCH_10
	end

.Clear11:
	doorstate 9, CLOSED3
	doorstate 10, OPEN2
	clearevent EVENT_SWITCH_11
	end

.Clear12:
	doorstate 11, CLOSED3
	doorstate 12, OPEN2
	clearevent EVENT_SWITCH_12
	end

.Clear13:
	doorstate 13, CLOSED3
	doorstate 14, OPEN2
	clearevent EVENT_SWITCH_13
	end

.Clear14:
	doorstate 15, CLOSED3
	doorstate 16, OPEN2
	clearevent EVENT_SWITCH_14
	end

GoldenrodUndergroundSwitchRoomEntrancesSmokeBall:
	itemball SMOKE_BALL

GoldenrodUndergroundSwitchRoomEntrancesFullHeal:
	itemball FULL_HEAL

GoldenrodUndergroundSwitchRoomEntrancesHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_HIDDEN_MAX_POTION

GoldenrodUndergroundSwitchRoomEntrancesHiddenRevive:
	hiddenitem REVIVE, EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_HIDDEN_REVIVE

UndergroundSilverApproachMovement1:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

UndergroundSilverApproachMovement2:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

UndergroundSilverRetreatMovement1:
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step_end

UndergroundSilverRetreatMovement2:
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step_end

UndergroundSilverBeforeText: 
if DEF(_FR_FR)
	text "Minute!"

	para "Hé hé! J'étais"
	line "derrière toi..."

	para "J'ai pas besoin de"
	line "toi pour casser la"

	para "tête à la TEAM"
	line "ROCKET."

	para "...Attends voir..."
	line "Tu m'as battu"
	cont "avant, non?"

	para "C'était de la"
	line "chance."

	para "Mais cette fois..."
	line "Ca va saigner!"
else
	text "Hold it!"

	para "I saw you, so I"
	line "tailed you."

	para "I don't need you"
	line "underfoot while I"

	para "take care of TEAM"
	line "ROCKET."

	para "…Wait a second."
	line "You beat me be-"
	cont "fore, didn't you?"

	para "That was just a"
	line "fluke."

	para "But I repay my"
	line "debts!"
endc

	done

UndergroundSilverWinText: 
if DEF(_FR_FR)
	text "...Pourquoi..."
	line "Moi perdre?"

	para "Mes #MON sont"
	line "super balèzes!"

	para "Je les ai entraî-"
	line "nés à fond!"

	para "Alors pourquoi???"
else
	text "…Why…"
	line "Why do I lose?"

	para "I've assembled the"
	line "toughest #MON."

	para "I didn't ease up"
	line "on the gas."

	para "So why do I lose?"
endc

	done

UndergroundSilverAfterText: 
if DEF(_FR_FR)
	text "C'est..."
	line "Incroyable..."

	para "Ce qu'a dit PETER"
	line "est donc vrai?"

	para "Je m'occupe mal de"
	line "mes #MON?"

	para "Amour..."

	para "Confiance..."

	para "Est-ce aussi im-"
	line "portant?"

	para "Est-ce la raison"
	line "de ma défaite?"

	para "Je ne comprends"
	line "plus rien..."

	para "Mais ce n'est pas"
	line "la fin."

	para "Pas maintenant..."
	line "Pas comme ça."

	para "Je serai le plus"
	line "grand dresseur de"

	para "#MON de tous"
	line "les temps!"
else
	text "…I don't under-"
	line "stand…"

	para "Is what that LANCE"
	line "guy said true?"

	para "That I don't treat"
	line "#MON properly?"

	para "Love…"

	para "Trust…"

	para "Are they really"
	line "what I lack?"

	para "Are they keeping"
	line "me from winning?"

	para "I… I just don't"
	line "understand."

	para "But it's not going"
	line "to end here."

	para "Not now. Not"
	line "because of this."

	para "I won't give up my"
	line "dream of becoming"

	para "the world's best"
	line "#MON trainer!"
endc

	done

UndergroundSilverLossText: 
if DEF(_FR_FR)
	text "Tsss! Voilà ce que"
	line "c'est la force."

	para "J'vais la bouffer"
	line "la TEAM ROCKET."

	para "Et PETER..."
	line "J'vais lui casser"
	cont "ses rêves."
else
	text "Humph. This is my"
	line "real power, wimp."

	para "I'll make TEAM"
	line "ROCKET history."

	para "And I'm going to"
	line "grind that LANCE"
	cont "under my heels."
endc

	done

GoldenrodUndergroundSwitchRoomEntrances_SuperNerdBeforeLockdownText:
if DEF(_FR_FR)
	text "J'ai vu un homme"
	line "suspect rôder dans"
	cont "le SOUTERRAIN."

	para "Il se trame un"
	line "truc, je le sens."

	para "Tu ferais mieux"
	line "de faire gaffe."
else
	text "I've seen a sus-"
	line "picious man down"
	cont "the underground."

	para "Something is up,"
	line "I can tell."

	para "You'd better be"
	line "careful."
endc
	done


GoldenrodUndergroundSwitchRoomEntrances_SuperNerdShadyDudeText:
if DEF(_FR_FR)
	text "Tu as remarqué un"
	line "type louche rôder"
	cont "à l'Est de la"
	cont "ville le matin?"
	
	para "Je l'ai vu parler"
	line "à un autre type"
	cont "louche du"
	cont "SOUTERRAIN."

	para "Pendant ce temps,"
	line "la police passe"
	cont "son temps à pour-"
	cont "chasser les gens"
	cont "dont le masque ne"
	cont "couvre pas bien"
	cont "leur nez..."
	
	para "Tu ferais mieux"
	line "de faire gaffe."
else
	text "Have you noticed a"
	line "shady dude lurking"
	cont "around the East"
	cont "part of the city"
	cont "in the morning?"
	
	para "I've seen him talk"
	line "to another sketchy"
	cont "guy down there."

	para "Meanwhile, the"
	line "police is busy"
	cont "chasing everyone"
	cont "whose face mask"
	cont "doesn't properly"
	cont "cover their nose…"
	
	para "You'd better be"
	line "careful."
endc
	done

GoldenrodUndergroundSwitchRoomEntrances_SuperNerdText: 
if DEF(_FR_FR)
	text "J'ai fait un"
	line "combat en bas."

	para "C'était super"
	line "chaud. Un conseil:"
	cont "fais super gaffe!"
else
	text "I was challenged"
	line "to a battle down-"
	cont "stairs."

	para "It's rough down"
	line "there. You'd"
	cont "better be careful."
endc

	done

GoldenrodUndergroundSwitchRoomEntrances_TeacherText: 
if DEF(_FR_FR)
	text "Il y a des bouti-"
	line "ques en bas..."

	para "Mais il y a aussi"
	line "des dresseurs..."

	para "Alors j'ai peur"
	line "d'y aller."
else
	text "There are some"
	line "shops downstairs…"

	para "But there are"
	line "also trainers."

	para "I'm scared to go"
	line "down there."
endc

	done

GruntM11SeenText: 
if DEF(_FR_FR)
	text "Ouvre un truc et"
	line "un autre se ferme."

	para "C'est dur d'avan-"
	line "cer, hein?"
else
	text "Open one shutter,"
	line "another closes."

	para "Bet you can't get"
	line "where you want!"
endc

	done

GruntM11BeatenText: 
if DEF(_FR_FR)
	text "Zut de flûte!"
	line "J'suis perdu!"
else
	text "Drat! I was sunk"
	line "by indecision!"
endc

	done

GruntM11AfterBattleText: 
if DEF(_FR_FR)
	text "Moi aussi je m'y"
	line "perds: le premier"

	para "interrupteur à"
	line "activer est au"
	cont "bout et après..."
else
	text "I'm confused too…"
	line "The switch on the"

	para "end is the one to"
	line "press first, but…"
endc

	done

GruntM25SeenText: 
if DEF(_FR_FR)
	text "Kwahaha!"

	para "Les volets te po-"
	line "sent un problème?"

	para "Bats-moi et je te"
	line "confie un p'tit"
	cont "secret!"
else
	text "Kwahaha!"

	para "Confounded by the"
	line "shutters, are we?"

	para "I'll let you in on"
	line "a secret if you"
	cont "can beat me!"
endc

	done

GruntM25BeatenText: 
if DEF(_FR_FR)
	text "Hmmm..."
	line "Dommage."
else
	text "Uwww…"
	line "I blew it."
endc

	done

GruntM25AfterBattleText: 
if DEF(_FR_FR)
	text "OK. Un conseil!"

	para "Change l'ordre"
	line "d'activation."

	para "Et l'ordre de fer-"
	line "meture des volets"
	cont "changera."
else
	text "All right. A hint!"

	para "Change the order"
	line "of switching."

	para "That'll change the"
	line "ways the shutters"
	cont "open and close."
endc

	done

BurglarDuncanSeenText: 
if DEF(_FR_FR)
	text "Envoie ton blé!"
else
	text "Fork over your"
	line "goodies!"
endc

	done

BurglarDuncanBeatenText: 
if DEF(_FR_FR)
	text "Pitié!"
else
	text "Mercy!"
endc

	done

BurglarDuncanAfterBattleText: 
if DEF(_FR_FR)
	text "Voler c'est cool!"
	line "Piller c'est top!"
else
	text "Steal and sell!"
	line "That's basic in"
	cont "crime, kid!"
endc

	done

BurglarEddieSeenText: 
if DEF(_FR_FR)
	text "Ils ont abandonné"
	line "ce projet avant la"
	cont "fin."

	para "Je cherche des"
	line "restes à voler."
else
	text "They ditched this"
	line "project before"
	cont "they finished."

	para "I'm searching for"
	line "leftover loot."
endc

	done

BurglarEddieBeatenText: 
if DEF(_FR_FR)
	text "Yarglah!"
else
	text "Over the top!"
endc

	done

BurglarEddieAfterBattleText: 
if DEF(_FR_FR)
	text "Le DEPOT"
	line "SOUTERRAIN?"

	para "Pourquoi tu veux"
	line "y aller?"

	para "Y'a rien du tout"
	line "dans le coin."
else
	text "UNDERGROUND WARE-"
	line "HOUSE?"

	para "What do you want"
	line "to go there for?"

	para "There's nothing"
	line "down there."
endc

	done

GruntM13SeenText: 
if DEF(_FR_FR)
	text "Je m'en fiche si"
	line "tu ne sais pas par"
	cont "où aller."

	para "Si tu viens ici,"
	line "tu dois t'attendre"
	cont "aux conséquences!"
else
	text "I don't care if"
	line "you're lost."

	para "You show up here,"
	line "you're nothing but"
	cont "a victim!"
endc

	done

GruntM13BeatenText: 
if DEF(_FR_FR)
	text "Gueuh! Tu te crois"
	line "balèze ou quoi?"
else
	text "Urk! Yeah, think"
	line "you're cool, huh?"
endc

	done

GruntM13AfterBattleText: 
if DEF(_FR_FR)
	text "T'as un sacré cou-"
	line "rage pour t'atta-"
	cont "quer à la ROCKET."
else
	text "You must have ice"
	line "in your veins to"
	cont "dis TEAM ROCKET."
endc

	done

SwitchRoomText_Switch1: 
if DEF(_FR_FR)
	text "C'est écrit:"
	line "INTERRUPTEUR 1."
else
	text "It's labeled"
	line "SWITCH 1."
endc

	done

GruntF3SeenText: 
if DEF(_FR_FR)
	text "T'as pas l'air"
	line "d'avoir peur."

	para "Attends..."
	line "Moi je vais te"
	cont "faire peur!"
else
	text "Are you lost? No,"
	line "you can't be."

	para "You don't have"
	line "that scared look."

	para "I'll give you"
	line "something to be"
	cont "scared about!"
endc

	done

GruntF3BeatenText: 
if DEF(_FR_FR)
	text "Comment oses-tu?"
else
	text "How could you?"
endc

	done

GruntF3AfterBattleText: 
if DEF(_FR_FR)
	text "Va où tu veux!"
	line "Va-t'en!"
	cont "Je m'en fiche!"
else
	text "Go wherever you'd"
	line "like! Get lost!"
	cont "See if I care!"
endc

	done

SwitchRoomText_OffTurnOn: 
if DEF(_FR_FR)
	text "C'est éteint."
	line "On l'active?"
else
	text "It's OFF."
	line "Turn it ON?"
endc

	done

SwitchRoomText_OnTurnOff: 
if DEF(_FR_FR)
	text "C'est activé."
	line "On l'éteint?"
else
	text "It's ON."
	line "Turn it OFF?"
endc

	done

SwitchRoomText_Switch2: 
if DEF(_FR_FR)
	text "C'est écrit:"
	line "INTERRUPTEUR 2."
else
	text "It's labeled"
	line "SWITCH 2."
endc

	done

SwitchRoomText_Switch3: 
if DEF(_FR_FR)
	text "C'est écrit:"
	line "INTERRUPTEUR 3."
else
	text "It's labeled"
	line "SWITCH 3."
endc

	done

SwitchRoomText_Emergency: 
if DEF(_FR_FR)
	text "C'est écrit:"
	line "URGENCE."
else
	text "It's labeled"
	line "EMERGENCY."
endc

	done

GoldenrodUndergroundSwitchRoomEntrances_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 23,  3, GOLDENROD_UNDERGROUND, 6
	warp_event 22, 10, GOLDENROD_UNDERGROUND_WAREHOUSE, 1
	warp_event 23, 10, GOLDENROD_UNDERGROUND_WAREHOUSE, 2
	warp_event  5, 25, GOLDENROD_UNDERGROUND, 2
	warp_event  4, 29, GOLDENROD_CITY, 14
	warp_event  5, 29, GOLDENROD_CITY, 14
	warp_event 21, 25, GOLDENROD_UNDERGROUND, 1
	warp_event 20, 29, GOLDENROD_CITY, 13
	warp_event 21, 29, GOLDENROD_CITY, 13

	def_coord_events
	coord_event 19,  4, CE_SCENE_ID, SCENE_DEFAULT, UndergroundSilverScene1
	coord_event 19,  5, CE_SCENE_ID, SCENE_DEFAULT, UndergroundSilverScene2

	def_bg_events
	bg_event 16,  1, BGEVENT_READ, Switch1Script
	bg_event 10,  1, BGEVENT_READ, Switch2Script
	bg_event  2,  1, BGEVENT_READ, Switch3Script
	bg_event 20, 11, BGEVENT_READ, EmergencySwitchScript
	bg_event  8,  9, BGEVENT_ITEM, GoldenrodUndergroundSwitchRoomEntrancesHiddenMaxPotion
	bg_event  1,  8, BGEVENT_ITEM, GoldenrodUndergroundSwitchRoomEntrancesHiddenRevive

	def_object_events
	object_event  9, 12, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerBurglarDuncan, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  8, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerBurglarEddie, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 17,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM13, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 11,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM11, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  3,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM25, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 19, 12, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerGruntF3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  3, 27, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundSwitchRoomEntrancesTeacherScript, -1
	object_event 19, 27, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundSwitchRoomEntrancesSuperNerdScript, -1
	object_event  1, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodUndergroundSwitchRoomEntrancesSmokeBall, EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_SMOKE_BALL
	object_event 14,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodUndergroundSwitchRoomEntrancesFullHeal, EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_FULL_HEAL
	object_event 23,  3, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_GOLDENROD_UNDERGROUND
