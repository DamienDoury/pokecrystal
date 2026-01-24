	object_const_def
	const MAHOGANYGYM_PRYCE
	const MAHOGANYGYM_BEAUTY1
	const MAHOGANYGYM_ROCKER1
	const MAHOGANYGYM_BEAUTY2
	const MAHOGANYGYM_ROCKER2
	const MAHOGANYGYM_ROCKER3
	const MAHOGANYGYM_GYM_GUIDE

MahoganyGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.TeamCheck:
	checkevent EVENT_BEAT_PRYCE
	iftrue .no_check

	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall MahoganyGymCheckForbiddenTypes
	iffalse .enter_check

	callstd GymKickPlayerOutAfterEvolution
	sjump .player_leaves

.enter_check
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .no_check
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	setval EGG
	special FindPartyMonThatSpecies
	iftrue .egg_found

	scall MahoganyGymCheckForbiddenTypes
	iftrue .do_check
	end

.egg_found
	setlasttalked MAHOGANYGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves
.do_check
	setlasttalked MAHOGANYGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp MAHOGANY_TOWN, 6, 13
.no_check
	end

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	endcallback

MahoganyGymCheckForbiddenTypes:
	setval STEEL
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval FIRE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval FIGHTING
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval ROCK
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

MahoganyGymPryceScript:
	faceplayer
	showemote EMOTE_SLEEP, MAHOGANYGYM_PRYCE, 60
	opentext
	writetext PryceSleepingText
	promptbutton
	checkevent EVENT_BEAT_PRYCE
	iftrue PryceScript_Defeat
	
	checkevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
	iftrue .PowerRestrainerExplained
	closetext
	showemote EMOTE_QUESTION, MAHOGANYGYM_PRYCE, 20
	opentext
	writetext MahoganyGymPowerRestrainerExplanation
	promptbutton
	setevent EVENT_GYM_POWER_RESTRAINER_EXPLAINED
.PowerRestrainerExplained

	writetext PryceText_Intro
	waitbutton
	closetext
	winlosstext PryceText_Impressed, 0
	loadtrainer PRYCE, PRYCE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PRYCE
	opentext
	writetext Text_ReceivedGlacierBadge
	playsound SFX_GET_BADGE
	waitsfx
	farscall IncMonthAndTryTriggeringCurfew
	setflag ENGINE_GLACIERBADGE
	setevent EVENT_BEAT_SKIER_ROXANNE
	setevent EVENT_BEAT_SKIER_CLARISSA
	setevent EVENT_BEAT_BOARDER_RONALD
	setevent EVENT_BEAT_BOARDER_BRAD
	setevent EVENT_BEAT_BOARDER_DOUGLAS
	writetext PryceText_GlacierBadgeSpeech
	promptbutton
	farscall NewBadgeObedienceNotification
	writetext PryceText_GlacierBadgeSpeech2
	promptbutton
	verbosegiveitem TM_ICY_WIND
	writetext PryceText_IcyWindSpeech
	waitbutton
	closetext
	end

PryceScript_Defeat:
	writetext PryceText_CherishYourPokemon
	waitbutton
	closetext
	end

TrainerSkierRoxanne:
	trainer SKIER, ROXANNE, EVENT_BEAT_SKIER_ROXANNE, SkierRoxanneSeenText, SkierRoxanneBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SkierRoxanneAfterBattleText

TrainerSkierClarissa:
	trainer SKIER, CLARISSA, EVENT_BEAT_SKIER_CLARISSA, SkierClarissaSeenText, SkierClarissaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SkierClarissaAfterBattleText

TrainerBoarderRonald:
	trainer BOARDER, RONALD, EVENT_BEAT_BOARDER_RONALD, BoarderRonaldSeenText, BoarderRonaldBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BoarderRonaldAfterBattleText

TrainerBoarderBrad:
	trainer BOARDER, BRAD, EVENT_BEAT_BOARDER_BRAD, BoarderBradSeenText, BoarderBradBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BoarderBradAfterBattleText

