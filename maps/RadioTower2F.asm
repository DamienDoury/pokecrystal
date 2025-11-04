BLUE_CARD_POINT_CAP EQU 30

	object_const_def
	const RADIOTOWER2F_SUPER_NERD
	const RADIOTOWER2F_TEACHER
	const RADIOTOWER2F_ROCKET1
	const RADIOTOWER2F_ROCKET2
	const RADIOTOWER2F_ROCKET3
	const RADIOTOWER2F_ROCKET_GIRL
	const RADIOTOWER2F_BLACK_BELT1
	const RADIOTOWER2F_BLACK_BELT2
	const RADIOTOWER2F_JIGGLYPUFF
	const RADIOTOWER2F_BUENA
	const RADIOTOWER2F_RECEPTIONIST

RadioTower2F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower2FSuperNerdScript:
	checkevent EVENT_GOT_CLEAR_BELL
	iftrue .TeamRocketOpinion
	jumptextfaceplayer RadioTower2FSuperNerdText

.TeamRocketOpinion
	jumptextfaceplayer RadioTower2FSuperNerdTROpinionText

RadioTower2FTeacherScript:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .Rockets
	writetext RadioTower2FTeacherText
	waitbutton
	closetext
	end

.Rockets:
	writetext RadioTower2FTeacherText_Rockets
	waitbutton
	closetext
	end

RadioTowerJigglypuff:
	opentext
	writetext RadioTowerJigglypuffText
	cry JIGGLYPUFF
	waitbutton
	closetext
	end

RadioTower2FBlackBelt1Script:
	jumptextfaceplayer RadioTower2FBlackBelt1Text

RadioTower2FBlackBelt2Script:
	jumptextfaceplayer RadioTower2FBlackBelt2Text

TrainerGruntM4:
	trainer GRUNTM, GRUNTM_4, EVENT_BEAT_ROCKET_GRUNTM_4, GruntM4SeenText, GruntM4BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM4AfterBattleText

TrainerGruntM5:
	trainer GRUNTM, GRUNTM_5, EVENT_BEAT_ROCKET_GRUNTM_5, GruntM5SeenText, GruntM5BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM5AfterBattleText

TrainerGruntM6:
	trainer GRUNTM, GRUNTM_6, EVENT_BEAT_ROCKET_GRUNTM_6, GruntM6SeenText, GruntM6BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM6AfterBattleText

TrainerGruntF2:
	trainer GRUNTF, GRUNTF_2, EVENT_BEAT_ROCKET_GRUNTF_2, GruntF2SeenText, GruntF2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntF2AfterBattleText

Buena:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .MidRocketTakeover
	checkevent EVENT_MET_BUENA
	iffalse .Introduction
	checkflag ENGINE_BUENAS_PASSWORD_2
	iftrue .PlayedAlready
	readvar VAR_HOUR
	ifless NITE_HOUR, .TooEarly
	checkflag ENGINE_BUENAS_PASSWORD
	iffalse .TuneIn
	checkitem BLUE_CARD
	iffalse .NoBlueCard
	readvar VAR_BLUECARDBALANCE
	ifequal BLUE_CARD_POINT_CAP, .BlueCardCapped0
	playmusic MUSIC_BUENAS_PASSWORD
	writetext RadioTower2FBuenaDoYouKnowPasswordText
	special AskRememberPassword
	iffalse .ForgotPassword
	writetext RadioTower2FBuenaJoinTheShowText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	readvar VAR_FACING
	ifnotequal RIGHT, .ShortWalk
	applymovement PLAYER, RadioTower2FPlayerWalksToMicrophoneMovement
	sjump .SittingInFrontOfBuena

.ShortWalk:
	applymovement PLAYER, RadioTower2FPlayerWalksToMicrophoneMovement2
.SittingInFrontOfBuena:
	applymovement RADIOTOWER2F_BUENA, RadioTower2FStompRightMovement
	opentext
	writetext RadioTower2FBuenaEveryoneSayPasswordText
	waitbutton
	closetext
	refreshscreen
	special BuenasPassword
	closetext
	iffalse .WrongAnswer

	applymovement RADIOTOWER2F_BUENA, RadioTower2FStompRightMovement
	opentext
	writetext RadioTower2FBuenaCorrectAnswerText
	waitbutton
	closetext
	readvar VAR_BLUECARDBALANCE
	addval 1
	writevar VAR_BLUECARDBALANCE
	waitsfx
	playsound SFX_TRANSACTION
	setflag ENGINE_BUENAS_PASSWORD_2
	pause 20
	turnobject RADIOTOWER2F_BUENA, RIGHT
	opentext
	writetext RadioTower2FBuenaThanksForComingText
	waitbutton
	closetext
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	readvar VAR_BLUECARDBALANCE
	ifequal BLUE_CARD_POINT_CAP, .BlueCardCapped1
	end

