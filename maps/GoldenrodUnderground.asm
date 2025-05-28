GOLDENRODUNDERGROUND_OLDER_HAIRCUT_PRICE   EQU 500
GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_PRICE EQU 300

	object_const_def
	const GOLDENRODUNDERGROUND_SUPER_NERD1
	const GOLDENRODUNDERGROUND_SUPER_NERD2
	const GOLDENRODUNDERGROUND_SUPER_NERD3
	const GOLDENRODUNDERGROUND_SUPER_NERD4
	const GOLDENRODUNDERGROUND_GRAMPS
	const GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	const GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	const GOLDENRODUNDERGROUND_GRANNY
	const GOLDENRODUNDERGROUND_GAMECORNER_EMPLOYEES_BACKDOOR
	const GOLDENRODUNDERGROUND_GAMECORNER_EXIT_BLOCK
	const GOLDENRODUNDERGROUND_BEATER
	const GOLDENRODUNDERGROUND_STONE_SCAMMER
	const GOLDENRODUNDERGROUND_RUSH_1
	const GOLDENRODUNDERGROUND_RUSH_2
	const GOLDENRODUNDERGROUND_RUSH_3
	const GOLDENRODUNDERGROUND_RUSH_4

GoldenrodUnderground_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .ResetSwitches
	callback MAPCALLBACK_TILES, .CheckBasementKey
	callback MAPCALLBACK_OBJECTS, .CheckDayOfWeek

.ResetSwitches:
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_4
	clearevent EVENT_SWITCH_5
	clearevent EVENT_SWITCH_6
	clearevent EVENT_SWITCH_7
	clearevent EVENT_SWITCH_8
	clearevent EVENT_SWITCH_9
	clearevent EVENT_SWITCH_10
	clearevent EVENT_SWITCH_11
	clearevent EVENT_SWITCH_12
	clearevent EVENT_SWITCH_13
	clearevent EVENT_SWITCH_14
	setval 0
	writemem wUndergroundSwitchPositions
	endcallback

.CheckBasementKey:
	checkevent EVENT_USED_BASEMENT_KEY
	iffalse .LockBasementDoor
	endcallback

.LockBasementDoor:
	changeblock 18, 6, $3d ; locked door
	endcallback

.CheckDayOfWeek:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday

; Sunday
	disappear GOLDENRODUNDERGROUND_GRAMPS
	disappear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	appear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	appear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Monday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	checktime MORN
	iffalse .NotMondayMorning
	appear GOLDENRODUNDERGROUND_GRAMPS
.NotMondayMorning:
	disappear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Tuesday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	appear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Wednesday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	disappear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	appear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Thursday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	appear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Friday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	disappear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	appear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Saturday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	appear GOLDENRODUNDERGROUND_OLDER_HAIRCUT_BROTHER
	disappear GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	appear GOLDENRODUNDERGROUND_GRANNY
	endcallback

TrainerSupernerdEric:
	trainer SUPER_NERD, ERIC, EVENT_BEAT_SUPER_NERD_ERIC, SupernerdEricSeenText, SupernerdEricBeatenText, 0, .Script

.Script:
	endifjustbattled
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .Reopening

	jumptextfaceplayer  SupernerdEricAfterBattleText

.Reopening
	jumptextfaceplayer SupernerdEricAfterBattleText_Reopening

TrainerSupernerdTeru:
	trainer SUPER_NERD, TERU, EVENT_BEAT_SUPER_NERD_TERU, SupernerdTeruSeenText, SupernerdTeruBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SupernerdTeruAfterBattleText
	waitbutton
	closetext
	end

TrainerPokemaniacIssac:
	trainer POKEMANIAC, ISSAC, EVENT_BEAT_POKEMANIAC_ISSAC, PokemaniacIssacSeenText, PokemaniacIssacBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacIssacAfterBattleText
	waitbutton
	closetext
	end

TrainerPokemaniacDonald:
	trainer POKEMANIAC, DONALD, EVENT_BEAT_POKEMANIAC_DONALD, PokemaniacDonaldSeenText, PokemaniacDonaldBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacDonaldAfterBattleText
	waitbutton
	closetext
	end

BitterMerchantScript:
	opentext
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .Open
	ifequal SATURDAY, .Open
	sjump GoldenrodUndergroundScript_ShopClosed

