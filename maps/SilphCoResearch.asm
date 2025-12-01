    object_const_def
    const SILPHCORESEARCH_POKEBALL_PORYGON
    const SILPHCORESEARCH_POKEBALL_FARFETCHD
    const SILPHCORESEARCH_POKEBALL_MRMIME
    const SILPHCORESEARCH_POKEBALL_LICKITUNG
    const SILPHCORESEARCH_POKEBALL_EXEGGCUTE
    const SILPHCORESEARCH_POKEBALL_UP_GRADE
    const SILPHCORESEARCH_SCIENTIST1
    const SILPHCORESEARCH_SCIENTIST2
    const SILPHCORESEARCH_SCIENTIST3
    const SILPHCORESEARCH_SCIENTIST4
    const SILPHCORESEARCH_SCIENTIST5
    const SILPHCORESEARCH_SCIENTIST6

SilphCoResearch_MapScripts:
    def_scene_scripts
    scene_script .Scene ; SCENE_ALWAYS

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    loadmem wNewStarterSpecies, 0
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

if DEF(_EN_US)
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
endc

SilphCo_PokeballContentAccorded:
if DEF(_FR_FR)
    writetext SilphCo_LookPokeballText
else
    scall IsVowel
    iftrue .vowel

    writetext SilphCo_LookPokeballText
    end

.vowel
    writetext SilphCo_LookPokeballVowelText
endc
    end

SilphCo_LookPokeballScript:
    opentext 
    scall SilphCo_PokeballContentAccorded
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
    writemem wNewStarterSpecies ; Backup the species.
    checkevent EVENT_GOT_POKEMON_FROM_SILPHCO
    iftrue SilphCo_LookPokeballScript

    refreshscreen
    readmem wNewStarterSpecies ; Retrieve the species.
	pokepic USE_SCRIPT_VAR
	cry USE_SCRIPT_VAR
	waitbutton
	closepokepic
	opentext
    scall SilphCo_PokeballContentAccorded
    promptbutton

    writetext SilphCo_LevelText
    promptbutton

    loadmem wNewStarterMovesIndex, 0
    special LoadSilphCoPokemonMoves
    writetext SilphCo_Moves12Text
    promptbutton

    loadmem wNewStarterMovesIndex, 2
    special LoadSilphCoPokemonMoves
    writetext SilphCo_Moves34Text
    promptbutton
    writetext SilphCo_WannaTakeItText
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

    readmem wNewStarterSpecies
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
    readmem wKantoAddLevel
	addval 2
	writemem wKantoAddLevel

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

    readmem wYearMonth
	addval 1
	writemem wYearMonth

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

SilphCoResearchScientist6Script:
    faceplayer
    opentext
    writetext SilphCoResearchScientist6IntroText
    checkitem DOME_FOSSIL
    iftrue .dome
    checkitem HELIX_FOSSIL
    iftrue .helix
    checkitem OLD_AMBER
    iftrue .amber
.wait_and_close_text
    waitbutton
    closetext
    end

.dome
    setval DOME_FOSSIL
    loadmem wFossilItem, DOME_FOSSIL
    loadmem wRevivedFossil, KABUTO
    sjump .fossil_chosen

.helix
    setval HELIX_FOSSIL
    loadmem wFossilItem, HELIX_FOSSIL
    loadmem wRevivedFossil, OMANYTE
    sjump .fossil_chosen

.amber
    setval OLD_AMBER
    loadmem wFossilItem, OLD_AMBER
    loadmem wRevivedFossil, AERODACTYL

.fossil_chosen
    promptbutton
    getitemname STRING_BUFFER_3, USE_SCRIPT_VAR

if DEF(_EN_US)
    scall IsVowel
    iftrue .vowel

    writetext SilphCoResearchScientist6AskReviveText
    sjump .request_sequel

.vowel
endc
    writetext SilphCoResearchScientist6AskReviveVowelText
