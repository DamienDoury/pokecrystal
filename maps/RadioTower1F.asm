	object_const_def
	const RADIOTOWER1F_RECEPTIONIST
	const RADIOTOWER1F_VP_CONTROLLER
	const RADIOTOWER1F_LASS
	const RADIOTOWER1F_YOUNGSTER
	const RADIOTOWER1F_ROCKET
	const RADIOTOWER1F_LUCKYNUMBERMAN
	const RADIOTOWER1F_CARD_WOMAN

RadioTower1F_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	
	readvar VAR_YCOORD
	ifless 6, .end

	checkevent EVENT_GOLDENROD_CITY_CIVILIANS
	iftrue .end

	jumpstd VaccinePassCheckpoint
.end
	end

RadioTower1FReceptionistScript:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .Rockets
	writetext RadioTower1FReceptionistWelcomeText
	waitbutton
	closetext
	end

.Rockets:
	writetext RadioTower1FReceptionistNoToursText
	waitbutton
	closetext
	end

RadioTower1FLuckyNumberManScript:
	faceplayer
	opentext
	writetext RadioTower1FLuckyNumberManAskToPlayText
	promptbutton
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue .skip
	special ResetLuckyNumberShowFlag
.skip
	special PrintTodaysLuckyNumber
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue .GameOver
	writetext RadioTower1FLuckyNumberManThisWeeksIdIsText
	promptbutton
	closetext
	applymovement RADIOTOWER1F_LUCKYNUMBERMAN, RadioTower1FLuckyNumberManGoToPCMovement
	opentext
	writetext RadioTower1FLuckyNumberManCheckIfMatchText
	promptbutton
	waitsfx
	writetext RadioTower1FLuckyNumberManDotDotDotText
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	promptbutton
	special CheckForLuckyNumberWinners
	closetext
	applymovement RADIOTOWER1F_LUCKYNUMBERMAN, RadioTower1FLuckyNumberManReturnToPlayerMovement
	opentext
	ifequal 1, .FirstPlace
	ifequal 2, .SecondPlace
	ifequal 3, .ThirdPlace
	sjump .NoPrize

.GameOver:
	writetext RadioTower1FLuckyNumberManComeAgainText
	waitbutton
	closetext
	end

.FirstPlace:
	writetext RadioTower1FLuckyNumberManPerfectMatchText
	playsound SFX_1ST_PLACE
	waitsfx
	promptbutton
	giveitem MASTER_BALL
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	sjump .GameOver

.SecondPlace:
	writetext RadioTower1FLuckyNumberManOkayMatchText
	playsound SFX_2ND_PLACE
	waitsfx
	promptbutton
	giveitem EXP_SHARE
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	sjump .GameOver

.ThirdPlace:
	writetext RadioTower1FLuckyNumberManWeakMatchText
	playsound SFX_3RD_PLACE
	waitsfx
	promptbutton
	giveitem PP_UP
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	sjump .GameOver

.NoPrize:
	writetext RadioTower1FLuckyNumberManNoneOfYourIDNumbersMatchText
	waitbutton
	closetext
	end

.BagFull:
	writetext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	waitbutton
	closetext
	end

RadioTower1FRadioCardWomanScript:
	faceplayer
	opentext
	checkflag ENGINE_RADIO_CARD
	iftrue .GotCard
	writetext RadioTower1FRadioCardWomanOfferQuizText
	yesorno
	iffalse .NoQuiz
	writetext RadioTower1FRadioCardWomanQuestion1Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion2Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion3Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion4Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion5Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanYouWinText
	promptbutton
	getstring STRING_BUFFER_4, .RadioCardText
	scall .ReceiveItem
	writetext RadioTower1FPokegearIsARadioText
	promptbutton
	setflag ENGINE_RADIO_CARD
.GotCard:
	writetext RadioTower1FRadioCardWomanTuneInText
	waitbutton
	closetext
	end

.RadioCardText: 
if DEF(_FR_FR)
	db "COUPON RADIO@"

else
	db "RADIO CARD@"

endc

.ReceiveItem:
	jumpstd ReceiveItemScript

.WrongAnswer:
	playsound SFX_WRONG
	writetext RadioTower1FRadioCardWomanWrongAnswerText
	waitbutton
	closetext
	end

.NoQuiz:
	writetext RadioTower1FRadioCardWomanNotTakingQuizText
	waitbutton
	closetext
	end

