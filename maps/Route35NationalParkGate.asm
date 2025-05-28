	object_const_def
	const ROUTE35NATIONALPARKGATE_OFFICER1
	const ROUTE35NATIONALPARKGATE_YOUNGSTER
	const ROUTE35NATIONALPARKGATE_OFFICER2

Route35NationalParkGate_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_ROUTE35NATIONALPARKGATE_NOTHING
	scene_script .DummyScene1 ; SCENE_ROUTE35NATIONALPARKGATE_UNUSED
	scene_script .LeaveContestEarly ; SCENE_ROUTE35NATIONALPARKGATE_LEAVE_CONTEST_EARLY

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
	setscene SCENE_ROUTE35NATIONALPARKGATE_NOTHING
	endcallback

.BugContestIsRunning:
	setscene SCENE_ROUTE35NATIONALPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

.CheckIfContestAvailable:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	disappear ROUTE35NATIONALPARKGATE_OFFICER1
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .EveryoneDisappears
	ifequal 1 << CURFEW, .EveryoneDisappears
	appear ROUTE35NATIONALPARKGATE_YOUNGSTER
	appear ROUTE35NATIONALPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear ROUTE35NATIONALPARKGATE_OFFICER1
.EveryoneDisappears
	disappear ROUTE35NATIONALPARKGATE_YOUNGSTER
	disappear ROUTE35NATIONALPARKGATE_OFFICER2
	endcallback

.LeavingContestEarly:
	applymovement PLAYER, Route35NationalParkGatePlayerApproachOfficer1Movement
	turnobject ROUTE35NATIONALPARKGATE_OFFICER1, RIGHT
	opentext
	readvar VAR_CONTESTMINUTES
	addval 1
	getnum STRING_BUFFER_3
	writetext Route35NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writetext Route35NationalParkGateOfficer1WaitAtNorthGateText
	waitbutton
	closetext
	jumpstd BugContestResultsWarpScript

.GoBackToContest:
	writetext Route35NationalParkGateOfficer1OkGoFinishText
	waitbutton
	closetext
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 10, 47
	end

Route35OfficerScriptContest:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, NationalParkLockdownMessage
	ifequal 1 << CURFEW, NationalParkLockdownMessage
	readvar VAR_WEEKDAY
	ifequal SUNDAY, Route35NationalParkGate_NoContestToday
	ifequal MONDAY, Route35NationalParkGate_NoContestToday
	ifequal WEDNESDAY, Route35NationalParkGate_NoContestToday
	ifequal FRIDAY, Route35NationalParkGate_NoContestToday
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route35NationalParkGate_ContestIsOver
	scall Route35NationalParkGate_GetDayOfWeek
	writetext Route35NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalse Route35NationalParkGate_DeclinedToParticipate
	readvar VAR_PARTYCOUNT
	ifgreater 1, Route35NationalParkGate_LeaveTheRestBehind
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
Route35NationalParkGate_OkayToProceed:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext Route35NationalParkGateOfficer1GiveParkBallsText
	promptbutton
	writetext Route35NationalParkGatePlayerReceivedParkBallsText
	playsound SFX_ITEM
	waitsfx
	writetext Route35NationalParkGateOfficer1ExplainsRulesText
	waitbutton
	closetext
	special GiveParkBalls
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	special SelectRandomBugContestContestants
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 10, 47
	end

NationalParkLockdownMessage:
	jumptextfaceplayer NationalParkLockdownText

Route35NationalParkGate_EnterContest:
	readvar VAR_FACING
	ifequal LEFT, Route35NationalParkGate_FacingLeft
	applymovement PLAYER, Route35NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement
	end

Route35NationalParkGate_FacingLeft:
	applymovement PLAYER, Route35NationalParkGatePlayerEnterParkMovement
	end

Route35NationalParkGate_LeaveTheRestBehind:
	readvar VAR_PARTYCOUNT
	ifless PARTY_LENGTH, Route35NationalParkGate_LessThanFullParty
	readvar VAR_BOXSPACE
	ifequal 0, Route35NationalParkGate_NoRoomInBox

Route35NationalParkGate_LessThanFullParty:
	special CheckFirstMonIsEgg
	ifequal TRUE, Route35NationalParkGate_FirstMonIsEgg
	writetext Route35NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse Route35NationalParkGate_DeclinedToLeaveMonsBehind
	special ContestDropOffMons
	iftrue Route35NationalParkGate_FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext Route35NationalParkGateOfficer1WellHoldYourMonText
	promptbutton
	writetext Route35NationalParkGatePlayersMonLeftWithHelperText
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump Route35NationalParkGate_OkayToProceed

Route35NationalParkGate_DeclinedToParticipate:
	writetext Route35NationalParkGateOfficer1TakePartInFutureText
	waitbutton
	closetext
	end

Route35NationalParkGate_DeclinedToLeaveMonsBehind:
	writetext Route35NationalParkGateOfficer1ChooseMonAndComeBackText
	waitbutton
	closetext
	end

Route35NationalParkGate_FirstMonIsFainted:
	writetext Route35NationalParkGateOfficer1FirstMonCantBattleText
	waitbutton
	closetext
	end

Route35NationalParkGate_NoRoomInBox:
	writetext Route35NationalParkGateOfficer1MakeRoomText
	waitbutton
	closetext
	end

