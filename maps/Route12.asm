	object_const_def
	const ROUTE12_FISHER1
	const ROUTE12_FISHER2
	const ROUTE12_FISHER3
	const ROUTE12_FISHER4
	const ROUTE12_POKE_BALL1
	const ROUTE12_POKE_BALL2
	const ROUTE12_TEACHER1
	const ROUTE12_YOUNGSTER1
	const ROUTE12_YOUNGSTER2
	const ROUTE12_SAILOR1
	const ROUTE12_SAILOR2
	const ROUTE12_POKEFANM1

Route12_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .CheckMomCall
	
.CheckMomCall:
	checkevent EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	iftrue .end

	setevent EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	specialphonecall SPECIALCALL_VACCINE_PASSPORT

.end
	endcallback

TrainerFisherKyle:
	trainer FISHER, KYLE, EVENT_BEAT_FISHER_KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherKyleAfterBattleText

TrainerFisherMartin:
	trainer FISHER, MARTIN, EVENT_BEAT_FISHER_MARTIN, FisherMartinSeenText, FisherMartinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherMartinAfterBattleText

TrainerFisherStephen:
	trainer FISHER, STEPHEN, EVENT_BEAT_FISHER_STEPHEN, FisherStephenSeenText, FisherStephenBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherStephenAfterBattleText

TrainerFisherBarney:
	trainer FISHER, BARNEY, EVENT_BEAT_FISHER_BARNEY, FisherBarneySeenText, FisherBarneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherBarneyAfterBattleText

TrainerTeacherCecilia:
	trainer TEACHER, CECILIA, EVENT_BEAT_TEACHER_CECILIA, TeacherCeciliaSeenText, TeacherCeciliaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TeacherCeciliaAfterBattleText

TrainerSchoolboySawara:
	trainer SCHOOLBOY, SAWARA, EVENT_BEAT_SCHOOLBOY_SAWARA, SchoolboySawaraSeenText, SchoolboySawaraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboySawaraAfterBattleText

TrainerSchoolboyGinko:
	trainer SCHOOLBOY, GINKO, EVENT_BEAT_SCHOOLBOY_GINKO, SchoolboyGinkoSeenText, SchoolboyGinkoBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyGinkoSeenText

TrainerSailorClovis:
	trainer SAILOR, CLOVIS, EVENT_BEAT_SAILOR_CLOVIS, SailorClovisSeenText, SailorClovisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorClovisAfterBattleText

TrainerSailorStrand:
	trainer SAILOR, STRAND, EVENT_BEAT_SAILOR_STRAND, SailorStrandSeenText, SailorStrandBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorStrandAfterBattleText

TrainerPokefanMNovak:
	trainer POKEFANM, NOVAK, EVENT_BEAT_POKEFANM_NOVAK, PokefanMNovakSeenText, PokefanMNovakBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokefanMNovakAfterBattleText

Route12_LockdownSpeakerScript:
	jumptextfaceplayer Route12_LockdownSpeakerText

Route12_TeacherLockdownScript:
	faceplayer
	opentext
	writetext Route12_TeacherLockdown1Text
	yesorno
	iftrue .no_1

	writetext Route12_TeacherLockdown3Text
	yesorno
	iffalse .close_text

	writetext Route12_TeacherLockdown5Text
	sjump .text_end

.no_1
	writetext Route12_TeacherLockdown2Text
.text_end
	waitbutton
.close_text
	closetext
	end

Route12Sign:
	jumptext Route12SignText

FishingSpotSign:
	jumptext FishingSpotSignText

Route12Calcium:
	itemball CALCIUM

Route12Nugget:
	itemball TOILET_PAPER

Route12FruitTree:
	fruittree FRUITTREE_ROUTE_12

Route12HiddenElixer:
	hiddenitem ELIXER, EVENT_ROUTE_12_HIDDEN_ELIXER

FisherMartinSeenText: 
if DEF(_FR_FR)
	text "La patience est"
	line "la meilleure arme"
	cont "pour pêcher..."
else
	text "Patience is the"
	line "key to both fish-"
	cont "ing and #MON."
endc

	done

FisherMartinBeatenText: 
if DEF(_FR_FR)
	text "Gwaaah!"
else
	text "Gwaaah!"
endc

	done

FisherMartinAfterBattleText: 
if DEF(_FR_FR)
	text "Bon... La pêche"
	line "c'est lourd..."
else
	text "I'm too impatient"
	line "for fishing…"
endc

	done

FisherStephenSeenText: 
if DEF(_FR_FR)
	text "Ca c'est le pied!"
	line "Pêcher en écoutant"
	cont "la radio, c'est"
	cont "super pépère."