RadioTower1FLassScript:
	jumptextfaceplayer RadioTower1FLassText

RadioTower1FYoungsterScript:
	jumptextfaceplayer RadioTower1FYoungsterText

TrainerGruntM3:
	trainer GRUNTM, GRUNTM_3, EVENT_BEAT_ROCKET_GRUNTM_3, GruntM3SeenText, GruntM3BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM3AfterBattleText

RadioTower1FDirectory:
	jumptext RadioTower1FDirectoryText

RadioTower1FLuckyChannelSign:
	jumptext RadioTower1FLuckyChannelSignText

RadioTower1FLuckyNumberManGoToPCMovement:
	step RIGHT
	turn_head UP
	step_end

RadioTower1FLuckyNumberManReturnToPlayerMovement:
	step LEFT
	turn_head UP
	step_end

RadioTower1FReceptionistWelcomeText: 
if DEF(_FR_FR)
	text "Bienvenue!"
else
	text "Welcome!"
endc

	done

RadioTower1FReceptionistNoToursText: 
if DEF(_FR_FR)
	text "Bonjour."
	line "Il n'y a pas de"
	cont "visite prévue"
	cont "aujourd'hui."
else
	text "Hello. I'm sorry,"
	line "but we're not"
	cont "offering any tours"
	cont "today."
endc

	done

RadioTower1FLuckyNumberManAskToPlayText: 
if DEF(_FR_FR)
	text "Salut! Es-tu ici"
	line "pour le SHOW du"
	cont "BON NUMERO?"

	para "Veux-tu que je re-"
	line "garde le No. ID de"
	cont "tes #MON?"

	para "Si tu as de la"
	line "chance, tu gagne-"
	cont "ras un prix."
else
	text "Hi, are you here"
	line "for the LUCKY NUM-"
	cont "BER SHOW?"

	para "Want me to check"
	line "the ID numbers of"
	cont "your #MON?"

	para "If you get lucky,"
	line "you win a prize."
endc

	done

RadioTower1FLuckyNumberManThisWeeksIdIsText:
if DEF(_FR_FR)
	text "Le No. ID d'au-"
	line "jourd'hui est..."
	cont "@"
	text_ram wStringBuffer3
	text "!"
else
	text "Today's ID"
	line "number is @"
	text_ram wStringBuffer3
	text "."
endc
	done

RadioTower1FLuckyNumberManCheckIfMatchText: 
if DEF(_FR_FR)
	text "Voyons si cela"
	line "correspond."
else
	text "Let's see if you"
	line "have a match."
endc

	done

RadioTower1FLuckyNumberManDotDotDotText:
	text "<……>"
	line "<……>"
	done

RadioTower1FLuckyNumberManComeAgainText: 
if DEF(_FR_FR)
	text "A la prochaine"
	line "fois pour un au-"
	cont "tre BON NUMERO."
else
	text "Please come back"
	line "next week for the"
	cont "next LUCKY NUMBER."
endc

	done

RadioTower1FLuckyNumberManPerfectMatchText: 
if DEF(_FR_FR)
	text "Oh! Tes 5 numéros"
	line "correspondent"
	cont "parfaitement!"

	para "Tu es le grand"
	line "vainqueur!"

	para "Tu remportes une"
	line "MASTER BALL!"
else
	text "Wow! You have a"
	line "perfect match of"
	cont "all five numbers!"

	para "We have a grand"
	line "prize winner!"

	para "You have won a"
	line "MASTER BALL!"
endc

	done

RadioTower1FLuckyNumberManOkayMatchText: 
if DEF(_FR_FR)
	text "Hé! Tes trois der-"
	line "niers numéros"
	cont "correspondent!"

	para "Tu remportes le"
	line "deuxième prix:"
	cont "un MULTI EXP!"
else
	text "Hey! You've"
	line "matched the last"
	cont "three numbers!"

	para "You've won second"
	line "prize, an EXP."
	cont "SHARE!"
endc

	done

RadioTower1FLuckyNumberManWeakMatchText: 
if DEF(_FR_FR)
	text "Hé! Tes deux der-"
	line "niers numéros"
	cont "correspondent!"

	para "Tu remportes le"
	line "troisième prix:"
	cont "un PP PLUS!"
else
	text "Ooh, you've"
	line "matched the last"
	cont "two numbers."

	para "You've won third"
	line "prize, a PP UP."
