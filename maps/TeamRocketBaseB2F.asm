	object_const_def
	const TEAMROCKETBASEB2F_ROCKET1
	const TEAMROCKETBASEB2F_ROCKET_GIRL
	const TEAMROCKETBASEB2F_LANCE
	const TEAMROCKETBASEB2F_DRAGON
	const TEAMROCKETBASEB2F_ELECTRODE1
	const TEAMROCKETBASEB2F_ELECTRODE2
	const TEAMROCKETBASEB2F_ELECTRODE3
	const TEAMROCKETBASEB2F_ELECTRODE4
	const TEAMROCKETBASEB2F_ELECTRODE5
	const TEAMROCKETBASEB2F_ELECTRODE6
	const TEAMROCKETBASEB2F_ROCKET2
	const TEAMROCKETBASEB2F_ROCKET3
	const TEAMROCKETBASEB2F_ROCKET4
	const TEAMROCKETBASEB2F_POKE_BALL

TeamRocketBaseB2F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS
	scene_script .DummyScene2 ; SCENE_TEAMROCKETBASEB2F_ELECTRODES
	scene_script .DummyScene3 ; SCENE_TEAMROCKETBASEB2F_NOTHING

	def_callbacks
	callback MAPCALLBACK_TILES, .TransmitterDoorCallback

.DummyScene0:
	end

.DummyScene1:
	end

.DummyScene2:
	end

.DummyScene3:
	end

.TransmitterDoorCallback:
	checkevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	iftrue .OpenDoor
	endcallback

.OpenDoor:
	changeblock 14, 12, $07 ; floor
	endcallback

RocketBaseBossFLeft:
	moveobject TEAMROCKETBASEB2F_LANCE, 9, 13
	sjump RocketBaseBossFScript

RocketBaseBossFRight:
	moveobject TEAMROCKETBASEB2F_ROCKET_GIRL, 21, 16
	moveobject TEAMROCKETBASEB2F_ROCKET1, 21, 16
	moveobject TEAMROCKETBASEB2F_DRAGON, 10, 13
	moveobject TEAMROCKETBASEB2F_LANCE, 10, 13
RocketBaseBossFScript:
	appear TEAMROCKETBASEB2F_ROCKET_GIRL
	appear TEAMROCKETBASEB2F_ROCKET1
	opentext
	writetext RocketBaseExecutiveFHoldItText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, RocketBasePlayerApproachesBossFMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFApproachesPlayerMovement
	turnobject PLAYER, UP
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntApproachesPlayerMovement
	opentext
	writetext RocketBaseBossFThrashText
	waitbutton
	closetext
	cry DRAGONITE
	turnobject TEAMROCKETBASEB2F_ROCKET_GIRL, LEFT
	turnobject PLAYER, LEFT
	appear TEAMROCKETBASEB2F_DRAGON
	applymovement TEAMROCKETBASEB2F_DRAGON, RocketBaseDragoniteAttacksMovement
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFHitMovement
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntProtectsBossFMovement
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesBossFMovement
	opentext
	writetext RocketBaseLanceShareFunText
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFFacesPlayerMovement
	opentext
	writetext RocketBaseBossDontMeddleText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntBattlesLanceMovement
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFBattlesPlayerMovement
	winlosstext RocketBaseBossWinText, 0
	setlasttalked TEAMROCKETBASEB2F_ROCKET_GIRL
	loadtrainer EXECUTIVEF, EXECUTIVEF_2
	startbattle
	disappear TEAMROCKETBASEB2F_DRAGON
	setevent EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	reloadmapafterbattle
	setevent EVENT_BEAT_ROCKET_EXECUTIVEF_2
	opentext
	writetext RocketBaseBossRetreatText
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear TEAMROCKETBASEB2F_ROCKET1
	disappear TEAMROCKETBASEB2F_ROCKET_GIRL
	disappear TEAMROCKETBASEB2F_ROCKET2
	disappear TEAMROCKETBASEB2F_ROCKET3
	disappear TEAMROCKETBASEB2F_ROCKET4
	pause 15
	special FadeInQuickly
	setscene SCENE_TEAMROCKETBASEB2F_ELECTRODES
	clearevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	opentext
	writetext RocketBaseLancePostBattleText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceChecksPlayerMovement
	turnobject PLAYER, UP
	opentext
	writetext RocketBaseLancePowerOffText
	waitbutton
	closetext
	follow TEAMROCKETBASEB2F_LANCE, PLAYER
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesMachineMovement
	stopfollow
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLancePacesMovement
	opentext
	writetext RockerBaseLanceElectrodeFaintText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesElectrodesMovement
	disappear TEAMROCKETBASEB2F_LANCE

