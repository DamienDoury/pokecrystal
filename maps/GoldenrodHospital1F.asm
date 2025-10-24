	object_const_def
	const GOLDENROD_HOSPITAL_RECEPTIONIST1
	const GOLDENROD_HOSPITAL_RECEPTIONIST2
	const GOLDENROD_HOSPITAL_CHANSEY1
	const GOLDENROD_HOSPITAL_SCIENTIST_THANKFUL
	const GOLDENROD_HOSPITAL_PATIENT1
	const GOLDENROD_HOSPITAL_PATIENT2
	const GOLDENROD_HOSPITAL_PATIENT3
	;const GOLDENROD_HOSPITAL_PATIENT4

GoldenrodHospital1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	setval 0
	writemem wGoldenrodHospitalCorridorNumber ; Resetting the corridor count.
	readvar VAR_XCOORD
	ifnotequal 5, .quit
	readvar VAR_YCOORD
	ifnotequal 9, .quit
	setscene SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS
.quit:
	endcallback

GoldenrodHospitalNurse1Script:
	faceplayer
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iffalse GoldenrodHospitalTakeover

	checkscene
	ifequal SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS, AskGelScript

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .CleanHands

	opentext
	writetext GoldenrodHospitalCleanHandsText
	promptbutton
	closetext
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.CleanHands:
	checkmapscene GOLDENROD_HOSPITAL_CORRIDOR
	ifequal 0, .regulartext
	ifequal 1, .quest1_advance
	ifequal 2, .quest2_text
	ifequal 3, .quest3_advance
	ifgreater 3, .quest4_text

.quest1_advance:
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_2
.quest2_text:
	jumptext GoldenrodHospitalNurse1Step1Text

.quest3_advance:
	setmapscene GOLDENROD_HOSPITAL_CORRIDOR, SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_4
.quest4_text
	jumptext GoldenrodHospitalNurse1Step3Text

.regulartext
	checkevent EVENT_PLAYER_CAN_GET_ITS_FIRST_SHOT
	iftrue .chief_waiting

	checkevent EVENT_PLAYER_CAN_GET_ITS_SECOND_SHOT
	iftrue .chief_waiting

	opentext
	callasm HasPlayerClappedALotInThisRoom_WithReset
	iffalse .show_regular_text

	farwritetext GoldenrodHospital1F_ClappedText
	promptbutton

.show_regular_text
	writetext GoldenrodHospitalNurse1Text
	waitbutton
	closetext
	end

.chief_waiting
	jumptext GoldenrodHospitalChiefWaitingText

GoldenrodHospitalTakeover:
	jumptext GoldenrodHospitalTakeoverNurse1Text

GoldenrodHospitalNurse2Script:
	faceplayer 
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iffalse GoldenrodHospitalTakeover
	checkscene
	ifequal SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS, AskGelScript.warning_text

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .CleanHands

	opentext
	writetext GoldenrodHospitalCleanHandsText
	promptbutton
	closetext
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.CleanHands:
	opentext
	writetext GoldenrodHospitalNurse2Text_Intro
	waitbutton
	closetext

	checkflag ENGINE_TRAINER_CARD
	iffalse .NoTrainerCard

	applymovement GOLDENROD_HOSPITAL_RECEPTIONIST1, Hospital_NurseWalksToPC
	playsound SFX_BOOT_PC
	waitsfx
	pause 30

	applymovement GOLDENROD_HOSPITAL_RECEPTIONIST1, Hospital_NurseWalksBackFromPC
	faceplayer
	pause 1

	special GetQuantityOfHospitalizedMons
	getnum STRING_BUFFER_3
	
	opentext
	ifequal 0, .NoMon
	
	writetext GoldenrodHospitalNurse2Text_MonQuantity
	promptbutton

	ifequal 1, .SingleMon

	addval 4
	getnum STRING_BUFFER_3
	writetext GoldenrodHospitalNurse2Text_Reside
	sjump .CheckRecoveredMons

.NoTrainerCard:
	jumptext GoldenrodHospitalNurse2Text_NoTrainerCard

.SingleMon:
	writetext GoldenrodHospitalNurse2Text_Room5Solo	

