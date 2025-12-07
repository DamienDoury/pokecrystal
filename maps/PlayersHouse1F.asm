	object_const_def
	const PLAYERSHOUSE1F_MOM1
	const PLAYERSHOUSE1F_MOM2
	const PLAYERSHOUSE1F_MOM3
	const PLAYERSHOUSE1F_MOM4
	const PLAYERSHOUSE1F_POKEFAN_F
	const PLAYERSHOUSE1F_WALL

PlayersHouse1F_MapScripts:
	def_scene_scripts

	def_callbacks

MeetMomLeftScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

MeetMomRightScript:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYER, LEFT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .OnRight
	applymovement PLAYERSHOUSE1F_MOM1, MomTurnsTowardPlayerMovement
	sjump MeetMomScript

.OnRight:
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksToPlayerMovement
MeetMomScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	opentext
	writetext ElmsLookingForYouText
	promptbutton
	getstring STRING_BUFFER_4, PokegearName
	scall PlayersHouse1FReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext MomGivesPokegearText
	promptbutton
	special SetDayOfWeek
.SetDayOfWeek:
	writetext IsItDSTText
	yesorno
	iffalse .WrongDay
	special InitialSetDSTFlag
	yesorno
	iffalse .SetDayOfWeek
	sjump .DayOfWeekDone

.WrongDay:
	special InitialClearDSTFlag
	yesorno
	iffalse .SetDayOfWeek
.DayOfWeekDone:
	writetext ComeHomeForDSTText
	yesorno
	iffalse .ExplainPhone
	sjump .KnowPhone

.KnowPhone:
	writetext KnowTheInstructionsText
	promptbutton
	sjump .FinishPhoneForReal

.ExplainPhone:
	writetext DontKnowTheInstructionsText
	promptbutton
	sjump .FinishPhone

.FinishPhone:
	writetext InstructionsNextText
	promptbutton
.FinishPhoneForReal:
	writetext CovidIntroText
	waitbutton
	closetext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .FromRight
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iffalse .FromLeft
	sjump .Finish

.FromRight:
	applymovement PLAYERSHOUSE1F_MOM1, MomTurnsBackMovement
	sjump .Finish

.FromLeft:
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksBackMovement
	sjump .Finish

.Finish:
	special RestartMapMusic
	turnobject PLAYERSHOUSE1F_MOM1, LEFT
	end

MeetMomTalkedScript:
	playmusic MUSIC_MOM
	sjump MeetMomScript

PokegearName: 
if DEF(_FR_FR)
	db "#MATOS@"

else
	db "#GEAR@"

endc

PlayersHouse1FReceiveItemStd:
	jumpstd ReceiveItemScript

FakeMomMornScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; If the player has never ever left the house (new game).
	iftrue .quit
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .quit
	checktime MORN
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM2
	sjump FakeMomScript
.quit:
	opentext
	writetext SmellText
	promptbutton
	closetext
	end

FakeMomDayScript:
	checkevent EVENT_PLAYERS_HOUSE_MOM_1 ; If the player has never ever talked to Mom (new game).
	iffalse .meet
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; If the player has never ever left the house (new game).
	iftrue .firstMom
	checktime DAY
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM3
	sjump FakeMomScript
.firstMom:
	setlasttalked PLAYERSHOUSE1F_MOM1
	sjump FakeMomScript
.meet
	setlasttalked PLAYERSHOUSE1F_MOM1
	sjump MomScript
.quit:
	opentext
	writetext MomsSeatText
	promptbutton
	closetext
	end

FakeMomNiteScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; If the player has never ever left the house (new game).
	iftrue .quit
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .quit
	checktime NITE
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM4
	sjump FakeMomScript
.quit:
	opentext
	writetext SmellText
	promptbutton
	closetext
	end

FakeMomScript:
	showemote EMOTE_QUESTION, LAST_TALKED, 15
	faceplayer
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	readvar VAR_FACING
	ifequal DOWN, .down
	ifequal UP, .up
	ifequal LEFT, .left
	ifequal RIGHT, .right
	end

.left:
	applymovement PLAYER, RightBackStepMovement
	sjump .congrats

.right:
	applymovement PLAYER, LeftBackStepMovement
	sjump .congrats

.up:
	applymovement PLAYER, DownBackStepMovement
	sjump .congrats