else
	text "I feel so content,"
	line "fishing while lis-"
	cont "tening to some"
	cont "tunes on my radio."
endc

	done

FisherStephenBeatenText: 
if DEF(_FR_FR)
	text "Ma radio m'a fait"
	line "perdre!"
else
	text "My stupid radio"
	line "distracted me!"
endc

	done

FisherStephenAfterBattleText: 
if DEF(_FR_FR)
	text "Tu connais les"
	line "radios de KANTO?"

	para "Elles sont pas"
	line "mal, tu sais..."
else
	text "Have you checked"
	line "out KANTO's radio"

	para "programs? We get a"
	line "good variety here."
endc

	done

FisherBarneySeenText: 
if DEF(_FR_FR)
	text "Quelle est la"
	line "chose la plus im-"
	cont "portante dans nos"
	cont "vies quotidiennes?"
else
	text "What's most impor-"
	line "tant in our every-"
	cont "day lives?"
endc

	done

FisherBarneyBeatenText: 
if DEF(_FR_FR)
	text "La réponse va"
	line "suivre!"
else
	text "The answer is"
	line "coming up next!"
endc

	done

FisherBarneyAfterBattleText: 
if DEF(_FR_FR)
	text "Je crois que"
	line "l'électricité est"

	para "la chose la plus"
	line "importante."

	para "Et c'est pour ça"
	line "qu'on a fait tant"

	para "d'histoires à pro-"
	line "pos de la panne de"
	cont "la CENTRALE."
else
	text "I think electric-"
	line "ity is the most"

	para "important thing in"
	line "our daily lives."

	para "If it weren't,"
	line "people wouldn't"

	para "have made such a"
	line "fuss when the"

	para "POWER PLANT went"
	line "out of commission."
endc

	done

FisherKyleSeenText: 
if DEF(_FR_FR)
	text "Tu t'en souviens?"
else
	text "Do you remember?"
endc

	done

FisherKyleBeatenText: 
if DEF(_FR_FR)
	text "Tu t'en souviens?"
else
	text "You do remember?"
endc

	done

FisherKyleAfterBattleText: 
if DEF(_FR_FR)
	text "La p'tite secousse"
	line "que l'on sent"

	para "quand on ferre un"
	line "#MON..."

	para "C'est la plus"
	line "belle des sensa-"
	cont "tions!!!"
else
	text "The tug you feel"
	line "on the ROD when"

	para "you hook a #-"
	line "MON…"

	para "That's the best"
	line "feeling ever for"
	cont "an angler like me."
endc

	done

TeacherCeciliaSeenText:
if DEF(_FR_FR)
	text "Maintenant que le"
	line "confinement est"
	cont "levé, c'est le"
	cont "retour des sorties"
	cont "scolaires!"
else
	text "Now that the stay-"
	line "at-home order is"
	cont "gone, it's time"
	cont "for field trips!"
endc
	done

TeacherCeciliaBeatenText:
if DEF(_FR_FR)
	text "... ... ..."
else
	text "… … …"
endc
	done

TeacherCeciliaAfterBattleText:
if DEF(_FR_FR)
	text "J'aime marcher"
	line "près des grands"
	cont "plans d'eau."
else
	text "I like walking"
	line "around large"
	cont "bodies of water."
endc
	done

SchoolboySawaraSeenText:
if DEF(_FR_FR)
	text "Je suis reconnais-"
	line "sant envers ma"
	cont "prof pour cette"
	cont "sortie!"
else
	text "I'm grateful to"
	line "my teacher for"
	cont "this trip!"
endc
	done

SchoolboySawaraBeatenText:
if DEF(_FR_FR)
	text "Je suis en train"
	line "d'apprendre."
else
	text "I'm still learning."
endc
	done

SchoolboySawaraAfterBattleText:
if DEF(_FR_FR)
	text "Mon frère GINKO..."
	
	para "Il est étrange"
	line "depuis le"
	cont "confinement..."
else
	text "My brother GINKO…"

	para "He's weird since"
	line "the lockdown…"
endc
	done

SchoolboyGinkoSeenText:
if DEF(_FR_FR)
	text "COURS VITE COURS"
	line "VITE COURS VITE"
else
	text "RUN RUN RUN"
	line "RUN RUN RUN"
endc
	done

SchoolboyGinkoBeatenText:
if DEF(_FR_FR)
	text "*derp*"
else
	text "*derp*"
endc
	done

SailorClovisSeenText:
if DEF(_FR_FR)
	text "Je suis coincé ici"
	line "avec l'AQUARIA."
	
	para "C'est comme un"
	line "nouveau confi-"
	cont "nement..."
else
	text "I'm stuck here with"
	line "the S.S.AQUA."

	para "It's like a new"
	line "lockdown…"