.request_sequel
    promptbutton
    writetext SilphCoResearchScientist6AskReviveSequelText
    yesorno
    iftrue .check_party_room
    writetext SilphCoResearchScientist6SadText
    sjump .wait_and_close_text

.check_party_room
    readvar VAR_PARTYCOUNT
    ifless PARTY_LENGTH, .enough_room

    writetext SilphCoResearchScientist6NotEnoughRoomText
    sjump .wait_and_close_text

.enough_room
    readmem wFossilItem
    takeitem ITEM_FROM_MEM, 1
    writetext SilphCoResearchScientist6WaitText
    waitbutton
    closetext

    ; animation
    applymovement SILPHCORESEARCH_SCIENTIST6, SilphCoResearch_ToElevatorMovement
    moveobject SILPHCORESEARCH_SCIENTIST6, 13, 0
    playsound SFX_ENTER_DOOR
    disappear SILPHCORESEARCH_SCIENTIST6

    readvar VAR_YCOORD
    ifequal 2, .from_left

    applymovement PLAYER, SilphCoResearch_SitOnSofaFromBottomMovement
    sjump .seated

.from_left
    applymovement PLAYER, SilphCoResearch_SitOnSofaFromLeftMovement

.seated
    applymovement PLAYER, SilphCoResearch_SitOnSofaMovement

    pause 60

    playsound SFX_ELEVATOR_END
    pause 10
    applymovement PLAYER, SilphCoResearch_MeetReviverScientistMovement
    appear SILPHCORESEARCH_SCIENTIST6
    applymovement SILPHCORESEARCH_SCIENTIST6, SilphCoResearch_StepDownMovement

    opentext
    writetext SilphCoResearchScientist6SuccessText
    waitbutton
    closetext

    applymovement SILPHCORESEARCH_SCIENTIST6, SilphCoResearch_StepDownMovement
    readmem wRevivedFossil
    opentext
    playsound SFX_CAUGHT_MON
    getmonname STRING_BUFFER_3, USE_SCRIPT_VAR
    writetext SilphCoResearchScientist6GetMonText
    waitsfx
    givepoke -1, 20
    writetext SilphCoResearchScientist6ThanksText
    waitbutton
    closetext

    ; animation
    applymovement SILPHCORESEARCH_SCIENTIST6, SilphCoResearch_GoToDeskAfterFollowMovement
    moveobject SILPHCORESEARCH_SCIENTIST6, 14, 2
    end


SilphCoResearch_ElevatorButton:
    jumpstd ElevatorButtonScript

SilphCoResearch_Printer:
	jumptext SilphCoResearch_FaxText

SilphCoResearch_UpGradeScript:
; This whole script is written out rather than as an itemball
; because we don't want it to be picked up by bumping into it.
    getitemname STRING_BUFFER_3, UP_GRADE

	giveitem UP_GRADE
	iffalse .BagFull

	disappear SILPHCORESEARCH_POKEBALL_UP_GRADE
	opentext
	farwritetext _PlayerFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	end

.BagFull:
	opentext
	farwritetext _PlayerFoundItemText
	promptbutton
	farwritetext _CantCarryItemText
	waitbutton
	closetext
	end

    disappear SILPHCORESEARCH_POKEBALL_UP_GRADE
	opentext
	verbosegiveitem UP_GRADE
	closetext
	end

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
SilphCoResearch_SitOnSofaFromLeftMovement:
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

SilphCoResearch_ToElevatorMovement:
    step LEFT
SilphCoResearch_SitOnSofaFromBottomMovement:
    step UP
    step UP
    step_end

SilphCoResearch_SitOnSofaMovement:
    turn_head DOWN
    fix_facing
    step UP
    remove_fixed_facing
    step_end

SilphCoResearch_MeetReviverScientistMovement:
    step DOWN
    step DOWN
    step LEFT
    turn_head UP
    step_end

SilphCoResearch_StepDownMovement:
    step DOWN
    step_end

