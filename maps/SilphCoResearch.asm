    object_const_def
    const SILPHCORESEARCH_POKEBALL_PORYGON
    const SILPHCORESEARCH_POKEBALL_FARFETCHD
    const SILPHCORESEARCH_POKEBALL_MRMIME
    const SILPHCORESEARCH_POKEBALL_LICKITUNG
    const SILPHCORESEARCH_POKEBALL_EXEGGCUTE
    const SILPHCORESEARCH_POKEBALL_UP_GRADE
    const SILPHCORESEARCH_SCIENTIST1

SilphCoResearch_MapScripts:
    def_scene_scripts
    scene_script .Scene ; SCENE_DEFAULT  / 0
    scene_script .Scene ; SCENE_FINISHED / 1

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    checkevent EVENT_SILPHCO_SCIENTIST_MET
    iftrue .end
    moveobject SILPHCORESEARCH_SCIENTIST1, 13, 1
.end
    endcallback

.Scene:
    checkevent EVENT_SILPHCO_SCIENTIST_MET
    iftrue .no_scene

    setevent EVENT_SILPHCO_SCIENTIST_MET
    prioritysjump .Accompany ; Use prioritysjump (now better called sdefer) to clear the automatic step down movement triggered by the elevator door (staircase).
    end

.Accompany:   
    follow SILPHCORESEARCH_SCIENTIST1, PLAYER
    applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_GoToDeskMovement
    stopfollow
    applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_GoToDeskAfterFollowMovement

    opentext
    writetext SilphCoResearchScientist1_HiText
    waitbutton
    closetext

    applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_GetItemMovement
    pause 10
    applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_GiveItemMovement

    opentext
    verbosegiveitem RARE_CANDY
    closetext

    applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_RespectDistanceMovement
    pause 5

    opentext
    writetext SilphCoResearchScientist1_PassText
    waitbutton
    closetext

    applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_ReturnToWorkMovement
    moveobject SILPHCORESEARCH_SCIENTIST1, 8, 5
    moveobject PLAYER, 6, 5
.no_scene
    end

SilphCo_PokeballContentAccorded:
    readmem wStringBuffer3
    ifequal $80, .vowel
    ifequal $84, .vowel
    ifequal $88, .vowel
    ifequal $8e, .vowel
    ifequal $94, .vowel
    ifequal $98, .vowel

    writetext SilphCo_LookPokeballText
    end

.vowel
    writetext SilphCo_LookPokeballVowelText
    end

SilphCo_LookPokeballScript:
    opentext 
    scall SilphCo_PokeballContentAccorded
    loadmem wTempByteValue, 0
    waitbutton
    closetext
    end




SilphCoPorygonPokeBallScript:
    setval PORYGON
    sjump SilphCoClickedPokeball

SilphCoFarfetchdPokeBallScript:
    setval FARFETCH_D
    sjump SilphCoClickedPokeball

SilphCoMrMimePokeBallScript:
    setval MR__MIME
    sjump SilphCoClickedPokeball

SilphCoLickitungPokeBallScript:
    setval LICKITUNG
    sjump SilphCoClickedPokeball

SilphCoExeggcutePokeBallScript:
    setval EXEGGCUTE

SilphCoClickedPokeball:
    getmonname STRING_BUFFER_3, USE_SCRIPT_VAR
    writemem wTempByteValue ; Backup the species.
    checkevent EVENT_GOT_POKEMON_FROM_SILPHCO
    iftrue SilphCo_LookPokeballScript

    readmem wTempByteValue ; Retrieve the species.
    refreshscreen
	pokepic USE_SCRIPT_VAR
	cry USE_SCRIPT_VAR
	waitbutton
	closepokepic
	opentext
    writemem wTempByteValue ; Backup the species.
    scall SilphCo_PokeballContentAccorded ;writetext SilphCo_LookPokeballText
    readmem wTempByteValue ; Retrieve the species.
    promptbutton

    writetext SilphCo_LevelText
    promptbutton

    loadmem wTempByteValue, 0
    special LoadSilphCoPokemonMoves
    writetext SilphCo_Moves12Text
    promptbutton

    loadmem wTempByteValue, 2
    special LoadSilphCoPokemonMoves
    writetext SilphCo_Moves34Text
    promptbutton
    writetext SilphCo_WannaTakeItText

    writemem wTempByteValue ; Backup the species.
    yesorno
    iftrue .getmon
    closetext
    end

