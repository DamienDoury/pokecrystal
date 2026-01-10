	object_const_def
	const TEAMROCKETBASEB3F_LANCE
	const TEAMROCKETBASEB3F_ROCKET1
	const TEAMROCKETBASEB3F_MURKROW
	const TEAMROCKETBASEB3F_ROCKET_GIRL
	const TEAMROCKETBASEB3F_ROCKET2
	const TEAMROCKETBASEB3F_SCIENTIST1
	const TEAMROCKETBASEB3F_SCIENTIST2
	const TEAMROCKETBASEB3F_ROCKET3
	const TEAMROCKETBASEB3F_SILVER
	const TEAMROCKETBASEB3F_POKE_BALL1
	const TEAMROCKETBASEB3F_POKE_BALL2
	const TEAMROCKETBASEB3F_POKE_BALL3
	const TEAMROCKETBASEB3F_POKE_BALL4
	const TEAMROCKETBASEB3F_POKE_BALL5

TeamRocketBaseB3F_MapScripts:
	def_scene_scripts
	scene_script .LanceGetsPassword ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER
	scene_script .DummyScene2 ; SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS
	scene_script .DummyScene3 ; SCENE_TEAMROCKETBASEB3F_NOTHING

	def_callbacks
	callback MAPCALLBACK_TILES, .CheckGiovanniDoor

.LanceGetsPassword:
	prioritysjump LanceGetPasswordScript
	end

.DummyScene1:
	end

.DummyScene2:
	end

.DummyScene3:
	end

.CheckGiovanniDoor:
	checkevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	iftrue .OpenSesame
	endcallback

.OpenSesame:
	changeblock 10, 8, $07 ; floor
	endcallback

LanceGetPasswordScript:
	turnobject PLAYER, LEFT
	pause 5
	turnobject TEAMROCKETBASEB3F_MURKROW, RIGHT
	pause 20
	turnobject TEAMROCKETBASEB3F_LANCE, RIGHT
	opentext
	writetext LanceGetPasswordText
	waitbutton 
	turnobject TEAMROCKETBASEB3F_LANCE, LEFT
	writetext LanceGetPasswordText2
	waitbutton 
	turnobject TEAMROCKETBASEB3F_LANCE, RIGHT
	writetext LanceGetPasswordText3
	waitbutton 
	closetext
	applymovement TEAMROCKETBASEB3F_LANCE, RocketBaseLanceLeavesMovement
	disappear TEAMROCKETBASEB3F_LANCE
	setscene SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER
	end

RocketBaseRival:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	appear TEAMROCKETBASEB3F_SILVER
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalEnterMovement
	turnobject PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext RocketBaseRivalText
	waitbutton
	closetext
	playsound SFX_TACKLE
	applymovement PLAYER, RocketBaseRivalShovesPlayerMovement
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalLeavesMovement
	disappear TEAMROCKETBASEB3F_SILVER
	setscene SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS
	special RestartMapMusic
	end

TeamRocketBaseB3FRocketScript:
	faceplayer
	jumptext TeamRocketBaseB3FRocketText

RocketBaseBossRight:
	applymovement PLAYER, RocketBasePlayerApproachesBossRightMovement

RocketBaseBossLeft:
	applymovement PLAYER, RocketBasePlayerApproachesBossLeftMovement
	pause 30
	showemote EMOTE_SHOCK, TEAMROCKETBASEB3F_ROCKET1, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject TEAMROCKETBASEB3F_ROCKET1, DOWN
	opentext
	writetext ExecutiveM4BeforeText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossApproachesPlayerMovement
	winlosstext ExecutiveM4BeatenText, 0
	setlasttalked TEAMROCKETBASEB3F_ROCKET1
	loadtrainer EXECUTIVEM, EXECUTIVEM_4
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_4
	opentext
	writetext ExecutiveM4AfterText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossHitsTableMovement
	playsound SFX_TACKLE
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossLeavesMovement
	disappear TEAMROCKETBASEB3F_ROCKET1
	setscene SCENE_TEAMROCKETBASEB3F_NOTHING
	end