.Introduction:
	writetext RadioTower2FBuenaShowIntroductionText
	promptbutton
	setevent EVENT_MET_BUENA
	verbosegiveitem BLUE_CARD
.TuneIn:
	writetext RadioTower2FBuenaTuneInToMyShowText
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered0
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue .OfferedNumberBefore
.Registered0:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.ForgotPassword:
	writetext RadioTower2FBuenaComeBackAfterListeningText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	end

.PlayedAlready:
	writetext RadioTower2FBuenaAlreadyPlayedText
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered1
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue .OfferedNumberBefore
.Registered1:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 10
	end

.WrongAnswer:
	setflag ENGINE_BUENAS_PASSWORD_2
	opentext
	writetext RadioTower2FBuenaDidYouForgetText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 20
	opentext
	writetext RadioTower2FBuenaThanksForComingText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	end

.MidRocketTakeover:
	writetext RadioTower2FBuenaPasswordIsHelpText
	waitbutton
	closetext
	end

.NoBlueCard:
	writetext RadioTower2FBuenaNoBlueCardText
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered2
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue .OfferedNumberBefore
.Registered2:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.BlueCardCapped0:
	writetext RadioTower2FBuenaCardIsFullText
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered3
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue .OfferedNumberBefore
.Registered3:
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.TooEarly:
	writetext RadioTower2FBuenaTuneInAfterSixText
	waitbutton
	closetext
	checkcellnum PHONE_BUENA
	iftrue .Registered4
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	iftrue .OfferedNumberBefore
.Registered4:
	end

.BlueCardCapped1:
	checkcellnum PHONE_BUENA
	iftrue .HasNumber
	pause 20
	turnobject RADIOTOWER2F_BUENA, DOWN
	pause 15
	turnobject PLAYER, UP
	pause 15
	checkevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	iftrue .OfferedNumberBefore
	showemote EMOTE_SHOCK, RADIOTOWER2F_BUENA, 15
	setevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER_NO_BLUE_CARD
	setevent EVENT_BUENA_OFFERED_HER_PHONE_NUMBER
	opentext
	writetext RadioTower2FBuenaOfferPhoneNumberText
	sjump .AskForNumber

.OfferedNumberBefore:
	opentext
	writetext RadioTower2FBuenaOfferNumberAgainText
.AskForNumber:
	askforphonenumber PHONE_BUENA
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	writetext RadioTower2FRegisteredBuenasNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	writetext RadioTower2FBuenaCallMeText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	addcellnum PHONE_BUENA
	end

.NumberDeclined:
	writetext RadioTower2FBuenaSadRejectedText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.PhoneFull:
	writetext RadioTower2FBuenaYourPhoneIsFullText
	waitbutton
	closetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
.HasNumber:
	end

RadioTowerBuenaPrizeReceptionist:
	faceplayer
	opentext
	checkitem BLUE_CARD
	iffalse .NoCard
	writetext RadioTower2FBuenaReceptionistPointsForPrizesText
	promptbutton
	special BuenaPrize
	closetext
	end

.NoCard:
	writetext RadioTower2FBuenaReceptionistNoCardText
	promptbutton
	closetext
	end

RadioTower2FSalesSign:
	jumptext RadioTower2FSalesSignText

RadioTower2FOaksPKMNTalkSign:
	jumptext RadioTower2FOaksPKMNTalkSignText

RadioTower2FPokemonRadioSign:
	jumptext RadioTower2FPokemonRadioSignText

RadioTower2FBookshelf:
	jumpstd MagazineBookshelfScript

RadioTower2FPlayerWalksToMicrophoneMovement:
	slow_step DOWN
	slow_step RIGHT
	slow_step DOWN
	slow_step RIGHT
RadioTower2FPlayerWalksToMicrophoneMovement2:
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	turn_head LEFT
	step_end

RadioTower2FStompRightMovement:
	turn_step RIGHT
	step_bump
	step_end

RadioTower2FSuperNerdText: 
if DEF(_FR_FR)
	text "Ecoutez la radio"
	line "n'importe où!"
	cont "A bientôt!"
