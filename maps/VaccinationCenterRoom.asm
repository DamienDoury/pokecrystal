    object_const_def
    const VACCINATION_CENTER_VACCINE
    const VACCINATION_CENTER_MON

VaccinationCenterRoom_MapScripts:
    def_scene_scripts

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    disappear VACCINATION_CENTER_MON
    setval 2
    writemem wSickMonIsInThisRoom
    endcallback

VaccinationCenterRoomVaccineScript:
    faceplayer
    opentext 

    checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
    iftrue .must_leave

    checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
    iffalse .first_meeting_today

    writetext VaccinationCenterRoom_SecondMeetingText
    waitbutton
    sjump .select_mon

.first_meeting_today:
    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
    writetext VaccinationCenterRoom_IntroText
.explanation:
    yesorno
    iftrue .explanation_done
    writetext VaccinationCenterRoom_InfoText
    sjump .explanation

.explanation_done:
    writetext VaccinationCenterRoom_GoodText
    waitbutton
    sjump .select_mon

.reselect_mon:
    writetext VaccinationCenterRoom_ChooseAnotherText
    waitbutton

.select_mon:
    special SelectMonToVaccinate
	ifequal VACCINATION_NEVER_GOT_COVID, .never_got_covid
	ifequal VACCINATION_PREVIOUSLY_GOT_COVID, .previously_got_covid
	ifequal VACCINATION_GOT_FIRST_SHOT, .got_first_shot
	ifequal VACCINATION_CURRENTLY_SICK, .currently_sick
	ifequal VACCINATION_FULLY_VACCINATED, .fully_vaccinated
	ifequal VACCINATION_IS_EGG, .is_egg
    ;ifequal VACCINATION_CANCEL, .cancel 
;.cancel:
    jumptext VaccinationCenterRoom_CancelText

.currently_sick:
    writetext VaccinationCenterRoom_CurrentlySickText
    promptbutton
    sjump .reselect_mon

.fully_vaccinated:
    writetext VaccinationCenterRoom_FullText
    promptbutton
    sjump .reselect_mon

.is_egg:
    writetext VaccinationCenterRoom_EggText
    promptbutton
    sjump .reselect_mon

.never_got_covid:
    writetext VaccinationCenterRoom_NeverCovidText
    promptbutton
    sjump .proceed

.previously_got_covid:
    writetext VaccinationCenterRoom_PrevCovidText
    promptbutton
    sjump .proceed
    
.got_first_shot:
    writetext VaccinationCenterRoom_PrevShotText
    promptbutton

.proceed:  
    writetext VaccinationCenterRoom_BedText
    waitbutton
    closetext

    applymovement VACCINATION_CENTER_VACCINE, VaccinationCenterRoom_FetchVaccineMovement
    readvar VAR_YCOORD
    ifgreater 4, .player_is_below
;.player_is_above
    applymovement PLAYER, VaccinationCenterRoom_DownDownMovement
    sjump .release_mon_on_bed

.player_is_below:
    applymovement PLAYER, VaccinationCenterRoom_UpUpMovement

.release_mon_on_bed
    applymovement PLAYER, VaccinationCenterRoom_HeadLeftMovement
    playsound SFX_BALL_POOF
    waitsfx
    appear VACCINATION_CENTER_MON
    pause 10
    

    applymovement PLAYER, VaccinationCenterRoom_DownDownMovement
    applymovement PLAYER, VaccinationCenter_HeadUpMovement

    applymovement VACCINATION_CENTER_VACCINE, VaccinationCenterRoom_ComeBackFromVaccineMovement

    opentext 
    writetext VaccinationCenterRoom_InjectionText
    waitbutton 
    closetext

    pause 15

    special PlayCurMonCry
    waitsfx
    pause 20

    special Vaccinate

    applymovement VACCINATION_CENTER_VACCINE, VaccinationCenter_HeadDownMovement
    opentext 
    writetext VaccinationCenterRoom_DoneText
    promptbutton 

    waitsfx
    playsound SFX_BALL_POOF
    pause 2
    disappear VACCINATION_CENTER_MON
    waitsfx

    setval 0
    writemem wSickMonIsInThisRoom ; Security, to make sure it doesn't mess something else.

.must_leave:
    setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
    writetext VaccinationCenterRoom_MustLeaveText
    waitbutton
    closetext
    end

VaccinationCenterRoom_VialsScript:
	jumptext VaccinationCenterRoom_VialsText

VaccinationCenterRoom_FetchVaccineMovement:
    step UP
    step LEFT
    step UP
    step_end

VaccinationCenterRoom_UpUpMovement:
    step UP
    step UP
    step_end

VaccinationCenterRoom_DownDownMovement:
    step DOWN
    step DOWN
    step_end

VaccinationCenterRoom_ComeBackFromVaccineMovement:
    step RIGHT
    step DOWN
    step DOWN

VaccinationCenterRoom_HeadLeftMovement:
    turn_head LEFT
    step_end