Route35NationalParkGate_FirstMonIsEgg:
	writetext Route35NationalParkGateOfficer1EggAsFirstMonText
	waitbutton
	closetext
	end

Route35NationalParkGate_ContestIsOver:
	writetext Route35NationalParkGateOfficer1ContestIsOverText
	waitbutton
	closetext
	end

Route35NationalParkGate_NoContestToday:
	jumptextfaceplayer Route35NationalParkGateOfficer1WeHoldContestsText

Route35NationalParkGateOfficerScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, NationalParkLockdownMessage
	ifequal 1 << CURFEW, NationalParkLockdownMessage
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route35NationalParkGate_ContestIsOver
	writetext Route35NationalParkGateOfficer1WeHoldContestsText
	waitbutton
	closetext
	end

Route35NationalParkGateYoungsterScript:
	jumptextfaceplayer Route35NationalParkGateYoungsterText

BugCatchingContestExplanationSign:
	jumptext BugCatchingContestExplanationText

Route35NationalParkGate_GetDayOfWeek:
	jumpstd DayToTextScript
	end

Route35NationalParkGatePlayerApproachOfficer1Movement:
	step DOWN
	turn_head LEFT
	step_end

Route35NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement:
	step RIGHT
	step UP
	step UP
	step_end

Route35NationalParkGatePlayerEnterParkMovement:
	step UP
	step_end

Route35NationalParkGateOfficer1AskToParticipateText: 
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

	para "Avec un #MON de"
	line "l'équipe, il faut"

	para "attraper un #-"
	line "MON insecte qui"
	cont "sera noté."

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

Route35NationalParkGateOfficer1GiveParkBallsText: 
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

Route35NationalParkGatePlayerReceivedParkBallsText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "{d:BUG_CONTEST_BALLS} PARC BALLS."
else
	text "<PLAYER> received"
	line "{d:BUG_CONTEST_BALLS} PARK BALLS."
endc

	done

Route35NationalParkGateOfficer1ExplainsRulesText: 
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

Route35NationalParkGateOfficer1AskToUseFirstMonText: 
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

Route35NationalParkGateOfficer1WellHoldYourMonText: 
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

Route35NationalParkGatePlayersMonLeftWithHelperText: 
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

Route35NationalParkGateOfficer1ChooseMonAndComeBackText: 
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

Route35NationalParkGateOfficer1TakePartInFutureText: 
if DEF(_FR_FR)
	text "OK. Et bien"
	line "à la prochaine."
else
	text "OK. We hope you'll"
	line "take part in the"
	cont "future."
endc

	done

Route35NationalParkGateOfficer1FirstMonCantBattleText: 
if DEF(_FR_FR)
	text "Oh-oh..."
	line "Le premier #MON"

	para "de ton équipe ne"
	line "peut combattre."

	para "Change-le avec le"
	line "#MON de ton"

	para "choix et viens me"
	line "voir."
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

Route35NationalParkGateOfficer1MakeRoomText: 
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

Route35NationalParkGateOfficer1EggAsFirstMonText: 
if DEF(_FR_FR)
	text "Oh-oh... Tu as un"
	line "OEUF en premier"
	cont "dans ton équipe."

	para "Change-le avec le"
	line "#MON de ton"

	para "choix et viens me"
	line "voir."
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

Route35NationalParkGateOfficer1WantToFinishText: 
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

Route35NationalParkGateOfficer1WaitAtNorthGateText: 
if DEF(_FR_FR)
	text "OK. Attends à la"
	line "Porte Nord pour"

	para "connaître le nom"
	line "des vainqueurs."
else
	text "OK. Please wait at"
	line "the North Gate for"

	para "the announcement"
	line "of the winners."
endc

	done

Route35NationalParkGateOfficer1OkGoFinishText: 
if DEF(_FR_FR)
	text "OK. Retourne de-"
	line "hors et termine."
else
	text "OK. Please get"
	line "back outside and"
	cont "finish up."
endc

	done

Route35NationalParkGateOfficer1ContestIsOverText: 
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

Route35NationalParkGateOfficer1WeHoldContestsText: 
if DEF(_FR_FR)
	text "Il y a des con-"
	line "cours régulière-"

	para "ment au PARC."
	line "Inscris-toi!"
else
	text "We hold Contests"
	line "regularly in the"

	para "PARK. You should"
	line "give it a shot."
endc

	done

Route35NationalParkGateYoungsterText: 
if DEF(_FR_FR)
	text "C'est pour quand"
	line "le prochain Con-"
	cont "cours de Capture?"
else
	text "When is the next"
	line "Bug-Catching Con-"
	cont "test going to be?"
endc

	done

BugCatchingContestExplanationText: 
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

NationalParkLockdownText: ; TO TRANSLATE
	text "How did you sneak"
	line "up in here?"
	
	para "It's past curfew,"
	line "go home!"
	done

Route35NationalParkGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  0, NATIONAL_PARK, 3
	warp_event  4,  0, NATIONAL_PARK, 4
	warp_event  3,  7, ROUTE_35, 3
	warp_event  4,  7, ROUTE_35, 3

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, BugCatchingContestExplanationSign

	def_object_events
	object_event  1,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35OfficerScriptContest, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  6,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route35NationalParkGateYoungsterScript, EVENT_ROUTE_35_NATIONAL_PARK_GATE_YOUNGSTER
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35NationalParkGateOfficerScript, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