TrainerBoarderDouglas:
	trainer BOARDER, DOUGLAS, EVENT_BEAT_BOARDER_DOUGLAS, BoarderDouglasSeenText, BoarderDouglasBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BoarderDouglasAfterBattleText

MahoganyGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_PRYCE
	iftrue .MahoganyGymGuideWinScript
	writetext MahoganyGymGuideText
	waitbutton
	closetext
	end

.MahoganyGymGuideWinScript:
	writetext MahoganyGymGuideWinText
	waitbutton
	closetext
	end

MahoganyGymStatue:
	checkflag ENGINE_GLACIERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, PRYCE, PRYCE1
	jumpstd GymStatue2Script

PryceSleepingText:
if DEF(_FR_FR)
	text "..."

	para "Hein? Quoi?"

	para "Non, j'dors pas..."
	line "..."
else
	text "…"

	para "Uh?"

	para "I'm awake…"
	line "…"
endc
	done

PryceText_Intro:
if DEF(_FR_FR)
	text "Les #MON ont"
	line "beaucoup d'aven-"

	para "tures au cours de"
	line "leur vie, comme"
	cont "nous."

	para "Moi aussi, j'ai"
	line "beaucoup souffert"
	cont "dans ma vie."

	para "J'ai affronté de"
	line "nombreux hivers,"

	para "bien avant ta"
	line "naissance."

	para "ACAJOU se situe à"
	line "haute altitude, où"
	cont "les hivers sont"
	cont "rudes."

	para "Cette ARENE dis-"
	line "pose de puissants"
	cont "canons à neige"

	para "qui répliquent"
	line "la brutalité de"
	cont "la saison froide."

	para "Les faibles ne"
	line "tiendront pas plus"
	cont "de quelques secon-"
	cont "des dans ces"
	cont "conditions."

	para "Comme je suis plus"
	line "vieux que toi,"
	cont "laisse-moi te"
	cont "montrer de quoi je"
	cont "parle..."

	para "Moi, FREDO, le"
	line "dresseur du froid,"

	para "je vais te montrer"
	line "ma puissance!"
else
	text "#MON have many"
	line "experiences in"

	para "their lives, just "
	line "like we do. "

	para "I, too, have seen"
	line "and suffered much"
	cont "in my life."

	para "I have fought"
	line "through many win-"
	cont "ters, long before"
	cont "you were born."

	para "MAHOGANY TOWN"
	line "stands at a high"
	cont "altitude where"
	cont "winters are harsh."

	para "This GYM incor-"
	line "porates powerful"
	cont "snow cannons to"
	
	para "replicate the"
	line "roughness of the"
	cont "cold season."

	para "The weak won't"
	line "last more than"
	cont "a few seconds in"
	cont "these conditions."

	para "Since I am your"
	line "elder, let me show"
	cont "you what I mean."

	para "I, PRYCE--the"
	line "ICE master--"

	para "shall demonstrate"
	line "my power!"
endc
	done

MahoganyGymPowerRestrainerExplanation:
	text_far _GymPowerRestrainerFirstExplanation
	text_end

PryceText_Impressed: 
if DEF(_FR_FR)
	text "Ah, je suis très"
	line "impressionné par"
	cont "ta prouesse."

	para "Avec un tempé-"
	line "rament comme le"

	para "tien, tu surmon-"
	line "teras tous les"
	cont "obstacles de la"
	cont "vie."

	para "Tu mérites ce"
	line "BADGE!"
else
	text "Ah, I am impressed"
	line "by your prowess."

	para "With your strong"
	line "will, I know you"

	para "will overcome all"
	line "life's obstacles."

	para "You are worthy of"
	line "this BADGE!"
endc

	done

Text_ReceivedGlacierBadge: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGEGLACIER."
else
	text "<PLAYER> received"
	line "GLACIERBADGE."
endc

	done