.Open:
	pokemart MARTTYPE_BITTER, MART_UNDERGROUND
	closetext
	end

StonesMerchantScript:
	checkevent EVENT_GOT_SICK_WHILE_HOLDING_EVIOSTONE
	iffalse .opentext_then_mart

	showemote EMOTE_QUESTION, GOLDENRODUNDERGROUND_STONE_SCAMMER, 30
	opentext
	writetext StoneScammerExcuseText
	special PlaceMoneyTopRight
	yesorno
	iffalse .aggressive

	checkmoney YOUR_MONEY, 9999
	ifequal HAVE_LESS, .not_enough_money

	giveitem JADE_CRYSTAL
	iffalse .no_room

	takemoney YOUR_MONEY, 9999
	waitsfx
	playsound SFX_TRANSACTION
	pause 15
	special PlaceMoneyTopRight

	itemnotify

	closetext ; Closes PlaceMoneyTopRight. 
	opentext

	writetext StoneScammerDoubleScamText
	promptbutton
	writetext StoneScammerEmptyBoxText
	sjump .mart	

.aggressive
	closetext ; Closes PlaceMoneyTopRight. 
	opentext
	writetext StoneScammerAggressiveText
	promptbutton
	writetext StoneScammerEmptyBoxText
	sjump .mart

.opentext_then_mart
	opentext
.mart
	pokemart MARTTYPE_STONES, MART_UNDERGROUND_STONES
	closetext
	end

.not_enough_money
	farwritetext _StoneShopNoMoneyText
	sjump .end_text

.no_room
	farwritetext _HerbalLadyPackFullText
.end_text
	waitbutton
	closetext
	end

BargainMerchantScript:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED
	iftrue GoldenrodUndergroundScript_ShopClosed
	readvar VAR_WEEKDAY
	ifequal MONDAY, .CheckMorn
	sjump GoldenrodUndergroundScript_ShopClosed

.CheckMorn:
	checktime MORN
	iffalse GoldenrodUndergroundScript_ShopClosed
	pokemart MARTTYPE_BARGAIN, 0
	closetext
	end

OlderHaircutBrotherScript:
	opentext
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .DoHaircut
	ifequal THURSDAY, .DoHaircut
	ifequal SATURDAY, .DoHaircut
	sjump GoldenrodUndergroundScript_ShopClosed

.DoHaircut:
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundOlderHaircutBrotherOfferHaircutText
	yesorno
	iffalse .Refused
	checkmoney YOUR_MONEY, GOLDENRODUNDERGROUND_OLDER_HAIRCUT_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	writetext GoldenrodUndergroundOlderHaircutBrotherAskWhichMonText
	promptbutton
	special OlderHaircutBrother
	ifequal $0, .Refused
	ifequal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequal $2, .two
	ifequal $3, .three
	sjump .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.then
	takemoney YOUR_MONEY, GOLDENRODUNDERGROUND_OLDER_HAIRCUT_PRICE
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundOlderHaircutBrotherWatchItBecomeBeautifulText
	waitbutton
	closetext
	special FadeOutPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext GoldenrodUndergroundOlderHaircutBrotherAllDoneText
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue EitherHaircutBrotherScript_SlightlyHappier
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue EitherHaircutBrotherScript_Happier
	sjump EitherHaircutBrotherScript_MuchHappier

.Refused:
	writetext GoldenrodUndergroundOlderHaircutBrotherThatsAShameText
	waitbutton
	closetext
	end

.NotEnoughMoney:
	writetext GoldenrodUndergroundOlderHaircutBrotherYoullNeedMoreMoneyText
	waitbutton
	closetext
	end

.AlreadyGotHaircut:
	writetext GoldenrodUndergroundOlderHaircutBrotherOneHaircutADayText
	waitbutton
	closetext
	end

YoungerHaircutBrotherScript:
	opentext
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .DoHaircut
	ifequal WEDNESDAY, .DoHaircut
	ifequal FRIDAY, .DoHaircut
	sjump GoldenrodUndergroundScript_ShopClosed