.down:
	applymovement PLAYER, UpBackStepMovement
	sjump .congrats

.congrats:
	showemote EMOTE_HAPPY, LAST_TALKED, 20
	opentext 
	writetext NowWeCanTalkText
	waitbutton
	closetext
	pause 5
	sjump MomScript

RightBackStepMovement:
	fix_facing
	step RIGHT
	remove_fixed_facing
	step_end

LeftBackStepMovement:
	fix_facing
	step LEFT
	remove_fixed_facing
	step_end

DownBackStepMovement:
	fix_facing
	step DOWN
	remove_fixed_facing
	step_end

UpBackStepMovement:
	fix_facing
	step UP
	remove_fixed_facing
	step_end

FakeNeighborScript:
	checkevent EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
	iftrue .quit
	setlasttalked PLAYERSHOUSE1F_POKEFAN_F
	sjump NeighborScript
.quit:
	opentext
	writetext PlayerSeatText
	promptbutton
	closetext
	readvar VAR_FACING
	ifequal DOWN, .down
	ifequal UP, .up
	ifequal LEFT, .left
	ifequal RIGHT, .right
	end

.left:
	applymovement PLAYER, LeftStepMovement
	sjump .watch_tv

.right:
	applymovement PLAYER, RightStepMovement
	sjump .watch_tv

.up:
	applymovement PLAYER, UpStepMovement
	sjump .watch_tv

.down:
	applymovement PLAYER, DownStepMovement
	sjump .watch_tv

.watch_tv:
	jumpstd TVScript

RightStepMovement:
	step RIGHT
	turn_head UP
	step_end

LeftStepMovement:
	step LEFT
	turn_head UP
	step_end

DownStepMovement:
	step DOWN
	turn_head UP
	step_end

UpStepMovement:
	step UP
	step_end

WallScript:
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	end

MomScript:
	faceplayer
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse MeetMomTalkedScript
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .FirstTimeBanking
	checkevent EVENT_LOCKDOWN_MART_RUSH
	iffalse .MartRush
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .GaveMysteryEgg
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .GotAPokemon
	writetext HurryUpElmIsWaitingText
	sjump .CloseText

.MartRush:
	writetext SecondEndText
	waitbutton
	closetext

	pause 90

	opentext
	writetext SecondEndSequelText
	waitbutton
	closetext
	pause 60
	turnobject PLAYER, DOWN
	pause 20
	musicfadeout MUSIC_NONE, 16
	pause 150

	special FadeOutPalettes
	callasm ClearBGPalettes
	callasm ResetBGPals
	callasm ApplyPals
	callasm ClearSprites
	callasm ClearScreen
	callasm WipeAttrmap
	pause 25
	loadmem wCreditsType, CREDITS_LAB
	credits

.GotAPokemon:
	writetext SoWhatWasProfElmsErrandText
	sjump .CloseText

.FirstTimeBanking:
	writetext ImBehindYouText
	sjump .CloseText

.GaveMysteryEgg:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	;setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special BankOfMom
.CloseText
	waitbutton
	closetext
	end

NeighborScript:
	faceplayer
	opentext
	checktime MORN
	iftrue .MornScript
	checktime DAY
	iftrue .DayScript
	checktime NITE
	iftrue .NiteScript

.MornScript:
	writetext NeighborMornIntroText
	promptbutton
	sjump .Main

.DayScript:
	writetext NeighborDayIntroText
	promptbutton
	sjump .Main

.NiteScript:
	writetext NeighborNiteIntroText
	promptbutton
	sjump .Main

.Main:
	writetext NeighborText
	waitbutton
	closetext
	end

PlayersHouse1FStoveScript:
	jumptext PlayersHouse1FStoveText

PlayersHouse1FSinkScript:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	callasm SetAllDecorationFlags
endc
	jumptext PlayersHouse1FSinkText

PlayersHouse1FFridgeScript:
	checkflag ENGINE_TOOK_DRINK_FROM_FRIDGE
	iftrue .AlreadyTookDrinkToday
	checkitem HM_FLASH
	iffalse .DrinksOnTheHouse
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .EmptyFridge
	checkmoney MOMS_MONEY, 150
	ifequal HAVE_LESS, .EmptyFridge
