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

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    endcallback

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

SilphCoResearchScientist1:
    jumptextfaceplayer SilphCoResearchScientist1Text

SilphCoResearch_ElevatorButton:
    jumpstd ElevatorButtonScript

SilphCoResearch_Printer:
	jumptext SilphCoResearch_FaxText

SilphCoResearch_UpGrade:
	itemball UP_GRADE

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
	object_event  8,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1, -1
	object_event  1,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1, -1
	object_event 14,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1, -1
	object_event  3,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1, -1
	object_event 14,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1, -1
    