RocketBaseCantLeaveScript:
	applymovement PLAYER, RocketBasePlayerCantLeaveElectrodesMovement
	end

RocketBaseLancesSideScript:
	opentext
	writetext RocketBaseLancesSideText
	waitbutton
	closetext
	applymovement PLAYER, RocketBasePlayerCantGoRightMovement
	end

LanceHealsScript1:
	turnobject PLAYER, RIGHT
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseBossFFacesPlayerMovement
	sjump LanceHealsCommon

LanceHealsScript2:
	turnobject PLAYER, RIGHT
	turnobject TEAMROCKETBASEB2F_LANCE, LEFT
LanceHealsCommon:
	faceplayer
	opentext
	writetext LanceHealsText1
	waitbutton
	closetext
	special FadeOutPalettes
	special StubbedTrainerRankings_Healings
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes
	opentext
	writetext LanceHealsText2
	waitbutton
	closetext
	setscene SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS
	setevent EVENT_LANCE_HEALED_YOU_IN_TEAM_ROCKET_BASE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

TrainerGruntM17:
	trainer GRUNTM, GRUNTM_17, EVENT_BEAT_ROCKET_GRUNTM_17, GruntM17SeenText, GruntM17BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM17AfterBattleText

TrainerGruntM18:
	trainer GRUNTM, GRUNTM_18, EVENT_BEAT_ROCKET_GRUNTM_18, GruntM18SeenText, GruntM18BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM18AfterBattleText

TrainerGruntM19:
	trainer GRUNTM, GRUNTM_19, EVENT_BEAT_ROCKET_GRUNTM_19, GruntM19SeenText, GruntM19BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM19AfterBattleText

RocketElectrode1:
	cry ELECTRODE
	loadwildmon ELECTRODE, 30
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE1
	disappear TEAMROCKETBASEB2F_ELECTRODE4
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement1
	sjump RocketBaseElectrodeScript

RocketElectrode2:
	cry ELECTRODE
	loadwildmon ELECTRODE, 30
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE2
	disappear TEAMROCKETBASEB2F_ELECTRODE5
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement2
	sjump RocketBaseElectrodeScript

RocketElectrode3:
	cry ELECTRODE
	loadwildmon ELECTRODE, 30
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE3
	disappear TEAMROCKETBASEB2F_ELECTRODE6
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement3
	sjump RocketBaseElectrodeScript

TeamRocketBaseB2FReloadMap:
	reloadmapafterbattle
	end

RocketBaseElectrodeScript:
	moveobject TEAMROCKETBASEB2F_LANCE, 18, 6
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesElectrodesMovement
	turnobject PLAYER, RIGHT
	opentext
	writetext RocketBaseLanceElectrodeDoneText
	promptbutton

	readmem wJohtoAddLevel
	addval 2
	writemem wJohtoAddLevel

	verbosegiveitem HM_STRENGTH
	writetext RocketBaseLanceStrengthText
	waitbutton
	closetext
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	opentext
	writetext RocketBaseLanceMonMasterText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesBaseMovement
	disappear TEAMROCKETBASEB2F_LANCE
	setevent EVENT_CLEARED_ROCKET_HIDEOUT
	setmapscene MAHOGANY_TOWN, SCENE_FINISHED
	clearflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setevent EVENT_ROUTE_43_GATE_ROCKETS
	setscene SCENE_TEAMROCKETBASEB2F_NOTHING
	clearevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	setevent EVENT_SECURITY_CAMERA_1
	setevent EVENT_SECURITY_CAMERA_2
	setevent EVENT_SECURITY_CAMERA_3
	setevent EVENT_SECURITY_CAMERA_4
	setevent EVENT_SECURITY_CAMERA_5
	end

TeamRocketBaseB2FLockedDoor:
	conditional_event EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER, .Script

.Script:
	opentext
	checkevent EVENT_LEARNED_HAIL_GIOVANNI
	iftrue .KnowsPassword
	writetext RocketBaseDoorNoPasswordText
	waitbutton
	closetext
	end

