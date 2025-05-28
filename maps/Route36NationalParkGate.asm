	object_const_def
	const ROUTE36NATIONALPARKGATE_OFFICER1
	const ROUTE36NATIONALPARKGATE_YOUNGSTER1
	const ROUTE36NATIONALPARKGATE_YOUNGSTER2
	const ROUTE36NATIONALPARKGATE_ROCKER
	const ROUTE36NATIONALPARKGATE_POKEFAN_M
	const ROUTE36NATIONALPARKGATE_YOUNGSTER3
	const ROUTE36NATIONALPARKGATE_YOUNGSTER4
	const ROUTE36NATIONALPARKGATE_LASS
	const ROUTE36NATIONALPARKGATE_YOUNGSTER5
	const ROUTE36NATIONALPARKGATE_YOUNGSTER6
	const ROUTE36NATIONALPARKGATE_YOUNGSTER7
	const ROUTE36NATIONALPARKGATE_OFFICER2

Route36NationalParkGate_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_ROUTE36NATIONALPARKGATE_NOTHING
	scene_script .DummyScene1 ; SCENE_ROUTE36NATIONALPARKGATE_UNUSED
	scene_script .LeaveContestEarly ; SCENE_ROUTE36NATIONALPARKGATE_LEAVE_CONTEST_EARLY

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .CheckIfContestRunning
	callback MAPCALLBACK_OBJECTS, .CheckIfContestAvailable

.DummyScene0:
	end

.DummyScene1:
	end

.LeaveContestEarly:
	prioritysjump .LeavingContestEarly
	end

.CheckIfContestRunning:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	setscene SCENE_ROUTE36NATIONALPARKGATE_NOTHING
	endcallback

.BugContestIsRunning:
	setscene SCENE_ROUTE36NATIONALPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

.CheckIfContestAvailable:
	checkevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	iftrue .Return
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .SetContestOfficer
	disappear ROUTE36NATIONALPARKGATE_OFFICER1
	appear ROUTE36NATIONALPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear ROUTE36NATIONALPARKGATE_OFFICER1
	disappear ROUTE36NATIONALPARKGATE_OFFICER2
.Return:
	endcallback

.LeavingContestEarly:
	turnobject PLAYER, UP
	opentext
	readvar VAR_CONTESTMINUTES
	addval 1
	getnum STRING_BUFFER_3
	writetext Route36NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writetext Route36NationalParkGateOfficer1WaitHereForAnnouncementText
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	scall .CopyContestants
	disappear ROUTE36NATIONALPARKGATE_OFFICER1
	appear ROUTE36NATIONALPARKGATE_OFFICER2
	applymovement PLAYER, Route36NationalParkGatePlayerWaitWithContestantsMovement
	pause 15
	special FadeInQuickly
	jumpstd BugContestResultsScript

.GoBackToContest:
	writetext Route36NationalParkGateOfficer1OkGoFinishText
	waitbutton
	closetext
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 33, 18
	end

.CopyContestants:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .Not1
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER1
.Not1:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .Not2
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER2
.Not2:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .Not3
	appear ROUTE36NATIONALPARKGATE_ROCKER
.Not3:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .Not4
	appear ROUTE36NATIONALPARKGATE_POKEFAN_M
.Not4:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .Not5
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER3
.Not5:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .Not6
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER4
.Not6:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .Not7
	appear ROUTE36NATIONALPARKGATE_LASS
.Not7:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .Not8
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER5
.Not8:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .Not9
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER6
.Not9:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .Not10
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER7
.Not10:
	special UpdateSprites
	end

Route36OfficerScriptContest:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	readvar VAR_WEEKDAY
	ifequal SUNDAY, _ContestNotOn
	ifequal MONDAY, _ContestNotOn
	ifequal WEDNESDAY, _ContestNotOn
	ifequal FRIDAY, _ContestNotOn
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	scall Route36ParkGate_DayToText
	writetext Route36NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalse .DecidedNotToJoinContest
	readvar VAR_PARTYCOUNT
	ifgreater 1, .LeaveMonsWithOfficer
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
.ResumeStartingContest:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext Route36NationalParkGateOfficer1GiveParkBallsText
	promptbutton
	waitsfx
	writetext Route36NationalParkGatePlayerReceivedParkBallsText
	playsound SFX_ITEM
	waitsfx
	writetext Route36NationalParkGateOfficer1ExplainsRulesText
	waitbutton
	closetext
	setflag ENGINE_BUG_CONTEST_TIMER
	special GiveParkBalls
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	special SelectRandomBugContestContestants
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 33, 18
	end