.DoHaircut:
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundYoungerHaircutBrotherOfferHaircutText
	yesorno
	iffalse .Refused
	checkmoney YOUR_MONEY, GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	writetext GoldenrodUndergroundYoungerHaircutBrotherAskWhichMonText
	promptbutton
	special YoungerHaircutBrother
	ifequal $0, .Refused
	ifequal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequal $2, .two
	ifequal $3, .three
	sjump .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.then
	takemoney YOUR_MONEY, GOLDENRODUNDERGROUND_YOUNGER_HAIRCUT_PRICE
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundYoungerHaircutBrotherIllMakeItLookCoolText
	waitbutton
	closetext
	special FadeOutPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext GoldenrodUndergroundYoungerHaircutBrotherAllDoneText
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue EitherHaircutBrotherScript_SlightlyHappier
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue EitherHaircutBrotherScript_Happier
	sjump EitherHaircutBrotherScript_MuchHappier

.Refused:
	writetext GoldenrodUndergroundYoungerHaircutBrotherHowDisappointingText
	waitbutton
	closetext
	end

.NotEnoughMoney:
	writetext GoldenrodUndergroundYoungerHaircutBrotherShortOnFundsText
	waitbutton
	closetext
	end

.AlreadyGotHaircut:
	writetext GoldenrodUndergroundYoungerHaircutBrotherOneHaircutADayText
	waitbutton
	closetext
	end

EitherHaircutBrotherScript_SlightlyHappier:
	writetext HaircutBrosText_SlightlyHappier
	special PlayCurMonCry
	waitbutton
	closetext
	end

EitherHaircutBrotherScript_Happier:
	writetext HaircutBrosText_Happier
	special PlayCurMonCry
	waitbutton
	closetext
	end

EitherHaircutBrotherScript_MuchHappier:
	writetext HaircutBrosText_MuchHappier
	special PlayCurMonCry
	waitbutton
	closetext
	end

GameCornerEmployeesBackdoorScript:
	jumptext GoldenrodUndergroundTheDoorsLockedText

GameCornerExitBlockScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	opentext
	writetext GameCornerExitBlockText
	waitbutton
	closetext
	end

BasementDoorScript::
	opentext
	checkevent EVENT_USED_BASEMENT_KEY
	iftrue .Open
	checkitem BASEMENT_KEY
	iftrue .Unlock
	writetext GoldenrodUndergroundTheDoorsLockedText
	waitbutton
	closetext
	end

.Unlock:
	playsound SFX_TRANSACTION
	writetext GoldenrodUndergroundBasementKeyOpenedDoorText
	waitbutton
	closetext
	changeblock 18, 6, $2e ; unlocked door
	reloadmappart
	closetext
	setevent EVENT_USED_BASEMENT_KEY
	end

.Open:
	writetext GoldenrodUndergroundTheDoorIsOpenText
	waitbutton
	closetext
	end

GoldenrodUndergroundScript_ShopClosed:
	writetext GoldenrodUndergroundWeAreNotOpenTodayText
	waitbutton
	closetext
	end

GoldenrodUndergroundNoEntrySign:
	jumptext GoldenrodUndergroundNoEntryText

GoldenrodUndergroundHiddenParlyzHeal:
	hiddenitem PARLYZ_HEAL, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_PARLYZ_HEAL

GoldenrodUndergroundHiddenSuperPotion:
	hiddenitem SUPER_POTION, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_SUPER_POTION

GoldenrodUndergroundHiddenAntidote:
	hiddenitem ANTIDOTE, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_ANTIDOTE

GoldenrodUndergroundExitBoard:
	jumptext GoldenrodUndergroundExitText

DoorKeeperScript:
	faceplayer
	readvar VAR_XCOORD
	ifgreater 7, .Instruct
	
	showemote EMOTE_HAPPY, GOLDENRODUNDERGROUND_BEATER, 25
	opentext
	writetext DoorKeeperCheckTeamText
	yesorno
	iffalse .RefuseTeamCheck
	checkpoke MURKROW
	iffalse .FakeCompliments
	checkpoke ZUBAT
	iffalse .FakeCompliments
	readvar VAR_PARTYCOUNT
	ifgreater 2, .FakeCompliments
	writetext CheckPassText
	yesorno
	iffalse .GoGetIt
	checkmoney YOUR_MONEY, 3000
	ifequal HAVE_LESS, .NotEnoughMoney
	special PlaceMoneyTopRight
	writetext MoneyCheckPassText
	promptbutton
	takemoney YOUR_MONEY, 1000
	waitsfx
	playsound SFX_TRANSACTION
	pause 15
	special PlaceMoneyTopRight
	writetext FollowText
	waitbutton
	closetext

	readvar VAR_YCOORD
	ifgreater 7, .follow