else
	text "You can listen to"
	line "the radio any-"
	cont "where. Tune in!"
endc

	done

RadioTower2FSuperNerdTROpinionText:
if DEF(_FR_FR)
	text "Je pense que le"
	line "message de la"
	
	para "TEAM ROCKET"
	line "n'a aucun sens."

	para "Il suffit d'aller"
	line "à l'HOPITAL de"
	cont "DOUBLONVILLE pour"
	cont "voir que le"
	cont "COVID-19 est bien"
	cont "réel et mortel."

	para "Je veux préserver"
	line "des vies, alors je"
	cont "respecte les ges-"
	cont "tes barrières et"
	cont "la distanciation"
	cont "sociale."
else
	text "I think TEAM"
	line "ROCKET's message"
	
	para "doesn't make any"
	line "sense whatsoever."

	para "You just have to"
	line "visit GOLDENROD"
	
	para "HOSPITAL to see"
	line "that COVID-19 is"
	cont "real and kills."

	para "I want to save"
	line "lives so I respect"
	
	para "sanitary measures"
	line "as well as social"
	cont "distancing."
endc
	done

RadioTower2FTeacherText: 
if DEF(_FR_FR)
	text "Les berceuses de"
	line "la radio peuvent"
	cont "endormir les"
	cont "#MON."
else
	text "Lullabies on the"
	line "radio may make"
	cont "#MON sleep."
endc

	done

RadioTower2FTeacherText_Rockets: 
if DEF(_FR_FR)
	text "Pourquoi veulent-"
	line "ils contrôler la"
	cont "TOUR RADIO?"
else
	text "Why would they"
	line "want to take over"
	cont "the RADIO TOWER?"
endc

	done

RadioTowerJigglypuffText: 
if DEF(_FR_FR)
	text "RONDOUDOU:"
	line "Douuu..."
else
	text "JIGGLYPUFF:"
	line "Jiggly…"
endc

	done

RadioTower2FBlackBelt1Text: 
if DEF(_FR_FR)
	text "Cet accès est ré-"
	line "servé au personnel"
	cont "autorisé."

	para "Cette mesure vient"
	line "d'être appliquée."

	para "Le DIRECTEUR ne"
	line "va pas bien..."
else
	text "Sorry. Authorized"
	line "personnel only"
	cont "beyond this point."

	para "It wasn't that way"
	line "before."

	para "There's something"
	line "wrong with the"
	cont "DIRECTOR…"
endc

	done

RadioTower2FBlackBelt2Text: 
if DEF(_FR_FR)
	text "Vous pouvez vous"
	line "balader."

	para "Le DIRECTEUR est"
	line "agréable. Comme"
	cont "avant, quoi."
else
	text "Feel free to look"
	line "around anywhere."

	para "The DIRECTOR is"
	line "nice again, just"
	cont "as he was before."
endc

	done

GruntM4SeenText:
if DEF(_FR_FR)
	text "Le vaccin en pré-"
	line "paration contient"

	para "des nano-puces 5G"
	line "dans le but de"

	para "contrôler notre"
	line "cerveau."
else
	text "The vaccine they"
	line "are working on"
	
	para "contains 5G cells"
	line "in order to take"

	para "control of our"
	line "brain."
endc
	done


GruntM4BeatenText:
if DEF(_FR_FR)
	text "Gah! Tu m'as re-"
	line "tourné le cerveau!"
else
	text "Gah! You destroyed"
	line "my brain!"
endc
	done


GruntM4AfterBattleText:
if DEF(_FR_FR)
	text "On ne te laissera"
	line "pas faire foirer"
	cont "nos plans!"
else
	text "We won't let you"
	line "ruin our plans!"
endc
	done


GruntM5SeenText:
if DEF(_FR_FR)
	text "On ne laissera pas"
	line "le gouvernement"
	cont "gagner!"
else
	text "We won't let the"
	line "government win!"
endc
	done

GruntM5BeatenText: 
if DEF(_FR_FR)
	text "Tu te crois"
	line "balèze?"
else
	text "You think you're a"
	line "hero?"
endc

	done

GruntM5AfterBattleText:
if DEF(_FR_FR)
	text "On devrait tous"
	line "faire ce qu'on"
	cont "veut."
else
	text "We should all"
	line "just do whatever"
	cont "we like."
endc
	done

GruntM6SeenText:
if DEF(_FR_FR)
	text "Ne renonce pas à"
	line "ta liberté pour"
	cont "une simple épi-"
	cont "démie de grippe!"
