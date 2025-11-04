	object_const_def
	const RADIOTOWER5F_DIRECTOR
	const RADIOTOWER5F_ROCKET
	const RADIOTOWER5F_ROCKET_GIRL
	const RADIOTOWER5F_ROCKER
	const RADIOTOWER5F_POKE_BALL
	const RADIOTOWER5F_BASEMENT_KEY
	const RADIOTOWER5F_ROCKET_IMPOSTER

RadioTower5F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterMap
	
.EnterMap:
	checkevent EVENT_TEAM_ROCKET_DISBANDED
	iftrue .ShowDirectorSprite

	checkevent EVENT_BEAT_ROCKET_EXECUTIVEM_3
	iftrue .ShowRocketSprite

.ShowDirectorSprite
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Hides the rocket.
	endcallback

.ShowRocketSprite
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Hides the director.
	endcallback

FakeDirectorScript:
	turnobject RADIOTOWER5F_DIRECTOR, UP
	showemote EMOTE_SHOCK, RADIOTOWER5F_DIRECTOR, 15
	opentext
	writetext FakeDirectorTextBefore1
	waitbutton
	closetext
	applymovement RADIOTOWER5F_DIRECTOR, FakeDirectorMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext FakeDirectorTextBefore2
	waitbutton
	closetext

	pause 10
	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FFakeDirectorSpinsMovement
	appear RADIOTOWER5F_ROCKET_IMPOSTER
	disappear RADIOTOWER5F_DIRECTOR
	applymovement RADIOTOWER5F_ROCKET_IMPOSTER, RadioTower5FFakeDirectorSpinsMovement
	pause 10

	opentext
	writetext FakeDirectorTextBefore3
	waitbutton
	closetext

	applymovement RADIOTOWER5F_ROCKET_IMPOSTER, RadioTower5FRocketImposterStepUp
	winlosstext FakeDirectorWinText, 0
	setlasttalked RADIOTOWER5F_DIRECTOR
	loadtrainer EXECUTIVEM, EXECUTIVEM_3
	startbattle
	reloadmapafterbattle
	opentext
	writetext FakeDirectorTextAfter
	waitbutton
	closetext
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_3
	end

Director:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .TrueDirector
	writetext FakeDirectorTextAfter
	waitbutton
	closetext
	end

.TrueDirector:
	writetext RadioTower5FDirectorText
	waitbutton
	closetext
	end

TrainerExecutivef1:
	trainer EXECUTIVEF, EXECUTIVEF_1, EVENT_BEAT_ROCKET_EXECUTIVEF_1, Executivef1SeenText, Executivef1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer Executivef1AfterBattleText

RadioTower5FRocketBossScene:
	applymovement PLAYER, RadioTower5FPlayerTwoStepsLeftMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject RADIOTOWER5F_ROCKET, RIGHT
	opentext
	writetext RadioTower5FRocketBossBeforeText
	yesorno
	iftrue .SkipBattle

	writetext RadioTower5FRocketBossStartBattleText
	waitbutton
	closetext
	winlosstext RadioTower5FRocketBossWinText, 0
	setlasttalked RADIOTOWER5F_ROCKET
	loadtrainer EXECUTIVEM, EXECUTIVEM_1
	startbattle
	reloadmapafterbattle
	opentext
	writetext RadioTower5FRocketBossAfterText
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear RADIOTOWER5F_ROCKET
	disappear RADIOTOWER5F_ROCKET_GIRL
	pause 15
	special FadeInQuickly
	
	readmem wJohtoAddLevel
	addval 2
	writemem wJohtoAddLevel

	setevent EVENT_GOLDENROD_ILLEGAL_CASINO
	setevent EVENT_GOLDENROD_BEATER
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_1
	setevent EVENT_CLEARED_RADIO_TOWER
	clearflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	setevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearflag ENGINE_ROCKETS_IN_MAHOGANY
	clearevent EVENT_GOLDENROD_CITY_CIVILIANS
	clearevent EVENT_RADIO_TOWER_CIVILIANS_AFTER
	setevent EVENT_BLACKTHORN_CITY_SUPER_NERD_BLOCKS_GYM
	clearevent EVENT_BLACKTHORN_CITY_SUPER_NERD_DOES_NOT_BLOCK_GYM
	special PlayMapMusic
	disappear RADIOTOWER5F_DIRECTOR
	moveobject RADIOTOWER5F_DIRECTOR, 12, 0
	appear RADIOTOWER5F_DIRECTOR
	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FDirectorWalksIn
	applymovement PLAYER, RadioTower5FPlayerStepsBackMovement
	opentext
	writetext RadioTower5FDirectorThankYouText
	promptbutton
	verbosegiveitem CLEAR_BELL
	writetext RadioTower5FDirectorDescribeClearBellText
	promptbutton

	checkevent EVENT_RELEASED_THE_BEASTS
	iffalse .SkipTinTowerEventNotification

	writetext RadioTower5FDirectorNotifiesAboutSuicuneText
	promptbutton