.player_moves_back
	applymovement PLAYER, GoldenrodUnderground_PlayerFacesBeaterMovement
.follow
	follow GOLDENRODUNDERGROUND_BEATER, PLAYER
	applymovement GOLDENRODUNDERGROUND_BEATER, PathMovement
	waitsfx
	playsound SFX_GLASS_TING_2
	pause 20
	applymovement GOLDENRODUNDERGROUND_BEATER, PathMovementEnd
	stopfollow
	setmapscene GOLDENROD_GAME_CORNER, SCENE_DEFAULT
	disappear GOLDENRODUNDERGROUND_GAMECORNER_EMPLOYEES_BACKDOOR
.Instruct:
	opentext
	writetext PathInstructionText
	waitbutton
	closetext
	end


.RefuseTeamCheck:
	writetext NevermindText
	waitbutton
	closetext
	end

.FakeCompliments:
	writetext FakeComplimentsText
	waitbutton
	closetext
	end

.GoGetIt:
	writetext RefuseMoneyCheckText
	waitbutton
	closetext
	end

.NotEnoughMoney:
	writetext NotEnoughMoneyCheckText
	waitbutton
	closetext
	end

GoldenrodUndergroundRush1Script:
	jumptext GoldenrodUndergroundRush1Text

GoldenrodUndergroundRush2Script:
	jumptext GoldenrodUndergroundRush2Text

GoldenrodUndergroundRush3Script:
	jumptext GoldenrodUndergroundRush3Text

GoldenrodUndergroundRush4Script:
	jumptext GoldenrodUndergroundRush4Text

PathMovement:
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

GoldenrodUnderground_PlayerFacesBeaterMovement:
	step LEFT
	step DOWN
	step_end

PathMovementEnd:
	step RIGHT
	turn_head LEFT
	step_end

SupernerdEricSeenText: ; TO TRANSLATE
	text "I like to gamble."
	done

SupernerdEricBeatenText: 
if DEF(_FR_FR)
	text "...Grrr..."
else
	text "…Grumble…"
endc

	done

SupernerdEricAfterBattleText: ; TO TRANSLATE
	text "I wish I could go"
	line "to the GAME COR-"
	cont "NER."

	para "It's such a"
	line "bummer that it's"
	cont "closed…"
	done

SupernerdEricAfterBattleText_Reopening: ; TO TRANSLATE
	text "The GAME CORNER"
	line "finally reopened!"
	cont "Time to gamble!"
	done

SupernerdTeruSeenText: 
if DEF(_FR_FR)
	text "Fais-tu attention"
	line "aux types de #-"
	cont "MON pendant les"
	cont "combats?"

	para "Apprends les fai-"
	line "blesses et les a-"

	para "vantages des types"
	line "pour devenir"
	cont "plus terrible!"
else
	text "Do you consider"
	line "type alignments in"
	cont "battle?"

	para "If you know your"
	line "type advantages,"

	para "you'll do better"
	line "in battle."
endc

	done

SupernerdTeruBeatenText: 
if DEF(_FR_FR)
	text "Oh, oh, oh!"
else
	text "Ow, ow, ow!"
endc

	done

SupernerdTeruAfterBattleText: 
if DEF(_FR_FR)
	text "Je connais tous"
	line "les types de #-"
	cont "MON."

	para "Mais je n'en uti-"
	line "lise qu'un seul."
else
	text "I know my #MON"
	line "type alignments."

	para "But I only use one"
	line "type of #MON."
endc

	done

PokemaniacIssacSeenText: 
if DEF(_FR_FR)
	text "Mes #MON se"
	line "sont fait"
	cont "toiletter!"

	para "Regarde comme ils"
	line "sont beaux et"
	cont "forts!"
else
	text "My #MON just"
	line "got a haircut!"

	para "I'll show you how"
	line "strong it is!"
endc

	done

PokemaniacIssacBeatenText: 
if DEF(_FR_FR)
	text "Yaaaaaaaah!"
else
	text "Aiyeeee!"
endc

	done

PokemaniacIssacAfterBattleText: 
if DEF(_FR_FR)
	text "Tes #MON t'ai-"
	line "meront plus si tu"

	para "les fais toilet-"
	line "ter."