.CheckRecoveredMons:
	special IsFirstHospitalMonReadyToLeave
	ifequal 0, .End

	promptbutton
	writetext GoldenrodHospitalNurse2Text_GoodNews
	promptbutton

	readvar VAR_PARTYCOUNT
	ifgreater 5, .PartyFullAtStart

	writetext GoldenrodHospitalNurse2Text_AreYouReady
	yesorno
	iftrue .PlayerAccepted
	writetext GoldenrodHospitalNurse2Text_ComeBackSoon
	sjump .End

.PlayerAccepted
	writetext GoldenrodHospitalNurse2Text_SignPapers
	readvar VAR_FACING
	ifequal LEFT, .InFrontOfPapers
	
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_RECEPTIONIST1, RIGHT
	pause 15
 	applymovement PLAYER, Hospital_PlayerWalksToPapers
	pause 15
	opentext
	sjump .HasSignedPapers

.InFrontOfPapers:
	promptbutton

.HasSignedPapers:
	; At this point, the player must have at least 1 available spot in its party, and 1 mon in the hospital box.
	special CountHospitalMonsReadyToLeave

.Loop:
	special RetrieveFirstMonFromHospitalBox

	writetext GoldenrodHospitalNurse2Text_MonReadyToLeave
	playsound SFX_KEY_ITEM
	waitsfx
	promptbutton	

	addval $ff ;-1
	ifgreater 0, .Loop

	special IsFirstHospitalMonReadyToLeave
	ifgreater 0, .ComeBackLater

	writetext GoldenrodHospitalNurse2Text_TakeCare
	sjump .End

.ComeBackLater:
	writetext GoldenrodHospitalNurse2Text_PartyFull2
	sjump .End

.PartyFullAtStart:
	writetext GoldenrodHospitalNurse2Text_PartyFull

.End:
	waitbutton
	closetext
	end

.NoMon:
	writetext GoldenrodHospitalNurse2Text_NoMon
	waitbutton
	closetext
	end

AskGelScript:
	callasm HasPlayerClappedALotInThisRoom_WithReset
	iffalse .warning_text

	opentext
	farwritetext GoldenrodHospital1F_ClappedText
	promptbutton
	sjump .skip_open_text

.warning_text
	opentext
.skip_open_text
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	writetext GoldenrodHospitalAskGelText ; Avoiding the use of jumptextfaceplayer prevents the display of the clap dialog.
	waitbutton
	closetext
	end

GoldenrodHospitalGelScript:
	setmapscene GOLDENROD_HOSPITAL_1F, SCENE_GOLDENROD_HOSPITAL_DEFAULT
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleHandWash
	writetext GoldenrodHospital1FWashHandsMaleText
	sjump .boops

.FemaleHandWash:
	writetext GoldenrodHospital1FWashHandsFemaleText

.boops:
	waitsfx
	playsound SFX_2_BOOPS
	waitsfx
	pause 10
	closetext
	end

GoldenrodHospitalThankOakScript:
	faceplayer
	jumptext GoldenrodHospital1FThankOakText ; This specific NPC is part of the medical staff, and shouldn't clap at himself. So we use jumptext instead of jumptextfaceplayer.

GoldenrodHospitalChansey1Script:
	cry CHANSEY
	jumptext GoldenrodHospitalChanseySeriousText

GoldenrodHospitalChanseyKicksYouScript:
	cry CHANSEY
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, GOLDENROD_HOSPITAL_CHANSEY1, 15
	waitsfx
	pause 10
	applymovement PLAYER, GoldenrodHospital_PlayerDownMovement
	end

GoldenrodHospitalPokefan1Script:
	jumptextfaceplayer GoldenrodHospitalPokefan1Text

GoldenrodHospitalBlackglassesScript:
	jumptext GoldenrodHospitalPharmacist1Text ; This specific NPC doesn't have a clapping animation, so we use jumptext instead of jumptextfaceplayer.

GoldenrodHospitalTwin1Script:
	jumptextfaceplayer GoldenrodHospital1FTwin1Text

GoldenrodHospitalDepressedScientistScript:
	faceplayer
	jumptext GoldenrodHospitalDepressedScientistText ; This specific NPC is part of the medical staff, and shouldn't clap at himself. So we use jumptext instead of jumptextfaceplayer.

GoldenrodHospitalCoughScript:
	jumptextfaceplayer GoldenrodHospital1FCoughText

GoldenrodHospitalKarenScript:
	jumptext GoldenrodHospitalKarenText

