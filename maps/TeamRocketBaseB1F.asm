	object_const_def
	const TEAMROCKETBASEB1F_ROCKET1
	const TEAMROCKETBASEB1F_ROCKET2
	const TEAMROCKETBASEB1F_SCIENTIST
	const TEAMROCKETBASEB1F_POKE_BALL1
	const TEAMROCKETBASEB1F_POKE_BALL2
	const TEAMROCKETBASEB1F_POKE_BALL3

TeamRocketBaseB1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene ; SCENE_DEFAULT

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .HideSecurityGrunt

.DummyScene:
	end

.HideSecurityGrunt:
	disappear TEAMROCKETBASEB1F_ROCKET1
	endcallback

SecurityCamera1a:
	checkevent EVENT_SECURITY_CAMERA_1
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 2
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 2
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_1
	end

SecurityCamera1b:
	checkevent EVENT_SECURITY_CAMERA_1
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 3
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 3
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_1
	end

SecurityCamera2a:
	checkevent EVENT_SECURITY_CAMERA_2
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 4, 7
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement2
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 12, 5
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement3
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_2
	end

SecurityCamera2b:
	checkevent EVENT_SECURITY_CAMERA_2
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 4, 8
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement4
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 12, 5
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement5
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_2
	end

SecurityCamera3a:
	checkevent EVENT_SECURITY_CAMERA_3
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 6
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 25, 11
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement6
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_3
	end

SecurityCamera3b:
	checkevent EVENT_SECURITY_CAMERA_3
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 7
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 25, 12
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement7
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_3
	end

SecurityCamera4:
	checkevent EVENT_SECURITY_CAMERA_4
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 17, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 25, 11
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement8
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_4
	end

SecurityCamera5:
	checkevent EVENT_SECURITY_CAMERA_5
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 3, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal TRUE, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 14, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement9
	scall TrainerCameraGrunt2
	ifequal TRUE, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_5
	end

NoSecurityCamera:
	end

TrainerCameraGrunt1:
	opentext
	writetext CameraGrunt1SeenText
	waitbutton
	closetext
	winlosstext CameraGrunt1BeatenText, 0
	setlasttalked TEAMROCKETBASEB1F_ROCKET1
	loadtrainer GRUNTM, GRUNTM_20
	startbattle
	disappear TEAMROCKETBASEB1F_ROCKET1
	reloadmapafterbattle
	end

TrainerCameraGrunt2:
	opentext
	writetext CameraGrunt2SeenText
	waitbutton
	closetext
	winlosstext CameraGrunt2BeatenText, 0
	setlasttalked TEAMROCKETBASEB1F_ROCKET1
	loadtrainer GRUNTM, GRUNTM_21
	startbattle
	disappear TEAMROCKETBASEB1F_ROCKET1
	reloadmapafterbattle
	end

PlaySecurityCameraSounds:
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	end

ExplodingTrap1:
	checkevent EVENT_EXPLODING_TRAP_1
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_1
	end

ExplodingTrap2:
	checkevent EVENT_EXPLODING_TRAP_2
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_2
	end

ExplodingTrap3:
	checkevent EVENT_EXPLODING_TRAP_3
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_3
	end

ExplodingTrap4:
	checkevent EVENT_EXPLODING_TRAP_4
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_4
	end

ExplodingTrap5:
	checkevent EVENT_EXPLODING_TRAP_5
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_5
	end

ExplodingTrap6:
	checkevent EVENT_EXPLODING_TRAP_6
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_6
	end

ExplodingTrap7:
	checkevent EVENT_EXPLODING_TRAP_7
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_7
	end

ExplodingTrap8:
	checkevent EVENT_EXPLODING_TRAP_8
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_8
	end

ExplodingTrap9:
	checkevent EVENT_EXPLODING_TRAP_9
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_9
	end

ExplodingTrap10:
	checkevent EVENT_EXPLODING_TRAP_10
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_10
	end

ExplodingTrap11:
	checkevent EVENT_EXPLODING_TRAP_11
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_11
	end

ExplodingTrap12:
	checkevent EVENT_EXPLODING_TRAP_12
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_12
	end

ExplodingTrap13:
	checkevent EVENT_EXPLODING_TRAP_13
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_13
	end

ExplodingTrap14:
	checkevent EVENT_EXPLODING_TRAP_14
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_14
	end

ExplodingTrap15:
	checkevent EVENT_EXPLODING_TRAP_15
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_15
	end

ExplodingTrap16:
	checkevent EVENT_EXPLODING_TRAP_16
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_16
	end

ExplodingTrap17:
	checkevent EVENT_EXPLODING_TRAP_17
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_17
	end

ExplodingTrap18:
	checkevent EVENT_EXPLODING_TRAP_18
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_18
	end

ExplodingTrap19:
	checkevent EVENT_EXPLODING_TRAP_19
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_19
	end

ExplodingTrap20:
	checkevent EVENT_EXPLODING_TRAP_20
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_20
	end

ExplodingTrap21:
	checkevent EVENT_EXPLODING_TRAP_21
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_21
	end