RocketBaseMurkrow:
	opentext
	writetext RocketBaseMurkrowText
	waitbutton
	closetext
	setevent EVENT_LEARNED_HAIL_GIOVANNI
	end

SlowpokeTailGrunt:
	trainer GRUNTF, GRUNTF_5, EVENT_BEAT_ROCKET_GRUNTF_5, GruntF5SeenText, GruntF5BeatenText, 0, GruntF5Script

GruntF5Script:
	endifjustbattled
	opentext
	writetext GruntF5AfterBattleText
	waitbutton
	closetext
	setevent EVENT_LEARNED_SLOWPOKETAIL
	end

RaticateTailGrunt:
	trainer GRUNTM, GRUNTM_28, EVENT_BEAT_ROCKET_GRUNTM_28, GruntM28SeenText, GruntM28BeatenText, 0, GruntM28Script

GruntM28Script:
	endifjustbattled
	opentext
	writetext GruntM28AfterBattleText
	waitbutton
	closetext
	setevent EVENT_LEARNED_RATICATE_TAIL
	end

TrainerScientistRoss:
	trainer SCIENTIST, ROSS, EVENT_BEAT_SCIENTIST_ROSS, ScientistRossSeenText, ScientistRossBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer ScientistRossAfterBattleText

TrainerScientistMitch:
	trainer SCIENTIST, MITCH, EVENT_BEAT_SCIENTIST_MITCH, ScientistMitchSeenText, ScientistMitchBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer ScientistMitchAfterBattleText

TeamRocketBaseB3FLockedDoor:
	conditional_event EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE, .Script

.Script:
	opentext
	checkevent EVENT_LEARNED_SLOWPOKETAIL
	iffalse .NeedsPassword
	checkevent EVENT_LEARNED_RATICATE_TAIL
	iffalse .NeedsPassword
	sjump .OpenSesame

.NeedsPassword:
	writetext TeamRocketBaseB3FLockedDoorNeedsPasswordText
	waitbutton
	closetext
	end

.OpenSesame:
	writetext TeamRocketBaseB3FLockedDoorOpenSesameText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 10, 8, $07 ; floor
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	waitsfx
	end

TeamRocketBaseB3FOathScript:
	jumpstd TeamRocketOathScript

TeamRocketBaseB3FProtein:
	itemball PROTEIN

TeamRocketBaseB3FXSpecial:
	itemball X_SPECIAL

TeamRocketBaseB3FFullHeal:
	itemball FULL_HEAL

TeamRocketBaseB3FIceHeal:
	itemball ICE_HEAL

TeamRocketBaseB3FUltraBall:
	itemball ULTRA_BALL

RocketBaseLanceLeavesMovement:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBasePlayerApproachesBossRightMovement:
	step LEFT
	step_end

RocketBasePlayerApproachesBossLeftMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBaseBossApproachesPlayerMovement:
	step DOWN
	step_end

RocketBaseBossHitsTableMovement:
	big_step RIGHT
	big_step RIGHT
	step_end

RocketBaseBossLeavesMovement:
	fix_facing
	fast_jump_step LEFT
	remove_fixed_facing
	step_sleep 8
	step_sleep 8
	slow_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

RocketBaseRivalEnterMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseRivalLeavesMovement:
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

RocketBaseRivalShovesPlayerMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

LanceGetPasswordText:
if DEF(_FR_FR)
	text "PETER: Il faut 2"
	line "mots de passe pour"

	para "entrer chez le"
	line "boss."

	para "Seuls certains"
	line "ROCKETS les con-"
	cont "naissent."
else
	text "LANCE: It takes"
	line "two passwords to"

	para "get into the"
	line "boss's quarters."

	para "Those passwords"
	line "are known only to"
	cont "a few ROCKETS."
endc
	done

LanceGetPasswordText2:
if DEF(_FR_FR)
	text "Ce ROCKET m'a ap-"
	line "pris tout ça très"
	cont "gentiment."
else
	text "That ROCKET there"
	line "very graciously"
	cont "told me so."
endc
	done

LanceGetPasswordText3:
if DEF(_FR_FR)
	text "<PLAY_G>, allons"
	line "trouver les mots"
	cont "de passe."