GoldenrodHospitalGranny1Script:
	jumptextfaceplayer GoldenrodHospitalGranny1Text

GoldenrodHospitalNursePatientScript:
	callasm HasPlayerClappedALotInThisRoom_WithReset
	iftrue .clapped

	jumptext GoldenrodHospitalNursePatientText
.clapped
	jumptext GoldenrodHospital1FCoughText
	
GoldenrodHospitalRocketScript:
	jumptext GoldenrodHospitalRocketText

GoldenrodHospitalRocketCounterScript:
	jumptext GoldenrodHospitalRocketCounterText

GoldenrodHospitalRocket3Script:
	faceplayer
	jumptext GoldenrodHospitalRocket3Text

GoldenrodHospital1FChiefNursePanel:
	jumptext GoldenrodHospital1FChiefNursePanelText

GoldenrodHospital1FScanner:	
	checkflag ENGINE_TRAINER_CARD
	iffalse .NoTrainerCard

	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .FemaleScanner
	writetext GoldenrodHospitalScannerMaleText
	sjump .AfterScan

.FemaleScanner:
	writetext GoldenrodHospitalScannerFemaleText

.AfterScan:
	promptbutton
	closetext
	pause 15
	playsound SFX_WRONG; OK sound = SFX_ELEVATOR_END
	waitsfx
	pause 5
	opentext
	writetext GoldenrodHospitalScanFailText
	waitbutton
	closetext
	end

.NoTrainerCard:
	jumptext GoldenrodHospitalScanDescriptionText

GoldenrodHospitalLockScript:
	jumptext GoldenrodHospitalLockText

GoldenrodHospital_PlayerDownMovement:
	slow_step DOWN
	step_end

GoldenrodHospital1FWashHandsMaleText:
	text_far _PlayersPCSanitizerText
	text_end

GoldenrodHospital1FWashHandsFemaleText:
	text_far _PlayersPCSanitizerFemaleText
	text_end

GoldenrodHospital1fMaxPotion:
	hiddenitem MAX_POTION, EVENT_GOLDENROD_1F_CORRIDOR_MAX_POTION

GoldenrodHospitalNurse1Text:
if DEF(_FR_FR)
	text "Bienvenue!"

	para "Veuillez noter que"
	line "si vous avez un"
	cont "#MON malade,"
	cont "nous ne pouvons"
	cont "pas le prendre."

	para "Nos places sont"
	line "limitées, et nous"
	cont "ne pouvons pas"
	cont "accueillir tout"
	cont "le monde."

	para "Seules les infir-"
	line "mières des CENTRES"
	cont "#MON sont habi-"
	cont "litées à décider"
	cont "si un #MON doit"
	cont "être envoyé ici."
else
	text "Welcome!"

	para "Please understand"
	line "that if you have a"
	cont "sick #MON, we"
	cont "can't take it in."

	para "We have a limited"
	line "number of rooms,"
	cont "and can't take"
	cont "everyone in."

	para "Only nurses at"
	line "#MON CENTERS"
	cont "are habilitated"
	cont "to determine if a"
	cont "#MON needs to"
	cont "be sent here."
endc
	done

GoldenrodHospitalNurse1Step1Text:
if DEF(_FR_FR)
	text "L'INFIRMIERE EN"
	line "CHEF?"

	para "Je ne l'ai pas"
	line "vue depuis un"
	cont "bon moment."

	para "Elle doit être"
	line "dans son bureau."

	para "C'est la porte"
	line "derrière moi, à"
	cont "côté de la salle"
	cont "d'attente."
else
	text "CHIEF NURSE JOY?"
	
	para "I haven't seen"
	line "her in a while."
	
	para "She must be in"
	line "her office."
	
	para "That's the door"
	line "behind me, next to"
	cont "the waiting room."
endc
	done

GoldenrodHospitalNurse1Step3Text:
if DEF(_FR_FR)
	text "Si l'INFIRMIERE EN"
	line "CHEF n'est pas"
	cont "dans son bureau,"

	para "elle fait sûrement"
	line "sa tournée des"
	cont "chambres."

	para "C'est sur ta"
	line "droite."

	para "Elle bouge vite,"
	line "alors je te"
	cont "conseille de"
	cont "parler à tout le"
	cont "monde plusieurs"
	cont "fois."

	para "Si quelqu'un te dit"
	line "ne pas l'avoir vu,"
	cont "peut-être qu'il la"
	cont "croisera après."

	para "Bonne chance pour"
	line "la trouver."