.SkipTinTowerEventNotification:
	writetext RadioTower5FDirectorGetBackText
	waitbutton
	closetext
	setevent EVENT_GOT_CLEAR_BELL
	setevent EVENT_TEAM_ROCKET_DISBANDED
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_3

	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FDirectorWalksOut
	playsound SFX_EXIT_BUILDING
	disappear RADIOTOWER5F_DIRECTOR
	end

.SkipBattle:
	writetext RadioTower5FRocketBossSkipBattleText
	waitbutton
	closetext
	turnobject RADIOTOWER5F_ROCKET, LEFT
	applymovement PLAYER, RadioTower5FPlayerSkipsBattleMovement
	; We don't stop the music.
	end

Ben:
	faceplayer
	jumptext BenText ; Avoiding the use of jumptextfaceplayer prevents the display of the clap dialog.

RadioTower5FUltraBall:
	itemball ULTRA_BALL

RadioTower5FBasementKey:
	itemball BASEMENT_KEY
	
RadioTower5FDirectorsOfficeSign:
	jumptext RadioTower5FDirectorsOfficeSignText

RadioTower5FStudio1Sign:
	jumptext RadioTower5FStudio1SignText

RadioTower5FBookshelf:
	jumpstd MagazineBookshelfScript

FakeDirectorMovement:
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

RadioTower5FDirectorWalksIn:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	turn_head LEFT
	step_end

RadioTower5FDirectorWalksOut:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
RadioTower5FRocketImposterStepUp:
	step UP
	step_end

RadioTower5FPlayerTwoStepsLeftMovement:
	step LEFT
	step_end

RadioTower5FPlayerSkipsBattleMovement:
	step RIGHT
	step UP
	step_end

RadioTower5FPlayerStepsBackMovement:
	step LEFT
	turn_head RIGHT
	step_end

RadioTower5FFakeDirectorSpinsMovement:
	turn_head RIGHT
	step_sleep 1
	turn_head DOWN
	step_sleep 1
	turn_head LEFT
	step_sleep 1
	turn_head UP
	step_sleep 1
	step_end

FakeDirectorTextBefore1: 
if DEF(_FR_FR)
	text "T-toi! T-tu es là"
	line "pour me s-sauver?"
else
	text "Y-you! You came to"
	line "rescue me?"
endc

	done

FakeDirectorTextBefore2:
if DEF(_FR_FR)
	text "Alors..."
	line "Tu t'y attendais?"

	para "Et oui! Je suis"
	line "un imposteur!"
else
	text "Is that what you"
	line "were expecting?"

	para "Wrong!"
	line "I'm an imposter!"
endc
	done

FakeDirectorTextBefore3:
if DEF(_FR_FR)
	text "Cette mascarade"
	line "était nécessaire"

	para "à notre invasion!"
	line "Ha ha ha ha ha!"

	para "Veux-tu savoir où"
	line "est caché le vrai"
	cont "DIRECTEUR?"

	para "J'vais te le dire."
	line "Mais d'abord..."
	cont "COMBAT!!!!"
else
	text "I pretended to be"
	line "the real thing to"

	para "prepare for our"
	line "takeover."

	para "Do you want to"
	line "know where we hid"
	cont "the real DIRECTOR?"

	para "Sure, I'll tell"
	line "you. But only if"
	cont "you can beat me!"
