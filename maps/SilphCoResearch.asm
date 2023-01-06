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
    verbosegiveitem SILPH_BADGE
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

IsVowel:
    readmem wStringBuffer3
    ifequal $80, .vowel
    ifequal $84, .vowel
    ifequal $88, .vowel
    ifequal $8e, .vowel
    ifequal $94, .vowel
    ifequal $98, .vowel

    setval FALSE
    end

.vowel
    setval TRUE
    end

SilphCo_PokeballContentAccorded:
    scall IsVowel
    iftrue .vowel

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
	faceplayer

	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iffalse .vaccine_is_available

; checking progress of the quest to find a vaccine.
	opentext 
	writetext SilphCoResearchScientist1_QuestIntro_Text
	promptbutton

	special SilphCo_GetTestSubjectProgress
	ifequal 0, .not_in_party

	writetext SilphCoResearchScientist1_Case2_Text
	promptbutton

	ifequal $a, .long_way_to_go
	ifequal $b, .almost_there
	ifequal $c, .training_finished

	; Unmanaged case.
	writetext SilphCoResearchScientist1_ConfusedText
	waitbutton
	closetext
	end
	
.vaccine_is_available
	jumptextfaceplayer SilphCoResearchScientist1_AfterQuest_Text

.not_in_party
	writetext SilphCoResearchScientist1_Case1_Text
	waitbutton
	closetext
	end

.long_way_to_go
	writetext SilphCoResearchScientist1_Case1A2A_Text
	sjump .check_level

.almost_there
	writetext SilphCoResearchScientist1_Case1B2B_Text

.check_level
	special SilphCo_GetTestSubjectLevel
	ifgreater 29, .explain_training_purpose
	waitbutton
	closetext
	end

.explain_training_purpose
	promptbutton
	writetext SilphCoResearchScientist1_ExplainTraining_Text
	waitbutton
	closetext
	end

.training_finished
	writetext SilphCoResearchScientist1_Case1C_Text
	waitbutton
	closetext
	
	opentext
	writetext SilphCoResearchScientist1_HandedOver_Text
	waitbutton
	closetext

	pause 5

	applymovement SILPHCORESEARCH_SCIENTIST1, SilphCoResearch_HeadUpMovement

	pause 5
	playsound SFX_BOOT_PC
	pause 90
	waitsfx

	faceplayer
	pause 5
	opentext
	writetext SilphCoResearchScientist1_CaseDone_Text
	promptbutton
	writetext SilphCoResearchScientist1_AfterQuest_Text
	waitbutton
	closetext

	clearevent EVENT_CROWD_IN_VACCINATION_CENTER

	; Either the happiness of the Pokémon is high and the player gets to keep it.
	; In this case, the trainer ID and trainer name of the #mon will be changed to those of the player.
	; Or the happiness is not high enough, and we remove the Pokémon from the player's party.
	special SilphCo_GetTestSubjectHappiness
	ifgreater 100, .keep_mon

; The test subject is removed from the player's party.
	special SilphCo_TestSubjectRemovedFromParty
	end
	
.keep_mon
	showemote EMOTE_QUESTION, SILPHCORESEARCH_SCIENTIST1, 15
	special SilphCo_PlayerGetsPropertyOfTestSubject ; Also places the Pokémon name in wStringBuffer1.

	opentext
	writetext SilphCoResearchScientist1_KeepMon_Text
	waitbutton
	closetext

	opentext
	writetext SilphCoResearchScientist1_GotBack_Text
	playsound SFX_KEY_ITEM
	waitbutton
	waitsfx
	closetext

	jumptext SilphCoResearchScientist1_ThankService_Text






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

SilphCoResearch_HeadUpMovement:
    turn_head UP
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

    para "#RUS vaccine"
    line "for all #MON."
    
    para "We are currently"
    line "field testing"
    cont "our solution."
    
    para "This phase is tak-"
    line "ing a lot of time"
    
    para "because we are"
    line "checking each"
    
    para "#MON species"
    line "one by one."
    
    para "That's why we need"
    line "trainers like you."
    
    para "There are many"
    line "#BALL in this"
    cont "office."
    
    para "They all contain"
    line "a voluntary test"
    
    para "subject that has"
    line "been injected with"
    
    para "our prototype of"
    line "the vaccine."
    
    para "I want you to"
    line "pick 1 #BALL."
    
    para "Go train and do"
    line "battles with the"
    cont "chosen #MON."
    
    para "Then return it"
    line "back, so we can"
    
    para "analyze the"
    line "effects of the"
    
    para "vaccine on its"
    line "health."
    
    para "Oh, I almost"
    line "forgot!"

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