endc

	done

RadioTower1FLuckyNumberManNoneOfYourIDNumbersMatchText: 
if DEF(_FR_FR)
	text "Non! Aucun de tes"
	line "numéros ID ne"
	cont "correspond."
else
	text "Nope, none of your"
	line "ID numbers match."
endc

	done

RadioTower1FLuckyNumberManNoRoomForYourPrizeText: 
if DEF(_FR_FR)
	text "Ton inventaire"
	line "est plein!"

	para "Fais de la place"
	line "et reviens vite."
else
	text "You've got no room"
	line "for your prize."

	para "Make room and come"
	line "back right away."
endc

	done

RadioTower1FRadioCardWomanOfferQuizText: 
if DEF(_FR_FR)
	text "Nous avons un quiz"
	line "disponible en ce"
	cont "moment."

	para "Réponds à 5 ques-"
	line "tions correctement"
	cont "pour gagner un"
	cont "COUPON RADIO."

	para "Glisse-le dans ton"
	line "#MATOS pour"

	para "écouter la radio"
	line "n'importe quand."

	para "Veux-tu jouer au"
	line "quiz?"
else
	text "We have a special"
	line "quiz campaign on"
	cont "right now."

	para "Answer five ques-"
	line "tions correctly to"
	cont "win a RADIO CARD."

	para "Slide it into your"
	line "#GEAR to play"

	para "the radio anytime,"
	line "anywhere."

	para "Would you like to"
	line "take the quiz?"
endc

	done

RadioTower1FRadioCardWomanQuestion1Text: 
if DEF(_FR_FR)
	text "Question 1:"

	para "Y a-t-il un #-"
	line "MON apparaissant"
	cont "uniquement le"
	cont "matin?"
else
	text "Question 1:"

	para "Is there a #MON"
	line "that appears only"
	cont "in the morning?"
endc

	done

RadioTower1FRadioCardWomanQuestion2Text: 
if DEF(_FR_FR)
	text "C'est exact!"
	line "Question 2:"

	para "Cette proposition"
	line "est-elle correcte?"

	para "On ne peut pas"
	line "acheter de BAIE à"
	cont "la BOUTIQUE."
else
	text "Correct!"
	line "Question 2:"

	para "Is this statement"
	line "correct?"

	para "You can't buy a"
	line "BERRY at a MART."
endc

	done

RadioTower1FRadioCardWomanQuestion3Text: 
if DEF(_FR_FR)
	text "Bravo!"
	line "Question 3:"

	para "CS01 contient-elle"
	line "FLASH?"
else
	text "Bull's-eye!"
	line "Question 3:"

	para "Does HM01 contain"
	line "the move FLASH?"
endc

	done

RadioTower1FRadioCardWomanQuestion4Text: 
if DEF(_FR_FR)
	text "Tout va bien!"
	line "Question 4:"

	para "ALBERT est-il le"
	line "CHAMPION de MAU-"

	para "VILLE et un utili-"
	line "sateur de #MON"
	cont "oiseaux?"
else
	text "So far so good!"
	line "Question 4:"

	para "Is FALKNER the"
	line "VIOLET GYM LEADER"

	para "who uses bird"
	line "#MON?"
endc

	done

RadioTower1FRadioCardWomanQuestion5Text:
if DEF(_FR_FR)
	text "Encore gagné!"
	line "Voici la dernière"
	cont "question:"

	para "Est-ce que"
	line "NIDORINA est"
	cont "seulement mâle?"
else
	text "Wow! Right again!"
	line "Here's the final"
	cont "question:"

	para "Can NIDORINA be"
	line "male only?"
endc
	done

RadioTower1FRadioCardWomanYouWinText: 
if DEF(_FR_FR)
	text "Bingo! Gagné!"
	line "Félicitations!"

	para "Voici ton prix: un"
	line "COUPON RADIO!"
else
	text "Bingo! You got it!"
	line "Congratulations!"

	para "Here's your prize,"
	line "a RADIO CARD!"
endc

	done

RadioTower1FPokegearIsARadioText: 
if DEF(_FR_FR)
	text "Le #MATOS de"
	line "<PLAYER> peut main-"
	cont "tenant servir de"
	cont "radio!"
else
	text "<PLAYER>'s #GEAR"
	line "can now double as"
	cont "a radio!"