SilphCo_LookPokeballText:
if DEF(_FR_FR)
	text "A l'intérieur il y"
	line "a un @"
	text_ram wStringBuffer3
	text "."
else
    text "It contains a"
	line "@"
	text_ram wStringBuffer3
	text "."
endc
	done

if DEF(_EN_US)
SilphCo_LookPokeballVowelText:
    text "It contains an"
	line "@"
	text_ram wStringBuffer3
	text "."
	done
endc

SilphCo_LevelText:
if DEF(_FR_FR)
	text "Il est niveau 10"
	line "et connaît les"
    cont "attaques"
else
    text "It is level 10 and"
    line "knows the moves"
endc
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
if DEF(_FR_FR)
    text "@"
	text_ram wStringBuffer2
	text_start

    line "et @"
    text_ram wStringBuffer1
	text "."
else
    text "@"
    text_ram wStringBuffer2
    text ","

    line "and @"
    text_ram wStringBuffer1
    text "."
endc
    done

SilphCo_WannaTakeItText:
if DEF(_FR_FR)
	text "Prendre celui-ci?"
else
    text "Do you want to"
    line "take this one?"
endc
    done

SilphCo_PartyFullText:
if DEF(_FR_FR)
	text "Mais votre équipe"
	line "est déjà pleine."
else
    text "But your party is"
    line "full."
endc
    done

SilphCoResearch_FaxText:
if DEF(_FR_FR)
	text "Il y a un fax"
	line "imprimé et signé"
	cont "par le PROF.CHEN,"
	cont "le PROF.ORME,"
	cont "M.#MON,"
	cont "l'INFIRMIERE EN"
	cont "CHEF JOELLE,"
	cont "et... EUSINE?"
	
	para "Ce doit être très"
	line "important."
else
    text "There's a printed"
    line "fax signed by"
    cont "PROF.OAK,"
    cont "PROF.ELM,"
    cont "MR.#MON,"
    cont "CHIEF NURSE JOY,"
    cont "and… EUSINE?"

    para "This must be very"
    line "important."
endc
    done

SilphCoResearchScientist1_HiText:
if DEF(_FR_FR)
	text "Ce bureau est l'un"
	line "des centres de re-"
	
	para "cherche dédiés à"
	line "la découverte d'un"
	
	para "vaccin contre le"
	line "COVID pour tous"
	cont "les #MON."
	
	para "Nous sommes actu-"
	line "ellement en phase"
	cont "de tests réels."
	
	para "Cette phase prend"
	line "beaucoup de temps,"
	
	para "car nous vérifions"
	line "chaque espèce de"
	cont "#MON une à une."
	
	para "C'est pourquoi"
	line "nous avons besoin"
	cont "de dresseurs tels"
    cont "que toi."
	
	para "Il y a plusieurs"
	line "# BALL dans ce"
	cont "bureau."
	
	para "Elles contiennent"
	line "toutes un sujet de"
	cont "test volontaire,"
	
	para "ayant été injecté"
	line "avec notre vaccin"
	cont "prototype."
	
	para "Je veux que tu"
	line "choisisses une"
	cont "# BALL."
	
	para "Entraîne et fais"
	line "combattre le"
	cont "#MON choisi."
	
	para "Puis rapporte-le,"
	line "afin que nous"
	
	para "puissions analyser"
	line "les effets du"
	
	para "vaccin sur sa"
	line "santé."
	
	para "Oh, j'ai failli"
	line "oublier!"
	
	para "Tu vas avoir"
	line "besoin de ceci."
else
    text "This office is one"
    line "of the research"
    
    para "facilities devoted"
    line "to finding a"

    para "COVID vaccine for"
    line "all #MON."
    
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
endc
    done

SilphCoResearchScientist1_PassText:
if DEF(_FR_FR)
	text "Avec ça, le gar-"
	line "dien à l'entrée ne"
	cont "te cassera plus"
    cont "les pieds."
	
	para "..."
	
	para "Un dernier détail:"
	line "les #MON dans"
	
	para "ce labo ont des"
	line "couleurs étranges."
	
	para "C'est le résultat"
	line "d'expériences"
	cont "précédentes."
	
	para "T'en fais pas pour"
    line "ça! Ils pètent la"
	cont "forme!"