.KnowsPassword:
	writetext RocketBaseDoorKnowPasswordText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 14, 12, $07 ; floor
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	waitsfx
	end

TeamRocketBaseB2FTransmitterScript:
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .Deactivated
	writetext RocketBaseB2FTransmitterText
	waitbutton
	closetext
	end

.Deactivated:
	writetext RocketBaseB2FDeactivateTransmitterText
	waitbutton
	closetext
	end

TeamRocketBaseB2FTMThief:
	itemball TM_THIEF

TeamRocketBaseB2FHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_TEAM_ROCKET_BASE_B2F_HIDDEN_FULL_HEAL

RocketBaseLanceLeavesAfterHealMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerApproachesBossFMovement:
	step DOWN
	step DOWN
	step DOWN
	turn_head RIGHT
	step_end

RocketBaseBossFApproachesPlayerMovement:
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	turn_head DOWN
	step_end

RocketBaseGruntApproachesPlayerMovement:
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

RocketBaseDragoniteAttacksMovement:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

RocketBaseBossFHitMovement:
	fix_facing
	set_sliding
	jump_step RIGHT
	remove_sliding
	remove_fixed_facing
	step_end

RocketBaseBossFFacesPlayerMovement:
	slow_step DOWN
	turn_head LEFT
	step_end

RocketBaseLanceApproachesBossFMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseBossFBattlesPlayerMovement:
	big_step LEFT
	step_end

RocketBaseGruntBattlesLanceMovement:
	big_step LEFT
	step_end

RocketBaseGruntProtectsBossFMovement:
	big_step UP
	turn_head LEFT
	step_end

RocketBaseLanceChecksPlayerMovement:
	step RIGHT
	step RIGHT
	step UP
	turn_head DOWN
	step_end

RocketBaseLanceApproachesMachineMovement:
	step UP
	step UP
	step_end

RocketBaseLancePacesMovement:
	step_sleep 8
	step LEFT
	step LEFT
	turn_head UP
	step_sleep 8
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_sleep 8
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

RocketBaseLanceApproachesElectrodesMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step_end

RocketBasePlayerCantLeaveElectrodesMovement:
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBasePlayerCantGoRightMovement:
	step LEFT
	step_end

RocketBaseLanceLeavesElectrodesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBaseLanceLeavesBaseMovement:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBasePlayerLeavesElectrodesMovement1:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerLeavesElectrodesMovement2:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerLeavesElectrodesMovement3:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseExecutiveFHoldItText: 
if DEF(_FR_FR)
	text "Hop hop hop!"
	line "On bouge plus!"
else
	text "Hold it right"
	line "there!"
endc

	done

RocketBaseBossFThrashText: 
if DEF(_FR_FR)
	text "On peut pas te"
	line "laisser fouiner"
	cont "par ici."

	para "C'est contre la"
	line "politique de la"
	cont "TEAM ROCKET."

	para "Même si t'es super"
	line "méga balèze, tu ne"

	para "pourras jamais"
	line "gagner contre nous"
	cont "deux en même"
	cont "temps."

	para "Désolé ma puce."
	line "C'est l'heure de"
	cont "prendre ta baffe."
else
	text "We can't have a"
	line "brat like you on"
	cont "the loose."

	para "It's harmful to"
	line "TEAM ROCKET's"
	cont "pride, you see."

	para "However strong you"
	line "may be, you can't"

	para "take both of us at"
	line "the same time."

	para "Sorry, baby. Now"
	line "get ready to be"
	cont "thrashed."
endc

	done

RocketBaseLanceShareFunText: 
if DEF(_FR_FR)
	text "Hé! Moi aussi"
	line "je veux m'amuser!"
	cont "T'es perso."
else
	text "Hey! Don't be so"
	line "selfish. Spread"
	cont "the fun around."
endc

	done

RocketBaseBossDontMeddleText: 
if DEF(_FR_FR)
	text "Quoi? Tu avais un"
	line "complice? Et ton"

	para "sens de l'honneur?"
	line "Il est où? Hein?"

	para "Avec le remplaçant"
	line "du boss GIOVANNI,"

	para "je vais te montrer"
	line "qu'il faut pas"

	para "venir se frotter"
	line "à la TEAM ROCKET!"