PryceText_GlacierBadgeSpeech:
if DEF(_FR_FR)
	text "Félicitations"
	line "p'tit bout!"
else
	text "Congratulations"
	line "lil'one!"
endc
	done

PryceText_GlacierBadgeSpeech2:
if DEF(_FR_FR)
	text "Et ça... C'est un"
	line "cadeau de ma part!"
else
	text "And this… This is"
	line "a gift from me!"
endc
	done

PryceText_IcyWindSpeech: 
if DEF(_FR_FR)
	text "Cette CT contient"
	line "VENT GLACE."

	para "Il inflige des"
	line "dégâts et réduit"
	cont "la vitesse des"
	cont "#MON."

	para "Il incarne la"
	line "rudesse du froid"
	cont "hivernal."
else
	text "That TM contains"
	line "ICY WIND."

	para "It inflicts damage"
	line "and lowers speed."

	para "It demonstrates"
	line "the harshness of"
	cont "winter."
endc

	done

PryceText_CherishYourPokemon: 
if DEF(_FR_FR)
	text "Lorsque la glace"
	line "et la neige"
	cont "fondent, le"
	cont "printemps arrive."

	para "Toi et tes #-"
	line "MON serez ensemble"
	cont "pendant des"
	cont "années."

	para "Profitez bien de"
	line "ces instants!"
else
	text "When the ice and"
	line "snow melt, spring"
	cont "arrives."

	para "You and your #-"
	line "MON will be to-"

	para "gether for many"
	line "years to come."

	para "Cherish your time"
	line "together!"
endc

	done

BoarderRonaldSeenText: 
if DEF(_FR_FR)
	text "Je vais geler tes"
	line "#MON et tu ne"
	cont "pourras plus rien"
	cont "faire!"
else
	text "I'll freeze your"
	line "#MON, so you"
	cont "can't do a thing!"
endc

	done

BoarderRonaldBeatenText: 
if DEF(_FR_FR)
	text "Saperlipopette!"
	line "Je n'ai rien pu"
	cont "faire."
else
	text "Darn. I couldn't"
	line "do a thing."
endc

	done

BoarderRonaldAfterBattleText: 
if DEF(_FR_FR)
	text "Je crois qu'il"
	line "existe une capa-"

	para "cité que les #-"
	line "MON peuvent utili-"
	cont "ser même en étant"
	cont "gelés."
else
	text "I think there's a"
	line "move a #MON"

	para "can use while it's"
	line "frozen."
endc

	done

BoarderBradSeenText: 
if DEF(_FR_FR)
	text "Cette ARENE a le"
	line "sol glissant."

	para "C'est délire, pas"
	line "vrai?"

	para "Mais..."
	line "Fini de jouer!"
else
	text "This GYM has a"
	line "slippery floor."

	para "It's fun, isn't"
	line "it?"

	para "But hey--we're"
	line "not playing games"
	cont "here!"
endc

	done

BoarderBradBeatenText: 
if DEF(_FR_FR)
	text "Tu vois à quel"
	line "point on est"
	cont "sérieux ici?"
else
	text "Do you see how"
	line "serious we are?"
endc

	done

BoarderBradAfterBattleText: 
if DEF(_FR_FR)
	text "Cette ARENE est"
	line "superbe. J'adore"
	cont "surfer avec mes"
	cont "#MON!"
else
	text "This GYM is great."
	line "I love boarding"
	cont "with my #MON!"
endc

	done

BoarderDouglasSeenText: 
if DEF(_FR_FR)
	text "Je connais le"
	line "secret de FREDO."
else
	text "I know PRYCE's"
	line "secret."
endc

	done

BoarderDouglasBeatenText: 
if DEF(_FR_FR)
	text "OK. Je vais te"
	line "le dire."
else
	text "OK. I'll tell you"
	line "PRYCE's secret."
endc

	done