.DrinksOnTheHouse:
	opentext
	writetext PlayersHouse1FFridgeText
	yesorno
	iftrue .TakeFreshWater
	writetext AskLemonadeFridgeText
	yesorno
	iftrue .TakeLemonade
	closetext
	end

.EmptyFridge:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	jumptext EmptyFridgeText

.TakeFreshWater:
	checkitem HM_FLASH
	iffalse .FridgeFreeFreshWater
	takemoney MOMS_MONEY, 50
.FridgeFreeFreshWater:
	setflag ENGINE_TOOK_DRINK_FROM_FRIDGE
	verbosegiveitem FRESH_WATER
	closetext
	end

.TakeLemonade:
	checkitem HM_FLASH
	iffalse .FridgeFreeLemonade
	takemoney MOMS_MONEY, 150
.FridgeFreeLemonade:
	setflag ENGINE_TOOK_DRINK_FROM_FRIDGE
	verbosegiveitem LEMONADE
	closetext
	end

.AlreadyTookDrinkToday:
	jumptext OtherDrinkIsForMomText

MomTurnsTowardPlayerMovement:
	turn_head RIGHT
	step_end

MomWalksToPlayerMovement:
	slow_step RIGHT
	step_end

MomTurnsBackMovement:
	turn_head LEFT
	step_end

MomWalksBackMovement:
	slow_step LEFT
	step_end

SmellText:
if DEF(_FR_FR)
	text "Ca sent bon!"
	
	para "Maman est bonne"
	line "cuisinière!"
else
	text "Smells good!"
	line "Mom's a good cook!"
endc
	done

PlayerSeatText:
if DEF(_FR_FR)
	text "C'est ma place"
	line "à table."

	para "Elle a la meilleu-"
	line "re vue sur la"
	cont "télé!"
else
	text "This is my seat"
	line "at the table."

	para "It has the best"
	line "view on the TV!"
endc
	done

MomsSeatText:
if DEF(_FR_FR)
	text "La chaise de Maman"
	line "a de jolis"
	cont "coussins."
else
	text "Mom's seat has"
	line "lovely cushions."
endc
	done

SocialDistancingText:
if DEF(_FR_FR)
	text "<PLAYER>, n'oublie"
	line "pas de garder 1"
	cont "pas de distance"
	cont "sociale."
else
	text "<PLAYER>, remember"
	line "to keep 1 step of"
	cont "social distancing."
endc
	done

ElmsLookingForYouText: 
if DEF(_FR_FR)
	text "Ah, <PLAYER>...!"
	line "Notre voisin, le"

	para "PROF.ORME, te"
	line "cherchait."

	para "Il voulait que"
	line "tu fasses quelque"
	cont "chose pour lui."

	para "Oh! J'allais"
	line "oublier! Ton"

	para "MATOS #MON est"
	line "revenu de chez le"
	cont "réparateur."

	para "Tiens!"
else
	text "Oh, <PLAYER>…! Our"
	line "neighbor, PROF."

	para "ELM, was looking"
	line "for you."

	para "He said he wanted"
	line "you to do some-"
	cont "thing for him."

	para "Oh! I almost for-"
	line "got! Your #MON"

	para "GEAR is back from"
	line "the repair shop."

	para "Here you go!"
endc

	done

MomGivesPokegearText: 
if DEF(_FR_FR)
	text "Le MATOS #MON,"
	line "ou simplement"
	cont "#MATOS..."

	para "...est primordial"
	line "si tu veux devenir"
	cont "dresseur."

	para "Oh! Le jour de la"
	line "semaine n'est pas"
	cont "paramétré."

	para "N'oublie pas ça!"
else
	text "#MON GEAR, or"
	line "just #GEAR."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
endc

	done

IsItDSTText: 
if DEF(_FR_FR)
	text "On est à l'heure"
	line "d'été?"
else
	text "Is it Daylight"
	line "Saving Time now?"
endc

	done

ComeHomeForDSTText: 
if DEF(_FR_FR)
	text "Reviens à la"
	line "maison pour le"

	para "changement"
	line "d'heure."

	para "Par ailleurs,"
	line "sais-tu comment"
	cont "utiliser le"
	cont "TELEPHONE?"
else
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."

	para "By the way, do you"
	line "know how to use"
	cont "the PHONE?"
endc

	done