else
	text "What? You had an"
	line "accomplice?"

	para "Where is your"
	line "sense of honor?"

	para "As the interim"
	line "boss in place of"

	para "GIOVANNI, I'll"
	line "show you how wrong"

	para "it is to meddle"
	line "with TEAM ROCKET!"
endc

	done

RocketBaseBossWinText: 
if DEF(_FR_FR)
	text "Pfff. C'est vrai"
	line "que t'es balèze."

	para "Ca craint."

	para "Si tu venais à la"
	line "TEAM ROCKET, tu"

	para "deviendrais vite"
	line "CAID."
else
	text "Tch, you really"
	line "are strong."

	para "It's too bad."

	para "If you were to"
	line "join TEAM ROCKET,"

	para "you could become"
	line "an EXECUTIVE."
endc

	done

RocketBaseBossRetreatText:
if DEF(_FR_FR)
	text "...Cette cachette"
	line "est fichue..."

	para "Mais c'est pas"
	line "grave. L'opération"
	cont "radio est une"
	cont "réussite totale."

	para "On se fiche de"
	line "cette cachette"
	cont "maintenant."

	para "On a d'autres"
	line "plans."

	para "Tu vas vite com-"
	line "prendre le véri-"

	para "table objectif de"
	line "la TEAM ROCKET."

	para "Hi hihihihi hi!"
else
	text "…This hideout is"
	line "done for…"

	para "But that's fine."
	line "The broadcast ex-"
	cont "periment was a"
	cont "total success."

	para "It doesn't matter"
	line "what happens to"
	cont "this hideout now."

	para "We have much big-"
	line "ger plans."

	para "You'll come to"
	line "understand TEAM"

	para "ROCKET's true"
	line "goal soon enough."

	para "Enjoy yourself"
	line "while you can…"

	para "Fufufufu…"
endc
	done

RocketBaseLancePostBattleText: 
if DEF(_FR_FR)
	text "PETER: Terminé!"
	line "On a battu tous"

	para "les gars de la"
	line "ROCKET du coin."

	para "Mais je m'inquiète"
	line "à propos du jeune"

	para "garçon que j'ai"
	line "combattu..."
else
	text "LANCE: That did"
	line "it. We defeated"

	para "all the ROCKETS"
	line "here."

	para "But I'm concerned"
	line "about the young"

	para "guy I battled in"
	line "the process…"
endc

	done

RocketBaseLancePowerOffText: 
if DEF(_FR_FR)
	text "Pardon, <PLAY_G>."
	line "J'étais en train"

	para "de t'admirer en"
	line "silence."

	para "Tout ce qu'il nous"
	line "reste à faire,"

	para "c'est d'arrêter le"
	line "signal radio."
else
	text "Sorry, <PLAY_G>."
	line "I saw how well you"

	para "were doing, so I"
	line "just hung back."

	para "Now all there is"
	line "left to do is to"

	para "turn off that odd"
	line "radio signal."
endc

	done

RockerBaseLanceElectrodeFaintText: 
if DEF(_FR_FR)
	text "Cette machine"
	line "est la cause du"
	cont "problème."

	para "Je ne vois pas"
	line "d'interrupteur..."

	para "Il n'y a pas de"
	line "choix: il faut"

	para "mettre K.O. tous"
	line "les ELECTRODE."

	para "Cela devrait arrê-"
	line "ter cette machine"

	para "et du même coup"
	line "le signal."

	para "Ce n'est pas la"
	line "faute des #MON,"

	para "ça me met donc un"
	line "peu mal à l'aise."

	para "<PLAY_G>, on"
	line "fait chacun un"
	cont "côté."
else
	text "It's this machine"
	line "that's causing all"
	cont "the problems."

	para "I don't see a"
	line "switch on it…"

	para "We have no choice."
	line "We have to make"

	para "all the ELECTRODE"
	line "faint."

	para "That should stop"
	line "this machine from"

	para "transmitting that"
	line "strange signal."

	para "It's no fault of"
	line "the #MON, so it"

	para "makes me feel"
	line "guilty."

	para "<PLAY_G>, let's"
	line "split the job."
endc

	done

RocketBaseLancesSideText: 
if DEF(_FR_FR)
	text "PETER: Je m'occupe"
	line "de ce côté."
else
	text "LANCE: Leave this"
	line "side to me."
endc

	done