endc

	done

RadioTower1FRadioCardWomanTuneInText: 
if DEF(_FR_FR)
	text "Ecoute bien nos"
	line "émissions!!!"
else
	text "Please tune in to"
	line "our radio shows."
endc

	done

RadioTower1FRadioCardWomanWrongAnswerText: 
if DEF(_FR_FR)
	text "Oh là làààà!!!"
	line "C'est la mauvaise"

	para "réponse! Essaie"
	line "une autre fois!"
else
	text "Oh, dear."
	line "Sorry, but you"

	para "got it wrong."
	line "Please try again!"
endc

	done

RadioTower1FRadioCardWomanNotTakingQuizText: 
if DEF(_FR_FR)
	text "Oh. Je vois."
	line "N'hésite pas si tu"
	cont "changes d'avis."
else
	text "Oh. I see. Please"
	line "see me if you"
	cont "change your mind."
endc

	done

RadioTower1FLassText: 
if DEF(_FR_FR)
	text "BEN est un super"
	line "DJ!!!"

	para "Sa voix me fait"
	line "super craquer!"
else
	text "BEN is a fabulous"
	line "DJ."

	para "His sweet voice"
	line "makes me melt!"
endc

	done

RadioTower1FYoungsterText: 
if DEF(_FR_FR)
	text "J'adore LULA de la"
	line "CHRONIQUE #MON."

	para "En tout cas j'ado-"
	line "re sa voix..."
	cont "C'est déjà ça."
else
	text "I love MARY, from"
	line "#MON TALK."

	para "I only know what"
	line "she sounds like,"
	cont "though."
endc

	done

GruntM3SeenText:
if DEF(_FR_FR)
	text "Nous avons enfin"
	line "envahi la TOUR"
	cont "RADIO!"

	para "Et maint'nant on"
	line "va mettre fin à"
	cont "ce misérable mode"
	cont "mode de vie!"
else
	text "We've finally"
	line "taken over the"
	cont "RADIO TOWER!"

	para "Now we will put"
	line "an end to this"

	para "miserable way of"
	line "life!"
endc
	done

GruntM3BeatenText: 
if DEF(_FR_FR)
	text "Trop fort! Toi"
	line "on t'a à l'oeil!"
else
	text "Too strong! We"
	line "must watch you…"
endc

	done

GruntM3AfterBattleText: 
if DEF(_FR_FR)
	text "Trop balèze."

	para "Je dois prévenir"
	line "les autres. Tu es"
	cont "un danger..."
else
	text "You're too strong."

	para "Our plan could be"
	line "ruined. I must"
	cont "warn the others…"
endc

	done

RadioTower1FDirectoryText: 
if DEF(_FR_FR)
	text "RDC  RECEPTION"
	line "1ER  VENTES"

	para "2EME PERSONNEL"
	line "3EME PRODUCTION"

	para "4EME BUREAU"
	line "     DIRECTION"
else
	text "1F RECEPTION"
	line "2F SALES"

	para "3F PERSONNEL"
	line "4F PRODUCTION"

	para "5F DIRECTOR'S"
	line "   OFFICE"
endc

	done

RadioTower1FLuckyChannelSignText: 
if DEF(_FR_FR)
	text "ANTENNE LA CHANCE!"

	para "Gagnez grâce aux"
	line "No. ID de vos"
	cont "#MON!"

	para "Echangez vos #-"
	line "MON pour avoir"
	cont "plus de No. ID!"
else
	text "LUCKY CHANNEL!"

	para "Win with #MON"
	line "ID numbers!"

	para "Trade your #MON"
	line "to collect differ-"
	cont "ent ID numbers!"
endc

	done

RadioTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 11
	warp_event  3,  7, GOLDENROD_CITY, 11
	warp_event 15,  0, RADIO_TOWER_2F, 2

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower1FDirectory
	bg_event 13,  0, BGEVENT_READ, RadioTower1FLuckyChannelSign

	def_object_events
	object_event  5,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower1FReceptionistScript, -1
	object_event  0,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, EVENT_GOLDENROD_CITY_CIVILIANS ; Should always be at the second spot in the list.
	object_event 16,  4, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower1FLassScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 15,  4, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FYoungsterScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  8,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FLuckyNumberManScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 12,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower1FRadioCardWomanScript, EVENT_GOLDENROD_CITY_CIVILIANS