else
	text "If CHIEF NURSE JOY"
	line "isn't in her office"

	para "she must be doing"
	line "her round in the"
	cont "patient rooms."

	para "It will be on your"
	line "right."
	
	para "She's moving fast,"
	line "so I advise you"

	para "to speak to every-"
	line "one several times."
	
	para "Because they didn't"
	line "see her earlier"

	para "doesn't mean they"
	line "didn't see her"
	cont "thereafter."
	
	para "Good luck"
	line "finding her."
endc
	done

GoldenrodHospitalChiefWaitingText:
if DEF(_FR_FR)
	text "Bienvenue!"

	para "L'INFIRMIERE EN"
	line "CHEF t'attend dans"
	cont "son bureau."
else
	text "Welcome!"

	para "The CHIEF is"
	line "waiting for you"
	cont "in her office."
endc
	done

GoldenrodHospitalChanseySeriousText:
if DEF(_FR_FR)
	text "Ce LEVEINARD a"
	line "l'air très sérieux."
else
	text "This CHANSEY"
	line "looks serious."
endc
	done

GoldenrodHospitalAskGelText:
if DEF(_FR_FR)
	text "Veuillez vous"
	line "laver les mains"
	cont "avec le gel hydro-"
	cont "alcoolique à"
	cont "l'entrée."
else
	text "Please wash your"
	line "hands using the"
	cont "hand sanitizer"
	cont "gel available"
	cont "at the entrance."
endc
	done

GoldenrodHospitalCleanHandsText:
if DEF(_FR_FR)
	text "Merci de vous être"
	line "lavé les mains."
else
	text "Thanks for washing"
	line "your hands."
endc
	done

GoldenrodHospital1FThankOakText:
if DEF(_FR_FR)
	text "Au tout début de"
	line "l'épidémie, plu-"
	cont "sieurs lanceurs"
	cont "d'alerte ont été"
	cont "ignorés ou moqués."

	para "Même si le PROF."
	line "CHEN n'est pas un"
	cont "spécialiste en"
	cont "épidémiologie, il"
	cont "est respecté et"
	cont "les gens suivent"
	cont "ses recomman-"
	cont "dations."

	para "Sans son inter-"
	line "vention, la situa-"
	cont "tion aurait pu"
	cont "être bien pire."

	para "Nous lui sommes"
	line "reconnaissants, à"
	cont "lui et à son"
	cont "équipe."
else
	text "At the very begin-"
	line "ning of the epi-"
	cont "demic several"
	cont "whistleblowers"
	cont "have been ignored"
	cont "or mocked."

	para "Even though PROF."
	line "OAK is not an"
	cont "epidemiology spe-"
	cont "cialist, he is"
	cont "respected and"
	cont "people listen to"
	cont "its guidance."

	para "Without its inter-"
	line "vention, the"
	cont "situation could"
	cont "have been way"
	cont "worse."

	para "We are thankful"
	line "for him and his"
	cont "team."
endc
	done

GoldenrodHospital1FTwin1Text:
if DEF(_FR_FR)
	text "A la télé, ils"
	line "disent que seuls"
	cont "les vieux peuvent"
	cont "tomber malade"
	cont "du virus."

	para "Mais mon frère"
	line "l'a eu, et je"
	cont "crois que c'est"
	cont "mon tour."
else
	text "On TV they say"
	line "only old people"
	cont "can get sick from"
	cont "the virus."

	para "But my brother got"
	line "it, and I think"
	cont "it's my turn now."
endc
	done

GoldenrodHospital1FCoughText:
if DEF(_FR_FR)
	text "(tousse) (tousse)"
	line "..."
else
	text "(cough) (cough)"
	line "…"
endc
	done

GoldenrodHospitalKarenText:
if DEF(_FR_FR)
	text "Je rends visite à"
	line "ma grand-mère."

	para "Elle..."
	
	para "Elle a attrapé"
	line "le virus."
else
	text "I'm visiting my"
	line "grandmother."

	para "She…"

	para "She caught"
	line "the virus."
endc
	done