; Case 1: the trainer doesn't have the test subject Pokémon in its party.
; Case 2: the trainer does.

; Case A: The trainer has done less than or equal to half the required amount of battles.
; Case B: The trainer has done more than half, but less than 100%.
; Case C: The trainer has done >= 100%.

SilphCoResearchScientist1_QuestIntro_Text:
	text "How is our test"
	line "subject #MON"
	cont "doing?"
	done

SilphCoResearchScientist1_Case1_Text:
	text "Please bring it"
	line "here so I can"
	
	para "check on the"
	line "effects of the"
	
	para "vaccine on its"
	line "health."
	done

SilphCoResearchScientist1_Case2_Text:	
    text "I see the test"
	line "subject #MON"
	cont "is doing good."
	done
	
SilphCoResearchScientist1_Case1A2A_Text:
	text "However I need"
	line "much more data"
	cont "to analyze."
	
	para "Come back after"
	line "training it way"
	cont "more."
	done

SilphCoResearchScientist1_Case1B2B_Text:
    text "A little more"
	line "training with you,"

	para "and we should have"
	line "enough data for"
	cont "reliable results."
	done

SilphCoResearchScientist1_ExplainTraining_Text:
	text "And by training"
	line "I mean battles."

	para "We need the test"
	line "subject to get"

	para "exposed to the"
	line "virus to see the"

	para "effects of the"
	line "vaccine."

	para "Using RARE CANDIES"
	line "and other doping"
	cont "items won't help."
	done

SilphCoResearchScientist1_Case1C_Text:
    text "You've trained"
	line "it a lot!"
	
	para "That should be"
	line "enough data."

    para "Give it to me,"
	line "I will check"
	
	para "the results right"
	line "now."
	done

SilphCoResearchScientist1_HandedOver_Text:
	text "<PLAYER> handed"
	line "over the #MON."
	done

SilphCoResearchScientist1_CaseDone_Text:
	text "Results are as"
	line "good as we"
	cont "expected!"

	para "This concludes the"
	line "testing phase!"
	
	para "Since we reached"
	line "a success rate"

	para "above 80<PERCENT> several"
	line "weeks ago,"
	
	para "we started mass"
	line "production and"
	
	para "distribution of"
	line "this vaccine."

	para "With the power of"
	line "a single call,"
	
	para "I will now notify"
	line "hierarchy and"
	
	para "start saving thou-"
	line "sands of lives."

    para "-I'm feeling so"
	line "powerful in this"
	cont "instant!-"
	done

SilphCoResearchScientist1_AfterQuest_Text:
    text "Our vaccination"
	line "center is located"
	
	para "to the right of"
	line "this building."

	para "We couldn't have"
	line "done it without"
	
	para "your help,"
	line "LEAGUE CHAMPION."
	done

SilphCoResearchScientist1_KeepMon_Text:
	text "The test subject"
	line "#MON feels"
	
	para "attached to you"
	line "and would like to"
	cont "stay with you."

	para "I see no problem"
	line "with that."
	done

SilphCoResearchScientist1_GotBack_Text:
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer1
	text " back!"
	done

SilphCoResearchScientist1_ThankService_Text:
	text "Thank you for your"
	line "service, dear"
	cont "@"
	text_ram wStringBuffer1
	text "."
	done
	



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

    para "that gives COVID"
    line "is a mutated ver-"
    cont "sion of #RUS."
    done

SilphCoResearchScientist5_Text:
    text "Yup, I'm the guy"
    line "that came up with"
    cont "the #MASK."

    para "Unfortunately,"
    line "making it ready"
    
    para "for mass produc-"
    line "tion as well as"
	
	para "affordable is a"
    line "huge challenge."
    done

SilphCoResearchScientist1_ConfusedText:
	text "I'm sorry"
	line "I'm confused."
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
    