RocketBaseLanceElectrodeDoneText:
if DEF(_FR_FR)
	text "PETER: Cet étrange"
	line "signal s'est enfin"
	cont "arrêté."

	para "Tu es formidable!"
	line "Je te remercie au"

	para "nom de tous les"
	line "#MON."

	para "Au fait. Voilà"
	line "pour toi."
else
	text "LANCE: That odd"
	line "signal has finally"
	cont "stopped."

	para "You're the hero!"
	line "Let me thank you"

	para "on behalf of all"
	line "the #MON."

	para "Oh, yes. You"
	line "should take this."
endc
	done

RocketBaseLanceStrengthText:
if DEF(_FR_FR)
	text "C'est FORCE."
	line "Apprends-la à un"
	
	para "#MON pour qu'il"
	line "puisse pousser des"
	cont "rochers."
	
	para "Ca peut être utile"
	line "pour un aventurier"
	cont "comme toi."
else
	text "That's STRENGTH."
	line "Teach it to a"

	para "#MON to push"
	line "boulders around."

	para "It may come handy"
	line "for an adventurer"
	cont "like you."
endc
	done

RocketBaseLanceMonMasterText:
if DEF(_FR_FR)
	text "<PLAY_G>..."

	para "Devenir le meil-"
	line "leur dresseur"

	para "#MON prend du"
	line "temps et est"
	cont "très difficile..."

	para "Vas-tu tenir le"
	line "coup?"

	para "..."

	para "Je vois."

	para "Je suis impatient"
	line "de te revoir!"
else
	text "<PLAY_G>…"

	para "The journey to be-"
	line "coming the #MON"

	para "MASTER is long and"
	line "difficult."

	para "Knowing that, will"
	line "you keep going?"

	para "…"

	para "I see."

	para "I look forward to"
	line "seeing you again!"
endc
	done

LanceHealsText1: 
if DEF(_FR_FR)
	text "PETER: Tu vas"
	line "bien?"

	para "Tes #MON sont"
	line "très fatigués."

	para "Tiens, soigne-les"
	line "avec mon médica-"
	cont "ment."
else
	text "LANCE: Are you all"
	line "right?"

	para "Your #MON are"
	line "hurt and tired."

	para "Here, give them"
	line "some of my medi-"
	cont "cine."
endc

	done

LanceHealsText2: 
if DEF(_FR_FR)
	text "PETER: <PLAY_G>,"
	line "ensemble pour"
	cont "les #MON!"
else
	text "LANCE: <PLAY_G>,"
	line "let's give it our"
	cont "best for #MON."
endc

	done

GruntM17SeenText: 
if DEF(_FR_FR)
	text "La porte ne"
	line "s'ouvre pas?"

	para "Normal, débiloss!"
	line "Il faut un mot de"

	para "passe connu seule-"
	line "ment de la TEAM"
	cont "ROCKET."
else
	text "The door won't"
	line "open?"

	para "Well, duh."
	line "It has to have a"

	para "password that only"
	line "TEAM ROCKET knows."
endc

	done

GruntM17BeatenText: 
if DEF(_FR_FR)
	text "Quoi? Perdu?"
else
	text "What? I lost?"
endc

	done

GruntM17AfterBattleText: 
if DEF(_FR_FR)
	text "Hé... J'suis juste"
	line "un SBIRE."

	para "J'le connais pas"
	line "le mot de passe..."
	cont "C'est bête, hein?"
else
	text "Heh, I'm just a"
	line "GRUNT."

	para "I don't know the"
	line "password. Too bad"
	cont "for you."
endc

	done

GruntM18SeenText: 
if DEF(_FR_FR)
	text "Désolé je suis. "
	line "Mais te briser"

	para "je dois."
else
	text "Oh, a kid? I don't"
	line "really like this,"

	para "but eliminate you"
	line "I must."
endc

	done

GruntM18BeatenText: 
if DEF(_FR_FR)
	text "Perdu j'ai?"
else
	text "I knew I'd lose…"
endc

	done

GruntM18AfterBattleText:
if DEF(_FR_FR)
	text "Les MAGICARPE qui"
	line "évoluaient à cause"
	cont "du signal, c'était"
	cont "pas prévu."
	
	para "Ca a attiré"
	line "l'attention sur"
	cont "nous, quelle"
	cont "poisse."
