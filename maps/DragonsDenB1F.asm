	object_const_def
	const DRAGONSDENB1F_POKE_BALL1
	const DRAGONSDENB1F_CLAIR
	const DRAGONSDENB1F_SILVER
	const DRAGONSDENB1F_COOLTRAINER_M
	const DRAGONSDENB1F_COOLTRAINER_F
	const DRAGONSDENB1F_TWIN1
	const DRAGONSDENB1F_TWIN2
	const DRAGONSDENB1F_POKE_BALL2
	const DRAGONSDENB1F_POKE_BALL3
	const DRAGONSDENB1F_DRAGON_SHRINE_DOOR

DragonsDenB1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DRAGONSDENB1F_NOTHING
	scene_script .DummyScene1 ; SCENE_DRAGONSDENB1F_CLAIR_GIVES_TM

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.DummyScene0:
	end

.DummyScene1:
	end

.EnterCallback:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .CheckSilver

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3

.CheckSilver:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue .CheckDay
	disappear DRAGONSDENB1F_SILVER
	endcallback

.CheckDay:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .AppearSilver
	ifequal THURSDAY, .AppearSilver
	disappear DRAGONSDENB1F_SILVER
	endcallback

.AppearSilver:
	appear DRAGONSDENB1F_SILVER
	endcallback

DragonsDenB1F_ClairScene:
	appear DRAGONSDENB1F_CLAIR
	opentext
	writetext ClairText_Wait
	pause 30
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	playmusic MUSIC_CLAIR
	applymovement DRAGONSDENB1F_CLAIR, MovementDragonsDen_ClairWalksToYou
	opentext
	writetext ClairText_GiveDragonbreathDragonDen
	promptbutton
	verbosegiveitem TM_DRAGONBREATH
	waitsfx
	setevent EVENT_GOT_TM24_DRAGONBREATH
	writetext ClairText_DescribeDragonbreathDragonDen
	promptbutton
	farwritetext BlackthornGymClairText_League
	waitbutton
	closetext
	sjump .FinishClair

.FinishClair:
	applymovement DRAGONSDENB1F_CLAIR, MovementDragonsDen_ClairWalksAway
	special FadeOutMusic
	pause 30
	special RestartMapMusic
	disappear DRAGONSDENB1F_CLAIR
	setscene SCENE_DRAGONSDENB1F_NOTHING
	end

TrainerCooltrainermDarin:
	trainer COOLTRAINERM, DARIN, EVENT_BEAT_COOLTRAINERM_DARIN, CooltrainermDarinSeenText, CooltrainermDarinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainermDarinAfterBattleText

TrainerCooltrainerfCara:
	trainer COOLTRAINERF, CARA, EVENT_BEAT_COOLTRAINERF_CARA, CooltrainerfCaraSeenText, CooltrainerfCaraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerfCaraAfterBattleText

TrainerTwinsLeaandpia1:
	trainer TWINS, LEAANDPIA1, EVENT_BEAT_TWINS_LEA_AND_PIA, TwinsLeaandpia1SeenText, TwinsLeaandpia1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsLeaandpia1AfterBattleText

TrainerTwinsLeaandpia2:
	trainer TWINS, LEAANDPIA1, EVENT_BEAT_TWINS_LEA_AND_PIA, TwinsLeaandpia2SeenText, TwinsLeaandpia2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsLeaandpia2AfterBattleText

DragonsDenB1FDragonFang:
	itemball DRAGON_FANG

DragonsDenB1FSilverScript:
	playmusic MUSIC_RIVAL_ENCOUNTER
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .SilverTalkAgain
	writetext SilverText_Training1
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	special RestartMapMusic
	end

.SilverTalkAgain:
	writetext SilverText_Training2
	waitbutton
	closetext
	special RestartMapMusic
	end

DragonShrineSignpost:
	jumptext DragonShrineSignpostText

DragonsDenDoorScript:
	farjumptext GoldenrodUndergroundTheDoorsLockedText

DragonsDenB1FCalcium:
	itemball CALCIUM

DragonsDenB1FMaxElixer:
	itemball MAX_ELIXER