.getmon
    readvar VAR_PARTYCOUNT
    ifgreater PARTY_LENGTH - 1, .partyfull

    farwritetext ManiaText_GotShuckle
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton

    readmem wTempByteValue
    ifequal PORYGON, .porygon
    ifequal FARFETCH_D, .farfetchd
    ifequal MR__MIME, .mrmime
    ifequal LICKITUNG, .lickitung
    ifequal EXEGGCUTE, .exeggcute
    sjump .end

.porygon
    disappear SILPHCORESEARCH_POKEBALL_PORYGON
    givepoke PORYGON, 10
    setevent EVENT_PORYGON_POKEBALL_IN_SILPHCO
    sjump .mon_taken

.farfetchd
    disappear SILPHCORESEARCH_POKEBALL_FARFETCHD
    givepoke FARFETCH_D, 10, STICK
    setevent EVENT_FARFETCHD_POKEBALL_IN_SILPHCO
    sjump .mon_taken

.mrmime
    disappear SILPHCORESEARCH_POKEBALL_MRMIME
    givepoke MR__MIME, 10, TOILET_PAPER
    setevent EVENT_MRMIME_POKEBALL_IN_SILPHCO
    sjump .mon_taken

.lickitung
    disappear SILPHCORESEARCH_POKEBALL_LICKITUNG
    givepoke LICKITUNG, 10, LEFTOVERS
    setevent EVENT_LICKITUNG_POKEBALL_IN_SILPHCO
    sjump .mon_taken

.exeggcute
    disappear SILPHCORESEARCH_POKEBALL_EXEGGCUTE
    givepoke EXEGGCUTE, 10
    setevent EVENT_EXEGGCUTE_POKEBALL_IN_SILPHCO

.mon_taken
    setevent EVENT_GOT_POKEMON_FROM_SILPHCO
    special SilphCo_SetMonAttributes
    
.end
    loadmem wTempByteValue, 0
    closetext
    end

.partyfull
    writetext SilphCo_PartyFullText
    waitbutton
    closetext
    end

SilphCoResearchScientist1Script:

SilphCoResearchScientist2Script:
    jumptextfaceplayer SilphCoResearchScientist2_Text

SilphCoResearchScientist3Script:
    jumptextfaceplayer SilphCoResearchScientist3_Text

SilphCoResearchScientist4Script:
    jumptextfaceplayer SilphCoResearchScientist4_Text

SilphCoResearchScientist5Script:
    jumptextfaceplayer SilphCoResearchScientist5_Text

SilphCoResearchScientist1:
    jumptextfaceplayer SilphCoResearchScientist1Text

SilphCoResearch_ElevatorButton:
    jumpstd ElevatorButtonScript

SilphCoResearch_Printer:
	jumptext SilphCoResearch_FaxText

SilphCoResearch_UpGrade:
	itemball UP_GRADE


SilphCoResearch_GoToDeskMovement:
    step DOWN
    step DOWN
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step UP
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step LEFT
    step DOWN
    step DOWN
    step DOWN
    step RIGHT
    step RIGHT
    step_end

SilphCoResearch_GoToDeskAfterFollowMovement:
    step RIGHT
    turn_head LEFT
    step_end

SilphCoResearch_ReturnToWorkMovement:
SilphCoResearch_GetItemMovement:
    slow_step RIGHT
    turn_head UP
    step_end

SilphCoResearch_GiveItemMovement:
    slow_step LEFT
    slow_step LEFT
    step_end 

SilphCoResearch_RespectDistanceMovement:
    fix_facing
    slow_step RIGHT
    remove_fixed_facing
    step_end 

SilphCo_LookPokeballText:
    text "It contains a"
	line "@"
	text_ram wStringBuffer3
	text "."
	done

SilphCo_LookPokeballVowelText:
    text "It contains an"
	line "@"
	text_ram wStringBuffer3
	text "."
	done

SilphCo_LevelText:
    text "It is level 10 and"
    line "knows the moves"
    done

SilphCo_Moves12Text:
    text "@"
	text_ram wStringBuffer2
	text ","

    line "@"
    text_ram wStringBuffer1
	text ","
    done

SilphCo_Moves34Text:
    text "@"
	text_ram wStringBuffer2
	text ","

    line "and @"
    text_ram wStringBuffer1
	text "."
    done

SilphCo_WannaTakeItText:
    text "Do you want to"
    line "take this one?"
    done

SilphCo_PartyFullText:
    text "But your party is"
    line "full."
    done



SilphCoResearch_FaxText:
    text "There's a printed"
    line "fax signed by"
    cont "PROF.OAK,"
    cont "PROF.ELM,"
    cont "MR.#MON,"
    cont "CHIEF NURSE JOY,"
    cont "and… EUSINE?"

    para "This must be very"
    line "important."
    done