.lockdown
	faceplayer
	farjumptext NationalParkLockdownText

.LeaveMonsWithOfficer:
	readvar VAR_PARTYCOUNT
	ifless PARTY_LENGTH, .ContinueLeavingMons
	readvar VAR_BOXSPACE
	ifequal 0, .BoxFull
.ContinueLeavingMons:
	special CheckFirstMonIsEgg
	ifequal TRUE, .FirstMonIsEgg
	writetext Route36NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse .RefusedToLeaveMons
	special ContestDropOffMons
	iftrue .FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext Route36NationalParkGateOfficer1WellHoldYourMonText
	promptbutton
	writetext Route36NationalParkGatePlayersMonLeftWithHelperText
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump .ResumeStartingContest

.DecidedNotToJoinContest:
	writetext Route36NationalParkGateOfficer1TakePartInFutureText
	waitbutton
	closetext
	end

.RefusedToLeaveMons:
	writetext Route36NationalParkGateOfficer1ChooseMonAndComeBackText
	waitbutton
	closetext
	end

.FirstMonIsFainted:
	writetext Route36NationalParkGateOfficer1FirstMonCantBattleText
	waitbutton
	closetext
	end

.BoxFull:
	writetext Route36NationalParkGateOfficer1MakeRoomText
	waitbutton
	closetext
	end

.FirstMonIsEgg:
	writetext Route36NationalParkGateOfficer1EggAsFirstMonText
	waitbutton
	closetext
	end

Route36Officer_ContestHasConcluded:
	checkevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	iftrue .Sunstone
	checkevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	iftrue .Everstone
	checkevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	iftrue .GoldBerry
	checkevent EVENT_CONTEST_OFFICER_HAS_BERRY
	iftrue .Berry
	writetext Route36NationalParkGateOfficer1ContestIsOverText
	waitbutton
	closetext
	end

.Sunstone:
	writetext Route36NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem SUN_STONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	closetext
	end

.Everstone:
	writetext Route36NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem EVERSTONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	closetext
	end

.GoldBerry:
	writetext Route36NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem GOLD_BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	closetext
	end

.Berry:
	writetext Route36NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_BERRY
	closetext
	end

.BagFull:
	writetext Route36NationalParkGateOfficer1WellHoldPrizeText
	waitbutton
	closetext
	end

_ContestNotOn:
	jumptextfaceplayer Route36NationalParkGateOfficer1SomeMonOnlySeenInParkText

Route36NationalParkGateOfficerScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, Route36OfficerScriptContest.lockdown
	ifequal 1 << CURFEW, Route36OfficerScriptContest.lockdown
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	writetext Route36NationalParkGateOfficer1SomeMonOnlySeenInParkText
	waitbutton
	closetext
	end

Route36ParkGate_DayToText:
	jumpstd DayToTextScript
	end

BugCatchingContestant1BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant1BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant1BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant2BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant2BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant2BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant3BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant3BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant3BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant4BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant4BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant4BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant5BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant5BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant5BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant6BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant6BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant6BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant7BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant7BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant7BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant8BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant8BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant8BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant9BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant9BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant9BStillCompetingText
	waitbutton
	closetext
	end

BugCatchingContestant10BScript:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	writetext BugCatchingContestant10BText
	waitbutton
	closetext
	end

.StillCompeting:
	writetext BugCatchingContestant10BStillCompetingText
	waitbutton
	closetext
	end

UnusedBugCatchingContestExplanationSign: ; unreferenced
; duplicate of BugCatchingContestExplanationSign in Route35NationalParkGate.asm
	jumptext UnusedBugCatchingContestExplanationText

Route36NationalParkGatePlayerWaitWithContestantsMovement:
	big_step DOWN
	big_step RIGHT
	turn_head UP
	step_end

Route36NationalParkGateOfficer1AskToParticipateText: 
if DEF(_FR_FR)
	text "On est @"
	text_ram wStringBuffer3
	text "."
	line "Ca veut dire que"

	para "le Concours de"
	line "Capture d'insecte"
	cont "est aujourd'hui."

	para "Les règles sont"
	line "simples."

	para "Avec un #MON"
	line "de l'équipe, il"

	para "faut attraper un"
	line "#MON insecte"
	cont "qui sera noté."

	para "Alors? On tente"
	line "sa chance?"