DragonsDenB1FHiddenRevive:
	hiddenitem REVIVE, EVENT_DRAGONS_DEN_B1F_HIDDEN_REVIVE

DragonsDenB1FHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_POTION

DragonsDenB1FHiddenMaxElixer:
	hiddenitem MAX_ELIXER, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXER

MovementDragonsDen_ClairWalksToYou:
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	step_end

MovementDragonsDen_ClairWalksAway:
	slow_step LEFT
	slow_step LEFT
	slow_step LEFT
	step_end

ClairText_Wait: 
if DEF(_FR_FR)
	text "Attends!"
else
	text "Wait!"
endc

	done

ClairText_GiveDragonbreathDragonDen: 
if DEF(_FR_FR)
	text "SANDRA: Excuse-moi"
	line "pour tout."

	para "Tiens. Pour me"
	line "faire pardonner."
else
	text "CLAIR: I'm sorry"
	line "about this."

	para "Here, take this as"
	line "my apology."
endc

	done

ClairText_DescribeDragonbreathDragonDen:
if DEF(_FR_FR)
	text "Ca contient"
	line "DRACOSOUFFLE."
	
	para "Non, ça n'a"
	line "rien à voir avec"
	cont "mon haleine."
	
	para "On respecte"
	line "la distanciation"
	cont "et on porte"
	cont "tous les deux"
	cont "un masque."
	
	para "Tu ne peux pas"
	line "pas la sentir..."
	cont "n'est-ce pas?"
	
	para "Ecoute, si tu ne"
	line "veux pas cette"
	cont "CT, tu n'as qu'à"
	cont "me la laisser."
else
	text "That contains"
	line "DRAGONBREATH."

	para "No, it doesn't"
	line "have anything to"
	cont "do with my breath."

	para "We're keeping"
	line "social distance"
	cont "and we're both"
	cont "wearing a face"
	cont "mask anyway."
	
	para "It's not like you"
	line "can smell it…"
	cont "right?"

	para "Look, if you don't"
	line "want the TM, you"
	cont "don't have to take"
	cont "it."
endc
	done

DragonShrineSignpostText: 
if DEF(_FR_FR)
	text "AUTEL DRAGON"

	para "En l'honneur des"
	line "#MON dragons"
	cont "ayant vécu dans"
	cont "l'ANTRE du DRAGON."
else
	text "DRAGON SHRINE"

	para "A shrine honoring"
	line "the dragon #MON"

	para "said to have lived"
	line "in DRAGON'S DEN."
endc

	done

SilverText_Training1: 
if DEF(_FR_FR)
	text "......"
	line "Quoi? <PLAYER>?"

	para "...Non, je ne me"
	line "battrai pas avec"
	cont "toi maintenant..."

	para "Mes #MON ne"
	line "sont pas prêts."

	para "Et je ne veux pas"
	line "les pousser."

	para "Je dois être sage"
	line "pour devenir un"

	para "jour le plus grand"
	line "des dresseurs..."
else
	text "…"
	line "What? <PLAYER>?"

	para "…No, I won't"
	line "battle you now…"

	para "My #MON aren't"
	line "ready to beat you."

	para "I can't push them"
	line "too hard now."

	para "I have to be dis-"
	line "ciplined to become"

	para "the greatest #-"
	line "MON trainer…"
endc

	done

SilverText_Training2:
if DEF(_FR_FR)
	text "..."
	
	para "Fiou..."
	
	para "Apprends à ne pas"
	line "te mettre en face"
	cont "de mon chemin..."
	
	para "On se verra au"
	line "PLATEAU INDIGO"
	
	para "les lundi ou"
	line "mercredi."
else
	text "…"

	para "Whew…"

	para "Learn to stay out"
	line "of my way…"

	para "We'll meet at"
	line "INDIGO PLATEAU"
	
	para "on Monday or"
	line "Wednesday."
endc
	done

CooltrainermDarinSeenText: 
if DEF(_FR_FR)
	text "Toi! On ne veut"
	line "pas de toi ici!"
else
	text "You! How dare you"
	line "enter uninvited!"
endc

	done

CooltrainermDarinBeatenText: 
if DEF(_FR_FR)
	text "Quelle puissance!"
else
	text "S-strong!"