else
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
endc
	done



; Case 1: the trainer doesn't have the test subject Pokémon in its party.
; Case 2: the trainer does.

; Case A: The trainer has done less than or equal to half the required amount of battles.
; Case B: The trainer has done more than half, but less than 100%.
; Case C: The trainer has done >= 100%.

SilphCoResearchScientist1_QuestIntro_Text:
if DEF(_FR_FR)
	text "Comment va notre"
	line "#MON cobaye?"
else
	text "How is our test"
	line "subject #MON"
	cont "doing?"
endc
	done

SilphCoResearchScientist1_Case1_Text:
if DEF(_FR_FR)
	text "Amène-le ici que"
	line "je puisse analyser"
	
	para "les effets du"
	line "vaccin sur sa"
	cont "santé."
else
	text "Please bring it"
	line "here so I can"
	
	para "check on the"
	line "effects of the"
	
	para "vaccine on its"
	line "health."
endc
	done

SilphCoResearchScientist1_Case2_Text:
if DEF(_FR_FR)
	text "Je vois que le"
	line "#MON cobaye se"
	cont "porte bien."
else
    text "I see the test"
	line "subject #MON"
	cont "is doing good."
endc
	done

SilphCoResearchScientist1_Case1A2A_Text:
if DEF(_FR_FR)
	text "Mais j'ai besoin"
	line "de beaucoup plus"
	cont "de données à"
	cont "analyser."
	
	para "Reviens quand tu"
    line "l'auras beaucoup"
	cont "plus entraîné."
else
	text "However I need"
	line "much more data"
	cont "to analyze."
	
	para "Come back after"
	line "training it way"
	cont "more."
endc
	done

SilphCoResearchScientist1_Case1B2B_Text:
if DEF(_FR_FR)
	text "Encore un chouïa"
	line "d'entraînement,"
	
	para "et nous aurons"
	line "assez de données"
	cont "pour en tirer des"
    cont "conclusions"
	cont "fiables."
else
    text "A little more"
	line "training with you,"

	para "and we should have"
	line "enough data for"
	cont "reliable results."
endc
	done

SilphCoResearchScientist1_ExplainTraining_Text:
if DEF(_FR_FR)
	text "Et quand je dis"
    line "entraînement, je"
	cont "parle de combats."
	
	para "Le sujet de test"
    line "doit être exposé"
	cont "au virus, pour que"
	
	para "nous puissions"
    line "observer les"
	cont "effets du vaccin."
	
	para "Utiliser des SUPER"
	line "BONBONS ou des"
	cont "objets de boost de"
    cont "stats ne servirait"
	cont "à rien."
else
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
endc
	done

SilphCoResearchScientist1_Case1C_Text:
if DEF(_FR_FR)
	text "Tu l'as beaucoup"
	line "entraîné!"
	
	para "Nous avons assez"
	line "de données à"
	cont "présent."
	
	para "Rend-le-moi, je"
	line "vais regarder les"
	cont "résultats tout"
	cont "de suite."
else
    text "You've trained"
	line "it a lot!"
	
	para "That should be"
	line "enough data."

    para "Give it to me,"
	line "I will check"
	
	para "the results right"
	line "now."
endc
	done

SilphCoResearchScientist1_HandedOver_Text:
if DEF(_FR_FR)
	text "<PLAYER> rend le"
	line "#MON."
else
	text "<PLAYER> handed"
	line "over the #MON."
endc
	done