else
	text "Today's @"
	text_ram wStringBuffer3
	text "."
	line "That means the"

	para "Bug-Catching Con-"
	line "test is on today."

	para "The rules are sim-"
	line "ple."

	para "Using one of your"
	line "#MON, catch a"

	para "bug #MON to be"
	line "judged."

	para "Would you like to"
	line "give it a try?"
endc

	done

Route36NationalParkGateOfficer1GiveParkBallsText: 
if DEF(_FR_FR)
	text "Voici des PARC"
	line "BALLS pour le"
	cont "concours."
else
	text "Here are the PARK"
	line "BALLS for the"
	cont "Contest."
endc

	done

Route36NationalParkGatePlayerReceivedParkBallsText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "{d:BUG_CONTEST_BALLS} PARC BALLS."
else
	text "<PLAYER> received"
	line "{d:BUG_CONTEST_BALLS} PARK BALLS."
endc

	done

Route36NationalParkGateOfficer1ExplainsRulesText: 
if DEF(_FR_FR)
	text "La personne qui"
	line "capture le #-"
	cont "MON insecte le"
	cont "plus puissant est"
	cont "désignée vain-"
	cont "queur."

	para "La partie dure"
	line "{d:BUG_CONTEST_MINUTES} minutes."

	para "Si toutes les"
	line "PARC BALLS sont"
	cont "épuisées, c'est"
	cont "fini!"

	para "Le dernier #MON"
	line "attrapé peut être"
	cont "gardé."

	para "Allez hop! C'est"
	line "la chasse aux"
	cont "#MON insecte!"
else
	text "The person who"
	line "gets the strong-"
	cont "est bug #MON"
	cont "is the winner."

	para "You have {d:BUG_CONTEST_MINUTES}"
	line "minutes."

	para "If you run out of"
	line "PARK BALLS, you're"
	cont "done."

	para "You can keep the"
	line "last #MON you"
	cont "catch as your own."

	para "Go out and catch"
	line "the strongest bug"

	para "#MON you can"
	line "find!"
endc

	done

Route36NationalParkGateOfficer1AskToUseFirstMonText: 
if DEF(_FR_FR)
	text "Oh-oh..."

	para "Tu as plus d'un"
	line "#MON."

	para "Tu dois utiliser"
	line "@"
	text_ram wStringBuffer3
	text ", le"

	para "premier #MON de"
	line "ton équipe."

	para "Tu es d'accord?"
else
	text "Uh-oh…"

	para "You have more than"
	line "one #MON."

	para "You'll have to use"
	line "@"
	text_ram wStringBuffer3
	text ", the"

	para "first #MON in"
	line "your party."

	para "Is that OK with"
	line "you?"
endc

	done

Route36NationalParkGateOfficer1WellHoldYourMonText: 
if DEF(_FR_FR)
	text "Parfait. Je vais"
	line "garder les autres"
	cont "#MON pendant le"
	cont "concours."
else
	text "Fine, we'll hold"
	line "your other #MON"
	cont "while you compete."
endc

	done

Route36NationalParkGatePlayersMonLeftWithHelperText: 
if DEF(_FR_FR)
	text "<PLAYER> confie"
	line "ses #MON au"
	cont "RECEPTIONNISTE."
else
	text "<PLAYER>'s #MON"
	line "were left with the"
	cont "CONTEST HELPER."
endc

	done

Route36NationalParkGateOfficer1ChooseMonAndComeBackText: 
if DEF(_FR_FR)
	text "Choisis le #MON"
	line "à utiliser pendant"

	para "le concours et"
	line "viens me voir."
else
	text "Please choose the"
	line "#MON to be used"

	para "in the Contest,"
	line "then come see me."
endc

	done

Route36NationalParkGateOfficer1TakePartInFutureText: 
if DEF(_FR_FR)
	text "OK."
	line "A la prochaine."
else
	text "OK. We hope you'll"
	line "take part in the"
	cont "future."
endc

	done

Route36NationalParkGateOfficer1FirstMonCantBattleText: 
if DEF(_FR_FR)
	text "Oh-oh..."
	line "Le premier #MON"

	para "de ton équipe ne"
	line "peut combattre."

	para "Change-le avec le"
	line "#MON de ton"

	para "choix et reviens"
	line "me voir."