else
	text "Don't give up your"
	line "freedom because of"
	cont "a little flu"
	cont "outbreak!"
endc
	done

GruntM6BeatenText: 
if DEF(_FR_FR)
	text "Pfff. J'abandonne."
else
	text "Arggh. I give up."
endc

	done

GruntM6AfterBattleText: 
if DEF(_FR_FR)
	text "Nos CAIDS sont en"
	line "train de contrôler"
	cont "cet endroit."

	para "Ils ont un super"
	line "plan en tête. Je"
	cont "me demande ce que"
	cont "c'est..."
else
	text "Our EXECUTIVES are"
	line "trying to take"
	cont "this place over."

	para "They have some big"
	line "plan. I wonder"
	cont "what that is?"
endc

	done

GruntF2SeenText: 
if DEF(_FR_FR)
	text "Hahaha!"

	para "Très ennuyeux."
	line "C'était trop fa-"

	para "cile d'envahir cet"
	line "endroit!"

	para "Allez les petits!"
	line "Faites-moi encore"
	cont "rire!"
else
	text "Hahaha!"

	para "How boring."
	line "It was far too"

	para "easy to take over"
	line "this place!"

	para "Come on, keep me"
	line "amused!"
endc

	done

GruntF2BeatenText: 
if DEF(_FR_FR)
	text "Qu-qui t'es toi?"
else
	text "Wh-who are you?"
endc

	done

GruntF2AfterBattleText: 
if DEF(_FR_FR)
	text "Tu as gagné. Je ne"
	line "l'oublierai pas!"
else
	text "You beat me, and"
	line "I won't forget it!"
endc

	done

RadioTower2FBuenaShowIntroductionText: 
if DEF(_FR_FR)
	text "BUENA: Salut!"
	line "Je suis BUENA!"

	para "Connais-tu l'émis-"
	line "sion LE MOT DE"
	cont "PASSE?"

	para "Si tu peux me"
	line "donner le mot de"

	para "passe de l'émis-"
	line "sion, tu remportes"
	cont "des points."

	para "Gagne plein de"
	line "points et échange-"

	para "les à la jolie"
	line "fille à côté con-"

	para "tre de fabuleux"
	line "prix!"

	para "Voilà!"

	para "Ta carte à points"
	line "personnelle!"
else
	text "BUENA: Hi! I'm"
	line "BUENA!"

	para "Do you know about"
	line "a radio program"
	cont "called PASSWORD?"

	para "If you can tell me"
	line "the password from"

	para "the program, you"
	line "will earn points."

	para "Save up those"
	line "points and trade"

	para "them to that sweet"
	line "young lady over"

	para "there for some"
	line "choice prizes!"

	para "Here you go!"

	para "It's your very own"
	line "point card!"
endc

	done

RadioTower2FBuenaTuneInToMyShowText: 
if DEF(_FR_FR)
	text "BUENA: Ecoutez"
	line "tous l'émission"
	cont "du MOT DE PASSE!"
else
	text "BUENA: Tune in to"
	line "my PASSWORD SHOW!"
endc

	done

RadioTower2FBuenaDoYouKnowPasswordText: 
if DEF(_FR_FR)
	text "BUENA: Bonjour!"
	line "As-tu écouté mon"
	cont "émission?"

	para "Te souviens-tu du"
	line "mot de passe d'au-"
	cont "jourd'hui?"
else
	text "BUENA: Hi!"
	line "Did you tune in to"
	cont "my radio show?"

	para "Do you remember"
	line "today's password?"
endc

	done

RadioTower2FBuenaJoinTheShowText: 
if DEF(_FR_FR)
	text "BUENA: Oh!"
	line "Merci!"

	para "Quel est ton nom,"
	line "déjà?"

	para "...<PLAY_G>, OK!"

	para "Viens, <PLAY_G>."
	line "Tu es en direct."
else
	text "BUENA: Oh, wow!"
	line "Thank you!"

	para "What was your name"
	line "again?"

	para "…<PLAY_G>, OK!"

	para "Come on, <PLAY_G>."
	line "Join the show."
endc

	done

RadioTower2FBuenaEveryoneSayPasswordText: 
if DEF(_FR_FR)
	text "BUENA: Tout le"
	line "monde est prêt?"

	para "Il faut crier le"
	line "mot de passe d'au-"

	para "jourd'hui pour"
	line "<PLAY_G>!"
else
	text "BUENA: Everyone"
	line "ready?"

	para "I want to hear you"
	line "shout out today's"

	para "password for"
	line "<PLAY_G>!"