else
	text "Your #MON will"
	line "like you more if"

	para "you give them"
	line "haircuts."
endc

	done

PokemaniacDonaldSeenText: ; TO TRANSLATE
	text "I think you have"
	line "some rare #MON"
	cont "with you."

	para "Lemme see them!"
	done

PokemaniacDonaldBeatenText: 
if DEF(_FR_FR)
	text "Graah! Perdu!"
	line "Ca craint!"
else
	text "Gaah! I lost!"
	line "That makes me mad!"
endc

	done

PokemaniacDonaldAfterBattleText: 
if DEF(_FR_FR)
	text "Tu remplis un"
	line "#DEX? Voilà"
	cont "un conseil."

	para "MARIO, le MONTA-"
	line "GNARD de la ROUTE"
	cont "33 est sympa."

	para "Il t'appellera"
	line "s'il voit des"
	cont "#MON rares."
else
	text "Are you making a"
	line "#DEX? Here's a"
	cont "hot tip."

	para "The HIKER on ROUTE"
	line "33, ANTHONY, is a"
	cont "good guy."

	para "He'll phone you if"
	line "he sees any rare"
	cont "#MON."
endc

	done

GameCornerExitBlockText: ; TO TRANSLATE
	text "The man locked the"
	line "door behind you…"
	done

GoldenrodUndergroundTheDoorsLockedText: 
if DEF(_FR_FR)
	text "C'est fermé..."
else
	text "The door's locked…"
endc

	done

GoldenrodUndergroundTheDoorIsOpenText: 
if DEF(_FR_FR)
	text "C'est ouvert."
else
	text "The door is open."
endc

	done

GoldenrodUndergroundBasementKeyOpenedDoorText: 
if DEF(_FR_FR)
	text "La CLE SOUS-SOL a"
	line "ouvert la porte."
else
	text "The BASEMENT KEY"
	line "opened the door."
endc

	done

GoldenrodUndergroundOlderHaircutBrotherOfferHaircutText: 
if DEF(_FR_FR)
	text "Bienvenue! Je"

	para "m'occupe du SALON"
	line "#MON!"

	para "Je suis l'aîné et"
	line "le meilleur des"
	cont "FRERES COIFFEURS."

	para "Je peux toiletter"
	line "tes #MON pour"
	cont "juste 500¥."

	para "Veux-tu que je"
	line "m'en occupe?"
else
	text "Welcome!"

	para "I run the #MON"
	line "SALON!"

	para "I'm the older and"
	line "better of the two"
	cont "HAIRCUT BROTHERS."

	para "I can make your"
	line "#MON beautiful"
	cont "for just ¥500."

	para "Would you like me"
	line "to do that?"
endc

	done

GoldenrodUndergroundOlderHaircutBrotherAskWhichMonText: 
if DEF(_FR_FR)
	text "Quel #MON veux-"
	line "tu me confier?"
else
	text "Which #MON"
	line "should I work on?"
endc

	done

GoldenrodUndergroundOlderHaircutBrotherWatchItBecomeBeautifulText: 
if DEF(_FR_FR)
	text "Je vais lui refai-"
	line "re une beauté!"
else
	text "OK! Watch it"
	line "become beautiful!"
endc

	done

GoldenrodUndergroundOlderHaircutBrotherAllDoneText: 
if DEF(_FR_FR)
	text "Ca y est! Fini!"
else
	text "There! All done!"
endc

	done

GoldenrodUndergroundOlderHaircutBrotherThatsAShameText: 
if DEF(_FR_FR)
	text "Vraiment?"
	line "Quel dommage!"
else
	text "Is that right?"
	line "That's a shame!"
endc

	done

GoldenrodUndergroundOlderHaircutBrotherYoullNeedMoreMoneyText: 
if DEF(_FR_FR)
	text "Il te faut plus"
	line "de sous..."
else
	text "You'll need more"
	line "money than that."
endc

	done

GoldenrodUndergroundOlderHaircutBrotherOneHaircutADayText: 
if DEF(_FR_FR)
	text "Je ne fais qu'un"
	line "toilettage par"
	cont "jour. Au revoir."
else
	text "I do only one"
	line "haircut a day. I'm"
	cont "done for today."
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherOfferHaircutText: 
if DEF(_FR_FR)
	text "Bienvenue au"
	line "SALON #MON!"

	para "Je suis le cadet"
	line "et le moins cher"
	cont "des FRERES"
	cont "COIFFEURS."

	para "J'peux m'occuper"
	line "de tes #MON"
	cont "pour 300¥."

	para "Alors? Ca te dit"
	line "oui ou non?"
