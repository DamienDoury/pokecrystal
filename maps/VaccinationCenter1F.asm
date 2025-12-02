    object_const_def
    const VACCINATION_CENTER_RECEPTIONIST
    const VACCINATION_CENTER_CHANSEY
    const VACCINATION_CENTER_WAITRESS

    const VACCINATION_CENTER_PERMANENT_1
    const VACCINATION_CENTER_PERMANENT_2

    const VACCINATION_CENTER_MORNING_1
    const VACCINATION_CENTER_MORNING_2
    const VACCINATION_CENTER_MORNING_3
    const VACCINATION_CENTER_MORNING_4

    const VACCINATION_CENTER_DAY_1
    const VACCINATION_CENTER_DAY_2
    const VACCINATION_CENTER_DAY_3
    const VACCINATION_CENTER_DAY_4
    const VACCINATION_CENTER_DAY_5

    const VACCINATION_CENTER_NITE_1
    const VACCINATION_CENTER_NITE_2
    const VACCINATION_CENTER_NITE_3
    const VACCINATION_CENTER_NITE_4
    const VACCINATION_CENTER_NITE_5

VaccinationCenter1F_MapScripts:
    def_scene_scripts
    scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene0 ; SCENE_VACCINATION_CENTER_FIND_SEAT

    def_callbacks
    callback MAPCALLBACK_OBJECTS, .EnterCallback

.DummyScene0:
	end

.EnterCallback:
    disappear VACCINATION_CENTER_WAITRESS
    setscene SCENE_DEFAULT

    readvar VAR_YCOORD
	ifnotequal 0, .make_hands_dirty

    applymovement PLAYER, VaccinationCenter_DownMovement

.make_hands_dirty:
    readvar VAR_XCOORD
	ifnotequal 2, .quit
	readvar VAR_YCOORD
	ifnotequal 7, .quit
	setmapscene GOLDENROD_HOSPITAL_1F, SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS
.quit:
	endcallback

VaccinationCenterReceptionistScript:
    faceplayer

    checkevent EVENT_CROWD_IN_VACCINATION_CENTER
    iftrue .in_construction 

    checkscene
    ifequal SCENE_VACCINATION_CENTER_YOUR_TURN, .your_turn

    checkmapscene GOLDENROD_HOSPITAL_1F
    ifequal SCENE_GOLDENROD_HOSPITAL_NEED_TO_WASH_HANDS, .AskGelScript

.CleanHands:
    checkscene SCENE_VACCINATION_CENTER_FIND_SEAT
    iftrue .accepted

    opentext 
    writetext VaccinationCenterAppointmentText
    promptbutton

    checkevent EVENT_GOT_A_SHOT_TODAY
    iftrue .failed
;.success:
    setevent EVENT_GOT_A_SHOT_TODAY
    writetext VaccinationCenterSuccessText
    yesorno
    iffalse .refused

    setscene SCENE_VACCINATION_CENTER_FIND_SEAT
.accepted:
    jumptext VaccinationCenterAcceptedText

.AskGelScript:
    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
    farjumptext GoldenrodHospitalAskGelText

.in_construction:
    jumptext VaccinationCenterConstructionText

.failed:
    jumptext VaccinationCenterFailText

.refused:
    jumptext VaccinationCenterRefusedText

.your_turn:
    jumptext VaccinationCenterYourTurnText

VaccinationCenterGelScript:
    farsjump GoldenrodHospitalGelScript

VaccinationCenterChanseyScript:
    cry CHANSEY
    farjumptext GoldenrodHospitalChanseySeriousText

VaccinationCenterDynamicWalkScript:
    applymovement PLAYER, VaccinationCenter_DownMovement

    readvar VAR_XCOORD
    ifgreater 10, .right_side
.left_side:
    applymovement PLAYER, VaccinationCenter_RightMovement
    readvar VAR_XCOORD
    ifnotequal 10, .left_side
    sjump .top_or_bot

.right_side:
    applymovement PLAYER, VaccinationCenter_LeftMovement
    readvar VAR_XCOORD
    ifnotequal 10, .right_side

.top_or_bot:
    readvar VAR_YCOORD
    ifgreater 3, .bot_side
;.top_side:
    applymovement PLAYER, VaccinationCenter_HeadUpMovement
    end

.bot_side:
    applymovement PLAYER, VaccinationCenter_UpMovement
    applymovement PLAYER, VaccinationCenter_UpMovement
    end

VaccinationCenterAllowedSeatScript:
    applymovement PLAYER, VaccinationCenter_HeadDownMovement

    random 8 ; Random waiting time!