else
	text "Uh-oh…"
	line "The first #MON"

	para "in your party"
	line "can't battle."

	para "Please switch it"
	line "with the #MON"

	para "you want to use,"
	line "then come see me."
endc

	done

Route36NationalParkGateOfficer1MakeRoomText: 
if DEF(_FR_FR)
	text "Oh-oh... Ton"
	line "équipe et ta BOITE"
	cont "PC sont pleines."

	para "Tu n'as pas de"
	line "place pour le"
	cont "#MON insecte"
	cont "à attraper."

	para "Fais de la place"
	line "dans l'équipe ou"

	para "dans la BOITE PC"
	line "et viens me voir."
else
	text "Uh-oh…"
	line "Both your party"

	para "and your PC BOX"
	line "are full."

	para "You have no room"
	line "to put the bug"
	cont "#MON you catch."

	para "Please make room"
	line "in your party or"

	para "your PC BOX, then"
	line "come see me."
endc

	done

Route36NationalParkGateOfficer1EggAsFirstMonText: 
if DEF(_FR_FR)
	text "Oh-oh... Tu as un"
	line "OEUF en premier"
	cont "dans ton équipe."

	para "Change-le avec le"
	line "#MON de ton"

	para "choix et reviens"
	line "me voir."
else
	text "Uh-oh…"
	line "You have an EGG as"

	para "the first #MON"
	line "in your party."

	para "Please switch it"
	line "with the #MON"

	para "you want to use,"
	line "then come see me."
endc

	done

Route36NationalParkGateOfficer1WantToFinishText: 
if DEF(_FR_FR)
	text "Tu as encore @"
	text_ram wStringBuffer3
else
	text "You still have @"
	text_ram wStringBuffer3
endc

	text_start
	line "minute(s) left."

	para "Do you want to"
	line "finish now?"
	done

Route36NationalParkGateOfficer1WaitHereForAnnouncementText: 
if DEF(_FR_FR)
	text "OK. Attends ici"
	line "pour connaître"

	para "le nom des"
	line "vainqueurs."
else
	text "OK. Please wait"
	line "here for the"

	para "announcement of"
	line "the winners."
endc

	done

Route36NationalParkGateOfficer1OkGoFinishText: 
if DEF(_FR_FR)
	text "OK. Retourne de-"
	line "hors et termine."
else
	text "OK. Please go back"
	line "outside and finish"
	cont "up."
endc

	done

Route36NationalParkGateOfficer1ContestIsOverText: 
if DEF(_FR_FR)
	text "Le concours d'au-"
	line "jourd'hui est ter-"

	para "miné. Reviens une"
	line "autre fois."
else
	text "Today's Contest is"
	line "over. We hope you"

	para "will participate"
	line "in the future."
endc

	done

Route36NationalParkGateOfficer1SomeMonOnlySeenInParkText: 
if DEF(_FR_FR)
	text "Certains #MON"
	line "n'apparaissent que"
	cont "dans le PARC."
else
	text "Some #MON can"
	line "only be seen in"
	cont "the PARK."
endc

	done

BugCatchingContestant1BText: 
if DEF(_FR_FR)
	text "JEAN-RAOUL: Oh! Tu"
	line "m'as battu! T'es"
	cont "balèze, toi."
else
	text "DON: Wow, you beat"
	line "me. You're pretty"
	cont "good."
endc

	done

BugCatchingContestant1BStillCompetingText: 
if DEF(_FR_FR)
	text "JEAN-RAOUL:"
	line "La chance compte"
	cont "beaucoup."

	para "Tu ne sais jamais"
	line "quel #MON va"
	cont "apparaître."
else
	text "DON: Luck plays a"
	line "big part in this."

	para "You never know"
	line "what #MON will"
	cont "appear."
endc

	done

BugCatchingContestant2BText: 
if DEF(_FR_FR)
	text "ODILON: T'as trop"
	line "de bol. Et moi"
	cont "j'suis maudit."
else
	text "ED: I envy you."
	line "I just couldn't"
	cont "do it this time."
endc

	done

BugCatchingContestant2BStillCompetingText: 
if DEF(_FR_FR)
	text "ODILON: T'as gagné"
	line "avec un gros #-"
	cont "MON?"
else
	text "ED: Maybe you win"
	line "with big #MON?"