endc
	done

SailorClovisBeatenText:
if DEF(_FR_FR)
	text "Je veux juste"
	line "rentrer à JOHTO..."
else
	text "I just want to go"
	line "back to JOHTO…"
endc
	done

SailorClovisAfterBattleText:
if DEF(_FR_FR)
	text "Attends... J'ai"
	line "raté le départ"
	cont "de l'AQUARIA?"
else
	text "Wait… Did I miss"
	line "the S.S.AQUA"
	cont "departure?"
endc
	done

SailorStrandSeenText:
if DEF(_FR_FR)
	text "Aaah, l'horizon..."
else
	text "Aaah, the horizon…"
endc
	done

SailorStrandBeatenText:
if DEF(_FR_FR)
	text "Tu as brisé ma"
	line "tranquillité."
else
	text "You're breaking my"
	line "peacefulness."
endc
	done

SailorStrandAfterBattleText:
if DEF(_FR_FR)
	text "J'ai visité"
	line "de nombreuses"
	cont "régions."
	
	para "Tu savais que la"
	line "pandémie a très"
	cont "peu touché la"
	cont "région d'ONWA?"
else
	text "I've visited many"
	line "places."

	para "Did you know the"
	line "pandemic barely"
	cont "hit the ONWA"
	cont "region?"
endc
	done

PokefanMNovakSeenText:
if DEF(_FR_FR)
	text "Alors comme ça"
	line "t'es vacciné?"
else
	text "So you're vacci-"
	line "nated, uh?"
endc
	done

PokefanMNovakBeatenText:
if DEF(_FR_FR)
	text "Perdre face à un"
	line "pion des Big Phar-"
	cont "ma, la honte..."
else
	text "How could I lose"
	line "to a pharma shill?"
endc
	done

PokefanMNovakAfterBattleText:
if DEF(_FR_FR)
	text "A quoi bon se"
	line "faire injecter des"
	cont "produits chimiques"
	
	para "alors qu'il existe"
	line "des méthodes natu-"
	cont "relles éprouvées,"
	
	para "comme respirer"
	line "l'air marin et"
	cont "manger sain?"
else
	text "What's the point of"
	line "getting injected"
	cont "some chemicals,"

	para "when instead, you"
	line "can use proven"
	cont "naturals methods"

	para "like breathing"
	line "salty sea air,"
	cont "and eating well?"
endc
	done

Route12_TeacherLockdown1Text:
if DEF(_FR_FR)
	text "Tu sais quel était"
	line "le pire aspect du"
	cont "confinement?"
else
	text "Do you know what"
	line "the worst aspect"
	cont "of the lockdown"
	cont "was?"
endc
	done

Route12_TeacherLockdown2Text:
if DEF(_FR_FR)
	text "Toi aussi tu l'as"
	line "vécu, n'est-ce pas?"
else
	text "You've lived"
	line "through it,"
	cont "haven't you?"
endc
	done

Route12_TeacherLockdown3Text:
if DEF(_FR_FR)
	text "Tu veux le savoir?"
else
	text "Do you want"
	line "to know?"
endc
	done

Route12_TeacherLockdown5Text:
if DEF(_FR_FR)
	text "Ce n'est pas le"
	line "fait d'être enfer-"
	cont "mé dans un espace"
	cont "clos."
	
	para "Après tout, on"
	line "peut tous passer"
	cont "un week-end à"
	cont "la maison sans"
	cont "sortir."
	
	para "Le pire, c'était"
	line "d'être prisonnier"
	cont "du temps."
	
	para "Au début, les"
	line "autorités disaient"
	cont "que le confinement"
	cont "durerait deux"
	cont "semaines."
	
	para "Ca peut sembler"
	line "court."
	
	para "Mais avec la"
	line "panique qui s'"
	cont "installait déjà,"
	cont "ça paraissait"
	cont "interminable."
	
	para "Le monde entier s'"
	line "est arrêté pendant"
	cont "deux semaines."
	
	para "Je me souviens"
	line "regarder à travers"
	cont "la fenêtre de"
	cont "mon appartement et"
	cont "de ne voir absolu-"
	cont "ment personne"
	cont "dehors."
	
	para "Comme dans un"
	line "film dystopique."
	
	para "Alors tu allumes"
	line "ta télé ou ton"
	cont "ordinateur pour"
	cont "trouver un peu de"
	cont "réconfort."
	
	para "Et tu n'y trouves"
	line "que des infos"
	cont "alarmantes."
	
	para "Après la période"
	line "initiale, ils l'ont"
	cont "prolongé pour deux"
	cont "semaines de plus."
	
	para "Imagine le niveau"
	line "de stress que ça"
	cont "a provoqué."
	
	para "Et après ça, ils"
	line "ont dit qu'il"
	cont "fallait prolonger"
	cont "le confinement"
	cont "“jusqu'à nouvel"
	cont "ordre”..."
	
	para "Ca a duré environ"
	line "deux mois."
	
	para "Piégé entre"
	line "quatre murs."
	
	para "Beaucoup de gens"
	line "sont tombés en"
	cont "dépression."
	
	para "Quand on a enfin"
	line "été libérés, se"
	cont "socialiser n'était"
	cont "plus naturel."
	
	para "On avait perdu"
	line "cette aptitude!"
	
	para "Revoir ses proches"
	line "paraissait étrange"
	cont "car tout le monde"
	cont "avait changé à sa"
	cont "manière."
	
	para "Une époque folle."