GoldenrodHospitalPokefan1Text:
if DEF(_FR_FR)
	text "Mon cher #MON a"
	line "été amené ici en"
	cont "urgence..."

	para "Personne ne m'a"
	line "dit s'il allait"
	cont "bien."

	para "Je suis venue"
	line "prendre de ses"
	cont "nouvelles."
else
	text "My dear #MON"
	line "was brought here"
	cont "urgently…"

	para "No one informed me"
	line "if she is well."

	para "I came to check"
	line "on her."
endc
	done

GoldenrodHospitalPharmacist1Text:
if DEF(_FR_FR)
	text "Je ne suis pas sûr"
	line "de m'en sortir."

	para "(TOUSSE TOUSSE)"

	para "Ecoute bien,"
	line "bout de chou."

	para "Vis chaque jour"
	line "comme si c'était"
	cont "le dernier."

	para "On ne sait jamais"
	line "ce que demain"
	cont "réserve."
else
	text "I'm not sure"
	line "I'm gonna make it."

	para "(COUGH COUGH)"

	para "Listen kid."

	para "Live every day"
	line "like its your"
	cont "last day."

	para "You never know"
	line "what comes"
	cont "tomorrow."
endc
	done

GoldenrodHospitalGranny1Text:
if DEF(_FR_FR)
	text "J'attends ici"
	line "depuis dix heures"
	
	para "et c'est pas"
	line "fini..."
else
	text "I've been waiting"
	line "here 10 hours"
	cont "and counting…"
endc
	done

GoldenrodHospitalNursePatientText:
if DEF(_FR_FR)
	text "(tousse)"

	para "Même les infir-"
	line "mières peuvent"
	cont "tomber malades."

	para "Malgré toutes les"
	line "précautions, nous"
	cont "sommes les plus"
	cont "exposées et beau-"
	cont "coup de collègues"
	cont "tombent malades."
else
	text "(cough)"
	
	para "Even nurses"
	line "can get sick."

	para "Even though we are"
	line "taking a lot of"
	cont "precautions, we"
	cont "are the most"
	cont "exposed and a lot"
	cont "of my colleagues"
	cont "are getting sick."
endc
	done

GoldenrodHospitalRocketText:
if DEF(_FR_FR)
	text "Ouais, je suis"
	line "assis sur une"
	cont "place interdite."

	para "ET ALORS?"

	para "Je suis un rebelle"
	line "hé hé!"
else
	text "Yeah, I'm sitting"
	line "in a forbidden"
	cont "seat."

	para "SO WHAT?"

	para "I'm a rebel,"
	line "hehe!"
endc
	done

GoldenrodHospitalRocketCounterText:
if DEF(_FR_FR)
	text "Occupe-toi de tes"
	line "affaires, je suis"
	cont "occupé."
else
	text "Mind your own"
	line "business, I'm busy."
endc
	done

GoldenrodHospitalRocket3Text:
if DEF(_FR_FR)
	text "On s'est enfin"
	line "emparés de la"
	cont "TOUR RADIO!"
else
	text "Finally we own"
	line "the RADIO TOWER!"
endc
	done

GoldenrodHospitalTakeoverNurse1Text:
if DEF(_FR_FR)
	text "Je... je suis"
	line "désolée, je ne"
	cont "peux pas vous"
	cont "assister à cet"
	cont "instant..."
else
	text "I… I'm sorry"
	line "I can't help you"
	cont "at the moment…"
endc
	done

GoldenrodHospitalDepressedScientistText:
if DEF(_FR_FR)
	text "Nos lits de"
	line "réanimation sont"
	cont "utilisés à 100<PERCENT>"
	cont "de leur capacité,"
	cont "ce qui reste"
	cont "raisonnable."

	para "Dans quel sens?"

	para "Certains établis-"
	line "sements tournent à"
	cont "140<PERCENT> de leur"
	cont "capacité."

	para "Ils ont ajouté des"
	line "lits additionnels"
	cont "dans les chambres"
	cont "et parfois même"
	cont "dans les couloirs!"

	para "Le personnel fait"
	line "des heures sup et"
	cont "sans pauses."

	para "Si les patients"
	line "continuent d'affl-"
	cont "uer, notre orga-"
	cont "nisation va finir"
	cont "par s'effondrer."