endc

	done

BugCatchingContestant3BText: 
if DEF(_FR_FR)
	text "NICK: Bien joué!"
	line "Je vais mieux en-"
	cont "traîner mes #-"
	cont "MON."
else
	text "NICK: Well done!"
	line "I'm going to raise"
	cont "my #MON better."
endc

	done

BugCatchingContestant3BStillCompetingText: 
if DEF(_FR_FR)
	text "NICK: On gagne"
	line "peut-être plus de"

	para "points avec un"
	line "#MON d'une"
	cont "couleur bizarre."
else
	text "NICK: Maybe you"
	line "get a higher score"

	para "for a #MON of"
	line "an unusual color."
endc

	done

BugCatchingContestant4BText: 
if DEF(_FR_FR)
	text "MARCEL: Tu as"
	line "gagné? Qu'as-tu"
	cont "attrapé?"
else
	text "WILLIAM: You're"
	line "the winner? What"
	cont "did you catch?"
endc

	done

BugCatchingContestant4BStillCompetingText: 
if DEF(_FR_FR)
	text "MARCEL: En tout"
	line "cas je suis"

	para "content: j'ai"
	line "attrapé le #MON"
	cont "que je voulais."
else
	text "WILLIAM: Well, I'm"
	line "satisfied because"

	para "I caught a #MON"
	line "that I wanted."
endc

	done

BugCatchingContestant5BText: 
if DEF(_FR_FR)
	text "FOULQUE: Bien!"
	line "J'te respecte,"
	cont "toi!"
else
	text "BENNY: Congrats!"
	line "You have earned my"
	cont "respect!"
endc

	done

BugCatchingContestant5BStillCompetingText: 
if DEF(_FR_FR)
	text "FOULQUE: J'ai eu"
	line "un INSECATEUR une"
	cont "fois mais j'ai"
	cont "perdu."
else
	text "BENNY: I caught a"
	line "SCYTHER before,"
	cont "but I didn't win."
endc

	done

BugCatchingContestant6BText: 
if DEF(_FR_FR)
	text "RENE: Le #MON"
	line "que tu as chopé..."
	cont "Il est bien!"
else
	text "BARRY: That #-"
	line "MON you caught…"
	cont "it's awesome!"
endc

	done

BugCatchingContestant6BStillCompetingText: 
if DEF(_FR_FR)
	text "RENE: C'est plus"
	line "facile de gagner"

	para "en attrapant un"
	line "#MON de haut"
	cont "niveau."

	para "Mais je crois qu'"
	line "ils prennent d'au-"
	cont "tres points en"
	cont "compte."
else
	text "BARRY: It's easier"
	line "to win if you get"

	para "a high-level bug"
	line "#MON."

	para "But I think they"
	line "also consider some"
	cont "other points."
endc

	done

BugCatchingContestant7BText: 
if DEF(_FR_FR)
	text "SANDY: T'as gagné?"
	line "Mais c'est cool!"

	para "Tu veux chercher"
	line "des #MON"
	cont "insecte avec moi?"
else
	text "CINDY: You won?"
	line "That's great!"

	para "Do you feel like"
	line "looking for bug"
	cont "#MON with me?"
endc

	done

BugCatchingContestant7BStillCompetingText: 
if DEF(_FR_FR)
	text "SANDY: Moi j'aime"
	line "les #MON"
	cont "insecte!"
else
	text "CINDY: I really"
	line "love bug #MON!"
endc

	done

BugCatchingContestant8BText: 
if DEF(_FR_FR)
	text "ARNAUD: J'ai..."
	line "Perdu...au..."
	cont "Concours..."
else
	text "JOSH: I… I can't"
	line "believe I lost at"
	cont "bug-catching…"
endc

	done

BugCatchingContestant8BStillCompetingText: 
if DEF(_FR_FR)
	text "ARNAUD: On dit que"
	line "quelqu'un a gagné"
	cont "avec un CHENIPAN!"
else
	text "JOSH: I heard that"
	line "somebody won with"
	cont "a CATERPIE!"
endc

	done

BugCatchingContestant9BText: 
if DEF(_FR_FR)
	text "GONTRAND: Je vais"
	line "gagner la prochai-"
	cont "ne fois."
else
	text "SAMUEL: Next time,"
	line "I'm going to win."
endc

	done