endc
	done

FakeDirectorWinText: 
if DEF(_FR_FR)
	text "OK, OK. Je vais"
	line "parler."
else
	text "OK, OK. I'll tell"
	line "you where he is."
endc

	done

FakeDirectorTextAfter: 
if DEF(_FR_FR)
	text "On a planqué le"
	line "DIRECTEUR dans"

	para "l'ENTREPOT"
	line "SOUTERRAIN."

	para "C'est tout au bout"
	line "du SOUTERRAIN."

	para "Mais t'y arriveras"
	line "jamais... Ha!"
else
	text "We stashed the"
	line "real DIRECTOR in"

	para "the UNDERGROUND"
	line "WAREHOUSE."

	para "It's at the far"
	line "end of the UNDER-"
	cont "GROUND."

	para "But I doubt you'll"
	line "get that far."
endc

	done

Executivef1SeenText: 
if DEF(_FR_FR)
	text "Tu te souviens de"
	line "moi? Dans la"
	cont "PLANQUE d'ACAJOU?"

	para "J'avais perdu..."
	line "Mais cette fois..."
else
	text "Remember me from"
	line "the HIDEOUT in"
	cont "MAHOGANY TOWN?"

	para "I lost then, but I"
	line "won't this time."
endc

	done

Executivef1BeatenText: 
if DEF(_FR_FR)
	text "Mais c'est pas"
	line "possible!"

	para "J'me bats à fond"
	line "et je perds..."
else
	text "This can't be"
	line "happening!"

	para "I fought hard, but"
	line "I still lost…"
endc

	done

Executivef1AfterBattleText:
if DEF(_FR_FR)
	text "<PLAYER>,"
	line "c'est ça?"

	para "Une peste comme"
	line "toi ne voit pas"

	para "la grandeur de"
	line "notre noble cause."

	para "C'est dommage."
	line "Tu as pourtant du"
	cont "talent."
else
	text "<PLAYER>, isn't it?"

	para "A brat like you"
	line "won't appreciate"

	para "the magnificence"
	line "of our cause."

	para "That's too bad."
	line "I really admire"
	cont "your power."
endc
	done

RadioTower5FRocketBossBeforeText:
if DEF(_FR_FR)
	text "Oh? Tu es déjà"
	line "là?"

	para "Tu dois avoir un"
	line "sacré talent."

	para "Nous allons con-"
	line "trôler cette STA-"

	para "TION de RADIO pour"
	line "éveiller les"
	cont "esprits."

	para "La population est"
	line "lobotomisée par"
	cont "les émissions TV"
	cont "& la radio."

	para "C'est tout de la"
	line "propagande!"

	para "La TEAM ROCKET est"
	line "le contre-pouvoir"
	cont "que le peuple"
	cont "mérite."

	para "As-tu déjà vu un"
	line "#MON mourir du"
	cont "COVID? Moi jamais."

	para "Je n'ai jamais"
	line "porté de masque,"
	
	para "et pourtant je ne"
	line "suis jamais tombé"
	cont "malade. Comment"
	cont "tu l'expliques?"

	para "Et maintenant ils"
	line "annoncent qu'un"
	cont "vaccin sera prêt"
	cont "avant la fin de"
	cont "l'année."

	para "Jamais dans"
	line "l'histoire un"
	cont "vaccin n'a été"
	cont "trouvé si vite."

	para "Que vont-ils donc"
	line "injecter dans le"
	cont "corps des gens?"

	para "Rien de sûr et"
	line "bien testé, tu"
	cont "peux me croire."

	para "Mais bon sang!"
	line "Ouvre les yeux!"

	para "..."

	para "Est-ce que tu vois"
	line "la vérité dans"
	cont "mes arguments?"