else
	text "<PLAY_G>, let's go"
	line "get the passwords."
endc
	done

TeamRocketBaseB3FRocketText: 
if DEF(_FR_FR)
	text "Gueuuh... Le type"
	line "avec la cape est"
	cont "trop balèze!"
else
	text "Urrggh… The guy"
	line "in the cape is"
	cont "incredibly tough…"
endc

	done

RocketBaseRivalText: 
if DEF(_FR_FR)
	text "..."

	para "J'te l'avais dit"
	line "que j'allais la"

	para "casser la TEAM"
	line "ROCKET, non?"

	para "Au fait, kissé le"
	line "type avec la cape"

	para "qui a plein de"
	line "#MON dragons?"

	para "Mes #MON se"
	line "sont fait éclater."

	para "Mais c'est pas"
	line "grave. Je pourrai"

	para "le battre dans pas"
	line "longtemps."

	para "Ce qu'il a dit"
	line "me perturbe..."

	para "Il raconte que je"
	line "n'aime ni ne res-"

	para "pecte mes #MON."
	line "Tu le crois ça?"

	para "Comment j'ai pu"
	line "perdre face à un"
	cont "crétin pareil."

	para "...Pfff..."
	line "Vous me faites"
	cont "tous pitié!"
else
	text "…"

	para "Didn't I tell you"
	line "that I was going"

	para "to destroy TEAM"
	line "ROCKET?"

	para "…Tell me, who was"
	line "the guy in the"

	para "cape who used"
	line "dragon #MON?"

	para "My #MON were no"
	line "match at all."

	para "I don't care that"
	line "I lost. I can beat"

	para "him by getting"
	line "stronger #MON."

	para "It's what he said"
	line "that bothers me…"

	para "He told me that"
	line "I don't love and"

	para "trust my #MON"
	line "enough."

	para "I'm furious that I"
	line "lost to a bleeding"
	cont "heart like him."

	para "…Humph! I don't"
	line "have the time for"
	cont "the likes of you!"
endc

	done

ExecutiveM4BeforeText:
if DEF(_FR_FR)
	text "Quoi? Qui es-tu?"
	line "Tu portes un"
	cont "masque chirur-"
	cont "gical..."
	
	para "J'en déduis que tu"
	line "fais partie de la"
	cont "foule endoctrinée"
	cont "et bien docile..."
	
	para "Quand la prétendue"
	line "pandémie a débuté,"
	
	para "le gouvernement a"
	line "réussi à cloîtrer"
	cont "tout le monde chez"
	cont "eux, d'un simple"
	cont "message à la télé."
	
	para "Et tout le monde"
	line "a obéi..."
	
	para "Sous prétexte d'un"
	line "ennemi invisible,"
	cont "ils ont pris le"
	cont "contrôle de nos"
	cont "libertés."
	
	para "Puis ils ont"
	line "déployé la police"
	cont "à chaque coin de"
	cont "la région,"
	
	para "nous maintenant"
	line "sous contrôle"
	cont "par la peur."
	
	para "La TEAM ROCKET ne"
	line "peut pas laisser"
	cont "faire ça..."
else
	text "What? Who are you?"
	line "You're wearing a"
	cont "face mask…"

	para "So you're part of"
	line "the brainwashed"
	cont "normies…"

	para "When the so-called"
	line "pandemic started,"

	para "with a simple"
	line "broadcast,"

	para "the government"
	line "managed to lock up"
	cont "everyone at home."

	para "And everyone"
	line "obeyed…"

	para "With the pretext"
	line "of this invisible"
	cont "enemy, they took"
	cont "over our liberty."

	para "And then they"
	line "deployed the"
	cont "police around"

	para "every corner of"
	line "this region,"

	para "maintaining us"
	line "under control"
	cont "with fear."

	para "TEAM ROCKET can't"
	line "let this go on…"
endc
	done

ExecutiveM4BeatenText:
if DEF(_FR_FR)
	text "Je...comment..."
	line "Trop balèze."
else
	text "I… I couldn't do a"
	line "thing…"
endc
	done