SilphCoResearchScientist1_CaseDone_Text:
if DEF(_FR_FR)
	text "Les résultats sont"
	line "aussi bons que"
    cont "prévu!"
	
	para "Ca conclut la"
    line "phase de test!"
	
	para "Depuis que nous"
	line "avons dépassé un"
	
	para "taux de succès de"
	line "80<PERCENT> il y a plu-"
	cont "sieurs semaines,"
	
	para "nous avons lancé"
	line "la production de"
	cont "masse et la"
	cont "distribution"
    cont "du vaccin."
	
	para "Par la puissance"
	line "d'un simple appel,"

	para "je vais prévenir"
	line "la hiérarchie et"
	
	para "commencer à sauver"
	line "des milliers de"
	cont "vies."
	
	para "-Je me sens si"
	line "puissant en cet"
	cont "instant!-"
else
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
endc
	done

SilphCoResearchScientist1_AfterQuest_Text:
if DEF(_FR_FR)
	text "Notre CENTRE DE"
	line "VACCINATION se"
	cont "trouve à droite"
	cont "de ce bâtiment."
	
	para "Nous n'aurions pas"
	line "pu y arriver sans"
	
	para "ton aide, MAITRE"
	line "de la LIGUE."
else
    text "Our vaccination"
	line "center is located"
	
	para "to the right of"
	line "this building."

	para "We couldn't have"
	line "done it without"
	
	para "your help,"
	line "LEAGUE CHAMPION."
endc
	done

SilphCoResearchScientist1_KeepMon_Text:
if DEF(_FR_FR)
	text "Le sujet de test"
	line "semble s'être"
	cont "attaché à toi et"
	cont "voudrait rester"
	cont "dans ton équipe."
	
	para "Je n'y vois aucun"
	line "inconvénient."
else
	text "The test subject"
	line "#MON feels"
	
	para "attached to you"
	line "and would like to"
	cont "stay with you."

	para "I see no problem"
	line "with that."
endc
	done

SilphCoResearchScientist1_GotBack_Text:
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

SilphCoResearchScientist1_ThankService_Text:
if DEF(_FR_FR)
	text "Merci pour ton"
	line "aide, valeureux"
	cont "@"
	text_ram wStringBuffer1
	text "."
else
	text "Thank you for your"
	line "service, dear"
	cont "@"
	text_ram wStringBuffer1
	text "."
endc
	done
	



SilphCoResearchScientist2_Text:
if DEF(_FR_FR)
	text "Il est sans danger"
	line "d'utiliser un"
	
    para "#MON contagieux"
	line "en combat tant"

	para "qu'aucun #MON"
	line "sain n'est envoyé"
	cont "après lui."
else
    text "It is safe to"
    line "use a contagious"
    
    para "#MON in battle"
    line "as long as no"

    para "healthy one is"
    line "sent afterwards."
endc
    done

SilphCoResearchScientist3_Text:
if DEF(_FR_FR)
	text "Nous avons fait"
	line "une percée dans la"
	cont "recherche grâce à"
	
	para "un échantillon"
	line "d'eau de SUICUNE."
else
    text "We made a break-"
    line "through in the"
    
    para "research thanks to"
    line "a SUICUNE water"
    cont "sample."
endc
    done

SilphCoResearchScientist4_Text:
if DEF(_FR_FR)
	text "Nos recherches"
	line "montrent que le"
	cont "virus responsable"
	
	para "du COVID est une"
	line "version mutée du"
	cont "#RUS."
else
    text "Our research shows"
    line "that the virus"

    para "that gives COVID"
    line "is a mutated ver-"
    cont "sion of #RUS."
endc
    done

SilphCoResearchScientist5_Text:
if DEF(_FR_FR)
	text "Yep, je suis le"
    line "type qui a inventé"
	cont "le #MASQUE."
	
	para "Malheureusement,"
	line "le rendre adapté à"
	
	para "la production de"
	line "masse, tout en"
    cont "restant abordable"
	cont "est un vrai défi."
else
    text "Yup, I'm the guy"
    line "that came up with"
    cont "the #MASK."

    para "Unfortunately,"
    line "making it ready"
    
    para "for mass produc-"
    line "tion as well as"
	
	para "affordable is a"
    line "huge challenge."