endc

	done

RadioTower2FBuenaComeBackAfterListeningText: 
if DEF(_FR_FR)
	text "BUENA: Reviens"
	line "après avoir écouté"

	para "mon émission, OK?"
	line "A plus tard!"
else
	text "BUENA: Come back"
	line "after you listen"

	para "to my show, OK?"
	line "Catch ya later!"
endc

	done

RadioTower2FBuenaAlreadyPlayedText: 
if DEF(_FR_FR)
	text "BUENA: Désolée..."

	para "Tu n'as qu'un"
	line "essai par jour."

	para "Reviens donc"
	line "demain!"
else
	text "BUENA: Sorry…"

	para "You get just one"
	line "chance each day."

	para "Come back tomorrow"
	line "for another try!"
endc

	done

RadioTower2FBuenaCorrectAnswerText: 
if DEF(_FR_FR)
	text "BUENA: OUAIIIS!"
	line "C'est exact!"

	para "Tu as donc écouté"
	line "mon émission!"

	para "Tu as gagné un"
	line "point! Bravo!"
else
	text "BUENA: YIPPEE!"
	line "That's right!"

	para "You did tune in!"
	line "I'm so happy!"

	para "You earned one"
	line "point! Congrats!"
endc

	done

RadioTower2FBuenaDidYouForgetText: 
if DEF(_FR_FR)
	text "BUENA: ..."
	line "Pas du tout."

	para "Tu as oublié le"
	line "mot de passe?"
else
	text "BUENA: Aww…"
	line "That's not it…"

	para "Did you forget the"
	line "password?"
endc

	done

RadioTower2FBuenaThanksForComingText: 
if DEF(_FR_FR)
	text "BUENA: Notre"
	line "candidat était"

	para "<PLAY_G>."
	line "Merci!"

	para "Suivez tous ma"
	line "super émission!"
else
	text "BUENA: Yup! Our"
	line "contestant was"

	para "<PLAY_G>."
	line "Thanks for coming!"

	para "I hope all you"
	line "listeners will"

	para "come too!"
	line "I'll be waiting!"
endc

	done

RadioTower2FBuenaPasswordIsHelpText: 
if DEF(_FR_FR)
	text "BUENA: De quoi?"
	line "Le mot de passe?"

	para "AU SECOURS!"
else
	text "BUENA: Huh?"
	line "Today's password?"

	para "HELP, of course!"
endc

	done

RadioTower2FBuenaCardIsFullText: 
if DEF(_FR_FR)
	text "BUENA: Ta carte"
	line "est pleine."

	para "Va donc empocher"
	line "un prix!"
else
	text "BUENA: Your BLUE"
	line "CARD's full."

	para "Trade it in for a"
	line "fabulous prize!"
endc

	done

RadioTower2FBuenaTuneInAfterSixText: 
if DEF(_FR_FR)
	text "BUENA: Ecoutez le"
	line "MOT DE PASSE tous"

	para "les soirs de 18"
	line "heures à minuit!"

	para "Ecoutez et venez!"
else
	text "BUENA: Tune in to"
	line "PASSWORD every"

	para "night from six to"
	line "midnight!"

	para "Tune in, then drop"
	line "in for a visit!"
endc

	done

RadioTower2FBuenaNoBlueCardText: 
if DEF(_FR_FR)
	text "BUENA: Oh? Tu n'as"
	line "pas amené ta"
	cont "CARTE BLEUE?"

	para "Je ne peux pas te"
	line "donner de points"
	cont "dans ce cas."
else
	text "BUENA: Oh? You"
	line "forgot to bring"
	cont "your BLUE CARD?"

	para "I can't give you"
	line "points if you"
	cont "don't have it."
endc

	done

RadioTower2FBuenaOfferPhoneNumberText: 
if DEF(_FR_FR)
	text "BUENA: Oh! Ta"
	line "CARTE BLEUE a un"

	para "total de {d:BLUE_CARD_POINT_CAP} pts"
	line "aujourd'hui!"

	para "Hmmm... Il n'y a"
	line "pas de prix spé-"
	cont "cial mais..."

	para "Tu viens si sou-"
	line "vent, <PLAY_G>."

	para "Je dois faire"
	line "quelque chose!"

	para "Tu veux mon numéro"
	line "de téléphone?"