else
	text "Welcome to the"
	line "#MON SALON!"

	para "I'm the younger"
	line "and less expen-"
	cont "sive of the two"
	cont "HAIRCUT BROTHERS."

	para "I'll spiff up your"
	line "#MON for just"
	cont "¥300."

	para "So? How about it?"
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherAskWhichMonText: 
if DEF(_FR_FR)
	text "De quel #MON"
	line "je m'occupe?"
else
	text "OK, which #MON"
	line "should I do?"
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherIllMakeItLookCoolText: 
if DEF(_FR_FR)
	text "OK! Y va être"
	line "trop cool!"
else
	text "OK! I'll make it"
	line "look cool!"
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherAllDoneText: 
if DEF(_FR_FR)
	text "Allez hop!"
	line "Terminé!"
else
	text "There we go!"
	line "All done!"
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherHowDisappointingText: 
if DEF(_FR_FR)
	text "Non?"
	line "Tant pis."
else
	text "No? "
	line "How disappointing!"
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherShortOnFundsText: 
if DEF(_FR_FR)
	text "T'es à court"
	line "de fric."
else
	text "You're a little"
	line "short on funds."
endc

	done

GoldenrodUndergroundYoungerHaircutBrotherOneHaircutADayText: 
if DEF(_FR_FR)
	text "Je ne fais qu'un"
	line "toilettage par"
	cont "jour. Au revoir."
else
	text "I can do only one"
	line "haircut a day."

	para "Sorry, but I'm all"
	line "done for today."
endc

	done

HaircutBrosText_SlightlyHappier: 
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text " a l'air"
	line "un peu plus"
	cont "heureux."
else
	text_ram wStringBuffer3
	text " looks a"
	line "little happier."
endc

	done

HaircutBrosText_Happier: 
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text " a l'air"
	line "heureux."
else
	text_ram wStringBuffer3
	text " looks"
	line "happy."
endc

	done

HaircutBrosText_MuchHappier: 
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text " a l'air"
	line "ravi!"
else
	text_ram wStringBuffer3
	text " looks"
	line "delighted!"
endc

	done

GoldenrodUndergroundWeAreNotOpenTodayText: 
if DEF(_FR_FR)
	text "C'est fermé"
	line "aujourd'hui."
else
	text "We're not open"
	line "today."
endc

	done

GoldenrodUndergroundNoEntryText: 
if DEF(_FR_FR)
	text "ENTREE"
	line "INTERDITE"
else
	text "NO ENTRY BEYOND"
	line "THIS POINT"
endc

	done

GoldenrodUndergroundExitText: ; TO TRANSLATE
	text "EMERGENCY EXIT"
	line "DO NOT BLOCK"
	done

DoorKeeperCheckTeamText: ; TO TRANSLATE
	text "Good evening!"

	para "You seem to be a"
	line "good trainer!"

	para "Can I see your"
	line "#MON team?"
	done

NevermindText: ; TO TRANSLATE
	text "Maybe another"
	line "time!"
	done

FakeComplimentsText: ; TO TRANSLATE
	text "…"

	para "That's a fine"
	line "team! Keep up the"
	cont "good training!"
	done

CheckPassText: ; TO TRANSLATE
	text "…"

	para "OK, you're clean."

	para "You got the money?"
	line "Lemme see it."
	done

RefuseMoneyCheckText: ; TO TRANSLATE
	text "GO GET CASH NOW,"
	line "BEFORE I LEAVE!"
	done

NotEnoughMoneyCheckText: ; TO TRANSLATE
	text "…"

	para "We said 3000¥"
	line "or more…"

	para "…"

	para "GET OUT OF MY"
	line "SIGHT, NOW!"
	done

MoneyCheckPassText: ; TO TRANSLATE
	text "My share is ¥1000."
	done

FollowText: ; TO TRANSLATE
	text "All right,"
	line "come with me."
	done

PathInstructionText: ; TO TRANSLATE
	text "Behind that door,"
	line "straight forward."

	para "Have fun."
	done

GoldenrodUndergroundRush1Text: ; TO TRANSLATE
	text "Let me find"
	line "my change…"
	done