SilphCoResearchScientist1Text:
    text "Reckless driving"
    line "causes accidents!"
    cont "Take it easy!"
    done

SilphCoResearchScientist1_HiText:
    text "This office is one"
    line "of the research"
    
    para "facilities devoted"
    line "to finding a"

;   para "#RUS vaccine"
;   line "for all #MON."
;   
;   para "We are currently"
;   line "field testing"
;   cont "our solution."
;   
;   para "This phase is tak-"
;   line "ing a lot of time"
;   
;   para "because we are"
;   line "checking each"
;   
;   para "#MON species"
;   line "one by one."
;   
;   para "That's why we need"
;   line "trainers like you."
;   
;   para "There are many"
;   line "#BALL in this"
;   cont "office."
;   
;   para "They all contain"
;   line "a voluntary test"
;   
;   para "subject that has"
;   line "been injected with"
;   
;   para "our prototype of"
;   line "the vaccine."
;   
;   para "I want you to"
;   line "pick 1 #BALL."
;   
;   para "Go train and do"
;   line "battles with the"
;   cont "chosen #MON."
;   
;   para "Then return it"
;   line "back, so we can"
;   
;   para "analyze the"
;   line "effects of the"
;   
;   para "vaccine on its"
;   line "health."
;   
;   para "Oh, I almost"
;   line "forgot!"

    para "You're gonna"
    line "need this."
    done

SilphCoResearchScientist1_PassText:
    text "With this, the"
    line "security guard"
    cont "won't bother you."

    para "…"

    para "One last thing:"
    line "the #MON in"

    para "this laboratory"
    line "have weird colors."

    para "It's the result of"
    line "previous experi-"
    cont "mentations."

    para "Don't worry about"
    line "it, they're all"
    cont "fine!"
    done

    ;case 1) How is our test subject #MON doing? 
    ;case 2) I see the test subject #MON is doing good.

    ;case 1A) et 2A) That wouldn't be not enough data to analyze. Come back after training it way more.
    ;case 1B) et 2B) A little more training with you, and we should have enough data to analyze.
    ;case 1C) That should be enough data gathered, please bring it back.
    ;case 2C) Give it to me, I'll go check the results right now.

    ; This concludes the testing phase! Since we reached a success rate above 80% several weeks ago, we started mass production and distribution of this vaccine.
    ; With the power of a single call, I will now notify hierarchy and start saving thousands of lifes.
    ; -I'm feeling so powerful in this instant!-
    ; Our vaccination center is located right of this building and should open in a moment.
    ; We couldn't have done it without your help, LEAGUE CHAMPION.





SilphCoResearchScientist2_Text:
    text "It is safe to"
    line "use a contagious"
    
    para "#MON in battle"
    line "as long as no"

    para "healthy one is"
    line "sent afterwards."
    done

SilphCoResearchScientist3_Text:
    text "We made a break-"
    line "through in the"
    
    para "research thanks to"
    line "a SUICUNE water"
    cont "sample."
    done

SilphCoResearchScientist4_Text:
    text "Our research shows"
    line "that the virus"

    para "that gives COVID is"
    line "a modified version"
    cont "of the #RUS."
    done

SilphCoResearchScientist5_Text:
    text "Yup, I'm the guy"
    line "that came up with"
    cont "the #MASK."

    para "Unfortunately,"
    line "making it ready"
    
    para "for mass produc-"
    line "tion is a huge"
    cont "challenge."
    done

SilphCoResearch_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event 13,  0, SILPHCO_ELEVATOR, 2

    def_coord_events

    def_bg_events
	bg_event 12,  0, BGEVENT_READ, SilphCoResearch_ElevatorButton
	bg_event  7,  1, BGEVENT_READ, SilphCoResearch_Printer

    def_object_events
	object_event 13,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoPorygonPokeBallScript, EVENT_PORYGON_POKEBALL_IN_SILPHCO
	object_event  0,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoFarfetchdPokeBallScript, EVENT_FARFETCHD_POKEBALL_IN_SILPHCO
	object_event  0,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoMrMimePokeBallScript, EVENT_MRMIME_POKEBALL_IN_SILPHCO
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoLickitungPokeBallScript, EVENT_LICKITUNG_POKEBALL_IN_SILPHCO
	object_event 10,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoExeggcutePokeBallScript, EVENT_EXEGGCUTE_POKEBALL_IN_SILPHCO
	object_event  7,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilphCoResearch_UpGrade, EVENT_FOUND_UP_GRADE
	object_event  8,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1Script, -1
	object_event  1,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist2Script, -1
	object_event 14,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist3Script, -1
	object_event  3,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist4Script, -1
	object_event 15,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist5Script, -1
    