ExecutiveM4AfterText: 
if DEF(_FR_FR)
	text "Je dois m'en"
	line "remettre et..."

	para "Je dois vite pré-"
	line "venir les autres!"
else
	text "No, I can't let"
	line "this affect me."

	para "I have to inform"
	line "the others…"
endc

	done

RocketBaseMurkrowText: 
if DEF(_FR_FR)
	text "CORNEBRE: Le mot"
	line "de passe est..."

	para "VIVE GIOVANNI."
else
	text "MURKROW: The"
	line "password is…"

	para "HAIL GIOVANNI."
endc

	done

GruntF5SeenText: 
if DEF(_FR_FR)
	text "Si je connais le"
	line "mot de passe?"

	para "Peut-être."

	para "Mais j'le donnerai"
	line "pas!"
else
	text "Do I know the"
	line "password?"

	para "Maybe."

	para "But no weakling's"
	line "going to get it!"
endc

	done

GruntF5BeatenText: 
if DEF(_FR_FR)
	text "OK. Arrête."
	line "Je vais parler."
else
	text "All right. Stop."
	line "I'll tell you."
endc

	done

GruntF5AfterBattleText: 
if DEF(_FR_FR)
	text "Le mot de passe de"
	line "la salle du chef"
	cont "est..."

	para "QUEUERAMOLOS."

	para "Mais ça te sert à"
	line "rien sans l'autre"
	cont "mot de passe."
else
	text "The password to"
	line "the boss's room is"

	para "SLOWPOKETAIL."

	para "But it's useless"
	line "unless you have"
	cont "two passwords."
endc

	done

GruntM28SeenText: 
if DEF(_FR_FR)
	text "Gnyark Gnyark!"

	para "Tu me lances un"
	line "défi? A moi? T'es"

	para "débile ou quoi?"
	line "J'vais te bouffer!"

	para "Gnyark Gnyark!"

	para "Bats-moi et je te"
	line "donne un des"

	para "mots de passe pour"
	line "la salle du chef!"
else
	text "Hyuck-hyuck-hyuck!"

	para "You're challenging"
	line "me to a battle?"

	para "Hah! You're nuts,"
	line "but you have guts!"

	para "I like that!"

	para "If you can beat"
	line "me, I'll tell you"

	para "a password to the"
	line "boss's room!"
endc

	done

GruntM28BeatenText: 
if DEF(_FR_FR)
	text "Gnyark!"
	line "Alors toi!"
else
	text "Hyuck-hyuck-hyuck!"
	line "You're good!"
endc

	done

GruntM28AfterBattleText: 
if DEF(_FR_FR)
	text "Gnyark Gnyark!"

	para "Le mot de passe"
	line "est..."

	para "Heu...c'est..."
	line "QUEUE RATTATAC."
else
	text "Hyuck-hyuck-hyuck!"

	para "The password to"
	line "the boss's room…"

	para "Uh…, I think it is"
	line "RATICATE TAIL."
endc

	done

ScientistRossSeenText: 
if DEF(_FR_FR)
	text "Je travaillais"
	line "pour la SYLPHE"

	para "mais maintenant je"
	line "suis pour la"
	cont "TEAM ROCKET."

	para "Une petite peste"
	line "comme toi doit"
	cont "être punie."
else
	text "I used to work for"
	line "SILPH, but now I"

	para "run research for"
	line "TEAM ROCKET."

	para "A meddlesome child"
	line "like you needs to"
	cont "be punished."
endc

	done

ScientistRossBeatenText: 
if DEF(_FR_FR)
	text "Petite erreur"
	line "de calcul..."
else
	text "A mere tactical"
	line "error cost me…"
endc

	done

ScientistRossAfterBattleText:
if DEF(_FR_FR)
	text "Bon, en réalité,"
	line "j'ai été viré de"
	cont "la SYLPHE SARL."
	
	para "Et maintenant, je"
	line "n'arrive pas à"
	
	para "configurer ce"
	line "transmetteur pour"
	cont "décoder les"
	cont "signaux vocaux."
	
	para "Il émet un bruit"
	line "parasite affreux,"
	cont "je supporte plus!"