GoldenrodUndergroundRush2Text: ; TO TRANSLATE
	text "Please don't sell"
	line "all you have to"
	cont "this lady. Save"
	cont "some for me!"

	para "I'll pay double"
	line "the price!"
	done

GoldenrodUndergroundRush3Text: ; TO TRANSLATE
	text "This old lady is"
	line "taking forever!"
	done

GoldenrodUndergroundRush4Text: ; TO TRANSLATE
	text "Sell me everything"
	line "you have. Now!"
	done

StoneScammerExcuseText: ; TO TRANSLATE
	text "Your #MON got"
	line "sick while holding"
	cont "a JADE CRYSTAL?"

	para "This can't happen…"
	line "Your #MON must"
	
	para "have held the item"
	line "incorrectly."

	para "…"

	para "To prevent this"
	line "from reoccurring,"
	
	para "I can sell you a"
	line "stronger JADE"
	cont "CRYSTAL for ¥9999."
	done

StoneScammerDoubleScamText: ; TO TRANSLATE
	text "You will see. This"
	line "JADE CRYSTAL is"
	cont "very powerful."
	done

StoneScammerAggressiveText: ; TO TRANSLATE
	text "Look, I will not"
	line "give you a refund."

	para "I cannot be held"
	line "responsible for"
	
	para "your mishandling"
	line "of my products."
	done

StoneScammerEmptyBoxText:
	text " "
	done

GoldenrodUnderground_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  2, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 7
	warp_event  3, 34, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 4
	warp_event 18,  6, GOLDENROD_UNDERGROUND, 4
	warp_event 21, 31, GOLDENROD_UNDERGROUND, 3
	warp_event 22, 31, GOLDENROD_UNDERGROUND, 3
	warp_event 22, 27, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 1
	warp_event 12,  6, GOLDENROD_UNDERGROUND, 8
	warp_event 26,  0, GOLDENROD_UNDERGROUND, 7
	warp_event 23, 16, GOLDENROD_GAME_CORNER, 1

	def_coord_events

	def_bg_events
	bg_event 18,  6, BGEVENT_READ, BasementDoorScript
	bg_event 19,  6, BGEVENT_READ, GoldenrodUndergroundNoEntrySign
	bg_event  6, 13, BGEVENT_ITEM, GoldenrodUndergroundHiddenParlyzHeal
	bg_event  4, 18, BGEVENT_ITEM, GoldenrodUndergroundHiddenSuperPotion
	bg_event 17,  8, BGEVENT_ITEM, GoldenrodUndergroundHiddenAntidote
	bg_event 27,  0, BGEVENT_READ, GoldenrodUndergroundExitBoard


	def_object_events
	object_event  5, 31, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, DAY, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerSupernerdEric, -1
	object_event  6,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, DAY, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerSupernerdTeru, -1
	object_event  3, 27, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, DAY, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerPokemaniacIssac, -1
	object_event  2,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, DAY, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacDonald, -1
	object_event  7, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BargainMerchantScript, EVENT_GOLDENROD_UNDERGROUND_GRAMPS
	object_event  7, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlderHaircutBrotherScript, EVENT_GOLDENROD_UNDERGROUND_OLDER_HAIRCUT_BROTHER
	object_event  7, 16, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, YoungerHaircutBrotherScript, EVENT_GOLDENROD_UNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	object_event  7, 20, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BitterMerchantScript, EVENT_GOLDENROD_UNDERGROUND_GRANNY
	object_event 12,  6, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GameCornerEmployeesBackdoorScript, -1
	object_event 26,  0, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GameCornerExitBlockScript, -1
	object_event  6,  8, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, %11100000 | (18 - START_HOUR_FILTER_OFFSET), %11100000 | 18, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DoorKeeperScript, EVENT_GOLDENROD_ILLEGAL_CASINO
	object_event  7, 22, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, %11100000 | MORN | DAY, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, StonesMerchantScript, -1
	object_event  5, 22, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundRush1Script, EVENT_LOCKDOWN_MART_RUSH
	object_event  6, 23, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundRush2Script, EVENT_LOCKDOWN_MART_RUSH
	object_event  3, 22, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundRush3Script, EVENT_LOCKDOWN_MART_RUSH
	object_event  5, 21, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundRush4Script, EVENT_LOCKDOWN_MART_RUSH