else
	text "Our acute beds use"
	line "is at 100<PERCENT> of its"
	cont "capacity, which is"
	cont "reasonable."

	para "How so?"

	para "Some establish-"
	line "ments are working"
	cont "at up to 140<PERCENT> of"
	cont "their capacity."

	para "They added new"
	line "beds in existing"
	cont "rooms, and even in"
	cont "corridors!"

	para "Personel's working"
	line "extra hours at an"
	cont "increased pace."

	para "If patients keep"
	line "flowing in, our"
	cont "organization will"
	cont "end up collapsing."
endc
	done

GoldenrodHospital1FChiefNursePanelText:
if DEF(_FR_FR)
	text "INFIRMIERE EN CHEF"
else
	text " CHIEF NURSE JOY"
endc
	done

if DEF(_EN_US)
GoldenrodHospitalScannerFemaleText:
	text "<PLAYER> scans"
	line "her TRAINER CARD."
	done
endc

GoldenrodHospitalScannerMaleText:
if DEF(_FR_FR)
GoldenrodHospitalScannerFemaleText:
	text "<PLAYER> scanne"
	line "sa CARTE DRESSEUR."
else
	text "<PLAYER> scans"
	line "his TRAINER CARD."
endc
	done

GoldenrodHospitalScanFailText:
if DEF(_FR_FR)
	text "ACCES REFUSé"
else
	text "RESTRICTED"
endc
	done

GoldenrodHospitalScanDescriptionText:
if DEF(_FR_FR)
	text "C'est un lecteur"
	line "de CARTE DRESSEUR."

	para "Malheureusement tu"
	line "n'as pas la tienne."
else
	text "It's a TRAINER"
	line "CARD reader."

	para "Unfortunately you"
	line "don't have yours."
endc
	done

GoldenrodHospitalLockText:
if DEF(_FR_FR)
	text "Cette porte est"
	line "verrouillée"
	cont "électroniquement."
else
	text "This door is elec-"
	line "tronically locked."
endc
	done

GoldenrodHospitalNurse2Text_Intro:
if DEF(_FR_FR)
	text "Bonjour dresseur!"

	para "Laissez-moi véri-"
	line "fier si vous avez"
	cont "des #MON hospi-"
	cont "talisés ici."

	para "Prêtez-moi votre"
	line "CARTE DRESSEUR"
	cont "s'il vous plaît."
else
	text "Hello trainer!"

	para "Let me check if"
	line "any #MON of"
	cont "yours is in here."

	para "Show me your"
	line "TRAINER CARD"
	cont "please."
endc
	done

GoldenrodHospitalNurse2Text_NoTrainerCard:
if DEF(_FR_FR)
	text "Vous ne l'avez pas?"

	para "J'en ai besoin"
	line "pour vous aider."
else
	text "You don't have it?"

	para "I can't help you"
	line "without it."
endc
	done

GoldenrodHospitalNurse2Text_NoMon:
if DEF(_FR_FR)
	text "Vous avez du bol."
	line "Aucun de vos"
	cont "#MON ne se"
	cont "trouve dans cet"
	cont "hôpital."
else
	text "Lucky you, you"
	line "have no #MON in"
	cont "this hospital."
endc
	done

GoldenrodHospitalNurse2Text_MonQuantity:
if DEF(_FR_FR)
	text "Nous nous occupons"
	line "actuellement de"
	cont "@"

	text_ram wStringBuffer3
	text " d'entre eux."
else
	text "We are currently"
	line "taking care of @"

	text_ram wStringBuffer3
	text_start
	cont "of them."
endc
	done

GoldenrodHospitalNurse2Text_Room5Solo:
if DEF(_FR_FR)
	text "Vous le trouverez"
	line "dans la chambre 5."
else
	text "You'll find it in"
	line "room 5."
endc
	done

GoldenrodHospitalNurse2Text_Reside:
if DEF(_FR_FR)
	text "Ils se trouvent"
	line "dans les chambres"
	cont "5 à @"
	text_ram wStringBuffer3
	text "."
else
	text "They reside in"
	line "rooms 5 to @"
	text_ram wStringBuffer3
	text "."
endc
	done

GoldenrodHospitalNurse2Text_GoodNews:
if DEF(_FR_FR)
	text "Voici la bonne"
	line "nouvelle!"

	para "Certains de vos"
	line "#MON sont com-"
	cont "plètement rétablis"
	cont "et peuvent partir."