else
	text "It's not being"
	line "emprisoned in an"
	cont "enclosed space."
	
	para "After all, we can"
	line "all spend a week-"
	cont "end at home"
	cont "without going out."

	para "The worst aspect"
	line "was being trapped"
	cont "in time."

	para "At first, the"
	line "authorithies said"
	cont "the lockdown was"
	cont "going to last for"
	cont "2 weeks."

	para "It may not seem"
	line "like a lot."
	
	para "But with the panic"
	line "that was already"
	cont "settling, it felt"
	cont "like forever."

	para "And it's not just"
	line "you who's trapped"
	cont "home. The whole"
	cont "world stopped for"
	cont "2 weeks."

	para "I remember looking"
	line "through the"
	cont "windows of my"
	cont "apartment and"
	cont "seeing absolutely"
	cont "no one outside."

	para "Just like in a"
	line "dystopian movie."

	para "So you turn on"
	line "your TV or your"
	cont "computer to get"
	cont "a some comfort."
	
	para "And all you find"
	line "there is alarming"
	cont "news."

	para "After the initial"
	line "period, they"
	
	para "prolonged it for"
	line "2 more weeks."
	
	para "Imagine the amount"
	line "of stress it"
	cont "caused."

	para "And then after"
	line "that, they said"
	cont "they'll prolong it"
	cont "“until necessary”…"

	para "It lasted for"
	line "about 2 months."

	para "Stuck between"
	line "four walls."
	
	para "Many people went"
	line "into depression."

	para "After finally"
	line "being released,"
	cont "socializing wasn't"
	cont "natural anymore."

	para "We had lost"
	line "this skill!"

	para "Seeing relatives"
	line "felt weird, as"
	cont "everyone had"
	cont "changed in their"
	cont "own way."
	
	para "Crazy times."
endc
	done

Route12_LockdownSpeakerText:
if DEF(_FR_FR)
	text "Je me souviens du"
	line "premier confine-"
	cont "ment, c'était un"
	
	para "choc. On est passé"
	line "de “tout ira bien”"
	
	para "à “reste chez toi"
	line "ou décède”."
else
	text "I remember the"
	line "first lockdown"
	cont "declaration was"
	cont "a shock. We went"
	
	para "from “everything's"
	line "gonna be alright”"
	
	para "to “stay home or"
	line "perish”."
endc
	done

Route12SignText: 
if DEF(_FR_FR)
	text "ROUTE 12"
	line "NORD: LAVANVILLE"
else
	text "ROUTE 12"

	para "NORTH TO LAVENDER"
	line "TOWN"
endc

	done

FishingSpotSignText: 
if DEF(_FR_FR)
	text "COIN PECHE"
else
	text "FISHING SPOT"
endc

	done

Route12_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 65, ROUTE_12_SUPER_ROD_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 11, 51, BGEVENT_READ, Route12Sign
	bg_event 13,  9, BGEVENT_READ, FishingSpotSign
	bg_event 14, 23, BGEVENT_ITEM, Route12HiddenElixer

	def_object_events
	object_event  5, 23, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherMartin, -1
	object_event 14, 45, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherStephen, -1
	object_event  9, 70, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerFisherBarney, -1
	object_event  6,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherKyle, -1
	object_event  5, 77, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Calcium, EVENT_ROUTE_12_CALCIUM
	object_event  4, 86, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Nugget, EVENT_ROUTE_12_NUGGET
	object_event  5, 87, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12FruitTree, -1
	object_event 12, 40, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerTeacherCecilia, -1
	object_event 15, 38, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSchoolboyGinko, -1
	object_event 15, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerSchoolboySawara, -1
	object_event 10, 48, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSailorClovis, -1
	object_event 17,  9, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSailorStrand, -1
	object_event 15, 79, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 4, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerPokefanMNovak, -1
	object_event 11, 29, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12_LockdownSpeakerScript, -1
	object_event 13, 29, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12_TeacherLockdownScript, -1