else
	text "The MAGIKARPS"
	line "evolving because"

	para "of the signal"
	line "wasn't our"
	cont "intention."

	para "It drew attention"
	line "to us, which is"
	cont "a bummer."
endc
	done

GruntM19SeenText: 
if DEF(_FR_FR)
	text "Espèce de sale"
	line "peste!"
else
	text "You rotten little"
	line "pest!"
endc

	done

GruntM19BeatenText: 
if DEF(_FR_FR)
	text "Grrrr..."
else
	text "Grrrr…"
endc

	done

GruntM19AfterBattleText: 
if DEF(_FR_FR)
	text "Hé! Seul le chef"
	line "connaît le mot de"
	cont "passe de la porte."

	para "Où est le chef?"
	line "Qui sait? Va le"
	cont "chercher toi-même."
else
	text "Heh, only the boss"
	line "knows the password"
	cont "for that door."

	para "Where's the boss?"
	line "Who knows? Go look"
	cont "for yourself."
endc

	done

RocketBaseDoorNoPasswordText: 
if DEF(_FR_FR)
	text "La porte est"
	line "fermée..."

	para "Il faut un mot"
	line "de passe."
else
	text "The door's closed…"

	para "It needs a pass-"
	line "word to open."
endc

	done

RocketBaseDoorKnowPasswordText: 
if DEF(_FR_FR)
	text "La porte est"
	line "fermée..."

	para "<PLAYER> tape"
	line "le mot de passe."

	para "La porte est"
	line "ouverte!"
else
	text "The door's closed…"

	para "<PLAYER> entered"
	line "the password."

	para "The door opened!"
endc

	done

RocketBaseB2FTransmitterText: 
if DEF(_FR_FR)
	text "C'est l'émetteur"
	line "qui envoie"

	para "l'horrible signal"
	line "radio."

	para "Il est réglé au"
	line "maximum."
else
	text "It's the radio"
	line "transmitter that's"

	para "sending the"
	line "sinister signal."

	para "It's working at"
	line "full capacity."
endc

	done

RocketBaseB2FDeactivateTransmitterText: 
if DEF(_FR_FR)
	text "L'émetteur radio"
	line "a enfin interrompu"

	para "son signal maléfi-"
	line "que."
else
	text "The radio trans-"
	line "mitter has finally"

	para "stopped its evil"
	line "broadcast."
endc

	done

TeamRocketBaseB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 14, TEAM_ROCKET_BASE_B1F, 2
	warp_event  3,  2, TEAM_ROCKET_BASE_B3F, 1
	warp_event 27,  2, TEAM_ROCKET_BASE_B3F, 2
	warp_event  3,  6, TEAM_ROCKET_BASE_B3F, 3
	warp_event 27, 14, TEAM_ROCKET_BASE_B3F, 4

	def_coord_events
	coord_event  5, 14, CE_SCENE_ID, SCENE_DEFAULT, LanceHealsScript1
	coord_event  5, 13, CE_SCENE_ID, SCENE_DEFAULT, LanceHealsScript2
	coord_event 14, 11, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, RocketBaseBossFLeft
	coord_event 15, 11, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, RocketBaseBossFRight
	coord_event 14, 12, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseCantLeaveScript
	coord_event 15, 12, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseCantLeaveScript
	coord_event 12,  3, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript
	coord_event 12, 10, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript
	coord_event 12, 11, CE_SCENE_ID, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript

	def_bg_events
	bg_event 14, 12, BGEVENT_IFNOTSET, TeamRocketBaseB2FLockedDoor
	bg_event 15, 12, BGEVENT_IFNOTSET, TeamRocketBaseB2FLockedDoor
	bg_event 17,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 16,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 15,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 14,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 13,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  8, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  7, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  6, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  5, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 13,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 14,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 15,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 16,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  5, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  6, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  7, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  8, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 26,  7, BGEVENT_ITEM, TeamRocketBaseB2FHiddenFullHeal

	def_object_events
	object_event 20, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	object_event 20, 16, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	object_event  7, 13, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	object_event  9, 13, SPRITE_DRAGON, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	object_event  7,  5, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode1, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event  7,  7, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode2, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event  7,  9, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode3, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 22,  5, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event 22,  7, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event 22,  9, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 25, 13, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM17, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerGruntM18, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerGruntM19, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  3, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB2FTMThief, EVENT_TEAM_ROCKET_BASE_B2F_TM_THIEF