KnowTheInstructionsText:
if DEF(_FR_FR)
	text "Nickel!"
else
	text "Great!"
endc
	done

DontKnowTheInstructionsText: 
if DEF(_FR_FR)
	text "Je vais lire le"
	line "manuel."

	para "Allume le"
	line "#MATOS et"
	cont "sélectionne"
	cont "l'icône TELEPHONE."
else
	text "I'll read the"
	line "instructions."

	para "Turn the #GEAR"
	line "on and select the"
	cont "PHONE icon."
endc

	done

InstructionsNextText: 
if DEF(_FR_FR)
	text "Les numéros de"
	line "téléphone sont"

	para "enregistrés dans"
	line "la mémoire."
	cont "Choisis le nom de"
	cont "celui que tu veux"
	cont "appeler."

	para "C'est pas trop"
	line "compliqué, non?"
else
	text "Phone numbers are"
	line "stored in memory."

	para "Just choose a name"
	line "you want to call."

	para "Gee, isn't that"
	line "convenient?"
endc

	done

CovidIntroText:
if DEF(_FR_FR)
	text "Une dernière"
	line "chose!"

	para "Ils parlent d'un"
	line "nouveau virus aux"
	cont "infos."

	para "Les médecins à la"
	line "télé recommandent"
	cont "de garder à 1 pas"
	cont "de distance quand"
	cont "on parle à quel-"
	cont "qu'un d'autre."

	para "Désormais, les"
	line "gens pourraient"
	cont "refuser de te"
	cont "parler si tu ne"
	cont "respectes pas"
	cont "cette règle."

	para "Sois prudent"
	line "là-dehors!"
else
	text "One last thing!"
	line "They are talking"
	cont "about a new virus"
	cont "in the news."

	para "Doctors on TV"
	line "recommended to"
	cont "stay 1 step away"
	cont "when talking to"
	cont "someone."

	para "Now people may not"
	line "want to talk to"
	cont "you if you do not"
	cont "respect this rule."

	para "Be careful"
	line "out there!"
endc
	done

HurryUpElmIsWaitingText: 
if DEF(_FR_FR)
	text "Le PROF.ORME"
	line "t'attend."

	para "Dépêche-toi, mon"
	line "poussin!"
else
	text "PROF.ELM is wait-"
	line "ing for you."

	para "Hurry up, baby!"
endc

	done

SecondEndText:
if DEF(_FR_FR)
	text "Alors tu reviens"
	line "passer le confine-"
	cont "ment à la maison"
	cont "avec moi?!"

	para "Je ne m'attendais"
	line "pas à ça de ta"
	cont "part, mais ça me"
	cont "soulage!"
else
	text "So you came back"
	line "to spend the lock-"
	cont "down at home with"
	cont "me?!"

	para "I didn't expect"
	line "you'd obey, but"
	cont "it's a relief!"
endc

	done

SecondEndSequelText:
if DEF(_FR_FR)
	text "Je n'ai jamais vécu"
	line "ça. Je n'ai aucune"
	cont "idée de comment"
	cont "ça va se passer."

	para "Reste plus qu'à"
	line "espérer qu'on ne"
	cont "s'ennuit pas trop"
	cont "vite."
else
	text "I've never lived"
	line "this. I have no"
	cont "idea how it's going"
	cont "to unfold."

	para "Let's hope we"
	line "don't get bored"
	cont "too quickly."
endc

	done

SoWhatWasProfElmsErrandText: 
if DEF(_FR_FR)
	text "Alors, quelle"
	line "était la commis-"
	cont "sion du PROF.ORME?"

	para "..."

	para "Ca a l'air"
	line "difficile."

	para "Mais c'est impor-"
	line "tant que l'on te"
	cont "fasse confiance."
else
	text "So, what was PROF."
	line "ELM's errand?"

	para "…"

	para "That does sound"
	line "challenging."

	para "But, you should be"
	line "proud that people"
	cont "rely on you."
endc

	done

ImBehindYouText: 
if DEF(_FR_FR)
	text "<PLAYER>, courage!"

	para "Je suis avec toi!"
else
	text "<PLAYER>, do it!"

	para "I'm behind you all"
	line "the way!"
endc

	done

NeighborMornIntroText: 
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>!"

	para "Je suis de"
	line "passage!"
