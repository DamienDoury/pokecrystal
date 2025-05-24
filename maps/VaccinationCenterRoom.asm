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
    end

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

VaccinationCenterRoom_IntroText: ; TO TRANSLATE
    text "<PLAYER> is"
    line "that it?"

    para "Good."

    para "Have you been"
    line "informed on how"
    
    para "the vaccination"
    line "works?"
    done

VaccinationCenterRoom_InfoText: ; TO TRANSLATE
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
    done

VaccinationCenterRoom_GoodText: ; TO TRANSLATE
    text "Good."

    para "Which #MON"
    line "should be"
    cont "vaccinated today?"
    done

VaccinationCenterRoom_EggText: ; TO TRANSLATE
    text "I can't vaccinate"
    line "an EGG!"
    done

VaccinationCenterRoom_PrevShotText: ; TO TRANSLATE
    text "I see this #MON"
    line "previously got a"
    cont "vaccine shot."

    para "I'm glad you came"
    line "back for the"
    cont "second one, it is"
    cont "important."
    done

VaccinationCenterRoom_PrevCovidText: ; TO TRANSLATE
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
    done

VaccinationCenterRoom_CurrentlySickText: ; TO TRANSLATE
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
    done

VaccinationCenterRoom_NeverCovidText: ; TO TRANSLATE
    text "This #MON"
    line "never caught"
    cont "COVID-19 before."

    para "A 2nd shot will"
    line "be required later,"
    cont "to fully protect"
    cont "your #MON."
    done

VaccinationCenterRoom_FullText: ; TO TRANSLATE
    text "This #MON"
    line "doesn't need more"
    cont "shots."
    done

VaccinationCenterRoom_ChooseAnotherText: ; TO TRANSLATE
    text "Please choose"
    line "another #MON."
    done

VaccinationCenterRoom_CancelText: ; TO TRANSLATE
    text "A sudden change"
    line "of mind?"

    para "It's your call."
    line "Come back when"
    cont "you're ready."
    done

VaccinationCenterRoom_SecondMeetingText: ; TO TRANSLATE
    text "Look, I don't"
    line "have time to"
    cont "waste."

    para "Do you want your"
    line "#MON to get"
    cont "vaccinated?"
    done

VaccinationCenterRoom_MustLeaveText: ; TO TRANSLATE
    text "You must leave"
    line "now."
    
    para "The next patient"
    line "is waiting."
    done

VaccinationCenterRoom_BedText: ; TO TRANSLATE
    text "Please put your"
    line "#MON on the"
    cont "bed."
    done

VaccinationCenterRoom_InjectionText: ; TO TRANSLATE
    text "I'm proceeding to"
    line "the injection."

    para "You'll see it's"
    line "painless…"

    para "…for most indivi-"
    line "duals anyway."
    done

VaccinationCenterRoom_DoneText: ; TO TRANSLATE
    text "Done!"

    para "I've updated the"
    line "STATUS of your"
    cont "#MON to reflect"
    cont "its vaccination"
    cont "state."

    para "Thanks for doing"
    line "your part against"
    cont "COVID!"
    done

VaccinationCenterRoom_VialsText: ; TO TRANSLATE
    text "Tons of refrige-"
    line "rated vials."
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