endc
    done

SilphCoResearchScientist1_ConfusedText:
if DEF(_FR_FR)
	text "Désolé,"
	line "je suis confus."
else
	text "I'm sorry"
	line "I'm confused."
endc
	done




SilphCoResearchScientist6IntroText:
if DEF(_FR_FR)
	text "J'ai été muté ici"
	line "car je suis expert"
	cont "en ADN."
	
	para "Mais mon domaine,"
	line "c'est l'ADN des"
	cont "#MON préhis-"
    cont "toriques!"
	
	para "Je me sens inutile"
	line "pour la recherche"
	cont "sur ce vaccin à"
	cont "ARNm!"
	
	para "Je préférerais"
    line "avoir un fossile"
	cont "pour m'occuper..."
else
    text "I was transfered"
    line "here because I'm"
    cont "an expert on DNA."

    para "But my field is"
    line "prehistoric #-"
    cont "MON DNA!"

    para "I'm no help with"
    line "the research on"
    cont "this mRNA vaccine!"

    para "I wish I had a"
    line "fossil to play"
    cont "with…"
endc
    done

if DEF(_EN_US)
SilphCoResearchScientist6AskReviveText:
    text "Is that a"
    line "@"
    text_ram wStringBuffer3
    text " you"
    cont "have here?"
    done
endc

SilphCoResearchScientist6AskReviveVowelText:
if DEF(_FR_FR)
	text "Est-ce bien un"
	line "@"
	text_ram wStringBuffer3
	text " que"
	cont "tu as là?"
else
    text "Is that an"
    line "@"
    text_ram wStringBuffer3
    text " you"
    cont "have here?"
endc
    done

SilphCoResearchScientist6AskReviveSequelText:
if DEF(_FR_FR)
	text "Je serais ravi"
	line "d'essayer de le"
	cont "ressusciter!"
	
	para "Tu m'le prêtes?"
else
    text "I'd be happy to"
    line "try to revive it!"

    para "Can I have it?"
endc
    done

SilphCoResearchScientist6SadText:
if DEF(_FR_FR)
	text "Avec cette tâche"
	line "j'aurais pu me"
	cont "sentir utile..."
else
    text "This task would"
    line "have given me"
    cont "purpose…"
endc
    done

SilphCoResearchScientist6NotEnoughRoomText:
if DEF(_FR_FR)
	text "Avant que je tente"
	line "quoi que ce soit,"
	
	para "il faut que tu"
	line "fasses de la place"
	cont "dans ton équipe."
else
    text "Before I try any-"
    line "thing, you gotta"
    cont "make some room"
    cont "in your party."
endc
    done

SilphCoResearchScientist6WaitText:
if DEF(_FR_FR)
	text "Mon matos est"
	line "à l'étage,"
	cont "patiente ici."
else
    text "My equipment is"
    line "upstairs, please"
    cont "wait here."
endc
    done

SilphCoResearchScientist6SuccessText:
if DEF(_FR_FR)
	text "J'ai réussi!"
	line "Et ouais bébé!"
else
    text "I succeeded!"
    line "Yeah baby!"
endc
    done

SilphCoResearchScientist6GetMonText:
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "@"
	text_ram wStringBuffer3
	text "!"
else
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "."
endc
	done

SilphCoResearchScientist6ThanksText:
if DEF(_FR_FR)
	text "Tu as illuminé ma"
	line "journée!"
	
	para "Par pitié repasses"
    line "si jamais tu en"
	cont "trouves un autre."
else
    text "You made my day!"
    line "Please come back"
    cont "if you ever find"
    cont "something else."
endc
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
	object_event  7,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearch_UpGradeScript, EVENT_FOUND_UP_GRADE
	object_event  8,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist1Script, -1
	object_event  1,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist2Script, -1
	object_event 14,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist3Script, -1
	object_event  3,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist4Script, -1
	object_event  6,  1, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist5Script, -1
	object_event 14,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoResearchScientist6Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
    