BoarderDouglasAfterBattleText: 
if DEF(_FR_FR)
	text "Le secret de la"
	line "force de FREDO..."

	para "Il médite"
	line "derrière une"

	para "cascade tous les"
	line "jours pour accroî-"
	cont "tre sa force et"
	cont "développer son"
	cont "esprit."
else
	text "The secret behind"
	line "PRYCE's power…"

	para "He meditates under"
	line "a waterfall daily"

	para "to strengthen his"
	line "mind and body."
endc

	done

SkierRoxanneSeenText: 
if DEF(_FR_FR)
	text "Pour vaincre"
	line "FREDO, notre"

	para "CHAMPION d'ARENE,"
	line "tu dois penser"
	cont "avant de patiner."
else
	text "To get to PRYCE,"
	line "our GYM LEADER,"

	para "you need to think"
	line "before you skate."
endc

	done

SkierRoxanneBeatenText: 
if DEF(_FR_FR)
	text "Enfin, moi j'te"
	line "bats en ski!"
else
	text "I wouldn't lose to"
	line "you in skiing!"
endc

	done

SkierRoxanneAfterBattleText: 
if DEF(_FR_FR)
	text "Si tu ne patines"
	line "pas avec précision"

	para "tu n'iras pas bien"
	line "loin dans cette"
	cont "ARENE."
else
	text "If you don't skate"
	line "with precision,"

	para "you won't get far"
	line "in this GYM."
endc

	done

SkierClarissaSeenText: 
if DEF(_FR_FR)
	text "Sors de mon"
	line "slalom!"
else
	text "Check out my"
	line "parallel turn!"
endc

	done

SkierClarissaBeatenText: 
if DEF(_FR_FR)
	text "Non! Tu m'as fait"
	line "déraper!"
else
	text "No! You made me"
	line "wipe out!"
endc

	done

SkierClarissaAfterBattleText: 
if DEF(_FR_FR)
	text "Je n'aurais pas"
	line "dû me vanter..."
else
	text "I shouldn't have"
	line "been bragging"
	cont "about my skiing…"
endc

	done

MahoganyGymGuideText: 
if DEF(_FR_FR)
	text "FREDO est un vété-"
	line "ran qui entraîne"

	para "des #MON depuis"
	line "50 ans."

	para "Il prétend être"
	line "bon pour geler ses"

	para "adversaires avec"
	line "des attaques de"
	cont "glace."

	para "Tu devrais le"
	line "faire fondre avec"

	para "ton ambition"
	line "brûlante!"
else
	text "PRYCE is a veteran"
	line "who has trained"

	para "#MON for some"
	line "50 years."

	para "He's said to be"
	line "good at freezing"

	para "opponents with"
	line "ice-type moves."

	para "That means you"
	line "should melt him"

	para "with your burning"
	line "ambition!"
endc

	done

MahoganyGymGuideWinText: 
if DEF(_FR_FR)
	text "FREDO, c'est quel-"
	line "qu'un, mais toi"
	cont "t'es pas naze"
	cont "non plus!"

	para "C'était un combat"
	line "chaud qui a soudé"

	para "l'écart entre deux"
	line "générations!"
else
	text "PRYCE is some-"
	line "thing, but you're"
	cont "something else!"

	para "That was a hot"
	line "battle that"

	para "bridged the gen-"
	line "eration gap!"
endc

	done

MahoganyGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, MAHOGANY_TOWN, 3
	warp_event  5, 17, MAHOGANY_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, MahoganyGymStatue
	bg_event  6, 15, BGEVENT_READ, MahoganyGymStatue

	def_object_events
	object_event  5,  3, SPRITE_PRYCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MahoganyGymPryceScript, -1
	object_event  4,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerSkierRoxanne, -1
	object_event  0, 17, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBoarderRonald, -1
	object_event  9, 17, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerSkierClarissa, -1
	object_event  5,  8, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBoarderBrad, -1
	object_event  7,  9, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBoarderDouglas, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MahoganyGymGuideScript, -1