else
	text "BUENA: Oh! Your"
	line "BLUE CARD reached"

	para "{d:BLUE_CARD_POINT_CAP} points today!"
	line "That's so wild!"

	para "Hmm… There isn't a"
	line "prize for hitting"
	cont "{d:BLUE_CARD_POINT_CAP} points, but…"

	para "You came by so"
	line "often, <PLAY_G>."

	para "I'll make you a"
	line "special deal!"

	para "How would you like"
	line "my phone number?"
endc

	done

RadioTower2FBuenaOfferNumberAgainText: 
if DEF(_FR_FR)
	text "BUENA: <PLAY_G>,"
	line "veux-tu mon numéro"
	cont "de téléphone?"
else
	text "BUENA: <PLAY_G>,"
	line "do you want to"

	para "register my phone"
	line "number?"
endc

	done

RadioTower2FRegisteredBuenasNumberText: 
if DEF(_FR_FR)
	text "<PLAYER> enregistre"
	line "le No. de BUENA."
else
	text "<PLAYER> registered"
	line "BUENA's number."
endc

	done

RadioTower2FBuenaCallMeText: 
if DEF(_FR_FR)
	text "BUENA: Appelle-moi"
	line "vite!"
else
	text "BUENA: I look"
	line "forward to hearing"
	cont "from you!"
endc

	done

RadioTower2FBuenaSadRejectedText: 
if DEF(_FR_FR)
	text "BUENA:..."
	line "C'est spécial..."
else
	text "BUENA: Aww… It's a"
	line "special prize…"
endc

	done

RadioTower2FBuenaYourPhoneIsFullText: 
if DEF(_FR_FR)
	text "BUENA: <PLAY_G>,"
	line "il n'y a plus de"

	para "place sur ton"
	line "téléphone..."
else
	text "BUENA: <PLAY_G>,"
	line "your phone list"

	para "has no room left"
	line "for me…"
endc

	done

RadioTower2FBuenaReceptionistPointsForPrizesText: 
if DEF(_FR_FR)
	text "Tu peux échanger"
	line "tes points contre"
	cont "un fabuleux prix!"
else
	text "You can cash in"
	line "your saved points"

	para "for a lovely prize"
	line "of your choice!"
endc

	done

RadioTower2FBuenaReceptionistNoCardText: 
if DEF(_FR_FR)
	text "Tu ne peux pas"
	line "échanger tes"
	cont "points sans ta"
	cont "CARTE BLEUE."

	para "N'oublie pas ta"
	line "CARTE BLEUE!"
else
	text "You can't trade in"
	line "points without"
	cont "your BLUE CARD."

	para "Don't forget your"
	line "BLUE CARD!"
endc

	done

RadioTower2FSalesSignText: 
if DEF(_FR_FR)
	text "1ER VENTES"
else
	text "2F SALES"
endc

	done

RadioTower2FOaksPKMNTalkSignText: 
if DEF(_FR_FR)
	text "CHRONIQUE #MON"
	line "DU PROF.CHEN"

	para "L'émission star"
	line "à l'antenne!"
else
	text "PROF.OAK'S #MON"
	line "TALK"

	para "The Hottest Show"
	line "on the Air!"
endc

	done

RadioTower2FPokemonRadioSignText: 
if DEF(_FR_FR)
	text "Pour chacune"
	line "Pour chacun"
	cont "Le soir"
	cont "Comme le matin"
	cont "RADIO #MON"
	cont "C'est bien..."
else
	text "Anywhere, Anytime"
	line "#MON Radio"
endc

	done

RadioTower2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_3F, 1
	warp_event 15,  0, RADIO_TOWER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower2FSalesSign
	bg_event  5,  0, BGEVENT_READ, RadioTower2FOaksPKMNTalkSign
	bg_event  9,  1, BGEVENT_READ, RadioTower2FBookshelf
	bg_event 10,  1, BGEVENT_READ, RadioTower2FBookshelf
	bg_event 11,  1, BGEVENT_READ, RadioTower2FBookshelf
	bg_event 13,  0, BGEVENT_READ, RadioTower2FPokemonRadioSign

	def_object_events
	object_event  6,  6, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower2FSuperNerdScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  2, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower2FTeacherScript, -1
	object_event  1,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  8,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM5, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGruntM6, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 10,  5, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerGruntF2, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  0,  1, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower2FBlackBelt1Script, EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	object_event  1,  1, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower2FBlackBelt2Script, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 12,  1, SPRITE_JIGGLYPUFF, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTowerJigglypuff, -1
	object_event 14,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Buena, -1
	object_event 12,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTowerBuenaPrizeReceptionist, EVENT_GOLDENROD_CITY_CIVILIANS