else
	text "Oh? You managed to"
	line "get this far?"

	para "You must be quite"
	line "the trainer."

	para "We intend to take"
	line "over this RADIO"

	para "STATION to wake"
	line "people up."

	para "The population is"
	line "brainwashed by"
	cont "radio & TV shows."

	para "It is all"
	line "propaganda!"

	para "TEAM ROCKET is the"
	line "counter-power"
	cont "people deserve."

	para "Have you ever"
	line "seen a #MON"
	cont "die of COVID?"
	cont "I don't."

	para "I've never worn a"
	line "face mask myself,"

	para "yet I never got"
	line "sick. How do you"
	cont "explain it?"

	para "And now they are"
	line "announcing that a"
	
	para "vaccine will be"
	line "found before the"
	cont "end of the year."

	para "Never in history"
	line "had a vaccine be"
	cont "found so quickly."

	para "What are they"
	line "going to inject"

	para "into people's"
	line "bodies? Nothing"

	para "safe, I can tell"
	line "you that much."

	para "Come on! Think"
	line "for yourself!"

	para "…"

	para "Don't you see the"
	line "truth in my"
	cont "arguments?"
endc
	done

RadioTower5FRocketBossStartBattleText:
if DEF(_FR_FR)
	text "Alors je ne peux"
	line "pas te laisser"
	cont "interférer avec"
	cont "nos plans."
else
	text "Then I can't let"
	line "you to interfere"
	cont "with our plan."
endc
	done

RadioTower5FRocketBossSkipBattleText:
if DEF(_FR_FR)
	text "Alors pars."
	line "Laisse-moi réa-"
	cont "liser ma mission."

	para "Je vais ouvrir les"
	line "yeux du peuple"
	
	para "et lancer une"
	line "rébellion!"
else
	text "Then leave."
	line "Let me do what I"
	cont "came for."

	para "I will open"
	line "people's eyes"

	para "and start a"
	line "revolution!"
endc
	done

RadioTower5FRocketBossWinText:
if DEF(_FR_FR)
	text "Noooon! Pardonne-"
	line "moi, peuple de"
	cont "JOHTO!"
else
	text "Nooo! Forgive me,"
	line "JOHTO people!"
endc
	done

RadioTower5FRocketBossAfterText:
if DEF(_FR_FR)
	text "Comment ça a pu"
	line "se passer ainsi?"

	para "Notre cause a"
	line "échoué."

	para "Je n'ai pas été à"
	line "la hauteur."

	para "Comme GIOVANNI l'a"
	line "fait avant moi,"

	para "je vais dissoudre"
	line "la TEAM ROCKET,"

	para "pour qu'elle re-"
	line "naisse plus forte"
	cont "à l'avenir."

	para "Adieu."
else
	text "How could this be?"

	para "Our objective has"
	line "come to naught."

	para "I wasn't up to the"
	line "task after all."

	para "Like GIOVANNI did"
	line "before me, I will"
	
	para "put TEAM ROCKET"
	line "to sleep, so we"

	para "can come back"
	line "stronger later." 

	para "Farewell."
endc
	done

RadioTower5FDirectorThankYouText:
if DEF(_FR_FR)
	text "DIRECTEUR: <PLAY_G>,"
	line "merci!"

	para "Tes actions"
	line "courageuses ont"
	cont "sauvé d'innom-"
	cont "brables vies des"
	cont "idées démentes"
	cont "diffusées par la"
	cont "TEAM ROCKET."

	para "Ce n'est pas grand"
	line "chose, mais c'est"
	cont "pour toi."
else
	text "DIRECTOR: <PLAY_G>,"
	line "thank you!"

	para "Your courageous"
	line "actions will save"

	para "countless people"
	line "from the irra-"
	cont "tional ideas TEAM"
	cont "ROCKET spread."

	para "I know it's not"
	line "much, but please"
	cont "take this."
endc
	done

RadioTower5FDirectorDescribeClearBellText:
if DEF(_FR_FR)
	text "Il y avait une"
	line "tour ici à DOU-"
	cont "BLONVILLE."

	para "Mais elle était"
	line "en mauvais état."

	para "On l'a alors rem-"
	line "placée par notre"
	cont "TOUR RADIO."

	para "Pendant les tra-"
	line "vaux, nous avons"
	cont "trouvé ce glas."

	para "On dit qu'une"
	line "multitude de #-"

	para "MON différents vi-"
	line "vaient ici."

	para "Alors..."

	para "Ce glas a"
	line "peut-être un lien"

	para "avec la TOUR FER-"
	line "RAILLE de ROSALIA."