else
	text "Good morning,"
	line "<PLAY_G>!"

	para "I'm visiting!"
endc

	done

NeighborDayIntroText: 
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>!"

	para "Je suis de"
	line "passage!"
else
	text "Hello, <PLAY_G>!"
	line "I'm visiting!"
endc

	done

NeighborNiteIntroText: 
if DEF(_FR_FR)
	text "Bonjour,"
	line "<PLAY_G>!"

	para "Je suis de"
	line "passage!"
else
	text "Good evening,"
	line "<PLAY_G>!"

	para "I'm visiting!"
endc

	done

NeighborText:
if DEF(_FR_FR)
	text "Tu as entendu?"
	line "Certaines person-"
	cont "nes ont attrapé"

	para "un virus jamais vu"
	line "auparavant."

	para "Pas d'inquiétude,"
	line "je suis sûr qu'on"
	cont "ira bien!"
else
	text "Have you heard?"
	line "Some people caught"

	para "a virus never seen"
	line "before."

	para "Nothing to worry"
	line "about, I'm sure"
	cont "we will be fine!"
endc
	done

PlayersHouse1FStoveText:
if DEF(_FR_FR)
	text "La spécialité de"
	line "Maman!"

	para "Les MAKIS"
	line "TOURBILLON"
	cont "d'IRISIA !"
else
	text "Mom's specialty!"

	para "CIANWOOD WHIRL"
	line "MAKIS!"
endc
	done

PlayersHouse1FSinkText:
if DEF(_FR_FR)
	text "L'évier brille."
	line "Maman aime qu'il"
	cont "soit propre."
else
	text "The sink is spot-"
	line "less. MOM likes it"
	cont "clean."
endc
	done

EmptyFridgeText:
if DEF(_FR_FR)
	text "C'est vide..."

	para "Peut-être que"
	line "Maman n'a pas assez"
	cont "d'argent pour faire"
	cont "les courses?"
else
	text "It's empty…"

	para "Maybe MOM doesn't"
	line "have enough money"
	cont "to do groceries?"
endc
	done

PlayersHouse1FFridgeText:
if DEF(_FR_FR)
	text "Voyons ce qu'il y a"
	line "dans le frigo..."

	para "De l'EAU FRAICHE et"
	line "un THE AU LAIT!"

	para "Prendre l'EAU"
	line "FRAICHE?"
else
	text "Let's see what's"
	line "in the fridge…"

	para "FRESH WATER and"
	line "tasty MILK TEA!"

	para "Take the FRESH"
	line "WATER?"
endc
	done

AskLemonadeFridgeText:
if DEF(_FR_FR)
	text "Prendre le THE"
	line "AU LAIT?"
else
	text "Take the MILK"
	line "TEA?"
endc
	done

OtherDrinkIsForMomText:
if DEF(_FR_FR)
	text "L'autre boisson"
	line "est pour Maman."
else
	text "The other drink"
	line "is for MOM."
endc
	done

NowWeCanTalkText:
if DEF(_FR_FR)
	text "Parfait! Mainte-"
	line "nant on peut"
	cont "parler!"
else
	text "Perfect!"
	line "Now we can talk!"
endc
	done

PlayersHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, NEW_BARK_TOWN, 2
	warp_event  7,  7, NEW_BARK_TOWN, 2
	warp_event  9,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events
	coord_event  8,  4, CE_EVENT_FLAG_CLEARED, EVENT_PLAYERS_HOUSE_MOM_1, MeetMomLeftScript
	coord_event  9,  4, CE_EVENT_FLAG_CLEARED, EVENT_PLAYERS_HOUSE_MOM_1, MeetMomRightScript

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PlayersHouse1FStoveScript
	bg_event  1,  1, BGEVENT_READ, PlayersHouse1FSinkScript
	bg_event  2,  1, BGEVENT_READ, PlayersHouse1FFridgeScript
	bg_event  2,  2, BGEVENT_READ, FakeMomMornScript
	bg_event  7,  4, BGEVENT_READ, FakeMomDayScript
	bg_event  0,  2, BGEVENT_READ, FakeMomNiteScript
	bg_event  4,  4, BGEVENT_READ, FakeNeighborScript

	def_object_events
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1
	object_event  2,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  0,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, NITE, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  4,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NeighborScript, EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