VaccinationCenterRoom_IntroText:
if DEF(_FR_FR)
	text "<PLAYER>."
	line "C'est correct?"
	
	para "Bien."
	
	para "On vous a informé"
	line "sur le processus"
	cont "de vaccination?"
else
    text "<PLAYER> is"
    line "that it?"

    para "Good."

    para "Have you been"
    line "informed on how"
    
    para "the vaccination"
    line "works?"
endc
    done

VaccinationCenterRoom_InfoText:
if DEF(_FR_FR)
	text "Le vaccin est in-"
	line "séré dans le corps"
	cont "par injection."
	
	para "Pour une bonne"
	line "protection immuni-"
	cont "taire, il faut 2"
	cont "doses, espacées"
	cont "dans le temps."
	
	para "Je ne vais"
	line "administrer"
	cont "qu'une dose"
	cont "aujourd'hui."
	
	para "Si ton #MON a"
	line "déjà attrapé le"
	cont "COVID-19, alors "
    cont "une seule dose"
	cont "suffira pour"
	cont "atteindre la"
	cont "dose complète."
	
	para "Quand ton #MON"
	line "aura reçu la dose"
	cont "complète, il ne"
    cont "sera pas totale-"
	cont "ment immunisé"
	cont "contre le virus."
    cont "Non."
	
	para "Mais ça réduira"
	line "considérablement"
	cont "la contagiosité"
	cont "et la gravité"
	cont "des symptômes."
	
	para "Par conséquent,"
    line "ça protège aussi"
	cont "les autres."
	
	para "Des effets secon-"
	line "daires peuvent"
	cont "apparaître, mais"
	cont "c'est vraiment"
    cont "très rare."
	
	para "Le risque d'en"
	line "contracter un est"
    cont "bien plus faible"
	cont "que le risque d'"
    cont "attraper le virus."
	
	para "Et c'est tout"
    line "gratuit!"
	
	para "C'est clair pour"
    line "toi?"
else
    text "The vaccine is"
    line "inserted into the"
    cont "body by injection."

    para "The dose required"
    line "for a good immune"
    cont "protection is 2"
    cont "shots, with a"
    cont "little time"
    cont "in-between."

    para "I will only"
    line "administer"
    cont "1 shot today."

    para "If your #MON"
    line "already caught"
    cont "COVID-19 in the"
    cont "past, only 1 shot"
    cont "will be necessary"
    cont "to reach the full"
    cont "dose."

    para "Once your #MON"
    line "has the full dose,"
    cont "it won't be fully"
    cont "immune to the"
    cont "virus. No."

    para "But it will"
    line "greatly reduce the"
    cont "contagiousness"
    cont "and severity of"
    cont "the symptoms."

    para "Thus, it will also"
    line "protect others."

    para "Side effects may"
    line "appear, but are"
    cont "extremely rare."

    para "The odds of"
    line "contracting a"
    cont "side effect are"
    cont "way lower than"
    cont "the odds of cat-"
    cont "ching COVID-19."

    para "All of this is"
    line "free of charge!"

    para "Was I clear?"
endc
    done

VaccinationCenterRoom_GoodText:
if DEF(_FR_FR)
	text "Parfait."
	
	para "Quel #MON doit"
	line "être vacciné"
	cont "aujourd'hui?"
else
    text "Good."

    para "Which #MON"
    line "should be"
    cont "vaccinated today?"
endc
    done

VaccinationCenterRoom_EggText:
if DEF(_FR_FR)
	text "Je ne peux pas"
	line "vacciner un OEUF!"
else
    text "I can't vaccinate"
    line "an EGG!"
endc
    done

VaccinationCenterRoom_PrevShotText:
if DEF(_FR_FR)
	text "Je vois que ce"
	line "#MON a déjà"
	cont "reçu une première"
    cont "dose."
	
	para "C'est bien que tu"
	line "reviennes pour la"
	cont "deuxième, c'est"
	cont "important."
else
    text "I see this #MON"
    line "previously got a"
    cont "vaccine shot."

    para "I'm glad you came"
    line "back for the"
    cont "second one, it is"
    cont "important."
endc
    done

VaccinationCenterRoom_PrevCovidText:
if DEF(_FR_FR)
	text "Je vois que ce"
	line "#MON a déjà"
	cont "attrapé le"
	cont "COVID-19."
	
	para "Du coup cette"
    line "injection fera"
	cont "office de deuxième"
	cont "dose."
	
	para "Inutile d'en faire"
	line "une deuxième plus"
	cont "tard."
else
    text "I see this #MON"
    line "already caught"
    cont "COVID-19 in the"
    cont "past."

    para "Then this shot"
    line "first shot will"
    cont "act as the second"
    cont "dose."
    
    para "No need for a 2nd"
    line "shot later."
endc
    done