.pause_loop ; Acts as a pause, without freezing Chansey's animations.
    pause 7
    applymovement VACCINATION_CENTER_CHANSEY, VaccinationCenter_HeadUpMovement 
    pause 7
    applymovement VACCINATION_CENTER_CHANSEY, VaccinationCenter_HeadDownMovement
    addval 1
    ifless 12, .pause_loop
    setval 0

    playsound SFX_ENTER_DOOR
    waitsfx
    appear VACCINATION_CENTER_WAITRESS
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_DownMovement

    opentext 
    writetext VaccinationCenterCallText
    waitbutton
    closetext

    moveobject VACCINATION_CENTER_WAITRESS, 10, 1

    setscene SCENE_VACCINATION_CENTER_YOUR_TURN
    end

VaccinationCenterGoToOffice:
    ;scall VaccinationCenterDynamicWalkScript
    applymovement PLAYER, VaccinationCenter_HeadUpMovement
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_NurseScansCardStartMovement
    pause 5
    playsound SFX_PUSH_BUTTON ;SFX_ELEVATOR_END
    waitsfx
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_LeftMovement
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_HeadUpMovement

    readvar VAR_YCOORD
    ifless 3, .move_on

    applymovement PLAYER, VaccinationCenter_UpMovement

.move_on
    follow VACCINATION_CENTER_WAITRESS, PLAYER
    applymovement VACCINATION_CENTER_WAITRESS, VaccinationCenter_UpMovement
    playsound SFX_ENTER_DOOR
    stopfollow
    disappear VACCINATION_CENTER_WAITRESS
    applymovement PLAYER, VaccinationCenter_UpMovement
    warpcheck
	;autoinput .movement_data
    ;special FadeOutPalettes
    ;warpfacing UP, VACCINATION_CENTER_CORRIDOR, 12, 3
    end

;.movement_data
;	db D_UP,   5, -1

VaccinationCenterForbiddenSeatScript:
VaccinationCenterChanseyKicksYouScript:
    pause 5
    applymovement PLAYER, VaccinationCenter_HeadDownMovement
    pause 5
    cry CHANSEY
    showemote EMOTE_SAD, VACCINATION_CENTER_CHANSEY, 15
    waitsfx
    pause 10
    applymovement PLAYER, VaccinationCenter_DownMovement
    ;jumptext VaccinationCenterForbiddenSeatText
    end

    
VaccinationCenter_Script1:
    jumptextfaceplayer VaccinationCenter_Text1

VaccinationCenter_Script2:
    jumptextfaceplayer VaccinationCenter_Text2

VaccinationCenter_Script4:
    jumptextfaceplayer VaccinationCenter_Text4

VaccinationCenter_Script5:
    jumptextfaceplayer VaccinationCenter_Text5

VaccinationCenter_Script6:
    jumptextfaceplayer VaccinationCenter_Text6

VaccinationCenter_Script7:
    jumptextfaceplayer VaccinationCenter_Text7

VaccinationCenter_Script8:
    jumptextfaceplayer VaccinationCenter_Text8

VaccinationCenter_Script9:
    jumptextfaceplayer VaccinationCenter_Text9

VaccinationCenter_Script10:
    jumptextfaceplayer VaccinationCenter_Text10

VaccinationCenter_Script11:
    jumptextfaceplayer VaccinationCenter_Text11

VaccinationCenter_Script12:
    jumptextfaceplayer VaccinationCenter_Text12

VaccinationCenter_Script13:
    faceplayer
    opentext
    writetext VaccinationCenter_Text13
    waitbutton
    closetext
    showemote EMOTE_SHOCK, VACCINATION_CENTER_NITE_1, 15
    jumptext VaccinationCenter_Text13Sequel

VaccinationCenter_Script14:
    jumptextfaceplayer VaccinationCenter_Text14

VaccinationCenter_Script15:
    jumptextfaceplayer VaccinationCenter_Text15

VaccinationCenter_Script16:
    jumptextfaceplayer VaccinationCenter_Text16

VaccinationCenter_Script17:
    showemote EMOTE_SLEEP, VACCINATION_CENTER_NITE_5, 45
    pause 15
    showemote EMOTE_SHOCK, VACCINATION_CENTER_NITE_5, 15
    pause 5
    jumptextfaceplayer VaccinationCenter_Text17

VaccinationCenter1FScanner:	
    farsjump GoldenrodHospital1FScanner