ExplodingTrap22:
	checkevent EVENT_EXPLODING_TRAP_22
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_22
	end

VoltorbExplodingTrap:
	special FadeOutPalettes
	cry VOLTORB
	special FadeInPalettes
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon VOLTORB, 28
	startbattle
	end

GeodudeExplodingTrap:
	special FadeOutPalettes
	cry GEODUDE
	special FadeInPalettes
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon GEODUDE, 28
	startbattle
	end

KoffingExplodingTrap:
	special FadeOutPalettes
	cry KOFFING
	special FadeInPalettes
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon KOFFING, 28
	startbattle
	end

NoExplodingTrap:
	end

TrainerScientistJed:
	trainer SCIENTIST, JED, EVENT_BEAT_SCIENTIST_JED, ScientistJedSeenText, ScientistJedBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer ScientistJedAfterBattleText

TrainerGruntM16:
	trainer GRUNTM, GRUNTM_16, EVENT_BEAT_ROCKET_GRUNTM_16, GruntM16SeenText, GruntM16BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM16AfterBattleText

TeamRocketBaseB1FSecurityCamera:
	jumptext TeamRocketBaseB1FSecurityCameraText

TeamRocketBaseB1FBookshelf:
	jumpstd TeamRocketOathScript

TeamRocketBaseB1FSecretSwitch:
	opentext
	checkevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	iftrue .SecretSwitchOff
	writetext TeamRocketBaseB1FSecretSwitchText
	playsound SFX_TALLY
	waitbutton
	closetext
	setevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	setevent EVENT_SECURITY_CAMERA_1
	setevent EVENT_SECURITY_CAMERA_2
	setevent EVENT_SECURITY_CAMERA_3
	setevent EVENT_SECURITY_CAMERA_4
	setevent EVENT_SECURITY_CAMERA_5
	end

.SecretSwitchOff:
	writetext TeamRocketBaseB1FSwitchOffText
	waitbutton
	closetext
	end

TeamRocketBaseB1FHyperPotion:
	itemball HYPER_POTION

TeamRocketBaseB1FNugget:
	itemball TOILET_PAPER

TeamRocketBaseB1FGuardSpec:
	itemball GUARD_SPEC

TeamRocketBaseB1FHiddenRevive:
	hiddenitem REVIVE, EVENT_TEAM_ROCKET_BASE_B1F_HIDDEN_REVIVE

SecurityCameraMovement1:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

SecurityCameraMovement2:
	big_step UP
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	turn_head RIGHT
	step_end

SecurityCameraMovement3:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

SecurityCameraMovement4:
; he jumps over a trap
	jump_step UP
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	turn_head RIGHT
	step_end

SecurityCameraMovement5:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

SecurityCameraMovement6:
	big_step UP
	big_step UP
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	step_end

SecurityCameraMovement7:
	big_step UP
	big_step UP
	big_step UP
	big_step RIGHT
	big_step UP
	big_step UP
	big_step LEFT
	step_end

SecurityCameraMovement8:
	big_step DOWN
	big_step DOWN
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

SecurityCameraMovement9:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

CameraGrunt1SeenText: 
if DEF(_FR_FR)
	text "Hé!"
	line "Alerte!!!!"
else
	text "Hey!"
	line "Intruder alert!"
endc

	done

CameraGrunt1BeatenText: 
if DEF(_FR_FR)
	text "Zut... Perdu."
else
	text "Dang… I failed…"
endc

	done

CameraGrunt2SeenText: 
if DEF(_FR_FR)
	text "Mon tour!"
	line "Yahahhaa!"
else
	text "It's my turn!"
	line "There's no escape!"
endc

	done

CameraGrunt2BeatenText: 
if DEF(_FR_FR)
	text "Des caméras se"
	line "trouvent dans les"
	cont "statues."

	para "On viendra tant"
	line "que tu n'actionne-"
	cont "ras pas l'inter-"
	cont "rupteur secret."
else
	text "Surveillance cams"
	line "are in the #MON"
	cont "statues."

	para "We'll keep appear-"
	line "ing until you trip"
	cont "a secret switch."
endc

	done

ScientistJedSeenText: 
if DEF(_FR_FR)
	text "C'était une ca-"
	line "chette ninja ici."

	para "Y'a des pièges"
	line "contre les intrus"
	cont "comme toi."
else
	text "This was once a"
	line "ninja hideout."

	para "There are traps to"
	line "confound intruders"
	cont "like you."
endc

	done

ScientistJedBeatenText: 
if DEF(_FR_FR)
	text "Dans ma face!"
else
	text "I get it…"
endc

	done

ScientistJedAfterBattleText: 
if DEF(_FR_FR)
	text "OK. Voici un"
	line "secret sur notre"
	cont "cachette."

	para "Le truc au sol"
	line "tout droit est un"
	cont "téléporteur."

	para "Marche dessus et"
	line "tu retournes"

	para "à l'entrée..."
	line "Pouf! Magie!"
else
	text "All right. I'll"
	line "divulge a secret"
	cont "about our hideout."

	para "That thing on the"
	line "floor up ahead is"
	cont "a warp panel."

	para "If you step on it,"
	line "you'll be warped"

	para "back to the en-"
	line "trance."