else
	text "All right, I"
	line "actually got fired"
	cont "from SILPH CO."

	para "And now I can't"
	line "configure this"
	
	para "transmitter to"
	line "decode voice"
	cont "signals."

	para "It's emitting this"
	line "garbage noise,"
	cont "I can't stand it!"
endc
	done

ScientistMitchSeenText:
if DEF(_FR_FR)
	text "Je me fiche que"
	line "les #MON soient"
	cont "blessés par nos"
	cont "expérimentations."
	
	para "C'est un dommage"
	line "collatéral."
else
	text "I don't care that"
	line "#MON are hurt"
	cont "by our experiment."

	para "It's a side-"
	line "product."
endc
	done

ScientistMitchBeatenText: 
if DEF(_FR_FR)
	text "Moi, j'suis un"
	line "cérébral, pas un"
	cont "combattant."
else
	text "Thinking is my"
	line "strong suit, not"
	cont "battling."
endc

	done

ScientistMitchAfterBattleText: 
if DEF(_FR_FR)
	text "On pourrait pous-"
	line "ser le signal au"

	para "niveau national..."
	line "Et puis..."

	para "Ha... Cela serait"
	line "formidable!"
else
	text "If we turn up the"
	line "power of our radio"

	para "signal for broad-"
	line "cast nationwide…"

	para "The very thought"
	line "excites me!"
endc

	done

TeamRocketBaseB3FLockedDoorNeedsPasswordText: 
if DEF(_FR_FR)
	text "La porte est"
	line "fermée..."

	para "Il faut deux mots"
	line "de passe."
else
	text "The door's closed…"

	para "It needs two"
	line "passwords to open."
endc

	done

TeamRocketBaseB3FLockedDoorOpenSesameText: 
if DEF(_FR_FR)
	text "La porte est"
	line "fermée..."

	para "<PLAYER> tape les"
	line "deux mots de"
	cont "passe."

	para "La porte est"
	line "ouverte!"
else
	text "The door's closed…"

	para "<PLAYER> entered"
	line "the two passwords."

	para "The door opened!"
endc

	done

TeamRocketBaseB3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  2, TEAM_ROCKET_BASE_B2F, 2
	warp_event 27,  2, TEAM_ROCKET_BASE_B2F, 3
	warp_event  3,  6, TEAM_ROCKET_BASE_B2F, 4
	warp_event 27, 14, TEAM_ROCKET_BASE_B2F, 5

	def_coord_events
	coord_event 10,  8, CE_SCENE_ID, SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS, RocketBaseBossLeft
	coord_event 11,  8, CE_SCENE_ID, SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS, RocketBaseBossRight
	coord_event  8, 10, CE_SCENE_ID, SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER, RocketBaseRival

	def_bg_events
	bg_event 10,  9, BGEVENT_IFNOTSET, TeamRocketBaseB3FLockedDoor
	bg_event 11,  9, BGEVENT_IFNOTSET, TeamRocketBaseB3FLockedDoor
	bg_event 10,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 11,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 12,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 13,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  4, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  5, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  6, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  7, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript

	def_object_events
	object_event 25, 14, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LanceGetPasswordScript, EVENT_TEAM_ROCKET_BASE_B3F_LANCE_PASSWORDS
	object_event  8,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B3F_EXECUTIVE
	object_event  7,  2, SPRITE_MURKROW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RocketBaseMurkrow, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21,  7, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, SlowpokeTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  5, 14, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, RaticateTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 23, 11, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerScientistRoss, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 11, 15, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerScientistMitch, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 23, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TeamRocketBaseB3FRocketScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  5, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_TEAM_ROCKET_BASE
	object_event  1, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FProtein, EVENT_TEAM_ROCKET_BASE_B3F_PROTEIN
	object_event  3, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FXSpecial, EVENT_TEAM_ROCKET_BASE_B3F_X_SPECIAL
	object_event 28,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FFullHeal, EVENT_TEAM_ROCKET_BASE_B3F_FULL_HEAL
	object_event 17,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FIceHeal, EVENT_TEAM_ROCKET_BASE_B3F_ICE_HEAL
	object_event 14, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FUltraBall, EVENT_TEAM_ROCKET_BASE_B3F_ULTRA_BALL