else
	text "Here is the"
	line "good news!"

	para "Some of your"
	line "#MON have fully"
	cont "recovered and are"
	cont "ready to leave."
endc
	done

GoldenrodHospitalNurse2Text_PartyFull:
if DEF(_FR_FR)
	text "Faites de la place"
	line "dans votre équipe"
	cont "et revenez les"
	cont "récupérer."
else
	text "Please make some"
	line "room in your party"
	cont "and come get them."
endc
	done

GoldenrodHospitalNurse2Text_AreYouReady:
if DEF(_FR_FR)
	text "Pouvez-vous les"
	line "récupérer"
	cont "maintenant?"
else
	text "Can you take them"
	line "away now?"
endc
	done

GoldenrodHospitalNurse2Text_SignPapers:
if DEF(_FR_FR)
	text "Signez ces papiers"
	line "et c'est tout bon!"
else
	text "Sign those papers"
	line "and they're"
	cont "good to go!"
endc
	done

GoldenrodHospitalNurse2Text_MonReadyToLeave:
if DEF(_FR_FR)
	text "<PLAYER> récupère"
	line "@"
	text_ram wStringBuffer1
	text "!"
else
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer1
	text " back!"
endc
	done

GoldenrodHospitalNurse2Text_PartyFull2:
if DEF(_FR_FR)
	text "Faites de la place"
	line "dans votre équipe"
	cont "pour récupérer"
	cont "les autres."
else
	text "Make room in your"
	line "party to get"
	cont "the others."
endc
	done

GoldenrodHospitalNurse2Text_ComeBackSoon:
if DEF(_FR_FR)
	text "Revenez dès que"
	line "possible."

	para "Nous devons libé-"
	line "rer les chambres"
	cont "pour d'autres"
	cont "patients."
else
	text "Come back as soon"
	line "as possible."
	
	para "We need to free"
	line "rooms for other"
	cont "patients."
endc
	done

GoldenrodHospitalNurse2Text_TakeCare:
if DEF(_FR_FR)
	text "Prenez soin d'eux"
	line "et de vous-même."
else
	text "Take good care of"
	line "them and yourself."
endc
	done

Hospital_NurseWalksToPC:
	slow_step UP
	slow_step LEFT
	slow_step LEFT
	turn_head UP
	step_end

Hospital_NurseWalksBackFromPC:
	slow_step RIGHT
	slow_step RIGHT
	slow_step DOWN
	step_end

Hospital_PlayerWalksToPapers:
	step RIGHT
	step RIGHT
	step UP
	step UP
	turn_head LEFT
	step_end

GoldenrodHospital1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  9, GOLDENROD_CITY, 16
	warp_event  6,  9, GOLDENROD_CITY, 16
	warp_event  5,  0, GOLDENROD_HOSPITAL_OFFICE, 1
	warp_event 19,  6, GOLDENROD_HOSPITAL_CORRIDOR, 1
	warp_event 19,  7, GOLDENROD_HOSPITAL_CORRIDOR, 2

	def_coord_events

	def_bg_events
	bg_event  7,  8, BGEVENT_READ, GoldenrodHospitalGelScript
	bg_event  4,  0, BGEVENT_READ, GoldenrodHospital1FChiefNursePanel
	bg_event 15,  9, BGEVENT_ITEM, GoldenrodHospital1fMaxPotion

	def_object_events
	object_event  7,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNurse2Script, -1
	object_event  5,  5, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNurse1Script, -1
	object_event 15,  5, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalChansey1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  1,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalThankOakScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  1, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | DAY, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalPokefan1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  1, SPRITE_NURSE, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalNursePatientScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  3, SPRITE_GRAMPS, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalCoughScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 16,  3, SPRITE_GRANNY, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalGranny1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 12,  3, SPRITE_TWIN, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalTwin1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 15,  1, SPRITE_KAREN, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalKarenScript, EVENT_ROUTE_36_SUDOWOODO
	object_event 15,  1, SPRITE_PHARMACIST, SPRITEMOVEDATA_STILL, 0, 0, -1, %11100000 | MORN | DAY, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalBlackglassesScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 13,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRocketScript, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRocketCounterScript, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRocket3Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, %11100000 | MORN | NITE, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalDepressedScientistScript, EVENT_GOLDENROD_CITY_CIVILIANS