VaccinationCenterLockScript:
    farjumptext GoldenrodHospitalLockText

VaccinationCenter_HeadDownMovement:
    turn_head DOWN
    step_end

VaccinationCenter_HeadUpMovement:
    turn_head UP
    step_end

VaccinationCenter_DownMovement:
    step DOWN
    step_end

VaccinationCenter_LeftMovement:
    step LEFT
    step_end

VaccinationCenter_RightMovement:
    step RIGHT
    step_end

VaccinationCenter_UpMovement:
    step UP
    step_end

VaccinationCenter_NurseScansCardStartMovement:
    step RIGHT
    turn_head UP
    step_end

VaccinationCenterConstructionText:
if DEF(_FR_FR)
	text "Cet immeuble de la"
	line "SYLPHE SARL est en"
	cont "rénovation pour"

	para "devenir un CENTRE"
	line "DE VACCINATION dès"
	
	para "que le vaccin pour"
	line "les #MON sera"
	cont "disponible."
	
	para "Revenez plus tard."
else
    text "This SILPH CO."
    line "condo is being"
    
    para "rehabilitated to"
    line "serve as a"
    
    para "VACCINATION"
    line "CENTER once"

    para "the vaccine for"
    line "#MON becomes"
    cont "available."

    para "Please come back"
    line "later."
endc
    done

VaccinationCenterAppointmentText:
if DEF(_FR_FR)
	text "Bienvenue au"
	line "CENTRE DE"
	cont "VACCINATION de"
	cont "la SYLPHE SARL!"
	
	para "Notre planning est"
	line "complet pour les"
	cont "deux prochains"

	para "mois. Nous ne"
	line "prenons plus de"
	cont "rendez-vous."
else
    text "Welcome to"
    line "SILPH CO."
    cont "VACCINATION"
    cont "CENTER!"

    para "Our schedule is"
    line "full for the next"
    
    para "two months, so we"
    line "don't take new"
    cont "appointments."
endc
    done

VaccinationCenterSuccessText:
if DEF(_FR_FR)
	text "Cependant!"
	
	para "Nous venons d'avoir"
	line "une annulation de"
	cont "dernière minute."
	
	para "Une place est li-"
	line "bre tout de suite."
	
	para "Souhaitez-vous"
	line "vacciner un de"
	cont "vos #MON?"
else
    text "However!"

    para "We just had a"
    line "last minute"
    cont "cancellation, so"

    para "there is an open"
    line "spot right now."

    para "Would you like to"
    line "vaccinate one of"
    cont "your #MON?"
endc
    done

VaccinationCenterFailText:
if DEF(_FR_FR)
	text "Il reste un moyen"
	line "d'obtenir une"
    cont "injection."
	
	para "Parfois, des gens"
	line "ne se présentent"
    
    para "pas à leur rendez-"
    line "vous."
	
	para "Quand ça arrive on"
	line "propose la place à"
    
    para "la première per-"
    line "sonne venue."
	
	para "On vous recommande"
	line "de revenir à un"
	cont "autre moment, avec"
    cont "un #MON prêt."
else
    text "There is still a"
    line "way to get a shot."

    para "Sometimes, people"
    line "don't show up."
    
    para "When it happens,"
    line "we offer the slot"

    para "to the first"
    line "person that comes."

    para "We advise you to"
    line "try again another"
    cont "time, with your"
    cont "#MON ready."
endc
    done

VaccinationCenterAcceptedText:
if DEF(_FR_FR)
	text "Veuillez vous"
	line "asseoir et atten-"
    cont "dre qu'on vous"
	cont "appelle."
else
    text "Please sit and"
    line "wait to be called."
endc
    done

VaccinationCenterRefusedText:
if DEF(_FR_FR)
	text "Pas de souci, je"
	line "vais donner la"
	cont "place à quelqu'un"
	cont "d'autre."
else
    text "No problem, I will"
    line "give the spot to"
    cont "someone else."
endc
    done

VaccinationCenterYourTurnText:
if DEF(_FR_FR)
	text "C'est votre tour!"
	line "Vous allez le"
    cont "rater si vous n'y"
	cont "allez pas!"
else
    text "It's your turn!"
    line "You'll miss it if"
    cont "you don't go now!"
endc
    done

;VaccinationCenterForbiddenSeatText:
;if DEF(_FR_FR)
;	text "Il est interdit de"
;	line "s'asseoir ici."
;	
;	para "La distanciation"
;	line "sociale n'est pas"
;	cont "respectée."
;else
;    text "It is not allowed"
;    line "to sit here."
;
;    para "Social distancing"
;    line "isn't respected."
;endc
;	done