endc

	done

CooltrainermDarinAfterBattleText: 
if DEF(_FR_FR)
	text "Le TEMPLE est la"
	line "demeure de notre"

	para "MAITRE, chef du"
	line "clan des dragons."

	para "Tu n'as pas le"
	line "droit d'entrer!"
else
	text "The SHRINE ahead"
	line "is home to the"

	para "MASTER of our"
	line "dragon-user clan."

	para "You're not allowed"
	line "to just go in!"
endc

	done

CooltrainerfCaraSeenText: 
if DEF(_FR_FR)
	text "Tu ne dois pas"
	line "être ici!"
else
	text "You shouldn't be"
	line "in here!"
endc

	done

CooltrainerfCaraBeatenText: 
if DEF(_FR_FR)
	text "Oups!"
else
	text "Oh yikes, I lost!"
endc

	done

CooltrainerfCaraAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais bientôt"
	line "avoir l'accord du"

	para "MAITRE pour utili-"
	line "ser des dragons."

	para "Et alors, je pour-"
	line "rai rendre mon"

	para "MAITRE fier en"
	line "devenant un grand"

	para "dresseur."
else
	text "Soon I'm going to"
	line "get permission"

	para "from our MASTER to"
	line "use dragons."

	para "When I do, I'm"
	line "going to become an"

	para "admirable dragon"
	line "trainer and gain"

	para "our MASTER's"
	line "approval."
endc

	done

TwinsLeaandpia1SeenText: 
if DEF(_FR_FR)
	text "C'est un étranger"
	line "que l'on ne"
	cont "connaît pas."
else
	text "It's a stranger we"
	line "don't know."
endc

	done

TwinsLeaandpia1BeatenText: 
if DEF(_FR_FR)
	text "Ouille."
else
	text "Ouchies."
endc

	done

TwinsLeaandpia1AfterBattleText: 
if DEF(_FR_FR)
	text "C'est comme com-"
	line "battre PETER."
else
	text "It was like having"
	line "to battle LANCE."
endc

	done

TwinsLeaandpia2SeenText: 
if DEF(_FR_FR)
	text "Qui es-tu?"
else
	text "Who are you?"
endc

	done

TwinsLeaandpia2BeatenText: 
if DEF(_FR_FR)
	text "Pas sympa."
else
	text "Meanie."
endc

	done

TwinsLeaandpia2AfterBattleText: 
if DEF(_FR_FR)
	text "On va le dire."

	para "Le MAITRE ne sera"
	line "pas content."
else
	text "We'll tell on you."

	para "MASTER will be"
	line "angry with you."
endc

	done

DragonsDenB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 20,  3, DRAGONS_DEN_1F, 3
	warp_event 19, 29, DRAGON_SHRINE, 1

	def_coord_events
	coord_event 19, 30, CE_SCENE_ID, SCENE_DRAGONSDENB1F_CLAIR_GIVES_TM, DragonsDenB1F_ClairScene

	def_bg_events
	bg_event 18, 24, BGEVENT_READ, DragonShrineSignpost
	bg_event 33, 29, BGEVENT_ITEM, DragonsDenB1FHiddenRevive
	bg_event 21, 17, BGEVENT_ITEM, DragonsDenB1FHiddenMaxPotion
	bg_event 31, 15, BGEVENT_ITEM, DragonsDenB1FHiddenMaxElixer

	def_object_events
	object_event 35, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DragonsDenB1FDragonFang, EVENT_DRAGONS_DEN_B1F_DRAGON_FANG
	object_event 14, 30, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGONS_DEN_CLAIR
	object_event 20, 23, SPRITE_SILVER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonsDenB1FSilverScript, EVENT_RIVAL_DRAGONS_DEN
	object_event 20,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainermDarin, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  8,  8, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfCara, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  4, 17, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsLeaandpia1, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  4, 18, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsLeaandpia2, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 30,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DragonsDenB1FCalcium, EVENT_DRAGONS_DEN_B1F_CALCIUM
	object_event  5, 20, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DragonsDenB1FMaxElixer, EVENT_DRAGONS_DEN_B1F_MAX_ELIXER
	object_event 19, 29, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonsDenDoorScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