BugCatchingContestant9BStillCompetingText: 
if DEF(_FR_FR)
	text "GONTRAND: Zut!"
	line "Je pensais vrai-"
	cont "ment gagner..."
else
	text "SAMUEL: Darn."
	line "I thought I would"
	cont "score higher…"
endc

	done

BugCatchingContestant10BText: 
if DEF(_FR_FR)
	text "CYRIL: Tu veux"
	line "bien me donner"

	para "des conseils?"
	line "J'aime ton style."
else
	text "KIPP: Could you"
	line "give me some tips?"

	para "I want to study"
	line "your style."
endc

	done

BugCatchingContestant10BStillCompetingText: 
if DEF(_FR_FR)
	text "CYRIL: J'étudie"
	line "beaucoup mais ce"
	cont "n'est pas assez."
else
	text "KIPP: I study a"
	line "lot, but that's"

	para "not good enough to"
	line "win."
endc

	done

UnusedSilphScope2Text: ; unreferenced
; This text is referring to Sudowoodo.
; The SILPHSCOPE2 was later reworked into the SQUIRTBOTTLE.
	text "I hear there's a"
	line "#MON that looks"
	cont "just like a tree."

	para "You can reveal its"
	line "identity using a"
	cont "SILPHSCOPE 2."
	done

UnusedBugCatchingContestExplanationText: 
if DEF(_FR_FR)
	text "Le Concours de"
	line "Capture se déroule"

	para "le mardi, le jeudi"
	line "et le samedi."

	para "On peut y gagner"
	line "un prix rien qu'en"

	para "participant mais"
	line "on garde aussi le"

	para "#MON insecte"
	line "que l'on chope"

	para "pendant le con-"
	line "cours."
else
; duplicate of BugCatchingContestExplanationText in Route35NationalParkGate.asm
	text "The Bug-Catching"
	line "Contest is held on"

	para "Tuesday, Thursday"
	line "and Saturday."

	para "Not only do you"
	line "earn a prize just"

	para "for participating,"
	line "you also get to"

	para "keep the bug"
	line "#MON you may"

	para "have at the end of"
	line "the contest."
endc

	done

Route36NationalParkGateOfficer1WellHoldPrizeText: 
if DEF(_FR_FR)
	text "Oh-oh... Ton SAC"
	line "est plein."

	para "On va garder ton"
	line "prix. Mais juste"
	cont "pour aujourd'hui."

	para "Fais de la place"
	line "et viens me voir."
else
	text "Uh-oh… Your PACK"
	line "is full."

	para "We'll hold on to"
	line "your prize, but"
	cont "only for today."

	para "Please make room,"
	line "then come see me."
endc

	done

Route36NationalParkGateOfficer1HeresThePrizeText: 
if DEF(_FR_FR)
	text "<PLAYER>?"

	para "Voilà ton prix."
	line "On l'a gardé pour"
	cont "toi."
else
	text "<PLAYER>?"

	para "Here's the prize"
	line "we were holding"
	cont "for you."
endc

	done

Route36NationalParkGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, NATIONAL_PARK, 1
	warp_event  0,  5, NATIONAL_PARK, 2
	warp_event  9,  4, ROUTE_36, 1
	warp_event  9,  5, ROUTE_36, 2

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_READ, BugCatchingContestExplanationSign

	def_object_events
	object_event  0,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36OfficerScriptContest, EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant1BScript, EVENT_BUG_CATCHING_CONTESTANT_1B
	object_event  4,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant2BScript, EVENT_BUG_CATCHING_CONTESTANT_2B
	object_event  2,  6, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant3BScript, EVENT_BUG_CATCHING_CONTESTANT_3B
	object_event  6,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant4BScript, EVENT_BUG_CATCHING_CONTESTANT_4B
	object_event  2,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant5BScript, EVENT_BUG_CATCHING_CONTESTANT_5B
	object_event  5,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant6BScript, EVENT_BUG_CATCHING_CONTESTANT_6B
	object_event  3,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant7BScript, EVENT_BUG_CATCHING_CONTESTANT_7B
	object_event  4,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant8BScript, EVENT_BUG_CATCHING_CONTESTANT_8B
	object_event  6,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant9BScript, EVENT_BUG_CATCHING_CONTESTANT_9B
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant10BScript, EVENT_BUG_CATCHING_CONTESTANT_10B
	object_event  3,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36NationalParkGateOfficerScript, EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