VaccinationCenterCallText:
if DEF(_FR_FR)
	text "<PLAYER>!"
	line "C'est votre tour!"
else
    text "<PLAYER>!"
    line "You're up next."
endc
    done

VaccinationCenter_Text1:
if DEF(_FR_FR)
	text "Je suis un ami de"
	line "l'INFIRMIERE EN"
	cont "CHEF JOELLE."
	
	para "Elle a pu me dire"
	line "quel variant du"
	cont "COVID mon pauvre"
	cont "#MON avait"
    cont "attrapé."
	
	para "Tu la connais"
	line "aussi?"
	
	para "Alors si ton"
	line "#MON a fait un"
	cont "test PCR, vas"
	cont "lui demander."
else
    text "I am a friend of"
	line "CHIEF NURSE JOY."

	para "She was able to"
	line "tell me which"
	cont "variant of COVID"
	cont "my dear #MON"
	cont "caught last time."

	para "You are a friend"
	line "of her as well?"

	para "Then if your"
	line "#MON has done"

	para "a PCR test, you"
	line "could ask her."
endc
    done

VaccinationCenter_Text2:
if DEF(_FR_FR)
	text "C'est le 5ème"
	line "rendez-vous pour"
	cont "mon PIKACHU."
	
	para "Ils disent que 2"
	line "doses suffisent?"
	
	para "J'en doute fort."
else
    text "It is the 5th"
    line "appointment for"
    cont "my PIKACHU."
    
    para "They say 2 shots"
    line "are enough?"
    
    para "I don't think so."
endc
    done

VaccinationCenter_Text4:
if DEF(_FR_FR)
	text "Yo."
else
    text "Yo."
endc
    done

VaccinationCenter_Text5:
if DEF(_FR_FR)
	text "Toute personne"
    line "mature devrait"
	cont "convaincre ses"
	cont "proches de se"
	cont "faire vacciner."
else
    text "A wise man shall"
    line "convince its rel-"
    cont "atives to get"
    cont "vaccinated."
endc
    done

VaccinationCenter_Text6:
if DEF(_FR_FR)
	text "Le vaccin pour les"
	line "#MON est une"
	cont "bénédiction pour"
	cont "les dresseurs."
else
    text "The #MON vac-"
    line "cine is a blessing"
    cont "for trainers."
endc
    done

VaccinationCenter_Text7:
if DEF(_FR_FR)
	text "Les vaccins sau-"
    line "vent notre santé"
	cont "physique."
	
	para "Mais il est tout"
	line "aussi important de"
	
	para "préserver notre"
	line "santé mentale."
	
	para "Beaucoup de gens"
	line "sont tombés en"
	
	para "dépression pendant"
	line "le confinement et"
	cont "le couvre-feu."
else
    text "The vaccines are"
    line "saving our phy-"
    cont "sical health."
    
    para "But it's important"
    line "to maintain a good"
    
    para "mental health as"
    line "well."
    
    para "A lot of people"
    line "fell into depres-"
    
    para "sion during the"
    line "lockdown and the"
    cont "curfew."
endc
    done

VaccinationCenter_Text8:
if DEF(_FR_FR)
	text "Le fait que le"
	line "virus mute en de"
	cont "nouveaux variants,"
	cont "c'est terrifiant."
else
    text "The fact that the"
    line "virus is mutating"
    
    para "into new variants"
    line "is scary."
endc
    done

VaccinationCenter_Text9:
if DEF(_FR_FR)
	text "Je fais ma part"
	line "dans la lutte" 
    cont "contre le COVID."
else
    text "I'm playing my part"
    line "against COVID."
endc
    done

VaccinationCenter_Text10:
if DEF(_FR_FR)
	text "Savoir mes #MON"
    line "vaccinés, ça va"
	cont "être un soulage-"
    cont "ment."
else
    text "Getting my #MON"
    line "vaccinated will"
    cont "be a relief."
endc
    done

VaccinationCenter_Text11:
if DEF(_FR_FR)
	text "La contamination"
	line "entre humains et"
	
    para "#MON peut se"
	line "produire, mais"
    cont "c'est hyper rare."
else
    text "Human-#MON"
    line "contamination can"

    para "happen, but it"
    line "is rare."
endc
    done

VaccinationCenter_Text12:
if DEF(_FR_FR)
	text "On n'a pas besoin"
	line "d'un nouveau"
	cont "confinement."
	
	para "Tout le monde"
	line "devrait se faire"
	cont "vacciner."