else
	text "There used to be a"
	line "tower right here"
	cont "in GOLDENROD CITY."

	para "But it was old and"
	line "creaky."

	para "So we replaced it"
	line "with our RADIO"
	cont "TOWER."

	para "We dug up that"
	line "bell during"
	cont "construction."

	para "I heard that all"
	line "sorts of #MON"

	para "lived in GOLDENROD"
	line "in the past."

	para "Perhaps…"

	para "That bell has some"
	line "connection to the"

	para "TIN TOWER in"
	line "ECRUTEAK CITY…"
endc
	done

RadioTower5FDirectorNotifiesAboutSuicuneText:
if DEF(_FR_FR)
	text "Ah!"

	para "Au fait..."

	para "J'ai entendu un"
	line "des types de la"
	cont "TEAM ROCKET."

	para "Apparemment, il se"
	line "passe des trucs à"
	cont "la TOUR FERRAILLE."

	para "A mon avis, tu"
	line "devrais y aller."
else
	text "Ah!"

	para "That reminds me…"

	para "I overheard TEAM"
	line "ROCKET whispering."

	para "Apparently, some-"
	line "thing is going on"
	cont "at the TIN TOWER."

	para "I have no idea"
	line "what is happening,"

	para "but you might look"
	line "into it."
endc
	done

RadioTower5FDirectorGetBackText:
if DEF(_FR_FR)
	text "OK, je retourne"
	line "au BUREAU."
else
	text "OK, I better go to"
	line "my OFFICE."
endc
	done

RadioTower5FDirectorText: 
if DEF(_FR_FR)
	text "DIRECTEUR: Salut,"
	line "<PLAY_G>!"

	para "Tu sais, j'adore"
	line "les #MON."

	para "J'ai construit"
	line "cette TOUR RADIO"

	para "pour crier au mon-"
	line "de mon amour."

	para "Mais les gens"
	line "aiment-ils nos"
	cont "émissions?"
else
	text "DIRECTOR: Hello,"
	line "<PLAY_G>!"

	para "You know, I love"
	line "#MON."

	para "I built this RADIO"
	line "TOWER so I could"

	para "express my love"
	line "of #MON."

	para "It would be nice"
	line "if people enjoyed"
	cont "our programs."
endc

	done

BenText: 
if DEF(_FR_FR)
	text "BEN: Tu écoutes"
	line "notre musique?"
else
	text "BEN: Do you listen"
	line "to our music?"
endc

	done

RadioTower5FDirectorsOfficeSignText: 
if DEF(_FR_FR)
	text "4EME BUREAU"
	line "     DIRECTION"
else
	text "5F DIRECTOR'S"
	line "   OFFICE"
endc

	done

RadioTower5FStudio1SignText: 
if DEF(_FR_FR)
	text "4EME STUDIO 1"
else
	text "5F STUDIO 1"
endc

	done

RadioTower5F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_4F, 1
	warp_event 12,  0, RADIO_TOWER_4F, 3

	def_coord_events
	coord_event  0,  4, CE_EVENT_FLAG_CLEARED, EVENT_BEAT_ROCKET_EXECUTIVEM_3, FakeDirectorScript
	coord_event 16,  5, CE_EVENT_FLAG_CLEARED, EVENT_TEAM_ROCKET_DISBANDED, RadioTower5FRocketBossScene

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower5FDirectorsOfficeSign
	bg_event 11,  0, BGEVENT_READ, RadioTower5FStudio1Sign
	bg_event 15,  0, BGEVENT_READ, RadioTower5FStudio1Sign
	bg_event 16,  1, BGEVENT_READ, RadioTower5FBookshelf
	bg_event 17,  1, BGEVENT_READ, RadioTower5FBookshelf

	def_object_events
	object_event  3,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Director, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 13,  5, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 17,  2, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerExecutivef1, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 13,  5, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Ben, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event  8,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RadioTower5FUltraBall, EVENT_RADIO_TOWER_5F_ULTRA_BALL
	object_event  5,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RadioTower5FBasementKey, EVENT_GOT_BASEMENT_KEY
	object_event  0,  6, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Director, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