VaccinationCenterRoom_CurrentlySickText:
if DEF(_FR_FR)
	text "Une minute. Ce"
	line "#MON est actu-"
	cont "ellement malade?"
	
	para "Ne le fais surtout"
	line "pas sortir de sa"
	cont "BALL!"
	
	para "Un #MON malade"
	line "ne peut pas être"
	cont "vacciné de toute"
	cont "façon."
	
	para "Il faut attendre"
	line "la disparition"
	cont "des symptômes."
else
    text "Wait, this #MON"
    line "is currently sick?"

    para "Do not release it"
    line "out of its BALL!"

    para "A sick #MON"
    line "can't be vacci-"
    cont "nated anyway."

    para "You must wait for"
    line "the disease to go,"
    cont "and for the immu-"
    cont "nity to settle."
endc
    done

VaccinationCenterRoom_NeverCovidText:
if DEF(_FR_FR)
	text "Ce #MON n'a"
	line "jamais attrapé"
    cont "le COVID-19."
	
	para "Une deuxième dose"
	line "sera nécessaire"
	cont "plus tard pour une"
	cont "protection signi-"
    cont "ficative."
else
    text "This #MON"
    line "never caught"
    cont "COVID-19 before."

    para "A 2nd shot will"
    line "be required later,"
    cont "to fully protect"
    cont "your #MON."
endc
    done

VaccinationCenterRoom_FullText:
if DEF(_FR_FR)
	text "Ce #MON n'a pas"
	line "besoin d'injection"
	cont "supplémentaire."
else
    text "This #MON"
    line "doesn't need more"
    cont "shots."
endc
    done

VaccinationCenterRoom_ChooseAnotherText:
if DEF(_FR_FR)
	text "Choisis un autre"
	line "#MON s'il te"
    cont "plaît."
else
    text "Please choose"
    line "another #MON."
endc
    done

VaccinationCenterRoom_CancelText:
if DEF(_FR_FR)
	text "Un changement"
	line "d'avis soudain?"
	
	para "C'est ta décision."

	para "Reviens quand tu"
    line "te sentiras à"
    cont "l'aise."
else
    text "A sudden change"
    line "of mind?"

    para "It's your call."
    line "Come back when"
    cont "you're ready."
endc
    done

VaccinationCenterRoom_SecondMeetingText:
if DEF(_FR_FR)
	text "Ecoute, j'ai pas le"
	line "temps de rêvasser."
	
	para "Tu veux faire"
    line "vacciner un de"
	cont "tes #MON?"
else
    text "Look, I don't"
    line "have time to"
    cont "waste."

    para "Do you want your"
    line "#MON to get"
    cont "vaccinated?"
endc
    done

VaccinationCenterRoom_MustLeaveText:
if DEF(_FR_FR)
	text "Il faut que tu"
    line "laisses la place."
	
	para "Le patient suivant"
	line "attend."
else
    text "You must leave"
    line "now."
    
    para "The next patient"
    line "is waiting."
endc
    done

VaccinationCenterRoom_BedText:
if DEF(_FR_FR)
	text "Place ton #MON"
	line "sur le lit, je te"
    cont "prie."
else
    text "Please put your"
    line "#MON on the"
    cont "bed."
endc
    done

VaccinationCenterRoom_InjectionText:
if DEF(_FR_FR)
	text "Je procède à"
	line "l'injection."
	
	para "Tu vas voir, c'est"
	line "indolore..."
	
	para "...pour la plupart"
	line "des individus"
    cont "en tout cas."
else
    text "I'm proceeding to"
    line "the injection."

    para "You'll see it's"
    line "painless…"

    para "…for most indivi-"
    line "duals anyway."
endc
    done

VaccinationCenterRoom_DoneText:
if DEF(_FR_FR)
	text "Terminé!"
	
	para "J'ai mis à jour"
	line "l'état vaccinal de"
    cont "ton #MON dans"
	cont "ses STATS."
	
	para "Merci d'avoir fait"
	line "ta part contre"
	cont "le COVID!"
else
    text "Done!"

    para "I've updated the"
    line "STATUS of your"
    cont "#MON to reflect"
    cont "its vaccination"
    cont "state."

    para "Thanks for doing"
    line "your part against"
    cont "COVID!"
endc
    done

VaccinationCenterRoom_VialsText:
if DEF(_FR_FR)
	text "Des fioles réfri-"
    line "gérées en masse."
else
    text "Tons of refrige-"
    line "rated vials."
endc
    done


VaccinationCenterRoom_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  1,  7, VACCINATION_CENTER_CORRIDOR, 3
	warp_event  0,  7, VACCINATION_CENTER_CORRIDOR, 3

    def_coord_events

    def_bg_events
	bg_event  0,  1, BGEVENT_READ, VaccinationCenterRoom_VialsScript
	bg_event  1,  1, BGEVENT_READ, VaccinationCenterRoom_VialsScript


    def_object_events
	object_event  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VaccinationCenterRoomVaccineScript, -1
	object_event  0,  4, SPRITE_HOSPITAL_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 6, OBJECTTYPE_SCRIPT, 0, VaccinationCenterRoomVaccineScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