endc

	done

GruntM16SeenText: 
if DEF(_FR_FR)
	text "Alors? On se croit"
	line "chez soi?"

	para "Allez, avance"
	line "pour voir."

	para "Y'a des pièges"
	line "partout!"
else
	text "Heheh. Feeling"
	line "lucky, punk?"

	para "Go ahead, take"
	line "another step."

	para "We've got traps"
	line "set in the floor!"
endc

	done

GruntM16BeatenText: 
if DEF(_FR_FR)
	text "Kaboum!"
else
	text "Kaboom!"
endc

	done

GruntM16AfterBattleText: 
if DEF(_FR_FR)
	text "Je sais même pas"
	line "où sont les"
	cont "pièges!!!"

	para "Alors..."
	line "Courage camarade!"
else
	text "I don't even know"
	line "where the traps"
	cont "are planted."

	para "You'll just have"
	line "to collect your"
	cont "courage and walk."
endc

	done

TeamRocketBaseB1FSecurityCameraText: 
if DEF(_FR_FR)
	text "Une statue de"
	line "PERSIAN..."

	para "Ses yeux brillent"
	line "d'un feu étrange."
else
	text "It's a PERSIAN"
	line "statue…"

	para "Its eyes are oddly"
	line "shiny."
endc

	done

TeamRocketBaseB1FSecretSwitchText: 
if DEF(_FR_FR)
	text "Un interrupteur!"
	line "Allez, on appuie."
else
	text "A secret switch!"
	line "Better press it."
endc

	done

TeamRocketBaseB1FSwitchOffText: 
if DEF(_FR_FR)
	text "L'interrupteur est"
	line "désactivé."
else
	text "The switch is"
	line "turned off."
endc

	done

TeamRocketBaseB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 27,  2, MAHOGANY_MART_1F, 3
	warp_event  3, 14, TEAM_ROCKET_BASE_B2F, 1
	warp_event  5, 15, TEAM_ROCKET_BASE_B1F, 4
	warp_event 25,  2, TEAM_ROCKET_BASE_B1F, 3

	def_coord_events
	; There are five security cameras in the base.
	; Walking in front of one triggers two Rocket Grunts.
	coord_event 24,  2, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera1a
	coord_event 24,  3, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera1b
	coord_event  6,  2, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera2a
	coord_event  6,  3, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera2b
	coord_event 24,  6, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera3a
	coord_event 24,  7, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera3b
	coord_event 22, 16, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera4
	coord_event  8, 16, CE_SCENE_ID, SCENE_DEFAULT, SecurityCamera5
	; There are spots on the floor that trigger a Pokémon battle.
	; Each Pokémon (Voltorb, Koffing, Geodude) knows Selfdestruct.
	coord_event  2,  7, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap1
	coord_event  3,  7, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap2
	coord_event  4,  7, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap3
	coord_event  1,  8, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap4
	coord_event  3,  8, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap5
	coord_event  5,  8, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap6
	coord_event  3,  9, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap7
	coord_event  4,  9, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap8
	coord_event  1, 10, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap9
	coord_event  2, 10, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap10
	coord_event  3, 10, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap11
	coord_event  5, 10, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap12
	coord_event  2, 11, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap13
	coord_event  4, 11, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap14
	coord_event  1, 12, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap15
	coord_event  2, 12, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap16
	coord_event  4, 12, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap17
	coord_event  5, 12, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap18
	coord_event  1, 13, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap19
	coord_event  3, 13, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap20
	coord_event  4, 13, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap21
	coord_event  5, 13, CE_SCENE_ID, SCENE_DEFAULT, ExplodingTrap22

	def_bg_events
	bg_event 19, 11, BGEVENT_READ, TeamRocketBaseB1FSecretSwitch
	bg_event 24,  1, BGEVENT_UP, TeamRocketBaseB1FSecurityCamera
	bg_event  6,  1, BGEVENT_UP, TeamRocketBaseB1FSecurityCamera
	bg_event  8, 15, BGEVENT_UP, TeamRocketBaseB1FSecurityCamera
	bg_event 22, 15, BGEVENT_UP, TeamRocketBaseB1FSecurityCamera
	bg_event 24,  5, BGEVENT_UP, TeamRocketBaseB1FSecurityCamera
	bg_event 20, 11, BGEVENT_READ, TeamRocketBaseB1FBookshelf
	bg_event 21, 11, BGEVENT_READ, TeamRocketBaseB1FBookshelf
	bg_event  3, 11, BGEVENT_ITEM, TeamRocketBaseB1FHiddenRevive

	def_object_events
	object_event  0,  0, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_SECURITY_GRUNTS
	object_event  2,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM16, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 18, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerScientistJed, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 27,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB1FHyperPotion, EVENT_TEAM_ROCKET_BASE_B1F_HYPER_POTION
	object_event 14, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB1FNugget, EVENT_TEAM_ROCKET_BASE_B1F_NUGGET
	object_event 21, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB1FGuardSpec, EVENT_TEAM_ROCKET_BASE_B1F_GUARD_SPEC