else
    text "We don't need a"
    line "new lockdown."
    
    para "Everyone should"
    line "get vaccinated."
endc
    done

VaccinationCenter_Text13:
if DEF(_FR_FR)
	text "Le MAITRE de la"
	line "LIGUE m'a motivé"
	cont "à me faire vacci-"
    cont "ner."
else
    text "The LEAGUE CHAMP-"
    line "ION inspired me"
    cont "to get vaccinated."
endc
    done

VaccinationCenter_Text13Sequel:
if DEF(_FR_FR)
	text "Hé mais c'est toi!"
	line "J'en reviens pas!"
else
    text "Hey it's you!"
    line "Incredible!"
endc
    done

VaccinationCenter_Text14:
if DEF(_FR_FR)
	text "J'étais antivax"
	line "jusqu'à ce que je"
	
	para "tombe gravement"
	line "malade, alors que"
	
	para "ma femme vaccinée,"
	line "elle, n'a rien eu."
	
	para "Maintenant, je"
    line "veux protéger"
	cont "mes #MON."
else
    text "I used to be an"
    line "anti-vaxxer until"
    
    para "I became severely"
    line "ill while my vac-"
    
    para "cinated wife didn't"
    line "get affected at"
    cont "all."
    
    para "Now I want to pro-"
    line "tect my #MON."
endc
    done

VaccinationCenter_Text15:
if DEF(_FR_FR)
	text "Pourquoi tu parles"
	line "à tout le monde?"
	
	para "Arrête! C'est"
	line "gênant."
else
    text "Why are you talk-"
    line "ing to everyone?"
    
    para "Stop it! It's"
    line "embarrassing."
endc
    done

VaccinationCenter_Text16:
if DEF(_FR_FR)
	text "Dès que le vaccin"
	line "pour les #MON a"
	cont "été annoncé,"
	
	para "tout le monde a"
	line "pris rendez-vous"
	cont "en même temps!"
	
	para "Ca a engendré des"
	line "semaines de délai."
else
    text "As soon as the"
    line "#MON vaccine"
    cont "was announced,"
    
    para "everyone took an"
    line "appointment at"
    cont "once!"
    
    para "It lead to weeks"
    line "of delay."
endc
    done

VaccinationCenter_Text17:
if DEF(_FR_FR)
	text "Han?"
	
	para "J'ai fermé les"
    line "yeux une seconde."
	
    para "Est-ce que j'ai"
	line "raté mon tour?"
else
    text "Ah!"

    para "I rested my eyes"
    line "for a second. Did"
    cont "I miss my slot?"
endc
    done

VaccinationCenter1F_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  3,  7, SAFFRON_CITY, 17
	warp_event  4,  7, SAFFRON_CITY, 17
	warp_event 10,  0, VACCINATION_CENTER_CORRIDOR, 1

    def_coord_events
	coord_event  9,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 13,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 15,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 14,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event 12,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event  7,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event  8,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript
	coord_event  6,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterForbiddenSeatScript

	coord_event  9,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript
	coord_event 13,  1, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript
	coord_event 12,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript
	coord_event  8,  3, CE_SCENE_ID, SCENE_VACCINATION_CENTER_FIND_SEAT, VaccinationCenterAllowedSeatScript

	;coord_event 10,  2, CE_SCENE_ID, 2, VaccinationCenterGoToOffice
    
    def_bg_events
	bg_event  5,  6, BGEVENT_READ, VaccinationCenterGelScript
	bg_event 11,  0, BGEVENT_READ, VaccinationCenter1FScanner
	bg_event 10,  0, BGEVENT_READ, VaccinationCenterLockScript

    def_object_events
	object_event  3,  3, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenterReceptionistScript, -1
	object_event 11,  5, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenterChanseyScript, -1
	object_event 10,  0, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenterGoToOffice, 0

	object_event 15,  1, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script1, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 14,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script2, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event  7,  1, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script4, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  9,  1, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script5, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 13,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script6, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | MORN, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script7, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event 12,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script8, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  8,  3, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script9, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  7,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script10, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event 13,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script11, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | DAY, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script12, EVENT_CROWD_IN_VACCINATION_CENTER

	object_event 12,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script13, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  8,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script14, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  9,  1, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script15, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  6,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, 0, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script16, EVENT_CROWD_IN_VACCINATION_CENTER
	object_event  7,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, %11100000 | NITE, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinationCenter_Script17, EVENT_CROWD_IN_VACCINATION_CENTER
